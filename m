Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F134BA45C
	for <lists+bpf@lfdr.de>; Thu, 17 Feb 2022 16:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242487AbiBQP3X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Feb 2022 10:29:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242490AbiBQP3W (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Feb 2022 10:29:22 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7DD2B1A98
        for <bpf@vger.kernel.org>; Thu, 17 Feb 2022 07:29:07 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id w20so4858028plq.12
        for <bpf@vger.kernel.org>; Thu, 17 Feb 2022 07:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gFplyG3MpQjvP7GkzFUjIQ19Oefwwr+BZ8SH9fdbg20=;
        b=S1o5aq2OSXE6Y7pSKLNp0e4Nc2wGoC7YbtAq0MSEaEdaoeIcVJTAEzMzeGPZ21v3pz
         F53FKxWxw2Z4wM/UD6ciDc5iDS0g1ostmUBnq4sQq3tBEQYRv5/G3ilG4jtWJyH/r2SG
         v73hdBThF+Y0ryNjl3qe9Qb74rrZDUUxFx1oAgeualqCfAHTKFiXM/s7MdV6Wsb5EU2D
         lw+eWqafV1PkeFEp16/ODixvXwR6dtnqLsVMDrnnGMj6oKlspZZBki5FS6QemxHRG2Ir
         Gfo6U0pb4WPS1CRx4tvaJVk7guDCEqnXChaol4az+Ba3sIt2CQtYgxMk6Ov9+UK3T4dQ
         VQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gFplyG3MpQjvP7GkzFUjIQ19Oefwwr+BZ8SH9fdbg20=;
        b=HkxK7CJTwKuR93UrtdzY5lIGniwbJA/BPiCBcdCaks7FMGfVjPOB+u43M3QgsndzMq
         /i8LzWl7trJi2ZOWx0koW6fIkXHiU5fCJse2f0YthQB/ztdbhn82kvIQKlMKHKm23dkl
         uCjzl151ho75Xaw6yQDRtvegN2lanu7jXvO85WmO070ocpHOjXdCcXiBdviG5iaxWhYB
         9pI6VMfpgKZslP54bntNAcfFbVJrK6oQRouwNkrtgRntPQAY93XvMr/3bOezKDa38BuK
         4iudsyxlhp1kb2IEdUmPb+HPqV6OAdRjulGIqhrMQK1quG5YXpinFY2v8c6bEbeId3kD
         sr9Q==
X-Gm-Message-State: AOAM531kTGzhHodkdlIS/pIx1id/YoKXg6Cr+X2chRMSWgC0fTMLKsEV
        Ka8uCfFtNZG7EA/SNO8CunZ8WJJT26MWcZAL80A=
X-Google-Smtp-Source: ABdhPJwtbsjW39qYHq6+t2cXlerTsI7Fz4qW8JylchzHaMCGdkJFO+YHD2oSgKerXjw2uLPaTTP0L6a/g3wYDmlwI7I=
X-Received: by 2002:a17:90a:b017:b0:1b9:485b:3005 with SMTP id
 x23-20020a17090ab01700b001b9485b3005mr7825804pjq.33.1645111747112; Thu, 17
 Feb 2022 07:29:07 -0800 (PST)
MIME-Version: 1.0
References: <20210913155122.3722704-1-yhs@fb.com> <b59428f2-28cf-f1fd-a02c-730c3a5e453f@fb.com>
 <87sfy82zvd.fsf@oracle.com> <fc6e80ec-a823-bee4-7451-2b4d497a64af@fb.com>
 <87ilvncy5x.fsf@oracle.com> <20211218014412.rlbpsvtcqsemtiyk@ast-mbp.dhcp.thefacebook.com>
 <7122dbee-8091-8cd1-d3e4-d5625d5d6529@fb.com> <87czlr4ndp.fsf@oracle.com>
 <61e04a73-bc4d-b250-31fe-93df4100c923@fb.com> <87pmodgpe8.fsf@oracle.com>
 <5e20c3e3-8074-9a94-ae9c-1ffa3c65ec82@fb.com> <875ypdvdcr.fsf@oracle.com>
In-Reply-To: <875ypdvdcr.fsf@oracle.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 17 Feb 2022 07:28:55 -0800
Message-ID: <CAADnVQJAHwMuyikV5+2xk5fUwsieH246YdqNFXFE0W1_AiD_qw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 00/11] bpf: add support for new btf kind BTF_KIND_TAG
To:     "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Mark Wielaard <mark@klomp.org>, david.faust@oracle.com
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

On Thu, Feb 17, 2022 at 5:20 AM Jose E. Marchesi
<jose.marchesi@oracle.com> wrote:
>
> Just a heads-up.
>
> We are still working on the GCC implementation of the tags.  Having some
> difficulties with the ordering of the C type attributes.
>
> Regarding the DWARF part, GCC uses DWARF as the internal "canonical"
> debug info, and the BTF is generated from it.  This means we had to add
> a DWARF DIE for the pointer tag qualifier anyway in order to convey the
> info to BTF.  So now it is just a matter of emitting it along with the
> rest of the DWARF.

Thanks for the update!
Do you have an early git branch we can use to test building
the kernel with it?
Or is it not at this level yet?
