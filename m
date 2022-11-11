Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9562A626373
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 22:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbiKKVRQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 16:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbiKKVRP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 16:17:15 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B1DDFD2
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 13:17:14 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id r186-20020a1c44c3000000b003cfa97c05cdso420907wma.4
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 13:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0qjG8ITBt9/CiA6anynanhqWalfLsM3uE+RtxKxf7gw=;
        b=OnJyleJOceN448BmempPSmw7/TBo7vxA0SFWMgFoYSrm5N75bcywtrgV+ti73/+BIu
         /7kG29VZ4aEC6t0rjEBh3g4JGpYv2HUrGvRnoMTKbsY1E+/EZFTQ7y4fOG/l7K9TA0SB
         9XjZ7vVlUK8fvXKMyoSrFXPbVaRMV7cogys8VixE8Y/Mh33LtGlKT1PKdW8bMxbvVFhO
         c9ealHBzVoauIW67rAjR6T4hGETU/Py1DSXQ64lLh1yuPf4aFn22qLtiak7FBL85V++S
         Eq4YogJIjiQ7oVRCOvjGclvVwLB11nYUmta/6Oh72FfXs/Cf5ZNMo4vyl07m7y6WJUJ9
         rhWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0qjG8ITBt9/CiA6anynanhqWalfLsM3uE+RtxKxf7gw=;
        b=0SU25qLZxV9esqugRZ12znjZrPa3FCdv80fKdO/KXusTKixLmnL8FKimvhtc8BIO8F
         iPohZ3lSxcX/5vm1YUqW98tmF3q6V/e0pklA7bMCNvZEfes7gkd9qY+5YxVd8hhLVxxc
         fK+sqTE6lzU6GmpvNaZkTPfvrgvxw2yANFzwkkEeB4ywajTiY06pr70R1XWvY12h2pvU
         oE2CMxQe4tT6OiCVvoPixvEMh5TjjXuRF9+OPdXBjjxt5P7iNtrjMwrAlCNLIi8PRkib
         JzjUvY0WvrKvMxHUzty+tgSzgD4G27qKO/kRkSFe2vrBy+gvspSZd5kDLce2/aYci0zC
         pbXQ==
X-Gm-Message-State: ANoB5pl15SskR88RFse8NNl80GVUAabMH9KrIeAY0WdDi3ga+5YcjYiF
        IMOQbiX6/dUCIp1OIo6lEqNWLDgSn3s=
X-Google-Smtp-Source: AA0mqf7s6CBT6/xQ77U3vvbFXCGwklHnG2D1Nqy2KgpVfcb7Ft1ByAukon/eP+8I8dSvksWnQ9QATg==
X-Received: by 2002:a05:600c:4101:b0:3cf:943f:bcf with SMTP id j1-20020a05600c410100b003cf943f0bcfmr2459448wmi.45.1668201431716;
        Fri, 11 Nov 2022 13:17:11 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id z9-20020a1cf409000000b003cfa81e2eb4sm3986844wma.38.2022.11.11.13.17.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 13:17:11 -0800 (PST)
Subject: Re: [PATCH bpf v1 0/2] Fix map value pruning check
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20221111202719.982118-1-memxor@gmail.com>
From:   Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <de18246f-3962-3870-1c72-31a4c9bd4a6d@gmail.com>
Date:   Fri, 11 Nov 2022 21:17:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20221111202719.982118-1-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/11/2022 20:27, Kumar Kartikeya Dwivedi wrote:
> However, looking more closely, it seems to me that the logic of
> check_ids is broken as well.
> 
> Edward, given you introduced the idmap, can you provide a little more
> historical context on what the idea behind check_ids was, since it seems
> to be doing the wrong thing as far as I understood things. I think we
> need to compare the ids directly everywhere.

reg->id has two different kinds of usage/semantics.  One, which was
 the only one when idmap was introduced, is pairing with other regs
 within state (including stack slots and caller frames); for this,
 check_ids() is fine (the comment above it explains why).
The other, added by d83525ca62cf ("bpf: introduce bpf_spin_lock"),
 pairs not with other regs' ids but with state->active_spin_lock;
 currently states_equal() requires this to be numerically identical
 between old and cur, rather than running it through the idmap; this
 would appear to be the origin of the bug.

Alexei, is there any valid world in which there's an active_spin_lock
 but the corresponding id does not exist anywhere in the state's
 regs, stack etc.?  If not then I think it suffices to
 check_ids(old->active_spin_lock, cur->active_spin_lock,
           env->idmap_scratch);
 in func_states_equal() of the leaf frame (only leaf frame can be
 holding a spinlock), and remove the existing check from
 states_equal().
Because what we want to know isn't "Do both of these spinlocks come
 from the same original ID derivation", but "do all registers that
 hold a value that could be used to unlock the spinlock in the
 continuation-to-exit of the old state also hold such a value in the
 current state", which means that we want the pair <old_asl, new_asl>
 in the idmap when we walk the regs and stack.

While we *could* implement that by requiring IDs to match numerically
 as in Kumar's patch, that's needlessly strict and will miss pruning
 opportunities.

-ed
