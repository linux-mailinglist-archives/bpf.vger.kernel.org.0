Return-Path: <bpf+bounces-76217-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E52CCAA621
	for <lists+bpf@lfdr.de>; Sat, 06 Dec 2025 13:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6AB70300EA07
	for <lists+bpf@lfdr.de>; Sat,  6 Dec 2025 12:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4882F12A8;
	Sat,  6 Dec 2025 12:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="IZMXcbwM"
X-Original-To: bpf@vger.kernel.org
Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.13.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F85E19CCF5;
	Sat,  6 Dec 2025 12:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.13.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765024047; cv=none; b=cooLXF6pZHZjO4cazhhVuZGoCl6SgBuy2V9FCKIT//Pavq5kuuJNXtRhw1HO2FvDDMZGirmBQivd9NongVZTIeQcW7QQNNHPaO0WsO5blRe2AI7P6a2sAPyLhAyqgunyh2a/t26rrm8kS+gV6rqmWCaPVJcUgQ9NA1yv81gj8LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765024047; c=relaxed/simple;
	bh=zWYJ1ppVcu9XVgKz0rjB80aNd1/2ERboAsoGdwHU1BY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q63c4/TlDZMv8TSBclALYkWxwG5akO79Tn6qHKSRXpOuX2knswiTImC8c55xMJ6nCaCHyI/Mw6mK3pZrBMM5ENe5EIDmqGyPOaZdjZqyLLGwq63hn+25SR85J8n2GPOGDv3R8N7l1KN9/wILBT0JQWu+/cajcbc0dlQyxBMRyU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=IZMXcbwM; arc=none smtp.client-ip=52.13.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1765024045; x=1796560045;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zWYJ1ppVcu9XVgKz0rjB80aNd1/2ERboAsoGdwHU1BY=;
  b=IZMXcbwMkhcMs1J4kyJnS4hRCYTt7Q97A6dPToHasAMKK4YZtizJ1uDv
   q5DseIxU+TkN25AeDw6R+vjWxotjvUQLgYHsbIyv5gYoGT0rc6WgLyndC
   nCbOR+NazAEMpzMUVwtDYkRhWs54UZq0Fkp17DgdMad0a115jkcV4oumo
   7uXxG+Gld+Pswg3qlK3GXPHRUeofxKb15xvhjry4EALEE2/MuYEYOmnoT
   qR7yM1h2rnl5exs2ZZQADhSf/lIs2TslRYMDzXGkNARx5alg+Ie2JXzOr
   oXq/nd+APuvuWT4oSrDH/HXduUtUEqcc8w5ReVLdz1c9twKP7H8ThTkP/
   w==;
X-CSE-ConnectionGUID: 5oPqqEGSRD2S6uSXvZpz0g==
X-CSE-MsgGUID: DKHiQnGZRaWzEXYVDCqWAw==
X-IronPort-AV: E=Sophos;i="6.20,254,1758585600"; 
   d="scan'208";a="8565127"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2025 12:27:23 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:31777]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.104:2525] with esmtp (Farcaster)
 id 0eacfba0-d52c-4779-9f77-366bd165cc13; Sat, 6 Dec 2025 12:27:22 +0000 (UTC)
X-Farcaster-Flow-ID: 0eacfba0-d52c-4779-9f77-366bd165cc13
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Sat, 6 Dec 2025 12:27:22 +0000
Received: from b0be8375a521.amazon.com (10.37.245.10) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Sat, 6 Dec 2025 12:27:19 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <alexei.starovoitov@gmail.com>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <davem@davemloft.net>, <eddyz87@gmail.com>,
	<enjuk@amazon.com>, <haoluo@google.com>, <hawk@kernel.org>,
	<john.fastabend@gmail.com>, <jolsa@kernel.org>, <kernel-team@cloudflare.com>,
	<kohei.enju@gmail.com>, <kpsingh@kernel.org>, <kuba@kernel.org>,
	<lorenzo@kernel.org>, <martin.lau@linux.dev>, <netdev@vger.kernel.org>,
	<sdf@fomichev.me>, <shuah@kernel.org>, <song@kernel.org>, <toke@kernel.org>,
	<yonghong.song@linux.dev>
Subject: Re: [PATCH bpf v1 1/2] bpf: cpumap: propagate underlying error in cpu_map_update_elem()
Date: Sat, 6 Dec 2025 21:26:51 +0900
Message-ID: <20251206122711.62868-1-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <CAADnVQKJ2wzZSCmYPR_wTfp3pLDpHjTVQ0RLviHWGMtWzVy8-Q@mail.gmail.com>
References: <CAADnVQKJ2wzZSCmYPR_wTfp3pLDpHjTVQ0RLviHWGMtWzVy8-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D046UWA001.ant.amazon.com (10.13.139.112) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Sat, 6 Dec 2025 04:22:02 -0800, Alexei Starovoitov wrote:

>On Sat, Dec 6, 2025 at 9:14 PM Kohei Enju <enjuk@amazon.com> wrote:
>>
>> On Sat, 6 Dec 2025 04:06:38 -0800, Alexei Starovoitov wrote:
>>
>> >On Sat, Dec 6, 2025 at 9:01 PM Kohei Enju <enjuk@amazon.com> wrote:
>> >>
>> >> Ah, I forgot that bpf-next is closed until Jan 2nd due to the merge window.
>> >> I'll resend v2 after Jan 2nd :)
>> >
>> >?! It's not closed. net-next is.
>>
>> Oh, really?
>> Hmm, I've read the documentation[1], but I may misunderstand something. Perhaps that documentation is outdated?
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/bpf/bpf_devel_QA.rst#n232
>
>yes. It's seriously outdated. bpf-next was never closed.

Today I learned! Thank you for the clarification.

As originally planned, I will work on v2 next week :)

