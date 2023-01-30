Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5071681777
	for <lists+bpf@lfdr.de>; Mon, 30 Jan 2023 18:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237792AbjA3RUo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Jan 2023 12:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236733AbjA3RUn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Jan 2023 12:20:43 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359D342BD5
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 09:20:42 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id 88so11695259pjo.3
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 09:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C82U95KCSXi2BH0rszJpP0O1OKELhnHte1DLWPVwgM0=;
        b=VCIFpt9uNnv/HJWeNc22Dl4/NekPyeIFcpq2O888rgx84aM/xZ5p+ya6fkzfua2JjS
         ADgL75+wV25OAu1RE4I18kOm/qrvgfrb8IoEeRpm5rrqW+mHG3CZQ0vGWZUAdP6lRg28
         02PJ/SVpvIEpeILwkJEKH3BoGApgQ9dM7Te41D4SprksJChaHs30u1BSWXtONYlEIb7d
         lQvrdESwweuHSvAegraNpl5gnYd5xiM171hWbl5xsmx+dcj/CUCUfDfPQKELgua15GU5
         7TQbuJwS1oYu1HIh0zhWMMqiS9w8ir5o2ypjTCqLiOIWrrXnzZ6wNH+GHKb/zlI1FUtj
         BmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C82U95KCSXi2BH0rszJpP0O1OKELhnHte1DLWPVwgM0=;
        b=nfliSwCjAnzAo+B0U7JqMaZB6Lxy/CCp0sedf8ZLL+0q8N9B5JjBYKZ6ukReYUf4l9
         BtbygGRvk+7nO2lq91x3mwHyJwY7VbPyZv1S4+36gBLZ9qkgWqhthY1NcEsT4t8CMysh
         T5GrUbE9qEvPiXc+rK+88y2pNMUDkJyNkaJBd8+1ZkXTyoaKwPoaHO7Gg0Dok+2l3/hC
         BpeHkMYWFSAkfy/jvSAcDvOkAmXu5exJDbIKJ5OILt0bXlGWN92q6zcIyIIRGXnhdUEh
         2lHTDgXAEo2647JOKIT5CArQQmmjRZHXDtB3KiMVHm9o4oK0w4Zx6eOl1GOm9BYNlkHj
         MRIQ==
X-Gm-Message-State: AO0yUKXOpuCVCc4bGbfKUWWsFuWsw7T/Ov2H40yYDFGgQZktOcoe/PDy
        Blb604BjZDlIR1Hfk09LClNDxDsTB1w=
X-Google-Smtp-Source: AK7set9osU4irWtF2lLo0hrJrbNleRVyjgQq4K26GLDq4EsM1iKkhy7fGxLAC+V1prEmtGKjz/OwJw==
X-Received: by 2002:a17:903:1c8:b0:192:d230:6778 with SMTP id e8-20020a17090301c800b00192d2306778mr11904322plh.13.1675099241460;
        Mon, 30 Jan 2023 09:20:41 -0800 (PST)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:a52d])
        by smtp.gmail.com with ESMTPSA id s9-20020a170902ea0900b0019311ec72e8sm7690918plg.253.2023.01.30.09.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 09:20:40 -0800 (PST)
Date:   Mon, 30 Jan 2023 09:20:37 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     acme@kernel.org, yhs@fb.com, ast@kernel.org, olsajiri@gmail.com,
        eddyz87@gmail.com, sinquersw@gmail.com, timo@incline.eu,
        daniel@iogearbox.net, andrii@kernel.org, songliubraving@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org, sdf@google.com,
        haoluo@google.com, martin.lau@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 dwarves 5/5] btf_encoder: delay function addition to
 check for function prototype inconsistencies
Message-ID: <20230130172037.vbe55faqcrkkxbge@macbook-pro-6.dhcp.thefacebook.com>
References: <1675088985-20300-1-git-send-email-alan.maguire@oracle.com>
 <1675088985-20300-6-git-send-email-alan.maguire@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1675088985-20300-6-git-send-email-alan.maguire@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 30, 2023 at 02:29:45PM +0000, Alan Maguire wrote:
> There are multiple sources of inconsistency that can result in
> functions of the same name having multiple prototypes:
> 
> - multiple static functions in different CUs share the same name
> - static and external functions share the same name
> 
> Here we attempt to catch such cases by finding inconsistencies
> across CUs using the save/compare/merge mechanisms that were
> previously introduced to handle optimized-out parameters,
> using it for all functions.
> 
> For two instances of a function to be considered consistent:
> 
> - number of parameters must match
> - parameter names must match
> 
> The latter is a less strong method than a full type
> comparison but suffices to match functions.
> 
> With these changes, we see 278 functions removed due to
> protoype inconsistency.  For example, wakeup_show()
> has two distinct prototypes:
> 
> static ssize_t wakeup_show(struct kobject *kobj,
>                            struct kobj_attribute *attr, char *buf)
> (from kernel/irq/irqdesc.c)
> 
> static ssize_t wakeup_show(struct device *dev, struct device_attribute *attr,
>                            char *buf)
> (from drivers/base/power/sysfs.c)
> 
> In some other cases, the parameter comparisons weed out additional
> inconsistencies in "."-suffixed functions across CUs.
> 
> We also see a large number of functions eliminated due to
> optimized-out parameters; 2542 functions are eliminated for this
> reason, both "."-suffixed (1007) and otherwise (1535).

imo it's a good thing.

> Because the save/compare/merge process occurs for all functions
> it is important to assess performance effects.  In addition,
> prior to these changes the number of functions ultimately
> represented in BTF was non-deterministic when pahole was
> run with multiple threads.  This was due to the fact that
> functions were marked as generated on a per-encoder basis
> when first added, and as such the same function could
> be added multiple times for different encoders, and if they
> encountered inconsistent function prototypes, deduplication
> could leave multiple entries in place for the same name.
> When run in a single thread, the "generated" state associated
> with the name would prevent this.
> 
> Here we assess both BTF encoding performance and determinism
> of the function representation in baseline compared to with
> these changes.  Determinism is assessed by counting the
> number of functions in BTF.  Comparisons are done for 1,
> 4 and 8 threads.
> 
> Baseline
> 
> $ time LLVM_OBJCOPY=objcopy pahole -J vmlinux
> 
> real	0m18.160s
> user	0m17.179s
> sys	0m0.757s
> 
> $ grep " FUNC " /tmp/vmlinux.btf.base |awk '{print $3}'|sort|wc -l
> 51150
> $ grep " FUNC " /tmp/vmlinux.btf.base |awk '{print $3}'|sort|uniq|wc -l
> 51150
> 
> $ time LLVM_OBJCOPY=objcopy pahole -J -j4 vmlinux
> 
> real	0m8.078s
> user	0m17.978s
> sys	0m0.732s
> 
> $ grep " FUNC " /tmp/vmlinux.btf.base |awk '{print $3}'|sort|wc -l
> 51592
> $ grep " FUNC " /tmp/vmlinux.btf.base |awk '{print $3}'|sort|uniq|wc -l
> 51150
> 
> $ time LLVM_OBJCOPY=objcopy pahole -J -j8 vmlinux
> 
> real	0m7.075s
> user	0m19.010s
> sys	0m0.587s
> 
> $ grep " FUNC " /tmp/vmlinux.btf.base |awk '{print $3}'|sort|wc -l
> 51683
> $ grep " FUNC " /tmp/vmlinux.btf.base |awk '{print $3}'|sort|uniq|wc -l
> 51150

Ouch. I didn't realize it is so random currently.

> Test:
> 
> $ time LLVM_OBJCOPY=objcopy pahole -J  vmlinux
> 
> real	0m19.039s
> user	0m17.617s
> sys	0m1.419s
> $ bpftool btf dump file vmlinux | grep ' FUNC ' |sort|wc -l
> 49871
> $ bpftool btf dump file vmlinux | grep ' FUNC ' |sort|uniq|wc -l
> 49871
> 
> $ time LLVM_OBJCOPY=objcopy pahole -J -j4 vmlinux
> 
> real	0m8.482s
> user	0m18.233s
> sys	0m2.412s
> $ bpftool btf dump file vmlinux | grep ' FUNC ' |sort|wc -l
> 49871
> $ bpftool btf dump file vmlinux | grep ' FUNC ' |sort|uniq|wc -l
> 49871
> 
> $ time LLVM_OBJCOPY=objcopy pahole -J -j8 vmlinux
> 
> real	0m7.614s
> user	0m19.384s
> sys	0m3.739s
> $ bpftool btf dump file vmlinux | grep ' FUNC ' |sort|wc -l
> 49871
> $ bpftool btf dump file vmlinux | grep ' FUNC ' |sort|uniq|wc -l
> 
> So there is a small cost in performance, but we improve determinism
> and the consistency of representation.

This is a great fix.

I'm not an expert in this code base, but patches look good to me.
Thank you for fixing it.

> For now it is better to have an incomplete representation
> that more accurately reflects the actual function parameters
> used, removing inconsistencies that could otherwise do harm.

+1
