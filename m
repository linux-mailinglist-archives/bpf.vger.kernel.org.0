Return-Path: <bpf+bounces-15595-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD1D7F37A7
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 21:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55C95282812
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 20:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BAB47799;
	Tue, 21 Nov 2023 20:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOcbTovf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D520E1A3;
	Tue, 21 Nov 2023 12:40:48 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cf6af8588fso14013755ad.0;
        Tue, 21 Nov 2023 12:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700599248; x=1701204048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WCC6s9NGPFKJC7qCc4GCCVN10BOm0r6c3YXwRd9V+sE=;
        b=NOcbTovf/u9WZES1HyIp/jIRGkMPkN5MHAZnPWJMI/4Isl55m7fCWkWUHtIsh1OHJc
         Ax3Qf+bPc32D4BOpEhWNbFksWSQLW96IqLA0pBDsGApkwcEbxyJvh1vEwB8vanOSNRvw
         ZN0tlrgVTvdi3tPj5d1eeG8jSlkFce1Iu1s9vpMYJvQ5SzU9a7eyzxR0MpKgxGGZXlJI
         qE25ChhZUtaPOtFb/n3NGeqF0gvI0F69K5uUanyeZrIGiNLKcgG6pgT/KGc6Q0b0Dauv
         3veqCzBs9yL52C0TWPC/IIQSuJuZguhr9YFnE5Q8bFue4nNhsm3496kjH11TjvO/Jqw2
         XpUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700599248; x=1701204048;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WCC6s9NGPFKJC7qCc4GCCVN10BOm0r6c3YXwRd9V+sE=;
        b=X0cofuNDY1XzZ8/pHZzWFlf50tsCQpB/hiAsib3/H6/dqL+mqjOBHmeHuWgukjqa6N
         vTRl6w57GAy6ZRmkfyOLzkJZoXcHB2vqYbnRT2JVaRJRCIyekR7c0xz/HHNshm4QlSXt
         KJtQkX7W5JguYGph3mWO3DF+4zvyyFREbDJRr/3b3xjziGUieET4VySjfdqOjdLBrK+S
         ip3DrXfJn6Vn0SDMwKsJT9AVgDxnfJVvqcR8oBcXA7HqsPNfOCRzJ/2Wv8AFjglXfHyf
         AXE+R3YrtwkwjtLTqtRuIUjVWSTcEjBx15B4s/UxOSZjxct7k3dhpTzxIvaUJJ4Cplyi
         QkXA==
X-Gm-Message-State: AOJu0YzyMBtsk33PqP+C150rMyhOb5Xlvig8b2bj+BCuEfLVMaE9061h
	9CThYYd/r2P37IW1htwv2r8=
X-Google-Smtp-Source: AGHT+IFE5wsKsmA/KMmkZhA/gpV1ibyC+Cl5yRXxt+owMi2A/BfcaFFEKIJ8+rLUR9zV4LdjMBDG1g==
X-Received: by 2002:a17:903:493:b0:1cf:774c:39a8 with SMTP id jj19-20020a170903049300b001cf774c39a8mr264254plb.56.1700599248179;
        Tue, 21 Nov 2023 12:40:48 -0800 (PST)
Received: from localhost ([98.97.116.126])
        by smtp.gmail.com with ESMTPSA id p2-20020a170902e74200b001b895336435sm8325327plf.21.2023.11.21.12.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 12:40:47 -0800 (PST)
Date: Tue, 21 Nov 2023 12:40:45 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 yangyingliang@huawei.com, 
 martin.lau@kernel.org, 
 Jakub Sitnicki <jakub@cloudflare.com>
Message-ID: <655d15cdb26fb_1fc7a208a5@john.notmuch>
In-Reply-To: <bc92c670-f472-43b1-af0b-a50353ed8757@linux.dev>
References: <20231016190819.81307-1-john.fastabend@gmail.com>
 <20231016190819.81307-2-john.fastabend@gmail.com>
 <87cywnjblh.fsf@cloudflare.com>
 <bc92c670-f472-43b1-af0b-a50353ed8757@linux.dev>
Subject: Re: [PATCH bpf 1/2] bpf: sockmap, af_unix sockets need to hold ref
 for pair sock
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Martin KaFai Lau wrote:
> On 11/6/23 4:35 AM, Jakub Sitnicki wrote:
> >> diff --git a/net/unix/unix_bpf.c b/net/unix/unix_bpf.c
> >> index 2f9d8271c6ec..705eeed10be3 100644
> >> --- a/net/unix/unix_bpf.c
> >> +++ b/net/unix/unix_bpf.c
> >> @@ -143,6 +143,8 @@ static void unix_stream_bpf_check_needs_rebuild(struct proto *ops)
> >>   
> >>   int unix_dgram_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
> >>   {
> >> +	struct sock *skpair;
> >> +
> >>   	if (sk->sk_type != SOCK_DGRAM)
> >>   		return -EOPNOTSUPP;
> >>   
> >> @@ -152,6 +154,9 @@ int unix_dgram_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool re
> >>   		return 0;
> >>   	}
> >>   
> >> +	skpair = unix_peer(sk);
> >> +	sock_hold(skpair);
> >> +	psock->skpair = skpair;
> >>   	unix_dgram_bpf_check_needs_rebuild(psock->sk_proto);
> >>   	sock_replace_proto(sk, &unix_dgram_bpf_prot);
> >>   	return 0;
> > unix_dgram should not need this, since it grabs a ref on each sendmsg.
> 
> John, could you address this comment and respin v2?

Respinning now just letting some tests run for a bit and I'll kick it out.

Thanks.

> 
> The unix_inet_redir_to_connected() seems needing a fix in patch 2 also as 
> pointed out by JakubS.
> 
> Thanks.
> 
> > 
> > I'm not able to reproduce this bug for unix_dgram.
> > 
> > Have you seen any KASAN reports for unix_dgram from syzcaller?

