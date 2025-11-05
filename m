Return-Path: <bpf+bounces-73612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7B3C34F09
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 10:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 157A74F6513
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 09:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBAB3009C3;
	Wed,  5 Nov 2025 09:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZp7nfxu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21072C0274
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 09:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762335984; cv=none; b=AxT0+5Uhm1teqCocGTO0DmSEk1VNMYJ7a7jzfgJ/rHD03FHM2EfdfRUwMsnx5Z83aTKotKzmzEqIACPcrjy/LMU2LSEBU+tSuPBUFJndSp8wb1xl2ntRC5sjOXDCro8IHJHjobJM2BVDavakdh5ulTazO+kf97D2G4ZKhcn8GPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762335984; c=relaxed/simple;
	bh=QAvroArLtgJT3RXMSrGF3g05l6jqCVt7MXSOIbY16Sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jtdglA4rmLecJkQNwDZcXljpsiPUkGsNG3klRBoAnoc44cR84CdlstOCzdcGnly5M5Y6M2xlaRHFZue1FHvDqgQI+LBMaNg1f85k7Bpd6JSOaSL9zwyOl4O9aXTgMNNcOKoow3zTNSlGpvjp2FI4SNelmwPEg2Fc7InJeEEOlhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZp7nfxu; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-640bd9039fbso5345745a12.2
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 01:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762335981; x=1762940781; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aurjflN4i/ac+akFHc1Qd5NSols8wpPRhChdsOSU89E=;
        b=hZp7nfxuW+sGGAFE89OioUaMK+XXjo2fQtWpxQ4l0x0vpmkyGfDPfdRkSXDNYs9X2I
         cJNev5ayc8ijO9w+S2rSSZF750I1cifaOttwHuBKvqR6zeiROjQ+lF4km91G7dP7Yml/
         cfIeouRfrvrojiVIhV+fl7ax58IzYm0/ikbUaIw5sfEoIWvYVzrdopvrhYqIGBShVYFB
         vwDc4KfSb07DV7iio7VZSy6TYh8u0qZffRf90eprkwrjdKmF7Z+7Qa1UYg42vhEIHBGh
         dEef/iJv3lESd/DCusc4coUS0P4Gl9EkSm6pae1tME7Dwog/plT4gn3wQHLsbXl/fxzT
         K6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762335981; x=1762940781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aurjflN4i/ac+akFHc1Qd5NSols8wpPRhChdsOSU89E=;
        b=xVYnzNvtuOfOBAAM5qL0olaekwigh9M1Rt2cRko3X9YXmUTQA+nhd7dgJI/IUWJVxq
         OicIYFa69fUqSEwcVssDWaQSsDco+024Qgh1cfPppo8gC60UjKh9Kv2aEAvpkru3+2f9
         LWuEQtXWg7mqlGWLPu6uaQMShSywix1iAIRcSCsLBUfXTDZM2QUVnQvn5/IxydMrwbO2
         A7jpr5V4Wn7Amxys40XeAmgaguRdmPakp6ZqFjwzOBwQ+B0gL3cR6xCwXaoKhp7qEyt9
         Sj4t2AYU9FwJVjNLgUtIesJl05RWXnFf3TdmYGzNJWdMWGWuxO9OTJ9JYTxvjNJox53W
         tD8A==
X-Gm-Message-State: AOJu0YwTTwMeFtfL/71Xb4mBlq6a/yb4rNveB4xZKFLSF8jv3vD7/oGf
	4ZnZPKJM+hmN3bWoLLNynFsu+6mAlFMrh3uoq/wqfhhdmY58xgeZ3Dq+
X-Gm-Gg: ASbGnct0kV6c2Zta0wyWeV26nw3qHum8LSBkTc0u3wLYhVYggKCBvTJZztzehyGfep9
	O4Eah+VXu7D3vQDbGM9Ve+sThGbxO1E0WFUlzeRZt3YDOekfWPGhqD8T/KUeyLnK3EbOPTKQ4NU
	hAUULmqy4/fGW06XrcWVpMsB2XXiS7K3y0cvneyXJ63Iz1BkEbteI2qIH8Ca6m7eTY8clnucsZG
	t3kk126jHMsYiBXOvJ0rMPYeDUH306SfPnsivukAdDVbchsMbhU7wbZwc54bGlAk61PBgzObCRx
	qF2WzvvsZO2irDj8fDWS6++N4uMVv32RTAlNoVBLErzqTHZdLU/y6gN0qVYazjpZhN7ikcMfsBL
	+DZgSj5lPk4cLuPfBrsaTA+npbpW2g3v4fo7JagzwXV1X9VtxNpdo1vx+cipG2v0PdRGUcQGlCQ
	xfU0eFK5K/VXYRxWBoTx2A
X-Google-Smtp-Source: AGHT+IFZX6haR7TXYUevMpEVTaT8tO+x7PaXZDTEJ/yemm6tPOiP7/AyuDXDhNn+8/+LPEr4N6ntGg==
X-Received: by 2002:a17:907:980d:b0:b3d:98fa:b3fe with SMTP id a640c23a62f3a-b72655a754emr252115266b.63.1762335980980;
        Wed, 05 Nov 2025 01:46:20 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723f6e26adsm442706666b.43.2025.11.05.01.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 01:46:18 -0800 (PST)
Date: Wed, 5 Nov 2025 09:52:32 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	aspsk@isovalent.com, daniel@iogearbox.net, eddyz87@gmail.com,
	qmo@kernel.org, yonghong.song@linux.dev, martin.lau@kernel.org,
	clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH v11 bpf-next 04/12] selftests/bpf: add selftests for new
 insn_array map
Message-ID: <aQseYF/oIN3UsRaF@mail.gmail.com>
References: <20251105090410.1250500-5-a.s.protopopov@gmail.com>
 <9f61c0c4ea50e3a25c4433dd5d5702fb1543931e905e689b9a99dd549f3d8aba@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f61c0c4ea50e3a25c4433dd5d5702fb1543931e905e689b9a99dd549f3d8aba@mail.kernel.org>

On 25/11/05 09:28AM, bot+bpf-ci@kernel.org wrote:
> > diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> > new file mode 100644
> > index 000000000..96ee9c998
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> 
> [ ... ]
> 
> > +/* Map can be used only by one BPF program */
> > +static void check_no_map_reuse(void)
> > +{
> > +	struct bpf_insn insns[] = {
> > +		BPF_MOV64_IMM(BPF_REG_0, 0),
> > +		BPF_EXIT_INSN(),
> > +	};
> > +	int prog_fd = -1, map_fd, extra_fd = -1;
> > +	struct bpf_insn_array_value val = {};
> > +	int i;
> > +
> > +	map_fd = map_create(BPF_MAP_TYPE_INSN_ARRAY, ARRAY_SIZE(insns));
> > +	if (!ASSERT_GE(map_fd, 0, "map_create"))
> > +		return;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(insns); i++) {
> > +		val.orig_off = i;
> > +		if (!ASSERT_EQ(bpf_map_update_elem(map_fd, &i, &val, 0), 0, "bpf_map_update_elem"))
> > +			goto cleanup;
> > +	}
> > +
> > +	if (!ASSERT_EQ(bpf_map_freeze(map_fd), 0, "bpf_map_freeze"))
> > +		goto cleanup;
> > +
> > +	prog_fd = prog_load(insns, ARRAY_SIZE(insns), &map_fd, 1);
> > +	if (!ASSERT_GE(prog_fd, 0, "bpf(BPF_PROG_LOAD)"))
> > +		goto cleanup;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(insns); i++) {
> > +		if (!ASSERT_EQ(bpf_map_lookup_elem(map_fd, &i, &val), 0, "bpf_map_lookup_elem"))
> > +			goto cleanup;
> > +
> > +		ASSERT_EQ(val.xlated_off, i, "val should be equal i");
> > +	}
> > +
> > +	extra_fd = prog_load(insns, ARRAY_SIZE(insns), &map_fd, 1);
> > +	if (!ASSERT_EQ(extra_fd, -EBUSY, "program should have been rejected (extra_fd != -EBUSY)"))
> > +		goto cleanup;
> > +
> > +	/* correctness: check that prog is still loadable without fd_array */
> > +	extra_fd = prog_load(insns, ARRAY_SIZE(insns), NULL, 0);
> > +	if (!ASSERT_GE(prog_fd, 0, "bpf(BPF_PROG_LOAD): expected no error"))
> >                          ^^^^^^^
> 
> In check_no_map_reuse(), is it correct to check prog_fd here? The
> function just loaded a program into extra_fd, so this check appears
> to be validating the wrong variable.

Indeed, the extra_fd should be checked

> 
> > +		goto cleanup;
> > +
> > +cleanup:
> > +	close(extra_fd);
> > +	close(prog_fd);
> > +	close(map_fd);
> > +}
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19096860051


