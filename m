Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96CB6287C8
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 19:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237952AbiKNSDm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 13:03:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238245AbiKNSDP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 13:03:15 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A252B194
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 10:01:56 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id z18so18456782edb.9
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 10:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+99p6AyWseoZxnXwKl/owMa4PlvnyBCfnTWD8GnxaC0=;
        b=gwnRqP2g9BR7DdYPKO7nHYNxfALogDVoz51Ha8vOkmptQaV9juLFnJcq+THJ2/sRfq
         3NzKdnJKxf+nZr4tbiydFZ6IfzItUga01HsMpGSco5Xu/yIFXiTnz13/BkuOYct9PLzm
         0Nr2ynT+8WSxH4ohJZnG9DAQEpJIE5uCCfDVS/lIS5xaX9zFHbtheD6x+3DXyBDcMitI
         F6RRpb4xTfcnbXhZ3ncCfC5gRFVO1IDz2ZvwJFB0mtHw4clCvpznUpR4MbadudetgNFE
         c/E2ULV2ZWXTRnAxx1RAp5NpMcbYIQ/W4MoR/W8LHOF/cwGI+ydTCaAmvxKflqdgSKFJ
         h6ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+99p6AyWseoZxnXwKl/owMa4PlvnyBCfnTWD8GnxaC0=;
        b=b5Dcl0XrdQbqSLT24rX0+sZ+cuPCX5DI1L6Tmk0/d9/xjWF0QM2EjwfSiVwLxDF9J3
         GNl+1VOshKfMrTkEhUZv/n2pObxPeGsjkUhpFmiLHm/UvTM4vF8U7eEmxGFwTqEELWIW
         b1ZXFvEhvXq/KneLZJw+K6rMQ6mpVwjsOGQ2zMlO0D19LhexljUMfU720GcKLYTKPW8e
         GMAZBp0HrqHh5b89X1YCMiH/zLRkn5JiS1PSMxKkovRfBQsOtGkn6O6R6y2Gc4HfKa9x
         YUM9z6EJ7D4C43jKPVrX6wx6m9XLDHAMFUJeRdXPpX+H92ynEgbgkG63UUcJLnKJbh+I
         f3fg==
X-Gm-Message-State: ANoB5pm1PeMwer1kC1YvvdI35V5WJQMR9jr/nd51r6xSOzFl/zHtqj/i
        dG83056BYdQfqIDZJO9TmmQCspohLWh7SstVL9QtFVlH
X-Google-Smtp-Source: AA0mqf7xdUp/UwFMpKlHWebMrUBMJgk0xPRK98gPXNu3gh8GH19mI0FDNnKbGCXgDo/SQPcnHYCAMaJGMDCUd949JO4=
X-Received: by 2002:aa7:c512:0:b0:45c:935b:ae15 with SMTP id
 o18-20020aa7c512000000b0045c935bae15mr11672533edq.357.1668448914696; Mon, 14
 Nov 2022 10:01:54 -0800 (PST)
MIME-Version: 1.0
References: <20220826172915.1536914-1-eddyz87@gmail.com> <20220826172915.1536914-3-eddyz87@gmail.com>
In-Reply-To: <20220826172915.1536914-3-eddyz87@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 14 Nov 2022 10:01:43 -0800
Message-ID: <CAADnVQLhcEduU3JahFSGEhv3V56FuWhFfwsgGE1JHSrCBiOf2Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: check nullness propagation
 for reg to reg comparisons
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 26, 2022 at 10:30 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> Verify that nullness information is porpagated in the branches of
> register to register JEQ and JNE operations.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> Acked-by: Yonghong Song <yhs@fb.com>
> ---
>  .../bpf/verifier/jeq_infer_not_null.c         | 166 ++++++++++++++++++
>  1 file changed, 166 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/verifier/jeq_infer_not_null.c

These 4 new tests are failing in unpriv.

Pls fix and respin.
