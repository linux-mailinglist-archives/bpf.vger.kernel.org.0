Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC69572997
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 01:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbiGLXBv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 19:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbiGLXBt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 19:01:49 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAEC64E22
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 16:01:47 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 16525240108
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 01:01:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1657666905; bh=GHAESN6c9SIIZaEWxDf24lIUHt01eILDhPTORTuoln0=;
        h=Date:From:To:Cc:Subject:From;
        b=p7Y5Z/TLjFYyUHdenaubK+ss0EiHRoxQIPxRivBBaYKC+0Z7OlE8TBXwkgoHc4kj7
         CbDNIeEC/AlVeT5hgaLSKc+RQqg8FIBv0o4h4KNQkFSBXn+rU6rHGMpRAqrC+YRZcW
         w/s2VE9VbobguoaYzks3IRrdiZEe6gH6sikX8rjTx2cNs2WRqT6DriQgy9xA5g68kM
         s/YgnScdWtzFQ3iZcWBrAe4uE5OTo3KlM4kfODO9rrxm/WJCfOipi2xwtDU9jEP8iv
         HA1hK/xRSM3E18lmvX3F4Js5l92uk0GerqcMi9uP9tieTSIeb72eb/uEvnkI4XlAyX
         PSvmdKqy35Cvg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LjGTd6Rgqz9rxH;
        Wed, 13 Jul 2022 01:01:41 +0200 (CEST)
Date:   Tue, 12 Jul 2022 23:01:38 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     sdf@google.com
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Mykola Lysenko <mykolal@fb.com>
Subject: Re: [PATCH bpf-next 1/3] selftests/bpf: Copy over libbpf configs
Message-ID: <20220712230138.mmdw323h5dop5abe@muellerd-fedora-MJ0AC3F3>
References: <20220712212124.3180314-1-deso@posteo.net>
 <20220712212124.3180314-2-deso@posteo.net>
 <CAADnVQLLNQHHJuqd-pKzU09Uw3N-kBsztPy0ysYEKVipP=yMqw@mail.gmail.com>
 <20220712215322.rw3z6eoix3yagi2q@muellerd-fedora-MJ0AC3F3>
 <Ys32tgTtkfeECzLc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ys32tgTtkfeECzLc@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 12, 2022 at 03:33:26PM -0700, sdf@google.com wrote:
> On 07/12, Daniel M�ller wrote:
> > On Tue, Jul 12, 2022 at 02:27:47PM -0700, Alexei Starovoitov wrote:
> > > On Tue, Jul 12, 2022 at 2:21 PM Daniel M�ller <deso@posteo.net> wrote:
> > > >
> > > > This change integrates the libbpf maintained configurations and
> > > > black/white lists [0] into the repository, co-located with the BPF
> > > > selftests themselves. The only differences from the source is that we
> > > > replaced the terms blacklist & whitelist with denylist and allowlist,
> > > > respectively.
> > > >
> > > > [0] https://github.com/libbpf/libbpf/tree/20f03302350a4143825cedcbd210c4d7112c1898/travis-ci/vmtest/configs
> > > >
> > > > Signed-off-by: Daniel M�ller <deso@posteo.net>
> > > > ---
> > > >  .../bpf/configs/allowlist/ALLOWLIST-4.9.0     |    8 +
> > > >  .../bpf/configs/allowlist/ALLOWLIST-5.5.0     |   55 +
> > > >  .../selftests/bpf/configs/config-latest.s390x | 2711 +++++++++++++++
> > > >  .../bpf/configs/config-latest.x86_64          | 3073
> > +++++++++++++++++
> > >
> > > Instead of checking in the full config please trim it to
> > > relevant dependencies like existing selftests/bpf/config.
> > > Otherwise every update/addition would trigger massive patches.
> 
> > Thanks for taking a look. Sure. Do we have some kind of tooling for that
> > or are
> > there any suggestions on the best approach to minimize?
> 
> I would be interested to know as well if somebody knows some tricks on
> how to deal with kconfig. I've spent some time yesterday manually
> crafting various minimal bpf configs (for build tests), running make
> olddefconfig and then verifying that all my options are still present in
> the final config file.
> 
> It seems like kconfig tool can resolve some of the dependencies,
> but there is a lot of if/endif that can break in non-obvious ways.
> For example, putting CONFIG_TRACING=y and doing 'make olddefconfig'
> won't get you CONFIG_TRACING=y in the final .config
> 
> So the only thing, for me, that helped, was to manually go through
> the kconfig files trying to see what the dependencies are.
> I've tried scripts/kconfig/merge_config.sh, but it doesn't
> seem to bring anything new to the table..
> 
> So here is what I ended up with, I don't think it will help you that
> much, but at least can highlight the moving parts (I was thinking that
> maybe we can eventually put them in the CI as well to make sure all weird
> configurations are build-tested?):

[...]

I *think* that make savedefconfig [0] is the way to go, at least for my use
case. That cuts down the config file to <350 lines. However, it does change some
configurations from 'm' to 'y', which I can't say I quite understand or would
have expected (but perhaps minimal implies no modules or similar; I haven't
investigated).
I am still verifying that the result is working as expected, though.

Thanks,
Daniel

[0] https://lwn.net/Articles/397363/
