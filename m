Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CB563325E
	for <lists+bpf@lfdr.de>; Tue, 22 Nov 2022 02:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbiKVBso (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 20:48:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbiKVBsl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 20:48:41 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAAFE0DE8
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 17:48:31 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id q96-20020a17090a1b6900b00218b8f9035cso3829276pjq.5
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 17:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ke50iDiDggsypuYDz1sOro+BT4BKyvfjzpsUJgvyItc=;
        b=Bj8aNyUS6hb7ZmtjPmacTUGYn/xwruXCB8l0eqh1ZTErG6qm9al4ct66mYrI6JD5yI
         TqODi3umDhB5cYGWjhS++xpEUNFFLkHGrA3B2m4X3ux+J9kzDCrDMGtk9a8bLM5tQWs9
         6N8gZ+K8o3zoyr/p238DvIDPWDeASW4klMSQQ1tTkqJL9m1z59QkCLA6wkZjUs+MMsSB
         tHNcOh9kB7llvPtCopQpeIBrzeHeZMeMq1/ANCh1E4Lb6abC8y1dRni8S8VbcQxC4Glp
         3EON5i5FXEaWfKCvKwyEjLcPBfXD+UUOqobB9vpLta7QCYN0yuSUY83wx+q/VRrBw3VI
         8jDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ke50iDiDggsypuYDz1sOro+BT4BKyvfjzpsUJgvyItc=;
        b=R0hQclt6zS3sDFQn80ou+H5pbubdyzTMn6odBOi51yvr4k0Hw7bbjHxTLdUYkPlUlx
         ZeL2kQFfT0y8wXRm5Z71f6XGTRyIv9Q6XYMRw2AvwgW9udyMFppxXH84zFWuON4da/ET
         NKTGwrFezLmQ4iAgkR9Rs7bBrmo7QhUKSoOReKBPYdcUYsDcvSM3rVTfEAwTBjRBJdGL
         2m3PNXJjUGQL2d2TamtTWUcefYgXd+40SASEXOOZfKo2Nx95WWPOEPQhTlGau1wMqnG6
         jTNzNN7u78ZtT94Nra8K3idTzeUkDxOQpcpQ6YE11PQLmkCRPX6uoqTx1fj3foqUnwVl
         JFhQ==
X-Gm-Message-State: ANoB5pnJnV/YmoyF97yOom3siRpvIU7/3SuWUkRzkQfHs69GvlYvySmW
        pDRTZfYfMjstu8kGr+aryLc=
X-Google-Smtp-Source: AA0mqf6hOQmDWcII1lD3oW6xvNrtOVk756v+09UwGrLr65/3SG+jxqVQ43pHES2JgP2mXddIaIW19Q==
X-Received: by 2002:a17:90a:307:b0:213:dce7:e1fe with SMTP id 7-20020a17090a030700b00213dce7e1femr29699000pje.110.1669081711278;
        Mon, 21 Nov 2022 17:48:31 -0800 (PST)
Received: from localhost ([2605:59c8:6f:2810:f4d9:9612:b71b:8711])
        by smtp.gmail.com with ESMTPSA id j5-20020a170902c3c500b0018853416bbcsm10454901plj.7.2022.11.21.17.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 17:48:30 -0800 (PST)
Date:   Mon, 21 Nov 2022 17:48:28 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Yonghong Song <yhs@meta.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Message-ID: <637c2a6c4b042_18ed92085f@john.notmuch>
In-Reply-To: <2c4f8cac-6935-2c72-cc1b-34a34708e127@meta.com>
References: <20221120195421.3112414-1-yhs@fb.com>
 <637ade2851bc6_99c62086@john.notmuch>
 <2c4f8cac-6935-2c72-cc1b-34a34708e127@meta.com>
Subject: Re: [PATCH bpf-next v4 0/4] bpf: Implement two type cast kfuncs
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yonghong Song wrote:
> 
> 
> On 11/20/22 6:10 PM, John Fastabend wrote:
> > Yonghong Song wrote:
> >> Currenty, a non-tracing bpf program typically has a single 'context' argument
> >> with predefined uapi struct type. Following these uapi struct, user is able
> >> to access other fields defined in uapi header. Inside the kernel, the
> >> user-seen 'context' argument is replaced with 'kernel context' (or 'kctx'
> >> in short) which can access more information than what uapi header provides.
> >> To access other info not in uapi header, people typically do two things:
> >>    (1). extend uapi to access more fields rooted from 'context'.
> >>    (2). use bpf_probe_read_kernl() helper to read particular field based on
> >>      kctx.

[...]

> >  From myside this allows us to pull in the dev info and from that get
> > netns so fixes a gap we had to split into a kprobe + xdp.
> > 
> > If we can get a pointer to the recv queue then with a few reads we
> > get the hash, vlan, etc. (see timestapm thread)
> 
> Thanks, John. Glad to see it is useful.
> 
> > 
> > And then last bit is if we can get a ptr to the net ns list, plus
> 
> Unfortunately, currently vmlinux btf does not have non-percpu global
> variables, so net_namespace_list is not available to bpf programs.
> But I think we could do the following with a little bit user space
> initial involvement as a workaround.

What would you think of another kfunc, bpf_get_global_var() to fetch
the global reference and cast it with a type? I think even if you
had it in BTF you would still need some sort of helper otherwise
how would you know what scope of the var should be and get it
correct in type checker as a TRUSTED arg? I think for my use case
UNTRUSTED is find, seeing we do it with probe_reads already, but
getting a TRUSTED arg seems nicer given it can be known correct
from kernel side.

I was thinking something like,

  struct net *head = bpf_get_global_var(net_namespace_list,
				bpf_core_type_id_kernel(struct *net));

> 
> In bpf program, we could have global variable
>    __u64 net_namespace_list;
> and user space can lookup /proc/kallsyms for net_namespace_list
> and assign it to bpf program 'net_namespace_list' before prog load.
> 
> After that, you could implement an in-bpf-prog iterator with bounded
> loop to ensure eventual ending. You can use
>    struct list_head *lh = bpf_rdonly_cast(net_namespace_list, 
> struct_list_head_btf_id)
> cast to struct list_head pointer. From there you can tracing down
> the list with needed bpf_rdonly_cast() for casting to element type.
> 
> > the rcu patch we can build the net ns iterator directly in BPF
> 
> I just posted rcu patch 
> https://lore.kernel.org/bpf/20221121170515.1193967-1-yhs@fb.com/
> Please help take a look whether it can serve your need.

Will look.
