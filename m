Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3EA94CE856
	for <lists+bpf@lfdr.de>; Sun,  6 Mar 2022 03:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbiCFCuD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 5 Mar 2022 21:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiCFCuC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 5 Mar 2022 21:50:02 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E4222BDC
        for <bpf@vger.kernel.org>; Sat,  5 Mar 2022 18:49:11 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id b8so10398741pjb.4
        for <bpf@vger.kernel.org>; Sat, 05 Mar 2022 18:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+B2jfCVg108jSEhSBIO3CNPBkJYMEtAT6G6QHn7XMUY=;
        b=IM0TfdIzNvevk/vv+UgPQflDZoMm4siWHceJR0Mu4mMKptJkPMXVRU7m21jmzz/FRR
         TvAo89795kdsmlHiykYFt+BfkT91QG/SOwhrobS67eGSOpEWYW2VLybgFhJrYxph8b24
         uAbAxet1EBJVgfkndJinve+lWu399Zh/56+ImS3I6wwh+zOWtzcS3jqAXlodE4/juGuz
         Fem/PYdWY0MNxz+hKCzFq8cm99SQvavEf5UO4KyRP6WUoL10nZl9WhTm4mUGearOVg8T
         eX4qo5/mLTfLWAfGbi+l/c8vx/Nagw7heldFUQMSq2Yah+5jK2sRm8pgNznZqf3a1w5J
         gekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+B2jfCVg108jSEhSBIO3CNPBkJYMEtAT6G6QHn7XMUY=;
        b=lK+SKO12IuFLC6FTTM/y8pKVKe0I2yMWePgLlaoY/5w0g0tkMrjG7RecBq6IMcqaOH
         rjI+tdXz2f2yhaM3IVYPo9mOBEWzmCwweEs8SkfelP8Wmb/4HkpslMDMwG6+wY/ugV5E
         nQedZ96WcZlLJWvf30Pvbkk69iQ652ftX8tKr2znOBj0oNG9YuFZh+u6y51DLk2A9qyy
         cKj2ijseYNj6c9NcyjMKZhLWCuggQsQOyd1zQgdrKWvNPYAZEsgm6pbxUCTWn5PAA4WT
         CplYHLzTWjLdAxr0YjwTSFmFHpuyFuwa4yxLcc4QKcYm0Oca01/i1t9VOG2x/m3WgX9s
         BZ1g==
X-Gm-Message-State: AOAM532cI6t0qrLBYn7Xpd8JaaENjOHhluwbs/4gA+I7cPmWt2o1hzwv
        eDHK28Z0vnGgb1NfWkhmi/w=
X-Google-Smtp-Source: ABdhPJywwSQ4hmtQM8go2Q2cPNTip2YL5GJEBIkIItptE/OzjuZD4qcqtNOnM6tz1UHROiK23MUkKQ==
X-Received: by 2002:a17:902:9348:b0:14d:8ee9:329f with SMTP id g8-20020a170902934800b0014d8ee9329fmr6035622plp.80.1646534947766;
        Sat, 05 Mar 2022 18:49:07 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:6d57])
        by smtp.gmail.com with ESMTPSA id n34-20020a056a000d6200b004e1ba1016absm10740283pfv.31.2022.03.05.18.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 18:49:07 -0800 (PST)
Date:   Sat, 5 Mar 2022 18:49:05 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     Hao Luo <haoluo@google.com>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, acme@kernel.org,
        KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v1 4/4] selftests/bpf: Add a test for
 btf_type_tag "percpu"
Message-ID: <20220306024905.ienwjn3vs2ecjavk@ast-mbp.dhcp.thefacebook.com>
References: <20220304191657.981240-1-haoluo@google.com>
 <20220304191657.981240-5-haoluo@google.com>
 <b26d6c7d-cba1-8b54-2939-95f4232e3c4c@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b26d6c7d-cba1-8b54-2939-95f4232e3c4c@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Mar 05, 2022 at 01:20:42PM -0800, Yonghong Song wrote:
> 
> On 3/4/22 11:16 AM, Hao Luo wrote:
> > Add test for percpu btf_type_tag. Similar to the "user" tag, we test
> > the following cases:
> > 
> >   1. __percpu struct field.
> >   2. __percpu as function parameter.
> >   3. per_cpu_ptr() accepts dynamically allocated __percpu memory.
> > 
> > Because the test for "user" and the test for "percpu" are very similar,
> > a little bit of refactoring has been done in btf_tag.c. Basically, both
> > tests share the same function for loading vmlinux and module btf.
> > 
> > Example output from log:
> > 
> >   > ./test_progs -v -t btf_tag
> > 
> >   libbpf: prog 'test_percpu1': BPF program load failed: Permission denied
> >   libbpf: prog 'test_percpu1': -- BEGIN PROG LOAD LOG --
> >   ...
> >   ; g = arg->a;
> >   1: (61) r1 = *(u32 *)(r1 +0)
> >   R1 is ptr_bpf_testmod_btf_type_tag_1 access percpu memory: off=0
> >   ...
> >   test_btf_type_tag_mod_percpu:PASS:btf_type_tag_percpu 0 nsec
> >   #26/6 btf_tag/btf_type_tag_percpu_mod1:OK
> > 
> >   libbpf: prog 'test_percpu2': BPF program load failed: Permission denied
> >   libbpf: prog 'test_percpu2': -- BEGIN PROG LOAD LOG --
> >   ...
> >   ; g = arg->p->a;
> >   2: (61) r1 = *(u32 *)(r1 +0)
> >   R1 is ptr_bpf_testmod_btf_type_tag_1 access percpu memory: off=0
> >   ...
> >   test_btf_type_tag_mod_percpu:PASS:btf_type_tag_percpu 0 nsec
> >   #26/7 btf_tag/btf_type_tag_percpu_mod2:OK
> > 
> >   libbpf: prog 'test_percpu_load': BPF program load failed: Permission denied
> >   libbpf: prog 'test_percpu_load': -- BEGIN PROG LOAD LOG --
> >   ...
> >   ; g = (__u64)cgrp->rstat_cpu->updated_children;
> >   2: (79) r1 = *(u64 *)(r1 +48)
> >   R1 is ptr_cgroup_rstat_cpu access percpu memory: off=48
> >   ...
> >   test_btf_type_tag_vmlinux_percpu:PASS:btf_type_tag_percpu_load 0 nsec
> >   #26/8 btf_tag/btf_type_tag_percpu_vmlinux_load:OK
> > 
> >   load_btfs:PASS:could not load vmlinux BTF 0 nsec
> >   test_btf_type_tag_vmlinux_percpu:PASS:btf_type_tag_percpu 0 nsec
> >   test_btf_type_tag_vmlinux_percpu:PASS:btf_type_tag_percpu_helper 0 nsec
> >   #26/9 btf_tag/btf_type_tag_percpu_vmlinux_helper:OK
> > 
> > Signed-off-by: Hao Luo <haoluo@google.com>
> 
> With one nit below.
> 
> Acked-by: Yonghong Song <yhs@fb.com>
> 
> > ---
> >   .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  17 ++
> >   .../selftests/bpf/prog_tests/btf_tag.c        | 164 ++++++++++++++----
> >   .../selftests/bpf/progs/btf_type_tag_percpu.c |  66 +++++++
> >   3 files changed, 218 insertions(+), 29 deletions(-)
> >   create mode 100644 tools/testing/selftests/bpf/progs/btf_type_tag_percpu.c
> > 
> > diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > index 27d63be47b95..17c211f3b924 100644
> > --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > @@ -33,6 +33,10 @@ struct bpf_testmod_btf_type_tag_2 {
> >   	struct bpf_testmod_btf_type_tag_1 __user *p;
> >   };
> > +struct bpf_testmod_btf_type_tag_3 {
> > +	struct bpf_testmod_btf_type_tag_1 __percpu *p;
> > +};
> > +
> >   noinline int
> >   bpf_testmod_test_btf_type_tag_user_1(struct bpf_testmod_btf_type_tag_1 __user *arg) {
> >   	BTF_TYPE_EMIT(func_proto_typedef);
> > @@ -46,6 +50,19 @@ bpf_testmod_test_btf_type_tag_user_2(struct bpf_testmod_btf_type_tag_2 *arg) {
> >   	return arg->p->a;
> >   }
> > +noinline int
> > +bpf_testmod_test_btf_type_tag_percpu_1(struct bpf_testmod_btf_type_tag_1 __percpu *arg) {
> > +	BTF_TYPE_EMIT(func_proto_typedef);
> > +	BTF_TYPE_EMIT(func_proto_typedef_nested1);
> > +	BTF_TYPE_EMIT(func_proto_typedef_nested2);
> 
> Are these necessary? They have been defined in
> bpf_testmod_test_btf_type_tag_user_1().

Yonghong,
Thanks. Good catch. I've removed those while applying.

Hao,
Great work.
I really liked how patch 3 discovers MEM_PERCPU flag from
two sources: percpu_datasec and clang tag.
