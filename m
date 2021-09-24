Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED44417E15
	for <lists+bpf@lfdr.de>; Sat, 25 Sep 2021 01:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbhIXXOt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Sep 2021 19:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245569AbhIXXOt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Sep 2021 19:14:49 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE933C061571
        for <bpf@vger.kernel.org>; Fri, 24 Sep 2021 16:13:15 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id k17so10173953pff.8
        for <bpf@vger.kernel.org>; Fri, 24 Sep 2021 16:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x0w08LHEdal3YJBxFIDxEaV3SmaBuxp6w/CY8MHo7DA=;
        b=PONCy9KdB96rrDNCreGByZPpD9khEP3qDHpZt5vESK5sQ1aKDNnMOb8gvoHP2Pqhmo
         wZKccMEd/jIskCMT45NzYebiX54ZEdqnmrLB+XXrzyf6HZthAFvZt1NGS4z1HokxN7rV
         NZkUs0wREf54PbwpZBG1yc9LDCdA4NvACKb7sFQBtNL5Q/+RheFeKI6XiuGfKlnuWHkp
         1sCdytYs/CaGJ+1k6XDRhpV0vch7HUVNcEOesDPny/lOp6yTlQ51IcOwJNx706zvGRH2
         Bmh89FXswt41UXmGbDiGTHr4+k0Z9Ruq6ndYYawt2mskblVXH5bnWUYjxjIjWxzxpsNe
         Trww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x0w08LHEdal3YJBxFIDxEaV3SmaBuxp6w/CY8MHo7DA=;
        b=CAzH1ta40zExXc36N1txoBoCCCNFy9xA9JFVPiVZXrjlxQ8Tp3+QgOF7qZzANvhXIN
         wz3C3r0vCnXVYRNwbOjZ0tOEm+t0W/Kehm+LP5dpJ/Wk5M4f4UO0EtvOLmQn42sHrCTu
         VvFu8WANT2dUqZ5zxDfF5RbUFaYAWR78mdZV8M8e3f/4pacv/LnZzG6VEytnek8CmLV8
         08/beGUEDjo9OffbhswlpK6+IdJhOBAbNhkZ0fhFnx3/0Xy56D6+8pv8zyqLLTM8HljB
         F0I1jAtdqhc7XKY6S7HkbE/8x0sEJkTKOFBPwih2l9mrPmmJMYXHAjd2a8MMDRoO1h9F
         I6pw==
X-Gm-Message-State: AOAM530nRBAClMgakjzjKUw1VOuNECDUIGE6xmCotvybafquxqaAVXPC
        xNkgjTis7Em0wx/063N+0/0=
X-Google-Smtp-Source: ABdhPJyUiQPT5k28XJ5x6II6xPWdwhcfqX+Ok5vReRyCQY9gHeSQ7h7k3zqPBiOhhS/CHBBor2TeHw==
X-Received: by 2002:a05:6a00:234f:b0:3eb:3ffd:6da2 with SMTP id j15-20020a056a00234f00b003eb3ffd6da2mr11908970pfj.15.1632525195298;
        Fri, 24 Sep 2021 16:13:15 -0700 (PDT)
Received: from ast-mbp.lan ([2620:10d:c090:400::5:da78])
        by smtp.gmail.com with ESMTPSA id a4sm9345376pjd.48.2021.09.24.16.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 16:13:15 -0700 (PDT)
Date:   Fri, 24 Sep 2021 16:13:13 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        mcroce@microsoft.com, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH RFC bpf-next 00/10] bpf: CO-RE support in the kernel.
Message-ID: <20210924231313.jbg4cs3wk63ii54a@ast-mbp.lan>
References: <20210917215721.43491-1-alexei.starovoitov@gmail.com>
 <CACAyw98puHhO7f=OmEACNaje0DvVdpS7FosLY9aM8z46hy=7ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACAyw98puHhO7f=OmEACNaje0DvVdpS7FosLY9aM8z46hy=7ww@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 23, 2021 at 12:33:58PM +0100, Lorenz Bauer wrote:
> 
> Some questions:
> * How can this handle kernels that don't have built-in BTF? Not a
> problem for myself, but some people have to deal with BTF-less distro
> kernels by using pahole to generate external BTF from debug symbols.
> Can we accommodate that?

I think so, but it probably should be done as a generic feature:
"populate kernel BTF".
When kernel wasn't compiled with BTF there could be a way to
populate it with such. Just like we do sys_bpf(BTF_LOAD)
for program's BTF we can allow populating vmlinux BTF this way.
Unlike builtin BTF it wouldn't be trusted for certain verifier assumptions,
but better than nothing and more convenient than specifying BTF file
on a side for every bpf prog load with traditional libbpf style.
