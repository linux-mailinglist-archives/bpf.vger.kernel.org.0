Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2ECB4967FC
	for <lists+bpf@lfdr.de>; Fri, 21 Jan 2022 23:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbiAUWsV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Jan 2022 17:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbiAUWsQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Jan 2022 17:48:16 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4651C06173D
        for <bpf@vger.kernel.org>; Fri, 21 Jan 2022 14:48:16 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d1so9952531plh.10
        for <bpf@vger.kernel.org>; Fri, 21 Jan 2022 14:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cBkItqn6+pzbQ3n6/INvQjgQalox3SWLJxljlHnrYrA=;
        b=Xm8UlkmZ09gg6htN80Jcojt5j/TByMziZ77d3uW5byi/J6XmKG/DF6if7NexkDJA2L
         LqQNJ6lNTz3ZIsDP/Mq0b0UC/rRttJit90kyqlTexmUob5LE+luNBUiIHP+DXcGoKA6R
         9ttpTeA9oay46+k7Mu0nmnG9fFACzKgCVY+HcDuvpiI+ocFZkPoaprv2urNe/7RcAoaH
         ihbu7IIQVVoWggqQ+A59VGlsSHgLv527CUdxUoUku89w1CkPZ1WqqPMx4CidsOGNVSWH
         Y+Tud/Xtu9A6+ymvHKnPUD+W9LZJFzUjTjDME2BSaIfB2fg73Zwg4Y14mSqdpSvTz4Ba
         RMnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cBkItqn6+pzbQ3n6/INvQjgQalox3SWLJxljlHnrYrA=;
        b=PIeNDYDFAhhVKztrlTXnkAPAeUYKEEKZVOn7VAkzzXMcDGaF+GktlNnbCx5XMD+fLL
         p3S0zn2wjHGtMf12xOMvZhr4L36/Qffb7gzGvgC4v1mzoDXkk4V0Mt/09jey2mzDzqbh
         1Ya6bUpZjL5SXTxKqlCkp3QY1xaxk2rstTacNbUtIE8Tafb+7fuXLoEo12C5FgV2lLZh
         o4swbQlFlpc7HxUgT7AhNCaFtjjWQ+NebiOpgohoS98lmJXdI4+InPByYa0ZXhx+VSjb
         YJsugr65lNSeTZVcop+Byg8VdA17AlPj/pU9zZG5slyFu0L8EI6ahpNeHalG6VBlfOSy
         SunQ==
X-Gm-Message-State: AOAM531vaauw5JSeNECGp2uf5zGrhs1VFzwFnlddrlp+Uyb19BRodjWy
        gUTfxSXUeD3dO5GUDHl/1xK2ictJ4zU=
X-Google-Smtp-Source: ABdhPJy3KHUQ6iJ1WfE5/afcGLxRuU6Pqtagn9L3gR2CaxPrhhlKxApOPDP08HSF3gnWcfDhyGbawQ==
X-Received: by 2002:a17:90a:be0e:: with SMTP id a14mr2793524pjs.144.1642805296124;
        Fri, 21 Jan 2022 14:48:16 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:8ddf])
        by smtp.gmail.com with ESMTPSA id q4sm8431274pfu.15.2022.01.21.14.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 14:48:15 -0800 (PST)
Date:   Fri, 21 Jan 2022 14:48:13 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Usama Arif <usama.arif@bytedance.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii.nakryiko@gmail.com, fam.zheng@bytedance.com,
        cong.wang@bytedance.com, song@kernel.org
Subject: Re: [RFC bpf-next 0/3] bpf: Introduce module helper functions
Message-ID: <20220121224813.6necsmszanxg5p5e@ast-mbp.dhcp.thefacebook.com>
References: <20220121193956.198120-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121193956.198120-1-usama.arif@bytedance.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 21, 2022 at 07:39:53PM +0000, Usama Arif wrote:
> This patchset is a working prototype that adds support for calling helper
> functions in eBPF applications that have been defined in a kernel module.
> 
> It would require further work including code refractoring (not included in
> the patchset) to rename functions, data structures and variables that are
> used for kfunc as well to be appropriately renamed for module helper usage.
> If the idea of module helper functions and the approach used in this patchset
> is acceptable to the bpf community, I can send a follow up patchset with the
> code refractoring included to make it ready for review.
> 
> Module helpers are useful as:
> - They support more argument and return types when compared to module
> kfunc.

What exactly is missing?

> - This adds a way to have helper functions that would be too specialized
> for a specific usecase to merge upstream, but are functions that can have
> a constant API and can be maintained in-kernel modules.

Could you give an example of something that would be "too specialized" that
it's worth maintaining in a module, but not worth maintaining in the kernel?

Also see:
https://www.kernel.org/doc/html/latest/bpf/bpf_design_QA.html#q-new-functionality-via-kernel-modules

Why do you think we made that rule years ago?
