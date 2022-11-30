Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F1E63CCCF
	for <lists+bpf@lfdr.de>; Wed, 30 Nov 2022 02:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiK3B1o (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Nov 2022 20:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbiK3B1m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Nov 2022 20:27:42 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E8610FDE
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 17:27:40 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id o127so4287973yba.5
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 17:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5Vqii2pGYCt6X71oB8dXqVlQ8VTHgANSwMXKIAHG2Hs=;
        b=WKE4aDjgxcqYT/uQyQVhtC3ENgm2ATKkH3eekesgSr0oc1wJL5R1QRjJXN93eHwhLy
         /Sc6mff8ACZjBO+eREXT92FbN2+gvsI3CQCVr5WEsH3s4KoKJgfOG/pZC0U4hCTVbNqP
         u89Ofzn9td9ND7ylEwW33XfRtPYTeISOkA3dzEXqiJNlcch34UUkHyYGx9o+MR0rzj9x
         pJq1/6rYQss7aGaC/IVET4H33b/9iuzKL0FL21xJDG3Ca3RYtfeT3onvjC7HjiJlx8Y+
         gK73cP3VqHtNFg7uyBMmIYmMbX+H3/LGADcmb+WVjBcReGz6gmyoEblYGdZJ8DuzbkBI
         nVjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Vqii2pGYCt6X71oB8dXqVlQ8VTHgANSwMXKIAHG2Hs=;
        b=7dRpqLUX+YXAFtUAP+K6ZEBKvXIjm+rm8ysBa2K9JGWVHIeUjWIF7YBkawrxeJuK62
         4fz8zbWlvVhDDlOYlyLNYkJ7XuDZWjPxnAKK9sWbhCYAfrq7uxmqGxefsQItMMyo7IAW
         CLpz49eL8cbRqlqbnOVqCyIsUjIxBdJ8nfVvnrFHRn6J4wm6xhTbipcl0sDphUsfm2BH
         mhx8sGRfQqDpqjyCWpRTIjWDJoIaufD1CFVJTJybNw1Wztrr70I9bAtD78FV/8Bz28y9
         TXdf/vR6ZV9NNYEsZ48lbupEhkKDENw/5Xoti8ISZM03G8fRytF4QGNnga7bAp2ImNAQ
         XRWQ==
X-Gm-Message-State: ANoB5pkHXXhri4IinhXj4tc/NYdO0HiL1H8dUE4cia/GDXdoE/B3/e8q
        EwMnoD0/njliPl7p0xxjGdGZORLxnRid0NUvtUZwrA==
X-Google-Smtp-Source: AA0mqf5aBOBLKSbPCYquOgnN8txbKoLXuL+cTp7rtoLM7hSVFv+p1qqRH6kiLJxByVg/A8RRQ0gxwa3EeooNzCTiqZA=
X-Received: by 2002:a25:50f:0:b0:6f0:9351:486a with SMTP id
 15-20020a25050f000000b006f09351486amr33201906ybf.198.1669771659636; Tue, 29
 Nov 2022 17:27:39 -0800 (PST)
MIME-Version: 1.0
References: <20221128132915.141211-1-jolsa@kernel.org> <20221128132915.141211-3-jolsa@kernel.org>
 <CAEf4BzaZCUoxN_X2ALXwQeFTCwtL17R4P_B_-hUCcidfyO2xyQ@mail.gmail.com>
 <CA+khW7gAYHmoUkq0UqTiZjdOqARLG256USj3uFwi6z_FyZf31w@mail.gmail.com> <CAEf4Bza6R2uedPiKi_FXMPOVe-WGS5LO-EbBzpqK9T-xCybS5Q@mail.gmail.com>
In-Reply-To: <CAEf4Bza6R2uedPiKi_FXMPOVe-WGS5LO-EbBzpqK9T-xCybS5Q@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 29 Nov 2022 17:27:28 -0800
Message-ID: <CA+khW7jLegurLPiUkWx5-gVnS3rywB1NTO0dy5qDWSY+-R1mgA@mail.gmail.com>
Subject: Re: [PATCHv4 bpf-next 2/4] bpf: Add bpf_vma_build_id_parse function
 and kfunc
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 29, 2022 at 4:35 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> This is hardly a generic solution, as it requires instrumenting every
> application to do this, right? So what I'm proposing is exactly to
> avoid having each individual application do something special just to
> allow profiling tools to capture build_id.

I agree. Because the mlock approach is working, we didn't look further
or try improving it. But an upstreamable and generic solution would be
nice. I think Jiri has started looking at it, I am happy to help
there.

> Is this due to remapping some binary onto huge pages?

I think so, but I'm not sure.

> But regardless, your custom BPF applications can fetch this build_id
> from vm_area_struct->anon_name in pure BPF code, can't it? Why do you
> need to modify in-kernel build_id_parse implementation?

The user is using bpf_get_stack() to collect stack traces. They don't
implement walking the stack and fetching build_id from vma in their
BPF code.
