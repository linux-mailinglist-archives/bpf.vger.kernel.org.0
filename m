Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D445A1B21
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 23:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243684AbiHYVeL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 17:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbiHYVeJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 17:34:09 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA539BE4E4;
        Thu, 25 Aug 2022 14:34:08 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id h22so31746700ejk.4;
        Thu, 25 Aug 2022 14:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Pzl9gLiTxZNXiExduEHbPetxKhGc6qFasSkzKZiLVdk=;
        b=UjUYsxG8W9bdXfHsN7AE7FaubveLGPve4TqqxsuTc6BR9HAqMbbb327ISq0VDZr521
         m2Cafk9ReH7skcxnAJonDTlMdchp53p8TvbmHkgKS560+5fFRaSjzNeDTyXMCu8AIEUI
         12Nt7uYFsyRqqDmQrdHqMtwSL2INhd3l9mOwyMUGoxj3ZMIrPiaNKklvYpycHzWEiZTG
         q4A8X3FdgGHI9OqLwivlvUeFE/V2bUCgNTYL+e+2LYw7qJc1TuStfBW7I9Ttki8KGrkX
         DSpaSIXY9oIAhJBm6EHy5WdDMw7uLDaFJf5MvH/ZpuoczGBHHdMJvgGe+oIKSMPQH7XM
         51kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Pzl9gLiTxZNXiExduEHbPetxKhGc6qFasSkzKZiLVdk=;
        b=kv/HS2MTVAqLPh3W1nwePEG3Ge/oAoyG3WFBAmIsw0BSVeOVO/QY+zjXX26CMAcqkg
         E4BxzeTsZ2XjwwxSMxiNcr9+i8JnzBcvIIsJrMfKZh/ROnTjcBKIlrx+F0ZNac0lCC72
         0/zYhn3x8D7yobL2xjM72TMvzFsBgqWnSfVU4jLnjcwcPtRdPhu9Lm61fz2eHC3+Dr3s
         V8x9NV4gnHDBS5Qn266snOvH1ikyIIKfBAIdRFH2r67Sz7e9OpRjU8+5KyWHcUUD3/UQ
         OwzfWQ5/ObObLUa7jStHbZXFBh+KaDx0W7k/ocJ1yXMHHcdQ6fsx/LJBhHSL14t5harr
         FHXw==
X-Gm-Message-State: ACgBeo3BP9MnTrYvj1Erx2FQPO0RfyVBRnhLYkMB668B7IVaw1tDr/uT
        Elf+/62xaETsKp/jl7fD75TfxLNsx8l6y9SUW+k=
X-Google-Smtp-Source: AA6agR7wM2bmeMatR9YBcLK5by8I58CFNgT+If4GLn6ZlDDlW7nn3Ljcso4Fi6WcGsp5hnJ/LhIVaAKOvg3I4FqAE2s=
X-Received: by 2002:a17:907:6096:b0:73d:9d12:4b04 with SMTP id
 ht22-20020a170907609600b0073d9d124b04mr3706378ejc.745.1661463247383; Thu, 25
 Aug 2022 14:34:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220823210354.1407473-1-namhyung@kernel.org>
In-Reply-To: <20220823210354.1407473-1-namhyung@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 25 Aug 2022 14:33:56 -0700
Message-ID: <CAEf4Bzbd0-jGFCSCJu3eDxxom42xnH9Tevq0n50-AajjHb5t3g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Add bpf_read_raw_record() helper
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, bpf@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
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

On Tue, Aug 23, 2022 at 2:04 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> The helper is for BPF programs attached to perf_event in order to read
> event-specific raw data.  I followed the convention of the
> bpf_read_branch_records() helper so that it can tell the size of
> record using BPF_F_GET_RAW_RECORD flag.
>
> The use case is to filter perf event samples based on the HW provided
> data which have more detailed information about the sample.
>
> Note that it only reads the first fragment of the raw record.  But it
> seems mostly ok since all the existing PMU raw data have only single
> fragment and the multi-fragment records are only for BPF output attached
> to sockets.  So unless it's used with such an extreme case, it'd work
> for most of tracing use cases.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
> I don't know how to test this.  As the raw data is available on some
> hardware PMU only (e.g. AMD IBS).  I tried a tracepoint event but it was
> rejected by the verifier.  Actually it needs a bpf_perf_event_data
> context so that's not an option IIUC.
>
>  include/uapi/linux/bpf.h | 23 ++++++++++++++++++++++
>  kernel/trace/bpf_trace.c | 41 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 64 insertions(+)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 934a2a8beb87..af7f70564819 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5355,6 +5355,23 @@ union bpf_attr {
>   *     Return
>   *             Current *ktime*.
>   *
> + * long bpf_read_raw_record(struct bpf_perf_event_data *ctx, void *buf, u32 size, u64 flags)
> + *     Description
> + *             For an eBPF program attached to a perf event, retrieve the
> + *             raw record associated to *ctx* and store it in the buffer
> + *             pointed by *buf* up to size *size* bytes.
> + *     Return
> + *             On success, number of bytes written to *buf*. On error, a
> + *             negative value.
> + *
> + *             The *flags* can be set to **BPF_F_GET_RAW_RECORD_SIZE** to
> + *             instead return the number of bytes required to store the raw
> + *             record. If this flag is set, *buf* may be NULL.

It looks pretty ugly from a usability standpoint to have one helper
doing completely different things and returning two different values
based on BPF_F_GET_RAW_RECORD_SIZE.

I'm not sure what's best, but I have two alternative proposals:

1. Add two helpers: one to get perf record information (and size will
be one of them). Something like bpf_perf_record_query(ctx, flags)
where you pass perf ctx and what kind of information you want to read
(through flags), and u64 return result returns that (see
bpf_ringbuf_query() for such approach). And then have separate helper
to read data.

2. Keep one helper, but specify that it always returns record size,
even if user specified smaller size to read. And then allow passing
buf==NULL && size==0. So passing NULL, 0 -- you get record size.
Passing non-NULL buf -- you read data.


And also, "read_raw_record" is way too generic. We have
bpf_perf_prog_read_value(), let's use "bpf_perf_read_raw_record()" as
a name. We should have called bpf_read_branch_records() as
bpf_perf_read_branch_records(), probably, as well. But it's too late.

> + *
> + *             **-EINVAL** if arguments invalid or **size** not a multiple
> + *             of **sizeof**\ (u64\ ).
> + *
> + *             **-ENOENT** if the event does not have raw records.
>   */
>  #define __BPF_FUNC_MAPPER(FN)          \
>         FN(unspec),                     \
> @@ -5566,6 +5583,7 @@ union bpf_attr {
>         FN(tcp_raw_check_syncookie_ipv4),       \
>         FN(tcp_raw_check_syncookie_ipv6),       \
>         FN(ktime_get_tai_ns),           \
> +       FN(read_raw_record),            \
>         /* */
>

[...]
