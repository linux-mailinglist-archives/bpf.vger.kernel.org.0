Return-Path: <bpf+bounces-71725-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EB352BFC42C
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 15:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 59BFE542D14
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 13:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA56347FDB;
	Wed, 22 Oct 2025 13:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duHquad+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8C5307ACE
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 13:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140270; cv=none; b=RpqREp1RmuLgELDfy4uDMESZ/m4x9ozBFsv2aU/yVP4LdLqrgEuwymGtMlbF4HYrCbTbnvZmQY8oq6hKoR4WXju68jkB7O1Y3Hgre4UBPMrmYMGGhMgzMq4Lw8UARDlRM2Obff4xOjU+OyUf36uMwGCxFlqxhOAjiSOlWsQq/vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140270; c=relaxed/simple;
	bh=vTZ/QYYKKJewuEyoJkLOivoNmUEVFK7RpLl0H0smQYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+hqd6NovEQ/dXw0bLKg0PHtrEafxOkLoSa+t/3OuR57n4ZlIm61Klh4Y0ylSoawv/U3i4l08VTK/8a+RIk7PEbid9PlAnazextmRHru8XoNjJVxnL6BA147fVDm6aaP6j9Qaax5xL2vNj3hXF9YRNL2ek2Q8XXoXffbfPCNTpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=duHquad+; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e542196c7so6583895e9.0
        for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 06:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761140266; x=1761745066; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YzEe6rQ9srp6mTnO3OzcOV7KqowtUJJFozx7hwwrHwo=;
        b=duHquad+xLlNyQTJzT9NY9zrpGiYiTDbdCNcI5d/pTc1LydqHMOZgKGkx8OVEP18bu
         icIymCQXOXSMZ4lzn00AmUgWhnxT8Udajh2MvnWQBi2AdzLhd70uA/dK7wHcegV6O3qv
         8mLEfjGu54IB+G8YisK5igB9xk1ExL4KSX15FSWc+Q027Pg/cDzhq2zqQTNDj2JwX2H1
         5H0F/VKHZZy/DPl9WR83QxsIB0FLHi12KCtIvFiCqUTGAkpsPbUil0qqfyJmfG5Fdskf
         hUKRN5glQ5RKpp2Fap6SNPGmS0w2DoYu/w8cP3YuWUgcHYm6SH86PJQl4GIs7sWoLLa4
         iKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761140266; x=1761745066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YzEe6rQ9srp6mTnO3OzcOV7KqowtUJJFozx7hwwrHwo=;
        b=wHMbzs3G3DX4nargVVWVlKNZO0/SwOy1mSXViMWdmOJ/tTdhKsZ/SJRKd0eJ5wwXSP
         4gtS0DByKjdC658oSNnB3wW5YtgkWCuK4uXhSfV1jzBVeVW3gzR10b3BCJL22w1WrqX7
         0ZH5lmJ0Twn44eHadH3QYIDw3GoYfIanPEa+c42FFd47fgEwK0LsXBDMhrJYa1dw4qNB
         b59wwflepRwNhd2yC95TYrcjHBKUiIPKEI7uuzHrhEqN2rGtCsno8uV2DYRAt1TefhMX
         TAnvCmDIEjW6MuD6mfYwKPHEiUkG6fYYtVY6ulaEjrZcjsFPRDwG+x4sQNB50d8UYvnr
         igLg==
X-Gm-Message-State: AOJu0YwKruCC+SJaI9qaDQSPEfG8OTRpm69yb/A9tBAXcjlslgScwSNc
	uXUVVzsy8jzDzcrK/GJePknBh8KI3Mddf3cyEmoiMhi0qOBY0DQYrypU
X-Gm-Gg: ASbGncs2GQtsLMvQaJ6ZlWNwjspY+9bkCB6meYLnOnDcUszc0TJpiLK09up3MsOgQ35
	t6amBKo0w20g/asrF1ioxMKonxlCxad6BVh2JOXSVTi4aVDUPRwscU4cY5HHyB3+hZS6SZnYYtC
	iN5cuc45amcUrhR566fE+wdaF0dfTkbNo6lgDQw7k22ras3oRlZkZOLJG8kNojGTJBCBXQqfK50
	Sq1UdLmWFI7u2BkYUNMAvW3MV6rZT3TvMcTzDVSrrzwB/Aq5JOdyKsZAz0CuoHeHaJdk0ks7mCa
	zyxNA+hdi804JE0RbHNyEq1U3KaNkl0z972I2/jbO/wCy4So0dQ1P0eoIbvkyItPTr0eeQJaH/w
	BQcePhdMSMTNHLMSNNQwbU2DIeqDQobDHMWLstUyShLNup7wzFAlWCy9n8G87ufzJchq4cdP19b
	iEN5CWJEl6Wv7qQV6pjCbo
X-Google-Smtp-Source: AGHT+IEVKIupRkfBe86PEDavyii3qkYXwgZmzG/Wl5ISXMDNDvL1AgTHZi5bhVz1FhTsj+dXXxHwgg==
X-Received: by 2002:a05:600c:4509:b0:45d:dc10:a5ee with SMTP id 5b1f17b1804b1-475c60da52amr15533745e9.15.1761140266234;
        Wed, 22 Oct 2025 06:37:46 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c427c3bfsm52001645e9.3.2025.10.22.06.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 06:37:45 -0700 (PDT)
Date: Wed, 22 Oct 2025 13:44:25 +0000
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
Message-ID: <aPjfuZd+370hXFLJ@mail.gmail.com>
References: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
 <20251019202145.3944697-6-a.s.protopopov@gmail.com>
 <9660d7d3d3348bdf84c0a1a2861b66db9e2cc980.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9660d7d3d3348bdf84c0a1a2861b66db9e2cc980.camel@gmail.com>

On 25/10/21 04:51PM, Eduard Zingerman wrote:
> On Sun, 2025-10-19 at 20:21 +0000, Anton Protopopov wrote:
> > Add the following selftests for new insn_array map:
> > 
> >   * Incorrect instruction indexes are rejected
> >   * Two programs can't use the same map
> >   * BPF progs can't operate the map
> >   * no changes to code => map is the same
> >   * expected changes when instructions are added
> >   * expected changes when instructions are deleted
> >   * expected changes when multiple functions are present
> > 
> > Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> > ---
> 
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> 
> >  .../selftests/bpf/prog_tests/bpf_insn_array.c | 404 ++++++++++++++++++
> >  1 file changed, 404 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> > 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> > new file mode 100644
> > index 000000000000..a4304ef5be13
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> 
> [...]
> 
> > +static void check_bpf_no_lookup(void)
> 
> This one can be moved to prog_tests/bpf_insn_array.c, I think.

A typo? (This is a patch for the prog_tests/bpf_insn_array.c)

> > +{
> > +	struct bpf_insn insns[] = {
> > +		BPF_LD_MAP_FD(BPF_REG_1, 0),
> > +		BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
> > +		BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
> > +		BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
> > +		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
> > +		BPF_EXIT_INSN(),
> > +	};
> > +	int prog_fd = -1, map_fd;
> > +
> > +	map_fd = map_create(BPF_MAP_TYPE_INSN_ARRAY, 1);
> > +	if (!ASSERT_GE(map_fd, 0, "map_create"))
> > +		return;
> > +
> > +	insns[0].imm = map_fd;
> > +
> > +	if (!ASSERT_EQ(bpf_map_freeze(map_fd), 0, "bpf_map_freeze"))
> > +		goto cleanup;
> > +
> > +	prog_fd = prog_load(insns, ARRAY_SIZE(insns), NULL, 0);
> > +	if (!ASSERT_EQ(prog_fd, -EINVAL, "program should have been rejected (prog_fd != -EINVAL)"))
> > +		goto cleanup;
> > +
> > +	/* correctness: check that prog is still loadable with normal map */
> > +	close(map_fd);
> > +	map_fd = map_create(BPF_MAP_TYPE_ARRAY, 1);
> > +	insns[0].imm = map_fd;
> > +	prog_fd = prog_load(insns, ARRAY_SIZE(insns), NULL, 0);
> > +	if (!ASSERT_GE(prog_fd, 0, "bpf(BPF_PROG_LOAD)"))
> > +		goto cleanup;
> > +
> > +cleanup:
> > +	close(prog_fd);
> > +	close(map_fd);
> > +}
> 
> [...]

