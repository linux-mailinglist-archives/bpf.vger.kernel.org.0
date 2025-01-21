Return-Path: <bpf+bounces-49392-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A812A18050
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 15:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1389B1884E09
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 14:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5270B1F3D5E;
	Tue, 21 Jan 2025 14:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y827Eh4J"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6117049641;
	Tue, 21 Jan 2025 14:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737470869; cv=none; b=UjV0ohieQULgz/B0sjZ9YJLBe2LlT9iy8dX1RuBf1b+UNNHMhbqouIi34cnQivHiOcdjZ+bj4sXGvesCQaiIZFAFgjruy0oDjJaBx92ygpwY8vIpN+c9y90gr7zMhmF6DZaIZGm5l4IRQ9e6eHdh95VZRHw2ofvYRLuJAytXPyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737470869; c=relaxed/simple;
	bh=Cktml07LPmg2xZ25NCIPiVqzfxD6P8TDXY7hcsNSf6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DULSEvgNVIWI4v52NsjFp3LQf9BAIbrkKd7sWvShZshs/qWnNVONOuGiPzJXwvlh59ddXZZuAu/t9axPkbxyM6gMi0wS/jJKNgh9f6yBvTXP9CGZUHb5fnnXh5ly7qLqXaU8oinG75nnS9tJO6TE7zlRrC5OCfxICUxlj28ndZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y827Eh4J; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-71e181fb288so2893707a34.2;
        Tue, 21 Jan 2025 06:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737470867; x=1738075667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4rAyOm3vvC9cyzYtwh1nipyUHmipDItlmipd/RY8fXQ=;
        b=Y827Eh4JiB7zZuR6zWZl4bEpau+kai9XLkFup/ISfD5h/uoQiTmTnRjhSMfe8CvY96
         JLqc9STOXnLjga6LjLxEsl5Mv0Go/Ue37xejEMfksWFRneFYi7ue0WtqwuAC6ciYBv9B
         8F9bndcrHQ4/EvTsIVpIop4jln0Vy6/1ixVvyhnrg3qtelMsLHGNEegdvqjsXrkifSCe
         6eTMt/MRtgRU5hB2WAHiUr/rf32g/SjdjZy0tzY42N6rtUZ1D1W8Gt3szKm0qfdN97Q1
         ZXk/klG5yLM682rlgxbMMuFdP+kLlpPsrn6WeBRBXNtaGMSpATg62AO0n/iTOWN8uOLq
         bvsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737470867; x=1738075667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4rAyOm3vvC9cyzYtwh1nipyUHmipDItlmipd/RY8fXQ=;
        b=OkhymSszyg1NsfKUu5wsmZ5GzRwIqIhJsaeNhajdOX4m4yD+X38evjLDtAVF2iPEsb
         YSy9BKTC2nx/ebo0IG221lhsoZGFi1PPbWc6W6EebDeG5DcF3aipYZ3gCquF5mpTbOOa
         25ZvFJQjN4zdjfWdsKBFmT1JyY997+4vBEEa7tgulprR0yYRsF1PEoeE0J0YTniLInux
         G48NvP9EftG7EUzZAM2fzw9Z1rM1j5XFGELmU7/NtBtKq1LB/liTCOBOKo06gdO0HysJ
         bDWUZygbT0y1aIbVEExRifAMgzukkT2qCRQf9mlnVqYxhXPixXU+13PTlfS41wtyMZaL
         ubMw==
X-Forwarded-Encrypted: i=1; AJvYcCUep4V1ODFe4hZdTxQqU2YhYu0qqVwyXMFiej9/d+2zmEyCeUNgVhKTzGXSpSxSvqdTHJbWb/FL@vger.kernel.org, AJvYcCWlZfyneTixHPijkG9+uXR1fnE1BiMQedtuzfcxrdWdaoHOwEDHyVxBSbDGz0mGp5ohiOE1lNTXoFoeimInp6IfkzdF@vger.kernel.org, AJvYcCWpr3Yc+Y+5YdfO26W74ZnVB3vZdcjFFy6JNTx6UZs7+X8hufNgVNQvgz541OR2PU2Baik6HRCbPOoS@vger.kernel.org, AJvYcCX9qWUC1F2g3rYpR3hHzY3OHKAppYhF5sZqnZvte0LNbGsEdxQ1shZlGINW+J5x7fXucqWUhtzRxqZDOBKM@vger.kernel.org, AJvYcCXVvCIxWXxnQQRRW7iQaW/hQ0YzVVn859LkF8MsCmgxGxwzv0iUsaAT3eBJijdtjCjMPDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzygC086BtCZ/8YHBNDjOwM8tOG6ws02CDLlYEiypTlJ/PeoNln
	tRu5cV5A2DN82YMlniEm2kfMa5Emk7D4lIApKQTCBOermrvZVO2kRyhdc5ksvLPh5cL9gK00C/P
	hQ4IC0AzEU1IXVk/NjWyebwTFtvY=
X-Gm-Gg: ASbGnctixg367ty6j3cgNOTy+0uFp0GvbPAsN+Jdw581yBe0h7xBovcvLf6V2yPu9pC
	MHKHmc4RbgyoqKm026D+9H4N9748TwcWszztJvXesoDOJyo7BO8g=
X-Google-Smtp-Source: AGHT+IHg70+kf9daAdil3t4gCIdHjAkzcSAk4ar4AK/QnIG6lVbxav1MbIKq4eCM3GctTzC1y/vvNy0sX+8+TR1jSO8=
X-Received: by 2002:a05:6830:628b:b0:71d:f239:c091 with SMTP id
 46e09a7af769-7249da56cedmr10066983a34.6.1737470867304; Tue, 21 Jan 2025
 06:47:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117005539.325887-1-eyal.birger@gmail.com>
 <202501181212.4C515DA02@keescook> <CAHsH6GuifA9nUzNR-eW5ZaXyhzebJOCjBSpfZCksoiyCuG=yYw@mail.gmail.com>
 <8B2624AC-E739-4BBE-8725-010C2344F61C@kernel.org> <CAHsH6GtpXMswVKytv7_JMGca=3wxKRUK4rZmBBxJPRh1WYdObg@mail.gmail.com>
 <Z4-xeFH0Mgo3llga@krava>
In-Reply-To: <Z4-xeFH0Mgo3llga@krava>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Tue, 21 Jan 2025 06:47:35 -0800
X-Gm-Features: AbW1kva2mCUZaFs5Ipo6EUmEB_SwjaLJCjqhvhI-g9qn-B9oSM16KZSJKWgpihY
Message-ID: <CAHsH6GsXacPXiEz7amTcgBfWdiOJx2G3cAMdSdnkqOnJ+opqQg@mail.gmail.com>
Subject: Re: [PATCH] seccomp: passthrough uretprobe systemcall without filtering
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Kees Cook <kees@kernel.org>, luto@amacapital.net, wad@chromium.org, oleg@redhat.com, 
	ldv@strace.io, mhiramat@kernel.org, andrii@kernel.org, 
	alexei.starovoitov@gmail.com, cyphar@cyphar.com, songliubraving@fb.com, 
	yhs@fb.com, john.fastabend@gmail.com, peterz@infradead.org, 
	tglx@linutronix.de, bp@alien8.de, daniel@iogearbox.net, ast@kernel.org, 
	andrii.nakryiko@gmail.com, rostedt@goodmis.org, rafi@rbk.io, 
	shmulik.ladkani@gmail.com, bpf@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 21, 2025 at 6:38=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Sat, Jan 18, 2025 at 07:39:25PM -0800, Eyal Birger wrote:
>
> SNIP
>
> > I think I wasn't accurate in my wording.
> > The uretprobe syscall is added to the tracee by the kernel.
> > The tracer itself is merely requesting to attach a uretprobe bpf
> > function. In previous versions, this was implemented by the kernel
> > installing an int3 instruction, and in the new implementation the kerne=
l
> > is installing a uretprobe syscall.
> > The "user" in this case - the tracer program - didn't deliberately inst=
all
> > the syscall, but anyway this is semantics.
> >
> > I think I understand your point that it is regarded as "policy", only t=
hat
> > it creates a problem in actual deployments, where in order to be able t=
o
> > run the tracer software which has been working on newer kernels a new d=
ocker
> > has to be deployed.
> >
> > I'm trying to find a pragmatic solution to this problem, and I understa=
nd
> > the motivation to avoid policy in seccomp.
> >
> > Alternatively, maybe this syscall implementation should be reverted?
>
> you mentioned in the previous reply:
>
> > > As far as I can tell libseccomp needs to provide support for this new
> > >  syscall and a new docker version would need to be deployed, so It's =
not
> > > just a configuration change. Also the default policy which comes pack=
ed in
> > > docker would probably need to be changed to avoid having to explicitl=
y
> > > provide a seccomp configuration for each deployment.
>
> please disregard if this is too stupid.. but could another way out be jus=
t
> to disable it (easy to do) and meanwhile teach libseccomp to allow uretpr=
obe
> (or whatever mechanism needs to be added to libseccomp) plus the needed
> docker change ... to minimize the impact ?

Right. the patch I was thinking to suggest wouldn't revert the entire
thing, but instead disable its use for now and allow a careful
reconsideration of the available options.

If that makes sense, I'll post it.

>
> or there's just too many other seccomp user space libraries

I think in theory, the example of a simple binary using "restrict" mode
makes it problematic to assume that this can be fixed solely from userspace
i.e. for such binary, uretprobes would still work in one kernel version and
break on another. It's hard to tell how common this is.

>
> I'm still trying to come up with some other solution but wanted
> to exhaust all the options I could think of
>
> thanks,
> jirka

