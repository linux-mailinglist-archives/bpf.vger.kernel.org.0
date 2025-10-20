Return-Path: <bpf+bounces-71357-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D56BEFA5B
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 09:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 357B64EEC9B
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 07:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064452D877A;
	Mon, 20 Oct 2025 07:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JL9o6iWm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98D81C3306
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 07:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760944630; cv=none; b=BlYM5sHpImaDA4eUbRA0CY3VhFA3V36OU9Mh7n7RSkFc7z/crQujPjioa4OitMwXcBZHvB54rZcI+i8yJvHBC19uZRIxTSFsSs7ceqS56VKQ4ZMvW1ZQqwpLVKzHGWQBww+uXrtSV9EtgglhEA7yY84gM47DwWGDMMeDG+ZOSUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760944630; c=relaxed/simple;
	bh=VX98mlxtPYjH7uHi14fcU0Y9W2rCrcBlo0la6pmre5Q=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EqQrwlomTmLwUEm+wC3bKVDdzoRfHmKX01taFRUNwKeYjl32pJv4p6fjQherEA7hRSkf6jqqPYWE73LsknHx6raHsEOYhejlmeF1Oe5AGQVPSFmhtNPvST8iBsaez3raDUMmuRuGwIJeJV2SeESPAbmxKRqqUrenre21lQIri3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JL9o6iWm; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47118259fd8so21322485e9.3
        for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 00:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760944626; x=1761549426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qGeDgH+006nMBZO+STd4+dGyA3p+13YdnkLcw3+y6Rs=;
        b=JL9o6iWm6ykjhViMNoTvGjBheQVWEShRJIWdkxoc/3LhealsZ1UU6dgmfDbp7jauXW
         lpX1IpwhGum5uNVApRh4AvxEpmrV9nlFhS91LD0EcGiHsTZ0xImp0RaiQSSOrnJidTPF
         wFbSMJHc9tqkHozoK46EH0rowgIHJ6kf6om2xzoZjN16ZN0DeAaCmX8ab94YtmuI22tI
         3DcsWPKOf7Q+DOrI3/OsBTrbRMXWYpT2pNhBR+5dS/gxxX9pLyay7dv3f+dzAasBDtQk
         zdPTbMosbK5i8bTqyTFa5qBRMGbQO0bGcu4BThmdraYGNjyLqwldX4pPpsrwNJOPiyo1
         3PiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760944626; x=1761549426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qGeDgH+006nMBZO+STd4+dGyA3p+13YdnkLcw3+y6Rs=;
        b=PiaN/PxbnpdReBUrwaBEEHKlpZtxkCi6OnEPheL1QHihxExyDy3TDp0BgZ6azMvaeU
         2YMpIVCvup/sP3esnjhSyDBEtTH4+8WhAMBN7q/DgWLtNaoxH7CMhGouHG72qTT+ck9K
         5OUnNCp8Nz5x0GEHOu0TITpmOIX9nkSBBLK+rscOBSGAgTP9+83I38sdK3NpCxCnU9tZ
         DY1fc3i2gfRXp+nt3ltuz2yRVoicjWQP4rukb+Y33NMhytlHRCDjxLlIiukY7ckYMFev
         nhdO8FEjapBK9QIyztN7GmV0vrGVMLr4qlVmVhdJCLzSif5MGcOS4StVfAt3r3U20YCQ
         sGFw==
X-Gm-Message-State: AOJu0YykdNvovXmAwiBp+Js/Xr4aX/8sJYeoHpVbeUWWDIWOIBjiB7nE
	zKCDmCaVsCzCn0XlMLX8+2QyGe0OgvnaqLx2Z2ot4pvI+P/ihAmI3rKIbat46w==
X-Gm-Gg: ASbGncvu+DH33uy4YK5jwLNotEuayHOYTyVJJri+m1T2CW3XeAt1V5zO3vBaxpaz74S
	jB79R6sgtBBV+OnNKzAm8ppexU4cxPT7iVlb0nH4GfdthxwroYygRo5vznGV90UYBjn9TsEkrRa
	tE/l/i/2ou4ShjjAES09xKo3MruqRXvqcGO27gVvaRNRYENN71K09GY/P6ML2FM1ia7exzfY598
	mg6sblIgygWEP0RH/+xuZTVZHWP+c2e63A32IuYYB81I3uVNpA/wNdQnMIn7X049VAzKESrQO+B
	/MclBzrtKh4hfzy2fCNvq3x5h98W7bKPzodMf+dto6pZzQf1KmlvMZAHoR9vFTXQWFpk/cl13Oy
	TSYS3ZDGAZk3pAe4CMp1S1zb10nva7OhdPp8vcbmFN6jcujtFofi/GndzNYyptbgE/DCjpYk9Uz
	j7TWuKJeQK+AymkbgDKpsn
X-Google-Smtp-Source: AGHT+IHCqu/FMlKsBy5PujdUoOM5euAkp+HjAqCActyQIp4PAfiDc5AfsA0/OnbcR1+hGsMfq66tyQ==
X-Received: by 2002:a05:600c:3e8f:b0:46f:a95d:e9e7 with SMTP id 5b1f17b1804b1-471177ab11dmr90834745e9.0.1760944625651;
        Mon, 20 Oct 2025 00:17:05 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144c831asm209053675e9.13.2025.10.20.00.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 00:17:05 -0700 (PDT)
Date: Mon, 20 Oct 2025 07:23:30 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v6 bpf-next 10/17] bpf, x86: add support for indirect
 jumps
Message-ID: <aPXjcpoDmWAvY3yw@mail.gmail.com>
References: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
 <20251019202145.3944697-11-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251019202145.3944697-11-a.s.protopopov@gmail.com>

On 25/10/19 08:21PM, Anton Protopopov wrote:
> Add support for a new instruction
> 
>     BPF_JMP|BPF_X|BPF_JA, SRC=0, DST=Rx, off=0, imm=0
>
> [...]
>
> +static struct bpf_iarray *
> +create_jt(int t, struct bpf_verifier_env *env, int fd)
> +{
> +	static struct bpf_subprog_info *subprog;
> +	int subprog_start, subprog_end;
> +	struct bpf_iarray *jt;
> +	int i;
> +
> +	subprog = bpf_find_containing_subprog(env, t);
> +	subprog_start = subprog->start;
> +	subprog_end = (subprog + 1)->start;
> +	jt = jt_from_subprog(env, subprog_start, subprog_end);
> +	if (IS_ERR(jt))
> +		return jt;
> +
> +	/* Check that the every element of the jump table fits within the given subprogram */
> +	for (i = 0; i < jt->cnt; i++) {
> +		if (jt->items[i] < subprog_start || jt->items[i] >= subprog_end) {
> +			verbose(env, "jump table for insn %d points outside of the subprog [%u,%u]",
> +					t, subprog_start, subprog_end);
> +			return ERR_PTR(-EINVAL);

AI found a bug here: jt should have been freed in this error path.
Will fix in the next version.

