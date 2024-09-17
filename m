Return-Path: <bpf+bounces-40016-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A1F97ABE4
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 09:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A2AE1C21E34
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 07:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1C314B94B;
	Tue, 17 Sep 2024 07:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="sahROmNx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F04D18C22
	for <bpf@vger.kernel.org>; Tue, 17 Sep 2024 07:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726557296; cv=none; b=UScfELHhNejZ5GOUMkHyalWJe9lcVpKItpY7SJNcdvia9P/RKdmSe3adaIU8MU1aPwqI/yPPgbrQWTPKvhqXHW7NttTWKbdKw4GNCtD6fJtbQ6JRX8HDS5gh1GP/uc7SiNHEODM9Rcri3ewAItVfyC5CgeaJ+g7F6LNQjC90umI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726557296; c=relaxed/simple;
	bh=XZkdS4sglS03WS7qFAlqRer07G+wd0agSmv2vWg0pEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r0IJ8lzfiPw2YYSLByR/59HMPD7R6IWoJA5g/AHK5DhBt+jtAP4sOTDY5eBOW7oK+sV7203uJUGq9FfSKnmH7ge7QrL0vzSnK2PlksRE1hoV4ahEy08PhY2IZVOCukXBRhO8cDmwLwd+8jtxklZR9qDifMqmJlrSTTJo1Gd/iX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=sahROmNx; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8d0d82e76aso878987566b.3
        for <bpf@vger.kernel.org>; Tue, 17 Sep 2024 00:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1726557292; x=1727162092; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2IV5aTo5kvdtk0fRESSTVce5a8XDqbnMuhig/5mCEvc=;
        b=sahROmNx/xt6QdMJ35q6Lmpju+G7WKngCwoXSIitxRFZMQqcE7xF9VNOvR2OVfx8y1
         tdBIr1+LcvXWFz3ne2jk7e6Hznl2mLHxh9rVs99Zb6CGhRlBoJurpIc/F5ad9Sd9+MvR
         +exHJ7iNh/MQ7GdTrdsLbD5i+i1KNk1CVwhZpZy8h8wwfqglimVRhEQ/n6BY1YGn/Znh
         KOYkS3fen0+MGBLhNP8fX7e5Ua5HfJXsPIw8JC2gvX/I23pXInnc/SyLGUkovZGzLi+B
         oyIyiWorkGQOsEithqc9yjA+BnqvyUfcra03x71vdhHsRJaFL7R7AZuOEBEWAjoFFzff
         EClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726557292; x=1727162092;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2IV5aTo5kvdtk0fRESSTVce5a8XDqbnMuhig/5mCEvc=;
        b=UCLgs4DhjIU6Xlf64vFB9G793vY9bd5GnohwUco6vUOvEHSvJdRXWkeSYWxOYMwa88
         rO4Bvsqa9GKg1rKELselbH3w8MgO3EkdDfGaVqrJ10Y00HdP3COjlqMwWfMXCeLE2f3H
         6HO62iHgea4BLQmmriHNnlZMWQLi1ACR85ZTS3auCkqA9t5pPJpOlUAAGRdFU2eppb6O
         8+bNVmc9EXizvaT6eOaadmEnA1cOhdnWpF5OI+c1gSgbrcZ0LTaM1aMUMQgtgSUHwgGc
         NDgRlg2T2oYC2kjn9Hlrsy+CfXWplQytgC3hXdueNWxTRCbI2Vre5f+StlITQ3WV5kEq
         vvyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdAavMNT2+GgLE5umi9zxYZPluwCx7j6179J16WAWwjgK3gw3zGHEl8lQIsOmUumygdMw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwvnl7J+SgdwXZtwj0pSRoCNpjiHteSzFnKPIzNQi2C11Hva3r
	RMMxftzBKZcNOa3G0Y6jwXCPkdU4nlASpuPr7K/pRofnEIufmwqLL7KrLqphzGU=
X-Google-Smtp-Source: AGHT+IGBsf/rOxMDH3CzdmsY7IaraXAMa6zukbA6KH9fLPxjOJlX9gVT+ac9GHFPhiOql64k7bJEIA==
X-Received: by 2002:a17:906:f5a7:b0:a86:a56a:3596 with SMTP id a640c23a62f3a-a9029678cbemr2016921066b.60.1726557292151;
        Tue, 17 Sep 2024 00:14:52 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610966aasm408733866b.26.2024.09.17.00.14.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 00:14:51 -0700 (PDT)
Message-ID: <2609348a-a70f-4dba-853f-e5163c99e1a8@blackwall.org>
Date: Tue, 17 Sep 2024 10:14:50 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bondig: Add bond_xdp_check for bond_xdp_xmit in
 bond_main.c
To: =?UTF-8?B?6rmA7KeA7JuQ?= <jiwonaid0@gmail.com>
Cc: jv@jvosburgh.net, andy@greyhouse.net, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 joamaki@gmail.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
 syzbot+c187823a52ed505b2257@syzkaller.appspotmail.com
References: <20240916055011.16655-1-jiwonaid0@gmail.com>
 <05707e9e-08ac-4ee1-b910-883f8b4b2636@blackwall.org>
 <CAKaoOqc4PMobrxo-Sz5-1RTG-Qkf+GjDnqyp0zbEUmyDtFu5Zw@mail.gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <CAKaoOqc4PMobrxo-Sz5-1RTG-Qkf+GjDnqyp0zbEUmyDtFu5Zw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 17/09/2024 07:26, 김지원 wrote:
> On Mon, Sep 16, 2024 at 5:48 PM Nikolay Aleksandrov <razor@blackwall.org> wrote:
>>
>> On 16/09/2024 08:50, Jiwon Kim wrote:
>>> Add bond_xdp_check to ensure the bond interface is in a valid state.
>>>
>>> syzbot reported WARNING in bond_xdp_get_xmit_slave.
>>> In bond_xdp_get_xmit_slave, the comment says
>>> /* Should never happen. Mode guarded by bond_xdp_check() */.
>>> However, it does not check the status when entering bond_xdp_xmit.
>>>
>>> Reported-by: syzbot+c187823a52ed505b2257@syzkaller.appspotmail.com
>>> Closes: https://syzkaller.appspot.com/bug?extid=c187823a52ed505b2257
>>> Fixes: 9e2ee5c7e7c3 ("net, bonding: Add XDP support to the bonding driver")
>>> Signed-off-by: Jiwon Kim <jiwonaid0@gmail.com>
>>> ---
>>>  drivers/net/bonding/bond_main.c | 33 ++++++++++++++++++---------------
>>>  1 file changed, 18 insertions(+), 15 deletions(-)
>>>
>>
>> How did you figure the problem is there? Did you take any time to actually
>> understand it? This patch doesn't fix anything, the warning can be easily
>> triggered with it. The actual fix is to remove that WARN_ON() altogether
>> and downgrade the netdev_err() to a ratelimited version. The reason is that
>> we can always get to a state where at least 1 bond device has xdp program
>> installed which increases bpf_master_redirect_enabled_key and another bond
>> device which uses xdpgeneric, then install an ebpf program that simply
>> returns ACT_TX on xdpgeneric bond's slave and voila - you get the warning.
>>
>> setup is[1]:
>>  $ ip l add veth0 type veth peer veth1
>>  $ ip l add veth3 type veth peer veth4
>>  $ ip l add bond0 type bond mode 6 # <- transmit-alb mode, unsupported by xdp
>>  $ ip l add bond1 type bond # <- rr mode by default, supported by xdp
>>  $ ip l set veth0 master bond1
>>  $ ip l set bond1 up
>>  $ ip l set dev bond1 xdpdrv object tx_xdp.o section xdp_tx # <- we need xdpdrv program to increase the static key, more below
>>  $ ip l set veth3 master bond0
>>  $ ip l set bond0 up
>>  $ ip l set veth4 up
>>  $ ip l set veth3 xdpgeneric object tx_xdp.o section xdp_tx # <- now we'll hit the codepath we need after veth3 Rx's a packet
>>
>>
>> If you take the time to look at the call stack and the actual code, you'll
>> see it goes something like (for the xdpgeneric bond slave, veth3):
>> ...
>> bpf_prog_run_generic_xdp() for veth3
>>  -> bpf_prog_run_xdp()
>>    -> __bpf_prog_run() # return ACT_TX
>>      -> xdp_master_redirect() # called because we have ACT_TX && netif_is_bond_slave(xdp->rxq->dev)
>>        -> master->netdev_ops->ndo_xdp_get_xmit_slave(master, xdp); # and here we go, WARN_ON()
>>
>> I've had a patch for awhile now about this and have taken the time to look into it.
>> I guess it's time to dust it off and send it out for review. :)
>>
>> Thanks,
>>  Nik
> 
> Hi Nikolay,
> 
> Thank you for taking the time to provide a detailed setup and call
> stack analysis.
> Would you be handling the new patch? If you don't mind, may I revise
> this patch to
> 
> - Replace with net_ratelimit()
> - Remove the WARN_ON()
> - Update the comment appropriately
> 
> Thanks again for your insights and patience.
> 
> Sincerely,
> 
> Jiwon Kim

sure, I don't mind, change the patch and I'll review the new one

Cheers,
 Nik


