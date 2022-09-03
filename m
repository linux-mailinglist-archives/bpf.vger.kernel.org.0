Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5C95ABF3F
	for <lists+bpf@lfdr.de>; Sat,  3 Sep 2022 16:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiICONw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 3 Sep 2022 10:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiICONv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 3 Sep 2022 10:13:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F7958517;
        Sat,  3 Sep 2022 07:13:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4AC126151E;
        Sat,  3 Sep 2022 14:13:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8490CC433C1;
        Sat,  3 Sep 2022 14:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662214428;
        bh=wR96nJJd4WNj9UMkwxs6pSZVS/BHL8f9p4HAQZWJjJ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z3KeN3h26tWcHPiPLDiRO4iFIQGbenqR+bbtXn+Gm+0Mj+oZjU9/kFZRypspfbkXu
         M07a/V/D2PNHdKU1SowaN+ZbmpawwguKXZ+xnmJnihSw3ITOR/wMz+y7N4LjroLGEh
         RXFY2pv6jxQoJnnx0k0tiicFmdOshTpjVf4EuETNLVIT5VPpIUDnq7IpDuEXxzDpD/
         wOFgFnOddWCi6B2Zoff/qcDqLE+hER+qRV5rGnraBrvB9H2u81jECvO8wOKsEi0//c
         lGkfTCz5Zhw832mHKjDB4ZA9tdIkExmy/TAjm9uD97oNRPpguFbAYf5u5B4rmwVBhF
         u+vDa7vg8Kfiw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0CE6F404A1; Sat,  3 Sep 2022 11:13:46 -0300 (-03)
Date:   Sat, 3 Sep 2022 11:13:45 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jiri Olsa <olsajiri@gmail.com>, stable@vger.kernel.org,
        bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH bpf v2] bpf: Add config for skipping BTF enum64s
Message-ID: <YxNhGc7Q+eiHCIr5@kernel.org>
References: <20220828233317.35464-1-yakoyoku@gmail.com>
 <YxI0dO2yuqTK0H6f@krava>
 <YxLlouzk1O1Prg3J@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxLlouzk1O1Prg3J@kroah.com>
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

Em Sat, Sep 03, 2022 at 07:26:58AM +0200, Greg KH escreveu:
> On Fri, Sep 02, 2022 at 06:51:00PM +0200, Jiri Olsa wrote:
> > On Sun, Aug 28, 2022 at 08:33:17PM -0300, Martin Rodriguez Reboredo wrote:
> > > After the release of pahole 1.24 some people in the dwarves mailing list
> > > notified issues related to building the kernel with the BTF_DEBUG_INFO
> > > option toggled. They seem to be happenning due to the kernel and
> > > resolve_btfids interpreting btf types erroneously. In the dwarves list
> > > I've proposed a change to the scripts that I've written while testing
> > > the Rust kernel, it simply passes the --skip_encoding_btf_enum64 to
> > > pahole if it has version 1.24.
> > > 
> > > v1 -> v2:
> > > - Switch to off by default and remove the config option.
> > > - Send it to stable instead.
> > 
> > hi,
> > we have change that needs to go to stable kernels but does not have the
> > equivalent fix in Linus tree
> 
> Why isn't it also relevant in Linus's tree?

See below.
 
> > what would be the best way to submit it?
> 
> Submit it here and document the heck out of why this isn't in Linus's
> tree, what changes instead fixed it there, and so on.  Look in the
> archives for examples of how this is done, one recent one that I can
> think of is here:
> 	https://lore.kernel.org/r/20220831191348.3388208-1-jannh@google.com
> 
> > the issue is that new 'pahole' will generate BTF data that are not supported
> > by older kernels, so we need to add --skip_encoding_btf_enum64 option to
> > stable kernel's scripts/pahole-flags.sh to generate proper BTF data
> > 
> > we got complains that after upgrading to latest pahole the stable kernel
> > compilation fails
> 
> And what is happening in Linus's tree for this same issue?

So, BTF_KIND_ENUM64 is a new BTF tag, one that is not accepted by older
kernels, but is accepted by the BPF verifier on Linus' tree.

Its about avoiding having a pahole command line with lots of
--enable-new-feature-foo for new stuff with the default producing the
most recent BTF spec.

One way to documenting it: if you update pahole, then please use
--skip_encoding_FOO for these new FOO features on kernels where those
aren't supported.

So this isn't a backport from a fix on Linus' tree, as both the older
pahole that doesn't encode BTF_KIND_ENUM64 and the new one, that encodes
it by default, work with Linus' tree.

Does this violates the stable@ rules?

- Arnaldo
