Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2188C5A2CDD
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 18:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344760AbiHZQxB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 12:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245701AbiHZQxB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 12:53:01 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D15BB84;
        Fri, 26 Aug 2022 09:52:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C8453CE3097;
        Fri, 26 Aug 2022 16:52:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C0CC433D6;
        Fri, 26 Aug 2022 16:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661532775;
        bh=Y/uzqAIh1YcNPax6RpqdWo4bFq80gveYSsLUPXyiOXI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rhta6UATMURxluUg/NlWzY+ixrgJdnYbSk3hUq0vXNzAcTjxEB8uPnDmMvGc2T2vy
         b0zvK+jwmy/v8YJFu2VAFZX8oWH89uyVzgP3roCDdXcKuIx0lo0L2Bn1ZyU7hY7Uoi
         cfkwpAnqa70l4NJpCBDOzia74cCBSBvMJDh1kAUBUK0gTCwXJGwHvsxyWWlo1A5LF7
         zGIePKVwy41B2BM87SwkL8Y9rluSUgI9ECacG46TCC+vrHtoQYulofLRLkPcH9jNBF
         TysOa60zZqQerFnNySPOW71mOOB+0M0u07wxtsBnUuWTUOh7BdJI/faOS0/Oij6vpl
         K7X+FlA7g7w/w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 30529404A1; Fri, 26 Aug 2022 13:52:53 -0300 (-03)
Date:   Fri, 26 Aug 2022 13:52:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yonghong Song <yhs@fb.com>
Cc:     Vitaly Chikunov <vt@altlinux.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Martin Reboredo <yakoyoku@gmail.com>
Subject: Re: pahole v1.24: FAILED: load BTF from vmlinux: Invalid argument
Message-ID: <Ywj6ZcqWsz8Au6qO@kernel.org>
References: <20220825163538.vajnsv3xcpbhl47v@altlinux.org>
 <CA+JHD904e2TPpz1ybsaaqD+qMTDcueXu4nVcmotEPhxNfGN+Gw@mail.gmail.com>
 <20220825171620.cioobudss6ovyrkc@altlinux.org>
 <20220826025220.cxfwwpem2ycpvrmm@altlinux.org>
 <20220826025944.hd7htqqwljhse6ht@altlinux.org>
 <00cb99bd-bd17-3ff6-9008-92861518aff8@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00cb99bd-bd17-3ff6-9008-92861518aff8@fb.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Aug 26, 2022 at 09:47:59AM -0700, Yonghong Song escreveu:
> 
> 
> On 8/25/22 7:59 PM, Vitaly Chikunov wrote:
> > On Fri, Aug 26, 2022 at 05:52:20AM +0300, Vitaly Chikunov wrote:
> > > Arnaldo,
> > > 
> > > On Thu, Aug 25, 2022 at 08:16:20PM +0300, Vitaly Chikunov wrote:
> > > > On Thu, Aug 25, 2022 at 01:47:59PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > > On Thu, Aug 25, 2022, 1:35 PM Vitaly Chikunov <vt@altlinux.org> wrote:
> > > > > > 
> > > > > > I also noticed that after upgrading pahole to v1.24 kernel build (tested on
> > > > > > v5.18.19, v5.15.63, sorry for not testing on mainline) fails with:
> > > > > > 
> > > > > >      BTFIDS  vmlinux
> > > > > >    + ./tools/bpf/resolve_btfids/resolve_btfids vmlinux
> > > > > >    FAILED: load BTF from vmlinux: Invalid argument
> > > > > > 
> > > > > > Perhaps, .tmp_vmlinux.btf is generated incorrectly? Downgrading dwarves to
> > > > > > v1.23 resolves the issue.
> > > > > > 
> > > > > 
> > > > > Can you try this, from Martin Reboredo (Archlinux):
> > > > > 
> > > > > Can you try a build of the kernel or the by passing the
> > > > > --skip_encoding_btf_enum64 to scripts/pahole-flags.sh?
> > > > > 
> > > > > Here's a patch for either in tree scripts/pahole-flags.sh or
> > > > > /usr/lib/modules/5.19.3-arch1-1/build/scripts/pahole-flags.sh
> > > > 
> > > > This patch helped and kernel builds successfully after applying it.
> > > > (Didn't notice this suggestion in release discussion thread.)
> > > 
> > > Even thought it now compiles with this patch, it does not boot
> > > afterwards (in virtme-like env), witch such console messages:
> > 
> > I'm talking here about 5.15.62. Yes, proposed patch does not apply there
> > (since there is no `scripts/pahole-flags.sh`), but I updated
> > `scripts/link-vmlinux.sh` with the similar `if` to append
> > `--skip_encoding_btf_enum64` which lets then compilation pass.
> 
> Right, pahole v1.24 supports enum64 to correctly encode
> some big 64bit values in BTF. But enum64 is only supported
> in recent kernels. For old kernels, --skip_encoding_btf_enum64
> is the way to workaround the issue.

Check Jiri response, this doesn't seem to be enough.

- Arnaldo

> > Thanks,
> > 
> > > 
> > >    [    0.767649] Run /init as init process
> > >    [    0.770858] BPF:[593] ENUM perf_event_task_context
> > >    [    0.771262] BPF:size=4 vlen=4
> > >    [    0.771511] BPF:
> > >    [    0.771680] BPF:Invalid btf_info kind_flag
> > >    [    0.772016] BPF:
> > >    [    0.772016]
> > >    [    0.772288] failed to validate module [9pnet] BTF: -22
> > >    init_module '9pnet.ko' error -1
> > >    [    0.785515] 9p: Unknown symbol p9_client_getattr_dotl (err -2)
> > >    [    0.786005] 9p: Unknown symbol p9_client_wstat (err -2)
> > >    [    0.786438] 9p: Unknown symbol p9_client_open (err -2)
> > >    [    0.786863] 9p: Unknown symbol p9_client_rename (err -2)
> > >    [    0.787307] 9p: Unknown symbol p9_client_remove (err -2)
> > >    [    0.787749] 9p: Unknown symbol p9_client_renameat (err -2)
> [...]

-- 

- Arnaldo
