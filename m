Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C6950EF81
	for <lists+bpf@lfdr.de>; Tue, 26 Apr 2022 06:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241233AbiDZEGZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Apr 2022 00:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239593AbiDZEGZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Apr 2022 00:06:25 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269AF12741;
        Mon, 25 Apr 2022 21:03:19 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id q8so5901332plx.3;
        Mon, 25 Apr 2022 21:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MuXHygb3vTcnu2qcstnRIn9AlArvLjRDQBMWJT6fWko=;
        b=h6kcgYxdBoGgOGyQT2W9yftO223D8+g7V2NT++em+Jbc4QTnjiKREcoFmvXm2zDgF7
         ajx3sbd4YDXevwGlJKIOVLrMYNA5Q53O6ZbBNQ+Heb9jOU+aP2BT0JpLUDtiSCRVM6mt
         XItqwRe+50Q4D3wQVP5d+jMB4TimAYwp7OIbq3W+lY9NEamQtO21nRbIj8o16c9xaMGI
         kpBN9wmq5HiD4IjEuzvFVfFPF66RxGy/LdyvBgKpqx7IKZqBfgXcfBMSNqrEC4xBuzq/
         dwub0b6/Wq7hc+938zIebRqUdL8zzAB1Vl0ocPCmJ1D5YMI8q+u3QiFxIfGEph4zUht0
         zeHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MuXHygb3vTcnu2qcstnRIn9AlArvLjRDQBMWJT6fWko=;
        b=MWpfHWETef3f2pbwAjuyyLAKDh3HyWNKgSTqiRBRvZtmLTzU76a6gV3wdyA6rxA8a1
         SHTiJrP3pe3G7a+fdNeQXiy6BMRMVTvCF4vx+gAXlyYqeYNy6xg4Xg/V8XSadNylwk21
         1bk5bTyjmBzOwm36zys3hGJGzwTwUryOMOGMVuvU5dARhbc36TcchCWAgq0mDUJ37Zha
         4PkIUMKPAHI2UPE3Tnl6ZGQROgmWU9par9yzyPXr4UPvBiz5QX/TSwIkb+FVPqXDKCnr
         dIG0JNKmu9Asl0XKCvAKcIcbQ2nch533+Oy1nYKwbPiGxGWwGXh2IReHYNxTQT0KsKvH
         Nshg==
X-Gm-Message-State: AOAM531lmMldgX03/6nrgEW4a+57fULA6kHK6VXXf0E6I8WfLl7vjabz
        k9SD07jOTxC+0ZyFMnuij9I=
X-Google-Smtp-Source: ABdhPJwSCtU03K5ifDEkta/cqH4vsqtSVrOggXdRu/yXMKsIvSGo2zTmucyyESziRDNf9UUp6yV/Tw==
X-Received: by 2002:a17:90a:8b8b:b0:1ca:6007:36e5 with SMTP id z11-20020a17090a8b8b00b001ca600736e5mr24634864pjn.128.1650945798601;
        Mon, 25 Apr 2022 21:03:18 -0700 (PDT)
Received: from MBP-98dd607d3435.dhcp.thefacebook.com ([2620:10d:c090:400::5:438a])
        by smtp.gmail.com with ESMTPSA id f127-20020a62db85000000b0050d3dd1138csm5505919pfg.126.2022.04.25.21.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 21:03:18 -0700 (PDT)
Date:   Mon, 25 Apr 2022 21:03:14 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
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
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [RFC bpf-next v4 0/7] Introduce eBPF support for HID devices
 (new attempt)
Message-ID: <20220426040314.ez3cdpv2w45vbgkk@MBP-98dd607d3435.dhcp.thefacebook.com>
References: <20220421140740.459558-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421140740.459558-1-benjamin.tissoires@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 21, 2022 at 04:07:33PM +0200, Benjamin Tissoires wrote:
> Hi,
> 
> so after the reviews from v3, and some discussion with Alexei, I am
> back with a new version of HID-BPF.
> 
> This version is not complete (thus the RFC), but I'd like to share
> it now to get initial feedback, in case I am too far from the actual
> goal.
> 
> FTR, the goal is to provide some changes in the core verifier/btf so
> that we can plug in HID-BPF independently from BPF core. This way we can
> extend it without having to care about bpf-next.

Overall looks great. imo much cleaner, simpler and more extensible
than the earlier versions.
The bpf core extensions are nicely contained and HID side can be
worked on in parallel.

> The things I am not entirely sure are:
> - do we need only fentry/fexit/fmod_ret BPF program types or should
>   programs that modify the data stream use a different kind?

Probably not. I'll reply in patch 2.

> - patch 3/7 is probably not the correct approach (see comments in the
>   patch itself)
> 
> We are missing quite a few bits here:
> - selftests for patches 1 to 4
> - add the ability to attach a program to a struct device, and run that
>   program only for that struct device

yes. That is still to be figured out.

> - when running through bpf_prog_test_run_opts, how can we ensure we are
>   talking to the correct device? (I have a feeling this is linked to the
>   previous point)
> - how can we reconnect the device when a report descriptor fixup BPF
>   program is loaded (would it make sense to allow some notifications on
>   when a BPF program is attached/detached to a device, and which
>   function have been traced?)

Not sure I follow. What kind of notification do you have in mind?
To user space?
