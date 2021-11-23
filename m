Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46077459920
	for <lists+bpf@lfdr.de>; Tue, 23 Nov 2021 01:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbhKWA0R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Nov 2021 19:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbhKWA0Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Nov 2021 19:26:16 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3AAC061574
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 16:23:09 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id p17so16688795pgj.2
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 16:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/HuP5TnmTxxykqG+YS65sBTNN49IdQaJyNHdNPGz5Yw=;
        b=qj9aJbuilrarkZQTppFnrjAM9q0JZ0IAliQw9claczCRWCEs2qD1hSFl94tcwS0kb0
         y5BInFUUhWJfGt0SHuV2nF4AHIVDEkLVnPjmkizVLAzzFdrcgdy5ecQhQFmC29/tG0XS
         INwPyguUD3JIDD2qvTYxTDI9GTY9ELwtVfMTs+wGnbplXawccvDYGn51xPptY5Fizf9g
         4pDuW1veFhr6Z20EHXjgPaCnDcIvB/89WshY74hgN2sn3Kn2wjS0GtAo8tFX4wTLC3mA
         AKsE0RZatJsb0GTXwhBTinvwwNMOaYb1OXSSECidXp5Y8a0dsIuY9X5uFSK/oyyLI8cv
         1f8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/HuP5TnmTxxykqG+YS65sBTNN49IdQaJyNHdNPGz5Yw=;
        b=U5jWeetFe3NJmBHvsqU9TMPWmgda/ZTvJdmEPDXJoJLvPiFPWzV4L+aDX69J3ddJ11
         zJeX9vlbKJY//XfUraVOTOLXuZnDY3mEBEu62C6+/5/XLEbGN/c0+GD/roaJwErSUpJj
         DeBMxs8d2oNNH1A4RTtfvJah9byna7sEsFYUURuTCwendzzCzmRsni0ZAFybQ5TId6md
         bfdQRf+g8zSCRNfLeD2izfQUWxHmg118eWgazUqZd7i2wgBnzm+dqE4wZqUCcJdFWqT7
         h7Smvl/FcKvQSvvkgFg+BX7G1Rc0eQ7kXr1XKCX/IheY69gs9H/O2j5ZykDVkbUtj3lx
         sGLg==
X-Gm-Message-State: AOAM531mhJSIrx/9CqsnZ+EiGLpRnYcYYUzG7OX5EyRUQ9QF+dGtCjmk
        d69UCD2uiu+q+CINcAzh0i2kmC817Fc=
X-Google-Smtp-Source: ABdhPJzDR4dnZCNBXc2+xq3Stdu2rHeoPFEd8ycz5OKheaiR454vhjStmQzW1EzULGj5Av85N3Wgxw==
X-Received: by 2002:aa7:9597:0:b0:49f:b04e:e669 with SMTP id z23-20020aa79597000000b0049fb04ee669mr844877pfj.62.1637626988772;
        Mon, 22 Nov 2021 16:23:08 -0800 (PST)
Received: from localhost ([2405:201:6014:d064:3d4e:6265:800c:dc84])
        by smtp.gmail.com with ESMTPSA id h22sm10195846pfv.25.2021.11.22.16.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 16:23:08 -0800 (PST)
Date:   Tue, 23 Nov 2021 05:53:06 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v3 bpf-next 13/13] selftest/bpf: Revert CO-RE removal in
 test_ksyms_weak.
Message-ID: <20211123002306.dng6mv2ryih4qq2j@apollo.localdomain>
References: <20211120033255.91214-1-alexei.starovoitov@gmail.com>
 <20211120033255.91214-14-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211120033255.91214-14-alexei.starovoitov@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Nov 20, 2021 at 09:02:55AM IST, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>
> The commit 087cba799ced ("selftests/bpf: Add weak/typeless ksym test for light skeleton")
> added test_ksyms_weak to light skeleton testing, but remove CO-RE access.
> Revert that part of commit, since light skeleton can use CO-RE in the kernel.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  tools/testing/selftests/bpf/prog_tests/ksyms_btf.c  | 4 ++--
>  tools/testing/selftests/bpf/progs/test_ksyms_weak.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/ksyms_btf.c b/tools/testing/selftests/bpf/prog_tests/ksyms_btf.c
> index 79f6bd1e50d6..988f5db3e342 100644
> --- a/tools/testing/selftests/bpf/prog_tests/ksyms_btf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/ksyms_btf.c
> @@ -101,7 +101,7 @@ static void test_weak_syms(void)
>  	usleep(1);
>
>  	data = skel->data;
> -	ASSERT_EQ(data->out__existing_typed, 0, "existing typed ksym");
> +	ASSERT_GE(data->out__existing_typed, 0, "existing typed ksym");

I think original test (2211c825e7b6b) was doing ASSERT_EQ, since per cpu ptr for
runqueue is from CPU 0.

>  	ASSERT_NEQ(data->out__existing_typeless, -1, "existing typeless ksym");
>  	ASSERT_EQ(data->out__non_existent_typeless, 0, "nonexistent typeless ksym");
>  	ASSERT_EQ(data->out__non_existent_typed, 0, "nonexistent typed ksym");
> @@ -128,7 +128,7 @@ static void test_weak_syms_lskel(void)
>  	usleep(1);
>
>  	data = skel->data;
> -	ASSERT_EQ(data->out__existing_typed, 0, "existing typed ksym");
> +	ASSERT_GE(data->out__existing_typed, 0, "existing typed ksym");
>  	ASSERT_NEQ(data->out__existing_typeless, -1, "existing typeless ksym");
>  	ASSERT_EQ(data->out__non_existent_typeless, 0, "nonexistent typeless ksym");
>  	ASSERT_EQ(data->out__non_existent_typed, 0, "nonexistent typed ksym");
> diff --git a/tools/testing/selftests/bpf/progs/test_ksyms_weak.c b/tools/testing/selftests/bpf/progs/test_ksyms_weak.c
> index 8eadbd4caf7a..5f8379aadb29 100644
> --- a/tools/testing/selftests/bpf/progs/test_ksyms_weak.c
> +++ b/tools/testing/selftests/bpf/progs/test_ksyms_weak.c
> @@ -38,7 +38,7 @@ int pass_handler(const void *ctx)
>  	/* tests existing symbols. */
>  	rq = (struct rq *)bpf_per_cpu_ptr(&runqueues, 0);
>  	if (rq)
> -		out__existing_typed = 0;
> +		out__existing_typed = rq->cpu;
>  	out__existing_typeless = (__u64)&bpf_prog_active;
>
>  	/* tests non-existent symbols. */
> --
> 2.30.2
>

--
Kartikeya
