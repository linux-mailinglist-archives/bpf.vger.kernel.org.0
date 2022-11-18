Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6EA62EC60
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 04:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235132AbiKRDeW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 22:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiKRDeV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 22:34:21 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C61D26108
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 19:34:21 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id g10so3447064plo.11
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 19:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nygd3Mm17elVDOxFjduJudPKFW8KUPoSs97+tQDmQbM=;
        b=ULRA7N14FEhAy9XKP+6/GqJmdjFFpegQiRhxg+x4IDMtYOmr0/DQf+VWkdjjBsjdBJ
         4zU5ircCGdNaXuAZzHs8D21aCL5LCsUaAkYaysGAEyDb28FUienB2k5qP6DxGwse1yCC
         PlFSl2rxNocr+wyHuVBST3Jaoaz3bCJoHtnyzeCcVKo8Id3V4bFGIHDIRyWnwG9eUY4q
         1173Ryy0HcO4PYzW8n4GKKBAIYfBa9uWijB6rcGx6lAvQzF9jOJGUyYWJ/MJ0rZsxFHe
         eDRYJekSiQ9BRKQxSJcfTV6YIP5Aipd/yAPuodQdd/xgEyfid92tpNeojdCOD/ScyA81
         bdwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nygd3Mm17elVDOxFjduJudPKFW8KUPoSs97+tQDmQbM=;
        b=0qj51a34/fGYGd/xOPixlJO8okPUEUWW6mxW6tzj3r2e40j00/AXAhwyExjZ50iyrd
         IABEnbl+dyoJbKcTEn78Dnye+rQ8N68NlcqJjHS1la2AsZdiDcxgHNYT6XsO6pLznCmB
         kZSRACDrncIPdeEGWJD93H73aMOvQU27RnA+iLOlXCvQC/eQxD0HxR1+EiEfGQeQsiW6
         NISQqs+XCLw/u45Rj5ev6xYQtfKakP/5it+M7nZTimD8DjlBkPqPz2xlmxfQR7QeVT8V
         EwVdc21gexMM3749d1gIlJmyWi5gMFHZs/J0vTkzDlUFCrq3RUnf37PbIq+74Xzkv7C0
         0NeQ==
X-Gm-Message-State: ANoB5pkQWO5n4e2FTUqdPJ9fSXHW3GL6BcPXWwyEUk5hRfeCF9r48zps
        zd3T0OhXDuPA92ejaCCNIRE=
X-Google-Smtp-Source: AA0mqf4/PDACrMI7b/IC38oSaeeQZDBHxSua1JcRXHxNqYx6BcFSe3ffR0d5o7kUeOLwvQODyETmtg==
X-Received: by 2002:a17:90b:234d:b0:212:c06c:47ba with SMTP id ms13-20020a17090b234d00b00212c06c47bamr11992621pjb.131.1668742460808;
        Thu, 17 Nov 2022 19:34:20 -0800 (PST)
Received: from MacBook-Pro-5.local ([163.114.132.6])
        by smtp.gmail.com with ESMTPSA id b8-20020a1709027e0800b0016c0c82e85csm2247092plm.75.2022.11.17.19.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 19:34:19 -0800 (PST)
Date:   Thu, 17 Nov 2022 19:34:15 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: Re: [PATCH bpf-next v10 11/24] bpf: Rewrite kfunc argument handling
Message-ID: <20221118033415.vpy2v2ypb4c2n6cn@MacBook-Pro-5.local>
References: <20221118015614.2013203-1-memxor@gmail.com>
 <20221118015614.2013203-12-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118015614.2013203-12-memxor@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 18, 2022 at 07:26:01AM +0530, Kumar Kartikeya Dwivedi wrote:
>  static int btf_check_func_arg_match(struct bpf_verifier_env *env,
>  				    const struct btf *btf, u32 func_id,
>  				    struct bpf_reg_state *regs,
>  				    bool ptr_to_mem_ok,
> -				    struct bpf_kfunc_arg_meta *kfunc_meta,
>  				    bool processing_call)

Something odd here.
Benjamin added the processing_call flag in
commit 95f2f26f3cac ("bpf: split btf_check_subprog_arg_match in two")
and we discussed to remove it.

>  		} else if (ptr_to_mem_ok && processing_call) {

since kfunc bit is gone from here the processing_call can be removed.
ptr_to_mem_ok and processing_call are two bool flags for the same thing, right?

> +static int process_kf_arg_ptr_to_kptr_strong(struct bpf_verifier_env *env,

I fixed this bit while applying.

> +static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_arg_meta *meta)

This function looks much better now.
The split of kfunc vs helper was long overdue.
Thank you for doing this.

I'm not convinced that KF_ARG_* is necessary, but it's much better than before.
So it's a step forward.

Pls watch for CI errors and follow up when necessary.
