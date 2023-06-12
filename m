Return-Path: <bpf+bounces-2386-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E2E72C36E
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 13:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 580E52810D7
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 11:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B99A18C35;
	Mon, 12 Jun 2023 11:50:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9C4168B0
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 11:50:23 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3592E4C3B;
	Mon, 12 Jun 2023 04:50:01 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-30fa23e106bso1817617f8f.3;
        Mon, 12 Jun 2023 04:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686570599; x=1689162599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/J8UNpFRKb+vdSdTYK+cVatgKOvNZz8OPhwwJZ4scw=;
        b=MC+q+musMttbXHmCDlg7+dcGRW7ew4bANWVV4tfHOnCO6rqi9oyJleaw8JgiV+Y8nL
         U3fY9mLDZUlGF8/uc2DakN//J3RYExrpwNWx9sYnLS9QQjMfiCdLx9n9A/B9Pjpx6IeK
         4N2fyNjly7ijtA3K4zY3aa5RxfE/PD9ck3QRhQyx1YbFJgAbeOm8Bl5wgwe6KgviVypd
         5lmgE1Idg5RBidEE9Dm1JAbVV1G94xiahyVLTV+ZSHEN36zpSx7Hlw9BQACzmOuGYZdr
         FcXsBlE4Rebk4T4s8llORZXvSQp6id0yCbUAIDBcU7KK2FrBcZOGUyFfEG828Le8SboN
         w9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686570599; x=1689162599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P/J8UNpFRKb+vdSdTYK+cVatgKOvNZz8OPhwwJZ4scw=;
        b=A0b2vcirYAqzbD6XMmwx6EwiYZ/wWvjZyhPXFqRFTqbEJQPCnAPNUyXzmrtGYZFP2J
         GfAsUKt7z945ixsFvQbj4+l7U7VhHKk7r2l7B5F+BFrsZCJE+3BvgP1mdXyaEC4qkgWS
         QFWfIYczZulEFU7b4YAuWl1AcyM+rQBNrQ5QNQsGZ+nI6Vzk4nZn2eTob+pBm9Cojwkx
         S1ERISsQXSkcPMDNNfvutmg4cULre/YKJRpxEiujrHE2PYy7itQiF2Jvxn8oU+7YiXp4
         BJw/kXwmnnNzniwn+Vg/1S4i78ZIGGfKTDAmGlysog/e6RyJTwzLXkTPux/QMWIuxFIC
         kDGA==
X-Gm-Message-State: AC+VfDzqXfJvbdsrKnlZtBlkXP1X4UDUugk9rglI6RhzjoFZGfOBcLyf
	xRoTeazxCu3kXx9Qo3/S4gA=
X-Google-Smtp-Source: ACHHUZ6VBcR+Ty7Mom1NSdu1wR1KVDWU+jaNtLkh5kLigcwkBrq4J0vbehItCLSFNr2av/Bn1wrkFQ==
X-Received: by 2002:adf:f087:0:b0:306:2d15:fc35 with SMTP id n7-20020adff087000000b003062d15fc35mr3519788wro.37.1686570599279;
        Mon, 12 Jun 2023 04:49:59 -0700 (PDT)
Received: from suse.localnet (host-95-252-166-216.retail.telecomitalia.it. [95.252.166.216])
        by smtp.gmail.com with ESMTPSA id a9-20020a5d5089000000b0030ae973c2e7sm12239136wrt.83.2023.06.12.04.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 04:49:58 -0700 (PDT)
From: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To: Sumitra Sharma <sumitraartsy@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ira Weiny <ira.weiny@intel.com>, Deepak R Varma <drv@mailo.com>
Subject: Re: [PATCH] lib/test_bpf: Replace kmap() with kmap_local_page()
Date: Mon, 12 Jun 2023 13:49:56 +0200
Message-ID: <3744835.kQq0lBPeGt@suse>
In-Reply-To: <20230612103341.GA354790@sumitra.com>
References: <20230612103341.GA354790@sumitra.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On luned=C3=AC 12 giugno 2023 12:33:41 CEST Sumitra Sharma wrote:
> kmap() has been deprecated in favor of the kmap_local_page()
> due to high cost, restricted mapping space, the overhead of
> a global lock for synchronization, and making the process
> sleep in the absence of free slots.
>=20
> kmap_local_page() is faster than kmap() and offers thread-local
> and CPU-local mappings, take pagefaults in a local kmap region
> and preserves preemption by saving the mappings of outgoing
> tasks and restoring those of the incoming one during a context
> switch.
>=20
> The mapping is kept thread local in the function
> =E2=80=9Cgenerate_test_data=E2=80=9D in test_bpf.c
>=20
> Therefore, replace kmap() with kmap_local_page() and use
> memcpy_to_page() to avoid open coding kmap_local_page()
> + memcpy() + kunmap_local().
>=20
> Remove the unused variable =E2=80=9Cptr=E2=80=9D.

Sumitra,

Please Cc your mentors while in the internship.
It's not mandatory but it would expedite comments and reviews :-)

>=20
> Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
> ---
>  lib/test_bpf.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
>=20
> diff --git a/lib/test_bpf.c b/lib/test_bpf.c
> index ade9ac672adb..3bb94727d83b 100644
> --- a/lib/test_bpf.c
> +++ b/lib/test_bpf.c
> @@ -14381,25 +14381,17 @@ static void *generate_test_data(struct bpf_test
> *test, int sub) * single fragment to the skb, filled with
>  		 * test->frag_data.
>  		 */
> -		void *ptr;
> -
>  		page =3D alloc_page(GFP_KERNEL);
>=20
>  		if (!page)
>  			goto err_kfree_skb;
>=20
> -		ptr =3D kmap(page);
> -		if (!ptr)
> -			goto err_free_page;
> -		memcpy(ptr, test->frag_data, MAX_DATA);
> -		kunmap(page);
> +		memcpy_to_page(page, 0, test->frag_data, MAX_DATA);

Why are you temporary mapping a page allocated with the GFP_KERNEL flag?=20
It cannot come from ZONE_HIGHMEM.=20

=46abio

>  		skb_add_rx_frag(skb, 0, page, 0, MAX_DATA, MAX_DATA);
>  	}
>=20
>  	return skb;
>=20
> -err_free_page:
> -	__free_page(page);
>  err_kfree_skb:
>  	kfree_skb(skb);
>  	return NULL;
> --
> 2.25.1




