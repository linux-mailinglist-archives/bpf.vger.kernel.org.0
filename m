Return-Path: <bpf+bounces-52099-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B56EA3E5D3
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 21:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A3AC3BD33D
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 20:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1999D264F87;
	Thu, 20 Feb 2025 20:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqyfoLCA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2836E2641F1
	for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 20:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740083051; cv=none; b=lkPtDL8+6ijZCDPEHrfjhMcnuBpBNzghwrcF/XHomf5DZ83V7bk7NHQnARWoRcwnfv9XLWmnIj2Z7mH8GAuiP3i9Z1R+w/4egqPGrIIKrQYtHcqHp+uyAaEVCfcHCDqWcRafK0zyPd7q/Ebw3CKvb2vPExdGBVMyHI0TDQkUH34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740083051; c=relaxed/simple;
	bh=qXLoVHkhu5fAEfprMGgEtzuSSAZ3NnoPOiTZI+85g9g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KHVujN0B0l3fHAgEt7S1VdyQv2IbnfFxs6kVcAcIsjNDzUMIIfQ0QcKRhlyR0wOJMSbQgprN/eE1vh2iN/4YQ30DtwL8MP8c3kBxIDtMdTUXpCdbSm3EnCMOLn/LH2JStnLpuf+1KCtsB5+BQxr6sArxHXNkGFPCngWuqlMAXG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VqyfoLCA; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22185cddbffso36773275ad.1
        for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 12:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740083049; x=1740687849; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GdMxpUubfWOokd9pAh23WlX8O30srcgyfKa85WKRVy0=;
        b=VqyfoLCAqOOT2nlcq7pedLwIBrM1UzQUggXX4widQlv3CzAwMN+RYSsVJEB7MAtrT6
         br53blw5W30VlCPW6bKLDNpBcggMRl0M4j2X7zHBkH7/5OQBodpg8CXxP5juuJhmpkxt
         kqD3TrRiO4LcPnnd3AphA7EovgFYK27daGxBmCHsLKifIYMsfHS3HnGV4I0pweUtA0Nb
         vxydr/1aMjfJrBFGnck5+TkhSCnc9Y6eQFVOfPYM1c7aen509am7Eq4/SR2eD/i1v6i2
         YNXS1dam8XROs0WatinhgaQc+LSX2nbGdzT4vimOa0dIzMbGSS9Dzo1+DhEfjwxO/qy5
         9yuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740083049; x=1740687849;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GdMxpUubfWOokd9pAh23WlX8O30srcgyfKa85WKRVy0=;
        b=pADMBRcZxd3xlEXANTk/R3Ps4/XS7LMxatrsdMPJn3kt7WxOrW5YBVaFoz3hZGcWbv
         2Hia5tlLOyPgfwwvdGZjllZ45sn4NWtWODrM+qzqcN2T2Pl2LoaglnxmHxa/FGFX2OeE
         3OCJPCFNkPonjHM9jE56Ta2+sHl418vGNFyQd5Mr2Urh12cIP3gfDgmzNnpL/h14dXBq
         VgHDZ14lAw3ieJjvETOIjaa/1AXqvZL8pQspCtllkPuadm2s81hsr8Og7H0JUgoB0AhP
         6p4yWvrv9DODihYmyEVqfPLbPoEv5FnJnewv+3QNk8Z3+BYefwvgVAMYFPheHv3DIts/
         jcdA==
X-Forwarded-Encrypted: i=1; AJvYcCVgMNdchddlVvRU34ydVAH1eqgo+xIKr+nadelDMeJDTxusRbVrm9zOCRGy9MIL9jdzoI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH79jvRU7qY14PN2bdeDDANeLL0xbD7pBqoSrt/5LOHhe1grot
	iSmUSth++hfberqPRF82zRSbPSPVf93VUcHsyVCJ+CvTWckV9qGv
X-Gm-Gg: ASbGnct6bV4SsJDhVr0t5k09DlgirMutcFHRQHAJooN/OxsSQr/hyCVvS37AjMrgLfV
	nLMEIqjmQI5I2FgdKY+VsJxWM1zrFhPoj2nQZ+lW7Jt3RnTYhTb5t9m3xrkyv4vVBCePpHbJq0G
	cHGCgGkXydDTvSVhByUczTOdTB6FV1kmMpkYYlDWy+FrlmBrnh4lTwPfx1FQnXNZYvmQ9cJc0dP
	tadHw6ARcUT8XWHwgI2A+YtNZzzENgHErfeQxrJRzi2MOaTuPEhxTQw2mtvkZjoocJRnHS0yaJU
	BExpRp8gz+9a
X-Google-Smtp-Source: AGHT+IH4URUopVJj+FCmjoLDDCn/scL1t/gIre1IL4Iz2R88EE4jcq7xaQdwp49X9paWb9sPTsOAGQ==
X-Received: by 2002:a05:6a00:84a:b0:730:8468:b2e8 with SMTP id d2e1a72fcca58-73425b84810mr762590b3a.6.1740083049174;
        Thu, 20 Feb 2025 12:24:09 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324273e2fesm14267407b3a.118.2025.02.20.12.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 12:24:08 -0800 (PST)
Message-ID: <efa9d618c13ab7f2108f3c739805313c10f9bf3a.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: introduce veristat test
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Thu, 20 Feb 2025 12:24:04 -0800
In-Reply-To: <20250219233045.201595-3-mykyta.yatsenko5@gmail.com>
References: <20250219233045.201595-1-mykyta.yatsenko5@gmail.com>
	 <20250219233045.201595-3-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-02-19 at 23:30 +0000, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>=20
> Introducing test for veristat, part of test_progs.
> Test cases cover functionality of setting global variables in BPF
> program.
>=20
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_veristat.c b/too=
ls/testing/selftests/bpf/prog_tests/test_veristat.c
> new file mode 100644
> index 000000000000..eff79bf55fe3
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/test_veristat.c

[...]

> +static struct fixture *init_fixture(void)
> +{
> +	struct fixture *fix =3D malloc(sizeof(struct fixture));
> +
> +	if (access("./veristat", F_OK) =3D=3D 0)
> +		strcpy(fix->veristat, "./veristat");
> +	/* for no_alu32 and cpuv4 veristat is in parent folder */
> +	if (access("../veristat", F_OK) =3D=3D 0)
> +		strcpy(fix->veristat, "../veristat");

Nit: 'else PRINT_FAIL("Can't find veristat binary");' ?

> +
> +	snprintf(fix->tmpfile, sizeof(fix->tmpfile), "/tmp/test_veristat.XXXXXX=
");
> +	fix->fd =3D mkstemp(fix->tmpfile);
> +	fix->sz =3D 1000000;
> +	fix->output =3D malloc(fix->sz);
> +	return fix;
> +}

[...]

> +static void test_set_global_vars_from_file_succeeds(void)
> +{
> +	struct fixture *fix =3D init_fixture();
> +	char input_file[80];
> +	const char *vars =3D "var_s16 =3D -32768\nvar_u16 =3D 60652";
> +	int fd;
> +
> +	snprintf(input_file, sizeof(input_file), "/tmp/veristat_input.XXXXXX");
> +	fd =3D mkstemp(input_file);
> +	if (!ASSERT_GE(fd, 0, "valid fd"))
> +		goto out;
> +
> +	write(fd, vars, strlen(vars));

Nit: 'syncfs(fd);' ?

> +	SYS(out, "%s set_global_vars.bpf.o -G \"@%s\" -vl2 > %s",
> +	    fix->veristat, input_file, fix->tmpfile);
> +	read(fix->fd, fix->output, fix->sz);
> +	__CHECK_STR("_w=3D0x8000 ", "var_s16 =3D -32768");
> +	__CHECK_STR("_w=3D0xecec ", "var_u16 =3D 60652");
> +
> +out:
> +	close(fd);
> +	remove(input_file);
> +	teardown_fixture(fix);
> +}

[...]


