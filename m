Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D781AC3A1
	for <lists+bpf@lfdr.de>; Sat,  7 Sep 2019 02:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732065AbfIGATP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Sep 2019 20:19:15 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:47000 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730799AbfIGATP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Sep 2019 20:19:15 -0400
Received: by mail-lf1-f67.google.com with SMTP id t8so6378145lfc.13
        for <bpf@vger.kernel.org>; Fri, 06 Sep 2019 17:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LMaOt4FuyGYZ6GmxTEoNOWFTUVjVfbek7WmSRfSN6/o=;
        b=K0DVaUnOkxgz+BKGM7Jmk5fFVihMqVmZ8hXXahLcWXcTRqMO4z4Fisuh4jSp+34lCI
         q3BxgPAm8qSgHy06TwfpR6TuhCPUBUgumdtMFFCzQC4Izg0n3WRU6McD42+kqdaiJhcM
         oUEZQcFUUG+F4oQWXMZh1jwL2SJ57qEaMSNjtH07rVPPJxrM3Bf0BSm4BoCGo5ooz3fw
         hGEMjhXT2x5q7uWChN33cEQR0+0IkbQFCW18gDg81qIQikzQjr+WASiocZ9cVeMnUhq1
         lwKjnr6PATu0XJ4NFeiYu0LBkXAuzLU3bKsd1fz7cwguDepfSUXPTtnuWQmpxHLiYTGO
         xWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=LMaOt4FuyGYZ6GmxTEoNOWFTUVjVfbek7WmSRfSN6/o=;
        b=s11pTX3bHQh5Va8EB6tZ7xfriRLHgJwIMY3BoRwav9JIDvodQZ2mlfkt4aWoczQRqM
         QfJTbOgTwksEw/nBsmDeYaiEiclugVEDvydVM7iTQoLN6bsQQE8mvaoyDzgM/xD+D4tt
         6Ax5o8Um4mMVF9CCb0Q8k5uUIeW86achYVVmh6T6BQj2jAC/g9zsGkKh32Cf/UEAz0CY
         dQibpWuAeKG9Hs4eD94JQbD00z9xxnpi6XKgfVBkNzchczc5j1hTXrJiQ1+hVsRkm3eB
         CX0/vEYauLnkWhWB9kwIHL2WK/MC/Gg9asusyEhSm2BzpIwrNDJWmYyyS1O4XTUHydNs
         SI5Q==
X-Gm-Message-State: APjAAAX7EYBctFKDi/X+BFHCOVMjovbTByCu1cWKay8PpFHhQYByzbQS
        fonnY5yysSVTbXjcnmL1DOPjow==
X-Google-Smtp-Source: APXvYqzTQQuqgyPV0OhoMW68LUGmu1SvlTcBRhM6FTRiqF/TZROjf7snMsVgox5ANFh6wnVtsDSn4w==
X-Received: by 2002:a19:117:: with SMTP id 23mr8278563lfb.115.1567815553302;
        Fri, 06 Sep 2019 17:19:13 -0700 (PDT)
Received: from khorivan (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id i65sm1138129lji.16.2019.09.06.17.19.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Sep 2019 17:19:12 -0700 (PDT)
Date:   Sat, 7 Sep 2019 03:19:10 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH bpf-next 2/8] samples: bpf: Makefile: remove target for
 native build
Message-ID: <20190907001909.GB3053@khorivan>
Mail-Followup-To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, Yonghong Song <yhs@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>
References: <20190904212212.13052-1-ivan.khoronzhuk@linaro.org>
 <20190904212212.13052-3-ivan.khoronzhuk@linaro.org>
 <20190906233138.4d4fqdnlbikemhau@ast-mbp.dhcp.thefacebook.com>
 <20190906235207.GA3053@khorivan>
 <CAADnVQKOT8D9156p49AQ0q0z5Zks5te4Ofi6DrBfpnitmRBgmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAADnVQKOT8D9156p49AQ0q0z5Zks5te4Ofi6DrBfpnitmRBgmg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 06, 2019 at 05:04:08PM -0700, Alexei Starovoitov wrote:
>On Fri, Sep 6, 2019 at 4:52 PM Ivan Khoronzhuk
><ivan.khoronzhuk@linaro.org> wrote:
>>
>> On Fri, Sep 06, 2019 at 04:31:39PM -0700, Alexei Starovoitov wrote:
>> >On Thu, Sep 05, 2019 at 12:22:06AM +0300, Ivan Khoronzhuk wrote:
>> >> No need to set --target for native build, at least for arm, the
>> >> default target will be used anyway. In case of arm, for at least
>> >> clang 5 - 10 it causes error like:
>> >>
>> >> clang: warning: unknown platform, assuming -mfloat-abi=soft
>> >> LLVM ERROR: Unsupported calling convention
>> >> make[2]: *** [/home/root/snapshot/samples/bpf/Makefile:299:
>> >> /home/root/snapshot/samples/bpf/sockex1_kern.o] Error 1
>> >>
>> >> Only set to real triple helps: --target=arm-linux-gnueabihf
>> >> or just drop the target key to use default one. Decision to just
>> >> drop it and thus default target will be used (wich is native),
>> >> looks better.
>> >>
>> >> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
>> >> ---
>> >>  samples/bpf/Makefile | 2 --
>> >>  1 file changed, 2 deletions(-)
>> >>
>> >> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
>> >> index 61b7394b811e..a2953357927e 100644
>> >> --- a/samples/bpf/Makefile
>> >> +++ b/samples/bpf/Makefile
>> >> @@ -197,8 +197,6 @@ BTF_PAHOLE ?= pahole
>> >>  ifdef CROSS_COMPILE
>> >>  HOSTCC = $(CROSS_COMPILE)gcc
>> >>  CLANG_ARCH_ARGS = --target=$(notdir $(CROSS_COMPILE:%-=%))
>> >> -else
>> >> -CLANG_ARCH_ARGS = -target $(ARCH)
>> >>  endif
>> >
>> >I don't follow here.
>> >Didn't you introduce this bug in patch 1 and now fixing it in patch 2?
>> >
>>
>> It looks like but that's not true.
>> Previous patch adds target only for cross compiling,
>> before the patch the target was used for both, cross compiling and w/o cc.
>>
>> This patch removes target only for native build (it's not cross compiling).
>>
>> By fact, it's two separate significant changes.
>
>How so?
>before first patch CLANG_ARCH_ARGS is only used under CROSS_COMPILE.
>After the first patch CLANG_ARCH_ARGS is now suddenly defined w/o CROSS_COMPILE
>and second patch brings it to the state before first patch.

Oh sorry ), messed with my local exp with target bpf, after rebase, even forgot
that's mine. Will drop it, with removing "else" for previous patch.

-- 
Regards,
Ivan Khoronzhuk
