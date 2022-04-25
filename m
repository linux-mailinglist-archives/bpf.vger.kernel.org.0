Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E21750DB1B
	for <lists+bpf@lfdr.de>; Mon, 25 Apr 2022 10:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiDYI2W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Apr 2022 04:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239900AbiDYI1w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Apr 2022 04:27:52 -0400
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3868DF07;
        Mon, 25 Apr 2022 01:24:45 -0700 (PDT)
Received: by mail-qv1-f47.google.com with SMTP id b17so11226445qvf.12;
        Mon, 25 Apr 2022 01:24:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/re6+Ak0/fc+uJjRwCS2l54bhVpG5GK4J73hEmUsv20=;
        b=KGWEKt3bonigeuAfv/M+7vu/1UfKDa5y5Aa6lFRnM2+cBfZn7bZTvT5BPqMInGYZt5
         oIxhZY0coopAPiEUrj+Atm1BX17gf/zZEs/EzK/xuOflWhvS4Q7rh1aC9qobe6hMsa0P
         0KYctkX66gX9gtOlqNWCynO2AYxli4sRyPZCAJngKOKwR8KY0+hMElhJXDM2WmY36aFz
         jWva5dzFk6bmtrRV7qjOA4Se7rYuTcx9QMBURMtf0Y2RdHYnD/mSr3sQhqLkGBhLM5zK
         KRYaAnFzxjbnQoazVsDHi2z4mV16Wxok4nqV+noKzixOhYTBQESBQdVI+qyeGdJmW1al
         dE3g==
X-Gm-Message-State: AOAM532WgU8BFjvOWq3jyj9g9Kem18H01frHlPftmSn3l6rhhv87BN9x
        0QLoLBU4xvJe/79FAPZj1yb3Gzzb/pkk9A==
X-Google-Smtp-Source: ABdhPJxJTZcxDdOinavtl9wtteuOaDpzqdi1qJgDfCC7HezMaN8Fgk17O6sy+k3DkH2Vk2G4U7LjIw==
X-Received: by 2002:ad4:5dc8:0:b0:446:493e:aed with SMTP id m8-20020ad45dc8000000b00446493e0aedmr11960515qvh.92.1650875084953;
        Mon, 25 Apr 2022 01:24:44 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id o21-20020a05620a0d5500b0069c59fae1a5sm4601937qkl.96.2022.04.25.01.24.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 01:24:44 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-2f7c424c66cso48333987b3.1;
        Mon, 25 Apr 2022 01:24:44 -0700 (PDT)
X-Received: by 2002:a81:c703:0:b0:2d0:cc6b:3092 with SMTP id
 m3-20020a81c703000000b002d0cc6b3092mr15284248ywi.449.1650875084343; Mon, 25
 Apr 2022 01:24:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220415164413.2727220-1-song@kernel.org> <20220415164413.2727220-3-song@kernel.org>
 <5e5e4759efef83250f9511d4ab0e1ba34f987ce5.camel@fb.com> <CAMuHMdVdx2V1uhv_152Sw3_z2xE0spiaWp1d6Ko8-rYmAxUBAg@mail.gmail.com>
 <CAHk-=wi5DYKbFE4j-jC2HGsKVuf1RpZbEiYt4tSXuxGKiN9oJg@mail.gmail.com>
In-Reply-To: <CAHk-=wi5DYKbFE4j-jC2HGsKVuf1RpZbEiYt4tSXuxGKiN9oJg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 25 Apr 2022 10:24:31 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXLBxATLYavmWRVQvHiLzQG_=ej_0Aq4Ctpdz4egUSbMA@mail.gmail.com>
Message-ID: <CAMuHMdXLBxATLYavmWRVQvHiLzQG_=ej_0Aq4Ctpdz4egUSbMA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf 2/4] page_alloc: use vmalloc_huge for large system hash
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "song@kernel.org" <song@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Rik van Riel <riel@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        "hch@lst.de" <hch@lst.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "hch@infradead.org" <hch@infradead.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "imbrenda@linux.ibm.com" <imbrenda@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Linus,

On Mon, Apr 25, 2022 at 10:18 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, Apr 25, 2022 at 12:07 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > vmalloc_huge() is provided by mm/vmalloc.c, which is not
> > compiled if CONFIG_MMU=n.
>
> Well, that's annoying.
>
> Does this trivial patch fix it for you?

Thanks, yes it does.
(at least it fixes the m5272c3_defconfig build, no hardware to test).

> I get this feeling that this could be done better with a weak alias to
> __vmalloc(), and that could take care of the "arch doesn't support
> VMAP_HUGE" case too, but the attached is the stupid and
> straightforward version.

Sounds reasonable.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
