Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F3D5267D8
	for <lists+bpf@lfdr.de>; Fri, 13 May 2022 19:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382278AbiEMRC4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 May 2022 13:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345717AbiEMRCz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 May 2022 13:02:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 37E9629805
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 10:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652461373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bFaHtuKvYdoU4Ss76MP2yzq3FoV8Rg2Z1GhsXd5Mi10=;
        b=h3iIRf0vdTQ9r3jFIxf4+6pIFMPM2SLxOWp3bZ5NcFYZ31SKXgzxVzEbyGpStLRyrYIXQI
        eSOlJ78Cd0ox3PfvT7W8D/F26jS8nsYDw25dZxZMsrWbb9L16vbs4db7oQ25tRkdnxHWyu
        PYM+XUjIiJpD2lh4i9SclI5NYycTABo=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-B17O1CThOzaq1PzwwTcVUA-1; Fri, 13 May 2022 13:02:52 -0400
X-MC-Unique: B17O1CThOzaq1PzwwTcVUA-1
Received: by mail-pj1-f70.google.com with SMTP id pt10-20020a17090b3d0a00b001dd200e709dso6470585pjb.9
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 10:02:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bFaHtuKvYdoU4Ss76MP2yzq3FoV8Rg2Z1GhsXd5Mi10=;
        b=p7qQbyhiwi4whU43asw+X0BzgP2srL6uM+uc+SQ6NK+kCEdI3aIZ7zwm04os8CjJRj
         /yypxjJ68grmMPPw3CBm8UzlsqX3oxv6FBl0Hgn0/AWTls41Ly1Y3CMy0RK1DHVlSlOZ
         /a9NhAt8Afrjlyo9Igj4g7J6pANIZXnHdaOEQwlqRxz98l/RVCd1tSubqS7zEK8teR8m
         i7brgKsXo2Ui/ibu7APAX2bZbkJ35TTQsGMIyLRbsIjPi+XHVJzsML7AVSaKvNAjz/SM
         emtg8KXWqNf+m4XcIZihpL0rzFzEqu8Seu2TecCOM/Sl2F9Tg+pgmFTmz1k/4TzMVWrp
         PA1w==
X-Gm-Message-State: AOAM533CcNhZX9PvhimQOGch3a91ja6EDK/ysWvFDlQW8Bd0xbaChVtU
        1B6RvzVbUjrq+A//KmRQiilUdSVnhoD5DF+/V9FVzc6C3vz7DeH6BRRErtTakODVZE4j6AftE/z
        ejN/aF54mzV9F4K8TkjZ83YP1/vok
X-Received: by 2002:a17:90a:170c:b0:1dc:20c4:6354 with SMTP id z12-20020a17090a170c00b001dc20c46354mr5816425pjd.113.1652461371087;
        Fri, 13 May 2022 10:02:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvsKEcWZDytpsjAcUlXt7ADVs8f3c+LgUSpP0KkqclabJGMk1FQZPg9M3uwu8B1bPuvgkNycBxFUwMrKYNPsQ=
X-Received: by 2002:a17:90a:170c:b0:1dc:20c4:6354 with SMTP id
 z12-20020a17090a170c00b001dc20c46354mr5816408pjd.113.1652461370900; Fri, 13
 May 2022 10:02:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220421140740.459558-1-benjamin.tissoires@redhat.com>
 <20220426040314.ez3cdpv2w45vbgkk@MBP-98dd607d3435.dhcp.thefacebook.com>
 <CAO-hwJLziatB9n5Rut_EYRgfN94t2XX8Zx8B_Zmu2nucTw3k8g@mail.gmail.com>
 <CAADnVQKN==eb3ASQhrJBg4yC8BuRdMQyY-OdRbXhdyv2P8L0-A@mail.gmail.com>
 <CAO-hwJ+HV=jZUgH1LXcPuBFirMzx3OAdSy4zvyyYh7PQhnaduQ@mail.gmail.com> <20220512042327.vla3j7rjqrmjporp@MBP-98dd607d3435.dhcp.thefacebook.com>
In-Reply-To: <20220512042327.vla3j7rjqrmjporp@MBP-98dd607d3435.dhcp.thefacebook.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 13 May 2022 19:02:40 +0200
Message-ID: <CAO-hwJLXM6Zf46_PweJ=QTiacX0+siUYkyqPu1hRrx_8fDVUTQ@mail.gmail.com>
Subject: Re: [RFC bpf-next v4 0/7] Introduce eBPF support for HID devices (new attempt)
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
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 12, 2022 at 6:23 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, Apr 30, 2022 at 09:12:09AM +0200, Benjamin Tissoires wrote:
> >
> > Also, I wonder if we should not have some way to namespace kfuncs.
> > Ideally, I would like to prevent the usage of those kfuncs outside of
> > some helpers that I define in HID so I don't have to worry too much
> > about other trace programs fuzzing and segfaulting the kernel.
>
> That would be a great feature to have. Other folks expressed the same interest.
> Just grouping them by prog type is not flexible enough.
> It feels kfuncs could be scoped by (prog_type, attach_btf_id or attach_hook) pair.
> What are your thoughts?
>

Scoping by attach_btf_id is very appealing to me (attach_hook less TBH):
I have internal functions I do not want normal users to use, and also
it would also restrict who can call what in the more general case.

However, I don't think I'll put that effort in v5. It is a nice to
have feature IMO, but not really required ATM.

Cheers,
Benjamin

