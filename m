Return-Path: <bpf+bounces-30809-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 522B88D29C5
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 03:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5EB41F2672E
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 01:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFC615A85C;
	Wed, 29 May 2024 01:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDw2jgE3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38723D2FE
	for <bpf@vger.kernel.org>; Wed, 29 May 2024 01:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716944941; cv=none; b=nohAzDmoTobG7MTObvdvj7Pjupv5ITEo7UrIc2caV0vxCUzmt86rkA/d06nqac8iMRL8REwotdbVDkqJ4tYBlpbEUJ4+B7twFDQlWwAf8B02VKc3p0EEUD6FqWxiNgPvvIqQDgzFBe7r8oW4YkXJbT1aaIh43reL/crbkVXVn4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716944941; c=relaxed/simple;
	bh=kLy7lZ3b3CLA0TfXTaah6usVGc7nfhiHZqXH5wx+zTE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y4D/rrWkcd9N+/vpn0/G7818N1mHD/E2bLSMJzPJRTUDaQLDhWszB5AbtKsLRrj+TcvwjVVB85A/gtrhMTM4kpEcrfMG6HjQbkgbBaH6Ybaewhmw51UeX/sbabtPepSi8tr9IqZFsxUAoKQbRxUd7Wqa90u0ibJ0J/T2bx03cS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aDw2jgE3; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f480624d04so13288025ad.2
        for <bpf@vger.kernel.org>; Tue, 28 May 2024 18:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716944939; x=1717549739; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CfaR2EAaZ7O72vnXSmEnoeC5aBgT1yRvNzwQ3S5el6Q=;
        b=aDw2jgE32G1TU12I5NE3zC+8z1fw1i0UK6F/bCz4LvRUX4JrIzCs3Wscf34jQH/fP8
         gfEVmV1m3waf5gfo8WzIYawLD+nP7y7K4U+flwPuvv73UdeaATfh8XBLalUj6V5xuQzQ
         OD7u6KeIGNdaP5ssxc6vbeyuwKv7qfmFqpsRML43kG+Lj37dTCv4p37FRUy3cLpGPug5
         4k/PLNWuS1eTdB35eQdb10rCk7Q68R/sFA4TtBBKKFmvYVbi9j8yPd9EXXxOVIpqyeEH
         /dANjNnoKadOcvCjkbxDOWWDdTkgGsLmdCZ58gy+DuJS1Oslsuamlig04OXAgrCB+Lx3
         9boA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716944939; x=1717549739;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CfaR2EAaZ7O72vnXSmEnoeC5aBgT1yRvNzwQ3S5el6Q=;
        b=wnORxMqvkcGhF66SPzhRSWIew0AgHXe2l7qWKulR5M9IoRwIMARXYEbkKptncy3G27
         JEgTe5eFKF9qa9AC9fw4J+XGaCZl3mIselExXh607zDKx/ddc/vgw5D0wfHT6lp3ag7k
         GWRP6VJQFokarXrxUATcSYDIaTJ+QcsneWpxTpWNm2PgtrtETWtaMlPLnxV1l58yCbaq
         csRvlKt1UKSk2U/MlRJVyCaQy4mKvBg21gcmLba2rGTrN/gWtxRMTEMrppPW0moB1Uyn
         NphKsJRjjAEEObjodfRy3HPOZO+UGxVe192CEDp02nmnSKqPEz0jd2GgnVb4daABomfN
         j3hA==
X-Gm-Message-State: AOJu0YwThaKs8IdsWTsaJkrcki302kIzp6MZ0A+ZLnYPlHUHmrOCU+0+
	QrrQFegoELr+48W/aWDwBYhuqQ6VXYWs/UqdnIjE2blYNIz/lgrw
X-Google-Smtp-Source: AGHT+IGVB/uG8Jr5IKU7+gKhwDosqwfcc9e1lCo46z3lpHXmHDwtdLIm+TAwv3Cuf+k5arifEtCcGg==
X-Received: by 2002:a17:902:ecc7:b0:1f4:81c0:b0d5 with SMTP id d9443c01a7336-1f481c0b2d4mr112516165ad.12.1716944939285;
        Tue, 28 May 2024 18:08:59 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160::3424? ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c79c545sm86913295ad.77.2024.05.28.18.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 18:08:58 -0700 (PDT)
Message-ID: <ceec0883544b6855b7d1fda2884de775414a56c4.camel@gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/2] bpf: Relax precision marking in open
 coded iters and may_goto loop.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel
 Team <kernel-team@fb.com>
Date: Tue, 28 May 2024 18:08:57 -0700
In-Reply-To: <CAADnVQJdaQT_KPEjvmniCTeUed3jY0mzDNLUhKbFjpbjApMJrA@mail.gmail.com>
References: <20240525031156.13545-1-alexei.starovoitov@gmail.com>
	 <90874d4e32e7fe937c6774ad34d1617592b8abc8.camel@gmail.com>
	 <CAADnVQJdaQT_KPEjvmniCTeUed3jY0mzDNLUhKbFjpbjApMJrA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-05-28 at 17:34 -0700, Alexei Starovoitov wrote:

[...]

> > I'm not sure how much of a deal-breaker this is, but proposed
> > heuristics precludes verification for the following program:
>=20
> not quite.
>=20
> >   char arr[10];
> >=20
> >   SEC("socket")
> >   __success __flag(BPF_F_TEST_STATE_FREQ)
> >   int simple_loop(const void *ctx)
> >   {
> >         struct bpf_iter_num it;
> >         int *v, sum =3D 0, i =3D 0;
> >=20
> >         bpf_iter_num_new(&it, 0, 10);
> >         while ((v =3D bpf_iter_num_next(&it))) {
> >                 if (i < 5)
> >                         sum +=3D arr[i++];
> >         }
> >         bpf_iter_num_destroy(&it);
> >         return sum;
> >   }
> >=20
> > The presence of the loop with bpf_iter_num creates a set of states
> > with non-null loop_header, which in turn switches-off predictions for
> > comparison operations inside the loop.
>=20
> Is this a pseudo code ?

No, I tried this test with v3 of this patch and on master.
It passes on master and fails with v3.
(Full test in the end of the email, I run it as
 ./test_progs -vvv -a verifier_loops1/simple_loop).

> Because your guess at the reason for the verifier reject is not correct.
> It's signed stuff that is causing issues.
> s/int i/__u32 i/
> and this test is passing the verifier with just 143 insn processed.

I'm reading through verifier log, will get back shortly.

> > This looks like a bad a compose-ability of verifier features to me.
>=20
> As with any heuristic there are two steps forward and one step back.
> The heuristic is trying to minimize the size of that step back.
> If you noticed in v1 and v2 I had to add 'if (!v) break;'
> to iter_pragma_unroll_loop().
> And it would have been ok this way.
> It is a step back for a corner case like iter_pragma_unroll_loop().
> Luckily this new algorithm in v3 doesn't need this if (!v) workaround
> anymore. So the step back is minimized.
> Is it still there? Absolutely. There is a chance that some working prog
> will stop working. (as with any verifier change).

Not sure I understand how 'if (!v) break;' is relevant.
The patch says:

+		ignore_pred =3D (get_loop_entry(this_branch) ||
+			       this_branch->may_goto_depth) &&
+				/* Gate widen_reg() logic */
+				env->bpf_capable;

get_loop_entry(this_branch) would return true for states inside a
'while' because of the bpf_iter_num_next() calls.
Hence, predictions for all conditionals inside the loop would be
ignored and also src/dst registers would be widened because comparison
is not JEQ/JNE.

[...]

> Just like i=3Dzero is magical.
> All such magic has to go. The users should write normal C.

Noted.

---

diff --git a/tools/testing/selftests/bpf/progs/verifier_loops1.c b/tools/te=
sting/selftests/bpf/progs/verifier_loops1.c
index e07b43b78fd2..1ebf0c829d5e 100644
--- a/tools/testing/selftests/bpf/progs/verifier_loops1.c
+++ b/tools/testing/selftests/bpf/progs/verifier_loops1.c
@@ -283,4 +283,22 @@ exit_%=3D:                                           \
        : __clobber_all);
 }
=20
+char arr[10];
+
+SEC("socket")
+__success __flag(BPF_F_TEST_STATE_FREQ)
+int simple_loop(const void *ctx)
+{
+      struct bpf_iter_num it;
+      int *v, sum =3D 0, i =3D 0;
+
+      bpf_iter_num_new(&it, 0, 10);
+      while ((v =3D bpf_iter_num_next(&it))) {
+              if (i < 5)
+                      sum +=3D arr[i++];
+      }
+      bpf_iter_num_destroy(&it);
+      return sum;
+}
+
 char _license[] SEC("license") =3D "GPL";

