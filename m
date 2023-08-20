Return-Path: <bpf+bounces-8135-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FEE781F57
	for <lists+bpf@lfdr.de>; Sun, 20 Aug 2023 20:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB13B1C20826
	for <lists+bpf@lfdr.de>; Sun, 20 Aug 2023 18:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF95663CE;
	Sun, 20 Aug 2023 18:47:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50747E6
	for <bpf@vger.kernel.org>; Sun, 20 Aug 2023 18:47:36 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207403C34
	for <bpf@vger.kernel.org>; Sun, 20 Aug 2023 11:44:49 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-522bd411679so3189997a12.0
        for <bpf@vger.kernel.org>; Sun, 20 Aug 2023 11:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1692557087; x=1693161887;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=NKDFyPyO4BrsPtbSAJ9B8kDPyp5fpzyNQ9wr0zWqaA0=;
        b=Ntz4YCZ0rgfPZzzPAMWaVCWGFUtu5y8cOVYkMV8bteRhyQZNNUADKjRfGsDlS4VdxC
         Cwa92J4GVIh0FVUxzlpX6d38YvlwIBdNxCnJh8SnGtF37nV1pTu/6KV9Jhc6Gu8l+LhS
         Runfdx2voZJGGVekjdFNbxVR7bMaaKOMB4J0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692557087; x=1693161887;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NKDFyPyO4BrsPtbSAJ9B8kDPyp5fpzyNQ9wr0zWqaA0=;
        b=AofjIeXq95gQYNQu3xtgJMJsl85YvbTAi3+wYiDBFQbqaWb1kKcjkpYrugqjoKnuLf
         A8EIE6K08bFv4UNGecZo+mdQcKenuIojQaRCGCuoifEFS5CXgte/14SD/UTyYz1NtP3T
         XWLXmpwvHee+frL9WI/Ak1ITM31czKtT7KInYsftGQKnGliXHqzlEmKHU28mW4wfvfbx
         vUUykQPdzzFVnfGqsv/mx+MR2cCrXRKSbpWEn0p3xXV9V0DUFHZ02FTyIeScXQvR6Msg
         wJZzyaFzefweba484IJnRZaKohh7x3P4QT3fiv688gUf7YBohBupfHdTB5twCZx+thAG
         drWQ==
X-Gm-Message-State: AOJu0Yx5IbAXJjSmkQhd1/vXCx79kjEaB0OfKQXRxnJiyYG2lFLDVNfz
	LqccnyGLuD8YzNJHa4QDOkwi2Q==
X-Google-Smtp-Source: AGHT+IEvJncm7ccSWu/O1+kruxTiTyzmG0szxjJTgNezrPsjqD4UoCrdgGacWuTds46xhfcUgs6+sQ==
X-Received: by 2002:aa7:c718:0:b0:52a:943:9abd with SMTP id i24-20020aa7c718000000b0052a09439abdmr693456edq.30.1692557087601;
        Sun, 20 Aug 2023 11:44:47 -0700 (PDT)
Received: from cloudflare.com (79.184.134.65.ipv4.supernova.orange.pl. [79.184.134.65])
        by smtp.gmail.com with ESMTPSA id l23-20020aa7c3d7000000b0052a023e9b5dsm2244385edr.47.2023.08.20.11.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 11:44:46 -0700 (PDT)
References: <20230811093237.3024459-1-liujian56@huawei.com>
 <20230811093237.3024459-2-liujian56@huawei.com>
 <c1ba1a3235464b8306a22c050225332fa3929a10.camel@inf.elte.hu>
User-agent: mu4e 1.6.10; emacs 28.2
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Ferenc Fejes <fejes@inf.elte.hu>, Liu Jian <liujian56@huawei.com>
Cc: john.fastabend@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 1/7] bpf, sockmap: add BPF_F_PERMANENTLY
 flag for skmsg redirect
Date: Sun, 20 Aug 2023 20:19:49 +0200
In-reply-to: <c1ba1a3235464b8306a22c050225332fa3929a10.camel@inf.elte.hu>
Message-ID: <87zg2l5zaa.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 17, 2023 at 02:05 PM +02, Ferenc Fejes wrote:
> Hi Liu!
>
> On Fri, 2023-08-11 at 17:32 +0800, Liu Jian wrote:
>> If the sockmap msg redirection function is used only to forward
>> packets
>> and no other operation, the execution result of the
>> BPF_SK_MSG_VERDICT
>> program is the same each time. In this case, the BPF program only
>> needs to
>> be run once. Add BPF_F_PERMANENTLY flag to bpf_msg_redirect_map() and
>> bpf_msg_redirect_hash() to implement this ability.
>
> Did you considered other names for this flag e.g. BPF_F_SPLICED or
> BPF_F_PIPED?

Ferenc,

A reference to splice/pipe syscall certainly paints a picture.

But I'm not sure if it makes it more intutive or more confusing in the
context of bpf_{msg,sk}_redirect_{hash,map}. Consider:

  bpf_msg_redirect_map(..., BPF_F_SPLICE)

vs

  bpf_msg_redirect_map(..., BPF_F_PERMANENTLY)


Liu,

No need to go for the adverb form ("PERMANENTLY"). An adjective
("PERMANENT") will as expressive here. So BPF_F_PERMANENT is what I'm
suggesting.

Also, I'm thinking maybe it's time for a dedicated prefix to avoid name
clashes, like BPF_F_ADJ_ROOM_*.

BPF_F_INGRESS, which is also accepted by other helpers. But that won't
be the case with the new flag. BPF_F_SK_REDIR_*? That would make it
BPF_F_SK_REDIR_PERMANENT.

Alternatively, BPF_F_SK_REDIR_FIXED comes to mind. Naming is hard.

[...]

