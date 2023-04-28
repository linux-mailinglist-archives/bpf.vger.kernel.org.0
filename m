Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965DD6F1115
	for <lists+bpf@lfdr.de>; Fri, 28 Apr 2023 06:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345164AbjD1Ekf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Apr 2023 00:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjD1Eke (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Apr 2023 00:40:34 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3182110
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 21:40:30 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-51b5490c6f0so8804687a12.0
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 21:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682656830; x=1685248830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l1V2aU456SDh9hWNYQSisKaULp7DN2wniMj7aNaymzU=;
        b=YInHZKfOxVjwpFGV96jlR/8iDPWS9b1awtScGgZ56rHhu/UoT7z/yQG+4wqqbWOp4A
         nRckwtLYIXZoZxWWF/SK0MysqlRWqpuB3lsSp+5SSaG2kPqtUdlZbqPdMR+eTGPCviR2
         hV4T0zx0BaZKKmQSbKHXRopdFQAJcCsXxShrPYF7eFjAtfR5s6oEYPmCwKBoKbbbltM0
         pE5ZO7913aDOF/d8GtGG37wBoNRPY0Vg0kuUe68k5pgL+8SjJjkCOpIeJbvzSpUznNqV
         VZDO1KAPY8y0w5jgmoXmHhNskf+6kEd4xFygcOPcKgpLa6WswbDXi5KdgfKUo5zIt6Ms
         sJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682656830; x=1685248830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1V2aU456SDh9hWNYQSisKaULp7DN2wniMj7aNaymzU=;
        b=TI3cMteTIM3Z4LAlECHwStg7SijP5ck3CqiozNRDBQC834h6nq4J44TxNMeb8+g5ZP
         t7egEm1nMK6E4fqfPyb4iphVf+i/0KWu6q/CR9Xse+7bJm9gGo8igDO3wV1aoEjh8CIk
         seJXhbhk9HeqR+PHungIqM2z90zi1adr2sNmrZNbWK41IzIYYnogpVykCBM9G4KsvEwV
         cZbBndIsspuSPhnLIKxNVJrqziG8JKV+bFDQ4Qp426RbyMNTXFSMj56Y0Vl54Hecga2S
         JlBmnD1uYk87NezWXOOl7/dH/VcNB8XC+nR0dYOTf60q4KDFIDb7lf6WEZ3P+Uimd7Ue
         PpjA==
X-Gm-Message-State: AC+VfDxBqRayZG9O4i6DO0FCXV84Ab5Iqcl9y7ei1ZfUWcM6HuEo01g0
        HIG87HhSEemYuq3kXxTM1WCa5H0bkss=
X-Google-Smtp-Source: ACHHUZ7U+Og2zIDkhvPbR+BpDcdEMRRJhtjdKMst6VARtaMfIfge6SKZjFqx6H9a9zznq36TCBpRBw==
X-Received: by 2002:a17:902:e383:b0:1a5:206:4c88 with SMTP id g3-20020a170902e38300b001a502064c88mr3050857ple.18.1682656829765;
        Thu, 27 Apr 2023 21:40:29 -0700 (PDT)
Received: from worktop ([2600:1700:3ec2:2011:d2f6:3ae7:6438:4ecf])
        by smtp.gmail.com with ESMTPSA id ji9-20020a170903324900b001a1d4a985eesm12411454plb.228.2023.04.27.21.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 21:40:28 -0700 (PDT)
Date:   Thu, 27 Apr 2023 21:40:24 -0700
From:   Manu Bretelle <chantr4@gmail.com>
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com,
        Manu Bretelle <chantra@meta.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Add fexit_sleep to
 DENYLIST.aarch64
Message-ID: <ZEtOOGglKw9F6qpR@worktop>
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
> The remaining tests cannot start. Put this test into DENYLIST.aarch64
> for now so that other tests can continue to run in the CI.
> 
Thanks

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

Acked-by: Manu Bretelle <chantr4@gmail.com>
