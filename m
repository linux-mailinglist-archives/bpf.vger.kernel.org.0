Return-Path: <bpf+bounces-21703-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDCA850394
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 09:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0F1D1C221D2
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 08:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8CB32C9C;
	Sat, 10 Feb 2024 08:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCC8a00u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63E828DC9
	for <bpf@vger.kernel.org>; Sat, 10 Feb 2024 08:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707555172; cv=none; b=ePcDCjycZblN6erVaihdTL9Z00/y+30/swGpatl9vfXnEikegNWBLXNvOeKXIeuttMtrDM0KYU0LfSINyKTHQUNSs2pINTzGnsQY/ehyUqD7Okpx9Pl1bCtdAJYg/ACrTL4B3TvQwuTyIeJsYPf4CsMjfpCPmvGEXvve6PfQbLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707555172; c=relaxed/simple;
	bh=RRVVqO5GMh7LjJA1W3LYuaDogFri38K/3v0+REEWRe8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FNZn67ybrrQhMNc6eEQsxPiI/mFzKhlZWsO/azybuvcOZHdDXkXJ2aMGkFvhdpGzVKlQIuZbfybIO25bmqqESP0vf1mNnWLc51KFMUEk1Sv/H2DjjwFwNSU3YhD7wtc7vmhZlm0BkMVeiZ8k7RVG9OEa/ltSVxZx8J3Cj2EcPVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCC8a00u; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-a3c0d92ca8aso106249566b.3
        for <bpf@vger.kernel.org>; Sat, 10 Feb 2024 00:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707555169; x=1708159969; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RRVVqO5GMh7LjJA1W3LYuaDogFri38K/3v0+REEWRe8=;
        b=SCC8a00uhp+HCrJyL1t+qf6u4mvH9pz872zXirtn5Z5+q/X46mP32UPfeA1zPmO4ah
         B/600f/Z1kTaTasUaaTQU9Rl3j1zlo+B7EXpcj73rJbhnOxNGVK8ajBkAahE/rB2cNup
         RFXHtvLFbIGqkLYa0quTv7140zBNjpPD4/uVpAL5Y3KQpKHdBFVLwKUbRGDQ/B/8QZoq
         JYUAAyygeGc083QMWuzwGLE9e4zLAwc+Wx6RN6fwIy/xZWen7I9mvnUtK/+PmQr4zcme
         JML078sturBAJOFUPJros+XWmYsLN4v0kSQbWuEJi7H9xxI2zOmTxNu7/2gDn7cYpuwJ
         ZkNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707555169; x=1708159969;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RRVVqO5GMh7LjJA1W3LYuaDogFri38K/3v0+REEWRe8=;
        b=wD3JPQJ/7U7PL+H03zAlUWwLKq5xI0Hvdw96mWARCkobuePeaG5Ng8U0T0tbdoDuuY
         rtOxk2CwFtit4B+oD5IKjE6gQkGqw7tIySD1eQZScqoxApUGcn8iFUYnvT6E90tF4iHl
         15zwVSuSFBcrC7y7tryCYu+E9Rp9Lt16SDX5aq9EsrnZLyYCTscm5kxL7qzN7Tjb58my
         rZV+/AjX5lLlSxIAwEDP6xeS90SW84d7q8fA5APs989JkZmLNwk+3TSm8Yku9e38aICW
         Ogminr08LO2pfazcjITp//VjqF+q/AgtjcvHmUumGSuooEnxivli/C1KityHMpfjnpW6
         Y02g==
X-Gm-Message-State: AOJu0YzYJcXn2MpJg3yrmYcWxQF3mFoNH7hJ93tAed7BVDapsLDvjwfj
	Z1SpPmHOykxln60WkzKObpQsRRq+8krdvm+iVIHbnn641o/WbPvbFaD/a0+9J2YX0fkfHcxgWZD
	SX9P9y9PIm0k5Dg+hm+PpiFvziHY=
X-Google-Smtp-Source: AGHT+IEhyCLZ8uJmu76QnGi4paO1w1ztjc+6KeG16diXA8QJNmefghpyrlgCn5Eczck94XL2KrRUG0nhdAqzO1OXrSA=
X-Received: by 2002:a17:907:20bb:b0:a37:95f1:f115 with SMTP id
 pw27-20020a17090720bb00b00a3795f1f115mr1081619ejb.50.1707555169205; Sat, 10
 Feb 2024 00:52:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com> <20240209040608.98927-16-alexei.starovoitov@gmail.com>
In-Reply-To: <20240209040608.98927-16-alexei.starovoitov@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 10 Feb 2024 09:52:12 +0100
Message-ID: <CAP01T74G=r7tjnxBdTEeoyPWHeK8tg-B1ofTu9JZvd1FivWRhg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 15/20] bpf: Tell bpf programs kernel's PAGE_SIZE
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, tj@kernel.org, brho@google.com, hannes@cmpxchg.org, 
	lstoakes@gmail.com, akpm@linux-foundation.org, urezki@gmail.com, 
	hch@infradead.org, linux-mm@kvack.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Feb 2024 at 05:07, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> vmlinux BTF includes all kernel enums.
> Add __PAGE_SIZE = PAGE_SIZE enum, so that bpf programs
> that include vmlinux.h can easily access it.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

