Return-Path: <bpf+bounces-34931-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E722193332A
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 22:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7323A286742
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 20:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE36558BC;
	Tue, 16 Jul 2024 20:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="vnDhk5tq"
X-Original-To: bpf@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2CB55884
	for <bpf@vger.kernel.org>; Tue, 16 Jul 2024 20:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721163453; cv=none; b=mwhTRbLKdXmnHOWstoXL7/+OiLIDxj4zcoG7DT3DKtDmqWRTY4gKV1mUD+itd3e1oO6+etioXZVKAksmh2XmTLc0z2n7mhPWwHnyBn8VgEuRgYphukhxFNYFpdYhYw5FcU8P6iUqcDkGfxOdWpkVuXpNIhfLHTsCQp8wKF4y0UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721163453; c=relaxed/simple;
	bh=qlfI/Ch6Q0lDFnRqWJzmFHtj+7qXbi8aq1C6OyAOtuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pjbMmH0SC8UBfDngzRm19OMOqyi1TG6vnvVksRYeI+Sv1h7PEP2/wual6AMdR+9SzIu6Ed//nCtLtJTJHwEQ2j7fojo2Z/wxHipYRDiccYCe/00XqYCYmE9rmGJq0nzjC2au86F8wwYTxYHtbQ+azvB4/MyMwRxRIh7Xq1vWSOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=vnDhk5tq; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1sTpEb-003lDV-La; Tue, 16 Jul 2024 22:57:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=psLYRik24ixlvkYt49aJBpS7lA+ewBMWrRxijBPUM5A=; b=vnDhk5tqsT8Fpc3ZZZrU68XAk+
	D1x5OUq7pBkREHnck7XF7bI/ZSNdL5MV40/1rYtsY7xuPHp4oXnqRjpS8Vb6NREqNkqAw/AdBI++y
	8JIZC82BpdIeMK4HJCdILKG5R3t4VqEg+IxYf4fwqeaoAFSOrAKCoV+MYTheysIYqZdHe0hnCQQyC
	9zAkPflUTnMhJVqD8JXIXGjko1Kld6Cei5/21DD3jHlNQLJBr/zA+T/fEb1y3LzWAya/YqZRmSnv4
	rBuybmFSV7qko0la5e/U8XPPhxlGEQHANg8KrmCVPBwUU1oUXJrYqjiGtpHaGQm1WlcRZdPF77ZaZ
	PhQaICWA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1sTpEa-0001v8-DX; Tue, 16 Jul 2024 22:57:16 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sTpER-002sjk-Gr; Tue, 16 Jul 2024 22:57:08 +0200
Message-ID: <2ce97e96-6976-4a96-b872-c83ed11ff8bf@rbox.co>
Date: Tue, 16 Jul 2024 22:57:06 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v4 0/4] af_unix: MSG_OOB handling fix & selftest
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 john.fastabend@gmail.com, kuniyu@amazon.com, Rao.Shoaib@oracle.com,
 cong.wang@bytedance.com
References: <20240713200218.2140950-1-mhal@rbox.co>
 <cc71d3c5-41f9-4e6a-98d2-7822877b6214@rbox.co>
 <87jzhl90o1.fsf@cloudflare.com>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <87jzhl90o1.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/16/24 10:54, Jakub Sitnicki wrote:
> On Sat, Jul 13, 2024 at 10:14 PM +02, Michal Luczaj wrote:
>> Arrgh, forgot the changelog:
> 
> Take a look at b4 for managing patch set the cover letter and changelog:
> 
> https://b4.docs.kernel.org/en/latest/

Thanks, will do.


