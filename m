Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14AC4BCBB0
	for <lists+bpf@lfdr.de>; Sun, 20 Feb 2022 03:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbiBTCYc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Feb 2022 21:24:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiBTCYc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Feb 2022 21:24:32 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F5B3982A
        for <bpf@vger.kernel.org>; Sat, 19 Feb 2022 18:24:11 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id u12so10121617plf.13
        for <bpf@vger.kernel.org>; Sat, 19 Feb 2022 18:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZLYly4JBWVrZS29IeUYiIhPhXWn0srD/7CU1LxCbYVQ=;
        b=myrYB1Gv+Xs77zjPnpohH6aGYLz325ui4zsI0+D0IWO++NH6UyPnnEDIYwWBzYEgkY
         XieNZGe1fjB8aP42ICVET9j/3H7bx0slXlPeJy8nXyaAw/m0oyuD8qAKHYZi5r5FutK7
         l46so/QS4+J5L9veNw3wUTe4pUv58R8GUnonHCe59DmcG5oOfTaZ1iXjcRMEUgsB/O6/
         1SXtbEZboBupIONa1lfgE7L5D/gevIOhVg1aWfK1mnfuEPlYUne69uSwWMG6G+x9l7Ay
         9co2ePX48FypAtqhIMJ603JylLPt3dwde0w+qaDUmzlCVUjpeCGuyVrfcAA8aGSudCq5
         p/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZLYly4JBWVrZS29IeUYiIhPhXWn0srD/7CU1LxCbYVQ=;
        b=LA+xMHQLkcFaQKoo/Xw3JCcqgzAbGo0y83l3K+o5mm85AxkCpD/3wSGTTCzHZxEjCn
         jaTKoofBhbNYXbayp4wgyNrcZzrzFhZyjJUP6eHzvOD06oAeViAl/cgSV1qGxL55Kqse
         QLhE+AnjBnlY1Oo//qbGHAPMt7o/fMXC1IDj/wwh7p9lk/9xn4HV7pFfPhSIOV4SOpYd
         7A9e8FCnk2nP/kgxC6E5RW+auYtvk1RNZW/nYVmkeRjfckU3raPI6IAUGG25rJoNt1tg
         vu+PJPMv3LPnBmTWMykvQNoVeixF0JcmDjNwV3tBEnO/jweJ8/7HhJjqxRaj17QSx3S/
         DBZw==
X-Gm-Message-State: AOAM531cwfv8Hpay3+pRKuonOPryR7hwkLCWNaHt4+Dm7WVrCCZBWiL0
        bFWLd6wvZ14gb9M9e5uYEmw=
X-Google-Smtp-Source: ABdhPJy0yaYuil2kBeVs6++BcjcYWhp0sC4qHeaZbcoObs0FVIvrP1ZuwRhLerMeVjXrT9pWWnSCtg==
X-Received: by 2002:a17:90b:3443:b0:1b8:cd4e:ad81 with SMTP id lj3-20020a17090b344300b001b8cd4ead81mr15058043pjb.154.1645323851371;
        Sat, 19 Feb 2022 18:24:11 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:e3e2])
        by smtp.gmail.com with ESMTPSA id s11sm8198052pfk.8.2022.02.19.18.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 18:24:10 -0800 (PST)
Date:   Sat, 19 Feb 2022 18:24:09 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>
Subject: Re: [PATCH bpf v1 1/5] bpf: Fix kfunc register offset check for
 PTR_TO_BTF_ID
Message-ID: <20220220022409.r5y2bovtgz3r2n47@ast-mbp.dhcp.thefacebook.com>
References: <20220219113744.1852259-1-memxor@gmail.com>
 <20220219113744.1852259-2-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220219113744.1852259-2-memxor@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Feb 19, 2022 at 05:07:40PM +0530, Kumar Kartikeya Dwivedi wrote:
>  
> +/* Caller ensures reg->type does not have PTR_MAYBE_NULL */
> +int check_func_arg_reg_off(struct bpf_verifier_env *env,
> +			   const struct bpf_reg_state *reg, int regno,
> +			   bool arg_alloc_mem)
> +{
> +	enum bpf_reg_type type = reg->type;
> +	int err;
> +
> +	WARN_ON_ONCE(type & PTR_MAYBE_NULL);

So the warn was added and made things more difficult and check had to be moved
into check_mem_reg to clear that flag?
Why add that warn in the first place then?
The logic get convoluted because of that.

> +	if (reg->off < 0) {
> +		verbose(env, "negative offset %s ptr R%d off=%d disallowed\n",
> +			reg_type_str(env, reg->type), regno, reg->off);
> +		return -EACCES;
> +	}

Out of the whole patch this part is useful. The rest seems to dealing
with self inflicted pain.
Just call check_ptr_off_reg() for kfunc ?
The patch seems to be doing several things at once. Please split.
