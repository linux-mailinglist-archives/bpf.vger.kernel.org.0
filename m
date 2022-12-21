Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7138652AD6
	for <lists+bpf@lfdr.de>; Wed, 21 Dec 2022 02:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbiLUBP4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Dec 2022 20:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234192AbiLUBPy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Dec 2022 20:15:54 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F40F20345
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 17:15:50 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id m19so19977604edj.8
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 17:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MSxjHqQVmsvAqdAktDzJq1Aaq4WkRfg4dNDMnFRlXJE=;
        b=VrDVe24FHaDSkP65tI54UK7fLaALS1pS5jFeOxPQ1kDDnh3sN1RhHR1YSx+wnbXlA+
         NbWw8lZujY6H54BLcSPCC/f1Zu+lo4kbfueL8eSRYVZ8U/qhDNXC0fuksNveGIMOy20b
         LSsYY4WMilHkek8xwkgEpvVIQaUo64Mtdb4wUkosnkDOAzRAWkfBHfnz7/ikMLiMYp+s
         uE7E6L1LVaSgmEY8fwpHHIBA9MECQqvk4z1AhOrP/Pt80Tya/G6rsxDbGkNay/T7MXJz
         Y8inQkZaznD6hml8uADsWdBvGpzswyNqjq/+lvGrEubHNdwV5ZmjAjoSQSdLYueP+/Ya
         x1zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MSxjHqQVmsvAqdAktDzJq1Aaq4WkRfg4dNDMnFRlXJE=;
        b=7rki8j2NhuwNHDOblpRBint2Mv5jY3rA87nibrapbCzTY54OYhKaFnXt/eXtFMlR43
         0pBNjH2AL9EYlUJ52QUPiKtYBV/y31EK7bFhmuVuhUanbgQonCXmAwidkZEl24wE0UX2
         wTl4GoM4GvmINY6qe2TSogucZ2nBHnX3IFbICG+i+X45l/Z81jTCDTloWat2eEr/xIeu
         q2/nlQKGBoYC2L9iTuTBoav3acxDozydXsuypyHHBLdHx41kYcjQA9tsU3CofjuRRCpT
         nUUtKSHbZSEdDH9xGnBfVGeIFepGrrf8b279nVQzkhxUTOdchVC9VY34Db6snBnlLJ3/
         ChLQ==
X-Gm-Message-State: ANoB5plufPcXdJRQi7I2mDw4PwAtzkQmmeN256qg20hjqYjvgqorPXxg
        lYXB1u1w7Kc8vkTKmJlUujw5nH7AgB2c8cc0LaqyzSaQyWFV3Q==
X-Google-Smtp-Source: AA0mqf6qc2LiyZvaSQXsjN2h5hAFiCgw1XRys8QcH//usSVpkPzL4fR28ordcBx7nokAK6srfF02EB7Nt84McYL+pw4=
X-Received: by 2002:a05:6402:2421:b0:461:524f:a8f4 with SMTP id
 t33-20020a056402242100b00461524fa8f4mr89362464eda.260.1671585348961; Tue, 20
 Dec 2022 17:15:48 -0800 (PST)
MIME-Version: 1.0
References: <20221216232951.3575596-1-martin.lau@linux.dev>
 <e68b892a-c688-f266-3819-0282ba5a1ac9@meta.com> <844f94a4-a003-55da-dc29-adf9f448fc45@linux.dev>
 <CAEf4BzbJGpkhyio9+S1U=bnYycaknw0SNada6orzNV_+VfPwGw@mail.gmail.com> <34389727-b9ee-4745-debf-935292bdaf3a@linux.dev>
In-Reply-To: <34389727-b9ee-4745-debf-935292bdaf3a@linux.dev>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 20 Dec 2022 17:15:36 -0800
Message-ID: <CAEf4BzasdKc35Aewj2xMGbtdMGua7TGkVjBXDgjM76cZ0oELNA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Reduce smap->elem_size
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     Yonghong Song <yhs@meta.com>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com,
        bpf <bpf@vger.kernel.org>
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

On Tue, Dec 20, 2022 at 4:56 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>
> [ Cc: the bpf list back.  I dropped it by mistake in my last reply. ]
>
> On 12/20/22 3:43 PM, Andrii Nakryiko wrote:
> > On Mon, Dec 19, 2022 at 11:47 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
> >>
> >> On 12/16/22 5:23 PM, Yonghong Song wrote:
> >>>
> >>>
> >>> On 12/16/22 3:29 PM, Martin KaFai Lau wrote:
> >>>> From: Martin KaFai Lau <martin.lau@kernel.org>
> >>>>
> >>>> 'struct bpf_local_storage_elem' has a 56 bytes padding at the end
> >>>> which can be used for attr->value_size.  The current smap->elem_size
> >>>
> >>> 'can be' => 'will be'?
> >>
> >> I used 'can be' to describe the current situation that the padding is not used
> >> for the map's value.  I may have used the wrong tense?
> >>
> >> I can rephrase it to something like,
> >>
> >> 'struct bpf_local_storage_elem' has a 56 bytes padding at the end which is
> >> currently not used for the attr->value_size.
> >
> > I actually found the use of attr->value_size to mean "value content"
> > more confusing than can vs will be.
> >
> > As a suggestion something like the below?
> >
> >
> > 'struct bpf_local_storage_elem' has an unused 56 byte padding at the
> > end due to struct's cache-line alignment requirement. This padding
> > space is overlapped by storage value contents, so if we use sizeof()
> > to calculate the total size, we overinflate it by 56 bytes. Use
> > offsetof() instead to calculate more exact memory use.
>
> SGTM.
>
> >
> >
> > btw, I think you can calculate the same arguably a bit more
> > straightforwardly as:
> >
> > smap->elem_size = offsetofend(struct bpf_local_storage_elem, sdata) +
> > attr->value_size;
>
> Sure. will change.
>
> >
> > right?
> >
> > but TIL that offsetof(struct bpf_local_storage_data,
> > data[attr->value_size]) does the right thing
>
> Yeah, I think I have seen other places using it also.  I found it more intuitive
> to read with array[size] to tell there is a flexible array at the end.  I am not
> super attached to it and will change to the way above.
>

I don't care either, was just surprised. But it just occurred to me
that your change can be written equivalently (but now I do think it's
cleaner) as:

smap->elem_size = offsetof(struct bpf_local_storage_elem,
sdata.data[attr->value_size]);


sdata is embedded struct, no pointer dereference, so single offsetof()
should be enough to peer inside it
