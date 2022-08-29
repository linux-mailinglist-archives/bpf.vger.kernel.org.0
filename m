Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C795A5692
	for <lists+bpf@lfdr.de>; Mon, 29 Aug 2022 23:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiH2V5T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 17:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiH2V5S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 17:57:18 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D80079696
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 14:57:15 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id u9so18446919ejy.5
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 14:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=VBA+kSIQPwArAD1ELvFTspW/7MJBxwV067Y2I2o663Y=;
        b=mdjwfXLzQ4b/3N7TJXfUe+7bylmjjR55mbwNwXga86/GmiBQ4w7xZYuTdQ5F6kxZWx
         lbIj0bX5bMBRPJDFxd15UZXQW8HC9KHoub1NGlepKa4htglHD4YRlHYBbQfMVegzfQGO
         zYSLAvIwHh1qJSkFIJcYDbyImN7EJFG83/T8UjKpwU/nkud49NQc+cHgG8cSluUeDT/d
         sU/7HH5FxX4kGciVILj2nGNzQ2qg9L0Vz8Sz1rDL2tRKUPq+rCXAe7Hu7KDLSVFKMPLl
         zXiPSqiBdpO6gVxfp7mt2udxhVvoK/18WV4NsVpkUuLJXmHR4fbN4+8TpfktmkA1qEKR
         MV/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=VBA+kSIQPwArAD1ELvFTspW/7MJBxwV067Y2I2o663Y=;
        b=tg2kVWCscir3XjH52fayENmOXCgIrlDHFq0GMvfcWsEFWF2wgFNsEDjX2rMJdB7hHk
         HAZjHJK2hLcYY3dLraa6kIWK2FCu7luN3AProJHTE129i5WLINgG4kXyUeNZ3o8eh7D/
         CwXsxa9RSaysDQBoUCf2XnyUpf3mD4f8xZm8G366FVpkMFb/G5r6f0ZjdYjDfNR3tvx2
         2vI4ZKfOc7JqIR6JuJc+JgkheS3IL50mtkpepcwrKjxpg9nS/C5HSNOssnfioCcVBwau
         P0wN8o7vShCfQ2Ougv1pjeKcKSW80HeeN7lq+uaw/45o2UbXgoGAj0LByims2Ve1QD99
         8HrQ==
X-Gm-Message-State: ACgBeo3np91wTx8Y5MeSVn1ECl+KR3dx+TRt2qFWBWRbVlCCv9CljUUp
        G4Ad9SPVjJLGH/xMTl3eZprdnX+MVTPvZAzzr6A8YUUn
X-Google-Smtp-Source: AA6agR6zkN7FHpBFVpPrOBXm20LVg0YdiFNUgES6wyeHYh0zyWorO5bHhinZMWWHFCjSrWOPmaN8ZWrWl3V0S/JuZGQ=
X-Received: by 2002:a17:907:2c74:b0:741:657a:89de with SMTP id
 ib20-20020a1709072c7400b00741657a89demr6549249ejc.58.1661810233628; Mon, 29
 Aug 2022 14:57:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220826024430.84565-1-alexei.starovoitov@gmail.com>
 <20220826024430.84565-7-alexei.starovoitov@gmail.com> <75b5f42d-84f6-4227-0bf9-fb62c89217c7@iogearbox.net>
In-Reply-To: <75b5f42d-84f6-4227-0bf9-fb62c89217c7@iogearbox.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 29 Aug 2022 14:57:02 -0700
Message-ID: <CAADnVQKnZecxOCA9ByNEQYgkT+wDcvAysisJ9fbifAvBv_CW2Q@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 06/15] bpf: Optimize element count in
 non-preallocated hash map.
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Andrii Nakryiko <andrii@kernel.org>, Tejun Heo <tj@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Delyan Kratunov <delyank@fb.com>,
        linux-mm <linux-mm@kvack.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
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

On Mon, Aug 29, 2022 at 2:47 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 8/26/22 4:44 AM, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > The atomic_inc/dec might cause extreme cache line bouncing when multiple cpus
> > access the same bpf map. Based on specified max_entries for the hash map
> > calculate when percpu_counter becomes faster than atomic_t and use it for such
> > maps. For example samples/bpf/map_perf_test is using hash map with max_entries
> > 1000. On a system with 16 cpus the 'map_perf_test 4' shows 14k events per
> > second using atomic_t. On a system with 15 cpus it shows 100k events per second
> > using percpu. map_perf_test is an extreme case where all cpus colliding on
> > atomic_t which causes extreme cache bouncing. Note that the slow path of
> > percpu_counter is 5k events per secound vs 14k for atomic, so the heuristic is
> > necessary. See comment in the code why the heuristic is based on
> > num_online_cpus().
>
> nit: Could we include this logic inside percpu_counter logic, or as an extended
> version of it? Except the heuristic of attr->max_entries / 2 > num_online_cpus() *
> PERCPU_COUNTER_BATCH which toggles between plain atomic vs percpu_counter, the
> rest feel generic enough that it could also be applicable outside bpf.

The heuristic is probably not generic enough and this optimization
is a stop gap. It helps many cases, but doesn't solve all.
It's ok for this specific large hash map to count max_entries,
but we shouldn't claim generality to suggest this heuristic
to anyone else. I was thinking to do a follow up and create
a true generic combined percpu and atomic counter, similar
to percpu_ref that can switch from percpu to atomic.
But it's more of a wish-list task atm.
