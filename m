Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C268C618B86
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 23:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiKCWaM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 18:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbiKCWaF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 18:30:05 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1B022BD5
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 15:30:04 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id b11so2987864pjp.2
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 15:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3fMKSoAbFdtv7kK19x6+LSLeUsnWQgkr5WPfElpsC14=;
        b=ZbK03pWheFqXA/nS5IgQ9O8tbxHwFwp70R6tkPNaTljl9NNhtrNje3uCY55IEBYtKc
         fZEeLhBEcwP3Pz54UGbf6eLANgSw5utCFv8xS00NfS336BlFoPV7WqeFGYqh8nl0GTru
         Jc/WyUO/1A/wRT5H8ZABrMCNUOMrlj5hPx6OmfFjnHv398aRxj6/cMUwQDmLhqSWVXkk
         z1uo/gN7Zm3ZD81/5ov9DrVEC00A9qZvPtlksrisJ2VVMnLpQPSq46NTAN7LYJ67AzfR
         /vNqmS7O1au/HmAIPYXg8hRHFOyFhJO+D9TWCQfCz0aoFr6Iev/k0XpQRmW0iPlHvJam
         B9Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fMKSoAbFdtv7kK19x6+LSLeUsnWQgkr5WPfElpsC14=;
        b=WMYIf+BwOc/2jjp2bKw5YJjCuF/CYwMGhsUCw82pO77vA25+cd2zqlS2XZYyeXMEd/
         W79jSz2MQotpX9mJtmCfcJNX1sXa26MRINbJm/qXmXvaMyJbRzErkfyIhJpOUjPyr0DP
         mzaFin2akG7V/ygtjs5uHv6RNPyBJfZtIuj9CGGvpIQMTWXqm+n3hBNFqdS1842a7D2+
         NzHqGXd8w2y1w63toqWHZTl6keufPXdf5EWWRqhKLNT67RqCCvO9Ljt7JjbOGCih4vH1
         z3DObL3rZOmLW15zfNLLDjMiG2dsc1x0Ly7CWvz81Yl/npCEebg/EAKm6rJgcuWrxwXG
         b4xw==
X-Gm-Message-State: ACrzQf3Y6GntsIS5q+N1d6+8xep06Qj8nt0n/mmC6JKGSw2/No03ikPB
        HnU+UHw37qab00kyqhzTvD0=
X-Google-Smtp-Source: AMsMyM5nDT2sT2FqbZQoW8FRe9Pibv8+vF7VjAc2dcM0sbMr7tZcoC5WfnhVTFhy7hMvXXzQu7WF7w==
X-Received: by 2002:a17:902:7897:b0:178:9292:57b9 with SMTP id q23-20020a170902789700b00178929257b9mr32539050pll.102.1667514604104;
        Thu, 03 Nov 2022 15:30:04 -0700 (PDT)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id q5-20020a17090a2dc500b002071ee97923sm458143pjm.53.2022.11.03.15.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 15:30:03 -0700 (PDT)
Date:   Fri, 4 Nov 2022 03:59:43 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Yonghong Song <yhs@meta.com>
Cc:     KP Singh <kpsingh@kernel.org>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next 2/5] bpf: Add bpf_rcu_read_lock/unlock helper
Message-ID: <20221103222943.6wksva7pavt24o7a@apollo>
References: <20221103072102.2320490-1-yhs@fb.com>
 <20221103072113.2322563-1-yhs@fb.com>
 <CACYkzJ6ASmpYPmenN6NMpThiJiXF2ggQR+sjaE5DATRFTp64eQ@mail.gmail.com>
 <7916c4e0-2957-f05d-a69b-fe74ae8a264c@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7916c4e0-2957-f05d-a69b-fe74ae8a264c@meta.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 04, 2022 at 02:30:55AM IST, Yonghong Song wrote:
>
>
> On 11/3/22 7:28 AM, KP Singh wrote:
> > On Thu, Nov 3, 2022 at 8:21 AM Yonghong Song <yhs@fb.com> wrote:
> > >
> > > Add bpf_rcu_read_lock() and bpf_rcu_read_unlock() helpers.
> > > Both helpers are available to all program types with
> > > CAP_BPF capability.
> > >
> > > Signed-off-by: Yonghong Song <yhs@fb.com>
> > > ---
> > >   include/linux/bpf.h            |  2 ++
> > >   include/uapi/linux/bpf.h       | 14 ++++++++++++++
> > >   kernel/bpf/core.c              |  2 ++
> > >   kernel/bpf/helpers.c           | 26 ++++++++++++++++++++++++++
> > >   tools/include/uapi/linux/bpf.h | 14 ++++++++++++++
> > >   5 files changed, 58 insertions(+)
> > >
> > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > index 8d948bfcb984..a9bda4c91fc7 100644
> > > --- a/include/linux/bpf.h
> > > +++ b/include/linux/bpf.h
> > > @@ -2554,6 +2554,8 @@ extern const struct bpf_func_proto bpf_get_retval_proto;
> > >   extern const struct bpf_func_proto bpf_user_ringbuf_drain_proto;
> > >   extern const struct bpf_func_proto bpf_cgrp_storage_get_proto;
> > >   extern const struct bpf_func_proto bpf_cgrp_storage_delete_proto;
> > > +extern const struct bpf_func_proto bpf_rcu_read_lock_proto;
> > > +extern const struct bpf_func_proto bpf_rcu_read_unlock_proto;
> > >
> > >   const struct bpf_func_proto *tracing_prog_func_proto(
> > >     enum bpf_func_id func_id, const struct bpf_prog *prog);
> > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > index 94659f6b3395..e86389cd6133 100644
> > > --- a/include/uapi/linux/bpf.h
> > > +++ b/include/uapi/linux/bpf.h
> > > @@ -5481,6 +5481,18 @@ union bpf_attr {
> > >    *             0 on success.
> > >    *
> > >    *             **-ENOENT** if the bpf_local_storage cannot be found.
> > > + *
> > > + * void bpf_rcu_read_lock(void)
> > > + *     Description
> > > + *             Call kernel rcu_read_lock().
> >
> > Simple wrapper around rcu_read_lock() and maybe explain where and how
> > it is supposed to
> > be used.
> >
> > e.g. the verifier will check if __rcu pointers are being accessed with
> > bpf_rcu_read_lock in
> > sleepable programs.
>
> Okay, I can add more descriptions.
>
> >
> > Calling the helper from a non-sleepable program is inconsequential,
> > but maybe we can even
> > avoid exposing it to non-sleepable programs?
>
> I actually debated myself whether to make bpf_rcu_read_lock()/unlock()
> to be sleepable only. Although it won't hurt for non-sleepable program,
> I guess I can make it as sleepable only so users don't make mistake
> to use them in non-sleepable programs.
>

It's better to let it be a noop in non-sleepable programs but still allow
calling it. It allows writing common helper functions in the BPF program that
work in both sleepable and non-sleepable cases by holding the RCU read lock.
