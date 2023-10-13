Return-Path: <bpf+bounces-12165-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 266917C8DE0
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 21:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 566221C21054
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 19:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D564A241F7;
	Fri, 13 Oct 2023 19:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a00n4HqR"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD72220B02;
	Fri, 13 Oct 2023 19:43:32 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437CCC2;
	Fri, 13 Oct 2023 12:43:31 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-53da80ada57so4450766a12.0;
        Fri, 13 Oct 2023 12:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697226210; x=1697831010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DroGrAmJQ8vU3d/rY63nLrdVnujPufnmBeDfKsy9CWc=;
        b=a00n4HqRX2/w2JRKH3lqP1qxnoppD724voq0r1ICmwxg0makQjBkzJK899/BMSGO+p
         xcDh5W0J/uygTs2grLnV8oTKwaty/CwyodLh26qzRhwmOR/6ahkmhgkyp6hZWisqfkri
         8xmEy+wc3HIm+L1DsK1CSLhsFF0fkY7cUSWyyRv8ecTeh8HYAcnZauiAH+KAuFZ3v5Hj
         KhT2wbZbAmMH10XH0gasepwg3x2G+RDOT1VO8Rz7pSE+/4V2jnbjgqlKcEv0UugwX5EO
         TJvLdtoa1pYLmYR12Qf5h/IxEbwAFst3I7fGbNfXsGf+yuprMU+B1QtfK3+wjzBloYlk
         mcbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697226210; x=1697831010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DroGrAmJQ8vU3d/rY63nLrdVnujPufnmBeDfKsy9CWc=;
        b=Q3p6OU02+QuO3cZ1Cwm0g9k03WqYJw7Myy7Pco+if2VTr+DmG0dFwtF0Dpg/sZYE4r
         X6kuHYaRoVZ6HuXzUuahqACDtlCcLlNrJfdSU6etzicI+AOR4GivRJ4iW+ZA6cN7cUwH
         A02p8pJ7kAWpUojWxmPOV5G9U1E2E0CCHaL96IEeBJWifTe67aBzRjryHZej2WEWqHc0
         ZTlL1L8fYF32IWOB0b8aE1jD2zPoLVtJ57YbrSmO4xaJAYxkTz5k2ALz9K3lcp/+fBzM
         muTJUX6xFMl63h0EoDsKWw3vdW5woBAB2ZeSlVXF9SR25Lv+As+HnkekQ6xujAA2LcS6
         jcSw==
X-Gm-Message-State: AOJu0YzFz0wEAL2tXcjek9yObq20KgzUqwbmKLEcT6s5AVZWSnamXDee
	cC8X4XXu2N0YFJLwfgtWavDNbNP0nTtdwX3elWw=
X-Google-Smtp-Source: AGHT+IFogbZDPF7HWauEzO6Zr62gSb2TMN+wPaGYfxIzp5t4tYzEsYriac3NcRedLzm9LeWT6n9FSrWiVyXTbepSiaQ=
X-Received: by 2002:aa7:cf87:0:b0:525:570c:566b with SMTP id
 z7-20020aa7cf87000000b00525570c566bmr22852967edx.22.1697226209658; Fri, 13
 Oct 2023 12:43:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231005123413.GA488417@alecto.usersys.redhat.com>
 <20231012114550.152846-1-asavkov@redhat.com> <20231012094444.0967fa79@gandalf.local.home>
 <CAEf4BzZKWkJjOjw8x_eL_hsU-QzFuSzd5bkBH2EHtirN2hnEgA@mail.gmail.com>
 <ZSjdPqQiPdqa-UTs@wtfbox.lan> <20231013100023.5b0943ec@rorschach.local.home>
In-Reply-To: <20231013100023.5b0943ec@rorschach.local.home>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 13 Oct 2023 12:43:18 -0700
Message-ID: <CAEf4Bza0ma+oRHYkHfQwmLPzJobRpq6-u2gog_uMNAHs0-KYiQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next] bpf: change syscall_nr type to int in struct syscall_tp_t
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Artem Savkov <asavkov@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	linux-rt-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 13, 2023 at 7:00=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Fri, 13 Oct 2023 08:01:34 +0200
> Artem Savkov <asavkov@redhat.com> wrote:
>
> > > But looking at [0] and briefly reading some of the discussions you,
> > > Steven, had. I'm just wondering if it would be best to avoid
> > > increasing struct trace_entry altogether? It seems like preempt_count
> > > is actually a 4-bit field in trace context, so it doesn't seem like w=
e
> > > really need to allocate an entire byte for both preempt_count and
> > > preempt_lazy_count. Why can't we just combine them and not waste 8
> > > extra bytes for each trace event in a ring buffer?
> > >
> > >   [0] https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-dev=
el.git/commit/?id=3Db1773eac3f29cbdcdfd16e0339f1a164066e9f71
> >
> > I agree that avoiding increase in struct trace_entry size would be very
> > desirable, but I have no knowledge whether rt developers had reasons to
> > do it like this.
> >
> > Nevertheless I think the issue with verifier running against a wrong
> > struct still needs to be addressed.
>
> Correct. My Ack is based on the current way things are done upstream.
> It was just that linux-rt showed the issue, where the code was not as
> robust as it should have been. To me this was a correctness issue, not
> an issue that had to do with how things are done in linux-rt.

I think we should at least add some BUILD_BUG_ON() that validates
offsets in syscall_tp_t matches the ones in syscall_trace_enter and
syscall_trace_exit, to fail more loudly if there is any mismatch in
the future. WDYT?

>
> As for the changes in linux-rt, they are not upstream yet. I'll have my
> comments on that code when that happens.

Ah, ok, cool. I'd appreciate you cc'ing bpf@vger.kernel.org in that
discussion, thank you!

>
> -- Steve

