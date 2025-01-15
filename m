Return-Path: <bpf+bounces-48957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6295EA12A01
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 18:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1E453A3E27
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 17:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0471C8776;
	Wed, 15 Jan 2025 17:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnVfVJ93"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D80C189F54;
	Wed, 15 Jan 2025 17:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736962702; cv=none; b=gIjKjTugFhD9X3trWsbof2j1PUN9Yzr+pTG+srSlp4urT5srYbZg2dTBoHwKhDI1zgYdo9xP8jUA7muMRFP+syfxP9r8X6l3nVbV3Ph3/VCafWYSjV7g0YuAtN4YCX5ImN48GagLO2VVpyMgG3neF8XhwT5sCk7WatTOEBJhP80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736962702; c=relaxed/simple;
	bh=8q3dKUnAbdu/O8CUZiTaxpUmetNImX1ysBcGf0/581g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QD/S0sxgIhXG2K41I8zF1K5Ufw1xdwWdykscjBcpSzdpb6ZqKdOyAqWXw3pckJE3+gx0N0nliQ2d7vRvBoT4LWUXPo8Bo4mTMDaappyCaSoKznffYQtSiK3RJ86F7YuRHgb61L5IM0d6e0Dh8sNF3rTazd6ufsEbHMuG37tVNUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OnVfVJ93; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21a7ed0155cso122713915ad.3;
        Wed, 15 Jan 2025 09:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736962700; x=1737567500; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ffTN+8BxxrgtsYW9mnk7jYQ9FtHVNVrRyvbSAwFbRGI=;
        b=OnVfVJ93M4pF1FYFNGrCU9cAyTtRAzXkDx9tL6KqU+GKY3cZwK/wgipoSqd4B5vAZX
         +JqWbxobbGhnineqHRT5Dhb3NPth5n5vZK4m7E3hRyW7LvyraGQ/3DguIhlzp668PVnE
         2z0uoPpRbJFEanPkil7YeJTEzUG//p8YpbaJaLmKeA2FeRdhvwq4XTM8MotJ4AEsbC12
         4TsooU1HSov+LmLDyc1cXuJJsEtX0CFV/alxaEy5EfItbSw1+PieQDIaQK5o8uYt/2mv
         AFBAQp/bnA/9dkzy127fYLxOi8TjDXmJL7I+eGoj6dbweQgABj+39hy9V+KYf5bf/JjB
         3OQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736962700; x=1737567500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ffTN+8BxxrgtsYW9mnk7jYQ9FtHVNVrRyvbSAwFbRGI=;
        b=vKMMNuIFhz8j96GAz+FTiXqepUTpoXV9/rH1U4wIOTqYcMcGRwdHSRsZtDG3X/hhm0
         hepjTLqmKT+hjM1C0+DmayQZUKT0H7kiXY5iyp7E6vYzNAHx+Pf5YZbopAKUDiy+AWDi
         0JX1VXsm0lWfdAGzNsoZypOCLDBUjlGeeKUYrPeD01nJEazFoF1wf5iQNcOv/O+mImn7
         EIeWjjdtXWJvGRplnm2rlrDE1ZsKXMfPaFI5SA68bNOhuFoBYh3j1FaCpPGicGC4zDey
         GBO2hpSSyVs/ABQeePxmYmZAvZuOBksYvCLFj3tcwzoQxpQ3a2nDB2cH+ye92ehqjq+b
         YEhA==
X-Forwarded-Encrypted: i=1; AJvYcCUThPTCgDdZhZN8UVTr6TcOqp6PMbzkQWjhoOJq6cBiUv+d1kqwe70toZAAxhqFi1tggi8=@vger.kernel.org, AJvYcCVkaSRKPtfvjrKLl3fjTAa1a9M0eKU3gYFzCUJAV3ZRtBU8ywBE2fQefunTvG4VISlq4CZF1VmXfQwvlTeN@vger.kernel.org, AJvYcCVkqIH2yYmXRn77levz+9Ru+lQc61K3j1hzezUnnlwt5xEOLEAy9dk0HtlJh25VV+m0/yztyurNBw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3spBlYn3LToBUHiSkel4fHrmpZ0m5Zs7D8PYC3xVjJAQgWKWR
	BqKs0QmSJJxrVq2WHL1p/gxeUNjSBJarmZimjDrI18ptH5OORTMg
X-Gm-Gg: ASbGncsUbVs6gZl0w2uFDkuAJuwiSas0Sb4nLKvknAsZV5LoJyaOdHWrReU51QSMCez
	hvnK/T5faIfFdYUgWEzjG9qmSYp3JbvcRxm3n9DmriAY/n7zfBPOicgCQrfW3kXmISfYCkXVZ7z
	uJwWGystbeaMnj2MBiUqhpR++GqXa49UAygcjI9UBZ0tMUFyzYOCyKnN8yhYRjy4F5yu3/0e7+9
	OeCYjqOIe+4VWATg4RUToMFPU/3NGR14OMJGEGfigqW40kE/nrM9XGRK48Hm7o=
X-Google-Smtp-Source: AGHT+IHweyN8ETy0hN0cfZvqN7G9Q8blcc9XGv+ulNoTPKJ0X3+8BdzOQkFAqN3Thq5VSuJTcAXEpA==
X-Received: by 2002:aa7:88cc:0:b0:71e:4930:162c with SMTP id d2e1a72fcca58-72d21f4ac63mr42651910b3a.6.1736962700388;
        Wed, 15 Jan 2025 09:38:20 -0800 (PST)
Received: from localhost ([2601:647:6881:9060:2b45:4736:5bcb:52eb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d405489bdsm9406934b3a.33.2025.01.15.09.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 09:38:19 -0800 (PST)
Date: Wed, 15 Jan 2025 09:38:18 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Uros Bizjak <ubizjak@gmail.com>, Laura Nao <laura.nao@collabora.com>,
	bpf@vger.kernel.org, chrome-platform@lists.linux.dev,
	kernel@collabora.com, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	"dwarves@vger.kernel.org" <dwarves@vger.kernel.org>
Subject: Re: [REGRESSION] module BTF validation failure (Error -22) on next
Message-ID: <Z4fyijoUoeTnOuDM@pop-os.localdomain>
References: <20241115171712.427535-1-laura.nao@collabora.com>
 <20241204155305.444280-1-laura.nao@collabora.com>
 <CAFULd4a+GjfN5EgPM-utJNfwo5vQ9Sq+uqXJ62eP9ed7bBJ50w@mail.gmail.com>
 <Z10MkXtzyY9RDqSp@pop-os.localdomain>
 <3be0346a-8bc9-4be1-8418-b26c7aa4a862@oracle.com>
 <c067bc3d-62d6-4677-9daf-17c57f007e67@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c067bc3d-62d6-4677-9daf-17c57f007e67@oracle.com>

On Mon, Dec 16, 2024 at 03:19:01PM +0000, Alan Maguire wrote:
> Seems like there's a few approaches we can take in fixing this:
> 
> 1. designate "__pcpu_" prefix as a variable prefix to filter out. This
> resolves the immediate problem but is too narrowly focused IMO and we
> may end up playing whack-a-mole with other dummy variable prefixes.
> 2. resurrect ELF section variable information fully; i.e. record a list
> of variables per ELF section (or at least per ELF section we care
> about). If variable is not on the list for the ELF section, do not
> encode it.
> 3. midway between the two; for the 0 address case specifically, verify
> that the variable name really _is_ in the associated ELF section. No
> need to create a local ELF table variable representation, we could just
> walk the table in the case of the 0 addresses.
> 
> Diff for approach 3 is as follows

Hi Alan,

Thanks for your detailed analysis.

Is your patch formally submitted and merged? A quick code search with
variable_in_sec() tells me no, but I could very easily miss things here,
hence I am asking you. :)

