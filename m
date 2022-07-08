Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F9D56B285
	for <lists+bpf@lfdr.de>; Fri,  8 Jul 2022 08:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237206AbiGHGIS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Jul 2022 02:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237193AbiGHGIS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Jul 2022 02:08:18 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643902CC89
        for <bpf@vger.kernel.org>; Thu,  7 Jul 2022 23:08:16 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l40-20020a05600c1d2800b003a18adff308so505980wms.5
        for <bpf@vger.kernel.org>; Thu, 07 Jul 2022 23:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=imWg30juxebp2+HgmLEcTTd8vT1XfY31E7uJrSMb3vY=;
        b=Alv+EqeA5ynzjC23/kfYq9z4mRCm0c0zgF40ogwbRfHD0h1c0vWRGkCJ/WXs4rXMJL
         1U2MbkdGYfXeKmzzvPldLdv9qXtcFs3zc4QcTDFaBLwVUdh4+Bd5WeEH3WyN5jxkr/d0
         PAdXVRqlYN4QNiZd92YX1YhmeP46aAeTv9nY2IwP+/TrGe8Lwwdn0sHDnugnGzplOfFD
         W4sXyS79E8/+p0lITwb3XXFNqacWy4YRtks4BbYQq+NWc384NJZ3w3Ma/c2f+X32uAWu
         6zUKRQQ0sZOfDt7hcB5sZerU9T/JSTdu2PswrtRQpN0K5QuRPnABwYjImlkP9EYFi+vF
         cx9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=imWg30juxebp2+HgmLEcTTd8vT1XfY31E7uJrSMb3vY=;
        b=j4MeILS6Qfad6Hq8Emf7EXU0MvjEy3FgBtFnb1Hbo0pbUmRDiuJxmJ/USJe8K43OA/
         G8pClcVmsiVlijF3nkmMLyBiWSbC2R0042IY8YI4s0GP51XgAOkEDApBM6P4Mkw52GHv
         mn6WNtcPdXVatvwYyfKwYUd+B+3YViqF2g9DnSckM8aADEeRGsfN+DHg6XMNWGNlFogt
         zuAxyYtsVYVpHEGxXlcKmM8o+wbA5oEamu4gd0KyZwa4Zu6k3Nhd/TsdVuGilpQZM/St
         ey7svjX22vulr1d1G2rlPidoqwg7N9TaDYMeGVrPjY3cY6KGSwtUZDp7z3QdUuZjDSSU
         LPZQ==
X-Gm-Message-State: AJIora93ZQhP9MmYDZRfJv+WKJU6PM2o3hr6zIhhcRtApWzP/vT+zGF4
        xslEAFvT4Owx0ty7hzSY3PkIwZakk0E=
X-Google-Smtp-Source: AGRyM1tfZBK7FZvS34LCFF+cScl04YbePNAc5RifhoqRxrEJFQ9dTJ0zELn+Dni8YbZHX+uPdqV4CA==
X-Received: by 2002:a1c:a1c4:0:b0:3a0:48dc:defa with SMTP id k187-20020a1ca1c4000000b003a048dcdefamr1674866wme.59.1657260494830;
        Thu, 07 Jul 2022 23:08:14 -0700 (PDT)
Received: from jondnuc ([2a0d:6fc2:4af0:cc00:f99d:5d19:6e17:dc3a])
        by smtp.gmail.com with ESMTPSA id a3-20020a1cf003000000b0039c8a22554bsm1022893wmb.27.2022.07.07.23.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 23:08:14 -0700 (PDT)
Date:   Fri, 8 Jul 2022 09:08:12 +0300
From:   Jon Doron <arilou@gmail.com>
To:     Song Liu <song@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, Jon Doron <jond@wiz.io>
Subject: Re: [PATCH v1 1/1] libbpf: perfbuf: allow raw access to buffers
Message-ID: <YsfJzASkXAFSFCAy@jondnuc>
References: <20220707071339.1486742-1-arilou@gmail.com>
 <20220707071339.1486742-2-arilou@gmail.com>
 <CAPhsuW7k3ExOjjonL=-=sg_rx0kyrgF=k7jxb+W0ZpxgxnoeLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAPhsuW7k3ExOjjonL=-=sg_rx0kyrgF=k7jxb+W0ZpxgxnoeLA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 07/07/2022, Song Liu wrote:

Hi Song Liu, thank you for the fast reply, I'll add comments on top
of your original email.

I will not be available through out next week, so sorry if I'll have a 
late reply for follow ups.

Thanks in advance,
-- Jon.

>On Thu, Jul 7, 2022 at 12:14 AM Jon Doron <arilou@gmail.com> wrote:
>
>Please prefix the patch with the target tree (bpf or bpf-next). For example,
>this patch should go via bpf-next.

Done

>>
>> From: Jon Doron <jond@wiz.io>
>>
>> Add API for perfbuf to support writing a custom event reader.
>
>This is too brief for such change. It is ok to duplicate text from the cover
>letter.
>

Done

>Please also update libbpf.map.
>

Done

>Also, we should add a selftest to use these new APIs.
>

I'm not sure I'm following here what were you had in mind, in practice I 
could just change **bpf_perf_event_read_simple** implementation to use
these new APIs to initialize it's variables (data_head, data_tail, 
base, mmap_size) and it would act exactly the same.

>>
>> Signed-off-by: Jon Doron <jond@wiz.io>
>> ---
>>  tools/lib/bpf/libbpf.c | 40 ++++++++++++++++++++++++++++++++++++++++
>>  tools/lib/bpf/libbpf.h |  6 ++++++
>>  2 files changed, 46 insertions(+)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index e89cc9c885b3..37299aa05185 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -12433,6 +12433,46 @@ static int perf_buffer__process_records(struct perf_buffer *pb,
>>         return 0;
>>  }
>>
>> +int perf_buffer__raw_ring_buf(const struct perf_buffer *pb, size_t buf_idx,
>> +                             void **base, size_t *buf_size, __u64 *head,
>> +                             __u64 *tail)
>
>Please add comments to each API function.

Done

>> +{
>> +       struct perf_cpu_buf *cpu_buf;
>> +       struct perf_event_mmap_page *header;
>> +
>> +       if (buf_idx >= pb->cpu_cnt)
>> +               return libbpf_err(-EINVAL);
>> +
>> +       cpu_buf = pb->cpu_bufs[buf_idx];
>> +       if (!cpu_buf)
>> +               return libbpf_err(-ENOENT);
>> +
>> +       header = cpu_buf->base;
>> +       *head = ring_buffer_read_head(header);
>> +       *tail = header->data_tail;
>> +       *base = ((__u8 *)header) + pb->page_size;
>> +       *buf_size = pb->mmap_size;
>> +       return 0;
>> +}
>> +
>> +int perf_buffer__set_ring_buf_tail(const struct perf_buffer *pb, size_t buf_idx,
>> +                                  __u64 tail)
>> +{
>> +       struct perf_cpu_buf *cpu_buf;
>> +       struct perf_event_mmap_page *header;
>> +
>> +       if (buf_idx >= pb->cpu_cnt)
>> +               return libbpf_err(-EINVAL);
>> +
>> +       cpu_buf = pb->cpu_bufs[buf_idx];
>> +       if (!cpu_buf)
>> +               return libbpf_err(-ENOENT);
>> +
>> +       header = cpu_buf->base;
>> +       ring_buffer_write_tail(header, tail);
>> +       return 0;
>> +}
>> +
>>  int perf_buffer__epoll_fd(const struct perf_buffer *pb)
>>  {
>>         return pb->epoll_fd;
>> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
>> index 9e9a3fd3edd8..b6f6b6a12d70 100644
>> --- a/tools/lib/bpf/libbpf.h
>> +++ b/tools/lib/bpf/libbpf.h
>> @@ -1381,6 +1381,12 @@ LIBBPF_API int perf_buffer__consume(struct perf_buffer *pb);
>>  LIBBPF_API int perf_buffer__consume_buffer(struct perf_buffer *pb, size_t buf_idx);
>>  LIBBPF_API size_t perf_buffer__buffer_cnt(const struct perf_buffer *pb);
>>  LIBBPF_API int perf_buffer__buffer_fd(const struct perf_buffer *pb, size_t buf_idx);
>> +LIBBPF_API int perf_buffer__raw_ring_buf(const struct perf_buffer *pb,
>> +                                        size_t buf_idx, void **base,
>> +                                        size_t *buf_size, __u64 *head,
>> +                                        __u64 *tail);
>> +LIBBPF_API int perf_buffer__set_ring_buf_tail(const struct perf_buffer *pb,
>> +                                             size_t buf_idx, __u64 tail);
>>
>>  typedef enum bpf_perf_event_ret
>>         (*bpf_perf_event_print_t)(struct perf_event_header *hdr,
>> --
>> 2.36.1
>>
