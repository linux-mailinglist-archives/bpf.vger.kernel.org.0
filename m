Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B1558E34E
	for <lists+bpf@lfdr.de>; Wed, 10 Aug 2022 00:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiHIWhi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 18:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiHIWhZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 18:37:25 -0400
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF19266104
        for <bpf@vger.kernel.org>; Tue,  9 Aug 2022 15:37:23 -0700 (PDT)
Received: by mail-qv1-f51.google.com with SMTP id i4so9698978qvv.7
        for <bpf@vger.kernel.org>; Tue, 09 Aug 2022 15:37:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=n4hLcbwi1/1bOLbZ0THQBnkw21tIrDQjYjdCVyoC64I=;
        b=X8M2wFt1VIlip2kthRrwxeCH3/uVsCYH0JrvsA0dORaicDEwBdAh2oww06+6wJyxeg
         h2SvELVp9Rcr9swLKv29giSi1KlVAX8JRdr6hqieEukGSsGfdocEZGsxrY2sQvAKpJiD
         oEr7q25EbTolClak2Pu4rKnZwUntpc5qCuLJqX+//xcaNbSEyFKd3nOf4JRUGcVz1EUv
         JHNEM/AmyoGJmZZFhyh9Cvjnrohbihbs9//G8fmCltSbV8FSb3+37twJMLmBf+l3JWeY
         1RDhDj9f01eVIegXiIOlgTdrY2hwYv2kzRd99OWUsCKP4AjY48qk6feCECwQRqvHTJ4D
         zhsA==
X-Gm-Message-State: ACgBeo1IPVhgiEGZjJN8/p8ZA5Otb/Y9nIRORZkZ74jVFfy+akNYotNP
        aCwMeX7nA28l5oL7FKFHOj139PpIdLUHvxcM
X-Google-Smtp-Source: AA6agR6IByoXmGLAJ7SlHnGEtR28XENDVi3+AtYVE3f537HvyR2DXcFf1LYpkV1SS7izTjMYmpkWrg==
X-Received: by 2002:ad4:5ded:0:b0:478:f7a1:bc4e with SMTP id jn13-20020ad45ded000000b00478f7a1bc4emr20095272qvb.54.1660084642764;
        Tue, 09 Aug 2022 15:37:22 -0700 (PDT)
Received: from maniforge (c-24-15-214-156.hsd1.il.comcast.net. [24.15.214.156])
        by smtp.gmail.com with ESMTPSA id s12-20020a05622a018c00b003431446588fsm2035191qtw.5.2022.08.09.15.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 15:37:22 -0700 (PDT)
Date:   Tue, 9 Aug 2022 17:37:20 -0500
From:   David Vernet <void@manifault.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, kafai@fb.com, andrii@kernel.org,
        daniel@iogearbox.net, ast@kernel.org
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Fix ref_obj_id for dynptr data
 slices in verifier
Message-ID: <20220809223720.yubta5hspmbn5vih@maniforge>
References: <20220809214055.4050604-1-joannelkoong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809214055.4050604-1-joannelkoong@gmail.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 09, 2022 at 02:40:54PM -0700, Joanne Koong wrote:
> When a data slice is obtained from a dynptr (through the bpf_dynptr_data API),
> the ref obj id of the dynptr must be found and then associated with the data
> slice.
> 
> The ref obj id of the dynptr must be found *before* the caller saved regs are
> reset. Without this fix, the ref obj id tracking is not correct for
> dynptrs that are at an offset from the frame pointer.
> 
> Please also note that the data slice's ref obj id must be assigned after the
> ret types are parsed, since RET_PTR_TO_ALLOC_MEM-type return regs get
> zero-marked.
> 
> Fixes: 34d4ef5775f776ec4b0d53a02d588bf3195cada6 ("bpf: Add dynptr data slices");
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---

[...]

Looks good, thanks Joanne!

Acked-by: David Vernet <void@manifault.com>
