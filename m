Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E792730C2
	for <lists+bpf@lfdr.de>; Mon, 21 Sep 2020 19:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbgIURQU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Sep 2020 13:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbgIURQU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Sep 2020 13:16:20 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5BFC061755
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2020 10:16:20 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id f18so9837454pfa.10
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2020 10:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Q1UPOcEgn83MFtoVKisPvJ1akrMb+pPB1vXUk5YbCyQ=;
        b=YxNYaSf6q50WlZCqkEDD/WThjuy6xCKlE/3CAo4sWH6cUOJklz08IDs2O31z/ridsf
         +s6zJYDxdmIxh+q4nhkFdY57xWCaV7rIpVHKlmSRwJGN0WJGOprKZPZU1z/WnCVRHuCL
         P9QA/khyL/5ZcE8ZrFxWlbAXOHn/ASxMQK5eDdR70t7M4YY0MzB7aX/GAy8pskxtWqaV
         7OrABiERnL15c4TWtL2ogVGgdqWHBLBkIgXbanQC4j/2hcHR4L6AWH9o0/qaVvbU3e6v
         Q4nZugCTtdOWiNunYkaDA3PuwXCwwaHQ2DXoW8IBvSZikw1UAXfF6PiJZBRMn9HVV/Ai
         0FRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Q1UPOcEgn83MFtoVKisPvJ1akrMb+pPB1vXUk5YbCyQ=;
        b=tjUPP8S2SU8/IKh2+hGhJIKR7xmrrf+iyjgICfgUS48Qvj86xLcZbxN7UrTtkbkK+F
         7gtPwipdURMRCZBu4ImyUDTSA1vkYJlJmkaI8UgVtcRfnqHIMYbKB/zkMCQ+Qf22E708
         U4PdOK+ocef6f0XWLjWiV71mfDH+jZTO8pz7Bld1+bA9XgJrjIHhqLgD2LD2EQRW2HKe
         4xOycwk+sgA3MW8EkLgniqF/vswh0+zR8Dkbl5n3w3mEKOkUvEVm6rs0WKGCuWCnrSPc
         YkwMQjEJhADQyqbrqTJ27PoMOhyGc9cTcefSIpqqv91v9Ml/C24+GrkMrJDtk7+O1fBi
         pTtQ==
X-Gm-Message-State: AOAM533CAVC+37/iyyd4F01T+Md95HguDyhSNzTZhLeTLZHTMiWZVCvQ
        JN0UX6ND3eKWJT0xI9SObNs=
X-Google-Smtp-Source: ABdhPJwxuXGfJWBdStULprTRaygEI3+YCo0Hee3LnCuuZadQ9SByn2r//aqe8s4Te5sRlKDgxcxU9g==
X-Received: by 2002:a63:1f4b:: with SMTP id q11mr490558pgm.444.1600708579614;
        Mon, 21 Sep 2020 10:16:19 -0700 (PDT)
Received: from localhost ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id i187sm12097653pgd.82.2020.09.21.10.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 10:16:19 -0700 (PDT)
Date:   Mon, 21 Sep 2020 10:16:12 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Xin Hao <xhao@linux.alibaba.com>, ast@kernel.org
Cc:     daniel@iogearbox.net, kafai@fb.com, andriin@fb.com,
        xhao@linux.alibaba.com, bpf@vger.kernel.org
Message-ID: <5f68dfdc66b63_1737020879@john-XPS-13-9370.notmuch>
In-Reply-To: <20200920144547.56771-3-xhao@linux.alibaba.com>
References: <20200920144547.56771-1-xhao@linux.alibaba.com>
 <20200920144547.56771-3-xhao@linux.alibaba.com>
Subject: RE: [bpf-next 2/3] sample/bpf: Add log2 histogram function support
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Xin Hao wrote:
> The relative functions is copy from bcc tools
> source code: libbpf-tools/trace_helpers.c.
> URL: https://github.com/iovisor/bcc.git
> 
> Log2 histogram can display the change of the collected
> data more conveniently.
> 
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> ---
>  samples/bpf/common.h | 67 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 samples/bpf/common.h
> 
> diff --git a/samples/bpf/common.h b/samples/bpf/common.h
> new file mode 100644
> index 000000000000..ec60fb665544
> --- /dev/null
> +++ b/samples/bpf/common.h
> @@ -0,0 +1,67 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of version 2 of the GNU General Public
> + * License as published by the Free Software Foundation.
> + */
> +

nit, for this patch and the last one we don't need the text. Just the SPDX
identifier should be enough. Its at least in line with everything we have
elsewhere.

Also if there is a copyright on that original file we should pull it over
as far as I understand it. I don't see anything there though so maybe
not.

> +#define min(x, y) ({				 \
> +	typeof(x) _min1 = (x);			 \
> +	typeof(y) _min2 = (y);			 \
> +	(void) (&_min1 == &_min2);		 \
> +	_min1 < _min2 ? _min1 : _min2; })

What was wrong with 'min(a,b) ((a) < (b) ? (a) : (b))' looks like
below its just used for comparing two unsigned ints?

Thanks.

> +
> +static void print_stars(unsigned int val, unsigned int val_max, int width)
> +{
> +	int num_stars, num_spaces, i;
> +	bool need_plus;
> +
> +	num_stars = min(val, val_max) * width / val_max;
> +	num_spaces = width - num_stars;
> +	need_plus = val > val_max;
> +
> +	for (i = 0; i < num_stars; i++)
> +		printf("*");
> +	for (i = 0; i < num_spaces; i++)
> +		printf(" ");
> +	if (need_plus)
> +		printf("+");
> +}
> +
> +static void print_log2_hist(unsigned int *vals, int vals_size, char *val_type)
> +{
> +	int stars_max = 40, idx_max = -1;
> +	unsigned int val, val_max = 0;
> +	unsigned long long low, high;
> +	int stars, width, i;
> +
> +	for (i = 0; i < vals_size; i++) {
> +		val = vals[i];
> +		if (val > 0)
> +			idx_max = i;
> +		if (val > val_max)
> +			val_max = val;
> +	}
> +
> +	if (idx_max < 0)
> +		return;
> +
> +	printf("%*s%-*s : count    distribution\n", idx_max <= 32 ? 5 : 15, "",
> +		idx_max <= 32 ? 19 : 29, val_type);
> +	if (idx_max <= 32)
> +		stars = stars_max;
> +	else
> +		stars = stars_max / 2;
> +
> +	for (i = 0; i <= idx_max; i++) {
> +		low = (1ULL << (i + 1)) >> 1;
> +		high = (1ULL << (i + 1)) - 1;
> +		if (low == high)
> +			low -= 1;
> +		val = vals[i];
> +		width = idx_max <= 32 ? 10 : 20;
> +		printf("%*lld -> %-*lld : %-8d |", width, low, width, high, val);
> +		print_stars(val, val_max, stars);
> +		printf("|\n");
> +	}
> +}
> -- 
> 2.28.0
> 


