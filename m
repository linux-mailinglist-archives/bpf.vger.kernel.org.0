Return-Path: <bpf+bounces-3500-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA8473EE38
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 00:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D75A1C202DC
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 22:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA46315ADD;
	Mon, 26 Jun 2023 22:02:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3E2154AB;
	Mon, 26 Jun 2023 22:02:54 +0000 (UTC)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390A73595;
	Mon, 26 Jun 2023 15:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687816946; x=1719352946;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=QK3fdaxZuor5qa3Z/btpNB2OXP4VL4lcuTWSbkk2O98=;
  b=Vo7+flBjeR53wETWhYnz3XTthbpwXDdnqmSKb16d1nqxjUfkN5Z+oHco
   xUby4BUXtFkaE7o2j97gn8Y146e9QaXba31p98hMQTChIdYN5Mux30+5K
   wpZ5TDfqOJp/QS9M6I5qVwmv+t17YhP/leXIBd96C9WS4TOt1r9oz/Kod
   0fleN37eZseHWcP8YthO0LpkXKZJch79qeTTF6A/eH4X3FDiPK/QkEK6l
   q5hDhzWaIEDEmEKMyYK1w1akm5mM1jMRbxF37j1hdOAPRrLi94BWvQweF
   oVUF11enMEKvsIn7WH9KpjsErJgvcI8YxLy7WnmuUC53CO4Z/ClyX+V49
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="341740629"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="341740629"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 15:00:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="710376128"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="710376128"
Received: from timot11x-mobl3.amr.corp.intel.com (HELO vcostago-mobl3) ([10.209.78.36])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 15:00:16 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC bpf-next v2 06/11] net: veth: Implement devtx timestamp
 kfuncs
In-Reply-To: <CAKH8qBt1GHnY2jVac--xymN-ch8iCDftiBckzp9wvTJ7k-3zAg@mail.gmail.com>
References: <20230621170244.1283336-1-sdf@google.com>
 <20230621170244.1283336-7-sdf@google.com> <87edm1rc4m.fsf@intel.com>
 <CAKH8qBt1GHnY2jVac--xymN-ch8iCDftiBckzp9wvTJ7k-3zAg@mail.gmail.com>
Date: Mon, 26 Jun 2023 15:00:15 -0700
Message-ID: <874jmtrij4.fsf@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Stanislav Fomichev <sdf@google.com> writes:

> On Fri, Jun 23, 2023 at 4:29=E2=80=AFPM Vinicius Costa Gomes
> <vinicius.gomes@intel.com> wrote:
>>
>> Stanislav Fomichev <sdf@google.com> writes:
>>
>> > Have a software-based example for kfuncs to showcase how it
>> > can be used in the real devices and to have something to
>> > test against in the selftests.
>> >
>> > Both path (skb & xdp) are covered. Only the skb path is really
>> > tested though.
>> >
>> > Cc: netdev@vger.kernel.org
>> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
>>
>> Not really related to this patch, but to how it would work with
>> different drivers/hardware.
>>
>> In some of our hardware (the ones handled by igc/igb, for example), the
>> timestamp notification comes some time after the transmit completion
>> event.
>>
>> From what I could gather, the idea would be for the driver to "hold" the
>> completion until the timestamp is ready and then signal the completion
>> of the frame. Is that right?
>
> Yeah, that might be the option. Do you think it could work?
>

For the skb and XDP cases, yeah, just holding the completion for a while
seems like it's going to work.

XDP ZC looks more complicated to me, not sure if it's only a matter of
adding something like:

void xsk_tx_completed_one(struct xsk_buff_pool *pool, struct xdp_buff *xdp);

Or if more changes would be needed. I am trying to think about the case
that the user sent a single "timestamp" packet among a bunch of
"non-timestamp" packets.


Cheers,
--=20
Vinicius

