Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A864CE416
	for <lists+bpf@lfdr.de>; Sat,  5 Mar 2022 11:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbiCEKIM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 5 Mar 2022 05:08:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiCEKIK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 5 Mar 2022 05:08:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 887DD25C12A
        for <bpf@vger.kernel.org>; Sat,  5 Mar 2022 02:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646474838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a0Fgc88E/ZnztbMYK2n/3xkvK5J7VCgRYmi3UI+KKPI=;
        b=EQrcV1RngVR5eUbfS2dgxmuc8SYZRCtPitexg/fdWpbtPZjqYmzv0D3SwI/WQN/+CG24Fp
        qgYiO31q68r9j7sANSvKfQBz/w04ttcabOHIm52l6vs5K+WVkjtBhFs+KbTw8BdYzKXx5E
        +jtAwQJWyPQRZy39BhDguIJ/+j+yd3o=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-609-3MXQ7CXxM2GjWu7-aNevww-1; Sat, 05 Mar 2022 05:07:17 -0500
X-MC-Unique: 3MXQ7CXxM2GjWu7-aNevww-1
Received: by mail-pj1-f70.google.com with SMTP id s20-20020a17090ad49400b001bf481fae01so42pju.1
        for <bpf@vger.kernel.org>; Sat, 05 Mar 2022 02:07:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a0Fgc88E/ZnztbMYK2n/3xkvK5J7VCgRYmi3UI+KKPI=;
        b=rwnWzKBiClEUqIdGhimjIu/wY6J5P3tFmd1xzabLGWfLMbVNL/NiN0UOjFGmLZ/fsH
         LZ4mzy+YBhF8FhFLgZ8tVs0SwCS2hjs4EZQBx80nVvmGDGP8Glhxxfp5zUHEe5iqKi1a
         0eLLObQCJGU3RM56wF+bBKLa33LzNV+nvDAlzPuohT3QoRgQR57Zzgaf7MJV259jyOnB
         95c+cmUe93ADR+4StxI71/loYAETYw//96dlEAHFgoV5xbgWbtGzifha4gFDXsAdYFnK
         2iy1B2qgTHKtWxZqDO1WmNGP+DXNFAb6yS5nuWZ6lryL79yyaZ8wY/+cY9PnsEruX36t
         Wl0w==
X-Gm-Message-State: AOAM532QOA5B//iDiyINyQFHe9rafMmJzc25+PD2Hi4V3xjRoJMVUccM
        Q2E6p4M8JjUpj+ft4PZ33ImW7+6y0HSS9LFPTCrUBEvokYKrNhD1zClR/L3eoO1EWLj7+OemckS
        JFvRZoGrCde0fNQxcEu+SHHp99Yd6
X-Received: by 2002:a17:90a:dac2:b0:1bd:fecf:6bd1 with SMTP id g2-20020a17090adac200b001bdfecf6bd1mr3049398pjx.113.1646474835944;
        Sat, 05 Mar 2022 02:07:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzDEJR/yHEdFWnXc0pHQ+ViBWp74yyK9Eo9xHnLMRRGwOjXlrUAgunUqQ5UkVHlbRmy69Wo/GZFxyibXBCaP0k=
X-Received: by 2002:a17:90a:dac2:b0:1bd:fecf:6bd1 with SMTP id
 g2-20020a17090adac200b001bdfecf6bd1mr3049372pjx.113.1646474835671; Sat, 05
 Mar 2022 02:07:15 -0800 (PST)
MIME-Version: 1.0
References: <20220304172852.274126-1-benjamin.tissoires@redhat.com>
 <20220304172852.274126-2-benjamin.tissoires@redhat.com> <CAPhsuW4otgwwDN6+xcjPXmZyUDiynEKFtXjaFb-=kjz7HzUmZw@mail.gmail.com>
In-Reply-To: <CAPhsuW4otgwwDN6+xcjPXmZyUDiynEKFtXjaFb-=kjz7HzUmZw@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Sat, 5 Mar 2022 11:07:04 +0100
Message-ID: <CAO-hwJJjDMaTXH9i1UkO7Qy+sbNprDyW67cRp8HryMMWMi5H9w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 01/28] bpf: add new is_sys_admin_prog_type() helper
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
        linux-kselftest@vger.kernel.org, Sean Young <sean@mess.org>
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

On Sat, Mar 5, 2022 at 12:12 AM Song Liu <song@kernel.org> wrote:
>
> On Fri, Mar 4, 2022 at 9:30 AM Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> >
> > LIRC_MODE2 does not really need net_admin capability, but only sys_admin.
> >
> > Extract a new helper for it, it will be also used for the HID bpf
> > implementation.
> >
> > Cc: Sean Young <sean@mess.org>
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> >
> > ---
> >
> > new in v2
> > ---
> >  kernel/bpf/syscall.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index db402ebc5570..cc570891322b 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -2165,7 +2165,6 @@ static bool is_net_admin_prog_type(enum bpf_prog_type prog_type)
> >         case BPF_PROG_TYPE_LWT_SEG6LOCAL:
> >         case BPF_PROG_TYPE_SK_SKB:
> >         case BPF_PROG_TYPE_SK_MSG:
> > -       case BPF_PROG_TYPE_LIRC_MODE2:
> >         case BPF_PROG_TYPE_FLOW_DISSECTOR:
> >         case BPF_PROG_TYPE_CGROUP_DEVICE:
> >         case BPF_PROG_TYPE_CGROUP_SOCK:
> > @@ -2202,6 +2201,17 @@ static bool is_perfmon_prog_type(enum bpf_prog_type prog_type)
> >         }
> >  }
> >
> > +static bool is_sys_admin_prog_type(enum bpf_prog_type prog_type)
> > +{
> > +       switch (prog_type) {
> > +       case BPF_PROG_TYPE_LIRC_MODE2:
> > +       case BPF_PROG_TYPE_EXT: /* extends any prog */
> > +               return true;
> > +       default:
> > +               return false;
> > +       }
> > +}
>
> I am not sure whether we should do this. This is a behavior change, that may
> break some user space. Also, BPF_PROG_TYPE_EXT is checked in
> is_perfmon_prog_type(), and this change will make that case useless.

Sure, I can drop it from v3 and make this function appear for HID only.

Regarding BPF_PROG_TYPE_EXT, it was already in both
is_net_admin_prog_type() and is_perfmon_prog_type(), so I duplicated
it here, but I agree, given that it's already in the first function
there, CPA_SYS_ADMIN is already checked.

Cheers,
Benjamin

>
> Thanks,
> Song
>
> [...]
>

