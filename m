Return-Path: <bpf+bounces-22505-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 457CF85FD1B
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 16:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0059B289FE6
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 15:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81CB3D97D;
	Thu, 22 Feb 2024 15:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bSXkMABR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD48514E2E8
	for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 15:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708617178; cv=none; b=CsU9fQfDli/DXKU2UjJbUHB7ejTlZodw/rQUcCdzaYR+3skG5lAxdkJVaqXg+60j7plUqh0PsEmPL9lWgybjysq80LefX6GBoKKKpty0Oc8MnGPZF8miKzc6fYiJzxq3H9p5ImLjm1v/DHvw1Evhga4274iXK/lMZq/0UmCgc2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708617178; c=relaxed/simple;
	bh=Vd3UzDgmX7Ao1DnE+nzyieBLFnftQ/B8sJIJRrxRpco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ux/uMIoa/Bw3r10heIJV/f48T/XSu3siX/WEZxirgd4D+pe3wYP+eOg24JIiN8rqrV4rdDg37TVgTEDyVShN+1yWimr5u2++teYfEIwNdiwI5um8F7+CwIXi3CHm41eMu/Ga7X1vabsZI2xJ99g3Jy3QNp/IN6BLqBJnpoUuscc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bSXkMABR; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e22e63abf1so3944840b3a.3
        for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 07:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708617176; x=1709221976; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1gfwnWmu63cYswR0b/u7RtSKFeQyr0VL4Kut1suu2n8=;
        b=bSXkMABRd5Gy9iYQZn6+kg10M0jGKVqcKbqT6VPDcuAA7I4OwHLOV8WaS+y/iZyRAA
         ZXkOoGHpESpLUfIhI9+kzg2G+h3GF+ylw44PN5ekhfb4B0mYFV+jnIr21/MZ8Ub7Wnw1
         xJO9AxAD0f5W355FyYMKjxJ+6Hq2yKqAYPkWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708617176; x=1709221976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1gfwnWmu63cYswR0b/u7RtSKFeQyr0VL4Kut1suu2n8=;
        b=FLSDQkMDSPM3MQ029l3QSzWQ3Gcz0IDjBEM9m5XD5+AS3g7vj7YlDnIqw073Hiz9kY
         9ugzPK56B6oXAZp5+xIwZMqbp8G8GrqJx40Xm3WhH1N8AGqaLmCazxOnb8lpss/FFQ6M
         j3uWtmxp9jMhC/jCBe2Howti2zg/o9ZQtRd8H9YOFuizpwhESN6zMaMVsfHj5UZ5vB0v
         Lt8Q49cV7P/i07/flfZjKof2qfyHofDtnczsSuTy51UPvZWnqNeSoZEcotN/4HmLu+9L
         2i7huIz2uatzTER/hF0RRhxUp1Xpplaq60C8xNymZv1WjXJUOtyORAGl/0J9MnA4+Btp
         NtSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4UXYmHlCBKkXI4w1phgXuIP0BPYP9F+leZxHqM7yD+ntgMd3+xSGAVEb27DPkEonqNJOmZl05mM4/Gt1tNFoifOSa
X-Gm-Message-State: AOJu0YwrKkV5cAGu+mDtttof9Wh8Q1lnKYhnEQ6l58GyPD/EjgdjWwu6
	jYUCKMeaN64PHCbwgwCnviM2ZhOhtMcYWcC+RcnT1+46PWsyB2K4GT33TeWN4Q==
X-Google-Smtp-Source: AGHT+IGrtsHGeHfg7xJD4IpKzMvkDmfLWoRjY3MrY0wjNmBdDYmkUNv35SM8aT2MKwO5Lko2A1nlBA==
X-Received: by 2002:aa7:90c6:0:b0:6e1:44ec:8e9e with SMTP id k6-20020aa790c6000000b006e144ec8e9emr14895496pfk.21.1708617176218;
        Thu, 22 Feb 2024 07:52:56 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g19-20020a056a0023d300b006e469e8b634sm7589863pfc.3.2024.02.22.07.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 07:52:55 -0800 (PST)
Date: Thu, 22 Feb 2024 07:52:54 -0800
From: Kees Cook <keescook@chromium.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Mark Rutland <mark.rutland@arm.com>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Haowen Bai <baihaowen@meizu.com>, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Yonghong Song <yonghong.song@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	Yafang Shao <laoar.shao@gmail.com>, Kui-Feng Lee <kuifeng@meta.com>,
	Anton Protopopov <aspsk@isovalent.com>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	netdev@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5] bpf: Replace bpf_lpm_trie_key 0-length array with
 flexible array
Message-ID: <202402220751.2370A263AD@keescook>
References: <20240221222613.do.428-kees@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221222613.do.428-kees@kernel.org>

On Wed, Feb 21, 2024 at 02:26:20PM -0800, Kees Cook wrote:
> Replace deprecated 0-length array in struct bpf_lpm_trie_key with
> flexible array. Found with GCC 13:

Nope, still breaking CI. I will respin again...
https://github.com/kernel-patches/bpf/actions/runs/7996482005/job/21839056683?pr=6451

-Kees

-- 
Kees Cook

