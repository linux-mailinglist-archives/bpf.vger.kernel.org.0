Return-Path: <bpf+bounces-3521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A611673F095
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 03:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 397AB280F64
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 01:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B676A47;
	Tue, 27 Jun 2023 01:38:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EB5A23;
	Tue, 27 Jun 2023 01:38:42 +0000 (UTC)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367AE10FF;
	Mon, 26 Jun 2023 18:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687829921; x=1719365921;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=lFXEDX8rSLqvIeeUP6Xgm1z7xi2mZaQYDH77RRje1w0=;
  b=Gwr1WGjKv0Z9GiliH3gTNvbc8b+y9z2AgFLZExK00rU+dzLomo2Q4e8a
   5Ofk/ct/eQcLhkj8Y9EYWKVOCL6ZYqC5zZniDxU6rtmoKm3Ei+TvmSMyU
   TF4bMMfA+0ntQvGfh/WoORFGUnjIZwrHIfZ1iJJvAZ9MsebXVcq5SRUMQ
   DqtX4OuUjqWefO0+8BG6G8RlnxL6q3YFCDdXkSrvaVT9C9oPUiRjd0oaj
   pR7GBO1YV3gXr270u9zJo9/PtvprbaKjLb4oFH13MImvCv8uJ+rczc2Ex
   si66TrStONcUe6HOOd3/EtZ7ID2hvldtOhy41GGByGsc22A7SkxtDNz0x
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="391883720"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="391883720"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 18:38:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="719595265"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="719595265"
Received: from timot11x-mobl3.amr.corp.intel.com (HELO vcostago-mobl3) ([10.209.78.36])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 18:38:40 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC bpf-next v2 06/11] net: veth: Implement devtx timestamp
 kfuncs
In-Reply-To: <CAKH8qBvnqOvCnp2C=hmPGwCcEz4UkuE9nod2N9sNmpPve9n_CQ@mail.gmail.com>
References: <20230621170244.1283336-1-sdf@google.com>
 <20230621170244.1283336-7-sdf@google.com> <87edm1rc4m.fsf@intel.com>
 <CAKH8qBt1GHnY2jVac--xymN-ch8iCDftiBckzp9wvTJ7k-3zAg@mail.gmail.com>
 <874jmtrij4.fsf@intel.com>
 <CAKH8qBvnqOvCnp2C=hmPGwCcEz4UkuE9nod2N9sNmpPve9n_CQ@mail.gmail.com>
Date: Mon, 26 Jun 2023 18:38:39 -0700
Message-ID: <87y1k5ptuo.fsf@intel.com>
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
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Stanislav Fomichev <sdf@google.com> writes:

> On Mon, Jun 26, 2023 at 3:00=E2=80=AFPM Vinicius Costa Gomes
> <vinicius.gomes@intel.com> wrote:
>>
>> Stanislav Fomichev <sdf@google.com> writes:
>>
>> > On Fri, Jun 23, 2023 at 4:29=E2=80=AFPM Vinicius Costa Gomes
>> > <vinicius.gomes@intel.com> wrote:
>> >>
>> >> Stanislav Fomichev <sdf@google.com> writes:
>> >>
>> >> > Have a software-based example for kfuncs to showcase how it
>> >> > can be used in the real devices and to have something to
>> >> > test against in the selftests.
>> >> >
>> >> > Both path (skb & xdp) are covered. Only the skb path is really
>> >> > tested though.
>> >> >
>> >> > Cc: netdev@vger.kernel.org
>> >> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
>> >>
>> >> Not really related to this patch, but to how it would work with
>> >> different drivers/hardware.
>> >>
>> >> In some of our hardware (the ones handled by igc/igb, for example), t=
he
>> >> timestamp notification comes some time after the transmit completion
>> >> event.
>> >>
>> >> From what I could gather, the idea would be for the driver to "hold" =
the
>> >> completion until the timestamp is ready and then signal the completion
>> >> of the frame. Is that right?
>> >
>> > Yeah, that might be the option. Do you think it could work?
>> >
>>
>> For the skb and XDP cases, yeah, just holding the completion for a while
>> seems like it's going to work.
>>
>> XDP ZC looks more complicated to me, not sure if it's only a matter of
>> adding something like:
>
> [..]
>
>> void xsk_tx_completed_one(struct xsk_buff_pool *pool, struct xdp_buff *x=
dp);
>>
>> Or if more changes would be needed. I am trying to think about the case
>> that the user sent a single "timestamp" packet among a bunch of
>> "non-timestamp" packets.
>
> Since you're passing xdp_buff as an argument I'm assuming that is
> suggesting out-of-order completions?
> The completion queue is a single index, we can't do ooo stuff.
> So you'd have to hold a bunch of packets until you receive the
> timestamp completion; after this event, you can complete the whole
> batch (1 packet waiting for the timestamp + a bunch that have been
> transmitted afterwards but were still unacknowleged in the queue).
>
> (lmk if I've misinterpreted)

Not at all, it was me that wasn't aware that out-of-order completions
were out of the picture.

So, yeah, what you are proposing, accumulating the pending completions
while there's a pending timestamp request, seems the only way to go.

The logic seems simple enough, but the fact that the "timestamp ready"
interrupt is not associated with any queue seems that it will make
things a bit "interesting" to get it right :-)=20

But I don't have any better suggestions.


Thank you,
--=20
Vinicius

