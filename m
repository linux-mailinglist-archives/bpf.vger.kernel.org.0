Return-Path: <bpf+bounces-44720-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D180B9C6A11
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 08:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72738B22BFA
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 07:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2223518756A;
	Wed, 13 Nov 2024 07:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VETkn3Rp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF7335885;
	Wed, 13 Nov 2024 07:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731483170; cv=none; b=DAYCZJMEJk3HmhobzAfiU3efsZ0ayyDCmUgqlPKAbUqy9VmlQIpxy3oQTevlz/5subfkl4wlZ+nHl4Pvtl353/Iw/QcPvlLQmUDisS65b5rf7CHN08KCvYggF/ik/Em1916V6LZbDi2dPLCy8X91UmXrX4TgoERha2QQmE2ZY14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731483170; c=relaxed/simple;
	bh=sVsJxS9e8Feoju3z9kLVoX7oyF2LbuRtLNrwKHqDJ3E=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=WWR/0yVO2K/VfHVrnxesUkC0ghH3StyAayVQpF71r9B9cqspjjfArYfYUI5Cub2OklFoaNtUmo8ANFilzNWTMw00/tqqVkRu0iViTF7Pq1RZzsOusM/W8JFeoJSrHC/c64KWKDuaBCfVtD/dYua9FYmFgnj4aBsQJCfYARohHnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VETkn3Rp; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7240d93fffdso5598327b3a.2;
        Tue, 12 Nov 2024 23:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731483168; x=1732087968; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ydt3a/CwJ8B9afYgE/yrVykOza81dEen6k3D9kqyuHM=;
        b=VETkn3RptQCfWGeWzz6TzgiJ0xmafCgDuqqYofNODFIW3KSw4SMRqCYyQ+c1BN65/I
         64F8Fruc91+4QaDqbdHGVkmcco0ZJT0yJTYEQjX9Q/jTyvyMGFBy3akP0R0/RudjnRLO
         JnZPU1lMA+p2h+10AsPFoJ3jShHWQGMkwMwcESUtqM3sPL6b/7rfwJn6ZXBo1fGqySbS
         rRk7hzu7EtPfkFNCOnnuheoK646I8AHzSLu0kTCzN5rFXiw6g25JKJS9KkVv4lg76w/R
         Xbf5kDSPXAuK2FUfmwR/PPogx3kl97RyxxdNCl84C+FccVdbu1HqSsew1XWKe8Qyv6I+
         SMJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731483168; x=1732087968;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ydt3a/CwJ8B9afYgE/yrVykOza81dEen6k3D9kqyuHM=;
        b=d3ylRecQOVrRtikX2fIuSG84vmraLijdfX6tuge5oP2SAs7J63vK31CD8DpK5A8SHm
         qmrqNENFsBLvTOOVHllC6a0/FddwMpsnDKRotrbAai9EEGzyovJl/P0nZOedmbUph8rQ
         x9lVEUbf5CkTgWRQ8dhRaPj7190LqbpU5JPg0qomKcw4GhumJdagLSsNvYNT4jJndmBN
         mzbWgN9xOc7IXrVLpDm5VLVQjUkZ9Li7zBfErbvVfBeXp0AXxt1RmjL2jw85+vmo5ecL
         W6IXi0pDqfqb3q1KIA1/MA8hpQDdoMpdzCdKB7JPsekX8Aa1jW1pBUNucjaH0NL27qZ0
         cWzA==
X-Forwarded-Encrypted: i=1; AJvYcCUlePrd/EFLQEBCPsUTRqnuFgoGBw4pwqU2bBgL7kKBBDAl56kD6YMVz5GgXqj8NML1y2U7K/nolaL10r8=@vger.kernel.org, AJvYcCW5qHFkrpVGdUdpn3wZPiubZHlZlLLX7fK2GEsbO5jDtGyPvQcMI62fTGdeGI/0H3hK6JAl9IluElKP7CryAA==@vger.kernel.org, AJvYcCXvFHcXcUdcAuH/TqZF/rzkaabczShcKDMp0r0U/7jQJidrfVSaD5wcOLqrOJIm97vGoGcGADzoYPmYL7JL5BKO+Qtj@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3f23SPs1VqPHGRr48iOrzbDEE10/S86IS7A2LnQM3H87dwvfF
	AUbk3XYfKwiB/W6oqWUEvQ4plDoUxtVlFcv3Vf34J8jZo1FMp6Dt
X-Google-Smtp-Source: AGHT+IGo17+0CiznxgzXvqz3+t8QWlsqph7jxFNRIn4nmCDEyVatBOR0uDeUb8AhZ6CKTeHN6RZgNQ==
X-Received: by 2002:a05:6a20:9191:b0:1d9:25d4:e8b1 with SMTP id adf61e73a8af0-1dc703de37dmr2643692637.25.1731483168541;
        Tue, 12 Nov 2024 23:32:48 -0800 (PST)
Received: from [192.168.68.56] ([122.161.49.182])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407862826sm12543777b3a.15.2024.11.12.23.32.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 23:32:47 -0800 (PST)
Message-ID: <8acdd32a-1702-4434-8d79-2e73ded36d2a@gmail.com>
Date: Wed, 13 Nov 2024 13:02:43 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: zhengyejian1@huawei.com
Cc: bpf@vger.kernel.org, jpoimboe@kernel.org, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mark.rutland@arm.com, mathieu.desnoyers@efficios.com, mcgrof@kernel.org,
 mhiramat@kernel.org, peterz@infradead.org, rostedt@goodmis.org
References: <20240607115211.734845-1-zhengyejian1@huawei.com>
Subject: Re: [RFC PATCH] ftrace: Skip __fentry__ location of overridden weak
 functions
Content-Language: en-US
From: Dropify <d.dropify@gmail.com>
In-Reply-To: <20240607115211.734845-1-zhengyejian1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Wondering where are we with this issue?

I am experiencing an issue where in a fentry/kfunc bpf probe attached to 
a function doesn't fire. I have only experienced this behavior on Debian 
kernels with `CONFIG_X86_KERNEL_IBT` enabled.

Because of weak symbols being removed from kallsyms, 
kallsyms_lookup_size_offset() returns the symbol offset for the function 
"acct_process()" more than the actual size. And the function body now 
contains two __fentry__ locations.

Depending on where binary search lands up first, correct (acct_process + 
4) or incorrect (acct_process + 260) location is returned.

Thanks,

Dropify


