Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6A763DB8C
	for <lists+bpf@lfdr.de>; Wed, 30 Nov 2022 18:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbiK3RGU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 12:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbiK3RFV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 12:05:21 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5271898952;
        Wed, 30 Nov 2022 09:00:20 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id t17so16214337pjo.3;
        Wed, 30 Nov 2022 09:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BIxkG6XtCL2NVCbpDxVt8cW3AePHIClzg7zjjJN02x4=;
        b=Q/3dOAiqE9Q5eO3HZSGyjs/ByTks7JYOhT8kAQaUyA1jA/Roh0+UPHvMwX78r6t9vP
         2fHZbgPk5V6Mg3w5gbmF9eqneYQxk/RPcrCPNTuLnvtRureMqD8P445/CDNcV7m8BkC4
         mBd56X8blbvytvSmWPwh0zAWRh+nXH5QwmHm5AGx3b5AZ78ULpzc+eP+aiYO+4IAu5Rd
         djUqhsz8ZZxK4+UqWwWjBsNiWETUMNbU4mVC0g1eQhC3yKZP7U2VflU1x+HhA43N8/MO
         0P1n/InMVN0/yZqRHdEmIe2TvgIO1UivZVwbWFRvnztzagPAYaBfXE4jj/DazmvQ9JxO
         8VDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BIxkG6XtCL2NVCbpDxVt8cW3AePHIClzg7zjjJN02x4=;
        b=UCdB3hxxckY5vvWGoHpxePmaMM+xnQqLX+JedpuUUe1gLqFY57lq9iZQekf/RVl7/O
         VrB1Sje6WWFmeIfQpsZfeIa1eE26vsjhbgKsH6bYm7pn2lAhW5EoexiLr5BZLh4qkihc
         2nSpBs3o/mYD1emP7IfHD46uKAxkiTQNkKGrWMFo75iA/5fmiqNNm3iqZ+xOSmnRtzTT
         aLrLrRLSXWA/z4xmQ5a9LNLZj1A1dHpz7iFAbxTJt5524ItSe5nonRwg/JClytKFQ5BT
         C81mIA1lCq4EMapo8MqcIGKacrh0zq1Km3w0nrbYqniq2x4n2X3Mg6OxBlVIHdBvCRyR
         ppOQ==
X-Gm-Message-State: ANoB5plr+FXEwK8/ORF0YQTMkjPpTOs9XiozHUqe4I6QLxClinvWvp3W
        p7geqVk31cORaid2Goxzx70=
X-Google-Smtp-Source: AA0mqf7T0JWZ+//PP4jsqkRBwCmS6cqF3P/aQtFBzHVJG8H/75AYlmiNvk9AIsaEZ3i0LANXbqO2dQ==
X-Received: by 2002:a17:90a:eac2:b0:219:484:e955 with SMTP id ev2-20020a17090aeac200b002190484e955mr29911286pjb.214.1669827619269;
        Wed, 30 Nov 2022 09:00:19 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902e80b00b0018996404dd5sm1741487plg.109.2022.11.30.09.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 09:00:18 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 30 Nov 2022 07:00:17 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH 01/31] rhashtable: Allow rhashtable to be used from
 irq-safe contexts
Message-ID: <Y4eMIVbgFgbxcMhr@slm.duckdns.org>
References: <20221130082313.3241517-1-tj@kernel.org>
 <20221130082313.3241517-2-tj@kernel.org>
 <CAHk-=wg8wvB4vo-PaCSMSRaCd2c+rk8OnE72eF+skDVMdk9LsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg8wvB4vo-PaCSMSRaCd2c+rk8OnE72eF+skDVMdk9LsA@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

On Wed, Nov 30, 2022 at 08:35:13AM -0800, Linus Torvalds wrote:
> On Wed, Nov 30, 2022 at 12:23 AM Tejun Heo <tj@kernel.org> wrote:
> >
> >
> >  static inline void rht_lock(struct bucket_table *tbl,
> > -                           struct rhash_lock_head __rcu **bkt)
> > +                           struct rhash_lock_head __rcu **bkt,
> > +                           unsigned long *flags)
> 
> I guess it doesn't matter as long as this actually gets inlined, but
> wouldn't it be better to have
> 
>    flags = rht_lock(..);
>    ...
>    rht_unlock(.., flags);
> 
> as the calling convention? Rather than passing a pointer to the stack around.

Sure thing.

> That's what the native _raw_spin_lock_irqsave() interface is (even if
> "spin_lock_irqsave()" itself for historical reasons uses that inline
> asm-like "pass argument by reference *without* using a pointer")

Yeah, it always feels kinda weird to wrap irqsave/restore due to the special
reference passing.

> And gaah, we should have made 'flags' be a real type long ago, but I
> guess 'unsigned long' is too ingrained and traditional to change that
> now.

Hahaha, that's gonna be an epic patchset.

Thanks.

-- 
tejun
