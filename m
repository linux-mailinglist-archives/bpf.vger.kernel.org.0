Return-Path: <bpf+bounces-71727-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC51BFC57A
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 16:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2486534E42B
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 14:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5390834AAEF;
	Wed, 22 Oct 2025 14:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1F5l/3S"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E636D34886A
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 14:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761141620; cv=none; b=NENjeax6qd5pa/+Iw3eIHNYMaVOXEgQNftljijE2PQQ4Gs7gABgnpIqEM4ZMsN/5JAuWBXuLCgMEFiwcRpwZxs0HgCiOuqOovpMht7lhB7BmETub+hSJi0V741e10Zh65jTw4n1DEGbMUHomzEsnc1V+X9CruJuijAfGH2vRcNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761141620; c=relaxed/simple;
	bh=02gJm9yRhmRUHaWkoQfr/MlG33omZZWG4wsfXHE5RpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0vkRNJcVME6RJ0iFL3SJY6oaYnoWWaQfTnohfdb8tIqspAaULs2CbaF/Z2otUoZF4kEg7+nZZvfH5UIyWQ4WQikd+JTj1ksz5fMuiuDv6iPUf3HSKO7dYyOS66r6QzlZt66WQ8dwDOfOU9snHUnCXk39ueHSMiKixmmV4tlmfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1F5l/3S; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-426fc536b5dso3872266f8f.3
        for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 07:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761141617; x=1761746417; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Re1JSCl2Jc24qdiTwXoEjtfmXZ9sVqIUqkpQs6nWQE=;
        b=e1F5l/3SlwqnWkllc9IK0NeijFTS7tUsyWuR/dPdbozU8emNe88lNP2mPhrBv5AsQg
         agejUEfdmdzqE8rEC/usB/MKFwlQiA14Kg+hgc8ZrWPQeObHa5jdcCdsh/G3nQIw5HSi
         gafjxaUPoq5FQsuslTwnEfYL7xRNH79qgHx7X0aCiR7aaDjVBzUYiO1G1JFvOl38Vgh0
         SKDn03grMAl9W/EW3egHAhfkECFpIEt2bGD1ErKsQfkBwj8HlErn1WJrxc6WPSCh9uOE
         iNl9MR3/Vf6W+2SjCml9YzIM/+1xw3vKoVa729ZVNaFkTxUxzVyam+JYZOLGZck9zs6r
         1ESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761141617; x=1761746417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Re1JSCl2Jc24qdiTwXoEjtfmXZ9sVqIUqkpQs6nWQE=;
        b=N/qiCfz+tnkIP6hcFA2eRzz2/LEp+mOP8vejFDx3r+GF98Qte22UQae2qcEd+lHKMX
         NOhco/898MiI+cjEC4czQdkQl+VhcSO4uoqx7IvYBNslHcawpzX2QRVSgP7oT2QXB5sW
         MygXmQsxCvZsZQNKKR/pbUBuaQi1iuhQK5Q55L/41PJTMChYWwyJWV9QOOvkwIcQSWcs
         CE93kFBaCByWSkjgTq6igDRQMEEvBS7CuHMWAafTNhRTcYpr2ygUMe+W/9/ZgiAT4G8I
         hvCKMVqqGYOrnVbdlpHXXdhB1earZc/yebe6VxxBRoBvj/nEO+Yx/6KDUi4a42WFX0CN
         plsQ==
X-Gm-Message-State: AOJu0YzdVrIa+fIBMZG6NSqgx05cM73BMosJyNv7kJyopdeV5eX3iPwp
	AcMqV8IdSx2fMU3rsc3dqVZ5S+b9nhZN+gecZykGrojmsNUkvfuo69xn
X-Gm-Gg: ASbGncuHFej4KpuAtOt9dahNcyZ7i6oD3Ic+aeV5kKeNLIDufNs1Yr2MEcXrFN4OpfP
	lUSngp09xSRMfVTzy/C200xCcY8j/QeV6G3FF/wdEXGcK83WluvTJA7VSDLBs1nilV0YYni0+C9
	FYH0X4TeBsUhJK01CD/hSfIGqZjeHN9m31aNenznABRULG7uy9D0ZUJx8g4OnAHJ1fLfejPlP8H
	vpzOmFuJD3P7VlT3wPpp0pslRYLgkJx0vl4ERFbfZ0S91zR4RCT5BeGASZrhHNXATdMnVBTcGU2
	2WZmvAwrm1cVT4dZn1kuc2Ivx8xougCQZEN8UloLLDG0sDw4oPUbspFGoleQ66IJvvtP4nX/L5b
	08DQ8NLcI/y/FHloQqkpAvtzZHJo4NEjPrw8de6tlyf7R47h+mrTdNtKUH7roOJc1ykIodTmoZ5
	LxbLFf98dZDkkHhx34wbmu
X-Google-Smtp-Source: AGHT+IFMVGM0xoxg3/8N8FrhrYihfXOVf8SqXgxWl+Lh99dqiGIGDaKlCF8FKbzcZbj2eqh4JJpV6A==
X-Received: by 2002:a05:6000:1884:b0:427:454:43b4 with SMTP id ffacd0b85a97d-42704dc943cmr13944351f8f.48.1761141617095;
        Wed, 22 Oct 2025 07:00:17 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5b3dabsm26386244f8f.16.2025.10.22.07.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 07:00:16 -0700 (PDT)
Date: Wed, 22 Oct 2025 14:06:56 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v6 bpf-next 05/17] selftests/bpf: add selftests for new
 insn_array map
Message-ID: <aPjlANnS+hj09w2s@mail.gmail.com>
References: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
 <20251019202145.3944697-6-a.s.protopopov@gmail.com>
 <9660d7d3d3348bdf84c0a1a2861b66db9e2cc980.camel@gmail.com>
 <aPjfuZd+370hXFLJ@mail.gmail.com>
 <0e98a654792b6ab8002b0cf7ddf604e20b2f8f5e.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e98a654792b6ab8002b0cf7ddf604e20b2f8f5e.camel@gmail.com>

On 25/10/22 06:55AM, Eduard Zingerman wrote:
> On Wed, 2025-10-22 at 13:44 +0000, Anton Protopopov wrote:
> > On 25/10/21 04:51PM, Eduard Zingerman wrote:
> > > On Sun, 2025-10-19 at 20:21 +0000, Anton Protopopov wrote:
> > > > Add the following selftests for new insn_array map:
> > > > 
> > > >   * Incorrect instruction indexes are rejected
> > > >   * Two programs can't use the same map
> > > >   * BPF progs can't operate the map
> > > >   * no changes to code => map is the same
> > > >   * expected changes when instructions are added
> > > >   * expected changes when instructions are deleted
> > > >   * expected changes when multiple functions are present
> > > > 
> > > > Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> > > > ---
> > > 
> > > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > > 
> > > >  .../selftests/bpf/prog_tests/bpf_insn_array.c | 404 ++++++++++++++++++
> > > >  1 file changed, 404 insertions(+)
> > > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> > > > 
> > > > diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> > > > new file mode 100644
> > > > index 000000000000..a4304ef5be13
> > > > --- /dev/null
> > > > +++ b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> > > 
> > > [...]
> > > 
> > > > +static void check_bpf_no_lookup(void)
> > > 
> > > This one can be moved to prog_tests/bpf_insn_array.c, I think.
> > 
> > A typo? (This is a patch for the prog_tests/bpf_insn_array.c)
> 
> Yes, I mean progs/verifier_gotox.c, the one with inline assembly.

I think it should stay here. There will be other usages of the
instruction array, and neither should allow operations on it from
a BPF prog (indirect calls, static keys).

> > 
> > > > +{
> > > > +	struct bpf_insn insns[] = {
> > > > +		BPF_LD_MAP_FD(BPF_REG_1, 0),
> > > > +		BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
> > > > +		BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
> > > > +		BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
> > > > +		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
> > > > +		BPF_EXIT_INSN(),
> > > > +	};
> > > > +	int prog_fd = -1, map_fd;
> > > > +
> > > > +	map_fd = map_create(BPF_MAP_TYPE_INSN_ARRAY, 1);
> > > > +	if (!ASSERT_GE(map_fd, 0, "map_create"))
> > > > +		return;
> > > > +
> > > > +	insns[0].imm = map_fd;
> > > > +
> > > > +	if (!ASSERT_EQ(bpf_map_freeze(map_fd), 0, "bpf_map_freeze"))
> > > > +		goto cleanup;
> > > > +
> > > > +	prog_fd = prog_load(insns, ARRAY_SIZE(insns), NULL, 0);
> > > > +	if (!ASSERT_EQ(prog_fd, -EINVAL, "program should have been rejected (prog_fd != -EINVAL)"))
> > > > +		goto cleanup;
> > > > +
> > > > +	/* correctness: check that prog is still loadable with normal map */
> > > > +	close(map_fd);
> > > > +	map_fd = map_create(BPF_MAP_TYPE_ARRAY, 1);
> > > > +	insns[0].imm = map_fd;
> > > > +	prog_fd = prog_load(insns, ARRAY_SIZE(insns), NULL, 0);
> > > > +	if (!ASSERT_GE(prog_fd, 0, "bpf(BPF_PROG_LOAD)"))
> > > > +		goto cleanup;
> > > > +
> > > > +cleanup:
> > > > +	close(prog_fd);
> > > > +	close(map_fd);
> > > > +}
> > > 
> > > [...]

