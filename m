Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F025253AA
	for <lists+bpf@lfdr.de>; Thu, 12 May 2022 19:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357062AbiELRaG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 May 2022 13:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357060AbiELRaE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 May 2022 13:30:04 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D11F26ADBA
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 10:30:04 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id k8so5292536qki.8
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 10:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aW98z9lhUHlNdFc2P1wyjE8DDIFvkXesFrP1QJD76M8=;
        b=GQ6afUnqLUeKzveOX4N7VoU/9WqUvbnY6GxvjYxXaN0tlxjMo5oaTM8urtWtBmBy+p
         xVd5dq4lgcmCRGZYwgRc3/BbDhWnArX7YvNEHLnwe1M7ASYrwmMiy9FfnvbjvpQUZ0Qd
         bHqISzgB0X2KzZEme+gi9HmHcaiJ2z45ZlARnwsGhZV2iuowPx4NJVJBC+KYorwh1VsB
         9G7CeV1zhRDPqmBGklfdJnnIy3XI8h5m8+yo449UKh8ie0hKiKQlkdMQJgCW86aEJ1ba
         AGDTt2vpfv2ALTtFxdFdqm6NqT/rVLRGZIeIoU0oIV7v6ON0IgYfoE99hM8jRqRrQYXU
         8UYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aW98z9lhUHlNdFc2P1wyjE8DDIFvkXesFrP1QJD76M8=;
        b=SpQGL8tCZusDoyqJygx4iRZ5cQ+e6hjW1SX2U4vZkiwv6p/zWnNyhk4QNbso9lm1pL
         jxgh+pdXsXmeOhQqxHraqHx1Sy1+iOsJ6OFLLVSoWfUoarqijZds3onEc/879nYWH8LR
         jq9Sk4mzrJXU2IFGKKinVQXPlKW8GB8CZ5h+jRqfVPtq8URZJt7wn9iiib0fqUxOinrD
         9h2fkz3aD+XOF0NUGYiqDojEVFGqv8Aik4ig06jQqitjFD07jSyb2zuQdAg9OlUXsEFL
         +YEmWDyGueuhx66Lp3hjYj0EVJ/WYmalDaAr6pirYLj8Nng9KOjR9jH6yb3qoMiHLPMn
         Zy9w==
X-Gm-Message-State: AOAM531xuH3RI1mb07nGeyIkY1boIbwMlQOmbv8y61JXEEp9mAzkfD+s
        2sYrPlyVpElDwSvVOMsie2BY8OBD+e8GiXjFsw+I/ug4R4c=
X-Google-Smtp-Source: ABdhPJwSVC7O0RZw8dB+cdG5rXx3Nj9V/X18mi59UL4VIRbQ+un3AYlno6LDt70r1jtGUy/ArThqXlpZ/4g36CFmQQ0=
X-Received: by 2002:a05:620a:258e:b0:680:f33c:dbcd with SMTP id
 x14-20020a05620a258e00b00680f33cdbcdmr819335qko.542.1652376603098; Thu, 12
 May 2022 10:30:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220512165051.224772-1-kpsingh@kernel.org> <20220512165051.224772-2-kpsingh@kernel.org>
In-Reply-To: <20220512165051.224772-2-kpsingh@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 12 May 2022 10:29:51 -0700
Message-ID: <CAADnVQJwB4R=8yasfaLLftx_Ca9kg+9HKWUk1X8d2U72t-9i+A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Implement bpf_getxattr helper
To:     KP Singh <kpsingh@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 12, 2022 at 9:50 AM KP Singh <kpsingh@kernel.org> wrote:
>
> +BPF_CALL_5(bpf_getxattr, struct user_namespace *, mnt_userns, struct dentry *,
> +          dentry, void *, name, void *, value, size_t, value_size)
> +{
> +       return vfs_getxattr(mnt_userns, dentry, name, value, value_size);
> +}

It will deadlock in tracing, since it grabs all kinds of locks
and calls lsm hooks (potentially calling other bpf progs).
It probably should be sleepable only.
Also there is no need to make it uapi.
kfunc is a better interface here.
__vfs_getxattr() is probably better too,
since vfs_getxattr() calls xattr_permission which calls
a bunch of capable*() which will return "random values"
depending on the current task, since it's called from bpf prog.
