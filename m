Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4467E4C4A27
	for <lists+bpf@lfdr.de>; Fri, 25 Feb 2022 17:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239075AbiBYQHT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Feb 2022 11:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242584AbiBYQHT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Feb 2022 11:07:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DF65721131C
        for <bpf@vger.kernel.org>; Fri, 25 Feb 2022 08:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645805206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JtNsOA458FeQEet3eOy2MiWL9UbbHGcWhapQcMGFooY=;
        b=EvriBeJmaKA9toWJMbVMuqAfxqoSfBrtIM4qzuETChFtVohuFJS+6d5EnlEeYoaHr08LXw
        P8iNNd0z262mnqlm0ljVnGszJsogvmlJHk8lkEMi7IP91a16U3YITDbqlRUkdOa+6psCMA
        3Ir7MxKR/xGDNsY3GIl87QQmWwxC5dQ=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-163-vYLXVTgyPCWCftVQtbNXjw-1; Fri, 25 Feb 2022 11:06:44 -0500
X-MC-Unique: vYLXVTgyPCWCftVQtbNXjw-1
Received: by mail-pj1-f71.google.com with SMTP id lj14-20020a17090b344e00b001bc8fe30103so2931586pjb.1
        for <bpf@vger.kernel.org>; Fri, 25 Feb 2022 08:06:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JtNsOA458FeQEet3eOy2MiWL9UbbHGcWhapQcMGFooY=;
        b=co6FuSUEpg6Cu8ZFWs2+rWRuTkooTvEcAsu3/6zUStxymV4oaVINkKfXMowCq+dAE8
         Pa/h8Gj//H5OGW91HmFMvCJAEuKnfIxosAmJoVoIdKUcrdZmhUac3vtcntwJTWBwMIEC
         tYBXE+0joONI1dBQ4VSasLQNBdMcjuO67rarqkTmGco5sDB7TVvm+t5idfzkqJ3bvLbb
         L/HkSbP9dUh/OSslU9H7nYg8hz71dFw8Zm+lAGs6LET49l/1Dbs1HjaysrV0yf8U7Zot
         +YfwKWyxXGOq304XHOhYn+lX1Y1Uk7NJ43EutT7a/iRxO2Z4pN5lYaJsTwiNnw6yvAPQ
         vgtw==
X-Gm-Message-State: AOAM532x0wUwiqgK3eYSEE+xPQvr0e89ntT2ENkmnfhvkDgZ5AHL0oLE
        sCQcWR8d/X2hCOwy4Gu9dIFEyYTOlRXsyRBSuGKQHCj5Au/cmI3QRHy1XDRVvmnnZxAYJrDLPI7
        Wr2xy1Swn8OF7e+8MqAI1ORy/WxBk
X-Received: by 2002:a17:902:9308:b0:14e:def5:e6b5 with SMTP id bc8-20020a170902930800b0014edef5e6b5mr8295952plb.73.1645805203634;
        Fri, 25 Feb 2022 08:06:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwUIpWXteQHikzWnedR/pQmtGNKJt81L52dh8Zvx5yBKuSs0mA4pDWiMKp+ELlQrYIZ5T2VI/o7I3Fd2NGvn7E=
X-Received: by 2002:a17:902:9308:b0:14e:def5:e6b5 with SMTP id
 bc8-20020a170902930800b0014edef5e6b5mr8295906plb.73.1645805203288; Fri, 25
 Feb 2022 08:06:43 -0800 (PST)
MIME-Version: 1.0
References: <20220224110828.2168231-1-benjamin.tissoires@redhat.com>
 <YhdsgokMMSEQ0Yc8@kroah.com> <CAO-hwJJcepWJaU9Ytuwe_TiuZUGTq_ivKknX8x8Ws=zBFUp0SQ@mail.gmail.com>
 <ed97e5e8-f2b8-569f-5319-36cd3d2b79b3@fb.com>
In-Reply-To: <ed97e5e8-f2b8-569f-5319-36cd3d2b79b3@fb.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 25 Feb 2022 17:06:32 +0100
Message-ID: <CAO-hwJ+CJkPqdOE+OpZHOscMk3HHZb4qVtXjF-bkOweU0QjppA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 0/6] Introduce eBPF support for HID devices
To:     Yonghong Song <yhs@fb.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Joe Stringer <joe@cilium.io>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Peter Hutterer <peter.hutterer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 24, 2022 at 6:21 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 2/24/22 5:49 AM, Benjamin Tissoires wrote:
> > Hi Greg,
> >
> > Thanks for the quick answer :)
> >
> > On Thu, Feb 24, 2022 at 12:31 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >>
> >> On Thu, Feb 24, 2022 at 12:08:22PM +0100, Benjamin Tissoires wrote:
> >>> Hi there,
> >>>
> >>> This series introduces support of eBPF for HID devices.
> >>>
> >>> I have several use cases where eBPF could be interesting for those
> >>> input devices:
> >>>
> >>> - simple fixup of report descriptor:
> >>>
> >>> In the HID tree, we have half of the drivers that are "simple" and
> >>> that just fix one key or one byte in the report descriptor.
> >>> Currently, for users of such devices, the process of fixing them
> >>> is long and painful.
> >>> With eBPF, we could externalize those fixups in one external repo,
> >>> ship various CoRe bpf programs and have those programs loaded at boot
> >>> time without having to install a new kernel (and wait 6 months for the
> >>> fix to land in the distro kernel)
> >>
> >> Why would a distro update such an external repo faster than they update
> >> the kernel?  Many sane distros update their kernel faster than other
> >> packages already, how about fixing your distro?  :)
> >
> > Heh, I'm going to try to dodge the incoming rhel bullet :)
> >
> > It's true that thanks to the work of the stable folks we don't have to
> > wait 6 months for a fix to come in. However, I think having a single
> > file to drop in a directory would be easier for development/testing
> > (and distribution of that file between developers/testers) than
> > requiring people to recompile their kernel.
> >
> > Brain fart: is there any chance we could keep the validated bpf
> > programs in the kernel tree?
>
> Yes, see kernel/bpf/preload/iterators/iterators.bpf.c.

Thanks. This is indeed interesting.
I am not sure the exact usage of it though :)

One thing I wonder too while we are on this topic, is it possible to
load a bpf program from the kernel directly, in the same way we can
request firmwares?

Because if we can do that, in my HID use case we could replace simple
drivers with bpf programs entirely and reduce the development cycle to
a bare minimum.

Cheers,
Benjamin


>
> >
> >>
> >> I'm all for the idea of using ebpf for HID devices, but now we have to
> >> keep track of multiple packages to be in sync here.  Is this making
> >> things harder overall?
> >
> > Probably, and this is also maybe opening a can of worms. Vendors will
> > be able to say "use that bpf program for my HID device because the
> > firmware is bogus".
> >
> > OTOH, as far as I understand, you can not load a BPF program in the
> > kernel that uses GPL-declared functions if your BPF program is not
> > GPL. Which means that if firmware vendors want to distribute blobs
> > through BPF, either it's GPL and they have to provide the sources, or
> > it's not happening.
> >
> > I am not entirely clear on which plan I want to have for userspace.
> > I'd like to have libinput on board, but right now, Peter's stance is
> > "not in my garden" (and he has good reasons for it).
> > So my initial plan is to cook and hold the bpf programs in hid-tools,
> > which is the repo I am using for the regression tests on HID.
> >
> > I plan on building a systemd intrinsic that would detect the HID
> > VID/PID and then load the various BPF programs associated with the
> > small fixes.
> > Note that everything can not be fixed through eBPF, simply because at
> > boot we don't always have the root partition mounted.
> [...]
>

