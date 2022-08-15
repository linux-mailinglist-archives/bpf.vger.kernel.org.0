Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF69B594CF5
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 03:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244164AbiHPBXT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Aug 2022 21:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244210AbiHPBW7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Aug 2022 21:22:59 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6F61C6AD8
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 14:13:27 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id w18so1576010qki.8
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 14:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=i1YnZDU4kGkUqvV68QP5vWBRPLjGwIcMu76nuGXlI1w=;
        b=i9KT+nlIeo4sOmKbkuU5XWL5+h8V3JdrhAle4xxsyCRvLbFhGDB7sd4z19BwiNcfaE
         4EuGTaG3d7cpnzjaB4g7LUVMlrmZnq/REudt4tOlnQ75HLaAHtI2trxUKf2mMLisTboI
         pVukSq5zi8A+93NLG9Ap70JSEVpKq4zTdmIilCVRWTG+SW2oDqlIDXvcW1n/6zB+Sl26
         EBGy2zwla+bX6tB4cJ1jT5fMYh8Q1YUIi18LfdnHXP7jKChD7WaUMdSehjflR9yiZJeS
         /LyJZNHx/L9681CppzBG+eBfI8aRp6JatjQhBY3b6qw3PT77qMJg2oTXwGcA/DbD35zK
         HqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=i1YnZDU4kGkUqvV68QP5vWBRPLjGwIcMu76nuGXlI1w=;
        b=JKfRdtvoNFS377hzCEin131oZ1aFqjAAj/5enmv0bKRd3bYyPFwjf52SQ0Z0Dnh4YI
         5M+yC+ZrB4h1whSLmmoignxNCZo0KK3W+FVjEVOGkxv8LCNvndYnEzm96YI0JN83Cbm4
         5dMl1Na64zoVSxqIs9xELyBodCoKXX3xMArsvun6bmJs7muVYje6+pekb1RvEO6TkQIe
         +48GLViHa6+rl5hJ5dTqW6AOAZ6gz/MFnEuREUS2TI/O7sAuCSXfV0/uvOUZvZL9GBok
         VkbUFr3jwuhxi1ugWysK4IWNZvzHYu9K7fgAhi26r3LI2v8xu4B+fSrNo+QMIl+6++9e
         sBFQ==
X-Gm-Message-State: ACgBeo0KrEiluAot8/AlzDRQLNnklMP3p32JVhJ+6ZiuqjZOdLnP8LH0
        4j7fgOIpHcNKJXV1ssuL+i9fAaSNS8dsn7jOzAaczg==
X-Google-Smtp-Source: AA6agR5pzAAJiuU9oX7Kdy38RRItPdNJmP3D71vCHcN9IBFjaFJ7BYZAyyUaT85g2vLwlvmgqg2PHrRSMbAXXhk1Sng=
X-Received: by 2002:a05:620a:459e:b0:6ba:c5a7:485c with SMTP id
 bp30-20020a05620a459e00b006bac5a7485cmr12410926qkb.267.1660598004119; Mon, 15
 Aug 2022 14:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220808155248.2475981-1-void@manifault.com> <CA+khW7iuENZHvbyWUkq1T1ieV9Yz+MJyRs=7Kd6N59kPTjz7Rg@mail.gmail.com>
 <20220810011510.c3chrli27e6ebftt@maniforge>
In-Reply-To: <20220810011510.c3chrli27e6ebftt@maniforge>
From:   Hao Luo <haoluo@google.com>
Date:   Mon, 15 Aug 2022 14:13:13 -0700
Message-ID: <CA+khW7iBeAW9tzuZqVaafcAFQZhNwjdEBwE8C-zAaq8gkyujFQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] bpf: Add user-space-publisher ringbuffer map type
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, john.fastabend@gmail.com, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
        jolsa@kernel.org, tj@kernel.org, joannelkoong@gmail.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 9, 2022 at 6:15 PM David Vernet <void@manifault.com> wrote:
>
> Hi Hao,
>
> On Mon, Aug 08, 2022 at 11:57:53AM -0700, Hao Luo wrote:
> > > Note that one thing that is not included in this patch-set is the ability
> > > to kick the kernel from user-space to have it drain messages. The selftests
> > > included in this patch-set currently just use progs with syscall hooks to
> > > "kick" the kernel and have it drain samples from a user-producer
> > > ringbuffer, but being able to kick the kernel using some other mechanism
> > > that doesn't rely on such hooks would be very useful as well. I'm planning
> > > on adding this in a future patch-set.
> > >
> >
> > This could be done using iters. Basically, you can perform draining in
> > bpf_iter programs and export iter links as bpffs files. Then to kick
> > the kernel, you simply just read() the file.
>
> Thanks for pointing this out. I agree that iters could be used this way to
> kick the kernel, and perhaps that would be a sufficient solution. My
> thinking, however, was that it would be useful to provide some APIs that
> are a bit more ergonomic, and specifically meant to enable kicking
> arbitrary "pre-attached" callbacks in a BPF prog, possibly along with some
> payload from userspace.

David, very sorry about the late reply. Thank you for sharing your
thoughts. I am looking at your v2 and understand you need a way to
trigger the kernel to consume samples in the ringbuf, which seems a
reasonable motivation to me.

>
> Iters allow userspace to kick the kernel, but IMO they're meant to enable
> data extraction from the kernel, and dumping kernel data into user-space.

Not necessarily extracting data and dumping data. It could be used to
do operations on a set of objects, the operation could be
notification. Iterating and notifying are orthogonal IMHO.

> What I'm proposing is a more generalizable way of driving logic in the
> kernel from user-space.
> Does that make sense? Looking forward to hearing your thoughts.

Yes, sort of. I see the difference between iter and the proposed
interface. But I am not clear about the motivation of a new APis for
kicking callbacks from userspace. I guess maybe it will become clear,
when you publish a concerte RFC of that interface and integrates with
your userspace publisher.

Hao
