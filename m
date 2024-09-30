Return-Path: <bpf+bounces-40541-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 115D4989A87
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 08:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34A811C21348
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 06:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB5C811F7;
	Mon, 30 Sep 2024 06:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BDjrO2ln"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com [209.85.208.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA9F1E49F
	for <bpf@vger.kernel.org>; Mon, 30 Sep 2024 06:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727677857; cv=none; b=IiFhp4Zj8SpTGcxMhrwKcrI68MnHYTMXQB9H8Ge7g5n3h8v8oDMvlxZjsgTI1S6XHUEWW47ixZK29ZNdfSBnVSlBVMiEjUxb0YaPPkZx70eNXCtozbuflwVedWfsVbk1kIKFtJpWjkrLjOM24s0ysr+HcNqju9nx6gT1q50SC6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727677857; c=relaxed/simple;
	bh=bV3SLzOq+vj8kW+8nQQMgY3Ip7oioVIHU7l0gBOEnbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XuFdI/3JNgo8PlfdOIM9hSQAVgdtLX9xHHx1yzIf0RYEGUHXzNoJ3GzewTUf3RmHj68up2xbj3A9R8plQvmHhTKTza1agbW6X2DOw6aITj5nAgjKFPwW+e/loreQCGgem04xWpbE60mbAIaEYNZ/+qMJgHWxzddLKwRZOxXl2Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BDjrO2ln; arc=none smtp.client-ip=209.85.208.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f194.google.com with SMTP id 38308e7fff4ca-2fac187eef2so14098721fa.3
        for <bpf@vger.kernel.org>; Sun, 29 Sep 2024 23:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727677853; x=1728282653; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J5JAH4+O+HEsbMKWU05INFsC1ZhTEoKXq3r/2nkYIxA=;
        b=BDjrO2lnZS+RzeklynbJo2njHYRKDfra1zkI27K7GoM2dlYqkncIUNEg4CatawyGgs
         eFQ+4VCBiP3NIALskRkfHX29KPMK4IFuESrkiqwMT2gm9xRRQdviYbe8hdHDC4EqlKQm
         +ioPRVcl/BzOnOT1s4uKylK6Fdimg7lyKGE9cOmGHBAN9uT6VWpTOhnw2YgYUdNdMv8u
         Es29E+iVKMpu5KmmcxAhLHNLLTw+RsgN6G7X8Im7ixRGelzfUekdrrlN/hL3BQvaYnvx
         0paBkeecEcXKUSLRg+IRuqYOTE1Os6BGnEKRuyQFznv5+eK+ZQmRG7odL6dxbJx/fhBz
         ECVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727677853; x=1728282653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J5JAH4+O+HEsbMKWU05INFsC1ZhTEoKXq3r/2nkYIxA=;
        b=F5hJa151HQ738lFNFcC1hpBGWEXq8GiQpv7X75BlPT2CeIH90yS9YKSP5P5SPN7xfg
         XWiw8JKYoreWXWid8Lue7Weff352eBCxJFZMejygEVE3f/deDSv0TKIH1+XhdzMWwm0y
         AGbmgsqK+iVZ9oTGKs/L0X4ZVZUZlNtYsJ/0E6ME3Uq+051FGBr9T31XacHFniNKVdQ6
         mTvvHv3NiVam6w3qUdU88JG+qfLtLSjB2S6gO4gzS2rZfUl3fv8gJn4a+FogdzFsitrm
         54O3vtwHpWAqc0dRSBcZa1O7s+XdAsNi2jHsGwpymSIIJjtclc5dcArj7Q2sa+rvucAk
         6CiQ==
X-Gm-Message-State: AOJu0YwqWis3j5ivo9RUb8UjBUFe9k7U+axm8ILKiVUBx6jLp444AhZL
	GK5TgVSZhsRUvaqF1Y4SVV3qMGYv9swltZIJBLeBIRkQoFUR/zLDa6AJryvxHO0=
X-Google-Smtp-Source: AGHT+IEL9aB0QfdHUhTVutPt2artQ97e0anzWE25pWQ4jsHjorDsLJgtYzBm7+DKxFyfKVs+EPAvfg==
X-Received: by 2002:a2e:a589:0:b0:2fa:d2c3:a7e8 with SMTP id 38308e7fff4ca-2fad2c3af79mr3187971fa.13.1727677852620;
        Sun, 29 Sep 2024 23:30:52 -0700 (PDT)
Received: from u94a ([2401:e180:8892:dc51:8a51:2220:e713:c1ee])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37d6840csm47984565ad.23.2024.09.29.23.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 23:30:52 -0700 (PDT)
Date: Mon, 30 Sep 2024 14:30:35 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Hemanth Malla <hemanth.malla@datadoghq.com>
Subject: Re: Good first-time BPF tasks
Message-ID: <pxhmdzeguovh77x7vjkbwxi2r4nthre6n7w2u63j3frvsediu4@x45otw5mpjq4>
References: <3xru56ozvb4mrphuqt53tvbsiv3n3wfcknme663zcxefayx3re@oq5xnb3o3fec>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3xru56ozvb4mrphuqt53tvbsiv3n3wfcknme663zcxefayx3re@oq5xnb3o3fec>

Hi Andrii and Eduard,

On Sun, Sep 22, 2024 at 02:41:08AM GMT, Shung-Hsi Yu wrote:
> A topic that came up several times off-list at LPC was how to start
> contributing to the BPF subsystem. One of the thing that would probably help
> is to have a list of todos that are nice to have and can be implemented in a
> relatively self-contained set of patches. Here's things that I've gathered.
> 
> On the more concrete task sides (easy to hard):
> 
> - Check return value of btf__align_of() in btf_dump_emit_struct_def()

The above task is currently being worked on. But I though its better to
ask you both for opinion before I lead anyone astray.

My understanding is that btf__align_of() could return an error, thus all
caller should check for its return value, for example:

	static void btf_dump_emit_struct_def(...)
	{
		...
		align = btf__align_of(d->btf, id);
	
		for (i = 0; i < vlen; i++, m++) {
			const char *fname;
			int m_off, m_sz, m_align;
			...
			m_align = packed ? 1 : btf__align_of(d->btf, m->type);
	
			in_bitfield = prev_bitfield && m_sz != 0;
	
			btf_dump_emit_bit_padding(d, off, m_off, m_align, in_bitfield, lvl + 1);
			btf_dump_printf(d, "\n%s", pfx(lvl + 1));
			...
		}
	
		/* pad at the end, if necessary */
		if (is_struct)
			btf_dump_emit_bit_padding(d, off, t->size * 8, align, false, lvl + 1);
		...
	}

Should check whether align or m_align is 0 before moving forward.

The reason I looked into this was because I ran into floating point
exception a while back when trying to dump C-style header file out of a
kernel module while mistakenly using the wrong base BTF, which crashed
inside btf_dump_emit_bit_padding() at

	roundup(cur_off, next_align * 8)

Because roundup() requires the second argument to be positive, yet
next_align that came from a btf__align_of() call was 0. I believe this
still may happen with basic BTF validation[1] added.

So, questions:
- Is checking return value of btf__align_of() in
  btf_dump_emit_struct_def() wanted? And if so:
  - What's the preferable action to take when it returns an error?
	According to the comment for btf_dump_emit_type() it seems like the
	best thing to do is simply return in btf_dump_emit_struct_def()?
  - Should we add a pr_* to report such error?
- Any place that skipping the return value check of btf__align_of() is
  fine?

1: https://lore.kernel.org/bpf/20230825202152.1813394-1-andrii@kernel.org/

(One more question below)

...
> - Replace open-coded & PTR_MAYBE_NULL checks with type_may_be_null()
> - Implement tnum_scast(), and use that to simply var_off induction in
>   coerce_reg_to_size_sx()
> - Better error message when BTF generation failed, or at least fail earlier
> - Refactor to use list_head to create a linked-list of bpf_verifier_state
>   instead of using bpf_verifier_state_list
> 
> On the more general side of things:
> 
> - Improve the documentation
>   - add the missing pieces (e.g. document all BPF_PROG_TYPE_*)
>   - update the out-date part (admittedly quite hard)
> - Improve the BPF selftests coverage
>   - add test for fixes that have been merged but does not come with a
>     corresponding test case to prevent regression
> 
> I want to keep the list from being too verbose, so I won't go into too
> much detail in this email. But feel free to reply to this thread and
> ask. You might want to use https://github.com/sjp38/hackermail to reply
> if you're not familiar with mailing lists.
> (I know mailing list don't have the best UX, is a scary place, and also
> not the best issue tracker, we'll see how this works out and change if
> needed)
> 
> Also If anyone has other things they want to add to the list that will
> be great.

Is there any libbpf task(s) that you think that might be good for
first-time contributors? I see there are issues tracker for the
libbpf/libbpf project on GitHub[2], but wonder if there's specific ones
that are suggested for first time contributor to tackle.

2: https://github.com/libbpf/libbpf/issues

...
> Resources
> 
> - Introduction to BPF selftests
>   https://lore.kernel.org/bpf/62b54401510477eebdb6e1272ba4308ee121c215.camel@gmail.com/

