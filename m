Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDFC9674958
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 03:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjATC2B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 21:28:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjATC2A (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 21:28:00 -0500
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BE99CBA7;
        Thu, 19 Jan 2023 18:27:57 -0800 (PST)
Received: by mail-qv1-f47.google.com with SMTP id n2so2936602qvo.1;
        Thu, 19 Jan 2023 18:27:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RvsGjt1TAervY/9r9whUOchjkA3fpkAqZ5KfexO5OlM=;
        b=g3Bfg8sFpP8/71rnSivXBB31pXkwHs5KQDHwtuUtSX8XZPcAv0ejJSxe/PTdNc9TVt
         r8jOKnxPB8Rvi8+W2ieiyNQKNWIpkywL1vof/JyeGRzuCtKQ1enkzrw6A1CPLlb6vPp+
         Sm0xqyBDfeBe0C4O8d9Fjjo/SoEABh9sjKjOkiGgJ+6pW0xg6l7xePRpMudUJxeyNA50
         KnQ5YQC+jy3GPTgCvaP56n+19sw2GkVxjGh/NgbOvyYMZZmVOdl4SZK5CmFsWzaXvYYG
         jUgXQdClD8A/BDf/q3uT78QCMvjaQoaEI2ENKC7QFRxRogjYnT1TDldJrXf9cWghWtFp
         kaUw==
X-Gm-Message-State: AFqh2kqM6EA6kuWppJCXv1mQiWlPkv/Ri5Tkd0iOLRljgrvWUSUfO4TH
        1gosJM29CjYO/kIetjdtbaE=
X-Google-Smtp-Source: AMrXdXsTN+AMAuZutGyVWEgzounRZKk09Nm//4Ihv0XXf4wK7/xnmZ8yLD8V3BsWGl79zb3EHRHtgA==
X-Received: by 2002:ad4:5893:0:b0:535:59ca:6c6b with SMTP id dz19-20020ad45893000000b0053559ca6c6bmr4639033qvb.19.1674181676320;
        Thu, 19 Jan 2023 18:27:56 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:2fc9])
        by smtp.gmail.com with ESMTPSA id x14-20020a05620a258e00b006e07228ed53sm25230695qko.18.2023.01.19.18.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 18:27:55 -0800 (PST)
Date:   Thu, 19 Jan 2023 20:27:59 -0600
From:   David Vernet <void@manifault.com>
To:     kernel test robot <lkp@intel.com>
Cc:     bpf@vger.kernel.org, oe-kbuild-all@lists.linux.dev, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@meta.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org
Subject: Re: [PATCH bpf-next 1/8] bpf: Enable annotating trusted nested
 pointers
Message-ID: <Y8n8L43j3a7Z4HJe@maniforge.lan>
References: <20230119235833.2948341-2-void@manifault.com>
 <202301200957.At49rpzu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202301200957.At49rpzu-lkp@intel.com>
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

On Fri, Jan 20, 2023 at 09:14:25AM +0800, kernel test robot wrote:
> Hi David,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on bpf-next/master]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/David-Vernet/bpf-Enable-annotating-trusted-nested-pointers/20230120-080139
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> patch link:    https://lore.kernel.org/r/20230119235833.2948341-2-void%40manifault.com
> patch subject: [PATCH bpf-next 1/8] bpf: Enable annotating trusted nested pointers
> config: ia64-allyesconfig (https://download.01.org/0day-ci/archive/20230120/202301200957.At49rpzu-lkp@intel.com/config)
> compiler: ia64-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/8f6df14342b1be3516f8e21037edf771df851427
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review David-Vernet/bpf-Enable-annotating-trusted-nested-pointers/20230120-080139
>         git checkout 8f6df14342b1be3516f8e21037edf771df851427
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash kernel/bpf/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> kernel/bpf/btf.c:533:5: warning: no previous prototype for 'bpf_find_btf_id' [-Wmissing-prototypes]
>      533 | s32 bpf_find_btf_id(const char *name, u32 kind, struct btf **btf_p)

Silly mistake on my part. I removed static while debugging something in
verifier.c and forgot to put it back. I'll put it back in v2.

>          |     ^~~~~~~~~~~~~~~
>    kernel/bpf/btf.c: In function 'btf_seq_show':
>    kernel/bpf/btf.c:6977:29: warning: function 'btf_seq_show' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
>     6977 |         seq_vprintf((struct seq_file *)show->target, fmt, args);
>          |                             ^~~~~~~~
>    kernel/bpf/btf.c: In function 'btf_snprintf_show':
>    kernel/bpf/btf.c:7014:9: warning: function 'btf_snprintf_show' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
>     7014 |         len = vsnprintf(show->target, ssnprintf->len_left, fmt, args);
>          |         ^~~
> 
> 
> vim +/bpf_find_btf_id +533 kernel/bpf/btf.c
> 
>    532	
>  > 533	s32 bpf_find_btf_id(const char *name, u32 kind, struct btf **btf_p)
>    534	{
>    535		struct btf *btf;
>    536		s32 ret;
>    537		int id;
>    538	
>    539		btf = bpf_get_btf_vmlinux();
>    540		if (IS_ERR(btf))
>    541			return PTR_ERR(btf);
>    542		if (!btf)
>    543			return -EINVAL;
>    544	
>    545		ret = btf_find_by_name_kind(btf, name, kind);
>    546		/* ret is never zero, since btf_find_by_name_kind returns
>    547		 * positive btf_id or negative error.
>    548		 */
>    549		if (ret > 0) {
>    550			btf_get(btf);
>    551			*btf_p = btf;
>    552			return ret;
>    553		}
>    554	
>    555		/* If name is not found in vmlinux's BTF then search in module's BTFs */
>    556		spin_lock_bh(&btf_idr_lock);
>    557		idr_for_each_entry(&btf_idr, btf, id) {
>    558			if (!btf_is_module(btf))
>    559				continue;
>    560			/* linear search could be slow hence unlock/lock
>    561			 * the IDR to avoiding holding it for too long
>    562			 */
>    563			btf_get(btf);
>    564			spin_unlock_bh(&btf_idr_lock);
>    565			ret = btf_find_by_name_kind(btf, name, kind);
>    566			if (ret > 0) {
>    567				*btf_p = btf;
>    568				return ret;
>    569			}
>    570			spin_lock_bh(&btf_idr_lock);
>    571			btf_put(btf);
>    572		}
>    573		spin_unlock_bh(&btf_idr_lock);
>    574		return ret;
>    575	}
>    576	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests
