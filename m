Return-Path: <bpf+bounces-15702-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 867787F5085
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 20:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4198A28161F
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 19:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5D35E0C0;
	Wed, 22 Nov 2023 19:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nF9+o0/u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CA5109;
	Wed, 22 Nov 2023 11:26:13 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3b2e72fe47fso112512b6e.1;
        Wed, 22 Nov 2023 11:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700681173; x=1701285973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IIHZeJRn0oRy73tvNVUHLihoCRPxdoAMFvGUMg+NgNc=;
        b=nF9+o0/u8//GPzT/WYwpslJQux2qaE53dripg9VYAltcsLaFXXat6VSkJVbABGHkmr
         7iXbYSsnMj0oWwGPilJ1EFtQ3YPx6ZzCeVUe9B0AnLPxeVvhHBQZWd4qkMMpJQngwIY1
         RsSfxpkMwqhZ4QE4wDgOxGPo70ePpXypohQlVsTK6bKlszR20G2Xc3PO1WcDqgCHLoic
         ER6ctgCnVBdZbLapJqOGjvuUpepqvc+vF+aBBJ9Gp74GlJOqPyfmRchP3GdUIUvjD34L
         lOi5Rd4b8MotYRzDdWXcQwBDH6M+4Kt33RFyaWFXhEAn6iXzf6An8Cv5eLZBKjIR9Xsf
         94gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700681173; x=1701285973;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IIHZeJRn0oRy73tvNVUHLihoCRPxdoAMFvGUMg+NgNc=;
        b=CoOv4wtCsVafuphMOda1OzG5Qh8AWQeeJXBKf1/neVGrp5MYTiRutbw04CL7cdK2bE
         u5xNFa5IsCuko9Q9Zvc8dDkueFXZUUxZ+nxKJio6rl9vVOmWqrmZPFrO6DxcZ8VnWgwW
         TUDtS8ZAO8Tkz+rxxtHKnCwKc7+d6OdrBG10E0hilf+j0b6cJZ9je4AkrALSjJYeaxgj
         GRfwriMNpfEBcVpzeOkaTuNdWsgX4cjPpvN9/IznBso2uUAoQz2jOFp8t/OZONkfcg7K
         ue/asxag+r00JvRg7JdseUqQv6Yt6AlGBsdYCJTEC6AmkZMZL0cVb/A9klstOlkryLiZ
         7Uvw==
X-Gm-Message-State: AOJu0YxeLrGqsYJeg3c7GiljwfcA8P4NnaUnB9yTDCnmdb88z4cWnefk
	aG14RkmYR8/tathYmyx7jB4=
X-Google-Smtp-Source: AGHT+IFjfxR8SyhpDD2CHhPj1RZihrtv76cHwwhgNn12UICD8adET2EFOkbHaNHC8JcH9hgO6qQ4Rw==
X-Received: by 2002:a05:6808:1aa5:b0:3b8:343c:fe74 with SMTP id bm37-20020a0568081aa500b003b8343cfe74mr2951899oib.18.1700681172763;
        Wed, 22 Nov 2023 11:26:12 -0800 (PST)
Received: from localhost ([98.97.116.126])
        by smtp.gmail.com with ESMTPSA id bz3-20020a056a02060300b005b7e3eddb87sm35413pgb.61.2023.11.22.11.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 11:26:12 -0800 (PST)
Date: Wed, 22 Nov 2023 11:26:10 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 yangyingliang@huawei.com, 
 martin.lau@kernel.org, 
 Jakub Sitnicki <jakub@cloudflare.com>
Message-ID: <655e55d2a665e_51e272082b@john.notmuch>
In-Reply-To: <655d15cdb26fb_1fc7a208a5@john.notmuch>
References: <20231016190819.81307-1-john.fastabend@gmail.com>
 <20231016190819.81307-2-john.fastabend@gmail.com>
 <87cywnjblh.fsf@cloudflare.com>
 <bc92c670-f472-43b1-af0b-a50353ed8757@linux.dev>
 <655d15cdb26fb_1fc7a208a5@john.notmuch>
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

John Fastabend wrote:
> Martin KaFai Lau wrote:
> > On 11/6/23 4:35 AM, Jakub Sitnicki wrote:
> > >> diff --git a/net/unix/unix_bpf.c b/net/unix/unix_bpf.c
> > >> index 2f9d8271c6ec..705eeed10be3 100644
> > >> --- a/net/unix/unix_bpf.c
> > >> +++ b/net/unix/unix_bpf.c
> > >> @@ -143,6 +143,8 @@ static void unix_stream_bpf_check_needs_rebuild(struct proto *ops)
> > >>   
> > >>   int unix_dgram_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
> > >>   {
> > >> +	struct sock *skpair;
> > >> +
> > >>   	if (sk->sk_type != SOCK_DGRAM)
> > >>   		return -EOPNOTSUPP;
> > >>   
> > >> @@ -152,6 +154,9 @@ int unix_dgram_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool re
> > >>   		return 0;
> > >>   	}
> > >>   
> > >> +	skpair = unix_peer(sk);
> > >> +	sock_hold(skpair);
> > >> +	psock->skpair = skpair;
> > >>   	unix_dgram_bpf_check_needs_rebuild(psock->sk_proto);
> > >>   	sock_replace_proto(sk, &unix_dgram_bpf_prot);
> > >>   	return 0;
> > > unix_dgram should not need this, since it grabs a ref on each sendmsg.
> > 
> > John, could you address this comment and respin v2?
> 
> Respinning now just letting some tests run for a bit and I'll kick it out.


v2 on the list. Unfortunately the simple fix to the selftests to test STREAM
and DGRAM types caused a test failure. I look at it Monday unless someone
beats me to it.

> 
> Thanks.
> 
> > 
> > The unix_inet_redir_to_connected() seems needing a fix in patch 2 also as 
> > pointed out by JakubS.
> > 
> > Thanks.
> > 
> > > 
> > > I'm not able to reproduce this bug for unix_dgram.
> > > 
> > > Have you seen any KASAN reports for unix_dgram from syzcaller?



