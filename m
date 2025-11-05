Return-Path: <bpf+bounces-73610-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67155C34E1C
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 10:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 052843BDB92
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 09:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A96302CCA;
	Wed,  5 Nov 2025 09:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWYPbV4W"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47FD3016E8
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 09:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762335070; cv=none; b=sbYuYLzXnLT/s+zmUhExl60OGOL/d2BnHESUPk7cSFqQidb5N5fAMdo2SUoD8Gjaz9tw0lcYFr7iUJFdA+oyR4nBhnPOG1YZfd0l7Ry0Ph5xuJe9b0bwHTbMw5ndHjPvBKkdmU+tfh7mddrGbDj6yNtHlII/Ypuk2l8htEbIb5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762335070; c=relaxed/simple;
	bh=J88cRyuctVH6q0/vqU7Hi6352OSIvIqWB+Tji/XrOGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H50wKFIqaQvwURmrv4sT+qWyMCIzF0kC0zN1p3Pf1sh8LdFyigmg/5f3aMIbAkL1H7bfOzEKEE3derKmFt5TCh8rx7sVAqaes5iEPgMemjPBUIWUKtshvH4wQ/fYk+uC9wl+wGwB9XIogHa9tB7cCFbS0Et8F9nb+HEgfmKcR0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WWYPbV4W; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-640ace5f283so4027173a12.2
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 01:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762335067; x=1762939867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cm7+LuWpqbsYDfDvKMcVgLLiwyqq96at3i8UIh5nd3A=;
        b=WWYPbV4W3PJed8OQhlOWGgP737YUL3TqoTRsC/byWwknIur77h21RxV1zRvBYbZQ7A
         DE2i/AjzSjyEeztOj+Vxp+7umkf25lBhpaHi7LMAVwOx9l+MMThhLk2VHOG55/HLoDY/
         pYsLqn0mlqNY1TmoD57wITKIUyC6GUuoCRb4JWRyhnpjq5wRyn+SNcyb5zAnotTbZxw2
         Th9fyC4rj6i975GY1ojTFZ/GMQ9xSTEZptJcr/4hEgjSkvJTpaYTNdfPbLOd20jn+jGi
         O4a2CFGBXLc+FZxWdNM2DujR2FXzv/UPFhYL46qmdQZYRHPgWigz68XkkdEvMr3uL7ct
         VHkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762335067; x=1762939867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cm7+LuWpqbsYDfDvKMcVgLLiwyqq96at3i8UIh5nd3A=;
        b=bV2AVfC86N9PJ9spWiEHOIj7Kyl9Mpu7PQXZDIo3dTjWfmA9KrYZwX71Wnap5OfxBy
         5u0+UPQTpea9/ajDaeXjtEI2KHrr2a7LOwMogu0wTaiHBoW8o97wEd03678JibcvyhuG
         XWxfyipH5vQBPhtxSoZrrUGq04hRYvIoUhvBgDc9WRRKd/HknRSXRzqCk6nCqYhcCOpr
         LCkgyzbgeAxM7hpLkjps3EScZ4rA1UJtKSBPBk0ajlEC1SCy+LnAIxQhyqvoexj9+col
         lh45wDTXML9hIod7BWhm45vPS/AmNwlK72NtQ07Ko8jFLDyIcX6rd7k+0FlL7k4WaK5r
         TuMw==
X-Gm-Message-State: AOJu0YzP/wk//SPVybhbG5nwJfot+eYod1SbR/wbIvjytlkFMuDqKTsE
	WcWBa7/VGBSgsYbLunLi49nMedP/e7joZx0HtBaWW6b62eubiFmgglIb
X-Gm-Gg: ASbGncsKbFFQErZgJ4cDFbsjJhZ3LxJBP435fkqgIRzzA6rlQnhEBkK279iPtJxD8p8
	m5qIgegR0tKhisbflhYAt9Wbqb4iGeD2gqD+fLMFg9HltgoQ35cuf5KVyf1w9eANWBLkVCKLngk
	TNc0chBQvnpHZTKQB2rm3sKq6o5c91RTJ8msALNyFLaSIeKqJjnkJNru+S8hqY1qX39ooQFih9k
	Qkghnbgfj4QIrSN5OTJQGp2m5ZI5yvrR9Fg8TustUCBXUq5gjto8kgjUzIgkp8Jw11LJgerWFUd
	O86NYskoyxDeUHtAysfEhTLpX8frL5TBHvfR/vpydc6Yp+zHg2mHv2lyGF4Wr/6Mn5rN+Mu8Oc7
	xWwZff6RTypySgM/n1BXkgaq0euwN1xLTNmKpoThOHktvyZXEEowdOS1ig4HAm1CUmUlSDo4XKs
	/8MH8RpbuTRiQWo1HiX1XR
X-Google-Smtp-Source: AGHT+IHbYzNoshQt1IgeRrXDvGs/O6DPVpD60ZjB/D98pzj9eZkDNHolcPoT1tGd3bb9T7BKx0wx1A==
X-Received: by 2002:a05:6402:13cd:b0:640:952d:f602 with SMTP id 4fb4d7f45d1cf-6410589939emr2313445a12.6.1762335066676;
        Wed, 05 Nov 2025 01:31:06 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-640e78f8985sm3996574a12.27.2025.11.05.01.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 01:31:06 -0800 (PST)
Date: Wed, 5 Nov 2025 09:37:20 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	aspsk@isovalent.com, daniel@iogearbox.net, eddyz87@gmail.com,
	qmo@kernel.org, yonghong.song@linux.dev, martin.lau@kernel.org,
	clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH v11 bpf-next 12/12] selftests/bpf: add C-level selftests
 for indirect jumps
Message-ID: <aQsa0J01s/cghl4x@mail.gmail.com>
References: <20251105090410.1250500-13-a.s.protopopov@gmail.com>
 <0fd4c10d43f9c3ce28948a5bff8b745a1298f30154f3c1d4d095163a905429f2@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fd4c10d43f9c3ce28948a5bff8b745a1298f30154f3c1d4d095163a905429f2@mail.kernel.org>

On 25/11/05 09:28AM, bot+bpf-ci@kernel.org wrote:
> > diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c b/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
> > new file mode 100644
> > index 000000000..ea1cd3cda
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
> 
> [ ... ]
> 
> > @@ -0,0 +1,292 @@
> 
> [ ... ]
> 
> > +static void check_one_map_two_jumps(struct bpf_gotox *skel)
> > +{
> > +	struct bpf_prog_info prog_info;
> > +	struct bpf_map_info map_info;
> > +	__u32 len;
> > +	__u32 map_ids[16];
> > +	int prog_fd, map_fd;
> > +	int ret;
> > +	int i;
> > +	bool seen = false;
> > +
> > +	memset(&prog_info, 0, sizeof(prog_info));
> > +	prog_info.map_ids = (long)map_ids;
> > +	prog_info.nr_map_ids = ARRAY_SIZE(map_ids);
> > +	prog_fd = bpf_program__fd(skel->progs.one_map_two_jumps);
> > +	if (!ASSERT_GE(prog_fd, 0, "bpf_program__fd(one_map_two_jumps)"))
> > +		return;
> > +
> > +	len = sizeof(prog_info);
> > +	ret = bpf_obj_get_info_by_fd(prog_fd, &prog_info, &len);
> > +	if (!ASSERT_OK(ret, "bpf_obj_get_info_by_fd(prog_fd)"))
> > +		return;
> > +
> > +	for (i = 0; i < prog_info.nr_map_ids; i++) {
> > +		map_fd  = bpf_map_get_fd_by_id(map_ids[i]);
> > +		if (!ASSERT_GE(map_fd, 0, "bpf_program__fd(one_map_two_jumps)"))
>                                                 ^^^^
> 
> This isn't a bug, but the error message looks like it was copied from the
> prog_fd check above. Should this say "bpf_map_get_fd_by_id" instead?

Yes, it should

> 
> > +			return;
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19096860051


