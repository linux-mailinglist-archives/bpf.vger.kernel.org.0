Return-Path: <bpf+bounces-10963-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2E27B0452
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 14:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id BF7D9282ECA
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 12:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2243527ED6;
	Wed, 27 Sep 2023 12:37:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7547211714
	for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 12:37:42 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C52C0
	for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 05:37:41 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-317c3ac7339so10555278f8f.0
        for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 05:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695818259; x=1696423059; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BcrjXdE3Gw6imqH4TP+OmEr2apZs/PU1rrd8IRXVF1s=;
        b=fdhHSTRe6eyoJWcLyjXHrS4pQTwZu2yIfkT3ec8W1W2UQaMNQ99QQ9dcY4vZw0Gjui
         Vxw/7vyaQQAHrVZFZuQqIabpF3pk+YvUupQGhB/VzjJZn7XivXg4hCvPQcXjfqvVyzj+
         kUCatbWxHLuuFOnJT0RRqTdxMVzpYi6fJNFn5l7Qk5ZElaYPrUvjqXdnaE7U4UGKsWB4
         nsBp8oR3ggkQkR87u6Qa/gSWeDBcQCwbtyglYIViDeXpKOa+0goyD0zaN/cl82waKvLu
         x0Js2hUCWvnq2I1mFgd+9o351B3SWOXcR/PO1KPXToz2a327qNLvHjUUsSngRmDP+0Xq
         yvow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695818259; x=1696423059;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BcrjXdE3Gw6imqH4TP+OmEr2apZs/PU1rrd8IRXVF1s=;
        b=JhaGS2IMSn931VbTq/YTpZC9gGyO1tMHEiv+azD8b7AuiaGiH7cgPYjUJNnNi/X5+S
         ATDxNWtd0lEbeIWUc7Umn++P8XH0GNcNG2zX2YV3QRc01qW/rcsua3Ml6AUZMODPy3/W
         ejzCThXSTjTKBvGuqnovwrcJLr/7VQ4FVtS5kJuz8Pxr9BAst0SuvXeLl0em5BnCC4xN
         psEcF2ffZkhTTxd/hKvJa+QmhqCtmByH7Wr9GQkjxlSjRKj0xusE0VvnEn0L2FlX+I34
         dROsyyGXwhn9XZg1z6v6CJcfYArymnUeBMs7NH+FNN0vLj9dv5supBaHZ45g41Pq3UpX
         3/Bw==
X-Gm-Message-State: AOJu0YzOXfKsP7ZRHrhOOxVpO6VNW+GnoqrRGsqWkbelnqENbQ0Ypi8Z
	m7y4IQHmAcvpug1b1aVWKqe5rD46t2c8zEQU11o=
X-Google-Smtp-Source: AGHT+IG9CgcKOaVan6KREX3sSbLD3la0Vk0aAjVAGgjU8IAL1gnOvgHH2XOIJZqOephQpfe5a6D5JA==
X-Received: by 2002:a5d:58c4:0:b0:317:dada:2417 with SMTP id o4-20020a5d58c4000000b00317dada2417mr1843140wrf.31.1695818259540;
        Wed, 27 Sep 2023 05:37:39 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o11-20020a056000010b00b0031c52e81490sm17126061wrx.72.2023.09.27.05.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 05:37:39 -0700 (PDT)
Date: Wed, 27 Sep 2023 14:02:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: memxor@gmail.com
Cc: bpf@vger.kernel.org
Subject: [bug report] bpf: Implement BPF exceptions
Message-ID: <240f64bd-0023-4e94-842c-f946e4931de1@moroto.mountain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello Kumar Kartikeya Dwivedi,

The patch f18b03fabaa9: "bpf: Implement BPF exceptions" from Sep 13,
2023 (linux-next), leads to the following Smatch static checker
warning:

	kernel/bpf/helpers.c:2492 bpf_throw()
	error: we previously assumed 'ctx.aux' could be null (see line 2483)

kernel/bpf/helpers.c
    2482         WARN_ON_ONCE(!ctx.aux);

Warns if NULL

    2483         if (ctx.aux)
    2484                 WARN_ON_ONCE(!ctx.aux->exception_boundary);

"ctx.aux" isn't going to be NULL, right?  Why not just crash here
instead of

    2485         WARN_ON_ONCE(!ctx.bp);
    2486         WARN_ON_ONCE(!ctx.cnt);
    2487         /* Prevent KASAN false positives for CONFIG_KASAN_STACK by unpoisoning
    2488          * deeper stack depths than ctx.sp as we do not return from bpf_throw,
    2489          * which skips compiler generated instrumentation to do the same.
    2490          */
    2491         kasan_unpoison_task_stack_below((void *)(long)ctx.sp);
--> 2492         ctx.aux->bpf_exception_cb(cookie, ctx.sp, ctx.bp);
                 ^^^^^^^
waiting until this line to crash?

    2493         WARN(1, "A call to BPF exception callback should never return\n");
    2494 }

regards,
dan carpenter

