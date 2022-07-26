Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B30581AF4
	for <lists+bpf@lfdr.de>; Tue, 26 Jul 2022 22:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239312AbiGZUWx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jul 2022 16:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiGZUWw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Jul 2022 16:22:52 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70AD2F66B
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 13:22:51 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 5556C240027
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 22:22:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1658866970; bh=oazh+0Dc/O2ItWHUMcs0i+K0LJZmgplau2HYd0CLMSE=;
        h=Date:From:To:Cc:Subject:From;
        b=g8kbQsQ+oJLp6R1zbB20rA9zA8HKrmjJpfLmup0CN7kvTfmhnsvdcMg5t/nr6bpXb
         vRKR9qLPhi3GT97A+ICBda9YxA8GEhtjIdCwasG4glJ4c9I+9fg7TpiaSIekBUJc0U
         NzmlHhxhVG45sGEGAoteZqaapFPMKaj89j8vf4fz72g761LJ6hKFSRvijyOHuJ4L6i
         BBzTVHsQ4VM7AQ2CuBgjVIRd0Gm9YlEu6JvFh8NRaGpxYaOBfW3tHDm/UCHbFEHuXi
         Kf/Z/VYQ2VsNMdsqJj1Umi+j3ZU4EzTxb26BItHbw/+9TKi67+p0bTJJb0VcNoVWEx
         7aPgKNrFSGoWA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LspHp5JVFz6trP;
        Tue, 26 Jul 2022 22:22:46 +0200 (CEST)
Date:   Tue, 26 Jul 2022 20:22:42 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     sdf@google.com
Cc:     oak.zeng@intel.com, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "martin.lau@linux.dev" <martin.lau@linux.dev>,
        "song@kernel.org" <song@kernel.org>, "yhs@fb.com" <yhs@fb.com>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "haoluo@google.com" <haoluo@google.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>
Subject: Re: Build error of samples/bpf
Message-ID: <20220726202242.yfvp5cehbrcvlk2x@muellerd-fedora-PC2BDTX9>
References: <BN6PR11MB16338E9998353C6B239CD27792869@BN6PR11MB1633.namprd11.prod.outlook.com>
 <BN6PR11MB16332A018C2FAB69B479EA2B92869@BN6PR11MB1633.namprd11.prod.outlook.com>
 <Ys2tkthkFE1XkEPh@google.com>
 <BN6PR11MB16331BEF1C7F6F37F76C55DD92899@BN6PR11MB1633.namprd11.prod.outlook.com>
 <Ys7wVqnuK3QWlnRH@google.com>
 <20220713201810.srddhocttytfufdr@muellerd-fedora-PC2BDTX9>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220713201810.srddhocttytfufdr@muellerd-fedora-PC2BDTX9>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 13, 2022 at 08:18:10PM +0000, Daniel Müller wrote:
> On Wed, Jul 13, 2022 at 09:18:43AM -0700, sdf@google.com wrote:
> > On 07/13, Zeng, Oak wrote:
> > > Thank you sdf for the reply.
> > 
> > > It is news to me that samples/bpf tend to go stale. When I looked the
> > > samples/bpf folder git history, the last update is from only 2 months
> > > ago. And yes I can see samples/bfp is not actively updated recently. We
> > > are from Intel's GPU group and we are working on some bpf tools for GPU
> > > profiling purpose. We made our work based on the structure of
> > > samples/bpf because we can conveniently use libbpf. We chose bpf c
> > > frontend (vs python frontend) because python bpf program seems can't
> > > execute under non-root leading to some security concerns. This work is
> > > not yet upstream but we planned to upstream it.
> > 
> > I'm mostly talking from the following perspective:
> > http://vger.kernel.org/bpfconf2022_material/lsfmmbpf2022-bpf-ci.pdf
> > 
> > BPF maintainers have a CI that continuously builds and runs
> > tools/testing/selftests/bpf. I don't think it includes samples/bpf;
> > that's what I mean by "go stale". Eventually, people fix samples, but
> > there is no continuous system to verify they are healthy.
> 
> I am looking into some aspects of the CI. I will see what it would take to
> build and/or test samples/bpf in an automated fashion there.

For what it's worth, we now [0] have samples/bpf built in BPF CI. Here is an
example run: https://github.com/kernel-patches/bpf/runs/7527372083 (it may not
be possible for folks not part of the organization to see detailed logs, but you
should be able to see the "Build samples" step)

Thanks,
Daniel

[0] https://github.com/kernel-patches/vmtest/pull/98
