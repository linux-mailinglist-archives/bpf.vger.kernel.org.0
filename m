Return-Path: <bpf+bounces-30282-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9223E8CBE8F
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 11:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2AF01C20DD8
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 09:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DA881734;
	Wed, 22 May 2024 09:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="WAtc0UB1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E26781721
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 09:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716371454; cv=none; b=OD4CmQbvABhrxXHaGluIDo5MNE0jnwx1T71OsZ+TdSNgLmMVyYt1zKRYd7R2lYXbEhht+Fa2PSeG2IrBOZEdW4r0AcxbcVm7w3oFu2No497NTogPxegNG5mIh37LXtXR06VPigeFd8ywaFIjb7BJW/98JlGgBJOKsHv7sGKXd2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716371454; c=relaxed/simple;
	bh=z43IRORribiar+crAULWZYDN90oM49HFlRGZRltN8G0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dhQSHSl2hdKTLEX+sw0Jpz3n7152HMdXSURnnDGcop7183cL9Ej4sOqai4SbemrBi0ddt+jeOQe2u2B2tqLijMfG6fExnG0gOfqotbZgbLpAZ3phg9a8lTgSPlfNdbadLGQaUgPkPYjkzBhn+/0mKM2Z/2wLp3A5EJroZCSYdvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=WAtc0UB1; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5751237a79bso7536021a12.2
        for <bpf@vger.kernel.org>; Wed, 22 May 2024 02:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1716371451; x=1716976251; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6Ex3aZZm4D5w1Bed0krlBVY2vwDtVuYFV3j7+qw0Xbw=;
        b=WAtc0UB1D3Hd742ZwdnqYpr6O0lvNl1gqruHB38kJy923OBTpHm/5br0k71CoIhEt9
         uNTMn+YXSMpskc4SNk+PDCkLS4xboE3clGiD9eklRIoP0+/o6ksmpNS11z/lNJ7sK7Ag
         oNGwkzrH3f1TveO5UEQ4BqH8dBGF7nIdqUy/iZIGrvUSfX7uNSAv6T91gcUj7emGlVzg
         UJEI1/fIrXi9Zrgig+s97RPgFPgEggzPvDaavwFjsCsKLmlsV/Jt/QuiVnyBgJ84E28J
         LFzM4J6ArPz/9aLm2EVhVA5JCPq98vuwuh6BqPpKyBn0QR6nsLXaBKEp/7/3uLRrqmUs
         P32A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716371451; x=1716976251;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Ex3aZZm4D5w1Bed0krlBVY2vwDtVuYFV3j7+qw0Xbw=;
        b=UhhW3cgcP4fIgT3qUrVzaSOKV/WEua0Em57/R4UzBLY0xcHw8eJlPFDHG8gtDwKAic
         xNlMdQycFo3KqQOiX7Y97FaWUmGc0XRBeys2Kz4CLmFDzZxrNFUzwbSKSNl5PnOBC4tO
         dQdR9Owyv6DYxqK6M5CS9/K7NASaCJ2hbMOom7DGRk5kuqEtHvj7sDM3QupPbsMa6mlN
         tIH3OdiRs8ryc5yX91MJ5bEHtYK5/z5o7s2vLGlj0iBm4XcKUpMA0qSlPUQl5bLkAYOq
         sJixHJUPrLbYqjPGj4wqJ5o9pQbRpWdfvvHQPwmfPJvF42KcDLfqlYztKVLPrMM9+Kbb
         PTaA==
X-Forwarded-Encrypted: i=1; AJvYcCW+Nf8yAlTCUXpUHKEfnhf3gOGWglwWkCuX1RL0qhRQvOHqven7Rz1mb6RNZv1wtZp0URWQFxTgZanOdds+X6N518ae
X-Gm-Message-State: AOJu0YwXzxyXLUyZbY3efn/Wy8tOEspv9KIkyanaxop/kbwBfx1s+LyL
	Nk+FO8X5LEBvpIcFLzp28sKxYSGpVs22/oa1BejmzM6vEYXp/iC1Tg0ZDcXtBGA=
X-Google-Smtp-Source: AGHT+IFLQ42GWSxj9rsp3TwgQQW8TBhyqtoMwkS/OgPeeXi9ZNzYopUkWWXHbVb297fqpZltZcpo7g==
X-Received: by 2002:a50:9fe7:0:b0:572:1589:eb98 with SMTP id 4fb4d7f45d1cf-57832a4c441mr778308a12.12.1716371451466;
        Wed, 22 May 2024 02:50:51 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:b7])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733c2cb54csm17950603a12.60.2024.05.22.02.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 02:50:50 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Hillf Danton <hdanton@sina.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,  Tetsuo Handa
 <penguin-kernel@i-love.sakura.ne.jp>,  Eric Dumazet <edumazet@google.com>,
  Linus Torvalds <torvalds@linux-foundation.org>,  bpf
 <bpf@vger.kernel.org>,  LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bpf, sockmap: defer sk_psock_free_link() using RCU
In-Reply-To: <20240521225918.2147-1-hdanton@sina.com> (Hillf Danton's message
	of "Wed, 22 May 2024 06:59:18 +0800")
References: <838e7959-a360-4ac1-b36a-a3469236129b@I-love.SAKURA.ne.jp>
	<20240521225918.2147-1-hdanton@sina.com>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Wed, 22 May 2024 11:50:49 +0200
Message-ID: <877cfmxjie.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, May 22, 2024 at 06:59 AM +08, Hillf Danton wrote:
> On Tue, 21 May 2024 08:38:52 -0700 Alexei Starovoitov <alexei.starovoitov@gmail.com>
>> On Sun, May 12, 2024 at 12:22=E2=80=AFAM Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> wrote:
>> > --- a/net/core/sock_map.c
>> > +++ b/net/core/sock_map.c
>> > @@ -142,6 +142,7 @@ static void sock_map_del_link(struct sock *sk,
>> >         bool strp_stop =3D false, verdict_stop =3D false;
>> >         struct sk_psock_link *link, *tmp;
>> >
>> > +       rcu_read_lock();
>> >         spin_lock_bh(&psock->link_lock);
>> 
>> I think this is incorrect.
>> spin_lock_bh may sleep in RT and it won't be safe to do in rcu cs.
>
> Could you specify why it won't be safe in rcu cs if you are right?
> What does rcu look like in RT if not nothing?

RCU readers can't block, while spinlock RT doesn't disable preemption.

https://docs.kernel.org/RCU/rcu.html
https://docs.kernel.org/locking/locktypes.html#spinlock-t-and-preempt-rt

I've finally gotten around to testing proposed fix that just disallows
map_delete_elem on sockmap/sockhash from BPF tracing progs
completely. This should put an end to this saga of syzkaller reports.

https://lore.kernel.org/all/87jzjnxaqf.fsf@cloudflare.com/

