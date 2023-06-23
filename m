Return-Path: <bpf+bounces-3328-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F0173C4CB
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 01:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC1171C21310
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 23:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BF26FD3;
	Fri, 23 Jun 2023 23:29:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DC4611C;
	Fri, 23 Jun 2023 23:29:33 +0000 (UTC)
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FC9D3;
	Fri, 23 Jun 2023 16:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687562972; x=1719098972;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=B/7dhzNJENs6r+cgb285R2fYdaedgJJSvCxvIsoVpQI=;
  b=AixOIaBVo83PNgHGSbaQkJuFjNfRJ+k70UE4AKZZ5EMYxqBwuAG0m+xS
   dIyO0dh1OaUxKHNvQqGFDxCnkadrvDMBzoSxcZn5QTj+GHYOBFx2cI9uq
   jwmwmBdReKfUNDFH9IY1f10GiRIt9t5/KPdqYJLRodd6SQQaBXRRxv+DT
   CS/fqeoTDKUkqed7BKjqFVpoiQvixuHIvdtvV5Ilsif38cx4I/PXGu4Lw
   ZTYJCrilTYfx/KiVXAZwTQdbXvUBIdydqsqIMjKuOii9gG1dOGK3cmhQb
   nf7FzGafxJ1MHw54hEldcRyKGfbE6Tx4wFkt35Tp5yH59DLqz4EdqKwNf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="424566773"
X-IronPort-AV: E=Sophos;i="6.01,153,1684825200"; 
   d="scan'208";a="424566773"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 16:29:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="860036574"
X-IronPort-AV: E=Sophos;i="6.01,153,1684825200"; 
   d="scan'208";a="860036574"
Received: from dwisnomi-mobl.amr.corp.intel.com (HELO vcostago-mobl3) ([10.212.223.154])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 16:29:30 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC bpf-next v2 06/11] net: veth: Implement devtx timestamp
 kfuncs
In-Reply-To: <20230621170244.1283336-7-sdf@google.com>
References: <20230621170244.1283336-1-sdf@google.com>
 <20230621170244.1283336-7-sdf@google.com>
Date: Fri, 23 Jun 2023 16:29:29 -0700
Message-ID: <87edm1rc4m.fsf@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Stanislav Fomichev <sdf@google.com> writes:

> Have a software-based example for kfuncs to showcase how it
> can be used in the real devices and to have something to
> test against in the selftests.
>
> Both path (skb & xdp) are covered. Only the skb path is really
> tested though.
>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

Not really related to this patch, but to how it would work with
different drivers/hardware.

In some of our hardware (the ones handled by igc/igb, for example), the
timestamp notification comes some time after the transmit completion
event.

From what I could gather, the idea would be for the driver to "hold" the
completion until the timestamp is ready and then signal the completion
of the frame. Is that right?


Cheers,
-- 
Vinicius

