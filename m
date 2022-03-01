Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555B84C8059
	for <lists+bpf@lfdr.de>; Tue,  1 Mar 2022 02:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiCAB3P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Feb 2022 20:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiCAB3O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Feb 2022 20:29:14 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305C9220CD
        for <bpf@vger.kernel.org>; Mon, 28 Feb 2022 17:28:34 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id 9so11430646ily.11
        for <bpf@vger.kernel.org>; Mon, 28 Feb 2022 17:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KiBIdinJU2UpK0/AVvUEQBeGI+ovyUYtmCBG4Vv/Gug=;
        b=kYWvgcMnjxdvQDLP8n1QrzjRIwIwhyE7hGAmM9dvmQ2L+A4YQ6nTuaw+t/jOMnr5Ki
         I85vATuaGLPDOqCGGjvaWjTujnBI/BuIeoB212WXTL9VlGhYiOElp7/N/QMk/gl6pO1h
         UEj206wrk1Id1H755XqaFLVbuOCLDm5Njz2ncq07XUjmsREXLCW+WUKkDry6JzWqS6R3
         MfmAj+beNVTbjpZ1jSquu1lWFW0GNUvG8E15t/b6lwMVxeMd1LmjQDENz4mbHV+DrDda
         4dJN3uQzngc9Bp7Ld6MfwUWkBbfTVcRKFe1nADeI5UjDinXV15xapmteCLBEjhJuV8Tw
         xaJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KiBIdinJU2UpK0/AVvUEQBeGI+ovyUYtmCBG4Vv/Gug=;
        b=zUTkc+0ur9udMML+HGyHPQdKwOnMOdzUeGHArdPLLgzSI5pNUXivGgMYY2Qiq8jMHw
         iTQMd4bF5R20dZUR81cPSsakx0TeD/dXmFtzkqGvjSG0lWRboO8kCH/xl2pDEphl7VT/
         8Ht3VfS6/UuU11GfwqBpIlX5DzfW1KdeIe0U/4jYS6OZEfPnaWziOIL86LWE9YJDQJrE
         C2EAiB5pPlc+ClPAFJEzgoek4fyZTqwrSXK+xm3DoTCHQEUpP4XkpG8Q8jCJ+CIbunMW
         XE7duofpXkBTzJWsDKlQZcNVg7s5sIQUWAqOjSvnmH21w/Nr8HaQkxIk5/gskx0Fb/qG
         jltA==
X-Gm-Message-State: AOAM5327oMpYXpNrzsIvxV1c85jyQr0PRaVdwN7/sJUYFOmC2r2Ycm1C
        lPVhrP5gSLi6qp+91yhseluPuxyFmvXKyX1w+r0=
X-Google-Smtp-Source: ABdhPJwfxLx/0npQJLppbCh7CAknCvb4jRGGAW4BscC+uTy6TA6aiQHZSD7w+DHlkGpnaDb4QbLeL5fUcr4nV1qZYW0=
X-Received: by 2002:a05:6e02:1a88:b0:2be:a472:90d9 with SMTP id
 k8-20020a056e021a8800b002bea47290d9mr21268057ilv.239.1646098113582; Mon, 28
 Feb 2022 17:28:33 -0800 (PST)
MIME-Version: 1.0
References: <20220224101444.1169015-1-xukuohai@huawei.com> <20220224101444.1169015-3-xukuohai@huawei.com>
In-Reply-To: <20220224101444.1169015-3-xukuohai@huawei.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 28 Feb 2022 17:28:22 -0800
Message-ID: <CAEf4BzbZr_VrJVJ+b9U9dxtQG0eF98sv+_VjQmqf5guGUC+5xA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Update btf_dump case for
 conflicting type names
To:     Xu Kuohai <xukuohai@huawei.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, Shuah Khan <shuah@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>
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

On Thu, Feb 24, 2022 at 2:04 AM Xu Kuohai <xukuohai@huawei.com> wrote:
>
> Update btf_dump case for conflicting names caused by forward declaration.
>
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> Acked-by: Song Liu <songliubraving@fb.com>
> ---

Please make sure that all tests are passing. Currently there are failures:

  [0] https://github.com/kernel-patches/bpf/runs/5367548029?check_suite_focus=true

>  .../selftests/bpf/prog_tests/btf_dump.c       | 54 ++++++++++++++-----
>  1 file changed, 41 insertions(+), 13 deletions(-)
>

[...]
