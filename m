Return-Path: <bpf+bounces-30120-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4398CB187
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 17:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34E311C21714
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 15:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E33146D71;
	Tue, 21 May 2024 15:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwITdQ4g"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAF0446B4;
	Tue, 21 May 2024 15:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716305947; cv=none; b=ZBLlZ4aug7YL+0Za06gp37+qKGPV1+DEvCXLi4CBE9NRHNBQiAs5j+ssiiFE1I69DZ80sLhMF9HvzLNvpQpEK192+QFvoQbKOhNsJox0lDlj8uiQ8iBF2cpQF1ZqWx+BpwdFmoQrK7IQXmvfeZTxxIaakiMaVt4KO8a3hv9Ay3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716305947; c=relaxed/simple;
	bh=SaoDykVHDT1haqx/gobymWgMMDw49xu2u/ehUnA457s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IAzxM2hx7LY3UirLuYNC7fWFW0OkhRtzcTOKOGq33qcHXJAb1DEdXERBFuW/+I4XOYXJFUbRbNOvY+As0SktBc2pblptmi+2I4t5OMryVu3y6kjl3l7/y0FTtXCnpiG7c4n0k05SVChQLXvRuJaDKy3JOorKBUtFRbt0MNWGXlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwITdQ4g; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e1fa824504so50413911fa.0;
        Tue, 21 May 2024 08:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716305944; x=1716910744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Re8Wl04dqGPF7qQ9KzoZRZT9kKy3SUlswFv2Sj3Vy1Q=;
        b=KwITdQ4gtEzQKyC1uafxOdr/5QHc9+PBSIHoFNJwmcXyy3Ply8NLEWh/dhiiL9ylYb
         GH3CSQtelaFDz3GYZvpmBv038A/F+AVEBdPfgo3QSTG2vhkqzpC7WlVeYNV/G8vrcNgk
         Wfucfb/w00TNrKgMch1M5+3j9M6xGI5rh3tEmo8zijDhgchA9RJ30ZbU48qQDKwysNSm
         OkWmapsKz1M4keo7ACeW84qFcU0QZU5yyN+Ju2fS90rXMKgt5UaY3kC083dNiZ8bsEEv
         B9RCuxEiMLMwJ7hDLtNFxMuVDiXkpTbDiRyaG1qCoWkwmJ5NhMzEfwWRyOH7sZRlkf7G
         9DiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716305944; x=1716910744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Re8Wl04dqGPF7qQ9KzoZRZT9kKy3SUlswFv2Sj3Vy1Q=;
        b=NaACMrIZG1kIy+CP/G2rahlebpYGvVSI57dmUNYIoRpgKBKNbiMapClwoO4nH7j152
         fMqCx8+Fx53uIKyqBgXf4Hl2Cv7Oa8pdgPvIoDv9EFIjjgZEHxvLYI/bj0PvIC22cNXt
         HJFHx9JKE28D27g4tRpIM0lR2eneFP4AfmIy2UY7nMmBmeEc22fJyH1NguFTFJ5Ird8i
         4pjd3mCWkM8ddU4UINngIcuwcK3FKDkbsCmvp5cYW6G1n7eloJzDuwudnWtqREruBPea
         1tCVg0m2j4L168VVfy0xnoq47ZQTXS9lpHe0Pj4iksSD5HE/V67WPBM9SsQDtGyTaZs8
         oq9w==
X-Forwarded-Encrypted: i=1; AJvYcCXrBs9LHGFJrBuk/T403KjeJsFwetJYRjdSkFAExi1utniFaVds4dt0TuZI4R2Q9iRcZaLBA0as0y4LFgUysYdvn6Dn0raHqp97g/F3kTinZ9ps7RA3GPqJmlooT2RtES9+ZfZNqryJYxcpciDnF+im4vxc3Lc+a8Mf
X-Gm-Message-State: AOJu0Yxree6V//rhlX+vM8qXcEKdklmdnfmKnRj9a2ae6cGRg4/unjsX
	C+U7tvLzqw1qHZDJbZjEhrgwBHt6U7nr9ZSYfnvqb4b4TZXvlR6iiz4KujzjpR0G3unEnXTkg65
	ZB2LmhTNBacpKETp8aTGR/665+/M=
X-Google-Smtp-Source: AGHT+IFaGIESxaIVgOuXFNadzUbBxUG8lqP5Jsv9vQbu94Ihc13oMyxcq9BJ/Wa9ujLSsAIJ+axGQK/3JuRVLT8D5pc=
X-Received: by 2002:a2e:9e48:0:b0:2e5:67bc:6f2 with SMTP id
 38308e7fff4ca-2e567bc07c3mr158550351fa.44.1716305943818; Tue, 21 May 2024
 08:39:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <838e7959-a360-4ac1-b36a-a3469236129b@I-love.SAKURA.ne.jp>
In-Reply-To: <838e7959-a360-4ac1-b36a-a3469236129b@I-love.SAKURA.ne.jp>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 21 May 2024 08:38:52 -0700
Message-ID: <CAADnVQKuPJv-GNH9SAWL-esSERMXJmSamWRe7AG3cW=NTnf51w@mail.gmail.com>
Subject: Re: [PATCH] bpf, sockmap: defer sk_psock_free_link() using RCU
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 12, 2024 at 12:22=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> If a BPF program is attached to kfree() event, calling kfree()
> with psock->link_lock held triggers lockdep warning.
>
> Defer kfree() using RCU so that the attached BPF program runs
> without holding psock->link_lock.
>
> Reported-by: syzbot+ec941d6e24f633a59172@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dec941d6e24f633a59172
> Tested-by: syzbot+ec941d6e24f633a59172@syzkaller.appspotmail.com
> Reported-by: syzbot+a4ed4041b9bea8177ac3@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Da4ed4041b9bea8177ac3
> Tested-by: syzbot+a4ed4041b9bea8177ac3@syzkaller.appspotmail.com
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  include/linux/skmsg.h | 7 +++++--
>  net/core/skmsg.c      | 2 ++
>  net/core/sock_map.c   | 2 ++
>  3 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
> index a509caf823d6..66590f20b777 100644
> --- a/include/linux/skmsg.h
> +++ b/include/linux/skmsg.h
> @@ -66,7 +66,10 @@ enum sk_psock_state_bits {
>  };
>
>  struct sk_psock_link {
> -       struct list_head                list;
> +       union {
> +               struct list_head        list;
> +               struct rcu_head         rcu;
> +       };
>         struct bpf_map                  *map;
>         void                            *link_raw;
>  };
> @@ -418,7 +421,7 @@ static inline struct sk_psock_link *sk_psock_init_lin=
k(void)
>
>  static inline void sk_psock_free_link(struct sk_psock_link *link)
>  {
> -       kfree(link);
> +       kfree_rcu(link, rcu);
>  }
>
>  struct sk_psock_link *sk_psock_link_pop(struct sk_psock *psock);
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index fd20aae30be2..9cebfeecd3c9 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -791,10 +791,12 @@ static void sk_psock_link_destroy(struct sk_psock *=
psock)
>  {
>         struct sk_psock_link *link, *tmp;
>
> +       rcu_read_lock();
>         list_for_each_entry_safe(link, tmp, &psock->link, list) {
>                 list_del(&link->list);
>                 sk_psock_free_link(link);
>         }
> +       rcu_read_unlock();
>  }
>
>  void sk_psock_stop(struct sk_psock *psock)
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index 8598466a3805..8bec4b7a8ec7 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -142,6 +142,7 @@ static void sock_map_del_link(struct sock *sk,
>         bool strp_stop =3D false, verdict_stop =3D false;
>         struct sk_psock_link *link, *tmp;
>
> +       rcu_read_lock();
>         spin_lock_bh(&psock->link_lock);

I think this is incorrect.
spin_lock_bh may sleep in RT and it won't be safe to do in rcu cs.

pw-bot: cr

>         list_for_each_entry_safe(link, tmp, &psock->link, list) {
>                 if (link->link_raw =3D=3D link_raw) {
> @@ -159,6 +160,7 @@ static void sock_map_del_link(struct sock *sk,
>                 }
>         }
>         spin_unlock_bh(&psock->link_lock);
> +       rcu_read_unlock();
>         if (strp_stop || verdict_stop) {
>                 write_lock_bh(&sk->sk_callback_lock);
>                 if (strp_stop)
> --
> 2.34.1
>

