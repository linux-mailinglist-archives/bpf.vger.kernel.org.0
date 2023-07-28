Return-Path: <bpf+bounces-6174-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB66E766567
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 09:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E78FC1C217B5
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 07:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2CCC2FB;
	Fri, 28 Jul 2023 07:32:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96355C2C0
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 07:32:41 +0000 (UTC)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B74D2728
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 00:32:39 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fe1b00fce2so2138196e87.3
        for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 00:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wowsignal-io.20221208.gappssmtp.com; s=20221208; t=1690529558; x=1691134358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rShMrosUmh0EdEzXKMAb9i5WGW24ya+miL9oggxZp0A=;
        b=Omu+eF771bwL8mEvV7PbQre/YQAEcimr14qNkg81KX+KpS5fZxw3qEFM8kT4jSa8de
         P5ErENRZ41KYleAAYpsQqHVT5RGgYQWthK7cBggpnPkBihhPQm5rYtmknYOUMrhYeyiV
         naOlxjva+BLZ7K+KpTKzwMk4tQmKjz7a2IBKxZKv4s3HLP3B+iO55eCn2q2ct2eedPaG
         /OCRamIYK19KO0o1j69O3CHbLprfBs5narWaB1ItyBaC4nwojWj9b/prEY2MGz1RGjGl
         DV7/9B/QZtmaYVy2YrvQMYNfPQDkQd7mdvpodDm7kIEudYRS88I+gXDv5bLIp+YAy7Pn
         MXhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690529558; x=1691134358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rShMrosUmh0EdEzXKMAb9i5WGW24ya+miL9oggxZp0A=;
        b=lFiNn3/DKl0TNwIANChsLJ/Up3B6eMREiaReOnCRrO6zq/Pa3iV4fCpwu8oYOlwhax
         LiWx78F3BBJh8W0sFB26YWU9DvTcULq8hOnn80ljrzLeYIL2IHe+Uv5L1riZrNYMe3kX
         /4sgZArGhz2VrJSF3/yKbMXex4OaI+htkdzXxzRskzQ39zKjcyv1BB7zGY3KfLcexzH6
         S8qazeWSuh2SRNnyIYMOl7hCWheoSq/bD8Z80RhVkOngZzYyY3J6oQ6jU3GtW2AusW0q
         2IDoxfYbNax2sr3mZGf76tXodZkJpG8JBQ067yzoR28dWZMB7lO6YQpeOd9RT0af8JR2
         k6pA==
X-Gm-Message-State: ABy/qLYtFtBsy+PpCdHJf84ELWJNt4p30o2EMr70eXwu02z5FmIHGhSa
	pDvrxvro883Istt6zukgR3pBNg==
X-Google-Smtp-Source: APBJJlEAyJ93oA9s8RteIR05B18LPvCGdKOQDFEgZEEFzKtfqiS1Ou395DblJfgbRuZxT6WTZeBdhg==
X-Received: by 2002:a19:4305:0:b0:4f8:56cd:da8c with SMTP id q5-20020a194305000000b004f856cdda8cmr909789lfa.34.1690529557565;
        Fri, 28 Jul 2023 00:32:37 -0700 (PDT)
Received: from localhost (212-51-140-210.fiber7.init7.net. [212.51.140.210])
        by smtp.gmail.com with ESMTPSA id d12-20020a5d644c000000b003142e438e8csm4100820wrw.26.2023.07.28.00.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 00:32:37 -0700 (PDT)
Date: Fri, 28 Jul 2023 09:32:35 +0200
From: Adam Sindelar <adam@wowsignal.io>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Adam Sindelar <ats@fb.com>,
	David Vernet <void@manifault.com>,
	Brendan Jackman <jackmanb@google.com>,
	KP Singh <kpsingh@chromium.org>, linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Florent Revest <revest@chromium.org>
Subject: Re: [PATCH bpf-next v4] libbpf: Expose API to consume one ring at a
 time
Message-ID: <ZMNvE-v3oyFWt2R_@Momo.fritz.box>
References: <20230727083436.293201-1-adam@wowsignal.io>
 <38a585f1-fcbe-01ec-cc4c-63058b824f2f@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38a585f1-fcbe-01ec-cc4c-63058b824f2f@linux.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 27, 2023 at 03:11:00PM -0700, Yonghong Song wrote:
> 
> 
> On 7/27/23 1:34 AM, Adam Sindelar wrote:
> > We already provide ring_buffer__epoll_fd to enable use of external
> > polling systems. However, the only API available to consume the ring
> > buffer is ring_buffer__consume, which always checks all rings. When
> > polling for many events, this can be wasteful.
> > 
> > Signed-off-by: Adam Sindelar <adam@wowsignal.io>
> > ---
> > v1->v2: Added entry to libbpf.map
> > v2->v3: Correctly set errno and handle overflow
> > v3->v4: Fixed an embarrasing typo from zealous autocomplete
> > 
> >   tools/lib/bpf/libbpf.h   |  1 +
> >   tools/lib/bpf/libbpf.map |  1 +
> >   tools/lib/bpf/ringbuf.c  | 22 ++++++++++++++++++++++
> >   3 files changed, 24 insertions(+)
> 
> Could you add a selftest to exercise ring_buffer__consume_ring()?
> This way, people can better understand how this API could be used.
> 

Yes, will do - I'll try to send out v5 with a test case this afternoon.

As a note, I looked at the perf ring buffer API and it turns out Andrii
Nakryiko saw the same problem and solved in a similar way in 2020. (See
perf_buffer__consume_buffer).

> > 
> > diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> > index 55b97b2087540..20ccc65eb3f9d 100644
> > --- a/tools/lib/bpf/libbpf.h
> > +++ b/tools/lib/bpf/libbpf.h
> > @@ -1195,6 +1195,7 @@ LIBBPF_API int ring_buffer__add(struct ring_buffer *rb, int map_fd,
> >   				ring_buffer_sample_fn sample_cb, void *ctx);
> >   LIBBPF_API int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms);
> >   LIBBPF_API int ring_buffer__consume(struct ring_buffer *rb);
> > +LIBBPF_API int ring_buffer__consume_ring(struct ring_buffer *rb, uint32_t ring_id);
> >   LIBBPF_API int ring_buffer__epoll_fd(const struct ring_buffer *rb);
> [...]

