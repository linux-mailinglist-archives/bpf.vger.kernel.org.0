Return-Path: <bpf+bounces-1229-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EA9710E6E
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 16:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0A731C20EFB
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 14:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D2D13AC3;
	Thu, 25 May 2023 14:35:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE549BE62
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 14:35:13 +0000 (UTC)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFD1139
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 07:35:11 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-331911956c3so15883545ab.1
        for <bpf@vger.kernel.org>; Thu, 25 May 2023 07:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1685025311; x=1687617311;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JahCaEAcBw9V6auX2WbLCtlVTk1hNDt7t03CHUqfyvo=;
        b=SILAZmmgq40xZgWfpxY3p9hsAyde96AlkJ5qyeD39YtWBjB5PFhdA77+izm6ZtU36Z
         2p3oRgcC5agZmP2e1FhX/XDexpm6x0N7qxAhYSLz3aMVpvqITip0GgGm50berArVoVSG
         PJThuD0bxmiNPDl6RLIREMJ4ptm4V1BQgu80Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685025311; x=1687617311;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JahCaEAcBw9V6auX2WbLCtlVTk1hNDt7t03CHUqfyvo=;
        b=YxH0m0xS46D5NAXTW9cCUUgfqTLbNF5uuC5xQ2naBT6AP1gQQeLFDniHttK7UK6+93
         4Q39Lz98b1+OWBsQjlucf2Z2MoN0fEDcsz8e9MC7EARcJiXu7dKM71WyKpc2sa6e8s/y
         YOqAPeLzC9XCplpWpcgzF6NSc9rEXNVeEpa08nUP6i01cyl5z8JPfNBHOMbPgy2JWywu
         nT4ed01MfMSsHGe31RF/HwysyCfYuKUmszgwrVirgR+9kRiVXkA2wRkRJcVKqlMucXnS
         L5s3Bgp1tBbD+rhsTd9sJU6SR4qUNU/FHKKTkmYUBJdf4a+gvHF5xTwz4ITnsiFqIo7l
         5Elg==
X-Gm-Message-State: AC+VfDx2m8uJ4GOqYLPt3cLT+wWQrWsiSGtC8CYcRswMII4AnbfR/dxy
	c9e/joIzXfrd8+ga8LcR37SAOPa4leGuYHDRcmA=
X-Google-Smtp-Source: ACHHUZ57NPBBTPwP4lbLmEm986qk4qyv9srWKqLvNVrBhAlVekEW1NwCP5+Y04iPFmqJa7342e+Cpg==
X-Received: by 2002:a92:bf06:0:b0:33a:2863:2c57 with SMTP id z6-20020a92bf06000000b0033a28632c57mr7791038ilh.9.1685025310896;
        Thu, 25 May 2023 07:35:10 -0700 (PDT)
Received: from fastly.com ([216.80.70.252])
        by smtp.gmail.com with ESMTPSA id o14-20020a92c04e000000b0032648a86067sm374789ilf.4.2023.05.25.07.35.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 May 2023 07:35:10 -0700 (PDT)
Date: Thu, 25 May 2023 07:35:08 -0700
From: Joe Damato <jdamato@fastly.com>
To: Yonghong Song <yhs@meta.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ast@kernel.org, edumazet@google.com,
	martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@google.com, jolsa@kernel.org,
	haoluo@google.com
Subject: Re: [PATCH bpf-next] bpf: Export rx queue info for reuseport ebpf
 prog
Message-ID: <20230525143508.GA21064@fastly.com>
References: <20230525033757.47483-1-jdamato@fastly.com>
 <26c90595-f45e-a813-d538-0892c3ef2424@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26c90595-f45e-a813-d538-0892c3ef2424@meta.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 24, 2023 at 10:26:32PM -0700, Yonghong Song wrote:
> 
> 
> On 5/24/23 8:37 PM, Joe Damato wrote:
> >BPF_PROG_TYPE_SK_REUSEPORT / sk_reuseport ebpf programs do not have
> >access to the queue_mapping or napi_id of the incoming skb. Having
> >this information can help ebpf progs determine which listen socket to
> >select.
> >
> >This patch exposes both queue_mapping and napi_id so that
> >sk_reuseport ebpf programs can use this information to direct incoming
> >connections to the correct listen socket in the SOCKMAP.
> >
> >For example:
> >
> >A multi-threaded userland program with several threads accepting client
> >connections via a reuseport listen socket group might want to direct
> >incoming connections from specific receive queues (or NAPI IDs) to specific
> >listen sockets to maximize locality or for use with epoll busy-poll.
> >
> >Signed-off-by: Joe Damato <jdamato@fastly.com>
> >---
> >  include/uapi/linux/bpf.h |  2 ++
> >  net/core/filter.c        | 10 ++++++++++
> >  2 files changed, 12 insertions(+)
> >
> >diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> >index 9273c654743c..31560b506535 100644
> >--- a/include/uapi/linux/bpf.h
> >+++ b/include/uapi/linux/bpf.h
> >@@ -6286,6 +6286,8 @@ struct sk_reuseport_md {
> >  	 */
> >  	__u32 eth_protocol;
> >  	__u32 ip_protocol;	/* IP protocol. e.g. IPPROTO_TCP, IPPROTO_UDP */
> >+	__u32 rx_queue_mapping; /* Rx queue associated with the skb */
> >+	__u32 napi_id;          /* napi id associated with the skb */
> >  	__u32 bind_inany;	/* Is sock bound to an INANY address? */
> >  	__u32 hash;		/* A hash of the packet 4 tuples */
> 
> This won't work. You will need to append to the end of data structure
> to keep it backward compatibility.
> 
> Also, recent kernel has a kfunc bpf_cast_to_kern_ctx() which converts
> a ctx to a kernel ctx and you can then use tracing-coding-style to
> access those fields. In this particular case, you can do
> 
>    struct sk_reuseport_kern *kctx = bpf_cast_to_kern_ctx(ctx);
> 
> We have
> 
> struct sk_reuseport_kern {
>         struct sk_buff *skb;
>         struct sock *sk;
>         struct sock *selected_sk;
>         struct sock *migrating_sk;
>         void *data_end;
>         u32 hash;
>         u32 reuseport_id;
>         bool bind_inany;
> };
> 
> through sk and skb pointer, you should be access the fields presented in
> this patch. You can access more fields too.
> 
> So using bpf_cast_to_kern_ctx(), there is no need for more uapi changes.
> Please give a try.

Thanks! I was looking at an LTS kernel tree that didn't have
bpf_cast_to_kern_ctx; this is very helpful and definitely a better way to
go.

Sorry for the noise.

