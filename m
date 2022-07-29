Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6745585371
	for <lists+bpf@lfdr.de>; Fri, 29 Jul 2022 18:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbiG2QcF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jul 2022 12:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiG2QcF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jul 2022 12:32:05 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC0D11C2E
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 09:32:04 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id y9so5045178pff.12
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 09:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=ThpkulsbdADtJrapzUd3q+YaG8olgKpnGH2NKFYof7o=;
        b=D3rnqyr4bPwMTrwAH2IazHrl7R1+VpIWpxwyVx3AN0jdrGdOleT0BsHXvqbhvgQKdb
         /m5maoAuUArp6ddQBGo1cK/VktL+AqAzkBUC2KcVot94a1tbjmG3kj5yE9LXEbNBakld
         r2IHSkJaUD4uT+Gh+ft1dmYIk/2kLfDnMHPFEDJ1B3kiLT++YfjqIN9kAp6ySOoRQ6YM
         wIJG7R1Oy3UddqBBGTcCzTgNez6OPraQCFqYJWyuFtoTM0uNWoTEOlozgP1Tgr7mN/cf
         ROsZ3+KfDOr45TbqM2ZXUJBRzpGc+7AWxv+lZuCjr4b6yG/5Amy76rHXqgNprqcfefQr
         BgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=ThpkulsbdADtJrapzUd3q+YaG8olgKpnGH2NKFYof7o=;
        b=P1yQbsYYpaN2GDeKoXIcOZRB6aNp9ipCvM97pThQ6wmPXm41nE/XowOLQ4YcdI4oYG
         EPGXjaLG7R8rRd8ZxNAS+BBZbgUzKXBUayrJuXYXgwFFvod4dcCDiydpiFkgO4ee8roO
         WfB0T0ziJPBFMUNQBH2mNQ39nS8t2w2zXYe5Nol1BdiJyY790nlvVuWeeTqjM0R4nn4z
         MHU7c4BbzPZYsaNkAL0pY/jONJeMtPezevtgJOSCF6iWz7yY0asGXsUVjGPTIg+RzX6n
         AS6Wg966ziHadRxmDWot7eKWByiq9qziSmgUrmkXFC8v5GlXRiiqkFC17YSuIGOiy6d1
         JMuw==
X-Gm-Message-State: AJIora/GxYaBbAr5pRIoufmcYFhslpCpLnF5cXE0++obuvq4ETVYMudh
        7KWoyN8tZ22Fs7VFClAiV1gi4W3xlLM=
X-Google-Smtp-Source: AGRyM1tvJGkWVKl2AIKwsf1joS3OT8TVPmkRm0j5PpNn3U6BuHmEwqyR+FpX0rEZSjLUCWnfeOlA4A==
X-Received: by 2002:a63:e348:0:b0:41b:444f:ff5f with SMTP id o8-20020a63e348000000b0041b444fff5fmr3470441pgj.333.1659112323603;
        Fri, 29 Jul 2022 09:32:03 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:df80])
        by smtp.gmail.com with ESMTPSA id e125-20020a621e83000000b005289a50e4c2sm3123370pfe.23.2022.07.29.09.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 09:31:14 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 29 Jul 2022 06:31:11 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [RFC PATCH bpf-next 10/11] bpf: Introduce PTR_ITER and
 PTR_ITER_END type flags
Message-ID: <YuQLT2QOsxyyTc8C@slm.duckdns.org>
References: <20220722183438.3319790-1-davemarchevsky@fb.com>
 <20220722183438.3319790-11-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722183438.3319790-11-davemarchevsky@fb.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

One nit clang found.

On Fri, Jul 22, 2022 at 11:34:37AM -0700, Dave Marchevsky wrote:
> @@ -5793,6 +5817,17 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
>  	if (arg_type & PTR_MAYBE_NULL)
>  		type &= ~PTR_MAYBE_NULL;
>  
> +	/* TYPE | PTR_ITER is valid input for helpers that expect TYPE
> +	 * TYPE is not valid input for helpers that expect TYPE | PTR_ITER
> +	 */
> +	if (type_is_iter(arg_type)) {
> +		if (!type_is_iter(type))
> +			goto not_found;

Here, we go to not_found with @i uninitialized and the not_found block loops
till @i.

Thanks.

-- 
tejun
