Return-Path: <bpf+bounces-30815-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8848D2AB4
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 04:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53F122854BA
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 02:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9133B15ADB4;
	Wed, 29 May 2024 02:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rv4Cwxou"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB09C2F2A
	for <bpf@vger.kernel.org>; Wed, 29 May 2024 02:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716949091; cv=none; b=mMzkjHNDVkOhZlB5UpOr1jWDuRwizgDZnLYpYpb6Et+cFyeEGdnJ19KJZD6Ec9kJoxi+q6j+E6bW/6ezRY47FqLTwam+ZslfuoE5sTQ8JIq16+KDXZor5Rzjbk4rOuuxeUNdp62cN/vYtH7QxZWEyFjMzAz2KKU+rFsviAltJb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716949091; c=relaxed/simple;
	bh=EgYl1HMPH5m33eOAq3Ik89tKYoe2oZzg7V9cZLnBNQ4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dslS50SG/jB4YvVvkN4jGH7f7kNuhag2X1H1UF9bMX9R/IH1oxjj26pRfzmrBRV7uK56WjlhP/miWPSuukyQOQFsvFUNwygmkmaW/BO6AjoD4JxdVxbbs+sZbJISy0Rs/4JnHBRfC9XkezN//uO4+L4w9kN5INIIEiXfidKTzN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rv4Cwxou; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-24542b8607fso707842fac.1
        for <bpf@vger.kernel.org>; Tue, 28 May 2024 19:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716949089; x=1717553889; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4EIorbBUKOzHauWJM1q8p0DMkTlkQdz3nlZ3/nrPOLw=;
        b=Rv4CwxouTfnNZgncVoxUwpZEutl4hyGAko9qEsNMgKVyihlNmv94blOnXYDxzGy9hv
         mMPYzVeibualF7T92RawYXP9TmR2O/khOUH7copdJky83txOa6+d4V+JD13mgsgW5fgk
         5NclOW7UaxvfkA3pnjDClLvNnaQ8Vq/Z18+CO89S04Jnh4gb8Dd6jNvcdI0TmlQrxN64
         Q3iHZygR6mqzesTVSdpFhYdaYRIrSfe4WA9wzjRhkx20c/Nycu5/zZxTWxUeVOyd7Gz7
         ISfZ6Sqv0MwBpx+eB5NtBb7MAdU1BNb7m/Pf+EYR6QNOyNBifiX7UotZG2QSG+IlufH9
         Lbyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716949089; x=1717553889;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4EIorbBUKOzHauWJM1q8p0DMkTlkQdz3nlZ3/nrPOLw=;
        b=dQ/ZwVX+3+B89TBJKB1PWj2F/hpNtF+hgFBt+sNu95Af3+AcWHGsx847Jq/MF8dVAq
         4pg6D8VxCdm2NFiCwV+N5R2EoBBM9EfSfQVTbPrZnKJF3f/HokcIuI2oxUx+MSqFVyog
         Dl7M/cicOu/5oKRoQa6Lk4cwhP5wNeiGmoN4ozbzVw9l1WXPq79t+N4WFQXbxSqihkTQ
         eIznMwU258HTBfDjsTr6VcO0Vg6ePEe5qaJZwu9chGH8xIJRvOj0wKlcD76oeY/Ppio9
         XpbzPGGSd3C937Mss6Vka7JIYV+sdCqro974qkgiKHOO+oO5K4nj+47dbKedomeWezt9
         A+ag==
X-Gm-Message-State: AOJu0Yz6z3gjR+BEbKp7Az1ovgViDxd/JYU7XavmDHaeskNLJTg+CvuN
	drtJ28NGTMVQLb+7tRA7CJhRrmGEnCO8Hk88Qbpg1Tq11mujlGGx
X-Google-Smtp-Source: AGHT+IENNHPPY9DW2ldU1se5GNDwmDIiKDn4fYScOfRrQOmqr4ZpdDJ5D9aIzGS7MDhMFZgfg4Fjcw==
X-Received: by 2002:a05:6870:a2c9:b0:24f:c6d7:6aae with SMTP id 586e51a60fabf-24fc6d7788emr11907747fac.35.1716949088481;
        Tue, 28 May 2024 19:18:08 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160::3424? ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fc36e5f1sm7263279b3a.94.2024.05.28.19.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 19:18:07 -0700 (PDT)
Message-ID: <a8612f7bada4cf00d47e74c1507f9ad262e8a08f.camel@gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/2] bpf: Relax precision marking in open
 coded iters and may_goto loop.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel
 Team <kernel-team@fb.com>
Date: Tue, 28 May 2024 19:18:06 -0700
In-Reply-To: <ceec0883544b6855b7d1fda2884de775414a56c4.camel@gmail.com>
References: <20240525031156.13545-1-alexei.starovoitov@gmail.com>
	 <90874d4e32e7fe937c6774ad34d1617592b8abc8.camel@gmail.com>
	 <CAADnVQJdaQT_KPEjvmniCTeUed3jY0mzDNLUhKbFjpbjApMJrA@mail.gmail.com>
	 <ceec0883544b6855b7d1fda2884de775414a56c4.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-05-28 at 18:08 -0700, Eduard Zingerman wrote:

[...]

> > Because your guess at the reason for the verifier reject is not correct=
.
> > It's signed stuff that is causing issues.
> > s/int i/__u32 i/
> > and this test is passing the verifier with just 143 insn processed.
>=20
> I'm reading through verifier log, will get back shortly.

Ok, so it is a bit more subtle than I thought.
Comparing verification log for master and v3 here is the state in
which they diverge and v3 rejects the program:

    from 14 to 15: R0=3Drdonly_mem(id=3D6,ref_obj_id=3D1,sz=3D4) R6=3Dscala=
r(id=3D5) R7=3D2
                   R10=3Dfp0 fp-8=3Diter_num(ref_id=3D1,state=3Dactive,dept=
h=3D3) refs=3D1
    15: R0=3Drdonly_mem(id=3D6,ref_obj_id=3D1,sz=3D4) R6=3Dscalar(id=3D5)
        R7=3D2 R10=3Dfp0 fp-8=3Diter_num(ref_id=3D1,state=3Dactive,depth=3D=
3) refs=3D1
    15: (55) if r0 !=3D 0x0 goto pc+5       ; R0=3Drdonly_mem(id=3D6,ref_ob=
j_id=3D1,sz=3D4) refs=3D1
    ; if (i < 5) @ verifier_loops1.c:298
0-> 21: (65) if r7 s> 0x4 goto pc-10      ; R7=3D2 refs=3D1
    21: refs=3D1
    ; sum +=3D arr[i++]; @ verifier_loops1.c:299
1-> 22: (bf) r1 =3D r7                      ; R1_w=3Dscalar(id=3D7,smax=3D4=
) R7=3Dscalar(id=3D7,smax=3D4) refs=3D1
2-> 23: (67) r1 <<=3D 3                     ; R1_w=3Dscalar(smax=3D0x7fffff=
fffffffff8,
                                                        umax=3D0xffffffffff=
fffff8,
                                                        smax32=3D0x7ffffff8=
,
                                                        umax32=3D0xfffffff8=
,
                                                        var_off=3D(0x0; 0xf=
ffffffffffffff8)) refs=3D1
    24: (18) r2 =3D 0xffffc900000f6000      ; R2_w=3Dmap_value(map=3Dverifi=
er.bss,ks=3D4,vs=3D80) refs=3D1
    26: (0f) r2 +=3D r1
    mark_precise: frame0: last_idx 26 first_idx 21 subseq_idx -1=20
    ...
    math between map_value pointer and register with unbounded min value is=
 not allowed

At point (0) the r7 is tracked as 2, at point (1) it is widened by the
following code in the falltrhough branch processing:

+		if (ignore_pred) {
+			if (opcode !=3D BPF_JEQ && opcode !=3D BPF_JNE) {
+				widen_reg(dst_reg);
+				if (has_src_reg)
+					widen_reg(src_reg);
+			}
+			widen_reg(other_dst_reg);
+			if (has_src_reg)
+				widen_reg(other_src_reg);
+		} else {

Here src_reg is a fake register set to 4,
because comparison instruction is BPF_K it does not get widened.
So, reg_set_min_max() produces range [-SMIN,+4] for R7.
And at (2) all goes south because of the "<<" logic.
Switch to unsigned values helps because umax range is computed
instead of smax at point (1).

However, below is an example where if comparison is BPF_X.
Note that I obfuscated constant 5 as a volatile variable.
And here is what happens when verifier rejects the program:

    from 16 to 17: R0=3Drdonly_mem(id=3D6,ref_obj_id=3D1,sz=3D4) R6=3Dscala=
r(id=3D5)
                   R7=3D2 R10=3Dfp0 fp-8=3D5 fp-16=3Diter_num(ref_id=3D1,st=
ate=3Dactive,depth=3D3) refs=3D1
    17: R0=3Drdonly_mem(id=3D6,ref_obj_id=3D1,sz=3D4) R6=3Dscalar(id=3D5)
        R7=3D2 R10=3Dfp0 fp-8=3D5 fp-16=3Diter_num(ref_id=3D1,state=3Dactiv=
e,depth=3D3) refs=3D1
    17: (55) if r0 !=3D 0x0 goto pc+5       ; R0=3Drdonly_mem(id=3D6,ref_ob=
j_id=3D1,sz=3D4) refs=3D1
    ; if (i < five) @ verifier_loops1.c:299
    23: (79) r1 =3D *(u64 *)(r10 -8)        ; R1=3D5 R10=3Dfp0 fp-8=3D5 ref=
s=3D1
0-> 24: (3d) if r7 >=3D r1 goto pc-11       ; R1=3D5 R7=3D2 refs=3D1
    24: refs=3D1
    ; sum +=3D arr[i++]; @ verifier_loops1.c:300
1-> 25: (bf) r1 =3D r7                      ; R1_w=3Dscalar(id=3D7,umax=3D0=
xfffffffffffffffe)
                                            R7=3Dscalar(id=3D7,umax=3D0xfff=
ffffffffffffe) refs=3D1
    26: (67) r1 <<=3D 3                     ; R1_w=3Dscalar(smax=3D0x7fffff=
fffffffff8,umax=3D0xfffffffffffffff8,
                                                        smax32=3D0x7ffffff8=
,umax32=3D0xfffffff8,
                                                        var_off=3D(0x0; 0xf=
ffffffffffffff8)) refs=3D1
    27: (18) r2 =3D 0xffffc90000112000      ; R2_w=3Dmap_value(map=3Dverifi=
er.bss,ks=3D4,vs=3D80) refs=3D1
    29: (0f) r2 +=3D r1

Note R7 has exact value 2 at point (0) and is widened to
umax=3D0xfffffffffffffffe at point (1).
Widening happens at the same point as before, but this time src_reg is
widened as well, so there is no upper bound for r7 anymore.

---

diff --git a/tools/testing/selftests/bpf/progs/verifier_loops1.c b/tools/te=
sting/selftests/bpf/progs/verifier_loops1.c
index e07b43b78fd2..0249fb63f18b 100644
--- a/tools/testing/selftests/bpf/progs/verifier_loops1.c
+++ b/tools/testing/selftests/bpf/progs/verifier_loops1.c
@@ -283,4 +283,24 @@ exit_%=3D:                                           \
        : __clobber_all);
 }
=20
+unsigned long arr[10];
+
+SEC("socket")
+__success __flag(BPF_F_TEST_STATE_FREQ)
+int simple_loop(const void *ctx)
+{
+      volatile unsigned long five =3D 5;
+      unsigned long sum =3D 0, i =3D 0;
+      struct bpf_iter_num it;
+      int *v;
+
+      bpf_iter_num_new(&it, 0, 10);
+      while ((v =3D bpf_iter_num_next(&it))) {
+              if (i < five)
+                      sum +=3D arr[i++];
+      }
+      bpf_iter_num_destroy(&it);
+      return sum;
+}
+

