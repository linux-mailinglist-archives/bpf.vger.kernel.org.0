Return-Path: <bpf+bounces-2811-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 854FB7344F2
	for <lists+bpf@lfdr.de>; Sun, 18 Jun 2023 07:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 715322812D4
	for <lists+bpf@lfdr.de>; Sun, 18 Jun 2023 05:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB9910F9;
	Sun, 18 Jun 2023 05:07:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25989A23
	for <bpf@vger.kernel.org>; Sun, 18 Jun 2023 05:07:07 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E495E137;
	Sat, 17 Jun 2023 22:07:05 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3111547c8f9so2353323f8f.1;
        Sat, 17 Jun 2023 22:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687064824; x=1689656824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+qqsqpcmp1BNuckvDBNutT1wsju4zMnJ/FPnqSF/3I=;
        b=lalI1AI7uebE7hPNOhbKNNQC24Lh5BL1X/SgQMnMTwRk+fvPSCcVn0KajZnibVQX+a
         QzoW9DNa2quSr6CQiYd9M9vcaTiKmcMUToe7KmIBRdux7BBFdr8tQ5dWM/40KJCxQrqn
         P8dKrQkQzZKCrEqAuoKBglwhZ7BBGvRsmZ0x+lXytN98bc/QKCG/tzckuHudZqbmi1fI
         Lgqm/Hbsiigmhmk/tgNTT3n4htYQQUWJFLhaiG2qm2SmjlBzsGAfhBsUVgxjpvQG4xP+
         kJMyJQzzbCDEVVYQEUxumz1+t/Fu74q61/ePHBwaSh9krXhswGKFSfXaOGOBssBY1puc
         G/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687064824; x=1689656824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+qqsqpcmp1BNuckvDBNutT1wsju4zMnJ/FPnqSF/3I=;
        b=kuFbwDzbTjmW9EXsr3/t3LgTnmGrGh1kOj7GbGDji5mh1gcW2g5Q64Lw2upXm6BcoL
         1g5v14suILLqV7eS/Ew9jYJNIBIuW0cDwLHpf4Gg3AOzkbYqqSEd101SZiGtr+YHCdiY
         WPwq07+rbBPj8rzSbazGZCTGigHZAVzWyHgcwN3OAAGfLNCX/dlczRS5fPfzwcK28Fbv
         CcoAAr3Lq2Pzh2Dul3E/SdCzoGLJRRX0pdz32JpTMd86omh1F1n3Wvo+EPEcRc8KGgks
         x9YZgLZWQyUW5Guqm6LWeC8HRXm9623c4nwi6ebw3Kud5Ybrkej13O69l2x7wVrLdq0m
         7WqA==
X-Gm-Message-State: AC+VfDwHoX4T/UKqQ3+o3FKxa/HAVm7QDJIj1uJtXSKXQe5Yq6A37YY3
	/LzFz7Ccsl7Ogg117fWckZpw8mZvjxg=
X-Google-Smtp-Source: ACHHUZ4XBWvxBlkNE5O4VAGreNupZntG7t9PNSr3dj/W2txjWoJ2+sUq4ds23q6UJFj0qQpWMLYGEw==
X-Received: by 2002:adf:db47:0:b0:30f:c6c3:e6d9 with SMTP id f7-20020adfdb47000000b0030fc6c3e6d9mr5011298wrj.46.1687064824120;
        Sat, 17 Jun 2023 22:07:04 -0700 (PDT)
Received: from suse.localnet (host-79-26-32-1.retail.telecomitalia.it. [79.26.32.1])
        by smtp.gmail.com with ESMTPSA id e8-20020adff348000000b00304adbeeabbsm27943038wrp.99.2023.06.17.22.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 22:07:03 -0700 (PDT)
From: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sumitra Sharma <sumitraartsy@gmail.com>
Cc: Ira Weiny <ira.weiny@intel.com>, Deepak R Varma <drv@mailo.com>
Subject:
 Re: [PATCH v2] lib/test_bpf: Call page_address() on page acquired with
 GFP_KERNEL flag
Date: Sun, 18 Jun 2023 07:07:00 +0200
Message-ID: <3564297.R56niFO833@suse>
In-Reply-To: <20230613071756.GA359746@sumitra.com>
References: <20230613071756.GA359746@sumitra.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On marted=EC 13 giugno 2023 09:17:56 CEST Sumitra Sharma wrote:
> generate_test_data() acquires a page with alloc_page(GFP_KERNEL). Pages
> allocated with GFP_KERNEL cannot come from Highmem. This is why
> there is no need to call kmap() on them.
>=20
> Therefore, use a plain page_address() on that page.
>=20
> Suggested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
> ---
>=20
> Changes in v2:
> 	- Remove the kmap() call and call page_address() instead.

NIT: Give credit to whom asked you for this removal and explain why the=20
mapping is not required.

> 	- Change the commit subject and message.
>=20
>  lib/test_bpf.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/lib/test_bpf.c b/lib/test_bpf.c
> index ade9ac672adb..70fcd0bcf14b 100644
> --- a/lib/test_bpf.c
> +++ b/lib/test_bpf.c
> @@ -14388,11 +14388,10 @@ static void *generate_test_data(struct bpf_test
> *test, int sub) if (!page)
>  			goto err_kfree_skb;
>=20
> -		ptr =3D kmap(page);
> +		ptr =3D page_address(page);
>  		if (!ptr)
>  			goto err_free_page;

What is the reason of this test? Could "ptr" ever be NULL? What is the code=
=20
checking just few lines above this latter test?

Please, take a deeper look at this function as a whole.

=46abio

>  		memcpy(ptr, test->frag_data, MAX_DATA);
> -		kunmap(page);
>  		skb_add_rx_frag(skb, 0, page, 0, MAX_DATA, MAX_DATA);
>  	}
>=20
> --
> 2.25.1





