Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A420E6190D0
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 07:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiKDGSY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 02:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiKDGSX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 02:18:23 -0400
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70F42BD7;
        Thu,  3 Nov 2022 23:18:22 -0700 (PDT)
Received: by mail-oo1-f49.google.com with SMTP id z127-20020a4a4985000000b0049ea7fbfb74so54388ooa.11;
        Thu, 03 Nov 2022 23:18:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nxh4Ult4tm5HMVuIqJILNDXALWg7ao8LKqdSJkXImSw=;
        b=ho2soYdYdIShE/E5BV/jh2M4ZGBbwS27iUiN/xZfDjK/3t5qjmt7N/I+p4vuxDq5sP
         XnsA1AkfN04kNE6pv/V8dZzPFHu9CxXz1xGWST8eaYzv9yNxn5yR8K/vNQBnQ449uo8T
         R1Fr4qpRqZu2yAPnqDMOk+ElVEnevd9+Yb1f/oIl0ESVCwP2c97Tv/hmWu4UOSvYfbZk
         prkbsBfoo0QLb2LyX53wp/ftImYEtQo92MyViBgJyv/WcVf6hZnvJE6MQ/YzqDPCAi0q
         hCLhg921OxKFAoeG635d3G+aj0VWDkNY/2yy/VsbPVSnZ63MCqdOrojBIQ0AfBnQLQf/
         rRVA==
X-Gm-Message-State: ACrzQf0kJIHdvv0IAc2BCatZpMvP5eVfMN3sELUz8WFFNJhA3/ErUVHj
        tGgOhpbSFPk1j/HJMKPzC668jiCCFXXrqYX7hWM=
X-Google-Smtp-Source: AMsMyM5BrSDWcSzLzfxmOrcsbBP5hi2lYFdekiQC8E/8we5njTWkgJUIB5DeAdsgC4wjnecE654QQQgikdE53XrGitA=
X-Received: by 2002:a4a:b913:0:b0:480:b3bf:7812 with SMTP id
 x19-20020a4ab913000000b00480b3bf7812mr14565694ooo.97.1667542702047; Thu, 03
 Nov 2022 23:18:22 -0700 (PDT)
MIME-Version: 1.0
References: <20221101052340.1210239-1-namhyung@kernel.org> <20221101052340.1210239-3-namhyung@kernel.org>
 <Y2DuzmnUm6NIh25a@krava> <5b0152db-8a8e-0d8c-0304-8c48b735c3b7@meta.com>
 <CF3D88C5-4D62-48E2-97AB-F6A7FF9CEF9D@fb.com> <ad15b398-9069-4a0e-48cb-4bb651ec3088@meta.com>
In-Reply-To: <ad15b398-9069-4a0e-48cb-4bb651ec3088@meta.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 3 Nov 2022 23:18:10 -0700
Message-ID: <CAM9d7ch+rv8q2yDEFZm6FoDD=3oe9cVRcOX4738CnsJhM2Q_jQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: Add bpf_perf_event_read_sample() helper
To:     Yonghong Song <yhs@meta.com>
Cc:     Song Liu <songliubraving@meta.com>, Jiri Olsa <olsajiri@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Martin Lau <kafai@meta.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 3, 2022 at 2:21 PM Yonghong Song <yhs@meta.com> wrote:
>
>
>
> On 11/3/22 1:55 PM, Song Liu wrote:
> >
> >
> >> On Nov 3, 2022, at 12:45 PM, Yonghong Song <yhs@meta.com> wrote:
> >>
> >>
> >>
> >> On 11/1/22 3:02 AM, Jiri Olsa wrote:
> >>> On Mon, Oct 31, 2022 at 10:23:39PM -0700, Namhyung Kim wrote:
> >>>> The bpf_perf_event_read_sample() helper is to get the specified sample
> >>>> data (by using PERF_SAMPLE_* flag in the argument) from BPF to make a
> >>>> decision for filtering on samples.  Currently PERF_SAMPLE_IP and
> >>>> PERF_SAMPLE_DATA flags are supported only.
> >>>>
> >>>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> >>>> ---
> >>>>   include/uapi/linux/bpf.h       | 23 ++++++++++++++++
> >>>>   kernel/trace/bpf_trace.c       | 49 ++++++++++++++++++++++++++++++++++
> >>>>   tools/include/uapi/linux/bpf.h | 23 ++++++++++++++++
> >>>>   3 files changed, 95 insertions(+)
> >>>>
> >>>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> >>>> index 94659f6b3395..cba501de9373 100644
> >>>> --- a/include/uapi/linux/bpf.h
> >>>> +++ b/include/uapi/linux/bpf.h
> >>>> @@ -5481,6 +5481,28 @@ union bpf_attr {
> >>>>    *               0 on success.
> >>>>    *
> >>>>    *               **-ENOENT** if the bpf_local_storage cannot be found.
> >>>> + *
> >>>> + * long bpf_perf_event_read_sample(struct bpf_perf_event_data *ctx, void *buf, u32 size, u64 sample_flags)
> >>>> + *        Description
> >>>> + *                For an eBPF program attached to a perf event, retrieve the
> >>>> + *                sample data associated to *ctx* and store it in the buffer
> >>>> + *                pointed by *buf* up to size *size* bytes.
> >>>> + *
> >>>> + *                The *sample_flags* should contain a single value in the
> >>>> + *                **enum perf_event_sample_format**.
> >>>> + *        Return
> >>>> + *                On success, number of bytes written to *buf*. On error, a
> >>>> + *                negative value.
> >>>> + *
> >>>> + *                The *buf* can be set to **NULL** to return the number of bytes
> >>>> + *                required to store the requested sample data.
> >>>> + *
> >>>> + *                **-EINVAL** if *sample_flags* is not a PERF_SAMPLE_* flag.
> >>>> + *
> >>>> + *                **-ENOENT** if the associated perf event doesn't have the data.
> >>>> + *
> >>>> + *                **-ENOSYS** if system doesn't support the sample data to be
> >>>> + *                retrieved.
> >>>>    */
> >>>>   #define ___BPF_FUNC_MAPPER(FN, ctx...)                   \
> >>>>    FN(unspec, 0, ##ctx)                            \
> >>>> @@ -5695,6 +5717,7 @@ union bpf_attr {
> >>>>    FN(user_ringbuf_drain, 209, ##ctx)              \
> >>>>    FN(cgrp_storage_get, 210, ##ctx)                \
> >>>>    FN(cgrp_storage_delete, 211, ##ctx)             \
> >>>> +  FN(perf_event_read_sample, 212, ##ctx)          \
> >>>>    /* */
> >>>>     /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
> >>>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> >>>> index ce0228c72a93..befd937afa3c 100644
> >>>> --- a/kernel/trace/bpf_trace.c
> >>>> +++ b/kernel/trace/bpf_trace.c
> >>>> @@ -28,6 +28,7 @@
> >>>>     #include <uapi/linux/bpf.h>
> >>>>   #include <uapi/linux/btf.h>
> >>>> +#include <uapi/linux/perf_event.h>
> >>>>     #include <asm/tlb.h>
> >>>>   @@ -1743,6 +1744,52 @@ static const struct bpf_func_proto bpf_read_branch_records_proto = {
> >>>>    .arg4_type      = ARG_ANYTHING,
> >>>>   };
> >>>>   +BPF_CALL_4(bpf_perf_event_read_sample, struct bpf_perf_event_data_kern *, ctx,
> >>>> +     void *, buf, u32, size, u64, flags)
> >>>> +{
> >>> I wonder we could add perf_btf (like we have tp_btf) program type that
> >>> could access ctx->data directly without helpers
> >>
> >> Martin and I have discussed an idea to introduce a generic helper like
> >>     bpf_get_kern_ctx(void *ctx)
> >> Given a context, the helper will return a PTR_TO_BTF_ID representing the
> >> corresponding kernel ctx. So in the above example, user could call
> >>
> >>     struct bpf_perf_event_data_kern *kctx = bpf_get_kern_ctx(ctx);
> >>     ...
> >
> > This is an interesting idea!
> >
> >> To implement bpf_get_kern_ctx helper, the verifier can find the type
> >> of the context and provide a hidden btf_id as the second parameter of
> >> the actual kernel helper function like
> >>     bpf_get_kern_ctx(ctx) {
> >>        return ctx;
> >>     }
> >>     /* based on ctx_btf_id, find kctx_btf_id and return it to verifier */
> >
> > I think we will need a map of ctx_btf_id => kctx_btf_id. Shall we somehow
> > expose this to the user?
>
> Yes, inside the kernel we need ctx_btf_id -> kctx_btf_id mapping.
> Good question. We might not want to this mapping as a stable API.
> So using kfunc might be more appropriate.

Ok, now I don't think I'm following well.. ;-)

So currently perf event type BPF programs can have perf_event
data context directly as an argument, but we want to disallow it?
I guess the context id mapping can be done implicitly based on
the prog type and/or attach type, but probably I'm missing
something here. :)

Thanks,
Namhyung
