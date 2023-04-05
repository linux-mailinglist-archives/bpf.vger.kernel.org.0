Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A023E6D72B5
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 05:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236593AbjDEDYt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Apr 2023 23:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236386AbjDEDYs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Apr 2023 23:24:48 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB9E30EF
        for <bpf@vger.kernel.org>; Tue,  4 Apr 2023 20:24:47 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id x37so20911926pga.1
        for <bpf@vger.kernel.org>; Tue, 04 Apr 2023 20:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680665086; x=1683257086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4CH8O9dTsI1lSb9s2saTiW7ZSrHInx9wzLXuIu57GT0=;
        b=H0B1vOi/Qihf7qiFWaPEsSveQv1FnEmS+lGYHC5B1J9ChIBSPLakJ/hk7y4XpD3xV2
         YQfmvYhrvy7yAwVibtdDj6BOxM5mKesLmHV2UfodRA48wF1vZNVzT/tD4im0iz+6Cvvh
         SkcQHBK2Ga/as4ALhx+GpX5qTS9RCJgvRWmHjAQobRlNpzYnuyp4Y+jUBnllWZGW8aRt
         x78HGqagr/sey6YcikfB3UPFEmGWHL4JnEAXGYsvof893+hWJo0pFJsfLmlw+2J7JkYk
         3VfhtyO41nuRaq5gMCSnjxiWQaDJ8ZnHZ6xuJC5LKbfpdUgJZcoMBVoAd3w7Fgkt1uv8
         9ASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680665086; x=1683257086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4CH8O9dTsI1lSb9s2saTiW7ZSrHInx9wzLXuIu57GT0=;
        b=7wv1T0kYVkdkUkZobB2wSjrFlC/AixX3Gv8PWJzLNxbML2GRzN+TgsWmBuOBenygce
         v9eGcDOh3GTkZKwD91/nhnMnwlGXKj/0ul5KiYHobsnPwPjSM472mnJ34tvdVYJ93DcQ
         iskdtE99bw2wKvlliy2ThY4LByjw5FV4i9J8QZYYdIm6+S7IX/oFDDfSeeauU1lWJwAg
         oDxB9ba2p3FGD4IUCDYpNjBWZKcSZ6mm3xCwyoMtm4KFo5B0YsIa7FcEH+wAllUwM1+W
         m3qgAld8D3d6yS7lKW2ul8kSTgVeNXO71Up5X0ICbrtAq5mf2d0CvL4CxIWFUTL/sZKq
         AMuw==
X-Gm-Message-State: AAQBX9coceQbsyL3ZlfyZ9054oMlAuQ4XUA8RLnacFleifECAAjWPw9k
        CUPUJxG0E7V3QWbXJWWbnaU=
X-Google-Smtp-Source: AKy350ar5tRv6y4ChOx1D/uA53acF47ei1Sl/kwIyc2C2vjVsS7dquI9MDUieSHK/zjO2cgAkCQmEQ==
X-Received: by 2002:a05:6a00:8f:b0:627:ee6a:2a40 with SMTP id c15-20020a056a00008f00b00627ee6a2a40mr4553541pfj.10.1680665086425;
        Tue, 04 Apr 2023 20:24:46 -0700 (PDT)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:f79f])
        by smtp.gmail.com with ESMTPSA id n2-20020aa79042000000b0062ddfce5cdbsm9262367pfo.45.2023.04.04.20.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 20:24:45 -0700 (PDT)
Date:   Tue, 4 Apr 2023 20:24:43 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@kernel.org, lmb@isovalent.com, timo@incline.eu,
        robin.goegge@isovalent.com, kernel-team@meta.com
Subject: Re: [PATCH v3 bpf-next 12/19] bpf: add log_size_actual output field
 to return log contents size
Message-ID: <20230405032443.tcfnfjsp4jko4gek@macbook-pro-6.dhcp.thefacebook.com>
References: <20230404043659.2282536-1-andrii@kernel.org>
 <20230404043659.2282536-13-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404043659.2282536-13-andrii@kernel.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 03, 2023 at 09:36:52PM -0700, Andrii Nakryiko wrote:
> @@ -1407,6 +1407,11 @@ union bpf_attr {
>  		__aligned_u64	fd_array;	/* array of FDs */
>  		__aligned_u64	core_relos;
>  		__u32		core_relo_rec_size; /* sizeof(struct bpf_core_relo) */
> +		/* output: actual total log contents size (including termintaing zero).
> +		 * It could be both larger than original log_size (if log was
> +		 * truncated), or smaller (if log buffer wasn't filled completely).
> +		 */
> +		__u32		log_size_actual;

Naming nit..
In the networking subsystem there is skb->truesize.
The concept is exposed to user space through tracepoints and well understood in networking.
May be call this field 'log_truesize' ?
With or without underscore.

Other than this the rest looks good and I believe it addresses Lorenz and Timo concerns.
Would be good to hear from them.
