Return-Path: <bpf+bounces-45976-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC59E9E0F8D
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 01:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E48EB233EC
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 00:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B444B10F2;
	Tue,  3 Dec 2024 00:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOpdJGVs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9516564D
	for <bpf@vger.kernel.org>; Tue,  3 Dec 2024 00:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733184914; cv=none; b=L1JtgcHLdkuwzvQqg7WkYM/tVWd4535EKYFIMjXnzngzt+QMY6SyjMYPieA5ck/0JDkwDO9sxypOsnKhQ2XEgus6mcRBdYxmDQTFIiTxC4JozkFPTYzKh92+tGlY8qdxYkLAnWCv7zBQx1Edpm1Pl5eQd19fDatbu7t5BLidzhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733184914; c=relaxed/simple;
	bh=RdBbDAud6EGIE4JVerzj2jGQ5AFpJOYxrsSWAGJyOg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=snhmrh84gsp9CcN5nyYHiaIyR+dgybz1intkuRaDSpWbgekQN6YC/PR5Wk3U/575u3MGKJYbp+GrHMqzIapFXKdH6gFa6hB9gSGWNYNB4IJ1vyfToND8lagts0Zea7F7n2iCYlru6/wUW7V3QzsCgsaBt7yeF0CAlmCO13rf+Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EOpdJGVs; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ee989553c1so1840170a91.3
        for <bpf@vger.kernel.org>; Mon, 02 Dec 2024 16:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733184912; x=1733789712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4Ul5/43HybrhVMnDSG9HKkBbrMkZ+SU7VvHndYVkDM=;
        b=EOpdJGVskkz7D36Av9dEn8ar8HSrXSmynrmtXNDTQml6HDs+bKxwPrudnIOwg2d8N9
         RaaEleQUqhhVcDcmbLjJ58KTIuB7Y6iWCfXcbnC2q8x4aXdSxLpCMsS4JW/h8DyonW4w
         Rmemr8DxiEqKp3I3MPXvgLQ/qu3U8hnTHdkJVuf90pYMxq7ez/Kc9Xvkxw9DtaisOOx2
         R8+5144jbGaQCfXao/5sUNYYyIx0PR0LFUQSFe9GHkteLWKTa4tN4xO877n/5PJDGE+G
         a1gZKTdFMd7wB9wQSwyXkwOFpC5Fdb9iqwWoaCEEnIaiOdOpqUcg7jusmQ0dx3yEKnlD
         h3ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733184912; x=1733789712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a4Ul5/43HybrhVMnDSG9HKkBbrMkZ+SU7VvHndYVkDM=;
        b=Cgl87CXrZY7mW+Pdf7Pz0VfRlVp0CWxiOwEVw9Sm+yLotcePaTTHFrLnV834deQfGV
         9RS9UvpJa1nbBLX3gEsU8dBQ7ofOEaWhDqL5dASJBVdu/u0cZEywcT3vF3+18u1hBRcy
         svhV0TvWoHtyoYZgrxtltTITBdcW6ALzyry1qSHdZWX1CKBDZIc+KIhNcf0n+gQx10lk
         XZlhBtgfw/XkkBN4FA4sDXy3rYhluXTML8O2kKQawRz6iuR5zQ1adpeIIZOdiME/oajj
         yBfD7kpqPm3+yORdJLgL8SxO0Jt6BiSYM5GUPWs1DWtMHp5V7IWl8d4FpWOCNvybsetb
         VlhA==
X-Gm-Message-State: AOJu0Yw3S2ZfMfvx+NZXBuu7oO5VwUrIQ5LGHa4led+7vAyqisLByjWW
	xjJhpLOPxwpSNmg/54l90kC6cjIRPy9kJd/t5bXABrrp4Ot8TEx13SuG6o6Iuej/t5KVl3yhS3d
	WFX5H9IdfTsZ9/8dtvl+Yfqp3RK3Wog==
X-Gm-Gg: ASbGnctgNsce+SB+N9UIMk9bU2QKzviOPcZhP+PvlARZ/N96Iv2D0OoWrWtIWaigigi
	ejWfRepSi1z3qACRQrc2P7z+C/AySQcijkK+l9XiGtCzpO8U=
X-Google-Smtp-Source: AGHT+IEPANuOiybeQnAfrkBlwRaWgfo0GOdRcTCd3sc2Q/8tNXo6o+uSTE6LrjxwWciBzNzkegjCCUbWsSsfM3uYy4k=
X-Received: by 2002:a17:90b:2547:b0:2ee:fa3f:4740 with SMTP id
 98e67ed59e1d1-2ef012759b6mr819099a91.35.1733184911681; Mon, 02 Dec 2024
 16:15:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202083814.1888784-1-memxor@gmail.com> <20241202083814.1888784-4-memxor@gmail.com>
In-Reply-To: <20241202083814.1888784-4-memxor@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 2 Dec 2024 16:14:57 -0800
Message-ID: <CAEf4Bzb5mhOM34eOtekMH8ebTHNL9ukrHkckWLTAuYz9DFhoOg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/5] selftests/bpf: Introduce __caps_unpriv
 annotation for tests
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, kkd@meta.com, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, Tao Lyu <tao.lyu@epfl.ch>, 
	Mathias Payer <mathias.payer@nebelwelt.net>, Meng Xu <meng.xu.cs@uwaterloo.ca>, 
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 12:38=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> From: Eduard Zingerman <eddyz87@gmail.com>
>
> Add a __caps_unpriv annotation so that tests requiring specific
> capabilities while dropping the rest can conveniently specify them
> during selftest declaration instead of munging with capabilities at
> runtime from the testing binary.
>
> While at it, let us convert test_verifier_mtu to use this new support
> instead.
>
> The original diff for this idea is available at link [0].
>
>   [0]: https://lore.kernel.org/bpf/a1e48f5d9ae133e19adc6adf27e19d585e06ba=
b4.camel@gmail.com
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> [ Kartikeya: rebase on bpf-next, remove unnecessary bits, convert test_ve=
rifier_mtu ]
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/verifier.c       | 19 +--------
>  tools/testing/selftests/bpf/progs/bpf_misc.h  |  2 +
>  .../selftests/bpf/progs/verifier_mtu.c        |  3 +-
>  tools/testing/selftests/bpf/test_loader.c     | 41 +++++++++++++++++++
>  4 files changed, 46 insertions(+), 19 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/te=
sting/selftests/bpf/prog_tests/verifier.c
> index d9f65adb456b..3ee40ee9413a 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> @@ -225,24 +225,7 @@ void test_verifier_xdp(void)                  { RUN(=
verifier_xdp); }
>  void test_verifier_xdp_direct_packet_access(void) { RUN(verifier_xdp_dir=
ect_packet_access); }
>  void test_verifier_bits_iter(void) { RUN(verifier_bits_iter); }
>  void test_verifier_lsm(void)                  { RUN(verifier_lsm); }
> -
> -void test_verifier_mtu(void)
> -{
> -       __u64 caps =3D 0;
> -       int ret;
> -
> -       /* In case CAP_BPF and CAP_PERFMON is not set */
> -       ret =3D cap_enable_effective(1ULL << CAP_BPF | 1ULL << CAP_NET_AD=
MIN, &caps);
> -       if (!ASSERT_OK(ret, "set_cap_bpf_cap_net_admin"))
> -               return;
> -       ret =3D cap_disable_effective(1ULL << CAP_SYS_ADMIN | 1ULL << CAP=
_PERFMON, NULL);
> -       if (!ASSERT_OK(ret, "disable_cap_sys_admin"))
> -               goto restore_cap;
> -       RUN(verifier_mtu);
> -restore_cap:
> -       if (caps)
> -               cap_enable_effective(caps, NULL);
> -}
> +void test_verifier_mtu(void)                 { RUN(verifier_mtu); }
>
>  static int init_test_val_map(struct bpf_object *obj, char *map_name)
>  {
> diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing=
/selftests/bpf/progs/bpf_misc.h
> index eccaf955e394..cd9dd427a91d 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_misc.h
> +++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
> @@ -106,6 +106,7 @@
>   * __arch_*          Specify on which architecture the test case should =
be tested.
>   *                   Several __arch_* annotations could be specified at =
once.
>   *                   When test case is not run on current arch it is mar=
ked as skipped.
> + * __caps_unpriv     Specify the capabilities that should be set when ru=
nning the test
>   */
>  #define __msg(msg)             __attribute__((btf_decl_tag("comment:test=
_expect_msg=3D" XSTR(__COUNTER__) "=3D" msg)))
>  #define __xlated(msg)          __attribute__((btf_decl_tag("comment:test=
_expect_xlated=3D" XSTR(__COUNTER__) "=3D" msg)))
> @@ -129,6 +130,7 @@
>  #define __arch_x86_64          __arch("X86_64")
>  #define __arch_arm64           __arch("ARM64")
>  #define __arch_riscv64         __arch("RISCV64")
> +#define __caps_unpriv(caps)    __attribute__((btf_decl_tag("comment:test=
_caps_unpriv=3D" XSTR(caps))))
>
>  /* Convenience macro for use with 'asm volatile' blocks */
>  #define __naked __attribute__((naked))
> diff --git a/tools/testing/selftests/bpf/progs/verifier_mtu.c b/tools/tes=
ting/selftests/bpf/progs/verifier_mtu.c
> index 70c7600a26a0..88b1fa5f6030 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_mtu.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_mtu.c
> @@ -6,7 +6,8 @@
>
>  SEC("tc/ingress")
>  __description("uninit/mtu: write rejected")
> -__failure __msg("invalid indirect read from stack")
> +__success __failure_unpriv __msg_unpriv("invalid indirect read from stac=
k")

nit: I'd move unpriv specification to a separate line to make it
easier to follow that __success is for privileged, while unpriv has
expected failure with a message
> +__caps_unpriv(CAP_BPF)

original code was setting both CAP_BPF and CAP_NET_ADMIN, but you are
changing to just CAP_BPF? Any reason why?


>  int tc_uninit_mtu(struct __sk_buff *ctx)
>  {
>         __u32 mtu;

[...]

