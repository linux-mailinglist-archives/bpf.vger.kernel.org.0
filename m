Return-Path: <bpf+bounces-6516-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7300076A7A1
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 05:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3D581C20E00
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 03:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483311C30;
	Tue,  1 Aug 2023 03:47:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0647E;
	Tue,  1 Aug 2023 03:47:52 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053A6F1;
	Mon, 31 Jul 2023 20:47:52 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bbc64f9a91so44043925ad.0;
        Mon, 31 Jul 2023 20:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690861671; x=1691466471;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vUxkf2Zv+G34S/jIfFi7uVAJxAGamTOqdnNoeJx+ffw=;
        b=rBdJE0KohdES+/eQJtWE9tY+02lsih5EdlQ2OW1jA2mTcX6X8lLJeiFdbXE/l3svf2
         gV4BU4ZXR+ScMrT5EOaLnSt3IcOWn1vTMyw2ri/G0qdQjdNrqr3NFYj2kc9CcgHPYAyK
         TOv6HM2R2+n0oQttQ7Q+bTQCSuTGl0WrjmK2k8bHglveCjiX3+tQJB22RRP5cnA569C4
         EhtRxgLLwBEmRh/B2VOr2mmDkFAwsKQe3OXTmaRXMX8UjomfHlv7Zg1Clmwc86dxsMKf
         1GZ8nBO0etF7X4X81p3cbRq8clIymTtkAMTYfK1hK3Ft/LN7xXPHEHz0Wstd3I0oPHJj
         MMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690861671; x=1691466471;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vUxkf2Zv+G34S/jIfFi7uVAJxAGamTOqdnNoeJx+ffw=;
        b=azuz0XJlLW221Or9pdQSh0j/ypcWLzO5oxnHbSZ2NtQJPomKfuTZqv4YHrnu47/PCu
         SviepD6GY0rVVO2hAzcnAMMio2qy1sZIhjj0HrM8lW3va74a8bGq2mR3ZW6o2JqoHWIQ
         zKKPZ1xKcmQDwoCOAaqm4siQJKAs3Wabq4bCCT+rPuSRVUriczwG0bP7f1Ookyp4wjUH
         QrUVJ6JCMVdBAWCo0mNTP4/XQEyrCjiM41ohXRzHKFwVK5z8TBURxazn61Xmn1Zr49ZX
         moDonpHs3b+NX2kzVLPyf/jSZp7w9IaF/IAz04nCL5xdmI+0tofdgzonLxntPvHQAeSY
         1TZQ==
X-Gm-Message-State: ABy/qLaBoiom/QdV8lfj1yfzKB7abdc+t2Ca0okqNNlgZCspG6AyUcz3
	lCA740AzJz01ErhFlmk2LGY=
X-Google-Smtp-Source: APBJJlFwBPWYASRvfrTXZAmcvtp7LfRSmpw/K8/3r9DsyEHazSHMhtU1URaBGiGKA7hJZZ5TKt84jA==
X-Received: by 2002:a17:902:b60a:b0:1b8:9b1d:9e24 with SMTP id b10-20020a170902b60a00b001b89b1d9e24mr10989029pls.22.1690861671233;
        Mon, 31 Jul 2023 20:47:51 -0700 (PDT)
Received: from localhost ([98.97.32.4])
        by smtp.gmail.com with ESMTPSA id jg1-20020a17090326c100b001bb4f9d86ebsm9366145plb.23.2023.07.31.20.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 20:47:50 -0700 (PDT)
Date: Mon, 31 Jul 2023 20:47:49 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Xu Kuohai <xukuohai@huaweicloud.com>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <64c8806537c3a_a427920846@john.notmuch>
In-Reply-To: <6965ceb9-0b96-ce21-cc72-7d29b42544bd@huaweicloud.com>
References: <20230728105649.3978774-1-xukuohai@huaweicloud.com>
 <e2d06c78-1434-8322-1089-ba6355bb4c83@linux.dev>
 <6965ceb9-0b96-ce21-cc72-7d29b42544bd@huaweicloud.com>
Subject: Re: [PATCH bpf] bpf, sockmap: Fix map type error in sock_map_del_link
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Xu Kuohai wrote:
> On 8/1/2023 9:19 AM, Martin KaFai Lau wrote:
> > On 7/28/23 3:56 AM, Xu Kuohai wrote:
> >> sock_map_del_link() operates on both SOCKMAP and SOCKHASH, although
> >> both types have member named "progs", the offset of "progs" member in
> >> these two types is different, so "progs" should be accessed with the
> >> real map type.
> > 
> > The patch makes sense to me. Can a test be written to trigger it?
> > 
> 
> Thank you for the review. I have a messy prog that triggers memleak
> caused by this issue. I'll try to simplify it to a test.
> 
> > John, please review.
> > 
> > 
> > .
> 
> 

Thanks good catch. One thing I don't see any tests for is deleting a
socket from a sockmap and then trying to use it? My guess is almost
no one deletes sockets from a map except on sock close. Maybe to
reproduce,

 1. connect a bunch of sockets to sockhash with verdict prog
 2. remove the sockets
 3. remove the sockhash
 4. that should leak the bpf ref cnt so we could check for the
    prog still existing?

Reviewed-by: John Fastabend <john.fastabend@gmail.com>


