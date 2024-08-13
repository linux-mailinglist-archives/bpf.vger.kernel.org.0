Return-Path: <bpf+bounces-37041-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9AE950840
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 16:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 644CCB220B7
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 14:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F15819EEA6;
	Tue, 13 Aug 2024 14:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+BBRFkj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222844317E
	for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 14:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723560861; cv=none; b=mWDHtOr3K8KUKdYCMRDmyFk7FvUKm4xDftoDdcKEFHTVN97Ym5SuvLb9DteneYdEnCwVsOkN4zFSF4+Xo5xVKc3lLhwybeM8cBNADCURrfjYPLbf1Lv7Ef+mHokbg61gx/aJYk+ynDnEzkALsxdw8yrGVJ6UN2QujFWyUeP47Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723560861; c=relaxed/simple;
	bh=DEuhMvJ0uNAs+h/YA0YaIsC0f9vsDHmdCmkJMCvzGa8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=k+wIbsFLbLtekjiKVCQysBbZU61W/xSfLPOlVOg/DUaEoMqsVPX+C5HmJIiJ30WGw8l9dJsrX5G0gPJCfyMMFjf+i9pWouaIrwFahVxrBnn2rYqZfgqbv2Ai7DfNxnwZRvG3rfTebzVuJX4fhYX9jrRPcuVBDLsr2r7RerlkMgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+BBRFkj; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-428085a3ad1so43862375e9.1
        for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 07:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723560858; x=1724165658; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22CvYXzFKqZuFhY+dCZ4eSZP8deD+KxkUIWXwTFteT4=;
        b=W+BBRFkjGx2dyp5RF6D3/DqUx1X4ojzghI1SzQNJ/tI6jSPe9o5NjtbFi0EqPxiv39
         LHW0s8ItgQaaKiLOhleHT2yRrH5dr+20tiHJjnwIxjeQIwZKqFPrRYPy4ROrR5IhI2lm
         juAkSJB65A52+qzlTnBqcH6z/AbzwpGIU6TT20BZ7n8Bd+IWTQyTtP/EI1oYTEO3wvt8
         qn71i0rEXp3JNcEAFOgJu39gGwx3XOWshU+kjxRKh+EnQf2xFBysCN9MO7W1nhbuSPoR
         50qUvLOAYO0MC743tNISnMRF/bzEXdElWrtOyEnB9ivujqhwKUrKiHe1bn3RKZjaYOX4
         Y2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723560858; x=1724165658;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=22CvYXzFKqZuFhY+dCZ4eSZP8deD+KxkUIWXwTFteT4=;
        b=YxTPQu6TbpllxkUt/a9y874kAbZf3hEJn+4kMWDGjQSFDJ/37Oti6LmtjjvQa6yPBc
         Td1+1Qx531qlWQW11BYVE7CLgVoMMIQp9kDZDDAbtF9xxx/rVA/y1VlIuTS7N/uHhUyf
         LqFiJrdNU/hX00Hqc+fBtPg35HGg7vlWjdrRrRo2yzGF9kMv2iIVqkfotWbkpHJgAjC5
         OWH7Ez2B8Z5wTfL+YOy5PEPAAzfq+DMHxvGZke5mkeFVRvi9ZCCIfL9d2fopu7M9tFV2
         0ROtsId5yyMESJb+yM5G/QifdznjBFt/iXA0fW/HDzTwcOBznekH9D+G3Q9kF8OsziRn
         6gIA==
X-Forwarded-Encrypted: i=1; AJvYcCWe+2Id1G9ZfqCfZ2HVpiq7z5PzU0mqALScMhA8OuOZhR02aMMF/8nt3DDOF4+0x2gUdj/3VrHXT4HKCa2Ze0Kua5rA
X-Gm-Message-State: AOJu0YySeDIY8TWHwJOjSSck3nXd1ntHFN0muZSOUySJRXXlRaVoF/w1
	NH+9QBN8V5qxmX9Ar6C7XdqFdQnv7OXJQqsL/j8KPfaVzAUkgB+z
X-Google-Smtp-Source: AGHT+IGqRTDEdMF6xtV7Jc6/GxHsTyKEM+wkLZyrsYZF4Jp1IfFtQzWl6xv/L+FityDUtAQf2A9vCQ==
X-Received: by 2002:a05:6000:c8b:b0:368:3f74:f7dd with SMTP id ffacd0b85a97d-3716ccf4e45mr2672352f8f.20.1723560858096;
        Tue, 13 Aug 2024 07:54:18 -0700 (PDT)
Received: from ?IPV6:2a02:6b6f:e750:7600:c5:51ce:2b5:970b? ([2a02:6b6f:e750:7600:c5:51ce:2b5:970b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4c36ba5csm10641864f8f.2.2024.08.13.07.54.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 07:54:17 -0700 (PDT)
Message-ID: <0d978215-97d3-4b12-80ba-1fb29cd6ff52@gmail.com>
Date: Tue, 13 Aug 2024 15:54:17 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: acme@redhat.com
Cc: andrii@kernel.org, dcavalca@meta.com, chantr4@gmail.com,
 bpf@vger.kernel.org, Linux Memory Management List <linux-mm@kvack.org>
From: Usama Arif <usamaarif642@gmail.com>
Subject: New release for pahole
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Hope you are doing well. Just wanted to check when the next dwarves release would be? v1.27 broke clang compilation with the kernel [1], [2]. And v1.26 doesn't have the patch that is needed to build the kernel with memory allocation profiling. 

We can use the upstream dwarves for building the kernel, but it makes things trickier when trying to do it for production without a released package. If the next release is planned far off, would it be possible to do an intermediate one? something like v1.27.1.

Thanks

[1] https://gitlab.archlinux.org/archlinux/packaging/packages/pahole/-/issues/1
[2] https://issues.redhat.com/browse/RHEL-54022

