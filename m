Return-Path: <bpf+bounces-54240-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45269A66023
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 22:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3825C16F887
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 21:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6580020370B;
	Mon, 17 Mar 2025 21:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BCzoaeJu"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427FC18A6BA
	for <bpf@vger.kernel.org>; Mon, 17 Mar 2025 21:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742245450; cv=none; b=gfGTmKItCiOJl2/FGTUci6IA0XSwXB5uQoaZFU/XJ+KHZZXiu0a8FaSPcywchjfKzD7XHaXu8M5Or9GDcLeZxjFvmLoUFtR+rMiysk7mxrfMLsega/iPRPk11u74EMd5H5rvadTViXehvpaolxX4CVhr3dqWqeUV5ObZl8YkiMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742245450; c=relaxed/simple;
	bh=OoiDlRqg4vyRAgxOAJNm87/M3zZ9sBnLYzT8dcStGps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sKYxxaZFaaos6mIDj7a/5nIus3+bBdJCwbsoJurYAqvldmUbZ8IoGsLqr8c22pGcyt016bZFp/UNmxNvy2kefyGLOe2F/G7JdMpWS+MNu8Ve8hOdlYmRpSvsPVRhw0UKAuNJ3IZx6QAygHgzww1U++SUREBacpsIhv8/UGMRuJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BCzoaeJu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742245448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZbwsXMam4KCw7aD09b2qjKYv+IfkBT52U0KqXE3xKYQ=;
	b=BCzoaeJuzV56knt1jrfbLsWeAv/Rz4TxjbYmZa6XIco83eWfETYJWj71BPLZ1AGopsHGls
	w26hu7vUd2afWnB9g9KTeszgk4PKKhUQ+LDQe2AqHLKj4HGGnQY7wWLC8v8uo6AtxzYaYP
	6In9skpU5IFJ9aoMv5DHFQtw12RJTr8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-KMF1JGsKOGOjYDuhVDYlFQ-1; Mon, 17 Mar 2025 17:04:06 -0400
X-MC-Unique: KMF1JGsKOGOjYDuhVDYlFQ-1
X-Mimecast-MFC-AGG-ID: KMF1JGsKOGOjYDuhVDYlFQ_1742245446
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-391425471ddso2553724f8f.0
        for <bpf@vger.kernel.org>; Mon, 17 Mar 2025 14:04:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742245446; x=1742850246;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZbwsXMam4KCw7aD09b2qjKYv+IfkBT52U0KqXE3xKYQ=;
        b=LQOivvjrOds25SSNfOmQYIvClSABvTjbZnFwGjQKJA+LpAUT7qLjcjgkAT321A/vjh
         n10vieJv8Cq6mfh0iR0UY9HdbWHyuVkYi7uISD03mX+diiGmqfRjT5lQcma4E49Ltlxk
         fuCIXOG5TBm81O3x06Pr6h6lhu6A4S/sW5t3k/OxaDUVwtwFxC9FNDHfxCJ1tx0aqcFO
         9xKYnUpsiMo7dCir80b9uykAzqriUkNouXjyTpX5F8pJhWAiyGiulbOt1KhwDaiDNju3
         QFM1k5cDL/ZKcF97O30GfEF/frAXnSf+beGjR9QBRgZ+ysl7Kg9EQ8abqTFAmgmbXh/s
         vBGw==
X-Forwarded-Encrypted: i=1; AJvYcCWobKPpDfU86ThKkhiz62uVfWWUSzIbKlln7BxPvmg+v6Le5qM6aAq+lmJVwikdzKztgBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA4b4Daz9cqHqpCFIS5sq3PKlO5ycXg3OsQBRmKUffRtpyPKnh
	e9ks+JX4PFjD2y2DzRq1BfnAvyIhxAxWuiu+WZSkMbhSbfnozZ/FEKU16/RlhdIloz3NhmHLD2m
	ljNI05O4A8P8fBzonK+cwd1wHPDcDZG4EU4FrSEXcZ+Prnc6xYA==
X-Gm-Gg: ASbGncu6NvqnhvpXva0IzJGBiVlgFJUM+DiPTGizGiHSsFMQqwqP5P8AaBgLvYI8W/M
	ip7yzJw9IUpz1ZrpgVILOgjSZArmbxZHgbXDWxHmk9nu/in8KGNbIUnUZPBwsFJKXRSAUBVgscd
	2J1B7iur+JCswD97uAxoksxGpdAeiU5tQ1FG9xIS0twfLhsQcAkjlAeYlobLEY3cEJRKZCbpLGf
	gtZlKqoXgxDK8fa4UNso5BVLHaMqQ/2GC0B/Q+hDA/9Zbn0llYmhGdYWq26Tll9sbvWojxfrmb8
	VsYy33pY9hxSqU3GljY9C7sa4OoyfQC6Hdb0VqRXwl8v4A==
X-Received: by 2002:a5d:648b:0:b0:390:e7c1:59c4 with SMTP id ffacd0b85a97d-3971e2ad603mr16741796f8f.13.1742245445592;
        Mon, 17 Mar 2025 14:04:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFk2wiVA9t3El2hJh8gfCbbFsSl0Bk4VQBu3x4PsYQOkuAVxoNzSqKy1vHCZNIGeDbgank4DQ==
X-Received: by 2002:a5d:648b:0:b0:390:e7c1:59c4 with SMTP id ffacd0b85a97d-3971e2ad603mr16741754f8f.13.1742245445217;
        Mon, 17 Mar 2025 14:04:05 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb40cdd0sm16112796f8f.77.2025.03.17.14.04.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 14:04:04 -0700 (PDT)
Message-ID: <eb1fb79c-d2f6-48bd-82b6-c630ae197a7d@redhat.com>
Date: Mon, 17 Mar 2025 22:04:02 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 net-next 00/12] AccECN protocol preparation patch
 series
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>,
 "patchwork-bot+netdevbpf@kernel.org" <patchwork-bot+netdevbpf@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "dsahern@gmail.com" <dsahern@gmail.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "dsahern@kernel.org" <dsahern@kernel.org>,
 "joel.granados@kernel.org" <joel.granados@kernel.org>,
 "kuba@kernel.org" <kuba@kernel.org>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "horms@kernel.org" <horms@kernel.org>,
 "pablo@netfilter.org" <pablo@netfilter.org>,
 "kadlec@netfilter.org" <kadlec@netfilter.org>,
 "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>,
 "coreteam@netfilter.org" <coreteam@netfilter.org>,
 "kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "kuniyu@amazon.com" <kuniyu@amazon.com>, "andrew@lunn.ch" <andrew@lunn.ch>,
 "ij@kernel.org" <ij@kernel.org>, "ncardwell@google.com"
 <ncardwell@google.com>,
 "Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>,
 "g.white" <g.white@cablelabs.com>,
 "ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>,
 "mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>,
 "cheshire@apple.com" <cheshire@apple.com>, "rs.ietf@gmx.at"
 <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
 <Jason_Livingood@comcast.com>, vidhi_goel <vidhi_goel@apple.com>
References: <20250305223852.85839-1-chia-yu.chang@nokia-bell-labs.com>
 <174222664074.3797981.10286790754550014794.git-patchwork-notify@kernel.org>
 <PAXPR07MB798499BAC1A21E323687C9CAA3DF2@PAXPR07MB7984.eurprd07.prod.outlook.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <PAXPR07MB798499BAC1A21E323687C9CAA3DF2@PAXPR07MB7984.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/17/25 5:44 PM, Chia-Yu Chang (Nokia) wrote:
> Hello:
>> This series was applied to netdev/net-next.git (main) by David S. Miller <davem@davemloft.net>:
[...]
>> Here is the summary with links:
>>   - [v7,net-next,01/12] tcp: reorganize tcp_in_ack_event() and tcp_count_delivered()
>>     https://git.kernel.org/netdev/net-next/c/149dfb31615e
>>   - [v7,net-next,02/12] tcp: create FLAG_TS_PROGRESS
>>     https://git.kernel.org/netdev/net-next/c/da610e18313b
>>   - [v7,net-next,03/12] tcp: use BIT() macro in include/net/tcp.h
>>     https://git.kernel.org/netdev/net-next/c/0114a91da672
>>   - [v7,net-next,04/12] tcp: extend TCP flags to allow AE bit/ACE field
>>     https://git.kernel.org/netdev/net-next/c/2c2f08d31d2f
>>   - [v7,net-next,05/12] tcp: reorganize SYN ECN code
>>     (no matching commit)
>>   - [v7,net-next,06/12] tcp: rework {__,}tcp_ecn_check_ce() -> tcp_data_ecn_check()
>>     https://git.kernel.org/netdev/net-next/c/f0db2bca0cf9
>>   - [v7,net-next,07/12] tcp: helpers for ECN mode handling
>>     (no matching commit)
>>   - [v7,net-next,08/12] gso: AccECN support
>>     https://git.kernel.org/netdev/net-next/c/023af5a72ab1
>>   - [v7,net-next,09/12] gro: prevent ACE field corruption & better AccECN handling
>>     https://git.kernel.org/netdev/net-next/c/4e4f7cefb130
>>   - [v7,net-next,10/12] tcp: AccECN support to tcp_add_backlog
>>     https://git.kernel.org/netdev/net-next/c/d722762c4eaa
>>   - [v7,net-next,11/12] tcp: add new TCP_TW_ACK_OOW state and allow ECN bits in TOS
>>     https://git.kernel.org/netdev/net-next/c/4618e195f925
>>   - [v7,net-next,12/12] tcp: Pass flags to __tcp_send_ack
>>     https://git.kernel.org/netdev/net-next/c/9866884ce8ef
>>
>> You are awesome, thank you!
>> --
>> Deet-doot-dot, I am a bot.
>> https://korg.docs.kernel.org/patchwork/pwbot.html
> 
> Hello,
> 
> I see two patches are NOT applied in the net-next (05/12 and 07/12) repo.
> So, I would like to ask would it be merged latter on, or shall I include in the next AccECN patch series? Thanks.

Something went wrong at apply time.

AFAICS patch 7 is there with commit 041fb11d518f ("tcp: helpers for ECN
mode handling") while patch got lost somehow. I think it's better if you
repost them, rebased on top of current net-next.

Thanks!

Paolo


