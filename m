Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518C75FF477
	for <lists+bpf@lfdr.de>; Fri, 14 Oct 2022 22:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbiJNUTs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Oct 2022 16:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiJNUTq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Oct 2022 16:19:46 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A83CB87E;
        Fri, 14 Oct 2022 13:19:42 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id g11so4419737qts.1;
        Fri, 14 Oct 2022 13:19:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6pM02CqWA47CT6v/gwwczEldB1iRqNTULNyxzzkOdng=;
        b=Y6XkSlRQ1jiEy0xc+tB5EtYB74U7B8laojyMGBUTzMJNBV35iQ+H5gmMQXDT3b99m3
         a5HYMCyYBpYu/fA4kTr2ljIdneKSeIpcXWoGn8TXgCJ1Z9R1QY5Q6WEEFolowTHD/ScB
         4LiLmGQzHM/b6HsiWTvxQsWqcovj/03PO15coQGVaBD0n12u9C5tJqnIqc6EsFgToWr1
         HKX8hdPgbpK6DS9+ilht/5X4J2Lm6ReEnDxRMI0J+g+FYPsl1ARBM0sg7Yqab9eRQu1h
         cjQZZlU6B6dvVdQyAPRMaPuIElZpObiFv//1Cw5KFSzEzoE5lSvp6rcsGUq2n0ugBfZU
         FvyA==
X-Gm-Message-State: ACrzQf1TBc0QDhoabG3IkM/3pZaF/aNZkfF8g6s9RUdu2MKWpNxKzlAc
        9MK9EDhHZyDmuDutPEu33cXZ0hBrKhenXg==
X-Google-Smtp-Source: AMsMyM79WpvIJ1lNm5YNc6eSlg3vqL5Nlc0ah+YPD/r0+PzYa1vdSNOBksCB8pmgCMceZXbMOGWAXQ==
X-Received: by 2002:ac8:7f94:0:b0:39c:dd8f:59f3 with SMTP id z20-20020ac87f94000000b0039cdd8f59f3mr1351931qtj.46.1665778780797;
        Fri, 14 Oct 2022 13:19:40 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::6918])
        by smtp.gmail.com with ESMTPSA id t14-20020a05622a148e00b00398313f286dsm2806264qtx.40.2022.10.14.13.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 13:19:40 -0700 (PDT)
Date:   Fri, 14 Oct 2022 15:19:39 -0500
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, tj@kernel.org, memxor@gmail.com
Subject: Re: [PATCH v3 1/3] bpf: Allow trusted pointers to be passed to
 KF_TRUSTED_ARGS kfuncs
Message-ID: <Y0nEW14JcWPqRCMO@maniforge.dhcp.thefacebook.com>
References: <20221014201427.2435461-1-void@manifault.com>
 <20221014201427.2435461-2-void@manifault.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014201427.2435461-2-void@manifault.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 14, 2022 at 03:14:25PM -0500, David Vernet wrote:

[...]

> @@ -5768,6 +5778,9 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
>  	if (arg_type & PTR_MAYBE_NULL)
>  		type &= ~PTR_MAYBE_NULL;
>  
> +	if (!(arg_type & ARG_PTR_TO_BTF_ID))
> +		type &= ~PTR_NESTED;
> +

Argh, I added while debugging something and I meant to remove it before
sending out the next version.  I'll send out v4 shortly without this,
apologies for the noise.
