Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66832560B13
	for <lists+bpf@lfdr.de>; Wed, 29 Jun 2022 22:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiF2UcH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Jun 2022 16:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiF2UcG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Jun 2022 16:32:06 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF34738DAD
        for <bpf@vger.kernel.org>; Wed, 29 Jun 2022 13:32:05 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id d129so16379699pgc.9
        for <bpf@vger.kernel.org>; Wed, 29 Jun 2022 13:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ecGWF+v+mh0foR6TRTuLDZqGO2rNb7f0qblUYZWHgOM=;
        b=DqCX8PD3D1UZMk4B4SbD0Qot2cvtKrH7sdN/k3I/uysDHGS7l4JF9nJJ+aOt4LV6/m
         w37Oez1KJvylXgDXvKk3fO0bxwcTwD0aSB32M0XasLdg11zKPGfZfnt2FLDpLK2yekYe
         1AIrcaDD+Ym5UoCixN1inuwpli5CwpoKQ9aJLpB8dj40whYasODZlDeBQvFyFbokzB46
         S8sn7kXRg6medm+HcC6CcU0w7vcVVDIycZGzXqkHgYDoWrS3Ys2sHZvINmm7Lckr3+An
         dR3cHIsnxcz1oAiGIGLBWjbIY8rR0v/5VzPioMVw0wNVaKaPbY9NcARf2OvBqIzGx/At
         4UqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ecGWF+v+mh0foR6TRTuLDZqGO2rNb7f0qblUYZWHgOM=;
        b=Uis3M0ptreEMOONFo2aHV0MKyF4jo4l0WaeFSQT9OTvifmKC2fChR7YorSwmm+TBpY
         YKi0vdZWB8uwXjKy2PXGKfa83e8tAOOHjCVqvLHKql9JPNkTNV1KbP2+uZRgAGVIoJ+4
         sehuqZAw9tUVOdfjYnsLqWmL2TFUN5Fuad/ek6QRrMXeHJuzzPTpPFIqFYiRXXPVAiTb
         OkiSTPjdDHI1Icsne5oJ5VV5Yq2nG2nfcNya2JosL/odGboTO0isATiHkzAQfzrikYOV
         uEJVnA6rGhbysoZdc1UaRlPtB8XIH8Fi+CW7pw89pbo1QB7dB/K4cGCjWqZ2SsLxt85X
         zrtw==
X-Gm-Message-State: AJIora8LEnuNP5qyYGqnQmTQp0uqS7miufA9/OmO0EYMJ42clw1t7nm6
        LwsTiqI5DjLZBJFuk91uUJxsfGNTQYya57jyHwtj6bP+CC8=
X-Google-Smtp-Source: AGRyM1sii0RC5bOgxyRji6AJa3Vmd7rcO2+eeNdLcNsPTKcqpo1aNsabVJpMXDXUdJzwQPvf7+QPYhKsp6B8+zxIgjk=
X-Received: by 2002:a63:db4d:0:b0:411:9d20:af14 with SMTP id
 x13-20020a63db4d000000b004119d20af14mr744886pgi.442.1656534725043; Wed, 29
 Jun 2022 13:32:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220628174314.1216643-1-sdf@google.com> <20220628174314.1216643-12-sdf@google.com>
 <CAADnVQJHKtYd2XKiWRj_5fnVdT7aP2NEwi4eVUdqCO7q2nQ6Og@mail.gmail.com>
In-Reply-To: <CAADnVQJHKtYd2XKiWRj_5fnVdT7aP2NEwi4eVUdqCO7q2nQ6Og@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 29 Jun 2022 13:31:52 -0700
Message-ID: <CAKH8qBtmoFbvvTSTA-u2J6n=So8Q9mMSwVqgdOBY6vzpOQzkKg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v11 11/11] selftests/bpf: lsm_cgroup functional test
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 29, 2022 at 1:26 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Jun 28, 2022 at 10:43 AM Stanislav Fomichev <sdf@google.com> wrote:
> > +
> > +static void test_lsm_cgroup_functional(void)
>
> It fails BPF CI on s390:
>
> test_lsm_cgroup_functional:FAIL:attach alloc_prog_fd unexpected error:
> -524 (errno 524)
> test_lsm_cgroup_functional:FAIL:detach_create unexpected
> detach_create: actual -2 < expected 0
> test_lsm_cgroup_functional:FAIL:detach_alloc unexpected detach_alloc:
> actual -2 < expected 0
> test_lsm_cgroup_functional:FAIL:detach_clone unexpected detach_clone:
> actual -2 < expected 0
>
> https://github.com/kernel-patches/bpf/runs/7100626120?check_suite_focus=true
>
> but I pushed it to bpf-next anyway.
> Thanks a lot for this work and please follow up with a fix.

Thanks, I'll take a look!

> Thanks a lot Martin for the code reviews.

+1, thanks Martin. I was trying to keep respinning at most once per
week, I hope I haven't overwhelmed you. The end result is so much
better because of your inputs.
