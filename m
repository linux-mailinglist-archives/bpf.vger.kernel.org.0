Return-Path: <bpf+bounces-3438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 574C573E032
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 15:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11BE9280D3A
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 13:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E478F70;
	Mon, 26 Jun 2023 13:07:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0908C1C
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 13:07:29 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA3210D;
	Mon, 26 Jun 2023 06:07:28 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fa8692a006so24213405e9.3;
        Mon, 26 Jun 2023 06:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687784846; x=1690376846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2AygcecPtn2LrwTAFghsbuSyei/AofSmSKKBMyrpNk=;
        b=dfjTTHqIPsYowz1YtzqV8uTL0zNrBLVlTpmXbF2oDmf0tyJEAf4bqCbyK/sACThn0K
         5r+iqvwdoghTWQ0B/cu7IKp/2Z11Q8KiM2avtTJRTHYkw7xHHK483jie61ymLtEo+Ki0
         1dMZoDnL8M1i14YjI6RFia+4cK9rbduD8STErSztM9cgmaQai2OhybwBkobvezIu6qwg
         oVYu7O4R/eQ2n24XW1tBiTXBj1te+ITGB6J2KNfr/UMHnjvKHbsqNdFb6mEHN2CokaI7
         YCKrCGmOzcEfBC5E2EK9iwAKK3gHMS/I0gkvBmPN8U3BozsXj7kA53kZviiEIYdD2McK
         TBYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687784846; x=1690376846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N2AygcecPtn2LrwTAFghsbuSyei/AofSmSKKBMyrpNk=;
        b=c5/iehqDPcMnSCz5Ivnq9+FRSLfhe11onHWNfMsFnw5hoyC9YVWE9adUQllIjukdmm
         3q+pxJCJdr/svnD8DvsaYQwUy6R5NSF36X6MTJWuSah3Begqjyqs2xK/2cbTRjAu2hsJ
         NulXmQbA3qgLW26TmO4/LS8Y3KP4OwSKjGKDBxoJqXqDyoq1hfAatn09Jvfda2uTiEmo
         pSY73r80FGtAkPiPhRVFvSsfLMIWU0C/9fnMShYcva5pUrng/ctPftgCBlBIimJ33o+a
         5YBwqrZ/UDBsZd8eRDRMdHnLivXLwx/H90icEmzcHKDNGps1GNgBPLf5/FI6SPLDNZYe
         thiQ==
X-Gm-Message-State: AC+VfDxj8qGrPeSbOdCuPyGq6+fxxCEQIptsFN9uCSVsk/uY9GRximSJ
	hnxHxg4PnwuQtuEHKpXPuJT2VK6oEbc=
X-Google-Smtp-Source: ACHHUZ5YNkYCJJUBeg29BkC3m2kmUDS+U6gVhk6E3OMqWsH2NcwEpdnuXYmLCfY0RFUU3aLtZWKdnA==
X-Received: by 2002:a05:600c:2152:b0:3f9:a6f3:8a53 with SMTP id v18-20020a05600c215200b003f9a6f38a53mr18390284wml.20.1687784845540;
        Mon, 26 Jun 2023 06:07:25 -0700 (PDT)
Received: from suse.localnet (host-79-17-50-162.retail.telecomitalia.it. [79.17.50.162])
        by smtp.gmail.com with ESMTPSA id 4-20020a05600c228400b003f7e4d143cfsm7622409wmf.15.2023.06.26.06.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 06:07:24 -0700 (PDT)
From: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sumitra Sharma <sumitraartsy@gmail.com>
Cc: Ira Weiny <ira.weiny@intel.com>, Deepak R Varma <drv@mailo.com>,
 Sumitra Sharma <sumitraartsy@gmail.com>
Subject:
 Re: [PATCH v4] lib/test_bpf: Call page_address() on page acquired with
 GFP_KERNEL flag
Date: Mon, 26 Jun 2023 15:07:22 +0200
Message-ID: <5846758.MhkbZ0Pkbq@suse>
In-Reply-To: <20230623151644.GA434468@sumitra.com>
References: <20230623151644.GA434468@sumitra.com>
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

On venerd=EC 23 giugno 2023 17:16:44 CEST Sumitra Sharma wrote:
> generate_test_data() acquires a page with alloc_page(GFP_KERNEL).
> The GFP_KERNEL is typical for kernel-internal allocations.
> The caller requires ZONE_NORMAL or a lower zone for direct access.
>=20
> Therefore the page cannot come from ZONE_HIGHMEM. Thus there's
> no need to map it with kmap().
>=20
> Also, the kmap() is being deprecated in favor of kmap_local_page() [1].
>=20
> Hence, use a plain page_address() directly.
>=20
> Since the page passed to the page_address() is not from the highmem
> zone, the page_address() function will always return a valid kernel
> virtual address and will not return NULL. Hence, remove the check
> 'if (!ptr)'.
>=20
> Remove the unused variable 'ptr' and label 'err_free_page'.
>=20
> [1]: https://lore.kernel.org/all/20220813220034.806698-1-ira.weiny@intel.=
com/
>=20
> Suggested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

I can't see no more things that prevent my tag, then it is...

Reviewed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Thanks for working on it for all the time it took to get to v4 and for=20
listening to what you've been suggested to change.

Well done :-)

=46abio

> Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
> ---
>=20
> - Link to v1:
> https://lore.kernel.org/bpf/20230613073020.GA359792@sumitra.com/T/ - Link=
 to
> v2: https://lore.kernel.org/all/20230613071756.GA359746@sumitra.com/ - Li=
nk
> to v3: https://lore.kernel.org/all/20230622080729.GA426913@sumitra.com/
>=20
> Changes in v4:
> Reported-by: kernel test robot <lkp@intel.com>
> Closes:
> https://lore.kernel.org/oe-kbuild-all/202306230559.hU5Aonpl-lkp@intel.com=
/ -
> Remove unused label 'err_free_page'.
>=20
> Changes in v3:
> Noted by: Fabio M. De Francesco<fmdefrancesco@gmail.com>
> 	- Remove the check 'if (!ptr)'.
> 	- Remove the unused variable 'ptr'.
> 	- Change the commit message.
>=20
> Changes in v2:
> Noted by: Fabio M. De Francesco<fmdefrancesco@gmail.com>
> 	- Remove the kmap() call and call page_address() instead.
> 	- Change the commit subject and message.
>=20
>  lib/test_bpf.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
>=20
> diff --git a/lib/test_bpf.c b/lib/test_bpf.c
> index ade9ac672adb..a5cc5f9fc4e8 100644
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
> +		memcpy(page_address(page), test->frag_data, MAX_DATA);
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





