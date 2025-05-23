Return-Path: <bpf+bounces-58838-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 696B0AC2700
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 18:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01A927B3966
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 15:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E7229711E;
	Fri, 23 May 2025 15:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NicA/MyG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A252957B4
	for <bpf@vger.kernel.org>; Fri, 23 May 2025 15:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748015946; cv=none; b=d3h2zU//NsCOA/mvECm1UBe8C6NLtv6wicW2bb6a4Eyug10PvzatlTuqpdw0D90UhyHksGEE2LIUS05tLDU7p2KRXSy3aUo/4eWuN/lgKdU/cIHV+XRmBgyl57nunpzqijbuYqWUSy5maNry0Ry+x2/fvLiPWu6zBeiUr9JtO+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748015946; c=relaxed/simple;
	bh=pBaS7FyIzCs7ytyhnBDghqiMEVDGLsKIQ9n8hGvAW9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=r3YchDgarQvnsNWNZga/oNdGniloTbYM4kvA7bG1rayk6trgJgVz1OD4aHzZmTMy/VfGembN1YfpX1bP7Y/eYkvdHFdBfr74qDha+gl6zHW2fQ9YMYmx1UeH73RS9KkkZEgyFijbOJzFQXTcRQGlMZUCCQv7+5MQI8WwevVfq60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NicA/MyG; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so77883875e9.1
        for <bpf@vger.kernel.org>; Fri, 23 May 2025 08:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748015943; x=1748620743; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6LLVYmFHopHFs0zGKxn88y8FkA5pTpDEP6h/IotMOuI=;
        b=NicA/MyGoe+q8rfNF+8dsHC3Ja8ErhMGYgTPOAFr03epEOJqa9C9vXR6wZx2QTrh/Z
         OX8x9leHz6SO4ycZns/pAAWjigpeu+/7oePrq2n6s0E3XpQBsFJKBcN/2T6VtCLhtsl+
         atRA6Pa69O1wZJh5uvoBFL4IvbjUxmbrss8tT/XZcrXef8/9QWaJGsXu2JTp4jdlf6GG
         BQjFTparkOjDFdxlp5PT+JGAcWFMOHOAQnK+wZy1OzUrAJ1T2D6pq4tHtKn5ars6SU3w
         7FdMuU384p45DMBt9DP04A4DNKrRQmbYhVh3b3WD78Mv1H9/hs3IKMerZqehosUPqPKK
         6utQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748015943; x=1748620743;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6LLVYmFHopHFs0zGKxn88y8FkA5pTpDEP6h/IotMOuI=;
        b=UI61kxhDTT6IJIQ2c1Lc7shzMfDiTckIEnuJM2USN+gEQ9KYFweaZX0bi/Xo9sd0lt
         vPvUsVMSerMEZ8+ZuMlZ/WtpN7tCRsaxWQqYvLN2L+gqtpxvMUSHWSL1PLBW4btDSevO
         Md1QOv4fbYX278J9VXPjNjDPUexqAdusm/o2voPUkqazbDDQWZGKW+y0hzyWUMhm3w4T
         grrp4VRztttb+3STphNwHttnQMxjYARu/gyHRMRLqkvAhqrB/5jRS4YmiuX9bwYTknVZ
         jtS8twjS0eoeoqIrwrXvXaYuB0B5rNuR3S+L7K54fLIojl+CX9KH6hSLPuDps3dPvxJq
         5guQ==
X-Gm-Message-State: AOJu0YzSEnXZsoRdV8Zr3K0fBRaRMnwGq0vtveb7SnNhW7uIMOVNZVFh
	6L8shnvnJZ3ajEdW8gp3kOKMfF+OlvoZl9KiTU0CqgnR4S4TmBjW49+XL03KwfIUNNDpLaiO7/N
	9hurQ
X-Gm-Gg: ASbGnctxDeT76+wHg5RkBVeGEeYse7pkQWeclkxLqggnjjxcn4nnYqAWScdwnXk+Jwv
	LVNwvGA4pnN9XTwr2f5iYBRCsFsTf/Vw/mj1ARt0yZrd+T5h7RGgv6OZSmXT5cebSwq4wLNyWkb
	5wDYgw0nxv1c0FqHWzeg1sXgBwiXUTtW6sL0hl+TNhNbmxvGeMv4ESEQveil7m8fSu/3i/pN4mJ
	gjE7rmPt9K1Tt+kRSpf5+nbuvlIZ+NOY8G/sFkaOElu+AWn8ty+tb3IQvgFW7pYao4AJWYw3KIs
	q/SYqbE+QkgnAxVfnMfzEgn0KPX5b46CHGBY1t3u68rN86juwbGGrPQRvZpADYOUz+4=
X-Google-Smtp-Source: AGHT+IGsq7ZpK7wS/9JJwrLMcIIrTnDHHQ48kpVOwrW9GI4Be0mwhH+Vc03G+oI7xzkmzzDYUlEZRQ==
X-Received: by 2002:a05:600c:1f95:b0:442:e03b:589d with SMTP id 5b1f17b1804b1-44b6e85fae2mr40823215e9.24.1748015943013;
        Fri, 23 May 2025 08:59:03 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-447f73d4aa2sm149955025e9.21.2025.05.23.08.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 08:59:02 -0700 (PDT)
Date: Fri, 23 May 2025 18:58:58 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Mykyta Yatsenko <yatsenko@meta.com>
Cc: bpf@vger.kernel.org
Subject: [bug report] bpf: Implement dynptr copy kfuncs
Message-ID: <aDCbQq99EfNDI8xr@stanley.mountain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Mykyta Yatsenko,

Commit a498ee7576de ("bpf: Implement dynptr copy kfuncs") from May
12, 2025 (linux-next), leads to the following Smatch static checker
warning:

	kernel/trace/bpf_trace.c:3557 copy_user_data_sleepable()
	warn: maybe return -EFAULT instead of the bytes remaining?

kernel/trace/bpf_trace.c
    3551 static __always_inline int copy_user_data_sleepable(void *dst, const void *unsafe_src,
    3552                                                     u32 size, struct task_struct *tsk)
    3553 {
    3554         int ret;
    3555 
    3556         if (!tsk) /* Read from the current task */
--> 3557                 return copy_from_user(dst, (const void __user *)unsafe_src, size);

I don't know if it matters what we return here so long as it's non-zero.
This is probably a fast path so maybe we're returning positives
intentionally?

    3558 
    3559         ret = access_process_vm(tsk, (unsigned long)unsafe_src, dst, size, 0);
    3560         if (ret != size)
    3561                 return -EFAULT;
    3562         return 0;
    3563 }

regards,
dan carpenter

