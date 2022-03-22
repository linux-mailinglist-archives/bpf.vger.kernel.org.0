Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13654E3D27
	for <lists+bpf@lfdr.de>; Tue, 22 Mar 2022 12:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbiCVLIH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Mar 2022 07:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233899AbiCVLHy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Mar 2022 07:07:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D130C6B088
        for <bpf@vger.kernel.org>; Tue, 22 Mar 2022 04:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647947184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FCN73VojYTO9kljcWQ13H5/nQPlAxw07sJxBf+2VjUA=;
        b=H2Zq1cVoJydixIK2B2CsbTdLcTbRe7kxljmiuqaaW/LETNRDoaPEs7LggRGM2BCptnvRsu
        kR4fff6qf9H5tuG+QS3noE7GmSOjKKlhHi/niNl4OGpQ/6TOD++N2SbEHqEx4/zml199eg
        mZaTkVscn6WMo5CEzL0X47N6hygNkF4=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-nwgXCTJ5OIa3_SeJAP-Nlg-1; Tue, 22 Mar 2022 07:06:23 -0400
X-MC-Unique: nwgXCTJ5OIa3_SeJAP-Nlg-1
Received: by mail-pl1-f199.google.com with SMTP id j1-20020a170903028100b0014b1f9e0068so6994544plr.8
        for <bpf@vger.kernel.org>; Tue, 22 Mar 2022 04:06:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FCN73VojYTO9kljcWQ13H5/nQPlAxw07sJxBf+2VjUA=;
        b=bWwXUzAieVc7J2+0sJk7UxTNobPy6oXOLxUKOiLGNBeeRk6gihJcDd4PTn+eLHFJaw
         W1hnBml6h5lMTAOxn4aycjU/S4knkliSx8GwU8StSVoipj5l+WMBpP8vg/8WTYSDPL3O
         EWUdy0gJIBGPPRpkKSKwZZ0aD+/G+a03ZepAIgV6g/lO+nr8Hfzrk6BnfvJYJcM2olDM
         JvJzF56II/I7dlB6/LaTrS1TX93vwLlYsI/Ku5MtQEgy+TslcBIf5oMaEPj+fUb3+CbO
         /dG1ivH6UqTRZ4/aNY1m1EoElLcSX9n0sEAy2iLGHijSrP3zGJ2xNdB1ARMOoL1FNr9J
         cCEQ==
X-Gm-Message-State: AOAM532N0uP8gobTmfkwPovWx7aEPMyjrlbpvTkiArLEYNMMt/C2j+TZ
        0thOK8qo9L4JUsoUeKXKcjzLdyG5tyeSz2GmfhQbwvJYM3iHYQAqjLH7OJXCkpt2Mxnpy0rPBiX
        vyW5GfgepiaSbjwH/fW87k695c//g
X-Received: by 2002:a05:6a00:781:b0:4f4:2a:2d89 with SMTP id g1-20020a056a00078100b004f4002a2d89mr28353590pfu.13.1647947182451;
        Tue, 22 Mar 2022 04:06:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxr+q2ATbHevtxQq+KnIYNOBZEc3a+OTtO21QwUxoenZhXslv90N6P5NwAn9zxlvY4pCldPh/cy5+2PEff6pyY=
X-Received: by 2002:a05:6a00:781:b0:4f4:2a:2d89 with SMTP id
 g1-20020a056a00078100b004f4002a2d89mr28353561pfu.13.1647947182060; Tue, 22
 Mar 2022 04:06:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220318161528.1531164-1-benjamin.tissoires@redhat.com>
 <20220318161528.1531164-3-benjamin.tissoires@redhat.com> <CAPhsuW5qseqVs4=hz3VvSJ2ObqB2kTbKXoaOCh=5vjoU_AXnKQ@mail.gmail.com>
 <CAO-hwJ+WSi645HhNV_BYACoJe2UTc4KZzqH0oHocfnBR8xUYEQ@mail.gmail.com> <CAPhsuW4+b66Keh_f+UoApM8UenhnJ5wD_SaatAFDms9=g7ENyw@mail.gmail.com>
In-Reply-To: <CAPhsuW4+b66Keh_f+UoApM8UenhnJ5wD_SaatAFDms9=g7ENyw@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 22 Mar 2022 12:06:11 +0100
Message-ID: <CAO-hwJLAAB=hAffiRAEsv-qgj+GYcLsULQVjQ2i1_ZZTB5dPRw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 02/17] bpf: introduce hid program type
To:     Song Liu <song@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Joe Stringer <joe@cilium.io>, Jonathan Corbet <corbet@lwn.net>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 21, 2022 at 10:52 PM Song Liu <song@kernel.org> wrote:
>
> On Mon, Mar 21, 2022 at 9:07 AM Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> >
> > Hi Song,
> >
> > many thanks for the quick response.
> >
> > On Fri, Mar 18, 2022 at 9:48 PM Song Liu <song@kernel.org> wrote:
> [...]
> > >
> > > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > >
> > > We need to mirror these changes to tools/include/uapi/linux/bpf.h.
> >
> > OK. I did that in patch 4/17 but I can bring in the changes there too.
>
> Let's keep changes to the two files in the same patch. This will make
> sure they are back ported together.

Ack

>
> [...]
> > > > +enum hid_bpf_event {
> > > > +       HID_BPF_UNDEF = 0,
> > > > +       HID_BPF_DEVICE_EVENT,           /* when attach type is BPF_HID_DEVICE_EVENT */
> > > > +       HID_BPF_RDESC_FIXUP,            /* ................... BPF_HID_RDESC_FIXUP */
> > > > +       HID_BPF_USER_EVENT,             /* ................... BPF_HID_USER_EVENT */
> > >
> > > Why don't we have a DRIVER_EVENT type here?
> >
> > For driver event, I want to have a little bit more of information
> > which tells which event we have:
> > - HID_BPF_DRIVER_PROBE
> > - HID_BPF_DRIVER_SUSPEND
> > - HID_BPF_DRIVER_RAW_REQUEST
> > - HID_BPF_DRIVER_RAW_REQUEST_ANSWER
> > - etc...
> >
> > However, I am not entirely sure on the implementation of all of those,
> > so I left them aside for now.
> >
> > I'll work on that for v4.
>
> This set is already pretty big. I guess we can add them in a follow-up set.
>
> >
> > >
> > > >
> > > [...]
 [...]
> > > > +
> > > > +static int hid_bpf_prog_test_run(struct bpf_prog *prog,
> > > > +                                const union bpf_attr *attr,
> > > > +                                union bpf_attr __user *uattr)
> > > > +{
> > > > +       struct hid_device *hdev = NULL;
> > > > +       struct bpf_prog_array *progs;
> > > > +       bool valid_prog = false;
> > > > +       int i;
> > > > +       int target_fd, ret;
> > > > +       void __user *data_out = u64_to_user_ptr(attr->test.data_out);
> > > > +       void __user *data_in = u64_to_user_ptr(attr->test.data_in);
> > > > +       u32 user_size_in = attr->test.data_size_in;
> > > > +       u32 user_size_out = attr->test.data_size_out;
> > > > +       u32 allocated_size = max(user_size_in, user_size_out);
> > > > +       struct hid_bpf_ctx_kern ctx = {
> > > > +               .type = HID_BPF_USER_EVENT,
> > > > +               .allocated_size = allocated_size,
> > > > +       };
> > > > +
> > > > +       if (!hid_hooks.hdev_from_fd)
> > > > +               return -EOPNOTSUPP;
> > > > +
> > > > +       if (attr->test.ctx_size_in != sizeof(int))
> > > > +               return -EINVAL;
> > >
> > > ctx_size_in is always 4 bytes?
> >
> > Yes. Basically what I had in mind is that the "ctx" for
> > user_prog_test_run is the file descriptor to the sysfs that represent
> > the HID device.
> > This seemed to me to be the easiest to handle for users.
> >
> > I'm open to suggestions though.
>
> How about we use data_in? ctx for test_run usually means the program ctx,
> which is struct hid_bpf_ctx here.
>

I'd rather not use data_in. data_in is forwarded as it is in the ctx
of the program, so adding a bulky API where the first byte is the
target_fd doesn't make a lot of sense IMO.

However, I just managed to achieve what I initially wanted to do
without luck: just use the struct bpf_prog as the sole argument.
I thought iterating over all hid devices would be painful, but it
turns out that is exactly what hid_bpf_fd_to_hdev() was doing, so
there is no penalty in doing so.

Anyway, I'll drop ctx_in in the next version.

Cheers,
Benjamin

