Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96358662A4C
	for <lists+bpf@lfdr.de>; Mon,  9 Jan 2023 16:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237279AbjAIPlo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Jan 2023 10:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237268AbjAIPkr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Jan 2023 10:40:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBC41EC69;
        Mon,  9 Jan 2023 07:39:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C65E0B80D66;
        Mon,  9 Jan 2023 15:39:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 337BBC433D2;
        Mon,  9 Jan 2023 15:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673278762;
        bh=rnfIk1jOfskD63wG/yF93j4JUbwfc5OF2eyMAQ8DGy8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KwOaYdQo8+qWEjnqNi5bAx3ZIkY6guZ9lgPlmHpsyw6yBMjlY6TOpBl5O3sPgi9vx
         nq/FOOSowwODoSjSp+u1St/JX3OJ7U2c/AGH5GAkpNj6V0rBW86L6YpoUEW6UEXVor
         h/p9qtxgDdx4utH+tvqBFzOmiy7n7DQMxxsYaM2VvWRI5vM+HhthfELR6ysyKrT2ej
         7DCJSU6yQbAc/y5vtDdKbm1iV9dOxf1WjcANHejLik+PDoc1dMz/h460iM30CKMbRI
         iV27ofdLiiGzJIYw0zpuhS9F5upOlrMfZ09DSEnlWEKj0Z8xhTrBBgOX1Y7SBO2iON
         nl3speuTMF1oA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D28B940468; Mon,  9 Jan 2023 12:39:19 -0300 (-03)
Date:   Mon, 9 Jan 2023 12:39:19 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        rust-for-linux@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Yonghong Song <yhs@fb.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Neal Gompa <neal@gompa.dev>
Subject: Re: Fwd: [PATCH bpf] scripts: Exclude Rust CUs with pahole
Message-ID: <Y7w1J489NWFtCD+7@kernel.org>
References: <828d438e-afe3-1fc0-bc12-ac98632c0908@gmail.com>
 <0ca4ad02-af27-0d1f-8750-1ff6b34e8d2a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ca4ad02-af27-0d1f-8750-1ff6b34e8d2a@gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Sat, Jan 07, 2023 at 11:23:11PM -0300, Martin Rodriguez Reboredo escreveu:
> On 1/5/23 13:40, Eric Curtin wrote:
> > Hiya Martin,
> > 
> > Just in case you hadn't noticed, the test bot complained about this...
> > 
> >>> grep: include/config/auto.conf: No such file or directory
> > --
> >>> grep: include/config/auto.conf: No such file or directory
> >>> grep: include/config/auto.conf: No such file or directory
> >>> grep: include/config/auto.conf: No such file or directory
> > 
> > Is mise le meas/Regards,
> > 
> > Eric Curtin
> > 
> > On Sun, 1 Jan 2023 at 08:57, kernel test robot <lkp@intel.com> wrote:
> >>
> >> Hi Martin,
> >>
> >> Thank you for the patch! Yet something to improve:
> >>
> >> [auto build test ERROR on bpf/master]
> >>
> >> url:    https://github.com/intel-lab-lkp/linux/commits/Martin-Rodriguez-Reboredo/scripts-Exclude-Rust-CUs-with-pahole/20221221-112806
> >> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master
> >> patch link:    https://lore.kernel.org/r/20221220203901.1333304-1-yakoyoku%40gmail.com
> >> patch subject: [PATCH bpf] scripts: Exclude Rust CUs with pahole
> >> config: sh-se7724_defconfig
> >> compiler: sh4-linux-gcc (GCC) 12.1.0
> >> reproduce (this is a W=1 build):
> >>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >>         chmod +x ~/bin/make.cross
> >>         # https://github.com/intel-lab-lkp/linux/commit/24aac5fd4ea59e02e9c203d3a59be6f13c5e702f
> >>         git remote add linux-review https://github.com/intel-lab-lkp/linux
> >>         git fetch --no-tags linux-review Martin-Rodriguez-Reboredo/scripts-Exclude-Rust-CUs-with-pahole/20221221-112806
> >>         git checkout 24aac5fd4ea59e02e9c203d3a59be6f13c5e702f
> >>         # save the config file
> >>         mkdir build_dir && cp config build_dir/.config
> >>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh olddefconfig
> >>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh distclean
> >>
> >> If you fix the issue, kindly add following tag where applicable
> >> | Reported-by: kernel test robot <lkp@intel.com>
> >>
> >> All errors (new ones prefixed by >>):
> >>
> >>>> grep: include/config/auto.conf: No such file or directory
> >> --
> >>>> grep: include/config/auto.conf: No such file or directory
> >>>> grep: include/config/auto.conf: No such file or directory
> >>>> grep: include/config/auto.conf: No such file or directory
> >>
> >> --
> >> 0-DAY CI Kernel Test Service
> >> https://01.org/lkp
> > 
> 
> I see, I was making a dependency on `auto.conf` in `pahole-flags.sh` but
> the former gets generated after the latter is called, so that's the
> reason behind the `grep` errors. Sent a new version of the patch.

I'll wait a bit then try to finally get into the rust bandwagon by
actually testing all this to ack this.

- Arnaldo
