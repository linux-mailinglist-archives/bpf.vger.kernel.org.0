Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733E463BC25
	for <lists+bpf@lfdr.de>; Tue, 29 Nov 2022 09:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbiK2Ixm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Nov 2022 03:53:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiK2Ix0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Nov 2022 03:53:26 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC29490A2
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 00:52:57 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id d20so8055915edn.0
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 00:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ndVC/xnRF2wA2OxS2u5R4c7vHglSA7us+u3ARVQalBk=;
        b=DltHa8TIin17OgUu1Wi95fKKWqiDlletcbAz2KweRpXZ6AIy0Qk5zNP+oW7b8+Ap63
         /CLsHhYUzlfqz2AtqlZ7Hpn51lzYGisQP3tI21Xdh1Q8DfnEstRnEqO7e/P6K/S4rOPx
         0me+anbEw5Skh1Spv6+OFhkCLZcghcg9RKFBsXzAEMwUP9MABtyIQ1rdWf8QWvLQzmg0
         UxOfNRpiWfiRirWdLd1phLuyvnTMCtwWSX1InCfVzVvnUHmR5xDwcEvsfYeDhrqRBA84
         Cu1BBhv8e8X35AiJKbA3bWS6LN4IhGdV24TOQNXcuDB7RgtatFBoX0CyCClfsumJ/CrO
         zj0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ndVC/xnRF2wA2OxS2u5R4c7vHglSA7us+u3ARVQalBk=;
        b=VrROhHYtR2lx9db7pVgPJ7JHnZ/wLC4hyKq87jnAJw14riLkHpiotY4L2ra9pINJet
         ILT+9AQfjCg8xe21fzI5OTpxk3+ZYypy85hsxG6lt8j2g8/buLVaU9WnK+CO1RKRooLh
         kXHR9XcMN1+JK1QnIEb0Ecwy2RjBc43MV6iWDao+Atce9lUBVBubZoRdzQb7EtyrvqKF
         t+shjZFT0gnntQb1dhjOsPwC2D/dV0IM8QqrNrNXK9L/FPv6GGoHqOCr8ajdc5VlEE1K
         PESP5EzbJc0nABSoUeJQa2f7rrMh73pY8pM8UnrI60teWXcvBqLh4xrRJL9q/Vaccuc5
         F1ow==
X-Gm-Message-State: ANoB5pk+pscDwMrwfT5WlrsS0ueG60xS2JR5kTx3o0D/uDgk3oMIKo0n
        75i/cVeNikWip6NHFAfE7FE=
X-Google-Smtp-Source: AA0mqf78z1/d2yiYYUJ1nKTqwnbhN+FqWb7sUjSki01WBflug/06fGBuEieYmzmuMf+N0Smr3TEfWw==
X-Received: by 2002:a05:6402:1d87:b0:459:41fa:8e07 with SMTP id dk7-20020a0564021d8700b0045941fa8e07mr33731354edb.140.1669711973871;
        Tue, 29 Nov 2022 00:52:53 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id cz7-20020a0564021ca700b0046adde27bcasm4143167edb.38.2022.11.29.00.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 00:52:53 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 29 Nov 2022 09:52:51 +0100
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCHv4 bpf-next 2/4] bpf: Add bpf_vma_build_id_parse function
 and kfunc
Message-ID: <Y4XIY2sV39VxgutD@krava>
References: <20221128132915.141211-1-jolsa@kernel.org>
 <20221128132915.141211-3-jolsa@kernel.org>
 <CAEf4BzaZCUoxN_X2ALXwQeFTCwtL17R4P_B_-hUCcidfyO2xyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzaZCUoxN_X2ALXwQeFTCwtL17R4P_B_-hUCcidfyO2xyQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 28, 2022 at 05:15:44PM -0800, Andrii Nakryiko wrote:
> On Mon, Nov 28, 2022 at 5:29 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding bpf_vma_build_id_parse function to retrieve build id from
> > passed vma object and making it available as bpf kfunc.
> 
> As a completely different way of solving this problem of retrieving
> build_id for tracing needs, can we teach kernel itself to parse and
> store build_id (probably gated behind Kconfig option) in struct file
> (ideally)? On exec() and when mmap()'ing with executable permissions,
> Linux kernel will try to fetch build_id from ELF file and if
> successful store it in struct file. Given build_id can be up to 20
> bytes (currently) and not each struct file points to executable, we
> might want to only add a pointer field to `struct file` itself, which,
> if build_id is present, will point to
> 
> struct build_id {
>     char sz;
>     char data[];
> };
> 
> This way we don't increase `struct file` by much.
> 
> And then any BPF program would be able to easily probe_read_kernel
> such build_id from vma_area_struct->vm_file->build_id?
> 
> I'm sure I'm oversimplifying, but this seems like a good solution for
> all kinds of profiling BPF programs without the need to maintain all
> these allowlists and adding new helpers/kfuncs?

good idea, that would make it much easier, will check

jirka

> 
> I know Hao was looking at the problem of getting build_id, I'm curious
> if something like this would work for their use cases as well?
> 
> 
> >
> > We can't use build_id_parse directly as kfunc, because we would
> > not have control over the build id buffer size provided by user.
> >
> > Instead we are adding new bpf_vma_build_id_parse function with
> > 'build_id__sz' argument that instructs verifier to check for the
> > available space in build_id buffer.
> >
> > This way we check that there's always available memory space
> > behind build_id pointer. We also check that the build_id__sz is
> > at least BUILD_ID_SIZE_MAX so we can place any buildid in.
> >
> > The bpf_vma_build_id_parse kfunc is marked as KF_TRUSTED_ARGS,
> > so it can be only called with trusted vma objects. These are
> > currently provided only by find_vma callback function and
> > task_vma iterator program.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/linux/bpf.h      |  4 ++++
> >  kernel/trace/bpf_trace.c | 31 +++++++++++++++++++++++++++++++
> >  2 files changed, 35 insertions(+)
> >
> 
> [...]
