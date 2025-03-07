Return-Path: <bpf+bounces-53529-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FCDA55E3E
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 04:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 125DA17229C
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 03:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BEE18E02A;
	Fri,  7 Mar 2025 03:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eVKYI77C"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413471624F7;
	Fri,  7 Mar 2025 03:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741317686; cv=none; b=t9CY0pdxW3F86slvR5FgkNr6rjw3Pog+dqmQ9BhYZ3ekczrKKeHSWEMKeg1psRslPkxiLOQfAcxix+Nlk4yQXlXgXMpit1BPln4h1dQShKyvGXQ9JrUbHKqcn4AIfgnZp+DRZzdunYdf0uEU4QXwyg7Kb+aNSq8Ut1ZxMBAC634=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741317686; c=relaxed/simple;
	bh=Jg5XeRxyuKD825uDbJYMZSOpqP9zMmh8t5nyw3/cSXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Au7scVnqTOpO7MiaA+1usvUlKfKL3O2HbDvAECqxFG201xVpW/BRXkJSRxiWkWws5v3/tQFM60mwtvKY5R03e983hMORLwYMYkf9P9aGZ9VjGqIOgqiFhIpIwYkEjR6BljbmrdUKs5tJI+rj+1kVZxrU00+n6fwBd61mqmSVaSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eVKYI77C; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741317684; x=1772853684;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Jg5XeRxyuKD825uDbJYMZSOpqP9zMmh8t5nyw3/cSXk=;
  b=eVKYI77CQg1VBIAf3OxuOQrecRd1/4XNcA6wNVhduzIa7gX9tb5hf+Vu
   k9i6sqD8EQzt5uLhJ7LZ4ZDpO6FNEaw8jYbOCYKOh80+WJm+qZmWQrJwV
   Cit4b+ZOWvSjS4ZM/Xx368Uek4dio7dQJUK2agC17J6ARiioZRQ93hlUb
   sEpFfS3ZLcNDyUGqakmanJAmSxVSuMkAQimAZ0TFyMhv8/ldc/5ygpw+y
   FFwAYIYIP3lnCD+cUckJG9nmRV/48zOD28NQ8qSragERDKxpRPNf1AEaA
   zftZQxxU0h8593rqSZeIiGc4SsPI+Oe/Or7XcOhV79q1AfTzLgE+flQMZ
   g==;
X-CSE-ConnectionGUID: 4a2FtoJwRoeo7X8ccIL9pg==
X-CSE-MsgGUID: AVofDC1bT7S0wIxXX1BV/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="45164185"
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; 
   d="scan'208";a="45164185"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 19:21:23 -0800
X-CSE-ConnectionGUID: iDlWGXgBRa+qU7VDX2G/zg==
X-CSE-MsgGUID: jWEeBpZ0ToCaX0rjX89xkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; 
   d="scan'208";a="119388873"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.247.100.177]) ([10.247.100.177])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 19:20:57 -0800
Message-ID: <df5f2ff0-2ead-4074-a40e-8a2fc9b63339@linux.intel.com>
Date: Fri, 7 Mar 2025 11:20:53 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v8 11/11] igc: add support to get frame
 preemption statistics via ethtool
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Furong Xu <0x1207@gmail.com>,
 Russell King <rmk+kernel@armlinux.org.uk>,
 Serge Semin <fancer.lancer@gmail.com>,
 Xiaolei Wang <xiaolei.wang@windriver.com>,
 Suraj Jaiswal <quic_jsuraj@quicinc.com>,
 Kory Maincent <kory.maincent@bootlin.com>, Gal Pressman <gal@nvidia.com>,
 Jesper Nilsson <jesper.nilsson@axis.com>,
 Choong Yong Liang <yong.liang.choong@linux.intel.com>,
 Chwee-Lin Choong <chwee.lin.choong@intel.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
References: <20250305130026.642219-1-faizal.abdul.rahim@linux.intel.com>
 <20250305130026.642219-1-faizal.abdul.rahim@linux.intel.com>
 <20250305130026.642219-12-faizal.abdul.rahim@linux.intel.com>
 <20250305130026.642219-12-faizal.abdul.rahim@linux.intel.com>
 <20250306004809.q2x565rys5zja6kh@skbuf>
Content-Language: en-US
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <20250306004809.q2x565rys5zja6kh@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/3/2025 8:48 am, Vladimir Oltean wrote:
> On Wed, Mar 05, 2025 at 08:00:26AM -0500, Faizal Rahim wrote:
>> +/* Received out of order packets with SMD-C */
>> +#define IGC_PRMEXCPRCNT_OOO_SMDC			0x000000FF
>> +/* Received out of order packets with SMD-C and wrong Frame CNT */
>> +#define IGC_PRMEXCPRCNT_OOO_FRAME_CNT			0x0000FF00
>> +/* Received out of order packets with SMD-C and wrong Frag CNT */
>> +#define IGC_PRMEXCPRCNT_OOO_FRAG_CNT			0x00FF0000
>> +/* Received packets with SMD-S and wrong Frag CNT and Frame CNT */
>> +#define IGC_PRMEXCPRCNT_MISS_FRAME_FRAG_CNT		0xFF000000
>>   
>> +/**
>> + * igc_ethtool_get_frame_ass_error - Get the frame assembly error count.
>> + * @reg_value: Register value for IGC_PRMEXCPRCNT
>> + * Return: The count of frame assembly errors.
>> + */
>> +static u64 igc_ethtool_get_frame_ass_error(u32 reg_value)
>> +{
>> +	u32 ooo_frame_cnt, ooo_frag_cnt; /* Out of order statistics */
>> +	u32 miss_frame_frag_cnt;
>> +
>> +	ooo_frame_cnt = FIELD_GET(IGC_PRMEXCPRCNT_OOO_FRAME_CNT, reg_value);
>> +	ooo_frag_cnt = FIELD_GET(IGC_PRMEXCPRCNT_OOO_FRAG_CNT, reg_value);
>> +	miss_frame_frag_cnt = FIELD_GET(IGC_PRMEXCPRCNT_MISS_FRAME_FRAG_CNT, reg_value);
>> +
>> +	return ooo_frame_cnt + ooo_frag_cnt + miss_frame_frag_cnt;
>> +}
> 
> These counters are quite small (8 bits each). What is their behavior
> once they reach 255? Saturate? Truncate? Do they clear on read?
> 
Hi Vladimir,

These are part of the statistic registers, which in IGC, reset upon read. 
When they reach their maximum value, each field remain at 0xFF.



