Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607D0601DCB
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 01:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiJQXns (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Oct 2022 19:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiJQXnr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Oct 2022 19:43:47 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A8F82D0B
        for <bpf@vger.kernel.org>; Mon, 17 Oct 2022 16:43:46 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id ot12so28545100ejb.1
        for <bpf@vger.kernel.org>; Mon, 17 Oct 2022 16:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YrggAwIdG4ipY6mUKWCbILqNULpiE4ntgyhiZ9dg4dY=;
        b=UlkcdMSr8FPRIQ1AMU9Z4licMSyZU+npDSOWGpDvJK6TwUDL47+E3QV7bnPFoUMA8t
         OH0pYvxpX8P3SsoGBgNUYdaeBKpduQXWaGq1OGm2vDSuxva2b8DsmJwtiexm7T5R+sZ4
         JtksPeSCT2pzSePZco95AYsDj8oRhh2+Wbfr62Vu3mDM+OjsWt1ddNG1nqtrxeRIv1pP
         h7VsIsG8jDlG0PTn6fqtsXX3zMgIg2Fu/AVC31AnidmqxtlqQulXF064YG1+mHr+nchM
         cSlJiiYGMzb0RnzdGC8CU0VC61x8hnS2l1qGRBF7BZ9Nhz8IQLdQGBXjUoLGapF9FLLK
         6Avw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YrggAwIdG4ipY6mUKWCbILqNULpiE4ntgyhiZ9dg4dY=;
        b=CKRxaDac81XOLunZ9MhwThNgUIw6+gBqYa6Au8/pvjBX3HKXJKeYoNIZPrP9OthL/V
         MwTOWdtfpdb1m2iWF+dcJPbxZLa4mlgRD/dxK3C5x+zIh2Z9xljLqFoh6yMPaw0ShMDx
         r74zhOluMoD8dsM5O2/ZTLOkqyDGT0/16T0qURfWKwFu7IhOlV8ft+1a4fmBSnrgCO4L
         rOB0qVPqJIUbkF7yd9WhAYpiEs3qkae4vYwAQ74iM0eRYGkG4JHl4jZOKHJQ2VqNq6OL
         TK1U7wnVgrarkmWL8LNPbbckHcd5xUHKPKT5uJRWBPOpCF1Vk3xuuNWNNkVY4RifgkTr
         NP9A==
X-Gm-Message-State: ACrzQf3kNsiee4ZgUEKt1//gDxSpFEnimoKJjm9rHtmvy5PEX7ZLcwmr
        gWTShL6DzkuaLojvXXl0RILhXnvJ8FBQ81stprU=
X-Google-Smtp-Source: AMsMyM5d2tFf6VDVDWAo1DNQ7MD3rOY236qixbZGJIVj7P3hFDsH4/NL/Pl8Tk3ucqrlEo0PAXBO24SSxQfG8hjfHJ4=
X-Received: by 2002:a17:907:2cd8:b0:78d:9c3c:d788 with SMTP id
 hg24-20020a1709072cd800b0078d9c3cd788mr132406ejc.327.1666050225072; Mon, 17
 Oct 2022 16:43:45 -0700 (PDT)
MIME-Version: 1.0
References: <20221004224745.1430-1-dthaler1968@googlemail.com>
 <DM4PR21MB3440B73030D09B1F09082807A3299@DM4PR21MB3440.namprd21.prod.outlook.com>
 <20221017214104.rtle5zdwnipqhwvb@macbook-pro-4.dhcp.thefacebook.com> <DM4PR21MB3440DA99F6621F50845E0A07A3299@DM4PR21MB3440.namprd21.prod.outlook.com>
In-Reply-To: <DM4PR21MB3440DA99F6621F50845E0A07A3299@DM4PR21MB3440.namprd21.prod.outlook.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 17 Oct 2022 16:43:33 -0700
Message-ID: <CAADnVQK7ofN_8CJuiRY4RFjmawiTEUbzs5m0orgiN1NeUi_Mnw@mail.gmail.com>
Subject: Re: [PATCH 1/9] bpf, docs: Add note about type convention
To:     Dave Thaler <dthaler@microsoft.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "dthaler1968@googlemail.com" <dthaler1968@googlemail.com>
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

On Mon, Oct 17, 2022 at 4:16 PM Dave Thaler <dthaler@microsoft.com> wrote:
>
> > -----Original Message-----
> > From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> > Sent: Monday, October 17, 2022 2:41 PM
> > To: Dave Thaler <dthaler@microsoft.com>
> > Cc: bpf@vger.kernel.org; dthaler1968@googlemail.com
> > Subject: Re: [PATCH 1/9] bpf, docs: Add note about type convention
> >
> > On Mon, Oct 17, 2022 at 08:42:13PM +0000, Dave Thaler wrote:
> > > Just checking if there is any more feedback on this patch set, as I've
> > > seen no comments since this set was posted on October 4th which
> > > addresses comments received on the previous submission.
> >
> > The was an issue found by build bot...
> >
> > > Let me know if I'm missing some step I should be doing as I'm new to
> > > this submission process.
> >
> > I'm still not excited about 'appendix'. How about moving it into separate file?
> > instruction-set-opcodes.rst ?
> >
> > If folks really want to use it in automated way that table needs to be uniform
> > and shouldn't be interleaved with normal text.
> > That's why a separate file with just that table seems a better fit.
>
> I can move it to a separate file, but that appendix is added in patch 5/9 of this set.
> Any comments on patches 1-4 or are they all good now?

Don't know. Since they're not in patchwork anymore no one
is looking at them. Just resend.
