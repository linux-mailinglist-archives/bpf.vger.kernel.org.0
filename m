Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED3A60381A
	for <lists+bpf@lfdr.de>; Wed, 19 Oct 2022 04:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiJSCb3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Oct 2022 22:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiJSCb2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 22:31:28 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0B3BC61F
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 19:31:27 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id i6so15585973pli.12
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 19:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=whepQjitcmgbS3eb6pV1cfvo2shRl7sNbM4Cq++qfEM=;
        b=TYSLDOyitlwGb3PzyRM8oV/EXRC8FV6G+05nZL7qYlZIW3CaDAiMTS303NItJPgdmw
         OFOWza9RMvE69kEMHxMZEI5HxT7iZLjz/ENaae4v5h7puoygX6U0q1Z1uMQ3hL5XdTxr
         scqzqD8rlVVV0pJgNsVUuv0y4G+bIgqMn1rj0T3b9tf+8qAx3BZWA+TIlvHfHrY8OowY
         zcB0eH0BbIxsUnEZ2peyL8vmZ/lwQqvcSZ3PZ+He+tRk8AxhT5T2HpFBmLddjgQif6WR
         OEHiwxa0+GOvr2f0+gCCxPw9ysxXqjrRpGCXlLaW0X8uO29FwYJHHVt9OfiBbeLJtihY
         3kCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=whepQjitcmgbS3eb6pV1cfvo2shRl7sNbM4Cq++qfEM=;
        b=k5y6wnPp3lNlqAVg5krHaoQIgWdSXtVuinLLb6eyL8ydnIdPojFQ20pPZCiA8WuLbf
         llAG2Rfj7V8och68sXSdLWeGEN+zrSgAHuSS/IQ5vBqiAAZ1w9mTDDTfeIViWhPb9a+n
         n8Zl/odKDK0PkHr69tkVh4z2dXnyVbGmGMBkES7w1qOZeHwE6v1cdsRaZXKe1BfqX6A8
         Am6vib6GLgXiRj+OGmDcmwN4+Kr8f8BbNE4/To2zrdDTJMhPULpuHl525h6fifbfh8OA
         8W+0JE6qy11XC11QID9oZ1SEtjK5qIQDec2aP2G+DvOWI2vC70TBUu9zrGeNyldRnxVB
         sl1g==
X-Gm-Message-State: ACrzQf0UsFGa0bd4bekvyWRNQgvZwL2FA3FzuKuDFFiUwscbd1bMOOnV
        lC5PAGIkpEwzT26igQHbuXc=
X-Google-Smtp-Source: AMsMyM7ci32zcGB3q9h19Cew2W+EsvUefd8ydJgto3VnGgR0mkrW1dJit8go0I54EBQs0bDmtXIDxA==
X-Received: by 2002:a17:90b:3b47:b0:20d:a991:3f24 with SMTP id ot7-20020a17090b3b4700b0020da9913f24mr33193135pjb.108.1666146687273;
        Tue, 18 Oct 2022 19:31:27 -0700 (PDT)
Received: from macbook-pro-4.dhcp.thefacebook.com ([2620:10d:c090:400::5:a07d])
        by smtp.gmail.com with ESMTPSA id bf1-20020a170902b90100b0017f7d7e95d3sm9397309plb.167.2022.10.18.19.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 19:31:26 -0700 (PDT)
Date:   Tue, 18 Oct 2022 19:31:24 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: Re: [PATCH bpf-next v2 19/25] bpf: Introduce bpf_kptr_new
Message-ID: <20221019023124.47zzi3gs2zcdvxca@macbook-pro-4.dhcp.thefacebook.com>
References: <20221013062303.896469-1-memxor@gmail.com>
 <20221013062303.896469-20-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013062303.896469-20-memxor@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 13, 2022 at 11:52:57AM +0530, Kumar Kartikeya Dwivedi wrote:
> +void *bpf_kptr_new_impl(u64 local_type_id__k, u64 flags, void *meta__ign)
> +{
> +	struct btf_struct_meta *meta = meta__ign;
> +	u64 size = local_type_id__k;
> +	void *p;
> +
> +	if (unlikely(flags || !bpf_global_ma_set))
> +		return NULL;

Unused 'flags' looks weird in unstable api. Just drop it?
And keep it as:
void *bpf_kptr_new(u64 local_type_id__k, struct btf_struct_meta *meta__ign);

and in bpf_experimental.h:

extern void *bpf_kptr_new(__u64 local_type_id) __ksym;

since __ign args are ignored during kfunc type match
the bpf progs can use it without #define.

> +	p = bpf_mem_alloc(&bpf_global_ma, size);
> +	if (!p)
> +		return NULL;
> +	if (meta)
> +		bpf_obj_init(meta->off_arr, p);

I'm starting to dislike all that _arr and _tab suffixes in the verifier code base.
It reminds me of programming style where people tried to add types into
variable names. imo dropping _arr wouldn't be just fine.
