Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCD366CF7B
	for <lists+bpf@lfdr.de>; Mon, 16 Jan 2023 20:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbjAPTW2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Jan 2023 14:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233470AbjAPTWW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Jan 2023 14:22:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7D2222F3;
        Mon, 16 Jan 2023 11:22:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B5596112A;
        Mon, 16 Jan 2023 19:22:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9065CC433D2;
        Mon, 16 Jan 2023 19:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673896940;
        bh=L1NhodYkH6/Gp746fFV1TRAQ/J/wBdCWuHxTilK4xk8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L37+P+iHlHkbknbwi5+PX9BAzmO7msvKkFkdjYjvDO/khk92JOyQ/gy7NbjIFXr7R
         hXbDoV3oK1nDpJewpv0bhOjD3eiDKS+W3eAYS7oicCvk40gb0W+DIUZmwnGr+YIMRX
         sfSU7I3EaYZ8/ZIXzOWKUjCYGRUUBFy50Ym8G5D3IdigXbb/qyoJKqUU9Ea50RfNNQ
         x8DXa028WHWC7HTVW7NBYUC1EJXE9xCv85ss2CVPKazJp8TCKPTaRYuB/AAACndzgp
         yU1x7Rj0VDElqUktHmt5GZPNnt5HChcEbu/7H9HfFDmK5Jj+1WAjtvRw8b0tQdGiuY
         XbfW0BDBSiTig==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3F492405BE; Mon, 16 Jan 2023 16:22:12 -0300 (-03)
Date:   Mon, 16 Jan 2023 16:22:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        linux-kernel@vger.kernel.org, Neal Gompa <neal@gompa.dev>,
        Eric Curtin <ecurtin@redhat.com>, bpf@vger.kernel.org,
        rust-for-linux@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Yonghong Song <yhs@fb.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH v3] scripts: Exclude Rust CUs with pahole
Message-ID: <Y8Wj5N0nH/1EH3Yo@kernel.org>
References: <20230111152050.559334-1-yakoyoku@gmail.com>
 <aaf97a61-73c9-ff90-422d-9f3a79b0acd6@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaf97a61-73c9-ff90-422d-9f3a79b0acd6@iogearbox.net>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Jan 16, 2023 at 05:37:08PM +0100, Daniel Borkmann escreveu:
> On 1/11/23 4:20 PM, Martin Rodriguez Reboredo wrote:
> > Version 1.24 of pahole has the capability to exclude compilation units
> > (CUs) of specific languages [1] [2]. Rust, as of writing, is not
> > currently supported by pahole and if it's used with a build that has
> > BTF debugging enabled it results in malformed kernel and module
> > binaries [3]. So it's better for pahole to exclude Rust CUs until
> > support for it arrives.
> > 
> > Link: https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?id=49358dfe2aaae4e90b072332c3e324019826783f [1]
> > Link: https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?id=8ee363790b7437283c53090a85a9fec2f0b0fbc4 [2]
> > Link: https://github.com/Rust-for-Linux/linux/issues/735 [3]
> > 
> > Co-developed-by: Eric Curtin <ecurtin@redhat.com>
> > Signed-off-by: Eric Curtin <ecurtin@redhat.com>
> > Signed-off-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> > ---
> > V2 -> V3: Enable pahole option upon comparing with version 1.24
> > V1 -> V2: Removed dependency on auto.conf
> > 
> >   init/Kconfig            | 2 +-
> >   lib/Kconfig.debug       | 9 +++++++++
> >   scripts/pahole-flags.sh | 4 ++++
> >   3 files changed, 14 insertions(+), 1 deletion(-)
> > 
> > diff --git a/init/Kconfig b/init/Kconfig
> > index 694f7c160c9c..360aef8d7292 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -1913,7 +1913,7 @@ config RUST
> >   	depends on !MODVERSIONS
> >   	depends on !GCC_PLUGINS
> >   	depends on !RANDSTRUCT
> > -	depends on !DEBUG_INFO_BTF
> > +	depends on !DEBUG_INFO_BTF || PAHOLE_HAS_LANG_EXCLUDE
> >   	select CONSTRUCTORS
> >   	help
> >   	  Enables Rust support in the kernel.
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index ea4c903c9868..d473d491e709 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -364,6 +364,15 @@ config PAHOLE_HAS_BTF_TAG
> >   	  btf_decl_tag) or not. Currently only clang compiler implements
> >   	  these attributes, so make the config depend on CC_IS_CLANG.
> > +config PAHOLE_HAS_LANG_EXCLUDE
> > +	def_bool PAHOLE_VERSION >= 124
> > +	help
> > +	  Support for the --lang_exclude flag which makes pahole exclude
> > +	  compilation units from the supplied language. Used in Kbuild to
> > +	  omit Rust CUs which are not supported in version 1.24 of pahole,
> > +	  otherwise it would emit malformed kernel and module binaries when
> > +	  using DEBUG_INFO_BTF_MODULES.
> > +
> >   config DEBUG_INFO_BTF_MODULES
> >   	def_bool y
> >   	depends on DEBUG_INFO_BTF && MODULES && PAHOLE_HAS_SPLIT_BTF
> > diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
> > index 0d99ef17e4a5..1f1f1d397c39 100755
> > --- a/scripts/pahole-flags.sh
> > +++ b/scripts/pahole-flags.sh
> > @@ -19,5 +19,9 @@ fi
> >   if [ "${pahole_ver}" -ge "122" ]; then
> >   	extra_paholeopt="${extra_paholeopt} -j"
> >   fi
> > +if [ "${pahole_ver}" -ge "124" ]; then
> > +	# see PAHOLE_HAS_LANG_EXCLUDE
> > +	extra_paholeopt="${extra_paholeopt} --lang_exclude=rust"
> > +fi
> >   echo ${extra_paholeopt}
> 
> I presume Miguel will pick this up via rust tree? (Either way, would be nice to
> also get an Ack from Arnaldo.)

I haven't had the time to actually go and test it from top to bottom
(which I'm about to do), but it _looks_ ok, so:

Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo
