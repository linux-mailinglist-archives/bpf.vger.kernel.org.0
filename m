Return-Path: <bpf+bounces-3109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA937396B5
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 07:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28A7E1C21039
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 05:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04311FD6;
	Thu, 22 Jun 2023 05:13:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7521D17E0
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 05:13:18 +0000 (UTC)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F101AE9;
	Wed, 21 Jun 2023 22:13:16 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-544c0d768b9so5346903a12.0;
        Wed, 21 Jun 2023 22:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687410796; x=1690002796;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7V9c1bRadtvspE8RX0+kzHasXFfz3GpqArsWjj0tqQ0=;
        b=kaSh3OC+Z/AIqk3/6hSw/Glei8j8XdAvZYMFoaTsnLdck8Q/vBT8YWKIga7P3nR+vB
         FAEaa5Xq+tk5UQgWWm3PkOv1OWqTAymAYryjoyIeFyBn1iXBxATDt2K5ZffMIQOB/jB2
         vR5S/P+SCm+lF49Ks/18IMQFJ+fQbTCdBAUVQG3Tvt2drkRWyDmjQ8vPKcnYvh5yEsls
         eGoZD3t58fD/5eoe9WKd71i1jAq3CWsyFPUWV2+MX2NhqeuJKfWCF47YQuvRXMH03wpL
         1/nAmsa/woxa+K7lcC7MlwgtVBsOsb4wv2eqcomqAE13xuWyNgrwgtjzIl3rjgbiojs4
         bIjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687410796; x=1690002796;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7V9c1bRadtvspE8RX0+kzHasXFfz3GpqArsWjj0tqQ0=;
        b=IxUoH5soXisITsDyVV9SYoKDfa97H5AbIujPH22d6Ek6EVreDXCl3beyZil6JKmpy2
         vgSz3+nFa+exua2nhrT+dczKEbjvq4iI8O1fmVP0jUKSja0NckGj0nqoPxrgGi1FB1ot
         ArBat9bAOIaLLaii3i4DtxhM5HR1oBbXoWrs/zDw3bWsA+OMG5+ND7hCiVBcFEvR119d
         czNwigwM+0EupSscUsO2OWxuuIosmqkFZvjOHlxDsYP0VFHbyB59cyk18zeKnxhrSzHD
         rGmSHDamIL7xItDM/9rM4isbhi2s3DkCsrIRtVqLJIPfWqj43i4WwI6Q7kV3KZhF2Y4O
         VFpA==
X-Gm-Message-State: AC+VfDx11/Mp2KPIoxI/O5bv3WfdrsSngShMJBqyzXJejasUVYj8pwse
	uPL6mG1vAdQwaUOIjMZ5uq0=
X-Google-Smtp-Source: ACHHUZ42cb21K95tQ49HcbND9JdpfRq6/wkmjgnjUJyszkamhgcDC+PGduxT+71nMR8BCJzWHQKeZg==
X-Received: by 2002:a05:6a20:5495:b0:122:5ed2:b521 with SMTP id i21-20020a056a20549500b001225ed2b521mr8864866pzk.59.1687410795736;
        Wed, 21 Jun 2023 22:13:15 -0700 (PDT)
Received: from sumitra.com ([59.89.167.84])
        by smtp.gmail.com with ESMTPSA id a7-20020a170902ecc700b001b53be3d942sm4320318plh.232.2023.06.21.22.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 22:13:15 -0700 (PDT)
Date: Wed, 21 Jun 2023 22:13:06 -0700
From: Sumitra Sharma <sumitraartsy@gmail.com>
To: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ira Weiny <ira.weiny@intel.com>, Deepak R Varma <drv@mailo.com>,
	Sumitra Sharma <sumitraartsy@gmail.com>
Subject: Re: [PATCH v2] lib/test_bpf: Call page_address() on page acquired
 with GFP_KERNEL flag
Message-ID: <20230622051306.GA422371@sumitra.com>
References: <20230613071756.GA359746@sumitra.com>
 <3564297.R56niFO833@suse>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3564297.R56niFO833@suse>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Jun 18, 2023 at 07:07:00AM +0200, Fabio M. De Francesco wrote:
> On martedì 13 giugno 2023 09:17:56 CEST Sumitra Sharma wrote:
> > generate_test_data() acquires a page with alloc_page(GFP_KERNEL). Pages
> > allocated with GFP_KERNEL cannot come from Highmem. This is why
> > there is no need to call kmap() on them.
> > 
> > Therefore, use a plain page_address() on that page.
> > 
> > Suggested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
> > ---
> > 
> > Changes in v2:
> > 	- Remove the kmap() call and call page_address() instead.
> 
> NIT: Give credit to whom asked you for this removal and explain why the 
> mapping is not required.

> 
> > 	- Change the commit subject and message.
> > 
> >  lib/test_bpf.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/lib/test_bpf.c b/lib/test_bpf.c
> > index ade9ac672adb..70fcd0bcf14b 100644
> > --- a/lib/test_bpf.c
> > +++ b/lib/test_bpf.c
> > @@ -14388,11 +14388,10 @@ static void *generate_test_data(struct bpf_test
> > *test, int sub) if (!page)
> >  			goto err_kfree_skb;
> > 
> > -		ptr = kmap(page);
> > +		ptr = page_address(page);
> >  		if (!ptr)
> >  			goto err_free_page;
> 
> What is the reason of this test? Could "ptr" ever be NULL? What is the code 
> checking just few lines above this latter test?
> 


The code is allocating a page using alloc_page() with the GFP_KERNEL flag to 
obtain a kernel page frame. The checks if (!page) and if (!ptr) are verifying 
if the page allocation or the mapping operation were successful. 

If the pages obtained through page_address() are not from the highmem zone, 
the page_address() function will always return a valid kernel virtual address 
and will not return NULL. Hence, the check !ptr can be ignored while the !page
must remain.

I will be working on the v2 patch.

I will also add the credits and add new lines to commit message
explaining why the mapping is not required.

Thank you for the help.

Thanks & regards
Sumitra

> Please, take a deeper look at this function as a whole.
> 
> Fabio
> 
> >  		memcpy(ptr, test->frag_data, MAX_DATA);
> > -		kunmap(page);
> >  		skb_add_rx_frag(skb, 0, page, 0, MAX_DATA, MAX_DATA);
> >  	}
> > 
> > --
> > 2.25.1
> 
> 
> 
> 

