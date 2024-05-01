Return-Path: <bpf+bounces-28412-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 061108B9198
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 00:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D881B21ED5
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 22:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53C0165FDA;
	Wed,  1 May 2024 22:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFCZgHu0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045CA165FD3
	for <bpf@vger.kernel.org>; Wed,  1 May 2024 22:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714601803; cv=none; b=RgzOE97BbCajb/3u4kkCiabnHFxq1n+pnYfft8QAZ8ZYUPF2WdQvfzE/4Ff0cxAdY982pyroVcRvL0pPk3n8SjQweiwOJC6i8NNl6P0u3TXpa6iFAyqrfMWUV5aRp5MR5XWpGqz8wOi4RkfrfBU8n0dyrP+npAf6IyuLy9yR6SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714601803; c=relaxed/simple;
	bh=iESVU2w+GAS6+wH1kBjWmBtZxItCbU8w9kexnJuuY6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bgF/035lGZpsJvKzHGNMBhHX9AJ5xzCrUpVpbCXaQEInJ1jfBnLLcldnbNwr719pSIoGU3DItTuP4rN3D+LtUjt3+9jYHtyqkJJRdqN566XDLwCd098Kvoz42N2y1BASp0QKK+xmpd89SHZThW60eXCesFqXGF8h9kyf+tLi5zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFCZgHu0; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c74fd6fb92so4656869b6e.3
        for <bpf@vger.kernel.org>; Wed, 01 May 2024 15:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714601801; x=1715206601; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V9JRPPGBf4cfDhmnmqofW9IoDydXekRrhWjClWvKl8Q=;
        b=hFCZgHu0Ah+cMlH6ap55tcsQPw3Hh8Yi82dbR6R6HvqK+jC/beq1v9UWcrZa1/FQTb
         lb2QHOqwg0GtyF8adrdKMFpRbxdL2Q5GJLpL4DjY7urCFccM/rRvIQgAuktsrQGIEsDh
         ISSrOk3EHH7Ma5MSxyrud//b+OzdeBf9/f+7qwFLoXRUR4UMfFJl19nC4KH7uOMfJ+fS
         gmv6FWB3SXuoDrNek7XCGzJp95w70MzUjwAngJWIo23AgrDp0AfRlUvCa724/HwiesYr
         EeuxsSzjjvW96gBYE/HYDl9Jtn1ddlbUD5BPBPWTDOn4rlp1U/s7/ITz18cMGlJp+6t9
         awTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714601801; x=1715206601;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V9JRPPGBf4cfDhmnmqofW9IoDydXekRrhWjClWvKl8Q=;
        b=fr7iyIvmkcvmS+gO1K16nx/H97++HdxCkRodZoSv4Jvcw1Hn1pZEkn0TlUYe8etu6A
         1UZtOtlCXiR/X+wnPQ7Pz+rfczyh4hwuYdBznh/OalQqleKiENOUTLCsX9quNDkpPTLw
         xcMg7IpJa+f6HNVdwq37FlbkDyuPUIxbMN6Kbcd6IYxVDPq8KmAQVpTvT02P5jg5xUOL
         g1kzQqa3ROvThG3nIXcAPDrnetyxn7ljLSkL9WOfLOBvp9HTA+K/E0IsaFNY0x/Km2JN
         aTGe57wtLZROCU1RQzSD1cMS4hMHmIS8weQaP3L17LEUP5z+nECMc56UpUIh2vov2Wm4
         Hi4g==
X-Gm-Message-State: AOJu0Yxcpshxr7Oa5sKnAqTuFthkDf9UpC7aHA1smNezaZCt61mqEQDb
	vxrCrQ7m/n6x36QQVxnP43N+M4t6J0MPv4rFJbTr5Vbsfu88BazS
X-Google-Smtp-Source: AGHT+IEk6PsDTRX6wPOUHU5h+lSC+S8rZLWD0PD4ZuOPR7eAiS+PFH6iPSnmosyClGv1vtSDbacI0w==
X-Received: by 2002:a05:6808:a8d:b0:3c5:e025:42f4 with SMTP id q13-20020a0568080a8d00b003c5e02542f4mr4128103oij.15.1714601801063;
        Wed, 01 May 2024 15:16:41 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:22b9:2301:860f:eff6? ([2600:1700:6cf8:1240:22b9:2301:860f:eff6])
        by smtp.gmail.com with ESMTPSA id ce13-20020a056808338d00b003c83725947csm2606854oib.9.2024.05.01.15.16.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 15:16:40 -0700 (PDT)
Message-ID: <f03f745e-d1e8-4506-bf12-62607e99001d@gmail.com>
Date: Wed, 1 May 2024 15:16:39 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 5/6] bpf: support epoll from bpf struct_ops
 links.
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org, kuifeng@meta.com
References: <20240429213609.487820-1-thinker.li@gmail.com>
 <20240429213609.487820-6-thinker.li@gmail.com>
 <CAEf4BzacheKXJRfnDimQYhqQzhPcMD9TEZBaT9mFqqKFK2B0BA@mail.gmail.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAEf4BzacheKXJRfnDimQYhqQzhPcMD9TEZBaT9mFqqKFK2B0BA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/1/24 10:03, Andrii Nakryiko wrote:
> On Mon, Apr 29, 2024 at 2:36 PM Kui-Feng Lee <thinker.li@gmail.com> wrote:
>>
>> Add epoll support to bpf struct_ops links to trigger EPOLLHUP event upon
>> detachment.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   include/linux/bpf.h         |  2 ++
>>   kernel/bpf/bpf_struct_ops.c | 14 ++++++++++++++
>>   kernel/bpf/syscall.c        | 15 +++++++++++++++
>>   3 files changed, 31 insertions(+)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index eeeed4b1bd32..a4550b927352 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -1574,6 +1574,7 @@ struct bpf_link {
>>          const struct bpf_link_ops *ops;
>>          struct bpf_prog *prog;
>>          struct work_struct work;
>> +       wait_queue_head_t wait_hup;
> 
> let's keep it struct_ops-specific, there is no need to pay for this
> for all existing BPF link types. We can always generalize later, if
> necessary.
> 
sure!

> pw-bot: cr
> 
> 
>>   };
>>
>>   struct bpf_link_ops {
>> @@ -1587,6 +1588,7 @@ struct bpf_link_ops {
>>                                struct bpf_link_info *info);
>>          int (*update_map)(struct bpf_link *link, struct bpf_map *new_map,
>>                            struct bpf_map *old_map);
>> +       __poll_t (*poll)(struct file *file, struct poll_table_struct *pts);
>>   };
>>
>>   struct bpf_tramp_link {
> 
> [...]

