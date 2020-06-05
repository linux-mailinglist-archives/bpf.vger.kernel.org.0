Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02F2B1EFBA6
	for <lists+bpf@lfdr.de>; Fri,  5 Jun 2020 16:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbgFEOlP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Jun 2020 10:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbgFEOlO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Jun 2020 10:41:14 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA36C08C5C2
        for <bpf@vger.kernel.org>; Fri,  5 Jun 2020 07:41:12 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id z5so10407429ejb.3
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2020 07:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=0rAalUMg9w3vPsyZY+ceSssQBK31Vuvamre8uDZ+wt0=;
        b=D9yg0uCHSOGN6VAcVWPtOXaGuMFIkC5F8wZAWTe2tM8+3iKheTBAzHfGxju2F7LdX8
         u9feCcnfobmRAYZVcYxH01OOgK2lnkRNkc7QBVSULJMBNpYleIGnB0lvg9I16R9dF2q9
         A8/lcOaYgI7Foi/Ow9WRnr0V/OF2egkieI7jY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=0rAalUMg9w3vPsyZY+ceSssQBK31Vuvamre8uDZ+wt0=;
        b=KB2PYUrAA83buCVrTSLHxie+B78x5E/wgSe1AqKXV2qucOZAYQNFrxMHjFI9wP1xVE
         PMqbtkfwlhXyqlEsmuJiH7nDKRen5pA8TrRQEMrhWx/SGwfcK1b5KNrJ+glnwSWgN95X
         QXer7UNkmpwSsD8BpG8EqlHUbYpC/mZMjBkyqc5+vfu+I3SDbiDjptE0+A/w6MpFC/Hd
         FyKlmr8qRqnrHSuoNIh1bps8tE8ComO5jyqjO1pZhAzlFz3fjX1ZmsQ8fR6GD8izzDL6
         mhtIfI1MZ8br9n/TJGNu6Rz6DUZ+fvyaqC4dXmuu1H+kShf1UcP5z/f77x3Aw6Y8cTGR
         /FFw==
X-Gm-Message-State: AOAM531qHpH8dcjRITdphhYkZEfiyvD18ladnPiJ2Rr+8rudT9Xi1KXZ
        HQFozwdYEP5Gt+i/02U/GjiPyA==
X-Google-Smtp-Source: ABdhPJy4qRUC0VwH63tjnVQCZdHejMI5c6+JcX9I3LYUC85CEAcYLR5l0TpmTAd7QELncv6AQ1lK3w==
X-Received: by 2002:a17:906:17c5:: with SMTP id u5mr8825745eje.275.1591368070886;
        Fri, 05 Jun 2020 07:41:10 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id qt19sm4222197ejb.14.2020.06.05.07.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 07:41:10 -0700 (PDT)
References: <20200527170840.1768178-6-jakub@cloudflare.com> <202005281031.S7IMfvFG%lkp@intel.com> <CAKwvOdmof_tGVAN+gkq8R3Hq_sRDHXE_cB+37Sd7gKvgzVzVHw@mail.gmail.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     bpf <bpf@vger.kernel.org>, kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Network Development <netdev@vger.kernel.org>,
        kernel-team@cloudflare.com, kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH bpf-next 5/8] bpf: Add link-based BPF program attachment to network namespace
In-reply-to: <CAKwvOdmof_tGVAN+gkq8R3Hq_sRDHXE_cB+37Sd7gKvgzVzVHw@mail.gmail.com>
Date:   Fri, 05 Jun 2020 16:41:09 +0200
Message-ID: <877dwl3796.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 05, 2020 at 01:38 AM CEST, Nick Desaulniers wrote:
> On Wed, May 27, 2020 at 8:19 PM kbuild test robot <lkp@intel.com> wrote:
>>
>> Hi Jakub,
>>
>> I love your patch! Perhaps something to improve:
>>
>> [auto build test WARNING on bpf-next/master]
>> [also build test WARNING on net-next/master next-20200526]
>> [cannot apply to bpf/master net/master linus/master v5.7-rc7]
>> [if your patch is applied to the wrong git tree, please drop us a note to help
>> improve the system. BTW, we also suggest to use '--base' option to specify the
>> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>>
>> url:    https://github.com/0day-ci/linux/commits/Jakub-Sitnicki/Link-based-program-attachment-to-network-namespaces/20200528-011159
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
>> config: arm-randconfig-r035-20200527 (attached as .config)
>> compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project 3393cc4cebf9969db94dc424b7a2b6195589c33b)
>> reproduce (this is a W=1 build):
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # install arm cross compiling tool for clang build
>>         # apt-get install binutils-arm-linux-gnueabi
>>         # save the attached .config to linux build tree
>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kbuild test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>, old ones prefixed by <<):
>>
>> >> kernel/bpf/net_namespace.c:130:6: warning: variable 'inum' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
>
> This looks legit to me. Please fix.

It is legit, or rather it was. Already fixed in v2 [0] (jump to
bpf_netns_link_fill_info).

[...]
