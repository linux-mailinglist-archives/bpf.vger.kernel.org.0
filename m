Return-Path: <bpf+bounces-54047-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BB7A60F41
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 11:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90FCE16BB51
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 10:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9AA1FBC84;
	Fri, 14 Mar 2025 10:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="erpJGrwQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6E51F709E
	for <bpf@vger.kernel.org>; Fri, 14 Mar 2025 10:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741949046; cv=none; b=H6hrVCVK/CYBU3K/5G+ZmvqlqF3VIClT7DdJAOPbBJKDqAb5wPRsT6J1yFtMGFOIioF/j3CBRjGpGGpyhQB+gMM5rQg5FsxlyGl9JbeQp+IuN/C+gQcLzUltQ9yKoTn5/Y2GFmycazRVXeIPtiKlWEm4ze8gTQlauVk2GUFluFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741949046; c=relaxed/simple;
	bh=yesTJPNbyIcSw648FltrN+NNbY8HcevtHpGeBr44k7w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=twL3kXSGPFuiOtWUOwtKJcMw+CL70VT06ZFMMo5CoMHUIXA/tLWVuIMkOsGk9gVn1YPyEkFkZq3sIgZKXeg7TZFmGX6QIG1SsL2GPm7E/eJWMeQXQ5Nk5lN8HUonmcmKPQp/CEOtr7CKiOZz0FNi5QZRag8bxymOrcvmcwnwoW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=erpJGrwQ; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so347370566b.3
        for <bpf@vger.kernel.org>; Fri, 14 Mar 2025 03:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1741949042; x=1742553842; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SbEOhoTEEu5x55+fPmrnGoGsT7RQD6j+d3DIIZHJ7QM=;
        b=erpJGrwQZHOQAyxNmiWCMql0qfG/P2OzWHVGvaYHqFRC4k3EWrtNSoBzOkwEnXjK1T
         a/YCjf0weFnySN1RDzhX2X1u5uDRNtYrpgOk6+OjnSWaMhlLVkECBAev4ByKOSTamr0H
         uolwHQKFhPhfMNDUqrQeoh2FK4Le0v7ZExie73cGfBuKPlKUDJOtvqSpp+FbbKx0drGy
         NYjy3o9TvApR2kx7Vg1CLheXuuE7YiA6VEm2h1pGydCcowDGuQbLOMsnPsAl7WRhmOKv
         kQG+XC0i9MY/M7iSXVPiLplKNgyQGqrOXKH0bRBUrsFoJvyiq27Oy4nmElKCeHtFXd4K
         Uwng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741949042; x=1742553842;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SbEOhoTEEu5x55+fPmrnGoGsT7RQD6j+d3DIIZHJ7QM=;
        b=QWSBx/QjkKXtN52J9I3D0IzhhG78Pp6XCYjm1pREvBrqkyH+Sfm2MdTzW1MD8i5Jew
         xUJl7pmwYTpqio78WqK1iAoJpbjTd8JepypHovFQ5NZgMzk4X+izfcr+qVw5m21Qd6Vs
         6AsYs7Ebs2GAp/Jm0WCnyl0vJL2Ypv302y7CAtWhVWGxf57wyeD7GK/ycQpmxpMCXiOj
         x0naVljwtQ8V6yT2N6nGzEMnI0xnhGh9Mc8Bs39gnUgwfDKCsQSzpOjbhaR/GzT6JQD0
         GtzqDVW92qybkk9hadYr251kOBeeSQaOTr2PLGNd7uECBysrzP7bv1GgGoQBJeD+Pm5+
         oocw==
X-Forwarded-Encrypted: i=1; AJvYcCW0gRurU+6i8i0l5vwozxcYqoz5szVhR2LNS9uLuvJhu/qpdi2IzpLFVxmdshnrZ/yTCiw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw24n3QzKiACvvqPsI2Yr/af2aDMwP5xWrHP8Qy+cFkliz/GQbD
	QxPAR8/X6dBWbca95D455a0WRScg1fb4qk8hgavpY/e3X3y1cCUlfpdfczq6LoE=
X-Gm-Gg: ASbGnctZ1TQkOSmbnMlbpvIhwYuD9BOgt/lMYq+86tTEbTNjYBRoVJzTLTpQjmiSzCS
	LgLyVEBIzseOn/2P9XK7ozYuZyaSlxDqjF6is8L95wmssYBEz2WDnWay2TiNhvYRsrvv5KdFkjS
	26u8fx4uiRa6Kxb5Ws2YWS7WBBUR71CiuKIDeIRWUGrjUtIMvSLrQB0FFfpBux1A/zsCmgJuPqz
	inJJl4jNbrUlVPA0qGeZ13CZUNNQT8wLTAUHMaw4YcdqLSrNa5HDR9+s9ylXIGTLzXBUPtVzUHn
	Sxn3QtUuQdoEB5kUjl9R+r0ktOa4jpQ3Bvb3ZxcpL3UAFg==
X-Google-Smtp-Source: AGHT+IFSCVQoVEn7iPn/TuwJfbODuInfrvqO1582NK0pYg3MKgyFAbCeHu9p4jsr87CjNZKVjj3cpA==
X-Received: by 2002:a17:907:3d87:b0:abf:6389:6d19 with SMTP id a640c23a62f3a-ac330258bcamr201708866b.15.1741949042421;
        Fri, 14 Mar 2025 03:44:02 -0700 (PDT)
Received: from [10.20.7.108] ([195.29.209.20])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147f0bd3sm210194366b.67.2025.03.14.03.44.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 03:44:01 -0700 (PDT)
Message-ID: <96a4043b-fdac-4ca1-a7b9-a6352b1d7dfe@blackwall.org>
Date: Fri, 14 Mar 2025 12:44:00 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bonding: check xdp prog when set bond mode
From: Nikolay Aleksandrov <razor@blackwall.org>
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Wang Liang <wangliang74@huawei.com>, jv@jvosburgh.net,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, joamaki@gmail.com
Cc: yuehaibing@huawei.com, zhangchangzhong@huawei.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20250314073549.1030998-1-wangliang74@huawei.com>
 <87y0x7rkck.fsf@toke.dk> <21d52659-622a-4b2a-b091-787bf0f5d67f@blackwall.org>
Content-Language: en-US
In-Reply-To: <21d52659-622a-4b2a-b091-787bf0f5d67f@blackwall.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/14/25 12:22 PM, Nikolay Aleksandrov wrote:
> On 3/14/25 12:13 PM, Toke Høiland-Jørgensen wrote:
>> Wang Liang <wangliang74@huawei.com> writes:
>>
>>> Following operations can trigger a warning[1]:
>>>
>>>     ip netns add ns1
>>>     ip netns exec ns1 ip link add bond0 type bond mode balance-rr
>>>     ip netns exec ns1 ip link set dev bond0 xdp obj af_xdp_kern.o sec xdp
>>>     ip netns exec ns1 ip link set bond0 type bond mode broadcast
>>>     ip netns del ns1
>>>
>>> When delete the namespace, dev_xdp_uninstall() is called to remove xdp
>>> program on bond dev, and bond_xdp_set() will check the bond mode. If bond
>>> mode is changed after attaching xdp program, the warning may occur.
>>>
>>> Some bond modes (broadcast, etc.) do not support native xdp. Set bond mode
>>> with xdp program attached is not good. Add check for xdp program when set
>>> bond mode.
>>>
>>>     [1]
>>>     ------------[ cut here ]------------
>>>     WARNING: CPU: 0 PID: 11 at net/core/dev.c:9912 unregister_netdevice_many_notify+0x8d9/0x930
>>>     Modules linked in:
>>>     CPU: 0 UID: 0 PID: 11 Comm: kworker/u4:0 Not tainted 6.14.0-rc4 #107
>>>     Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
>>>     Workqueue: netns cleanup_net
>>>     RIP: 0010:unregister_netdevice_many_notify+0x8d9/0x930
>>>     Code: 00 00 48 c7 c6 6f e3 a2 82 48 c7 c7 d0 b3 96 82 e8 9c 10 3e ...
>>>     RSP: 0018:ffffc90000063d80 EFLAGS: 00000282
>>>     RAX: 00000000ffffffa1 RBX: ffff888004959000 RCX: 00000000ffffdfff
>>>     RDX: 0000000000000000 RSI: 00000000ffffffea RDI: ffffc90000063b48
>>>     RBP: ffffc90000063e28 R08: ffffffff82d39b28 R09: 0000000000009ffb
>>>     R10: 0000000000000175 R11: ffffffff82d09b40 R12: ffff8880049598e8
>>>     R13: 0000000000000001 R14: dead000000000100 R15: ffffc90000045000
>>>     FS:  0000000000000000(0000) GS:ffff888007a00000(0000) knlGS:0000000000000000
>>>     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>     CR2: 000000000d406b60 CR3: 000000000483e000 CR4: 00000000000006f0
>>>     Call Trace:
>>>      <TASK>
>>>      ? __warn+0x83/0x130
>>>      ? unregister_netdevice_many_notify+0x8d9/0x930
>>>      ? report_bug+0x18e/0x1a0
>>>      ? handle_bug+0x54/0x90
>>>      ? exc_invalid_op+0x18/0x70
>>>      ? asm_exc_invalid_op+0x1a/0x20
>>>      ? unregister_netdevice_many_notify+0x8d9/0x930
>>>      ? bond_net_exit_batch_rtnl+0x5c/0x90
>>>      cleanup_net+0x237/0x3d0
>>>      process_one_work+0x163/0x390
>>>      worker_thread+0x293/0x3b0
>>>      ? __pfx_worker_thread+0x10/0x10
>>>      kthread+0xec/0x1e0
>>>      ? __pfx_kthread+0x10/0x10
>>>      ? __pfx_kthread+0x10/0x10
>>>      ret_from_fork+0x2f/0x50
>>>      ? __pfx_kthread+0x10/0x10
>>>      ret_from_fork_asm+0x1a/0x30
>>>      </TASK>
>>>     ---[ end trace 0000000000000000 ]---
>>>
>>> Fixes: 9e2ee5c7e7c3 ("net, bonding: Add XDP support to the bonding driver")
>>> Signed-off-by: Wang Liang <wangliang74@huawei.com>
>>> ---
>>>  drivers/net/bonding/bond_options.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
>>> index 327b6ecdc77e..127181866829 100644
>>> --- a/drivers/net/bonding/bond_options.c
>>> +++ b/drivers/net/bonding/bond_options.c
>>> @@ -868,6 +868,9 @@ static bool bond_set_xfrm_features(struct bonding *bond)
>>>  static int bond_option_mode_set(struct bonding *bond,
>>>  				const struct bond_opt_value *newval)
>>>  {
>>> +	if (bond->xdp_prog)
>>> +		return -EOPNOTSUPP;
>>> +
>>
>> Should we allow changing as long as the new mode also supports XDP?
>>
>> -Toke
>>
>>
> 
> +1
> I think we should allow it, the best way probably is to add a new option 
> BOND_VALFLAG_XDP_UNSUPP (for example) as a bond option flag and to set
> it in bond_options.c for each mode that doesn't support XDP, then you
> can do the check in a generic way (for any option) in
> bond_opt_check_deps. Any bond option that can't be changed with XDP prog

err, I meant any bond option's value that isn't supported with XDP, for
a whole option it would be a bit different

> should have that flag set.
> 
> Cheers,
>  Nik
> 


