Return-Path: <bpf+bounces-67450-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D746CB43FAC
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 16:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A591A541C9A
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 14:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A6E301467;
	Thu,  4 Sep 2025 14:53:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4F91EB1A4;
	Thu,  4 Sep 2025 14:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756997605; cv=none; b=HqJo6UMU07qYgJdm2LJ9veSXF9dF/pl6/BR4ahq1rQLi/bPNWAoPcMcFlgXORb/vEHFonpICyCUKltPHj7s3Vl3cLc2D1Tgxf1jnMOP2zBl8QDWUBz7UG0ouHR98Rs+WOgWcaclcKMyhD60aVYV2VQfex54EAIzkd/KO3qSjBUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756997605; c=relaxed/simple;
	bh=KSx/TiJ8ZczLmapgz5FLegPMs0j6YLk3ABF+H2N+FoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ELEj3OQo8WvCySjJOiSEfDVS2BEjdgmzcjxDSpopT8Bx2MKLVm+t3uHWy/EdGALd58nta2Q3zLHZ7ZcaMBwY4PHRTCk2/g/cfvxG1gAMeEmaJILqyHRcNYeYnb4dZ70HkYbYT19VGwQsmUUbrNRLstcNe0yX3T9o78K9YyWpqug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from [IPV6:2a01:e0a:3e8:c0d0:74c4:9b58:271e:cbdf] (unknown [IPv6:2a01:e0a:3e8:c0d0:74c4:9b58:271e:cbdf])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id 9524441C88;
	Thu,  4 Sep 2025 14:53:21 +0000 (UTC)
Authentication-Results: Plesk;
        spf=pass (sender IP is 2a01:e0a:3e8:c0d0:74c4:9b58:271e:cbdf) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=[IPV6:2a01:e0a:3e8:c0d0:74c4:9b58:271e:cbdf]
Received-SPF: pass (Plesk: connection is authenticated)
Message-ID: <3e283264-e53e-4d16-a0f1-401f1acbd546@arnaud-lcm.com>
Date: Thu, 4 Sep 2025 16:53:20 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: syztest
To: Jakub Kicinski <kuba@kernel.org>
Cc: syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <6887e3c8.a00a0220.b12ec.00ad.GAE@google.com>
 <20250904141113.40660-1-contact@arnaud-lcm.com>
 <20250904074752.352982bf@kernel.org>
Content-Language: en-US
From: "Lecomte, Arnaud" <contact@arnaud-lcm.com>
In-Reply-To: <20250904074752.352982bf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <175699760199.24351.8490463781548650169@Plesk>
X-PPP-Vhost: arnaud-lcm.com


On 04/09/2025 16:47, Jakub Kicinski wrote:
> On Thu,  4 Sep 2025 16:11:13 +0200 Arnaud Lecomte wrote:
>> #syz test
> You are hereby encouraged to not CC the vger MLs on your attempts
> to get your patches tested by syzbot. It's not necessary.
>
Hey, sorry for the inconvenience.
Will be removed.

