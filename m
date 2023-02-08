Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50FA568F5FE
	for <lists+bpf@lfdr.de>; Wed,  8 Feb 2023 18:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjBHRrH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Feb 2023 12:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbjBHRqw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 12:46:52 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E9DE3BF
        for <bpf@vger.kernel.org>; Wed,  8 Feb 2023 09:45:39 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id f10so21663123qtv.1
        for <bpf@vger.kernel.org>; Wed, 08 Feb 2023 09:45:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jgOLymf+QwO6fdKGbEbQRwre2/IMr8Cax6mjXfYnbLI=;
        b=ABpQiUQoiH8zEBgdGvtLyw2dJtSBIfPDLqSoCgdJBGg6Qt0OZkdIoPtp9v7eokuZDA
         7l+8gAEf6Z0AynPJmrlzJpnRaZkoE/AhFZ4+UhoVv66UFhNeiDlWHHXRrvvjo3zecygS
         zOM+yPtuhXss3O511qj7YBvj4und45Sd5soh4Ugd1o4Xcez9tPjlrU9wMAjG42uukipc
         0Qnah4dER5LYQaAvDgGs8XM5AjgMu6GLlMMxjxoskmdQY+Woj1CBnClQQCW9Up5hdvOT
         dTmirCfuReewVsUOymUBYK6S0ZP8Vw3wcGmhYnXwk2roXS+oUbiGaR80Lelhs8UgMdMh
         yU/A==
X-Gm-Message-State: AO0yUKWKyR0lT2DJqsLOMxFe+sFjUWv75atT4DULsWySgf5dFBm/4uTQ
        Dw0/13B4HNSCjJiXVbM1wDg=
X-Google-Smtp-Source: AK7set91Q9u13caVeR4LVkRpiYWusBNmR9Cifhpm/nOKf1EMMwCeNl21z/qQ/UaGVDNjTKOkxkZIjw==
X-Received: by 2002:a05:622a:1393:b0:3b6:30b6:b894 with SMTP id o19-20020a05622a139300b003b630b6b894mr12113279qtk.20.1675878009349;
        Wed, 08 Feb 2023 09:40:09 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:8e05])
        by smtp.gmail.com with ESMTPSA id bj29-20020a05620a191d00b0071b158849e5sm12201067qkb.46.2023.02.08.09.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 09:40:08 -0800 (PST)
Date:   Wed, 8 Feb 2023 11:40:14 -0600
From:   David Vernet <void@manifault.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Dave Thaler <dthaler=40microsoft.com@dmarc.ietf.org>,
        Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "bpf@ietf.org" <bpf@ietf.org>
Subject: Re: [Bpf] [PATCH bpf-next v2] bpf, docs: Explain helper functions
Message-ID: <Y+PefizA09h21XSF@maniforge.lan>
References: <20230206191647.2075-1-dthaler1968@googlemail.com>
 <Y+O7b5iKBUpskWLg@maniforge.lan>
 <PH7PR21MB387847C84B7D6DA43607692DA3D89@PH7PR21MB3878.namprd21.prod.outlook.com>
 <CAADnVQ+hgqw4fL8Vvq7GkP8VkO3wvFbhVD-LFU+h9-8vQC+0RQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQ+hgqw4fL8Vvq7GkP8VkO3wvFbhVD-LFU+h9-8vQC+0RQ@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 08, 2023 at 09:31:18AM -0800, Alexei Starovoitov wrote:
> On Wed, Feb 8, 2023 at 9:26 AM Dave Thaler
> <dthaler=40microsoft.com@dmarc.ietf.org> wrote:
> >
> > David Vernet wrote:
> > > > +Reserved instructions
> > > > +====================
> > >
> > > small nit: Missing a =
> >
> > Ack.
> >
> > > > +Clang will generate the reserved ``BPF_CALL | BPF_X | BPF_JMP`` (0x8d)
> > > instruction if ``-O0`` is used.
> > >
> > > Are we calling this out here to say that BPF_CALL in clang -O0 builds is not
> > > supported? That would seem to be the case given that we say that BPF_CALL
> > > | BPF_X | BPF_JMP in reserved and not permitted in instruction-set.rst.
> >
> > Yes, exactly.  I could update the language to add something like
> > "... so BPF_CALL in clang -O0 builds is not supported".
> 
> That will not be a correct statement.
> BPF_CALL is a valid insn regardless of optimization flags.
> BPF_CALLX will be a valid insn when the verifier support is added.
> Compilers need to make a choice which insn to use on a case by case basis.
> When compilers have no choice, but to use call by register they will
> use callx. That what happens with = (void *)1 hack that we use for
> helpers.
> It can happen with -O2 just as well.

In that case, I suggest we update the verbiage in instruction-set.rst to
say:

Note that ``BPF_CALL | BPF_X | BPF_JMP`` (0x8d), where the helper
function integer would be read from a specified register, is not
currently supported by the verifier. Any programs with this instruction
will fail to load until such support is added.

And then we can update this section to say something similar, or just
remove it altogether per Alexei's point that it's an implementation
detail of the compiler which could change at any time.
