Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041DD678DCB
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 02:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbjAXBzp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Jan 2023 20:55:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbjAXBzo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Jan 2023 20:55:44 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703E639CC6
        for <bpf@vger.kernel.org>; Mon, 23 Jan 2023 17:55:38 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id v23so13349943plo.1
        for <bpf@vger.kernel.org>; Mon, 23 Jan 2023 17:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7lBS0YQWj6yQkRRAE4IXaum+Uw4ZV2JtiMr42FSj3bE=;
        b=qBQjewPADtcSujS4dSgSrlX4K9/pEKldPu49x4I3MeJ6tG6sLyYeKNdlGU0R3cj/Ou
         1cKfFfYob2fhCowZYyPrrsJIlj7fvk10k/mr0vbyEoP3vAmJ3avZpYBrZzX+SacTgLAi
         PBVOiaISJnd6xfGqKx6bAroHyLGJC/NYgBrVhW3UnEiWnKqMr1BXE0iY6PUU4jDZ9Yk+
         +icbAf0XSpnzLzmeVqXgBCuN0fEvUFV4UPcQ0wcfpWah0OpgweoQko/kcXJ9jWS7YsNW
         XoDzEK49xVleG9zql+DfLIj7mhN+i+7YlxpLlSeKGi+rzPYFdBOwSTgUT2bIssXxN14U
         W5eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7lBS0YQWj6yQkRRAE4IXaum+Uw4ZV2JtiMr42FSj3bE=;
        b=2/PaTTicgXce42FJk+VHzdtIQnU7tQf2Unq6D5mZalwothw3vWazySzSxVGM8iotzT
         C6MEu6+In7tcwlZbsoLwXh79af2p+laGFCtkRJlroqdoVCM3ZWb8MtwrgccSd+sItN/B
         WZqgMSY1IDSsR97FmvXO9ix92CuCYJCOc0GJeIYnvDxk+40oGosgmUH+rFmxdlefIaYg
         ShZeTJ9sV9NEjtCQLSg6pBOjIN1kT95Jt2v33rK0qFWJZ9EYqe/gQdpAxq1FtURVgLtA
         ipXAaFTRr7OmzJ06trs4Z+p8LmRjigpTs9aPqcWNLHV/cJ9vCLZI0ffXqZ4fY9mVgbQB
         0WhA==
X-Gm-Message-State: AFqh2krQ0rWwf1b82oej2vLekABU2J8AVfxYd0BjlGAcRmEZA+J13pD6
        vG98PxErpM6hRw/kAlzL1uGyo9XopLfGWpHfdTDq0w==
X-Google-Smtp-Source: AMrXdXskrHuZ7vmtymm5IEJuaMdp14SLsyaqkKiG2Qm+tCmMiGxLDk8AMRSmTP4bzan31Z191HNEvuosICEwVseHho8=
X-Received: by 2002:a17:90b:3758:b0:229:32c7:871a with SMTP id
 ne24-20020a17090b375800b0022932c7871amr2635203pjb.59.1674525337606; Mon, 23
 Jan 2023 17:55:37 -0800 (PST)
MIME-Version: 1.0
References: <CA+PiJmTMrWq-BGAMZgd317q0sT7tN-6=r3sDbZdb8iVzwPKdsw@mail.gmail.com>
 <0c4e8a7f-9891-338e-1308-599f2c2af447@linux.dev>
In-Reply-To: <0c4e8a7f-9891-338e-1308-599f2c2af447@linux.dev>
From:   Daniel Rosenberg <drosen@google.com>
Date:   Mon, 23 Jan 2023 17:55:26 -0800
Message-ID: <CA+PiJmSSgfAVo+SzevhE0qSdnX2MBKV17B-9JHcyGKF_aFvE-g@mail.gmail.com>
Subject: Re: Struct_ops Questions
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>
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

On Tue, Jan 17, 2023 at 11:06 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>
> On 1/13/23 5:05 PM, Daniel Rosenberg wrote:
>
> I think the first question is related to the refcnt of the struct_ops. Whenever
> a new tcp connection is established, it also needs to bump the refcnt of a (bpf)
> tcp_congestion_ops. The tcp subsystem currently does a bpf_try_module_get()
> which then calls bpf_struct_ops_get() if 'owner == BPF_MODULE_OWNER'.
> bpf_struct_ops_get() will inc the refcnt of the struct_ops.
>

Thanks! I hadn't noticed the 'owner == BPF_MODULE_OWNER' case. That
fits what I need exactly. The only issue there is that those functions
aren't exported for module use, which is easy enough to change.

>
> I think the next set of question is about when FUSE itself is built as a module.
> The first is how to register 'struct bpf_struct_ops bpf_fuse_struct_ops'. You
> are correct that right now it is done during compile time in
> bpf_struct_ops_types.h. To make FUSE itself built as a module and
> bpf_fuse_struct_ops defined in the FUSE module, some work is needed in
> bpf_struct_ops.c to allow registering struct_ops in runtime during module_init.
> For module reference counting, I think the bpf_fuse_struct_ops should be able to
> hold one refcnt of the fuse module. Not sure how bpf_fuse_struct_ops looks like
> and I also don't know how grabbing the map fd will help. It seems you already
> have something working, so it may be easier to discuss base on that.

For the moment, I'm just building the verification side into the
kernel and exporting a function to register the reg/unreg functions.
Adjusting bpf_struct_ops.c for registering struct_ops at runtime is
probably a better path. I'll look into that after I've got more
working under the new system. I still need to figure out how to get
dynptrs working with struct_ops, which I think is going to involve a
new dynptr type... Something like DYNPTR_TYPE_KERN, where the memory
is managed by the kernel, and only fully initialized dynptrs are
passed in. It's possible that BPF_DYNPTR_TYPE_RINGBUF might mostly
cover that already, but I imagine there's some ringbuf specific things
to it... At the moment, I've just got a toy setup for
bpf_fuse_struct_ops to figure out the verification I need, so there's
not all that much to see there yet.
