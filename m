Return-Path: <bpf+bounces-62709-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F100AFD909
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 22:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43A577A369A
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 20:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698BC24290E;
	Tue,  8 Jul 2025 20:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="air0X4GR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF422066F7
	for <bpf@vger.kernel.org>; Tue,  8 Jul 2025 20:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752008365; cv=none; b=bln6G41yqa68fg+mLTRbyF/xv2OskB8osZwcde4HdOC3DQY8sKFyz95OVKGumsTnxDYd7RCTsf+YnXlghaDWZQPMDnlpPNoOwSKFSop6zgRa4yoCLQ7h6RSNfFOC190BY5YDAd+5/CqlpVOigX3Jwq3IyEVmbg9qU+QCxvm+tQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752008365; c=relaxed/simple;
	bh=SdEPMhRnecnEQaVzU/uf5Syi6Q3g0uIhBo6Kg/CnDac=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EhKsKjopllNJhjNMAnLHkbN50TxosgDNAh1eCoPRL5MPfHzvFMD+M21khuAoigK/EbDPr1R4WS3908rMRY/WevAHO1WHSO+XmLDqoQVsp6Khc+8FToeBs02QTbF6BDYifSFs8EYJ+Y8rkEHVb9DQZSQzxMyRhUcJ6iTKB/1m89o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=air0X4GR; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7490702fc7cso2980418b3a.1
        for <bpf@vger.kernel.org>; Tue, 08 Jul 2025 13:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752008363; x=1752613163; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S8aWCe2/2qRtFsrcvoAmQ+b5ERzasZ6OM6J9SbhDrJE=;
        b=air0X4GRR5GI6xP/x4FnVoNS8VJO/YfyBwrwlVbbaPRjDSACMy4fNkSZzg65h6o8fR
         a0zs/tWE3m7QSyICbIY3fbO4vm9D5Zq9u5XUiUcBi/Zr0MwuqMPC6ZQRrZV4Ozx41s14
         Dld6GeaRXNWBLCFR0pO+KXuWeNTHZjHhC8jA2CqII0gWk3CFiq+JHtdwq4/YSkJ1iuvj
         2BqdDwbFC0SfjbsTnMGAc5ejUQHx0SPNKCTZYPWdxEZKJfQSS86/EgP/Y4FTRgzArFw6
         JUg8nGULDOXL6Fha0xdlxDiSnj9/XgYNzzeEROgg3+EWzTxjH8YMNRWQ4wwPseea0ZAf
         +XNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752008363; x=1752613163;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S8aWCe2/2qRtFsrcvoAmQ+b5ERzasZ6OM6J9SbhDrJE=;
        b=VgT9zvuyVrWlfI19LjZSlDXD2Eik+MEJx4T4HnBVEnYQ9V/Eqg/rKTrvsshBumKUhU
         IHWHof8KWfivKy2GNbL/aFwAdWU0mv/5lq2ySXGeYi0SRTd3jsBLEDy25NaLU4J2ZHbd
         kzmUKNFFHj9X4qngYjguKwLf8Kz/mky4A0a9Z1pm+vNUfyaK/dLsptLgjbgOnDB0uy9P
         zty9eJNCShZMWn+LTCerTbcdfYorfLE9pRFgeQpVIxjaNpz+8U68Hr6DQiJ6T/TMJWnM
         GmJtPhG0xJchpM4iAoYo5nwsOWtBO8nSlFUkxdm1ytJ/h2TfQq+GKSh/AfJJ6jROShoI
         Popg==
X-Gm-Message-State: AOJu0YxPnvcCurQOv4LqwzytONP5JhR90yD1g7ARlAwCRSwRDQlbam0o
	5xEh5RiVkPAqBZsLTWioEfBjw+LphxJIHxZi9DtqAwcJNoHhnYL3le54
X-Gm-Gg: ASbGncsaHiWGbuZ6eXeT2aJXYgH3yi7FAXih2GT4a0rhiZjPtkqQD92FhtsNTErfmO7
	6CfTFWhGBVMt5z6e4UzokCQDTrwebP1SeSDwhtKXCSru9OnQLA04PzveEpEJ3YdvEHnlqmBAAXV
	ghI6R58SpjVL5Ecoog37+d/Zt3SxcBqbvpTja3En0/zcyufcfw6UAmUY0y/Yby1iLXqFvJ3AwJv
	dObWbpDeVA5BWINXzWH/V59UULNO+hlbWItN+d1pgcPeHeCP8ck6+GE7yVp0a+kQ+t7luvWjKuh
	UftqE0hsugwqRizZTvehLUddaDLl50AvXPEGgibiD8PrhgmZEgrJ7OwOelFoojVK/Drn
X-Google-Smtp-Source: AGHT+IG8hRjnlcI9kYpEWPhW83hVai2Qk/WLVsDTqO4fskKXZmEaGJd4k7/zR0Eh/mmksfD0xC+EMw==
X-Received: by 2002:a05:6a00:887:b0:748:f41d:69d2 with SMTP id d2e1a72fcca58-74ea641c9d4mr97130b3a.4.1752008362874;
        Tue, 08 Jul 2025 13:59:22 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::647? ([2620:10d:c090:600::1:2404])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce429c46asm12885511b3a.129.2025.07.08.13.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 13:59:22 -0700 (PDT)
Message-ID: <690335c5969530cb96ed9b968ce7371fb1f0228a.camel@gmail.com>
Subject: Re: [RFC bpf-next 8/9] libbpf: support llvm-generated indirect jumps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Anton Protopopov
	 <a.s.protopopov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>,
 Daniel Borkmann	 <daniel@iogearbox.net>, Quentin Monnet <qmo@kernel.org>,
 Yonghong Song	 <yonghong.song@linux.dev>
Date: Tue, 08 Jul 2025 13:59:20 -0700
In-Reply-To: <CAADnVQKhVyh4WqjUgxYLZwn5VMY6hSMWyLoQPxt4TJG1812DcA@mail.gmail.com>
References: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
	 <20250615085943.3871208-9-a.s.protopopov@gmail.com>
	 <CAADnVQKhVyh4WqjUgxYLZwn5VMY6hSMWyLoQPxt4TJG1812DcA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-06-17 at 20:22 -0700, Alexei Starovoitov wrote:
> On Sun, Jun 15, 2025 at 1:55=E2=80=AFAM Anton Protopopov
> <a.s.protopopov@gmail.com> wrote:
> >=20
> > The final line generates an indirect jump. The
> > format of the indirect jump instruction supported by BPF is
> >=20
> >     BPF_JMP|BPF_X|BPF_JA, SRC=3D0, DST=3DRx, off=3D0, imm=3Dfd(M)
> >=20

[...]

> Uglier alternatives is to redesign the gotox encoding and
> drop ld_imm64 and *=3D8 altogether.
> Then gotox jmp_table[R5] will be like jumbo insn that
> does *=3D8 and load inside and JIT emits all that.
> But it's ugly and likely has other downsides.

I talked to Alexei and Yonghong off-list, and we seem to be in
agreement that having a single gotox capturing both the map and the
offset looks more elegant. E.g.:

  gotox imm32[dst_reg];

Where imm32 is an fd of the map corresponding to the jump table,
and dst-reg is an offset inside the table (it could also be an index).

So, instead of a current codegen:

  0000000000000000 <foo>:
       ...
       1:       w1 =3D w1
       2:       r1 <<=3D 0x3
       3:       r2 =3D 0x0 ll
                0000000000000018:  R_BPF_64_64  .BPF.JT.0.0
       5:       r2 +=3D r1
       6:       r1 =3D *(u64 *)(r2 + 0x0)
       7:       gotox r1
                0000000000000038:  R_BPF_64_64  .BPF.JT.0.0

LLVM would produce:

  0000000000000000 <foo>:
       ...
       1:       w1 =3D w1
       2:       r1 <<=3D 0x3
       3:       gotox r1
                0000000000000038:  R_BPF_64_64  .BPF.JT.0.0

This sequence leaks a bit less implementation details and avoids a
check for correspondence between load and gotox instructions.
It will require using REG_AX on the jit side.
LLVM side implementation is not hard, as it directly maps to `br_jt`
selection DAG instruction.

Anton, wdyt?

