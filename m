Return-Path: <bpf+bounces-15074-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B15D7EB6CF
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 20:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F2132812B6
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 19:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732BB219FC;
	Tue, 14 Nov 2023 19:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="bJGPhLmt"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AE31D684;
	Tue, 14 Nov 2023 19:19:55 +0000 (UTC)
X-Greylist: delayed 174 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Nov 2023 11:19:54 PST
Received: from mx14lb.world4you.com (mx14lb.world4you.com [81.19.149.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEF2102;
	Tue, 14 Nov 2023 11:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=skwkjM3f099hX9S0QFbf+mqzZWgdiZmYAe3qnEU6yeg=; b=bJGPhLmtRcLL5FJBfPOrAVD2n7
	pofEY0fr0xgnhjPHqlNhnxfyPatRokOQgK8EtSTPIIQxZYGg/k0tNQdOuRHAGFQNbEK1WuVdkXdNn
	gYQV0yAmUuYWe5tZAZ9QHZdH1EBmwNMD5BdM0Qtdso381+BqIPjKUWCCRH5oWtoMUOu4=;
Received: from [88.117.50.201] (helo=[10.0.0.160])
	by mx14lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1r2ywr-0004Cc-2a;
	Tue, 14 Nov 2023 20:19:45 +0100
Message-ID: <a9801ebb-6c37-45a9-9b75-61f07577beb6@engleder-embedded.com>
Date: Tue, 14 Nov 2023 20:19:45 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] igc: Add support for PTP .getcyclesx64()
Content-Language: en-US
To: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>, sasha.neftin@intel.com,
 richardcochran@gmail.com, maciej.fijalkowski@intel.com,
 magnus.karlsson@intel.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, bpf@vger.kernel.org,
 Naama Meir <naamax.meir@linux.intel.com>
References: <20231114183640.1303163-1-anthony.l.nguyen@intel.com>
 <20231114183640.1303163-3-anthony.l.nguyen@intel.com>
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <20231114183640.1303163-3-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 14.11.23 19:36, Tony Nguyen wrote:
> From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> 
> Add support for using Timer 1 (i225/i226 have 4 timer registers) as a
> free-running clock (the "cycles" clock) in addition to Timer 0 (the
> default, "adjustable clock"). The objective is to allow taprio/etf
> offloading to coexist with PTP vclocks.
> 
> Besides the implementation of .getcyclesx64() for i225/i226, to keep
> timestamping working when vclocks are in use, we also need to add
> support for TX and RX timestamping using the free running timer, when
> the requesting socket is bound to a vclock.
> 
> On the RX side, i225/i226 can be configured to store the values of two
> timers in the received packet metadata area, so it's a matter of
> configuring the right registers and retrieving the right timestamp.
> 
> The TX is a bit more involved because the hardware stores a single
> timestamp (with the selected timer in the TX descriptor) into one of
> the timestamp registers.
> 
> Note some changes at how the timestamps are done for RX, the
> conversion and adjustment of timestamps are now done closer to the
> consumption of the timestamp instead of near the reception.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Tested-by: Naama Meir <naamax.meir@linux.intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc.h         | 21 +++++++-
>   drivers/net/ethernet/intel/igc/igc_base.h    |  4 ++
>   drivers/net/ethernet/intel/igc/igc_defines.h |  2 +
>   drivers/net/ethernet/intel/igc/igc_main.c    | 55 ++++++++++++++------
>   drivers/net/ethernet/intel/igc/igc_ptp.c     | 50 +++++++++++-------
>   drivers/net/ethernet/intel/igc/igc_regs.h    |  5 ++
>   6 files changed, 101 insertions(+), 36 deletions(-)

I'm happy to see a second driver supporting this functionality!

Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>

