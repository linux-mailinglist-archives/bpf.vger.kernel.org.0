Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B17B63625B
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 15:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237579AbiKWOtx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 09:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237611AbiKWOtv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 09:49:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C0E6E546
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 06:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669214933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XVwsHMkeuOJlctKFKAb4Da/8dTubU4VpbLh+0BeUA34=;
        b=XHcWS4/sHyXelC1GCNqeIT/Yp/tY7Xh0S73ueC/xdqQB2mUoUNcMb0QaO8YH+IJG9dCUT+
        4CM919R4Gw29+6HMSOdQ0Thv+G9s69OCHrIqVwoPD+A9e56NTPH7AueYthNOoiy1gvVqLQ
        PyPKptfkkdb4PPx8R/Sj2L4QoE+TGFk=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-190-Ag4_FCSWMUmTnSWqRFS-TA-1; Wed, 23 Nov 2022 09:48:51 -0500
X-MC-Unique: Ag4_FCSWMUmTnSWqRFS-TA-1
Received: by mail-il1-f199.google.com with SMTP id d2-20020a056e020be200b00300ecc7e0d4so12995409ilu.5
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 06:48:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XVwsHMkeuOJlctKFKAb4Da/8dTubU4VpbLh+0BeUA34=;
        b=eDtAlgX6jB/wS/C5yv1ZNz/LIw4/cRoMPdgtoH+DLrWH7g1/iCILV9LUuEPeyvyPgD
         LAc5IAb5My26s//P5Z8DJetYzko4LDFDE1W5/PmiO5VtTHpubAL85XWBRVBeejJUlLb4
         vPSjvvllJboVwF7FtR05qGIew+5kFO4EuHlhHwoVzZEdl2N1AB4OtHUfOaZGuBCxIJe2
         XBZhwLMZJJAHUwLJXqaQ9GnMlbmZc0a1lwda82k6FW0J5zPoW6SMjoXNI6lr2jQj1U8K
         qfwsuSwQcwP/7cdYUGO9H6cVXeWRXM0MUsC7MMF1xEEAgj679OItni6JVFV9NzULrOkT
         wlBA==
X-Gm-Message-State: ANoB5pmfEg5fVAsn9epTJd/TRhfwV8W+H7yovfmJxdGK/fwagaJB8hIw
        8NoMmwwU2Py7qWmI9ecLHzQYjh1pP4CwOvnyDNA3t13o7H90HLod3x8FBlhc1tcUsFLu3SNbkf+
        HVSNlxeWTbjqJsLIq/nHC8TC+JiSK
X-Received: by 2002:a92:c691:0:b0:302:75c9:5d55 with SMTP id o17-20020a92c691000000b0030275c95d55mr4126273ilg.34.1669214931052;
        Wed, 23 Nov 2022 06:48:51 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7t6tBPN8sYXy8dh8uHxD1HawZPKG6isYlau3hUqFJFGOIk/LhU7kZ8leId0LJjjgLzaxuDzjr+0sIG2p/qtrU=
X-Received: by 2002:a92:c691:0:b0:302:75c9:5d55 with SMTP id
 o17-20020a92c691000000b0030275c95d55mr4126263ilg.34.1669214930760; Wed, 23
 Nov 2022 06:48:50 -0800 (PST)
MIME-Version: 1.0
References: <20221103155756.687789-1-benjamin.tissoires@redhat.com>
 <20221103155756.687789-4-benjamin.tissoires@redhat.com> <ff1a0b34-71f2-cebe-a6ef-675936b276eb@nvidia.com>
In-Reply-To: <ff1a0b34-71f2-cebe-a6ef-675936b276eb@nvidia.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 23 Nov 2022 15:48:39 +0100
Message-ID: <CAO-hwJJZxgeTT8mLwFrYynSVASva=o7qL9Kr4xOywV3KDUu2GA@mail.gmail.com>
Subject: Re: [PATCH hid v12 03/15] HID: initial BPF implementation
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Jon,

On Wed, Nov 23, 2022 at 2:25 PM Jon Hunter <jonathanh@nvidia.com> wrote:
>
>
> On 03/11/2022 15:57, Benjamin Tissoires wrote:
> > Declare an entry point that can use fmod_ret BPF programs, and
> > also an API to access and change the incoming data.
> >
> > A simpler implementation would consist in just calling
> > hid_bpf_device_event() for any incoming event and let users deal
> > with the fact that they will be called for any event of any device.
> >
> > The goal of HID-BPF is to partially replace drivers, so this situation
> > can be problematic because we might have programs which will step on
> > each other toes.
> >
> > For that, we add a new API hid_bpf_attach_prog() that can be called
> > from a syscall and we manually deal with a jump table in hid-bpf.
> >
> > Whenever we add a program to the jump table (in other words, when we
> > attach a program to a HID device), we keep the number of time we added
> > this program in the jump table so we can release it whenever there are
> > no other users.
> >
> > HID devices have an RCU protected list of available programs in the
> > jump table, and those programs are called one after the other thanks
> > to bpf_tail_call().
> >
> > To achieve the detection of users losing their fds on the programs we
> > attached, we add 2 tracing facilities on bpf_prog_release() (for when
> > a fd is closed) and bpf_free_inode() (for when a pinned program gets
> > unpinned).
> >
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>
> ...
>
> > +static int __init hid_bpf_init(void)
> > +{
> > +     int err;
> > +
> > +     /* Note: if we exit with an error any time here, we would entirely break HID, which
> > +      * is probably not something we want. So we log an error and return success.
> > +      *
> > +      * This is not a big deal: the syscall allowing to attach a BPF program to a HID device
> > +      * will not be available, so nobody will be able to use the functionality.
> > +      */
> > +
> > +     err = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &hid_bpf_kfunc_set);
> > +     if (err) {
> > +             pr_warn("error while setting HID BPF tracing kfuncs: %d", err);
> > +             return 0;
> > +     }
> > +
> > +     err = hid_bpf_preload_skel();
> > +     if (err) {
> > +             pr_warn("error while preloading HID BPF dispatcher: %d", err);
> > +             return 0;
> > +     }
> > +
> > +     /* register syscalls after we are sure we can load our preloaded bpf program */
> > +     err = register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &hid_bpf_syscall_kfunc_set);
> > +     if (err) {
> > +             pr_warn("error while setting HID BPF syscall kfuncs: %d", err);
> > +             return 0;
> > +     }
> > +
> > +     return 0;
> > +}
>
>
> We have a kernel test that checks for new warning and error messages on
> boot and with this change I am now seeing the following error message on
> our Tegra platforms ...
>
>   WARNING KERN hid_bpf: error while preloading HID BPF dispatcher: -13
>
> I have a quick look at the code, but I can't say I am familiar with
> this. So I wanted to ask if a way to fix this or avoid this? I see the
> code returns 0, so one option would be to make this an informational or
> debug print.

I am not in favor of debug in that case, because I suspect it'll hide
too much when getting a bug report. Informational could do, yes.

However, before that, I'd like to dig a little bit more on why it is
failing. I thought arm64 now has support of tracing bpf programs, so I
would not expect this to fail.

Would you mind sending me your .config so I can check in it if you are
missing anything? I am thinking that maybe I need to also depend on
BPF_JIT.

Cheers,
Benjamin

>
> Thanks
> Jon
>
> --
> nvpublic
>

