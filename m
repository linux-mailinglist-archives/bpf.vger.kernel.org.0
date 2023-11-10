Return-Path: <bpf+bounces-14729-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED14D7E7931
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 07:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6E951C20DF0
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 06:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C3363A3;
	Fri, 10 Nov 2023 06:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ch7QOf0f"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041F26118
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 06:22:11 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C0E6E99
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 22:22:10 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40859dee28cso12381965e9.0
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 22:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699597329; x=1700202129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w0V5sue/Dp5gh8SazXmO3goUQuzygoMuLavvwR3dJRQ=;
        b=ch7QOf0fjaOFwN2cGYlYP58XtS3XLrz5UKLVoi3WCWOAHWyPf/Kwt21nr4bRS82SI3
         382svMzjEf2cuZ5KRodr26D8vWyZPexMkP9uXz3pSWsJCO/g0QAKxjHvCjHzrwJ4ttMY
         BQCO4wnMqZVa8dDVSe1AKO8RsoYd49mDQV4Zt5fMhAU58zgCbyFTdhf2ekkIdnIYsGH/
         HoCkAvROpb7AaPCks5U6Fo/ThU1BG4X6zYBMiiGWCYSSzaI3DDvM4IVTGuAeObrYxwoz
         FNCG27t0a0VbSdLMJYVMGNUHmnxob1jB3/YaA5Vq4KKiV3sVGPubfcSX8Ob+/O0vorxk
         kcZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699597329; x=1700202129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w0V5sue/Dp5gh8SazXmO3goUQuzygoMuLavvwR3dJRQ=;
        b=VeNi0tLZ27IjsFAQzZt4Dt4/8LTeyK3IwVH/4NBLj2OqT9HAeHb7JTQHSJ1qMW7+iZ
         Qi9Vc4hnckvyhy4QS8iRd7BD74fmm4Jlvn4Nzts05UWY0SEwrpU1rO2UzUCUO7YUwb+U
         5amrjyWHI6V8uEJp7JQRn7Fz11ew6d/lYqBR3M9fnQ71l8x8caOZRug3I1r5geLxk1pG
         RjCk5+TUeDY0fRVXhVdyZU4SwOSADcC5ugzKqbgeX9eso1LTPBs5gMDCdXYvBpYuLewP
         zVb0gApZgTHwGBpADcGbIfowLsiXwWGQsP8ftzm7l1Z8xcDzrYfZLr2sTdzckBjrukVF
         kGaA==
X-Gm-Message-State: AOJu0Yywjk3TT5YIrmDXs0HPoO5cJlMM5DUTCe9vI77dgoTDIWPZ7yXd
	CXIkHC5l9Mdl8zNGLTpWzpiTgpLxFBDH/W99bobGa89yEl4=
X-Google-Smtp-Source: AGHT+IHBTaI0knehw5JCkGqE0QrfVV8F/5OvjfT9aK0AMd9kAkEum/41DRbprE8Xe7lfRPq9NACGSnLGN5t5E5UekQU=
X-Received: by 2002:a50:a410:0:b0:540:118:e8f with SMTP id u16-20020a50a410000000b0054001180e8fmr6321749edb.24.1699592801900;
 Thu, 09 Nov 2023 21:06:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231110002638.4168352-1-andrii@kernel.org> <20231110002638.4168352-4-andrii@kernel.org>
 <CAADnVQ+KtueBdD=8DazMhM3Xz0+YpLVW1-5-N4ZFiBOzji4vbg@mail.gmail.com>
 <CAEf4Bza1nxvLcBORkV+bKbKCz=f1jhRYM=PPaJxXDfQ7rmfJvA@mail.gmail.com>
 <CAEf4BzZFc6t5KCdCH4zYA1jp9UgRWHsEKgfMjVcc72qgH-FHXQ@mail.gmail.com>
 <CAADnVQ+GzfdYSYAK5MYJ4cbOXsFPKG_Ly5CO5raCP7sopj9AXA@mail.gmail.com> <CAEf4BzZT_Sgpgtm2yrUCUoCLAdJey_rofJi7jOq0603N2ELRcg@mail.gmail.com>
In-Reply-To: <CAEf4BzZT_Sgpgtm2yrUCUoCLAdJey_rofJi7jOq0603N2ELRcg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 9 Nov 2023 21:06:30 -0800
Message-ID: <CAEf4BzbBUkgWGNw3JpozOx_q1XJD4fph1Ubd=H8NSVdGX7ZfQA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf 3/3] selftests/bpf: add edge case backtracking
 logic test
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 8:48=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Nov 9, 2023 at 8:14=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Nov 9, 2023 at 8:05=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > >
> > > > When I was analysing and crafting the test I for some reason assume=
d I
> > > > need to have a jump inside the state that won't trigger state
> > > > checkpoint. But I think that's not necessary, just doing conditiona=
l
> > > > jump and jumping back an instruction or two should do. With that ye=
s,
> > > > TEST_STATE_FREQ should be a better way to do this.
> > >
> > > Ah, ok, TEST_STATE_FREQ won't work. It triggers state checkpointing
> > > both at conditional jump instruction and on its target, because targe=
t
> > > is prune point.
> > >
> > > So I think this test has to be the way it is.
> >
> > I see.
> > I was about to apply it, but then noticed:
> > numamove_bpf-numamove_bpf.o |migrate_misplaced_page |success ->
> > failure (!!)|-100.00 %
> >
> > veristat is not known for sporadic failures.
> > Is this a real issue?
>
> No idea what this is, I don't have it in my local object files, will
> need to regenerate them and check.

libbpf: prog 'migrate_misplaced_page_exit': failed to find kernel BTF
type ID of 'migrate_misplaced_page': -3

It fails also on bpf-next/master.

I think CI compares with the last state before net/net-next merge, and
now this tool (it's from libbpf-tools) fails to find
migrate_misplaced_page kernel function, apparently.

So veristat itself doesn't have sporadic failures, but our CI setup is
not 100% reliable, it seems.

