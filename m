Return-Path: <bpf+bounces-73544-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A47C337DC
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 01:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4A9C734E3B8
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 00:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CA1224AED;
	Wed,  5 Nov 2025 00:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCrTr+VL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04EF1A76D4
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 00:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762303260; cv=none; b=FL+Rm76YsJYAgALTpj4PvnKTTVOcCBgPf/IoAuIeVz/h0Y7ZQDaWrRLGmsiGinV4YR/RWd32CeIQVWL48AEWOty3Jd/FvcNchFSxZGTA98p8Ro1NK7loop3sQYyCVeWDSAagkHOg49bstcmtJdw+NO1I3zry3RvsHXxwMM7cIzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762303260; c=relaxed/simple;
	bh=eQSojdtgLVR7/Kw+4EOTYx2+5jfhiuoErGVSlDeTdfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=moUWL4fdX0bwybVGNLuiEBwjyu/rYkvJ9bnLuausY1ruMNau4pSDyFROrB8Kl9vohu2dgYjy3Blgtpnls/c6lQODFm5XjQBkFhEbE7DIqJiYVFLOzjltR37ZMtOYqFXZ+Pq/r9GZAgESyh2dqqdWKYKRRAammycTQN4T5U+IDNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hCrTr+VL; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-340299fe579so6042520a91.2
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 16:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762303258; x=1762908058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pH0elYSV9fHZGweJNo1sTUp7pNpnKPw4ARHFUWVRcc=;
        b=hCrTr+VLmiTyWWxf6FlbvFe6pvIUqN1fl8qyvENNvzJW43XoxRUkF3rl77i93W0IY/
         DBh53vLNtNvNgXBfl+Hw40h1W/FTCSDBMb9HCdIgLElz1UlApf0qGNBIjDZRTOAJa9VM
         uErApLM7Yj6XyAOKcjusa0QEvC8J76VdjVHyMppwTekG/hqazKOMVqk4BASx82fb1HtC
         2XhxCIVqTXEEy7DR0EeBmKWyzCaR5/YwQkeEp26uafbx7JgzwIZEp7uRWxkWzB7yzwLm
         wz8Bxyu2DxAGZ0zS0W8d06ui4s8+W2xKPndTkjbM8urpXnHQIbAHJEGsPfW19Hd25Tg6
         ZDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762303258; x=1762908058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5pH0elYSV9fHZGweJNo1sTUp7pNpnKPw4ARHFUWVRcc=;
        b=VmoiliaFGZg4MNFPO6UzU7Co3KAHSdJJHqe/u3tJwngBtdLQZuLyMO0FkRqFkRa+jg
         8n9i1nwf/Co6uDZri2bPBZu+3C0yHnL0yT/GjrQelJdZjaP/D08asimaQF+QlJzt0sWK
         QGQf8as4fY9cNsjYsqX9icFNun/NpHarRh5xfnxEpSI/6ccEMZl2wUrlBMNNFZVr3ovn
         tnJnwwTy9mKmRYsIEw07wotcCePzJ6hur1N7ljnYYtTvCWIz0LoA9HVuhNBjgGm1wp8I
         F0mGYPev62YdWNG4Y0O+oa4zX6XgBwKFXgbwRFzIwUOsFoCFKjpdCiTQvaSb9Bf+i4gq
         d94g==
X-Forwarded-Encrypted: i=1; AJvYcCUyRGREAAbPiSFhmR3a+kmNeJm6zdmu7LozYdlQoFfK0dqELv8N4/adJVgFUw99F6CYeNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDuUB1ZNF8LeDgCZh1AneWSTsRagqeZbjI5PuKkN2iibqbGpuw
	xCpOi5A/fbIQstOC3GhyDiGm9gppqFSBnDruduDSUPVh/VM/5E1RNtAYoZ469qDp98CPP0aivYl
	ztMT9a8qW+n+o2DuCWkpttWPuYOeQ4Aw=
X-Gm-Gg: ASbGnctzgly6qM/4NLaJFc1/qE7J716T3Q5IF2gey5vZUznpiUXR7MVPpc0CL2/QG/9
	0CBd+h5OypaDXBiRRsXXE2HdkvZQynFUOU/N/gxjPg1k1bQeeRntBWrcjhO4hJRMxSeSt6vRdtx
	svxeJyYf19JJ5pJCEqBXDt/Qe7BaFE+IKEEA7nTvUnbPCC70KhqF1AivViR+eYvw8PeVAm1DiLP
	WmHxZGDuu4qZJn5gPGn2bLYXvaJb/77xP2yfMtgjrqbA8eNnkh1G7V92waT3ql9fuSa35dIP36D
X-Google-Smtp-Source: AGHT+IH9I9hiPSdGirkpxUD9Q91UxnbQt7srf4hv2bz+O5oUIH8hTOKqw/mh5p6X8l4L3pU16XyWHwFeTmNF35qvvNc=
X-Received: by 2002:a17:90b:5281:b0:340:5b6a:5bb0 with SMTP id
 98e67ed59e1d1-341a6def359mr1525214a91.26.1762303258061; Tue, 04 Nov 2025
 16:40:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026030143.23807-1-dongml2@chinatelecom.cn>
 <CADxym3Y4nc2Qaq00Pp7XwmCXJHn0SsEoOejK8ZxhydepcbB8kQ@mail.gmail.com>
 <CAADnVQKDza_ueBFRkZS8rmUVJriynWi_0FqsZE8=VbTzQYuM4w@mail.gmail.com> <3577705.QJadu78ljV@7950hx>
In-Reply-To: <3577705.QJadu78ljV@7950hx>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 4 Nov 2025 16:40:43 -0800
X-Gm-Features: AWmQ_blJIoxjnat4nYQEP4--m4bEcKCdlXG0h1PFwD7EYD3Nc5RBayfWiCPvzpA
Message-ID: <CAEf4Bzas7Or4yPzqdHqEcgVpTDx2j26dR5oRnSg7bepr-uDqHw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/7] bpf,x86: add tracing session supporting
 for x86_64
To: Menglong Dong <menglong.dong@linux.dev>
Cc: Menglong Dong <menglong8.dong@gmail.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Jiri Olsa <jolsa@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Leon Hwang <leon.hwang@linux.dev>, jiang.biao@linux.dev, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 3:29=E2=80=AFAM Menglong Dong <menglong.dong@linux.d=
ev> wrote:
>
> On 2025/11/1 01:57, Alexei Starovoitov wrote:
> > On Thu, Oct 30, 2025 at 8:36=E2=80=AFPM Menglong Dong <menglong8.dong@g=
mail.com> wrote:
> > >
> > > On Fri, Oct 31, 2025 at 9:42=E2=80=AFAM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Sat, Oct 25, 2025 at 8:02=E2=80=AFPM Menglong Dong <menglong8.do=
ng@gmail.com> wrote:
> > > > >
> > > > > Add BPF_TRACE_SESSION supporting to x86_64. invoke_bpf_session_en=
try and
> > > > > invoke_bpf_session_exit is introduced for this purpose.
> > > > >
> > > > > In invoke_bpf_session_entry(), we will check if the return value =
of the
> > > > > fentry is 0, and set the corresponding session flag if not. And i=
n
> > > > > invoke_bpf_session_exit(), we will check if the corresponding fla=
g is
> > > > > set. If set, the fexit will be skipped.
> > > > >
> > > > > As designed, the session flags and session cookie address is stor=
ed after
> > > > > the return value, and the stack look like this:
> > > > >
> > > > >   cookie ptr    -> 8 bytes
> > > > >   session flags -> 8 bytes
> > > > >   return value  -> 8 bytes
> > > > >   argN          -> 8 bytes
> > > > >   ...
> > > > >   arg1          -> 8 bytes
> > > > >   nr_args       -> 8 bytes

Let's look at "cookie ptr", "session flags", and "nr_args". We can
combine all of them into a single 8 byte slot: assign each session
program index 0, 1, ..., Nsession. 1 bit for entry/exit flag, few bits
for session prog index, and few more bits for nr_args, and we still
will have tons of space for some other additions in the future. From
that session program index you can calculate cookieN address to return
to user.

And we should look whether moving nr_args into bpf_run_ctx would
actually minimize amount of trampoline assembly code, as we can
implement a bunch of stuff in pure C. (well, BPF verifier inlining is
a separate thing, but it can be mostly arch-independent, right?)

> > > > >   ...
> > > > >   cookieN       -> 8 bytes
> > > > >   cookie1       -> 8 bytes
> > > > >
> > > > > In the entry of the session, we will clear the return value, so t=
he fentry
> > > > > will always get 0 with ctx[nr_args] or bpf_get_func_ret().
> > > > >
> > > > > Before the execution of the BPF prog, the "cookie ptr" will be fi=
lled with
> > > > > the corresponding cookie address, which is done in
> > > > > invoke_bpf_session_entry() and invoke_bpf_session_exit().
> > > >

[...]

> I have to maintain a hash table "m_context" to check if
> the exit of skb_clone() is what I want. It works, but it has
> extra overhead in the hash table lookup and deleting. What's
> more, it's not stable on some complex case.
>
> The problem is that we don't has a way to pair the
> fentry/fexit on the stack(do we?).
>
> >
> > > AFAIT, the mast usage of session cookie in kprobe is passing the
> > > function arguments to the exit. For tracing, we can get the args
> > > in the fexit. So the session cookie in tracing is not as important as
> > > in kprobe.
> >
> > Since kprobe_multi was introduced, retsnoop and tetragon adopted
> > it to do mass attach, and both use bpf_get_attach_cookie().
> > While both don't use bpf_session_cookie().
> > Searching things around I also didn't find a single real user
> > of bpf_session_cookie() other than selftests/bpf and Jiri's slides :)
> >
> > So, doing all this work in trampoline for bpf_session_cookie()
> > doesn't seem warranted, but with that doing session in trampoline
> > also doesn't look useful, since the only benefit vs a pair
> > of fentry/fexit is skip of fexit, which can be done already.
> > Plus complexity in all JITs... so, I say, let's shelve the whole thing =
for now.
>
> Yeah, the session cookie is not useful in my case too, I'm OK to
> skip it.

hmm, in my view session cookie is one of the main reasons why
"session" concept is useful :) that's certainly the case for
multi-kprobe session, IMO (and yes, I haven't yet used it in retsnoop,
but it's just because I'm lazy, not because it's not useful... )

>
> The pair of fentry/fexit have some use cases(my nettrace and
> Leon's bpfsnoop, at least). Not sure if the reason above is sufficient,
> please ignore the message if it is not :)
>
> The way we implement the trampoline makes it arch related and
> complex. I tried to rewrite it with C code, but failed. It's too difficul=
t
> and I suspect it's impossible :/
>
> Thanks!
> Menglong Dong
>
> >
> >
>
>
>
>

