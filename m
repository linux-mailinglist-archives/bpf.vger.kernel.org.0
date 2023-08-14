Return-Path: <bpf+bounces-7708-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FBF77B82F
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 14:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E96B1C20A9B
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 12:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1A7BE45;
	Mon, 14 Aug 2023 12:05:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35391AD47
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 12:05:54 +0000 (UTC)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAB418B;
	Mon, 14 Aug 2023 05:05:51 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b9d3dacb33so65409251fa.1;
        Mon, 14 Aug 2023 05:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692014749; x=1692619549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knsc5YPfC/WceC+DsUjbvgGYRviUK/I7sfDY7NcGB5A=;
        b=WwWIxRwAHv/a0iRDmjo/3dp5VuB05tDpEbkzuYLdUMdIOCfteHViVu+bhOzmoRMH6f
         4hVbkf7yYp/JIwseBC0mLoiucBXVC81IDrkVIaGm8lH14Yq6/O1eBhkYzTnlQJjh5mM4
         qwrNjr1CJ5ZE85tYorZbHoCL/hW/ukffIkNnysiZa2vsfKiC849h3t13f+rnohE7g+2Y
         OzZj8C2r/9xZ0wvN/1rSkzkvtcucVLgmdNc3FM4W5IuzpzrbK9iyHxugF8VLeqB33ezF
         Fs56QbfmsfA6T+6gzqL55dguJJ4b60EKoomvLScynmv0v6WbNKVCM/9F4b9qLfj6Ig5U
         3Tug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692014749; x=1692619549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=knsc5YPfC/WceC+DsUjbvgGYRviUK/I7sfDY7NcGB5A=;
        b=MG3k6DOVtBmFJIktszeO1KNrakfrMPmdaZhmxnQ6SemNYnz4AYrRQ6GrtQwDYlThkC
         gUbZC+PsgDuGFa4Bcc69F0vyd0n7lrZTozahdJqEEeT25DNYz/h9ooSAwVa4sjry4vF2
         UahwpJmbvMB8kxEJSzFDUQoXuEC0GXBhC6VzfGEca3HkJsekVGSPMtN9bcV2+nN5mOiB
         x83Sue4h9Zdm0OXIygsWxSohubJPcE4DmJ+PqaVlhM54PYJRnP0mu/Jr4tmsRID+NHA1
         bh9uwLYQDX4EW6yRpBXSvTV2+VYzfM6EHK8qEYpdvvP1tdtnjwOgl4KY2HvOr46u0yZy
         PioA==
X-Gm-Message-State: AOJu0Yw9+djls9lTefcNZ+hj9/1IXjWkNbldAhQmhGFaoA2Ajbse7Ka1
	hmGMD4pQprTtidnwbENiljfD42IaT4Aazo0sEsk=
X-Google-Smtp-Source: AGHT+IHz9aumXankCpXAo/3UXM/LwXJJTHNS19+6PgY3LYuTq919ToMMEIfuAhbiYscialRV7ogqypA1NMV+znHeLXo=
X-Received: by 2002:a2e:809a:0:b0:2b4:6f0c:4760 with SMTP id
 i26-20020a2e809a000000b002b46f0c4760mr6142397ljg.11.1692014749086; Mon, 14
 Aug 2023 05:05:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230720154941.1504-1-puranjay12@gmail.com> <87pm3qt2c8.fsf@all.your.base.are.belong.to.us>
 <87v8dhgb4u.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87v8dhgb4u.fsf@all.your.base.are.belong.to.us>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Mon, 14 Aug 2023 14:05:38 +0200
Message-ID: <CANk7y0jySJ6e+_e5SZDUJnqA=+doLVsOAX81ZoPF6nFBBzNGMQ@mail.gmail.com>
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

On Mon, Aug 14, 2023 at 12:40=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kerne=
l.org> wrote:
>
> Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:
>
> > Puranjay Mohan <puranjay12@gmail.com> writes:
> >
> >> BPF programs currently consume a page each on RISCV. For systems with =
many BPF
> >> programs, this adds significant pressure to instruction TLB. High iTLB=
 pressure
> >> usually causes slow down for the whole system.
> >>
> >> Song Liu introduced the BPF prog pack allocator[1] to mitigate the abo=
ve issue.
> >> It packs multiple BPF programs into a single huge page. It is currentl=
y only
> >> enabled for the x86_64 BPF JIT.
> >>
> >> I enabled this allocator on the ARM64 BPF JIT[2]. It is being reviewed=
 now.
> >>
> >> This patch series enables the BPF prog pack allocator for the RISCV BP=
F JIT.
> >> This series needs a patch[3] from the ARM64 series to work.
> >>
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> >> Performance Analysis of prog pack allocator on RISCV64
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> >>
> >> Test setup:
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> Host machine: Debian GNU/Linux 11 (bullseye)
> >> Qemu Version: QEMU emulator version 8.0.3 (Debian 1:8.0.3+dfsg-1)
> >> u-boot-qemu Version: 2023.07+dfsg-1
> >> opensbi Version: 1.3-1
> >>
> >> To test the performance of the BPF prog pack allocator on RV, a stress=
er
> >> tool[4] linked below was built. This tool loads 8 BPF programs on the =
system and
> >> triggers 5 of them in an infinite loop by doing system calls.
> >>
> >> The runner script starts 20 instances of the above which loads 8*20=3D=
160 BPF
> >> programs on the system, 5*20=3D100 of which are being constantly trigg=
ered.
> >> The script is passed a command which would be run in the above environ=
ment.
> >>
> >> The script was run with following perf command:
> >> ./run.sh "perf stat -a \
> >>         -e iTLB-load-misses \
> >>         -e dTLB-load-misses  \
> >>         -e dTLB-store-misses \
> >>         -e instructions \
> >>         --timeout 60000"
> >>
> >> The output of the above command is discussed below before and after en=
abling the
> >> BPF prog pack allocator.
> >>
> >> The tests were run on qemu-system-riscv64 with 8 cpus, 16G memory. The=
 rootfs
> >> was created using Bjorn's riscv-cross-builder[5] docker container link=
ed below.
> >>
> >> Results
> >> =3D=3D=3D=3D=3D=3D=3D
> >>
> >> Before enabling prog pack allocator:
> >> ------------------------------------
> >>
> >> Performance counter stats for 'system wide':
> >>
> >>            4939048      iTLB-load-misses
> >>            5468689      dTLB-load-misses
> >>             465234      dTLB-store-misses
> >>      1441082097998      instructions
> >>
> >>       60.045791200 seconds time elapsed
> >>
> >> After enabling prog pack allocator:
> >> -----------------------------------
> >>
> >> Performance counter stats for 'system wide':
> >>
> >>            3430035      iTLB-load-misses
> >>            5008745      dTLB-load-misses
> >>             409944      dTLB-store-misses
> >>      1441535637988      instructions
> >>
> >>       60.046296600 seconds time elapsed
> >>
> >> Improvements in metrics
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> It was expected that the iTLB-load-misses would decrease as now a sing=
le huge
> >> page is used to keep all the BPF programs compared to a single page fo=
r each
> >> program earlier.
> >>
> >> --------------------------------------------
> >> The improvement in iTLB-load-misses: -30.5 %
> >> --------------------------------------------
> >>
> >> I repeated this expriment more than 100 times in different setups and =
the
> >> improvement was always greater than 30%.
> >>
> >> This patch series is boot tested on the Starfive VisionFive 2 board[6]=
.
> >> The performance analysis was not done on the board because it doesn't
> >> expose iTLB-load-misses, etc. The stresser program was run on the boar=
d to test
> >> the loading and unloading of BPF programs
> >>
> >> [1] https://lore.kernel.org/bpf/20220204185742.271030-1-song@kernel.or=
g/
> >> [2] https://lore.kernel.org/all/20230626085811.3192402-1-puranjay12@gm=
ail.com/
> >> [3] https://lore.kernel.org/all/20230626085811.3192402-2-puranjay12@gm=
ail.com/
> >> [4] https://github.com/puranjaymohan/BPF-Allocator-Bench
> >> [5] https://github.com/bjoto/riscv-cross-builder
> >> [6] https://www.starfivetech.com/en/site/boards
> >>
> >> Puranjay Mohan (2):
> >>   riscv: Extend patch_text_nosync() for multiple pages
> >>   bpf, riscv: use prog pack allocator in the BPF JIT
> >
> > I get a hang for "test_tag", but it's not directly related to your
> > series, but rather "remote fence.i".
> >
> >   | rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> >   | rcu:      0-....: (1400 ticks this GP) idle=3Dd5e4/1/0x400000000000=
0000 softirq=3D5542/5542 fqs=3D1862
> >   | rcu:      (detected by 1, t=3D5252 jiffies, g=3D10253, q=3D195 ncpu=
s=3D4)
> >   | Task dump for CPU 0:
> >   | task:kworker/0:5     state:R  running task     stack:0     pid:319 =
  ppid:2      flags:0x00000008
> >   | Workqueue: events bpf_prog_free_deferred
> >   | Call Trace:
> >   | [<ffffffff80cbc444>] __schedule+0x2d0/0x940
> >   | watchdog: BUG: soft lockup - CPU#0 stuck for 21s! [kworker/0:5:319]
> >   | Modules linked in: nls_iso8859_1 drm fuse i2c_core drm_panel_orient=
ation_quirks backlight dm_mod configfs ip_tables x_tables
> >   | CPU: 0 PID: 319 Comm: kworker/0:5 Not tainted 6.5.0-rc5 #1
> >   | Hardware name: riscv-virtio,qemu (DT)
> >   | Workqueue: events bpf_prog_free_deferred
> >   | epc : __sbi_rfence_v02_call.isra.0+0x74/0x11a
> >   |  ra : __sbi_rfence_v02+0xda/0x1a4
> >   | epc : ffffffff8000ab4c ra : ffffffff8000accc sp : ff20000001c9bbd0
> >   |  gp : ffffffff82078c48 tp : ff600000888e6a40 t0 : ff20000001c9bd44
> >   |  t1 : 0000000000000000 t2 : 0000000000000040 s0 : ff20000001c9bbf0
> >   |  s1 : 0000000000000010 a0 : 0000000000000000 a1 : 0000000000000000
> >   |  a2 : 0000000000000000 a3 : 0000000000000000 a4 : 0000000000000000
> >   |  a5 : 0000000000000000 a6 : 0000000000000000 a7 : 0000000052464e43
> >   |  s2 : 000000000000ffff s3 : 00000000ffffffff s4 : ffffffff81667528
> >   |  s5 : 0000000000000000 s6 : 0000000000000000 s7 : 0000000000000000
> >   |  s8 : 0000000000000001 s9 : 0000000000000003 s10: 0000000000000040
> >   |  s11: ffffffff8207d240 t3 : 000000000000000f t4 : 000000000000002a
> >   |  t5 : ff600000872df140 t6 : ffffffff81e26828
> >   | status: 0000000200000120 badaddr: 0000000000000000 cause: 800000000=
0000005
> >   | [<ffffffff8000ab4c>] __sbi_rfence_v02_call.isra.0+0x74/0x11a
> >   | [<ffffffff8000accc>] __sbi_rfence_v02+0xda/0x1a4
> >   | [<ffffffff8000a886>] sbi_remote_fence_i+0x1e/0x26
> >   | [<ffffffff8000cee2>] flush_icache_all+0x1a/0x48
> >   | [<ffffffff80007736>] patch_text_nosync+0x6c/0x8c
> >   | [<ffffffff8000f0f8>] bpf_arch_text_invalidate+0x62/0xac
> >   | [<ffffffff8016c538>] bpf_prog_pack_free+0x9c/0x1b2
> >   | [<ffffffff8016c84a>] bpf_jit_binary_pack_free+0x20/0x4a
> >   | [<ffffffff8000f198>] bpf_jit_free+0x56/0x9e
> >   | [<ffffffff8016b43a>] bpf_prog_free_deferred+0x15a/0x182
> >   | [<ffffffff800576c4>] process_one_work+0x1b6/0x3d6
> >   | [<ffffffff80057d52>] worker_thread+0x84/0x378
> >   | [<ffffffff8005fc2c>] kthread+0xe8/0x108
> >   | [<ffffffff80003ffa>] ret_from_fork+0xe/0x20
> >
> > I'm digging into that now, and I would appreciate if you could run the
> > test_tag on VF2 or similar (I'm missing that HW).
> >
> > It seems like we're hitting a bug with this series, so let's try to
> > figure out where the problems is, prior merging it.
>
> Hmm, it looks like the bpf_arch_text_invalidate() implementation is a
> bit problematic:
>
> +int bpf_arch_text_invalidate(void *dst, size_t len)
> +{
> +       __le32 *ptr;
> +       int ret =3D 0;
> +       u32 inval =3D 0;
> +
> +       for (ptr =3D dst; ret =3D=3D 0 && len >=3D sizeof(u32); len -=3D =
sizeof(u32)) {
> +               mutex_lock(&text_mutex);
> +               ret =3D patch_text_nosync(ptr++, &inval, sizeof(u32));
> +               mutex_unlock(&text_mutex);
> +       }
> +
> +       return ret;
> +}
>
> Each patch_text_nosync() is a remote fence.i, and for a big "len", we'll
> be flooded with remote fences.

I understand this now, thanks for debugging this.

We are calling patch_text_nosync() for each word (u32) which calls
flush_icache_range() and therefore "fence.i" is inserted after every word.

I still don't fully understand how it causes this bug because I lack
the prerequisite
knowledge about test_tag and what the failing test is doing.

But to solve this issue we would need a function like the x86
text_poke_set() that will only
insert a single "fence.i" after setting the whole memory area. This
can be done by
implementing a wrapper around patch_insn_write() which would set the memory=
 area
and at the end call flush_icache_range().

Something like:

void *text_set_nosync(void *dst, int c, size_t len)
{
        __le32 *ptr;
        int ret =3D 0;

        for (ptr =3D dst; ret =3D=3D 0 && len >=3D sizeof(u32); len -=3D si=
zeof(u32)) {
                ret =3D patch_insn_write(ptr++, &c, sizeof(u32));
        }
        if(!ret)
                flush_icache_range((uintptr_t) dst, (uintptr_t) dst + len);

        return ret;
}

Let me know if this looks correct or we need more details here.
I will then send v2 with this implemented as a separate patch.

>
> I think that's exactly what we hit with "test_tag".
>
>
> Bj=C3=B6rn

Thanks,
Puranjay

