Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C876E3B7630
	for <lists+bpf@lfdr.de>; Tue, 29 Jun 2021 18:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbhF2QIT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Jun 2021 12:08:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32670 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234010AbhF2QGh (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 29 Jun 2021 12:06:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624982649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RvB+9cLmPhrHEpOWinUSns1Le4MAeBRLdIig0ysrJL4=;
        b=BLAcHchyaSQqY+PZFFdIN1BJXMVIs89MlSmQT3dSreoKhPndXXGz7Q2F2oCOWevGlr+LFi
        E4eEFZCQrGoEmFGpMfU8nAAfzL9McMaMouBtvFNjfn2KiaR26gfh/EpDSCE3srtNQnLBAn
        PGE8xykV9vSeXRaM1X9AmCJ6DyiuUnU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-7EBwcBciOneadkrtsCx2pQ-1; Tue, 29 Jun 2021 12:04:08 -0400
X-MC-Unique: 7EBwcBciOneadkrtsCx2pQ-1
Received: by mail-wm1-f72.google.com with SMTP id k16-20020a7bc3100000b02901d849b41038so1466444wmj.7
        for <bpf@vger.kernel.org>; Tue, 29 Jun 2021 09:04:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RvB+9cLmPhrHEpOWinUSns1Le4MAeBRLdIig0ysrJL4=;
        b=Fwd4Pw6/cHxqD5zZ08lBtTZmCbslC0VeRaTuZDHZ04qG6x8jTgB0ieYKkBCAf+IZR7
         0R1XdzLmtl9fdocgaqyJNK5IoK/JeBW86T6hEy+m6dFdgu35wz5AveQfOopU15zyPeac
         Clfz7f15ANCRgkJOaMdBsCeUEwZSO9bCuzEduhROB5GE1hamPKsQlSYXWqndleSamyET
         v6s3pqIpl7MrAUc4z9BRp5krfh/wcMJ/e4Y0A7Ld3a58cg4g2Q/Hlp62xPHkCXUfoXan
         +YCxM1wysB84KyFEqpUaroEF+Z28lF1YjdAB3uESwJK/NYyuaOIPa38titrFuJQSGH2A
         dyzg==
X-Gm-Message-State: AOAM531AGK9fxfL4/kqDUGSjlwKz1F9bxGHeyJajZ7ymozgR89b5GkLU
        8qB8PpvGbG6/1aUO8AVQNC1t5C4AR5RzlQIY95fgaDedmQHiSazkEjND2Jq+oc1oFyYr+6rjZqP
        q3hcDultkDJ+D
X-Received: by 2002:a05:6000:12c8:: with SMTP id l8mr34682302wrx.236.1624982647149;
        Tue, 29 Jun 2021 09:04:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzEioWF2HDmLDesWZK7FTaqqpnOwEU7X32JeZtf+U0xYViqMKa6gwDy3CTUQVk+erWTvrCu/g==
X-Received: by 2002:a05:6000:12c8:: with SMTP id l8mr34682268wrx.236.1624982646864;
        Tue, 29 Jun 2021 09:04:06 -0700 (PDT)
Received: from krava ([5.171.247.102])
        by smtp.gmail.com with ESMTPSA id 16sm5498684wmk.18.2021.06.29.09.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 09:04:06 -0700 (PDT)
Date:   Tue, 29 Jun 2021 18:04:02 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Brendan Jackman <jackmanb@google.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        John Fastabend <john.fastabend@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Sandipan Das <sandipan@linux.ibm.com>
Subject: Re: [BUG soft lockup] Re: [PATCH bpf-next v3] bpf: Propagate stack
 bounds to registers in atomics w/ BPF_FETCH
Message-ID: <YNtEcjYvSvk8uknO@krava>
References: <20210202135002.4024825-1-jackmanb@google.com>
 <YNiadhIbJBBPeOr6@krava>
 <CA+i-1C0DAr5ecAOV06_fqeCooic4AF=71ur63HJ6ddbj9ceDpQ@mail.gmail.com>
 <YNspwB8ejUeRIVxt@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNspwB8ejUeRIVxt@krava>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 29, 2021 at 04:10:12PM +0200, Jiri Olsa wrote:
> On Mon, Jun 28, 2021 at 11:21:42AM +0200, Brendan Jackman wrote:
> > On Sun, 27 Jun 2021 at 17:34, Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > On Tue, Feb 02, 2021 at 01:50:02PM +0000, Brendan Jackman wrote:
> > >
> > > SNIP
> > >
> > > > diff --git a/tools/testing/selftests/bpf/verifier/atomic_bounds.c b/tools/testing/selftests/bpf/verifier/atomic_bounds.c
> > > > new file mode 100644
> > > > index 000000000000..e82183e4914f
> > > > --- /dev/null
> > > > +++ b/tools/testing/selftests/bpf/verifier/atomic_bounds.c
> > > > @@ -0,0 +1,27 @@
> > > > +{
> > > > +     "BPF_ATOMIC bounds propagation, mem->reg",
> > > > +     .insns = {
> > > > +             /* a = 0; */
> > > > +             /*
> > > > +              * Note this is implemented with two separate instructions,
> > > > +              * where you might think one would suffice:
> > > > +              *
> > > > +              * BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
> > > > +              *
> > > > +              * This is because BPF_ST_MEM doesn't seem to set the stack slot
> > > > +              * type to 0 when storing an immediate.
> > > > +              */
> > > > +             BPF_MOV64_IMM(BPF_REG_0, 0),
> > > > +             BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -8),
> > > > +             /* b = atomic_fetch_add(&a, 1); */
> > > > +             BPF_MOV64_IMM(BPF_REG_1, 1),
> > > > +             BPF_ATOMIC_OP(BPF_DW, BPF_ADD | BPF_FETCH, BPF_REG_10, BPF_REG_1, -8),
> > > > +             /* Verifier should be able to tell that this infinite loop isn't reachable. */
> > > > +             /* if (b) while (true) continue; */
> > > > +             BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, -1),
> > > > +             BPF_EXIT_INSN(),
> > > > +     },
> > > > +     .result = ACCEPT,
> > > > +     .result_unpriv = REJECT,
> > > > +     .errstr_unpriv = "back-edge",
> > > > +},
> > > >
> > > > base-commit: 61ca36c8c4eb3bae35a285b1ae18c514cde65439
> > > > --
> > > > 2.30.0.365.g02bc693789-goog
> > > >
> > >
> > > hi,
> > > I tracked soft lock up on powerpc to this test:
> > >
> > >         [root@ibm-p9z-07-lp1 bpf]# ./test_verifier 25
> > >         #25/u BPF_ATOMIC bounds propagation, mem->reg SKIP
> > >         #25/p BPF_ATOMIC bounds propagation, mem->reg
> > >
> > >         Message from syslogd@ibm-p9z-07-lp1 at Jun 27 11:24:34 ...
> > >          kernel:watchdog: BUG: soft lockup - CPU#2 stuck for 26s! [test_verifier:1055]
> > >
> > >         Message from syslogd@ibm-p9z-07-lp1 at Jun 27 11:25:04 ...
> > >          kernel:watchdog: BUG: soft lockup - CPU#2 stuck for 48s! [test_verifier:1055]
> > >
> > > please check the console output below.. it looks like the verifier
> > > allowed the loop to happen for some reason on powerpc.. any idea?
> > >
> > > I'm on latest bpf-next/master, I can send the config if needed
> > >
> > > thanks,
> > > jirka
> > >
> > >
> > > ---
> > > ibm-p9z-07-lp1 login: [  184.108655] watchdog: BUG: soft lockup - CPU#2 stuck for 26s! [test_verifier:1055]
> > > [  184.108679] Modules linked in: snd_seq_dummy(E) snd_hrtimer(E) snd_seq(E) snd_seq_device(E) snd_timer(E) snd(E) soundcore(E) bonding(E) tls(E) rfkill(E) pseries_rng(E) drm(E) fuse(E) drm_panel_orientation_quirks(E) xfs(E) libcrc32c(E) sd_mod(E) t10_pi(E) ibmvscsi(E) ibmveth(E) scsi_transport_srp(E) vmx_crypto(E) dm_mirror(E) dm_region_hash(E) dm_log(E) dm_mod(E)
> > > [  184.108722] CPU: 2 PID: 1055 Comm: test_verifier Tainted: G            E     5.13.0-rc3+ #3
> > > [  184.108728] NIP:  c00800000131314c LR: c000000000c56918 CTR: c008000001313118
> > > [  184.108733] REGS: c0000000119ef820 TRAP: 0900   Tainted: G            E      (5.13.0-rc3+)
> > > [  184.108739] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 44222840  XER: 20040003
> > > [  184.108752] CFAR: c008000001313150 IRQMASK: 0
> > > [  184.108752] GPR00: c000000000c5671c c0000000119efac0 c000000002a08400 0000000000000001
> > > [  184.108752] GPR04: c0080000010c0048 ffffffffffffffff 0000000001f3f8ec 0000000000000008
> > > [  184.108752] GPR08: 0000000000000000 c0000000119efae8 0000000000000001 49adb8fcb8417937
> > > [  184.108752] GPR12: c008000001313118 c00000001ecae400 0000000000000000 0000000000000000
> > > [  184.108752] GPR16: 0000000000000000 0000000000000000 0000000000000000 c0000000021cf6f8
> > > [  184.108752] GPR20: 0000000000000000 c0000000119efc34 c0000000119efc30 c0080000010c0048
> > > [  184.108752] GPR24: c00000000a1dc100 0000000000000001 c000000011fadc80 c0000000021cf638
> > > [  184.108752] GPR28: c0080000010c0000 0000000000000001 c0000000021cf638 c0000000119efaf0
> > > [  184.108812] NIP [c00800000131314c] bpf_prog_a2eb9104e5e8a5bf+0x34/0xcee8
> > > [  184.108819] LR [c000000000c56918] bpf_test_run+0x2f8/0x470
> > > [  184.108826] Call Trace:
> > > [  184.108828] [c0000000119efac0] [c0000000119efb30] 0xc0000000119efb30 (unreliable)
> > > [  184.108835] [c0000000119efb30] [c000000000c5671c] bpf_test_run+0xfc/0x470
> > > [  184.108841] [c0000000119efc10] [c000000000c57b6c] bpf_prog_test_run_skb+0x38c/0x660
> > > [  184.108848] [c0000000119efcb0] [c00000000035de6c] __sys_bpf+0x46c/0xd60
> > > [  184.108854] [c0000000119efd90] [c00000000035e810] sys_bpf+0x30/0x40
> > > [  184.108859] [c0000000119efdb0] [c00000000002ea34] system_call_exception+0x144/0x280
> > > [  184.108866] [c0000000119efe10] [c00000000000c570] system_call_vectored_common+0xf0/0x268
> > > [  184.108874] --- interrupt: 3000 at 0x7fff8bb3ef24
> > > [  184.108878] NIP:  00007fff8bb3ef24 LR: 0000000000000000 CTR: 0000000000000000
> > > [  184.108883] REGS: c0000000119efe80 TRAP: 3000   Tainted: G            E      (5.13.0-rc3+)
> > > [  184.108887] MSR:  800000000280f033 <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 28000848  XER: 00000000
> > > [  184.108903] IRQMASK: 0
> > > [  184.108903] GPR00: 0000000000000169 00007fffe4577710 00007fff8bc27200 000000000000000a
> > > [  184.108903] GPR04: 00007fffe45777b8 0000000000000080 0000000000000001 0000000000000008
> > > [  184.108903] GPR08: 000000000000000a 0000000000000000 0000000000000000 0000000000000000
> > > [  184.108903] GPR12: 0000000000000000 00007fff8be1c400 0000000000000000 0000000000000000
> > > [  184.108903] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> > > [  184.108903] GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> > > [  184.108903] GPR24: 0000000000000000 0000000000000000 0000000000000000 000000001000d1d0
> > > [  184.108903] GPR28: 0000000000000002 00007fffe4578128 00007fffe45782c0 00007fffe4577710
> > > [  184.108960] NIP [00007fff8bb3ef24] 0x7fff8bb3ef24
> > > [  184.108964] LR [0000000000000000] 0x0
> > > [  184.108967] --- interrupt: 3000
> > > [  184.108970] Instruction dump:
> > > [  184.108974] 60000000 f821ff91 fbe10068 3be10030 39000000 f91ffff8 38600001 393ffff8
> > > [  184.108985] 7d4048a8 7d4a1a14 7d4049ad 4082fff4 <28230000> 4082fffc 60000000 ebe10068
> > 
> > Hmm, is the test prog from atomic_bounds.c getting JITed there (my
> > dumb guess at what '0xc0000000119efb30 (unreliable)' means)? That
> > shouldn't happen - should get 'eBPF filter atomic op code %02x (@%d)
> > unsupported\n' in dmesg instead. I wonder if I missed something in
> > commit 91c960b0056 (bpf: Rename BPF_XADD and prepare to encode other

I see that for all the other atomics tests:

[root@ibm-p9z-07-lp1 bpf]# ./test_verifier 21
#21/p BPF_ATOMIC_AND without fetch FAIL
Failed to load prog 'Unknown error 524'!
verification time 32 usec
stack depth 8
processed 10 insns (limit 1000000) max_states_per_insn 0 total_states 1 peak_states 1 mark_read 1
Summary: 0 PASSED, 0 SKIPPED, 2 FAILED

console:

	[   51.850952] eBPF filter atomic op code db (@2) unsupported
	[   51.851134] eBPF filter atomic op code db (@2) unsupported


[root@ibm-p9z-07-lp1 bpf]# ./test_verifier 22
#22/u BPF_ATOMIC_AND with fetch FAIL
Failed to load prog 'Unknown error 524'!
verification time 38 usec
stack depth 8
processed 14 insns (limit 1000000) max_states_per_insn 0 total_states 1 peak_states 1 mark_read 1
#22/p BPF_ATOMIC_AND with fetch FAIL
Failed to load prog 'Unknown error 524'!
verification time 26 usec
stack depth 8
processed 14 insns (limit 1000000) max_states_per_insn 0 total_states 1 peak_states 1 mark_read 1

console:
	[  223.231420] eBPF filter atomic op code db (@3) unsupported
	[  223.231596] eBPF filter atomic op code db (@3) unsupported

...


but no such console output for:

[root@ibm-p9z-07-lp1 bpf]# ./test_verifier 24
#24/u BPF_ATOMIC bounds propagation, mem->reg OK


> > atomics in .imm). Any idea if this test was ever passing on PowerPC?
> > 
> 
> hum, I guess not.. will check

nope, it locks up the same:

ibm-p9z-07-lp1 login: [   88.070644] watchdog: BUG: soft lockup - CPU#4 stuck for 22s! [test_verifier:950]
[   88.070674] Modules linked in: snd_seq_dummy(E) snd_hrtimer(E) snd_seq(E) snd_seq_device(E) snd_timer(E) snd(E) soundcore(E) bonding(E) tls(E) rfkill(E) pseries_rng(E) drm(E) fuse(E) drm_panel_orientation_quirks(E) xfs(E) libcrc32c(E) sd_mod(E) t10_pi(E) ibmvscsi(E) ibmveth(E) scsi_transport_srp(E) vmx_crypto(E) dm_mirror(E) dm_region_hash(E) dm_log(E) dm_mod(E)
[   88.070714] CPU: 4 PID: 950 Comm: test_verifier Tainted: G            E     5.11.0-rc4+ #4
[   88.070721] NIP:  c0080000017daad8 LR: c000000000c26ea8 CTR: c0080000017daaa0
[   88.070726] REGS: c000000011407870 TRAP: 0900   Tainted: G            E      (5.11.0-rc4+)
[   88.070732] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 44222840  XER: 20040169
[   88.070745] CFAR: c0080000017daad8 IRQMASK: 0 
[   88.070745] GPR00: c000000000c26d1c c000000011407b10 c000000002011600 0000000000000001 
[   88.070745] GPR04: c0080000016d0038 ffffffffffffffff 0000000001f3f8ec 0017b1edefe5ad37 
[   88.070745] GPR08: 0000000000000000 c000000011407b38 0000000000000001 f5d4bac969e94f08 
[   88.070745] GPR12: c0080000017daaa0 c00000001ecab400 0000000000000000 0000000000000000 
[   88.070745] GPR16: 000000001003a348 000000001003a3e8 0000000000000000 0000000000000000 
[   88.070745] GPR20: c000000011407c64 c0080000016d0038 c000000011407c60 c000000001734238 
[   88.070745] GPR24: c000000012ce8400 0000000000000001 c000000001734230 c0000000113e9300 
[   88.070745] GPR28: 0000000e5b65166b 0000000000000001 c0080000016d0000 c000000011407b40 
[   88.070807] NIP [c0080000017daad8] bpf_prog_a2eb9104e5e8a5bf+0x38/0x5560
[   88.070815] LR [c000000000c26ea8] bpf_test_run+0x288/0x470
[   88.070823] Call Trace:
[   88.070825] [c000000011407b10] [c000000011407b80] 0xc000000011407b80 (unreliable)
[   88.070832] [c000000011407b80] [c000000000c26d1c] bpf_test_run+0xfc/0x470
[   88.070840] [c000000011407c40] [c000000000c2823c] bpf_prog_test_run_skb+0x38c/0x660
[   88.070846] [c000000011407ce0] [c00000000035896c] __do_sys_bpf+0x4cc/0xf30
[   88.070853] [c000000011407db0] [c000000000037a14] system_call_exception+0x134/0x230
[   88.070861] [c000000011407e10] [c00000000000c874] system_call_vectored_common+0xf4/0x26c
[   88.070869] Instruction dump:
[   88.070873] f821ff91 fbe10068 3be10030 39000000 f91ffff8 38600001 393ffff8 7d4048a8 
[   88.070886] 7d4a1a14 7d4049ad 4082fff4 28230000 <4082fffc> 60000000 ebe10068 38210070 

ibm-p9z-07-lp1 login: [  121.762511] rcu: INFO: rcu_sched self-detected stall on CPU
[  121.762536] rcu:     4-....: (5999 ticks this GP) idle=9ee/1/0x4000000000000002 softirq=2299/2299 fqs=2998 
[  121.762546]  (t=6000 jiffies g=3681 q=798)
[  121.762551] NMI backtrace for cpu 4
[  121.762555] CPU: 4 PID: 950 Comm: test_verifier Tainted: G            EL    5.11.0-rc4+ #4
[  121.762562] Call Trace:
[  121.762565] [c0000000114072b0] [c0000000007cfe9c] dump_stack+0xc0/0x104 (unreliable)
[  121.762575] [c000000011407300] [c0000000007dd028] nmi_cpu_backtrace+0xe8/0x130
[  121.762582] [c000000011407370] [c0000000007dd21c] nmi_trigger_cpumask_backtrace+0x1ac/0x1f0
[  121.762589] [c000000011407410] [c0000000000718a8] arch_trigger_cpumask_backtrace+0x28/0x40
[  121.762596] [c000000011407430] [c000000000215740] rcu_dump_cpu_stacks+0x10c/0x168
[  121.762604] [c000000011407480] [c00000000020b080] print_cpu_stall+0x1d0/0x2a0
[  121.762611] [c000000011407530] [c00000000020e4d4] check_cpu_stall+0x174/0x340
[  121.762618] [c000000011407560] [c000000000213b28] rcu_sched_clock_irq+0x98/0x3f0
[  121.762625] [c0000000114075a0] [c00000000022b974] update_process_times+0xc4/0x150
[  121.762631] [c0000000114075e0] [c000000000245cec] tick_sched_handle+0x3c/0xd0
[  121.762638] [c000000011407610] [c000000000246408] tick_sched_timer+0x68/0xe0
[  121.762645] [c000000011407650] [c00000000022ca18] __hrtimer_run_queues+0x1c8/0x430
[  121.762652] [c0000000114076f0] [c00000000022ddd4] hrtimer_interrupt+0x124/0x300
[  121.762658] [c0000000114077a0] [c0000000000286a4] timer_interrupt+0x104/0x290
[  121.762665] [c000000011407800] [c000000000009978] decrementer_common_virt+0x1c8/0x1d0
[  121.762673] --- interrupt: 900 at bpf_prog_a2eb9104e5e8a5bf+0x34/0x5560
[  121.762680] NIP:  c0080000017daad4 LR: c000000000c26ea8 CTR: c0080000017daaa0
[  121.762684] REGS: c000000011407870 TRAP: 0900   Tainted: G            EL     (5.11.0-rc4+)
[  121.762689] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 44222840  XER: 20040169
[  121.762702] CFAR: c0080000017daad8 IRQMASK: 0 
[  121.762702] GPR00: c000000000c26d1c c000000011407b10 c000000002011600 0000000000000001 
[  121.762702] GPR04: c0080000016d0038 ffffffffffffffff 0000000001f3f8ec 0017b1edefe5ad37 
[  121.762702] GPR08: 0000000000000000 c000000011407b38 0000000000000001 f5d4bac969e94f08 
[  121.762702] GPR12: c0080000017daaa0 c00000001ecab400 0000000000000000 0000000000000000 
[  121.762702] GPR16: 000000001003a348 000000001003a3e8 0000000000000000 0000000000000000 
[  121.762702] GPR20: c000000011407c64 c0080000016d0038 c000000011407c60 c000000001734238 
[  121.762702] GPR24: c000000012ce8400 0000000000000001 c000000001734230 c0000000113e9300 
[  121.762702] GPR28: 0000000e5b65166b 0000000000000001 c0080000016d0000 c000000011407b40 
[  121.762765] NIP [c0080000017daad4] bpf_prog_a2eb9104e5e8a5bf+0x34/0x5560
[  121.762770] LR [c000000000c26ea8] bpf_test_run+0x288/0x470
[  121.762777] --- interrupt: 900
[  121.762779] [c000000011407b10] [c000000011407b80] 0xc000000011407b80 (unreliable)
[  121.762786] [c000000011407b80] [c000000000c26d1c] bpf_test_run+0xfc/0x470
[  121.762793] [c000000011407c40] [c000000000c2823c] bpf_prog_test_run_skb+0x38c/0x660
[  121.762800] [c000000011407ce0] [c00000000035896c] __do_sys_bpf+0x4cc/0xf30
[  121.762807] [c000000011407db0] [c000000000037a14] system_call_exception+0x134/0x230
[  121.762814] [c000000011407e10] [c00000000000c874] system_call_vectored_common+0xf4/0x26c
[  148.073962] watchdog: BUG: soft lockup - CPU#4 stuck for 22s! [test_verifier:950]
[  148.073990] Modules linked in: snd_seq_dummy(E) snd_hrtimer(E) snd_seq(E) snd_seq_device(E) snd_timer(E) snd(E) soundcore(E) bonding(E) tls(E) rfkill(E) pseries_rng(E) drm(E) fuse(E) drm_panel_orientation_quirks(E) xfs(E) libcrc32c(E) sd_mod(E) t10_pi(E) ibmvscsi(E) ibmveth(E) scsi_transport_srp(E) vmx_crypto(E) dm_mirror(E) dm_region_hash(E) dm_log(E) dm_mod(E)
[  148.074029] CPU: 4 PID: 950 Comm: test_verifier Tainted: G            EL    5.11.0-rc4+ #4
[  148.074036] NIP:  c0080000017daad8 LR: c000000000c26ea8 CTR: c0080000017daaa0
[  148.074041] REGS: c000000011407870 TRAP: 0900   Tainted: G            EL     (5.11.0-rc4+)
[  148.074047] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 44222840  XER: 20040169
[  148.074060] CFAR: c0080000017daad8 IRQMASK: 0 
[  148.074060] GPR00: c000000000c26d1c c000000011407b10 c000000002011600 0000000000000001 
[  148.074060] GPR04: c0080000016d0038 ffffffffffffffff 0000000001f3f8ec 0017b1edefe5ad37 
[  148.074060] GPR08: 0000000000000000 c000000011407b38 0000000000000001 f5d4bac969e94f08 
[  148.074060] GPR12: c0080000017daaa0 c00000001ecab400 0000000000000000 0000000000000000 
[  148.074060] GPR16: 000000001003a348 000000001003a3e8 0000000000000000 0000000000000000 
[  148.074060] GPR20: c000000011407c64 c0080000016d0038 c000000011407c60 c000000001734238 
[  148.074060] GPR24: c000000012ce8400 0000000000000001 c000000001734230 c0000000113e9300 
[  148.074060] GPR28: 0000000e5b65166b 0000000000000001 c0080000016d0000 c000000011407b40 
[  148.074122] NIP [c0080000017daad8] bpf_prog_a2eb9104e5e8a5bf+0x38/0x5560
[  148.074129] LR [c000000000c26ea8] bpf_test_run+0x288/0x470
[  148.074137] Call Trace:
[  148.074139] [c000000011407b10] [c000000011407b80] 0xc000000011407b80 (unreliable)
[  148.074147] [c000000011407b80] [c000000000c26d1c] bpf_test_run+0xfc/0x470
[  148.074154] [c000000011407c40] [c000000000c2823c] bpf_prog_test_run_skb+0x38c/0x660
[  148.074160] [c000000011407ce0] [c00000000035896c] __do_sys_bpf+0x4cc/0xf30
[  148.074168] [c000000011407db0] [c000000000037a14] system_call_exception+0x134/0x230
[  148.074175] [c000000011407e10] [c00000000000c874] system_call_vectored_common+0xf4/0x26c
[  148.074183] Instruction dump:
[  148.074188] f821ff91 fbe10068 3be10030 39000000 f91ffff8 38600001 393ffff8 7d4048a8 
[  148.074199] 7d4a1a14 7d4049ad 4082fff4 28230000 <4082fffc> 60000000 ebe10068 38210070 

jirka

