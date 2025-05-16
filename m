Return-Path: <bpf+bounces-58375-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 788ABAB949C
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 05:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5182B7AE42E
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 03:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A68425CC61;
	Fri, 16 May 2025 03:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dSHc5cQQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A22E25C80A
	for <bpf@vger.kernel.org>; Fri, 16 May 2025 03:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747365519; cv=none; b=K8hAdJZDJazZNoFpkaAGutCX3EXLimnhiSSzWAr3LGHIJVX8EnfKkyYDpuX2WUVgBhPSVOt/LZFL5FPBXWuHl7mB7vz+fjpE5pFhMPP3aoj4yAIUmOL/9rp4I+Xd3PQLky6FJfBbeWL5X7qjaiiC7q0s0aeUqVpJbsSLmxVuP4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747365519; c=relaxed/simple;
	bh=fUleARR8WOqVRUDxvmAQ8pRYUbbZ08VVcF0Rc27NNPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QpCw9iIHXs6bWfhMdbrqx1dYcnTKB6Qs6dCwFbAImfkNSs7Fp2cNyOv+rsYaTeRb+/tR853zbJefJLtpkVn7uf4VeygOs2d23sWtygzKGvNJJZhu7dLtY6ceWIhUjdp6Rs33t3Z9ROxLBgj1v/LqJoFJJ/tt291J+VugS2gVK54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dSHc5cQQ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-741b3e37a1eso1831664b3a.1
        for <bpf@vger.kernel.org>; Thu, 15 May 2025 20:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1747365517; x=1747970317; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j7W5OEI+FZQpiN0ZKth0yhvtWhfARtMcnHwli9u5j+8=;
        b=dSHc5cQQo2CZFdfwoG8O2njoB4pdMQKkcfr3n7Vh/99vPIGoiaTKgUfyjoFHZUlB14
         953LvPOOf55lnEsq/TPB7sFqkN9W8LIlU45o6sb2PSo7/kPi9a4Rtg1dNR/v9RuOJYpg
         S4OAYdtRFitpgCrD/BEsEiBYJ7KL0O/7ikFW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747365517; x=1747970317;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7W5OEI+FZQpiN0ZKth0yhvtWhfARtMcnHwli9u5j+8=;
        b=AjIjxnE/30ehL0ZjtVboQWa80lxjprIMPZ08CmIycfPH3mysP9Gv3JfSLuVfG0ceGO
         LlC84/8+HkM9J0eRQKrUjsMF9qF+YaRuWcaYWhIVdc3q9w1FInzyzeCh+yxVfNiA4jSu
         7hcIdtKvnbQLG8ZBYcxAgIZZhx1PoLjL+IhfnQJGY6ovNYLv/Srq/sGzQ5I7l4F3B0l4
         VTOqrG7lTr0omk7v/5i2g4cJe5ltUyAzpAZe3rMwbYVl83XEd/5d+x8KQ+ljATPgwSgS
         Mu0wHY25xzxhGSknzuXqI3rHS+7DMB+2DOqtZzFCR5bxJFBpu2whIVAWMhveV4U/VrHs
         ceqw==
X-Forwarded-Encrypted: i=1; AJvYcCXTNcz02lhz3Ld0x8jSo+L1ERgBkbOpW+5zGO1YBiVbnADFgW8wMRs0QK3Jcu+mtBCVtew=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjfU/4H9Qo3XO+eO0BBi7wQsOB9lO2y6j6b/5v0AT8FuyrUfR1
	3a1aRh6xbPy/P+PXL8DNlU3K5VjDqeSiEhSCH7kpmnDSp8DZlaDKdtqRtkSbFadOxw==
X-Gm-Gg: ASbGncsBFnKzi8ong07k7X0vTPc9utrKFL9NL4pE2mtrqfAjK7D1yJkrH09olrR7+7P
	fTQsEG4oE4KGepQ9aTWcz854vHSdFYsQ8/Za6edPhs0Le4ueFXLS7sw3QUb8/aYDNTuO9IP2IXL
	m0YoY3vl2us2ukjIpnGZvpUccxlLb5QinsfeZJXsFWk67AeXAty3lZYu4zfqVtiQag+jl+SxOj8
	1NGq9+r+U1bFOdDWupS86l5JNg6nipvtwe2gVgjlNS4vkR9/clQOC/j8mV9VTplg0/6JU84hVTt
	JrCBzJa3sotxIXLa+sFdNcwKn54S/rKVdl0psKF5Bv6AQPhILHPAvtU=
X-Google-Smtp-Source: AGHT+IHLTkuxZtugendz3dTtnKy+P2jOonT5OD2OO6kiYftSGNfAKI2vlh4zIm6rwvJZn9EZjsTHaQ==
X-Received: by 2002:a05:6a00:10c6:b0:736:a540:c9ad with SMTP id d2e1a72fcca58-742a98b833bmr2119960b3a.20.1747365517264;
        Thu, 15 May 2025 20:18:37 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:3a9e:6985:1cf8:b3be])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9871517sm559838b3a.135.2025.05.15.20.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 20:18:36 -0700 (PDT)
Date: Fri, 16 May 2025 12:18:31 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Ferenc Fejes <ferenc@fejes.dev>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] bpf: add bpf_msleep_interruptible() kfunc
Message-ID: <3q3yni3umfwq6mhghcoyqfpvji2a2toumo3elgjq44tqvxwuag@jzci6ssmkrf3>
References: <20250515064800.2201498-1-senozhatsky@chromium.org>
 <eefad549e3d0568b523305252b6ec3a468502d2d.camel@fejes.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eefad549e3d0568b523305252b6ec3a468502d2d.camel@fejes.dev>

On (25/05/15 10:59), Ferenc Fejes wrote:
> > +__bpf_kfunc unsigned long bpf_msleep_interruptible(unsigned int msecs)
> > +{
> > +	return msleep_interruptible(msecs);
> 
> Perhaps exposing fsleep instead of msleep? fsleep might fallback to msleep if no
> better mechanism exists or if the sleep duration is >1000us.

I like the TASK_INTERRUPTIBLE semantics of msleep_interruptible().

