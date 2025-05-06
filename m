Return-Path: <bpf+bounces-57479-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46200AAB945
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 08:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 011471C26D7E
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 06:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A62236430;
	Tue,  6 May 2025 04:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gfrsILBB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2812FF2BD
	for <bpf@vger.kernel.org>; Tue,  6 May 2025 02:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746498043; cv=none; b=gwRIS2Z/GOQbgRKy/VRZoM24LdlWxw9HVQUFizcdcUNauZNmG/qUZoyt+l77TNUucdxLnF10N668yRNAZVNDFtuOmmbK0k1nR9vD9PKnB7JvSwCe5us3FjphTbd49sCfwem+aZ1BeXAoFc3UylNhQsyTUp6LvorcygKpbTZGakU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746498043; c=relaxed/simple;
	bh=pB/2z9gfgk2QzpmlM92q8FYnfovHFOn4LHn8HHtn3ZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UrytcPFVRXZsRD+0gepEg0uJJVRNiv2XM6VpMdBZHuVUmXiYnAdhEy4P+wjd3ChfxYuYj5ibsf6tfIZoePPw+g+w0JR0mHF1Bl9VNPeSWQA/6ONxpIVWvsvbKu9dr9wj0aEAa5K5IN9m2hWHZddSMpOCwPX+pVpH6tpZRPyr7yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gfrsILBB; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso5382595b3a.2
        for <bpf@vger.kernel.org>; Mon, 05 May 2025 19:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1746498041; x=1747102841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YCRivcMyKZAjTDZHcc+7HA18fyk8T4lAA8XlsxUQKdQ=;
        b=gfrsILBBHx+up9yBXju5DXqKwSz/MMQeUd6C6UtCfmtCvjzCRf1VWLut1v644DXEvB
         hRSALIMzGS1Uyo5IQMx+omHlKfLuyEzx0K7XfxXFnR/jq+EU0oeNPchAKky5gSm8REAA
         J04iZKRcGiPPibX9D260oqUxvVQsxbZo4hR6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746498041; x=1747102841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCRivcMyKZAjTDZHcc+7HA18fyk8T4lAA8XlsxUQKdQ=;
        b=OGo/4sgEdy7AGfLhMa8zw2bxXzyZEfPex93Ciu/aW4L9dap3VUhrt80SAHNlNP0qBd
         C950rTnaZtHMJlTOGX67Kv2Gi0mjmgJPEfSaRT7vmpW9V8w1qGArEC+BdoZefOr/gVNf
         pAyMca2RgjCH+s1Uz5EdDar4qpzDK1dPm4FgAZmgW6xPm2UVIzLa8RF1q96RiWdzxglV
         nlOqtL1ZieETuIaS90CGHoyJ/sYk+kX49f5YjLtkwSYPpWAxF6p9Yrs3nVpN/km53GTF
         KD1+lpSh/WmGexBinAG8hZ6aArDwe3Xfvj9JGnZ9ZVnmHt5/IJTQoB0BBAjfIrOUzE06
         3TcA==
X-Forwarded-Encrypted: i=1; AJvYcCX7XWwab6ky3tuas6s8q+x9clEq/qidnSqGcKpTPW/9ndXf+VLU/wbsNxUI2fj+rz2t9aA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj/eLyoulZRTbw2mi4ckhyYy5GAxLtay5hP/itRd1kJkgo2O/X
	LiixHqBJLZqT21jk/U/NxribwnVi8uee/Dv4oNeUFkVc/isLlSVprdX6O678HA==
X-Gm-Gg: ASbGnctj6T/YPBhKqAahL5bMH4lTsnqHh8aK2goT89Ez0IMtiuQuAt+H6Jf4PEvxVm4
	FrfNe0AuMvHKBhixT7BYMMM6Fk+q6hu0UzztBCDrBymPZ2iPxjP7WEcICzga+QRN/JHUIFBWcKG
	NRoXqgIPzVIpz2an1CJW5ZlICJIEv6tAzetyOJbMpSlKV+qD8ErSS6ZOQ4ZLu2e2nsi4R0NENEb
	eFITbvldGCvhvR2mrqKNl49uFpIBxJlnj7NQ4D9WuBVbNUMaKAe7P1tG7AbkDIgHfHpIs9SUMyv
	+S4QNkmXPx9d7Di56eoeLUJax6IzhbGmVuH/lPx2EBLq
X-Google-Smtp-Source: AGHT+IGh1OnULhXn2xtFUOqy1BCdiiwtDwGquTntDY3zBj6xTjRCCRtPqb5UQgHUOHJ7rl2HYeeMFQ==
X-Received: by 2002:a05:6a20:2452:b0:1ee:b8bc:3d2e with SMTP id adf61e73a8af0-20cde373ebbmr24382308637.8.1746498040820;
        Mon, 05 May 2025 19:20:40 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:4dd5:88f9:86cd:18ef])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b1fb3c3bfabsm6327470a12.62.2025.05.05.19.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 19:20:40 -0700 (PDT)
Date: Tue, 6 May 2025 11:20:35 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: add bpf_msleep_interruptible()
Message-ID: <6g5d4y7ahyjcrlixjkzwgn473klmdhib376q5vvvfp2kelkk6t@yz6sipuhe2lt>
References: <20250505063918.3320164-1-senozhatsky@chromium.org>
 <CAPhsuW7-jkU+KiunvZw9-NsxT+7ohcHQtJ6JSXNU4aDPxJLWwQ@mail.gmail.com>
 <CAP01T74_fCpuqwPpqs0tVWAUwO3rm6D-PRC0MZjiGyqf=oXRPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP01T74_fCpuqwPpqs0tVWAUwO3rm6D-PRC0MZjiGyqf=oXRPQ@mail.gmail.com>

On (25/05/05 21:30), Kumar Kartikeya Dwivedi wrote:
> On Mon, 5 May 2025 at 21:07, Song Liu <song@kernel.org> wrote:
> > Please keep in mind that BPF programs run in not sleepable
> > contexts, including NMIs. Maybe udelay() is a better option?

If we want to timeout various SCSI operations, for instance, I think
we need to sleep for seconds.  udelay() won't probably work for that.

> Or mark the kfunc KF_SLEEPABLE, IIUC the intention is to use it from
> hooks which are sleepable.

I think it is already marked as KF_SLEEPABLE.

