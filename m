Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96CB569085
	for <lists+bpf@lfdr.de>; Wed,  6 Jul 2022 19:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbiGFRVB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jul 2022 13:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbiGFRVA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jul 2022 13:21:00 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3811A80E
        for <bpf@vger.kernel.org>; Wed,  6 Jul 2022 10:20:59 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id g1so12498970edb.12
        for <bpf@vger.kernel.org>; Wed, 06 Jul 2022 10:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tLXc6jTqTjXJ4Qen61dxId+GRkP81P9emcepSvfh1GY=;
        b=V9EfZ4LUfZsA5RDuIKDvrzcQl0zpdAe7MKg2QaK99tUW9N8aIu4xfBsAA+RM2dq/B8
         gqWVAHPNTccwHXogMV9xWqmfwEpTV+9ab4dAx+BFehFd4NIbDPqbVpzRcOMG0mEVNegu
         qNBj/5W1gy/gynUlg4/sBPga32uzj4RaDDLDQFO+o/pbfRusp0QSSspa5oKrmuB7djWc
         TuNQRr0Q0l5w7m8AOchVy+YjfXEuHUYIav5g6YD7Bkaek4E0JdjFkZmpeO1hISR8CouN
         G6scypZ8YOqzV1HzOSsx4/QFJIuy8V8BPO6hKloMrlClx7xaTBOHaLNnbx2dGij/wbBw
         8awg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tLXc6jTqTjXJ4Qen61dxId+GRkP81P9emcepSvfh1GY=;
        b=2BRA7omtpGqCiMcjahlezoXmHtkxEyfKb/yCF3qHb1xIJzfq4ETuA4/sKwgwcw3loP
         PueCkZNNQafivRJogiODWk9Z/SaAySEEsdPFAAaxa1CvCHKlhf3Dq1NHZ5uI0Ablya4I
         Rcb0AbXnhn742KNUZwnM2GLfb2pfe98Cp6f6caB5XpKpj0n2MLYUNVLSC/o8Ds+x1qqy
         kYhHQIS1Yqoo3O0vG2EttquSrBXuNaj7/UgNrlbIowmCs2L2Zn6m6zH3Uq18vDNTC79k
         PUb5pervQZfIykUJ18dkE+2wuTkjr/5Hm0XXCTo001Go4pI6VmacsRfSQVxjQgScZoZI
         WfbA==
X-Gm-Message-State: AJIora9NV3njdrc4nr/gleY4XrfPBu/+j5yYM+Jsrbv5RxxakvlFdalu
        OLc+W/z6TIDq0pKnDunMj16cGL6VqzO0JxUIa4rLyl71H+EATw==
X-Google-Smtp-Source: AGRyM1svDLq2pZ+Sx6d6olmOtQjHGblCAqvEb56PmZKONVV+e/t+oRmZEMZ/DAvS2HhtAnVEGOJJT8BqoYhFV4qhasE=
X-Received: by 2002:a05:6402:3514:b0:435:f24a:fbad with SMTP id
 b20-20020a056402351400b00435f24afbadmr53585507edd.311.1657128058282; Wed, 06
 Jul 2022 10:20:58 -0700 (PDT)
MIME-Version: 1.0
References: <CADvTj4rytB_RDemr4CXO08waaEJGXRC6kt2y_SO0SKN3FgWg0g@mail.gmail.com>
In-Reply-To: <CADvTj4rytB_RDemr4CXO08waaEJGXRC6kt2y_SO0SKN3FgWg0g@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 6 Jul 2022 10:20:47 -0700
Message-ID: <CAEf4BzZVq2VZg=S2xZinfth2-f50zxhMm-fPVQGUoeYPC5J4XA@mail.gmail.com>
Subject: Re: bpftool gen object doesn't handle GCC built BPF ELF files
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 6, 2022 at 10:13 AM James Hilliard
<james.hilliard1@gmail.com> wrote:
>
> Note I'm testing with the following patches:
> https://lore.kernel.org/bpf/20220706111839.1247911-1-james.hilliard1@gmail.com/
> https://lore.kernel.org/bpf/20220706140623.2917858-1-james.hilliard1@gmail.com/
>
> It would appear there's some compatibility issues with bpftool gen and
> GCC, not sure what side though is wrong here:
> /home/buildroot/buildroot/output/per-package/systemd/host/sbin/bpftool
> gen object src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.o
> src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.unstripped.o
> libbpf: failed to find BTF info for global/extern symbol 'sd_restrictif_i'
> Error: failed to link
> 'src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.unstripped.o':
> Unknown error -2 (-2)
>
> Relevant difference seems to be this:
> GCC:
> [55] FUNC 'sd_restrictif_i' type_id=47 linkage=static
> Clang:
> [27] FUNC 'sd_restrictif_i' type_id=26 linkage=global
>

GCC is wrong, clearly. This function is global ([0]) and libbpf
expects it to be marked as such in BTF.

https://github.com/systemd/systemd/blob/main/src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.c#L42-L50


> GCC:
>
> [1] INT 'signed char' size=1 bits_offset=0 nr_bits=8 encoding=UNKN
> [2] INT 'unsigned char' size=1 bits_offset=0 nr_bits=8 encoding=CHAR
> [3] TYPEDEF '__u8' type_id=2
> [4] CONST '(anon)' type_id=3

[...]
