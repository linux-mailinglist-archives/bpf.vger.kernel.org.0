Return-Path: <bpf+bounces-7728-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B50C77BD34
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 17:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D446428115A
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 15:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4BCC2E4;
	Mon, 14 Aug 2023 15:38:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86205C2C9
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 15:38:16 +0000 (UTC)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489A810D0;
	Mon, 14 Aug 2023 08:38:14 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so65432951fa.2;
        Mon, 14 Aug 2023 08:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692027492; x=1692632292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kkMzisnskl9lYIKbrIom0Ycqpgo+oJzAmdjODS/rpSo=;
        b=GMO7GC3SdoiVqVzLVtSS6DcX0wysRBFo7uof+/Th5OmTkveR3WFiZBfiuHoL4WhJAW
         /SSdUOcWFLa60INBg2CerhJAUyc53au9bQqzBr4AAoMQ+7rjiJtMcQnRMOJAzQcOTIQw
         EB2Xjp0GpJ4UDmUxUlkEijnMVVHawAEzSxqicBBsaRr3NXaD2yMEZcLQ/TNM6r1ahEv3
         1QtYe7T9gESNvMwOxHDvM5sHhtV52qHf4sPNKYuWOYPWNlkvAqTyR506OcMCpVx6ftka
         9W6/P/tvNNNO5wgKbM6imdaKZ+IcGYBooh10WvviSgUNqkwB5O533zye9dpK6m2BME9c
         Lsxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692027492; x=1692632292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kkMzisnskl9lYIKbrIom0Ycqpgo+oJzAmdjODS/rpSo=;
        b=k+2v+gTKH/jY9foVn/vJV0h4lDcpLyzCiVxre11sgAVvbNuJDzsnZz2YW66GXkOTqO
         ULtn/R7aBso9+0jMcvicG8/ZIw9kgcIyMIzkuJzlz0o6uc7n/Zy02gYUPP4ceLDypVfQ
         PrLYNJ6WNZyweaiKnGDZsAhvsv6XHD8oK2/3Qrzrl7d2yFP9ifZCHLdViFbLZUqxH2Sb
         PJ1KTDUzB5/ki0B5LZJ3Db2unNiQJMRvQu0UCWzEYg8jgDNRHhrwFeqWSOJVd8EUrF5Z
         WGy4uGECzwVR4BD0YdN+lmcmD6MILJdkjlWYmo6tGQ7SM/VldqvszbqdJ9xSlNT7Ms1M
         VXaA==
X-Gm-Message-State: AOJu0Yxh1d2dkH0gmb6rLqG5uvfZ0RiLm0iLyV8ST1JaWkdrPoV8SU9H
	w1UPsB9HS9WdJJoxKKTeZ3/FhxBeTte1KoKWTBI=
X-Google-Smtp-Source: AGHT+IGHIeq4Zqkkwrm/zK/+rHmnpUEKi71prlasSG/7YNlewAf0VEc6L+gQfFZdseFq/j6cq9v154tSzlS4DwVhlYg=
X-Received: by 2002:a2e:8e85:0:b0:2b4:65ef:3af5 with SMTP id
 z5-20020a2e8e85000000b002b465ef3af5mr7508544ljk.30.1692027491879; Mon, 14 Aug
 2023 08:38:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230720154941.1504-1-puranjay12@gmail.com> <87pm3qt2c8.fsf@all.your.base.are.belong.to.us>
 <87v8dhgb4u.fsf@all.your.base.are.belong.to.us> <CANk7y0jySJ6e+_e5SZDUJnqA=+doLVsOAX81ZoPF6nFBBzNGMQ@mail.gmail.com>
 <87zg2telzb.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87zg2telzb.fsf@all.your.base.are.belong.to.us>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Mon, 14 Aug 2023 17:38:00 +0200
Message-ID: <CANk7y0iLccTsuPEazPsxaqfB0js3Okr2mhi0ErpczmYW++7JWg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/2] bpf, riscv: use BPF prog pack allocator in
 BPF JIT
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	pulehui@huawei.com, conor.dooley@microchip.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yhs@fb.com, kpsingh@kernel.org, bpf@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Bj=C3=B6rn,

On Mon, Aug 14, 2023 at 4:29=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
.org> wrote:
>
> Puranjay Mohan <puranjay12@gmail.com> writes:
>
> > On Mon, Aug 14, 2023 at 12:40=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@k=
ernel.org> wrote:
> >>
> >> Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:
> >>
> >> > Puranjay Mohan <puranjay12@gmail.com> writes:
> >> >
> >> >> BPF programs currently consume a page each on RISCV. For systems wi=
th many BPF
> >> >> programs, this adds significant pressure to instruction TLB. High i=
TLB pressure
> >> >> usually causes slow down for the whole system.
> >> >>
> >> >> Song Liu introduced the BPF prog pack allocator[1] to mitigate the =
above issue.
> >> >> It packs multiple BPF programs into a single huge page. It is curre=
ntly only
> >> >> enabled for the x86_64 BPF JIT.
> >> >>
> >> >> I enabled this allocator on the ARM64 BPF JIT[2]. It is being revie=
wed now.
> >> >>
> >> >> This patch series enables the BPF prog pack allocator for the RISCV=
 BPF JIT.
> >> >> This series needs a patch[3] from the ARM64 series to work.
> >> >>
> >> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> >> >> Performance Analysis of prog pack allocator on RISCV64
> >> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> >> >>
> >> >> Test setup:
> >> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> >>
> >> >> Host machine: Debian GNU/Linux 11 (bullseye)
> >> >> Qemu Version: QEMU emulator version 8.0.3 (Debian 1:8.0.3+dfsg-1)
> >> >> u-boot-qemu Version: 2023.07+dfsg-1
> >> >> opensbi Version: 1.3-1
> >> >>
> >> >> To test the performance of the BPF prog pack allocator on RV, a str=
esser
> >> >> tool[4] linked below was built. This tool loads 8 BPF programs on t=
he system and
> >> >> triggers 5 of them in an infinite loop by doing system calls.
> >> >>
> >> >> The runner script starts 20 instances of the above which loads 8*20=
=3D160 BPF
> >> >> programs on the system, 5*20=3D100 of which are being constantly tr=
iggered.
> >> >> The script is passed a command which would be run in the above envi=
ronment.
> >> >>
> >> >> The script was run with following perf command:
> >> >> ./run.sh "perf stat -a \
> >> >>         -e iTLB-load-misses \
> >> >>         -e dTLB-load-misses  \
> >> >>         -e dTLB-store-misses \
> >> >>         -e instructions \
> >> >>         --timeout 60000"
> >> >>
> >> >> The output of the above command is discussed below before and after=
 enabling the
> >> >> BPF prog pack allocator.
> >> >>
> >> >> The tests were run on qemu-system-riscv64 with 8 cpus, 16G memory. =
The rootfs
> >> >> was created using Bjorn's riscv-cross-builder[5] docker container l=
inked below.
> >> >>
> >> >> Results
> >> >> =3D=3D=3D=3D=3D=3D=3D
> >> >>
> >> >> Before enabling prog pack allocator:
> >> >> ------------------------------------
> >> >>
> >> >> Performance counter stats for 'system wide':
> >> >>
> >> >>            4939048      iTLB-load-misses
> >> >>            5468689      dTLB-load-misses
> >> >>             465234      dTLB-store-misses
> >> >>      1441082097998      instructions
> >> >>
> >> >>       60.045791200 seconds time elapsed
> >> >>
> >> >> After enabling prog pack allocator:
> >> >> -----------------------------------
> >> >>
> >> >> Performance counter stats for 'system wide':
> >> >>
> >> >>            3430035      iTLB-load-misses
> >> >>            5008745      dTLB-load-misses
> >> >>             409944      dTLB-store-misses
> >> >>      1441535637988      instructions
> >> >>
> >> >>       60.046296600 seconds time elapsed
> >> >>
> >> >> Improvements in metrics
> >> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> >> >>
> >> >> It was expected that the iTLB-load-misses would decrease as now a s=
ingle huge
> >> >> page is used to keep all the BPF programs compared to a single page=
 for each
> >> >> program earlier.
> >> >>
> >> >> --------------------------------------------
> >> >> The improvement in iTLB-load-misses: -30.5 %
> >> >> --------------------------------------------
> >> >>
> >> >> I repeated this expriment more than 100 times in different setups a=
nd the
> >> >> improvement was always greater than 30%.
> >> >>
> >> >> This patch series is boot tested on the Starfive VisionFive 2 board=
[6].
> >> >> The performance analysis was not done on the board because it doesn=
't
> >> >> expose iTLB-load-misses, etc. The stresser program was run on the b=
oard to test
> >> >> the loading and unloading of BPF programs
> >> >>
> >> >> [1] https://lore.kernel.org/bpf/20220204185742.271030-1-song@kernel=
.org/
> >> >> [2] https://lore.kernel.org/all/20230626085811.3192402-1-puranjay12=
@gmail.com/
> >> >> [3] https://lore.kernel.org/all/20230626085811.3192402-2-puranjay12=
@gmail.com/
> >> >> [4] https://github.com/puranjaymohan/BPF-Allocator-Bench
> >> >> [5] https://github.com/bjoto/riscv-cross-builder
> >> >> [6] https://www.starfivetech.com/en/site/boards
> >> >>
> >> >> Puranjay Mohan (2):
> >> >>   riscv: Extend patch_text_nosync() for multiple pages
> >> >>   bpf, riscv: use prog pack allocator in the BPF JIT
> >> >
> >> > I get a hang for "test_tag", but it's not directly related to your
> >> > series, but rather "remote fence.i".
> >> >
> >> >   | rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> >> >   | rcu:      0-....: (1400 ticks this GP) idle=3Dd5e4/1/0x400000000=
0000000 softirq=3D5542/5542 fqs=3D1862
> >> >   | rcu:      (detected by 1, t=3D5252 jiffies, g=3D10253, q=3D195 n=
cpus=3D4)
> >> >   | Task dump for CPU 0:
> >> >   | task:kworker/0:5     state:R  running task     stack:0     pid:3=
19   ppid:2      flags:0x00000008
> >> >   | Workqueue: events bpf_prog_free_deferred
> >> >   | Call Trace:
> >> >   | [<ffffffff80cbc444>] __schedule+0x2d0/0x940
> >> >   | watchdog: BUG: soft lockup - CPU#0 stuck for 21s! [kworker/0:5:3=
19]
> >> >   | Modules linked in: nls_iso8859_1 drm fuse i2c_core drm_panel_ori=
entation_quirks backlight dm_mod configfs ip_tables x_tables
> >> >   | CPU: 0 PID: 319 Comm: kworker/0:5 Not tainted 6.5.0-rc5 #1
> >> >   | Hardware name: riscv-virtio,qemu (DT)
> >> >   | Workqueue: events bpf_prog_free_deferred
> >> >   | epc : __sbi_rfence_v02_call.isra.0+0x74/0x11a
> >> >   |  ra : __sbi_rfence_v02+0xda/0x1a4
> >> >   | epc : ffffffff8000ab4c ra : ffffffff8000accc sp : ff20000001c9bb=
d0
> >> >   |  gp : ffffffff82078c48 tp : ff600000888e6a40 t0 : ff20000001c9bd=
44
> >> >   |  t1 : 0000000000000000 t2 : 0000000000000040 s0 : ff20000001c9bb=
f0
> >> >   |  s1 : 0000000000000010 a0 : 0000000000000000 a1 : 00000000000000=
00
> >> >   |  a2 : 0000000000000000 a3 : 0000000000000000 a4 : 00000000000000=
00
> >> >   |  a5 : 0000000000000000 a6 : 0000000000000000 a7 : 0000000052464e=
43
> >> >   |  s2 : 000000000000ffff s3 : 00000000ffffffff s4 : ffffffff816675=
28
> >> >   |  s5 : 0000000000000000 s6 : 0000000000000000 s7 : 00000000000000=
00
> >> >   |  s8 : 0000000000000001 s9 : 0000000000000003 s10: 00000000000000=
40
> >> >   |  s11: ffffffff8207d240 t3 : 000000000000000f t4 : 00000000000000=
2a
> >> >   |  t5 : ff600000872df140 t6 : ffffffff81e26828
> >> >   | status: 0000000200000120 badaddr: 0000000000000000 cause: 800000=
0000000005
> >> >   | [<ffffffff8000ab4c>] __sbi_rfence_v02_call.isra.0+0x74/0x11a
> >> >   | [<ffffffff8000accc>] __sbi_rfence_v02+0xda/0x1a4
> >> >   | [<ffffffff8000a886>] sbi_remote_fence_i+0x1e/0x26
> >> >   | [<ffffffff8000cee2>] flush_icache_all+0x1a/0x48
> >> >   | [<ffffffff80007736>] patch_text_nosync+0x6c/0x8c
> >> >   | [<ffffffff8000f0f8>] bpf_arch_text_invalidate+0x62/0xac
> >> >   | [<ffffffff8016c538>] bpf_prog_pack_free+0x9c/0x1b2
> >> >   | [<ffffffff8016c84a>] bpf_jit_binary_pack_free+0x20/0x4a
> >> >   | [<ffffffff8000f198>] bpf_jit_free+0x56/0x9e
> >> >   | [<ffffffff8016b43a>] bpf_prog_free_deferred+0x15a/0x182
> >> >   | [<ffffffff800576c4>] process_one_work+0x1b6/0x3d6
> >> >   | [<ffffffff80057d52>] worker_thread+0x84/0x378
> >> >   | [<ffffffff8005fc2c>] kthread+0xe8/0x108
> >> >   | [<ffffffff80003ffa>] ret_from_fork+0xe/0x20
> >> >
> >> > I'm digging into that now, and I would appreciate if you could run t=
he
> >> > test_tag on VF2 or similar (I'm missing that HW).
> >> >
> >> > It seems like we're hitting a bug with this series, so let's try to
> >> > figure out where the problems is, prior merging it.
> >>
> >> Hmm, it looks like the bpf_arch_text_invalidate() implementation is a
> >> bit problematic:
> >>
> >> +int bpf_arch_text_invalidate(void *dst, size_t len)
> >> +{
> >> +       __le32 *ptr;
> >> +       int ret =3D 0;
> >> +       u32 inval =3D 0;
> >> +
> >> +       for (ptr =3D dst; ret =3D=3D 0 && len >=3D sizeof(u32); len -=
=3D sizeof(u32)) {
> >> +               mutex_lock(&text_mutex);
> >> +               ret =3D patch_text_nosync(ptr++, &inval, sizeof(u32));
> >> +               mutex_unlock(&text_mutex);
> >> +       }
> >> +
> >> +       return ret;
> >> +}
> >>
> >> Each patch_text_nosync() is a remote fence.i, and for a big "len", we'=
ll
> >> be flooded with remote fences.
> >
> > I understand this now, thanks for debugging this.
> >
> > We are calling patch_text_nosync() for each word (u32) which calls
> > flush_icache_range() and therefore "fence.i" is inserted after every
> > word.
>
> But more importantly, it does a remote fence.i (which is an IPI to all
> cores).
>
> > I still don't fully understand how it causes this bug because I lack
> > the prerequisite
> > knowledge about test_tag and what the failing test is doing.
>
> The test_tag is part of kselftest/bpf:
> tools/testing/selftests/bpf/test_tag.c
>
> TL;DR: it generates a bunch of programs, where some have a length of,
> e.g, 41024. bpf_arch_text_invalidate() does ~10k of remote fences in
> that case.
>
> > But to solve this issue we would need a function like the x86
> > text_poke_set() that will only
> > insert a single "fence.i" after setting the whole memory area. This
> > can be done by
> > implementing a wrapper around patch_insn_write() which would set the me=
mory area
> > and at the end call flush_icache_range().
> >
> > Something like:
> >
> > void *text_set_nosync(void *dst, int c, size_t len)
> > {
> >         __le32 *ptr;
> >         int ret =3D 0;
> >
> >         for (ptr =3D dst; ret =3D=3D 0 && len >=3D sizeof(u32); len -=
=3D sizeof(u32)) {
> >                 ret =3D patch_insn_write(ptr++, &c, sizeof(u32));
> >         }
> >         if(!ret)
> >                 flush_icache_range((uintptr_t) dst, (uintptr_t) dst + l=
en);
> >
> >         return ret;
> > }
> >
> > Let me know if this looks correct or we need more details here.
> > I will then send v2 with this implemented as a separate patch.
>
> Can't we do better here? Perhaps a similar pattern like the 2 page fill?
> Otherwise we'll have a bunch of fixmap updates as well.

I agree that we can make it more efficient by first copying the value to a
RW buffer using normal memcpy() and then copying that area to the RO area
using patch_insn_write(). Then it would solve both problems. Or we implemen=
t
a new function like patch_insn_write() that does the 2 page map and
set explicitly.

Which approach would you prefer?
1) Wrapper around patch_insn_write() that first memsets a RW buffer and the=
n
copies the complete RW buffer to the RO area by calling
patch_insn_write() with len.

2) A new function like patch_insn_write() that takes dst, src, len and
maps the dst, 2 pages
at a time and sets it to *src in a loop.

>
> I'd keep the patch_ prefix in the name for consistency. Please measure
> the runtime of test_tag pre/after the change.

test_tag currently wouldn't even complete right? with the current
version of the patch?

>
> I don't know if your arm64 work has similar problems?

Thanks for bringing this up. I will revisit that and verify if
test_tag is working
there. There also the bpf_arch_text_invalidate() is calling
aarch64_insn_patch_text_nosync()
in a loop that in turn calls caches_clean_inval_pou(). So I might see
similar issues there.
I think https://github.com/kernel-patches doesn't run test_tag hence I
might have missed it.

>
>
> Bj=C3=B6rn

Thanks,
Puranjay

