Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958CE67FAF8
	for <lists+bpf@lfdr.de>; Sat, 28 Jan 2023 21:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjA1Utj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 28 Jan 2023 15:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjA1Uti (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 28 Jan 2023 15:49:38 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870D47A99
        for <bpf@vger.kernel.org>; Sat, 28 Jan 2023 12:49:37 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id rm7-20020a17090b3ec700b0022c05558d22so7782373pjb.5
        for <bpf@vger.kernel.org>; Sat, 28 Jan 2023 12:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TmAHU2aWdzYRmjNMiGoIWy7cs0wnGrLYejiYWETzIUc=;
        b=bclcCxpLTJGT9AcvbE+X9k6zJJE2ps+Oz7gYlA1JFj8sH+G06foPAkcIGjSJKyecy1
         KAkXYHHyBIJSMai6pw833ZMEQ82x1pbM6tXF9GJDhVH3IY4b/CqgeIsnmojE9KlqwZ/E
         XL40K/dIGfIHjA44+7Si1CsC6nUUHZXkcMn2Nh/CjlIt9vffpGuaWgl+24o5ruQ9RXlL
         /DvBkTtLefLiMWV0ubzNWD6PniLjASGnltdnxDeTIbiq5r6DUeaq83iUqFWcr+jclHrt
         6Xn7Dvjgf1BwpPqDuxGY2gewL7chf3CWyzu2MbDHhWmQvBL7XStyqx0nST7Fyz27hd7Y
         TGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TmAHU2aWdzYRmjNMiGoIWy7cs0wnGrLYejiYWETzIUc=;
        b=VqcDCfzp7AKkuvNxWB2o+2Nq5FE1hex/rp96FN310ZK65iVS3AZnaBRcptWNsjLOD+
         9Vs8Eb1EHtu0IVXx7WyUgNiJtaNA56zx21VF6/9utVLxH3rG6b0v6iXUDS06hBdOHn6b
         c/vk/aekSlFQLB5/AC0I/cI5Ta/+IrseQCgYtbcZLD1oLJ2GI9nfGlRBej3Zw5fy/rr6
         aVhsgKLS3bpRuglgKd0399hzCavpGoZ0cNuLsPCUNN26zj0Bu+s1rfUQJqxfQAFg5n3U
         2MR2NdK55ob8TPKHiDiMivjjI+FrZmObpHdpTwtyzOpvGdynseejch3QlWS/eHl+HAwT
         +ncA==
X-Gm-Message-State: AO0yUKV4vf0YB3bwJwKNHxlJOeNu/1M4pKdxfSV/FgMNmJNFQXLSjYxV
        VaQTRf11e3O2VTuMDtYHB4+vJBSeZto=
X-Google-Smtp-Source: AK7set+fqu4yCicQ1y1fZANV1sSfC53JRidFIi7kIvvUtDWo0Re1FOljgYBUf74ILEGxuhp/ICq7kw==
X-Received: by 2002:a17:90a:1a15:b0:22c:912:b80d with SMTP id 21-20020a17090a1a1500b0022c0912b80dmr15657065pjk.33.1674938976976;
        Sat, 28 Jan 2023 12:49:36 -0800 (PST)
Received: from MacBook-Pro-6.local ([2620:10d:c090:400::5:d8f1])
        by smtp.gmail.com with ESMTPSA id l15-20020a17090a660f00b0022c147850cbsm4837396pjj.36.2023.01.28.12.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jan 2023 12:49:36 -0800 (PST)
Date:   Sat, 28 Jan 2023 12:49:33 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH bpf-next v2 03/31] selftests/bpf: Query
 BPF_MAX_TRAMP_LINKS using BTF
Message-ID: <20230128204933.6uzlvt45dpgi7zik@MacBook-Pro-6.local>
References: <20230128000650.1516334-1-iii@linux.ibm.com>
 <20230128000650.1516334-4-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230128000650.1516334-4-iii@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jan 28, 2023 at 01:06:22AM +0100, Ilya Leoshkevich wrote:
> diff --git a/tools/testing/selftests/bpf/prog_tests/trampoline_count.c b/tools/testing/selftests/bpf/prog_tests/trampoline_count.c
> index 564b75bc087f..416addbb9d8e 100644
> --- a/tools/testing/selftests/bpf/prog_tests/trampoline_count.c
> +++ b/tools/testing/selftests/bpf/prog_tests/trampoline_count.c
> @@ -2,7 +2,11 @@
>  #define _GNU_SOURCE
>  #include <test_progs.h>
>  
> +#if defined(__s390x__)
> +#define MAX_TRAMP_PROGS 27
> +#else
>  #define MAX_TRAMP_PROGS 38
> +#endif

This was a leftover from v1. I've removed it while applying.

Also dropped sk_assign fix patch 18, since it requires 'tc'
to be built with libbpf which might not be the case.
Pls figure out a different fix.

Pushed the first 26-1 patches. The last few need a respin to fix a build warn.
Thanks! Great stuff.
