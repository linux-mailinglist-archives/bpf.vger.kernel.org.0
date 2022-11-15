Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812356291C9
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 07:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiKOGXZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 01:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiKOGXX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 01:23:23 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8F71583F
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 22:23:22 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so12932083pjl.3
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 22:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GFlc2xlvLZPTS3IFcws1rmxjVw/ZOz+0ckF2D3i5CPI=;
        b=hY2iky9EaqHyPryzej/rIN63gbk1CkkRKXWE8Ymu4GDpRBYDjGRN/1P+o3njBDi2Ji
         /7MLjYttAlIRdk0uQpFXFkLcrRI7+mpA6tXdq2LlVjowWd8ZEMP033bJvuhMngeSA5QA
         6I3TiB3h9JI67Y5RpSSq4NEKXlcQiN1HhBs3ApBYmCxqZliQLKcoqXYtYVHr3hbD+FKX
         GtwELoHg4ejhgN86GN9A7ee5Nt9cfNeqvnvR+Q36WwdZZDMH1V+IYiBvwtgegsmsc7Ji
         EkgXrqX60CjPIHDZb5VnTQCJ7jHmaRmNTFTSkPsaGewDPdkPR6WVO7s+IgO0C29rrbZ9
         r6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFlc2xlvLZPTS3IFcws1rmxjVw/ZOz+0ckF2D3i5CPI=;
        b=rtisVnE6kS+yVnnKwLV+fz1AsNsS0iENbYhP8vquLNKWYjX/YXOU0fsDXs8HlbKC2I
         uJ7Pt4YMURSvVp3QVoHpWII0a/mKMgOk6mESZbG8J/wzizrKyLmSYpV6eMSzpMNzKW1W
         ChOZpaWFpBrqLMjLtn6hOo01wEe5EkuPIocxY0/hnkd8tFtRkgeusF2gPyvClqPx4hb5
         A1f253JIQtBlGTtqTgDYtJbhwsfnz3cZaCcQUBzYCgMavBE2w8k8M35khcVrQE6irCUe
         G0onEFU0a1xvshBCY1I04rS8qwkpLDdIymUwN4gKy0oBghochEQbG6S2tlrzNPPD4VjG
         ut2Q==
X-Gm-Message-State: ANoB5pnDX6837lH0DHFvInNTqNG9Z4UO7r3/YDBF3UY1kj9IFZtdQj5b
        Nl26/105MHir9bAeINYViiY=
X-Google-Smtp-Source: AA0mqf7dWeFZ6l2RynObJf+yhn0iu+Xac5mqXcvgGJSMwu97Ssn7DBm8DkTSO1M8RPpdAohkabGrow==
X-Received: by 2002:a17:902:f7c3:b0:176:e414:722 with SMTP id h3-20020a170902f7c300b00176e4140722mr2752824plw.26.1668493401728;
        Mon, 14 Nov 2022 22:23:21 -0800 (PST)
Received: from macbook-pro-5.dhcp.thefacebook.com ([2620:10d:c090:400::5:cee6])
        by smtp.gmail.com with ESMTPSA id e186-20020a621ec3000000b0056b9d9e2521sm8044726pfe.177.2022.11.14.22.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 22:23:21 -0800 (PST)
Date:   Mon, 14 Nov 2022 22:23:19 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: Re: [PATCH bpf-next v7 19/26] bpf: Permit NULL checking pointer with
 non-zero fixed offset
Message-ID: <20221115062319.3hkphudyakopnqvb@macbook-pro-5.dhcp.thefacebook.com>
References: <20221114191547.1694267-1-memxor@gmail.com>
 <20221114191547.1694267-20-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114191547.1694267-20-memxor@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 15, 2022 at 12:45:40AM +0530, Kumar Kartikeya Dwivedi wrote:
>  	if (type_may_be_null(reg->type) && reg->id == id &&
>  	    !WARN_ON_ONCE(!reg->id)) {
> -		if (WARN_ON_ONCE(reg->smin_value || reg->smax_value ||
> -				 !tnum_equals_const(reg->var_off, 0) ||
> -				 reg->off)) {
> +		if (reg->smin_value || reg->smax_value || !tnum_equals_const(reg->var_off, 0) || reg->off) {
....
> +			if (WARN_ON_ONCE(reg->smin_value || reg->smax_value || !tnum_equals_const(reg->var_off, 0)))

That is too much copy-paste between two lines.
Please combine the checks.
