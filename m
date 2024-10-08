Return-Path: <bpf+bounces-41301-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5F59959DC
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 00:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FB721F24527
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 22:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB03215F64;
	Tue,  8 Oct 2024 22:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fx84mf6i"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00E8215F54
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 22:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728425476; cv=none; b=FshQIh9fI3xb3thHG8ZbkWrS2UH8kRau4HBurEtw8TRT4Fu0Sjow+NNu7+oDGIFXFaQDVTsJ7sf0RXCpC7jX/qBIHLSKVJ4D9Ff17dGTJGg7Jhp8A2MfgZt9hy+16SX70kITO3uKNDsumbIzS4qKMUHWMdbj+GaXBUajYJumuX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728425476; c=relaxed/simple;
	bh=insKODWPt6oQ6RYD8SqgRdZU8+/JNWUXBxV/EV3f0kI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KTLbJnCEFjdFsmJAe5rkmLfk2D6IRvWepE/gAq6z0rS+jkMEZ1Ek81JVyGp/55CNNbULcSeLClAr9HhAU5eMQWTF5/B+PICJgruwlNSGRZBVrU2gn2BWLSYahhoXzBFxHTTzcs+vp8u+kGuBf6a8Qn7xWTIs3SnDnPHzj3OylAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fx84mf6i; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37cd8a5aac9so3293731f8f.2
        for <bpf@vger.kernel.org>; Tue, 08 Oct 2024 15:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728425472; x=1729030272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qtlYOr/Tzl4nKLysgKB6CYI4peP/DmpP4FEBbdkBjTI=;
        b=fx84mf6iuFpaB1BGOVy2c8zzjR1DPZFYHPwCeyQk3FBptcLakZFJkNe8tcuUcATkJG
         XJgL8i/EhEjoedilL5gyZBflb0oq/Vvpod/FSorYGJ9K/mhke8YmD7cN96MtTpUKs9DR
         Jv/Jf1vWg9eWavRNuSe1ikXZxHNj5F0S/IqkemV+hUJn52K9uF5fCATRbnmn5spb5DcF
         UEYzI9pAgrYJb2KTk0pOhCaxb2N7i/k7xyy2Wb+87Za/F/CJAW2O6vDC9IsOmUhD2b1X
         Tj69cvlM9qh87gmZOEJ5MzyKnyD1nSgb3WaF47Fxqa98sS8OpxRUT+iWaCChm8bh7/ET
         qpPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728425472; x=1729030272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qtlYOr/Tzl4nKLysgKB6CYI4peP/DmpP4FEBbdkBjTI=;
        b=qJj5S6Vpdcr/39tCbuhssO5gAz0wIGgGNQneVTX0aawS5zY97+i2UeEt0eKK1cowPg
         jjU5TaBDX8deX8qauzYbSZbeL9KjmKAvjOCyqUAZXgmz/3YuAismumeV6/4pWuGfNQVJ
         ZZ1qDScAIL5nASv4sTVYclXS0HXR/cvhZknqXGHmhyiFhwysvMZ/7QzjRoF3u50+Oa0D
         YsaBUGA7tkLxMb+XhZIRtIJm7Q+BjzfnJoTJxwsUgIp3monglndU4kjV/QslIEI5zrAl
         ab0e/+tb53gvieRcqYbGWr911xvltfsw7BSqvjnYSJhtZovZ2C5SRINL8UvhiHSmBYqq
         iHag==
X-Forwarded-Encrypted: i=1; AJvYcCU/J+rzBV4idHrTv+ZSW26sKAx+872OAZJoOCW+PEwQM1CvVcSZXfsXTZniieJiKiqOxM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJrTvU55uaumNGAdYuT6v19WMyVykRHn+LekizgUgdR8ovnjpr
	kDtQYCIgQvE3C7xZbE3B0Z4jhfOD0TzVxIpvyLoqx7zRl7Uh3QtHXD0UsyCosNJFssKpEVyamtY
	gBV8nRIkB6wahBj5Y51gHaGpFu5w=
X-Google-Smtp-Source: AGHT+IFDxRgKbcdlvofAb/I5YGhG1NDlIUkFwdUsJQ7L32izhaf9DSibInOvfMD4ulxvUTtZhryFWnsdjPNkVp3uFZs=
X-Received: by 2002:adf:f6ca:0:b0:37c:d0f2:baaf with SMTP id
 ffacd0b85a97d-37d3a9be4d4mr150127f8f.13.1728425471697; Tue, 08 Oct 2024
 15:11:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926234506.1769256-1-yonghong.song@linux.dev>
 <CAADnVQ+caNh8+fgCj2XeZDrXniYif5Y+rw6vsMOojBO3Qwk+Nw@mail.gmail.com>
 <CAADnVQKLWi_TfpbiYb1vPMYMqPOPWPS-RGbB0FksEQW5i36poQ@mail.gmail.com>
 <CAP01T77q_H31mPXPQV4xHifutxxFeuoD8eg75C717MZ=OOeHew@mail.gmail.com>
 <CAADnVQLfWgpu6WvZRCFo39YHJ=zSSQWcOnaCOqdfyCg8uRoddg@mail.gmail.com>
 <CAP01T77G63MGvomrd3563bgBcNKUZg0Jc=GGmcGO0zPLS0hcHA@mail.gmail.com>
 <CAADnVQ+z-s07V_KU91+zGRB3qXGR9nr3w1dMBfCEEgunyes7EA@mail.gmail.com>
 <8b6c1eb1-de43-4ddb-b2b6-48256bdacddb@linux.dev> <CAP01T77k7bqTx_VRhnUjcOcGDp-y=zJHzKi7S-+domZjhEGfzQ@mail.gmail.com>
 <CAADnVQ+UByKkpVSg4tC-hoV7DstEYE11WxJ4nbGj27emZ2PFmA@mail.gmail.com>
 <a3116710-7e55-42ce-abd2-7becee9c275f@linux.dev> <CAADnVQKO1=ywkfULmSE=15dFU4Ovn3OMVbnGpkah5noeDnwtgw@mail.gmail.com>
 <d8ff2878-c53b-48d7-b624-93aeb2087113@linux.dev> <a4468429-3b93-49b3-b8e4-122b903c98fb@linux.dev>
 <CAADnVQJRd-ngE8UBVUZVzwUwK6cGLMtZngwoUK+HOh2t_evcgQ@mail.gmail.com> <1fc78197-c266-41d2-8d8a-c9dbf2e35d8f@linux.dev>
In-Reply-To: <1fc78197-c266-41d2-8d8a-c9dbf2e35d8f@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 8 Oct 2024 15:10:59 -0700
Message-ID: <CAADnVQ+tvGMFnEuZmKyXxJX25pL+G6X+9445Ct-RSU1sZ+57xw@mail.gmail.com>
Subject: Re: yet another approach Was: [PATCH bpf-next v3 4/5] bpf, x86: Add
 jit support for private stack
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 7:03=E2=80=AFPM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
>
> On 10/4/24 12:52 PM, Alexei Starovoitov wrote:
> > On Fri, Oct 4, 2024 at 12:28=E2=80=AFPM Yonghong Song <yonghong.song@li=
nux.dev> wrote:
> >>
> >> On 10/3/24 10:22 PM, Yonghong Song wrote:
> >>> On 10/3/24 3:32 PM, Alexei Starovoitov wrote:
> >>>> On Thu, Oct 3, 2024 at 1:44=E2=80=AFPM Yonghong Song
> >>>> <yonghong.song@linux.dev> wrote:
> >>>>>> Looks like the idea needs more thought.
> >>>>>>
> >>>>>> in_task_stack() won't recognize the private stack,
> >>>>>> so it will look like stack overflow and double fault.
> >>>>>>
> >>>>>> do you have CONFIG_VMAP_STACK ?
> >>>>> Yes, my above test runs fine withCONFIG_VMAP_STACK. Let me guard
> >>>>> private stack support with
> >>>>> CONFIG_VMAP_STACK for now. Not sure whether distributions enable
> >>>>> CONFIG_VMAP_STACK or not.
> >>>> Good! but I'm surprised it makes a difference.
> >>> That only for the test case I tried. Now I tried the whole bpf selfte=
sts
> >>> with CONFIG_VMAP_STACK on. There are still some failures. Some of the=
m
> >>> due to stack protector. I disabled stack protector and then those sta=
ck
> >>> protector error gone. But some other errors show up like below:
> >>>
> >>> [   27.186581] kernel tried to execute NX-protected page - exploit
> >>> attempt? (uid: 0)
> >>> [   27.187480] BUG: unable to handle page fault for address:
> >>> ffff888109572800
> >>> [   27.188299] #PF: supervisor instruction fetch in kernel mode
> >>> [   27.189085] #PF: error_code(0x0011) - permissions violation
> >>>
> >>> or
> >>>
> >>> [   27.736844] BUG: unable to handle page fault for address:
> >>> 0000000080000000
> >>> [   27.737759] #PF: supervisor instruction fetch in kernel mode
> >>> [   27.738631] #PF: error_code(0x0010) - not-present page
> >>> [   27.739455] PGD 0 P4D 0
> >>> [   27.739818] Oops: Oops: 0010 [#1] PREEMPT SMP PTI
> >>>
> >>> ...
> >>>
> >>> Some further investigations are needed.
> >>
> >> I found one failure case (with stackprotector disabled):
> >>
> >> [   20.032611] traps: PANIC: double fault, error_code: 0x0
> >> [   20.032615] Oops: double fault: 0000 [#1] PREEMPT SMP PTI
> >> [   20.032619] CPU: 0 UID: 0 PID: 1959 Comm: test_progs Tainted: G    =
       OE      6.11.0-10576-g17baa0096769-dirty #1006
> >> [   20.032623] Tainted: [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
> >> [   20.032624] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), =
BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> >> [   20.032626] RIP: 0010:error_entry+0x17/0x140
> >> [   20.032633] Code: ff 0f 01 f8 e9 56 fe ff ff 90 90 90 90 90 90 90 9=
0 90 90 56 48 8b 74 24 08 48 89 7c 24 08 52 51 50 41 50 41 51 41 52 49
> >> [   20.032635] RSP: 0018:ffffe8ffff400000 EFLAGS: 00010093
> >> [   20.032637] RAX: ffffe8ffff4000a8 RBX: ffffe8ffff4000a8 RCX: ffffff=
ff82201737
> >> [   20.032639] RDX: 0000000000000000 RSI: ffffffff8220128d RDI: ffffe8=
ffff4000a8
> >> [   20.032640] RBP: 0000000000000000 R08: 0000000000000000 R09: 000000=
0000000000
> >> [   20.032641] R10: 0000000000000000 R11: 0000000000000000 R12: 000000=
0000000000
> >> [   20.032642] R13: 0000000000000000 R14: 000000000002ed80 R15: 000000=
0000000000
> >> [   20.032643] FS:  00007f8a3a2006c0(0000) GS:ffff888237c00000(0000) k=
nlGS:ffff888237c00000
> >> [   20.032645] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> [   20.032646] CR2: ffffe8ffff3ffff8 CR3: 0000000103580002 CR4: 000000=
0000370ef0
> >> [   20.032649] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000=
0000000000
> >> [   20.032650] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000=
0000000400
> >> [   20.032651] Call Trace:
> >> [   20.032660]  <#DF>
> >> [   20.032664]  ? __die_body+0xaf/0xc0
> >> [   20.032667]  ? die+0x2f/0x50
> >> [   20.032670]  ? exc_double_fault+0xbf/0xd0
> >> [   20.032674]  ? asm_exc_double_fault+0x23/0x30
> >> [   20.032678]  ? restore_regs_and_return_to_kernel+0x1b/0x1b
> >> [   20.032681]  ? asm_exc_page_fault+0xd/0x30
> >> [   20.032684]  ? error_entry+0x17/0x140
> >> [   20.032687]  </#DF>
> >>
> >> The private stack for cpu 0:
> >>     priv_stack_ptr cpu 0 =3D [ffffe8ffff434000, ffffe8ffff438000] (tot=
al 16KB)
> >> That is, the top stack is ffffe8ffff438000 and the bottom stack is fff=
fe8ffff434000.
> >>
> >> During bpf execution, a softirq may happen, at that point,
> >> stack pointer becomes:
> >>      RSP: 0018:ffffe8ffff400000 (see above)
> >> and there is a read/write (mostly write) to address
> >>      CR2: ffffe8ffff3ffff8
> >> And this may cause a fault.
> >> After this fault, there are some further access and probably because
> >> of invalid stack, double fault happens.
> >>
> >> So the quesiton is why RSP is reset to ffffe8ffff400000?
> > 0x38000 bytes consumed by stack or rounded down?
> > That's unlikely.
> >
> >> I have not figured out which code changed this? Maybe somebody can hel=
p?
> > As Kumar said earlier pls share the patch. Link to github? or whichever=
.
> >
> > Double check that any kind of tail-call logic is not mixed with priv st=
ack.
>
> Here is the reproducer. Two attached files:
> priv_stack.config: the config file to build the kernel
> 0001-bpf-implement-private-stack.patch: the patch to apply to the top of =
bpf-next.
>
> The top bpf-next commit in my test:
> commit 9502a7de5a61bec3bda841a830560c5d6d40ecac (origin/master, origin/HE=
AD, master)
> Author: Mykyta Yatsenko <yatsenko@meta.com>
> Date:   Tue Oct 1 00:15:22 2024 +0100
>
>      selftests/bpf: Emit top frequent code lines in veristat
>
>
> I am using clang18 to build the kernel and selftests.
> The build command line:
>    make LLVM=3D1 -j
>    make -C tools/testing/selftests/bpf LLVM=3D1 -j
>
> In qemu vm, tools/testing/selftests/bpf directory, run the following scri=
pt:
>
> $ cat run.sh
> cat /proc/sys/net/core/bpf_jit_limit
> echo 796917760 > /proc/sys/net/core/bpf_jit_limit
> # ./test_progs -n 339/4
> ./test_progs -t task_local_storage/nodeadlock
>
> With private stack on by default, in my environment, booting will failure=
.
> So by default, private stack is off.
> In the above
>    echo 796917760 > /proc/sys/net/core/bpf_jit_limit
> intends to enable private stack.

well, the patch is written in a way that
  cat /proc/sys/net/core/bpf_jit_limit
is enough to enable priv stack.

> +       if (yhs && !is_subprog && !tail_call_reachable && bpf_prog->aux->=
priv_stack_ptr) {
> +               EMIT3_off32(0x48, 0x81, 0xEC, round_up(stack_depth, 8) + =
16);

this part is unnecessary.
Just setting rsp to the top is enough to start doing things
in a new stack, but I'm afraid this is a dead end.
I've played with orc and frame pointer unwders.
Both are not happy with our hack.
get_stack_info() returns unknown, so any logic that needs to collect
the stack gets into the loop that exhausts our broken stack and
it eventually dies with NULL deref or double fault.
The simplest way to repro the brokeness is with:

@@ -255,6 +255,8 @@ BPF_CALL_5(bpf_task_storage_get, struct bpf_map *,
map, struct task_struct *,
        if (flags & ~BPF_LOCAL_STORAGE_GET_F_CREATE || !task)
                return (unsigned long)NULL;

+       dump_stack();
+       return 0;

(in addition to your patch that calls it from
task_local_storage/nodeadlock test).
It will loop like:
[   17.708612] bad stack ffffe8fffd620000
[   17.714759] CPU: 0 UID: 0 PID: 2186 Comm: test_progs Not tainted
6.12.0-rc1-00162-g3fe52dc7912d-dirty #6365
[   17.715692] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[   17.715692] Call Trace:
[   17.715692] bad stack ffffe8fffd620000
[   17.721814] CPU: 0 UID: 0 PID: 2182 Comm: test_progs Not tainted
6.12.0-rc1-00162-g3fe52dc7912d-dirty #6365
[   17.722763] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[   17.722763] Call Trace:
[   17.722763] bad stack ffffe8fffd620000
[   17.728865] CPU: 0 UID: 0 PID: 2156 Comm: test_progs Not tainted
6.12.0-rc1-00162-g3fe52dc7912d-dirty #6365
[   17.729826] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014

To make it less broken it requires a bunch of work in
arch/x86/kernel/dumpstack.c
I tried to hack things up, but wasn't successful.
Even if we do succeed eventually this is too risky.
We don't have a strong reason to introduce another stack type
along with all the delicate logic to recognize it based on rsp
value alone. If our percpu stack is per prog the get_stack_info()
logic gets complicated and that's not acceptable.
We need to scrap this idea.
Let's go back to push/pop r11 around calls :(

