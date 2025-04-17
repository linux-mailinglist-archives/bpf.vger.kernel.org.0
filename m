Return-Path: <bpf+bounces-56123-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A9EA91A61
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 13:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1219719E539C
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 11:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368DC238D35;
	Thu, 17 Apr 2025 11:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOld4/TR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B195523817B;
	Thu, 17 Apr 2025 11:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744888575; cv=none; b=PejLLbjEoLGOECt9Pq6N9Oq1Il2nA0DN0XyGQb8dVwr3S62Def0r4eRnIy4eMZ6n294OKY2lu0uXxPHbZR8Kpb1HFLcOsiMpUy8cM5/bNyYCDwZlQ67IEb0tuzGONRtLXfF8hxkX7YSq7GXL5+2KI9xmsYgGmOJ/x3suANuPGFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744888575; c=relaxed/simple;
	bh=R5O71Js30BHfakH/NEkLiIkAkq1QV6lpTAlKWsMZPn4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9dDHlXNNVfKgbiTTVuyi/fZI00Oq2s71JGdfhEgYm0WxMuv6dHi3eHVp6NQRHsuzwd3LbX+egfSN4ld3mse/cUIq5yWPGUAph9bBJGNfvuF3BqfWOjisj4rbLJt4amS4Xma32x/BWrTXwqH0uhidwdq9jlg/jCC813A/rkK38Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NOld4/TR; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43d2d952eb1so4269725e9.1;
        Thu, 17 Apr 2025 04:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744888572; x=1745493372; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nska21crBmdz6JojasinsB56GkEwbIFHHV+nNujavCA=;
        b=NOld4/TRVEJcC9boGAK+SKtmdj2ESZavuRjCih8qFZj3xIcCig34v1P4x0Ho0r2Uq9
         dS+O0RoCXDpeKxqODhlS8ihiw6kPAFamjyTJH9jmNI2JyQtlnqJspA/jJCHQ96h6wzku
         kyB/ERCiTSMKVGT0rcSa7bruTsFoDO8HWkfZVlF4b5J4ATqEY/wTT7nZeJnD7L5MHtmL
         +e6Vof0aii5tNKO0ceSkdhJ58UDrO3BsnfuBOaQppgH4mG+OzrmXOn3LJYe6ABLm5M4J
         CuifZjxs99XHSlNdyxqAcA79xJF9Sia6leK8NiAPUNzc4E8DzHnzI0JZHLOGxJrmYWvT
         ycOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744888572; x=1745493372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nska21crBmdz6JojasinsB56GkEwbIFHHV+nNujavCA=;
        b=ZCkcSWtlm/fBnFgEPHOTJgx+wLseYPCVym58KhhLS81gwnAfOhPbxVjGqKL/hqZlNc
         c6V2SnNsWGKkt68S4ly8jp5edADWM6ViQzPQDE9wV6gE80lC4WZgpfy2NiE0jNgo9U2t
         ygqhFZhHAF+ytHP1vNIUPgReEfxRzBIaBbtfVZtgK5MH6MCz+wxoQhtc2p35fcIEsZkA
         sl2H4DU9/AKggcBAJvQ2NO7MVWE1sEKgVqbXp1IYInbKyMDTKk8xZWWTCzEQa0MDX685
         OW/C1sHPiZJGKQo62lJMM36h2QNCI2qL5pe2YIfyIxGtNx45MB8Ys6ymSA9hQo8I9FpU
         TGDQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1s5XcbVeZfW6T20o3jm4CXCobIWPWfewaW/4Y7dRuQ9APoR68IDO7Ob/UQbQMuJOsZLnthRDusRCHY56n@vger.kernel.org, AJvYcCU6ATjMKBgxJWhE1/gKvwS+N10mL7/JttR3ctI0nTDrbxeS8DA6k7NIMHFGXdBDQ4y9PWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YySXqBWAsfyR2M4Zdo2oOey2H/0jXW53CIbiSeZQlBBIksDWrBr
	WFg1PJMBoalWuOdVeijju+qgwi4ZNCHZViUCt2IHDLojoqQR2EfO
X-Gm-Gg: ASbGnctuOVcYAL0JQRMAcQpo4i0mY1ZTFzeiDMNEFcvdHVWsL/ySlv1gFGKlD7HDtjt
	a4+YCJ7HTrBIYiFDc3gCyLTnP5NujH5us/AZjWXTP6pO7U2vGWqNlRXZeelVWIKcF9+vjzMIkHC
	D48joT1qY6+/1xCHGkMverrSyvxjzkZ60XF8QFvDNgaI2F5Xgd6WLQHAHMdkAXq+OmrwCz8ogLX
	VkJ5FHY2oZ/zIBKERmVS3AX/pQ6fynEB6O7FRCTlmGZC+5NYi94+VxbhFgw/yBwTkds7ibOetXC
	XEZ77O5+rnKcQmnOJqfiidgT7EVLh9wq
X-Google-Smtp-Source: AGHT+IHb9v83zlnCd8nEWcdCrNOaKQ7h/prAuXYrbjfN/0KrYcDFFbB3UDQBtoUx6diru6/n01SsQA==
X-Received: by 2002:a05:600c:354c:b0:43c:e70d:4504 with SMTP id 5b1f17b1804b1-4405d636637mr44515535e9.19.1744888571754;
        Thu, 17 Apr 2025 04:16:11 -0700 (PDT)
Received: from krava ([2a00:102a:400b:c830:675c:d00d:19b9:1f1c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4405b54224bsm49227705e9.38.2025.04.17.04.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 04:16:11 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 17 Apr 2025 13:16:08 +0200
To: Feng Yang <yangfeng59949@163.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	hengqi.chen@gmail.com, olsajiri@gmail.com, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 bpf-next 0/3] libbpf: Fix event name too long error
 and add tests
Message-ID: <aADi-FfI-PljQzcO@krava>
References: <20250417014848.59321-1-yangfeng59949@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417014848.59321-1-yangfeng59949@163.com>

On Thu, Apr 17, 2025 at 09:48:45AM +0800, Feng Yang wrote:
> From: Feng Yang <yangfeng@kylinos.cn>
> 
> Hi everyone,
> 
> This series tries to fix event name too long error and add tests.
> 
> When the binary path is excessively long, the generated probe_name in libbpf
> exceeds the kernel's MAX_EVENT_NAME_LEN limit (64 bytes).
> This causes legacy uprobe event attachment to fail with error code -22.
> 
> The fix reorders the fields to place the unique ID before the name.
> This ensures that even if truncation occurs via snprintf, the unique ID
> remains intact, preserving event name uniqueness. Additionally, explicit
> checks with MAX_EVENT_NAME_LEN are added to enforce length constraints.
> ---
> Changes in v5:
> - use strrchr instead of basename.
> - kprobe_test add __weak. Thanks, Andrii Nakryiko!
> - Link to v4: https://lore.kernel.org/all/20250415093907.280501-1-yangfeng59949@163.com/

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka


> 
> Changes in v4:
> - add changelog. 
> - gen_uprobe_legacy_event_name and gen_kprobe_legacy_event_name are combined into a function
> - kprobe_test use normal module function. Thanks, Jiri Olsa!
> - Link to v3: https://lore.kernel.org/bpf/20250414093402.384872-1-yangfeng59949@163.com/
> 
> Changes in v3:
> - add __sync_fetch_and_add(&index) and let snprintf() do the trimming. Thanks, Andrii Nakryiko!
> - add selftests.
> - Link to v2: https://lore.kernel.org/all/20250411080545.319865-1-yangfeng59949@163.com/
> 
> Changes in v2:
> - Use basename() and %.32s to fix. Thanks, Hengqi Chen!
> - Link to v1: https://lore.kernel.org/all/20250410052712.206785-1-yangfeng59949@163.com/
> 
> Feng Yang (3):
>   libbpf: Fix event name too long error
>   selftests/bpf: Add test for attaching uprobe with long event names
>   selftests/bpf: Add test for attaching kprobe with long event names
> 
>  tools/lib/bpf/libbpf.c                        | 43 ++++------
>  .../selftests/bpf/prog_tests/attach_probe.c   | 84 +++++++++++++++++++
>  .../selftests/bpf/test_kmods/bpf_testmod.c    |  4 +
>  3 files changed, 104 insertions(+), 27 deletions(-)
> 
> -- 
> 2.43.0
> 

