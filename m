Return-Path: <bpf+bounces-60000-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 334BDAD105B
	for <lists+bpf@lfdr.de>; Sun,  8 Jun 2025 00:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C0783ACE8A
	for <lists+bpf@lfdr.de>; Sat,  7 Jun 2025 22:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E031FBC91;
	Sat,  7 Jun 2025 22:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvYUACl2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB8E1DFFD;
	Sat,  7 Jun 2025 22:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749335123; cv=none; b=VGqV0iJcWSHh/hwG0cyp9MYg94EUOdVe+3rh640Pkp98bzFdahGNOBpDncodbcAtDV1UIAzYlLOG6kjA9qQ5iN4HZ7CmQRd9CNd1M18u8BXrs9MQh4EEAxyf1X78vyMXGBGRBPUn3ysF/PU9FTIn5OzBAkFUMCb9GIZK+iLDnUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749335123; c=relaxed/simple;
	bh=VLJGPo2+sNQKCsHyC9QPqQfP6bwpsrkDVSGXaixHRQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cXdQKqZ4KtoG21W2C1tkwSCacIAygjws0LwqK0ODE6oqQ7DxMXU+MQtjhV2up5NsqB1hfEr8r8p3/7idZhgvKF6Wk1aYmwLKdzuhaqUf52Ui1oTahVe9Z/6BipoQeWsjQXLiuxO117ZUwGDyi6rROKURyZld8WYyJelfHNvkx0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AvYUACl2; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45024721cbdso27607595e9.2;
        Sat, 07 Jun 2025 15:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749335121; x=1749939921; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MbWVuaywrQ+wbzaocOpfest7CI/8ROVGkhW3PV0j638=;
        b=AvYUACl20EZnOzsXzZvmTp6ArThpxr3iFZ1pkUgCndhwoELWviMMAm15/VE8alDoeO
         hh9ikE/UO5iGXIJy3QSrGRgo71F2U1icSJzSzUwjALREhB6PjGjlEu+cu3hwU+BsvKaN
         PCjPZXITpSI+YoUpyljZO/blcbhOciCCKCFn00INocwZ39QYO2I+M5Q3x3eKi42jg3RU
         TmJb9g/XO4SX7FDwbNvC9M7hXeN8BY9pv4Ai6EQOUGAV0Ktgnx9/Khz2sF5tqt91chid
         mkcme6SEODQF8+jDkHdb/klkhGLAMlT5SErcztgqY/msOwM1DIXZB0Q/FJxAJt0SUmlM
         ZGLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749335121; x=1749939921;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MbWVuaywrQ+wbzaocOpfest7CI/8ROVGkhW3PV0j638=;
        b=fEr/wbfLs7YZLp/oxrtTCbV8c7jn8cSVb+kllLUwu6MCiYmV1CeGuOdLCzGEEq5L/m
         QulXETBbKml8N/BvCjYqEN3MvlE0rYD0dIeR/D/pKs3bJcrLbEkkpEnxyfKHu6qIRhQk
         k3lwLMpdG0AtGJbETnSjuwY8AWXOW47wbEmf9Zajj/LGAk20zoMKgbswbuE+LEriQoGG
         UhSDt5w7pLrLWGHpnksnvde2dcy9KMZoKDxAKn4kJL3aBPrdB5vjObrR3rT4cxrOswrY
         KmaIYkROO5E0kEgQVzUELG8znEdHZ9Bu83WcedHqGiVW51JXDPpo0kP7nIGa1wtQJXOD
         PRlg==
X-Forwarded-Encrypted: i=1; AJvYcCXVGru0wtcbALPXWCtARBx9R4xRhdvnu/BBNcUsSKpLGr0arpR86nFO77Vd4eE1pWk/hjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJAhRcN6GXuL/OYe8sK4YXP+Uw1EcegN67g8YhhhOBZBUK6NZ8
	QXOi4UfC+E33uJyNDHTDblnBOsUkfq2Zof+jd5Gv5qwvL4aq2GsGGLbu
X-Gm-Gg: ASbGncvbjO2/UhCsORoyOkhst5C7I3aPTOgb83MFt53ydJeUKWnklQiQP0D2VdwJmFM
	EoP4+RyVhPUEJtyH2zpeRat0ONQSUZaqd6G0Fc/WfI+JAoIWRTXltE0ShFSH7EHzBimm0NrqAhS
	6FYfvPkyh4sB1sfGdQ/5h6cJ+WzaVOevxyrwsiadqwm18LHeSRmtwYUUPaRFVlBgAnP53bUx1AK
	nWgNyQ+yvDn7EcZ9CCkiGbb0YH6CiEQLndQK0AjOjLAoRFvVEhN+YRbA7vvpSsx/5OyQCLMgfeW
	3tBXElhe48G4bmyw7PeueLav1yg33nc/bZsGwi5wGjwhyCtA/g6awA6zEo0nBmQwI6O5I9xA9w=
	=
X-Google-Smtp-Source: AGHT+IEJm/ryDtL70PLk+TdAMtgS2z54mjDcCzj2pC1YIByirh2dxErSrDk/QRUr5HWTlo+9LYQYhQ==
X-Received: by 2002:a05:600c:3486:b0:453:d3d:d9fd with SMTP id 5b1f17b1804b1-4530d3ddd57mr729055e9.12.1749335120509;
        Sat, 07 Jun 2025 15:25:20 -0700 (PDT)
Received: from [192.168.1.3] ([41.232.132.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45209bc6c6csm68416095e9.2.2025.06.07.15.25.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Jun 2025 15:25:20 -0700 (PDT)
Message-ID: <c74ed44b-fdec-43fe-91c8-06aaa197f0d3@gmail.com>
Date: Sun, 8 Jun 2025 01:25:19 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] Documentation: Fix spelling mistake.
To: Dave Thaler <dthaler1968@googlemail.com>, void@manifault.com,
 ast@kernel.org
Cc: linux-doc@vger.kernel.org, skhan@linuxfoundation.org, bpf@vger.kernel.org
References: <20250606100511.368450-1-eslam.medhat1993@gmail.com>
 <04a101dbd6f6$2635cac0$72a16040$@gmail.com>
Content-Language: en-US
From: Eslam Khafagy <eslam.medhat1993@gmail.com>
In-Reply-To: <04a101dbd6f6$2635cac0$72a16040$@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/6/25 18:17, Dave Thaler wrote:
> However the phrase "dividing -1" is one I find confusing.  E.g.,
> "INT_MIN dividing -1" sounds like "-1 / INT_MIN" rather than the inverse.
> Perhaps "divided by" instead of "dividing" assuming the inverse is meant.
Good catch. you're right.
Since this paragraph is taking about overflow and underflow.
it makes more sense that what is meant is "INT_MIN / -1" as this 
actually will overflow.
I just sent another patch for this.

