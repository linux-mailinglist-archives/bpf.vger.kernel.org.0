Return-Path: <bpf+bounces-76995-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E635CCC686
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 16:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C6E430A1FEA
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 15:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755672D8768;
	Thu, 18 Dec 2025 15:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OT7P/G9X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f67.google.com (mail-oa1-f67.google.com [209.85.160.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5860A2C2368
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 15:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766070340; cv=none; b=puySIHn1wKFjtnKhL0pjOnXe2MPfi4pmdOZIz4zCn74dvT75OHzgIOCFjVKZ1z2finI1bFxbMM6dEEcoH4fT9WqEwnX6oJmVLn/NHcuDS0qWKYrDp6HtwKZWdQ8DQvJ0tXlA0W07uLixFR/InTlcMF8ZNcTiJcjIyDUXWJ8hajw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766070340; c=relaxed/simple;
	bh=2fXW/yTQnSzTFycxk33wkAysOyNdy+IqqPw6vt65LzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qWznoNLx7pyysfaRN/HkecHsBccD2nICbim9X9ul6PvviWZdo/TEoJSxJOs9As0fI7F9GlBw19ogcmiFzB66shhQKSw3znekBc/toX6KteHDadqYzHQ8hhp6Zv+otNpb4i/CcAIQcTkOerQEIZc9bxO0jkLDrHgovDtvz1RFI/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OT7P/G9X; arc=none smtp.client-ip=209.85.160.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f67.google.com with SMTP id 586e51a60fabf-3f5c9275b31so453335fac.0
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 07:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766070338; x=1766675138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7x1LVvCf3VLvAjtIqXQBbk4xwbIbAqccEsSWEs0YiDA=;
        b=OT7P/G9X9OJSjqla3Y/0bv4C+Q3L5xtHMNGGeeBswTGDmQk/JL17a9QWOoyf6sL8Qc
         OlVjpXiiQv8+7kd6fRbdhtnhEJ8y88RRfRXDgAWQBQzBXFo1jnCbKZCtNArtiOtCCksl
         RmJHDAYZD7Bt+9gNTYpW43gger22LrCoPS0rNbeAfDVJBdKo7Kxgc8U+QY731m1o2jtf
         nYa04cw3+nLxh5w968OoOonAvJexhkgjmWgY/2hSc/WKjcgqHaWECvETqo2AFOlOhRme
         qXfR9UuYZTItdtZUBS125fOpsBR2gZ0yjfqb5WTWqWxICYVPH0NhdsEKHsw9SuWMgraY
         MKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766070338; x=1766675138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7x1LVvCf3VLvAjtIqXQBbk4xwbIbAqccEsSWEs0YiDA=;
        b=PspfAcUVAQlGuiAQh06lIQCJGRjMDqilqX1untfEUB4E5lu10C1kc1CUtUMYBk997b
         EjKw3s57vvbGSqRyrz/alaL9A+fjhnTejoBYR++4BjVbgNGKdG0svuWdjeu5+lewLryD
         HcZRf0fiMmXoztTqMUmepFCqD/mB47YpudEox8JNUjzFMrvuFkCBD9Z202/e+ywmeHTK
         9SVCnO2+J+KUHy1zb4fMzFF7gUpWTOdIozlBW5+oPSafy/reCbSRYtKaf17O4FfGb1mZ
         BuXNFbn3knwCQdBtd0tqU4X9KcPIpRYYeK9Vf4C/VXy7zWJ8NlIcJEZlhCNNWA42H2xY
         Npog==
X-Forwarded-Encrypted: i=1; AJvYcCWwLfsacqWCwoweXZJkrcSjixVZf4n1nW+4u7L/A8EuO7UaF6vNV1Gtl+apxW8f3UYTYJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZpd1BQpoGl1bLw/bA9ncC6OcuRnhmi17B0mqGhs+7G6LS9kQn
	6BiX9EdozdEI9jh+NUeLl4GWzOxJ4HVOHXeO9gRm3uikDrnAHZhSdnKS8dBn1+nxSt05mjgm77H
	/ZfgFhk8piaNit0A+iPBGOIw3XMw/lEA=
X-Gm-Gg: AY/fxX6Reb/EF7G8CHrVpypaO3ZwDzQVO7KukhWOgtwpMfPlfcZFq4fYaZv3zouOHpK
	mIHG1zUqBQUavEyPvkgqWRhfd3teRmVppiwlE45v+7N8NIpyZ0FWTW3uAR9enJt21imHtg9CgbO
	VdmTKVKGG4+bGyB9hEVxjA7IcRJNIuiFsV47/bftE390K60geB73loWxjNGNwRfEzui1lLlElXX
	xsUa0caQPHERaTgLYkV+oevjLcGisxRbDlwTMsOWJQiJr5MOmQuFhgBaRJSLxz1igEKdaQ=
X-Google-Smtp-Source: AGHT+IF/fTgkutYeIcFjjXnYQpZJcb84xx01Knr1X9n+e2+wE5pUKMKQXwP4SNGCv9mNmL7FhzoGgDf01xZJLuAW9uk=
X-Received: by 2002:a05:6808:1919:b0:450:4628:e3ce with SMTP id
 5614622812f47-455ac843d39mr8893507b6e.15.1766070334496; Thu, 18 Dec 2025
 07:05:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118123639.688444-1-dongml2@chinatelecom.cn>
 <20251118123639.688444-4-dongml2@chinatelecom.cn> <874ipnkfvt.fsf@igel.home>
In-Reply-To: <874ipnkfvt.fsf@igel.home>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Thu, 18 Dec 2025 23:05:23 +0800
X-Gm-Features: AQt7F2rBCJ5wWtnPg0y__c3D4AxuhAyRjyuKDUvUD5czSDgloXW-454tfs3x8_U
Message-ID: <CADxym3byFuS7c9C17pUc7EE+ipAoQMdJgsBM0wr5+VV5esNw-Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/6] bpf: fix the usage of BPF_TRAMP_F_SKIP_FRAME
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: ast@kernel.org, rostedt@goodmis.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	mhiramat@kernel.org, mark.rutland@arm.com, mathieu.desnoyers@efficios.com, 
	jiang.biao@linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 10:45=E2=80=AFPM Andreas Schwab <schwab@linux-m68k.=
org> wrote:
>
> On Nov 18 2025, Menglong Dong wrote:
>
> > Some places calculate the origin_call by checking if
> > BPF_TRAMP_F_SKIP_FRAME is set. However, it should use
> > BPF_TRAMP_F_ORIG_STACK for this propose. Just fix them.
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > Acked-by: Alexei Starovoitov <ast@kernel.org>
>
> This breaks RISC-V:

It's weird, as the 2 flags should be set together all the time
in RISC-V. Sorry that I'm already in bed, I'll check it tomorrow
morning.

Thanks!
Menglong Dong

>
> [    8.584381][    T1] systemd[1]: bpf-restrict-fs: LSM BPF program attac=
hed
> [    8.588359][    T1] Insufficient stack space to handle exception!
> [    8.588823][    T1] Task stack:     [0xff20000000010000..0xff200000000=
14000]
> [    8.589219][    T1] Overflow stack: [0xff600000ffdad070..0xff600000ffd=
ae070]
> [    8.590133][    T1] CPU: 1 UID: 0 PID: 1 Comm: systemd Not tainted 6.1=
8.0-rc5+ #15 PREEMPT(voluntary)  c900881ed1c1988ec5cf3e914d0edeb1b4d83ca3
> [    8.590898][    T1] Hardware name: riscv-virtio qemu/qemu, BIOS 2025.1=
0 10/01/2025
> [    8.591494][    T1] epc : copy_from_kernel_nofault+0xa/0x198
> [    8.592292][    T1]  ra : bpf_probe_read_kernel+0x20/0x60
> [    8.592658][    T1] epc : ffffffff802b732a ra : ffffffff801e6070 sp : =
ff2000000000ffe0
> [    8.593121][    T1]  gp : ffffffff82262ed0 tp : 0000000000000000 t0 : =
ffffffff80022320
> [    8.593566][    T1]  t1 : ffffffff801e6056 t2 : 0000000000000000 s0 : =
ff20000000010040
> [    8.593997][    T1]  s1 : 0000000000000008 a0 : ff20000000010050 a1 : =
ff60000083b3d320
> [    8.594446][    T1]  a2 : 0000000000000008 a3 : 0000000000000097 a4 : =
0000000000000000
> [    8.594940][    T1]  a5 : 0000000000000000 a6 : 0000000000000021 a7 : =
0000000000000003
> [    8.595396][    T1]  s2 : ff20000000010050 s3 : ff6000008459fc18 s4 : =
ff60000083b3d340
> [    8.595831][    T1]  s5 : ff20000000010060 s6 : 0000000000000000 s7 : =
ff20000000013aa8
> [    8.596215][    T1]  s8 : 0000000000000000 s9 : 0000000000008000 s10: =
000000000058dcb0
> [    8.596641][    T1]  s11: 000000000058dca7 t3 : 000000006925116d t4 : =
ff6000008090f026
> [    8.597065][    T1]  t5 : 00007fff9b0cbaa8 t6 : 0000000000000016
> [    8.597363][    T1] status: 0000000200000120 badaddr: 0000000000000000=
 cause: 8000000000000005
> [    8.598033][    T1] Kernel panic - not syncing: Kernel stack overflow
> [    8.598597][    T1] CPU: 1 UID: 0 PID: 1 Comm: systemd Not tainted 6.1=
8.0-rc5+ #15 PREEMPT(voluntary)  c900881ed1c1988ec5cf3e914d0edeb1b4d83ca3
> [    8.599244][    T1] Hardware name: riscv-virtio qemu/qemu, BIOS 2025.1=
0 10/01/2025
> [    8.599659][    T1] Call Trace:
> [    8.600117][    T1] [<ffffffff8001a1f8>] dump_backtrace+0x28/0x38
> [    8.600517][    T1] [<ffffffff80002502>] show_stack+0x3a/0x50
> [    8.600844][    T1] [<ffffffff800122be>] dump_stack_lvl+0x56/0x80
> [    8.601176][    T1] [<ffffffff80012300>] dump_stack+0x18/0x22
> [    8.601518][    T1] [<ffffffff80002abe>] vpanic+0xf6/0x328
> [    8.601819][    T1] [<ffffffff80002d2e>] panic+0x3e/0x40
> [    8.602088][    T1] [<ffffffff80019ef0>] handle_bad_stack+0x98/0xa0
> [    8.602395][    T1] [<ffffffff801e6070>] bpf_probe_read_kernel+0x20/0x=
60
>
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint =3D 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC=
1
> "And now for something completely different."

