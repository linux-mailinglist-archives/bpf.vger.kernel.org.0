Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B8B6ED57A
	for <lists+bpf@lfdr.de>; Mon, 24 Apr 2023 21:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbjDXTqu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Apr 2023 15:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjDXTqu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Apr 2023 15:46:50 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8685B8C
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 12:46:49 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-63b62d2f729so4047734b3a.1
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 12:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682365609; x=1684957609;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hNC8FgloV+azAmjYrmYkPDzFDekEApPC3gjDmncj4RU=;
        b=N6qYz4okTKI9eWkpo1m1DEc7oQ1aF2Vwpb21eKFXZ2wUu0FZACPKE/w6agDtp37rJs
         kKkbf1OVUhGIjNf8RtSZZVnu7t/lu/Cz3vrXgqHuNni+CXvQiejL34lAE8GAkPB1AnSB
         VFgDML2Lsa73ZHrPM5wLs1yPDCdSEWS2FFT2gmjyB1+rYtfep4lkgO3/ClBbR59BnrBd
         QxG+U26JcT7x4QD87s3h0814gyhbjl/9TT2igCEb0CHpgjHg3o7bAwq/emr9dTr8DK4Q
         ia7qK0BviowYaTTQqPlxj0Vl8iCXb6laDCZBRPqi2OysaXYjT6HgjGNtYYYhPnxrpU8x
         YXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682365609; x=1684957609;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hNC8FgloV+azAmjYrmYkPDzFDekEApPC3gjDmncj4RU=;
        b=HNHvWiaoPG2hoJ/cslOoCKtUZc3m3XOgIBs3bTaFOzw4Rk8hiRHbs8PbAuNz9LwZrb
         dCZpGKZHqo3GoddN00othdqd7/vUMIHp2a4E6zRK15AK3ilpnusZeMdhXHWan4eyIaMN
         V7ur+RzzVTbfH9YTdnzYZQ3o9Vu51ONSUVJm8h4qUb/c6bA6tjQJzWH5d/fOKHIS75Cq
         1N5PvV4MhD7dyYqzzvn2qgVltN5aUYBE4Ob2yZ9OQbNhrQmv8GBYjPGznc6+0ExUE3t2
         PNIxL7gIzUjHqJPV2LA/QMj4QDwSc4ov6lSVbAFVbp8y2uMOIrssdySpjr0C3uElDwX5
         gwDw==
X-Gm-Message-State: AAQBX9faPhnwegNroYpzaLjZCzRppFzIgQ/vuG9xtNlwkJOsjI4tXIIg
        fWBIdru6bpxNBbsfWWiCMAI=
X-Google-Smtp-Source: AKy350afHGlGjcZr+W5xgNQ7LqgMJYxNFgHOg8IvWsy08vSrdZ66WbG66Xc9FS1pyAJ8pXK+MM+Qsw==
X-Received: by 2002:a05:6a00:1a56:b0:63d:3789:733f with SMTP id h22-20020a056a001a5600b0063d3789733fmr20274727pfv.15.1682365608583;
        Mon, 24 Apr 2023 12:46:48 -0700 (PDT)
Received: from localhost ([2605:59c8:148:ba10:d8b6:344e:b81a:e8b5])
        by smtp.gmail.com with ESMTPSA id p2-20020a056a000a0200b00638c9a2ba5csm7831577pfh.62.2023.04.24.12.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 12:46:48 -0700 (PDT)
Date:   Mon, 24 Apr 2023 12:46:46 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Joanne Koong <joannelkoong@gmail.com>, bpf@vger.kernel.org
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        Joanne Koong <joannelkoong@gmail.com>
Message-ID: <6446dca6c74fd_389cc208e3@john.notmuch>
In-Reply-To: <20230420071414.570108-2-joannelkoong@gmail.com>
References: <20230420071414.570108-1-joannelkoong@gmail.com>
 <20230420071414.570108-2-joannelkoong@gmail.com>
Subject: RE: [PATCH v2 bpf-next 1/5] bpf: Add bpf_dynptr_adjust
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Joanne Koong wrote:
> Add a new kfunc
> 
> int bpf_dynptr_adjust(struct bpf_dynptr_kern *ptr, u32 start, u32 end);
> 
> which adjusts the dynptr to reflect the new [start, end) interval.
> In particular, it advances the offset of the dynptr by "start" bytes,
> and if end is less than the size of the dynptr, then this will trim the
> dynptr accordingly.
> 
> Adjusting the dynptr interval may be useful in certain situations.
> For example, when hashing which takes in generic dynptrs, if the dynptr
> points to a struct but only a certain memory region inside the struct
> should be hashed, adjust can be used to narrow in on the
> specific region to hash.

Would you want to prohibit creating an empty dynptr with [start, start)?

> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  kernel/bpf/helpers.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 00e5fb0682ac..7ddf63ac93ce 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1448,6 +1448,13 @@ u32 bpf_dynptr_get_size(const struct bpf_dynptr_kern *ptr)
>  	return ptr->size & DYNPTR_SIZE_MASK;
>  }
>  
> +static void bpf_dynptr_set_size(struct bpf_dynptr_kern *ptr, u32 new_size)
> +{
> +	u32 metadata = ptr->size & ~DYNPTR_SIZE_MASK;
> +
> +	ptr->size = new_size | metadata;
> +}
> +
>  int bpf_dynptr_check_size(u32 size)
>  {
>  	return size > DYNPTR_MAX_SIZE ? -E2BIG : 0;
> @@ -2297,6 +2304,24 @@ __bpf_kfunc void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr_kern *ptr, u32 o
>  	return bpf_dynptr_slice(ptr, offset, buffer, buffer__szk);
>  }
>  
> +__bpf_kfunc int bpf_dynptr_adjust(struct bpf_dynptr_kern *ptr, u32 start, u32 end)
> +{
> +	u32 size;
> +
> +	if (!ptr->data || start > end)
> +		return -EINVAL;
> +
> +	size = bpf_dynptr_get_size(ptr);
> +
> +	if (start > size || end > size)
> +		return -ERANGE;

maybe 'start >= size'? OTOH if the verifier doesn't mind I guess its OK
to create the thing even if it doesn't make much sense.

> +
> +	ptr->offset += start;
> +	bpf_dynptr_set_size(ptr, end - start);
> +
> +	return 0;
> +}
> +
>  __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
>  {
>  	return obj;
> @@ -2369,6 +2394,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_slice_rdwr, KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_num_new, KF_ITER_NEW)
>  BTF_ID_FLAGS(func, bpf_iter_num_next, KF_ITER_NEXT | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
> +BTF_ID_FLAGS(func, bpf_dynptr_adjust)
>  BTF_SET8_END(common_btf_ids)
>  
>  static const struct btf_kfunc_id_set common_kfunc_set = {
> -- 
> 2.34.1
> 
