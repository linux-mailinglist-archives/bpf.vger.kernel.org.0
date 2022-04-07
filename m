Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC7B4F8941
	for <lists+bpf@lfdr.de>; Fri,  8 Apr 2022 00:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiDGUs3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Apr 2022 16:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbiDGUrv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Apr 2022 16:47:51 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961E1362218
        for <bpf@vger.kernel.org>; Thu,  7 Apr 2022 13:40:21 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id h14so6529616lfl.2
        for <bpf@vger.kernel.org>; Thu, 07 Apr 2022 13:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8dXAY3IIlkqrl5k95XVgZ0MzxiI/DT3HPhjs1rEkzEA=;
        b=KGII1tl9j2zWs4Z81TBrPcMfvV9EWEa8D4uE44xWiAjU1927B56qpJGr6L+SQU4acf
         BKeS7f5qcyhCHnHvk7fnWqXDI0NsLuLZ0H0dHCgNyS1AGKs2XwcE214Vd8UUO9XgPILH
         IsaM0RrNkzgnzigv0wqvo+c+zIMW1f4jYu7AFNRIbm3Q9tQOClsfMOEyiIV4saBXCPHm
         21/prLAS/HiKzGAXxsJoN8ZV2B6ssq3noHPslfbIRDA0xVvoPGKkXdPVl1uOcLu9mqvX
         beVP/YEEczRoAAM+a83DsjVpNPebBpVGUzzWslfpTrmd03G6m/4pD4CW8WcSTyEf41tC
         5x0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8dXAY3IIlkqrl5k95XVgZ0MzxiI/DT3HPhjs1rEkzEA=;
        b=fE7MC6cyogE9CGUY3z7H0F38HhqpyJWuHjsg4bMhfsOVUui7rXABJLywup78MpgvLD
         IlHWfefv3kvakbtEST3XL8dYpWUttShB5lbbvUZB9QC+UG5WncFHOaCOS1KUOiqT6mY5
         Kt+OdP3i9m6VlPqRmkTlTFTuvDFXkhv0N2deBP2lJu7+DrEpoCkPzZ6KjoEQo6+FYn9G
         oJ1MRABkJD5Dekkx9hYWz3VXJq/anqkk5sZFSgy653gRLAx0uhFgkH5+8262GLS14OpO
         jRRJ7JSt2XRQA/weWNIr09F7SKC5v6FL9/vu5egkr/G45M1riat4dan7tagkdtwvyHNx
         DtIQ==
X-Gm-Message-State: AOAM533WSpSSdY/Q9aoKYgNoO12BHC6TnYT9I8pKCKdSVMosZfhkaKJm
        xalMQCPbKsdpAJjkt4wuVMlTjvjVUuw0drGYMSE=
X-Google-Smtp-Source: ABdhPJxoauzCLIEzW/9gcK9ImMCuIsOWUtBbC0tUnmqxR8auQ00glB8pushRc6Pm0nAb9Apu4TgUhebOjTPzCFM/b60=
X-Received: by 2002:a05:6512:a86:b0:44a:7d2d:b763 with SMTP id
 m6-20020a0565120a8600b0044a7d2db763mr10824811lfu.540.1649364019680; Thu, 07
 Apr 2022 13:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220402015826.3941317-1-joannekoong@fb.com> <CAEf4BzbfFtgebrWOyfOP71Cn6ZAYXGfjLDPDNmyhzTJ3uTPFpQ@mail.gmail.com>
 <CA+i-1C1wjFcH5OMGVWt4+nB4hoSp_aVU=mv3LPtLq-5Ua-dggw@mail.gmail.com>
In-Reply-To: <CA+i-1C1wjFcH5OMGVWt4+nB4hoSp_aVU=mv3LPtLq-5Ua-dggw@mail.gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Thu, 7 Apr 2022 13:40:08 -0700
Message-ID: <CAJnrk1YKaRDpW-etMzraKLHwLaVMetZGpdjujsNLSbzh4Q1LoQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 0/7] Dynamic pointers
To:     Brendan Jackman <jackmanb@google.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Joanne Koong <joannekoong@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Florent Revest <revest@chromium.org>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
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

On Thu, Apr 7, 2022 at 5:44 AM Brendan Jackman <jackmanb@google.com> wrote:
>
> On Thu, 7 Apr 2022 at 01:13, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, Apr 1, 2022 at 6:59 PM Joanne Koong <joannekoong@fb.com> wrote:
> > >
> > > From: Joanne Koong <joannelkoong@gmail.com>
> > KP, Florent, Brendan,
> >
> > You always wanted a way to work with runtime-sized BPF ringbuf samples
> > without extra copies. This is the way we can finally do this with good
> > usability and simplicity. Please take a look and provide feedback.
> > Thanks!
>
> Thanks folks, this looks very cool. Please excuse my ignorance, one
> thing that isn't clear to me is does this work for user memory? Or
> would we need bpf_copy_from_user_dynptr to avoid an extra copy?

Userspace programs will not be able to use or interact with dynptrs
directly. If there is data at a user-space address that needs to be
copied into the ringbuffer, the address can be passed to the bpf
program and then the bpf program can use a helper like
bpf_probe_read_user_dynptr (not added in this patchset but will be
part of a following one), which will read the contents at that user
address into the ringbuf dynptr.
