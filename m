Return-Path: <bpf+bounces-73677-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6988EC372A0
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 18:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 68CBC5074EC
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 17:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3506F339701;
	Wed,  5 Nov 2025 17:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQNBG1NE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D404314B64
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 17:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762363800; cv=none; b=pJUZxq8DcejzFyPDNekh50Uc+1Qwv0RyYgVbpw9nu+irK5ng44aQa5YOF1lH0lS3x5zpu7RLBIgclapF3vwThDQhogigdtNEzjHT2Ng26b3oRmG06ef3wq1kLOlQDPkKFQK9X9bMyeRrh3rkqFhkvKTkOaCZPf0Zb8QhsrFHR8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762363800; c=relaxed/simple;
	bh=RvSfWVZfvt6ZvxqcXys/+zepByojWnev0+IFDvJvzak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pta+pl5o53rSZOqW+5S3QWmk5CUwWVmeOI3+yTBm4fQ616XYgEZH9h0Tnuu0F3GR4YJU08VyfrjM6USouS0E4BcIrDtnExXP5J2DsKd8jA7CGqurjQD5/45xuzREB5bCI7zXy22LLLMH4d+Qdq5wk7NkTXKuoYjHqseKpop95c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQNBG1NE; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-340564186e0so143266a91.0
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 09:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762363799; x=1762968599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2hQIMYQG3Hf6nYd9wO88tObbD60jSpKwJAfmQ0sEW4=;
        b=RQNBG1NEJPSwLEnYZj1C9N2ryyjY5yZTyipLqw2liAucEx0iNOabw/9sp+SSjX6HCJ
         Mnfwvynj/kPqm0ctoICyvamvjGiG9V6qcpqrpN8xf3u23kqIE39lsnL2fExB1pU4mqzB
         GcoVzZfSJeuqgOCufONYBTKlgWXOfCBovtX3FzVQED1vaDyzcJAKYOG6JUKq4pu/Mr1W
         we3cDA6XNa3wHmn1HIMh/2Widk/TB4Zyq/Q7LzQzCGg04XqKaHtzJfd9YEX+jFMRX1Br
         M2ri8BUf1dagz/wdZxHQXPEVEUzHWPNEseIWFCRTENP46YFsOHIBMW7EGb1eOdtMwHpr
         fHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762363799; x=1762968599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T2hQIMYQG3Hf6nYd9wO88tObbD60jSpKwJAfmQ0sEW4=;
        b=rWG6TxEa16gINSQC+wWtjJ7O2Eazi5sfoWLcSIxs46xrF7dRvl76eTVWOfbbcvEmc0
         udIwW5Jsu6RP2TEqlU/4BYRePlL7AMFKVxy40ZSiIswD4fgDuERhiEsp2wpooF5Kg16y
         IWgWliPd0CA9QcJAEShlPPS4iuqGM0L+OVEvGDy/SD/A0H1GzQrGUCSyTTL8g9hzXK8V
         CNAV2JEI4YPvy48KMnyyKP33rfZA+lJrydp1sYGd77shRE/ri6KBcl99h6ct5EGPu1lw
         0j+OUazMe6g6/aJZ7C/XFN/Zh6K7sEwP7uRL74HsYvgWHGr57XDs6R2Yhzm+f99XRdTK
         kJCw==
X-Forwarded-Encrypted: i=1; AJvYcCXFqU+9+kLYLJkPmSYkzYYfl1aj6sy8sfbiEBjiB7vOhFHdvtF1S5DZoW5VC6ZNqpO2wQg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl5iIAKf4+ZkTzMWsPNVMicxAs7zaDfhlBRSasWIEeEkM1ki0V
	z5/nCS1vp5e6lG4tTF5TmumrB3ZAxGgaR31R7SBbSi5pmBdlP6lzSto7YGtk2B8HFRmalT8m6DZ
	LTv6jdod4vt/Z6MsjcpSRabzDJoH/8FQ=
X-Gm-Gg: ASbGncu1ul4IzBERmk7dRZC4CS5BEBM5YbzzEu5ttICUU+s95QVkLstT7fg9XK/z6ov
	6jSGqv8BgNC22hpZpT9gGS8m7JFCjEX2F/BzrDVzA9HluL0C7vO7vcj0soBnZMX+H5FTJN4niFL
	mYxDiCFNL7pQ1aTYxfjoUbperw4ArzSCJ4mnvXtzlhrnE/PX4X+q4if3m1C6XoAEfxM5Xkt4sGo
	5s1I8Gu4c/JVwV/bJI3yqHL39oRv51b6kg12IXtdBE+f0TwTlW8ZECzF6vZ6TFBdPpjSQ8=
X-Google-Smtp-Source: AGHT+IFgAXJJOk7ORU5o6YIKB0A34EpEk1PJ4V+J9E6KEas3UShp7DR4vAS7t6oA1ZcaWPHA1qFEfxUfiKX3z6blJOE=
X-Received: by 2002:a17:902:f647:b0:295:ceaf:8d76 with SMTP id
 d9443c01a7336-2962add07f1mr53423145ad.47.1762363798567; Wed, 05 Nov 2025
 09:29:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026030143.23807-1-dongml2@chinatelecom.cn>
 <CADxym3Y4nc2Qaq00Pp7XwmCXJHn0SsEoOejK8ZxhydepcbB8kQ@mail.gmail.com>
 <CAADnVQKDza_ueBFRkZS8rmUVJriynWi_0FqsZE8=VbTzQYuM4w@mail.gmail.com>
 <3577705.QJadu78ljV@7950hx> <CAEf4Bzas7Or4yPzqdHqEcgVpTDx2j26dR5oRnSg7bepr-uDqHw@mail.gmail.com>
 <CAADnVQKV_a7NxvWwXDgRab_gakwJ=VadZ0=eC5sHwutVyM0rmg@mail.gmail.com>
In-Reply-To: <CAADnVQKV_a7NxvWwXDgRab_gakwJ=VadZ0=eC5sHwutVyM0rmg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 5 Nov 2025 09:29:46 -0800
X-Gm-Features: AWmQ_bnteJmeSonAy7_JuZJ4InwEV7gR1gsgI7sE1YVD_mQPjGGbTjZoahh0RKQ
Message-ID: <CAEf4BzZcrWCyC3DhNoefJsWNUhE46_yu0d3XyJZttQ8sRRpyag@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/7] bpf,x86: add tracing session supporting
 for x86_64
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Menglong Dong <menglong.dong@linux.dev>, Menglong Dong <menglong8.dong@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Leon Hwang <leon.hwang@linux.dev>, jiang.biao@linux.dev, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 6:43=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Nov 4, 2025 at 4:40=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Nov 3, 2025 at 3:29=E2=80=AFAM Menglong Dong <menglong.dong@lin=
ux.dev> wrote:
> > >
> > > On 2025/11/1 01:57, Alexei Starovoitov wrote:
> > > > On Thu, Oct 30, 2025 at 8:36=E2=80=AFPM Menglong Dong <menglong8.do=
ng@gmail.com> wrote:
> > > > >
> > > > > On Fri, Oct 31, 2025 at 9:42=E2=80=AFAM Alexei Starovoitov
> > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > >
> > > > > > On Sat, Oct 25, 2025 at 8:02=E2=80=AFPM Menglong Dong <menglong=
8.dong@gmail.com> wrote:
> > > > > > >
> > > > > > > Add BPF_TRACE_SESSION supporting to x86_64. invoke_bpf_sessio=
n_entry and
> > > > > > > invoke_bpf_session_exit is introduced for this purpose.
> > > > > > >
> > > > > > > In invoke_bpf_session_entry(), we will check if the return va=
lue of the
> > > > > > > fentry is 0, and set the corresponding session flag if not. A=
nd in
> > > > > > > invoke_bpf_session_exit(), we will check if the corresponding=
 flag is
> > > > > > > set. If set, the fexit will be skipped.
> > > > > > >
> > > > > > > As designed, the session flags and session cookie address is =
stored after
> > > > > > > the return value, and the stack look like this:
> > > > > > >
> > > > > > >   cookie ptr    -> 8 bytes
> > > > > > >   session flags -> 8 bytes
> > > > > > >   return value  -> 8 bytes
> > > > > > >   argN          -> 8 bytes
> > > > > > >   ...
> > > > > > >   arg1          -> 8 bytes
> > > > > > >   nr_args       -> 8 bytes
> >
> > Let's look at "cookie ptr", "session flags", and "nr_args". We can
> > combine all of them into a single 8 byte slot: assign each session
> > program index 0, 1, ..., Nsession. 1 bit for entry/exit flag, few bits
> > for session prog index, and few more bits for nr_args, and we still
> > will have tons of space for some other additions in the future. From
> > that session program index you can calculate cookieN address to return
> > to user.
> >
> > And we should look whether moving nr_args into bpf_run_ctx would
> > actually minimize amount of trampoline assembly code, as we can
> > implement a bunch of stuff in pure C. (well, BPF verifier inlining is
> > a separate thing, but it can be mostly arch-independent, right?)
>
> Instead of all that I have a different suggestion...
>
> how about we introduce this "session" attach type,
> but won't mess with trampoline and whole new session->nr_links.
> Instead the same prog can be added to 'fentry' list
> and 'fexit' list.
> We lose the ability to skip fexit, but I'm still not convinced
> it's necessary.
> The biggest benefit is that it will work for existing JITs and trampoline=
s.
> No new complex asm will be necessary.
> As far as writable session_cookie ...
> let's add another 8 byte space to bpf_tramp_run_ctx
> and only allow single 'fsession' prog for a given kernel function.
> Again to avoid changing all trampolines.
> This way the feature can be implemented purely in C and no arch
> specific changes.
> It's more limited, but doesn't sound that the use case for multiple
> fsession-s exist. All this is on/off tracing. Not something
> that will be attached 24/7.

I'd rather not have a feature at all, than have a feature that might
or might not work depending on circumstances I don't control. If
someone happens to be using fsession program on the same kernel
function I happen to be tracing (e.g., with retsnoop), random failure
to attach would be maddening to debug.

If we can't implement this properly, let's just put it on hold instead
of adding crippled implementation.

