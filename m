Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56D0576659
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 19:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiGORrf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Jul 2022 13:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiGORrY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 13:47:24 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACAA31DDA
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 10:47:22 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id v16so7674801wrd.13
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 10:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g8/90hhhpjUkplTAJC66s00mf5yeEC6gJowVeI8MAlQ=;
        b=WRy93W+YLnHCUt03hATCC/sl4yVi+MS9opbhLAm3UFiFdpyFdV8UpL47toHBLdYQy5
         DiNjKnEOr3UXI24pVxapU3kQ4JtrhfmBbnfEwLASk9QoxuaBkfI+OcVx9bDcpP0PvNNr
         Sh0H6neoLSc72codynkTK3R8ZYgUCp6j/SOjmN0qcaY/Wn2S/m9Y9uOMifzpD2kdSL02
         h59l6wjawfMk/Fxz0vtqAPVHV9x8UXTaYSDtltAiQryQG3gq7nGVVlwF5v+BifxOW6tF
         6bKScL6ABXLD2Aq106Dg3FbRdLYpx+MaBP+1SYyEJ81yEyqTsy4jhHLxEc09D9YitahW
         kLPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g8/90hhhpjUkplTAJC66s00mf5yeEC6gJowVeI8MAlQ=;
        b=Vo0/JC+le37+sJ1Yka9QH0ysNm0DqViCTM2VgUAKtE2gbVxoLv0e+Qzc5YlC1iCtCF
         /35dbfIym/wJ5OposoC9+JKJSnxaCEsJ2VjzVH5TtXHhmttaBgIt+okMoymd6UtdAcwJ
         8PX0rJwP1qKhCciuDjtXvheMn3J0zRYubL156V3+odBzFj3yLkICwzp4O6Su89gszhz3
         rTljAlfZs2fChPOS2ErHLm8KPaw/+CvZdT77Z9t5cLe+F6tez7+jPnNmFqVxiTMEOuL+
         q55QdxdA3NUSKCrZwPBUZh3XzT6J5XfY/o8baNNGMDPhpExDHdeTa+P9UII+pyJie5G5
         glkQ==
X-Gm-Message-State: AJIora+77mTDvM392Sr4pUgy2KNcjabNmcgBh+x0buzdKTwRZ8pqmpl2
        MIzeaionb/zo06eL6Z98NYg=
X-Google-Smtp-Source: AGRyM1tmuBVS/s4dVvigoAjwuC4UKQJJmCp/yo5KoHLFHElI+XREnYtX3WqtJd92rKsrKs8kIvYYUg==
X-Received: by 2002:adf:df86:0:b0:21d:8506:99e2 with SMTP id z6-20020adfdf86000000b0021d850699e2mr13981930wrl.696.1657907241287;
        Fri, 15 Jul 2022 10:47:21 -0700 (PDT)
Received: from jondnuc ([2a0d:6fc2:4af0:cc00:f99d:5d19:6e17:dc3a])
        by smtp.gmail.com with ESMTPSA id bg11-20020a05600c3c8b00b003a1980d55c4sm10384377wmb.47.2022.07.15.10.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 10:47:20 -0700 (PDT)
Date:   Fri, 15 Jul 2022 20:47:19 +0300
From:   Jon Doron <arilou@gmail.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, Jon Doron <jond@wiz.io>
Subject: Re: [PATCH bpf-next v4] libbpf: perfbuf: Add API to get the ring
 buffer
Message-ID: <YtGoJ8W8Vm19nzpz@jondnuc>
References: <20220715171540.134813-1-arilou@gmail.com>
 <23ee86bc-c4f2-0a05-120b-555f7c1a02fa@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <23ee86bc-c4f2-0a05-120b-555f7c1a02fa@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 15/07/2022, Yonghong Song wrote:
>
>
>On 7/15/22 10:15 AM, Jon Doron wrote:
>>From: Jon Doron <jond@wiz.io>
>>
>>Add support for writing a custom event reader, by exposing the ring
>>buffer.
>>
>>With the new API perf_buffer__buffer() you will get access to the
>>raw mmaped()'ed per-cpu underlying memory of the ring buffer.
>>
>>This region contains both the perf buffer data and header
>>(struct perf_event_mmap_page), which manages the ring buffer
>>state (head/tail positions, when accessing the head/tail position
>>it's important to take into consideration SMP).
>>With this type of low level access one can implement different types of
>>consumers here are few simple examples where this API helps with:
>>
>>1. perf_event_read_simple is allocating using malloc, perhaps you want
>>    to handle the wrap-around in some other way.
>>2. Since perf buf is per-cpu then the order of the events is not
>>    guarnteed, for example:
>>    Given 3 events where each event has a timestamp t0 < t1 < t2,
>>    and the events are spread on more than 1 CPU, then we can end
>>    up with the following state in the ring buf:
>>    CPU[0] => [t0, t2]
>>    CPU[1] => [t1]
>>    When you consume the events from CPU[0], you could know there is
>>    a t1 missing, (assuming there are no drops, and your event data
>>    contains a sequential index).
>>    So now one can simply do the following, for CPU[0], you can store
>>    the address of t0 and t2 in an array (without moving the tail, so
>>    there data is not perished) then move on the CPU[1] and set the
>>    address of t1 in the same array.
>>    So you end up with something like:
>>    void **arr[] = [&t0, &t1, &t2], now you can consume it orderely
>>    and move the tails as you process in order.
>>3. Assuming there are multiple CPUs and we want to start draining the
>>    messages from them, then we can "pick" with which one to start with
>>    according to the remaining free space in the ring buffer.
>>
>>Signed-off-by: Jon Doron <jond@wiz.io>
>>---
>>  tools/lib/bpf/libbpf.c   | 16 ++++++++++++++++
>>  tools/lib/bpf/libbpf.h   | 16 ++++++++++++++++
>>  tools/lib/bpf/libbpf.map |  2 ++
>>  3 files changed, 34 insertions(+)
>>
>>diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>>index e89cc9c885b3..c18bdb9b6e85 100644
>>--- a/tools/lib/bpf/libbpf.c
>>+++ b/tools/lib/bpf/libbpf.c
>>@@ -12485,6 +12485,22 @@ int perf_buffer__buffer_fd(const struct perf_buffer *pb, size_t buf_idx)
>>  	return cpu_buf->fd;
>>  }
>>+int perf_buffer__buffer(struct perf_buffer *pb, int buf_idx, void **buf, size_t *buf_size)
>>+{
>>+	struct perf_cpu_buf *cpu_buf;
>>+
>>+	if (buf_idx >= pb->cpu_cnt)
>>+		return libbpf_err(-EINVAL);
>>+
>>+	cpu_buf = pb->cpu_bufs[buf_idx];
>>+	if (!cpu_buf)
>>+		return libbpf_err(-ENOENT);
>>+
>>+	*buf = cpu_buf->base;
>>+	*buf_size = pb->mmap_size;
>>+	return 0;
>>+}
>>+
>>  /*
>>   * Consume data from perf ring buffer corresponding to slot *buf_idx* in
>>   * PERF_EVENT_ARRAY BPF map without waiting/polling. If there is no data to
>>diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
>>index 9e9a3fd3edd8..9cd9fc1a16d2 100644
>>--- a/tools/lib/bpf/libbpf.h
>>+++ b/tools/lib/bpf/libbpf.h
>>@@ -1381,6 +1381,22 @@ LIBBPF_API int perf_buffer__consume(struct perf_buffer *pb);
>>  LIBBPF_API int perf_buffer__consume_buffer(struct perf_buffer *pb, size_t buf_idx);
>>  LIBBPF_API size_t perf_buffer__buffer_cnt(const struct perf_buffer *pb);
>>  LIBBPF_API int perf_buffer__buffer_fd(const struct perf_buffer *pb, size_t buf_idx);
>>+/**
>>+ * @brief **perf_buffer__buffer()** returns the per-cpu raw mmap()'ed underlying
>>+ * memory region of the ring buffer.
>>+ * This ring buffer can be used to implement a custom events consumer.
>>+ * The ring buffer starts with the *struct perf_event_mmap_page*, which
>>+ * holds the ring buffer managment fields, when accessing the header
>>+ * structure it's important to be SMP aware.
>>+ * You can refer to *perf_event_read_simple* for a simple example.
>>+ * @param pb the perf buffer structure
>>+ * @param buf_idx the buffer index to retreive
>>+ * @param buf (out) gets the base pointer of the mmap()'ed memory
>>+ * @param buf_size (out) gets the size of the mmap()'ed region
>>+ * @return 0 on success, negative error code for failure
>>+ */
>>+LIBBPF_API int perf_buffer__buffer(struct perf_buffer *pb, int buf_idx, void **buf,
>>+				   size_t *buf_size);
>>  typedef enum bpf_perf_event_ret
>>  	(*bpf_perf_event_print_t)(struct perf_event_header *hdr,
>>diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
>>index 52973cffc20c..75cf9d4c871b 100644
>>--- a/tools/lib/bpf/libbpf.map
>>+++ b/tools/lib/bpf/libbpf.map
>>@@ -461,5 +461,7 @@ LIBBPF_0.8.0 {
>>  } LIBBPF_0.7.0;
>>  LIBBPF_1.0.0 {
>>+	global:
>>+		perf_buffer__buffer;
>
>You probably use a old version of bpf-next?
>The latest bpf-next has
>
>LIBBPF_1.0.0 {
>        global:
>                bpf_prog_query_opts;
>                btf__add_enum64;
>                btf__add_enum64_value;
>                libbpf_bpf_attach_type_str;
>                libbpf_bpf_link_type_str;
>                libbpf_bpf_map_type_str;
>                libbpf_bpf_prog_type_str;
>};
>
>You need to add perf_buffer__buffer after libbpf_bpf_prog_type_str 
>(alphabet order).
>

I was working on top of origin/master in:
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
The HEAD is:
commit 9b59ec8d50a1f28747ceff9a4f39af5deba9540e (origin/master, origin/HEAD)

Is there a different git I should rebase on?

>>  	local: *;
>>  };
