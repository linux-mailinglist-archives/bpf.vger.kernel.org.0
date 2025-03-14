Return-Path: <bpf+bounces-54046-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19569A60EA8
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 11:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39AF446115F
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 10:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711611F4161;
	Fri, 14 Mar 2025 10:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="XhotPjCt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9211EB5D4
	for <bpf@vger.kernel.org>; Fri, 14 Mar 2025 10:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741947774; cv=none; b=pMue7HnY/QYTM2qwvItiITbiikILKhcrrUP0IrVFfNuW5UE4fQ9Y5Euwh+RbAuJIvLvwHeubzaxAD/S7RgUbXO4GLRbkr0943L1A+gUu4qfF4yHu6sEkCd9MKlrYZrO+Q6VdxIXfCSnuD431TY962Rsa6LEu7g3Iz/dRMX6A0e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741947774; c=relaxed/simple;
	bh=MbdRv+iM89FnZKw451+VGkit0JczZSSrCCsWB6ggDHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=unOP0pFf3XFH8oTsoUy8hHdOeipdmQCtV9BtfqMXcAdEMICmqniyVAOMjI8GxBfEesGXZvjKp06Qj5h3y1vvhTg+PKoNLH/e3m3f2FNzw4PzFkj67CXBLMxOeuvOhg9xM0tf7iZHR+mUr+yF5BXntAyLs24jVRFoGfu/aUD47OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=XhotPjCt; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-ac2ab99e16eso401084066b.0
        for <bpf@vger.kernel.org>; Fri, 14 Mar 2025 03:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1741947770; x=1742552570; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WLC14bT7l5qVe9L1a3up7gLBRmwJJU5Zq8l66jxt7TQ=;
        b=XhotPjCtFrrkvpxaJbXNGbFVj2zrV24A5/UMXkO+qCweMi6RqSJTI3nTz9E3pkpxkL
         sQG3oMV8xV61qP3oL6uXPtfsatrt0Hn62gRWFcZaWpGY6eDzhs35swUJVES7W2To6DvB
         ovWaS/GAjHmMGx5OYRr5WL7gZgsza8nh2w61FT2WTViUdN3nFOpFzDXftlmLV44C0I1Y
         ku4049pvwKlTRtQUDBBgvi7um3k8i32r6v3RqkCEin72Z6o9bO/PvMo4wnDWItOfH6nU
         kLEZBzpwthjfdxrqHXL3PrIWwXeHUaZopxJ12bDPTzP3psN1/ICsWv66AxuORESaNTSs
         OqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741947770; x=1742552570;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WLC14bT7l5qVe9L1a3up7gLBRmwJJU5Zq8l66jxt7TQ=;
        b=Y6Zo2dEXsiO7ocjFpNlc5O1aPMrOhyorF3css1x/ag8921haM24iGkk1TcyibEywjZ
         41SqbSWEPaG37rd4mpcAVBfnvTo07h3yeKs5wRmyLF9Goz/c8Jw/ccxsnT7e5qOomXeG
         UB3ZR1T5K3a/+ssnFSoXELMjSGCjCXUvNGwuLMamHrzuZZ/NQP0f8lLSCH9BpX3ptyfh
         N4HXLeYSJVNquNZiiVaxw6DvMD/O4qpZWJ1NHp9MdcUdGIA4xirMpuBvF1X6Q7AMgmQO
         fg9wkx+k0Xl0cxKlh6T8L8R26f5WnX9ex+pV8/ERGdHptPr5eVG0OIfGdTP521vef37L
         mc4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVm4oeFsEnmM9JqCEOvywG0OsDQtW4+YvM6G4RAhgcOdJxpt0vjtCtAeRvtvFacwTeAXIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM5fQhY4qwzgECiCGNKdtwKPXtlNP9/RkoY1QhXTNRk9yqx8nR
	BAkbT2d70bx0d2QBSRSztBXtQMq+C0gj9oJMxK4x7cz+0GeTLM9+jB6VcjwY/XE=
X-Gm-Gg: ASbGncuOOzGFisxNSootHuOpfSyqrbtkHC/sTrFXQRXBPimJPJ+MJOfQt3LKu5FsJdO
	553S5yarzAqzZArGFKeIIjEA+zohBq/X2iL+oBduNV5Q9EFNpA8i9s6GXfIiAd1qnXH5tNqnwGJ
	MwJtu8LnPpwretOD7h2NG6cPtJ3ONYF6aYOrrfmOe2lkXtZlsWGb2Sqw+ucPWVlajfT/RI6mChU
	BrdEBY2VSB9R5z/wdAuEtvEZ7swS63fAdZ5hXP9nPrdJq4+Xm9TBxT4XM6na+KrZMvU6gjACbPT
	Yp1xPSAGLPHgPOtBHiPwleNkUzvcZfe+XkOxIW9Wxb8uUkoewlYj9Zsz
X-Google-Smtp-Source: AGHT+IEtf+5uMhZHeMpuNHp44VDObLkwKhS755JgMPyzBh3Tkne5oU6MDvaxu9uSs1lL4nigwL2EYA==
X-Received: by 2002:a17:906:c10d:b0:ac2:9210:d96e with SMTP id a640c23a62f3a-ac3304412b9mr190659866b.43.1741947769542;
        Fri, 14 Mar 2025 03:22:49 -0700 (PDT)
Received: from [10.20.7.108] ([195.29.209.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a9db94sm209442666b.171.2025.03.14.03.22.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 03:22:49 -0700 (PDT)
Message-ID: <21d52659-622a-4b2a-b091-787bf0f5d67f@blackwall.org>
Date: Fri, 14 Mar 2025 12:22:47 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bonding: check xdp prog when set bond mode
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Wang Liang <wangliang74@huawei.com>, jv@jvosburgh.net,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, joamaki@gmail.com
Cc: yuehaibing@huawei.com, zhangchangzhong@huawei.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20250314073549.1030998-1-wangliang74@huawei.com>
 <87y0x7rkck.fsf@toke.dk>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <87y0x7rkck.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/14/25 12:13 PM, Toke Høiland-Jørgensen wrote:
> Wang Liang <wangliang74@huawei.com> writes:
> 
>> Following operations can trigger a warning[1]:
>>
>>     ip netns add ns1
>>     ip netns exec ns1 ip link add bond0 type bond mode balance-rr
>>     ip netns exec ns1 ip link set dev bond0 xdp obj af_xdp_kern.o sec xdp
>>     ip netns exec ns1 ip link set bond0 type bond mode broadcast
>>     ip netns del ns1
>>
>> When delete the namespace, dev_xdp_uninstall() is called to remove xdp
>> program on bond dev, and bond_xdp_set() will check the bond mode. If bond
>> mode is changed after attaching xdp program, the warning may occur.
>>
>> Some bond modes (broadcast, etc.) do not support native xdp. Set bond mode
>> with xdp program attached is not good. Add check for xdp program when set
>> bond mode.
>>
>>     [1]
>>     ------------[ cut here ]------------
>>     WARNING: CPU: 0 PID: 11 at net/core/dev.c:9912 unregister_netdevice_many_notify+0x8d9/0x930
>>     Modules linked in:
>>     CPU: 0 UID: 0 PID: 11 Comm: kworker/u4:0 Not tainted 6.14.0-rc4 #107
>>     Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
>>     Workqueue: netns cleanup_net
>>     RIP: 0010:unregister_netdevice_many_notify+0x8d9/0x930
>>     Code: 00 00 48 c7 c6 6f e3 a2 82 48 c7 c7 d0 b3 96 82 e8 9c 10 3e ...
>>     RSP: 0018:ffffc90000063d80 EFLAGS: 00000282
>>     RAX: 00000000ffffffa1 RBX: ffff888004959000 RCX: 00000000ffffdfff
>>     RDX: 0000000000000000 RSI: 00000000ffffffea RDI: ffffc90000063b48
>>     RBP: ffffc90000063e28 R08: ffffffff82d39b28 R09: 0000000000009ffb
>>     R10: 0000000000000175 R11: ffffffff82d09b40 R12: ffff8880049598e8
>>     R13: 0000000000000001 R14: dead000000000100 R15: ffffc90000045000
>>     FS:  0000000000000000(0000) GS:ffff888007a00000(0000) knlGS:0000000000000000
>>     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>     CR2: 000000000d406b60 CR3: 000000000483e000 CR4: 00000000000006f0
>>     Call Trace:
>>      <TASK>
>>      ? __warn+0x83/0x130
>>      ? unregister_netdevice_many_notify+0x8d9/0x930
>>      ? report_bug+0x18e/0x1a0
>>      ? handle_bug+0x54/0x90
>>      ? exc_invalid_op+0x18/0x70
>>      ? asm_exc_invalid_op+0x1a/0x20
>>      ? unregister_netdevice_many_notify+0x8d9/0x930
>>      ? bond_net_exit_batch_rtnl+0x5c/0x90
>>      cleanup_net+0x237/0x3d0
>>      process_one_work+0x163/0x390
>>      worker_thread+0x293/0x3b0
>>      ? __pfx_worker_thread+0x10/0x10
>>      kthread+0xec/0x1e0
>>      ? __pfx_kthread+0x10/0x10
>>      ? __pfx_kthread+0x10/0x10
>>      ret_from_fork+0x2f/0x50
>>      ? __pfx_kthread+0x10/0x10
>>      ret_from_fork_asm+0x1a/0x30
>>      </TASK>
>>     ---[ end trace 0000000000000000 ]---
>>
>> Fixes: 9e2ee5c7e7c3 ("net, bonding: Add XDP support to the bonding driver")
>> Signed-off-by: Wang Liang <wangliang74@huawei.com>
>> ---
>>  drivers/net/bonding/bond_options.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
>> index 327b6ecdc77e..127181866829 100644
>> --- a/drivers/net/bonding/bond_options.c
>> +++ b/drivers/net/bonding/bond_options.c
>> @@ -868,6 +868,9 @@ static bool bond_set_xfrm_features(struct bonding *bond)
>>  static int bond_option_mode_set(struct bonding *bond,
>>  				const struct bond_opt_value *newval)
>>  {
>> +	if (bond->xdp_prog)
>> +		return -EOPNOTSUPP;
>> +
> 
> Should we allow changing as long as the new mode also supports XDP?
> 
> -Toke
> 
> 

+1
I think we should allow it, the best way probably is to add a new
BOND_VALFLAG_XDP_UNSUPP (for example) as a bond option flag and to set
it in bond_options.c for each mode that doesn't support XDP, then you
can do the check in a generic way (for any option) in
bond_opt_check_deps. Any bond option that can't be changed with XDP prog
should have that flag set.

Cheers,
 Nik


