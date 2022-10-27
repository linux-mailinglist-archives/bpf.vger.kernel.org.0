Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04B260F358
	for <lists+bpf@lfdr.de>; Thu, 27 Oct 2022 11:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235265AbiJ0JMF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Oct 2022 05:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235350AbiJ0JLF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Oct 2022 05:11:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E0840E1B
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 02:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666861840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ziau/u6EFDYrbkB/0U+jFJAy6/VcVCK6XBP9il5+IKo=;
        b=DR5zuXHf5QYQzPYnaLGXt8eE8oU7NfyR9QZxMvMVwhJuA7xwH/EZj0ElS7pRNsptcEFkeu
        e8JSGMnmc/lnJg6iqUJEWGsUMIAVat7/2FcnYJhRcSqpDtDF6bH0JFo9+Mm0LJrSPHvsgb
        MmUgl5J7hAXmZ1k2btfJ5I15MkVZFPM=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-592-VOomaLEzMTqLjow0gw-JEQ-1; Thu, 27 Oct 2022 05:10:39 -0400
X-MC-Unique: VOomaLEzMTqLjow0gw-JEQ-1
Received: by mail-lf1-f71.google.com with SMTP id bp18-20020a056512159200b004a2c88a4e1eso349449lfb.3
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 02:10:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ziau/u6EFDYrbkB/0U+jFJAy6/VcVCK6XBP9il5+IKo=;
        b=2dEs95Fb+08/iINWKrVuFUW1IgzFWlptwaC7S6MeSKQxHPlGSjBm5q0Ai/p443z7LB
         eqV0nLVigltiScOCGXSdmUnfe/sT3TDk+Oo8IvHej7n8nu1sLWmmiI3R6gj3mdHUiEGY
         iuOC05C07q2T3EErQ0ijnS07im7NcGHFGc7FqpNV3s4c5GbMSoNne1hHZr+m/MN2++Hj
         VtI26htHWi411lVDGPebfFIOB3q0UzgeP/q6Yp03EqWMCgUwvSkDbAlvo+n0ybUMUVql
         qvo7abgDOB8yD8mXYMoZzocz5I6jmlTfVCVoK+004rJYMF6E15dUw2tjQ2IuIeu4aRt5
         w4JQ==
X-Gm-Message-State: ACrzQf0umZVpS/Nbwr5ZIg1Nej9f4pIjDKzdk06GBTUvNQ2vlmCk8k/i
        bbcP9fNvafypsA2LuJ4p1F7YIYlJm4/XS5m0V3tbDARbJWTW6rCwDAxjxECnjLEOk/GYtExWptg
        BM1ffQEJhz7fSc8pGOU42ZV9H3aW2
X-Received: by 2002:ac2:47e1:0:b0:4af:5088:9576 with SMTP id b1-20020ac247e1000000b004af50889576mr2998557lfp.468.1666861837591;
        Thu, 27 Oct 2022 02:10:37 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4fIV6ydQRgmrMVyIU2r9H0oB18YXsVEUdlFYjrQuSfS2ucEUJhllLqj68fs6nzyLA4Vj6RKPmXnDYesOOZKOo=
X-Received: by 2002:ac2:47e1:0:b0:4af:5088:9576 with SMTP id
 b1-20020ac247e1000000b004af50889576mr2998542lfp.468.1666861837363; Thu, 27
 Oct 2022 02:10:37 -0700 (PDT)
MIME-Version: 1.0
References: <20221025093458.457089-1-benjamin.tissoires@redhat.com>
 <20221025093458.457089-3-benjamin.tissoires@redhat.com> <20221025225219.i3pi7ewue6xqeig4@macbook-pro-4.dhcp.thefacebook.com>
In-Reply-To: <20221025225219.i3pi7ewue6xqeig4@macbook-pro-4.dhcp.thefacebook.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 27 Oct 2022 10:11:31 +0100
Message-ID: <CAO-hwJ+WWO-GhzX-eaoGtF8+5Mw-QOVREWYmtm-VNBF5NGC22g@mail.gmail.com>
Subject: Re: [PATCH hid v11 02/14] HID: initial BPF implementation
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 25, 2022 at 11:52 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Oct 25, 2022 at 11:34:46AM +0200, Benjamin Tissoires wrote:
> >  include/linux/hid.h                           |   5 +
> >  include/linux/hid_bpf.h                       | 102 +++
> >  include/uapi/linux/hid_bpf.h                  |  25 +
> >  tools/include/uapi/linux/hid.h                |  62 ++
> >  tools/include/uapi/linux/hid_bpf.h            |  25 +
>
> ...
>
> > +++ b/include/linux/hid_bpf.h
> > @@ -0,0 +1,102 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +
> > +#ifndef __HID_BPF_H
> > +#define __HID_BPF_H
> > +
> > +#include <linux/spinlock.h>
> > +#include <uapi/linux/hid.h>
> > +#include <uapi/linux/hid_bpf.h>
> > +
> > +struct hid_device;
> > +
> > +/*
> > + * The following is the HID BPF API.
> > + *
> > + * It should be treated as UAPI, so extra care is required
> > + * when making change to this file.
> > + */
>
> I thought at the maintainer summit we discussed that it shouldn't be
> treated as uapi. There is no need to draw this line right now.
> If the whole concept turns out to be useful and api is stable
> then promote it.

I'd still like to keep the kfunc API explicitly marked as "danger
zone". I want to let contributors know that changing this part has an
impact on the existing available bpf programs that are out of the tree
(the HID firewall for instance might be out of the tree).

I'll reword it to not mark it as uapi though.

>
> > +++ b/include/uapi/linux/hid_bpf.h
> > @@ -0,0 +1,25 @@
> > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > +
> > +#ifndef _UAPI_HID_BPF_H
> > +#define _UAPI_HID_BPF_H
> > +
> > +#include <linux/const.h>
> > +#include <linux/hid.h>
> > +
> > +/**
> > + * enum hid_bpf_attach_flags - flags used when attaching a HIF-BPF program
> > + *
> > + * @HID_BPF_FLAG_NONE: no specific flag is used, the kernel choses where to
> > + *                     insert the program
> > + * @HID_BPF_FLAG_INSERT_HEAD: insert the given program before any other program
> > + *                            currently attached to the device. This doesn't
> > + *                            guarantee that this program will always be first
> > + * @HID_BPF_FLAG_MAX: sentinel value, not to be used by the callers
> > + */
> > +enum hid_bpf_attach_flags {
> > +     HID_BPF_FLAG_NONE = 0,
> > +     HID_BPF_FLAG_INSERT_HEAD = _BITUL(0),
> > +     HID_BPF_FLAG_MAX,
> > +};
> > +
> > +#endif /* _UAPI_HID_BPF_H */
>
> Not sure what is the purpose of this uapi file.
> Since it's enum the progs can get it from vmlinux.h.

Good point. It can easily go into the non uapi hid_bpf.h

>
> > diff --git a/tools/include/uapi/linux/hid.h b/tools/include/uapi/linux/hid.h
> > new file mode 100644
> > index 000000000000..3e63bea3b3e2
> > --- /dev/null
> > +++ b/tools/include/uapi/linux/hid.h
> > @@ -0,0 +1,62 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> > +/*
> > + *  Copyright (c) 1999 Andreas Gal
> > + *  Copyright (c) 2000-2001 Vojtech Pavlik
> > + *  Copyright (c) 2006-2007 Jiri Kosina
> > + */
> > +#ifndef _UAPI__HID_H
> > +#define _UAPI__HID_H
>
> This is a copy of include/uapi/linux/hid.h ?

Yes it is

> Probably should be a separate commit to make it obvious.
>

I'll need to assess why I needed that. I think it was related to the
selftests, but now that they are in selftests/hid, I can probably have
a special include in the Makefile to not have to duplicate the file at
all.

Thanks for the review :)

Cheers,
Benjamin

