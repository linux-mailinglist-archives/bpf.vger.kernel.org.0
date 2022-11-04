Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F64B619C5C
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 16:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbiKDP7j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 11:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbiKDP73 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 11:59:29 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D723054D
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 08:59:27 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id i21so8226329edj.10
        for <bpf@vger.kernel.org>; Fri, 04 Nov 2022 08:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Zs7UKNzIY/itGlp6zdkxW4FR/Xd6w9KeYRagvnFqMRg=;
        b=InLNXczhjBthFo1/HW3TxLlo7RJv2PItQ6YEgHsVMtYs4JiLWTILwpwhh3itax8M71
         PJrXcGHiIn+LyWq34A4MeL47HCc0Q2M5sxjNB/GXlhumHuTvWf0WOfp27+N8aDZGbUeC
         xKY8ZMob2i35ssiLiOUsVX6d5JLie+rlDPxrgDAtnXH/+nZCalr7/E8qKR7bYxoRr9pr
         4H9aT9X8FpnQjxJJKv2cqkHh38oqYiovFQ+rUHCOoReJvx7NpG933rNrPZDQidQgc9Ql
         eKvvJ7gjyFg/0B6JHZ9CLskHzWZDKkgXBuB0Gw2ItCoJ2Z/nVTD+Z+sYHHKX7AsDjG4a
         pH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zs7UKNzIY/itGlp6zdkxW4FR/Xd6w9KeYRagvnFqMRg=;
        b=UhF6hN+X8UxjT6jqUGesqxp+cbYdvpBbWHdO5W2RRAxyLWbAT/JKRytkO6Sp+B+kxY
         NhSN/oJHsgI7OLO0/vrOMgJj0+G5DX3km/kLEm/VES6yRcSXxi9CN3D96PRjVxJ/6Vj8
         TV4jaOQLrkSIF7fLQHHTKUd3fL4sP1wkAItsMng/87d/XAnLMowuvwHRv0isWHyIuiBz
         klTGCCr1g3pYaqG+6EO2EiBk0qp603N7x0zDQDcU88oEhgJSP1XDc97YuqM+iq6Vz4NQ
         RqrAeLMw/xpcaz8kzLummjUr+KTA6pAQJdWvBHwVgM3ahLfd3PkeCw4sQqh0qqR6EL5g
         6opA==
X-Gm-Message-State: ACrzQf20laj1Sfzo2zEXu550vzfykXmxEGd4eWCaDacCksz4bNp77hxk
        i0mtgRch/s8AV+7kzdw7AfOviUgl2jYWjCjFjMk=
X-Google-Smtp-Source: AMsMyM4Twt1W9RzwKiWYvewP4DHGjRyEHt6VKEIyTyznZdCK/J24nrxXbvEnUT8mIZ002UcgBFDzSeLB10zqdhMrDp0=
X-Received: by 2002:a05:6402:5406:b0:452:1560:f9d4 with SMTP id
 ev6-20020a056402540600b004521560f9d4mr36788198edb.333.1667577565715; Fri, 04
 Nov 2022 08:59:25 -0700 (PDT)
MIME-Version: 1.0
References: <20221104051644.nogfilmnjred2dt2@altlinux.org> <CACYkzJ4AeNEbag2EZo4+Mpn6NM-ELvKUkSKVDHdoNFHcFOygQA@mail.gmail.com>
In-Reply-To: <CACYkzJ4AeNEbag2EZo4+Mpn6NM-ELvKUkSKVDHdoNFHcFOygQA@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 4 Nov 2022 08:59:14 -0700
Message-ID: <CAADnVQKUeyDwdJ9AZvbxCCVc6hyvm1wdBRg4+3RHx5u5o1wLMA@mail.gmail.com>
Subject: Re: bpf: Is it possible to move .BTF data into a module
To:     KP Singh <kpsingh@kernel.org>
Cc:     Vitaly Chikunov <vt@altlinux.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>
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

On Fri, Nov 4, 2022 at 7:35 AM KP Singh <kpsingh@kernel.org> wrote:
>
> On Fri, Nov 4, 2022 at 6:16 AM Vitaly Chikunov <vt@altlinux.org> wrote:
> >
> > Hi,
> >
> > We need to reduce kernel size for aarch64, because it does not fit into
> > U-Boot loader on Raspberry Pi (due to it having fdt_addr_r=0x02600000)
> > and one of big ELF sections in vmlinuz is .BTF taking around 5MB.
> > Compression does not help because on aarch64 kernels are
> > uncompressed[1].
> >
> > Is it theoretically possible to make sysfs_btf a module?
>
> I think so, it may need some refactoring and changes
> but, yeah, in theory, the module could ship with the
> kernel's BTF information which can then be initialized by the module.
>
> Curious to see what others think as well.

Yeah. That request came up a few times.
Whoever has cycles to work on it... please go ahead :)
