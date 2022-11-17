Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D6162D0D0
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 02:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbiKQBtc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Nov 2022 20:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbiKQBt1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Nov 2022 20:49:27 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27B06036B
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 17:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=g86pi13U5fqQjMMTOmWhOQ6kKD058Yl0Y95DFucR3dQ=; b=SDvjE5KtKIvgDRJi10Gyg0+YYm
        Mg27EFT21bONScnRw9uN4LpfuMDgAiKsxgFddxoCAyblWB7+2TE25sqIFUiL7uUj319oWcKA/iXgR
        +2uVXeC3vPopf/SamElZPDeu74g6w3XvvghUuVGCeeUw2iDh8UiNGOnzW2GMX/aNqehD0redx8SMv
        UZaW97cDwn2we2xG2ZMgWwup2nNgPRJIe/laPSn9UedlrPTobNyI2dbIqzAs8rP7GIL5NpqqW0JPD
        3hTlbE67TzNrZtd0VI8EHLQIdAsr5lgghcj8mYZeAFRfWUjycJuTGS1ZahVhyv9g2ek3A+MYb3Nb5
        CqlSYeJg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ovU1p-009OY6-Ud; Thu, 17 Nov 2022 01:49:21 +0000
Date:   Wed, 16 Nov 2022 17:49:21 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
        x86@kernel.org, peterz@infradead.org, hch@lst.de,
        rick.p.edgecombe@intel.com, aaron.lu@intel.com, rppt@kernel.org
Subject: Re: [PATCH bpf-next v3 3/6] selftests/vm: extend test_vmalloc to
 test execmem_* APIs
Message-ID: <Y3WTIdYY7Vsc5QXH@bombadil.infradead.org>
References: <20221117010621.1891711-1-song@kernel.org>
 <20221117010621.1891711-4-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117010621.1891711-4-song@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 16, 2022 at 05:06:18PM -0800, Song Liu wrote:
> Add logic to test execmem_[alloc|fill|free] in test_vmalloc.c.
> No need to change tools/testing/selftests/vm/test_vmalloc.sh.
> 
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  lib/test_vmalloc.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
> index cf7780572f5b..6591c4932c3c 100644
> --- a/lib/test_vmalloc.c
> +++ b/lib/test_vmalloc.c
> @@ -50,6 +50,7 @@ __param(int, run_test_mask, INT_MAX,
>  		"\t\tid: 128,  name: pcpu_alloc_test\n"
>  		"\t\tid: 256,  name: kvfree_rcu_1_arg_vmalloc_test\n"
>  		"\t\tid: 512,  name: kvfree_rcu_2_arg_vmalloc_test\n"
> +		"\t\tid: 1024, name: execmem_alloc_test\n"
>  		/* Add a new test case description here. */
>  );
>  
> @@ -352,6 +353,34 @@ kvfree_rcu_2_arg_vmalloc_test(void)
>  	return 0;
>  }
>  
> +static int
> +execmem_alloc_test(void)
> +{
> +	void *p, *tmp;
> +	int i;
> +
> +	for (i = 0; i < test_loop_count; i++) {
> +		/* allocate variable size, up to 64kB */
> +		size_t size = (i % 1024 + 1) * 64;
> +
> +		p = execmem_alloc(size, 64);
> +		if (!p)
> +			return -1;
> +
> +		tmp = execmem_fill(p, "a", 1);
> +		if (tmp != p)
> +			return -1;
> +
> +		tmp = execmem_fill(p + size - 1, "b", 1);
> +		if (tmp != p + size - 1)
> +			return -1;
> +
> +		execmem_free(p);
> +	}
> +
> +	return 0;
> +}
> +

This is a basic test and it is useful.

But given all those WARN_ON() and WARN_ON_ONCE() I think the real value
test here would be to race 1000 threads doing this at the same time.
From a quick look at the test I think adding another entry into the
test_case_array with the same call again or 3 times would suffice
for a basic clash test.

Thoughts?

  Luis
