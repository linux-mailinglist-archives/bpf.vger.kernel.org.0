Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4924950EFB5
	for <lists+bpf@lfdr.de>; Tue, 26 Apr 2022 06:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiDZEXC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Apr 2022 00:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiDZEXB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Apr 2022 00:23:01 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A9E37A2D;
        Mon, 25 Apr 2022 21:19:54 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id s137so15087437pgs.5;
        Mon, 25 Apr 2022 21:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/l15FFYKRMkzqRzmDHai7/3WwowENpJ+GSOSZrIPVqA=;
        b=DYvnYF4nSvbM9gwTOPnyxpgUUtUhpniaICGSbBA9qXpAzJaADif/1HO0KoY3VJbXOM
         oG/N/LZwl0bAFhVzzs700MncngXydagtUv6tSLUj+FQQdy4hyZvMujYFZDfq1Pd4PTSb
         qJsMNhr9EfXiEKKdZIpLcy1l63WHJxwEzkFcEvIO2pJ+3x9RH4V9OFy9PLZuTIMv16c6
         sNFRuQT0U4sCO4r75X84+mLcJDCv2jt8mo6e5EIyzQFBgIRGx13xx4V/GXvebDuG4yzW
         snCDn/G5fpIRJAwBBFfMmB5t8qQFw1RrHULgePAhS+guOSzlYmvwzZu1eZ7p4uPADDZS
         13LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/l15FFYKRMkzqRzmDHai7/3WwowENpJ+GSOSZrIPVqA=;
        b=5/ttNEE1oBir0tGxCXo96EYPFWQkcWoOYeUOHvBwD3eoHp/uzh3TGUPcS0mn5DRtM9
         dOjhxYQKilVfyr3I3MItkF7wFLenwGobbm5LdV3oF08BqjYgojuppyrSfan+Rfr4QT3p
         iX+3lP+Ofylgf7/5mHz+qUoO5JTNpb/LbJeCYp/jGj568LdgAg/JoY6C7mYftkM5c0Hh
         8+Z1Ok3OM6PAzSVWUJpw9wmMhrWQQFI/pElfXQl8HnGMoREwgYLaRhtywAIB+6I7ihC5
         2cS3jydPFgl8GvSdvu1negux1kaylW/8Y8t/9sTxc4gqJPNxRFHH7Wui+1KtpoAIxAqM
         v3Pw==
X-Gm-Message-State: AOAM532yS0T7IGPyyXP+i+O6y0p4RtZSMZ19kFUjKIeUbblvnuwPbelQ
        aUvHltBmZRz0l2cRp+bV9JA=
X-Google-Smtp-Source: ABdhPJz272A1/elptqNr4fFLMbKVCsS6oHN4V3OEXR9w5j27ZJGaoQMxEgcCibwnahG//o2bCgMFrQ==
X-Received: by 2002:a63:42c4:0:b0:3a2:b7e5:5077 with SMTP id p187-20020a6342c4000000b003a2b7e55077mr17895644pga.427.1650946794073;
        Mon, 25 Apr 2022 21:19:54 -0700 (PDT)
Received: from MBP-98dd607d3435.dhcp.thefacebook.com ([2620:10d:c090:400::5:438a])
        by smtp.gmail.com with ESMTPSA id e6-20020a17090a7c4600b001d960eaed66sm887311pjl.42.2022.04.25.21.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 21:19:53 -0700 (PDT)
Date:   Mon, 25 Apr 2022 21:19:50 -0700
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
Subject: Re: [RFC bpf-next v4 5/7] HID: initial BPF new way implementation
Message-ID: <20220426041950.j37velutd2ckj3s5@MBP-98dd607d3435.dhcp.thefacebook.com>
References: <20220421140740.459558-1-benjamin.tissoires@redhat.com>
 <20220421140740.459558-6-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421140740.459558-6-benjamin.tissoires@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 21, 2022 at 04:07:38PM +0200, Benjamin Tissoires wrote:
> Declare an entry point that can use fmod_ret BPF programs, and
> also an API to access and change the incoming data.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> ---
> 
> new-ish in v4:
> - far from complete, but gives an overview of what we can do now.
> ---
>  drivers/hid/hid-core.c  | 115 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/hid_bpf.h |  29 ++++++++++
>  2 files changed, 144 insertions(+)
>  create mode 100644 include/linux/hid_bpf.h
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index db925794fbe6..ff4e1b47d2fb 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -32,6 +32,9 @@
>  #include <linux/hiddev.h>
>  #include <linux/hid-debug.h>
>  #include <linux/hidraw.h>
> +#include <linux/btf.h>
> +#include <linux/btf_ids.h>
> +#include <linux/hid_bpf.h>
>  
>  #include "hid-ids.h"
>  
> @@ -2008,6 +2011,99 @@ int hid_report_raw_event(struct hid_device *hid, int type, u8 *data, u32 size,
>  }
>  EXPORT_SYMBOL_GPL(hid_report_raw_event);
>  
> +struct hid_bpf_ctx_kern {
> +	struct hid_device *hdev;
> +	struct hid_bpf_ctx ctx;
> +	u8 *data;
> +	size_t size;
> +};
> +
> +__weak int hid_bpf_device_event(struct hid_bpf_ctx *ctx, s64 type)
> +{
> +	return 0;
> +}
> +ALLOW_ERROR_INJECTION(hid_bpf_device_event, NS_ERRNO);
> +
> +noinline __u8 *
> +hid_bpf_kfunc_get_data(struct hid_bpf_ctx *ctx, unsigned int offset, const size_t __sz)
> +{
> +	struct hid_bpf_ctx_kern *ctx_kern;
> +
> +	if (!ctx)
> +		return NULL;
> +
> +	ctx_kern = container_of(ctx, struct hid_bpf_ctx_kern, ctx);
> +
> +	return ctx_kern->data;
> +}

It probably needs to check that "rdonly_buf_sz" or "__sz" constant passed
by the program is less than what was allocated in hid_bpf_ctx_kern->data.
Right?

> +
> +noinline void
> +hid_bpf_kfunc_data_release(__u8 *data)
> +{
> +}

Not clear what release() is for.
hid_bpf_kfunc_get_data() will return PTR_TO_MEM.
There is no need to release it.

> +
> +noinline int
> +hid_bpf_kfunc_hw_request(struct hid_bpf_ctx *ctx)
> +{
> +	if (!ctx)
> +		return -EINVAL;
> +
> +	pr_err("%s test ctx->bus: %04x %s:%d", __func__, ctx->bus, __FILE__, __LINE__);
> +
> +	return 0;
> +}
> +
> +/*
> + * The following set contains all functions we agree BPF programs
> + * can use.
> + */
> +BTF_SET_START(hid_bpf_kfunc_ids)
> +BTF_ID(func, hid_bpf_kfunc_get_data)
> +BTF_ID(func, hid_bpf_kfunc_data_release)
> +BTF_ID(func, hid_bpf_kfunc_hw_request)
> +BTF_SET_END(hid_bpf_kfunc_ids)
> +
> +/*
> + * The following set contains all functions to provide a kernel
> + * resource to the BPF program.
> + * We need to add a counterpart release function.
> + */
> +BTF_SET_START(hid_bpf_kfunc_acquire_ids)
> +BTF_ID(func, hid_bpf_kfunc_get_data)
> +BTF_SET_END(hid_bpf_kfunc_acquire_ids)
> +
> +/*
> + * The following set is the release counterpart of the previous
> + * function set.
> + */
> +BTF_SET_START(hid_bpf_kfunc_release_ids)
> +BTF_ID(func, hid_bpf_kfunc_data_release)
> +BTF_SET_END(hid_bpf_kfunc_release_ids)
> +
> +/*
> + * The following set tells which functions are sleepable.
> + */
> +BTF_SET_START(hid_bpf_kfunc_sleepable_ids)
> +BTF_ID(func, hid_bpf_kfunc_hw_request)
> +BTF_SET_END(hid_bpf_kfunc_sleepable_ids)
> +
> +static const struct btf_kfunc_id_set hid_bpf_kfunc_set = {
> +	.owner         = THIS_MODULE,
> +	.check_set     = &hid_bpf_kfunc_ids,
> +	.acquire_set   = &hid_bpf_kfunc_acquire_ids,
> +	.release_set   = &hid_bpf_kfunc_release_ids,
> +	.ret_null_set  = &hid_bpf_kfunc_acquire_ids, /* duplicated to force BPF programs to
> +						      * check the validity of the returned pointer
> +						      * in acquire function
> +						      */
> +	.sleepable_set = &hid_bpf_kfunc_sleepable_ids,
> +};
> +
> +static int __init hid_bpf_init(void)
> +{
> +	return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &hid_bpf_kfunc_set);
> +}
> +
>  /**
>   * hid_input_report - report data from lower layer (usb, bt...)
>   *
> @@ -2025,6 +2121,17 @@ int hid_input_report(struct hid_device *hid, int type, u8 *data, u32 size, int i
>  	struct hid_driver *hdrv;
>  	struct hid_report *report;
>  	int ret = 0;
> +	struct hid_bpf_ctx_kern ctx_kern = {
> +		.hdev = hid,
> +		.ctx = {
> +			.bus = hid->bus,
> +			.group = hid->group,
> +			.vendor = hid->vendor,
> +			.product = hid->product,
> +		},
> +		.data = data,
> +		.size = size,
> +	};

I'm not sure why hid_bpf_ctx_kern is needed.
Just to scope all args into one struct?

> +/*
> + * The following is the HID BPF API.
> + *
> + * It should be treated as UAPI, so extra care is required
> + * when making change to this file.
> + */
> +
> +struct hid_bpf_ctx {
> +	__u16 bus;							/* BUS ID */
> +	__u16 group;							/* Report group */
> +	__u32 vendor;							/* Vendor ID */
> +	__u32 product;							/* Product ID */
> +	__u32 version;							/* HID version */
> +};

Your choice of course,
but not clear why kernel has to populate it with explicit:
+			.bus = hid->bus,
+			.group = hid->group,
+			.vendor = hid->vendor,
+			.product = hid->product,
and waste cpu cycles on that while bpf program can read all these fields
on demand when necessary.
