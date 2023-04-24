Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B213C6ED05B
	for <lists+bpf@lfdr.de>; Mon, 24 Apr 2023 16:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbjDXObM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Apr 2023 10:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjDXObJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Apr 2023 10:31:09 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA50846A4
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 07:31:08 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f1763ee8f8so30356015e9.1
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 07:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682346667; x=1684938667;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eM+gPn+/fObYiSeXczvQ+BwbjKrL1hckl0Wkk8JoDVA=;
        b=Cyb1SwiSN8KB54bFy6iuSw+IStl/PWCN+uEm7UFje7KFF+i4cm7hu+SfNEc/jFiHNo
         2Er7K536y6xGRcwImM1Ae/YK0uJ+ue9k7rLUgg8e2tnDp0esSjidtg5Qz1OifGi6YG2B
         2AO1s2cOasSHF/zB3Zm3DHYlkY+wOyq7cco1CV9szrY6/hd3HXEfHlrPlm+BUlre97gt
         GJVzb/8d/L/EYbsgo8xdZjygqPw/fsK3WRsymHfWGT//8Ndg/Pv8dgCYH6ktqZfe1R1m
         e22FAROxyhDiFzsQ9ccP+4vpHr4gxNGIJSn4SAaSzYuwRG2Krw+oFOHR8XFrGxp/Qkkl
         Kv0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682346667; x=1684938667;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eM+gPn+/fObYiSeXczvQ+BwbjKrL1hckl0Wkk8JoDVA=;
        b=CV4w16D31TgTUrLJaAJYWXCp2Ecii9lfhlfzI7H8uZZznJA0gK9XYxL9GaiuH/UV3q
         a13d7QKHHhI9+64u0uk3phhUWfAfS48XuQQI6NhUmCyJWU/YOYu3YJKXbkehyDPRuraM
         yQCtJBpglQyG8C8bkb+0U6/sktFr8QhBvjWEBNSlR62ER/HXdF0O59pDYnaYTqFUs8WR
         BCKX/pDjjNXXzAvL+Q9UCTYgK6fnxTJy1LJE4LAfUXheiMb9Sm8UBU5YU1jM322V5tP7
         D/P+kSvJn6olF2C3JNwnziv8bdF1IPJ6F8NUMIojx5DmNMpT5268nJLlgyJrqK9CKxHI
         xb7A==
X-Gm-Message-State: AAQBX9evBuAVqArtxPY3uI44zNAxhb4YZZzU1zhpbh6OxQAjV0oDXQk8
        +iTaT/XDlby+3HNFHnSYiRU=
X-Google-Smtp-Source: AKy350aGd0mrjFpotRb8DxAcb7zf7GOURa1niXkimXwHCV+gPWXvpG8KBz+8V5YR0+y3KuPSwXzMGw==
X-Received: by 2002:a7b:cb96:0:b0:3eb:39e2:915b with SMTP id m22-20020a7bcb96000000b003eb39e2915bmr7797463wmi.31.1682346666995;
        Mon, 24 Apr 2023 07:31:06 -0700 (PDT)
Received: from [192.168.1.95] (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id g9-20020a05600c000900b003f0aa490336sm15609945wmc.26.2023.04.24.07.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 07:31:06 -0700 (PDT)
Message-ID: <5882dfa8dd1d04a3161151a63f368a7dbc5fad50.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/5] bpf: Add bpf_dynptr_adjust
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Joanne Koong <joannelkoong@gmail.com>, bpf@vger.kernel.org
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net
Date:   Mon, 24 Apr 2023 17:31:03 +0300
In-Reply-To: <20230420071414.570108-2-joannelkoong@gmail.com>
References: <20230420071414.570108-1-joannelkoong@gmail.com>
         <20230420071414.570108-2-joannelkoong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2023-04-20 at 00:14 -0700, Joanne Koong wrote:
> Add a new kfunc
>=20
> int bpf_dynptr_adjust(struct bpf_dynptr_kern *ptr, u32 start, u32 end);
>=20
> which adjusts the dynptr to reflect the new [start, end) interval.
> In particular, it advances the offset of the dynptr by "start" bytes,
> and if end is less than the size of the dynptr, then this will trim the
> dynptr accordingly.
>=20
> Adjusting the dynptr interval may be useful in certain situations.
> For example, when hashing which takes in generic dynptrs, if the dynptr
> points to a struct but only a certain memory region inside the struct
> should be hashed, adjust can be used to narrow in on the
> specific region to hash.
>=20
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  kernel/bpf/helpers.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>=20
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 00e5fb0682ac..7ddf63ac93ce 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1448,6 +1448,13 @@ u32 bpf_dynptr_get_size(const struct bpf_dynptr_ke=
rn *ptr)
>  	return ptr->size & DYNPTR_SIZE_MASK;
>  }
> =20
> +static void bpf_dynptr_set_size(struct bpf_dynptr_kern *ptr, u32 new_siz=
e)
> +{
> +	u32 metadata =3D ptr->size & ~DYNPTR_SIZE_MASK;
> +
> +	ptr->size =3D new_size | metadata;
> +}
> +
>  int bpf_dynptr_check_size(u32 size)
>  {
>  	return size > DYNPTR_MAX_SIZE ? -E2BIG : 0;
> @@ -2297,6 +2304,24 @@ __bpf_kfunc void *bpf_dynptr_slice_rdwr(const stru=
ct bpf_dynptr_kern *ptr, u32 o
>  	return bpf_dynptr_slice(ptr, offset, buffer, buffer__szk);
>  }
> =20
> +__bpf_kfunc int bpf_dynptr_adjust(struct bpf_dynptr_kern *ptr, u32 start=
, u32 end)
> +{
> +	u32 size;
> +
> +	if (!ptr->data || start > end)
> +		return -EINVAL;
> +
> +	size =3D bpf_dynptr_get_size(ptr);
> +
> +	if (start > size || end > size)
> +		return -ERANGE;

If new size is computed as "end - start" should
the check above be "end >=3D size"?

> +
> +	ptr->offset +=3D start;
> +	bpf_dynptr_set_size(ptr, end - start);
> +
> +	return 0;
> +}
> +
>  __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
>  {
>  	return obj;
> @@ -2369,6 +2394,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_slice_rdwr, KF_RET_NU=
LL)
>  BTF_ID_FLAGS(func, bpf_iter_num_new, KF_ITER_NEW)
>  BTF_ID_FLAGS(func, bpf_iter_num_next, KF_ITER_NEXT | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
> +BTF_ID_FLAGS(func, bpf_dynptr_adjust)
>  BTF_SET8_END(common_btf_ids)
> =20
>  static const struct btf_kfunc_id_set common_kfunc_set =3D {

