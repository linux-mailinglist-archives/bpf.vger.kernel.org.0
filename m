Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F4765465B
	for <lists+bpf@lfdr.de>; Thu, 22 Dec 2022 20:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbiLVTHb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Dec 2022 14:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbiLVTHY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Dec 2022 14:07:24 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA90123E87
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 11:07:23 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id ud5so7110461ejc.4
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 11:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zDk3Z8LF/7cq77BQBNXO6zSp9zVGQU4gvD7pCwRagLU=;
        b=PQ63oeB76G9hgwwOvaQiUF8b6X/kO27aCsvw7eEtY/TIvUkJhXRNyokeoNAiBSQe+j
         0QB4pTYcp4Lv6mxZRlRaBdiebxu9btf6pg3Qf5T1WYA3j6owbjBbFU9nJejoPqWYL2Ms
         M8UGB7a8pxx4bsuRDdBOldLoh/C4dpc1BL0wmv+eGP15iUrGf49y3ZwD6ZlnLrZhhznh
         dssYCDA620nMR6ljx80X41Y+THGyhL+K4pgnVqJdp3rJ1rDEVt9CS4IEwrzu3gQkdiXB
         pcIN7FoZlg0khDrOVORUrWzQiu78EXoAGGVIBygAmlPPD60XU4uV5QS0lmalpqjXcDRz
         TRbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zDk3Z8LF/7cq77BQBNXO6zSp9zVGQU4gvD7pCwRagLU=;
        b=FNRL3bt+wHVl4HrxESKOdjzVoCvzpOlAg0iUBH/XP8Q6qcYkhttKdDEmQpuycikf0+
         hMhf+poDicEgA2Y1/MzBf5BqBtbRQvNQxryy+zHSaJSf7IZoGxTtmGQT3x7sqqyYyWZd
         +vIMP21VgbBAy3P54XzKdKbgc9L+B91zFR95cWLJXz9bzMioWiEvE2EABJSdxB6O3dX+
         C0G4OtXvkhhDvG5AsLkUf7+GhBH3Nyk02SW8bB9fmuPFV47VnTvgPsOhFtpfYG93ihPu
         hOz9UQ9YLXoBXFYPT+R2CI52IMdPok5/uJgbOPkDAm0+am4h9kUggweGdKJ1+zh8UuqW
         xPdg==
X-Gm-Message-State: AFqh2kp/sbW32qgmf3Dx/71fb7QdVbNkiMpZ+ecrmeCWHwTSGarhsEGw
        FpbWyiBJE2/bUVizOvnASvZwdqNmXFuHGEorVAnr/oAJ
X-Google-Smtp-Source: AMrXdXsKpkV4CKDZ4TXNyXlmSjK1swfh8k6ANr5h7RoeLtQuQwzT87E05ApQ59IDoa3skZbdvuGyzdOpalAiTQ3R40w=
X-Received: by 2002:a17:907:d489:b0:7c0:dd4e:3499 with SMTP id
 vj9-20020a170907d48900b007c0dd4e3499mr762636ejc.545.1671736042452; Thu, 22
 Dec 2022 11:07:22 -0800 (PST)
MIME-Version: 1.0
References: <20221217021711.172247-1-eddyz87@gmail.com> <20221217021711.172247-2-eddyz87@gmail.com>
 <CAEf4BzZH0ZxorCi7nPDbRqSK9f+410RooNwNJGwfw8=0a5i1nw@mail.gmail.com> <8492d922b7b2d1829e286ed48e8b0b44974500e0.camel@gmail.com>
In-Reply-To: <8492d922b7b2d1829e286ed48e8b0b44974500e0.camel@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 22 Dec 2022 11:07:10 -0800
Message-ID: <CAEf4BzYuxWNn=QM42kW-rwf1NAfDgMxgSz2moj+TDE883PBFfg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/4] selftests/bpf: support for
 BPF_F_TEST_STATE_FREQ in test_loader
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com
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

On Wed, Dec 21, 2022 at 4:11 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Tue, 2022-12-20 at 13:03 -0800, Andrii Nakryiko wrote:
> > On Fri, Dec 16, 2022 at 6:17 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
> > >
> > > Adds a macro __test_state_freq, the macro expands as a btf_decl_tag of a
> > > special form that instructs test_loader that the flag BPF_F_TEST_STATE_FREQ
> > > has to be passed to BPF verifier when program is loaded.
> > >
> >
> > I needed similar capabilities locally, but I went a slightly different
> > direction. Instead of defining custom macros and logic, I define just
> > __flags(X) macro and then parse flags either by their symbolic name
> > (or just integer value, which might be useful sometimes for
> > development purposes). I've also added support for matching multiple
> > messages sequentially which locally is in the same commit. Feel free
> > to ignore that part, but I think it's useful as well. So WDYT about
> > the below?
>
> Makes total sense. I can replace my patch with your patch in the
> patchset, or just wait until your changes land.

Mine will take a bit more time and will be stuck in discussions
anyways, so the more prerequisites land before it the better. Please
go ahead and add it to your patch set.

>
> >
> >
