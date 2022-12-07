Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F28645D24
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 16:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiLGPBc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 10:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiLGPBF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 10:01:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307B261BBA
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 06:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670425114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=81tx4Qu/i7V9KBQ9lAK66Q8QPlDEub1zKKTdHJd3xZc=;
        b=N/RrsmV9Xk/zo3xcdthUJVkvjtyu8L2n9NcOZoEvloWtM9rAQ0Hn8vQznVqMkVCSJeBu3w
        6uG9jKG3+WTmE/ytH9IoAYwcMvoO7DIflD4fGuwBX/18SM8KblSilA6/iKeyOTIaBOCF3t
        iWXk+f/hqaS0DnoRqcc/lWnMEJe9fk0=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-166-7LFfixQLMhucGLiMtqjGRw-1; Wed, 07 Dec 2022 09:58:33 -0500
X-MC-Unique: 7LFfixQLMhucGLiMtqjGRw-1
Received: by mail-io1-f71.google.com with SMTP id h21-20020a05660224d500b006debd7dedccso13630521ioe.9
        for <bpf@vger.kernel.org>; Wed, 07 Dec 2022 06:58:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=81tx4Qu/i7V9KBQ9lAK66Q8QPlDEub1zKKTdHJd3xZc=;
        b=lxaQqxFw5uYaCTJ2I+405uNErQiJzFWrRA5dPXnazKCrXQcDqNy/soJsoc67PS1yV6
         Q1+ZToH5Jr9utot03vWiyknzWhdeL5F1kploBvBEhnIFGDxetLI2A89UVdQgJlKs5JK2
         aarjFSzOr+5CBEgtit5bCknj/ai5B/c2V6cXsET4EHUAPyesq+07j/6J51fDbMXUfymI
         KAyhkXbEimO6dvIU/I6gM65HRiMR7ffMK9mnhtWcLx2ek3uSNShjtvRY463JDoJhd2bZ
         uSBUZBZDzUJSX50LrOy3zlZzEs2tMy3i+2xqzFlIdnjq1cq+iB+2L89QhgVPbor+p3nS
         KRsg==
X-Gm-Message-State: ANoB5pmCWaoKIz+wZVMtonbTvQKc1MX2k3h3FGULiruAeJVEME33M9Ta
        YlsAy6vqBZ4ddNnFP6+YR1OWO7dR7OrTya99kP1nnxnfVVr3Lkf16y7JCzpwKtonzC9V9JyzouK
        BVaVu0hpdDqK8My3MlBsDOTo+rV9j
X-Received: by 2002:a02:cc31:0:b0:389:f21d:ec44 with SMTP id o17-20020a02cc31000000b00389f21dec44mr16621888jap.106.1670425112456;
        Wed, 07 Dec 2022 06:58:32 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4kM7WVmrniMvBfEcxbq+UC0cEZ9wYd5nOJPAwF5eggKPwWUOBHz/nl3G5o4x/8P8WXHDfEVEplpo9f2kjZxWE=
X-Received: by 2002:a02:cc31:0:b0:389:f21d:ec44 with SMTP id
 o17-20020a02cc31000000b00389f21dec44mr16621879jap.106.1670425112254; Wed, 07
 Dec 2022 06:58:32 -0800 (PST)
MIME-Version: 1.0
References: <20221206145936.922196-1-benjamin.tissoires@redhat.com> <20221206145936.922196-4-benjamin.tissoires@redhat.com>
In-Reply-To: <20221206145936.922196-4-benjamin.tissoires@redhat.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 7 Dec 2022 15:58:21 +0100
Message-ID: <CAO-hwJJq23V+ceJvX8zz-wGB6VgByuMY-xGu8VukiOmP+FfXHA@mail.gmail.com>
Subject: Re: [PATCH HID for-next v3 3/5] HID: bpf: enforce HID_BPF dependencies
To:     Jiri Kosina <jikos@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 6, 2022 at 3:59 PM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> As mentioned in the link below, having JIT and BPF is not enough to
> have fentry/fexit/fmod_ret APIs. This resolves the error that
> happens on a system without tracing enabled when hid-bpf tries to
> load itself.
>
> Link: https://lore.kernel.org/r/CABRcYmKyRchQhabi1Vd9RcMQFCcb=EtWyEbFDFRTc-L-U8WhgA@mail.gmail.com
> Fixes: f5c27da4e3c8 ("HID: initial BPF implementation")
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>
> ---
>
> no changes in v3
>
> changes in v2:
> - dropped ALLOW_ERROR_INJECTION requirement

Florent, can I keep your reviewed-by on this patch?

Jon, may I ask you to do one more testing with the full v3 applied on
top of for-next?

Cheers,
Benjamin

> ---
>  drivers/hid/bpf/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/bpf/Kconfig b/drivers/hid/bpf/Kconfig
> index 298634fc3335..03f52145b83b 100644
> --- a/drivers/hid/bpf/Kconfig
> +++ b/drivers/hid/bpf/Kconfig
> @@ -4,7 +4,8 @@ menu "HID-BPF support"
>  config HID_BPF
>         bool "HID-BPF support"
>         default HID_SUPPORT
> -       depends on BPF && BPF_SYSCALL
> +       depends on BPF && BPF_SYSCALL && \
> +                  DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>         help
>         This option allows to support eBPF programs on the HID subsystem.
>         eBPF programs can fix HID devices in a lighter way than a full
> --
> 2.38.1
>

