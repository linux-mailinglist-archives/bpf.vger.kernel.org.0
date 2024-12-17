Return-Path: <bpf+bounces-47113-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6219F47ED
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 10:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BF2F1887BE7
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 09:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07701DF996;
	Tue, 17 Dec 2024 09:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NQ/A7Nuz"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2386E1DF961;
	Tue, 17 Dec 2024 09:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734428832; cv=none; b=eV9gkhTno3oWCUibeH4prdefGUepnDwVeoo4R3MAZTEjIYRkANeyJqoDLwfzIRt8Fr2IJR9An+qqz1vn0SNrxyU2gJAVUvCSNNY8z8zD6PIb21+w+WIA8ISQdGF8b5vgwTN1iDzKK7wrZAH6xYYWUFrcvakfr8v82X5IvJ4KUkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734428832; c=relaxed/simple;
	bh=TywHOsLe9J4L4PuYcOrxBq9KYHTRDSQRWvdeuyZVVaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E9WbpbrZ6QTeO1pCa2levOsF+6tgGHO5c+hMAxPKKBB9ylxIjtAHaV+4SXLlhXEyzaUcJ5kjQ1ze+S/1jHskViQlKVqRTr411d+KqH91lU7dBu3ZDtOFnpO+yjq5/BbQrU0CNG0GwTrabqS1WQogkHJTUE2Y0GwPzkk9qTEXQ/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NQ/A7Nuz; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734428830; x=1765964830;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TywHOsLe9J4L4PuYcOrxBq9KYHTRDSQRWvdeuyZVVaY=;
  b=NQ/A7NuzbLBYwJKXqsIGL7mPTdL2WZzPbSJMRewSrSvbLCQHoGe3ngjh
   e2TLzNvt4pqQMgfaJl6O/bAgXw2kzL9Hkw2SxeX+Co6Q31dM6K0BNgyEB
   5bZta5lB0yAMtGvWwBBAIfXtQsYtmnwoS7l0PS38OzWhHD3SShc79xEAD
   aHfhc80lm9FIZiagOvZfSv0wrgD3zUPOlYBzrX87Ri3HbMyxWMCQn6vr4
   T0B75dKa8P59TVKsVw1vHmtZ+ezM3fQmYKxo2GlA53VVZed/Kk5I94gov
   7gDnTa2Y+O+7oilBWVHCcWZup9euk4CgLRDL5fo1BcI7+OBG5WSAR3bkb
   w==;
X-CSE-ConnectionGUID: nuo3IIsMTsWUZZWrkCyC2Q==
X-CSE-MsgGUID: H1vmOAnZRq+ScXXp/eNo8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="45330401"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="45330401"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 01:47:09 -0800
X-CSE-ConnectionGUID: N/aRvvV8QYSYTW7GPDUFBw==
X-CSE-MsgGUID: bqCuAgKgSsuB/qEfCPga1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="102084252"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.247.127.121]) ([10.247.127.121])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 01:47:06 -0800
Message-ID: <8f8d6149-d6a6-4fec-bb4d-fa0eb3613cd8@linux.intel.com>
Date: Tue, 17 Dec 2024 17:47:02 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next 6/9] igc: Add support for frame preemption
 verification
To: Vladimir Oltean <olteanv@gmail.com>, Furong Xu <0x1207@gmail.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20241216064720.931522-1-faizal.abdul.rahim@linux.intel.com>
 <20241216064720.931522-1-faizal.abdul.rahim@linux.intel.com>
 <20241216064720.931522-7-faizal.abdul.rahim@linux.intel.com>
 <20241216064720.931522-7-faizal.abdul.rahim@linux.intel.com>
 <20241217002254.lyakuia32jbnva46@skbuf>
Content-Language: en-US
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <20241217002254.lyakuia32jbnva46@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 17/12/2024 8:22 am, Vladimir Oltean wrote:
> On Mon, Dec 16, 2024 at 01:47:17AM -0500, Faizal Rahim wrote:
>> The i226 hardware doesn't implement the process of verification
>> internally, this is left to the driver.
>>
>> Add a simple implementation of the state machine defined in IEEE
>> 802.3-2018, Section 99.4.7. The state machine is started manually by
>> user after "verify-enabled" command is enabled.
>>
>> Implementation includes:
>> 1. Send and receive verify frame
>> 2. Verification state handling
>> 3. Send and receive response frame
>>
>> Tested by triggering verification handshake:
>> $ sudo ethtool --set-mm enp1s0 pmac-enabled on
>> $ sudo ethtool --set-mm enp1s0 tx-enabled on
>> $ sudo ethtool --set-mm enp1s0 verify-enabled on
>>
>> Note that Ethtool API requires enabling "pmac-enabled on" and
>> "tx-enabled on" before "verify-enabled on" can be issued.
>>
>> After the upcoming patch ("igc: Add support to get MAC Merge data via
>> ethtool") is implemented, verification status can be checked using:
>> $ ethtool --show-mm enp1s0
>>    MAC Merge layer state for enp1s0:
>>    pMAC enabled: on
>>    TX enabled: on
>>    TX active: on
>>    TX minimum fragment size: 252
>>    RX minimum fragment size: 252
>>    Verify enabled: on
>>    Verify time: 128
>>    Max verify time: 128
>>    Verification status: SUCCEEDED
>>
>> Co-developed-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
>> ---
> 
> Am I missing something, or this does not handle link state changes,
> where the verification should restart on each link up? (maybe the old
> link partner didn't support FPE and the new one does, or vice versa)
> 
> Either I don't follow the link between igc_watchdog_task() and any
> verification related task, or it doesn't exist.

The latter. I missed this "link state changes" interaction, will rework, 
thanks.

> Anyway, while browsing through this software implementation of a
> verification process, I cannot help but think we'd be making a huge
> mistake to allow each driver to reimplement it on its own. We just
> recently got stmmac to do something fairly clean, with the help and
> great perseverence of Furong Xu (now copied).
> 
> I spent a bit of time extracting stmmac's core logic and putting it in
> ethtool. If Furong had such good will so as to regression-test the
> attached patch, do you think you could use this as a starting place
> instead, and implement some ops and call some library methods, instead
> of writing the entire logic yourself?

Totally agree with moving it to a layer reusable by any driver. Thank you 
so much for the skeleton patch implementing it in ethtool — I’ll expand on 
it from here.



