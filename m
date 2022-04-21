Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63FE4509576
	for <lists+bpf@lfdr.de>; Thu, 21 Apr 2022 05:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383961AbiDUDjF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Apr 2022 23:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383951AbiDUDjE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Apr 2022 23:39:04 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C84B1CD;
        Wed, 20 Apr 2022 20:36:16 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id q19so3546317pgm.6;
        Wed, 20 Apr 2022 20:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=KZBHfUAnf51a3ognrNtvN+eHbKSNCphMcLIe5ZMRThc=;
        b=PCe7bAX3iBfbqv9eSgOGEg9WCaXfFJFt7TVzTbPMK1ZiGF3DJ/i7ikNIzthtoLSoIm
         9Jb4x3JftBxcolj7nk8HkUV51ivT9/2Dfz88vO69fCPSvSpgV3oqxaNazPDry8yY9BW/
         V9gz+YBHh+TtRQKfdNGU+1hfdJzKaaNbA2Z77aWYHH/Wg1j7lMpD1yzXs5SsdDm+3Vpo
         zDIq4egIgAJWxkJKnAD6dQncYLtimp3cYFesXxI1rrX28Nnr2y4INRP8uo+ZtbFx/9l+
         OemD6U2GUfzmg8dJTnVr0am2i3X0DjLbmO+T7aO6QL+U0I/vjvpiMlLSUHSbj3UZbQQs
         dSTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=KZBHfUAnf51a3ognrNtvN+eHbKSNCphMcLIe5ZMRThc=;
        b=CNGJXR5X3btLd6CJGUaJkJ9LH/OlybIWStC/txiXxhyn9i03efGnzf4GKNArxlMxJz
         7Wh3xDnf4qubdoQc6a5odnw1uXjgdJiMZSuXm/cVAbSEwinXogGafsGFZnVV2gKUexzs
         /AfNGgK5bTFSCdsK5QPzbgeiwiRbn/YRA97pIgULqrdQ82G1pbnze593/UK+ZqpWgqS0
         Uerkty4a5vCF5i5C3wCbOhmUJ161EKRc6ud8hT+I734McQIwjKyql9gyCdCobkqLta5y
         ET6daoB6Syq8XwTrpjaDFXcAsGV7GYaR3/eCRgNCYGe7jq8jksrRRGfniXSdIvp2vJhF
         PA8w==
X-Gm-Message-State: AOAM5305Wwrii4pQh2FNB0xF0WetMiJTJEoCPOP1C8KTHdYug1f8KNTZ
        8d/cMiIjhUDE6NUFY3jFxd0=
X-Google-Smtp-Source: ABdhPJxQr9J+ROdkc9BycRypV+qU0m5iXTY6LBPfnBUZC934BBe41CdVYGTJUGyVbs+jMCvc5Fxcxg==
X-Received: by 2002:a63:de01:0:b0:3aa:2cf6:faf7 with SMTP id f1-20020a63de01000000b003aa2cf6faf7mr11477691pgg.224.1650512175591;
        Wed, 20 Apr 2022 20:36:15 -0700 (PDT)
Received: from localhost (58-6-252-72.tpgi.com.au. [58.6.252.72])
        by smtp.gmail.com with ESMTPSA id k22-20020aa790d6000000b0050a765d5d48sm12861566pfk.160.2022.04.20.20.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 20:36:14 -0700 (PDT)
Date:   Thu, 21 Apr 2022 13:35:55 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 bpf 1/3] vmalloc: replace VM_NO_HUGE_VMAP with
 VM_ALLOW_HUGE_VMAP
To:     Christoph Hellwig <hch@infradead.org>, Song Liu <song@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, imbrenda@linux.ibm.com,
        open list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        rick.p.edgecombe@intel.com
References: <20220411233549.740157-1-song@kernel.org>
        <20220411233549.740157-2-song@kernel.org> <YlT9i9DFvwDx9+AD@infradead.org>
        <CAPhsuW7XJHa3OaTT-4=33c70gUjCaWFrVe8h8J-hZetjxXeeog@mail.gmail.com>
        <1650507506.z839xl6pvt.astroid@bobo.none>
In-Reply-To: <1650507506.z839xl6pvt.astroid@bobo.none>
MIME-Version: 1.0
Message-Id: <1650512125.tnay4e9v4h.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Excerpts from Nicholas Piggin's message of April 21, 2022 12:24 pm:
> Excerpts from Song Liu's message of April 12, 2022 4:00 pm:
>> On Mon, Apr 11, 2022 at 9:18 PM Christoph Hellwig <hch@infradead.org> wr=
ote:
>>>
>>> On Mon, Apr 11, 2022 at 04:35:46PM -0700, Song Liu wrote:
>>> > Huge page backed vmalloc memory could benefit performance in many cas=
es.
>>> > Since some users of vmalloc may not be ready to handle huge pages,
>>> > VM_NO_HUGE_VMAP was introduced to allow vmalloc users to opt-out huge
>>> > pages. However, it is not easy to add VM_NO_HUGE_VMAP to all the user=
s
>>> > that may try to allocate >=3D PMD_SIZE pages, but are not ready to ha=
ndle
>>> > huge pages properly.
>>>
>>> This is a good place to document what the problems are, and how they ar=
e
>>> hard to track down (e.g. because the allocations are passed down I/O
>>> stacks)
>>=20
>> Will add it in v3.
>>=20
>>>
>>> >
>>> > Replace VM_NO_HUGE_VMAP with an opt-in flag, VM_ALLOW_HUGE_VMAP, so t=
hat
>>> > users that benefit from huge pages could ask specificially.
>>> >
>>> > Also, replace vmalloc_no_huge() with opt-in helper vmalloc_huge().
>>>
>>> We still need to find out what the primary users of the large vmalloc
>>> hashes was and convert them.
>>=20
>> @ Claudio and Nicholas,
>>=20
>> Could you please help identify users of large vmalloc? So far, I found
>> alloc_large_system_hash(), and something like the following seems to
>> work:
>=20
> The large system hashes were the main ones I was interested in. IIRC=20
> there was a few more in some drivers or tracing things depending on
> config but those are less important (to me at least).

Oh there is also a reverse map array in KVM now I think of it.

Thanks,
Nick
