Return-Path: <bpf+bounces-21964-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B331485484A
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 12:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27CE91F280D8
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 11:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D6D19475;
	Wed, 14 Feb 2024 11:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVD7aIDG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6186A1B7E2
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 11:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707910091; cv=none; b=BY22HLB2zshGfJaCMJgjl1Uk5vxIuGKViym1u6ihJoIYyXyUybALozTlN+HeLgFzaHa6CN5Ma76P0lG7IPxjFYBkjH/1id7gfQoLTjyFDQ+IdQ0YzgUuyuIM82Y/Y8tf4W4NsiYv5Q5CtmAnqW4uUvl+R7/l58iGHXCqGX2NaFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707910091; c=relaxed/simple;
	bh=pJ8/crYwhEjVvOCyhIQykLrb/eTtAFnnZyQt9kZ41Cc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwbC/lPlsr7E7nnEYxar5RPmYIJQeljy8Xv0ymPPuBmdlQQkX0kFf4MvM5tJZ3jgVhknREtujUKky9tPlrXX45QiAP5rYsRm+RKMkHs1O2GGFpzl+o8xzhou8Pa/LOi2iDXGdKyaCl99UHb3glALZTfv+2p7WMyd9vrO7SUjIxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVD7aIDG; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d0cd9871b3so5467791fa.1
        for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 03:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707910087; x=1708514887; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ilK6j7aiXKm79YRIG4VPGrDSniL27Z6n5HlbJy8gcvs=;
        b=AVD7aIDGXCtkg8U4aOJayy3WVu1kc8MBs4rgK5saRePDvGeaG7M+Jr/CX5gTJfT8dl
         I+Xiz5SAdFBG9lCK8a5n75eERogfasx3xHwqfMhZSo86FsjdzHt1iEMkAVbav5jFzTxY
         VkxR31mYhl4ATsJDr1VM8pFwwv/UaYN1WLguaS/Opi4ZHPq5W9q+Flc1jhkMVYilns5w
         9M66l+X+F4saSlGDjKbpXd2CXAJdv8Qpck1FebDP4XGq891nnoc5BaBbd4X9X8RRn1lg
         G3ktqam5BSIN2M7GsB+er+I1gnjfG/V9kouu7Z2CLZHl+3SHEjAGQJRmt3Mbm2yqNV+n
         C2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707910087; x=1708514887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ilK6j7aiXKm79YRIG4VPGrDSniL27Z6n5HlbJy8gcvs=;
        b=ObUk36UWfk3f1Q+QsjMJnyxsfYn2L0k5B7pAnqGG0hOuhN6LomuNxRC1+65ro7B918
         l0SRx0SUDZu/dOrkCgjSh8bgGiR+Vf712I3WVbIz2GCimQQqgjPbywUWSpAKUxx23Jo8
         gzj0iVJIvjRlaMRBQyGgwOfa5ReGwukMMy4Crlvhv9NcRRR/vO/aqCDEMraCXZrb+HCO
         Sp92NrC9NzTJNpFMC4l06MM4yAWWdA+qtv2EJKmDCMDpT3YZmqxSDlofIT6G/JK5mC+s
         ACcTMH5i1zSGoCKKgXUA0i3g/FKGSCVUxis1aanOqTp8GbS/5qG1auwmx/3ZzAGlAvFf
         2I0A==
X-Gm-Message-State: AOJu0Yx4dMqHkXLKFda5OkOIC/4b17G1odHQJum33wfGryrV4gzxpOJo
	a2EOx8xS7B+Oo2Qp39uocsZEMrGDxIvpP+9kJ3tFWxaFSHEN0nDgWevEu+NN
X-Google-Smtp-Source: AGHT+IH1ovkJi18rXRgUWKo0jZkVnQQJX0pwapDf1Se1CDgpUYfgqeLxPbeVxqH6oSbxlBt8YpyNYA==
X-Received: by 2002:a05:651c:1066:b0:2cd:2771:a2fb with SMTP id y6-20020a05651c106600b002cd2771a2fbmr574797ljm.2.1707910086913;
        Wed, 14 Feb 2024 03:28:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWwjY6uu3DtseGuZdPrb8jtlDtIuw0A0lkiCbBDyIcUJQ6oJOZ5Mj/aMfCnnZu+jp++h3AJD14Rnb56/xSvTzMRWwwAo8NtXoTaDfQx2FtDBCHKfgSUQwt/E+WNLIK+YZqWpoECx2J8/5F4D8ryNwtHhNJFqXUtV35B7b4NStOfUng=
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a16-20020a05651c211000b002d11746a310sm209388ljq.13.2024.02.14.03.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 03:28:06 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 14 Feb 2024 12:28:03 +0100
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next] bpf: use O(log(N)) binary search to find line
 info record
Message-ID: <Zcyjw4qX_XHJhFo6@krava>
References: <20240214002311.2197116-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214002311.2197116-1-andrii@kernel.org>

On Tue, Feb 13, 2024 at 04:23:11PM -0800, Andrii Nakryiko wrote:
> Real-world BPF applications keep growing in size. Medium-sized production
> application can easily have 50K+ verified instructions, and its line
> info section in .BTF.ext has more than 3K entries.
> 
> When verifier emits log with log_level>=1, it annotates assembly code
> with matched original C source code. Currently it uses linear search
> over line info records to find a match. As complexity of BPF
> applications grows, this O(K * N) approach scales poorly.
> 
> So, let's instead of linear O(N) search for line info record use faster
> equivalent O(log(N)) binary search algorithm. It's not a plain binary
> search, as we don't look for exact match. It's an upper bound search
> variant, looking for rightmost line info record that starts at or before
> given insn_off.
> 
> Some unscientific measurements were done before and after this change.
> They were done in VM and fluctuate a bit, but overall the speed up is
> undeniable.
> 
> BASELINE
> ========
> File                              Program           Duration (us)   Insns
> --------------------------------  ----------------  -------------  ------
> katran.bpf.o                      balancer_ingress        2497130  343552
> pyperf600.bpf.linked3.o           on_event               12389611  627288
> strobelight_pyperf_libbpf.o       on_py_event              387399   52445
> --------------------------------  ----------------  -------------  ------
> 
> BINARY SEARCH
> =============
> 
> File                              Program           Duration (us)   Insns
> --------------------------------  ----------------  -------------  ------
> katran.bpf.o                      balancer_ingress        2339312  343552
> pyperf600.bpf.linked3.o           on_event                5602203  627288
> strobelight_pyperf_libbpf.o       on_py_event              294761   52445
> --------------------------------  ----------------  -------------  ------
> 
> While Katran's speed up is pretty modest (about 105ms, or 6%), for
> production pyperf BPF program (on_py_event) it's much greater already,
> going from 387ms down to 295ms (23% improvement).
> 
> Looking at BPF selftests's biggest pyperf example, we can see even more
> dramatic improvement, shaving more than 50% of time, going from 12.3s
> down to 5.6s.

nice speedup

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
> Different amount of improvement is the function of overall amount of BPF
> assembly instructions in .bpf.o files (which contributes to how much
> line info records there will be and thus, on average, how much time linear
> search will take), among other things:
> 
> $ llvm-objdump -d katran.bpf.o | wc -l
> 3863
> $ llvm-objdump -d strobelight_pyperf_libbpf.o | wc -l
> 6997
> $ llvm-objdump -d pyperf600.bpf.linked3.o | wc -l
> 87854
> 
> Granted, this only applies to debugging cases (e.g., using veristat, or
> failing verification in production), but seems worth doing to improve
> overall developer experience anyways.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/bpf/log.c | 30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
> index 594a234f122b..2dfac246a27d 100644
> --- a/kernel/bpf/log.c
> +++ b/kernel/bpf/log.c
> @@ -333,7 +333,8 @@ find_linfo(const struct bpf_verifier_env *env, u32 insn_off)
>  {
>  	const struct bpf_line_info *linfo;
>  	const struct bpf_prog *prog;
> -	u32 i, nr_linfo;
> +	u32 nr_linfo;
> +	int l, r, m;
>  
>  	prog = env->prog;
>  	nr_linfo = prog->aux->nr_linfo;
> @@ -342,11 +343,30 @@ find_linfo(const struct bpf_verifier_env *env, u32 insn_off)
>  		return NULL;
>  
>  	linfo = prog->aux->linfo;
> -	for (i = 1; i < nr_linfo; i++)
> -		if (insn_off < linfo[i].insn_off)
> -			break;
> +	/* Loop invariant: linfo[l].insn_off <= insns_off.
> +	 * linfo[0].insn_off == 0 which always satisfies above condition.
> +	 * Binary search is searching for rightmost linfo entry that satisfies
> +	 * the above invariant, giving us the desired record that covers given
> +	 * instruction offset.
> +	 */
> +	l = 0;
> +	r = nr_linfo - 1;
> +	while (l < r) {
> +		/* (r - l + 1) / 2 means we break a tie to the right, so if:
> +		 * l=1, r=2, linfo[l].insn_off <= insn_off, linfo[r].insn_off > insn_off,
> +		 * then m=2, we see that linfo[m].insn_off > insn_off, and so
> +		 * r becomes 1 and we exit the loop with correct l==1.
> +		 * If the tie was broken to the left, m=1 would end us up in
> +		 * an endless loop where l and m stay at 1 and r stays at 2.
> +		 */
> +		m = l + (r - l + 1) / 2;
> +		if (linfo[m].insn_off <= insn_off)
> +			l = m;
> +		else
> +			r = m - 1;
> +	}
>  
> -	return &linfo[i - 1];
> +	return &linfo[l];
>  }
>  
>  static const char *ltrim(const char *s)
> -- 
> 2.39.3
> 
> 

