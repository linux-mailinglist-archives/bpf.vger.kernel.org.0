Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF05645140
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 02:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiLGBcZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 20:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiLGBcZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 20:32:25 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A31452156
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 17:32:24 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id k79so16193034pfd.7
        for <bpf@vger.kernel.org>; Tue, 06 Dec 2022 17:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0HN1AyyUK3W77oAc8G3ArfwP54yaq4caEzdXDIWgY+0=;
        b=CHNG/3umLdY8+SI7vKeXQLW5CWfEx8xI/cM5uMahnKeHaZdxDlXfl8qGa+pH9g8Ml0
         VYNJu2njj7Sv2iVORon2vPnPLCbeGzVBMw1C2wuFgnITf1cmtdHuUbnBh+UMltoXVon1
         67fLAblo6Lb2bX7vJZdnMjNZ1S5itwnxBnnVs3pz3qQ2aePNTwlhGPNH3D1F58jchQTH
         cRIuya2mdaHqeA0vodB0Txq4b0ZPd5nxdkSx7KKb6kG0PwX6RCufeR02Lqzd2+3i5yNY
         tQPLHI/WYN99N10y8jGV4eAr42SYYx0CflgrRyT0L/pJwEWfGN50pW/+bx2E9ESjOxMY
         Pcuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0HN1AyyUK3W77oAc8G3ArfwP54yaq4caEzdXDIWgY+0=;
        b=LkfiDJUslE3MIUYusdI1DFJ03PfuLAzXk2x5Z9aGcIungQq3r4xYpwNX5Bdu9/M8Rj
         0MUMmMZ92igGanqOahI9u05Z0lnLCnh9f7JvDOKl4Fp1n1mFZvQ6tRQqQCvi6Q5DdoqV
         CeEYQZb+rbbTEf0V+z919SrowcTp0uCWBOnJngod3rCdsNM+XDUNBwrI0iIJLlvYKVWj
         MnkHYHy7f8rTVyPCfUZ8B0FM8LyuphWhofR+txFz5B9vQTXUhkdQwdbtBQrw+S0j5Idr
         Dreu0bRi0yQUQEOPfKQ5KTBMfeviTZV30MaIbdyqafU6sUhDQ382nV1E2fXESYe06swY
         zwPQ==
X-Gm-Message-State: ANoB5pmqPi7nOhOUywZMR/jCCJDZevUbuBpxK3bfuuL+2SZAONrzCs+n
        +ZTeioYHzzSep9yEhia/Nls=
X-Google-Smtp-Source: AA0mqf5NSNMNCZ54TETVV+/rpSJwRxkWSMQlncaLIS+nJNLBlSseWqsGcMAk2qsmRN12wXWvyfKLtQ==
X-Received: by 2002:a62:b40e:0:b0:56b:d328:5441 with SMTP id h14-20020a62b40e000000b0056bd3285441mr325999pfn.11.1670376743822;
        Tue, 06 Dec 2022 17:32:23 -0800 (PST)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:11da])
        by smtp.gmail.com with ESMTPSA id a4-20020a621a04000000b005752b9fec48sm12287923pfa.204.2022.12.06.17.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 17:32:23 -0800 (PST)
Date:   Tue, 6 Dec 2022 17:32:19 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next 02/13] bpf: map_check_btf should fail if
 btf_parse_fields fails
Message-ID: <Y4/tIxxJ7JCrTmRR@macbook-pro-6.dhcp.thefacebook.com>
References: <20221206231000.3180914-1-davemarchevsky@fb.com>
 <20221206231000.3180914-3-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206231000.3180914-3-davemarchevsky@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 06, 2022 at 03:09:49PM -0800, Dave Marchevsky wrote:
> map_check_btf calls btf_parse_fields to create a btf_record for its
> value_type. If there are no special fields in the value_type
> btf_parse_fields returns NULL, whereas if there special value_type
> fields but they are invalid in some way an error is returned.
> 
> An example invalid state would be:
> 
>   struct node_data {
>     struct bpf_rb_node node;
>     int data;
>   };
> 
>   private(A) struct bpf_spin_lock glock;
>   private(A) struct bpf_list_head ghead __contains(node_data, node);
> 
> groot should be invalid as its __contains tag points to a field with

s/groot/ghead/ ?

> type != "bpf_list_node".
> 
> Before this patch, such a scenario would result in btf_parse_fields
> returning an error ptr, subsequent !IS_ERR_OR_NULL check failing,
> and btf_check_and_fixup_fields returning 0, which would then be
> returned by map_check_btf.
> 
> After this patch's changes, -EINVAL would be returned by map_check_btf
> and the map would correctly fail to load.
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Fixes: aa3496accc41 ("bpf: Refactor kptr_off_tab into btf_record")
> ---
>  kernel/bpf/syscall.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 35972afb6850..c3599a7902f0 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1007,7 +1007,10 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
>  	map->record = btf_parse_fields(btf, value_type,
>  				       BPF_SPIN_LOCK | BPF_TIMER | BPF_KPTR | BPF_LIST_HEAD,
>  				       map->value_size);
> -	if (!IS_ERR_OR_NULL(map->record)) {
> +	if (IS_ERR(map->record))
> +		return -EINVAL;
> +
> +	if (map->record) {
>  		int i;
>  
>  		if (!bpf_capable()) {
> -- 
> 2.30.2
> 
