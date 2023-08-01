Return-Path: <bpf+bounces-6525-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D9D76A8CB
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 08:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F38512814EE
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 06:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0676F4A11;
	Tue,  1 Aug 2023 06:15:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CDBEA3
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 06:15:25 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41DB18E
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 23:15:23 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31765aee31bso4707708f8f.1
        for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 23:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690870522; x=1691475322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/nwlFyGogiUX3g0hBQ6QiczaDPbP0CFqMj2DOCItMQg=;
        b=p6fdgHmQkUMbN/NXmly0dejbiIuI9O5JXTuUxOqYObmdf4jbJXeEuEGZ6CMUd9jBPd
         m8WsbosbtDDkqgrbdmblAHoAoVnstaca9VWKhVQwcciiHdUoECyW1EcG/lATUlzndgoM
         qOUmmH3gGJ0vv5vtwHG+z03D/kJPFj/MIguSb4+JSYJH2AgTJYK7yHjEuYy/OsBiO0Ac
         tn9O0ssM7ZF3j1xfJbJgoICINQUXZmNNEuMc+WnWUSehvtejXzmSPTUkiBFK8KzK5t0Q
         dgEXRF4823kbHRia5RZ9Qvm2PTOtIx+PZ9qdWeUgVKa3Ct1EhgFvBrN9Dh9TJT9z05K0
         4/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690870522; x=1691475322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/nwlFyGogiUX3g0hBQ6QiczaDPbP0CFqMj2DOCItMQg=;
        b=U5FgvvSGAn2bscdMbR7uXgGmy36kD20Ypimtxkp3ammhvhTAOgdZcPyOj+vOWInh9u
         vVig/oMAdBrfsD/56ySJp2qlFkSLnGjAZ2Vjld7ZLmWHYDC9ToZEAhQs7Go5PDoGzbUA
         6tZRFRCNHNpocaPenXV/o+ulZnm5+LR1qbQa0CgBtQxIDqOWJG33mvBY+qwofmRZ2aUS
         NbmcLayfODI4QgsnEdDnt5xeL8ACUh7upORVq2bby3RFI9F4dDFI7qpUrfmNIV//Lh3I
         ipw45Sv+jpiKpiYYE2yXIgDtgpIcm+4QfTjgOYUGDlg7crVMqRiiBnS9R8hGVYidnonX
         4QoQ==
X-Gm-Message-State: ABy/qLYn6QmQUa6aWvN1o+3s3zQosmcvT2yT9/2IHj+z8bgVihp03w40
	EV/VyIJLRQqDR8D5VboPpilREbWAFFHnS1QNMMM=
X-Google-Smtp-Source: APBJJlHMgmO8zYgDL49UykM9Zd0B3suqHmIdFgRxjRm2/7e8oWx3QHnORFRN4wl3w6BG6BGU9/ZcBA==
X-Received: by 2002:a5d:658a:0:b0:317:4a0b:c4db with SMTP id q10-20020a5d658a000000b003174a0bc4dbmr1264542wru.71.1690870522170;
        Mon, 31 Jul 2023 23:15:22 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d654d000000b00314398e4dd4sm15015824wrv.54.2023.07.31.23.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 23:15:21 -0700 (PDT)
Date: Tue, 1 Aug 2023 09:15:18 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kui-Feng Lee <kuifeng@meta.com>, Joanne Koong <joannelkoong@gmail.com>,
	bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [bug report] bpf: Add bpf_dynptr_slice and bpf_dynptr_slice_rdwr
Message-ID: <1036389e-2dda-4399-922a-e6d0c39934ae@kadam.mountain>
References: <d1360219-85c3-4a03-9449-253ea905f9d1@moroto.mountain>
 <CAADnVQJjRy75vy3KSm7hbyBq=1Urfz4eVKiigPHr78nuxz-CBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJjRy75vy3KSm7hbyBq=1Urfz4eVKiigPHr78nuxz-CBA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 31, 2023 at 01:47:01PM -0700, Alexei Starovoitov wrote:
> Probably the following will be enough:
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 56ce5008aedd..eb91cae0612a 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2270,7 +2270,7 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct
> bpf_dynptr_kern *ptr, u32 offset
>         case BPF_DYNPTR_TYPE_XDP:
>         {
>                 void *xdp_ptr = bpf_xdp_pointer(ptr->data, ptr->offset
> + offset, len);
> -               if (xdp_ptr)
> +               if (!IS_ERR_OR_NULL(xdp_ptr))
>                         return xdp_ptr;

Also please, add a comment to bpf_xdp_pointer() which explains what the
NULL return means.  I couldn't figure it out.

> 
> Also I've noticed:
> void bpf_xdp_copy_buf(struct xdp_buff *xdp, unsigned long off,
>                       void *buf, unsigned long len, bool flush);
> #else /* CONFIG_NET */
> static inline void *bpf_xdp_pointer(struct xdp_buff *xdp, u32 offset, u32 len)
> {
>         return NULL;
> }
> 
> The latter is wrong.

This the only part which I thought I understood.  :P  How is this wrong?

regards,
dan carpenter


