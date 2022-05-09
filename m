Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB9D5205A3
	for <lists+bpf@lfdr.de>; Mon,  9 May 2022 22:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240767AbiEIUHF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 May 2022 16:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240735AbiEIUHE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 May 2022 16:07:04 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8A6200F62
        for <bpf@vger.kernel.org>; Mon,  9 May 2022 13:03:09 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id q76so12900821pgq.10
        for <bpf@vger.kernel.org>; Mon, 09 May 2022 13:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ixVfidBfjtS3og2Mo9gN8zk2z4PRDdweTrNBhFmf+HU=;
        b=czfJXOtvvsTs2snJP9jORRwgp2nH7jPRpq5EKitZiqjil6AsYOtzBbt1KPVWWFQA/Z
         up5SAdD7ptweEvd9Evz3GJ2yTcxYKQJ7qpSIdL4td3hcaSnLR/CXGEqcBQlPGEoZWGyP
         5OVoSDR+aIIG4KUmiRwd4L4SIz0bJOe0q37wMCD9NW/Af12xDgp/fY5hJ+Jah0lDyZtf
         +oWzD+Zxi2dBjJwLLAL7Z5lXHUBfcyhKD/JW6cn6IdzAmOiBXeP+5mzSsPH5k6L0/VDz
         jrmy0xmI/W6KbLEqf5L+4B0csN2cwyIgbdG7VouMWCl+fpIbvz1+zw+zTSn9BpnfKkgF
         0Qpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ixVfidBfjtS3og2Mo9gN8zk2z4PRDdweTrNBhFmf+HU=;
        b=DbPj7t8pghkA4crqkmMp0qPjNQb/ypknZKFN/eMjCKtu0X2mMnqLV79Pz3y3twVfmj
         wci85jnXP+LRvg/pX7sB0ScCGl0Eq4f7IncHHOuzfmkRXd6A+hglJgk+US0/MF+4RYTk
         klsUBLeyPYWShj9OM2EzX1plk33ZBxlTa00yT4uF5T5dp2bqyWjQZREGCldeSM+PQCEb
         U6UdwT+MVA/qSZ0QPHGN0KRI0/tI/HMZqeKroYf9GWYapP8LIE2bWp0tYyK1ebD1ohdM
         D+lAK7AtxJdZ3yhzirK4nSIfYD9bD9B6y+JOdSpbaL3Pze4+je/IXzMXcwUlHzQzyqOl
         V78w==
X-Gm-Message-State: AOAM530/Kw1szO6cJ0ZbR4UaZ8H3mxWQP/bJQDulNb4iLzCzkZHT0tR0
        XAkqS0II21XhZ6MqcONG29U=
X-Google-Smtp-Source: ABdhPJw/+n2qhyKm8mreKll7pNZMTKY3S82TUk4O/Pfasy/dQjm3YnQvG/PiCFVabq0mTlm/xo6Ffg==
X-Received: by 2002:a05:6a00:14cc:b0:510:4b70:403e with SMTP id w12-20020a056a0014cc00b005104b70403emr17386002pfu.55.1652126589106;
        Mon, 09 May 2022 13:03:09 -0700 (PDT)
Received: from localhost ([157.51.71.11])
        by smtp.gmail.com with ESMTPSA id t3-20020aa79383000000b0050dc762817csm9065561pfe.86.2022.05.09.13.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 13:03:08 -0700 (PDT)
Date:   Tue, 10 May 2022 01:33:44 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf-next v6 12/13] selftests/bpf: Add verifier tests for
 kptr
Message-ID: <20220509200344.bl7cpvh366fkfzrn@apollo.legion>
References: <20220424214901.2743946-1-memxor@gmail.com>
 <20220424214901.2743946-13-memxor@gmail.com>
 <20220426033544.lxxnz6epet6qrzq6@MBP-98dd607d3435.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426033544.lxxnz6epet6qrzq6@MBP-98dd607d3435.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 26, 2022 at 09:05:44AM IST, Alexei Starovoitov wrote:
> On Mon, Apr 25, 2022 at 03:19:00AM +0530, Kumar Kartikeya Dwivedi wrote:
> > Reuse bpf_prog_test functions to test the support for PTR_TO_BTF_ID in
> > BPF map case, including some tests that verify implementation sanity and
> > corner cases.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  net/bpf/test_run.c                            |  45 +-
> >  tools/testing/selftests/bpf/test_verifier.c   |  55 +-
> >  .../testing/selftests/bpf/verifier/map_kptr.c | 469 ++++++++++++++++++
> >  3 files changed, 562 insertions(+), 7 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/verifier/map_kptr.c
> >
> > diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> > index e7b9c2636d10..29fe32821e7e 100644
> > --- a/net/bpf/test_run.c
> > +++ b/net/bpf/test_run.c
> > @@ -584,6 +584,12 @@ noinline void bpf_kfunc_call_memb_release(struct prog_test_member *p)
> >  {
> >  }
> >
> > +noinline struct prog_test_ref_kfunc *
> > +bpf_kfunc_call_test_kptr_get(struct prog_test_ref_kfunc **p, int a, int b)
> > +{
> > +	return &prog_test_struct;
> > +}
> > +
> >  struct prog_test_pass1 {
> >  	int x0;
> >  	struct {
> > @@ -669,6 +675,7 @@ BTF_ID(func, bpf_kfunc_call_test3)
> >  BTF_ID(func, bpf_kfunc_call_test_acquire)
> >  BTF_ID(func, bpf_kfunc_call_test_release)
> >  BTF_ID(func, bpf_kfunc_call_memb_release)
> > +BTF_ID(func, bpf_kfunc_call_test_kptr_get)
> >  BTF_ID(func, bpf_kfunc_call_test_pass_ctx)
> >  BTF_ID(func, bpf_kfunc_call_test_pass1)
> >  BTF_ID(func, bpf_kfunc_call_test_pass2)
> > @@ -682,6 +689,7 @@ BTF_SET_END(test_sk_check_kfunc_ids)
> >
> >  BTF_SET_START(test_sk_acquire_kfunc_ids)
> >  BTF_ID(func, bpf_kfunc_call_test_acquire)
> > +BTF_ID(func, bpf_kfunc_call_test_kptr_get)
> >  BTF_SET_END(test_sk_acquire_kfunc_ids)
> >
> >  BTF_SET_START(test_sk_release_kfunc_ids)
> > @@ -691,8 +699,13 @@ BTF_SET_END(test_sk_release_kfunc_ids)
> >
> >  BTF_SET_START(test_sk_ret_null_kfunc_ids)
> >  BTF_ID(func, bpf_kfunc_call_test_acquire)
> > +BTF_ID(func, bpf_kfunc_call_test_kptr_get)
> >  BTF_SET_END(test_sk_ret_null_kfunc_ids)
> >
> > +BTF_SET_START(test_sk_kptr_acquire_kfunc_ids)
> > +BTF_ID(func, bpf_kfunc_call_test_kptr_get)
> > +BTF_SET_END(test_sk_kptr_acquire_kfunc_ids)
> > +
> >  static void *bpf_test_init(const union bpf_attr *kattr, u32 user_size,
> >  			   u32 size, u32 headroom, u32 tailroom)
> >  {
> > @@ -1579,14 +1592,36 @@ int bpf_prog_test_run_syscall(struct bpf_prog *prog,
> >
> >  static const struct btf_kfunc_id_set bpf_prog_test_kfunc_set = {
> >  	.owner        = THIS_MODULE,
> > -	.check_set    = &test_sk_check_kfunc_ids,
> > -	.acquire_set  = &test_sk_acquire_kfunc_ids,
> > -	.release_set  = &test_sk_release_kfunc_ids,
> > -	.ret_null_set = &test_sk_ret_null_kfunc_ids,
> > +	.check_set        = &test_sk_check_kfunc_ids,
> > +	.acquire_set      = &test_sk_acquire_kfunc_ids,
> > +	.release_set      = &test_sk_release_kfunc_ids,
> > +	.ret_null_set     = &test_sk_ret_null_kfunc_ids,
> > +	.kptr_acquire_set = &test_sk_kptr_acquire_kfunc_ids
> >  };
>
> This hunk probably should have been in the previous patch,
> but since it's not affecting bisect I left it as-is.
>
> > +BTF_ID_LIST(bpf_prog_test_dtor_kfunc_ids)
> > +BTF_ID(struct, prog_test_ref_kfunc)
> > +BTF_ID(func, bpf_kfunc_call_test_release)
> > +BTF_ID(struct, prog_test_member)
> > +BTF_ID(func, bpf_kfunc_call_memb_release)
>
> dtor of prog_test_member doesn't seem to be used ?
>

It is necessary to be able to embed prog_test_member struct as a referenced kptr
in a map value, so it is still called by the map implementation's free path. But
since this is just used for verifier tests related to type matching when
non-zero offset is involved, both acquire and release are dummy functions.

> Please improve dtor and kptr_get test methods for
> struct prog_test_ref_kfunc and prog_test_member to do the real refcnting.
> Empty methods are not testing things fully.

I will leave out prog_test_member since it is not meant to be used at runtime,
but I will add refcount_t to prog_test_ref_kfunc, and include tests for it.

--
Kartikeya
