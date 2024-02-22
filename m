Return-Path: <bpf+bounces-22519-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 365CC8601F0
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 19:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 683861C2659A
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 18:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AF36E5FA;
	Thu, 22 Feb 2024 18:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jZnn94kL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D179E6E5E0
	for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 18:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627627; cv=none; b=PHRq0T2KZVAw0MmjIAuh5UoMd8f+p19J53aC9Y06mUhybPInPs5aYEoQmUUyvVNq7kAy/3ZHrNlYOmkGw3jdJwjEZeD9q4QvQ/qxn0bmXwXZTTEsCOro9/ihcpLlNcOH90Gvr9ARyx2H09JKrN6q6oxlclZ9sDMSFwgrdF3JZU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627627; c=relaxed/simple;
	bh=NwoZ/s/YB6zInacwyEad3YhKFkgtInk+ILfXRdyVvto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDIHlzLh2k0COtwKvozwR7MhfLC9AXjOtSzT2YXvdppYcnj6yD4YuLxA3cEZPAQSy6s4M2OhvW5EiMM/4cuknc+2lgxPs6zFV6bwo4idcOplwKhqz+uJfD/eT65n0zrC9SAAc0ijBDmkGYou9BHMIhQxi6FsxqmjxLBSL26D3dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jZnn94kL; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6da9c834646so2003503b3a.3
        for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 10:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708627625; x=1709232425; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W4vpO/kuwhEAbu5lyhpp3cdM+wCLzEUK+hlVl6YVNB0=;
        b=jZnn94kLXyYka+9eXc6AizHVEys8TFY2OiJFG7PIg2WwOoOPGz/WnjIUBC7K1XuDyA
         N9WXbD4i43+FAb+UXraPUYghcAZtBZ9c/hsS++vfJPdXD4DWX6Tn2LFckfPHMQVQ39OA
         b5jXaD5DSRAvbP8DPkBMeXcy0mMxLq472fvQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708627625; x=1709232425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4vpO/kuwhEAbu5lyhpp3cdM+wCLzEUK+hlVl6YVNB0=;
        b=gmWbFg3ayPLk2BbWNgXOVfe2FPe6rlmK8gsIVsOO85qWLkzi1ISUJgvj69YWQ5y5zd
         ZYzZSwn+NxmhsDK7LQ1gSkNVdNQvvPUYmPhtNkWlnGozM8tMPwNLC3xdPGbU+IuCA0af
         jHU/TW8yPoQt/B9Q+6HPsndHB7z2rJfMslcgnmUAiab2uz8ECHnBomgy1q3BGO1LM+Q4
         v2Td38ehbjdPI5g+dF3nDiIMnTSwzUXKJWWPv1R63scIl7RKp0xops7vn/WWiUqfc0RV
         See7drtU1ae9Jeyaw6g6/ikAfXKyraQjcQ987TRG/HDtR3hsl1yT1rb4aeuf1/OZxC/E
         qVWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVghNbPjxJ4LtLbCIeVJ9qgw+2uQNPRHVSA0wo9pUdYhr179D5/zOdrFXuTfIMbj3TKb/khFxgCUb2VYWllT+7BUnvA
X-Gm-Message-State: AOJu0Yzllt87oqFVyxBMvi1FVLHC5Z8Ecp4p0DNNHpJRqpAcA1LsueCi
	E7HDgkRKHOZo6IXpr7XDnpXnuU7AE7G6+5QcJlMQCtc0cImUd1/d+2XxKNyL5A==
X-Google-Smtp-Source: AGHT+IHgy3WwdGAsnQPmK2m2JDsitnCNDlW/VOsDIP4yBtdVhbhIse0VsuYogkkxJuuqsoNLgdNNGw==
X-Received: by 2002:a05:6a00:6c95:b0:6e4:6a3f:f065 with SMTP id jc21-20020a056a006c9500b006e46a3ff065mr12647864pfb.10.1708627625231;
        Thu, 22 Feb 2024 10:47:05 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s12-20020aa7828c000000b006e0651ec05csm11280323pfm.43.2024.02.22.10.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 10:47:04 -0800 (PST)
Date: Thu, 22 Feb 2024 10:47:04 -0800
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
Subject: Re: [PATCH v6] bpf: Replace bpf_lpm_trie_key 0-length array with
 flexible array
Message-ID: <202402221046.020C94D@keescook>
References: <20240222155612.it.533-kees@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222155612.it.533-kees@kernel.org>

On Thu, Feb 22, 2024 at 07:56:15AM -0800, Kees Cook wrote:
> Replace deprecated 0-length array in struct bpf_lpm_trie_key with
> flexible array. Found with GCC 13:

Yay! This finally passes all of CI:
https://patchwork.kernel.org/project/netdevbpf/patch/20240222155612.it.533-kees@kernel.org/

-- 
Kees Cook

