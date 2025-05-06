Return-Path: <bpf+bounces-57485-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86615AAB99E
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 09:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAFE250214A
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 06:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFDD2973A5;
	Tue,  6 May 2025 04:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cJn0CY9N"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BD635C87C
	for <bpf@vger.kernel.org>; Tue,  6 May 2025 03:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746501143; cv=none; b=GMxwsuEx9/id6JoE85zaht6alPxK856vVaGhIRizFo0Uy+nkq8KDrOh3FPw7v740hUwKz5ri/17hoomJ+MQ1CkCzu3noX3m1m6XIWBMApu/cktd2DfYoSHhN0eyp2tMq6++7TRwsZ14wGtfQfpIu06XcMJqcFl4jQ/yzvDwIHeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746501143; c=relaxed/simple;
	bh=RqqvXt513iIsi4tEHeAi0LVjqWyjH4X/JB/2aZa5zjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Obke+41XsZT0zY7l2bu0SkCjTIq5Mdd7OFR9BLSHdRvh+te/U8G8z+beRM1ah6uCeDvhNypcY4M4LkYy16zYF2OJtNnu3ssQLbEXFr+sco4MstL2I5CIq2VfK/m78EHDI3BLArZ7M5+YIMrjM8ogBDiyOvJyxSSkVJuZKCtcObQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cJn0CY9N; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-30a509649e3so2803714a91.2
        for <bpf@vger.kernel.org>; Mon, 05 May 2025 20:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1746501139; x=1747105939; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RqqvXt513iIsi4tEHeAi0LVjqWyjH4X/JB/2aZa5zjQ=;
        b=cJn0CY9NZ3pbmevczDz/80RrUdulL3i9FvnttFsS2l1L67X1YTc1UNTLgcYTwROx6g
         IYyCqOlv3Z8Wilg1d1+7qaY16FGrzQ9Un8YFP7AojmNPirSp6o/zLmbsIkKuoDIWgUDU
         YYFfkKEVcH5rmf8u0MonNsafcDynGSvHL0I2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746501139; x=1747105939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RqqvXt513iIsi4tEHeAi0LVjqWyjH4X/JB/2aZa5zjQ=;
        b=HYub90MpmJ485bWmQ3dO1ZUyM3YTQdmfKlQHsByPxzyPIEWy6TtE4d1Na3qs6bE/eK
         7+Sr6P5U9mQ4eo12vBpfzAtnktPWGibpJvfo4EvlHTSr5e5njL72E1OY5vy+qHGNt8/O
         BTYoVYsLg8lxHIwsNGMSA2yyHjz02HI5LtDRuoWkd9e19aI5VelEI9TObXBDTOElANFJ
         ZMoREts1f7lSkn+vT1b1/43kmThnHFsX8PiVl1vZVv2Q6Krh82+WehA64Zgv2LQjpEdn
         hAdbRzcGqSUm+++VShFa03y5nyIpVDGVWTIfUJk7j8pBtLVKndmsS1+XWbT+0wL/F8DU
         NsUg==
X-Forwarded-Encrypted: i=1; AJvYcCWqJoOUmy1TLpzSS3wUcKLxaTh6Ejt+cL0ESan1abM8O5g9rAHLY0+8+g9GMGTq3D7F84I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSpRfzZ7JbE/LdykuY7oQhW4hit/gQjRZ+pxq3U9euwCVfxY5k
	ACRFlQ7/zDRANLZTu9iVnc9w/gOz+miKJkjXzgCi6zrXLoYEAM9n8yLZGECwWQ==
X-Gm-Gg: ASbGncsoKPoOxiy236reenQ8gzPtHNrHaty4K77x18dajNLitAnNq+QGL/7lhRaLkdj
	kYIjH36QjgeJgNAQm6CUkTY0lNsZbRi5z2kBvfVFczwY8w9fc4xfFDmwsB66dP5oiQ3ocDsc+MU
	zHpjTvY1HoijPFijOsJgN1tP1vkVsj6z/OFnKZcZoPG03ZhRcsJiimjP42qcZOS580iCKcHY3G1
	pwueOF1NjpT7Y0MHa05C/ZFfkD6ptht6RBRGS3G9j9oh618hJsd0JBPSMWxOJKOX6jItNDg49h7
	4LwkqESUq/FTM4uXryt1/T12AATDdpj8e6qLDq2Ogvk=
X-Google-Smtp-Source: AGHT+IEoP0z3CQ01WfsoSBzGXyLXz6fM+zSx5xAVq1j+5tcUHWpw1G3BbjuLnXDQ6/FXH15JqRBSUA==
X-Received: by 2002:a17:90b:3f83:b0:2fc:a3b7:108e with SMTP id 98e67ed59e1d1-30a7dabd723mr1736929a91.4.1746501138855;
        Mon, 05 May 2025 20:12:18 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:761:97e0:917d:ad1e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a47642083sm9968386a91.45.2025.05.05.20.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 20:12:18 -0700 (PDT)
Date: Tue, 6 May 2025 12:12:14 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] BPF fault/jitter-injection framework
Message-ID: <giu7jtmw7ixfej4hkpmdjy6agplhokinyo7lzfd6pc3chi6zm3@7jjqpl4m5r2i>
References: <5l4btekupkqatpxkfaolqhc5kw5wra3xvd7dosalem6zuo5vp5@vwfd7idoqdzv>
 <CAADnVQKgEViz3gQ2QJzCmnm-ou-r-=_i3yLaW5JoKK9okVcGzA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQKgEViz3gQ2QJzCmnm-ou-r-=_i3yLaW5JoKK9okVcGzA@mail.gmail.com>

On (25/05/02 19:10), Alexei Starovoitov wrote:
> To call schedule_timeout() bpf program needs to be sleepable.
> Majority of LSM and ALLOW_ERROR_INJECTION hooks are sleepable.
> All syscalls are sleepable too.

Thank you for your reply, Alexei.

A question:
Are "ALLOW_ERROR_INJECTION hooks" some sort of BPF programs type?
I looked at libbpf but couldn't find any mention of ALLOW_ERROR_INJECTION.

Is there a way to make sure that "bpf_sleep()" can only be called from
those special programs (that would require CONFIG_FAULT_INJECTION)?

