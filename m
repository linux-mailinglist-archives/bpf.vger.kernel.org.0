Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E84658E464
	for <lists+bpf@lfdr.de>; Wed, 10 Aug 2022 03:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiHJBPT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 21:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiHJBPP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 21:15:15 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6B4390;
        Tue,  9 Aug 2022 18:15:13 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id h22so4665566qtu.2;
        Tue, 09 Aug 2022 18:15:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=9z8DBBifgkq61eRO+eTNs7T6Uni8kIgemh6E9ctPyVk=;
        b=kOqSB8i+OjaAZelptc48qGUHp+W0b6QQIjNUFh1Uk/579fjU4Ha2HGtZ07n5nQiPXh
         RBCTnYHwlCfPVY8pRaHExCpuMuy4MIbYQg8E8zFzU263l/7C2we/tRHm14CIH2OJd22l
         VzH9lRpmzeKZrGrhkW7zkQSn5nloBmamPPKDCrtiTovNJ4c3mFW7UTxkCnJoBWhDm9II
         Yk6fm3gI1OgQpOkQgNakwzqALEr3gFAq11ZdmvnQBIIU3d+cfQe8zwJ87VSAcfkgFouZ
         3d/QztaJQ5gdIGBB9FmHaCjhQnGlg/G+Gdpxsb9hyVSXp+NMJEXlA0oeNr5xaIjg9WJ6
         JYbQ==
X-Gm-Message-State: ACgBeo2sV0J54FsI3DLNVopBHdqZw90FlPmxWkczNSyPrUKErEnbEUIn
        ElUmN3K3pzMpvGz3QWflG4c=
X-Google-Smtp-Source: AA6agR6gwRuYaoWSNfwhCRSGAbU97vnIZ7xYN+3f4SdlOvWm8FcE+H6apQTwi27KEHzX3zsd3vling==
X-Received: by 2002:a05:622a:654:b0:31e:e8aa:aef0 with SMTP id a20-20020a05622a065400b0031ee8aaaef0mr22124777qtb.328.1660094112722;
        Tue, 09 Aug 2022 18:15:12 -0700 (PDT)
Received: from maniforge (c-24-15-214-156.hsd1.il.comcast.net. [24.15.214.156])
        by smtp.gmail.com with ESMTPSA id y5-20020a37f605000000b006b5f8f32a8fsm12152264qkj.114.2022.08.09.18.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 18:15:12 -0700 (PDT)
Date:   Tue, 9 Aug 2022 20:15:10 -0500
From:   David Vernet <void@manifault.com>
To:     Hao Luo <haoluo@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, john.fastabend@gmail.com, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
        jolsa@kernel.org, tj@kernel.org, joannelkoong@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] bpf: Add user-space-publisher ringbuffer map type
Message-ID: <20220810011510.c3chrli27e6ebftt@maniforge>
References: <20220808155248.2475981-1-void@manifault.com>
 <CA+khW7iuENZHvbyWUkq1T1ieV9Yz+MJyRs=7Kd6N59kPTjz7Rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+khW7iuENZHvbyWUkq1T1ieV9Yz+MJyRs=7Kd6N59kPTjz7Rg@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Hao,

On Mon, Aug 08, 2022 at 11:57:53AM -0700, Hao Luo wrote:
> > Note that one thing that is not included in this patch-set is the ability
> > to kick the kernel from user-space to have it drain messages. The selftests
> > included in this patch-set currently just use progs with syscall hooks to
> > "kick" the kernel and have it drain samples from a user-producer
> > ringbuffer, but being able to kick the kernel using some other mechanism
> > that doesn't rely on such hooks would be very useful as well. I'm planning
> > on adding this in a future patch-set.
> >
> 
> This could be done using iters. Basically, you can perform draining in
> bpf_iter programs and export iter links as bpffs files. Then to kick
> the kernel, you simply just read() the file.

Thanks for pointing this out. I agree that iters could be used this way to
kick the kernel, and perhaps that would be a sufficient solution. My
thinking, however, was that it would be useful to provide some APIs that
are a bit more ergonomic, and specifically meant to enable kicking
arbitrary "pre-attached" callbacks in a BPF prog, possibly along with some
payload from userspace.

Iters allow userspace to kick the kernel, but IMO they're meant to enable
data extraction from the kernel, and dumping kernel data into user-space.
What I'm proposing is a more generalizable way of driving logic in the
kernel from user-space.

Does that make sense? Looking forward to hearing your thoughts.

Thanks,
David
