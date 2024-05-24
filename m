Return-Path: <bpf+bounces-30485-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CE68CE5B7
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 15:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09EEA1F2205E
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 13:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D82E86657;
	Fri, 24 May 2024 13:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Q/UEguK6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF348663A
	for <bpf@vger.kernel.org>; Fri, 24 May 2024 13:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716556015; cv=none; b=Wt8/G3/neLNktbLKRUyTRnYsb59oOLf3u0xW9ZBMmwvYNSuNKD8gnb27WkYEdJ0sQUEwrPdYerZL6hCmkr/SjLBfLB8SymKJfaS3yPVWJrEuj4DDh7EghnVmOzAFZuddat9cAeYH0VQp1rduBiP9FcZZLjoQgYCo8NsbAq3O4Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716556015; c=relaxed/simple;
	bh=5V2+EptcI6TX7J2zROHp8bQdWXegKov5jcgAdU9YNXU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uPJVHXetkLNM+9uKz5fgXMjw7flEPf+YwMnF9ddpSQxrBUSSzlmuDVEaoRF43VbjEZOnkLEaOkdtUYRWeeIKM8Epd3DiLHcJ/G5E3nUznp6phPz4qDxm4DfXcjc8Qe+HFGtv7jiT8Cu812PPGAq5rUelhjdlkDRY6bRXtfmnhJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Q/UEguK6; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a6269ad71b6so100299466b.2
        for <bpf@vger.kernel.org>; Fri, 24 May 2024 06:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1716556012; x=1717160812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5D4uHBRMvW2P1UolsuKrkfSqzKnJV+XORhvSy/dA9yo=;
        b=Q/UEguK6PDGhX+UCJNFghbk69D3ot1x4AXHDUHp1F5GrDXcIHVtNk8XiQv/llKCHcx
         S8guw4sF6kLpm2nfhWoU17rvw9igvGEdugb654GiNPT08fYfHz5NjqGSP9s4iW4+SJ+o
         mDiboXLD+diWqFheZdcTYjJeL8CWAe1OF5zKb79QTddljULshffHKc/NGEQH1CZzzZiN
         HKvXpOkKe9PkzD2OxvL9731cKYcYndL6O3HlVrvKrZfb5PAEmXh5nNaoUXq4VWrbZ2Bb
         66o8fm8JVJlEgx2JVw0LqVfQFK1Ulh9wvb+VXfLsI+urkTYhaaZkpxrRY2e3JYi4S5vP
         6WEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716556012; x=1717160812;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5D4uHBRMvW2P1UolsuKrkfSqzKnJV+XORhvSy/dA9yo=;
        b=ZuG+cDVvrv243xH3PS01AQESJTXRPzAhSAjIWmJnSrir36OgC2tNH9gYAmI4GfUcVl
         TMZ6XuSufkr/LC9cEfYy12sVLVVxbiDdidOqfT0JUKiL6UTcEPWogtKBKIWXHgM/jlYJ
         kLX/tgGMW30xTrVCWyKQ1z0wg/S1T588jKiGTkbDNdFSE9WY/kmYG3eR0StF4tO/KRTj
         KvIFU5y4EyHt7HWtnCi6/+Mk6JbNc/tzy01eIoB9ZmUsYpHK2+H+062v2/eVsPoMyOWV
         uRIaHqebQZvzA3OOj6TL2KIKid+yDcSQ4xuhmn70g9rEiYcXHS39zeCWxO/LvGf4rTDg
         mKyA==
X-Forwarded-Encrypted: i=1; AJvYcCXxEXIMmBBGoCvEx6tA+qIi/1HyKBGxk0A/gVZ9MBhhLoptlaNh0yZMNVsAws4S7fqKVNNzXcREon0tromJGxy2s+t9
X-Gm-Message-State: AOJu0YxxalE4Eppc7v6jvihVvDtNelFMEa2tOgqH8wWXMA8YH0bkkTle
	TY3zM4i9m45eBA1dtKBQXGaxDS1coAdluLAE/qPVisgqc33xrZWHQdmjjrzDJv68z8R1cb5zPJQ
	r
X-Google-Smtp-Source: AGHT+IGEG7/JrO6Dtf30LBLhIMaqw1L8qmyybu7t7SjQaXvHTTGgjoVnuSm6jeH023DXQ3qCeIvmug==
X-Received: by 2002:a17:906:e258:b0:a59:8cd2:5b2c with SMTP id a640c23a62f3a-a62646cd7d5mr152421066b.39.1716556012345;
        Fri, 24 May 2024 06:06:52 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c9376dasm129455466b.54.2024.05.24.06.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 06:06:51 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Hillf Danton <hdanton@sina.com>,  Tetsuo Handa
 <penguin-kernel@i-love.sakura.ne.jp>,  Eric Dumazet <edumazet@google.com>,
  Linus Torvalds <torvalds@linux-foundation.org>,  bpf
 <bpf@vger.kernel.org>,  LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bpf, sockmap: defer sk_psock_free_link() using RCU
In-Reply-To: <CAADnVQKfbaY-pm2H-6U_c=-XyvocSAkNqXg4+Kj7cXGtmajaAA@mail.gmail.com>
 (Alexei
	Starovoitov's message of "Wed, 22 May 2024 07:57:48 -0700")
References: <838e7959-a360-4ac1-b36a-a3469236129b@I-love.SAKURA.ne.jp>
	<20240521225918.2147-1-hdanton@sina.com>
	<20240522113349.2202-1-hdanton@sina.com> <87o78yvydx.fsf@cloudflare.com>
	<CAADnVQKfbaY-pm2H-6U_c=-XyvocSAkNqXg4+Kj7cXGtmajaAA@mail.gmail.com>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Fri, 24 May 2024 15:06:50 +0200
Message-ID: <87a5kfwe8l.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 07:57 AM -07, Alexei Starovoitov wrote:
> On Wed, May 22, 2024 at 5:12=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.=
com> wrote:
>>
>> On Wed, May 22, 2024 at 07:33 PM +08, Hillf Danton wrote:
>> > On Wed, 22 May 2024 11:50:49 +0200 Jakub Sitnicki <jakub@cloudflare.co=
m>
>> > On Wed, May 22, 2024 at 06:59 AM +08, Hillf Danton wrote:
>> >> > On Tue, 21 May 2024 08:38:52 -0700 Alexei Starovoitov <alexei.staro=
voitov@gmail.com>
>> >> >> On Sun, May 12, 2024 at 12:22=3DE2=3D80=3DAFAM Tetsuo Handa <pengu=
in-kernel@i-love.sakura.ne.jp> wrote:
>> >> >> > --- a/net/core/sock_map.c
>> >> >> > +++ b/net/core/sock_map.c
>> >> >> > @@ -142,6 +142,7 @@ static void sock_map_del_link(struct sock *s=
k,
>> >> >> >         bool strp_stop =3D3D false, verdict_stop =3D3D false;
>> >> >> >         struct sk_psock_link *link, *tmp;
>> >> >> >
>> >> >> > +       rcu_read_lock();
>> >> >> >         spin_lock_bh(&psock->link_lock);
>> >> >>
>> >> >> I think this is incorrect.
>> >> >> spin_lock_bh may sleep in RT and it won't be safe to do in rcu cs.
>> >> >
>> >> > Could you specify why it won't be safe in rcu cs if you are right?
>> >> > What does rcu look like in RT if not nothing?
>> >>
>> >> RCU readers can't block, while spinlock RT doesn't disable preemption.
>> >>
>> >> https://docs.kernel.org/RCU/rcu.html
>> >> https://docs.kernel.org/locking/locktypes.html#spinlock-t-and-preempt=
-rt
>> >>
>> >> I've finally gotten around to testing proposed fix that just disallows
>> >> map_delete_elem on sockmap/sockhash from BPF tracing progs
>> >> completely. This should put an end to this saga of syzkaller reports.
>> >>
>> >> https://lore.kernel.org/all/87jzjnxaqf.fsf@cloudflare.com/
>
> Agree. Let's do that. According to John the delete path is not something
> that is used in production. It's only a source of trouble with syzbot.

Cool. The proposed API rule would be that if a BPF program type is
allowed to update a sockmap/sockhash, then it is also allowed to delete
from it.

So I need to tweak my patch to allow deletes from sock_ops progs.
We have a dedicated bpf_sock_map_update() helper there.

[...]

