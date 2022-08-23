Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140D359ECF7
	for <lists+bpf@lfdr.de>; Tue, 23 Aug 2022 22:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbiHWUAV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 16:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiHWUAE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 16:00:04 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9ED58B2EB
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 12:11:51 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id u15so20656468ejt.6
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 12:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=mz2B68wWUIQKtpeC5hwzoIAym/fGgGRW2t073shoO0Y=;
        b=kX/utu7TsfYVqaplhb4/1pEvHBDFRiJCU9mpvvlv48MWxIYl/3sOZTwiWsbamFyE+3
         cj6YtmAK6BpZaUheO2Js9Q6RaIbZepfZCGeZ3w4F5xXBOS9VjLhUA+NrD7IkY/E0dgCs
         K6qs4m5J62/DfiaQXj42AZFeKX4IaEUCrRe0bAsq+qz/6+hEYWTycFfZHtFexCAridHK
         H465R6uXveja6mAdBWO8+6fPjsKx7v3c9EVo7GZFB2yo4bzNRPSNtouvOE0gmvPQr2oF
         LdoNcp/mv24JPwb6X7cPOUyTpBOH0PxWFWSNCx4jWM/bbwMma1f7qbQOgLXB3K2ePq9b
         SRKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=mz2B68wWUIQKtpeC5hwzoIAym/fGgGRW2t073shoO0Y=;
        b=BdIq+hWY/0xzKprqI6cXgojhuAU1cIQel6Tf51Czbq2GcwEIutVhZ9paShX28qgeBm
         H9Y7/RdUTIQKKiJnxRUTmVPbC5aMJGhTJC2hAcJFUFMuqbt1NqenfPB3ZzmPncqP0C5/
         av+0eDzTovZisq90yprIWsLTp1zg4ooswC06bES+kEBHFC0Dlsnr+fs2+m6S9CYSznHI
         5ZrS1Jt9p5rjbv5fK4W3Wa7c6nVHbNXUh8YW+/zhSnqc9JBNlwgRiaDYpfG4ecVa0RlE
         VF01WRNTtwvPgBHe/3Kb8teTeH1pcU6nHARl20TGSCWkRlxMIJIbR3TjeNuaR2GHALmB
         a5RQ==
X-Gm-Message-State: ACgBeo1xsY2vXlel5DSrfg/aFJgdTTYOhu8kUVccKRNYNgIx0XGGb64v
        5bsNtF1IQplI20w4WVQs/YhnYyvHfQo6Ogw+7UQ=
X-Google-Smtp-Source: AA6agR59sTOGZOTvVVplPVB/heu+fuHoUSRKdYZK3jtFtr+q3TCSrPmMm39t7+bdktYNbBMJCDwXUW0GGZYCHuviUjo=
X-Received: by 2002:a17:907:a408:b0:73d:6696:50af with SMTP id
 sg8-20020a170907a40800b0073d669650afmr644129ejc.369.1661281910032; Tue, 23
 Aug 2022 12:11:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220823133020.73872-1-shmulik.ladkani@gmail.com> <20220823133020.73872-2-shmulik.ladkani@gmail.com>
In-Reply-To: <20220823133020.73872-2-shmulik.ladkani@gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Tue, 23 Aug 2022 12:11:38 -0700
Message-ID: <CAJnrk1bYX5iZXGBOfPD43fgGvnKqynD2qgioS9PnEEDMzoYmgw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 1/4] bpf: Add 'bpf_dynptr_get_data' helper
To:     Shmulik Ladkani <shmulik@metanetworks.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Paul Chaignon <paul@isovalent.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 23, 2022 at 10:01 AM Shmulik Ladkani
<shmulik@metanetworks.com> wrote:
>
> The task of calculating bpf_dynptr_kern's available size, and the
> current (offset) data pointer is common for BPF functions working with
> ARG_PTR_TO_DYNPTR parameters.
>
> Introduce 'bpf_dynptr_get_data' which returns the current data
> (with properer offset), and the number of usable bytes it has.
>
> This will void callers from directly calculating bpf_dynptr_kern's
> data, offset and size.
>
> Signed-off-by: Shmulik Ladkani <shmulik.ladkani@gmail.com>
> ---
>  include/linux/bpf.h  |  1 +
>  kernel/bpf/helpers.c | 10 ++++++++++
>  2 files changed, 11 insertions(+)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 39bd36359c1e..6d288dfc302b 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2576,6 +2576,7 @@ void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data,
>                      enum bpf_dynptr_type type, u32 offset, u32 size);
>  void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr);
>  int bpf_dynptr_check_size(u32 size);
> +void *bpf_dynptr_get_data(struct bpf_dynptr_kern *ptr, u32 *avail_bytes);
>
>  #ifdef CONFIG_BPF_LSM
>  void bpf_cgroup_atype_get(u32 attach_btf_id, int cgroup_atype);
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 3c1b9bbcf971..91f406a9c37f 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1461,6 +1461,16 @@ void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data,
>         bpf_dynptr_set_type(ptr, type);
>  }
>
> +void *bpf_dynptr_get_data(struct bpf_dynptr_kern *ptr, u32 *avail_bytes)
> +{
> +       u32 size = bpf_dynptr_get_size(ptr);
> +
> +       if (!ptr->data || ptr->offset > size)

The "ptr->offset > size" check isn't quite correct because size is the
number of usable bytes (more on this below :))

> +               return NULL;
> +       *avail_bytes = size - ptr->offset;

dynptr->size is already the number of usable bytes; this is noted in
include/linux/bpf.h

/* the implementation of the opaque uapi struct bpf_dynptr */
struct bpf_dynptr_kern {
        void *data;
        /* Size represents the number of usable bytes of dynptr data.
         * If for example the offset is at 4 for a local dynptr whose data is
         * of type u64, the number of usable bytes is 4.
         *
         * The upper 8 bits are reserved. It is as follows:
         * Bits 0 - 23 = size
         * Bits 24 - 30 = dynptr type
         * Bit 31 = whether dynptr is read-only
         */
        u32 size;
        u32 offset;
} __aligned(8);

> +       return ptr->data + ptr->offset;
> +}
> +

>  void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr)
>  {
>         memset(ptr, 0, sizeof(*ptr));
> --
> 2.37.2
>
