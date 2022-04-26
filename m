Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4824850EF3A
	for <lists+bpf@lfdr.de>; Tue, 26 Apr 2022 05:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243227AbiDZDeA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Apr 2022 23:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbiDZDdx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Apr 2022 23:33:53 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC96613E14
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 20:30:47 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id v10so3911107pgl.11
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 20:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7Hna/J4oeram2tnv7654xHwO1ayMgrZ1avqTnbhveOg=;
        b=Vgk69vh385OvqdDv/4Af3cDeqle4VZdHNYUAlq6TRf952UrFadM90f6PqOg3S7Gogz
         2xOSfXKEMvUr6bmibMPwuddSviCdFPclf5PkyDKcL2l+AO3HE1sWPBl4037uZWu9b+04
         YVlL5Vc+F5uZSD3PPQBNCBVee326Spcqofdh2Or774NJ1iG9fsvD7MSTWTbKdflbGBqX
         jxQS82gNeP7dFDO81y9ubSwbTM9aaRIiMajmwbU60jvNYUItyD3Zb60RGa3FbCrS9W5e
         hUGojV1Yw8kj0t6IzQBJp5MWi7S9cQO+RUnGd/9AOX7rPt16rvnl0Fd5pi8DVn/xO8n4
         +PdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7Hna/J4oeram2tnv7654xHwO1ayMgrZ1avqTnbhveOg=;
        b=AVeYSh76juh0RCk5ZziFPiLDxYoLDfvHZmEK046SqBrJLWLCB4PF6SuNmnL0htbAde
         eZYwArQ4S3qVCSLEaHWni4LKHUgkaCIqnuA7rkwpVANMpf8VIgTNAzEDEyKtanptHwe4
         XXUmXJOvYAdmJTKIaFTHEC0Syi30ki/LFzgmjkeudhkRwLiqewuZGldrlqUpiuvqyQLC
         gInyfw/kKbIPZhyNGI5ISXi+RJCETUhRyeeSrJb5KONEB9FaeImbMLTGLoK2qAh/VdQx
         8sYTtH36gBTgrAE5WLf67gaJHN4y6Z00+Vc/jEBBrPQyxn0LVhTVg6jl439sqaOEuikB
         f7tQ==
X-Gm-Message-State: AOAM532e04nsjqllkYs+bC3G6laDmuAfEaJMx3uHL8M2hPkubf/Ybh+f
        HsuzSpSz49eyCSe+hju1z6Y=
X-Google-Smtp-Source: ABdhPJzW2ykL2nqvQValHk9x1NJXYPhESA1/mvJ7CX5jJWX+X5ubx9ThY35cmuh0YeYNXxQ/myWvNQ==
X-Received: by 2002:a63:cf0c:0:b0:380:fb66:fa2a with SMTP id j12-20020a63cf0c000000b00380fb66fa2amr17993551pgg.273.1650943847173;
        Mon, 25 Apr 2022 20:30:47 -0700 (PDT)
Received: from MBP-98dd607d3435.dhcp.thefacebook.com ([2620:10d:c090:400::5:438a])
        by smtp.gmail.com with ESMTPSA id h2-20020a17090ac38200b001cd4989feecsm769890pjt.56.2022.04.25.20.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 20:30:46 -0700 (PDT)
Date:   Mon, 25 Apr 2022 20:30:44 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf-next v6 03/13] bpf: Allow storing referenced kptr in
 map
Message-ID: <20220426033044.ifygawcnigdmg25y@MBP-98dd607d3435.dhcp.thefacebook.com>
References: <20220424214901.2743946-1-memxor@gmail.com>
 <20220424214901.2743946-4-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220424214901.2743946-4-memxor@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 25, 2022 at 03:18:51AM +0530, Kumar Kartikeya Dwivedi wrote:
> +
> +static u32 bpf_kptr_xchg_btf_id;
> +
> +const struct bpf_func_proto bpf_kptr_xchg_proto = {
> +	.func         = bpf_kptr_xchg,
> +	.gpl_only     = false,
> +	.ret_type     = RET_PTR_TO_BTF_ID_OR_NULL,
> +	.ret_btf_id   = &bpf_kptr_xchg_btf_id,
> +	.arg1_type    = ARG_PTR_TO_KPTR,
> +	.arg2_type    = ARG_PTR_TO_BTF_ID_OR_NULL | OBJ_RELEASE,
> +	.arg2_btf_id  = &bpf_kptr_xchg_btf_id,
> +};

I've tweaked above with:
+/* Unlike other PTR_TO_BTF_ID helpers the btf_id in bpf_kptr_xchg()
+ * helper is determined dynamically by the verifier.
+ */
+#define BPF_PTR_POISON ((void *)((0xeB9FUL << 2) + POISON_POINTER_DELTA))
+
+const struct bpf_func_proto bpf_kptr_xchg_proto = {
+       .func         = bpf_kptr_xchg,
+       .gpl_only     = false,
+       .ret_type     = RET_PTR_TO_BTF_ID_OR_NULL,
+       .ret_btf_id   = BPF_PTR_POISON,
+       .arg1_type    = ARG_PTR_TO_KPTR,
+       .arg2_type    = ARG_PTR_TO_BTF_ID_OR_NULL | OBJ_RELEASE,
+       .arg2_btf_id  = BPF_PTR_POISON,
