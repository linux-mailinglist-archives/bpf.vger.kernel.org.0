Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3F2658920
	for <lists+bpf@lfdr.de>; Thu, 29 Dec 2022 04:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbiL2DYr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Dec 2022 22:24:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiL2DYr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Dec 2022 22:24:47 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F1C13CE0
        for <bpf@vger.kernel.org>; Wed, 28 Dec 2022 19:24:46 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id gv5-20020a17090b11c500b00223f01c73c3so17580883pjb.0
        for <bpf@vger.kernel.org>; Wed, 28 Dec 2022 19:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kNGQTYnWLO4Ig6hvbrr/vuR2AWwlklQm82CjJ7iLYAQ=;
        b=c56d4QAE4izT+Z62l59UNuQ7edgZ/YKlIr24WL9j/uflo5dZ6caxJGBfmsIW+fiYja
         UWE/adokSQPD3OVttzGEFWE3yd26iYNLDLvmwXZlNOIZRB0fBvWfyIhC2z3P3zlRqm2x
         usc6CkbBKglOe+ghHGDG/w8NdSR1L1MoOIY3pFQCpUHKZyZ7rkHKLlPFNh6HOeD/8R5F
         ktQePTf2qRaSy3Db0t5o/e6dpcvNlh5xqySexDwaimBBygXwPzNwpd6lzv48UB0o1vwM
         e5DwN+idb/q182rGx93Izlj3/7AqLnXzll4D8GBTjIXi21zx5GRfJU0s2U4CcayaNVyO
         5qbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNGQTYnWLO4Ig6hvbrr/vuR2AWwlklQm82CjJ7iLYAQ=;
        b=Z85JSRUoEL91U7+I88EnRu2JBnjJOmUVmscB7V6gHySZdTx8pX6YKxZVkZ49KmwJcb
         JnYmGiS7sPHtlbjnid4JDvVNKqRh1w5iynhwcds6tqtLVHyQDierI+K+4JfoDpD0KwOv
         DWSDfALcSvq49sGiOFmrTf7oIJKb5CofxDp5o9CpCozlFCjGN9g5PDzjnZs+tY3wkgBU
         bXM4mtoUQHXgXlAYkWtizSOILgFwo9FqdDt6nS+i7VsY8dr0Uo+xsBqQQRyuaI0HxkSV
         zdj25ftxlr3hNZj5EacwRDrl9tFMV0xjjPl0BaCacI08b8JWCTHN6h3VBvxO/ZEHwBEe
         JLpQ==
X-Gm-Message-State: AFqh2ko/I5Ya+4O/SH0jtYSNYKFxIjse8GjbtuUTWO3CAHUBTqTPUD8p
        8U+0LoWHVmjm8QpTXtJF0pOmCbw6XIM=
X-Google-Smtp-Source: AMrXdXuy1Sonp41ytd5pdr69T9qt0T7IcktuiBTr3TSxY5nu5p163P1+eeTsFNJgSxIGlgxZB53PrA==
X-Received: by 2002:a17:902:ccc4:b0:186:e434:6265 with SMTP id z4-20020a170902ccc400b00186e4346265mr33535920ple.2.1672284285495;
        Wed, 28 Dec 2022 19:24:45 -0800 (PST)
Received: from MacBook-Pro-6.local ([2620:10d:c090:400::5:e38b])
        by smtp.gmail.com with ESMTPSA id p8-20020a170902780800b0017f59ebafe7sm11708329pll.212.2022.12.28.19.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 19:24:44 -0800 (PST)
Date:   Wed, 28 Dec 2022 19:24:42 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 bpf-next 01/13] bpf: Support multiple arg regs w/
 ref_obj_id for kfuncs
Message-ID: <20221229032442.dkastsstktsxjymb@MacBook-Pro-6.local>
References: <20221217082506.1570898-1-davemarchevsky@fb.com>
 <20221217082506.1570898-2-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221217082506.1570898-2-davemarchevsky@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Dec 17, 2022 at 12:24:54AM -0800, Dave Marchevsky wrote:
> Currently, kfuncs marked KF_RELEASE indicate that they release some
> previously-acquired arg. The verifier assumes that such a function will
> only have one arg reg w/ ref_obj_id set, and that that arg is the one to
> be released. Multiple kfunc arg regs have ref_obj_id set is considered
> an invalid state.
> 
> For helpers, RELEASE is used to tag a particular arg in the function
> proto, not the function itself. The arg with OBJ_RELEASE type tag is the
> arg that the helper will release. There can only be one such tagged arg.
> When verifying arg regs, multiple helper arg regs w/ ref_obj_id set is
> also considered an invalid state.
> 
> Later patches in this series will result in some linked_list helpers
> marked KF_RELEASE having a valid reason to take two ref_obj_id args.
> Specifically, bpf_list_push_{front,back} can push a node to a list head
> which is itself part of a list node. In such a scenario both arguments
> to these functions would have ref_obj_id > 0, thus would fail
> verification under current logic.

Well, I think this patch is unnecessary, because there is really no need
to mark lish_push as KF_RELEASE.
The verifier still has to do custom checks for both arguments:
list_node and list_head.
They are different enough. The 'generalization' via
KF_RELEASE | KF_RELEASE_NON_OWN is quite confusing.
Especially considering how register is being picked: 1st vs 2nd.
More details on this in the other reply to patch 2.
