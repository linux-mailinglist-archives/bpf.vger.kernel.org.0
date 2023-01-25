Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1C167A95F
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 04:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjAYDty (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 22:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjAYDtx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 22:49:53 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197E9485BF
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 19:49:52 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id az20so44345948ejc.1
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 19:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DCBbFCrXdwZZbPrnppBRBm0p31YxMzGRRqmSle342gI=;
        b=QqC4mD5w712vbxJ+aslqK/iy+OkS6ZcISF5ayN8ioFRtzw01a6qw5xYT1PWKrt1x4f
         9ufUusA1+mcqwW4vYxgv6WXrktnvQnzmWiqeMh1NcaxzwOpaN2PwtWjX36QTnYOw7mfc
         Eod6hzKoUjxKdOHfGF7p2Lcx++HG5T8rpZFUqlDA7mejrY9FOeYSCXQT5rkQOxkqJlVN
         FevSYZNjVU8lShtB6LbHHGw9ntmEllaeLEnVQ8NZBGu5v+mm5zvj/OqJWkOKm+qqcQIQ
         hTvb3xMkfsxkuP1YJBiLTW/+6HDKTdAYI/NhD0VOZn3E3A/J0HRdMSK+xlmKzWjUVnXW
         k/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DCBbFCrXdwZZbPrnppBRBm0p31YxMzGRRqmSle342gI=;
        b=LK+JumYpZFXUzbXiVjcg3cMFScBsu+OIZa+932DDOtyAmzdB9nm0o7riXjWxvdPA1L
         cw9Ep/8+ZP5fAw0o0fqgj56NHFPmB8+xDL4rt+R5hXbqIXMhfAUXJG3LoEhpQfnqwud3
         QhYKk8EfTSf7XK5DwzJpo9sR5sQz4EnHyCZ75q1yLyfgmkQ5Th35gKw+kbWkgIwpWVXK
         keDJc0fWDVW7voymHa9Eeam1Ku9vmBuuh6t5vZTLwRFVup048yNpn4x+S66VJGaZ9n2X
         tPvelAQ7hNTXf/RLQKbrOseQa879SldJgu5+EgxSk2fynYXonbEvhB0/bZyTvxgkpqVU
         Nn1A==
X-Gm-Message-State: AFqh2kpEk9oOiZ8p0Ag+f69x2xGrPZKJYMDx0BTFtBgIg2iJ/DqUg7eU
        Xl9iIn8EHy20aE1V0uPbGS2hHtBuXMDK7ZWS12k=
X-Google-Smtp-Source: AMrXdXtIZguddUDp83CT+MXiFrvW/WZhXtCPYiDevAsWavGEarnzWKY7hg8H1KaVk7LmBTRAbDtatJqoU3HPtxq+v5Q=
X-Received: by 2002:a17:906:5a94:b0:84d:3b9a:e2b3 with SMTP id
 l20-20020a1709065a9400b0084d3b9ae2b3mr2736306ejq.318.1674618590458; Tue, 24
 Jan 2023 19:49:50 -0800 (PST)
MIME-Version: 1.0
References: <20230124143626.250719-1-jolsa@kernel.org>
In-Reply-To: <20230124143626.250719-1-jolsa@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 24 Jan 2023 19:49:38 -0800
Message-ID: <CAADnVQLpk2-fcjgkOssuaT82Pdtu1KzgnxjHXiBV1TJzYXjtWQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/5] bpf: Move kernel test kfuncs into bpf_testmod
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 24, 2023 at 6:36 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> hi,
> I noticed several times in discussions that we should move test kfuncs
> into kernel module, now perhaps even more pressing with all the kfunc
> effort. This patchset moves all the test kfuncs into bpf_testmod.
>
> I added bpf_testmod/bpf_testmod_kfunc.h header that is shared between
> bpf_testmod kernel module and BPF programs, which brings some difficulties
> with __ksym define. But I'm not sure having separate headers for BPF
> programs and for kernel module would be better.

This part looks fine and overall it's great.
Thanks a lot for working on this.
But see failing tests.
test_progs-no_alu32 -t cb_refs
is consistently failing.
Also it seems it introduces instability into other tests.
BPF CI isn't happy.
