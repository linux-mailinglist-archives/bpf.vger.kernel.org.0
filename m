Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD54A6F117E
	for <lists+bpf@lfdr.de>; Fri, 28 Apr 2023 07:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345311AbjD1FvU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Apr 2023 01:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjD1FvN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Apr 2023 01:51:13 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D68630D5
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 22:51:08 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-64115eef620so10123949b3a.1
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 22:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682661068; x=1685253068;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kFe/AO1I9AjmnxCtLn5sEqtrrNWu4IZImwzHRGVbHpY=;
        b=YbfQLNG3dS1DW1Aevm0KWRl034HXOoU3bqE4W/5EtBCJx6fsSudqLr0UtFuNylIgTX
         HA27s4P5qtVfOnnGWpe1Gaibu86jm+jLT34BiBtyvdw4kTFnEYfJ5WfUq5kRlGOp9sAP
         oP9LmIF51GW/mxS7aWHzh3ZcTinVScksVOX/jC4VudBphdjjrBuBIuW7L2acAhANdP/G
         PjNkTRfit5OFp57yRB86AEGm8pHoaat5zd517RYmRSCNFW190wO77swucki+JLH8Ba0Z
         blnS84WG9dcBa9SgbuX9y+PEPGxq3bP6dbpWBB5WWDqPZIjO+r+tI+p2Guc1mzUym6Zb
         GXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682661068; x=1685253068;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kFe/AO1I9AjmnxCtLn5sEqtrrNWu4IZImwzHRGVbHpY=;
        b=Q/sUfdrtADIwgDOOAKZo34NU/4izrb2/xcDhYpIAchchmOMt2QCJNTSzGHn7EEA646
         b7cLpDX/zz7KSrN5SWio8QX02D2m+sgu8hq5Ugr2BfsB1XscdYWKnH5Q0fdJUyJQdO8h
         bOJtL4bA0dOY31iQjwEeP/pBEWPS+wUR5JAzJ/4HcfgssfKQF3R6PIGKkNgl0ZSpaRXH
         9vHi1F2pxtM7dC1g34+XU9zUmZKMrznw3ZPziKovcbBYBn7gHC7infyHKf+uBFIRPc+d
         tHzTkK7bWkrsN+oUme9Q4FQCU4kHG3AG0Sfj9zrnJQRutQRmCCymQ8XXcrhmYzk19FE6
         Fexw==
X-Gm-Message-State: AC+VfDzF1L0rsszJU06Yc0ZJqx84P7Y3mH0ojL0Ft3Rgid7kjSmrdsFE
        rWbJHZWfkDv//XQLycOXHgk=
X-Google-Smtp-Source: ACHHUZ6TiIDGa4WsOP06qAEs6V1NkW+oVbINCikKm35pgNKfnmeIKEhpue+NFYvYSuOeaLD9zRtFIw==
X-Received: by 2002:a05:6a00:1791:b0:63b:8dcc:84de with SMTP id s17-20020a056a00179100b0063b8dcc84demr5849309pfg.4.1682661067639;
        Thu, 27 Apr 2023 22:51:07 -0700 (PDT)
Received: from worktop ([2620:10d:c090:400::5:aa3f])
        by smtp.gmail.com with ESMTPSA id x30-20020a056a000bde00b0063b806b111csm14073592pfu.169.2023.04.27.22.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 22:51:07 -0700 (PDT)
Date:   Thu, 27 Apr 2023 22:51:04 -0700
From:   Manu Bretelle <chantr4@gmail.com>
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com,
        Manu Bretelle <chantra@meta.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Add fexit_sleep to
 DENYLIST.aarch64
Message-ID: <ZEteyNfBuJXlxnhG@worktop>
References: <20230428034726.2593484-1-martin.lau@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428034726.2593484-1-martin.lau@linux.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 27, 2023 at 08:47:26PM -0700, Martin KaFai Lau wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> It is reported that the fexit_sleep never returns in aarch64.

Just to clarify, this was only happening against kernels compiled with
llvm-16. It was working fine against kernel compiled with gcc.

> The remaining tests cannot start. Put this test into DENYLIST.aarch64
> for now so that other tests can continue to run in the CI.
> 
> Reported-by: Manu Bretelle <chantra@meta.com>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> ---
>  tools/testing/selftests/bpf/DENYLIST.aarch64 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing/selftests/bpf/DENYLIST.aarch64
> index 4b6b18424140..cd42e2825bd2 100644
> --- a/tools/testing/selftests/bpf/DENYLIST.aarch64
> +++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
> @@ -1,5 +1,6 @@
>  bpf_cookie/multi_kprobe_attach_api               # kprobe_multi_link_api_subtest:FAIL:fentry_raw_skel_load unexpected error: -3
>  bpf_cookie/multi_kprobe_link_api                 # kprobe_multi_link_api_subtest:FAIL:fentry_raw_skel_load unexpected error: -3
> +fexit_sleep                                      # The test never returns. The remaining tests cannot start.
>  kprobe_multi_bench_attach                        # bpf_program__attach_kprobe_multi_opts unexpected error: -95
>  kprobe_multi_test/attach_api_addrs               # bpf_program__attach_kprobe_multi_opts unexpected error: -95
>  kprobe_multi_test/attach_api_pattern             # bpf_program__attach_kprobe_multi_opts unexpected error: -95
> -- 
> 2.34.1
> 
