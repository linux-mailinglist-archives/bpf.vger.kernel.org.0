Return-Path: <bpf+bounces-22869-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E241486B06D
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 14:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 135A71C25C57
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 13:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801B414C59D;
	Wed, 28 Feb 2024 13:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="A8ecUt47"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542FB145B18;
	Wed, 28 Feb 2024 13:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709127316; cv=none; b=Z5lBqNoQJ4EvcjayavMspVez1y7wJDb0aqHb4Hwb6LV733x6xEuM4LnSupNPZfTUaQ9tO5waS3lqB5mc/OYlSgjmBUGS6ff2MAW/+77CoWq4YE8Oy9eU3eby1TztQpG/hCK5CyITT76Vl5xT0/5cLpLp66ZGHQiTInnIUaQYm38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709127316; c=relaxed/simple;
	bh=9OjOYTocLBb1ogOiemenpkw8Y91g8aR9Ss4e4aSOKp0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=mdDJqJ0OQBBUMmRm9NlcFdj1T+Dvt8RtAoRXtEH7Ceyxsjo8PCffSMHbGzvLNYjNsLIeqMQv1g9eeCMpBm5882YiWqnhQUgnxQVXx5f+Qs9VW1aOAXWhv2YDQh6nFAWyX6ZA42rD6rIzoXH7MwpYWqAgMK2/CKSafUN3j1FhTuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=A8ecUt47; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=7hKktLa8vwAg7gBkeFVxG3uw7KCw4YZfOnQGsRcW8lU=; b=A8ecUt47rW2jToa43Ehsgl/Jm2
	cAt5Feruk+msUqIPfd60Sa5tbIiVcGjBjwuuiug6oB25SqnTSYnYWSShAOcAthYSxt+bVGOy9RrHa
	8jbiRQr19SCFA2n2XhVPIWLtuyEgh+qpHZIMTxbYOx3IPMTl2Oumnlo6Tx0iguo3THi++BBJpvumz
	fc3Z5ltE35q84kzMFXXBE1hBJbwLmj7PsxpUn5ZlAOwYsBl9JgdyHthDFU1fYRaPfdSwaXyIT2CZM
	alHxo2M6XJQU5WzVsOKblv95kGFkm/amTXHkK7an/rbHEzvh+GrRSGGzMp1x66SzSgohaTE0aJIU7
	fu6Db/sQ==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rfK5I-0006R0-5m; Wed, 28 Feb 2024 14:34:56 +0100
Received: from [178.197.248.40] (helo=linux.home)
	by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rfK5H-0003lv-E4; Wed, 28 Feb 2024 14:34:55 +0100
Subject: Re: [PATCH bpf-next v8 0/2] bpf, arm64: use BPF prog pack allocator
 in BPF JIT
To: Catalin Marinas <catalin.marinas@arm.com>,
 Puranjay Mohan <puranjay12@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 mark.rutland@arm.com, bpf@vger.kernel.org, kpsingh@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 xukuohai@huaweicloud.com
References: <20240221145106.105995-1-puranjay12@gmail.com>
 <Zd8o__ow2F6-ENVh@arm.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <7b4588ff-c769-c185-3b4c-aab4a472d872@iogearbox.net>
Date: Wed, 28 Feb 2024 14:34:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zd8o__ow2F6-ENVh@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27199/Wed Feb 28 10:31:56 2024)

On 2/28/24 1:37 PM, Catalin Marinas wrote:
> On Wed, Feb 21, 2024 at 02:51:04PM +0000, Puranjay Mohan wrote:
>> Puranjay Mohan (2):
>>    arm64: patching: implement text_poke API
>>    bpf, arm64: use bpf_prog_pack for memory management
>>
>>   arch/arm64/include/asm/patching.h |   2 +
>>   arch/arm64/kernel/patching.c      |  75 ++++++++++++++++
>>   arch/arm64/net/bpf_jit_comp.c     | 139 ++++++++++++++++++++++++------
>>   3 files changed, 192 insertions(+), 24 deletions(-)
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> Feel free to take it through the bpf tree.

Thanks for the review, Catalin!

Puranjay, this needs a rebase before it can be merged into bpf-next,
please take a look and resubmit.

