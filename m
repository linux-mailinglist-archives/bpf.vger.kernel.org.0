Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2C06E17CB
	for <lists+bpf@lfdr.de>; Fri, 14 Apr 2023 00:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjDMW6E (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Apr 2023 18:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjDMW6B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Apr 2023 18:58:01 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103431BEA
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 15:57:59 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id b2-20020a17090a6e0200b002470b249e59so5850084pjk.4
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 15:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681426679; x=1684018679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1OFoeNgRZ4+aQgvJwLAE0B32wf8ZriQONaW/mvfw9n0=;
        b=nr6N4Hl1m2lpSdmjov+VvOOGWD/R8StLqEESTlQMq5xMdOqO7SWOX7M7Oi6y9h2X2s
         z0j814cKDV4Aj1O7yrx1zNAY31IonqWW5scduZg079IHZdCUH3imefI/MZ2FJl2duLVV
         PUOHmfsYFVp7nzGQz70HrnJXSOmwB1n9g61mmwLOfawrG3/MOcqeHwBVRD+vz5gWKDWr
         NAX5v7J5SV4gr/sjTPKg4jsUOEOY/I5D5YihB10vN25IdgP8N2Y9L78m+nBqXkvfhvoG
         ePt9qH+EDJZNKF+gn2hfmZbB4XUOLgw19/Y7O7iFNhLrzcMj2u/STM+39VryILklB4Ov
         u2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681426679; x=1684018679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1OFoeNgRZ4+aQgvJwLAE0B32wf8ZriQONaW/mvfw9n0=;
        b=AZnt+qUh30hq+4U+CnCx6mU6ZFKnICFB2FoXG2je5JyE9OK7w+chTpydmmUdLEAUO4
         997waRQmby2UtKP7E5zHClNr3KFNqnIw0BuzHX09Y+4b9j55aV2mRrr/FdQiw/I+fLMc
         QDZQJyeBex7b+gxuF+h77PHQM2RG1fKzk4sxXcAmlg4P5aI3hfcDMy996hhKgyCQ3xiq
         CgUVWH3RTfPfQQcAUilaPf+tKXD46T7l+I5cSqHKhXTgs1Ww6eCO93z5ivH3mLs3Sxlw
         DlEHsXn4JK9j7pPQVHu1XHKMj5J/3MzKDaz+RSHJp1I/RZf+6kv3V12iovCu3B4dALhM
         rHrg==
X-Gm-Message-State: AAQBX9eCTzfS+Yuve+1UI/cL92f5Y+NW3fWJnDHN7dTp32LK5k5ziYb7
        5IxdYCgHy5qS4N4Jo4hTh1vTipTea/k=
X-Google-Smtp-Source: AKy350Yf8k8uCw7aCWzXvx0583S0/cTiSUe3Sqc6COxGW+m52dm2PJZkWs3UD6JXOOnYHVsyWfrdkw==
X-Received: by 2002:a17:90a:a416:b0:240:d3b7:e850 with SMTP id y22-20020a17090aa41600b00240d3b7e850mr3087692pjp.49.1681426679125;
        Thu, 13 Apr 2023 15:57:59 -0700 (PDT)
Received: from dhcp-172-26-102-232.dhcp.thefacebook.com ([2620:10d:c090:400::5:5f5b])
        by smtp.gmail.com with ESMTPSA id jw19-20020a170903279300b0019f3cc463absm1984013plb.0.2023.04.13.15.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 15:57:58 -0700 (PDT)
Date:   Thu, 13 Apr 2023 15:57:56 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v1 bpf-next 4/9] bpf: Add bpf_refcount_acquire kfunc
Message-ID: <20230413225756.3j5z6ko54m4z6gbq@dhcp-172-26-102-232.dhcp.thefacebook.com>
References: <20230410190753.2012798-1-davemarchevsky@fb.com>
 <20230410190753.2012798-5-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230410190753.2012798-5-davemarchevsky@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 10, 2023 at 12:07:48PM -0700, Dave Marchevsky wrote:
> Currently, BPF programs can interact with the lifetime of refcounted
> local kptrs in the following ways:
> 
>   bpf_obj_new  - Initialize refcount to 1 as part of new object creation
>   bpf_obj_drop - Decrement refcount and free object if it's 0
>   collection add - Pass ownership to the collection. No change to
>                    refcount but collection is responsible for
> 		   bpf_obj_dropping it
> 
> In order to be able to add a refcounted local kptr to multiple
> collections we need to be able to increment the refcount and acquire a
> new owning reference. This patch adds a kfunc, bpf_refcount_acquire,
> implementing such an operation.
> 
> bpf_refcount_acquire takes a refcounted local kptr and returns a new
> owning reference to the same underlying memory as the input. The input
> can be either owning or non-owning. To reinforce why this is safe,
> consider the following code snippets:
> 
>   struct node *n = bpf_obj_new(typeof(*n)); // A
>   struct node *m = bpf_refcount_acquire(m); // B

typo. should probably be bpf_refcount_acquire(n) ?
