Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141195ED10E
	for <lists+bpf@lfdr.de>; Wed, 28 Sep 2022 01:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiI0XgW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 19:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiI0XgV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 19:36:21 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24451D1E06
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 16:36:20 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id z191so8961573iof.10
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 16:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=mKXjPFvWHZipW8cVLSdeUCbsshoNW9WUv5VPPj0C3W4=;
        b=a3JLsEkO8VnDWpc239JjW7zvus+Zxd076kR5kzVUVfPeoc1/ql1nkqEyJwsojqIFHT
         OzGD88h8xqQw1upbdCgzQtwZ3JjyuZpWLHf3yfeaGyfr+RRvLJaE0WKxVsK3xzMUYSUV
         MxnnicIFy5xy5SK5pZwrOB3Xo/cDIsZvajrni7InXUyJldZMC2ppqyMGuGiA2cbsqhFN
         orlIM/lIN+WwsNhG0BdHfbKwmzA0Jt9in0oX8qnlTY7ENAXaPZisM0S1GVaZnZ5Ah88r
         Kq4EtmZ3Zp20mIxQVfgM8MxhMyO3gbz2aO2UQgx/ZyMqxLLwY4i3U8slE0dFgI9S8SKK
         Wb9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=mKXjPFvWHZipW8cVLSdeUCbsshoNW9WUv5VPPj0C3W4=;
        b=dDkokii+OnrYlxeDTImn9YgY6OKqVzgRveGwSTbNoIkb+bop+YHbY/IpALOKrScwvm
         MJRz3FuyxcDAHTgfOGOxNdGESImfHiP0lzdQm4asIJDsJd/M3tYLFdzq10cCchgoySV1
         UguA7xE8FCKogepi8JF17H+S149l7kwIv4JdUTt2pgDPx2X5e7EPFqbXVrcx3kGYSzzz
         lw6XxWzUQCC+8vSAq6YzrE5pfHohIzH5X6BiLfaT9HnljazCd17sMSli5aeq+jOpfmpH
         /CArIphooNXazAyp98/sHkq6GB5YeK+04VtleFv4tATC4d8CBMHB3Cgv1o4Sh4FFVCut
         2o4g==
X-Gm-Message-State: ACrzQf3SXNuCxjAOLf2JxCVEix+kXHRq+Gmd/a2OGG0EO2oNFgodVTky
        6N82UgbeUCAd1g+9HMfQzSxZ245xZla4tr5iUo4esQ==
X-Google-Smtp-Source: AMsMyM4YIXJmBvFQQrOG/SzPAJysY9vj1YOwD1tiKFQi4osKaQfnuGgb+6A673umFvtrzVx4y6hL0v0qIJWEkmR7oZc=
X-Received: by 2002:a5d:9d8e:0:b0:6a1:8e85:3584 with SMTP id
 ay14-20020a5d9d8e000000b006a18e853584mr12746504iob.53.1664321780189; Tue, 27
 Sep 2022 16:36:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220926231822.994383-1-drosen@google.com> <20220926231822.994383-13-drosen@google.com>
 <20220927220722.GA2703033@dread.disaster.area>
In-Reply-To: <20220927220722.GA2703033@dread.disaster.area>
From:   Daniel Rosenberg <drosen@google.com>
Date:   Tue, 27 Sep 2022 16:36:09 -0700
Message-ID: <CA+PiJmSfYMvT91LkaZyu=f7HynscNEUG8X90x7cByCCvEb-g9w@mail.gmail.com>
Subject: Re: [PATCH 12/26] fuse-bpf: Add support for fallocate
To:     Dave Chinner <david@fromorbit.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@google.com>,
        David Anderson <dvander@google.com>,
        Sandeep Patil <sspatil@google.com>,
        linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 27, 2022 at 3:07 PM Dave Chinner <david@fromorbit.com> wrote:
>
> As I browse through this series, I find this pattern unnecessarily
> verbose and it exposes way too much of the filtering mechanism to
> code that should not have to know anything about it.
>
> Wouldn't it be better to code this as:
>
>         error = fuse_filter_fallocate(file, mode, offset, length);
>         if (error < 0)
>                 return error;
>
>
> And then make this fuse_bpf_backing() call and all the indirect
> functions it uses internal (i.e. static) in fs/fuse/backing.c?
>
> That way the interface in fs/fuse/fuse_i.h can be much cleaner and
> handle the #ifdef CONFIG_FUSE_BPF directly by:
>
> #ifdef CONFIG_FUSE_BPF
> ....
> int fuse_filter_fallocate(file, mode, offset, length);
> ....
> #else /* !CONFIG_FUSE_BPF */
> ....
> static inline fuse_filter_fallocate(file, mode, offset, length)
> {
>         return 0;
> }
> ....
> #endif /* CONFIG_FUSE_BPF */
>
> This seems much cleaner to me than exposing fuse_bpf_backing()
> boiler plate all over the code...
>
> Cheers,
>
> Dave.
> --
> Dave Chinner
> david@fromorbit.com
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>

Thanks for the suggestion, that'll help clean things up a bit. It's
quite nice to have fresh eyes looking over the code.

-Daniel
