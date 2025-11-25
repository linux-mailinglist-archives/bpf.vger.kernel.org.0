Return-Path: <bpf+bounces-75495-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CE9C86C7B
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 20:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C6CED4E88C6
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 19:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE57337BA0;
	Tue, 25 Nov 2025 19:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="0RfdHa56"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DCB333437
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 19:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764098355; cv=none; b=cmGL3ecB6E9YZIZkByp6r/o0/iPLB3ipWLOFGu+DP5UYBJ612Flg9PEMBVSaoYWWqP1KjyirtqK/YctwlVM5bLk3tOc1wtwpCH5gkSbS7RO9DC2UU0AnwdmK10/CsnzZ+Z2medRVNNqAViP+YKP9+o4zdZSOE6M9ZZ3KQK/wkyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764098355; c=relaxed/simple;
	bh=45sbcsoq0xhsn+W5aOkv0g/ik59ollw7OK4nkRDzkZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dKyZ6VA1n0f8vC9xei2iaGs7LhsDAi9E0k4v4GAhbQdVGff9TlBDZPLpIfjfYChPPmtA0oRgmw/eNZJHIpcvselhMOYaBDsVKaBdeZslJGVATTXa3eE6ecfUMHxe2Zq0VKgcHW/jnGOy1CxMDPYAqhXTosV6XDiwYgGoHPKEeXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=0RfdHa56; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-434709e7cc9so27433635ab.1
        for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 11:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1764098352; x=1764703152; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mUfqGNY8yNMCOlzV27bzhMu4chO9eJxWxW9kWFtTcZI=;
        b=0RfdHa56HkCqjGft6ZM3f9ZRGWqMxVLGvBYSDJcNW0xBHEb50rtnCPR7S4M8THVjsK
         hqKTu0JqV8a2FMQU6KwQFEdyWHwhVeDhDgtbygr/OSIPPZfgipOsHRVinPBzGrr4VT5o
         KDfEeaM/jqJUiis23wNz2bL1fewwXy7gesBFA6mM1XIdygxsbFF0n5Os1a4GwY0r6l0U
         dP0WR6SJPOFFSUNngFQfQaZwAvGgExdn78Hb/RhCc6mAWeHn7mPINdByL+ZKfjhK9hZQ
         SZizayExk5WDnrH0+TIG5ruvfmevVCu8XY5GvJQKgL1zMi/ngzL5HpSEdTfl1J4FZ0b9
         YrWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764098352; x=1764703152;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mUfqGNY8yNMCOlzV27bzhMu4chO9eJxWxW9kWFtTcZI=;
        b=teJ7JIp2btR9qCIs5DPTxbWFcln8RQmpN/r8eClKGph1X7KjPeKbVfUJSpnogZ/kyG
         LG0FbZbywBmsfBki5SpfHS/tImhsuCqMUpWvL5axcnrCmfY8VB5UuW6EImRr33ZexZ0k
         Lmj2Ufzhuh7nazObHefrMBmyxTWwR49DaR8U3EUKBBNvebeFJThqMGe9QQiuTdpN6Upt
         CrCHi0SufUuEVP5c+u1SAsnO8fLEp8L1NgYC4atbTBXxzaBspCBzxaZtTXPDiUFmuJmX
         dqhb1RQvW1oqmneNa0B9FHF/zSKEkdwMN055dZny0ct8B9g8j7lSZsnnoHRTNtUC4Ge3
         LtBw==
X-Forwarded-Encrypted: i=1; AJvYcCUIK3zRzWuHbfRc+FeSGcIxsUeFdAPj/Twg3I7cK6ljM0mk0Ncr5busWwhdByXRLgRhSCk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq2NmtV+Xp5m7iCpXXxZV/UslVIlWhByu13assk+HbPGCvKalM
	MQr2xU0ZzxUvzb+iEyxdRaW/51eNsZztcKQUW2sXCgbLa7hyU+I6M5HlXBymfgic+c0=
X-Gm-Gg: ASbGncuTX6gL9JGuji14oD0aywLTkyrRBf3vvBMRIJBZDEpZaXtfyTQQOsOeLi7oTZV
	qqqhvPDrg2w4ojr28buxTPl1Mh/JY1Mmokjgl+mWquHfYzih69RuxGIV53JLORUCeoHO7mVNtxd
	Tkw6YXC9L1a0HSgSVvUKqCwl5pZc4rC38Sh5DC2PQrD2tb+VtKJhdsP1ByemJm0XSaIdwwgcsjQ
	lJEV0Fb4FkG3ylul2eD/3HGSH0pOu0QpZRO+cOOAzuqDzRF+JeJSoU/94nsmEFzyHJ7vvOprgQW
	JCp++YsBTf83D/AM47UF1loEKEjmGZ/m8ojs/tGairefWDRpLPjvk53j+h/E63rsCaZyP6gXFrc
	cXETxrU3IQF6eSzmqu8GN26anqacjofNZCvEVFj5AkCOYqZPjz5PchhZrlRIaGaBQo8og3vSxoc
	8upmKAeA==
X-Google-Smtp-Source: AGHT+IFQEaswkUqFfWJbDMiqY0I1VozYHdfo1ZahjMrEfHe7a5FmQfgVW6+5KRthy6ytF5ENx/5MzA==
X-Received: by 2002:a05:6e02:330e:b0:434:70cd:e27d with SMTP id e9e14a558f8ab-435b8e6957fmr145921635ab.24.1764098352527;
        Tue, 25 Nov 2025 11:19:12 -0800 (PST)
Received: from [192.168.1.99] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b954b48ed9sm7452092173.50.2025.11.25.11.19.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 11:19:11 -0800 (PST)
Message-ID: <a192b8dd-6d67-475c-972e-a88d6d8b8e5a@kernel.dk>
Date: Tue, 25 Nov 2025 12:19:10 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/6] block: ignore discard return value
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, agk@redhat.com,
 snitzer@kernel.org, mpatocka@redhat.com, song@kernel.org, yukuai@fnnas.com,
 hch@lst.de, sagi@grimberg.me, kch@nvidia.com, jaegeuk@kernel.org,
 chao@kernel.org, cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, bpf@vger.kernel.org,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
 <20251124234806.75216-2-ckulkarnilinux@gmail.com>
 <e3f09e0c-63f4-4887-8e3a-1fb24963b627@kernel.dk>
 <851516d5-a5e8-47dd-82e0-3e34090e600d@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <851516d5-a5e8-47dd-82e0-3e34090e600d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/25/25 12:09 PM, Chaitanya Kulkarni wrote:
> On 11/25/25 09:38, Jens Axboe wrote:
>> On 11/24/25 4:48 PM, Chaitanya Kulkarni wrote:
>>> __blkdev_issue_discard() always returns 0, making the error check
>>> in blkdev_issue_discard() dead code.
>> Shouldn't it be a void instead then?
>>
> Yes, we have decided to clean up the callers first [1]. Once they are
> merged safely, after rc1 I'll send a patch [2] to make it void since
> it touches many different subsystems.

OK, that make sense. I'll queue patch 1.

-- 
Jens Axboe


