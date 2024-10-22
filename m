Return-Path: <bpf+bounces-42746-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 335E39A98A7
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 07:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C2471C21755
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 05:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E30131E38;
	Tue, 22 Oct 2024 05:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dwc3cRfH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D849B3D994
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 05:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729575531; cv=none; b=Lu2DhWioyy79CRBucpV3pyrjRxZ4O7svgzaat95Yzj7zGyHMeNz4J3BZTPkp2zwiPxlSXriLY5BuIBgbspFP8xYO4veHjKn/q5VAIMSulWdgjB+E5XsC5gVdaSzbgisET7PGbAmwDE6hJCFMzrx1rpp1tABD+r4ECiWMc7R6TFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729575531; c=relaxed/simple;
	bh=JzACodQZj521pHgvO84ejFM4SySd680v7/5pMs9fTsM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CDW23wQPa987YumXz9Gr4kWYF1MLKtuOfVbVVq4j9L0B6Ah2yQv0g1TXfVmA6SyJtOVlOnw74zSwYmCJn8NNI6k3AI9PiidWkAi8Wczhx2KEC4L/+kM3tMH7cYnj/hWU+dShO60cCxcLBVgmjWNH6EOGTgKmk/HxnRy0oIC/VlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dwc3cRfH; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20ca1b6a80aso48868715ad.2
        for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 22:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729575529; x=1730180329; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zKQSQbdbxCD+bALn8MM7QYG8zsQQ/cFBUpgWFho0C/A=;
        b=Dwc3cRfHKtHT3gyiR1IevqldW6Q2ehhOETaBnKOACW3wfjTAugSv/msihJd7a6yjIL
         4euAdLyFjBLegUH4geNE08/r8BEhE8cA/+qZZ22Kf/Q731VYsjv9Ge6i9giZit4zHbci
         YA4w28U4mxqa5ZfbNCtsy6kOrGE/TAZzT+beb0VlFVD3kwr6PfCNbViGSro2o52KAFEA
         XSoMoHPKhoWiXGg28we83fxFpi0Fm4WMOe96cRpVIZS7xOc0HCn0sSc7fhHdu0eS0Nzb
         6QmwdeYXOm59v8van/yum0XkmV+mxyQSBl8hO1ZPmmdQaCO18B4k+U08LWTgkO9i98fk
         pp8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729575529; x=1730180329;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zKQSQbdbxCD+bALn8MM7QYG8zsQQ/cFBUpgWFho0C/A=;
        b=FKTAWc0BxJUTu+mf9YqnZu9LrUt78pRWy7dsGY1uJrPS5oJnAGEMkWVWjc3iKxlliz
         qI6eUxLCMx0Pve3AhDy2K7udFlgK4INR6K0SCuePMEfvsqzdaD/TTclGhfexDNW/TZVU
         yV0f77vh10B7VRaY4OHeFiJf/Fx4efQXTVBXUmuka0nbWlHwjlMKdTaKlz6Gi8CJun6Z
         muf3ohdiNlqH7kPqPI4/MqwxA8DeleTdCO8cji1Mv3qM2PwmLzNPWLM19T3+J/nFbs/h
         k+YtJEU7kHk5XSycyIl4lpJWodQ9Y0OsP7Tf4VwYioZzUECBQQnw2J3dDWHDKpBHSW0G
         y7RQ==
X-Gm-Message-State: AOJu0YzXbhTM8rXW57Vp6KmRsVzGhfCERY5UYHeZJL49PyezZ+0X7FDs
	1j+a/qaEEBw3dUE5KAsANQySobT9LwMSQTwbUC8METaWYTU+f56O
X-Google-Smtp-Source: AGHT+IEwMMrAPOOJ4dxsKG8+SQMdyvmuq48CGJJwfezDieP/Uf8WNgyJkMKQcEBB66kd2v/g5DYECw==
X-Received: by 2002:a17:902:d2c6:b0:20e:71ee:568e with SMTP id d9443c01a7336-20e71ee56abmr138791805ad.13.1729575528920;
        Mon, 21 Oct 2024 22:38:48 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f109c5asm35051845ad.305.2024.10.21.22.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 22:38:48 -0700 (PDT)
Message-ID: <658394292b21edb9b30a5add27a8cd7fa8a778ed.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: force checkpoint when jmp history
 is too long
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>,
 Yonghong Song <yonghong.song@linux.dev>
Date: Mon, 21 Oct 2024 22:38:43 -0700
In-Reply-To: <CAADnVQJa8+tLnxpMWPVXO=moX+4tv3nTomang5=PAeLjVAe+ow@mail.gmail.com>
References: <20241018020307.1766906-1-eddyz87@gmail.com>
	 <CAADnVQKtR96Dricc=JiOi3VR9OeHjgT6xLOto9k_QcpPQNsKJw@mail.gmail.com>
	 <1564924604e5e17af10beac6bd3263481a1723f0.camel@gmail.com>
	 <CAADnVQJa8+tLnxpMWPVXO=moX+4tv3nTomang5=PAeLjVAe+ow@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-10-21 at 19:53 -0700, Alexei Starovoitov wrote:

[...]

> Instead of tweaking force_new_state earlier, it's better to do:
> if (!force_new_state && cur->jmp_history_cnt < N &&
>     env->jmps_processed - env->prev_jmps_processed < 20 && ..)
>     add_new_state =3D false;
>
> You're essentially proposing N =3D=3D 40.
> Just add your existing comment next to the check.
> # define MAX_JMPS_PER_STATE is imo overkill.

This condition is only triggered when verifier processes loops,
but this corner case is also possible w/o loops,
e.g. consider the following program:

    func#0 @0
    0: R1=3Dctx() R10=3Dfp0
    0: (79) r2 =3D *(u64 *)(r1 +0)          ; R1=3Dctx() R2_w=3Dscalar()
    1: (b7) r0 =3D 0                        ; R0_w=3D0
    2: (35) if r2 >=3D 0x0 goto pc+5
    mark_precise: frame0: last_idx 2 first_idx 0 subseq_idx -1=20
    mark_precise: frame0: regs=3Dr2 stack=3D before 1: (b7) r0 =3D 0
    mark_precise: frame0: regs=3Dr2 stack=3D before 0: (79) r2 =3D *(u64 *)=
(r1 +0)
    2: R2_w=3Dscalar()
    8: (35) if r2 >=3D 0x1 goto pc+6        ; R2_w=3D0
    9: (05) goto pc+0
    10: (05) goto pc+0
    11: (05) goto pc+0
    12: (05) goto pc+0
    13: (05) goto pc+0
    14: (95) exit
   =20
    from 8 to 15: R0_w=3D0 R1=3Dctx() R2_w=3Dscalar(umin=3D1) R10=3Dfp0
    15: R0_w=3D0 R1=3Dctx() R2_w=3Dscalar(umin=3D1) R10=3Dfp0
    15: (35) if r2 >=3D 0x2 goto pc+6       ; R2_w=3D1
    16: (05) goto pc+0
    17: (05) goto pc+0
    18: (05) goto pc+0
    19: (05) goto pc+0
    20: (05) goto pc+0
    21: (95) exit
   =20
    from 15 to 22: R0_w=3D0 R1=3Dctx() R2_w=3Dscalar(umin=3D2) R10=3Dfp0
    22: R0_w=3D0 R1=3Dctx() R2_w=3Dscalar(umin=3D2) R10=3Dfp0
    22: (35) if r2 >=3D 0x3 goto pc+6       ; R2_w=3D2
    23: (05) goto pc+0
    24: (05) goto pc+0
    25: (05) goto pc+0
    26: (05) goto pc+0
    27: (05) goto pc+0
    28: (95) exit

    ... and so on ...

Here amount of "goto +0;" instructions before each exit is chosen
specifically to force checkpoint before "exit;" is processed.

This takes ~10 minutes to verify on master.
Surprisingly current patch does not seem to help,
I'll investigate this tomorrow.
Full example is in the end of the email.

> I see. Thanks for explaining.
> So the bug is actually in reset logic of jmps/insns_processed
> coupled with push/pop stack.
> I think let's add cur->jmp_history_cnt < 40 check for now
> and target bpf tree (assuming no veristat regressions),
> but for bpf-next we probably need to follow up.

You'd like different fixes for bpf and bpf-next?

> We can probably remove jmps_processed counter
> and replace it with jmp_history_cnt.

I tried that :)
Results are a bit surprising, when the following patch is used:

    diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.=
h
    index 4513372c5bc8..4565c0c3e5b1 100644
    --- a/include/linux/bpf_verifier.h
    +++ b/include/linux/bpf_verifier.h
    @@ -468,6 +468,10 @@ struct bpf_verifier_state {
            u32 dfs_depth;
            u32 callback_unroll_depth;
            u32 may_goto_depth;
    +       /* number of jmps, calls, exits analyzed within this state */
    +       u32 jmps_processed;
    +       /* total number of instructions processed within this state */
    +       u32 insn_processed;
     }
    ...
    diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
    index f514247ba8ba..d61648d4c905 100644
    --- a/kernel/bpf/verifier.c
    +++ b/kernel/bpf/verifier.c
    ...
    @@ -17891,8 +17893,8 @@ static int is_state_visited(struct bpf_verifier=
_env *env, int insn_idx)
             * In tests that amounts to up to 50% reduction into total veri=
fier
             * memory consumption and 20% verifier time speedup.
             */
    -       if (env->jmps_processed - env->prev_jmps_processed >=3D 2 &&
    -           env->insn_processed - env->prev_insn_processed >=3D 8)
    +       if (cur->jmps_processed >=3D 2 &&
    +           cur->insn_processed >=3D 8)
                    add_new_state =3D true;

File                              Program           Insns       (DIFF)  Sta=
tes   (DIFF)
--------------------------------  ----------------  ------------------  ---=
------------
bpf_xdp.o                         tail_lb_ipv4         +8003 (+18.27%)   -3=
94 (-14.18%)
bpf_xdp.o                         tail_lb_ipv6        +19757 (+24.71%)   -4=
31 (-11.23%)
loop1.bpf.o                       nested_loops             +0 (+0.00%)     =
 +0 (+0.00%)
loop3.bpf.o                       while_true               +0 (+0.00%)     =
 +0 (+0.00%)
pyperf100.bpf.o                   on_event               -213 (-0.32%)  -11=
28 (-19.26%)
pyperf180.bpf.o                   on_event              +7863 (+6.25%)  -18=
01 (-17.23%)
pyperf600.bpf.o                   on_event            -79267 (-14.44%)  -50=
90 (-17.24%)
pyperf600_nounroll.bpf.o          on_event             +39203 (+7.78%)  -60=
55 (-17.69%)
strobemeta.bpf.o                  on_event          +587119 (+246.59%)  -19=
09 (-37.09%)
strobemeta_nounroll1.bpf.o        on_event            +49553 (+91.96%)   -6=
67 (-42.24%)
strobemeta_nounroll2.bpf.o        on_event           +109673 (+92.35%)  -17=
32 (-46.19%)
strobemeta_subprogs.bpf.o         on_event               -413 (-0.76%)   -5=
82 (-38.77%)
test_cls_redirect.bpf.o           cls_redirect        +20875 (+58.96%)     =
-73 (-3.35%)
test_cls_redirect_subprogs.bpf.o  cls_redirect        +12337 (+20.37%)     =
+52 (+1.25%)
test_verif_scale1.bpf.o           balancer_ingress   +224652 (+41.09%)    -=
670 (-7.76%)
test_verif_scale2.bpf.o           balancer_ingress      +7145 (+0.92%)  +29=
83 (+97.87%)
test_verif_scale3.bpf.o           balancer_ingress   +162514 (+19.40%)  -19=
59 (-22.68%)
verifier_search_pruning.bpf.o     short_loop1                      N/A     =
         N/A

Plus timer_mim.c starts to fail because we do not force checkpoint at
entry to async callback :)

> Based on the above explanation insns_processed counter is
> also bogus.

My reasoning is that jmp_history_cnt is what matters for
mark_chain_precision(), so it should be a marker for state cut-off,
insns_processed does not seem to add such constraints.

---

diff --git a/tools/testing/selftests/bpf/prog_tests/jumpjump.c b/tools/test=
ing/selftests/bpf/prog_tests/jumpjump.c
new file mode 100644
index 000000000000..f78675ba0341
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/jumpjump.c
@@ -0,0 +1,62 @@
+#include <test_progs.h>
+
+#define MAX_INSNS (512 * 1024)
+
+static char log_buf[16 * 1024* 1024];
+
+void test_jumpjump(void)
+{
+	/* Generate a series of jumps that would take a long time to verify. */
+	struct bpf_insn *insns =3D NULL;
+	int jmps_processed =3D 0;
+	int insn_processed =3D 0;
+	int jmp_idx =3D -1;
+	int prog_fd =3D -1;
+	int cnt =3D 0;
+	int i =3D 0;
+
+	insns =3D calloc(MAX_INSNS + 32, sizeof(*insns));
+	if (!ASSERT_OK_PTR(insns, "insns =3D calloc()"))
+		return;
+	insns[i++] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, 0);
+	insn_processed++;
+	insns[i++] =3D BPF_MOV64_IMM(BPF_REG_0, 0);
+	insn_processed++;
+	while (i < MAX_INSNS) {
+		if (jmp_idx > 0)
+			insns[jmp_idx].off =3D i - jmp_idx - 1;
+		jmp_idx =3D i;
+		insns[i++] =3D BPF_JMP_IMM(BPF_JGE, BPF_REG_2, cnt++, 0);
+		jmps_processed++;
+		insn_processed++;
+		while (insn_processed < 7 || jmps_processed < 2) {
+			insns[i++] =3D BPF_JMP_IMM(BPF_JA, 0, 0, 0);
+			jmps_processed++;
+			insn_processed++;
+		}
+		insns[i++] =3D BPF_EXIT_INSN();
+		jmps_processed =3D 1;
+		insn_processed =3D 1;
+	}
+	if (jmp_idx > 0)
+		insns[jmp_idx].off =3D i - jmp_idx - 1;
+	insns[i++] =3D BPF_EXIT_INSN();
+
+	LIBBPF_OPTS(bpf_prog_load_opts, opts);
+	opts.log_buf =3D log_buf;
+	opts.log_size =3D sizeof(log_buf);
+	opts.log_level =3D 0;
+	if (env.verbosity >=3D VERBOSE_VERY)
+		opts.log_level =3D 1 | 2 | 4;
+	prog_fd =3D bpf_prog_load(BPF_PROG_TYPE_RAW_TRACEPOINT, NULL, "GPL", insn=
s, i, &opts);
+	if (prog_fd < 0)
+		PRINT_FAIL("Can't load program, errno %d (%s)\n", errno, strerror(errno)=
);
+	if (env.verbosity >=3D VERBOSE_VERY || prog_fd < 0) {
+		printf("Verifier log:\n%s\n", log_buf);
+	}
+	if (prog_fd < 0)
+		goto out;
+out:
+	close(prog_fd);
+	free(insns);
+}


