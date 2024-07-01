Return-Path: <bpf+bounces-33480-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A36A791DBAE
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 11:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D33851C21522
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 09:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE5F84E18;
	Mon,  1 Jul 2024 09:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UDKOiL3S"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D260347B4
	for <bpf@vger.kernel.org>; Mon,  1 Jul 2024 09:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719827117; cv=none; b=GNg3usBnRVRj+EQBTRqq1rFcdtlsTFRRdXHWHz3ktasooYBqg4J1yXj3YteK+D3hXL6oc71T1ZDvBirt5nuS5yfboTR6Z9vdgMYoD9T+8KkTkwNMkiNOS2FNXI9AgDS3YydwRL9WHVIMlF1m4GU99OjU6lYHUoJzg46ZFl1ORLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719827117; c=relaxed/simple;
	bh=1uxmJBN+W8zu9AkVdAz9dN8z4qxeX44Hk8DACDgi5ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hXd0FFNUN8csjsj7/Oov9oFOi1qQxUb0hkgSYbot7yqVR00S05LJAP/e0l6RpNb0yor9XIwLMcU/xsxvdN+f5w7LoP6iFbo+RPvu9FJr+SUAimsrN9GkMDD9vQ3u81w18JDRWzsNKgtNI9UkqHNzB4x4Og1xAyJyS8PHtIlR24E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UDKOiL3S; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ec52fbb50aso32223921fa.3
        for <bpf@vger.kernel.org>; Mon, 01 Jul 2024 02:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719827112; x=1720431912; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ccmwGa1gVy9fHFovHvdOv7IsQQQMdqa3hzIJT5Q+iKo=;
        b=UDKOiL3Sz/N4TkkrewoNRloEbO8/0wY7/KdXMgw1BFkAM+BBAIEvBvIp7NOeCWQPIy
         ZpASLJu/4by7lXnmVuMRSD+NLbAu9xkS5K0RPAR4f5boxkyswdp+Kjq0nu6QsVy/l5PX
         vPtRNyczFL5UMjEd1eMRJyY2IahoEjyGeE1ZoEPIjGuXRB5knby9M0mdc2F1ElpzEfX5
         REllr+fNwttcwlxOva/z3QHaTssiDwnpSvynD6Avj+L1cUgta8dZU9Px1Da5KHdpV9JT
         +2bcKotRIsP0WRjoWevoaGfgUk6dBZwa/96EcZlAsiuUEtPjS+oO/aRvd8UmHDI1HI3O
         5i2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719827112; x=1720431912;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ccmwGa1gVy9fHFovHvdOv7IsQQQMdqa3hzIJT5Q+iKo=;
        b=ubWe9uAf2OCehxQ5/q5w77q6suwmDjRjPx1WWVeSEc2hOduML5OkSjunR1Z3bNl6ZW
         ltoguTTMpuhRxAI5r8hQbVsraHozH/0OTxRrKZiJbHHi3VAorLYV9LE3+i985F98WzJf
         4nrrGELAdUCV+PvTll/ts1IDF1V544Za16rC5nHi+BEjrEyljM2IVK+yCV8QHzsQ6Kp2
         G1X0L8AnZ4HW2qX0Z6h7S6inuuU5g7EccYYwQith1e149voCe5nB0jT3koxG7z2g3PC8
         9fe3HsmkUCGC9fRIVFv57MRYRRMOY50QDF9NloxNFoXGx+Z8RpxYu9iar3Q+lfQy+WeJ
         1yog==
X-Gm-Message-State: AOJu0YxPeou30EZCc34qK2Xubxzi717qd868TVW52E7W6NJHxSrpcVMo
	G0Taa4FqCkawbRiLQBEOcUYq8h1bmdsx4QtVgYrOk/HWwepOqX+v8JwBdlTFIek=
X-Google-Smtp-Source: AGHT+IE4tzibOTIygZYgQoVa75CZ1IC7YbrMfMYCpgj8m2gIteBMd2YSnTUgOw0A9JiXwnw4/5fWXA==
X-Received: by 2002:a05:651c:2203:b0:2ee:4623:93e with SMTP id 38308e7fff4ca-2ee5e393f39mr50174011fa.20.1719827111998;
        Mon, 01 Jul 2024 02:45:11 -0700 (PDT)
Received: from u94a (2001-b011-fa04-1bba-b2dc-efff-fee8-7e7a.dynamic-ip6.hinet.net. [2001:b011:fa04:1bba:b2dc:efff:fee8:7e7a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70804a9540fsm6007539b3a.216.2024.07.01.02.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 02:45:11 -0700 (PDT)
Date: Mon, 1 Jul 2024 17:45:05 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf-next v2 0/2] Use overflow.h helpers to check for
 overflows
Message-ID: <oexxtxrd5vwfoelvrrdntrzxysiivynwaw3rcji3ujmyqr36dm@xomyw3rny5rd>
References: <20240701055907.82481-1-shung-hsi.yu@suse.com>
 <ZoJ0b_DtHvcTbehC@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoJ0b_DtHvcTbehC@krava>

On Mon, Jul 01, 2024 at 11:18:39AM GMT, Jiri Olsa wrote:
> On Mon, Jul 01, 2024 at 01:59:03PM +0800, Shung-Hsi Yu wrote:
> > This patch set refactors kernel/bpf/verifier.c to use type-agnostic,
> > generic overflow-check helpers defined in include/linux/overflow.h to
> > check for addition and subtraction overflow, and drop the
> > signed_*_overflows() helpers we currently have in kernel/bpf/verifier.c.
> > There should be no functional change in how the verifier works.
> > 
> > The main motivation is to make future refactoring[1] easier.
> > 
> > While check_mul_overflow() also exists and could potentially replace what
> > we have in scalar*_min_max_mul(), it does not help with refactoring and
> > would either change how the verifier works (e.g. lifting restriction on
> > umax<=U32_MAX and u32_max<=U16_MAX) or make the code slightly harder to
> > read, so it is left for future endeavour.
> > 
> > Changes from v1 <https://lore.kernel.org/r/20240623070324.12634-1-shung-hsi.yu@suse.com>:
> > - use pointers to values in dst_reg directly as the sum/diff pointer and
> >   remove the else branch (Jiri)
> > - change local variables to be dst_reg pointers instead of src_reg values
> > - include comparison of generated assembly before & after the change
> >   (Alexei)
> > 
> > 1: https://github.com/kernel-patches/bpf/pull/7205/commits
> 
> CI failed, but it looks like aws hiccup:
>   https://github.com/kernel-patches/bpf/actions/runs/9739067425/job/26873810583

Should be, before submitting I've checked that it passed in the BPF
CI[1] through manually opened PR#7280.

> lgtm
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks!

1: https://github.com/kernel-patches/bpf/actions/runs/9738751746

