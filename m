Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2DE575EE0
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 11:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbiGOJ5E (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Jul 2022 05:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbiGOJ5D (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 05:57:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D19C97B78A
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 02:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657879020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8Hrnh4xSI/kevtIOtrai4yHB4Q/NHMbskcGk41P5Ttk=;
        b=PsH6Jp4gDgWEO2c6O5T8slh9gayjaLIKx7B3sXJqc1ZliDKia4tYlaxgdMmKghcLBdAT63
        gompULAD7cQQMxgWv4hNE8l8s1BzQpM8vayKzm4gcEsSdkCEpTkEhWFaoWXJpRqY6LrOGw
        VxZdpqA4X4mV5hOrxoDtWCCkfyiWtbg=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657--HUzbqTsO7iu3pFrlJdzmQ-1; Fri, 15 Jul 2022 05:56:59 -0400
X-MC-Unique: -HUzbqTsO7iu3pFrlJdzmQ-1
Received: by mail-pj1-f71.google.com with SMTP id o21-20020a17090aac1500b001ef977190efso5067294pjq.7
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 02:56:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Hrnh4xSI/kevtIOtrai4yHB4Q/NHMbskcGk41P5Ttk=;
        b=4K2HC/27sX61wYsT0cRXFxKKmh+ZzsLwE7b4BE57Fw7e4k1Xkpdn995PVG5ouQvOaL
         eZ9RzTo1vaeOix3YW3OSXWBYThoA0lm/Z6x0NcLkB5mCoVextAtrf7bW0LnYJ5n9gLln
         P2IH6bp30JxqmJZI5gr7hKxQsQ8R1uf3e4rbbeEgMXzspGrs9jXQ5aT/7X5KaNblrfP9
         qa2QKA9Pdn8JfD5I5Jt6qixJGQUDv1MqRgD+A7nqOgdsarjJptT0y69OfhDGq6gkNeV3
         vyNnwf4G173gLYCJl8IDRx/2o7bwtM4RUJh58V1Kvu5irolwL/RNFYZdGreEfI1pabRL
         dD5Q==
X-Gm-Message-State: AJIora+qAmd7ZaynEv7nNNOGHhFjLtMqmxaeMFxsWJH7k/vm8Ge/2TXz
        bRpk5AC31nKASgIkkitbOgx8VvFrmG3YKvMrJ+j4xnTM6ImXhy221TlLgLCUtCvfcSHGSP4W/o+
        01CvrZ+BTqPil+iPqjUX8LWq1saUZ
X-Received: by 2002:a17:90a:be0c:b0:1ef:accb:23a5 with SMTP id a12-20020a17090abe0c00b001efaccb23a5mr14728449pjs.113.1657879018490;
        Fri, 15 Jul 2022 02:56:58 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vH3VKnUSifYcKOV2DL1yCJLfK4VppjP4mBn1OJIP42LQAI4oYiGA7TAcUy7OJJe7owCfc/M0euZYcsf4hCj2s=
X-Received: by 2002:a17:90a:be0c:b0:1ef:accb:23a5 with SMTP id
 a12-20020a17090abe0c00b001efaccb23a5mr14728406pjs.113.1657879018230; Fri, 15
 Jul 2022 02:56:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220712145850.599666-1-benjamin.tissoires@redhat.com>
 <20220712145850.599666-13-benjamin.tissoires@redhat.com> <YtD09KwkxvJAbgCy@kroah.com>
In-Reply-To: <YtD09KwkxvJAbgCy@kroah.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 15 Jul 2022 11:56:46 +0200
Message-ID: <CAO-hwJ+d6mNO2L5kZtOC6QVrDy+LZ6ECoY2f83C93GFPKbSx7g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 12/23] HID: initial BPF implementation
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
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
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 15, 2022 at 7:02 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jul 12, 2022 at 04:58:39PM +0200, Benjamin Tissoires wrote:
> > --- /dev/null
> > +++ b/drivers/hid/bpf/Kconfig
> > @@ -0,0 +1,19 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +menu "HID-BPF support"
> > +     #depends on x86_64
> > +
> > +config HID_BPF
> > +     bool "HID-BPF support"
> > +     default y
>
> Things are only default y if you can't boot your machine without it.
> Perhaps just mirror what HID is to start with and do not select HID?
>
> > +     depends on BPF && BPF_SYSCALL
> > +     select HID
>
> select is rough, why not depend?

Let me try to explain this mess, maybe you can give me the piece that
I am missing:

The requirements I have (or want) are:
- HID-BPF should be "part" of HID-core (or something similar of "part"):
  I intend to have device fixes as part of the regular HID flow, so
allowing distros to opt out seems a little bit dangerous
- the HID tree is not as clean as some other trees:
  drivers/hid/ sees both core elements and leaf drivers
  transport layers are slightly better, they are in their own
subdirectories, but some transport layers are everywhere in the kernel
code or directly in drivers/hid (uhid and hid-logitech-dj for
instance)
- HID can be loaded as a module (only ubuntu is using that), and this
is less and less relevant because of all of the various transport
layers we have basically prevent a clean unloading of the module

These made me think that I should have a separate bpf subdir for
HID-BPF, to keep things separated, which means I can not include
HID-BPF in hid.ko directly, it goes into a separate driver. And then I
have a chicken and egg problem:
- HID-core needs to call functions from HID-BPF (to hook into it)
- but HID-BPF needs to also call functions from HID-core (for
accessing HID internals)

I have solved that situation with struct hid_bpf_ops but it is not the
cleanest possible way.

And that's also why I did "select HID", because HID-BPF without HID is
pointless.

One last bit I should add. hid-bpf.ko should be allowed to be compiled
in as a module, but I had issues at boot because kfuncs were not
getting registered properly (though it works for the net test driver).
So I decided to make hid-bpf a boolean instead of a tristate.

As I type all of this, I am starting to wonder if I should not tackle
the very first point and separate hid-core in its own subdir. This way
I can have a directory with only the core part, and having hid-bpf in
here wouldn't be too much of an issue.

Thoughts?

Cheers,
Benjamin

