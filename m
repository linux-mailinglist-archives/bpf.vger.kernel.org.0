Return-Path: <bpf+bounces-71726-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB391BFC50A
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 15:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A1DA1A04CC0
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 13:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F5C3491EE;
	Wed, 22 Oct 2025 13:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCc7/oMM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A3F34887F
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 13:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761141348; cv=none; b=c3uFtDJfKutWdysdSfxcMEZ4K/0zsx5KQUWaw8AHyYeBS6b6nXnJXdYSdOuDE4o4REtVKw9v+H5j6HOhlTQLkm0yn6dkJLsX5YiYw3F/xD2/oOsIgNEaqqc3X2XPDPVMkL0kZZHRK5VE0hDHkS1tuzlwFKyeZd6hU94JBWzY1jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761141348; c=relaxed/simple;
	bh=XXU7DAhp4u1VmisZ6MCFdxXdLNcGpiicV9/vznhG7yQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XLQMri2TBwo257/parWKH6RiCjlgNhM/POF2xp/5sPYHncv/CJnV/1Qh21i3YXUfBnxZDPdMf8UCrR8ty0Ng+05aFevKgfsIFDX1G2f3LEhtwROIe4u+Z/rUJi5acNxV4oQTS4PqcW7Q5qTB8GB3jTpC2B0bAPSGEIldZX/L+Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCc7/oMM; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b5579235200so4463580a12.3
        for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 06:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761141346; x=1761746146; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ixSty1biBvZ1MICVjxXViCLlenG5mUqweug41nFumEU=;
        b=DCc7/oMMycQUk719rKDLeIePLcpR6NQbCV9oQigExHD0bKEcHr8c0eacRxv5tIHX0K
         B0l1hBbRq83ELr9ge7sgc8h7zy8GdNvRHjBrajlDz4Icmw49W/mMka8jVxDZGUd0YNcx
         7Fw/DWpMQQ/GtKfxq0iu2D2Pb60t0sxMzRqxiJL537QLkBCJ4tQZZfHvNtVaZS6BPJTO
         yNNenfs/6MGEY6vpv3nsiWl/zwFM0alpAxDSw6gdmEPN4Dpgg7Hx84Fi5xB1el4k00KT
         sI97xpX7D9RVY+qnf2qkFfX0WbCSp0ShHJ7XDU4EZIC91lrw8ju72YQ4PKu2+IP4/7iB
         w1Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761141346; x=1761746146;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ixSty1biBvZ1MICVjxXViCLlenG5mUqweug41nFumEU=;
        b=gOgqrVYIlgJiKM9Q8PWG4645zAxaKHx+hYQKJtiJY3E6FAUwAVkAq8Y/Z4EAAeMdvn
         YRSfQciQ3vKgpPyzWQgvsbledtsx7iKodvqKf4HW4B2nxYK4/IPKrbhRmL4qdxHtndOz
         g3ZS+jpVvsvONDbTMSFzSSUEh+WJg9cd2kq5A5UW39/tJ7KXzeaFbIvEpeg00ff/G1wp
         XPxJTdQSL17tNrLOhzRKIy91iu7vKrlONpAOupOIVvNTkhljhiJn341y6Z+GBv+heFq/
         Xut8gGwo/bJ07O10yKJPRcO0sTpPkA4xN+vHTZl6bsSL4GQnTq5PsVIVcBwtbKWQd3fe
         5sMw==
X-Gm-Message-State: AOJu0YzDau7lX8n2aMwNDL1S/UGCbQG3JyWn3yQ9owFMrF4EDJsF0EIb
	T//8PFfBV4bw5dqCeISDvEB9HcjcO7CJhqFi+x0xYyHwqdXomDduq0ug
X-Gm-Gg: ASbGncs08+5LtnfPNu0154Bx47ryyOXQV1zSkE/6hudK4b5IWPvBrIWAGT1Am6jWo+z
	g/jWp2FhGqebKpsNwzd6DNB6zUX8Pecb+eV/KdCTOpyVyUiDS46R7/FmrxJbcoTbgeyXVi5IkQl
	NmmfOJQ5sEUoLzd8GbqybnUGOUV9UznH+xtUaB8Cb6SSJ+Ns4wcw4gucD48D/bSRxtn4MfcgIar
	bf6tE5V6mqlPF7qdwBQ+dd7cLfoVwFh2+1SbuX3QfPQb1rL3C/8ki31BV6IghUm8PA1aReDgM/K
	0JcakxAKsQoZaU63nvmpBkPMi8jAUc6lYh9codyO4QV0pfVxGBm9aN/xKQt8eVXcBOLVYJjFltO
	Wc4tRfgp/4dWVNhZlN+pHhbYUG43C5DmnOrt1DNfw8BHpXXtg7y9PWEPJwmV8ZjMMy+wnx4TnxU
	4DGT4BsKI=
X-Google-Smtp-Source: AGHT+IH5cyNHkIEVDqd7I77Cw6gXx4qQrfQs7yx+1aNdJ1uoMgW8eTd7ztFMtpBvDunVEmT8IvCnIA==
X-Received: by 2002:a17:903:98b:b0:27e:ef27:1e47 with SMTP id d9443c01a7336-290caf84612mr265404665ad.31.1761141345494;
        Wed, 22 Oct 2025 06:55:45 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fed21sm139694925ad.80.2025.10.22.06.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 06:55:44 -0700 (PDT)
Message-ID: <0e98a654792b6ab8002b0cf7ddf604e20b2f8f5e.camel@gmail.com>
Subject: Re: [PATCH v6 bpf-next 05/17] selftests/bpf: add selftests for new
 insn_array map
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko	 <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>,
 Daniel Borkmann	 <daniel@iogearbox.net>, Quentin Monnet <qmo@kernel.org>,
 Yonghong Song	 <yonghong.song@linux.dev>
Date: Wed, 22 Oct 2025 06:55:41 -0700
In-Reply-To: <aPjfuZd+370hXFLJ@mail.gmail.com>
References: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
	 <20251019202145.3944697-6-a.s.protopopov@gmail.com>
	 <9660d7d3d3348bdf84c0a1a2861b66db9e2cc980.camel@gmail.com>
	 <aPjfuZd+370hXFLJ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-22 at 13:44 +0000, Anton Protopopov wrote:
> On 25/10/21 04:51PM, Eduard Zingerman wrote:
> > On Sun, 2025-10-19 at 20:21 +0000, Anton Protopopov wrote:
> > > Add the following selftests for new insn_array map:
> > >=20
> > >   * Incorrect instruction indexes are rejected
> > >   * Two programs can't use the same map
> > >   * BPF progs can't operate the map
> > >   * no changes to code =3D> map is the same
> > >   * expected changes when instructions are added
> > >   * expected changes when instructions are deleted
> > >   * expected changes when multiple functions are present
> > >=20
> > > Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> > > ---
> >=20
> > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> >=20
> > >  .../selftests/bpf/prog_tests/bpf_insn_array.c | 404 ++++++++++++++++=
++
> > >  1 file changed, 404 insertions(+)
> > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_insn_a=
rray.c
> > >=20
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c =
b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> > > new file mode 100644
> > > index 000000000000..a4304ef5be13
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> >=20
> > [...]
> >=20
> > > +static void check_bpf_no_lookup(void)
> >=20
> > This one can be moved to prog_tests/bpf_insn_array.c, I think.
>=20
> A typo? (This is a patch for the prog_tests/bpf_insn_array.c)

Yes, I mean progs/verifier_gotox.c, the one with inline assembly.

>=20
> > > +{
> > > +	struct bpf_insn insns[] =3D {
> > > +		BPF_LD_MAP_FD(BPF_REG_1, 0),
> > > +		BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
> > > +		BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
> > > +		BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
> > > +		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem=
),
> > > +		BPF_EXIT_INSN(),
> > > +	};
> > > +	int prog_fd =3D -1, map_fd;
> > > +
> > > +	map_fd =3D map_create(BPF_MAP_TYPE_INSN_ARRAY, 1);
> > > +	if (!ASSERT_GE(map_fd, 0, "map_create"))
> > > +		return;
> > > +
> > > +	insns[0].imm =3D map_fd;
> > > +
> > > +	if (!ASSERT_EQ(bpf_map_freeze(map_fd), 0, "bpf_map_freeze"))
> > > +		goto cleanup;
> > > +
> > > +	prog_fd =3D prog_load(insns, ARRAY_SIZE(insns), NULL, 0);
> > > +	if (!ASSERT_EQ(prog_fd, -EINVAL, "program should have been rejected=
 (prog_fd !=3D -EINVAL)"))
> > > +		goto cleanup;
> > > +
> > > +	/* correctness: check that prog is still loadable with normal map *=
/
> > > +	close(map_fd);
> > > +	map_fd =3D map_create(BPF_MAP_TYPE_ARRAY, 1);
> > > +	insns[0].imm =3D map_fd;
> > > +	prog_fd =3D prog_load(insns, ARRAY_SIZE(insns), NULL, 0);
> > > +	if (!ASSERT_GE(prog_fd, 0, "bpf(BPF_PROG_LOAD)"))
> > > +		goto cleanup;
> > > +
> > > +cleanup:
> > > +	close(prog_fd);
> > > +	close(map_fd);
> > > +}
> >=20
> > [...]

