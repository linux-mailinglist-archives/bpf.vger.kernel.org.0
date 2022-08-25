Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA6B5A1CF3
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 01:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiHYXJ5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 19:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiHYXJz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 19:09:55 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013716579;
        Thu, 25 Aug 2022 16:09:54 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id h22so65166ejk.4;
        Thu, 25 Aug 2022 16:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=HCxmx0yNyTL2kArb9XWDSOaf8yKfNMf3XRyDp4h9L44=;
        b=a3ysaU+RBdGx9frb9s6eh4DxM+sPlE3829qYp2oK7W4W1IUQbBkbW9EgchxFLlPLj3
         hDnqgqsRNyZFKU0Sp41XaddaOxo+h2fbzXDN0xcLzYsyr/2AH6XtxOrHfTe+q1oaNSGM
         cxgqEx7kSkCLOjLGWzcGzHNwC3iwZB0RFGxCDM303rrbk55STw7WcgB4LeXRcEUR4kWF
         Kv+tbLrm/jEDRDIU8e8ICG4P04xStY5FsAgmTLGbLb2xC1aBsxQmot0iwGBmqgtS5syj
         SkOZLM37PK70p3xcoEwxfTD29CB8UhE+/bpNOuOFMcTwtHSz+yIeRC7WbMKFVO6LKcrr
         iA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=HCxmx0yNyTL2kArb9XWDSOaf8yKfNMf3XRyDp4h9L44=;
        b=hrBJZgBxJHmVHbRxeD5kWfXUfGYsThf/2F8FlN2QPTrpClT+R1I/wmQLQWfAuUmeLA
         gdoWUskGAtG6vuStzZO8c0drt3RuwmGxbOx79QH0qCaVSrOftsH3XsyhMbD9GQNIvplP
         n1XD1VmWD9o7UY5cc+keDa7KLb+zRdzoDhk8pJuAc6sPDsZeeRrIljABsr5oqwfPb7Tb
         7Btsk0zIjhdhCFaPeFr1JRHXr17MCmMD+TuSmrqhx9CtzQ+it6bKE/mq56aa/T2qRW5W
         6GPL0xqNs3F2paP2MqwnnY2oJ7+m6AIeXT4+Ggvt/z2A1HhuqHSvgcLC81oTXb4yl7j7
         icJw==
X-Gm-Message-State: ACgBeo2Lr+3RqSXrFc2gvVuhccKdO2cZL8oxD9kDIKLjQRw4CC4cFVJ6
        Uj7waHoIqRslYm4cRGtHFXpEe7BMWM40w1s60Rk=
X-Google-Smtp-Source: AA6agR5BKoWqDFUIfCH68ExU6ZwkLv/dc4tB0HYqnXDyoVFT9DGVF7Os6K1Q4TXe8hkrnf5+50PsuAnjIkqlQ01QpS8=
X-Received: by 2002:a17:907:6e8b:b0:73d:c094:e218 with SMTP id
 sh11-20020a1709076e8b00b0073dc094e218mr3892228ejc.226.1661468992546; Thu, 25
 Aug 2022 16:09:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220823210354.1407473-1-namhyung@kernel.org> <CAEf4Bzbd0-jGFCSCJu3eDxxom42xnH9Tevq0n50-AajjHb5t3g@mail.gmail.com>
 <CAM9d7cjiGjO5dAw_zf01+j=5cvd6cnz0_TK4OJW5MVxDwi7psA@mail.gmail.com>
In-Reply-To: <CAM9d7cjiGjO5dAw_zf01+j=5cvd6cnz0_TK4OJW5MVxDwi7psA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 25 Aug 2022 16:09:41 -0700
Message-ID: <CAEf4BzaTwj=Uq_AZBoGSS-4Wkrz1xC2oiwJJednWVKRBogJd9Q@mail.gmail.com>
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
        Ingo Molnar <mingo@kernel.org>, bpf <bpf@vger.kernel.org>,
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

On Thu, Aug 25, 2022 at 3:13 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hello,
>
> On Thu, Aug 25, 2022 at 2:34 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Aug 23, 2022 at 2:04 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > The helper is for BPF programs attached to perf_event in order to read
> > > event-specific raw data.  I followed the convention of the
> > > bpf_read_branch_records() helper so that it can tell the size of
> > > record using BPF_F_GET_RAW_RECORD flag.
> > >
> > > The use case is to filter perf event samples based on the HW provided
> > > data which have more detailed information about the sample.
> > >
> > > Note that it only reads the first fragment of the raw record.  But it
> > > seems mostly ok since all the existing PMU raw data have only single
> > > fragment and the multi-fragment records are only for BPF output attached
> > > to sockets.  So unless it's used with such an extreme case, it'd work
> > > for most of tracing use cases.
> > >
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > > I don't know how to test this.  As the raw data is available on some
> > > hardware PMU only (e.g. AMD IBS).  I tried a tracepoint event but it was
> > > rejected by the verifier.  Actually it needs a bpf_perf_event_data
> > > context so that's not an option IIUC.
> > >
> > >  include/uapi/linux/bpf.h | 23 ++++++++++++++++++++++
> > >  kernel/trace/bpf_trace.c | 41 ++++++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 64 insertions(+)
> > >
> > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > index 934a2a8beb87..af7f70564819 100644
> > > --- a/include/uapi/linux/bpf.h
> > > +++ b/include/uapi/linux/bpf.h
> > > @@ -5355,6 +5355,23 @@ union bpf_attr {
> > >   *     Return
> > >   *             Current *ktime*.
> > >   *
> > > + * long bpf_read_raw_record(struct bpf_perf_event_data *ctx, void *buf, u32 size, u64 flags)
> > > + *     Description
> > > + *             For an eBPF program attached to a perf event, retrieve the
> > > + *             raw record associated to *ctx* and store it in the buffer
> > > + *             pointed by *buf* up to size *size* bytes.
> > > + *     Return
> > > + *             On success, number of bytes written to *buf*. On error, a
> > > + *             negative value.
> > > + *
> > > + *             The *flags* can be set to **BPF_F_GET_RAW_RECORD_SIZE** to
> > > + *             instead return the number of bytes required to store the raw
> > > + *             record. If this flag is set, *buf* may be NULL.
> >
> > It looks pretty ugly from a usability standpoint to have one helper
> > doing completely different things and returning two different values
> > based on BPF_F_GET_RAW_RECORD_SIZE.
>
> Agreed.
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
>
> I like this as I want to have more info for the perf event sample like
> instruction address or sample type.  I know some of the info is
> available through the context but I think this is a better approach.
>
> >
> > 2. Keep one helper, but specify that it always returns record size,
> > even if user specified smaller size to read. And then allow passing
> > buf==NULL && size==0. So passing NULL, 0 -- you get record size.
> > Passing non-NULL buf -- you read data.
> >
> >
> > And also, "read_raw_record" is way too generic. We have
> > bpf_perf_prog_read_value(), let's use "bpf_perf_read_raw_record()" as
> > a name. We should have called bpf_read_branch_records() as
> > bpf_perf_read_branch_records(), probably, as well. But it's too late.
>
> Yeah, what about this?
>
>  * bpf_perf_event_query(ctx, flag)
>  * bpf_perf_event_get(ctx, flag, buf, size)
>
> Maybe we can use the same flag for both.  Like BPF_PERF_RAW_RECORD
> can return the size (or -1 if not) on _query() and read the data on _get().
> Or we can have a BPF_PERF_RAW_RECORD_SIZE only for _query().
> It seems we don't need _get() for things like BPF_PERF_SAMPLE_IP.
> What do you think?
>

probably separate flags makes more sense, because I can see how we can
allow querying multiple up-to-u64-sized things (even sample_ip, for
example), while reserve bpf_perf_event_get() to variable-size or big
sized values.

Not super keen on "get", "read" or "load" is the verb we typically use
for such operations, but we already have bpf_perf_event_read(). And
bpf_perf_event_load() doesn't seem right either. Naming is hard. Maybe
"fetch"? Or just "get". Don't know, but maybe someone has good ideas.

> Thanks,
> Namhyung
