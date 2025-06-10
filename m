Return-Path: <bpf+bounces-60193-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D779AD3DD3
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 17:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3AA63A35DF
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 15:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9492238150;
	Tue, 10 Jun 2025 15:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSM+meW+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902DC22A4CC;
	Tue, 10 Jun 2025 15:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749570137; cv=none; b=V3EuSaXNBenm8t51aniIgJxYNWZqMoun90SGd0ENBlp/saDkycWpCZBsFIU1NdDVx7sJeiBUvcFBa5Pe0PeRL2KAQ6pgx6POyxfJ7Eh/+LhAn+EFYSE/ZTyEnwYQv3ZQIrdmkUT60beIb7/HL6EYEtcNuUPhEwvIBxRdj1HOzvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749570137; c=relaxed/simple;
	bh=yU5z7NVJf0ZGnk9RFyz5G+eeykduta97xm9PAycnmlo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pqmmyDpS6BOLljHEpvchB1/DCdrpovhoo9acgk6a3DO42w2F6ymoAQruKnDTujNxc7D26QlUUreyHpc6w4Vig2nVkoUmVYVmSNW6dbAjgBEqRi3OIxfmHENPIWcyMbpMR2qsOG5rNJ7LgcX7znOHJtXbnqwVYFBhI+n3+6ceLoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GSM+meW+; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so44858875e9.1;
        Tue, 10 Jun 2025 08:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749570134; x=1750174934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=An0x98MW8GyvK9C4LlLhjzsNtEGQ7tKMYBI6UkPjrc4=;
        b=GSM+meW+wBQ1U6oPkMdMOG3t88tJRzX4YO1/zR2sV5KsjBntgGGku4fCjjJSEf1Jrp
         u6GjxYSb++rWnq9qiNvDwdrb/AtCsekA8a0E3bzNEs/Op30FZWmAgb+GQkftcyephtnP
         gvZ7bqtU6pVS4aOyUIVjgCFvZre3h5wwKmbIv7S98ni50HNiHku4/kpc16eiF5xWu0LM
         GbTSEf2Dmws+Ced0ESp3J33suzQDxjoh4wTJfGz+tUe/t1YeI/cyoi6tmwGtAqecX48y
         nu+1l5Ndd4xoWP4wGNbQCbWAHhfC4GkIdAxknDxNwrpBqs6CF49x8RnZ/wby2+vh/WW9
         dTqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749570134; x=1750174934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=An0x98MW8GyvK9C4LlLhjzsNtEGQ7tKMYBI6UkPjrc4=;
        b=La0n/5DJ2Eny07b2QWoYDYeD3UmyiyXgubEGihO3eG0aQnIHu1Dq/SPjZKZFpvF6z9
         R1SIGoAxpQu9vC6ZhTXOA2WxW/E5mrLv5Wbupnl4fB3N8zZmgibrHr7r8mnoVAae38Nx
         1nyxg1kVwRDzK01RAgvY2WSaqYCqMrUhU/+bnIK91E/+97+hEdDvVnD93AEExWoB6K1/
         tNntYO8vlhLlFCRMAYj6WWsxxsUWk930cAovINoKfcaX8UDcu2lvCUOZtPpPIBzM5e1z
         0QwCWsG0fyI+6DRsGB60WYTni9y0tj7YoEiZTm5tbYM+IfVdjPzTp3rArnDoZ6R1vLyz
         XO4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUWVEXB8jz12JdvquGpAhwfZSM9HuwZZICA7fPkM62LYvBBhUdkiXcKZPCrY/THLcd9q2GxFfgo@vger.kernel.org, AJvYcCWIu3Iw62gOFHs7zFiOJoD4fOGQ4ReE/9lOCS4RdVcQVgRX8DM6s6lWXgjyHxe81vzuJs5DX49w88mMKISl@vger.kernel.org, AJvYcCWLd6ogkES6w86bnp4NqETISy+B6WnE6TRaqi5lYObitm9k41WwsWKrntpM8nlAk50W3NA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya2/TT8HTBH6D+Z0Ir3GONaZxHUQv8ceWRF2ztyxnphLFWX4hu
	N0H8jLqu5bVA7YApnIoaVl4XnGABbGRANoooEDLgsR25TrI78Pi73V4YsrUMroJ0Zhff5fBCksV
	G+q2gmsaexyR0IQ3u5nbK8uJ8IYPxN0M=
X-Gm-Gg: ASbGncvHEQUhifKkuB6wwI9TqfjfGVoftUcnDPwCyMTnHBs7u/UByf14Tr9/e8BSoUU
	/Wpk0ePHDjfaTrKQb24QmJwKJ+6GSPW32vceUwAWIFZkJ++L51EM6+GdzsMFqUkedpVg6ZYhAsu
	OO2RnwOLmetMhLiII147W2urW8V1INc5rMt/uFWf2X+Lg7KE8gUrA2RM2agdM=
X-Google-Smtp-Source: AGHT+IHM8rnS0aNMuNoWI1TsLts/niaP28EmoxhfJfKkP1MgC1dyL6sDicQYrVvP0wjJ9asjPmkCUOIRk4YaahSUphs=
X-Received: by 2002:a05:600c:8b57:b0:43c:f1b8:16ad with SMTP id
 5b1f17b1804b1-452014d5243mr182679485e9.30.1749570133345; Tue, 10 Jun 2025
 08:42:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250608-rcu-fix-task_cls_state-v1-1-2a2025b4603b@posteo.net>
 <CAADnVQLxaxVpCaK90FfePOKMLpH=axaK3gDwVZLp0L1+fNxgtA@mail.gmail.com>
 <9eae82be-0900-44ea-b105-67fadc7d480d@iogearbox.net> <CAADnVQK_k4ReDwS_urGtJPQ1SXaHdrGWYxJGd-QK=tAn60p4vw@mail.gmail.com>
 <87wm9jy623.fsf@posteo.net>
In-Reply-To: <87wm9jy623.fsf@posteo.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 10 Jun 2025 08:42:02 -0700
X-Gm-Features: AX0GCFvYQfRa1BcQynirYNrkGMZ4GvpbY9FzJzUuCGW3o-tyfEZpFrhaxIx4DdM
Message-ID: <CAADnVQ+mzrDH+8S=ddDCtyo6YUO4dUUsAS88Jza93pDQ2K3Bng@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Fix RCU usage in bpf_get_cgroup_classid_curr
 helper
To: Charalampos Mitrodimas <charmitro@posteo.net>
Cc: Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Feng Yang <yangfeng@kylinos.cn>, Tejun Heo <tj@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, syzbot+b4169a1cfb945d2ed0ec@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 8:23=E2=80=AFAM Charalampos Mitrodimas
<charmitro@posteo.net> wrote:
>
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>
> > On Tue, Jun 10, 2025 at 5:58=E2=80=AFAM Daniel Borkmann <daniel@iogearb=
ox.net> wrote:
> >>
> >> On 6/9/25 5:51 PM, Alexei Starovoitov wrote:
> >> > On Sun, Jun 8, 2025 at 8:35=E2=80=AFAM Charalampos Mitrodimas
> >> > <charmitro@posteo.net> wrote:
> >> >>
> >> >> The commit ee971630f20f ("bpf: Allow some trace helpers for all pro=
g
> >> >> types") made bpf_get_cgroup_classid_curr helper available to all BP=
F
> >> >> program types.  This helper used __task_get_classid() which calls
> >> >> task_cls_state() that requires rcu_read_lock_bh_held().
> >> >>
> >> >> This triggers an RCU warning when called from BPF syscall programs
> >> >> which run under rcu_read_lock_trace():
> >> >>
> >> >>    WARNING: suspicious RCU usage
> >> >>    6.15.0-rc4-syzkaller-g079e5c56a5c4 #0 Not tainted
> >> >>    -----------------------------
> >> >>    net/core/netclassid_cgroup.c:24 suspicious rcu_dereference_check=
() usage!
> >> >>
> >> >> Fix this by replacing __task_get_classid() with task_cls_classid()
> >> >> which handles RCU locking internally using regular rcu_read_lock() =
and
> >> >> is safe to call from any context.
> >> >>
> >> >> Reported-by: syzbot+b4169a1cfb945d2ed0ec@syzkaller.appspotmail.com
> >> >> Closes: https://syzkaller.appspot.com/bug?extid=3Db4169a1cfb945d2ed=
0ec
> >> >> Fixes: ee971630f20f ("bpf: Allow some trace helpers for all prog ty=
pes")
> >> >> Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>
> >> >> ---
> >> >>   net/core/filter.c | 2 +-
> >> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >> >>
> >> >> diff --git a/net/core/filter.c b/net/core/filter.c
> >> >> index 30e7d36790883b29174654315738e93237e21dd0..3b3f81cf674dde7d2bd=
83488450edad4e129bdac 100644
> >> >> --- a/net/core/filter.c
> >> >> +++ b/net/core/filter.c
> >> >> @@ -3083,7 +3083,7 @@ static const struct bpf_func_proto bpf_msg_po=
p_data_proto =3D {
> >> >>   #ifdef CONFIG_CGROUP_NET_CLASSID
> >> >>   BPF_CALL_0(bpf_get_cgroup_classid_curr)
> >> >>   {
> >> >> -       return __task_get_classid(current);
> >> >> +       return task_cls_classid(current);
> >> >>   }
> >> >
> >> > Daniel added this helper in
> >> > commit 5a52ae4e32a6 ("bpf: Allow to retrieve cgroup v1 classid from =
v2 hooks")
> >> > with intention to use it from networking hooks.
> >> >
> >> > But task_cls_classid() has
> >> >          if (in_interrupt())
> >> >                  return 0;
> >> >
> >> > which will trigger in softirq and tc hooks.
> >> > So this might break Daniel's use case.
> >>
> >> Yeap, we cannot break tc(x) BPF programs. It probably makes sense to h=
ave
> >> a new helper implementation for the more generic, non-networking case =
which
> >> then internally uses task_cls_classid().
> >
> > Instead of forking the helper I think we can :
> > rcu_read_lock_bh_held() || rcu_read_lock_held()
> > in task_cls_state().
>
> I tested your suggestion with,
>
>   rcu_read_lock_bh_held() || rcu_read_lock_held()
>
> but it still triggers the RCU warning because BPF syscall programs use
> rcu_read_lock_trace().
>
> Adding rcu_read_lock_trace_held() fixes it functionally but triggers a
> checkpatch warning:
>
>   WARNING: use of RCU tasks trace is incorrect outside BPF or core RCU co=
de

It's safe to ignore checkpatch in this case.

> I think the best solution here would be to add
> local_bh_disable()/enable() protection directly in the BPF helper. This
> keeps the fix localized to where the problem exists, and avoids
> modifying core cgroup RCU.

That works, but it will add runtime overhead.
I doubt the helper is in a critical path, so I don't mind.

