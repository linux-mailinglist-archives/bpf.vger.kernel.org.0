Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E62EC3B73F4
	for <lists+bpf@lfdr.de>; Tue, 29 Jun 2021 16:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbhF2OMr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Jun 2021 10:12:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59772 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233665AbhF2OMr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 29 Jun 2021 10:12:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624975819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Td2jaOtu1OIAJ2dbnNafo3OTJR7dFIW9/V+YM1ko/D8=;
        b=AQEABwaSSCthlEXyTqd9M7tBsJWOk3CZgNyF/kKReGRzKRxXG92aW6Wf4NUporHEuz9jrN
        DwyglfG6GrqCbFiDk1Pp1FP/Jez/FMPk0086s6cZRk6Se7YFNmLr8K+rxMbAUseEzD+Vdd
        bFhilsRhzz+RxfzHm2Ai/JYXYMfflmM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-I3fcONfaMRq0V7sQ-NieYQ-1; Tue, 29 Jun 2021 10:10:13 -0400
X-MC-Unique: I3fcONfaMRq0V7sQ-NieYQ-1
Received: by mail-wr1-f72.google.com with SMTP id u16-20020a5d51500000b029011a6a17cf62so5947560wrt.13
        for <bpf@vger.kernel.org>; Tue, 29 Jun 2021 07:10:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Td2jaOtu1OIAJ2dbnNafo3OTJR7dFIW9/V+YM1ko/D8=;
        b=IPo1rBsj0vKRJTvLNNTWXc4dfUEEqZJh3p4rub0Z0bdrojZXC2KE8QTaOcIqgvAv/u
         pufy41rVfYX/XVPBtezGZ+6BKYyL51j4nY6enZ1V26JWrb0mjV6inigR4K7YZZXtwRkz
         gLwQFBWK09jrAFB1IjZNS5mh0bqmoyE6PdY9YH1N7GvDC0QLsaF7WTyGEqbc5BGHVFIX
         CNxJDbqj9KxfKqjMqX71kUQ1KdUnZurJciY4yMSVfiGcoGKP84LpAATTSQJer/G9HzrZ
         TD1T6mfiXpbqYfghB7pvYF8BO0zgq/ikjMlRxUsHFckY41ldXCSAn/hA1bt33bOa+z46
         pAaQ==
X-Gm-Message-State: AOAM5317Iviu9Ar1LbANUVLx4C2pnDiOTWbRA/LOcBBSq60BHelOs3xY
        RO4CfO+R7vpjO4sMAuI2gBPDSNYg6vhlMD89PyRA2x5hFpTQo0ymvjCHMe3PqxzIITAkrywINSu
        OqZAAj5+QeP0t
X-Received: by 2002:a1c:2142:: with SMTP id h63mr33528929wmh.84.1624975812318;
        Tue, 29 Jun 2021 07:10:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzLUdw5Die2LWREGG/yf8LkBUxbDjAtXMajSOHgnHtWdHBFSXTTg2TI5FV04s4W8dGxb5ka7w==
X-Received: by 2002:a1c:2142:: with SMTP id h63mr33528890wmh.84.1624975812136;
        Tue, 29 Jun 2021 07:10:12 -0700 (PDT)
Received: from krava ([109.53.15.83])
        by smtp.gmail.com with ESMTPSA id p3sm1658779wmq.17.2021.06.29.07.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 07:10:11 -0700 (PDT)
Date:   Tue, 29 Jun 2021 16:10:08 +0200
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
Message-ID: <YNspwB8ejUeRIVxt@krava>
References: <20210202135002.4024825-1-jackmanb@google.com>
 <YNiadhIbJBBPeOr6@krava>
 <CA+i-1C0DAr5ecAOV06_fqeCooic4AF=71ur63HJ6ddbj9ceDpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+i-1C0DAr5ecAOV06_fqeCooic4AF=71ur63HJ6ddbj9ceDpQ@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 28, 2021 at 11:21:42AM +0200, Brendan Jackman wrote:
> On Sun, 27 Jun 2021 at 17:34, Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Tue, Feb 02, 2021 at 01:50:02PM +0000, Brendan Jackman wrote:
> >
> > SNIP
> >
> > > diff --git a/tools/testing/selftests/bpf/verifier/atomic_bounds.c b/tools/testing/selftests/bpf/verifier/atomic_bounds.c
> > > new file mode 100644
> > > index 000000000000..e82183e4914f
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/bpf/verifier/atomic_bounds.c
> > > @@ -0,0 +1,27 @@
> > > +{
> > > +     "BPF_ATOMIC bounds propagation, mem->reg",
> > > +     .insns = {
> > > +             /* a = 0; */
> > > +             /*
> > > +              * Note this is implemented with two separate instructions,
> > > +              * where you might think one would suffice:
> > > +              *
> > > +              * BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
> > > +              *
> > > +              * This is because BPF_ST_MEM doesn't seem to set the stack slot
> > > +              * type to 0 when storing an immediate.
> > > +              */
> > > +             BPF_MOV64_IMM(BPF_REG_0, 0),
> > > +             BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -8),
> > > +             /* b = atomic_fetch_add(&a, 1); */
> > > +             BPF_MOV64_IMM(BPF_REG_1, 1),
> > > +             BPF_ATOMIC_OP(BPF_DW, BPF_ADD | BPF_FETCH, BPF_REG_10, BPF_REG_1, -8),
> > > +             /* Verifier should be able to tell that this infinite loop isn't reachable. */
> > > +             /* if (b) while (true) continue; */
> > > +             BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, -1),
> > > +             BPF_EXIT_INSN(),
> > > +     },
> > > +     .result = ACCEPT,
> > > +     .result_unpriv = REJECT,
> > > +     .errstr_unpriv = "back-edge",
> > > +},
> > >
> > > base-commit: 61ca36c8c4eb3bae35a285b1ae18c514cde65439
> > > --
> > > 2.30.0.365.g02bc693789-goog
> > >
> >
> > hi,
> > I tracked soft lock up on powerpc to this test:
> >
> >         [root@ibm-p9z-07-lp1 bpf]# ./test_verifier 25
> >         #25/u BPF_ATOMIC bounds propagation, mem->reg SKIP
> >         #25/p BPF_ATOMIC bounds propagation, mem->reg
> >
> >         Message from syslogd@ibm-p9z-07-lp1 at Jun 27 11:24:34 ...
> >          kernel:watchdog: BUG: soft lockup - CPU#2 stuck for 26s! [test_verifier:1055]
> >
> >         Message from syslogd@ibm-p9z-07-lp1 at Jun 27 11:25:04 ...
> >          kernel:watchdog: BUG: soft lockup - CPU#2 stuck for 48s! [test_verifier:1055]
> >
> > please check the console output below.. it looks like the verifier
> > allowed the loop to happen for some reason on powerpc.. any idea?
> >
> > I'm on latest bpf-next/master, I can send the config if needed
> >
> > thanks,
> > jirka
> >
> >
> > ---
> > ibm-p9z-07-lp1 login: [  184.108655] watchdog: BUG: soft lockup - CPU#2 stuck for 26s! [test_verifier:1055]
> > [  184.108679] Modules linked in: snd_seq_dummy(E) snd_hrtimer(E) snd_seq(E) snd_seq_device(E) snd_timer(E) snd(E) soundcore(E) bonding(E) tls(E) rfkill(E) pseries_rng(E) drm(E) fuse(E) drm_panel_orientation_quirks(E) xfs(E) libcrc32c(E) sd_mod(E) t10_pi(E) ibmvscsi(E) ibmveth(E) scsi_transport_srp(E) vmx_crypto(E) dm_mirror(E) dm_region_hash(E) dm_log(E) dm_mod(E)
> > [  184.108722] CPU: 2 PID: 1055 Comm: test_verifier Tainted: G            E     5.13.0-rc3+ #3
> > [  184.108728] NIP:  c00800000131314c LR: c000000000c56918 CTR: c008000001313118
> > [  184.108733] REGS: c0000000119ef820 TRAP: 0900   Tainted: G            E      (5.13.0-rc3+)
> > [  184.108739] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 44222840  XER: 20040003
> > [  184.108752] CFAR: c008000001313150 IRQMASK: 0
> > [  184.108752] GPR00: c000000000c5671c c0000000119efac0 c000000002a08400 0000000000000001
> > [  184.108752] GPR04: c0080000010c0048 ffffffffffffffff 0000000001f3f8ec 0000000000000008
> > [  184.108752] GPR08: 0000000000000000 c0000000119efae8 0000000000000001 49adb8fcb8417937
> > [  184.108752] GPR12: c008000001313118 c00000001ecae400 0000000000000000 0000000000000000
> > [  184.108752] GPR16: 0000000000000000 0000000000000000 0000000000000000 c0000000021cf6f8
> > [  184.108752] GPR20: 0000000000000000 c0000000119efc34 c0000000119efc30 c0080000010c0048
> > [  184.108752] GPR24: c00000000a1dc100 0000000000000001 c000000011fadc80 c0000000021cf638
> > [  184.108752] GPR28: c0080000010c0000 0000000000000001 c0000000021cf638 c0000000119efaf0
> > [  184.108812] NIP [c00800000131314c] bpf_prog_a2eb9104e5e8a5bf+0x34/0xcee8
> > [  184.108819] LR [c000000000c56918] bpf_test_run+0x2f8/0x470
> > [  184.108826] Call Trace:
> > [  184.108828] [c0000000119efac0] [c0000000119efb30] 0xc0000000119efb30 (unreliable)
> > [  184.108835] [c0000000119efb30] [c000000000c5671c] bpf_test_run+0xfc/0x470
> > [  184.108841] [c0000000119efc10] [c000000000c57b6c] bpf_prog_test_run_skb+0x38c/0x660
> > [  184.108848] [c0000000119efcb0] [c00000000035de6c] __sys_bpf+0x46c/0xd60
> > [  184.108854] [c0000000119efd90] [c00000000035e810] sys_bpf+0x30/0x40
> > [  184.108859] [c0000000119efdb0] [c00000000002ea34] system_call_exception+0x144/0x280
> > [  184.108866] [c0000000119efe10] [c00000000000c570] system_call_vectored_common+0xf0/0x268
> > [  184.108874] --- interrupt: 3000 at 0x7fff8bb3ef24
> > [  184.108878] NIP:  00007fff8bb3ef24 LR: 0000000000000000 CTR: 0000000000000000
> > [  184.108883] REGS: c0000000119efe80 TRAP: 3000   Tainted: G            E      (5.13.0-rc3+)
> > [  184.108887] MSR:  800000000280f033 <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 28000848  XER: 00000000
> > [  184.108903] IRQMASK: 0
> > [  184.108903] GPR00: 0000000000000169 00007fffe4577710 00007fff8bc27200 000000000000000a
> > [  184.108903] GPR04: 00007fffe45777b8 0000000000000080 0000000000000001 0000000000000008
> > [  184.108903] GPR08: 000000000000000a 0000000000000000 0000000000000000 0000000000000000
> > [  184.108903] GPR12: 0000000000000000 00007fff8be1c400 0000000000000000 0000000000000000
> > [  184.108903] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> > [  184.108903] GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> > [  184.108903] GPR24: 0000000000000000 0000000000000000 0000000000000000 000000001000d1d0
> > [  184.108903] GPR28: 0000000000000002 00007fffe4578128 00007fffe45782c0 00007fffe4577710
> > [  184.108960] NIP [00007fff8bb3ef24] 0x7fff8bb3ef24
> > [  184.108964] LR [0000000000000000] 0x0
> > [  184.108967] --- interrupt: 3000
> > [  184.108970] Instruction dump:
> > [  184.108974] 60000000 f821ff91 fbe10068 3be10030 39000000 f91ffff8 38600001 393ffff8
> > [  184.108985] 7d4048a8 7d4a1a14 7d4049ad 4082fff4 <28230000> 4082fffc 60000000 ebe10068
> 
> Hmm, is the test prog from atomic_bounds.c getting JITed there (my
> dumb guess at what '0xc0000000119efb30 (unreliable)' means)? That
> shouldn't happen - should get 'eBPF filter atomic op code %02x (@%d)
> unsupported\n' in dmesg instead. I wonder if I missed something in
> commit 91c960b0056 (bpf: Rename BPF_XADD and prepare to encode other
> atomics in .imm). Any idea if this test was ever passing on PowerPC?
> 

hum, I guess not.. will check

jirka

