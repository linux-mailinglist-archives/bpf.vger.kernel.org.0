Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A415D5A1CEC
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 01:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiHYXDn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 19:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiHYXDm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 19:03:42 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4902C2F87;
        Thu, 25 Aug 2022 16:03:37 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z8so183754edb.0;
        Thu, 25 Aug 2022 16:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=uy4eH0cBiH6VU7iDFo4rGPAwd8NTm7jEGdIZq3tRJxM=;
        b=d4FVXcH8g22QdNUlTFXYjsz3gDlyRAh4ZnMhVQbhaR8KUSAMJ1t7SnnuMeH28v3bMy
         C/lwGiKZhGz9mAOTqe1lhnNUCOrfy89en1XSHEBwNPrMyd9IURQjIskBNV+5XNJTq+w6
         zctifzwtpvMOmGlMv45gtFv8jmbLReyKdFUb65e+RXmZyUSdohxNOvDk13+1F0fBlB7p
         3TYK+PuN51hFJICB4S4lAVJsRSHEnHACp82xGHDkmWgGN+iIA1gJvVBwAl2BSMpntqDq
         RaV9WFjttTSWOfvKfAis3/8AQKnAtaIidtIHWIJONlUcKfgH5U973PFdAC8YALVazAK3
         7TTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=uy4eH0cBiH6VU7iDFo4rGPAwd8NTm7jEGdIZq3tRJxM=;
        b=Y53WNirwpIowSQ6rVN0t5Odqv5V3Uo2IAR1IlWLORiqOdhDFxGUEkxw+2c3Ie4nggz
         DOA39DCeR0DfznEafjy3TK5olGR15jkP+6uBTWO0ewyXw/HDGHFdvZ75poQdnoYKXdhr
         BYtjuw/Csz5olQ/XulbBNdgjEJI5YTThLjqeNLUjVNBu8z9bCDNgrIjNokPBZlPmdzJH
         9Ii/gVIUqYSxG6lxtJQMbnYKzUOLYIPJjuBSzTZojgrgtJPTYy1HVpSi/ydeeqvEZtwm
         akOq21pOoTRAI0dcOWHikDvLiu2pu8MA962egm7DmLgSDgg1hcYA821M7YB57KRORqjX
         Myew==
X-Gm-Message-State: ACgBeo2BHnhuoD7zccCRvbEtNwA0/Qi3kBPuRiT4vJrc8VJBqwC99rGn
        zkrCn7WY3mn1MtERpoF72y5CliIHqhGp63Or8cg=
X-Google-Smtp-Source: AA6agR4RdyM3LN7R9+lXS9ivos/4rO05SuMvNAdDk2Xg3cZd9pdH4WAX7BiPOZIDwdUUrIU9vuK5JpLPjSLNdYKBruY=
X-Received: by 2002:a05:6402:24a4:b0:440:8c0c:8d2b with SMTP id
 q36-20020a05640224a400b004408c0c8d2bmr4677996eda.311.1661468616191; Thu, 25
 Aug 2022 16:03:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220823210354.1407473-1-namhyung@kernel.org> <CAEf4Bzbd0-jGFCSCJu3eDxxom42xnH9Tevq0n50-AajjHb5t3g@mail.gmail.com>
 <A9E2E766-E8A2-4E2E-A661-922400D2674D@fb.com>
In-Reply-To: <A9E2E766-E8A2-4E2E-A661-922400D2674D@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 25 Aug 2022 16:03:24 -0700
Message-ID: <CAEf4BzbGf6FuM7VcnA7HKb33HJeJjrDuydC4h1_tCUB8sPCW2g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Add bpf_read_raw_record() helper
To:     Song Liu <songliubraving@fb.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
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

On Thu, Aug 25, 2022 at 3:08 PM Song Liu <songliubraving@fb.com> wrote:
>
>
>
> > On Aug 25, 2022, at 2:33 PM, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Aug 23, 2022 at 2:04 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >>
> >> The helper is for BPF programs attached to perf_event in order to read
> >> event-specific raw data.  I followed the convention of the
> >> bpf_read_branch_records() helper so that it can tell the size of
> >> record using BPF_F_GET_RAW_RECORD flag.
> >>
> >> The use case is to filter perf event samples based on the HW provided
> >> data which have more detailed information about the sample.
> >>
> >> Note that it only reads the first fragment of the raw record.  But it
> >> seems mostly ok since all the existing PMU raw data have only single
> >> fragment and the multi-fragment records are only for BPF output attached
> >> to sockets.  So unless it's used with such an extreme case, it'd work
> >> for most of tracing use cases.
> >>
> >> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> >> ---
> >> I don't know how to test this.  As the raw data is available on some
> >> hardware PMU only (e.g. AMD IBS).  I tried a tracepoint event but it was
> >> rejected by the verifier.  Actually it needs a bpf_perf_event_data
> >> context so that's not an option IIUC.
> >>
> >> include/uapi/linux/bpf.h | 23 ++++++++++++++++++++++
> >> kernel/trace/bpf_trace.c | 41 ++++++++++++++++++++++++++++++++++++++++
> >> 2 files changed, 64 insertions(+)
> >>
> >> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> >> index 934a2a8beb87..af7f70564819 100644
> >> --- a/include/uapi/linux/bpf.h
> >> +++ b/include/uapi/linux/bpf.h
> >> @@ -5355,6 +5355,23 @@ union bpf_attr {
> >>  *     Return
> >>  *             Current *ktime*.
> >>  *
> >> + * long bpf_read_raw_record(struct bpf_perf_event_data *ctx, void *buf, u32 size, u64 flags)
> >> + *     Description
> >> + *             For an eBPF program attached to a perf event, retrieve the
> >> + *             raw record associated to *ctx* and store it in the buffer
> >> + *             pointed by *buf* up to size *size* bytes.
> >> + *     Return
> >> + *             On success, number of bytes written to *buf*. On error, a
> >> + *             negative value.
> >> + *
> >> + *             The *flags* can be set to **BPF_F_GET_RAW_RECORD_SIZE** to
> >> + *             instead return the number of bytes required to store the raw
> >> + *             record. If this flag is set, *buf* may be NULL.
> >
> > It looks pretty ugly from a usability standpoint to have one helper
> > doing completely different things and returning two different values
> > based on BPF_F_GET_RAW_RECORD_SIZE.
>
> Yeah, I had the same thought when I first looked at it. But that's the
> exact syntax with bpf_read_branch_records(). Well, we still have time
> to fix the new helper..
>
> >
> > I'm not sure what's best, but I have two alternative proposals:
> >
> > 1. Add two helpers: one to get perf record information (and size will
> > be one of them). Something like bpf_perf_record_query(ctx, flags)
> > where you pass perf ctx and what kind of information you want to read
> > (through flags), and u64 return result returns that (see
> > bpf_ringbuf_query() for such approach). And then have separate helper
> > to read data.
> >
> > 2. Keep one helper, but specify that it always returns record size,
> > even if user specified smaller size to read. And then allow passing
> > buf==NULL && size==0. So passing NULL, 0 -- you get record size.
> > Passing non-NULL buf -- you read data.
>
> AFAICT, this is also confusing.
>

this is analogous to snprintf() behavior, so not that new and
surprising when you think about it. But if query + read makes more
sense, then it's fine by me

> Maybe we should use two kfuncs for this?
>
> Thanks,
> Song
>
> >
> >
> > And also, "read_raw_record" is way too generic. We have
> > bpf_perf_prog_read_value(), let's use "bpf_perf_read_raw_record()" as
> > a name. We should have called bpf_read_branch_records() as
> > bpf_perf_read_branch_records(), probably, as well. But it's too late.
> >
> >> + *
> >> + *             **-EINVAL** if arguments invalid or **size** not a multiple
> >> + *             of **sizeof**\ (u64\ ).
> >> + *
> >> + *             **-ENOENT** if the event does not have raw records.
> >>  */
> >> #define __BPF_FUNC_MAPPER(FN)          \
> >>        FN(unspec),                     \
> >> @@ -5566,6 +5583,7 @@ union bpf_attr {
> >>        FN(tcp_raw_check_syncookie_ipv4),       \
> >>        FN(tcp_raw_check_syncookie_ipv6),       \
> >>        FN(ktime_get_tai_ns),           \
> >> +       FN(read_raw_record),            \
> >>        /* */
> >>
> >
> > [...]
>
