Return-Path: <bpf+bounces-56596-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98928A9ADF7
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 14:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31BAF3B8063
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 12:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B3D27B511;
	Thu, 24 Apr 2025 12:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OrhpR7r3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F28027A92A;
	Thu, 24 Apr 2025 12:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745499091; cv=none; b=bhRRiXuq40ADOk4WsWQ5uxXLZy3oZsdsP5vQf7mQQmEiW1OP2QhYF2vg6UkGpkj+2ZbnxRain7i3SETXeyg0R71VmpSg0W5juZvPY1C+1XyxvJfdfEFjbXbwgJ+vWDlfFSV/4GhsnN1Wv3RZ6YCUFf7HU+qkP7X15HZs+PklKo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745499091; c=relaxed/simple;
	bh=1gjsb9NkSqMfNHlNKdtHGqO2zMQ8vXUc1iNCKWvHVOM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VxSyUgGqFPVo6m67DjecRA0ZcSqAoI2lO6ZUc7UFD0xH3SWd2yJIplXR+YKQDK+UnaZ8OcgCwekwN//Ka9hoB+0618K/LE4czpi3Iyh2SCqtusjJjeuras1KG8XPAsKhuLSjpEd9XAkm15kAQ6HiQP+zqAwS3L/uPT6nzN83Z7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OrhpR7r3; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac6ed4ab410so161922366b.1;
        Thu, 24 Apr 2025 05:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745499088; x=1746103888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g7x4P6/o/1RuBbUUxeX5Et6jW21wH4n+BIhd6MZxDSM=;
        b=OrhpR7r3mf+ueq29iawuPfNxiBAPMzHw/rWfdX2XgXAx2rnPdIO/Cf0trYg0RGaXDU
         GaqIxsJ6WR3rPHNHdwC0Pq/oOyzbsUIFnveV6disEGe2wS7nK7MecvFqzF4vR6woF4DF
         z9lSzUL867AP61LP9B2tBq2SC2OE39glD6vOWyHFT+LxgwWJQNUF4H4Tt+GJEy7PyuyA
         kNnuiTXBcPmBHr/3gcj6tPPs74IH9LB6KqukFwdlnvf5w2+oBFOsqamQ66VryoWdSZlA
         nijPi9kqqTT0RMYoWftK6vSm37Eu0HhjRQdD/tSZ50kiRFzSmXUlSiIwd/y4r8Cb41W4
         UhQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745499088; x=1746103888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g7x4P6/o/1RuBbUUxeX5Et6jW21wH4n+BIhd6MZxDSM=;
        b=AZPiBiirMTNUKsWT5qllklLWTyEEdN66NrzO/wCfKJxb94xgqqk+wNIfqPNx7sjXXV
         XwDDNI0XW7tGY+GTKyEHJTpc+C4sOZ/yzEaLgkOrCWysbcFeTfmm2a2um6Et/PRzC51n
         ryGjFoengpj3s3oakB2F/p2pZrXIqppSt9NkCSzVt/35xrPUVEcTfQVUiAig8/OIQvzL
         IpjIywwxL5BlcK7szxciOfunvSH802utpX+RUIfsMbr1EN/bzXi2urUzzSoGS0a7acyZ
         hBCVrhZ54sHJsR7svCa9rm1SbXE2sQQHHx3l/jKUIlvG+1x3sYcHg3ak1nX4MZ//7j2R
         zBOA==
X-Forwarded-Encrypted: i=1; AJvYcCVK+/ih8bAOWFVIKN9joCKavKfecirV33BTYK+6FQGIzKsMClobpw6NtvhcJTbTdJ/fePw=@vger.kernel.org, AJvYcCVU4MNa0gDsTrLOWM6E9JierglKoZlGSKBAodqyuKMxZVdN9PTDVhI+LY4awuCb9syJpt6dDOt9/IsoaUS7vfIx4OvU@vger.kernel.org, AJvYcCW0OvQ3G0c9DuplJNfRZlliAmJsN01UwtxtuO12navYEb3B94jGKLRTrx/lMBTteMxEY7Ji1duvcVHLqhRL@vger.kernel.org
X-Gm-Message-State: AOJu0YynCq/esDpHZTlbEhwT0+1jb4qv4CCG10/MmW6NghT+A7lirx7n
	UkOxlRjG7Jg90VQNqcUNE1UaM5rxfkNr5zoLHnNtZB2P8rEngWZf
X-Gm-Gg: ASbGnctfdw8/plgUhkmtc9NWqe2ARnk2Vt7mYPOROqcivSdoUGVqIYuMi8hnF7Q5RYy
	NBMQijIVwZvTfLw8GzWlmS84TE/EP30cqIpUk06/xOcdPR8p2tj5U1tBy3XhkjncAAQbhJJi7lp
	/Phg/i4D21/zv8rhGH4/aYvBr7xWFVz8GouSUFg1pzsYpnDI4Tdwnosi+21E59/sTK9pqU/vUTZ
	vXd11Yhh/nxQISokA68Z89AqAFWhqgI7zRBQOgcJhikDHfW7e+xelarxx+lgUcq5Ih9+oIxREgf
	bYk4Kojt5V8Hehx5A83wsD+RR+E=
X-Google-Smtp-Source: AGHT+IGH3Af6vLJPl3/jTKvaQl8vTs+F5eGn8wCShrqSNYAbF39JzgvbjKB6TISi8idom0YHrGMK9w==
X-Received: by 2002:a17:907:6e8c:b0:aca:a687:3af4 with SMTP id a640c23a62f3a-ace573c2f7bmr203373066b.42.1745499087585;
        Thu, 24 Apr 2025 05:51:27 -0700 (PDT)
Received: from krava ([173.38.220.55])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace59bbd6b5sm104701566b.100.2025.04.24.05.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 05:51:27 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 24 Apr 2025 14:51:25 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH perf/core 15/22] selftests/bpf: Add hit/attach/detach
 race optimized uprobe test
Message-ID: <aAozzY6ls7LLXNSc@krava>
References: <20250421214423.393661-1-jolsa@kernel.org>
 <20250421214423.393661-16-jolsa@kernel.org>
 <CAEf4Bzb+LT2nTTjVXi3ATu9AsYSxZJr2XzegA09Cm8izNG=grg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzb+LT2nTTjVXi3ATu9AsYSxZJr2XzegA09Cm8izNG=grg@mail.gmail.com>

On Wed, Apr 23, 2025 at 10:42:43AM -0700, Andrii Nakryiko wrote:

SNIP

> > +
> > +static void test_uprobe_race(void)
> > +{
> > +       int err, i, nr_threads;
> > +       pthread_t *threads;
> > +
> > +       nr_threads = libbpf_num_possible_cpus();
> > +       if (!ASSERT_GE(nr_threads, 0, "libbpf_num_possible_cpus"))
> 
> I hope there are strictly more than zero CPUs... ;)
> 
> > +               return;
> > +
> > +       threads = malloc(sizeof(*threads) * nr_threads);
> > +       if (!ASSERT_OK_PTR(threads, "malloc"))
> > +               return;
> > +
> > +       for (i = 0; i < nr_threads; i++) {
> > +               err = pthread_create(&threads[i], NULL, i % 2 ? worker_trigger : worker_attach,
> > +                                    NULL);
> 
> What happens when three is just one CPU?
> 

right, we need at least 2 threads, how about the change below

thanks,
jirka


---
diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
index d55c3579cebe..c885f097eed4 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -701,8 +701,9 @@ static void test_uprobe_race(void)
 	pthread_t *threads;
 
 	nr_threads = libbpf_num_possible_cpus();
-	if (!ASSERT_GE(nr_threads, 0, "libbpf_num_possible_cpus"))
+	if (!ASSERT_GT(nr_threads, 0, "libbpf_num_possible_cpus"))
 		return;
+	nr_threads = max(2, nr_threads);
 
 	threads = malloc(sizeof(*threads) * nr_threads);
 	if (!ASSERT_OK_PTR(threads, "malloc"))

