Return-Path: <bpf+bounces-20999-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F614846661
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 04:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AD921F278AD
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 03:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850CDDF5D;
	Fri,  2 Feb 2024 03:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BYE8S6Lj"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1F0D289;
	Fri,  2 Feb 2024 03:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706843274; cv=none; b=P3iA9J1B5XlKWwW4BvPsbcDxe+7jtLfYLlkUyYhwyW+pvL4P+CSkc7WrVrXMGhtMabdktq6d8S5Gea9S3LJqTCAEz1csERHSE5JmIoKXW0hKDV0w9n+8tGvaxw9ItFAZciLTwywIEbP7jw9Eh//7gQ3f+6D/jWnSPpe0dZRp6uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706843274; c=relaxed/simple;
	bh=obWK63Zy5XJ19imquZEyMwnqRVC/TkO3K+PmbgWqdY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TW6DWRBdIabzMYSI3bNPy1E1esgij+m/vyZuMi054omi05GxbYLx0EK9FPxP4o9Jyo26Buuo0lBmM61+X7b1P0vjRqtJhZ18IC4TrzpjjYJpKFJed0DtssA4vR9skB/qZbVbe8+Xhqpruqdm0kRb0QQUfbk3c40hw28+7c6EM0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BYE8S6Lj; arc=none smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706843272; x=1738379272;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=obWK63Zy5XJ19imquZEyMwnqRVC/TkO3K+PmbgWqdY0=;
  b=BYE8S6LjLkHyCNhk2dGBKMYvEP879uDHxCSlYWrNWH3umFf2yXbSj5oB
   7PW3ug5fIZmpGuRNnWPYkfIcg6AkYAbPErFSUNuch1QDE6QsUsgZs7jiW
   o8WKRxXX2OV3w8CJ6pkmf8oPzvXv6c90VXSuHgTvUE1raIJqVJzH/vQXC
   R8R2FdLqA/G613qqfh2woRidkwDXF3Oi85pkVVQuFXevMZC+ZdOEqisXe
   Kw3dJI6xnMIYcLuDdOMFb8jKbtqgZx+v1civhhvVkVKQSiH2VbRkhwmrl
   aKnkb+e9yT3YG2jjgnAAqPQwPOqZuDlwac28lxtzmysOpHEtJmGCwJrVH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="468284161"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="468284161"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 19:07:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="859304289"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="859304289"
Received: from choongyo-mobl.gar.corp.intel.com (HELO [10.247.22.55]) ([10.247.22.55])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 19:07:40 -0800
Message-ID: <46d14e3e-a334-447f-a25c-17ed58170741@linux.intel.com>
Date: Fri, 2 Feb 2024 11:07:40 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 4/5] net: stmmac: enable Intel mGbE 1G/2.5G
 auto-negotiation support
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: Serge Semin <fancer.lancer@gmail.com>,
 Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
 David E Box <david.e.box@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>,
 Jose Abreu <Jose.Abreu@synopsys.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Wong Vee Khee
 <veekhee@apple.com>, Jon Hunter <jonathanh@nvidia.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Revanth Kumar Uppala <ruppala@nvidia.com>,
 Shenwei Wang <shenwei.wang@nxp.com>,
 Andrey Konovalov <andrey.konovalov@linaro.org>,
 Jochen Henneberg <jh@henneberg-systemdesign.com>,
 David E Box <david.e.box@intel.com>, Andrew Halaney <ahalaney@redhat.com>,
 Simon Horman <simon.horman@corigine.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org,
 linux-hwmon@vger.kernel.org, bpf@vger.kernel.org,
 Voon Wei Feng <weifeng.voon@intel.com>,
 Tan Tee Min <tee.min.tan@linux.intel.com>,
 Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
 Lai Peter Jun Ann <jun.ann.lai@intel.com>
References: <20230921121946.3025771-1-yong.liang.choong@linux.intel.com>
 <20230921121946.3025771-5-yong.liang.choong@linux.intel.com>
 <jmq54bskx4zd75ay4kf5pcdo6wnz72pxzfo5ivevleef4scucr@uw4fkfs64f3c>
 <26568944-563d-4911-8f6f-14c0162db6e9@linux.intel.com>
 <07a4aa8e-800c-4564-81c8-7cfcdddf1379@lunn.ch>
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
In-Reply-To: <07a4aa8e-800c-4564-81c8-7cfcdddf1379@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 29/1/2024 9:41 pm, Andrew Lunn wrote:
> Hi Choong
> 
> Please trim the text when replying. It can be hard to find actually
> replies when having to do lots and lots of page downs. Just give the
> context needed to understand your reply.
> 
> 	Andrew
Hi Andrew,

Thank you for the feedback.
I will trim the message next time.

