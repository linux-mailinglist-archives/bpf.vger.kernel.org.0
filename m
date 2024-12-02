Return-Path: <bpf+bounces-45927-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8646A9E012B
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 13:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9691A1626AA
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 12:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3341FE478;
	Mon,  2 Dec 2024 12:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOLX9a97"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5488A1FC0FA;
	Mon,  2 Dec 2024 12:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733140845; cv=none; b=Ik18wg8w8njrUuMYOxN8LpWcyVrlwZS9BWUOEHvs5ffphzhB/xHQ5IfjbTYIIj/XGBzJXuZzoZLIdOKi1wVtv5a0+bSqOYDsUZZl1rFIRu//d6F1mwFtp1/o5lYIMrri3puezlqHtIFbj738LjeT7FO6nhXMj1kH/dz8PJKC+q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733140845; c=relaxed/simple;
	bh=JGYBHesYIbhC7aBl5yCYh/PzDEWQVUhlwalGax3dWiY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMGIK8MY0iAACYzwIYeXW9WZsMs2Jqy2RmoZ2R7+0aAREllUBRcghHQqf+wcLVpTZfluKwZDdPyxKUDtR13Q5uqmSdOwdA+m6shCpPrHNOO1NWKJyG033NxSb9080P0oBCs9NTfQKpg/Hh68Jtf4Tap2bEoOuq9iWytXUuJQQds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mOLX9a97; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-434a1fe2b43so37390325e9.2;
        Mon, 02 Dec 2024 04:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733140843; x=1733745643; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MQnantWxCB7aLJu1F0kD476uJFD2vd0GkTEQYnGy5wg=;
        b=mOLX9a97jirvY0sKTqzVtRymLx1fTYgt9+YkTqzvTjFMjR63I2xYxHFiJuiP7vHy7C
         dneq35YaF51dbSlDwiPrVOUEwwb0WqcUkDHxT8CITApoQXr+OvUQCAhZ31y9z+VyFXqM
         +kLUyjul6LuFpZnSfxb7SXymLfxp/LqhgOJ2ggxnU4zyyJrAjxX6k52mDqPgdnVhXyQ/
         GJpCTqhkzMXpW0bMrv4gxLGft1hYf7OyuwteS2oHVm56XnzyBlw8FhZ+Dqs4OE+PMu4F
         Sbg6DvyphFhNjB7A68f3zH8MdNMocCeAAMYyutN5OdVu0OhFq1k4b3HKPAKhAwwpP4JQ
         4XWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733140843; x=1733745643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQnantWxCB7aLJu1F0kD476uJFD2vd0GkTEQYnGy5wg=;
        b=mI9buOci5Fu0hLR1SQnFGclByTHmC7bpuDtwlLMFYWCMRaoBBvUJm1ptpQ7EeclX2o
         GSKaqW9L7bQf8Zg8OVkUS5UmrZ4y0p09t5YMOFJjV7wwzo8YrUXy9kxGML83JwONjiIw
         35gvnImWbd9RKBzXHH1YQby4exF9DTSHEfkLBtQBgU4a6uJEzinR3wSKg/zNFX1UWP2T
         3b6j+LbfrAQVPIVGLzvpZzYk2VluaLciaJnU+vNF01bVrZCYi5VXSwZwUBfFST7NADMX
         WaGaNwWrssWg0plENQ1bl40lbd5QFjAey6Y1s2DVADIqGJjt9miFLh4D7AteI3JqajH+
         GX3w==
X-Forwarded-Encrypted: i=1; AJvYcCWS9Q0l86ihNPtaCHIu7xsqfpPIdHuxrTE1/Zp5C6VAkiWdquXOnlPqCy6dQlnLUr1RwBg=@vger.kernel.org, AJvYcCWkXjM9Nc7FscYOB2ROIqXgOvQNSMakhzP5Bit4eiX+zB2ThsUDFVjMrZpM5mi/Vr2Xgrvlnfbr6kHI0wFy@vger.kernel.org, AJvYcCX3xzK+dE/iCMv6z3Vszmtj9ytR/F/KP2hvlNbEnuKtoarwVQ6Ye7ZFD5ECe3qm3ArL6zluV26PTg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxB23XR6UF0Tffaxnjd+VPeLXX3PhoFfzgRGaJVWF64yHtRF1tx
	Hfx7v427DdiCvC2ixYQz3hr2H5pqcmcoZZm6hQPKR2G6Ih/JZK66
X-Gm-Gg: ASbGncvVbbLoVnVlfkirQ7USU6P33FPHSGa48Zx3PlSXxO6reqGc8ZP+149H+TyzuDx
	oqWKfGHYOe5YRBcQl4K/L7xxuIYu/5MIso80WsG8/exuhs8k0j2sK/zPMQnvQovry2dbMa7NFA4
	igVUWF2P518oS3V9eIpqLKy7aXUsovEhemCjaG9H5oN+ElVgjZolnSy7M8caf4MLDJiksIO983Z
	ZBWe2fjzcN4YRJHfpcY9e9vIIGbjWDIb9OAR02kJikI/lU/5o33MvMBCs2nLGpc+NvaAtLvkDcd
	iIxpc9n9iHAVCldN+QkAjjE=
X-Google-Smtp-Source: AGHT+IFUnVztOxsIywsf2K4G+S+p56Y2jH9xH9k5ei+h2anBWbIlAMqqxZ0Jl6BPHhhsppFFnIdtUg==
X-Received: by 2002:a05:600c:314a:b0:434:9de2:b101 with SMTP id 5b1f17b1804b1-434a9dbae1amr200448405e9.2.1733140842328;
        Mon, 02 Dec 2024 04:00:42 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7d29fbsm182935605e9.29.2024.12.02.04.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 04:00:41 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 2 Dec 2024 13:00:40 +0100
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>, Daniel Xu <dxu@dxuuu.xyz>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Jan Alexander Steffens <heftig@archlinux.org>,
	Domenico Andreoli <cavok@debian.org>,
	Matthias Schwarzott <zzam@gentoo.org>,
	Dominique Leuenberger <dimstar@opensuse.org>,
	Dominique Martinet <asmadeus@codewreck.org>, bpf@vger.kernel.org,
	kernel-team@fb.com, dwarves@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFT: Testing pahole for the release of v1.28
Message-ID: <Z02haBRcetTCNK7A@krava>
References: <Z0jVLcpgyENlGg6E@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0jVLcpgyENlGg6E@x1>

On Thu, Nov 28, 2024 at 05:40:13PM -0300, Arnaldo Carvalho de Melo wrote:
> Hi,
> 
> 	Please consider testing what is in the master branch both in
> kernel.org as in github:
> 
> https://git.kernel.org/pub/scm/devel/pahole/pahole.git
> https://github.com/acmel/dwarves.git
> 
> 	So that we can release v1.28, we want to follow the cadence of
> the kernel, i.e. since the kernel was recently released, we should
> release a new version of pahole, and this one is long overdue.
> 
> 	We'll then try to release v1.29 shortly after Linus releases
> v6.13, and so on.
> 
> 	Alan Maguire accepted to co-maintain pahole and as soon as he
> gets a kernel.org account he'll be able to help me in processing
> patches, that we expect to continue with the current fashion of being
> tested and reviewed by as many developers as possible, its greatly
> appreciated and a good way for us to keep this codebase in shape.
> 
> Thanks a lot for all the help,

hi,
works fine on my setup

Tested-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

