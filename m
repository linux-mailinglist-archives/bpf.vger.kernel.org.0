Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC165595EC6
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 17:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiHPPKG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 11:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiHPPKE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 11:10:04 -0400
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4E2543CF;
        Tue, 16 Aug 2022 08:10:02 -0700 (PDT)
Received: by mail-qv1-f42.google.com with SMTP id mk9so8048858qvb.11;
        Tue, 16 Aug 2022 08:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=dmgWwEwfSK7FGsGGvHTpCWRuqiYbuUsXIkCtXthtW4o=;
        b=h64S4wkiwJ9kr5LkPNu1MnA4VHptnYRU5RBoLqa6wrSsRQxzuQyzGWVpo2sCiG13KX
         ogJBJ9XN2yee8BRFyZ5CQ8LP2SEqtCk8DrtlBMOO/HwxlLjJ+a08aWTE9uE6wFTxq5Bo
         7uk2LpAKGZyxL8A1k/JGCGcrQJZe/Owec0uPZhnPyKBFAiV7nNth7sG9jd6KggEpjf6F
         AH5w9W1gWm3Yy3KZ9wt2pDzRt4IWOxf/JSK3ElWDFU9DTZ6EekuuMvBYTgokQHXvUgyN
         hkMiCFuntWmNG0fJFJXgP0BdxhvmiqPM0FsBDa7A5buVP3UdQrPR038PFeioPhS+y9ca
         E2+A==
X-Gm-Message-State: ACgBeo0QyT0R1xQ/d9vQ8zgUBHp34V6TwXXJBuU6Na2r2LJvRhVgBFem
        qnoee4Bt/Ooiu3YKrlI3B+sYq6TnAFfKcJxm
X-Google-Smtp-Source: AA6agR4EeFp05FpPHq8UdmVOXNNu464JjT1fmdsjyoMQjlwI69GiHM8ow57TAxJ2PMe6tP3RBnqjVw==
X-Received: by 2002:a05:6214:c6c:b0:496:8e7:a93b with SMTP id t12-20020a0562140c6c00b0049608e7a93bmr1193772qvj.97.1660662601979;
        Tue, 16 Aug 2022 08:10:01 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::a5ed])
        by smtp.gmail.com with ESMTPSA id dm14-20020a05620a1d4e00b006bad20a6cfesm10794561qkb.102.2022.08.16.08.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 08:10:01 -0700 (PDT)
Date:   Tue, 16 Aug 2022 10:09:41 -0500
From:   David Vernet <void@manifault.com>
To:     Hao Luo <haoluo@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, john.fastabend@gmail.com, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
        jolsa@kernel.org, tj@kernel.org, joannelkoong@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] bpf: Add user-space-publisher ringbuffer map type
Message-ID: <YvuzNaam90n4AJcm@maniforge.dhcp.thefacebook.com>
References: <20220808155248.2475981-1-void@manifault.com>
 <CA+khW7iuENZHvbyWUkq1T1ieV9Yz+MJyRs=7Kd6N59kPTjz7Rg@mail.gmail.com>
 <20220810011510.c3chrli27e6ebftt@maniforge>
 <CA+khW7iBeAW9tzuZqVaafcAFQZhNwjdEBwE8C-zAaq8gkyujFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+khW7iBeAW9tzuZqVaafcAFQZhNwjdEBwE8C-zAaq8gkyujFQ@mail.gmail.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 15, 2022 at 02:13:13PM -0700, Hao Luo wrote:
> >
> > Iters allow userspace to kick the kernel, but IMO they're meant to enable
> > data extraction from the kernel, and dumping kernel data into user-space.
> 
> Not necessarily extracting data and dumping data. It could be used to
> do operations on a set of objects, the operation could be
> notification. Iterating and notifying are orthogonal IMHO.
> 
> > What I'm proposing is a more generalizable way of driving logic in the
> > kernel from user-space.
> > Does that make sense? Looking forward to hearing your thoughts.
> 
> Yes, sort of. I see the difference between iter and the proposed
> interface. But I am not clear about the motivation of a new APis for
> kicking callbacks from userspace. I guess maybe it will become clear,
> when you publish a concerte RFC of that interface and integrates with
> your userspace publisher.

Fair enough -- let me remove this from the cover letter in future
versions of the patch-set. To your point, there's probably little to be
gained in debating the merits of adding such APIs until there's a
concrete use-case.

Thanks,
David
