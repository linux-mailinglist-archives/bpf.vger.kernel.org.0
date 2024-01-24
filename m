Return-Path: <bpf+bounces-20210-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDEF83A5EC
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 10:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8EF5B2B2E1
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 09:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87906182A0;
	Wed, 24 Jan 2024 09:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="VFBWV2IP"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF533182AB;
	Wed, 24 Jan 2024 09:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706089607; cv=none; b=myhuFTHiXkfJCSlXheWFrLGERxm/Rcz57WKflTecmfukR3yVKvYs82c8AxEU7BbXAs40PXcEa9t3i62FoTRLG/Exzun9BuD/xSDZf4ET6pwMFp7Rfd0fuN3j1W7i9gVbL6vjbDUXgqDy7qJAvPLIzCco3iStFzDuEq3XYGeY0W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706089607; c=relaxed/simple;
	bh=g88xxGggv15/xdqsSHg5R7sXTHhEp+krTJy1ll1lV4U=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=MKEuZaS2q7zQYUn0W/1o+tbOcOpC6UeaTQBEdG0xlAxzyMiibaBMHncqJ6bQzk9FNU4ZXz2TH9H4eWQNO9lPxqQ9HSSsnegUBSYcRR40cMXEeCI8n6KWvs5sxHgqj9Tp6dEUZb/hrFb9QxjKVrf0fCXHcfLUzNdL0VPfrnK0LRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=VFBWV2IP; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=bA7AsA7CeLFm30KGGEVuSKCxjLezcEyRJ3yCntSdgy0=; b=VFBWV2IPxHc2UVAaJtQ1i0QTwo
	8EMjQINaWYOQBlG9wxWmCqAISdREh9sfQNAaCKABeW5zAHOAtviEVOnOrTou6vyHdWhL7RjDtAoWm
	wMdNiWj6Yp8i4W7EU/3KpzE5Nln/wljg96lY9xzrUUr3+MSRziMUKAs36jwEqjoZ557c0tOE/zL2u
	LA5FDakV3oasErJ2ZDivV1tqRLM9RHig8vM9mTfupxuJ5Q/vXyIy3ryYLitYvP53QtFdIatksExrE
	2I2IdUGUK0MOTbcdfS9vOUHT7U6qoDLEeff3hQ6E4bsONYlAkBvyj7Gf15V2sgq6KQEmI+cZRH+M/
	uD92dAKw==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rSZq7-000K6v-HJ; Wed, 24 Jan 2024 10:46:35 +0100
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1rSZq6-0007cZ-2v;
	Wed, 24 Jan 2024 10:46:34 +0100
Subject: Re: linux-next: manual merge of the bpf-next tree with the mm tree
To: Andrew Morton <akpm@linux-foundation.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Nathan Chancellor <nathan@kernel.org>
References: <20240124121605.1c4cc5bc@canb.auug.org.au>
 <CAADnVQKBCpkwx1HVaNy1wmHqVrekgkd4LEZm9UzqOkOBniTOyw@mail.gmail.com>
 <20240124001808.bfff657f089afe10e5b0824c@linux-foundation.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <8cd3a7f4-db72-dc8f-581c-40d115562c55@iogearbox.net>
Date: Wed, 24 Jan 2024 10:46:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240124001808.bfff657f089afe10e5b0824c@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27163/Tue Jan 23 10:42:11 2024)

On 1/24/24 9:18 AM, Andrew Morton wrote:
> On Tue, 23 Jan 2024 17:18:55 -0800 Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> 
>>> Today's linux-next merge of the bpf-next tree got a conflict in:
>>>
>>>    tools/testing/selftests/bpf/README.rst
>>>
>>> between commit:
>>>
>>>    0d57063bef1b ("selftests/bpf: update LLVM Phabricator links")
>>>
>>> from the mm-nonmm-unstable branch of the mm tree and commit:
>>>
>>>    f067074bafd5 ("selftests/bpf: Update LLVM Phabricator links")
>>>
>>> from the bpf-next tree.
>>
>> Andrew,
>> please drop the bpf related commit from your tree.
> 
> um, please don't cherry-pick a single patch from a multi-patch series
> which I have already applied.

The BPF one was actually a stand-alone patch targetted at bpf-next:

https://lore.kernel.org/bpf/20240111-bpf-update-llvm-phabricator-links-v2-1-9a7ae976bd64@kernel.org/

