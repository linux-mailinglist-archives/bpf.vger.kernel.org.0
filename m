Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C744FC0E7
	for <lists+bpf@lfdr.de>; Mon, 11 Apr 2022 17:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348012AbiDKPhy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Apr 2022 11:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245017AbiDKPhx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Apr 2022 11:37:53 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FACB165BD;
        Mon, 11 Apr 2022 08:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649691338; x=1681227338;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xb409+a6wzjn9TrSE0bssz5Ds6/xnTzG4w9HkLA3hJM=;
  b=BCzmuo1jcdndbFWLsQ9IaFQRGjiWNzWWbu6UnKAf2nCOkceS/LaW+Ewp
   06t91v8zbhIgrabpryG/5WVzSwfwCI51lRxHyEAOhSNbhF+Iu0BvCb/I0
   Iql8qouJhQDdVKvb9FWx/RN6lb4Vu87cm0H2THJLtWR9Oc4LB0VDUK6Oq
   2Gr/Z08Z8ch//h69Re9ON9Mv5ObfGK2f9a5VcFV4rvP3hp9QvVeAYh9ES
   NwdorR4i3YugtrJOkMww7xkiu1MXFJkGWmMh4Cg4VvWDxhreTIceb7SFa
   ZoFZvI4x4RQLC3D5UhbbMvDDa7aqDRc4Fj0Qauco5iw3/LrQbd7OIjbr/
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="348583594"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="348583594"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 08:35:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="611028784"
Received: from boxer.igk.intel.com (HELO boxer) ([10.102.20.173])
  by fmsmga008.fm.intel.com with ESMTP; 11 Apr 2022 08:35:35 -0700
Date:   Mon, 11 Apr 2022 17:35:34 +0200
From:   Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To:     Maxim Mikityanskiy <maximmi@nvidia.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        magnus.karlsson@intel.com, bjorn@kernel.org,
        netdev@vger.kernel.org, brouer@redhat.com,
        alexandr.lobakin@intel.com, Tariq Toukan <tariqt@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH bpf-next 00/10] xsk: stop softirq processing on full XSK
 Rx queue
Message-ID: <YlRKxh0xKDfOHvgn@boxer>
References: <20220405110631.404427-1-maciej.fijalkowski@intel.com>
 <8a81791e-342e-be8b-fc96-312f30b44be6@nvidia.com>
 <Yk/7mkNi52hLKyr6@boxer>
 <82a1e9c1-6039-7ead-e663-2b0298f31ada@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82a1e9c1-6039-7ead-e663-2b0298f31ada@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 08, 2022 at 03:48:44PM +0300, Maxim Mikityanskiy wrote:
> On 2022-04-08 12:08, Maciej Fijalkowski wrote:
> > On Thu, Apr 07, 2022 at 01:49:02PM +0300, Maxim Mikityanskiy wrote:
> > > On 2022-04-05 14:06, Maciej Fijalkowski wrote:
> > > > Hi!
> > > > 
> > > > This is a revival of Bjorn's idea [0] to break NAPI loop when XSK Rx
> > > > queue gets full which in turn makes it impossible to keep on
> > > > successfully producing descriptors to XSK Rx ring. By breaking out of
> > > > the driver side immediately we will give the user space opportunity for
> > > > consuming descriptors from XSK Rx ring and therefore provide room in the
> > > > ring so that HW Rx -> XSK Rx redirection can be done.
> > > > 
> > > > Maxim asked and Jesper agreed on simplifying Bjorn's original API used
> > > > for detecting the event of interest, so let's just simply check for
> > > > -ENOBUFS within Intel's ZC drivers after an attempt to redirect a buffer
> > > > to XSK Rx. No real need for redirect API extension.
> > > 
> > 
> > Hey Maxim!
> > 
> > > I believe some of the other comments under the old series [0] might be still
> > > relevant:
> > > 
> > > 1. need_wakeup behavior. If need_wakeup is disabled, the expected behavior
> > > is busy-looping in NAPI, you shouldn't break out early, as the application
> > > does not restart NAPI, and the driver restarts it itself, leading to a less
> > > efficient loop. If need_wakeup is enabled, it should be set on ENOBUFS - I
> > > believe this is the case here, right?
> > 
> > Good point. We currently set need_wakeup flag for -ENOBUFS case as it is
> > being done for failure == true. You are right that we shouldn't be
> > breaking the loop on -ENOBUFS if need_wakeup flag is not set on xsk_pool,
> > will fix!
> > 
> > > 
> > > 2. 50/50 AF_XDP and XDP_TX mix usecase. By breaking out early, you prevent
> > > further packets from being XDP_TXed, leading to unnecessary latency
> > > increase. The new feature should be opt-in, otherwise such usecases suffer.
> > 
> > Anyone performing a lot of XDP_TX (or XDP_PASS, etc) should be using the
> > regular copy-mode driver, while the zero-copy driver should be used when most
> > packets are sent up to user-space.
> 
> You generalized that easily, but how can you be so sure that all mixed use
> cases can live with the much slower copy mode? Also, how do you apply your
> rule of thumb to the 75/25 AF_XDP/XDP_TX use case? It's both "a lot of
> XDP_TX" and "most packets are sent up to user-space" at the same time.

We are not aware of a single user that has this use case. What we do know
is that we have a lot of users that care about zero packet loss
performance when redirecting to an AF_XDP socket when using the zero-copy
driver. And this work addresses one of the corner cases and therefore
makes ZC driver better overall. So we say, focus on the cases people care
about. BTW, we do have users using mainly XDP_TX, XDP_PASS and
XDP_REDIRECT, but they are all using the regular driver for a good reason.
So we should not destroy those latencies as you mention.

> 
> At the moment, the application is free to decide whether it wants zerocopy
> XDP_TX or zerocopy AF_XDP, depending on its needs. After your patchset the
> only valid XDP verdict on zerocopy AF_XDP basically becomes "XDP_REDIRECT to
> XSKMAP". I don't think it's valid to break an entire feature to speed up
> some very specific use case.

We disagree that it 'breaks an entire feature' - it is about hardening the
driver when user did not come up with an optimal combo of ring sizes vs
busy poll budget. Driver needs to be able to handle such cases in a
reasonable way. What is more, (at least Intel) zero-copy drivers are
written in a way that XDP_REDIRECT to XSKMAP is the most probable verdict
that can come out of XDP program. However, other actions are of course
supported, so with your arguments, you could even say that we currently
treat redir as 'only valid' action, which is not true. Just note that
Intel's regular drivers (copy-mode AF_XDP socket) are optimized for
XDP_PASS (as that is the default without an XDP program in place) as that
is the most probable verdict for that driver.

> 
> Moreover, in early days of AF_XDP there was an attempt to implement zerocopy
> XDP_TX on AF_XDP queues, meaning both XDP_TX and AF_XDP could be zerocopy.
> The implementation suffered from possible overflows in driver queues, thus
> wasn't upstreamed, but it's still a valid idea that potentially could be
> done if overflows are worked around somehow.
> 

That feature would be good to have, but it has not been worked on and
might never be worked on since there seems to be little interest in XDP_TX
for the zero-copy driver. This also makes your argument about disregarding
XDP_TX a bit exaggerated. As we stated before, we have not seen a use case
from a real user for this.

> > For the zero-copy driver, this opt in is not
> > necessary. But it sounds like a valid option for copy mode, though could we
> > think about the proper way as a follow up to this work?
> 
> My opinion is that the knob has to be part of initial submission, and the
> new feature should be disabled by default, otherwise we have huge issues
> with backward compatibility (if we delay it, the next update changes the
> behavior, breaking some existing use cases, and there is no way to work
> around it).
> 

We would not like to introduce knobs for every
feature/optimization/trade-off we could think of unless we really have to.
Let us keep it simple. Zero-copy is optimized for XDP_REDIRECT to an
AF_XDP socket. The regular, copy-mode driver is optimized for the case
when the packet is consumed by the kernel stack or XDP. That means that we
should not introduce this optimization for the regular driver, as you say,
but it is fine to do it for the zero-copy driver without a knob. If we
ever introduce this for the regular driver, yes, we would need a knob.

> > > 
> > > 3. When the driver receives ENOBUFS, it has to drop the packet before
> > > returning to the application. It would be better experience if your feature
> > > saved all N packets from being dropped, not just N-1.
> > 
> > Sure, I'll re-run tests and see if we can omit freeing the current
> > xdp_buff and ntc bump, so that we would come back later on to the same
> > entry.
> > 
> > > 
> > > 4. A slow or malicious AF_XDP application may easily cause an overflow of
> > > the hardware receive ring. Your feature introduces a mechanism to pause the
> > > driver while the congestion is on the application side, but no symmetric
> > > mechanism to pause the application when the driver is close to an overflow.
> > > I don't know the behavior of Intel NICs on overflow, but in our NICs it's
> > > considered a critical error, that is followed by a recovery procedure, so
> > > it's not something that should happen under normal workloads.
> > 
> > I'm not sure I follow on this one. Feature is about overflowing the XSK
> > receive ring, not the HW one, right?
> 
> Right. So we have this pipeline of buffers:
> 
> NIC--> [HW RX ring] --NAPI--> [XSK RX ring] --app--> consumes packets
> 
> Currently, when the NIC puts stuff in HW RX ring, NAPI always runs and
> drains it either to XSK RX ring or to /dev/null if XSK RX ring is full. The
> driver fulfills its responsibility to prevent overflows of HW RX ring. If
> the application doesn't consume quick enough, the frames will be leaked, but
> it's only the application's issue, the driver stays consistent.
> 
> After the feature, it's possible to pause NAPI from the userspace
> application, effectively disrupting the driver's consistency. I don't think
> an XSK application should have this power.

It already has this power when using an AF_XDP socket. Nothing new. Some
examples, when using busy-poll together with gro_flush_timeout and
napi_defer_hard_irqs you already have this power. Another example is not
feeding buffers into the fill ring from the application side in zero-copy
mode. Also, application does not have to be "slow" in order to cause the
XSK Rx queue overflow. It can be the matter of not optimal budget choice
when compared to ring lengths, as stated above.

Besides that, you are right, in copy-mode (without busy-poll), let us not
introduce this as this would provide the application with this power when
it does not have it today.

> 
> > Driver picks entries from fill ring
> > that were produced by app, so if app is slow on producing those I believe
> > this would be rather an underflow of ring, we would simply receive less
> > frames. For HW Rx ring actually being full, I think that HW would be
> > dropping the incoming frames, so I don't see the real reason to treat this
> > as critical error that needs to go through recovery.
> 
> I'll double check regarding the hardware behavior, but it is what it is. If
> an overflow moves the queue to the fault state and requires a recovery,
> there is nothing I can do about that.
> 
> A few more thoughts I just had: mlx5e shares the same NAPI instance to serve
> all queues in a channel, that includes the XSK RQ and the regular RQ. The
> regular and XSK traffic can be configured to be isolated to different
> channels, or they may co-exist on the same channel. If they co-exist, and
> XSK asks to pause NAPI, the regular traffic will still run NAPI and drop 1
> XSK packet per NAPI cycle, unless point 3 is fixed. It can also be

XSK does not pause the whole NAPI cycle, your HW XSK RQ just stops with
doing redirects to AF_XDP XSK RQ. Your regular RQ is not affected in any
way. Finally point 3 needs to be fixed.

FWIW we also support having a channel/queue vector carrying more than one
RQ that is associated with particular NAPI instance.

> reproduced if NAPI is woken up by XSK TX. Besides, (correct me if I'm wrong)
> your current implementation introduces extra latency to XSK TX if XSK RX
> asked to pause NAPI, because NAPI will be restarted anyway (by TX wakeup),
> and it could have been rescheduled by the kernel.

Again, we don't pause NAPI. Tx and Rx processing are separate.

As for Intel drivers, Tx is processed first. So even if we break at Rx due
to -ENOBUFS from xdp_do_redirect(), Tx work has already been done.

To reiterate, we agreed on fixing point 1 and 3 from your original mail.
Valid and good points.

> 
> > Am I missing something? Maybe I have just misunderstood you.
> > 
> > > 
> > > > One might ask why it is still relevant even after having proper busy
> > > > poll support in place - here is the justification.
> > > > 
> > > > For xdpsock that was:
> > > > - run for l2fwd scenario,
> > > > - app/driver processing took place on the same core in busy poll
> > > >     with 2048 budget,
> > > > - HW ring sizes Tx 256, Rx 2048,
> > > > 
> > > > this work improved throughput by 78% and reduced Rx queue full statistic
> > > > bump by 99%.
> > > > 
> > > > For testing ice, make sure that you have [1] present on your side.
> > > > 
> > > > This set, besides the work described above, also carries also
> > > > improvements around return codes in various XSK paths and lastly a minor
> > > > optimization for xskq_cons_has_entries(), a helper that might be used
> > > > when XSK Rx batching would make it to the kernel.
> > > 
> > > Regarding error codes, I would like them to be consistent across all
> > > drivers, otherwise all the debuggability improvements are not useful enough.
> > > Your series only changed Intel drivers. Here also applies the backward
> > > compatibility concern: the same error codes than were in use have been
> > > repurposed, which may confuse some of existing applications.
> > 
> > I'll double check if ZC drivers are doing something unusual with return
> > values from xdp_do_redirect(). Regarding backward comp, I suppose you
> > refer only to changes in ndo_xsk_wakeup() callbacks as others are not
> > exposed to user space? They're not crucial to me, but it improved my
> > debugging experience.
> 
> Sorry if I wasn't clear enough. Yes, I meant the wakeup error codes. We
> aren't doing anything unusual with xdp_do_redirect codes (can't say for
> other drivers, though).
> 
> Last time I wanted to improve error codes returned from some BPF helpers
> (make the errors more distinguishable), my patch was blocked because of
> backward compatibility concerns. To be on the safe side (i.e. to avoid
> further bug reports from someone who actually relied on specific codes), you
> might want to use a new error code, rather than repurposing the existing
> ones.
> 
> I personally don't have objections about changing the error codes the way
> you did if you keep them consistent across all drivers, not only Intel ones.

Got your point. So I'll either drop the patches or look through
ndo_xsk_wakeup() implementations and try to standardize the ret codes.
Hope this sounds fine.

MF
