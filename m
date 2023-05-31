Return-Path: <bpf+bounces-1522-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E6A718952
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 20:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 017EE2814F8
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 18:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C719319BCD;
	Wed, 31 May 2023 18:24:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A2A171BB
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 18:24:34 +0000 (UTC)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6219497
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 11:24:33 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5289cf35eeaso967748a12.1
        for <bpf@vger.kernel.org>; Wed, 31 May 2023 11:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685557473; x=1688149473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d4W7VbnO3Q5CUOp94HNU1MVP1s6mGv6DJtirltchbCc=;
        b=aiCGa7/0N7Ifnxe42JdXN8prVnWkQh4yRtufuD5IOuthpb7iQAWgieTt+rLScVSOsu
         lDb1BVQVsffp7FwSQKEcPQN2qcMj5ykWDJam9wrAnh5EC1H6sLlJM5YZYzGGTyzs2gvP
         Vkd/rVOq8YSlfwIEuHMxtgPTYa4g7LsPKkmmnoSita/wR4EbtdiNuo66aMJsnFVPbJv3
         i2/q888oJ7uxCkqdFA+9dh7Ooo7JA4aMnr7uFaJ7cFqSnFeJAdCavkrqugfERRGQJ3Ge
         N0V/rj8h1k6pUyLnuvbSLMJOvtkS1/7gVbPIihfE+ywLJEX1kiivbTurzmRomdUOhnzJ
         FmUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685557473; x=1688149473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4W7VbnO3Q5CUOp94HNU1MVP1s6mGv6DJtirltchbCc=;
        b=eItMOnEG2xYjU+zpr20EPJpAo55odJKRqL6WvAFZme662HjE2a4bhUICNwIigwzKUl
         VUG4TQCOFwtusc7wPKT9TEHqUAGuZhjHzoq6ypwY5P358yFlQjZpAOcmGgkNhlbZy8Wg
         s5X2nqqrXON8Lz+EdLuKAuPKsE2IYjBpfjBo+LV6yYm/aAJAEF1zewnmGsmDw9/zCFlT
         +CVfIqQRipRgrCdqpZvvZNRIjh4bUoylucIaeUCEfELpLb/bF2iD3UcfrfgB5EVxAztk
         fqqA7CAD3mE/+uSRnXAYiB30ENXne4kG1+dMCJSGTxxltF93lRGA7l3kbRBF2wRW4BOd
         hT2g==
X-Gm-Message-State: AC+VfDz0bEvLw8+mHB/cQNmM1Aa0OyzG/SfJyfY910QD3qcmwJ9zC8Et
	FphOdiHt2YEqoHsQDuLkOpY=
X-Google-Smtp-Source: ACHHUZ401IhIdgcdTyXTiRI2v9mhI00+kEG6/hZUZR+RBCdWWt23lwBECNZgwVJQ7/O8XDSQFhyv+g==
X-Received: by 2002:a17:902:e850:b0:1b0:ec0:7cff with SMTP id t16-20020a170902e85000b001b00ec07cffmr7125004plg.10.1685557472468;
        Wed, 31 May 2023 11:24:32 -0700 (PDT)
Received: from MacBook-Pro-8.local ([2620:10d:c090:400::5:d8f6])
        by smtp.gmail.com with ESMTPSA id ik7-20020a170902ab0700b001a967558656sm1751227plb.42.2023.05.31.11.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 11:24:31 -0700 (PDT)
Date: Wed, 31 May 2023 11:24:29 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Anton Protopopov <aspsk@isovalent.com>
Cc: bpf@vger.kernel.org, Joe Stringer <joe@isovalent.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add new map ops ->map_pressure
Message-ID: <20230531182429.wb5kti4fvze34qiz@MacBook-Pro-8.local>
References: <20230531110511.64612-1-aspsk@isovalent.com>
 <20230531110511.64612-2-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531110511.64612-2-aspsk@isovalent.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 31, 2023 at 11:05:10AM +0000, Anton Protopopov wrote:
>  static void free_htab_elem(struct bpf_htab *htab, struct htab_elem *l)
>  {
>  	htab_put_fd_value(htab, l);
>  
> +	dec_elem_count(htab);
> +
>  	if (htab_is_prealloc(htab)) {
>  		check_and_free_fields(htab, l);
>  		__pcpu_freelist_push(&htab->freelist, &l->fnode);
>  	} else {
> -		dec_elem_count(htab);
>  		htab_elem_free(htab, l);
>  	}
>  }
> @@ -1006,6 +1024,7 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
>  			if (!l)
>  				return ERR_PTR(-E2BIG);
>  			l_new = container_of(l, struct htab_elem, fnode);
> +			inc_elem_count(htab);

The current use_percpu_counter heuristic is far from perfect. It works for some cases,
but will surely get bad as the comment next to PERCPU_COUNTER_BATCH is trying to say.
Hence, there is a big performance risk doing inc/dec everywhere.
Hence, this is a nack: we cannot decrease performance of various maps for few folks
who want to see map stats.

If you want to see "pressure", please switch cilium to use bpf_mem_alloc htab and
use tracing style direct 'struct bpf_htab' access like progs/map_ptr_kern.c is demonstrating.
No kernel patches needed.
Then bpf_prog_run such tracing prog and read all internal map info.
It's less convenient that exposing things in uapi, but not being uapi is the point.


