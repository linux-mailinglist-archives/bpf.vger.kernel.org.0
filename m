Return-Path: <bpf+bounces-54166-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B522BA643E6
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 08:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56A15189380B
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 07:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73A021B1AA;
	Mon, 17 Mar 2025 07:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="BvUQEJKf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1821215046
	for <bpf@vger.kernel.org>; Mon, 17 Mar 2025 07:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742197156; cv=none; b=MbwdTjIBuwPsskddjljshCLhifu8OFiOEnhg3FenCru0oDByNLTI7dvuhO9H/kAh241YgQtNa+ZFiix54DD7u95F9UinI0M+hpqfh5J71tXejyTGm/DPQVsegIPLuN02XH1uC63pCvt4ja1KKU2Gz2XCUZLCXUi7J8DAHbcG08U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742197156; c=relaxed/simple;
	bh=Th8f45SOQCPR890tBRd7bDTWMo3bJcioqXxHTMd02+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NmiPzxdlGyxVg6pY9CcIwsTvOlf/0rA8cJu9m98qwA/lwRiSI9mjDuVnvrx38gXqVB1HtrGV89/QVrG1jkL2gnFLAwZkmiuk0TV4iVQhpDgATdg4MUHbjIKakaGsNkDqwGbmTkKXoE3blHuJYJiU+uhLKlKCcjAMGwcJAS541fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=BvUQEJKf; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso11575785e9.0
        for <bpf@vger.kernel.org>; Mon, 17 Mar 2025 00:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1742197152; x=1742801952; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WvL6YVUC/iLIzrgQ7ghXKRXq4PF6b66cA4hhiSylm1U=;
        b=BvUQEJKf2t4OFEs8T/vvLjLOZxJDAYxxyO2bb9fnK4I7PvIvgc1q2Mjp8fRn1x13Z+
         YAxPQ6B5Bv7Ae4ZWM2lSLQzrtjsYhNWsvfLe8t7ob6NGgriTxjMk5iFjOS4SxKeEm0P+
         tOzhuNNZ0AQucen62rjgyDheXziW4SLoUZQx7DV3EgQbGucuCqAz8gD1dz/NqPzxud5Q
         49qgBAui4oKZF2POEJ9QuUNW/D1kVUC47pAtPg5ku16fhhzdO2DS2c6L4WXJzWAgfr56
         FQr/I+7n0p0m2qr5VW8+HSfNaVsSoa4shmbIoUYUjhSWKv17xJSh6LRnJYdPoyV/x3oS
         7hRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742197152; x=1742801952;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WvL6YVUC/iLIzrgQ7ghXKRXq4PF6b66cA4hhiSylm1U=;
        b=GfYzM2w+gWgZAv/xWWLGOmEdENmUXamRdR7Iz+W+yX4tYnRjeAv+MVBBHvMkWolhm9
         omGEgWxjJ14rjrkcAPg1S6t0wifC9Uaem1v8df76Wi/vCwpYiCjc2+s+RL3qTVm9ItXa
         u77W7rfNl2RN5SKObVw08Cxlsn+Cn5URuuDwsUonwnHFP8DRYDJMuRIxV94GcfR9KjiG
         C1pkc3PyL+iSgnuvcTiyyOiX+Og8xS3b7lu1i+nDskjraJwrrWZrpwCGdek2DNqKZ2gU
         VbdH6CGc4BwpnKRbB+BGaG4kI74XS9QPwS382OczRnFGI6SSAOPQVR/MnxldtfGuhhcs
         6VVA==
X-Forwarded-Encrypted: i=1; AJvYcCWTaUd/sE1FA0+SM/gh7NXyAuEbO+tqz5TpAz9Uk0lrb7VSObhtz52SziCz3K0gVkv/ZQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvuhGw4Aw/khT11hoIYEYJNsbvM+jE94kfx34++xFif34EMpuh
	6Lq7P8779k+sGuX0JW8uIWIMZ4QvcpauVJgOgq+q7E3UfBS67zm9eWnrDF4fR4k=
X-Gm-Gg: ASbGnctLwIvLKW1R8JNSWXq9SKCy7+h1r6O57vHQkBlk5jtsEQXqzIx5fHkqMkiW8/N
	E38QrH2tcUK4Ims6NEgWUAkwVwZvrYtIcXtgBDfTmjyVosNCxMrhR5uTuC4akDFFar+nwcLmhFi
	oRS/4h5HnIG8wkXhOkN1CD3eXXXQOUzjk9IZw1abaCBW15KZzo/XkkkCQxRtk4XkanQf9jpU1du
	+gaMBj3xMxAwtZjq+Q+6C+D9C4/4isRgNlyCxBU+wt9dBiLWIw8i88IP68D5i+VKzX+6FkTR0sw
	TlUhP0O25aWGVVx8/Glf8D2OVQjsjd/xceJi4KpU4J/jL5VPJ5G+LKBNdGQTKsl/XnrfJje7ixV
	FPmBxZQHxCn8=
X-Google-Smtp-Source: AGHT+IHqwKjiX7teb/pYc+lujlnEosSIXQee1577UGyyGKXpSNDEIcsnj3vai7+fhOIxXIGibFhRIg==
X-Received: by 2002:a5d:59a9:0:b0:391:ffc:2413 with SMTP id ffacd0b85a97d-3971f9e497amr14184713f8f.40.1742197151769;
        Mon, 17 Mar 2025 00:39:11 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe60951sm96760055e9.26.2025.03.17.00.39.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 00:39:11 -0700 (PDT)
Message-ID: <6ea34ad0-8456-4e49-8eb1-372cf571d91b@blackwall.org>
Date: Mon, 17 Mar 2025 09:39:09 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bonding: check xdp prog when set bond mode
To: Wang Liang <wangliang74@huawei.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 joamaki@gmail.com
Cc: yuehaibing@huawei.com, zhangchangzhong@huawei.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20250314073549.1030998-1-wangliang74@huawei.com>
 <87y0x7rkck.fsf@toke.dk> <21d52659-622a-4b2a-b091-787bf0f5d67f@blackwall.org>
 <96a4043b-fdac-4ca1-a7b9-a6352b1d7dfe@blackwall.org>
 <fad4cb08-be38-4f43-ba61-db147e4d26d0@huawei.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <fad4cb08-be38-4f43-ba61-db147e4d26d0@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/17/25 06:07, Wang Liang wrote:
> 
> 在 2025/3/14 18:44, Nikolay Aleksandrov 写道:
>> On 3/14/25 12:22 PM, Nikolay Aleksandrov wrote:
>>> On 3/14/25 12:13 PM, Toke Høiland-Jørgensen wrote:
>>>> Wang Liang <wangliang74@huawei.com> writes:
>>>>
>>>>> Following operations can trigger a warning[1]:
>>>>>
>>>>>      ip netns add ns1
>>>>>      ip netns exec ns1 ip link add bond0 type bond mode balance-rr
>>>>>      ip netns exec ns1 ip link set dev bond0 xdp obj af_xdp_kern.o sec xdp
>>>>>      ip netns exec ns1 ip link set bond0 type bond mode broadcast
>>>>>      ip netns del ns1
>>>>>
>>>>> When delete the namespace, dev_xdp_uninstall() is called to remove xdp
>>>>> program on bond dev, and bond_xdp_set() will check the bond mode. If bond
>>>>> mode is changed after attaching xdp program, the warning may occur.
>>>>>
>>>>> Some bond modes (broadcast, etc.) do not support native xdp. Set bond mode
>>>>> with xdp program attached is not good. Add check for xdp program when set
>>>>> bond mode.
>>>>>
>>>>>      [1]
>>>>>      ------------[ cut here ]------------
>>>>>      WARNING: CPU: 0 PID: 11 at net/core/dev.c:9912 unregister_netdevice_many_notify+0x8d9/0x930
>>>>>      Modules linked in:
>>>>>      CPU: 0 UID: 0 PID: 11 Comm: kworker/u4:0 Not tainted 6.14.0-rc4 #107
>>>>>      Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
>>>>>      Workqueue: netns cleanup_net
>>>>>      RIP: 0010:unregister_netdevice_many_notify+0x8d9/0x930
>>>>>      Code: 00 00 48 c7 c6 6f e3 a2 82 48 c7 c7 d0 b3 96 82 e8 9c 10 3e ...
>>>>>      RSP: 0018:ffffc90000063d80 EFLAGS: 00000282
>>>>>      RAX: 00000000ffffffa1 RBX: ffff888004959000 RCX: 00000000ffffdfff
>>>>>      RDX: 0000000000000000 RSI: 00000000ffffffea RDI: ffffc90000063b48
>>>>>      RBP: ffffc90000063e28 R08: ffffffff82d39b28 R09: 0000000000009ffb
>>>>>      R10: 0000000000000175 R11: ffffffff82d09b40 R12: ffff8880049598e8
>>>>>      R13: 0000000000000001 R14: dead000000000100 R15: ffffc90000045000
>>>>>      FS:  0000000000000000(0000) GS:ffff888007a00000(0000) knlGS:0000000000000000
>>>>>      CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>>      CR2: 000000000d406b60 CR3: 000000000483e000 CR4: 00000000000006f0
>>>>>      Call Trace:
>>>>>       <TASK>
>>>>>       ? __warn+0x83/0x130
>>>>>       ? unregister_netdevice_many_notify+0x8d9/0x930
>>>>>       ? report_bug+0x18e/0x1a0
>>>>>       ? handle_bug+0x54/0x90
>>>>>       ? exc_invalid_op+0x18/0x70
>>>>>       ? asm_exc_invalid_op+0x1a/0x20
>>>>>       ? unregister_netdevice_many_notify+0x8d9/0x930
>>>>>       ? bond_net_exit_batch_rtnl+0x5c/0x90
>>>>>       cleanup_net+0x237/0x3d0
>>>>>       process_one_work+0x163/0x390
>>>>>       worker_thread+0x293/0x3b0
>>>>>       ? __pfx_worker_thread+0x10/0x10
>>>>>       kthread+0xec/0x1e0
>>>>>       ? __pfx_kthread+0x10/0x10
>>>>>       ? __pfx_kthread+0x10/0x10
>>>>>       ret_from_fork+0x2f/0x50
>>>>>       ? __pfx_kthread+0x10/0x10
>>>>>       ret_from_fork_asm+0x1a/0x30
>>>>>       </TASK>
>>>>>      ---[ end trace 0000000000000000 ]---
>>>>>
>>>>> Fixes: 9e2ee5c7e7c3 ("net, bonding: Add XDP support to the bonding driver")
>>>>> Signed-off-by: Wang Liang <wangliang74@huawei.com>
>>>>> ---
>>>>>   drivers/net/bonding/bond_options.c | 3 +++
>>>>>   1 file changed, 3 insertions(+)
>>>>>
>>>>> diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
>>>>> index 327b6ecdc77e..127181866829 100644
>>>>> --- a/drivers/net/bonding/bond_options.c
>>>>> +++ b/drivers/net/bonding/bond_options.c
>>>>> @@ -868,6 +868,9 @@ static bool bond_set_xfrm_features(struct bonding *bond)
>>>>>   static int bond_option_mode_set(struct bonding *bond,
>>>>>                   const struct bond_opt_value *newval)
>>>>>   {
>>>>> +    if (bond->xdp_prog)
>>>>> +        return -EOPNOTSUPP;
>>>>> +
>>>> Should we allow changing as long as the new mode also supports XDP?
>>>>
>>>> -Toke
>>>>
>>>>
>>> +1
>>> I think we should allow it, the best way probably is to add a new option
>>> BOND_VALFLAG_XDP_UNSUPP (for example) as a bond option flag and to set
>>> it in bond_options.c for each mode that doesn't support XDP, then you
>>> can do the check in a generic way (for any option) in
>>> bond_opt_check_deps. Any bond option that can't be changed with XDP prog
>> err, I meant any bond option's value that isn't supported with XDP, for
>> a whole option it would be a bit different
> Thanks for your suggestions!
> 
> When install xdp prog, bond_xdp_set() use bond_xdp_check() to check whether the bond mode support xdp.
> 
> When uninstall xdp prog, the paramter prog of bond_xdp_set() is NULL. How about not call bond_xdp_check() to avoid the warning when the prog is NULL, like:
> 
> static int bond_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>             struct netlink_ext_ack *extack)
>     ...
>     if (prog && !bond_xdp_check(bond))

No, this could cause other problems. Actually, for -net I think the best would be to stick to
a simpler fix and just do bond_xdp_check() if there's a XDP program attached when changing
the mode so it can be backported easier. The option value flag can be done in the future
if more option values (or options) need to be disabled for XDP.

Cheers,
 Nik

>>> should have that flag set.
>>>
>>> Cheers,
>>>   Nik
>>>
>>


