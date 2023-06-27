Return-Path: <bpf+bounces-3573-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B774873FF2E
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 17:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D9D4280E84
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 15:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDD919515;
	Tue, 27 Jun 2023 15:01:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7222418C1A
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 15:01:52 +0000 (UTC)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E9C1BE4;
	Tue, 27 Jun 2023 08:01:50 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6686a05bc66so2900530b3a.1;
        Tue, 27 Jun 2023 08:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687878110; x=1690470110;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QhnmqepLZzo6a37ROg3ReZXKJhIRw52WCvxXCDCV0oM=;
        b=H4nVxqccKCn4ZL+AGgk0iSwu85tHAREMFJGtTN4faV0WVgoyRViUKcSoCztZy6rmbK
         4N71X7Sdwi24PPLMWXm787VRZLcaUOZddlqeNcSTIbTQBD0qYzNdAxwHoY9kb2aRt2PO
         g0ttVSSMFqwuTKq4m1Wi8ojP/0x6xj4bX+ouwm5FQS6UWkot/6pEPLNjimD4pBMqqi6k
         2yY3Ta0HYNkr4avKMz22U8jaQb4OuXYBxAdZUtBsnf0i3+rR0lndyyEKBHKN1nhGUaIp
         gGdiZI9DQ+82tu+VIKpGnBNm0E6uiWHdIydriekdhyk3g6zNDROBinoytL1ZJ2owwck+
         WdBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687878110; x=1690470110;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QhnmqepLZzo6a37ROg3ReZXKJhIRw52WCvxXCDCV0oM=;
        b=D8m/3vnjQsGi0w9bRT7OH7T99N/dovUJq21ArooTbdyIrI8aQxEWNEOWJZd0VPAiXr
         biOvCVO7plSqZfz7w/Xq4QC3p60UhseUOtueqpIcvnOhhBcdBdKCOPlM1dD/izhPnsZ0
         BMCTZXGHGvbnU5hoFaNd46AQvzqGOhx4nrPh0IM0VkI85W4Q+fGb95XUE81eXWdeOnuH
         Hy07IgajTm+uxzDtzk9G7FC7MUdPugB1zDa4YYeNpxkjcA87+sY+Epi4wnSHuKtrJU5l
         SGbRIY637LQqi3/14eGlZ+KOlO7SotICoA7siY8QtQckGNSYFWgq3r/M3aB88Ly7hr4H
         hjEw==
X-Gm-Message-State: AC+VfDyvime3rH6NBTppRcO26AY+8ei02M4XWIik5lib738aKFFzzS2U
	PAh550tmEhw1PKCCEMBYnCI=
X-Google-Smtp-Source: ACHHUZ6mxZ6DQfquEXB0KlWHZILVlqKkNBcnpf0hJVZghjdb9etphQwlS3SOCJxW2ODvj/b1YTUGQw==
X-Received: by 2002:a05:6a00:2341:b0:680:98c:c58d with SMTP id j1-20020a056a00234100b00680098cc58dmr26466pfj.2.1687878109504;
        Tue, 27 Jun 2023 08:01:49 -0700 (PDT)
Received: from sumitra.com ([59.95.154.112])
        by smtp.gmail.com with ESMTPSA id 204-20020a6300d5000000b0053051d50a48sm5832558pga.79.2023.06.27.08.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 08:01:49 -0700 (PDT)
Date: Tue, 27 Jun 2023 08:01:38 -0700
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
Subject: Re: [PATCH v4] lib/test_bpf: Call page_address() on page acquired
 with GFP_KERNEL flag
Message-ID: <20230627150138.GB452923@sumitra.com>
References: <20230623151644.GA434468@sumitra.com>
 <5846758.MhkbZ0Pkbq@suse>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5846758.MhkbZ0Pkbq@suse>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 26, 2023 at 03:07:22PM +0200, Fabio M. De Francesco wrote:
> On venerdì 23 giugno 2023 17:16:44 CEST Sumitra Sharma wrote:
> > generate_test_data() acquires a page with alloc_page(GFP_KERNEL).
> > The GFP_KERNEL is typical for kernel-internal allocations.
> > The caller requires ZONE_NORMAL or a lower zone for direct access.
> > 
> > Therefore the page cannot come from ZONE_HIGHMEM. Thus there's
> > no need to map it with kmap().
> > 
> > Also, the kmap() is being deprecated in favor of kmap_local_page() [1].
> > 
> > Hence, use a plain page_address() directly.
> > 
> > Since the page passed to the page_address() is not from the highmem
> > zone, the page_address() function will always return a valid kernel
> > virtual address and will not return NULL. Hence, remove the check
> > 'if (!ptr)'.
> > 
> > Remove the unused variable 'ptr' and label 'err_free_page'.
> > 
> > [1]: https://lore.kernel.org/all/20220813220034.806698-1-ira.weiny@intel.com/
> > 
> > Suggested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> 
> I can't see no more things that prevent my tag, then it is...
> 
> Reviewed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> 
> Thanks for working on it for all the time it took to get to v4 and for 
> listening to what you've been suggested to change.
> 
> Well done :-)

Thank you, Fabio and Ira, for your tags and kind words :)

Thanks & regards
Sumitra

> 
> Fabio
> 
> > Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
> > ---
> > 
> > - Link to v1:
> > https://lore.kernel.org/bpf/20230613073020.GA359792@sumitra.com/T/ - Link to
> > v2: https://lore.kernel.org/all/20230613071756.GA359746@sumitra.com/ - Link
> > to v3: https://lore.kernel.org/all/20230622080729.GA426913@sumitra.com/
> > 
> > Changes in v4:
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes:
> > https://lore.kernel.org/oe-kbuild-all/202306230559.hU5Aonpl-lkp@intel.com/ -
> > Remove unused label 'err_free_page'.
> > 
> > Changes in v3:
> > Noted by: Fabio M. De Francesco<fmdefrancesco@gmail.com>
> > 	- Remove the check 'if (!ptr)'.
> > 	- Remove the unused variable 'ptr'.
> > 	- Change the commit message.
> > 
> > Changes in v2:
> > Noted by: Fabio M. De Francesco<fmdefrancesco@gmail.com>
> > 	- Remove the kmap() call and call page_address() instead.
> > 	- Change the commit subject and message.
> > 
> >  lib/test_bpf.c | 10 +---------
> >  1 file changed, 1 insertion(+), 9 deletions(-)
> > 
> > diff --git a/lib/test_bpf.c b/lib/test_bpf.c
> > index ade9ac672adb..a5cc5f9fc4e8 100644
> > --- a/lib/test_bpf.c
> > +++ b/lib/test_bpf.c
> > @@ -14381,25 +14381,17 @@ static void *generate_test_data(struct bpf_test
> > *test, int sub) * single fragment to the skb, filled with
> >  		 * test->frag_data.
> >  		 */
> > -		void *ptr;
> > -
> >  		page = alloc_page(GFP_KERNEL);
> > 
> >  		if (!page)
> >  			goto err_kfree_skb;
> > 
> > -		ptr = kmap(page);
> > -		if (!ptr)
> > -			goto err_free_page;
> > -		memcpy(ptr, test->frag_data, MAX_DATA);
> > -		kunmap(page);
> > +		memcpy(page_address(page), test->frag_data, MAX_DATA);
> >  		skb_add_rx_frag(skb, 0, page, 0, MAX_DATA, MAX_DATA);
> >  	}
> > 
> >  	return skb;
> > 
> > -err_free_page:
> > -	__free_page(page);
> >  err_kfree_skb:
> >  	kfree_skb(skb);
> >  	return NULL;
> > --
> > 2.25.1
> 
> 
> 
> 

