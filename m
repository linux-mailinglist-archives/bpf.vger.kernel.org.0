Return-Path: <bpf+bounces-6100-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8311765BCD
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 21:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41C60281A56
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 19:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3F31989A;
	Thu, 27 Jul 2023 19:00:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F353427127
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 19:00:15 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A81E30C5;
	Thu, 27 Jul 2023 12:00:14 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-686f8614ce5so816740b3a.3;
        Thu, 27 Jul 2023 12:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690484413; x=1691089213;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HPGWKRpk2Fz9v/1VmZ5uRMYeY+s+4KXrK0E516edFpk=;
        b=AH59uZ1P/rVgUKRK+i7ZyOlcwXYMicrqUtdshlHIuNmlX8fAMHL665Ty1oCVhsLPWT
         RTLhcWN63EE8jZD2cGQV6w0xYkQ/zHBO+YcMiljBxCAjPeoQGw/lyq1E86xmQtj7LJz0
         2XqaXLOfnRgQtD/Z9bjqCrMm58dF9L5c3j4wvLXvQNOFD7fnqBXAQiyOhIvRdmn04PeA
         bYulhN8sTVVUaAt/ScZhw5m5e6BR9n9MSueGN9y2sZbdNKf+WBfvxoEYvEIouSc+lzqq
         i7lXqBRM++pDfqPlhfof4HvBy6McIVhenm7M4XChlefbbXJMMY304ecGcZM0aIJr/UXq
         /26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690484413; x=1691089213;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HPGWKRpk2Fz9v/1VmZ5uRMYeY+s+4KXrK0E516edFpk=;
        b=aIS/h8/ozEfORMdL3e9d6/0+4gHyCEiRPxDiiLfRIsS9/GpRYko25uuZmNK+b5vl9k
         KuX4L0GF49mw0RLXr/aPOy4Lgpco24TyTlXytN+Zpj6tCOxlf2NbzwybBZ7yVvHyT6Gx
         SEFCsR+jIHLF6nDh1zes+MIB1SnPz7DSDc0QGrYn85moU0YxuiyMj5q8z6g5QCQ5/7KL
         F9sO+2HHL7n1fPEvJrhJgiU6SXJMdfya8L7cvl2HWzRgGQieTji2HPQJ1Dmt7TjqcMz/
         j3pLvn+uz/qHWzFOhu2OQLlK8JXwWl+BWHmXLpsI7sLQnRLikW0abEalyguyNZrP3L+p
         gc9A==
X-Gm-Message-State: ABy/qLZjorAfbUPkXzSTWfZFL3cR33YbkPlNOoOJzY3qeiSfinlyYlm3
	38bjetQugc9t9s2o9aNU1Q8=
X-Google-Smtp-Source: APBJJlEipMIGnVsvgRGIsBE1HP21D6Nj42yo8XW274BgmYCtsKxyxVJkguXl54qu8myHzzuHxj3RQQ==
X-Received: by 2002:a05:6a20:8f1e:b0:137:db14:e88b with SMTP id b30-20020a056a208f1e00b00137db14e88bmr7956946pzk.29.1690484413162;
        Thu, 27 Jul 2023 12:00:13 -0700 (PDT)
Received: from localhost ([2605:59c8:148:ba10:705d:54ca:a48d:47da])
        by smtp.gmail.com with ESMTPSA id a9-20020a631a09000000b00563590be25esm1858427pga.29.2023.07.27.12.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 12:00:12 -0700 (PDT)
Date: Thu, 27 Jul 2023 12:00:10 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Adam Sindelar <adam@wowsignal.io>, 
 bpf@vger.kernel.org
Cc: Adam Sindelar <ats@fb.com>, 
 David Vernet <void@manifault.com>, 
 Brendan Jackman <jackmanb@google.com>, 
 KP Singh <kpsingh@chromium.org>, 
 linux-kernel@vger.kernel.org, 
 Alexei Starovoitov <ast@kernel.org>, 
 Florent Revest <revest@chromium.org>
Message-ID: <64c2bebadbbba_831d208b3@john.notmuch>
In-Reply-To: <20230727083436.293201-1-adam@wowsignal.io>
References: <20230727083436.293201-1-adam@wowsignal.io>
Subject: RE: [PATCH bpf-next v4] libbpf: Expose API to consume one ring at a
 time
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Adam Sindelar wrote:
> We already provide ring_buffer__epoll_fd to enable use of external
> polling systems. However, the only API available to consume the ring
> buffer is ring_buffer__consume, which always checks all rings. When
> polling for many events, this can be wasteful.
> 
> Signed-off-by: Adam Sindelar <adam@wowsignal.io>
> ---
> v1->v2: Added entry to libbpf.map
> v2->v3: Correctly set errno and handle overflow
> v3->v4: Fixed an embarrasing typo from zealous autocomplete
> 
>  tools/lib/bpf/libbpf.h   |  1 +
>  tools/lib/bpf/libbpf.map |  1 +
>  tools/lib/bpf/ringbuf.c  | 22 ++++++++++++++++++++++
>  3 files changed, 24 insertions(+)
> 
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 55b97b2087540..20ccc65eb3f9d 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -1195,6 +1195,7 @@ LIBBPF_API int ring_buffer__add(struct ring_buffer *rb, int map_fd,
>  				ring_buffer_sample_fn sample_cb, void *ctx);
>  LIBBPF_API int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms);
>  LIBBPF_API int ring_buffer__consume(struct ring_buffer *rb);
> +LIBBPF_API int ring_buffer__consume_ring(struct ring_buffer *rb, uint32_t ring_id);
>  LIBBPF_API int ring_buffer__epoll_fd(const struct ring_buffer *rb);
>  
>  struct user_ring_buffer_opts {
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 9c7538dd5835e..42dc418b4672f 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -398,4 +398,5 @@ LIBBPF_1.3.0 {
>  		bpf_prog_detach_opts;
>  		bpf_program__attach_netfilter;
>  		bpf_program__attach_tcx;
> +		ring_buffer__consume_ring;
>  } LIBBPF_1.2.0;
> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> index 02199364db136..457469fc7d71e 100644
> --- a/tools/lib/bpf/ringbuf.c
> +++ b/tools/lib/bpf/ringbuf.c
> @@ -290,6 +290,28 @@ int ring_buffer__consume(struct ring_buffer *rb)
>  	return res;
>  }
>  
> +/* Consume available data from a single RINGBUF map identified by its ID.
> + * The ring ID is returned in epoll_data by epoll_wait when called with
> + * ring_buffer__epoll_fd.
> + */
> +int ring_buffer__consume_ring(struct ring_buffer *rb, uint32_t ring_id)
> +{
> +	struct ring *ring;
> +	int64_t res;
> +
> +	if (ring_id >= rb->ring_cnt)
> +		return libbpf_err(-EINVAL);
> +
> +	ring = &rb->rings[ring_id];
> +	res = ringbuf_process_ring(ring);
> +	if (res < 0)
> +		return libbpf_err(res);
> +
> +	if (res > INT_MAX)
> +		return INT_MAX;
> +	return res;

Why not just return int64_t here? Then skip the INT_MAX check? I would
just assume get the actual value if I was calling this.

> +}
> +
>  /* Poll for available data and consume records, if any are available.
>   * Returns number of records consumed (or INT_MAX, whichever is less), or
>   * negative number, if any of the registered callbacks returned error.
> -- 
> 2.39.2
> 
> 



