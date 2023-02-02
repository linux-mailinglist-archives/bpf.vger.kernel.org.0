Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9896687F9E
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 15:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjBBOMm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 09:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjBBOMl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 09:12:41 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED33903B2
        for <bpf@vger.kernel.org>; Thu,  2 Feb 2023 06:12:18 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id m26so1878850qtp.9
        for <bpf@vger.kernel.org>; Thu, 02 Feb 2023 06:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8lKwPpkPDxwm1VBqDHuuHVHYFGb1CHGpldcsBIhtkdM=;
        b=fN/lac7S0hEha5x8ywniY7iRYMzhonZYyA0EvuvEBq5QbCZHEPgZsn7N4hiR5LgeaO
         Jh1fkkK4eKeZKgNa2tMvfn6N0q4W+SCCRrKMyDuJpUUIVYH+luyi/t+uEtsaoQ6RidvS
         beRW6DCDMqRhXeoLebx7wyoBwmlzf/++Rcl1TcoypuidOIior69I1RwPavAz1vBRIXLS
         y2jK89CaBkav/OtELC5vP2FOEgvZvhV4asMXSwWK5UNyYghmj2vBPaGB6gvBXYtfl5l7
         78ctZVTOxPjqXUT9T0nMxcfk97joBOH5rjcet4q9urTUosSkzmy+bs3WZs+6xHIYkT1r
         ej+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8lKwPpkPDxwm1VBqDHuuHVHYFGb1CHGpldcsBIhtkdM=;
        b=5JSdhRFYWxyaB5XsYJdh2x9FixNia7AD3HAv3rXPKFMx/ZAOoVG3ltVB4OFrwGUO2I
         xMnWOEa0IYnh24Bo3kU17Qjx8jrtM31D6V2xMfHluZD9teC6JsMkEPtVtcV0IgpH7Oag
         NEmcdvYuBX98PZJA8ZRhGHsMob6KsXWHbxoG/3ugbJFjU6xQ+sP4rciZfxya1fxCjomf
         q3YsZjBBWmmc1jqXmrzCEaFq1FsF1JkacZ79McXtLJB/qIUjJbzTco7vEotQOowHYqCi
         IXEqQJCFH+ow+AjeG08d0SqTTyI6hBoAFrpZmmWIyEgql7KSZimL6Y56MbucmgnPXob9
         880w==
X-Gm-Message-State: AO0yUKUiTlO7Vr/whaTBK0AvdA3sMLEnUEudHBltqfjQ3nA2l1v5ywI4
        /bn3I2PeoNPAdzCW/tiXpIYmzHNkqDnxHu6t8Lo=
X-Google-Smtp-Source: AK7set9k5XCQtHVBDhmS2cTjynxpRw3/UekFOEHwWW/291ryl6hyF+HTz1I4NTG83hwQ78BYzyTyhDxsbXw/IdAbDg8=
X-Received: by 2002:a05:622a:1ba9:b0:3b4:6444:546b with SMTP id
 bp41-20020a05622a1ba900b003b46444546bmr581897qtb.295.1675347132004; Thu, 02
 Feb 2023 06:12:12 -0800 (PST)
MIME-Version: 1.0
References: <20230202014158.19616-7-laoar.shao@gmail.com> <202302021258.By6JZK71-lkp@intel.com>
In-Reply-To: <202302021258.By6JZK71-lkp@intel.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 2 Feb 2023 22:11:36 +0800
Message-ID: <CALOAHbDFtsL5BPDPt8XnHyfEzTRH3xz3=i42YUn43uo+H5hhxA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 6/7] bpf: introduce bpf_mem_alloc_size()
To:     kernel test robot <lkp@intel.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        dennis@kernel.org, cl@linux.com, akpm@linux-foundation.org,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, vbabka@suse.cz,
        urezki@gmail.com, oe-kbuild-all@lists.linux.dev,
        linux-mm@kvack.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 2, 2023 at 12:54 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Yafang,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on bpf-next/master]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Yafang-Shao/mm-percpu-fix-incorrect-size-in-pcpu_obj_full_size/20230202-094352
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> patch link:    https://lore.kernel.org/r/20230202014158.19616-7-laoar.shao%40gmail.com
> patch subject: [PATCH bpf-next 6/7] bpf: introduce bpf_mem_alloc_size()
> config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230202/202302021258.By6JZK71-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/996f3e2ac4dca054396d0f37ffe8ddb97fc4212f
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Yafang-Shao/mm-percpu-fix-incorrect-size-in-pcpu_obj_full_size/20230202-094352
>         git checkout 996f3e2ac4dca054396d0f37ffe8ddb97fc4212f
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash kernel/bpf/
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> kernel/bpf/memalloc.c:227:15: warning: no previous prototype for 'bpf_mem_cache_size' [-Wmissing-prototypes]
>      227 | unsigned long bpf_mem_cache_size(struct bpf_mem_cache *c, void *obj)
>          |               ^~~~~~~~~~~~~~~~~~

Should be defined with 'static'.
Thanks for the report. Will update it in the next version.

>
>
> vim +/bpf_mem_cache_size +227 kernel/bpf/memalloc.c
>
>    226
>  > 227  unsigned long bpf_mem_cache_size(struct bpf_mem_cache *c, void *obj)
>    228  {
>    229          unsigned long size;
>    230
>    231          if (!obj)
>    232                  return 0;
>    233
>    234          if (c->percpu_size) {
>    235                  size = percpu_size(((void **)obj)[1]);
>    236                  size += ksize(obj);
>    237                  return size;
>    238          }
>    239
>    240          return ksize(obj);
>    241  }
>    242
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests



-- 
Regards
Yafang
