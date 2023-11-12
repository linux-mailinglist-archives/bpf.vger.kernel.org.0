Return-Path: <bpf+bounces-14960-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF0D7E92EC
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 23:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E47DF280C22
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 22:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544E71BDD8;
	Sun, 12 Nov 2023 22:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="hAABIU75"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303A61A58D;
	Sun, 12 Nov 2023 22:13:01 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35101BEC;
	Sun, 12 Nov 2023 14:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=sfrisplrlO/RCCGWkUsEXzSMDWEELzHqoGvrDf0E4Yc=; b=hAABIU75Oy1IsC3ZNTN7+yzHTt
	Q27w3YUckHRHfM/wAHBD43fmtucNCPu5L3u9hS9JCMK5PQjcCgGNDQ6xow+TjA8HRBMJaYAVhxAbo
	WIlWvWU5wGqrdoQIFk3KTsv1tzjE4sSPZYtNHQgRtlqMgsi4GSgAePFR5H93/OO7DkpOOuYCgKXlb
	pcx7JQuPoxLbeoczlr4lFxHSZHC9ZtxqM89rGErBeSQFJT/+RzIOxYF9s2cYKFFfHEOdGhvP1fG7l
	xLzpTnsbxjaiIYIQvpWgy9jSZ74gU8pSutEaLoTeP7kZ/fqtO0Zn9yYYUiZbXR4nk9CRKTAxOMnZG
	zrMVircA==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1r2IhJ-000DiN-8Z; Sun, 12 Nov 2023 23:12:53 +0100
Received: from [194.230.158.57] (helo=localhost.localdomain)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1r2IhI-0004aj-Ko; Sun, 12 Nov 2023 23:12:52 +0100
Subject: Re: [PATCH bpf v2 4/8] veth: Use tstats per-CPU traffic counters
To: Peilin Ye <yepeilin.cs@gmail.com>
Cc: martin.lau@kernel.org, kuba@kernel.org, razor@blackwall.org,
 sdf@google.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
 Peilin Ye <peilin.ye@bytedance.com>
References: <20231112203009.26073-1-daniel@iogearbox.net>
 <20231112203009.26073-5-daniel@iogearbox.net>
 <20231112220930.GA3368259@n191-129-154.byted.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <87c47416-9dff-fae3-37bf-5c2e89669617@iogearbox.net>
Date: Sun, 12 Nov 2023 23:12:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231112220930.GA3368259@n191-129-154.byted.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27091/Sun Nov 12 09:38:11 2023)

Hi Peilin,

On 11/12/23 11:09 PM, Peilin Ye wrote:
> Hi Daniel,
> 
> Thanks a lot for taking care of this!
> 
> On Sun, Nov 12, 2023 at 09:30:05PM +0100, Daniel Borkmann wrote:
>> Signed-off-by: Peilin Ye <peilin.ye@bytedance.com>
> 
> Would you like to add your Co-developed-by: here, since you've changed
> the code?

Thanks, forgot about it, I'll just reply with the tag here:

Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>

Cheers,
Daniel

