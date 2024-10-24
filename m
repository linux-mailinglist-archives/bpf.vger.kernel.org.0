Return-Path: <bpf+bounces-43053-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 136A89AEA79
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 17:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 944EBB2092B
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 15:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA1B1F5840;
	Thu, 24 Oct 2024 15:28:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2741F4FBC;
	Thu, 24 Oct 2024 15:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729783735; cv=none; b=CqR8UJzKuk+FcZIY3z9gjcfAPzeKnNk2zYUsLVbJ5Wtw/P14R4X3J9Y6dWIDseezhruIUgN1zsV6ZXPGiJqlt4Bs0uySg62Sh5itTesyv2DYND1EhbpGcCSaAfhvD0oOO+6lhK0UqfazFBKotBOkri+r3EATS8W4oiDkQAx/BXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729783735; c=relaxed/simple;
	bh=Wa/lBblz8zjg3K8a5GZVELp9ATHR0GpBk3nPK66gzHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iBYMK6I60N1vUjKgLddnIotRaLBnWTAPLP81uD3NGTEOh15eYncNMSfdRIS8KAcCEKda/zjFXFsheivS6YrY/Rad4jI/wrbRuUe2w/TbAaJpHapuY8Swuw7azrPgfjfAgJ6/HalxwU+/ZaJS3D2oejBMxvVGM5pgiPFa9ypgIs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-83aff992087so44914739f.3;
        Thu, 24 Oct 2024 08:28:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729783732; x=1730388532;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CHw3/FAGgd1iO3/H3N2rtqx/81x0A/R4/DsL+0VLYc0=;
        b=MEHRILrUanCyVYccVSS3u1kVGKDueTgSf5sZufqhq/7Oo3ARCPPYH2Hyt9RPOblZm3
         ptvQCUUr3Qgi7tX2k05+UbBmBVv++hDZ9F5lDvLwVuFZZnFwwVwAU5wfv2Ojqk+W2Uj5
         IvxiusDq6/L0U1aapMil0Nv3ZD1ucTr7uSfGZ8mCW7rvqnlDiQ3jg8EeOZfqVELeeLWi
         0YTl0O1ONyP6FdS2e9eonbc+Uyer6odYyJrvTzXd1aVPVKED39f9G1J666NGsv2WpHoi
         LMIXfQDbOIB5JyEZQOgE8l4mFolW1uoDd2HJIhsJdbSrbDpgeLwRSbc6jGGsT+efvAyV
         KQpA==
X-Forwarded-Encrypted: i=1; AJvYcCVDqx/DX4W0HJKM6zYTfWR66UUFl87oUgTXjeOkRe5WY1QkBiinTGgWFqEoNkRcyfXiuWjzelpfOf3ym1E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6V48ab99z4OwMZRSaDxj/W0ou7nLtVh64H0P4+xIUBqC1NJkV
	zEPFZquCc0uJP0voeZTpMl6AYnGuyU5OmBkJuKnEaMJNUL4Tv1A9
X-Google-Smtp-Source: AGHT+IGyyklvlcShkZHydXmk6sdPP0CT8P2KZkA9ch5qq8b8L0RNr9KgCxszEmSlNtN8EeBFMVpLig==
X-Received: by 2002:a05:6602:3c4:b0:835:359b:8a07 with SMTP id ca18e2360f4ac-83b041bacf1mr283365339f.16.1729783732451;
        Thu, 24 Oct 2024 08:28:52 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc2a6301c4sm2688533173.153.2024.10.24.08.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 08:28:51 -0700 (PDT)
Date: Thu, 24 Oct 2024 10:28:49 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>, kernel-team@meta.com,
	sched-ext@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.13 1/2] sched_ext: Rename CFI stubs to
 names that are recognized by BPF
Message-ID: <20241024152849.GA140253@maniforge>
References: <Zxma0Vt6kwWFe1hx@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uWMMB4gSplatliRm"
Content-Disposition: inline
In-Reply-To: <Zxma0Vt6kwWFe1hx@slm.duckdns.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--uWMMB4gSplatliRm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 02:54:41PM -1000, Tejun Heo wrote:
> CFI stubs can be used to tag arguments with __nullable (and possibly other
> tags in the future) but for that to work the CFI stubs must have names th=
at
> are recognized by BPF. Rename them.
>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>

For both patches:

Acked-by: David Vernet <void@manifault.com>

Here's the selftest output for posterity / FYI:

[root@virtme-ng sched_ext]# ./runner -t maybe_null
=3D=3D=3D=3D=3D START =3D=3D=3D=3D=3D
TEST: maybe_null
DESCRIPTION: Verify if PTR_MAYBE_NULL work for .dispatch
OUTPUT:
libbpf: prog 'maybe_null_fail_dispatch': BPF program load failed: Permissio=
n denied
libbpf: prog 'maybe_null_fail_dispatch': -- BEGIN PROG LOAD LOG --
Global function maybe_null_fail_dispatch() doesn't return scalar. Only thos=
e are supported.
0: R1=3Dctx() R10=3Dfp0
; void BPF_STRUCT_OPS(maybe_null_fail_dispatch, s32 cpu, struct task_struct=
 *p) @ maybe_null_fail_dsp.bpf.c:15
0: (79) r1 =3D *(u64 *)(r1 +8)          ; R1_w=3Dtrusted_ptr_or_null_task_s=
truct(id=3D1)
; vtime_test =3D p->scx.dsq_vtime; @ maybe_null_fail_dsp.bpf.c:17
1: (79) r1 =3D *(u64 *)(r1 +848)
R1 invalid mem access 'trusted_ptr_or_null_'
processed 2 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak=
_states 0 mark_read 0
-- END PROG LOAD LOG --
libbpf: prog 'maybe_null_fail_dispatch': failed to load: -13
libbpf: failed to load object 'maybe_null_fail_dsp'
libbpf: failed to load BPF skeleton 'maybe_null_fail_dsp': -13
libbpf: prog 'maybe_null_fail_yield': BPF program load failed: Permission d=
enied
libbpf: prog 'maybe_null_fail_yield': -- BEGIN PROG LOAD LOG --
0: R1=3Dctx() R10=3Dfp0
; bool BPF_STRUCT_OPS(maybe_null_fail_yield, struct task_struct *from, @ ma=
ybe_null_fail_yld.bpf.c:15
0: (b7) r2 =3D 2328                     ; R2_w=3D2328
1: (79) r1 =3D *(u64 *)(r1 +8)          ; R1_w=3Dtrusted_ptr_or_null_task_s=
truct(id=3D1)
2: (bf) r3 =3D r1                       ; R1_w=3Dtrusted_ptr_or_null_task_s=
truct(id=3D1) R3_w=3Dtrusted_ptr_or_null_task_struct(id=3D1)
3: (0f) r3 +=3D r2
R3 pointer arithmetic on trusted_ptr_or_null_ prohibited, null-check it fir=
st
processed 4 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak=
_states 0 mark_read 0
-- END PROG LOAD LOG --
libbpf: prog 'maybe_null_fail_yield': failed to load: -13
libbpf: failed to load object 'maybe_null_fail_yld'
libbpf: failed to load BPF skeleton 'maybe_null_fail_yld': -13
ok 1 maybe_null #
=3D=3D=3D=3D=3D  END  =3D=3D=3D=3D=3D


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

RESULTS:

PASSED:  1
SKIPPED: 0
FAILED:  0


--uWMMB4gSplatliRm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZxpnsQAKCRBZ5LhpZcTz
ZN9OAP9ixANrOXLXbTeswGXzt0jLBTQz9H/2x707oHohQy76lQD9GbF33Li8J93X
Ul16haFzaXzgO65ICnqV8Mrlgf9d9QI=
=Uiak
-----END PGP SIGNATURE-----

--uWMMB4gSplatliRm--

