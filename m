Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D5B674A4B
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 04:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjATDj0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 22:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjATDj0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 22:39:26 -0500
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE25EA2597;
        Thu, 19 Jan 2023 19:39:24 -0800 (PST)
Received: by mail-qv1-f51.google.com with SMTP id t7so3021221qvv.3;
        Thu, 19 Jan 2023 19:39:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s2/u49MGkiTdhDi/wUNzsd0MzL5LPWw1jXjelpgTNjQ=;
        b=LqWpHgtRjt1PgS+l1vW3ehG2VBjAVE2gZb12OBPSyQ/TgGD+TLc01r06TLQ7D4e+lF
         MdRHsP+X3iB3C9PT+9NxRiQntVwsRdLH98DdxHmeCqub5iSDfOq82BhqtYwEnG4NGssh
         YqEbsD2/1wpoGueP5AKnDPIf5z3hdUKMavhzSXRDwntrmTTayxLvmrI/M1Tf8Jpmmdm0
         IyVKbxhDoT1KhbnUBoHOoBDFKHiUrXe83h8p07DbAxUaF5cl2GEElBkq1Hp0ePgqQhsp
         qLCNlUZhz+g74uiAiUIxcMsNq/F2a0zUyGUSVipEU6ExvcwpL/hMTEwKnyG/xJsQqalb
         ct1A==
X-Gm-Message-State: AFqh2kqdFZJuqR3B82ye79DRUV9u5kciMZwmtaImL1XVB2PpNz0kCvoy
        Sujc8noYS2xr2YFNaTpu8jY=
X-Google-Smtp-Source: AMrXdXtmeyvC2AGHjJRQX0twXoVPRG4rYfCl/1AY5U+LOqUUu/GWx4y4szZt8bMWeJmZBfYOTxOL8Q==
X-Received: by 2002:a05:6214:5d8d:b0:531:e636:e236 with SMTP id mf13-20020a0562145d8d00b00531e636e236mr18587890qvb.28.1674185963926;
        Thu, 19 Jan 2023 19:39:23 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:2fc9])
        by smtp.gmail.com with ESMTPSA id s1-20020a05620a0bc100b006fa4ac86bfbsm25132205qki.55.2023.01.19.19.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 19:39:23 -0800 (PST)
Date:   Thu, 19 Jan 2023 21:39:27 -0600
From:   David Vernet <void@manifault.com>
To:     kernel test robot <lkp@intel.com>
Cc:     bpf@vger.kernel.org, oe-kbuild-all@lists.linux.dev, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@meta.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org
Subject: Re: [PATCH bpf-next 4/8] bpf: Enable cpumasks to be queried and used
 as kptrs
Message-ID: <Y8oM7xxNqNDDHUpT@maniforge.lan>
References: <20230119235833.2948341-5-void@manifault.com>
 <202301201053.OKCBdOsh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202301201053.OKCBdOsh-lkp@intel.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 20, 2023 at 10:36:24AM +0800, kernel test robot wrote:
> Hi David,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on bpf-next/master]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/David-Vernet/bpf-Enable-annotating-trusted-nested-pointers/20230120-080139
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> patch link:    https://lore.kernel.org/r/20230119235833.2948341-5-void%40manifault.com
> patch subject: [PATCH bpf-next 4/8] bpf: Enable cpumasks to be queried and used as kptrs
> config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230120/202301201053.OKCBdOsh-lkp@intel.com/config)
> compiler: sparc64-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/11541205c58f2226e5ffbc5967317469d65efac6
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review David-Vernet/bpf-Enable-annotating-trusted-nested-pointers/20230120-080139
>         git checkout 11541205c58f2226e5ffbc5967317469d65efac6
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash kernel/bpf/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> kernel/bpf/cpumask.c:38:21: warning: no previous prototype for 'bpf_cpumask_create' [-Wmissing-prototypes]
>       38 | struct bpf_cpumask *bpf_cpumask_create(void)

Sorry, also forgot to do the __diag() dance described in [0]. I'll
include that fix in v2.

[0]: https://docs.kernel.org/bpf/kfuncs.html#creating-a-wrapper-kfunc

This is also reminding me to send out the v2 for [1]. I'll do that
after I take care of another few small things I've been putting off.

[1]: https://lore.kernel.org/lkml/20230106195130.1216841-3-void@manifault.com/T/

Thanks,
David
