Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057F8515AF7
	for <lists+bpf@lfdr.de>; Sat, 30 Apr 2022 09:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbiD3H2I (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 30 Apr 2022 03:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382261AbiD3H2I (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 30 Apr 2022 03:28:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DDE7DC0D18
        for <bpf@vger.kernel.org>; Sat, 30 Apr 2022 00:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651303485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cq/bV6RK8FDU8B3/J6PiOX4oHk2MVdSUsZvuBXDrwOw=;
        b=Q8XpaOT9QsBC/R6rWy5qZsA/cX2B03/PCeW0zIkafROVXujic56jDWgfZoZQPWCgRzetfJ
        zSfMa1Yn6lJwtrtQ6fL3NmhgEwFO/U/Ms1udY3GFrwk6QGvjrRLSr/0oQLTzGsy8s1nvOF
        SgH5dKzHU9zFILKeSLJS6nVoazKHc8w=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-433-wIp8PLNOP4SaiAVccm2bqQ-1; Sat, 30 Apr 2022 03:24:44 -0400
X-MC-Unique: wIp8PLNOP4SaiAVccm2bqQ-1
Received: by mail-pf1-f198.google.com with SMTP id g5-20020a62f945000000b0050578328060so5220171pfm.17
        for <bpf@vger.kernel.org>; Sat, 30 Apr 2022 00:24:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cq/bV6RK8FDU8B3/J6PiOX4oHk2MVdSUsZvuBXDrwOw=;
        b=5nZDN+UnY12ebAD71/pzGvzdW18KWFyl6rMDbawiSNRCkLCcuLkrE+sug6jqbAI0Xb
         fBUGlGWdwOKXZl4xAhrbMwWtc3XQ3vVkRkl5sEiqoWW13yqvcjNbSR+xaUVJC2fNNSIG
         wUKii7wQonZyAnba9o9g/NkXT8tnIyuKeTHicb1WAdBOKFMpb0rUIsOqz6FkR5WNM3BX
         YnC263aNF5tXZxivi+6TsbNjG2/kZRbpY+VsC4Pzt65xLcoW0gKzMM0GMrLq600Ok9Xj
         Rpca9Dz5oqba5kDPwvsr+2fIvdFbVK3rEXpC+J5GfK14OoeXNFfCktQpfi4R5Ziz97lF
         gRew==
X-Gm-Message-State: AOAM530ABdjQFP2USCQCFy1mRHsBwyUcEfAdMWRE+C0JL/8b7tu0eerA
        4YkCvdMqqmgWSmgLN+jXPkCxBPRnTh5IWA5pQqBLkLqr7xMB6TEkV8pYtr2w7Nbn0oXxLDAR9kX
        fBWOftYtwE8CPJgjfrjoaEFYhTuoB
X-Received: by 2002:a17:902:e012:b0:15d:53:61ff with SMTP id o18-20020a170902e01200b0015d005361ffmr2857437plo.73.1651303483091;
        Sat, 30 Apr 2022 00:24:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxap4SoZ79RaRepH1X+iEfYwFKlJ6T98AKWhyrpoUO7M5FfKKLyJ9bgOK31Ee7KLiI2ncnoHj58lJVAGRIL1so=
X-Received: by 2002:a17:902:e012:b0:15d:53:61ff with SMTP id
 o18-20020a170902e01200b0015d005361ffmr2857422plo.73.1651303482851; Sat, 30
 Apr 2022 00:24:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220421140740.459558-1-benjamin.tissoires@redhat.com>
 <20220421140740.459558-4-benjamin.tissoires@redhat.com> <20220426041147.gwnxhcjftl2kaz6g@MBP-98dd607d3435.dhcp.thefacebook.com>
 <CAO-hwJLWxtZcs-ynzAaF4hGf6zPF5wAni3Etzb1_XrvQpx2Jxw@mail.gmail.com> <CAADnVQL3U5Gz_spmdTsC6zOuR=XLEMppwn+=bkyOsSt0=7pP7Q@mail.gmail.com>
In-Reply-To: <CAADnVQL3U5Gz_spmdTsC6zOuR=XLEMppwn+=bkyOsSt0=7pP7Q@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Sat, 30 Apr 2022 09:24:31 +0200
Message-ID: <CAO-hwJL8TQ2wkFYpR99S7zsujPrH2NC1Wp13EvkyzijkY6oY8A@mail.gmail.com>
Subject: Re: [RFC bpf-next v4 3/7] error-inject: add new type that carries if
 the function is non sleepable
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Apr 30, 2022 at 5:30 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Apr 26, 2022 at 12:52 AM Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> >
> > On Tue, Apr 26, 2022 at 6:11 AM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Thu, Apr 21, 2022 at 04:07:36PM +0200, Benjamin Tissoires wrote:
> > > > When using error-injection function through bpf to change the return
> > > > code, we need to know if the function is sleepable or not.
> > > >
> > > > Currently the code assumes that all error-inject functions are sleepable,
> > > > except for a few selected of them, hardcoded in kernel/bpf/verifier.c
> > > >
> > > > Add a new flag to error-inject so we can code that information where the
> > > > function is declared.
> > > >
> > > > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > > >
> > > > ---
> > > >
> > > > new in v4:
> > > > - another approach would be to define a new kfunc_set, and register
> > > >   it with btf. But in that case, what program type would we use?
> > > >   BPF_PROG_TYPE_UNSPEC?
> > > > - also note that maybe we should consider all of the functions
> > > >   non-sleepable and only mark some as sleepable. IMO it makes more
> > > >   sense to be more restrictive by default.
> > >
> > > I think the approach in this patch is fine.
> > > We didn't have issues with check_non_sleepable_error_inject() so far,
> > > so I wouldn't start refactoring it.
> >
> > OK... though I can't help but thinking that adding a new
> > error-inject.h enum value is going to be bad, because it's an API
> > change, and users might not expect NS_ERRNO.
>
> Not sure about api concern. This is the kernel internal tag.
> bpf progs are not aware of them. The functions can change
> from sleepable to non-sleepable too.
> allow_error_inject can be removed. And so on.
>
> > OTOH, if we had a new kfunc_set, we keep the existing error-inject API
> > in place with all the variants and we just teach the verifier that the
> > function is non sleepable.
> ...
> > IIUC, the kfunc_set approach would solve that, no?
>
> Makes sense. Let's figure out an extensible kfunc_set approach
> that is not centralized in verifier.c
>

OK, I'll work on this in v5.

But I need to rethink the whole sleepable/non-sleepable definitions
for my use case, because I have now a clear separation between not
sleepable context (in fentry/fexit/fmod_ret) and sleepable context (in
SEC("syscall")), so maybe the whole thing is not really required.

Cheers,
Benjamin

