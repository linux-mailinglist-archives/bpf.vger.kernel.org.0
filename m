Return-Path: <bpf+bounces-29793-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 663518C6BAB
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 19:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97BB01C21F1B
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 17:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E561586F4;
	Wed, 15 May 2024 17:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="By2qxv9s"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1504EB3A
	for <bpf@vger.kernel.org>; Wed, 15 May 2024 17:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715795074; cv=none; b=IjMSzHSLvtda3/pGQOAN9jXBDnfoUKKBV9ynA/2mMMdM3R2Y+ydiiqOqjkfUIxLVccCtlfzSZRL+0x2zM/uUe2sUva4lsf0g/hjLqI7KQo3E0YiE8EaR/7as/IPfIwAjWAFXFKWC4BFrzq+ATe9pzd2I+PVF3N+DVin/1jyitVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715795074; c=relaxed/simple;
	bh=q9J1FZs9ozWZVyiyoFMZDS1AeW945fryMwv6slh8FOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L2UvRXx2ktJDT7vXYcoht/iHilyiC5F8HWiJtfshGPQz7ws+6M4aoKxPNM+6hxPgzeg/4JhsHJ1UTbHL/lzAZXeKg8eNYdPvNQJkPcWUBZubRnc3JXCmqJGZi3ACgQcABR9mCbo9o2bprFOEkxX2ShphM69sSma6HNA3UAE/5xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=By2qxv9s; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-61bed5ce32fso76793037b3.2
        for <bpf@vger.kernel.org>; Wed, 15 May 2024 10:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715795068; x=1716399868; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q9J1FZs9ozWZVyiyoFMZDS1AeW945fryMwv6slh8FOM=;
        b=By2qxv9sA5pNcIzwp1pOeDb4xjrnZoAbDmfXlcXhv9aLqdlagZwDZgYw3WHECo6YcK
         o4bkSvQJrcBqB/DnpKFScDkXGHp8CWKiOKh+hlnxYku/2hMC/beP2ycx1XoxGlYCmDwe
         hAbbhgAdDgKN0aZcmWld7UNHESOs/QpgMQdXNnL/ps/GEERFvM0evbE5A0aKQZQIQ+c2
         bz279ci7cRcJwlSkQM7dapW1DWQ66IJPY91E9DFJ9xrdD4bUxu3b72SHIy3uQC8Xed1g
         9HqyoZRxSvggcB+McGsJJMrPd+dMWrTH+3bOHWkkBHD/h2o25bGp13N6FsCPI2c790yv
         KVXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715795068; x=1716399868;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q9J1FZs9ozWZVyiyoFMZDS1AeW945fryMwv6slh8FOM=;
        b=QDjKmm2UbYHcpfL7mLstvbfW2/F3ZUPuYADCRvD/PUezxmgPEStZat+pSFE3kTCF8n
         +ALofGu/rU2aH0zMoOIleuCXvCSWeWWuQdTsJTVVx0XQQMnz9gmgxOT+2xMxpiGSyjdE
         cK60BgINYjCg2SSwcBkxTes2LHPUXsfCo99+grF4SaJPpb07X9T3ZZME3j9uluxlvMwA
         fWTEaYZrlZs0v/LSTLgZSeV9Y0+GGqBg4UwaUwYaFHHG9QkWB0FeaGFyDQ9cI2CTNTMm
         x3Nb5eVQgR8BMz3+kNeHydtgU7a3IYlZfmuyl2FDAk+ogKxLZIklw0O2E8Sfv24JFCR4
         KIGw==
X-Gm-Message-State: AOJu0YwLUZoeOWN/Cm2i38cuRHYg3g3nuv4Yg7YscUH0L7BcT2Z/reyX
	u3XOl+N4XgZi7Ao6WiUGqN70Uhy5GsOOauo8WQUdog8U8KcBtWF8uBVFwKg3CQz45urWfgP4d7B
	z2syh2A0QLMxwNm3lDMdGoSQYfqE=
X-Google-Smtp-Source: AGHT+IEblYS9wnsq+kWWE9lLBUNCRABMIgIFypPGLZ+bzBhngmMdIwrVP+v0VaFFvsupfbX7MostoNUD8lUVvz2fv/o=
X-Received: by 2002:a25:ae90:0:b0:dcd:2f89:6aac with SMTP id
 3f1490d57ef6-dee4f1b7b86mr15445145276.10.1715795068176; Wed, 15 May 2024
 10:44:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514124052.1240266-1-sidchintamaneni@gmail.com> <CAP01T778YG3sL1BTJnPdOJkqhcNG=zv2dEp1hquUV1+aX+DXDA@mail.gmail.com>
In-Reply-To: <CAP01T778YG3sL1BTJnPdOJkqhcNG=zv2dEp1hquUV1+aX+DXDA@mail.gmail.com>
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Date: Wed, 15 May 2024 13:44:17 -0400
Message-ID: <CAE5sdEgjqYkSyG9MgrpJ=dDCEGtC0e-L4hzV+tz8Pr8c2EbrnQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/2] selftests/bpf: Added selftests to check
 deadlocks in queue and stack map
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, daniel@iogearbox.net, 
	olsajiri@gmail.com, andrii@kernel.org, yonghong.song@linux.dev, rjsu26@vt.edu, 
	sairoop@vt.edu, miloc@vt.edu
Content-Type: text/plain; charset="UTF-8"

> CI fails on s390
> https://github.com/kernel-patches/bpf/actions/runs/9081519831/job/24957489598?pr=7031
> A different method of triggering deadlock is required. Seems like
> _raw_spin_lock_irqsave being available everywhere cannot be relied
> upon.

The other functions which are in the critical section are getting
inlined so I have used
_raw_spin_lock_irqsave to write the selftests.

Other approach could be to just pass the tests if the function is
getting inlined just like in
https://elixir.bootlin.com/linux/latest/source/tools/testing/selftests/bpf/prog_tests/htab_update.c

