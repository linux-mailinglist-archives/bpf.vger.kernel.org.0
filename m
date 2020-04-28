Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93C81BB5C3
	for <lists+bpf@lfdr.de>; Tue, 28 Apr 2020 07:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgD1FSs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Apr 2020 01:18:48 -0400
Received: from condef-03.nifty.com ([202.248.20.68]:41025 "EHLO
        condef-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbgD1FSr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Apr 2020 01:18:47 -0400
Received: from conssluserg-05.nifty.com ([10.126.8.84])by condef-03.nifty.com with ESMTP id 03S5F1jC024503
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2020 14:15:01 +0900
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 03S5EZx7018686;
        Tue, 28 Apr 2020 14:14:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 03S5EZx7018686
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1588050876;
        bh=xRUJalPmxSa3IwO0mbX8+bZsqXvmh5sIzpQvN19Y1Qg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pP/mxVbR2xduse1JEi6QZ8GoH8YhEQNP39wIopOeWdW8x1RJRwMKtLL1oTZOxstvF
         3g0O5f0N/ZRWqiflrw7Cz442nxTHCaOYg/PoVarAlMmF2TQ61W5Dwq1pnkg1z/dvzh
         WvD/+Bm2UmmkFcCMvPjfJmfZWLkwFg7C1mMUyKF0tmspN9aw+IeVcfcmHgAwgxpvDM
         Is92Qdv+TT69EdxUs1NHZa/erHGXAOvmFRQG9iBnYhm23xk/s4bdTTNsZKszuLQb6P
         gRV9Z0nWI7FALHF7BYFgn5ISKO1r2TkcjwnoJvraLYCrtvUDVlfb+YaEPetoNXRoHj
         PGnc9hJGlo6UQ==
X-Nifty-SrcIP: [209.85.222.45]
Received: by mail-ua1-f45.google.com with SMTP id y10so20081373uao.8;
        Mon, 27 Apr 2020 22:14:35 -0700 (PDT)
X-Gm-Message-State: AGi0PuYvY3TLII9thcLEDJL1E7mCg1VkdZ9Pfofzt+HTpZLyKuEPG5xN
        sabFwgHS4UnhP0X4ueM+NRk7nmwMorDW7jkbr5I=
X-Google-Smtp-Source: APiQypJOEZwJRbZeM9LhBugkGuqlPL46+tnrLO/5mGkeAE074X4HzqUJOtQaMAK6LbvOX/mEJbhvhz/21GD3G/WiS5Q=
X-Received: by 2002:ab0:1166:: with SMTP id g38mr20152241uac.40.1588050874872;
 Mon, 27 Apr 2020 22:14:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200423073929.127521-5-masahiroy@kernel.org> <202004280948.0higRDEI%lkp@intel.com>
In-Reply-To: <202004280948.0higRDEI%lkp@intel.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 28 Apr 2020 14:13:58 +0900
X-Gmail-Original-Message-ID: <CAK7LNATNC9ndOMjOUdFbSCpM=P5Tv-M=ZJ-QDN+zRGMU4TQMbA@mail.gmail.com>
Message-ID: <CAK7LNATNC9ndOMjOUdFbSCpM=P5Tv-M=ZJ-QDN+zRGMU4TQMbA@mail.gmail.com>
Subject: Re: [PATCH 04/16] net: bpfilter: use 'userprogs' syntax to build bpfilter_umh
To:     kbuild test robot <lkp@intel.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        kbuild-all@lists.01.org, bpf <bpf@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 28, 2020 at 10:46 AM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Masahiro,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on kbuild/for-next]
> [cannot apply to linus/master v5.7-rc3 next-20200424]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>
> url:    https://github.com/0day-ci/linux/commits/Masahiro-Yamada/kbuild-support-userprogs-syntax/20200426-114001
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git for-next
> config: i386-allyesconfig (attached as .config)
> compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    /usr/bin/ld: i386 architecture of input file `net/bpfilter/main.o' is incompatible with i386:x86-64 output
> >> collect2: error: ld returned 1 exit status
>

Thanks.
-m32/-m64 is missing in the link time of the bpfilter_umh.
I will fix it soon.



-- 
Best Regards
Masahiro Yamada
