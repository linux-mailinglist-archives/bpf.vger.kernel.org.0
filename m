Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE205F619F
	for <lists+bpf@lfdr.de>; Thu,  6 Oct 2022 09:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiJFH2F (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Oct 2022 03:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiJFH2D (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Oct 2022 03:28:03 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D7E8993C
        for <bpf@vger.kernel.org>; Thu,  6 Oct 2022 00:28:02 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r13so1246846wrj.11
        for <bpf@vger.kernel.org>; Thu, 06 Oct 2022 00:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ozPeQ8u8yr3gPijCfZ9Xvrl3du7s6/eIXizcwtEXkgU=;
        b=UI3/eoAcRaSxR2j+/FJ73RrTZc4040hHJMig7TDUTJ5qaJ29tl6CEb+J3si3dEFJU5
         lHRJ7XmRlwV+fd3Hy5Kd1ezN5vruqswKArilWkrTEw93EAWX/Z5v9tjjMqaD5Ek6Ibhn
         mN8OnkbWfj5eI/aeIibPPseGnUxt19AHUyst87SK40d5fjFvNQOnoGVs7dEl2l6NOuvt
         WOv57yMIQLs59ORghGfd5S8H1s3UMe7oeODPs+2kQkarO6rgA1xQCEHiCeY/4lcJ/oev
         Nb6QNaA52PlWvELWShU0K9xYwK+4toiUGdQaOwprkyH9lqR5Lb8JXcIypCxks8eKouOn
         QHcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozPeQ8u8yr3gPijCfZ9Xvrl3du7s6/eIXizcwtEXkgU=;
        b=Oj9wXUJnXOmQcKUFjxy5N8lIXe2mrFt8nyJ3k4D8xBUfZtbu8Fd6jEF9Zjh9DoWvKP
         n14Z2002P+EKg7br2aP35AuYBKC3NyJsr9MkHD+oAQ3b9CnKeYZkG2Qw7MamiKi03EyJ
         kljkNhFiRB1O6GvTw87D6L1O8Jzebi0NQKzAuSrfud/n8T9KSm6iXE0ksJ1T8cmjmz91
         an/NKmYO52WVxa626EhkhioqKEwp4T4bOyTcAaYwNm5p01WmdfxYDIG6/hJpSfB9CepE
         YnOzzOpYO1cv8UdzX4oGh0FvBbYG26ByCxQbbI1bfZBXbo47jqQO9HNEJYYsSXS7S9x8
         c+CQ==
X-Gm-Message-State: ACrzQf2TLamr1EfdtI2hkHleW0FwSgpj5Oh3C5S3IDkWmCzZYa69FeOu
        IRswhF1azaPVMN+6eIYztE+ZwN9UpTyahw==
X-Google-Smtp-Source: AMsMyM5zvq10+M2skH464j1V5myXFWuSkFbqi1GhP2VqHnUQKLLzhi7h+BWsu06qLlxV0iMUsnLIvQ==
X-Received: by 2002:a5d:64e9:0:b0:22e:7631:bcab with SMTP id g9-20020a5d64e9000000b0022e7631bcabmr6170wri.36.1665041280991;
        Thu, 06 Oct 2022 00:28:00 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id p3-20020a5d4e03000000b002238ea5750csm20044614wrt.72.2022.10.06.00.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 00:28:00 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 6 Oct 2022 09:27:58 +0200
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
Subject: Re: [PATCH bpf-next] selftests/bpf: Add selftest deny_namespace to
 s390x deny list
Message-ID: <Yz6Dfi2uo0lxyvzO@krava>
References: <20221006053429.3549165-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006053429.3549165-1-yhs@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 05, 2022 at 10:34:29PM -0700, Yonghong Song wrote:
> BPF CI reported that selftest deny_namespace failed with s390x.
> 
>   test_unpriv_userns_create_no_bpf:PASS:no-bpf unpriv new user ns 0 nsec
>   test_deny_namespace:PASS:skel load 0 nsec
>   libbpf: prog 'test_userns_create': failed to attach: ERROR: strerror_r(-524)=22
>   libbpf: prog 'test_userns_create': failed to auto-attach: -524
>   test_deny_namespace:FAIL:attach unexpected error: -524 (errno 524)
>   #57/1    deny_namespace/unpriv_userns_create_no_bpf:FAIL
>   #57      deny_namespace:FAIL
> 
> BPF program test_userns_create is a BPF LSM type program which is
> based on trampoline and s390x does not support s390x. Let add the
> test to x390x deny list to avoid this failure in BPF CI.
> 
> Signed-off-by: Yonghong Song <yhs@fb.com>

lgtm

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  tools/testing/selftests/bpf/DENYLIST.s390x | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
> index 17e074eb42b8..0fb03b8047d5 100644
> --- a/tools/testing/selftests/bpf/DENYLIST.s390x
> +++ b/tools/testing/selftests/bpf/DENYLIST.s390x
> @@ -75,3 +75,4 @@ user_ringbuf                             # failed to find kernel BTF type ID of
>  lookup_key                               # JIT does not support calling kernel function                                (kfunc)
>  verify_pkcs7_sig                         # JIT does not support calling kernel function                                (kfunc)
>  kfunc_dynptr_param                       # JIT does not support calling kernel function                                (kfunc)
> +deny_namespace                           # failed to attach: ERROR: strerror_r(-524)=22                                (trampoline)
> -- 
> 2.30.2
> 
