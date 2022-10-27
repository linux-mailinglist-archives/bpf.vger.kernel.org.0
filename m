Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C29A60EDBC
	for <lists+bpf@lfdr.de>; Thu, 27 Oct 2022 04:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiJ0CEI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Oct 2022 22:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbiJ0CEE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Oct 2022 22:04:04 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E00E140E5D
        for <bpf@vger.kernel.org>; Wed, 26 Oct 2022 19:04:03 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id h188so260723iof.1
        for <bpf@vger.kernel.org>; Wed, 26 Oct 2022 19:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UOFU7TWNoKl3gLQ8fYw9RrWHNeiOvVPNBPek/80Wo1g=;
        b=Y0VNjLDGom6PAfSwwGEqJZ3qs4L8/xRBdA6/AsEQEb3Ffw0SVX9GCPz1w8hccBiaqv
         TSuHNPoDJlRB2GLLxU2jl3KFl6wAd2BgMS+sBvgjlaiBfHA7FVUzHPQuMzda1Jp/UHfs
         lSNrP8wBA9FH7WMIeMz6A3g2y489mOxVLqWua67S2wwJ2QJYszFLEYVbq9skVEHbnlpb
         RIXGvT20qns1Ob/D3HZFR51/f7dpYEeHYXQirRwhWCqs1tiqhZJBSFBlB+YOkHKNjD/C
         yp4b6G09IULUoQTekIlI3GtQIZpyzPOGXCtv5hkCe486s5vA7Y7hct4p5/Kgp0FZmRgD
         4xtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UOFU7TWNoKl3gLQ8fYw9RrWHNeiOvVPNBPek/80Wo1g=;
        b=El/EjSIyxvywowkf47igNaPsau0rVR9imtSfeLyt/DvSBiRGZ7+kblP1ootT37hrr/
         oCyvb5rKEwvPUmfakU2YJIVMv6ulOjjmjiWzVohaftdZsSCIqkWi9BYxMD2tMeNF5xWj
         N2XsoAl1hiOY/Kfm+KZqioBw3xO+lm/wt6xfxQLC/e/QekQ2YpOUcMKqOoGxbyJ9eGO7
         2XZO+LJTO6qvO8q1O0TekkT4iky9paFOfTehlqHvLpR/opNBKWKDFXcF+uBt6ANT35j3
         yF+2J2XoLSZrWZT9NWfT1ODbdTgB4UTYuI1ziZmV7MUUQe3y5lh6AHF1EqSihP515POn
         Bg8Q==
X-Gm-Message-State: ACrzQf1BPOjgfWNBul4PXkxJfA1UBz2SD9kCP5bSiXHardxvqsH/8XHz
        gTGd6N4zjJx9widAtdi+o3bWr3DkN3dnE8HL3YQVmBvCc+s=
X-Google-Smtp-Source: AMsMyM7CT4nQZHJKhbV8cQalibjRmE82FnsznwB1bgUpiOsitZkMkanx4W5jeRvm6bEy7EPPTtOHm3J8TN9SoG8Afh8=
X-Received: by 2002:a02:cc71:0:b0:373:1604:274d with SMTP id
 j17-20020a02cc71000000b003731604274dmr11809921jaq.119.1666836242849; Wed, 26
 Oct 2022 19:04:02 -0700 (PDT)
MIME-Version: 1.0
References: <5c8b7d59-1f28-2284-f7b9-49d946f2e982@linux.dev>
In-Reply-To: <5c8b7d59-1f28-2284-f7b9-49d946f2e982@linux.dev>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 26 Oct 2022 19:03:52 -0700
Message-ID: <CAKH8qBu7OXptKF46SQSEfueKXRUkBxix3K0qmucgREP4h_rQJQ@mail.gmail.com>
Subject: Re: [Question]: BPF_CGROUP_{GET,SET}SOCKOPT handling when optlen > PAGE_SIZE
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 26, 2022 at 6:14 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>
> The cgroup-bpf {get,set}sockopt prog is useful to change the optname behavior.
> The bpf prog usually just handles a few specific optnames and ignores most
> others.  For the optnames that it ignores, it usually does not need to change
> the optlen.  The exception is when optlen > PAGE_SIZE (or optval_end - optval).
> The bpf prog needs to set the optlen to 0 for this case or else the kernel will
> return -EFAULT to the userspace.  It is usually not what the bpf prog wants
> because the bpf prog only expects error returning to userspace when it has
> explicitly 'return 0;' or used bpf_set_retval().  If a bpf prog always changes
> optlen for optnames that it does not care to 0,  it may risk if the latter bpf
> prog in the same cgroup may want to change/look-at it.
>
> Would like to explore if there is an easier way for the bpf prog to handle it.
> eg. does it make sense to track if the bpf prog has changed the ctx->optlen
> before returning -EFAULT to the user space when ctx.optlen > max_optlen?

Good point on chaining being broken because of this requirement :-/

With tracking, we need to be careful, because the following situation
might be problematic:
Suppose setsockopt is larger than 4k, the program can rewrite some
byte in the first 4k, not touch optlen and expect this to work.
Currently, optlen=0 explicitly means "ignore whatever is in the bpf
buffer and use the original one".
If we can have a tracking that catches situations like this - we
should be able to drop that optlen=0 requirement.
IIRC, that's the only tricky part.
