Return-Path: <bpf+bounces-14910-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6951B7E8E04
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 03:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0254280D98
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 02:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43C71840;
	Sun, 12 Nov 2023 02:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhhj8rkU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEC0185F
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 02:49:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1785C433CB
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 02:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699757367;
	bh=rIkFv8nGkPM9rlQLYrVYnJRrrtq8rKN0184X/jIv9cY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fhhj8rkU64adBHDeZHFxBVH7qfiTCmhb2f8dol4zeFcO5P74pW9wyigV71B1PNsnU
	 aOGXq0PT+VSZkwUR9k92d96HkGtrj6OlRhKoyRJ20PsJDkNR1YoXb0Pq/dvcaw28vC
	 0dnzG4ulgVExMR9jMg2U/oBqi8yZfed2uv5/QH+MoH4t95rcVCzqHH+GeGBqQK0S6a
	 MU9aaP0rqYK+xPEX4VjS4H6gaNehdSOjoGoydy2TrRbAWYT1AhOROtzt9bD2N2anEG
	 I2GM4GF4A+0aqnoTOSrJIMhHWrw+Kff5S1hB0+WmPOL17AwzgPcEZLKhvYAJK9n3VS
	 fyp8DlliwEwng==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5446c9f3a77so5309876a12.0
        for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 18:49:27 -0800 (PST)
X-Gm-Message-State: AOJu0YzKXFC6NYUsIriCgWciWJ1PdNcQb7L5AxCcsQE7OSsRXl7NzlXn
	nQF0L9EEGD4ItQdqhvEluUzuV/uoaUirqram7jo=
X-Google-Smtp-Source: AGHT+IFkC/VPpxj9L9NOaZjxlh5akwRjzXDgYVje2TQycWdZSZORdo8BMdC0DJF7DSsCmIodCZLnj7yMXuLbJWKAEW0=
X-Received: by 2002:a05:6402:88d:b0:543:7201:7c70 with SMTP id
 e13-20020a056402088d00b0054372017c70mr2906409edy.7.1699757365914; Sat, 11 Nov
 2023 18:49:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231026184337.563801-1-hengqi.chen@gmail.com>
 <20231026184337.563801-9-hengqi.chen@gmail.com> <CAAhV-H7Zh3NVaxrag-4t594K8shW4Y7V0sp3Wn79Z1WJoACcwQ@mail.gmail.com>
 <CAEyhmHTKzXfAOXAk0BxzM7XyLVy=A8P_bWpG-u+UTHSG2WF+qQ@mail.gmail.com> <CAAhV-H5gzXV=Dt05jt59y76KCQorik67ndQ7VxguPTKg8nsD3w@mail.gmail.com>
In-Reply-To: <CAAhV-H5gzXV=Dt05jt59y76KCQorik67ndQ7VxguPTKg8nsD3w@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 12 Nov 2023 10:49:16 +0800
X-Gmail-Original-Message-ID: <CAAhV-H77+wDuycUBSpzkNEHJm-K0QHmCuYTHFUwvbGKo46WeWg@mail.gmail.com>
Message-ID: <CAAhV-H77+wDuycUBSpzkNEHJm-K0QHmCuYTHFUwvbGKo46WeWg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 8/8] selftests/bpf: Enable cpu v4 tests for LoongArch
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, kernel@xen0n.name, 
	yangtiezhu@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 12, 2023 at 12:19=E2=80=AFAM Huacai Chen <chenhuacai@kernel.org=
> wrote:
>
> Hi, Hengqi,
>
> On Sat, Nov 11, 2023 at 10:50=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail.c=
om> wrote:
> >
> > Hi Huacai,
> >
> > On Thu, Nov 9, 2023 at 11:25=E2=80=AFPM Huacai Chen <chenhuacai@kernel.=
org> wrote:
> > >
> > > Hi, Hengqi,
> > >
> > > I applied this series here:
> > > https://github.com/chenhuacai/linux/commits/loongarch-next
> > >
> > > But I have some problems, see below.
> > >
> > > On Fri, Oct 27, 2023 at 2:01=E2=80=AFPM Hengqi Chen <hengqi.chen@gmai=
l.com> wrote:
> > > >
> > > > Enable cpu v4 tests for LoongArch. Currently, we don't
> > > > have BPF trampoline in LoongArch JIT, so the fentry
> > > > test `test_ptr_struct_arg` still failed, will followup.
> > > > Test result attached below:
> > > >
> > > >   # ./test_progs -t verifier_sdiv,verifier_movsx,verifier_ldsx,veri=
fier_gotol,verifier_bswap
> > > If I disable unprivileged bpf, these tests pass, but unprivileged
> > > tests are skipped; if I enable unprivileged bpf, the 'verifier_movsx'
> > > causes the system hang.
> > >
> >
> > I can't reproduce this on my machine, see my .config at
> > https://github.com/chenhengqi/public
> OK, I will try you .config, and could you please try the code in my
> repo, too? I rebased on the mainline and there may be other problems.
I have tried your .config and no system hangs. And I also find that if
enabling CONFIG_BPF_JIT_ALWAYS_ON based on your .config there will be
a system hang during tests. So, does that mean you only tested the
interpreter but not JIT?

And the other problem still exists even using your .config,
'ctx_member_sign_ext' still fails.

Huacai

>
> Huacai
>
> >
> > > >   #316/1   verifier_bswap/BSWAP, 16:OK
> > > >   #316/2   verifier_bswap/BSWAP, 16 @unpriv:OK
> > > >   #316/3   verifier_bswap/BSWAP, 32:OK
> > > >   #316/4   verifier_bswap/BSWAP, 32 @unpriv:OK
> > > >   #316/5   verifier_bswap/BSWAP, 64:OK
> > > >   #316/6   verifier_bswap/BSWAP, 64 @unpriv:OK
> > > >   #316     verifier_bswap:OK
> > > >   #330/1   verifier_gotol/gotol, small_imm:OK
> > > >   #330/2   verifier_gotol/gotol, small_imm @unpriv:OK
> > > >   #330     verifier_gotol:OK
> > > >   #338/1   verifier_ldsx/LDSX, S8:OK
> > > >   #338/2   verifier_ldsx/LDSX, S8 @unpriv:OK
> > > >   #338/3   verifier_ldsx/LDSX, S16:OK
> > > >   #338/4   verifier_ldsx/LDSX, S16 @unpriv:OK
> > > >   #338/5   verifier_ldsx/LDSX, S32:OK
> > > >   #338/6   verifier_ldsx/LDSX, S32 @unpriv:OK
> > > >   #338/7   verifier_ldsx/LDSX, S8 range checking, privileged:OK
> > > >   #338/8   verifier_ldsx/LDSX, S16 range checking:OK
> > > >   #338/9   verifier_ldsx/LDSX, S16 range checking @unpriv:OK
> > > >   #338/10  verifier_ldsx/LDSX, S32 range checking:OK
> > > >   #338/11  verifier_ldsx/LDSX, S32 range checking @unpriv:OK
> > > >   #338     verifier_ldsx:OK
> > > >   #349/1   verifier_movsx/MOV32SX, S8:OK
> > > >   #349/2   verifier_movsx/MOV32SX, S8 @unpriv:OK
> > > >   #349/3   verifier_movsx/MOV32SX, S16:OK
> > > >   #349/4   verifier_movsx/MOV32SX, S16 @unpriv:OK
> > > >   #349/5   verifier_movsx/MOV64SX, S8:OK
> > > >   #349/6   verifier_movsx/MOV64SX, S8 @unpriv:OK
> > > >   #349/7   verifier_movsx/MOV64SX, S16:OK
> > > >   #349/8   verifier_movsx/MOV64SX, S16 @unpriv:OK
> > > >   #349/9   verifier_movsx/MOV64SX, S32:OK
> > > >   #349/10  verifier_movsx/MOV64SX, S32 @unpriv:OK
> > > >   #349/11  verifier_movsx/MOV32SX, S8, range_check:OK
> > > >   #349/12  verifier_movsx/MOV32SX, S8, range_check @unpriv:OK
> > > >   #349/13  verifier_movsx/MOV32SX, S16, range_check:OK
> > > >   #349/14  verifier_movsx/MOV32SX, S16, range_check @unpriv:OK
> > > >   #349/15  verifier_movsx/MOV32SX, S16, range_check 2:OK
> > > >   #349/16  verifier_movsx/MOV32SX, S16, range_check 2 @unpriv:OK
> > > >   #349/17  verifier_movsx/MOV64SX, S8, range_check:OK
> > > >   #349/18  verifier_movsx/MOV64SX, S8, range_check @unpriv:OK
> > > >   #349/19  verifier_movsx/MOV64SX, S16, range_check:OK
> > > >   #349/20  verifier_movsx/MOV64SX, S16, range_check @unpriv:OK
> > > >   #349/21  verifier_movsx/MOV64SX, S32, range_check:OK
> > > >   #349/22  verifier_movsx/MOV64SX, S32, range_check @unpriv:OK
> > > >   #349/23  verifier_movsx/MOV64SX, S16, R10 Sign Extension:OK
> > > >   #349/24  verifier_movsx/MOV64SX, S16, R10 Sign Extension @unpriv:=
OK
> > > >   #349     verifier_movsx:OK
> > > >   #361/1   verifier_sdiv/SDIV32, non-zero imm divisor, check 1:OK
> > > >   #361/2   verifier_sdiv/SDIV32, non-zero imm divisor, check 1 @unp=
riv:OK
> > > >   #361/3   verifier_sdiv/SDIV32, non-zero imm divisor, check 2:OK
> > > >   #361/4   verifier_sdiv/SDIV32, non-zero imm divisor, check 2 @unp=
riv:OK
> > > >   #361/5   verifier_sdiv/SDIV32, non-zero imm divisor, check 3:OK
> > > >   #361/6   verifier_sdiv/SDIV32, non-zero imm divisor, check 3 @unp=
riv:OK
> > > >   #361/7   verifier_sdiv/SDIV32, non-zero imm divisor, check 4:OK
> > > >   #361/8   verifier_sdiv/SDIV32, non-zero imm divisor, check 4 @unp=
riv:OK
> > > >   #361/9   verifier_sdiv/SDIV32, non-zero imm divisor, check 5:OK
> > > >   #361/10  verifier_sdiv/SDIV32, non-zero imm divisor, check 5 @unp=
riv:OK
> > > >   #361/11  verifier_sdiv/SDIV32, non-zero imm divisor, check 6:OK
> > > >   #361/12  verifier_sdiv/SDIV32, non-zero imm divisor, check 6 @unp=
riv:OK
> > > >   #361/13  verifier_sdiv/SDIV32, non-zero imm divisor, check 7:OK
> > > >   #361/14  verifier_sdiv/SDIV32, non-zero imm divisor, check 7 @unp=
riv:OK
> > > >   #361/15  verifier_sdiv/SDIV32, non-zero imm divisor, check 8:OK
> > > >   #361/16  verifier_sdiv/SDIV32, non-zero imm divisor, check 8 @unp=
riv:OK
> > > >   #361/17  verifier_sdiv/SDIV32, non-zero reg divisor, check 1:OK
> > > >   #361/18  verifier_sdiv/SDIV32, non-zero reg divisor, check 1 @unp=
riv:OK
> > > >   #361/19  verifier_sdiv/SDIV32, non-zero reg divisor, check 2:OK
> > > >   #361/20  verifier_sdiv/SDIV32, non-zero reg divisor, check 2 @unp=
riv:OK
> > > >   #361/21  verifier_sdiv/SDIV32, non-zero reg divisor, check 3:OK
> > > >   #361/22  verifier_sdiv/SDIV32, non-zero reg divisor, check 3 @unp=
riv:OK
> > > >   #361/23  verifier_sdiv/SDIV32, non-zero reg divisor, check 4:OK
> > > >   #361/24  verifier_sdiv/SDIV32, non-zero reg divisor, check 4 @unp=
riv:OK
> > > >   #361/25  verifier_sdiv/SDIV32, non-zero reg divisor, check 5:OK
> > > >   #361/26  verifier_sdiv/SDIV32, non-zero reg divisor, check 5 @unp=
riv:OK
> > > >   #361/27  verifier_sdiv/SDIV32, non-zero reg divisor, check 6:OK
> > > >   #361/28  verifier_sdiv/SDIV32, non-zero reg divisor, check 6 @unp=
riv:OK
> > > >   #361/29  verifier_sdiv/SDIV32, non-zero reg divisor, check 7:OK
> > > >   #361/30  verifier_sdiv/SDIV32, non-zero reg divisor, check 7 @unp=
riv:OK
> > > >   #361/31  verifier_sdiv/SDIV32, non-zero reg divisor, check 8:OK
> > > >   #361/32  verifier_sdiv/SDIV32, non-zero reg divisor, check 8 @unp=
riv:OK
> > > >   #361/33  verifier_sdiv/SDIV64, non-zero imm divisor, check 1:OK
> > > >   #361/34  verifier_sdiv/SDIV64, non-zero imm divisor, check 1 @unp=
riv:OK
> > > >   #361/35  verifier_sdiv/SDIV64, non-zero imm divisor, check 2:OK
> > > >   #361/36  verifier_sdiv/SDIV64, non-zero imm divisor, check 2 @unp=
riv:OK
> > > >   #361/37  verifier_sdiv/SDIV64, non-zero imm divisor, check 3:OK
> > > >   #361/38  verifier_sdiv/SDIV64, non-zero imm divisor, check 3 @unp=
riv:OK
> > > >   #361/39  verifier_sdiv/SDIV64, non-zero imm divisor, check 4:OK
> > > >   #361/40  verifier_sdiv/SDIV64, non-zero imm divisor, check 4 @unp=
riv:OK
> > > >   #361/41  verifier_sdiv/SDIV64, non-zero imm divisor, check 5:OK
> > > >   #361/42  verifier_sdiv/SDIV64, non-zero imm divisor, check 5 @unp=
riv:OK
> > > >   #361/43  verifier_sdiv/SDIV64, non-zero imm divisor, check 6:OK
> > > >   #361/44  verifier_sdiv/SDIV64, non-zero imm divisor, check 6 @unp=
riv:OK
> > > >   #361/45  verifier_sdiv/SDIV64, non-zero reg divisor, check 1:OK
> > > >   #361/46  verifier_sdiv/SDIV64, non-zero reg divisor, check 1 @unp=
riv:OK
> > > >   #361/47  verifier_sdiv/SDIV64, non-zero reg divisor, check 2:OK
> > > >   #361/48  verifier_sdiv/SDIV64, non-zero reg divisor, check 2 @unp=
riv:OK
> > > >   #361/49  verifier_sdiv/SDIV64, non-zero reg divisor, check 3:OK
> > > >   #361/50  verifier_sdiv/SDIV64, non-zero reg divisor, check 3 @unp=
riv:OK
> > > >   #361/51  verifier_sdiv/SDIV64, non-zero reg divisor, check 4:OK
> > > >   #361/52  verifier_sdiv/SDIV64, non-zero reg divisor, check 4 @unp=
riv:OK
> > > >   #361/53  verifier_sdiv/SDIV64, non-zero reg divisor, check 5:OK
> > > >   #361/54  verifier_sdiv/SDIV64, non-zero reg divisor, check 5 @unp=
riv:OK
> > > >   #361/55  verifier_sdiv/SDIV64, non-zero reg divisor, check 6:OK
> > > >   #361/56  verifier_sdiv/SDIV64, non-zero reg divisor, check 6 @unp=
riv:OK
> > > >   #361/57  verifier_sdiv/SMOD32, non-zero imm divisor, check 1:OK
> > > >   #361/58  verifier_sdiv/SMOD32, non-zero imm divisor, check 1 @unp=
riv:OK
> > > >   #361/59  verifier_sdiv/SMOD32, non-zero imm divisor, check 2:OK
> > > >   #361/60  verifier_sdiv/SMOD32, non-zero imm divisor, check 2 @unp=
riv:OK
> > > >   #361/61  verifier_sdiv/SMOD32, non-zero imm divisor, check 3:OK
> > > >   #361/62  verifier_sdiv/SMOD32, non-zero imm divisor, check 3 @unp=
riv:OK
> > > >   #361/63  verifier_sdiv/SMOD32, non-zero imm divisor, check 4:OK
> > > >   #361/64  verifier_sdiv/SMOD32, non-zero imm divisor, check 4 @unp=
riv:OK
> > > >   #361/65  verifier_sdiv/SMOD32, non-zero imm divisor, check 5:OK
> > > >   #361/66  verifier_sdiv/SMOD32, non-zero imm divisor, check 5 @unp=
riv:OK
> > > >   #361/67  verifier_sdiv/SMOD32, non-zero imm divisor, check 6:OK
> > > >   #361/68  verifier_sdiv/SMOD32, non-zero imm divisor, check 6 @unp=
riv:OK
> > > >   #361/69  verifier_sdiv/SMOD32, non-zero reg divisor, check 1:OK
> > > >   #361/70  verifier_sdiv/SMOD32, non-zero reg divisor, check 1 @unp=
riv:OK
> > > >   #361/71  verifier_sdiv/SMOD32, non-zero reg divisor, check 2:OK
> > > >   #361/72  verifier_sdiv/SMOD32, non-zero reg divisor, check 2 @unp=
riv:OK
> > > >   #361/73  verifier_sdiv/SMOD32, non-zero reg divisor, check 3:OK
> > > >   #361/74  verifier_sdiv/SMOD32, non-zero reg divisor, check 3 @unp=
riv:OK
> > > >   #361/75  verifier_sdiv/SMOD32, non-zero reg divisor, check 4:OK
> > > >   #361/76  verifier_sdiv/SMOD32, non-zero reg divisor, check 4 @unp=
riv:OK
> > > >   #361/77  verifier_sdiv/SMOD32, non-zero reg divisor, check 5:OK
> > > >   #361/78  verifier_sdiv/SMOD32, non-zero reg divisor, check 5 @unp=
riv:OK
> > > >   #361/79  verifier_sdiv/SMOD32, non-zero reg divisor, check 6:OK
> > > >   #361/80  verifier_sdiv/SMOD32, non-zero reg divisor, check 6 @unp=
riv:OK
> > > >   #361/81  verifier_sdiv/SMOD64, non-zero imm divisor, check 1:OK
> > > >   #361/82  verifier_sdiv/SMOD64, non-zero imm divisor, check 1 @unp=
riv:OK
> > > >   #361/83  verifier_sdiv/SMOD64, non-zero imm divisor, check 2:OK
> > > >   #361/84  verifier_sdiv/SMOD64, non-zero imm divisor, check 2 @unp=
riv:OK
> > > >   #361/85  verifier_sdiv/SMOD64, non-zero imm divisor, check 3:OK
> > > >   #361/86  verifier_sdiv/SMOD64, non-zero imm divisor, check 3 @unp=
riv:OK
> > > >   #361/87  verifier_sdiv/SMOD64, non-zero imm divisor, check 4:OK
> > > >   #361/88  verifier_sdiv/SMOD64, non-zero imm divisor, check 4 @unp=
riv:OK
> > > >   #361/89  verifier_sdiv/SMOD64, non-zero imm divisor, check 5:OK
> > > >   #361/90  verifier_sdiv/SMOD64, non-zero imm divisor, check 5 @unp=
riv:OK
> > > >   #361/91  verifier_sdiv/SMOD64, non-zero imm divisor, check 6:OK
> > > >   #361/92  verifier_sdiv/SMOD64, non-zero imm divisor, check 6 @unp=
riv:OK
> > > >   #361/93  verifier_sdiv/SMOD64, non-zero imm divisor, check 7:OK
> > > >   #361/94  verifier_sdiv/SMOD64, non-zero imm divisor, check 7 @unp=
riv:OK
> > > >   #361/95  verifier_sdiv/SMOD64, non-zero imm divisor, check 8:OK
> > > >   #361/96  verifier_sdiv/SMOD64, non-zero imm divisor, check 8 @unp=
riv:OK
> > > >   #361/97  verifier_sdiv/SMOD64, non-zero reg divisor, check 1:OK
> > > >   #361/98  verifier_sdiv/SMOD64, non-zero reg divisor, check 1 @unp=
riv:OK
> > > >   #361/99  verifier_sdiv/SMOD64, non-zero reg divisor, check 2:OK
> > > >   #361/100 verifier_sdiv/SMOD64, non-zero reg divisor, check 2 @unp=
riv:OK
> > > >   #361/101 verifier_sdiv/SMOD64, non-zero reg divisor, check 3:OK
> > > >   #361/102 verifier_sdiv/SMOD64, non-zero reg divisor, check 3 @unp=
riv:OK
> > > >   #361/103 verifier_sdiv/SMOD64, non-zero reg divisor, check 4:OK
> > > >   #361/104 verifier_sdiv/SMOD64, non-zero reg divisor, check 4 @unp=
riv:OK
> > > >   #361/105 verifier_sdiv/SMOD64, non-zero reg divisor, check 5:OK
> > > >   #361/106 verifier_sdiv/SMOD64, non-zero reg divisor, check 5 @unp=
riv:OK
> > > >   #361/107 verifier_sdiv/SMOD64, non-zero reg divisor, check 6:OK
> > > >   #361/108 verifier_sdiv/SMOD64, non-zero reg divisor, check 6 @unp=
riv:OK
> > > >   #361/109 verifier_sdiv/SMOD64, non-zero reg divisor, check 7:OK
> > > >   #361/110 verifier_sdiv/SMOD64, non-zero reg divisor, check 7 @unp=
riv:OK
> > > >   #361/111 verifier_sdiv/SMOD64, non-zero reg divisor, check 8:OK
> > > >   #361/112 verifier_sdiv/SMOD64, non-zero reg divisor, check 8 @unp=
riv:OK
> > > >   #361/113 verifier_sdiv/SDIV32, zero divisor:OK
> > > >   #361/114 verifier_sdiv/SDIV32, zero divisor @unpriv:OK
> > > >   #361/115 verifier_sdiv/SDIV64, zero divisor:OK
> > > >   #361/116 verifier_sdiv/SDIV64, zero divisor @unpriv:OK
> > > >   #361/117 verifier_sdiv/SMOD32, zero divisor:OK
> > > >   #361/118 verifier_sdiv/SMOD32, zero divisor @unpriv:OK
> > > >   #361/119 verifier_sdiv/SMOD64, zero divisor:OK
> > > >   #361/120 verifier_sdiv/SMOD64, zero divisor @unpriv:OK
> > > >   #361     verifier_sdiv:OK
> > > >   Summary: 5/163 PASSED, 0 SKIPPED, 0 FAILED
> > > >
> > > >   # ./test_progs -t ldsx_insn
> > > >   test_map_val_and_probed_memory:PASS:test_ldsx_insn__open 0 nsec
> > > >   test_map_val_and_probed_memory:PASS:test_ldsx_insn__load 0 nsec
> > > >   libbpf: prog 'test_ptr_struct_arg': failed to attach: ERROR: stre=
rror_r(-524)=3D22
> > > >   libbpf: prog 'test_ptr_struct_arg': failed to auto-attach: -524
> > > >   test_map_val_and_probed_memory:FAIL:test_ldsx_insn__attach unexpe=
cted error: -524 (errno 524)
> > > >   #116/1   ldsx_insn/map_val and probed_memory:FAIL
> > > >   #116/2   ldsx_insn/ctx_member_sign_ext:OK
> > > During my tests, 'ctx_member_sign_ext' fails.
> > >
> > > Do you know why (you can test with the code in my repo)? Thanks.
> > >
> > > Huacai
> > >
> > > >   #116/3   ldsx_insn/ctx_member_narrow_sign_ext:OK
> > > >   #116     ldsx_insn:FAIL
> > > >
> > > >   All error logs:
> > > >   test_map_val_and_probed_memory:PASS:test_ldsx_insn__open 0 nsec
> > > >   test_map_val_and_probed_memory:PASS:test_ldsx_insn__load 0 nsec
> > > >   libbpf: prog 'test_ptr_struct_arg': failed to attach: ERROR: stre=
rror_r(-524)=3D22
> > > >   libbpf: prog 'test_ptr_struct_arg': failed to auto-attach: -524
> > > >   test_map_val_and_probed_memory:FAIL:test_ldsx_insn__attach unexpe=
cted error: -524 (errno 524)
> > > >   #116/1   ldsx_insn/map_val and probed_memory:FAIL
> > > >   #116     ldsx_insn:FAIL
> > > >   Summary: 0/2 PASSED, 0 SKIPPED, 1 FAILED
> > > >
> > > > Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> > > > ---
> > > >  tools/testing/selftests/bpf/progs/test_ldsx_insn.c | 3 ++-
> > > >  tools/testing/selftests/bpf/progs/verifier_bswap.c | 3 ++-
> > > >  tools/testing/selftests/bpf/progs/verifier_gotol.c | 3 ++-
> > > >  tools/testing/selftests/bpf/progs/verifier_ldsx.c  | 3 ++-
> > > >  tools/testing/selftests/bpf/progs/verifier_movsx.c | 3 ++-
> > > >  tools/testing/selftests/bpf/progs/verifier_sdiv.c  | 3 ++-
> > > >  6 files changed, 12 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/tools/testing/selftests/bpf/progs/test_ldsx_insn.c b/t=
ools/testing/selftests/bpf/progs/test_ldsx_insn.c
> > > > index 3ddcb3777912..2a2a942737d7 100644
> > > > --- a/tools/testing/selftests/bpf/progs/test_ldsx_insn.c
> > > > +++ b/tools/testing/selftests/bpf/progs/test_ldsx_insn.c
> > > > @@ -7,7 +7,8 @@
> > > >
> > > >  #if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) ||=
 \
> > > >       (defined(__TARGET_ARCH_riscv) && __riscv_xlen =3D=3D 64) ||  =
     \
> > > > -     defined(__TARGET_ARCH_s390)) && __clang_major__ >=3D 18
> > > > +     defined(__TARGET_ARCH_s390) || defined(__TARGET_ARCH_loongarc=
h)) && \
> > > > +     __clang_major__ >=3D 18
> > > >  const volatile int skip =3D 0;
> > > >  #else
> > > >  const volatile int skip =3D 1;
> > > > diff --git a/tools/testing/selftests/bpf/progs/verifier_bswap.c b/t=
ools/testing/selftests/bpf/progs/verifier_bswap.c
> > > > index 107525fb4a6a..e61755656e8d 100644
> > > > --- a/tools/testing/selftests/bpf/progs/verifier_bswap.c
> > > > +++ b/tools/testing/selftests/bpf/progs/verifier_bswap.c
> > > > @@ -6,7 +6,8 @@
> > > >
> > > >  #if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) ||=
 \
> > > >         (defined(__TARGET_ARCH_riscv) && __riscv_xlen =3D=3D 64) ||=
 \
> > > > -        defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390))=
 && \
> > > > +       defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390) |=
| \
> > > > +       defined(__TARGET_ARCH_loongarch)) && \
> > > >         __clang_major__ >=3D 18
> > > >
> > > >  SEC("socket")
> > > > diff --git a/tools/testing/selftests/bpf/progs/verifier_gotol.c b/t=
ools/testing/selftests/bpf/progs/verifier_gotol.c
> > > > index 9f202eda952f..d1edbcff9a18 100644
> > > > --- a/tools/testing/selftests/bpf/progs/verifier_gotol.c
> > > > +++ b/tools/testing/selftests/bpf/progs/verifier_gotol.c
> > > > @@ -6,7 +6,8 @@
> > > >
> > > >  #if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) ||=
 \
> > > >         (defined(__TARGET_ARCH_riscv) && __riscv_xlen =3D=3D 64) ||=
 \
> > > > -        defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390))=
 && \
> > > > +       defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390) |=
| \
> > > > +       defined(__TARGET_ARCH_loongarch)) && \
> > > >         __clang_major__ >=3D 18
> > > >
> > > >  SEC("socket")
> > > > diff --git a/tools/testing/selftests/bpf/progs/verifier_ldsx.c b/to=
ols/testing/selftests/bpf/progs/verifier_ldsx.c
> > > > index 375525329637..d4427d8e1217 100644
> > > > --- a/tools/testing/selftests/bpf/progs/verifier_ldsx.c
> > > > +++ b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
> > > > @@ -6,7 +6,8 @@
> > > >
> > > >  #if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) ||=
 \
> > > >         (defined(__TARGET_ARCH_riscv) && __riscv_xlen =3D=3D 64) ||=
 \
> > > > -        defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390))=
 && \
> > > > +       defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390) |=
| \
> > > > +       defined(__TARGET_ARCH_loongarch)) && \
> > > >         __clang_major__ >=3D 18
> > > >
> > > >  SEC("socket")
> > > > diff --git a/tools/testing/selftests/bpf/progs/verifier_movsx.c b/t=
ools/testing/selftests/bpf/progs/verifier_movsx.c
> > > > index b2a04d1179d0..cbb9d6714f53 100644
> > > > --- a/tools/testing/selftests/bpf/progs/verifier_movsx.c
> > > > +++ b/tools/testing/selftests/bpf/progs/verifier_movsx.c
> > > > @@ -6,7 +6,8 @@
> > > >
> > > >  #if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) ||=
 \
> > > >         (defined(__TARGET_ARCH_riscv) && __riscv_xlen =3D=3D 64) ||=
 \
> > > > -        defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390))=
 && \
> > > > +       defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390) |=
| \
> > > > +       defined(__TARGET_ARCH_loongarch)) && \
> > > >         __clang_major__ >=3D 18
> > > >
> > > >  SEC("socket")
> > > > diff --git a/tools/testing/selftests/bpf/progs/verifier_sdiv.c b/to=
ols/testing/selftests/bpf/progs/verifier_sdiv.c
> > > > index 8fc5174808b2..2a2271cf0294 100644
> > > > --- a/tools/testing/selftests/bpf/progs/verifier_sdiv.c
> > > > +++ b/tools/testing/selftests/bpf/progs/verifier_sdiv.c
> > > > @@ -6,7 +6,8 @@
> > > >
> > > >  #if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) ||=
 \
> > > >         (defined(__TARGET_ARCH_riscv) && __riscv_xlen =3D=3D 64) ||=
 \
> > > > -        defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390))=
 && \
> > > > +       defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390) |=
| \
> > > > +       defined(__TARGET_ARCH_loongarch)) && \
> > > >         __clang_major__ >=3D 18
> > > >
> > > >  SEC("socket")
> > > > --
> > > > 2.34.1
> > > >

