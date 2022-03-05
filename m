Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8315C4CE41E
	for <lists+bpf@lfdr.de>; Sat,  5 Mar 2022 11:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiCEKLf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 5 Mar 2022 05:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiCEKLe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 5 Mar 2022 05:11:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C527C4DF46
        for <bpf@vger.kernel.org>; Sat,  5 Mar 2022 02:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646475043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uP1EZwK12VovZoxEdkUXW5CRQDWRv4FFnOIIOb/Aux0=;
        b=IETLmhnA2bN+25e9unMKV7nVlOb8oK/9T0ip1WXwFapI6O7zzQT1grLRv8FzKhQ7lZNEZN
        Tlkg2/J0m326BVkPXfDe6tpPre4q+T5TaNzyjR1wq8Pt+dS2wEfEKe+HivOQZfOpi7GSSe
        dVeulamfmPK0sD5o4DswJaFyS1HH/So=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-231-u2RJoEjyMtSm43J9-o5h-w-1; Sat, 05 Mar 2022 05:10:42 -0500
X-MC-Unique: u2RJoEjyMtSm43J9-o5h-w-1
Received: by mail-pj1-f69.google.com with SMTP id e7-20020a17090a4a0700b001bc5a8c533eso6178710pjh.4
        for <bpf@vger.kernel.org>; Sat, 05 Mar 2022 02:10:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uP1EZwK12VovZoxEdkUXW5CRQDWRv4FFnOIIOb/Aux0=;
        b=ECbHmGMsQWa+G7XtzXqn8fpcRipmkKx8GrhV6COGPk3dV/SB7JICZTsy3P2HSyCGqm
         nTrAufxG+701BmXr0DmfQ6CCePmtSbDOE6Zru0DjnkmpaElj0E3WSBbej6/KdOhZ8b7j
         U7kEWcpqBS/PAHGyxvto1Wb9ECGqKf7Gm33WP3wuycyesxg5rQR/aYXrGVhqePwP3JGU
         CoZratZzRXJ64wyOXBFibIHbh9pPHaErqsGNf8fApEVkXFiCP3kyKF40xA8l43CUmFxa
         wKhJFThz+p0xSJEFNU+dUer8c4xQSJLoDdgBGCZWmtaCuc2PxHAs5GOY6ADqUDTyejvD
         N1VA==
X-Gm-Message-State: AOAM532emjwp/q5hKswx+AWsijnqMg2rhG5X2K8Jsu88P1y/CrhU7w2a
        Ea8hLXQp49P/dDi8HKEnkokuPfVNgkHi+zFdTBzGN9xOc77s6dq3Bv1wa6O+Lg5/+/e6GxE9ZC2
        Xry8GZrGTEaRCjpHray+mm59jbCtM
X-Received: by 2002:a05:6a00:3006:b0:4f6:54ba:3581 with SMTP id ay6-20020a056a00300600b004f654ba3581mr3132729pfb.83.1646475041686;
        Sat, 05 Mar 2022 02:10:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzdMa4XGi5GgPncj0jNwlqnMBkbMcQKLgvKlNPPZy7+Ffim9IJzJb2EaijCC7uk1SuFaJIhvGBjTDkg2OrP65M=
X-Received: by 2002:a05:6a00:3006:b0:4f6:54ba:3581 with SMTP id
 ay6-20020a056a00300600b004f654ba3581mr3132702pfb.83.1646475041419; Sat, 05
 Mar 2022 02:10:41 -0800 (PST)
MIME-Version: 1.0
References: <20220304172852.274126-1-benjamin.tissoires@redhat.com>
 <20220304172852.274126-6-benjamin.tissoires@redhat.com> <CAPhsuW63HQE_GWFrz-t9_Uyq3KK3raYeG_x7OYMGR02DHzQ1=g@mail.gmail.com>
In-Reply-To: <CAPhsuW63HQE_GWFrz-t9_Uyq3KK3raYeG_x7OYMGR02DHzQ1=g@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Sat, 5 Mar 2022 11:10:30 +0100
Message-ID: <CAO-hwJLuwiHgzmRonNBOU3yOZJBkBVktqgSC8yzHi_UwnSUyNw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 05/28] selftests/bpf: add tests for the
 HID-bpf initial implementation
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
        Joe Stringer <joe@cilium.io>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Mar 5, 2022 at 1:41 AM Song Liu <song@kernel.org> wrote:
>
> On Fri, Mar 4, 2022 at 9:31 AM Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> >
> > The test is pretty basic:
> > - create a virtual uhid device that no userspace will like (to not mess
> >   up the running system)
> > - attach a BPF prog to it
> > - open the matching hidraw node
> > - inject one event and check:
> >   * that the BPF program can do something on the event stream
> >   * can modify the event stream
> >
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> >
>
> Does this test run with vm (qemu, etc.)? Maybe we need to update
> tools/testing/selftests/bpf/config ?

Good point. I'll give it a shot. I was testing on my devel machine so
it was quicker to iterate, but I completely forgot to make a run at
qemu with the scripts in place.

Cheers,
Benjamin

>
> Thanks,
> Song
>

