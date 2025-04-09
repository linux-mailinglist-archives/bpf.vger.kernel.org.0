Return-Path: <bpf+bounces-55552-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 786CDA82C47
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 18:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD6BC189C821
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 16:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB77269CF7;
	Wed,  9 Apr 2025 16:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8yc5WDl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C1F268C41
	for <bpf@vger.kernel.org>; Wed,  9 Apr 2025 16:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744215596; cv=none; b=ALAoFQkH5pvfCmE3/9/PyVFJuWeAsYjafUQ+f1VdlwyEZVg/71qBvVTAO49abeYbKE1SFYTejJKJgoHtkggX2ikqKwTLcWfdDCoyr+6E/qvvuf02ck2A2ldSUZXca2JKeQcFzmCDoBwMxwZ0u8sn9TTj0LWz/xuQ0MoVYu0j4Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744215596; c=relaxed/simple;
	bh=7Cd3EyNgFJmLcBQObIFVhnq5X8tgAGgaZVLvbcLf8os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMG8fy066LzEYwrUteQMnrHStlc0gzBenkliOeiki6xiqQCVd+eJV1hzZuC5vXjpevuhGB4CVmopnp++9r3/WoO9hEPtKXwaVMfB8P56TktoDjqE3AiSzOTdoQ3VRhS7D73Q7H8KD7c/xcgkUoJznnUzt3bn/UoqA5wn/Ki2904=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A8yc5WDl; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22401f4d35aso81625235ad.2
        for <bpf@vger.kernel.org>; Wed, 09 Apr 2025 09:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744215594; x=1744820394; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Cd3EyNgFJmLcBQObIFVhnq5X8tgAGgaZVLvbcLf8os=;
        b=A8yc5WDlAb+xu7oM2QDJ6W/OpUSewhK05PQ8Qyo75WgSHaubZI4ozrfN8qtiVGncEq
         3ag3v+ofZMHqJx51IpYaZEl3RpIYdHakxfAWG9JonkU3JAClgUKZEP51tkxfb1tcmd8X
         2hPwkb9gzkzkqy4Fmf4Fabxpmy1EVrO3vQDoGN5WwAk+SSGBYNnlywyyYmJsSAUouqj0
         4u/PRVaMbNe9xYq4eclzsh6us8/rh8WkQDe5tY+R2wWKX0kkBAcI2g6y4iSNv44xQqLj
         JKvhQQn3LIV3N0s7kNN4n1tXah5ojMNt3sR1H7UjR9t8+NuzDd9Finl+E1KqgdYSQpCm
         FNGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744215594; x=1744820394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Cd3EyNgFJmLcBQObIFVhnq5X8tgAGgaZVLvbcLf8os=;
        b=Bm7lO9xYg7PGImd0kfZJMwuoZ6py67usLZf8gbnsIegnXHKkr8a22/cE+07BC6ntiB
         YPHOvH1na4McNvZ4IHYR0vbeY94Z27tQs+9R5BpHeIDzRyKb6RIPzPFFzq18DaSq1zl0
         NDWH5YoqvKGd0vngvhVT5i+K5ZZG4rETcHT8QJCq9V6ysqp2x6FVsvUKth+XVcP2Zcds
         RK5PR/FA+TYV1T30ZM4il1qaLXiLlRPXADcTBaxMjfW3jkrwPwL2PPc/Hjy2TkZClhIq
         CcMhWKv6rH1XoyLxpCrQ5ByCrTrHYa5NLfFWIy6uDEZ+duH7x0MQne0zL2f4p9wsydXL
         kCpA==
X-Gm-Message-State: AOJu0Yym1Ssrf3ChxTD4UQDLrTRosm0X7+7yxr4xJweAfQA3n5Up4G8P
	QZLPw5CFS5ROiDLg0+DtxowEt4y8kO9YcO2oDs2esMBpzmuYUIJuYT7Oag==
X-Gm-Gg: ASbGnctOf7G4rAlyliFUTmvCTsnXonAxET7AlOStB7XajDa3FJHXu4Llox9mqA7x76b
	iKg8RQVx+fbEStZu8ysMR8B5WCXPmoHhEJLiiSlNFGdUtNEXaneWgxihfK2NUKB32C+IBxuEtn+
	4vfAgpnUO2iRRJHjskcOZwj0RAXMCPSq3bqrSWGDyjDq4Ah4NzyP3El7OFYiO58bVWtqy9bdSoS
	sVxU2q+n7o389y4OhzUzg7GL4tzjD+MHjsgCJddGc/jlR+ZJn7Cu9QXOmN6rCVREWYflvg/5DIF
	FlHdADQBCzYuHMNramLDGiXt4hq3546nud+Xv8kjGupR
X-Google-Smtp-Source: AGHT+IHtCf6gtBzFe2HpgAUEu2N4XmGipJ3KWXNbgKfescVYjtk2CANORcKgWZVOmAUx6FgjVm8wcw==
X-Received: by 2002:a17:903:1aac:b0:216:393b:23d4 with SMTP id d9443c01a7336-22ac298000emr60842415ad.11.1744215594473;
        Wed, 09 Apr 2025 09:19:54 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7c95cf3sm13996685ad.156.2025.04.09.09.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 09:19:53 -0700 (PDT)
Date: Wed, 9 Apr 2025 09:19:52 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Brandon Kammerdiener <brandon.kammerdiener@intel.com>
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH RESEND] bpf: fix possible endless loop in BPF map
 iteration
Message-ID: <Z/aeKNWeqlVLCfNW@pop-os.localdomain>
References: <Z_aSOFIJkhq5wcye@bkammerd-mobl>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_aSOFIJkhq5wcye@bkammerd-mobl>

On Wed, Apr 09, 2025 at 11:28:56AM -0400, Brandon Kammerdiener wrote:
> This patch fixes an endless loop condition that can occur in
> bpf_for_each_hash_elem, causing the core to softlock. My understanding is
> that a combination of RCU list deletion and insertion introduces the new
> element after the iteration cursor and that there is a chance that an RCU
> reader may in fact use this new element in iteration. The patch uses a
> _safe variant of the macro which gets the next element to iterate before
> executing the loop body for the current element. The following simple BPF
> program can be used to reproduce the issue:

If you could integrate it into BPF selftests, it would help a lot. With
AI copilot today, writing selftests is much easier and faster. ;)

Thanks!

