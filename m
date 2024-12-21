Return-Path: <bpf+bounces-47521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 225219F9F0E
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 08:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2303C188C167
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 07:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E491EC4D5;
	Sat, 21 Dec 2024 07:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="CtdJKTsk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914441EBFE4
	for <bpf@vger.kernel.org>; Sat, 21 Dec 2024 07:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734765851; cv=none; b=CSyAXb7I5w11FnB6dUU9k8bJnN35X84Pb4MYFXNuTroiGaZUiQYrQcW2dGCu1eN0X/rpBcZpgPnIxFUGd9WE4EWOPY59LFEFPdWBux7fUQP/MjFa0aZFbU4DoDkNlkRe7pnuriL1F9f8tpOr/0CsOylZSBiCkmPKRYH3YtWp6SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734765851; c=relaxed/simple;
	bh=vk60omweXjX6SnQqQJyR2j+N9Ja1OJHyKZkcgTBw5QM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BJMHqTNoCV3jj9SE3nH/OUUAue8ZnRlf1QxiUXd6ojEonQV3YFuqtm5UttBq9ydNz/TX9kACDy5EyXFx/k1l85Ms5l0Qunt6cQVXjJk5HZgf7v986nsv0gdm3E3otycdbrwiSgnUMRV16AJXNG4ZPNFmVqCja2asrKg0aM+ZnWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=CtdJKTsk; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4361fe642ddso26502215e9.2
        for <bpf@vger.kernel.org>; Fri, 20 Dec 2024 23:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1734765848; x=1735370648; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EGEFp1KPbeLDL94qhspE2PUo2l278kl6WFBceVcNGBk=;
        b=CtdJKTskldDvq1OcpJLXi0jtnZST9yDZsoanwgEeXwTwKiWhCbiLZ4HovZlRi7Bhba
         lMdPxXOjWnGq0ekwc6EtOUbzWny1HhXPW+erVnutQexsTxyAA6k4Cst6VX2v5BktHOZM
         /wCwIMIGVnCrd4ZxlzklWhug8Np4vnFDlrcJ6oSqF3ANtjpWzh2VUUvy8wSWyszNz7WU
         a27ng33jAAiThyKN/WhS/PCx6yeuSHlxgfWuRO5DDdotoYuaLRrC9Jvgk/HmQUnZvHfX
         8xA2/xHzdNi6XUPHPq3u5GQh2W7sn6upIvCW35nm10BhoQTzvPhQPX0eHc8fpnhqJMsz
         2svw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734765848; x=1735370648;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EGEFp1KPbeLDL94qhspE2PUo2l278kl6WFBceVcNGBk=;
        b=Xf6zUV1JzlL+zqKrUK4mr/TiiwLe+F6/QKO7ZcQ/HwN/bC04SxFghq/Osygi5MOg/f
         hm5kuxOK5CgGFl/Sq5BJ6ilVf9DTAe3U/xR9GheBFAlOUQ1g60JXpc/7W9FBRZ+//mKh
         89Au577hV95mDv6ONiUnG6O+N8h8MjHPftDaeWNLsbBnt6/j7Z0ieftWAwPdMM7B4RCM
         yNivcEu0LBQrFRghr4IcMDX7BSgSxUIO7hID+Zm2ff1XKybKTGC4jfR+qMvUkt1f6ey0
         rv2iECLVEUKWBD/WQJYdpZ93qBB3T36hXh8/R4OaaSmSguySS7boV+TI5hxkISmw9XG9
         37Kg==
X-Forwarded-Encrypted: i=1; AJvYcCX2Sa9Cz25oM1kXN4Z/WbJ9+YSuQxHI10TenHFxwGwIABCiClXBoB20U/ilLEgb/Ip1wf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgTAlESty0N3erL+wYu1L/GPku3r0r0kCbmPEPuwzZQsGwq6bn
	5RBTh5OPIHNmtQ2UTZGgWTsYUv+Q7KpdRS6ZScZtUDW03oObqUuwgNXLKx2VaO0=
X-Gm-Gg: ASbGnctTYC4ssk+569IeDKK6cevfVQHNC79gD5QEOpQpwbj/e05pj90aDtHfV4izQfL
	7ImKLJSej3LITuRhwwUik3pgdSDCA5bXE5e/dDtc98tXhLo6Y0qL9BjURVLpQsbLz2pz1kwhpnC
	W+UzyrN6S1nJR0+1m9OhzIIkbc5UcCZ1+6v5mFR/+yciSnwBO4iE3XCQnsrkBJ5IJ7rVQ7K6MvK
	M3KBMGQaprtu2V8hGH6HTejEHqBXD0bpXLSd4+WXJ6Ag2Z5Q2jdDcyIGiVSbqhCl0OeANxraTlQ
	ggp80HYIrn/z
X-Google-Smtp-Source: AGHT+IFK4C/XgshfBwOKq/NkUSSIx04Y0eC4xtK3xybQdj6GwzPmOY1eORzQR2obtBLIIkIuUgUzlQ==
X-Received: by 2002:a05:600c:6b64:b0:436:469f:2210 with SMTP id 5b1f17b1804b1-43668548aa7mr37920275e9.1.1734765847845;
        Fri, 20 Dec 2024 23:24:07 -0800 (PST)
Received: from [192.168.0.123] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436611ea3d5sm68543305e9.5.2024.12.20.23.24.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 23:24:07 -0800 (PST)
Message-ID: <f1652194-13cf-4304-a81a-a3de91d4b839@blackwall.org>
Date: Sat, 21 Dec 2024 09:24:06 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 3/3] selftests/bpf: Extend netkit tests to
 validate set {head,tail}room
To: Daniel Borkmann <daniel@iogearbox.net>, martin.lau@linux.dev
Cc: pabeni@redhat.com, kuba@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20241220234658.490686-1-daniel@iogearbox.net>
 <20241220234658.490686-3-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241220234658.490686-3-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/21/24 01:46, Daniel Borkmann wrote:
> Extend the netkit selftests to specify and validate the {head,tail}room
> on the netdevice:
> 
>   # ./vmtest.sh -- ./test_progs -t netkit
>   [...]
>   ./test_progs -t netkit
>   [    1.174147] bpf_testmod: loading out-of-tree module taints kernel.
>   [    1.174585] bpf_testmod: module verification failed: signature and/or required key missing - tainting kernel
>   [    1.422307] tsc: Refined TSC clocksource calibration: 3407.983 MHz
>   [    1.424511] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x311fc3e5084, max_idle_ns: 440795359833 ns
>   [    1.428092] clocksource: Switched to clocksource tsc
>   #363     tc_netkit_basic:OK
>   #364     tc_netkit_device:OK
>   #365     tc_netkit_multi_links:OK
>   #366     tc_netkit_multi_opts:OK
>   #367     tc_netkit_neigh_links:OK
>   #368     tc_netkit_pkt_type:OK
>   #369     tc_netkit_scrub:OK
>   Summary: 7/0 PASSED, 0 SKIPPED, 0 FAILED
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> ---
>   v2:
>     - Rework to pass flags to create_netkit
> 
>  .../selftests/bpf/prog_tests/tc_netkit.c      | 49 ++++++++++++-------
>  .../selftests/bpf/progs/test_tc_link.c        | 15 ++++++
>  2 files changed, 46 insertions(+), 18 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


