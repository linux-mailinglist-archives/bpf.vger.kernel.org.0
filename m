Return-Path: <bpf+bounces-33607-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E419B9239CB
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 11:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FD8A28280E
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 09:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB441155308;
	Tue,  2 Jul 2024 09:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hw21mziT"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACBF152166
	for <bpf@vger.kernel.org>; Tue,  2 Jul 2024 09:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719912233; cv=none; b=ZEXRzx014Gig3k3VlHlp8iwfEmDRO/MZO1eZvpP8ToX5mAfinQZqy/E3ZNYMHfYgSOyWf9jjYZbP/r35Jhu44fuqFkONhV3tg4MobCv9FCq8NjJseWVWFCCXhIJ4foJYPZX6DYUqiGlc7yKwMBRq65kZlnY5qaEfXpfX94OhWgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719912233; c=relaxed/simple;
	bh=hDTH/MaA/ICnydS4TBySOg+LV4kE2oTgYGre9E1DOKU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M45UUaJ32edlF/zIQz7T04okB8xbSdygWfeB0r9KxqACjjdQmOG2QJJn7XECu+hIg5vT8VlXSurZVuI9/vdbWosfimIWcpWyoeD2zKZK8mrA0pCQ0EXct0dH94ILTfB+jSaReKzr5/oU7TB+TN7oZLFX3ZKsClPz1UdhZRuRPPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hw21mziT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719912230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UaPOuhsj6tCNLaZ5bjVrx34kvuXz5QnPcYyj6Z75iKc=;
	b=Hw21mziTXpQZmdfopuv1viScpqNAJF1rRjO+KuBMctrV/SvvOiUTHK05BgfKKDo2ev5hHm
	0STCH2kDMHudmzhqeCx8Us+Y+AECCdl4BnY+1sebhZ5BXWsyMco74B8QetIIuP6F+LrXvD
	nVQFs8yPtpbZXW7qf7v4ww0j4sxc3GA=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-zTbLFQALMcOxMor-o6NXvg-1; Tue, 02 Jul 2024 05:23:46 -0400
X-MC-Unique: zTbLFQALMcOxMor-o6NXvg-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-52cf484855bso811459e87.1
        for <bpf@vger.kernel.org>; Tue, 02 Jul 2024 02:23:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719912225; x=1720517025;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UaPOuhsj6tCNLaZ5bjVrx34kvuXz5QnPcYyj6Z75iKc=;
        b=o5BOFCX/Ih7k54qQLS88+FSoRz3qjtdOZJT/gqrT/+S0jTcFNcm0J2WN7UlNkf4cCi
         SJdhJNa0I9hrfAsnbzCl2P80O/xkfpB5cFn+lc9UeNt8XZ0YnpHnFMqGm73VIaXdhc6U
         a+IXWKfKe6yWMH7nVjiL4Q1XfG0alFstHq6PHJPkw/bsFH9SfzjBi6/xe+xVMkspvHCV
         mNzWj/1CFPb2V8+VdRXc50Wju4FWMtv5zf4YrJ/dci/UK1r2nzR/hgFMabdw1jSvZkNh
         cL6amh20tUNVMelJaESW3hcYerOVevQU6Ums1n1uXgP/SiXPZJ/lZgb16JLxQPpfwzMZ
         8rHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEj1R1lvGTW+GTgBW64sKs22FaQlO1n0BVCKuSzsTG9V1zBdcznLgl8j0rMLmE0/fDeIM92itf3LpinqDUBGJlOWsl
X-Gm-Message-State: AOJu0Yy8pLC7dYUdaSni5CFd02p28uxIiasI/RMElp09STbiGi8NqbwR
	Bhds7frL5/eCRKrB9p7cg7PnD4yItuWN4fRvvf0w1uB5RKUBzb5gVE+xBrAHK2bgwZvcfCyKHTZ
	mSvNOyxm0OpUHjvXHNnGFvUXdin3T8a0N/KkE+PZsYKBJDgozWA==
X-Received: by 2002:a05:6512:b95:b0:52c:6b51:2e9a with SMTP id 2adb3069b0e04-52e8267ee01mr5152905e87.2.1719912225313;
        Tue, 02 Jul 2024 02:23:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/du4/f+47zB9a3lFEQ3O0bJ+//0RPuS+OLhA6v4Apj6Wp+Iab+S1fhVhfRqiCRDSCiNBp8Q==
X-Received: by 2002:a05:6512:b95:b0:52c:6b51:2e9a with SMTP id 2adb3069b0e04-52e8267ee01mr5152865e87.2.1719912224818;
        Tue, 02 Jul 2024 02:23:44 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b0a6:6710:872d:b0f7:af0b:a62f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af5b61bsm191343975e9.17.2024.07.02.02.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 02:23:44 -0700 (PDT)
Message-ID: <fd44c91884d0ebf3625ac85a1049679a987f8f79.camel@redhat.com>
Subject: Re: [PATCH v2 1/2] net: Fix skb_segment when splitting gso_size
 mangled skb having linear-headed frag_list whose head_frag=true
From: Paolo Abeni <pabeni@redhat.com>
To: Fred Li <dracodingfly@gmail.com>, davem@davemloft.net,
 edumazet@google.com,  kuba@kernel.org, aleksander.lobakin@intel.com,
 sashal@kernel.org,  linux@weissschuh.net, hawk@kernel.org, nbd@nbd.name,
 mkhalfella@purestorage.com,  ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev,  song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com,  kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Date: Tue, 02 Jul 2024 11:23:41 +0200
In-Reply-To: <20240626065555.35460-2-dracodingfly@gmail.com>
References: <20240626065555.35460-1-dracodingfly@gmail.com>
	 <20240626065555.35460-2-dracodingfly@gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-06-26 at 14:55 +0800, Fred Li wrote:
> When using calico bpf based NAT, hits a kernel BUG_ON at function
> skb_segment(), line 4560. Performing NAT translation when accessing
> a Service IP across subnets, the calico will encap vxlan and calls the
> bpf_skb_adjust_room to decrease the gso_size, and then call bpf_redirect
> send packets out.
>=20
> 4438 struct sk_buff *skb_segment(struct sk_buff *head_skb,
> 4439                             netdev_features_t features)
> 4440 {
> 4441     struct sk_buff *segs =3D NULL;
> 4442     struct sk_buff *tail =3D NULL;
> ...
> 4558         if (hsize <=3D 0 && i >=3D nfrags && skb_headlen(list_skb) &=
&
> 4559             (skb_headlen(list_skb) =3D=3D len || sg)) {
> 4560                 BUG_ON(skb_headlen(list_skb) > len);
> 4561
> 4562                 nskb =3D skb_clone(list_skb, GFP_ATOMIC);
> 4563                 if (unlikely(!nskb))
> 4564                     goto err;
>=20
> call stack:
> ...
>    [exception RIP: skb_segment+3016]
>     RIP: ffffffffb97df2a8  RSP: ffffa3f2cce08728  RFLAGS: 00010293
>     RAX: 000000000000007d  RBX: 00000000fffff7b3  RCX: 0000000000000011
>     RDX: 0000000000000000  RSI: ffff895ea32c76c0  RDI: 00000000000008c1
>     RBP: ffffa3f2cce087f8   R8: 000000000000088f   R9: 0000000000000011
>     R10: 000000000000090c  R11: ffff895e47e68000  R12: ffff895eb2022f00
>     R13: 000000000000004b  R14: ffff895ecdaf2000  R15: ffff895eb2023f00
>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>  #9 [ffffa3f2cce08720] skb_segment at ffffffffb97ded63
> ...
>=20
> The skb has the following properties:
>     doffset =3D 66
>     list_skb =3D skb_shinfo(skb)->frag_list
>     list_skb->head_frag =3D true
>     skb->len =3D 2441 && skb->data_len =3D 2250
>     skb_shinfo(skb)->nr_frags =3D 17
>     skb_shinfo(skb)->gso_size =3D 75
>     skb_shinfo(skb)->frags[0...16].bv_len =3D 125
>     list_skb->len =3D 125
>     list_skb->data_len =3D 0
>=20
> When slicing the frag_list skb, there three cases:
> 1. Only *non* head_frag
>     sg will be false, only when skb_headlen(list_skb)=3D=3Dlen is satisfi=
ed,
>     it will enter the branch at line 4560, and there will be no crash.
> 2. Mixed head_frag
>     sg will be false, Only when skb_headlen(list_skb)=3D=3Dlen is satisfi=
ed,
>     it will enter the branch at line 4560, and there will be no crash.
> 3. Only frag_list with head_frag=3Dtrue
>     sg is true, three cases below:
>     (1) skb_headlen(list_skb)=3D=3Dlen is satisfied, it will enter the br=
anch
>        at line 4560, and there will be no crash.
>     (2) skb_headlen(list_skb)<len is satisfied, it will enter the branch
>        at line 4560, and there will be no crash.
>     (3) skb_headlen(list_skb)>len is satisfied, it will be crash.
>=20
> Applying this patch, three cases will be:
> 1. Only *non* head_frag
>     sg will be false. No difference with before.
> 2. Mixed head_frag
>     sg will be false. No difference with before.
> 3. Only frag_list with head_frag=3Dtrue
>     sg is true, there also three cases:
>     (1) skb_headlen(list_skb)=3D=3Dlen is satisfied, no difference with b=
efore.
>     (2) skb_headlen(list_skb)<len is satisfied, will be revert to copying
>         in this case.
>     (3) skb_headlen(list_skb)>len is satisfied, will be revert to copying
>         in this case.
>=20
> Since commit 13acc94eff122("net: permit skb_segment on head_frag frag_lis=
t
> skb"), it is allowed to segment the head_frag frag_list skb.
>=20
> Signed-off-by: Fred Li <dracodingfly@gmail.com>
> ---
>  net/core/skbuff.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index f0a9ef1aeaa2..b1dab1b071fc 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -4556,7 +4556,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_sk=
b,
>  		hsize =3D skb_headlen(head_skb) - offset;
> =20
>  		if (hsize <=3D 0 && i >=3D nfrags && skb_headlen(list_skb) &&
> -		    (skb_headlen(list_skb) =3D=3D len || sg)) {
> +		    (skb_headlen(list_skb) =3D=3D len)) {
>  			BUG_ON(skb_headlen(list_skb) > len);
> =20
>  			nskb =3D skb_clone(list_skb, GFP_ATOMIC);

I must admit I more than a bit lost in the many turns of skb_segment(),
but the above does not look like the correct solution, as it will make
the later BUG_ON() unreachable/meaningless.

Do I read correctly that when the BUG_ON() triggers:

list_skb->len is 125
len is 75
list_skb->frag_head is true

It looks like skb_segment() is becoming even and ever more complex to
cope with unexpected skb layouts, only possibly when skb_segment() is
called by some BPF helpers.

I think it should be up to the helper itself to adjust the skb and/or
the device features to respect skb_segment() constraints, instead of
making the common code increasingly not maintainable.

Thanks,

Paolo


