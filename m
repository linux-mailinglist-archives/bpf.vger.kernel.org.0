Return-Path: <bpf+bounces-40797-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECB298E631
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 00:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 419201C21D30
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 22:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4ED619D063;
	Wed,  2 Oct 2024 22:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gUchvAEH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB03819ABB7
	for <bpf@vger.kernel.org>; Wed,  2 Oct 2024 22:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727908999; cv=none; b=o6FZcpzLc7gQanIDmKutOL+hl0CIgvJ8dKfBXcf6adCzAQ+HOhJBFpvhCOHfJgxALshJBfYcjLwSAk4UJqbQp8RVWF9gbG9fsENtEPTCKQShiJJWOt65C53XX66u8YWYUMBxk9uab2zxBIH6zpCi/zwB1CWOqXFcL2TZsuP8tlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727908999; c=relaxed/simple;
	bh=j6t8tk7Z//+2Is6i3VUUm0aYAVTeRD5a2UMG2eI0ATY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=au961aX1wxDPDW1f58kjgbSLKf4EgRtGsBp4HtZ7txFnzo4zHyM4Y+QfgbQt3TPaxk+aRPLmpoN7MvY7KewXnS6/GUTdfFQV8ktyErJ1ktwYmDxMGLL+Bhj5YiAEyHuPnBg4ZI8jBVzNrIjqAHKeCOsvbMHaHEV6s/0/C2LsPCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gUchvAEH; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-82ce603d8b5so17140739f.0
        for <bpf@vger.kernel.org>; Wed, 02 Oct 2024 15:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727908996; x=1728513796; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x3ilwW6cK4QI7nkKPfL57rY6tVRa1T4n8ruZSd7gO4c=;
        b=gUchvAEHJSH0hLbv3OtCwqew2nqDy9GLdhWArdnNmGO0eos8j/p1a6+iNRh90nvhb0
         e96QEinpPBagoDMvI2O5ioG2188zpfOz++N9k+/z62XJKsY9344uOJO67RPrycNjOGBt
         mkjj8TM14u30zm5au5TJEskki7oaTIlBPED3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727908996; x=1728513796;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x3ilwW6cK4QI7nkKPfL57rY6tVRa1T4n8ruZSd7gO4c=;
        b=sdtx97lfrcIXr1rkPHQkzdEVSO3CUVRc1yyhNnbo4XhvDOrEM1Er56RiH2D/9Qd8ig
         FtQbiTqNu7NWsWhIB1+2ercQ+uloHeycl3U7zyXOKmvkyZtdFn05Z3Cr7CSmQ+FJJ7Tf
         vMkDv6vuFV5vTul1BKmNVOhdozuARZeqP9GHjq3IStLLOd1u4uZp5VNxRFX1outgFKtP
         enATy1p6UT38f29+gAkmyxUQlUUz0hMkjlMhd1uEpdfy7rv7sLcQJu/qGwyVuPqTdtCk
         FlHZHslUv/ko0kuRxJF1p3NfQ6mRTJQXOmIE7ujjgQyoO25irqlV5fql24K9l+9tCKlT
         jwgg==
X-Forwarded-Encrypted: i=1; AJvYcCXZNjoBCQygOXGAwWBEd1ER+NvR3oQzDBpMQjKJujjjCXVPFjKDxX9zZKn7HJ+us+vZWTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrxwJM6TBTYR5sAeUqGr5RrC2J4obVsfmN5kCV9DS2T1uAnw/n
	dQakANs37bGlRdZX7mBPDAblZ8/xWDgW+EVww7LCu/rY3M+G5EnsqESCRITQ0qU=
X-Google-Smtp-Source: AGHT+IG7ncSQ5cx0L4TiFYzd75wjkYvgQW/jpvx2/bj9FPfBqI0KRbv1UTT6Cok8YzgBkusExy0uDQ==
X-Received: by 2002:a05:6602:601b:b0:82c:967b:6f96 with SMTP id ca18e2360f4ac-834d8411337mr547748739f.8.1727908996579;
        Wed, 02 Oct 2024 15:43:16 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-834936b4e97sm350364539f.6.2024.10.02.15.43.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 15:43:16 -0700 (PDT)
Message-ID: <1fd8fd72-2439-4497-a18a-fdc06628eb1e@linuxfoundation.org>
Date: Wed, 2 Oct 2024 16:43:14 -0600
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH HID v3 0/9] HID: bpf: add a new hook to control
 hid-generic
To: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 Peter Hutterer <peter.hutterer@who-t.net>, Vicki Pfau <vi@endrift.com>,
 Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241001-hid-bpf-hid-generic-v3-0-2ef1019468df@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241001-hid-bpf-hid-generic-v3-0-2ef1019468df@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/1/24 08:30, Benjamin Tissoires wrote:
> This is a slight change from the fundamentals of HID-BPF.
> In theory, HID-BPF is abstract to the kernel itself, and makes
> only changes at the HID level (through report descriptors or
> events emitted to/from the device).
> 
> However, we have seen a few use cases where HID-BPF might interact with
> the running kernel when the target device is already handled by a
> specific device.
> 
> For example, the XP-Pen/Huion/UC-Logic tablets are handled by
> hid-uclogic but this driver is also doing a report descriptor fixup
> without checking if the device has already been fixed by HID-BPF.
> 
> In the same way, another recent example[0] was when a cheap foot pedal is
> used and tricks iPhones and Windows machines by presenting itself as a
> known Apple wireless keyboard. The problem is that this fake keyboard is
> not presenting a compatible report descriptor and hid-core merges all
> device nodes together making libinput ignore the keyboard part for
> historical reasons.
> 
> This series aims at tackling this problem:
> - first, we promote hid_bpf_report_descriptor_fixup to be called before
>    any driver is even matched for the device
> - then we allow hdev->quirks to be written during report_fixup and add a
>    new quirk to force hid-core to ignore any non hid-generic driver.
> 
> Basically, it means that when we insert a BPF program to fix a device,
> we can force hid-generic to handle the device, and thus preventing
> any other kernel driver to tamper with our device.
> 
> This branch is on top of the for-6.12/upstream-fixes branch of hid.git.
> 
> [0] https://gitlab.freedesktop.org/libinput/libinput/-/issues/1014
> 
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> ---
> Changes in v3:
> - dropped the last 2 patches with hid-input control, as I'm not 100%
>    sure of it
> - changed the first patch to avoid a double free on cleanup of a device
>    when a HID-BPF program was attached
> - kept Peter's rev-by for all but patches 1 and 6
> - Link to v2: https://lore.kernel.org/r/20240910-hid-bpf-hid-generic-v2-0-083dfc189e97@kernel.org
> 

>        HID: bpf: move HID-BPF report descriptor fixup earlier
>        HID: core: save one kmemdup during .probe()
>        HID: core: remove one more kmemdup on .probe()
>        HID: bpf: allow write access to quirks field in struct hid_device
>        selftests/hid: add dependency on hid_common.h
>        selftests/hid: cleanup C tests by adding a common struct uhid_device
>        selftests/hid: allow to parametrize bus/vid/pid/rdesc on the test device
>        HID: add per device quirk to force bind to hid-generic
>        selftests/hid: add test for assigning a given device to hid-generic

> 
>   drivers/hid/bpf/hid_bpf_dispatch.c                 |   9 +-
>   drivers/hid/bpf/hid_bpf_struct_ops.c               |   1 +
>   drivers/hid/hid-core.c                             |  84 +++++++++---
>   drivers/hid/hid-generic.c                          |   3 +
>   include/linux/hid.h                                |  20 +--
>   include/linux/hid_bpf.h                            |  11 +-
>   tools/testing/selftests/hid/Makefile               |   2 +-
>   tools/testing/selftests/hid/hid_bpf.c              | 151 ++++++++++++++-------
>   tools/testing/selftests/hid/hid_common.h           | 112 ++++++++++-----
>   tools/testing/selftests/hid/hidraw.c               |  36 ++---
>   tools/testing/selftests/hid/progs/hid.c            |  12 ++
>   .../testing/selftests/hid/progs/hid_bpf_helpers.h  |   6 +-
>   12 files changed, 296 insertions(+), 151 deletions(-)

I am assuming selftests go with the driver changes.
For selftests:

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

