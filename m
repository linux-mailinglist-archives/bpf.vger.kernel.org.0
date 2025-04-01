Return-Path: <bpf+bounces-55095-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3DDA781FD
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 20:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C9C916B996
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 18:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFA920E01D;
	Tue,  1 Apr 2025 18:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="vYRRAKLu"
X-Original-To: bpf@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96551607B4;
	Tue,  1 Apr 2025 18:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743531399; cv=none; b=ermr/clabcuqDrRuyX6Sg/Dgr8sMEdzgF5+1m5Ok94IVDJrdjZ/vVj8KLXB9xcbczIkVM71Kt+YUUp6lwM8ZRZZojBEBNsgIBJDjWIZG2v1Ybx4Jjt6Jlkh5C7XTCGwx8SpRFYFD2zNfgI9tKiYmAUYWapYUZ9uD6wqQv9r7NZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743531399; c=relaxed/simple;
	bh=HsU4nCvTufU6UvDaGtG5pBsrOWcyfbyriu0SXl0Bb4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=loT1JI0Luj60vJ73B9PwHjDIAzPyo6AqbtcP2f1WOi0c0oUHHS0tKg3k8GJgZLDWwBQYxHCn5Nv7wBw/71qFKNlrIBaW1f3FT4xggCCqYxgkoP2o91F9Bwyb1jq/MOK5mzxmERrIG3T/4MPpzItoUb7NsnDCU782GsHUJPBqGO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=vYRRAKLu; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [192.168.1.58] (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id E4903200BE75;
	Tue,  1 Apr 2025 20:16:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be E4903200BE75
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1743531395;
	bh=bKA0C89WKr01eijuy+us5pAvRGEr5x5x/B9TTtSCrbQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vYRRAKLuYCezagHlNCtif2e3xkG4lV5X3v18lcC8U+x4JSZPDSBvjuiMTjUJQN+qU
	 qxFepD69oH05dtQqcOAowjlt1aIYB8S4eMSSRGeNc1NmfQb8iddziTO/C67d/eRTWN
	 JxNs6mqde53sDZSdsFdhV6KVeSl3sr+Tu17FmXzPL8UZthVQj1sBvA3FT3a84+i0nY
	 eYnRbgP63/4t4T7kkCS7DBKZ99FaSM7pJIUxi/OyHAAKqFJDVP807XF6H7SZ/XpaYt
	 2DYNFV7SaexOELX2f/iIXAXqJ8jLOuxd6CoDXwS/F/asmi84ivbOcs9tWODbMC6grS
	 cD+V12Vj6OFQw==
Message-ID: <48e12ec7-61ae-4e48-a3f8-71e776bd5bb9@uliege.be>
Date: Tue, 1 Apr 2025 20:16:34 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: new splat
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf
 <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>,
 Jakub Kicinski <kuba@kernel.org>
References: <CAADnVQJFWn3dBFJtY+ci6oN1pDFL=TzCmNbRgey7MdYxt_AP2g@mail.gmail.com>
 <647c3886-72fd-4e49-bdd0-4512f0319e8c@redhat.com>
 <d24ea1cc-4d32-44f9-9051-0c874f73f1c5@uliege.be> <Z-wYH-gIvMd89-3d@mini-arch>
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <Z-wYH-gIvMd89-3d@mini-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/1/25 18:45, Stanislav Fomichev wrote:
> On 04/01, Justin Iurman wrote:
>>
>> Correct, I came to the same conclusion based on that trace. However, I can't
>> reproduce it with a PREEMPT kernel. It goes through without problem and the
>> output is (as expected), i.e., "lwtunnel_xmit(): recursion limit reached on
>> datapath".
> 
> For me adding the following to the config did the trick:
> CONFIG_PREEMPT
> CONFIG_DEBUG_PREEMPT
> 
> And reverting your patch made it go away.

*Sigh* Looks like CONFIG_DEBUG_PREEMPT did the trick... thanks!

@Paolo, I'll provide a fix ASAP.

