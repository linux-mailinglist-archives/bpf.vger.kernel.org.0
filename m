Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC8B6316D7
	for <lists+bpf@lfdr.de>; Sun, 20 Nov 2022 23:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiKTW32 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Nov 2022 17:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiKTW31 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Nov 2022 17:29:27 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9255315FE4
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 14:29:26 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id b29so9706263pfp.13
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 14:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+y9zoAJ02P+qTFlsZZbSVrw4Q5Nu6Z+3Dm+dv7mQ8Ps=;
        b=lvXVHjxinZwVGkPhgP23d7HLDPV2WKCIVMpfaDHlC6irDiaSvabCNoXF5KwdIYBreT
         lWOD0IPWZLvNIkAcjN6GspGVGrQQz8VsCGRLOprc9AF0sqL/cWP2yzY6UDZKFjxHy27H
         4gKUu95dARjVWJuKA8lGamRREzjxmLUIu3SQJqz2gVOv4ueotho+QjqohmpZjmgWkSh9
         j5FUIoDIRyW4sG2+YMAkoqAs7ypGNyCD/D8Ar19aELePrwxdD5tn6nXHvogaSLxd0nI+
         y9DjCcdu4nDK+cDB+absoDSHAl2cDn6Xk11MLrW4zanMlXrITe61bpLd7igX0gUz9sy6
         gzcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+y9zoAJ02P+qTFlsZZbSVrw4Q5Nu6Z+3Dm+dv7mQ8Ps=;
        b=OecJsNnD875WT9xhOtLNZmhVERj3zRoRfogp9+Mdi0DjcWkeUsp70NTO04jLShJrZk
         wVwaJ8TaOo7+yohwt1T1/55APvkP/UdiKv8SAoEhYFuws02tH2NlY7JE4bVuFyIlCHFD
         NVqDFViUEH2oYUP0lVGVd169i0uy67bvGFTf/Mo8V86qERAX48hlQHHxmCV7XGH/z1jM
         FtaQDASOqWS2/QG8FpFC8GOiJYQW1YWvFhfiBPAFR19BX2c/PukCYzILOiQjvVwnTURp
         S7j4yIya9IxA6lw/xDRLrj14Jw1rmO8iZ0pnof6DZTXHB3t7fVPRjBhdOlGBqmTkCmyt
         SNeg==
X-Gm-Message-State: ANoB5pkH1QhrkvrKEEdAGKqv7M3ZOwZxNq7H66b/T1dTJQqNJMwlnyhR
        p06ekraQ3pzmXcZH91LVpss=
X-Google-Smtp-Source: AA0mqf6rI3XV3mXYiKaD2KuTVQgAiK4B52i2ILNpN2jC+M5IfdjQv3gN1mNutL6kTCL7F/5Ks2lkEQ==
X-Received: by 2002:aa7:83c1:0:b0:563:b60:b097 with SMTP id j1-20020aa783c1000000b005630b60b097mr17509540pfn.36.1668983365210;
        Sun, 20 Nov 2022 14:29:25 -0800 (PST)
Received: from macbook-pro-5.dhcp.thefacebook.com ([2620:10d:c090:400::5:7165])
        by smtp.gmail.com with ESMTPSA id q13-20020a170902f78d00b001801aec1f6bsm8092687pln.141.2022.11.20.14.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 14:29:24 -0800 (PST)
Date:   Sun, 20 Nov 2022 14:29:22 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Disallow calling bpf_obj_new_impl
 on bpf_mem_alloc_init failure
Message-ID: <20221120222922.udsuzkr5hcvjzot5@macbook-pro-5.dhcp.thefacebook.com>
References: <20221118185938.2139616-1-memxor@gmail.com>
 <20221118185938.2139616-2-memxor@gmail.com>
 <CAADnVQLKwfr_UiLEc-5exQGd3saeuYUX2j8BHzAtBgZovUpCGA@mail.gmail.com>
 <20221120204625.ndtr7ygh7zgjxrsz@apollo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221120204625.ndtr7ygh7zgjxrsz@apollo>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 21, 2022 at 02:16:25AM +0530, Kumar Kartikeya Dwivedi wrote:
> 
> > Also please get rid of special_kfunc_set and
> > and btf_id_set_contains(&special_kfunc_set, meta.func_id)
> > That additional check is unnecessary as well.
> > special_kfunc_list is enough.
> 
> It provides an easy way to do 'btf == vmlinux && is_special_kfunc'.
> Otherwise if I drop it, every check matching func_id == special_kfunc_list will
> also have to do btf == vmlinux check (because eventually we want to drop to the
> other branches that should work for non-vmlinux BTF as well).
> 
> What I mean is:
> 	if (btf == vmlinux && btf_id_set_contains(special_kfunc_set)) {
> 		if (func_id == special_kfunc_list) {
> 		} else if (func_id == special_kfunc_list) {
> 		} else {
> 		}
> 	} else if (!__btf_type_is_struct) {
> 	} else /* struct */ {
> 	}
> 
> will become:
> 	if (btf == vmlinux && func_id == special_kfunc_list) {
> 	} else if (btf == vmlinux && func_id == special_kfunc_list) {
> 	} else if (!__btf_type_is_struct) {
> 	} else /* struct */ {
> 	}

One less indent looks better.
Repeated btf == vmlinux doesn't bother me.
There is no use for this special_kfunc_set. It just wastes memory.
So I still think it's better to remove it.

While at it please swap branches !__btf_type_is_struct to __btf_type_is_struct:
  else if (__btf_type_is_struct) {
    regs[BPF_REG_0].type = PTR_TO_BTF_ID
  } else { // handle 'void *' return aka r0_size
would read better.
