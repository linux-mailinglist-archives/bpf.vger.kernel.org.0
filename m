Return-Path: <bpf+bounces-6062-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CE1764D77
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 10:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23B72281A7B
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 08:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD17C2FD;
	Thu, 27 Jul 2023 08:34:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6290BD51B
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 08:34:43 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C3C41432
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 01:34:21 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-992e22c09edso83791866b.2
        for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 01:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690446811; x=1691051611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nUvK86AzIN7ZlL1xdRRVHzWzExphj9M3BOhUf1rA40k=;
        b=KgLkAYZv+ta3XaBsSFR3dQGvo9QtzAQ2o1jwXHRDnOnQZvy2KEeGKCdHxeJZFyqbyD
         c7Q3B6p2FkmuiX+rEENXtzY2TDfzZUwI+VBkhxRB9Jr57BwO6JNS/GP66GNL73ArzyzB
         w3Y6APCEIsGwaR6cDVHzx4U5xv7htbSW8PyP+W5ZJ8+df2BAnqZqQwqh973FEukzXIWt
         zv9CPRH0DCtcu1yjErlUZ3lglco9Ok1l5TMDhucqECK2U3hDeKy42wuTu8m03rLBvr3G
         z6LDoCvaVQfLoG8Il5dbv0Un9CrC65dWPkWdrWOZqcYIeTRyMrogPk5OqCMTRwUB7BL9
         oMAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690446811; x=1691051611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nUvK86AzIN7ZlL1xdRRVHzWzExphj9M3BOhUf1rA40k=;
        b=QbJciKGJiTUksxNIQZFbb9kAc1sdIfs/QyDohVI2kl4o1wqqJgKX09KQv3qmClhBuH
         LcNm37TOxu8ELrW6MeCGc+Msko5b8BLuLyXzV6bML260Xn7XufuZjCkOspifCkhzOcK4
         bpHgI7NeBafZcUqgu7V5/fQb3R6s12CnMZ9grN9i3fchiLl27Pa6mL0LkKQJKAHY9sqv
         ytmJGz3PJUCfE4dvduRK7yb0/ujB5iFEPe+ebhiv/lc9Ny6+NFwM8egStM36hIFfsBeX
         ByhjATLRmwpGBatxK6KLdtY8BkCYmeshoHiB1QiQjVWCCPr6PRbBNtrA9mW1SA74pdzr
         QzyQ==
X-Gm-Message-State: ABy/qLY5arGaFYMlwBwGXDtJvrtKgIw1Jq+Tqj3M7eUYyv7hs0XD/ire
	rc4WkP7orRFXYTVFDTcp9eA=
X-Google-Smtp-Source: APBJJlE63BBISGiGuSxlurg9tsEbp/txk7bd/+va20fiNOjuGhhAWX7k3HqKzCPkedUrliqTOs47+w==
X-Received: by 2002:a17:906:9bef:b0:987:5761:2868 with SMTP id de47-20020a1709069bef00b0098757612868mr1505178ejc.11.1690446811001;
        Thu, 27 Jul 2023 01:33:31 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id q20-20020a1709060e5400b00992b3ea1ee4sm499779eji.149.2023.07.27.01.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 01:33:30 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 27 Jul 2023 10:33:28 +0200
To: Andrew Werner <awerner32@gmail.com>
Cc: bpf@vger.kernel.org, kernel-team@dataexmachina.dev,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf-next v2] libbpf: handle producer position overflow
Message-ID: <ZMIr2GbRcvihtidX@krava>
References: <20230724132543.1282645-1-awerner32@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724132543.1282645-1-awerner32@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 24, 2023 at 09:25:45AM -0400, Andrew Werner wrote:
> Before this patch, the producer position could overflow `unsigned
> long`, in which case libbpf would forever stop processing new writes to
> the ringbuf. This patch addresses that bug by avoiding ordered
> comparison between the consumer and producer position. If the consumer
> position is greater than the producer position, the assumption is that
> the producer has overflowed.
> 
> A more defensive check could be to ensure that the delta is within
> the allowed range, but such defensive checks are neither present in
> the kernel side code nor in libbpf. The overflow that this patch
> handles can occur while the producer and consumer follow a correct
> protocol.
> 
> A selftest was written to demonstrate the bug, and indeed this patch
> allows the test to continue to make progress past the overflow.
> However, the author was unable to create a testing environment on a
> 32-bit machine, and the test requires substantial memory and over 4
> hours to hit the overflow point on a 64-bit machine. Thus, the test
> is not included in this patch because of the impracticality of running
> it.
> 
> Additionally, this patch adds commentary around a separate point to note
> that the modular arithmetic is valid in the face of overflows, as that
> fact may not be obvious to future readers.
> 
> v1->v2:
>  - Fixed comment grammar.
>  - Properly formatted subject line.
> 
> Reference:
> [v1]: https://lore.kernel.org/bpf/20230724132404.1280848-1-awerner32@gmail.com/T/#u
> 
> Signed-off-by: Andrew Werner <awerner32@gmail.com>
> ---
>  tools/lib/bpf/ringbuf.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> index 02199364db13..2055f3099843 100644
> --- a/tools/lib/bpf/ringbuf.c
> +++ b/tools/lib/bpf/ringbuf.c
> @@ -237,7 +237,11 @@ static int64_t ringbuf_process_ring(struct ring *r)
>  	do {
>  		got_new_data = false;
>  		prod_pos = smp_load_acquire(r->producer_pos);
> -		while (cons_pos < prod_pos) {
> +
> +		/* Avoid signed comparisons between the positions; the producer
> +		 * position can overflow before the consumer position.
> +		 */
> +		while (cons_pos != prod_pos) {
>  			len_ptr = r->data + (cons_pos & r->mask);
>  			len = smp_load_acquire(len_ptr);
>  
> @@ -498,6 +502,11 @@ void *user_ring_buffer__reserve(struct user_ring_buffer *rb, __u32 size)
>  	prod_pos = smp_load_acquire(rb->producer_pos);
>  
>  	max_size = rb->mask + 1;
> +
> +	/* Note that this formulation is valid in the face of overflow of
> +	 * prod_pos so long as the delta between prod_pos and cons_pos is
> +	 * no greater than max_size.
> +	 */
>  	avail_size = max_size - (prod_pos - cons_pos);

hi,
the above hunk handles the case for 'prod_pos < cons_pos',

but it looks like we assume 'cons_pos < prod_pos' in above calculation,
should we check on that?

jirka


>  	/* Round up total size to a multiple of 8. */
>  	total_size = (size + BPF_RINGBUF_HDR_SZ + 7) / 8 * 8;
> -- 
> 2.39.2
> 
> 

