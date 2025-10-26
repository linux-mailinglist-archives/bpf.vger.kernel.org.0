Return-Path: <bpf+bounces-72272-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33339C0B1C0
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 21:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2F9F1886B5F
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 20:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42C6246BBA;
	Sun, 26 Oct 2025 20:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="feYFzQoU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E595E3207
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 20:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761509358; cv=none; b=SG+oML9EXOuYI0zmEe1gBDTFa+gNJWuDyIJ3BbZDRpBzSs5BAIjCyVBPf+wcPRGKlMZ+QEHSqmMTSAf5bdD7lS5Es8kPejiE9ycZjUH6bahpU1VbBUgGclFJFM5MOS+k9nq4Ahke5WiFnqh6yfSgvfbTy4LBzN4WRCXJ8+UDXRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761509358; c=relaxed/simple;
	bh=Tm7mFHJDCqzAT9Q0vSNC9AAbGipDNd9XVt8ZATxCHtA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYir8s4WwJ6hCZ+XRQ1PRCV3x47O2o1FdT3XGBED+b1/Urrt67tOXyW5KtjmEsm8gagBDWa28TODz2QCGLJ9LjMsjSzOP5JqPYk7nYBQ9jPv/4AlBoWwJR4m0+dk4PZ4+dzn9F/AvUjyIUYNja5AxV+eI5U28Fvt2MQYKbwcS+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=feYFzQoU; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4770c34ca8eso6897235e9.0
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 13:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761509355; x=1762114155; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qecvpDR4wuxb90B1fEPxPGa75qjm657f2FyC0E/w2ts=;
        b=feYFzQoU3Mm44uHb6tVprvdbCBBgwRY2+y0pzvq3uiWjQYGsCrPuzJPLfbm+dc0xt8
         BGaiFbhhENoBy0KyGDZBOeUdPZgCGSwbo/4xCf6jKGQIUgArI6tEVtnAidU3F0soXQvh
         yEh7+O/DytlLCLyWGO2/bx8ao+gOgCEIYIHynn3/U+2QMawm2zPsAqMlJFAQ7qR2SWjX
         u8Ktjdq72NnzGnZyuAAqec/80C46EWgBIhhG/GEoypweOn2PaHgl1Hm8InxzIDSJUDKQ
         7xq5M2fMOCwLS40oormYOxMj50xZ12HGfadA4UvyUsv8p+CLnUzr/pESplyP457J41e9
         YiXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761509355; x=1762114155;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qecvpDR4wuxb90B1fEPxPGa75qjm657f2FyC0E/w2ts=;
        b=kqV/NlfzUpHowoScjGCKamqnNqckfNEf7kt0t8wockST7xnmum4Yla2f84X1v0puvB
         3GQuQ0gRxOMFsya+ZIsl8WGGSy+gQgyNXLm6JKkb8swIKVYMH3G8PzQSU2mP+JY/AbAq
         NhnH4Ytnw/LZLnB7XfaRw0FJUZV97MwCx/9gUumjS4z1BGoAG0ToDunzcmgPsxzzZYuw
         9B8DB+N32kthwHvJskvpQfKkIG49ub6d1YT+g8LksHXcHXF3Ktd0zwhon2qGk4mCY9bU
         CDDPnktz4mthx801beq+IESCcp9AYcNKq6I1tAO39veDrOsWqJ4sHTNEn9xTyebgj8EM
         YSTA==
X-Gm-Message-State: AOJu0Yw3p3IqNjkJ1l/lDI0LGN6OZevVaQRa3Pxpjy2/Vs59KeLSRDT4
	RjBvLLewueOKTMR4r64UuwHHc9uEAe6OEFZqHzLAs94IOTXbrSIcp5waUruAxA==
X-Gm-Gg: ASbGncs75vAF9a+LjE8yreyrTwLvaQzj1me6PJEAkQjQYaHribxTd7aSfCyC/5jb1LU
	fGv44b5tnoEmnnNkrF30rSPky/ahK0DxBgQJd5KW7b5nSPAA4f4XqM0yshSHyM3BzuMlc47REpi
	3z8OLZU4iofy6wqj0+zSAwou6K8GPtpL11Te266+Csawbq1kVoH2YGZOGnmM6t/Cwa8O7QF0H/9
	ppR9zklBuYajfsp5mrLJVpKq/SjKSR9rh+ib62sT5tS3mdWNFs5UQJqwuBtnIw7ffwed/pQ1Zf7
	To8LMWGXRJWw3v7DMjcK13xTS6jiscUnf4XJ+8sJoO+FOGK5HXCnlMpxsM9lGpspBKRpAuIgQwl
	Gy9eItDzNXX0sfkGqehQzk1tm8xkKGneIwOHGxxFKdffYoQoDG4GYRzZa3J3cH4dnOvQRfF+Nz6
	n2FnjCj+kLXgutM6w2dxtJ
X-Google-Smtp-Source: AGHT+IGeQgmChLdznF7pAu4S9cBDb4BrxxNgvXj7f1v5/SlRproG9QstguNtdK/GV6/AYifQFr0vdw==
X-Received: by 2002:a05:600c:3b24:b0:46e:1abc:1811 with SMTP id 5b1f17b1804b1-47117912b6amr254343615e9.27.1761509354953;
        Sun, 26 Oct 2025 13:09:14 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d4494sm10185082f8f.21.2025.10.26.13.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 13:09:14 -0700 (PDT)
Date: Sun, 26 Oct 2025 20:15:54 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v7 bpf-next 09/12] libbpf: support llvm-generated
 indirect jumps
Message-ID: <aP6BevtDoOh58/48@mail.gmail.com>
References: <20251026192709.1964787-1-a.s.protopopov@gmail.com>
 <20251026192709.1964787-10-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251026192709.1964787-10-a.s.protopopov@gmail.com>

On 25/10/26 07:27PM, Anton Protopopov wrote:
> [...]
> +	if (!obj->jumptables_data) {
> +		pr_warn("map '.jumptables': ELF file is missing jump table data\n");
> +		err = -EINVAL;
> +		goto err_close;
> +	}
> +	if (sym_off + jt_size > obj->jumptables_data_sz) {
> +		pr_warn("jumptables_data size is %zd, trying to access %d\n",
> +			obj->jumptables_data_sz, sym_off + jt_size);
> +		err = -EINVAL;
> +		goto err_close;
> +	}
> +
> +	jt = (__u64 *)(obj->jumptables_data + sym_off);
> +	for (i = 0; i < max_entries; i++) {
> +		/*
> +		 * The offset should be made to be relative to the beginning of
> +		 * the main function, not the subfunction.
> +		 */
> +		insn_off = jt[i]/sizeof(struct bpf_insn);
> +		if (!prog->subprogs) {
> +			insn_off -= prog->sec_insn_off;
> +		} else {
> +			subprog_idx = find_subprog_idx(prog, relo->insn_idx);
> +			if (subprog_idx < 0) {
> +				pr_warn("invalid jump insn idx[%d]: %d, no subprog found\n",
> +					i, relo->insn_idx);
> +				err = -EINVAL;
> +			}

And AI found a correct issue here. Should +goto err_close. Fixed it.

> +			insn_off -= prog->subprogs[subprog_idx].sec_insn_off;
> +			insn_off += prog->subprogs[subprog_idx].sub_insn_off;
> +		}
> [...]

