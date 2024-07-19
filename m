Return-Path: <bpf+bounces-35093-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5BF937A11
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 17:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8D46B21D5E
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 15:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1BF145A0D;
	Fri, 19 Jul 2024 15:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="IL0WM0a3"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E151E4AD;
	Fri, 19 Jul 2024 15:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721403661; cv=none; b=EG75c5MAp20xvojPhP7PBABI/w6dXhm6olCJGaQCrto2Dc8OrP0hYG/lqyZ2uINanGuKR/yOAH7WtFRAlY6nntTdE2BRCXM79bWccW5buMlX5RGeqwGmPVy8OC+MihKFrit52xF8K7Q361N/Cz1xGCWMjuJJrTr2R6EsVLPArFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721403661; c=relaxed/simple;
	bh=KP/l8WgAb82aWSw+cUpPZycmTV1N/vcGIcgxbsaLNNA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=rt+CMQlngqpwFjQK7SuspD8/lCsE4OYpa96GhkRhmFIFC7w1gcW4hkd36r3W0SS7FQqKebl86ZrD/Yugzg3tEw7m6+3PGBuv4C0OxUFy2wGZFxrLEstTj6VmtMgJRP2KSj3Rx/gX1DsZLQXwh7/x8kKE45edGbMy5tqKK0VjIvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=IL0WM0a3; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=6CnxiAa0mm0ndD8EckYTCCsKgB5tGr0pE3+vdzbeaO4=; b=IL0WM0a3WMo7D4NVwN11uw4xyp
	evVwHKcWPENEnlYDNhlyBE1Dyni+XdVbul0HO6bz+FY/XmbGxqk4BTErAsHv7DgAwCau78VV6Sp4O
	J8PT1HU/w3S/k6b/nBhztUezDYDAf4vLRiTiJxBvaY31tAL5z/ggStj0q7fqoFgdyIGwEakn1jY7+
	SmgXlsFuZqSx6Bp+pzwiU8SiJV5LIsGhbwi9NusIK/U+8dVq/naHNGTZM5lrUIxKEQdpwdKqxncie
	lKbJCmMTpD2CUmPzXuEVDmtQunZNY/dkczFj2DSENG4Q7t9fLZ1uPnN5PiUpXMYzd+TLX58nwWi4T
	uK3YDJiA==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sUpj5-00093A-AD; Fri, 19 Jul 2024 17:40:55 +0200
Received: from [178.197.248.43] (helo=linux-2.home)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1sUpj4-000Dn5-01;
	Fri, 19 Jul 2024 17:40:54 +0200
Subject: Re: [PATCH bpf 0/3] xsk: require XDP_UMEM_TX_METADATA_LEN to actuate
 tx_metadata_len
To: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "ast@kernel.org" <ast@kernel.org>, "andrii@kernel.org"
 <andrii@kernel.org>, "martin.lau@linux.dev" <martin.lau@linux.dev>,
 "song@kernel.org" <song@kernel.org>, "yhs@fb.com" <yhs@fb.com>,
 "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
 "kpsingh@kernel.org" <kpsingh@kernel.org>, "sdf@google.com"
 <sdf@google.com>, "haoluo@google.com" <haoluo@google.com>,
 "jolsa@kernel.org" <jolsa@kernel.org>,
 Julian Schindel <mail@arctic-alpaca.de>,
 Magnus Karlsson <magnus.karlsson@gmail.com>
References: <20240713015253.121248-1-sdf@fomichev.me>
 <284c6aba-8872-f971-7adb-60ed5ab3c29c@iogearbox.net>
 <DM4PR11MB6117959BE15FCBF84B2A89C982AD2@DM4PR11MB6117.namprd11.prod.outlook.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <6b334974-6b85-4952-0da4-37603932f09d@iogearbox.net>
Date: Fri, 19 Jul 2024 17:40:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <DM4PR11MB6117959BE15FCBF84B2A89C982AD2@DM4PR11MB6117.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27341/Fri Jul 19 10:28:50 2024)

On 7/19/24 5:29 PM, Fijalkowski, Maciej wrote:
>> On 7/13/24 3:52 AM, Stanislav Fomichev wrote:
>>> Julian reports that commit 341ac980eab9 ("xsk: Support tx_metadata_len")
>>> can break existing use cases which don't zero-initialize xdp_umem_reg
>>> padding. Fix it (while still breaking a minority of new users of tx
>>> metadata), update the docs, update the selftest and sprinkle some
>>> BUILD_BUG_ONs to hopefully catch similar issues in the future.
>>>
>>> Thank you Julian for the report and for helping to chase it down!
>>>
>>> Reported-by: Julian Schindel <mail@arctic-alpaca.de>
>>> Cc: Magnus Karlsson <magnus.karlsson@gmail.com>
>>>
>>> Stanislav Fomichev (3):
>>>     xsk: require XDP_UMEM_TX_METADATA_LEN to actuate tx_metadata_len
>>>     selftests/bpf: Add XDP_UMEM_TX_METADATA_LEN to XSK TX metadata test
>>>     xsk: Try to make xdp_umem_reg extension a bit more future-proof
>>>
>>>    Documentation/networking/xsk-tx-metadata.rst  | 16 ++++++++-----
>>>    include/uapi/linux/if_xdp.h                   |  4 ++++
>>>    net/xdp/xdp_umem.c                            |  9 +++++---
>>>    net/xdp/xsk.c                                 | 23 ++++++++++---------
>>>    tools/include/uapi/linux/if_xdp.h             |  4 ++++
>>>    .../selftests/bpf/prog_tests/xdp_metadata.c   |  3 ++-
>>>    6 files changed, 38 insertions(+), 21 deletions(-)
>>>
>>
>> Magnus or Maciej, ptal when you get a chance.
> 
> I'll do so on Monday as I'll be back from vacation, Magnus will be out for
> yet another week. Hope it works for you?

Sounds good, just making sure this doesn't fall off the radar. :)

Thanks Maciej!

