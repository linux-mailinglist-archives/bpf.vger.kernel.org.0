Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607D66ED061
	for <lists+bpf@lfdr.de>; Mon, 24 Apr 2023 16:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbjDXOeC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Apr 2023 10:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjDXOeB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Apr 2023 10:34:01 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84A865AA
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 07:33:59 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f1cfed93e2so16936995e9.3
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 07:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682346838; x=1684938838;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t/uWLXzzWb2zLgq8embzO94uCaCQ0nwEQSqR7jQD8iQ=;
        b=JiZcNWpJCNNJewX9BZxo72cxQexiHPChEvcsYjMBfntVUDr08kEPwZHROQBHC6zueC
         wxf8ePiNb6ImLfJltmsrBB1bq2O3SMTfeb0hlUboJCq23aIdlqbNAoJ1vmOhNUPPzfUP
         P/C+8eae7Owatr55EgjhYtGC5Gz79TU2RYVC6OQp9LNseWw9wHmHx2otxrMebv/QzwAk
         4+O6cCcKTxExqeOr5a5NLji32LR3NZm82YGtVqboTnQcZaiRhGKUeccVeZwYFvob/jwF
         sACBlgzlzjbjseGfJ+wa+ESJhQDokUlkCP1FBmrQqZEubgaswYfo7UrVcZ1PDb3lQvn2
         8xyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682346838; x=1684938838;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t/uWLXzzWb2zLgq8embzO94uCaCQ0nwEQSqR7jQD8iQ=;
        b=DrInveWRPqxVsRedWYYl3iEVZVASbnnWdY2fdzKpev2o40RXBplBL6B/RcrQLnuhYK
         eI8AgZtnlH+vpj0Md9XwZNKCTxpquQOV6Q06V4IMc8Xjh5B0pSnQQmEGQO7Om/x22sTS
         eubqFSHGzuyDMmGUl7uuFyjn/oCe6Zgno4K7F+4uN5HPDtzDob0FFfmPyJwYa7WN3Y3e
         sW4asG7GP7wyLSRJweMMxfeuxc28GpYUmkGkUwhpYDuWhSD0kM1kBQSwK7+HVgLSFVS5
         SGleT5ZUN2N3Wpkr5qmZ0v7lUCP1uG60zXjtGl+ICoIpglh6bDGSgg6GJAaim2eBPQDU
         fdPg==
X-Gm-Message-State: AAQBX9fS4AQwKee16ju9sh6CVEeZX0VPblwdeeaYK+LWpeGjoWB5iR7g
        0gPsVDYk6NJ+tttgyO8pD3k=
X-Google-Smtp-Source: AKy350awPPtHfxacPB1MC276NrPhxP5tXDm/Y1fbSPyclnPNjR5u1CqfMEKj0KueGykVq22+/p8zhw==
X-Received: by 2002:a1c:7714:0:b0:3f1:7277:ea6 with SMTP id t20-20020a1c7714000000b003f172770ea6mr7783880wmi.31.1682346838113;
        Mon, 24 Apr 2023 07:33:58 -0700 (PDT)
Received: from [192.168.1.95] (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id z16-20020a05600c221000b003ee1b2ab9a0sm12336380wml.11.2023.04.24.07.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 07:33:57 -0700 (PDT)
Message-ID: <c0bbdf9cc90368b6b5c024e8654c7fe94c95964a.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/5] bpf: Add bpf_dynptr_adjust
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Joanne Koong <joannelkoong@gmail.com>, bpf@vger.kernel.org
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net
Date:   Mon, 24 Apr 2023 17:33:56 +0300
In-Reply-To: <5882dfa8dd1d04a3161151a63f368a7dbc5fad50.camel@gmail.com>
References: <20230420071414.570108-1-joannelkoong@gmail.com>
         <20230420071414.570108-2-joannelkoong@gmail.com>
         <5882dfa8dd1d04a3161151a63f368a7dbc5fad50.camel@gmail.com>
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

On Mon, 2023-04-24 at 17:31 +0300, Eduard Zingerman wrote:
> On Thu, 2023-04-20 at 00:14 -0700, Joanne Koong wrote:
> > Add a new kfunc
> >=20
> > int bpf_dynptr_adjust(struct bpf_dynptr_kern *ptr, u32 start, u32 end);
> >=20
> > which adjusts the dynptr to reflect the new [start, end) interval.
> > In particular, it advances the offset of the dynptr by "start" bytes,
> > and if end is less than the size of the dynptr, then this will trim the
> > dynptr accordingly.
> >=20
> > Adjusting the dynptr interval may be useful in certain situations.
> > For example, when hashing which takes in generic dynptrs, if the dynptr
> > points to a struct but only a certain memory region inside the struct
> > should be hashed, adjust can be used to narrow in on the
> > specific region to hash.
> >=20
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  kernel/bpf/helpers.c | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >=20
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 00e5fb0682ac..7ddf63ac93ce 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -1448,6 +1448,13 @@ u32 bpf_dynptr_get_size(const struct bpf_dynptr_=
kern *ptr)
> >  	return ptr->size & DYNPTR_SIZE_MASK;
> >  }
> > =20
> > +static void bpf_dynptr_set_size(struct bpf_dynptr_kern *ptr, u32 new_s=
ize)
> > +{
> > +	u32 metadata =3D ptr->size & ~DYNPTR_SIZE_MASK;
> > +
> > +	ptr->size =3D new_size | metadata;
> > +}
> > +
> >  int bpf_dynptr_check_size(u32 size)
> >  {
> >  	return size > DYNPTR_MAX_SIZE ? -E2BIG : 0;
> > @@ -2297,6 +2304,24 @@ __bpf_kfunc void *bpf_dynptr_slice_rdwr(const st=
ruct bpf_dynptr_kern *ptr, u32 o
> >  	return bpf_dynptr_slice(ptr, offset, buffer, buffer__szk);
> >  }
> > =20
> > +__bpf_kfunc int bpf_dynptr_adjust(struct bpf_dynptr_kern *ptr, u32 sta=
rt, u32 end)
> > +{
> > +	u32 size;
> > +
> > +	if (!ptr->data || start > end)
> > +		return -EINVAL;
> > +
> > +	size =3D bpf_dynptr_get_size(ptr);
> > +
> > +	if (start > size || end > size)
> > +		return -ERANGE;
>=20
> If new size is computed as "end - start" should
> the check above be "end >=3D size"?

Please ignore this comment, I got confused.

>=20
> > +
> > +	ptr->offset +=3D start;
> > +	bpf_dynptr_set_size(ptr, end - start);
> > +
> > +	return 0;
> > +}
> > +
> >  __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
> >  {
> >  	return obj;
> > @@ -2369,6 +2394,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_slice_rdwr, KF_RET_=
NULL)
> >  BTF_ID_FLAGS(func, bpf_iter_num_new, KF_ITER_NEW)
> >  BTF_ID_FLAGS(func, bpf_iter_num_next, KF_ITER_NEXT | KF_RET_NULL)
> >  BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
> > +BTF_ID_FLAGS(func, bpf_dynptr_adjust)
> >  BTF_SET8_END(common_btf_ids)
> > =20
> >  static const struct btf_kfunc_id_set common_kfunc_set =3D {
>=20

