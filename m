Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCBC272E1D
	for <lists+bpf@lfdr.de>; Mon, 21 Sep 2020 18:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbgIUQqa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Sep 2020 12:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbgIUQq0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Sep 2020 12:46:26 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF1DC061755
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2020 09:46:25 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id k13so9257469pfg.1
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2020 09:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Ym7IY74jegn0Dk0i7hDIlNPbZzleyDkjidatfZH60LY=;
        b=azDDVhnwoU5GSbIHRZc2IoDe6WZVGfSCWHnQTKCax8eAGLW1ET77B9Q0odDFY99pt5
         WjICbb6rNIW23ylmO+g+D5L6LQgT9DM3L/UE5yr8oqYC1J8Gnupy/3yn7mk/M8Nti9Ql
         wRtls1blDsD6EaJ3WTz32AErV3lO7mzIfR5WuGtRAKCkye6F7IaMKjwLtRrd2FQgk6R8
         qmZtJnX7zTls12084wUezCENMHbmELSLbHtH+bVXokntyNMc8gWG1Gu6kgnHYgnVkeBj
         KbTB2gy9A8t7ei+6i54vEDi9EQeNTW/q2ZZS9nhTSXxUwA7TwzJvOi/4UEkE+3nE1Ofu
         fFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Ym7IY74jegn0Dk0i7hDIlNPbZzleyDkjidatfZH60LY=;
        b=WnlZMk+IGhTrRHLVyj+kuRR36aCt0k8aNNw9B2g4ZIUKJzB8AE/n/QRLSNyHs2v7nS
         ytyHKav3/WwiuFvfvZGb53V+gskpSN0pQgCa7RBnAa7bXmLDVLwmifN7bdG+tiH2C5D2
         /6A4Crrv52zVFxNxfWVdK1+pykaeSJC2p6SkuW+fn7qyRLUjOKnKuPjp1yDlQzHD+N4S
         lZsd+z3K738aDmmhcObzQ20i2UBktIeCjuQ7Njy1WY3EaYbDNHZWm/Lz41DVSLufVUGL
         A42P6+xRx8lroQD7n1BzCBGpxPbOXPzXHjJg3I9e5wmHR5Ih/FBS37MbZlar6WF8oFw6
         B4XQ==
X-Gm-Message-State: AOAM531jIIP6ebzofTCl1C7gvWE/UZ6BM2iOWHJSWovLdtgfLpNJJGGb
        n8gYZmsLVf/zzO+iDuDvkybqDkF5WxxeGg==
X-Google-Smtp-Source: ABdhPJxdZHY3GIPA992M4smiUFEchBJS5X94zrriTsSQvLtwngM1n2K3Mxg6XYiKYnv2XU2IO/xQaw==
X-Received: by 2002:a05:6a00:1507:b029:13e:d13d:a13c with SMTP id q7-20020a056a001507b029013ed13da13cmr709258pfu.36.1600706784191;
        Mon, 21 Sep 2020 09:46:24 -0700 (PDT)
Received: from localhost ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id x198sm11654175pgx.28.2020.09.21.09.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 09:46:23 -0700 (PDT)
Date:   Mon, 21 Sep 2020 09:46:16 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Florian Lehner <dev@der-flo.net>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net,
        Florian Lehner <dev@der-flo.net>
Message-ID: <5f68d8d8b3a7e_1737020895@john-XPS-13-9370.notmuch>
In-Reply-To: <20200920101935.57378-1-dev@der-flo.net>
References: <20200920101935.57378-1-dev@der-flo.net>
Subject: RE: [PATCH bpf-next] bpf: lift hashtab key_size limit
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Florian Lehner wrote:
> Currently key_size of hashtab is limited to MAX_BPF_STACK.
> 
> As the key of hashtab can also be a value from a per cpu map it can be
> larger than MAX_BPF_STACK.
> ---

Will need a signed-off-by line at minimum.

>  kernel/bpf/hashtab.c                    | 16 +++++-----------
>  tools/testing/selftests/bpf/test_maps.c |  2 +-
>  2 files changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index fe0e06284..fcac16cd4 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -390,17 +390,11 @@ static int htab_map_alloc_check(union bpf_attr *attr)
>  	    attr->value_size == 0)
>  		return -EINVAL;
>  
> -	if (attr->key_size > MAX_BPF_STACK)
> -		/* eBPF programs initialize keys on stack, so they cannot be
> -		 * larger than max stack size
> -		 */
> -		return -E2BIG;
> -
> -	if (attr->value_size >= KMALLOC_MAX_SIZE -
> -	    MAX_BPF_STACK - sizeof(struct htab_elem))
> -		/* if value_size is bigger, the user space won't be able to
> -		 * access the elements via bpf syscall. This check also makes
> -		 * sure that the elem_size doesn't overflow and it's
> +	if ((attr->key_size + attr->value_size) >= KMALLOC_MAX_SIZE -
> +	    sizeof(struct htab_elem))
> +		/* if key_size + value_size is bigger, the user space won't be
> +		 * able to access the elements via bpf syscall. This check
> +		 * also makes sure that the elem_size doesn't overflow and it's
>  		 * kmalloc-able later in htab_map_update_elem()
>  		 */
>  		return -E2BIG;
> diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
> index 754cf6117..9b2a096f0 100644
> --- a/tools/testing/selftests/bpf/test_maps.c
> +++ b/tools/testing/selftests/bpf/test_maps.c
> @@ -1225,7 +1225,7 @@ static void test_map_large(void)
>  {
>  	struct bigkey {
>  		int a;
> -		char b[116];
> +		char b[4096];
>  		long long c;
>  	} key;
>  	int fd, i, value;
> -- 
> 2.26.2
> 

Also how about adding a test for bpf side this just updates the key
from user side iirc. I would want a test to do the per cpu update from
BPF side as well.
