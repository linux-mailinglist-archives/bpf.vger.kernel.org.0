Return-Path: <bpf+bounces-70471-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEF2BBFDA9
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 02:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8692434C1AE
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 00:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BD51C2DB2;
	Tue,  7 Oct 2025 00:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8i+Fs59"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C59B8248B
	for <bpf@vger.kernel.org>; Tue,  7 Oct 2025 00:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759797295; cv=none; b=ZACPhvBG64GlJNPKv/oDdG0StddxLcNBlD6xnNUfv72sqnZSoAQlFAYsYgybsnQLoo8n90xn6aUvhZ3D0QZ8ZAKZ9RMSlhLsy/unnR7dC5hTKPDFtlBwXZOb4jE/RMTFI97SzF0XrMRSYlMMik7rqNDVONg7VN/4YJDPDCA4dl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759797295; c=relaxed/simple;
	bh=dVxE4kqsayik9spu5iC05JI2jJiP0Lo28tGW/vykYxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S7BiqlhMzLWbaevpMgltKrSadxxdinbTYaIeretXEPGhbqnFykTv3XpD5TvKQRppIbWYZ+rByinRuNHekIMnhAFh9EwGPSgdrmbmP5PsCXfRL7/5bJOsucJ2a/fWTw8cf0Y3j+Ow0wW6QLgEyfRkt/6/OtUIWkFLdGbua8m2X5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8i+Fs59; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-59a8c1eb90cso3131480137.0
        for <bpf@vger.kernel.org>; Mon, 06 Oct 2025 17:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759797293; x=1760402093; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dVxE4kqsayik9spu5iC05JI2jJiP0Lo28tGW/vykYxs=;
        b=O8i+Fs59v+RApqmjxLQTsjINrjwmMkBgpV+NHyy+yBgjg4jRTbvM1rwgb9I1w4kXpm
         ajFx1qwzt4WzWk++fzHIpC6rX3/E8j0o7Et1bMynrT+cXPNGdai/+Cz2uxOwpNHPgHI0
         2EnpEOo1WDROSdZn7nU8RYbrkvtni2yz8Lo2s0zHjNCuEy1S+Ng0oZOD4SauESpB0sMe
         p8oXlkLssAeYLupLiikR71+sHT23H79YcKjHbI+wXnFeQM2qmze9IpL0iQaYOPXUNEhd
         rRaH0cPu9sLiUIoyVQi1o9ig6bLumBeVDLvrs9P21UAQG5OKhnfPRFMBFpHPEygd/xKk
         TlfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759797293; x=1760402093;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dVxE4kqsayik9spu5iC05JI2jJiP0Lo28tGW/vykYxs=;
        b=mESED3b9DdSPE2PDjS/FBIMV2xQ8sUXuQ3enFXonKgp71GJfLIBQ8rXmHQhiPyM73m
         Sq2yA5F0lbT08I3ihccgnpCAGUloq37nSJmRK1s6neYOk6+06xi1rdmJv7cl2zNJ7nlW
         DR+YqqB2Gq2hyKlDcg7RmBY7Y88+icdLRxzhddv/f6jmHm+DLOeFsDdgGI023oM3Wd80
         d7K/EDP3PsxGLD1Uo312KUqRUWd6nfygKINLj9IZNMhp8MkJBRnEMaenpxkl+YPgQg4B
         AvEu6sWCkgPfZosUKigXr3xo/zfgdXqyho0oay4WxJklv/YpzxQJQU0w1VU6XjaDNmqy
         Xuig==
X-Forwarded-Encrypted: i=1; AJvYcCXkUHxvcN0cpimuhy1wC3aV7frd2OvercLTPTdczy+UWvCZ2o6Boch3ikLUTRZLsznOQTU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5mZUMx5/f+lXy7TMB6uSwg0K/ofFrqI6zXKgUQZbt4oJ4KKNI
	uRVqA6LtiHyjJj+AOlzPTCNIIdUvjPtiAzVSNZLU3e7ssl7nKXpqdkxS
X-Gm-Gg: ASbGncuPhLhFf+VZr4QADASl+Ej48iUjix1AwrPYImcYub31cWLKmYkc3CYZ5bCI12D
	j9VUROq/uow0QaqNMBdpVd/IHTvqEVqBCFKJ3AJ16DoHK27irH6HzCbddQyBIZZOHxKkvzJ/EeQ
	8YPZuHKA6TyRzHE3kDxSoRP4MEG3hvzNPr4GO/dIMe+OZYmQwrrLbQ5R9vI6KGhOwAyGCzrf/zi
	vUay2lvf/Q6uXuG2HTVoG0vlE2REZe8slkDMQWY2vgiGN6TXLx6uhuAjS4o66MaJQGcM6zocw2n
	YbDSt8vQQQ4Ibl3XVuW1bHFL41ZpOWTmkhilwimocJMqhpYB+Nf8DonikkBk/lnx2Mu+2TO1uf0
	SN5FddSFDkQs5Bay8h/h+/RI9QCsaW5Jo9aUsYtrLyWfCnjChAaT7WERQ41cAxjs=
X-Google-Smtp-Source: AGHT+IE3DxDJy1X2O0RVTDrH5pK6Mahm73HMjAQ3c3xbUcpHPjYdcbPHQ3+bH9uPCNtWQ0OHwdA6iQ==
X-Received: by 2002:a05:6102:54a6:b0:4f9:d929:8558 with SMTP id ada2fe7eead31-5d41d0588b7mr5504246137.10.1759797292906;
        Mon, 06 Oct 2025 17:34:52 -0700 (PDT)
Received: from [192.168.1.145] ([104.203.11.126])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5d5d3571cd4sm425310137.0.2025.10.06.17.34.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 17:34:52 -0700 (PDT)
Message-ID: <1265ca13-ac43-4ee4-a9f0-a6b5ae2af4e2@gmail.com>
Date: Mon, 6 Oct 2025 20:34:49 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf: test_run: Fix timer mode initialization to
 NO_MIGRATE mode
To: Sahil Chandna <chandna.linuxkernel@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, john.fastabend@gmail.com, haoluo@google.com,
 jolsa@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: skhan@linuxfoundation.org, khalid@kernel.org,
 syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com
References: <20251006054320.159321-1-chandna.linuxkernel@gmail.com>
Content-Language: en-US
From: David Hunter <david.hunter.linux@gmail.com>
In-Reply-To: <20251006054320.159321-1-chandna.linuxkernel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/6/25 01:43, Sahil Chandna wrote:
> By default, the timer mode is being initialized to `NO_PREEMPT`.
> This disables preemption and forces execution in atomic context.
> This can cause issue with PREEMPT_RT when calling spin_lock_bh() due
> to sleeping nature of the lock.


What kind of testing did you do for this?

