Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E444B312A
	for <lists+bpf@lfdr.de>; Sat, 12 Feb 2022 00:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353928AbiBKXQG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Feb 2022 18:16:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiBKXQF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Feb 2022 18:16:05 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D37D62
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 15:16:01 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id y17so5826708plg.7
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 15:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tBfH/g0D9S9phqQTYeyZs+Qpi4U5WdXbenxIHQNguPg=;
        b=kJ7d7d0+2ZXqIvxGgTJmV99nYkrmGBPOSzTy+MOj/5wAVKP7vdNbr08AKD9jpNBOGH
         pi50ksW7qQ7M6xOjArKgUPQjrfp3mLG0VNUr18BwxuP4uuIoPmTa6gBqUdV0qQRm44vo
         EC8omZ4R2OhWlkOenGrhDXb8AvhASe/KknjkmBxEuoZLzs0wEW4OnIFaH0UednNthGWn
         1H1bv80uGBFghVd6mJCplSeH6WApOtnxaGf3RSS5YUzP407cVaZXrcNmnfgve2mqSOu0
         8qZ1s3j7PVQ//GlteCgMD4cOlxSEnUfXhAe4449YKrtsTghSvsQecVPZ8PqFEy9Y6UND
         KBtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tBfH/g0D9S9phqQTYeyZs+Qpi4U5WdXbenxIHQNguPg=;
        b=u9LuEfp+6GL+fOGC1RTHY5xgew10MVJ52Gnzy4wcHITW7iGV2zDUdZXkzzmgReUNUM
         Kr3FC43uHSElLhYPvjSP50FJNfeHrbd9Lw6DNg/3QWgDs8RPBQblzAUyawvE6wMim/yu
         C3Eh2TTriBeqCGeX+0x0MmGaW6Ykq4jQSfeS/zjTxi4n5C6RmDILTbu3/eDLp20xmRwS
         +BnxSrXLd0YWQBFvWNfpLt+Cxe7FC9v9nWJfl+FKVrMpgKfPZsATmu1hX59uvBvx7X9J
         Jz1j+J4Fp6DcVHNrsGvam3rg4Oksuo7tSU9agc1TBP8s/W2EP+bHbHgI4WyxepKWLrxW
         CVCA==
X-Gm-Message-State: AOAM5336j3t5f3mCf11pFi8zJvDJLlpn1OhM7TETXmD7Bg88UvOzg3Zv
        dA05CbtYzpUcuQK7htFqHE4=
X-Google-Smtp-Source: ABdhPJxC0ZAOUhYu4t5TqIsJ5muBKkhLwmyVmre2MorNgQSNtKLBCySBh0sVeDPLVPqvOu9HPGe1OQ==
X-Received: by 2002:a17:903:2c5:: with SMTP id s5mr3665169plk.157.1644621361239;
        Fri, 11 Feb 2022 15:16:01 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:eb33])
        by smtp.gmail.com with ESMTPSA id 9sm11301961pfw.62.2022.02.11.15.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 15:16:00 -0800 (PST)
Date:   Fri, 11 Feb 2022 15:15:59 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Subject: Re: [PATCH bpf-next 1/2] bpftool: add C++-specific open/load/etc
 skeleton wrappers
Message-ID: <20220211231559.shm25hmwuuacvvmg@ast-mbp.dhcp.thefacebook.com>
References: <20220211225007.2693813-1-andrii@kernel.org>
 <20220211225007.2693813-2-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211225007.2693813-2-andrii@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 11, 2022 at 02:50:06PM -0800, Andrii Nakryiko wrote:
>  		}							    \n\
>  									    \n\
> -		#endif /* %s */						    \n\
> +		#ifdef __cplusplus					    \n\
> +		struct %1$s *%1$s::open() { return %1$s__open(); }	    \n\
> +		struct %1$s *%1$s::open(const struct bpf_object_open_opts *opts) { return %1$s__open_opts(opts); }\n\

Why two methods? instead of "opts = nullptr" ?
