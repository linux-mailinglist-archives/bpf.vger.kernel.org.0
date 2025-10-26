Return-Path: <bpf+bounces-72273-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B6EC0B2ED
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 21:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 780B93B6C5B
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 20:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07F126E6F0;
	Sun, 26 Oct 2025 20:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZ8kl16Z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286A9240604
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 20:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761510462; cv=none; b=m6mGCgJn0Y2lJcTPnGBMvRbysMXpU5vMlYEA1KszcdoPgPlsEP8txawiJZepPiDY2CfSjxecEa8xFRvbstohgi2oZR5L5ENMMpaGcrYHIsHiDf+3MNCKbww5SOLpbsNfeJId2LpIvMJ3Q40EUT7rX6U2nym/AKfsO4wOk3ADEX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761510462; c=relaxed/simple;
	bh=bCRYFVf/yj26So76o/UscaSGcOLCs2R309YdgNO2eV8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNG8WMhPBxtSjkKfZg77AP+m9dB8iRJsBvwlPshJPukOL6fFEVaasBZY+Q68FukpauBjMYdP/VYrn2G5g8bi7xwiyQLejffAJ+2T7tMyXEMO/PKY1wrWi+yG1X7g4UDnC28NblPk/QcX+Vk1YF0+nzXv8vRAG2ntQXxUvffbt9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZ8kl16Z; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-475ca9237c2so21347535e9.3
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 13:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761510457; x=1762115257; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pblCzHnA/TD1DlfgnXYI2tr2t1P6JwQmaCDKB+tRFYY=;
        b=VZ8kl16Z2slDJLPqmZPO2HXdf5WyvwU5JOx8Qib6oOSQZkPXaOtqMTMu6q9J+vYcjg
         dWvU8mbri+blOddmgbzsHRaj/iXyHAu9obemiTG8ppUr5zNyb5id67zkQQ5Q+Jga4gh8
         8DN6oLTScA+vPehRo6xN/fL5weeVYdwyOV44SpOEfMoBtfNV75AsvteVtM2mIAboZFgA
         8+L74iEkcLNRutlJskkVCj6QNtDbnOvRiTuBQmQTd2s/QyV1G6R5b6UonErnJyrYPYxY
         mMcgKYk4+RmDT0OdV8hmS8nXcCA6LG3XNIYH+eH+kgsz3zO0+XnHFoEtFgei7HEhjc3W
         x4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761510457; x=1762115257;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pblCzHnA/TD1DlfgnXYI2tr2t1P6JwQmaCDKB+tRFYY=;
        b=KZlfReMGEii2CZ0EyDEvfJ+n4uWK9mcuYSOMB+01z8AfUdbLeFXzREeeNZ5crKvh4n
         NdUnbZSVVzXllXmm97eTvpbhNmgW/R61fpmSUmZ7mJ5qK5O2w1C9TB9QmSvTHBY4oE5+
         Cz5KdXfY9YOQXfha0wdickZwvok6HnuAKHpHoadU8MI0BZkuB/hGX2XXErNPde3Ppblc
         zv2H2n0WtD6U9upAyEtrjJd+acOmw1bYXRxVgIeJEyMoyzoyQC316IJdEhbi5ULxwl/2
         RHZUj/xl1pbvDEKR+IzUTP5p/myJOVXO/QJQAMy87n/VkIiznHQvasyo1LJz710/ZlVX
         L2iQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUNWRuw6Of6/svkDFb6vJlR25KW+L3T54RjG1Rcq59uahfpBYXiM55H6mdTKlGZfto/K8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE1u9WC4K717KRMnDL5e+ouxWU3jX9jg0VLm9Uwlnxfn001/RN
	PfUrzcnXhCLzvimWJKUtlj/bVRiiRkOdLHhG9bkHmdQfoEr0bODvKxuS
X-Gm-Gg: ASbGncsKqwn6xWB6MMha6+gQQwhCN3ukJRsFJHEfs2nKJXnR0bEjWZiYGkFZ9omjV5c
	QqgOECLbS0jkDJ7JAHzLFzWgRf0qc1JZIrvhZozEVlHu9SiRj6H+wqIx0e4JEQL/LZI/LImpXAv
	CLbnLmgWt6Opisna4wIjpBvzQqQwefj4MsBDGb0yWkt2hCoDMPpimAMX2/mV1sB+lDzo2kUHh8q
	3fpNJbpRWO3rFdv26UCSCuLWVN0ioHKJdBfn+VtEIrfxYOrJdlozznoQipZAf22d4YOfWsEOZza
	bmjnvOhiO2gLCLp73L/bKEDCKUe0XMXwPO+ReIDRtzhApJbm2h0Fk8+Rqiga+hRP3E37dUxRVTK
	LYYYagRNgx2i2xuFZQDbZChYKVw5YzwQBzryfl3eWOoG/Ejf8nrUe6bHmN6fSDd/r
X-Google-Smtp-Source: AGHT+IFlHbsfbgm+f6PZD4U6LbUt6zcC9Kc4REe2auj3h2CrWE2UTufQJB1Q/D7zVf6QyTHhVZYEBA==
X-Received: by 2002:a05:600c:83c6:b0:475:de12:d3b5 with SMTP id 5b1f17b1804b1-475de12d752mr48711745e9.34.1761510457198;
        Sun, 26 Oct 2025 13:27:37 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd48a07dsm98111805e9.17.2025.10.26.13.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 13:27:36 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 26 Oct 2025 21:27:34 +0100
To: Song Liu <songliubraving@meta.com>
Cc: Song Liu <song@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"live-patching@vger.kernel.org" <live-patching@vger.kernel.org>,
	"ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	"andrii@kernel.org" <andrii@kernel.org>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"andrey.grodzovsky@crowdstrike.com" <andrey.grodzovsky@crowdstrike.com>,
	"mhiramat@kernel.org" <mhiramat@kernel.org>,
	Kernel Team <kernel-team@meta.com>,
	"olsajiri@gmail.com" <olsajiri@gmail.com>
Subject: Re: [PATCH v2 bpf 0/3] Fix ftrace for livepatch + BPF fexit programs
Message-ID: <aP6ENht0hNVcVYbf@krava>
References: <20251024182901.3247573-1-song@kernel.org>
 <8412F9AA-FEC6-4EFA-BACD-8B1579B90177@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8412F9AA-FEC6-4EFA-BACD-8B1579B90177@meta.com>

On Fri, Oct 24, 2025 at 08:47:08PM +0000, Song Liu wrote:
> 
> 
> > On Oct 24, 2025, at 11:28 AM, Song Liu <song@kernel.org> wrote:
> > 
> > livepatch and BPF trampoline are two special users of ftrace. livepatch
> > uses ftrace with IPMODIFY flag and BPF trampoline uses ftrace direct
> > functions. When livepatch and BPF trampoline with fexit programs attach to
> > the same kernel function, BPF trampoline needs to call into the patched
> > version of the kernel function.
> > 
> > 1/3 and 2/3 of this patchset fix two issues with livepatch + fexit cases,
> > one in the register_ftrace_direct path, the other in the
> > modify_ftrace_direct path.
> > 
> > 3/3 adds selftests for both cases.
> 
> AI has a good point on this:
> 
> https://github.com/kernel-patches/bpf/pull/10088#issuecomment-3444465504

makes sense, I think it'll make the code easier to read

jirka

> 
> 
> I will wait a bit more for human to chime in before sending v3 with the
> suggestion by AI. 
> 
> Thanks,
> Song
> 

