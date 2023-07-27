Return-Path: <bpf+bounces-6107-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE71765EFA
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 00:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17C372824F9
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 22:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5DE1DA5D;
	Thu, 27 Jul 2023 22:11:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE1217AC1
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 22:11:10 +0000 (UTC)
Received: from out-101.mta1.migadu.com (out-101.mta1.migadu.com [95.215.58.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EF4271E
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 15:11:08 -0700 (PDT)
Message-ID: <38a585f1-fcbe-01ec-cc4c-63058b824f2f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690495866; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mDfxM8VujKA0wIuHAnqnppoIHUE5olFbUxZ3AXNPMug=;
	b=eezK/geLM39yIb2IZSaBX9LIa4JXiVFxgBkMOWQctySN+3cJ3G9hhPzSeh83R112J0Mfm9
	l6F7mVff9HVndFqSb269Tq53SvTHvSlsvKD+zeYqR4fq8/cCzC8aKgq+gRtYA5UV6s3iPY
	vuyx64MHaqy/AFSQeavD7E9cs+fvsVc=
Date: Thu, 27 Jul 2023 15:11:00 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v4] libbpf: Expose API to consume one ring at a
 time
Content-Language: en-US
To: Adam Sindelar <adam@wowsignal.io>, bpf@vger.kernel.org
Cc: Adam Sindelar <ats@fb.com>, David Vernet <void@manifault.com>,
 Brendan Jackman <jackmanb@google.com>, KP Singh <kpsingh@chromium.org>,
 linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Florent Revest <revest@chromium.org>
References: <20230727083436.293201-1-adam@wowsignal.io>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230727083436.293201-1-adam@wowsignal.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/27/23 1:34 AM, Adam Sindelar wrote:
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
>   tools/lib/bpf/libbpf.h   |  1 +
>   tools/lib/bpf/libbpf.map |  1 +
>   tools/lib/bpf/ringbuf.c  | 22 ++++++++++++++++++++++
>   3 files changed, 24 insertions(+)

Could you add a selftest to exercise ring_buffer__consume_ring()?
This way, people can better understand how this API could be used.

> 
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 55b97b2087540..20ccc65eb3f9d 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -1195,6 +1195,7 @@ LIBBPF_API int ring_buffer__add(struct ring_buffer *rb, int map_fd,
>   				ring_buffer_sample_fn sample_cb, void *ctx);
>   LIBBPF_API int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms);
>   LIBBPF_API int ring_buffer__consume(struct ring_buffer *rb);
> +LIBBPF_API int ring_buffer__consume_ring(struct ring_buffer *rb, uint32_t ring_id);
>   LIBBPF_API int ring_buffer__epoll_fd(const struct ring_buffer *rb);
>   
[...]

