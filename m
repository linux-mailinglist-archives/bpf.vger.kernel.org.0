Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFEE85F52A8
	for <lists+bpf@lfdr.de>; Wed,  5 Oct 2022 12:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiJEKdk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Oct 2022 06:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJEKdi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Oct 2022 06:33:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37299754BF
        for <bpf@vger.kernel.org>; Wed,  5 Oct 2022 03:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664966017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aSocIwrgEkDka1DlTJPwPXJMuDv+aU5NB9kPIpmlG0I=;
        b=BhBftDmyyYKjikUCm8RWAT5pV2OaKkwSNSeUXQkSJt92oS48XzvtMSpAMgqFKDbOdkPhBj
        ZTzk0MYMaJuvr3L+vPx+srTRYQt6P1ytFSZWG8g42rpW3f18apjIMRpLbwwJTBGy4mmpYT
        gayCLgcXwVaaMmsPD/ad/Gh5nGN0VhM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-594-rch2o2qdNHaeEm01MxGWXQ-1; Wed, 05 Oct 2022 06:33:36 -0400
X-MC-Unique: rch2o2qdNHaeEm01MxGWXQ-1
Received: by mail-ed1-f69.google.com with SMTP id z16-20020a05640235d000b0045485e4a5e0so13192640edc.1
        for <bpf@vger.kernel.org>; Wed, 05 Oct 2022 03:33:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=aSocIwrgEkDka1DlTJPwPXJMuDv+aU5NB9kPIpmlG0I=;
        b=Gu6RlFIq7sQ6f5kKqTJpdylBsLYad18gHv9Z7FmpyI0fgSqg88fbxRw7sOXuglCmMC
         E8neNU/KDQ7gJ6I9NKPwVen0ZiwxSC5GKE0DoF0EasGl2CRwlvscZolCrmUT8u02KSbY
         Es7RoUoH5c8s4u9GTTkSM6W7+u+MeyM7XNuWkG+3isDvSmlQworJ9u0+LzWGYIdneats
         I62ZAlXmLJ/57f1mmDstJbEsF5huzSqkmWCjuqapic4/MZWAx2gZ/ATuN8sAsiPOjOH6
         5NX8nwUvuP/fbvO3QUpDEOAnuPYV5Ia0MRHajS74gNl55BazaO8AIZXUkVRvDeH0E9SW
         kluA==
X-Gm-Message-State: ACrzQf0zkztM9unGHse6hNZ2b5TWwCfvzZJJpOlqWqVZV/gmQAZBvn/p
        gGUyc50KOuvLAMU/2/nsg4tuzhQgqeNitbnTxS7s6lEfaSazdDAHjrtBVrZ5RviMqGh4K0/5kbw
        byXaA4c4qadUx
X-Received: by 2002:a05:6402:3547:b0:451:3be6:d55b with SMTP id f7-20020a056402354700b004513be6d55bmr27300777edd.57.1664966013550;
        Wed, 05 Oct 2022 03:33:33 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM64Kd8eN0YvoYqGN6dYRN8+ecYh1gUUThzoOVgNb56Y2SDI4BsTp0JLge+DROJ9OwiXcqW6zQ==
X-Received: by 2002:a05:6402:3547:b0:451:3be6:d55b with SMTP id f7-20020a056402354700b004513be6d55bmr27300629edd.57.1664966011102;
        Wed, 05 Oct 2022 03:33:31 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id j14-20020a170906094e00b007417041fb2bsm8397875ejd.116.2022.10.05.03.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 03:33:30 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id AB7DF64EB7E; Wed,  5 Oct 2022 12:33:29 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Cc:     razor@blackwall.org, ast@kernel.org, andrii@kernel.org,
        martin.lau@linux.dev, john.fastabend@gmail.com,
        joannelkoong@gmail.com, memxor@gmail.com, joe@cilium.io,
        netdev@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next 01/10] bpf: Add initial fd-based API to attach
 tc BPF programs
In-Reply-To: <20221004231143.19190-2-daniel@iogearbox.net>
References: <20221004231143.19190-1-daniel@iogearbox.net>
 <20221004231143.19190-2-daniel@iogearbox.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 05 Oct 2022 12:33:29 +0200
Message-ID: <87bkqqimpy.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Daniel Borkmann <daniel@iogearbox.net> writes:

> As part of the feedback from LPC, there was a suggestion to provide a
> name for this infrastructure to more easily differ between the classic
> cls_bpf attachment and the fd-based API. As for most, the XDP vs tc
> layer is already the default mental model for the pkt processing
> pipeline. We refactored this with an xtc internal prefix aka 'express
> traffic control' in order to avoid to deviate too far (and 'express'
> given its more lightweight/faster entry point).

Woohoo, bikeshed time! :)

I am OK with having a separate name for this, but can we please pick one
that doesn't sound like 'XDP' when you say it out loud? You really don't
have to mumble much for 'XDP' and 'XTC' to sound exactly alike; this is
bound to lead to confusion!

Alternatives, in the same vein:
- ltc (lightweight)
- etc (extended/express/ebpf/et cetera ;))
- tcx (keep the cool X, but put it at the end)

[...]

> +/* (Simplified) user return codes for tc prog type.
> + * A valid tc program must return one of these defined values. All other
> + * return codes are reserved for future use. Must remain compatible with
> + * their TC_ACT_* counter-parts. For compatibility in behavior, unknown
> + * return codes are mapped to TC_NEXT.
> + */
> +enum tc_action_base {
> +	TC_NEXT		= -1,
> +	TC_PASS		= 0,
> +	TC_DROP		= 2,
> +	TC_REDIRECT	= 7,
> +};

Looking at things like this, though, I wonder if having a separate name
(at least if it's too prominent) is not just going to be more confusing
than not? I.e., we go out of our way to make it compatible with existing
TC-BPF programs (which is a good thing!), so do we really need a
separate name? Couldn't it just be an implementation detail that "it's
faster now"?

Oh, and speaking of compatibility should 'tc' (the iproute2 binary) be
taught how to display these new bpf_link attachments so that users can
see that they're there?

-Toke

