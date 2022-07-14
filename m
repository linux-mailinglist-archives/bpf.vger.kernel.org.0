Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E504357532E
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 18:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240158AbiGNQoV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 12:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238503AbiGNQnn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 12:43:43 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F8362E8
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 09:43:39 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id E343A240029
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 18:43:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1657817016; bh=LCPOarZMNMa6gf9nni/vAiDCL0+e1A9RDbTt/7oxHlQ=;
        h=Date:From:To:Cc:Subject:From;
        b=FIeUKYn4ep9VEvrT0fBZT7aBBHAqmOoOxVXr0ReGGX5QCvKdCyMCWX5W8yGYi/5yT
         esnCt7VomkbnJz/Cln+QnwroxY/egNGPIM+vRk4Ve6NtaXy8vzhbjGzpLU3AtzjkM4
         nUfFhxlBbxERoq6AFkwsIyBn2bXUdU4XqMz2+RWhNB7UDGWHGXgfeukVCCNblE5ggL
         6cwsFjnvzlK7dG2M/DGudHeA5yQCgJxOOw+OHCL6J10wv1QoCOWS6ZPnUm0RxHpvpe
         sCM1gZL5mzI0ZiDTbqmVXwyVlvxuiGlQSGKBAh8iawgcBBI9qSpTWdbnoaNdFh6nqF
         radF3+2RKoLgA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LkL0P57hCz9rxQ;
        Thu, 14 Jul 2022 18:43:33 +0200 (CEST)
Date:   Thu, 14 Jul 2022 16:43:30 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     sdf@google.com
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Mykola Lysenko <mykolal@fb.com>
Subject: Re: [PATCH bpf-next 1/3] selftests/bpf: Copy over libbpf configs
Message-ID: <20220714164330.5klrmv6bmgi7oqmn@muellerd-fedora-MJ0AC3F3>
References: <20220712212124.3180314-1-deso@posteo.net>
 <20220712212124.3180314-2-deso@posteo.net>
 <CAADnVQLLNQHHJuqd-pKzU09Uw3N-kBsztPy0ysYEKVipP=yMqw@mail.gmail.com>
 <20220712215322.rw3z6eoix3yagi2q@muellerd-fedora-MJ0AC3F3>
 <Ys32tgTtkfeECzLc@google.com>
 <20220712230138.mmdw323h5dop5abe@muellerd-fedora-MJ0AC3F3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220712230138.mmdw323h5dop5abe@muellerd-fedora-MJ0AC3F3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 12, 2022 at 11:01:38PM +0000, Daniel Müller wrote:
> On Tue, Jul 12, 2022 at 03:33:26PM -0700, sdf@google.com wrote:
> > On 07/12, Daniel M�ller wrote:
> > > On Tue, Jul 12, 2022 at 02:27:47PM -0700, Alexei Starovoitov wrote:
> > > > On Tue, Jul 12, 2022 at 2:21 PM Daniel M�ller <deso@posteo.net> wrote:
> > > > >
> > > > > This change integrates the libbpf maintained configurations and
> > > > > black/white lists [0] into the repository, co-located with the BPF
> > > > > selftests themselves. The only differences from the source is that we
> > > > > replaced the terms blacklist & whitelist with denylist and allowlist,
> > > > > respectively.
> > > > >
> > > > > [0] https://github.com/libbpf/libbpf/tree/20f03302350a4143825cedcbd210c4d7112c1898/travis-ci/vmtest/configs
> > > > >
> > > > > Signed-off-by: Daniel M�ller <deso@posteo.net>
> > > > > ---
> > > > >  .../bpf/configs/allowlist/ALLOWLIST-4.9.0     |    8 +
> > > > >  .../bpf/configs/allowlist/ALLOWLIST-5.5.0     |   55 +
> > > > >  .../selftests/bpf/configs/config-latest.s390x | 2711 +++++++++++++++
> > > > >  .../bpf/configs/config-latest.x86_64          | 3073
> > > +++++++++++++++++
> > > >
> > > > Instead of checking in the full config please trim it to
> > > > relevant dependencies like existing selftests/bpf/config.
> > > > Otherwise every update/addition would trigger massive patches.
> > 
> > > Thanks for taking a look. Sure. Do we have some kind of tooling for that
> > > or are
> > > there any suggestions on the best approach to minimize?
> > 
> > I would be interested to know as well if somebody knows some tricks on
> > how to deal with kconfig. I've spent some time yesterday manually
> > crafting various minimal bpf configs (for build tests), running make
> > olddefconfig and then verifying that all my options are still present in
> > the final config file.
> > 
> > It seems like kconfig tool can resolve some of the dependencies,
> > but there is a lot of if/endif that can break in non-obvious ways.
> > For example, putting CONFIG_TRACING=y and doing 'make olddefconfig'
> > won't get you CONFIG_TRACING=y in the final .config
> > 
> > So the only thing, for me, that helped, was to manually go through
> > the kconfig files trying to see what the dependencies are.
> > I've tried scripts/kconfig/merge_config.sh, but it doesn't
> > seem to bring anything new to the table..
> > 
> > So here is what I ended up with, I don't think it will help you that
> > much, but at least can highlight the moving parts (I was thinking that
> > maybe we can eventually put them in the CI as well to make sure all weird
> > configurations are build-tested?):
> 
> [...]
> 
> I *think* that make savedefconfig [0] is the way to go, at least for my use
> case. That cuts down the config file to <350 lines. However, it does change some
> configurations from 'm' to 'y', which I can't say I quite understand or would
> have expected (but perhaps minimal implies no modules or similar; I haven't
> investigated).
> I am still verifying that the result is working as expected, though.

Just to add to that...it turns out that while savedefconfig works, it can
produce faulty configs by silently disabling functionality when used with an
architecture that is not the native one (i.e., make ARCH=xxx savedefconfig).

The reason being that some options may directly or indirectly dependent on the
compiler supporting certain features. But if one "just" wants to minimize a
configuration for a different architecture, a fully blown cross-compilation
toolchain may not be present. So the feature availability check fails and,
consequently, options may be disabled.

That so happened in my case where we want to have a config for s390. I noticed
that BPF_JIT (which was set in the to-be-minimized config), for example, always
ended up being disabled. The reason turned out to be that it transitively
depends on MARCH_Z196 which "depends on $(cc-option,-march=z196)", which, well,
my compiler does not know about.

I am unsure if there is a better way than to manually fiddle around to get those
options back or whether I was using it wrong. I also have not come across any
warnings about such behavior, but perhaps I missed it; or it's "too obvious".

Daniel
