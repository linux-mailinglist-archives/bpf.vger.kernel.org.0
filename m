Return-Path: <bpf+bounces-28548-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E25E8BB4FC
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 22:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 616B91C202C9
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 20:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47EC2C69D;
	Fri,  3 May 2024 20:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SS+wrDCX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5C2134B1;
	Fri,  3 May 2024 20:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714768768; cv=none; b=oQ1jcfyL//8oOwatv6DY58fYegc1FXplyOWz9Noi2Cnlpu5iI3AeZ8YHAyM0ESI2G4fUCWaEdsY6ZmoPec6q0/bVupvW6U2z6sD+9D0U5lKIVsjThQt5AE037A1Q5H1f38F8AhH+Hb5MWnzjobMPerC94AcIHxMDLjSxDrkS3CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714768768; c=relaxed/simple;
	bh=Rep+x/1IhbTWBkGtXMfFkyJ0D8lQ+OKZafkHQtxPmB4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLXy3WJbGeXWBi9xlmKm0rcQlIh6uq+tA2EhDTnjbYEvU+p+crNYVqtqeStcshbdHUvyhkor4642txrlqCPrx40nRJ4gZigX4z8dLpGSG/Bq9KsTERxqhtJSBFQxvysrGZMUDxmT9s5+kuYq++uFJ+0B3hhFHv9rxxq5y/FClgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SS+wrDCX; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51ae2e37a87so66967e87.2;
        Fri, 03 May 2024 13:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714768765; x=1715373565; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZqsBll30nF6InCu+LuZTkxYmMemHYMNhisoQizv1i44=;
        b=SS+wrDCXD//5KDkWwl2IHUGbJ6QuUtX0DQ8cBHr1orczGAVx7kC4bZOoQH1lYEL3uy
         mGmrY3N2+BDwijlUWCP3EY9FyLmpEvgEZtHQ3evGQz+MeLzUBgSXm013yoByJa+RDCTl
         qD0i99mECxjckP2m32IE2lIvozLpJpf8J3CH22jqXe3JvgO9BLHHR0tpt83iTzPxmC9f
         L9ehHRXOyUWClEW/d9GFh5hT2detQq/LwWYG8svEdzY0Uyz+kue4yBVTmFv5q1c6bKPi
         fQqG/7qfFe19hl0SGNqvCy6NiUlnv8A25MEJq4Bpnn+mCpzPOhRlELEAVHh+zAnsZI0l
         gaYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714768765; x=1715373565;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZqsBll30nF6InCu+LuZTkxYmMemHYMNhisoQizv1i44=;
        b=wlNGUY0uLE54+gmdOBW6qyOdkWCYn+ibVUSmYdPYVZJ5DJtEJxQ5VWnkH/gumnQCEJ
         0tqxeXr1s9mSzxTB/fq3O6Na7GXe64Sm8tc/227nclWskVCSxdpXSwyRxwS7eVyCSPxN
         EsDfvLeyuVN7AZ2CMKNRnaC1Xqb5J3R6rMJmAyl7oMe7PDik746oSgqEopjgUA20FTGQ
         +F5N0zw43TlzKab68W1lscQF6gDwaGWnZJg4jAz/HW0fO2a5/vBZADdGe1VNaNfYrQdh
         pSIMcTlLq86hDzRRr2EOpmC2wvIF3cpgHtLUb7y+ZcOwIWlMyuKULM9YD4CzDNoikOdq
         NQ6g==
X-Forwarded-Encrypted: i=1; AJvYcCU/KCHhZw/5tAlWJnWWA3p2TNTLsVds79sTrMpjA1CWp77y+S0quEBub13X8f0Y8fGa9A1uWOPb8uEv804qxAR1z9TAiS4ejQVNB1LPM2UE/6tdHnOZ6xFdwx0x/yEOMSuS7Sij2PmNDA+yXBLBANiobW+2wAV1LW5pBfDI8uceTArfn1yPznvfwZZygPBz6byucdXgevfY1/jajvQL7gLBcVh9mRQ9qNhsxXVdmKe5sdS+SZjt5gta58ym
X-Gm-Message-State: AOJu0YwTaK1xMDGuPQxYeFfii0lcnntzVt79QSu22j8Ta3IZIy3izSKS
	W1kqi3wMZQS8aiV2C5552HoKJGNDm1OsUC3KeIyFdvG0d0Z9Aemy
X-Google-Smtp-Source: AGHT+IEO04P5Df9q/LsX2fv5yYDz2bukf7fwPopZc+/ml9FBu8Ry9bPZOljmvYWZfe7I6pDfREzbzQ==
X-Received: by 2002:a19:644b:0:b0:51c:cd8d:2865 with SMTP id b11-20020a19644b000000b0051ccd8d2865mr2454181lfj.44.1714768764410;
        Fri, 03 May 2024 13:39:24 -0700 (PDT)
Received: from krava ([83.240.62.36])
        by smtp.gmail.com with ESMTPSA id bk15-20020a170906b0cf00b00a52244ab819sm2141858ejb.170.2024.05.03.13.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 13:39:23 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 3 May 2024 22:39:21 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	linux-man@vger.kernel.org, x86@kernel.org, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCHv4 bpf-next 0/7] uprobe: uretprobe speed up
Message-ID: <ZjVLedyQFBoHh-T_@krava>
References: <20240502122313.1579719-1-jolsa@kernel.org>
 <CAEf4BzYxsRMx9M_AiLavTHFpndSmZqOM8QcYhDTbBviSpv1r+A@mail.gmail.com>
 <ZjPx0fncg-8brFBk@krava>
 <CAEf4Bzb-dM+464JvW96KuxwOTfRQA1pxZRWM+pA7AfSWtWwqZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzb-dM+464JvW96KuxwOTfRQA1pxZRWM+pA7AfSWtWwqZw@mail.gmail.com>

On Fri, May 03, 2024 at 11:03:24AM -0700, Andrii Nakryiko wrote:
> On Thu, May 2, 2024 at 1:04 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Thu, May 02, 2024 at 09:43:02AM -0700, Andrii Nakryiko wrote:
> > > On Thu, May 2, 2024 at 5:23 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > > >
> > > > hi,
> > > > as part of the effort on speeding up the uprobes [0] coming with
> > > > return uprobe optimization by using syscall instead of the trap
> > > > on the uretprobe trampoline.
> > > >
> > > > The speed up depends on instruction type that uprobe is installed
> > > > and depends on specific HW type, please check patch 1 for details.
> > > >
> > > > Patches 1-6 are based on bpf-next/master, but path 1 and 2 are
> > > > apply-able on linux-trace.git tree probes/for-next branch.
> > > > Patch 7 is based on man-pages master.
> > > >
> > > > v4 changes:
> > > >   - added acks [Oleg,Andrii,Masami]
> > > >   - reworded the man page and adding more info to NOTE section [Masami]
> > > >   - rewrote bpf tests not to use trace_pipe [Andrii]
> > > >   - cc-ed linux-man list
> > > >
> > > > Also available at:
> > > >   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
> > > >   uretprobe_syscall
> > > >
> > >
> > > It looks great to me, thanks! Unfortunately BPF CI build is broken,
> > > probably due to some of the Makefile additions, please investigate and
> > > fix (or we'll need to fix something on BPF CI side), but it looks like
> > > you'll need another revision, unfortunately.
> > >
> > > pw-bot: cr
> > >
> > >   [0] https://github.com/kernel-patches/bpf/actions/runs/8923849088/job/24509002194
> >
> > yes, I think it's missing the 32-bit libc for uprobe_compat binary,
> > probably it needs to be added to github.com:libbpf/ci.git setup-build-env/action.yml ?
> > hm but I'm not sure how to test it, need to check
> 
> You can create a custom PR directly against Github repo
> (kernel-patches/bpf) and BPF CI will run all the tests on your custom
> code. This way you can iterate without spamming the mailing list.

I'm running CI tests like that, but I think I need to change the action
which is in other repo (github.com:libbpf/ci.git)

> 
> But I'm just wondering if it's worth complicating setup just for
> testing this x32 compat mode. So maybe just dropping one of those
> patches would be better?

well, we had compat process crashing on uretprobe because of this change,
so I rather keep the test.. or it can go in later on when the CI stuff is
figured out.. I got busy with the shadow stack issue today, will check on
the CI PR next week

jirka

