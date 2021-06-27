Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93DB03B5405
	for <lists+bpf@lfdr.de>; Sun, 27 Jun 2021 17:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbhF0Pgq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 27 Jun 2021 11:36:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35061 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230268AbhF0Pgp (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 27 Jun 2021 11:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624808060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EqOhxqoG2yCQME4V9EK3p1H/36nD6dQTd7dtgHixW20=;
        b=giIibSgg0+hQ/VCkueJDN0Y7uakqBZCYqurLEwAopZYuTHVUXBkwkrgKBjLIW74Upe/9Df
        6zh8Hh2lpme6sHQPo1c0Ub37zFtTMOb9+wAazi9Mp6Uwa3W1lEL02EdrQrpUvFQpDNq9qU
        Z1PD7HvWpN6msiwTDIYiVw7PdNgHbxg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-TaHj4HMwOcyecrl7tOxrpQ-1; Sun, 27 Jun 2021 11:34:19 -0400
X-MC-Unique: TaHj4HMwOcyecrl7tOxrpQ-1
Received: by mail-ed1-f70.google.com with SMTP id r15-20020aa7da0f0000b02903946a530334so7967045eds.22
        for <bpf@vger.kernel.org>; Sun, 27 Jun 2021 08:34:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EqOhxqoG2yCQME4V9EK3p1H/36nD6dQTd7dtgHixW20=;
        b=glu3CCYEl6FSaVr7LlZi2ZBXX0dNf4MorLqGC74Il9dKoiCU85fNeJi72wYOZDXKSL
         AG9VveNjkBWMECI/ol3g6FoFeaZzKXSPqCQH6fkrgGS4EKCKJn0GejZALoSUopxnW6hR
         aNTOMCLgdqjKNKv000erlL61TkHb2l+lvXHj3SgPnpWaICIAah2f/vJVSCuiLQFE1e8T
         WI4lk1H5++em+t6fXl4dFxWqT5b6ZZ5p2oaro8uL2QLEGe+6fxF0hRyeiDS8n407amqF
         Ia/K1HlR3FUJ5NKXyZ+eQLjlcWWYX/6ICmNsH7bZA0h2LG62LQohYDaC38yQ0Kzn/0Ey
         2zRg==
X-Gm-Message-State: AOAM533JL8wGQw9dtt8aY7cVE2sc2g3j+6j8BR2s2sdvCKLNOHlj19XA
        ABrm0tbXuoN2Vs563mxpZRIvNGZG+JOOrFnP/yXxn1sTubLtosCuxRn+PflkeSoM4YxRmNT2x7F
        KCH63SXB5XP1e
X-Received: by 2002:aa7:ce17:: with SMTP id d23mr27431203edv.314.1624808057861;
        Sun, 27 Jun 2021 08:34:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJxmpZKeE0tlPOiFJjCON/8oaokHtU/AE1N5dstoRajKfwTfX7WX67LSLu5A6JOjlx0WOKvw==
X-Received: by 2002:aa7:ce17:: with SMTP id d23mr27431189edv.314.1624808057666;
        Sun, 27 Jun 2021 08:34:17 -0700 (PDT)
Received: from krava ([5.170.244.150])
        by smtp.gmail.com with ESMTPSA id e3sm5933703ejy.78.2021.06.27.08.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 08:34:17 -0700 (PDT)
Date:   Sun, 27 Jun 2021 17:34:14 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Brendan Jackman <jackmanb@google.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        John Fastabend <john.fastabend@gmail.com>,
        linux-kernel@vger.kernel.org,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Sandipan Das <sandipan@linux.ibm.com>
Subject: [BUG soft lockup] Re: [PATCH bpf-next v3] bpf: Propagate stack
 bounds to registers in atomics w/ BPF_FETCH
Message-ID: <YNiadhIbJBBPeOr6@krava>
References: <20210202135002.4024825-1-jackmanb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202135002.4024825-1-jackmanb@google.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 02, 2021 at 01:50:02PM +0000, Brendan Jackman wrote:

SNIP

> diff --git a/tools/testing/selftests/bpf/verifier/atomic_bounds.c b/tools/testing/selftests/bpf/verifier/atomic_bounds.c
> new file mode 100644
> index 000000000000..e82183e4914f
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/verifier/atomic_bounds.c
> @@ -0,0 +1,27 @@
> +{
> +	"BPF_ATOMIC bounds propagation, mem->reg",
> +	.insns = {
> +		/* a = 0; */
> +		/*
> +		 * Note this is implemented with two separate instructions,
> +		 * where you might think one would suffice:
> +		 *
> +		 * BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
> +		 *
> +		 * This is because BPF_ST_MEM doesn't seem to set the stack slot
> +		 * type to 0 when storing an immediate.
> +		 */
> +		BPF_MOV64_IMM(BPF_REG_0, 0),
> +		BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -8),
> +		/* b = atomic_fetch_add(&a, 1); */
> +		BPF_MOV64_IMM(BPF_REG_1, 1),
> +		BPF_ATOMIC_OP(BPF_DW, BPF_ADD | BPF_FETCH, BPF_REG_10, BPF_REG_1, -8),
> +		/* Verifier should be able to tell that this infinite loop isn't reachable. */
> +		/* if (b) while (true) continue; */
> +		BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, -1),
> +		BPF_EXIT_INSN(),
> +	},
> +	.result = ACCEPT,
> +	.result_unpriv = REJECT,
> +	.errstr_unpriv = "back-edge",
> +},
> 
> base-commit: 61ca36c8c4eb3bae35a285b1ae18c514cde65439
> --
> 2.30.0.365.g02bc693789-goog
> 

hi,
I tracked soft lock up on powerpc to this test:

	[root@ibm-p9z-07-lp1 bpf]# ./test_verifier 25
	#25/u BPF_ATOMIC bounds propagation, mem->reg SKIP
	#25/p BPF_ATOMIC bounds propagation, mem->reg 

	Message from syslogd@ibm-p9z-07-lp1 at Jun 27 11:24:34 ...
	 kernel:watchdog: BUG: soft lockup - CPU#2 stuck for 26s! [test_verifier:1055]

	Message from syslogd@ibm-p9z-07-lp1 at Jun 27 11:25:04 ...
	 kernel:watchdog: BUG: soft lockup - CPU#2 stuck for 48s! [test_verifier:1055]

please check the console output below.. it looks like the verifier
allowed the loop to happen for some reason on powerpc.. any idea?

I'm on latest bpf-next/master, I can send the config if needed

thanks,
jirka


---
ibm-p9z-07-lp1 login: [  184.108655] watchdog: BUG: soft lockup - CPU#2 stuck for 26s! [test_verifier:1055]
[  184.108679] Modules linked in: snd_seq_dummy(E) snd_hrtimer(E) snd_seq(E) snd_seq_device(E) snd_timer(E) snd(E) soundcore(E) bonding(E) tls(E) rfkill(E) pseries_rng(E) drm(E) fuse(E) drm_panel_orientation_quirks(E) xfs(E) libcrc32c(E) sd_mod(E) t10_pi(E) ibmvscsi(E) ibmveth(E) scsi_transport_srp(E) vmx_crypto(E) dm_mirror(E) dm_region_hash(E) dm_log(E) dm_mod(E)
[  184.108722] CPU: 2 PID: 1055 Comm: test_verifier Tainted: G            E     5.13.0-rc3+ #3
[  184.108728] NIP:  c00800000131314c LR: c000000000c56918 CTR: c008000001313118
[  184.108733] REGS: c0000000119ef820 TRAP: 0900   Tainted: G            E      (5.13.0-rc3+)
[  184.108739] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 44222840  XER: 20040003
[  184.108752] CFAR: c008000001313150 IRQMASK: 0 
[  184.108752] GPR00: c000000000c5671c c0000000119efac0 c000000002a08400 0000000000000001 
[  184.108752] GPR04: c0080000010c0048 ffffffffffffffff 0000000001f3f8ec 0000000000000008 
[  184.108752] GPR08: 0000000000000000 c0000000119efae8 0000000000000001 49adb8fcb8417937 
[  184.108752] GPR12: c008000001313118 c00000001ecae400 0000000000000000 0000000000000000 
[  184.108752] GPR16: 0000000000000000 0000000000000000 0000000000000000 c0000000021cf6f8 
[  184.108752] GPR20: 0000000000000000 c0000000119efc34 c0000000119efc30 c0080000010c0048 
[  184.108752] GPR24: c00000000a1dc100 0000000000000001 c000000011fadc80 c0000000021cf638 
[  184.108752] GPR28: c0080000010c0000 0000000000000001 c0000000021cf638 c0000000119efaf0 
[  184.108812] NIP [c00800000131314c] bpf_prog_a2eb9104e5e8a5bf+0x34/0xcee8
[  184.108819] LR [c000000000c56918] bpf_test_run+0x2f8/0x470
[  184.108826] Call Trace:
[  184.108828] [c0000000119efac0] [c0000000119efb30] 0xc0000000119efb30 (unreliable)
[  184.108835] [c0000000119efb30] [c000000000c5671c] bpf_test_run+0xfc/0x470
[  184.108841] [c0000000119efc10] [c000000000c57b6c] bpf_prog_test_run_skb+0x38c/0x660
[  184.108848] [c0000000119efcb0] [c00000000035de6c] __sys_bpf+0x46c/0xd60
[  184.108854] [c0000000119efd90] [c00000000035e810] sys_bpf+0x30/0x40
[  184.108859] [c0000000119efdb0] [c00000000002ea34] system_call_exception+0x144/0x280
[  184.108866] [c0000000119efe10] [c00000000000c570] system_call_vectored_common+0xf0/0x268
[  184.108874] --- interrupt: 3000 at 0x7fff8bb3ef24
[  184.108878] NIP:  00007fff8bb3ef24 LR: 0000000000000000 CTR: 0000000000000000
[  184.108883] REGS: c0000000119efe80 TRAP: 3000   Tainted: G            E      (5.13.0-rc3+)
[  184.108887] MSR:  800000000280f033 <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 28000848  XER: 00000000
[  184.108903] IRQMASK: 0 
[  184.108903] GPR00: 0000000000000169 00007fffe4577710 00007fff8bc27200 000000000000000a 
[  184.108903] GPR04: 00007fffe45777b8 0000000000000080 0000000000000001 0000000000000008 
[  184.108903] GPR08: 000000000000000a 0000000000000000 0000000000000000 0000000000000000 
[  184.108903] GPR12: 0000000000000000 00007fff8be1c400 0000000000000000 0000000000000000 
[  184.108903] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
[  184.108903] GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
[  184.108903] GPR24: 0000000000000000 0000000000000000 0000000000000000 000000001000d1d0 
[  184.108903] GPR28: 0000000000000002 00007fffe4578128 00007fffe45782c0 00007fffe4577710 
[  184.108960] NIP [00007fff8bb3ef24] 0x7fff8bb3ef24
[  184.108964] LR [0000000000000000] 0x0
[  184.108967] --- interrupt: 3000
[  184.108970] Instruction dump:
[  184.108974] 60000000 f821ff91 fbe10068 3be10030 39000000 f91ffff8 38600001 393ffff8 
[  184.108985] 7d4048a8 7d4a1a14 7d4049ad 4082fff4 <28230000> 4082fffc 60000000 ebe10068 

