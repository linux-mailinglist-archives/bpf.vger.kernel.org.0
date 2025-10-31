Return-Path: <bpf+bounces-73177-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33000C2639C
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 17:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BACAA189A594
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 16:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1524A2F3C34;
	Fri, 31 Oct 2025 16:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gd+Vq+54"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB5F2C15AB
	for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 16:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761929338; cv=none; b=Yxu1wXqRGOEpjgUWPGcCL/K4S3k3tykG8Qj64J2AzklfRx79PNm6CwGgidfJuHDb063QF/wUlEbz4PrpMA/rgJwJKmGfN+2+/NC5DvTaJZHF5pYLn9fN69cxaIDX6zTaGJ9II2Yc7Pwf4+XBpwc6rF6p/2Y9JKqZgndmRRUfkzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761929338; c=relaxed/simple;
	bh=jkmdMqGEGLTAlWpJzbFnFqAwY8BBbmWukGoDZnvbHLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XK2f7rb+l4ShFJobzlGCQGM0XNRJw05m/3PWe/Iw11Jt3nXffONybJ8awzc+gzUMG8llqKl7l46EGBS/pZnKVwXfupAf4PnzScq+jJspocHheSd3jVLxJwwdi9AKKBUxRMREro7Ci0kjl+Ud5FaKASkHabJma6rwP68Co0LwfRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gd+Vq+54; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-79af647cef2so2430180b3a.3
        for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 09:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761929336; x=1762534136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lgb+9C3jvqIAil5vMaPqTfTmFra5MOD9hf+0ALcR1eE=;
        b=gd+Vq+54MXmvC5nvbN879S4ri6sxSBUwohX8qDc5jnZQl6lhgbNrMEykQP0cNSuhB/
         ClasQv1XTo/KBgJ54eSq2PtB9Wjm8ZBGmxuk1cPrIiPwCwHjpCwgaIvDM4gPvNv7ZjoP
         5WRVKHiaY2hPnXKYOGbLF17aGlaUL3bpPdM7RCKkk2zMmzXd1CmZQr4Fl19F3MWeEZxy
         Sbzo0VInSsmjQFyCDA5gCPwbJG39CYOdS/zhie658SAmNY6w6cVfkqfRV6FF6RvoS7/D
         OouEt+u3p0ARrhHu8gjlmrQJPGVHZm9vzf1gQmwADhLANAY/GyWzSasfl4nEBhBkwm2w
         wvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761929336; x=1762534136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lgb+9C3jvqIAil5vMaPqTfTmFra5MOD9hf+0ALcR1eE=;
        b=C4Vm3o/YKf2lUpc2GowQmbKXbkAyKO6atIKH0pJjN2mrh2q9o8swy5LVVtnR/Fasxi
         EJ4+WahRFsr6lx2LxvgpiHHD4xcYSmWQ8YIHT8HDpGvx2WPW9dDHHgbFWY6UdWOtWPg4
         yNLomNt3TI5+gy5s4uVZ2yhS3LjyEIU/ZPhwyvcgSg5W+qy1I7yRiNSYHJieZoJ3LIit
         g7Dny2RRo4UCNCYTahKfGljfPjcgRue4rvWhzzA5xGd8942HoovQbtdaTPeh7iEdWvLA
         FYO93dWMbNRS7IKWxBK3b3CGsNGPJH8bt6dtgeTvoHhEp4pqahbNH3iTbuArKXuAY6wi
         y9rg==
X-Forwarded-Encrypted: i=1; AJvYcCVivwk///CdWdR7bmlgh2kfW4fCuWQHvbaYX+4MFCvqGNjnvnuL6Elc+Fi4v6ZitPentkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCxptRcpN6l6+VK8RtB1vampuPrRWhdG5/teYg1bmA+pOeQXx5
	cuuw9RyI+QK2fbh8+zTufMbhObogqGLsTrktwsma5Ha4XQDI2m9YI2J9
X-Gm-Gg: ASbGnctcFOIene3I400lgxgVSFCU0MX5ozB1aPtTKbvnFb4jmIIPD2g8Fslc/RDWu7u
	vCVc640kL0YbxaHZa6NC5MxQCsYg9PVg/6EM2H3dD6uqBXVKHWVodKxHdlC4+CB8Ffv1waLsGDo
	+FGOn/B03gETX5wQvZVr3Sgy1TqGycSubiEN9+A0AIlX0ynr6difpVta1u58GPNBRML7SfSD65v
	sC3bNcmCaMNslDOCujXkUuLae/RxBlx63GFL/ol6Hx3i0AqY4mc6802YLFVnqWq1WZKDolx1O8c
	Idpye1i6xh319kdBT6rIh1M/260RWq3L7YnQAzGwhx9A++ISfkmtrcjQxgs3548MANBFXqu93Gw
	2LTB6cCFmjOZgbnWy59bXkSl7iXxe6H3uYbwsQLHnk41f3gPZlvzz1eGPOwCdiqPyedLpX8j2vC
	wyZTJuig3riG8AaRgAQ0tq
X-Google-Smtp-Source: AGHT+IHzisb8pOTUrWEeEIlE11gPDxItgXXojG7g9LRH0MLHpSQGT5VIV7jL+XPyT0+qo+/zJb0lZA==
X-Received: by 2002:a05:6a00:9291:b0:79a:905a:8956 with SMTP id d2e1a72fcca58-7a77718e95cmr5394654b3a.14.1761929336301;
        Fri, 31 Oct 2025 09:48:56 -0700 (PDT)
Received: from localhost.localdomain ([124.156.216.125])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db0a26f2sm2755863b3a.41.2025.10.31.09.48.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 31 Oct 2025 09:48:55 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: mhocko@suse.com
Cc: akpm@linux-foundation.org,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	cgroups@vger.kernel.org,
	hannes@cmpxchg.org,
	inwardvessel@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	song@kernel.org,
	surenb@google.com,
	tj@kernel.org,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH v2 00/23] mm: BPF OOM
Date: Sat,  1 Nov 2025 00:48:44 +0800
Message-ID: <20251031164844.27060-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <aQSB-BgjKmSkrSO7@tiehlicka>
References: <aQSB-BgjKmSkrSO7@tiehlicka>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Yang <lance.yang@linux.dev>


On Fri, 31 Oct 2025 10:31:36 +0100, Michal Hocko wrote:
> On Mon 27-10-25 16:17:03, Roman Gushchin wrote:
> > The second part is related to the fundamental question on when to
> > declare the OOM event. It's a trade-off between the risk of
> > unnecessary OOM kills and associated work losses and the risk of
> > infinite trashing and effective soft lockups.  In the last few years
> > several PSI-based userspace solutions were developed (e.g. OOMd [3] or
> > systemd-OOMd [4]). The common idea was to use userspace daemons to
> > implement custom OOM logic as well as rely on PSI monitoring to avoid
> > stalls. In this scenario the userspace daemon was supposed to handle
> > the majority of OOMs, while the in-kernel OOM killer worked as the
> > last resort measure to guarantee that the system would never deadlock
> > on the memory. But this approach creates additional infrastructure
> > churn: userspace OOM daemon is a separate entity which needs to be
> > deployed, updated, monitored. A completely different pipeline needs to
> > be built to monitor both types of OOM events and collect associated
> > logs. A userspace daemon is more restricted in terms on what data is
> > available to it. Implementing a daemon which can work reliably under a
> > heavy memory pressure in the system is also tricky.
> 
> I do not see this part addressed in the series. Am I just missing
> something or this will follow up once the initial (plugging to the
> existing OOM handling) is merged?

I noticed that this thread only shows up to patch 10/23. The subsequent
patches (11-23) appear to be missing ...

This might be why we're not seeing the userspace OOM daemon part
addressed. I suspect the relevant code is likely in those subsequent
patches.

Cheers,
Lance

