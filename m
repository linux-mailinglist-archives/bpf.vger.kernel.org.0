Return-Path: <bpf+bounces-76215-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D83BBCAA607
	for <lists+bpf@lfdr.de>; Sat, 06 Dec 2025 13:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2A5E3067323
	for <lists+bpf@lfdr.de>; Sat,  6 Dec 2025 12:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E825B2F39D1;
	Sat,  6 Dec 2025 12:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Yb2vLvru"
X-Original-To: bpf@vger.kernel.org
Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9E32F1FC9;
	Sat,  6 Dec 2025 12:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.83.148.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765023274; cv=none; b=V5yVn1IaDhHD1sq3HOFSs0UwGsxS0ObdXGMkkVppWCtSxCHkFlSk/PKXYDJH3AIaTA9AOq7iXc+N9yS3VA5NOL1Z/dtgZkBWjPlY0L/OOwOg/hnSckB4sIITp0kc02/NSA18voUinPF8GjF6Rl73sAIpIBYogdvOzha3mYaB8Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765023274; c=relaxed/simple;
	bh=bpiDnIJ+JNXwSy4A9k7dCht21sr0kMaUXGf+K3ovGwY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nDxt9R4AJF9Q9CAwba1jiGMibEGnoA4AK5ejSGRK46MY9zbDB6/glClHDrspkW6/NrPUdBsi6Txvn3TRsS2CNhFztu/LzEJjdmy57pDLoN+J0LaRb3gUtRruY/s6gndsQEE17fEXKp/DnyvCn7e58b2yFXoQSwn1/7p8CJo6K7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Yb2vLvru; arc=none smtp.client-ip=35.83.148.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1765023273; x=1796559273;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bpiDnIJ+JNXwSy4A9k7dCht21sr0kMaUXGf+K3ovGwY=;
  b=Yb2vLvru/LAo63QHLXZmJ0nMCKWRQ9le+KB+ZZkKDnTYkhGeX7vo0rm4
   W2ucwVjWGxqhK1/qgiW47d7zC9HBUuKsi6dZWl83OyqVlFwn/ahN7GVMU
   mRhqmyLP3H9XhgGf2c/GI7crCLDpqJ5owtM2Oa/yIuTcXtDdzvbsOmuJ+
   GHSgSDajZOTsyv9KoYKBB4L/afBtaflil8iGE8fMac+tCfVy9X/r/e97M
   1zlSf6sKd2q7ftdqvl3EntZ+XcUP26O8HLs1SnJivJsOgwHdfoLsiMOij
   6ZbF20ZFeGGs5aqB9Z5CQMKmnmWDrBe0j3Cc/acBjsUpUHELP+9BCbOch
   w==;
X-CSE-ConnectionGUID: 7Enf8gBFTdi+kx32Sf5Jvg==
X-CSE-MsgGUID: gmailz9tQV6Y4oUgnLczmA==
X-IronPort-AV: E=Sophos;i="6.20,254,1758585600"; 
   d="scan'208";a="8359251"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2025 12:14:29 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:12515]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.243:2525] with esmtp (Farcaster)
 id f1bfe2a7-c994-4d11-a872-dd09963f8151; Sat, 6 Dec 2025 12:14:29 +0000 (UTC)
X-Farcaster-Flow-ID: f1bfe2a7-c994-4d11-a872-dd09963f8151
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Sat, 6 Dec 2025 12:14:29 +0000
Received: from b0be8375a521.amazon.com (10.37.245.10) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Sat, 6 Dec 2025 12:14:25 +0000
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
Date: Sat, 6 Dec 2025 21:14:07 +0900
Message-ID: <20251206121418.59654-1-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <CAADnVQKxZv9hCLeFz60Sra5t4J4h=EncoKW3K1OyEBePAfqmuQ@mail.gmail.com>
References: <CAADnVQKxZv9hCLeFz60Sra5t4J4h=EncoKW3K1OyEBePAfqmuQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D031UWA003.ant.amazon.com (10.13.139.47) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Sat, 6 Dec 2025 04:06:38 -0800, Alexei Starovoitov wrote:

>On Sat, Dec 6, 2025 at 9:01 PM Kohei Enju <enjuk@amazon.com> wrote:
>>
>> Ah, I forgot that bpf-next is closed until Jan 2nd due to the merge window.
>> I'll resend v2 after Jan 2nd :)
>
>?! It's not closed. net-next is.

Oh, really?
Hmm, I've read the documentation[1], but I may misunderstand something. Perhaps that documentation is outdated?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/bpf/bpf_devel_QA.rst#n232

