Return-Path: <bpf+bounces-40256-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E76998446F
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 13:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A04AEB271E9
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 11:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA131A270;
	Tue, 24 Sep 2024 11:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="I4mRZlgf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E791A4F0A
	for <bpf@vger.kernel.org>; Tue, 24 Sep 2024 11:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727176909; cv=none; b=QtygIvIEZby5KJNVba/Ee9U6VJOqG8Mce+OQ1Ml5z+qSOoRkIjk6MY6L1XpY3rPF3oCnBMfWiAxS/FiIy95bqCL6QakTOUMhPzwvGDH7rPby4YCDcxcF5K451RZM2aqMA5Kz3Shs8KXUjvVbbPvRkEHfVbdNgaAYFgZhvgoRrZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727176909; c=relaxed/simple;
	bh=Jj2kY0s3nLvGSJk43H/8dQ6ptNHqz4lwqKkwB5lyxNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OJGl3k6X/lLxsg7TZ3UnXk6cbJLGTc68vspZgyCWOJWEoH/lBCb2XeJkCTgA9peuP3/ycwhmH5V2NhxmtwE7Z0RSFDBA78EPMXR7cE5AQpU59NNDMOIh2jx+LbkN+7tl1lh0J3yyGWf5j6ey6A3+RSipMGG+EJ5qkQhhB8YI/Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=I4mRZlgf; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f75b13c2a8so57488701fa.3
        for <bpf@vger.kernel.org>; Tue, 24 Sep 2024 04:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1727176906; x=1727781706; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J3VQ/oBeOZme7i4I/7mHE4CNcL6txPF1CWfw+Th573A=;
        b=I4mRZlgfy7EdyPc2tI7OzrXslFHz5kS/x5LozXap56fdTyATrSAIORwv6Z6WdiPAvz
         sYVpTMtYlz02PsxWJXkifURYsvvw3wH7jhjwjF+bEZP0jtztKDbuPk1ZnejiRiIfDlVG
         k+Bano87Ja8rSMNvRee+bWTHBpcIljbUMBVa+MhFAgWn5jiiMeZC5KzfE16d1zhZh2xa
         t8kywtC5qUXVhWB5DvdKJaeZZeH/Zf5KaU1B2BKPzAqGkCqUOYrzVBLOTn3bI+9juau/
         fmXqZ07ANglwmHa9oUnhlRi0umw9tYlhalJG2/NlvIrMAhUQanzuGBwxs3S+184VIhGD
         wVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727176906; x=1727781706;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J3VQ/oBeOZme7i4I/7mHE4CNcL6txPF1CWfw+Th573A=;
        b=Kju0f2QxSVz2EtsG+TEKe+ekNIEa742VYVV57fB+pmMkmXm6VtchZ/kgHiGIJsfXO4
         oNysJ6WNc0tK6oilznJIs6TXg2/GLrYPwP6YcsC3vTvn3s7ZH0ajbkDiF26Atex4JEjW
         O8TmpC1iZMtqf0bKMo2/dU2B51v6DENm5vFI5ff4noBxHWK1bQ6UPtHEKT//SdTmzHq1
         589eSx+gOcuGnLSJQOy8DEC/yqVvJRyX+5YLTpXyb30O5jKU5hWN0PfNyGo4RI20JcFJ
         YYc6KMXGkw8QxmsE0BUJROIOzL0u6risU0wrfIntQrj8lD67gF2+diiMe3S+AhsFFeo8
         BFWw==
X-Forwarded-Encrypted: i=1; AJvYcCWYJcci2RFyjIFKUfHJ3kLIMccANQYe/b8y6/oio4xx0Dtyyc59QXNOlwsFq+RWhcBZ4C4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEJZULredTRSjtjKJK1/iUcdJiDJ8fxISXyN339CPUV2glHVUK
	5W2eIgvv7iQTHRQtnwQW84L++btAQyuGEOaS/VgGoqPV1YatrBR02HjcghYGRjQ=
X-Google-Smtp-Source: AGHT+IFk/otU7x9ha29AT1wwFhwBtrmwOZzPPA+MwpRBiO6fr4bhrwIYWdQcvPw2P2NZiHOtZN2UBA==
X-Received: by 2002:a05:651c:2211:b0:2f7:8d3f:11fc with SMTP id 38308e7fff4ca-2f7cb360354mr81843491fa.31.1727176905904;
        Tue, 24 Sep 2024 04:21:45 -0700 (PDT)
Received: from [192.168.1.18] (176.111.185.181.kyiv.nat.volia.net. [176.111.185.181])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f8d283b661sm1905781fa.33.2024.09.24.04.21.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 04:21:45 -0700 (PDT)
Message-ID: <52874821-600b-4ffe-b4b4-9efbed6a3aca@blackwall.org>
Date: Tue, 24 Sep 2024 14:21:43 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] bonding: Fix unnecessary warnings and logs from
 bond_xdp_get_xmit_slave()
To: Paolo Abeni <pabeni@redhat.com>, Jiwon Kim <jiwonaid0@gmail.com>,
 jv@jvosburgh.net, andy@greyhouse.net, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, joamaki@gmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, syzbot+c187823a52ed505b2257@syzkaller.appspotmail.com
References: <20240918140602.18644-1-jiwonaid0@gmail.com>
 <29ef00f0-57dc-4332-9569-e88868a85575@redhat.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <29ef00f0-57dc-4332-9569-e88868a85575@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/24/24 13:20, Paolo Abeni wrote:
> On 9/18/24 16:06, Jiwon Kim wrote:
>> syzbot reported a WARNING in bond_xdp_get_xmit_slave. To reproduce
>> this[1], one bond device (bond1) has xdpdrv, which increases
>> bpf_master_redirect_enabled_key. Another bond device (bond0) which is
>> unsupported by XDP but its slave (veth3) has xdpgeneric that returns
>> XDP_TX. This triggers WARN_ON_ONCE() from the xdp_master_redirect().
>> To reduce unnecessary warnings and improve log management, we need to
>> delete the WARN_ON_ONCE() and add ratelimit to the netdev_err().
>>
>> [1] Steps to reproduce:
>>      # Needs tx_xdp with return XDP_TX;
>>      ip l add veth0 type veth peer veth1
>>      ip l add veth3 type veth peer veth4
>>      ip l add bond0 type bond mode 6 # BOND_MODE_ALB, unsupported by XDP
>>      ip l add bond1 type bond # BOND_MODE_ROUNDROBIN by default
>>      ip l set veth0 master bond1
>>      ip l set bond1 up
>>      # Increases bpf_master_redirect_enabled_key
>>      ip l set dev bond1 xdpdrv object tx_xdp.o section xdp_tx
>>      ip l set veth3 master bond0
>>      ip l set bond0 up
>>      ip l set veth4 up
>>      # Triggers WARN_ON_ONCE() from the xdp_master_redirect()
>>      ip l set veth3 xdpgeneric object tx_xdp.o section xdp_tx
>>
>> Reported-by: syzbot+c187823a52ed505b2257@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=c187823a52ed505b2257
>> Fixes: 9e2ee5c7e7c3 ("net, bonding: Add XDP support to the bonding driver")
>> Signed-off-by: Jiwon Kim <jiwonaid0@gmail.com>
> 
> Isn't the above issue completely addressed by explicitly checking for 
> bond->prog in bond_xdp_get_xmit_slave()? Or would that broke some use-case?
> 
> Thanks,
> 
> Paolo
> 

There isn't much difference with this patch, bond_xdp_get_xmit_slave()
always returns either a slave or NULL, either way you'd return NULL.

It does have a potential to break some weird setup, but I can't
currently come up with one where bond_xdp_get_xmit_slave is used and
xdp_prog is not set, so I don't have a preference about which way
to fix it. :)

Cheers,
 Nik


