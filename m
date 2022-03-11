Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738114D567C
	for <lists+bpf@lfdr.de>; Fri, 11 Mar 2022 01:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344860AbiCKAZH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Mar 2022 19:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240304AbiCKAZG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Mar 2022 19:25:06 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC941A12A5
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 16:24:03 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id hu12so5855760qvb.6
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 16:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C0NJCF215u7J1keWHi6UUO/2cqd9pO2REm63LKre0R0=;
        b=MIUeSn8OYMGKM8eYxc6CG4lNAZsIgeK628Xe2+I9+LMKomBR6RsPIZoXcUB0LX4UY0
         1joG4HRzqHJDO2cOEFMSOcOqY6pRmnFsoNZpkmgcbDRgR9pHxOMK15xwZCoCgv1RNMEO
         DYFyfYu2uZj9Zm8Ic7zt5bYFEGDXUhWngyAXxIrqJIZ4Gvw6upyEbcxzncXDzkyXwaKU
         fL74LBGBYt/f7A2+4A6EvclX+a+SkJMUVkh5NN09Y+esV6JBKgA2o1KmyCu4Dw1RGpaU
         1t+mI4u7axYdiNvfuqizL3kqmMVV+uJV+LR3s2jjgKnCSNuHLlSXHDM+EamzTk6mRyFR
         VziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C0NJCF215u7J1keWHi6UUO/2cqd9pO2REm63LKre0R0=;
        b=ChNNObxEKeJZRIoUGToHKGtMQlhZtp5DZ66f/Hpw511mLf8MvDbeAB7sh+f/r+aFYv
         7MZXmI8lCbXkAIP2UPYpluFaJbXZDQRxlDlZiDhJ10XEACwEhb7g3UUIZ47rssNaz9W+
         qACXeUYGr57uCMjs5NQWCU02hazHy0foLSW2N2bD01FCYgoEH3Imh6L4/iSm8/4oMTqj
         tQ2mveYX95DppobrXbTE38y9JxMAfk5P3OlXLUoHLZoEzmnkURX8SgoonW2e6yd9Pyyt
         LZJa+vK+aJFcqiXo5jDTHDGFeAbkO9KzKBAHvnEFoiHRnJswTjZhSxXcsWAx1smPB0ce
         JNAg==
X-Gm-Message-State: AOAM5321zRehOHh3z6sC3MilfpjTqWlil+FV4Z8sAkIRErV4k5jYToxe
        Y17Qxuvy5Z/U8ZgeH9diMZTMOWSYBV8sitEr1hIkiw==
X-Google-Smtp-Source: ABdhPJwr1wtw/pT+vuVD46ep8QP6+ZhcO8m5MDj8JhahngMWKxiAsIhBSVF51eS0DsOu6lwsUIfuOXWMC0F+Zf8lPbE=
X-Received: by 2002:a05:6214:2a4a:b0:435:8b63:ecfb with SMTP id
 jf10-20020a0562142a4a00b004358b63ecfbmr6118246qvb.44.1646958241993; Thu, 10
 Mar 2022 16:24:01 -0800 (PST)
MIME-Version: 1.0
References: <20220310082202.1229345-1-namhyung@kernel.org> <d2af0d13-68cf-ad8c-5b16-af76201452c4@fb.com>
In-Reply-To: <d2af0d13-68cf-ad8c-5b16-af76201452c4@fb.com>
From:   Hao Luo <haoluo@google.com>
Date:   Thu, 10 Mar 2022 16:23:50 -0800
Message-ID: <CA+khW7ieO9QbGYdJQvg8vpYLi-yoUQcZDze8wtpf5qqSiNxosQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] bpf: Adjust BPF stack helper functions to accommodate
 skip > 0
To:     Yonghong Song <yhs@fb.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Eugene Loh <eugene.loh@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 10, 2022 at 2:54 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 3/10/22 12:22 AM, Namhyung Kim wrote:
> > Let's say that the caller has storage for num_elem stack frames.  Then,
> > the BPF stack helper functions walk the stack for only num_elem frames.
> > This means that if skip > 0, one keeps only 'num_elem - skip' frames.
> >
> > This is because it sets init_nr in the perf_callchain_entry to the end
> > of the buffer to save num_elem entries only.  I believe it was because
> > the perf callchain code unwound the stack frames until it reached the
> > global max size (sysctl_perf_event_max_stack).
> >
> > However it now has perf_callchain_entry_ctx.max_stack to limit the
> > iteration locally.  This simplifies the code to handle init_nr in the
> > BPF callstack entries and removes the confusion with the perf_event's
> > __PERF_SAMPLE_CALLCHAIN_EARLY which sets init_nr to 0.
> >
> > Also change the comment on bpf_get_stack() in the header file to be
> > more explicit what the return value means.
> >
> > Based-on-patch-by: Eugene Loh <eugene.loh@oracle.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>
> The change looks good to me. This patch actually fixed a bug
> discussed below:
>
>
> https://lore.kernel.org/bpf/30a7b5d5-6726-1cc2-eaee-8da2828a9a9c@oracle.com/
>
> A reference to the above link in the commit message
> will be useful for people to understand better with an
> example.
>
> Also, the following fixes tag should be added:
>
> Fixes: c195651e565a ("bpf: add bpf_get_stack helper")
>
> Since the bug needs skip > 0 which is seldomly used,
> and the current returned stack is still correct although
> with less entries, I guess that is why less people
> complains.
>
> Anyway, ack the patch:
> Acked-by: Yonghong Song <yhs@fb.com>
>
>
> > ---
> >   include/uapi/linux/bpf.h |  4 +--
> >   kernel/bpf/stackmap.c    | 56 +++++++++++++++++-----------------------
> >   2 files changed, 26 insertions(+), 34 deletions(-)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index b0383d371b9a..77f4a022c60c 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -2975,8 +2975,8 @@ union bpf_attr {
> >    *
> >    *                  # sysctl kernel.perf_event_max_stack=<new value>
> >    *  Return
> > - *           A non-negative value equal to or less than *size* on success,
> > - *           or a negative error in case of failure.
> > + *           The non-negative copied *buf* length equal to or less than
> > + *           *size* on success, or a negative error in case of failure.
> >    *
> >    * long bpf_skb_load_bytes_relative(const void *skb, u32 offset, void *to, u32 len, u32 start_header)

Namhyung, I think you also need to mirror the change in
tools/include/uapi/linux/bpf.h
