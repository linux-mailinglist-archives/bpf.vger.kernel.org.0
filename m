Return-Path: <bpf+bounces-58839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA7FAC273D
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 18:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B18D43B5B5E
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 16:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23102951CE;
	Fri, 23 May 2025 16:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLjsKwyA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B4828382
	for <bpf@vger.kernel.org>; Fri, 23 May 2025 16:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748016615; cv=none; b=PsJKWVrmx8Ojy1zDBSifU1ZTwcqqywW3IogXHQqNlhBdqxHCkPzEaeDNkqOz3qOKRcpS1KrRQaC6IpnhONi1DiKOkA9+7U3mklVbRneuw6wrCA1bl4N29sFR2rp7qCXnISQNSVmU1gdjTBPDO3PPtNxaHketcUwio9Az2lzzK8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748016615; c=relaxed/simple;
	bh=MdeTd3rM5HYiFRxlMhSjPgfVKtSw6Na/CQf4bqhqu6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OSHNFF25QZtS7P7AbKt5LMu05ODiy0KmTluAZv97uTpL9uE3ja1+h3QLS+OnTKP3u3f3pes+9C7me6MHefuFKOVGvuDvSAirtz/VvW7rFH+R8X1lmuka0KJO9rfZGvMXC7paenlRtUS4DcbcEhKnGti3VEXmbi7W5XXgKh4ISVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WLjsKwyA; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a3758b122cso68777f8f.1
        for <bpf@vger.kernel.org>; Fri, 23 May 2025 09:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748016612; x=1748621412; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VpR78bX5KRC1E+HA7mDO7S7Abkj6lrGgctHHVM3OZ5U=;
        b=WLjsKwyATE5fwBJSs3ZBJrQF29Ap0VC+Y9Nn27+qFEXsQcx/suUvJuASNxcsm2llZb
         uMxPhoqLf2R8dYAOVHQL/1Qeie/+vR5WHXmt+UrhfwR9Z5BLobXcQ9NjkfvAu3FTwNvW
         cMMXAiy+W+ZuYMws/wGQWUElo5OyD3K1pYqzH/SiHcW5u2w+5RGpNzJ0E+Xg+i5XmhVK
         7zCdba6Wvh4tpql3gKtBu6UKz8YR36L4ailRIjWnU3TDOY7GS43UscEQ9w/L11XRKp/r
         BfGudOKXCzdGe8MZwVMEdmSQnNU0GSEo2+wmhpyqsiiBKRFzPdQM9H2OqLFji+LF4kQn
         Hn1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748016612; x=1748621412;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VpR78bX5KRC1E+HA7mDO7S7Abkj6lrGgctHHVM3OZ5U=;
        b=VWngafr243PP5Umq9raIbsaMr8oclomsx8UQHylnraTFr15YPQc/vD4Ro234OoukQG
         kgwb9Fskg5FhggaebRkJ+mCWILXxi33wfB3VgJhIl5UfY3/F1MI40MmdP1cNgOgXmbjv
         xhBYJJw9RdF6Y++6YU3qEzUE5mUIwCmf2ONMRhCWMO+CsPOMnrfeUfruDZ2mZlouDSgg
         l9bKLMf0P302HZHkg9cHpUdXCGaQa/i80kmWMpKWgEdP72uFQHvCAL/AxcvwJHLZLKjb
         YO9Tk2E65lsshXVnHVwn7tKLFWKagUE7HUniitUMn+0n1McTcGhUjd/r+z4WYIlXRtmN
         HWcw==
X-Gm-Message-State: AOJu0YzprFZ9D6lcdlS1r4nDirCM/jfQ68CCOQvbjlpkrnSdXtUINPbY
	bP73lY4EYwJsUErGHG0b2LhdP/977hHwyU54UfyksX6jisDIHzI2iORJ
X-Gm-Gg: ASbGncsCdnvyv/9/pGCdd3PUYDcWWALVm3Hl64MLEFiQh59uTbE+sLcvBbJWTMCpdHE
	wEG5x+sMReKF/j6VS0Omnv5xcy5H5VkPIDAAVOb1Lpk0wxLk8LkxgY0I/bj0kyZM+nKN2ApIILg
	mEqxtxeoNkavGQdW278Qk6hVtTf1zzAQy94GbLkfXTG5kX6OPHsTxDfA4yFEAZ11ap25s8AyHSV
	V3nT6A0vlE3ihhBfNSHr2qa1JusTLkvq1Hz+ifrE6ygWa11mxlnH7fFd/kkKm3VJdaRKs6ZayKv
	+gc/kjq/gZzZkU6oP6QhRW+XRZKm1Owk8aULxxBWHUSbd0bQt0HpE2d9+VOr9DOQNYww7zbmySk
	hKEqOIi85bt7LCGiYU2Hh6S1z51WW9klNgf3JL07yf7Q=
X-Google-Smtp-Source: AGHT+IHbDcGHSWIJF2lo3TkgGCW8T8c3oTlrGGleXNLZnu/DREGGf9Muq3axBUpAbLD86ceXr7c8CA==
X-Received: by 2002:a05:6000:25c8:b0:3a4:bfe2:87ca with SMTP id ffacd0b85a97d-3a4bfe28b4cmr6448855f8f.11.1748016611523;
        Fri, 23 May 2025 09:10:11 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10? ([2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d1fasm9185328f8f.1.2025.05.23.09.10.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 May 2025 09:10:11 -0700 (PDT)
Message-ID: <1d6a8908-01dd-4285-989c-0d7a6b4dbfd5@gmail.com>
Date: Fri, 23 May 2025 17:10:10 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] bpf: Implement dynptr copy kfuncs
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Mykyta Yatsenko <yatsenko@meta.com>
Cc: bpf@vger.kernel.org
References: <aDCbQq99EfNDI8xr@stanley.mountain>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <aDCbQq99EfNDI8xr@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/23/25 16:58, Dan Carpenter wrote:
> Hello Mykyta Yatsenko,
>
> Commit a498ee7576de ("bpf: Implement dynptr copy kfuncs") from May
> 12, 2025 (linux-next), leads to the following Smatch static checker
> warning:
>
> 	kernel/trace/bpf_trace.c:3557 copy_user_data_sleepable()
> 	warn: maybe return -EFAULT instead of the bytes remaining?
>
> kernel/trace/bpf_trace.c
>      3551 static __always_inline int copy_user_data_sleepable(void *dst, const void *unsafe_src,
>      3552                                                     u32 size, struct task_struct *tsk)
>      3553 {
>      3554         int ret;
>      3555
>      3556         if (!tsk) /* Read from the current task */
> --> 3557                 return copy_from_user(dst, (const void __user *)unsafe_src, size);
>
> I don't know if it matters what we return here so long as it's non-zero.
> This is probably a fast path so maybe we're returning positives
> intentionally?
>
>      3558
>      3559         ret = access_process_vm(tsk, (unsigned long)unsafe_src, dst, size, 0);
>      3560         if (ret != size)
>      3561                 return -EFAULT;
>      3562         return 0;
>      3563 }
>
> regards,
> dan carpenter
>
Hi, thanks for the report, I think the warning is right, let me send the 
fix a bit later today.

