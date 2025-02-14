Return-Path: <bpf+bounces-51552-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECA4A35A8D
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 10:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 503A63AD5EC
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 09:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2D9245AE1;
	Fri, 14 Feb 2025 09:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ViFKXovg"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0868149C7D;
	Fri, 14 Feb 2025 09:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739526214; cv=none; b=X3eZruUpOMiAiaU2lLbdS9XvSVwpfBK6m7udDQBETqFjSlCjaFQIyXnIiS3fSRkXAYvL9ZwZ3TtBmIF+pYUJQhimVRCk6AmwSiz9eKmyEFdM6zIcZIOaf3ZJcIn7ao+Zmo+QiwYwW6DR3TIVIh3x6xoJnFIS2PVAJg8c4x6VQU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739526214; c=relaxed/simple;
	bh=zLq34zyZ+vn2x8EHLG71uh1H2EfQ4PWpqK69Hy66e7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IKFGWwGtU1z85/o7wpfkp/hn/QqPFHsO8bAv1RYWBtvnJfKSqtfBjeQYQHefToCxdB+Db31x9QeSmkKmMyQdLbWrSO0JSi8rhV9gWQVz/X4RwgQmo94dORIS6SgzBKdl8jIgRT1R+cBDviUeBHlxWzr14wFxzSnQnoYgqEj/42A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ViFKXovg; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739526212; x=1771062212;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zLq34zyZ+vn2x8EHLG71uh1H2EfQ4PWpqK69Hy66e7w=;
  b=ViFKXovgOXOFScFg8+GYrAxPhRy9KrENocku7RpenrL9BzfXvYfaAZRg
   jQBm7hnEPZCmZFwxjmlZhA1z7C884dKiyWJRzLl8bO3TkrMIBK4CjR3kQ
   iqurHJTYsCdnfougLXc2YPBCsTovqq8GIgRYMPsOzAkv0cquC2S4DIMU+
   oOMT3Z1Oe+9e+snzMOfYflKKKQ5C+P8mZeM5socKzbvrqA9r2vppzVmzq
   WVFF52dfBY+NX/AymnmuoDXRS5tYSoHjzijwYsnEPB/LzYD6/3AYtu8Ig
   DU1IYpzd/u+Tz0eUOkYtwsCAcpc0pPEI4dRofM6FLOeWYPi9UrF1cONln
   g==;
X-CSE-ConnectionGUID: Kq6TxkY1RuiUtW2hdM1HLw==
X-CSE-MsgGUID: 37DqnfFoQ02HpGKQAJ6h4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="44197299"
X-IronPort-AV: E=Sophos;i="6.13,285,1732608000"; 
   d="scan'208";a="44197299"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 01:43:30 -0800
X-CSE-ConnectionGUID: ZO0UWXkJQOin2e28wbPaEw==
X-CSE-MsgGUID: Hg2vL6gvSzaFtD29bl+/3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118036852"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.247.89.75]) ([10.247.89.75])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 01:43:22 -0800
Message-ID: <641ab972-e110-4af2-ad9b-6688cee56562@linux.intel.com>
Date: Fri, 14 Feb 2025 17:43:19 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v4 0/9] igc: Add support for Frame Preemption
 feature in IGC
To: Kurt Kanzenbach <kurt@linutronix.de>,
 Vladimir Oltean <vladimir.oltean@nxp.com>
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
 Andrew Halaney <ahalaney@redhat.com>,
 Choong Yong Liang <yong.liang.choong@linux.intel.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
References: <20250210070207.2615418-1-faizal.abdul.rahim@linux.intel.com>
 <20250210070207.2615418-1-faizal.abdul.rahim@linux.intel.com>
 <20250212220121.ici3qll66pfoov62@skbuf>
 <b19357dc-590d-458c-9646-ee5993916044@linux.intel.com>
 <87cyfmnjdh.fsf@kurt.kurt.home>
 <5902cc28-a649-4ae9-a5ba-83aa265abaf8@linux.intel.com>
 <20250213130003.nxt2ev47a6ppqzrq@skbuf>
 <1c981aa1-e796-4c53-9853-3eae517f2f6d@linux.intel.com>
 <877c5undbg.fsf@kurt.kurt.home> <20250213184613.cqc2zhj2wkaf5hn7@skbuf>
 <87v7td3bi1.fsf@kurt.kurt.home>
 <b7740709-6b4a-4f44-b4d7-e265bb823aca@linux.intel.com>
 <874j0wrjk2.fsf@kurt.kurt.home>
Content-Language: en-US
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <874j0wrjk2.fsf@kurt.kurt.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 14/2/2025 4:56 pm, Kurt Kanzenbach wrote:
> On Fri Feb 14 2025, Abdul Rahim, Faizal wrote:
>> On 14/2/2025 3:12 am, Kurt Kanzenbach wrote:
>>> On Thu Feb 13 2025, Vladimir Oltean wrote:
>>>> So, confusingly to me, it seems like one operating mode is fundamentally
>>>> different from the other, and something will have to change if both will
>>>> be made to behave the same. What will change? You say mqprio will behave
>>>> like taprio, but I think if anything, mqprio is the one which does the
>>>> right thing, in igc_tsn_tx_arb(), and taprio seems to use the default Tx
>>>> arbitration scheme?
>>>
>>> Correct. taprio is using the default scheme. mqprio configures it to
>>> what ever the user provided (in igc_tsn_tx_arb()).
>>>
>>>> I don't think I'm on the same page as you guys, because to me, it is
>>>> just odd that the P traffic classes would be the first ones with
>>>> mqprio, but the last ones with taprio.
>>>
>>> I think we are on the same page here. At the end both have to behave the
>>> same. Either by using igc_tsn_tx_arb() for taprio too or only using the
>>> default scheme for both (and thereby keeping broken_mqprio). Whatever
>>> Faizal implements I'll match the behavior with mqprio.
>>>
>>
>> Hi Kurt & Vladimir,
>>
>> After reading Vladimir's reply on tc, hw queue, and socket priority mapping
>> for both taprio and mqprio, I agree they should follow the same priority
>> scheme for consistency—both in code and command usage (i.e., taprio,
>> mqprio, and fpe in both configurations). Since igc_tsn_tx_arb() ensures a
>> standard mapping of tc, socket priority, and hardware queue priority, I'll
>> enable taprio to use igc_tsn_tx_arb() in a separate patch submission.
> 
> There's one point to consider here: igc_tsn_tx_arb() changes the mapping
> between priorities and Tx queues. I have no idea how many people rely on
> the fact that queue 0 has always the highest priority. For example, it
> will change the Tx behavior for schedules which open multiple traffic
> classes at the same time. Users may notice.

Yeah, I was considering the impact on existing users too. I hadn’t given it 
much thought initially and figured they’d just need to adapt to the 
changes, but now that I think about it, properly communicating this would 
be tough. taprio on igc (i225, i226) has been around for a while, so a lot 
of users would be affected.

> OTOH changing mqprio to the broken_mqprio model is easy, because AFAIK
> there's only one customer using this.
> 

Hmmmm, now I’m leaning toward keeping taprio as is (hw queue 0 highest 
priority) and having mqprio follow the default priority scheme (aka 
broken_mqprio). Even though it’s not the norm, the impact doesn’t seem 
worth the gain. Open to hearing others' thoughts.


