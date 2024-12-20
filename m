Return-Path: <bpf+bounces-47459-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A09EE9F9914
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 19:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FCA216C7F2
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 18:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0855C22A7F2;
	Fri, 20 Dec 2024 17:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxhJnQ0Q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBC821C9FB;
	Fri, 20 Dec 2024 17:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734717165; cv=none; b=aXw19SuaqjSsCSWdRrhgcwKE38qcOJ+YmRz5wMpKCYg6IjpoTRAxZPzQp0CSa830TMFCO5x2uUXdHKvq0PPxIn0EzYLttjc+qz5aMZCnqje0ir939OYAa0tumzUZo7e9Zu2ngWPfSs8JvkIOwXlpi1a0q4nQvnin5toOtZ13jeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734717165; c=relaxed/simple;
	bh=q0nIjW1ysVM9kJfZ/fVXtFk+Dv7z+myDGOE5MtapGsA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=PCeMPbcF4uNfgjF/IlNXeYrWCwzC4bJbFikXxG9UjBPu+rHanzEUZv8szcFyl7DczwJI8I2ltXD7QUhLUOptpTTM0PfYugPUE0mdFzLhPm40sjtlDSSIGPY0QAnuOR0HZys4DZYEgSZPrgB9K8yyJjpTCGgJkboyiIyuVLbUsEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RxhJnQ0Q; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2161eb95317so21914855ad.1;
        Fri, 20 Dec 2024 09:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734717163; x=1735321963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m0a3Bi3FP3g9rKfyCAlvbxco5mrew9qXQ5adEdI95vk=;
        b=RxhJnQ0Q3npbaVJgPS3ngd4yXLr5md3qNzy5khVi4sYvL74tYiPUd1D/KOB+8bGEQy
         q26EVGTBL7l72pE1rWcnPMfZLjp9Y5/n37yV7IxrjMYBJy2WqWXLm6/xZzZw6D780Dwv
         HX+QIjlE4bp3uqXP8Xcs3AkDvkETu2EULqb+N7oLA6mC04Hz0OFatyCpAblwe7G+HL3c
         Tmg8MtmOhxGiow+iSWJGO5MkGot4ohcf4zydm+ZU3WHgEptnF3O8sw8ZvLLerQrMP2Pk
         lrU48niK/t5R+Hzod5y4KE6priVyc1t8L+4sgrwV6q6UM7bz3NMze0Wcg7/I+NVf9xo7
         oipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734717163; x=1735321963;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m0a3Bi3FP3g9rKfyCAlvbxco5mrew9qXQ5adEdI95vk=;
        b=sptYeRDRNuHfsHBvFLaHX4hejqHDHRaWdlbujmZhMLUEMFIsafM8+ersCHtoIKE3SE
         YX7Uns7zXXe9bIa43pi/KSy73S+mCeF++sD+AWG6lSV7NHIDACdqgkaRkGqJNmH9pxrd
         vn04IsA/Fo8zQwzmXe9FiajC5xHpncR4xLH2gIVUtG676ioGJpIFWyMMUkMqKQ36Q2tQ
         NFzmomQ+zwn/KgjE1j9t1pTONbAxOL1YsqrwUaigttydX8dCwYxBqqDgiWIei5tWG1xe
         433tYYHlpwKeVUHqJOGCCHblwZKLjaW7EZKpoKPlr8SugQ9k++/KYUiUgcHkcplyr6aQ
         8nLw==
X-Forwarded-Encrypted: i=1; AJvYcCU9c3BAkhOLqL+EdE9v5gBqsW4hsaxFcZEZVMtJrjT4b6wz9fWqPO/wweeYYkcwicwIv0dFKD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YztmXx/hjsuTDMd+fn0u2RGBI7y9+M30K6HrYkzW4l20wHk8Cdp
	fJAwawW25wClPRvY/Mzx4jy3PNyRBxBwTiVralGL5dTAelwcdXrI
X-Gm-Gg: ASbGnctJQgrEiY7qsawkODc6IfwMTo/Sf9AUdzAXhYPmOoEdaOwnsS7ik47taPNJQFk
	uxxAx4h9H5a5Qo97umZmJsC0v3ieSxG05qOFj3BNFjftsxj4rNnm6b+RSrBitYPvWaWwE4Wc/CR
	83XNXa84HEJ9dJRPlvFk/MMNtJbu3AtwdUBI5MOh7VKMddosux041kQ48U9LvuaynxUTzLfCZBo
	e81zO3+xVNvVcYqfUaglQlUO35N7aHLr2qnGYFUUQ2vaPAN+wWh0UE=
X-Google-Smtp-Source: AGHT+IHyjgW7Q0px2p10Uhw4EG/Sj2d8pX5Izwwq0TBKyxstbWEkb2Uysd3or2bWBE7jcCnDjMVIZw==
X-Received: by 2002:a17:903:25d2:b0:215:ba2b:cd51 with SMTP id d9443c01a7336-219e6e9fdd8mr42679415ad.15.1734717163369;
        Fri, 20 Dec 2024 09:52:43 -0800 (PST)
Received: from localhost ([98.97.44.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc970c84sm31846585ad.58.2024.12.20.09.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 09:52:42 -0800 (PST)
Date: Fri, 20 Dec 2024 09:52:42 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Cong Wang <xiyou.wangcong@gmail.com>, 
 netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, 
 Cong Wang <cong.wang@bytedance.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Zijian Zhang <zijianzhang@bytedance.com>
Message-ID: <6765aeeaf0b9_21de220885@john.notmuch>
In-Reply-To: <20241213034057.246437-3-xiyou.wangcong@gmail.com>
References: <20241213034057.246437-1-xiyou.wangcong@gmail.com>
 <20241213034057.246437-3-xiyou.wangcong@gmail.com>
Subject: RE: [Patch bpf v3 2/4] selftests/bpf: Add a BPF selftest for
 bpf_skb_change_tail()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Cong Wang wrote:
> From: Cong Wang <cong.wang@bytedance.com>
> 
> As requested by Daniel, we need to add a selftest to cover
> bpf_skb_change_tail() cases in skb_verdict. Here we test trimming,
> growing and error cases, and validate its expected return values and the
> expected sizes of the payload.
> 
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Zijian Zhang <zijianzhang@bytedance.com>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> ---
>  .../selftests/bpf/prog_tests/sockmap_basic.c  | 51 +++++++++++++++++++
>  .../bpf/progs/test_sockmap_change_tail.c      | 40 +++++++++++++++
>  2 files changed, 91 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_change_tail.c

Acked-by: John Fastabend <john.fastabend@gmail.com>

