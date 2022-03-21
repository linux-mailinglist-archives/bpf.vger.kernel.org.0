Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1DED4E3227
	for <lists+bpf@lfdr.de>; Mon, 21 Mar 2022 22:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiCUVKL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Mar 2022 17:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiCUVKK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Mar 2022 17:10:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C8735AAE;
        Mon, 21 Mar 2022 14:08:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F292EB819C7;
        Mon, 21 Mar 2022 21:08:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD0CC340E8;
        Mon, 21 Mar 2022 21:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647896921;
        bh=9R1HG55IiLHxyMr19TMRy4BRam3sXhg+kNYxQxoAbh8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I3x57HGCa67NtNtZwQlzlwJXxltfZ0cQgqWK3OHIlbgfsLD5YWabP/d/NrepNX0kr
         SrzpkMfxDcfiC/xkgm0r17emmX8TZSueJgFvslLUQTt0Qn3EgxJpN3hjrtVtkAJ8Qk
         /I6+yI7nMoVi3lVNiHIGxPsqypc513JyGWK9WeoTkanZXsv4WOh27Txzfx2kkJ+0AO
         kiBUL5TO57IxE/aS7Y6vK/LDr55UHzt2GgfTiq12Sbbr+oQYiOhQETv2mzEx0ajtEB
         wuRhJcHLW3wiLbbJnBYsDBpIaXDg594lprkUskWlwO1Ga81aV8ZMPNmxvpon01tQdC
         ICiUMsJpepk2Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 32D7F40407; Mon, 21 Mar 2022 18:08:39 -0300 (-03)
Date:   Mon, 21 Mar 2022 18:08:39 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH dwarves v4 1/4] dwarf_loader: Receive per-thread data on
 worker threads.
Message-ID: <YjjpV5rzYgBZIuBg@kernel.org>
References: <20220126192039.2840752-1-kuifeng@fb.com>
 <20220126192039.2840752-2-kuifeng@fb.com>
 <CAEf4BzarN4L8U+hLnvZrNg0CR-oQr25OFs_W_tfW3aAHGAVFWw@mail.gmail.com>
 <YfJudZmSS1yTkeP/@kernel.org>
 <CAEf4Bza8xB+yFb4qGPvM7YwvHCb1zQ8yosGbKj63vcRM7d9aLg@mail.gmail.com>
 <Yij/BSPgMl8/HEhg@kernel.org>
 <CAEf4BzZX8Q5MPt62+68nRoQNPe=3jnVkcEMMJwPzoU51YCBszg@mail.gmail.com>
 <CAEf4BzYxOgNjC+nFJGY_wpnOZZ-Jik=15L0aSq3Uxbiamc0h+w@mail.gmail.com>
 <c9c436a6935bb39e4135d4f0d7efd1ecc49d660b.camel@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9c436a6935bb39e4135d4f0d7efd1ecc49d660b.camel@fb.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Mar 21, 2022 at 07:06:06PM +0000, Kui-Feng Lee escreveu:
> On Wed, 2022-03-09 at 16:18 -0800, Andrii Nakryiko wrote:
> > On Wed, Mar 9, 2022 at 4:14 PM Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > > I did check locally with latest pahole master, and it seems like
> > > something is wrong with generated BTF. I get three selftests
> > > failure
> > > if I use latest pahole compiled from master.

> > > Kui-Feng, please take a look when you get a chance. Arnaldo, please
> > > hold off from releasing a new version for now.
 
> I just figure out the root cuase.
> It caused by missing info from percpu_secinfo when collecting data from
> threads.  The encoder stores it separatedly from struct btf, and we
> have separated different encoders for threads.  They are not merged
> together.  I will fixed it ASAP.

Cool, looking forward to the fix.

- Arnaldo
