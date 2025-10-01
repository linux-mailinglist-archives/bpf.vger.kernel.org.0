Return-Path: <bpf+bounces-70127-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEDCBB1754
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 20:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D55ED19218C7
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 18:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841382D3EE0;
	Wed,  1 Oct 2025 18:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SF3BQPsU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467AA17AE1D
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 18:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759342465; cv=none; b=J9Ml+uLr4LQEDNWsL/25+4/4wp9FWFQJ2ahqhzsQPrn3T/2xdHxFqOrnm1nCMi9P/DDdAJU4kzk9KMuw+KegwN+KhyyttcbaJYTQ2AHlHJn4a5R4NpqMLnKL0l0mw4hfLAAWS7ghLXQr/gS8wq1Nk3ulRtnxPN7LBZF+QvDyE9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759342465; c=relaxed/simple;
	bh=xe98Lhw7LN5iEPgVytaXr1jp4D0iugEZP+IAAXeLzcU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PJidw9PF3G5mW0jQgN3lrfIG7OvMojZzp4zWrQYrnDWIlEulCPujqeyUdqB+xSGadRiv1InkBCbbZJJzW1BhWHwg2rzszZ6NJV3HiLOdaN0SrJh7iOiGABiA71A9HKr/mTtJZDcT1VZqgSlh/hUGc3UgBxCzRRt65IVNQyNyWyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SF3BQPsU; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-33082aed31dso276199a91.3
        for <bpf@vger.kernel.org>; Wed, 01 Oct 2025 11:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759342463; x=1759947263; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OvHGNFVBS9g+ye3VGLtSJiliXheVt4FuI8i4MMUEQk0=;
        b=SF3BQPsU/IwE7QFtfecoLUb8AWRgdMHFhBm/r54VXWDZtHcAoK6Xhw7/kiB2Mz0waB
         l15S6o3f5vH4w/QQjD8Xq7hkX3ZH9qxVKYvLzEaRCR3EnBmLYP8vhJi6EpJ7GxqKIZ8k
         hYrZHDkJesM2qog1Kpg0ZzCRERwt3IKJ6g3Pem+SKw+JSA3oiakXRDGbXmPyaB34Wj0a
         tEYn/2uX2V1hIlCoiF/PAh4IeapgE23mxH9XWb2r/IXk7W3tRhy/USQEgbul2M80ppw5
         y4l4bpQHuJL/j7USmG+xBT32p1k4vv9Vx+xcUkcVeflp7c0vz2XcUGGAeMkSwRFgSgnz
         W45g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759342463; x=1759947263;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OvHGNFVBS9g+ye3VGLtSJiliXheVt4FuI8i4MMUEQk0=;
        b=XdQ4AI/4Osdm2+2n7DPu87jk8O+bwai6hWtG7nwarv/lQVSqPUvaZypUnDrwnKh/xp
         URcvlCtVYp2hvLJZbI/1Bs01piYdlifLNyTi43wW9FwxEzqEbUqFXNFUM7eUmwPYZ01h
         5gjUq96gGvhTlR59BfPNSpD/OwefVNaFWuixhjQG9fDA+MgxWvUkznz9KK1l8gZBF4Ao
         XnsIh/L+fNb+JUkMN7nUpowDwtdy2l3VvdDlcvAi/dSafsG6gCWL8sFL4vP5hk2kUeWq
         DdXQyWEOV2cvOa07cSF9JYV4On6yiCMZZnI4FpVwNZo9mYXO9QpUkAKJSu4nvflnK4Tj
         fS4A==
X-Forwarded-Encrypted: i=1; AJvYcCVyspIN0NedZjJTmUTCaeN+pLlXd13uKvYtT/BuM3MtSe+kAEoJUVQGjD94Bz48ERdBJL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUvpdRaqXut6fM6DtZCZp0FZbo0/Uignq8OZK5ifmW5luFMhqg
	w+qGKqeQavn/fLmUqISLP+KAu+K1zLNikAH0Nv8ooneuAa377wUCO1oiRPNl1q4j
X-Gm-Gg: ASbGncuNTTIDmyClHTKfMzyrQ5q5n8KaVvqrn0QZYt8ujiUaTIrZ0t1bjKj1kRfNK29
	Y+JrAii6y+ZRMx6WNLSpoJuPITBYZ3oOqAoGVHCuHCsQvCtX+z2G3EqqV4QTNZyBkgWamyC9FjZ
	ecSZELmOUoDRXK4DY7taTdTa4Nv1KFyjgr1aU/jiXVvVHW+s2uHEbsmMSFpkZ9UeU7RL4DkM+u1
	A6KNNrjCiz0juqoNsWOJZojYAHjL2w9g6AWNA1T42zbKwag20zWfxH27QRescFplBDdyY5bQUXo
	KGw4YNM9QuI1JqbCD2PnkZhK0vRFN5hlsQUc8QH+sVRl5KJU2jadE5D6sdFbhKcbtiAmk+TRI2J
	C+GRTrBG3YYX+zBc96m/oizc69t1S5sWtVCzvMoGPfvSHKfr+gNYjFV67jTcHY4lNj8X1VFRrdV
	iUdc2LyA==
X-Google-Smtp-Source: AGHT+IE4ja9rb0uqnbaM+/U2g/4af/dafj/NRjkIAnoRvhZuTKoph6UKxZxtJ+6qt4mtZ6+RC/DFfQ==
X-Received: by 2002:a17:90b:4c4b:b0:32d:d5f1:fe7f with SMTP id 98e67ed59e1d1-339a6ea6944mr5075134a91.15.1759342463464;
        Wed, 01 Oct 2025 11:14:23 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:1ed4:e17:bedc:abbb? ([2620:10d:c090:500::6:420a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339b4eb06cdsm343731a91.8.2025.10.01.11.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 11:14:23 -0700 (PDT)
Message-ID: <ce95e0574660f0f9d8cc2a280957aa4f922e6458.camel@gmail.com>
Subject: Re: [PATCH bpf] bpf: Correctly reject negative offsets for ALU ops
From: Eduard Zingerman <eddyz87@gmail.com>
To: yazhoutang@foxmail.com, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, 	kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, Yazhou Tang
 <tangyazhou518@outlook.com>, Shenghao Yuan <shenghaoyuan0928@163.com>,
 Tianci Cao	 <ziye@zju.edu.cn>
Date: Wed, 01 Oct 2025 11:14:21 -0700
In-Reply-To: <tencent_70D024BAE70A0A309A4781694C7B764B0608@qq.com>
References: <tencent_70D024BAE70A0A309A4781694C7B764B0608@qq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-09-30 at 23:04 +0800, yazhoutang@foxmail.com wrote:
> From: Yazhou Tang <tangyazhou518@outlook.com>
>
> When verifying BPF programs, the check_alu_op() function validates
> instructions with ALU operations. The 'offset' field in these
> instructions is a signed 16-bit integer.
>
> The existing check 'insn->off > 1' was intended to ensure the offset is
> either 0, or 1 for BPF_MOD/BPF_DIV. However, because 'insn->off' is
> signed, this check incorrectly accepts all negative values (e.g., -1).
>
> This commit tightens the validation by changing the condition to
> '(insn->off !=3D 0 && insn->off !=3D 1)'. This ensures that any value
> other than the explicitly permitted 0 and 1 is rejected, hardening the
> verifier against malformed BPF programs.
>
> Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> Co-developed-by: Tianci Cao <ziye@zju.edu.cn>
> Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
> Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
> ---

The change makes sense to me.
Could you please add a selftest?
Something like this:

---- 8< ------------------------------

diff --git a/tools/testing/selftests/bpf/progs/verifier_sdiv.c b/tools/test=
ing/selftests/bpf/progs/verifier_sdiv.c
index 148d2299e5b4..c0f7e6d82e13 100644
--- a/tools/testing/selftests/bpf/progs/verifier_sdiv.c
+++ b/tools/testing/selftests/bpf/progs/verifier_sdiv.c
@@ -1221,4 +1221,20 @@ int dummy_test(void)

 #endif

+#include "../../../include/linux/filter.h"
+
+SEC("socket")
+__failure __msg("BPF_ALU uses reserved fields")
+__naked void div_bad_off(void)
+{
+       asm volatile(
+               "r0 =3D 1;"
+               ".8byte %[bad_div];"
+               "r0 =3D 0;"
+               "exit;"
+       :
+       : __imm_insn(bad_div, BPF_RAW_INSN(BPF_ALU64 | BPF_DIV | BPF_X, 0, =
0, -1, 0))
+       : __clobber_all);
+}
+

------------------------------ >8 ----

But maybe wrap this with a macro, to try different opcodes and offsets/imm.

>  kernel/bpf/verifier.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9fb1f957a093..8979a84f9253 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -15739,7 +15739,7 @@ static int check_alu_op(struct bpf_verifier_env *=
env, struct bpf_insn *insn)
>  	} else {	/* all other ALU ops: and, sub, xor, add, ... */
>
>  		if (BPF_SRC(insn->code) =3D=3D BPF_X) {
> -			if (insn->imm !=3D 0 || insn->off > 1 ||
> +			if (insn->imm !=3D 0 || (insn->off !=3D 0 && insn->off !=3D 1) ||
>  			    (insn->off =3D=3D 1 && opcode !=3D BPF_MOD && opcode !=3D BPF_DIV=
)) {
>  				verbose(env, "BPF_ALU uses reserved fields\n");
>  				return -EINVAL;
> @@ -15749,7 +15749,7 @@ static int check_alu_op(struct bpf_verifier_env *=
env, struct bpf_insn *insn)
>  			if (err)
>  				return err;
>  		} else {
> -			if (insn->src_reg !=3D BPF_REG_0 || insn->off > 1 ||
> +			if (insn->src_reg !=3D BPF_REG_0 || (insn->off !=3D 0 && insn->off !=
=3D 1) ||
>  			    (insn->off =3D=3D 1 && opcode !=3D BPF_MOD && opcode !=3D BPF_DIV=
)) {
>  				verbose(env, "BPF_ALU uses reserved fields\n");
>  				return -EINVAL;

Nit: personally, I'd change this whole 'if' block to something like below:

                bool good_off =3D insn->off =3D=3D 0 ||
                                (insn->off =3D=3D 1 && (opcode =3D=3D BPF_M=
OD || opcode =3D=3D BPF_DIV));
                bool good_imm =3D BPF_SRC(insn->code) =3D=3D BPF_X
                                ? insn->imm =3D=3D 0
                                : insn->src_reg =3D=3D BPF_REG_0;

                if (!good_off || !good_imm) { // (or make these bad_off and=
 bad_imm)
                        verbose(private_data: env, fmt: "BPF_ALU uses reser=
ved fields\n");
                        return -EINVAL;
                }

                if (BPF_SRC(insn->code) =3D=3D BPF_X) {
                        err =3D check_reg_arg(env, regno: insn->src_reg, t:=
 SRC_OP);
                        if (err)
                                return err;
                }

     imo, a bit easier to read, but feel free to ignore this suggestion.

