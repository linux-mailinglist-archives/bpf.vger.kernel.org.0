Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D456EE3D1
	for <lists+bpf@lfdr.de>; Tue, 25 Apr 2023 16:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbjDYOUd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Apr 2023 10:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbjDYOUc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Apr 2023 10:20:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BFE1545B
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 07:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682432361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=thZWYLLZcDX55mVu1+A52YHxk2dw+nbxOfZf7i61JuY=;
        b=dyNe+EAg8Ubmgh2E7ILoV2Gw6iammy48P1hSgxwRV0vS84cDMPZZ6xwMo0KXs17BHY9V/y
        Cb2XBcAtBumK6eH61ovoz8kfaGs3McPYVbax3zHXwP8v8GxGQfObS1boCSJ3B4IHQC+Z0z
        A228HKEXHfFM9YW2vj0CEuBnMUUy0v8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-TX_53gUrMbOKuKNR0dG4iA-1; Tue, 25 Apr 2023 10:13:11 -0400
X-MC-Unique: TX_53gUrMbOKuKNR0dG4iA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f065208a64so33891525e9.3
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 07:13:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682431989; x=1685023989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thZWYLLZcDX55mVu1+A52YHxk2dw+nbxOfZf7i61JuY=;
        b=cu8WwfvslBvmywMyX+vNgS/t3qeGr9RxCO6d/gQMH8yZkTtPmIXENccjR2aTfOONfi
         +Fu3L/wy4TYNPKuNZ8gOVhf/8jssF2UBueSTjdHapz7SJKc63KZJV4RUceGDRsybR3Gt
         1gjrVv7TJYN1Knm4qCQT5yUjEUAGQPsydbmyCvjwCmvC4Mqz7CGc11z0ZcB0bDN/+H0F
         kIr2pfufO9YJmoYejShGKCI57FogcPStawTAPG903/DYYBt+ZVFgt9NB64m65mdT7iR1
         aXDlikF44uUeyphxx9mHTvYz09IMca0GpAKIwk0Q0MqEmMfG0wtXinWGSioXHQTBrr16
         nakA==
X-Gm-Message-State: AAQBX9fQ5MUWlYuGoV7THeM71n3QkFycGB+yo8uM4De2tMjkoolLTaKm
        ogkoiUlUHhHUK7driN/TRpssi4T3OfUKvC/4nIkNfuaW3uaOSsIr8xWLhC4EeOR/3yNwb6l+/ai
        /Xuq0Fqtywnbx
X-Received: by 2002:a1c:ed01:0:b0:3f1:7b8d:38ec with SMTP id l1-20020a1ced01000000b003f17b8d38ecmr10305874wmh.35.1682431989729;
        Tue, 25 Apr 2023 07:13:09 -0700 (PDT)
X-Google-Smtp-Source: AKy350bJGY+FZC43FdCJjTRL7XkjQU2DBR+cD6qqUiqenfVzDuWXgnT/+wvkpBSWPa/aO83OrDN9FA==
X-Received: by 2002:a1c:ed01:0:b0:3f1:7b8d:38ec with SMTP id l1-20020a1ced01000000b003f17b8d38ecmr10305856wmh.35.1682431989391;
        Tue, 25 Apr 2023 07:13:09 -0700 (PDT)
Received: from localhost (net-130-25-106-149.cust.vodafonedsl.it. [130.25.106.149])
        by smtp.gmail.com with ESMTPSA id c21-20020a7bc855000000b003f17300c7dcsm15023553wml.48.2023.04.25.07.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 07:13:08 -0700 (PDT)
Date:   Tue, 25 Apr 2023 16:13:07 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, hawk@kernel.org,
        john.fastabend@gmail.com, ast@kernel.org, daniel@iogearbox.net
Subject: Re: [PATCH v2 net-next 1/2] net: veth: add page_pool for page
 recycling
Message-ID: <ZEff8wJmZ3konvbV@lore-desk>
References: <cover.1682188837.git.lorenzo@kernel.org>
 <6298f73f7cc7391c7c4a52a6a89b1ae21488bda1.1682188837.git.lorenzo@kernel.org>
 <4f008243-49d0-77aa-0e7f-d20be3a68f3c@huawei.com>
 <ZEU+vospFdm08IeE@localhost.localdomain>
 <3c78f045-aa8e-22a5-4b38-ab271122a79e@huawei.com>
 <ZEZJHCRsBVQwd9ie@localhost.localdomain>
 <0c1790dc-dbeb-8664-64ca-1f71e6c4f3a9@huawei.com>
 <ZEZ/xXcOv9Co5Vif@boxer>
 <99890c72-eb61-e032-944a-6671d6494c23@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CadSs8zlJcx9K3kf"
Content-Disposition: inline
In-Reply-To: <99890c72-eb61-e032-944a-6671d6494c23@huawei.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--CadSs8zlJcx9K3kf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 2023/4/24 21:10, Maciej Fijalkowski wrote:
> >>> There was a discussion in the past to reduce XDP_PACKET_HEADROOM to 1=
92B but
> >>> this is not merged yet and it is not related to this series. We can a=
ddress
> >>> your comments in a follow-up patch when XDP_PACKET_HEADROOM series is=
 merged.
> >=20
> > Intel drivers still work just fine at 192 headroom and split the page b=
ut
> > it makes it problematic for BIG TCP where MAX_SKB_FRAGS from shinfo nee=
ds
>=20
> I am not sure why we are not enabling skb_shinfo(skb)->frag_list to suppo=
rt
> BIG TCP instead of increasing MAX_SKB_FRAGS, perhaps there was some dissc=
ution
> about this in the past I am not aware of?
>=20
> > to be increased. So it's the tailroom that becomes the bottleneck, not =
the
> > headroom. I believe at some point we will convert our drivers to page_p=
ool
> > with full 4k page dedicated for a single frame.
>=20
> Can we use header splitting to ensure there is enough tailroom for
> napi_build_skb() or xdp_frame with shinfo?
>=20

since veth_convert_skb_to_xdp_buff() runs in veth_poll() I think we can use
napi_build_skb(). I tested it and we get an improvement (9.65Gbps vs 9.2Gbps
for 1500B frames).

Regards,
Lorenzo

--CadSs8zlJcx9K3kf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZEff8gAKCRA6cBh0uS2t
rMbdAQD3WHQe/mjpUtHWLC7RlTGjjTZB2VrCKz6tldyN9wIguQEAsjoeLh830e8k
AGbqbbOerSm9+RznSSmS08hoTh5VLQ8=
=njoc
-----END PGP SIGNATURE-----

--CadSs8zlJcx9K3kf--

