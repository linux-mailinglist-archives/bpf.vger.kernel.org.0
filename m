Return-Path: <bpf+bounces-64916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8906B185D3
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 18:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F16D1C27444
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 16:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6418F19C55E;
	Fri,  1 Aug 2025 16:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="sdazmD5x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E663176ADE
	for <bpf@vger.kernel.org>; Fri,  1 Aug 2025 16:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754065913; cv=none; b=CoBj8+RpSY6W2gaYmMeMguMqpoAERYrBtOwCrTUXHDhur18swCSvhCwcE+H3Pb1ZmtWR76LWASSa2Fk0LEZzCCaeuIRk6tFKXbc5kvgYwTuL3iOecwgt5Lz0lRj/wJHM94qDoNuwosDovz+hjI6858/TD3t2bNwdJbq3v4pgnVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754065913; c=relaxed/simple;
	bh=6hEkeN4SJSpxJSAVhU28lk309YvI51c5hc4D7f3JTM0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=iGPQ51houFDEez2gVDmJ4xcqOXnsl0nWJR5vFQc/QlxJEsA7DAhziddY+sIYCuFCV9Hk8s/aEo5dHvc1K818LMA6hokF68n2gp4Lzf2jCLnylaBZvTmocb8RANA26NoBDNM6F7096bQnU2IutESwNlBqAULz0qPKKKnDtdjpGmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=sdazmD5x; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-87c09672708so17079439f.3
        for <bpf@vger.kernel.org>; Fri, 01 Aug 2025 09:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1754065910; x=1754670710; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dmze8JSbkhnZOjJ2MGDZak6RjJrqfUwPzsMaderEcdU=;
        b=sdazmD5x+WmM4rYDCEqxyJqvbaGGSLazllDchFQ/0Wx0s9kg3ZfXjDA03m+w7NGOEW
         2JugTxA4Dwd+A5l/WuBaVa+Mq/CosiMpxP4NnXwMi3fLk1w+IwLCD2wPvjYBPVYy4RwB
         +5VPi8qP5TsRG0SIVfY95FtURq9LrC7IwE6odyho2xYfElae865uvRfrga9GvGWhtEHS
         zC6zqUpSUHeiOMzp46R1k1LTYQ1R7X5Ec876NdHZY0HR79GQUYVQoUdWoO0WQ+Et5Ckk
         J0BDNQKq54t9hvxDMq5+DareeDXBJ6cOTkuhb6sHbtM8QDqSnN0NGDRa3TEjEozBhvxv
         Lt4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754065910; x=1754670710;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Dmze8JSbkhnZOjJ2MGDZak6RjJrqfUwPzsMaderEcdU=;
        b=dvOoqMSY7X+PqL9Aqu2mx5IS9Aoi8mJJTRE/pk8YmxJer0ze2IKAPD37QO1n9VuowZ
         LIYA8uhOXXAnyVu8/TlVsJOLOschnsLKKy9OXHEqPNZy64ea/7rpUdqi2t+NpLzeTrKA
         9udmPvrbi3aah3vR1aU8zGfSyhzC0S2znaEuPj3N5f7YCab1VVddiHMPDF02xdEr2wX0
         MYUU4gUBzqy+w1MXKlmF3r1IQWf663luTpfD3hVV7tcqKF1t8RT9SeGAVJJ1+DiuRMhb
         XkM0VXNv2A3lGFOIUWPt6MgG2CaZNtBxBVEkNTSjvFPiR9filRjK5Y8+/u//MFmWJfDz
         JfZA==
X-Gm-Message-State: AOJu0YzTeAJRs+ENeYVdB66Yg9K6edgcTbgT5v4zzAOkhs6AeWps2B/0
	pUjF9lPWrMTQRHMDymqq1IsbILZT1n08AdlAMxdS4ElXETen/zgKn7K8Awz3xN79fNQ=
X-Gm-Gg: ASbGncviRx2wTX+0xt20WsWVJcdfHjsH1oeezNYkACbxiZ0j0O3ja47uFJwSEhOIP5g
	p8WzhYaz8Zi5eks9EMwKCtJDrGrelcr+6UXk31OsE9IqMrUex4Cje5fHGDowMZvmEcltxGTEmGb
	orvZccdI+IkVf3m3cNB339LVytsmudkPzlBWiuTZ17iPX9aNSwTMhYbRvBg3HfemqXb6I5mBTLt
	TnrN10LNOj45QouMDB6FmGMj6Qk00Ck9r3lYkMKr7VflzL8nUn9QaScMhSiy6elBQLIYw7l2hzg
	kb9E8kk2A9zF91fNbRm0As93H4JyFOXkazOiUV84HYMRLzM0jOru35v26NlykotLjI48oSw5SkV
	enKDeqOZ5nZZRhq8BvQ==
X-Google-Smtp-Source: AGHT+IH/Kh7/mkL0Tt6+UNLWcBElFJw8/hHxPE2lY1Z918yM1IGVUgyZ114xF7oqCq2jdC0X9PJJgQ==
X-Received: by 2002:a05:6602:4818:b0:875:d675:55f2 with SMTP id ca18e2360f4ac-88168344737mr18187439f.7.1754065910405;
        Fri, 01 Aug 2025 09:31:50 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8814defb6ddsm131712439f.12.2025.08.01.09.31.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 09:31:49 -0700 (PDT)
Message-ID: <97100307-8297-45b2-8f0b-d3b7ef109805@kernel.dk>
Date: Fri, 1 Aug 2025 10:31:48 -0600
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>
Cc: "open list:XDP SOCKETS (AF_XDP)" <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: bpf leaking memory
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Current -git (any within the last day or two) leaks memory at boot,
as reported by kmemleak, see below. This is running debian unstable
on aarc64.

unreferenced object 0xffff0000c820d000 (size 64):
  comm "systemd", pid 1, jiffies 4294667980
  hex dump (first 32 bytes):
    01 00 00 00 00 00 ff ff 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 84021ac):
    kmemleak_alloc+0x3c/0x50
    __kmalloc_node_track_caller_noprof+0x370/0x500
    krealloc_noprof+0x238/0x300
    kvrealloc_noprof+0x44/0x100
    do_check_common+0x2668/0x2d50
    bpf_check+0x2464/0x2ec0
    bpf_prog_load+0x5c8/0xba8
    __sys_bpf+0x9c0/0x20a0
    __arm64_sys_bpf+0x24/0x60
    invoke_syscall.constprop.0+0x44/0x100
    el0_svc_common.constprop.0+0x3c/0xe0
    do_el0_svc+0x20/0x30
    el0_svc+0x30/0xe0
    el0t_64_sync_handler+0x98/0xe0
    el0t_64_sync+0x170/0x178
unreferenced object 0xffff0000c8ccd900 (size 64):
  comm "systemd", pid 1, jiffies 4294667983
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 8e80d088):
    kmemleak_alloc+0x3c/0x50
    __kmalloc_node_track_caller_noprof+0x370/0x500
    krealloc_noprof+0x238/0x300
    kvrealloc_noprof+0x44/0x100
    do_check_common+0x2668/0x2d50
    bpf_check+0x2464/0x2ec0
    bpf_prog_load+0x5c8/0xba8
    __sys_bpf+0x9c0/0x20a0
    __arm64_sys_bpf+0x24/0x60
    invoke_syscall.constprop.0+0x44/0x100
    el0_svc_common.constprop.0+0x3c/0xe0
    do_el0_svc+0x20/0x30
    el0_svc+0x30/0xe0
    el0t_64_sync_handler+0x98/0xe0
    el0t_64_sync+0x170/0x178
unreferenced object 0xffff0000c8fc0300 (size 64):
  comm "systemd", pid 1, jiffies 4294668000
  hex dump (first 32 bytes):
    01 00 00 00 29 00 00 20 00 00 00 00 00 00 00 00  ....).. ........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 335bd269):
    kmemleak_alloc+0x3c/0x50
    __kmalloc_node_track_caller_noprof+0x370/0x500
    krealloc_noprof+0x238/0x300
    kvrealloc_noprof+0x44/0x100
    do_check_common+0x2668/0x2d50
    bpf_check+0x2464/0x2ec0
    bpf_prog_load+0x5c8/0xba8
    __sys_bpf+0x9c0/0x20a0
    __arm64_sys_bpf+0x24/0x60
    invoke_syscall.constprop.0+0x44/0x100
    el0_svc_common.constprop.0+0x3c/0xe0
    do_el0_svc+0x20/0x30
    el0_svc+0x30/0xe0
    el0t_64_sync_handler+0x98/0xe0
    el0t_64_sync+0x170/0x178
unreferenced object 0xffff0000c8c84980 (size 64):
  comm "systemd", pid 1, jiffies 4294668003
  hex dump (first 32 bytes):
    01 00 00 00 23 00 00 00 00 00 00 00 00 00 00 00  ....#...........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 3cc2e52e):
    kmemleak_alloc+0x3c/0x50
    __kmalloc_node_track_caller_noprof+0x370/0x500
    krealloc_noprof+0x238/0x300
    kvrealloc_noprof+0x44/0x100
    do_check_common+0x2668/0x2d50
    bpf_check+0x2464/0x2ec0
    bpf_prog_load+0x5c8/0xba8
    __sys_bpf+0x9c0/0x20a0
    __arm64_sys_bpf+0x24/0x60
    invoke_syscall.constprop.0+0x44/0x100
    el0_svc_common.constprop.0+0x3c/0xe0
    do_el0_svc+0x20/0x30
    el0_svc+0x30/0xe0
    el0t_64_sync_handler+0x98/0xe0
    el0t_64_sync+0x170/0x178

-- 
Jens Axboe



