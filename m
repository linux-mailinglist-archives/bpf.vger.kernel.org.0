Return-Path: <bpf+bounces-16811-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD0280611D
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 22:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AC8C1C20EF8
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 21:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3FE6FCE4;
	Tue,  5 Dec 2023 21:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1MwyMa9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D7AD47
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 13:57:38 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-54bfa9b3ffaso7936919a12.1
        for <bpf@vger.kernel.org>; Tue, 05 Dec 2023 13:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701813457; x=1702418257; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o8QtwLGiRlArwFyNEfpvSrgux1sAbr6cNe4/iTfvgd4=;
        b=O1MwyMa9M2TrEcIMCrUCrE5GV+7PXeqHOb1P6HnZLgnvJL/UufAGDTpX8fi5Hx925j
         f/tt6kOCiXFaBdFplABRU5tw4+/4yc8hNQzgx1rQJY6Ws1cCq0SY8pavxQh5k3zDjTb+
         dnn0GJmePmlHvm5ZW1eipn97XBAxtgotYdBTxTqAFCZl7IdS+qbU5rMKjQ/cKVKbvi8D
         fni1iImQCPFzyqYCaFUxR7fBZv2uwrp6SrCCU6I1ngIan9PKLITNg2SChClKICzD53Ra
         oLIVeCbdJIk42+n+KKS+7X/xn8hzSq7fD2BJPKppAqo/hzNBJxw7IkAvN8dpdVKkj7Du
         ahoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701813457; x=1702418257;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o8QtwLGiRlArwFyNEfpvSrgux1sAbr6cNe4/iTfvgd4=;
        b=C7B3THpEvwyPw3AI6Tre9AE41aEMoZgh4X7dBjmq8q80QTkZEdr4m4w/w9BUFM0FAm
         L4WFavk83xKGNSdV4uPpSn3cVBf2vQISeUo+0mT9p6Qu8Dk4gcktLk+7t5KhgsX18Co9
         gX+rXa381ys8ZNmvtFRvhfQjEN4+RhJGIoeKnOr0J7r8mo7LS/1mtAXNTpPBSpbsBmFL
         XAO+/7j8FQjVO4qSRNAKfYHPzyvGqTEC/iZZWVBZJX1uX8ttT+Qkkul/BxnYgV7ywvte
         uDTaLFXvhXBZCvbdnoIWF5RF77ORtz1cQJr8T5qX7kj9vmTbn7sMeAOQ48HfUms8rjec
         FCCA==
X-Gm-Message-State: AOJu0YxT1miW/tg9K1ly09SNTKzYkeARLlLR6ErRX8Ey//R4eIgYLOZP
	oHJVa0B6zHkKApVrYzpXP5s=
X-Google-Smtp-Source: AGHT+IHuB2C1yz1V3YlWyEnathGr+XoEDODV9Hg7zv6G4UOc4fPl2aVBo5Zn+MKGVvM3qaJDaqkAMA==
X-Received: by 2002:a50:d60f:0:b0:54c:555e:ef4e with SMTP id x15-20020a50d60f000000b0054c555eef4emr5170edi.1.1701813456554;
        Tue, 05 Dec 2023 13:57:36 -0800 (PST)
Received: from krava ([83.240.62.123])
        by smtp.gmail.com with ESMTPSA id ck16-20020a0564021c1000b0054d360bdfd6sm1094038edb.73.2023.12.05.13.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 13:57:36 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 5 Dec 2023 22:57:33 +0100
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCHv3 bpf 2/2] selftests/bpf: Add test for early update in
 prog_array_map_poke_run
Message-ID: <ZW-czRcdvQL7A1e_@krava>
References: <20231203204851.388654-1-jolsa@kernel.org>
 <20231203204851.388654-3-jolsa@kernel.org>
 <0c2c5931-535c-49ab-86c4-275f64e5767c@linux.dev>
 <ZW7imIQDjdOFdlLn@krava>
 <f18d75bc-1d1c-4391-b006-308568de10bf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f18d75bc-1d1c-4391-b006-308568de10bf@linux.dev>

On Tue, Dec 05, 2023 at 08:00:48AM -0800, Yonghong Song wrote:

SNIP

> > > > +void test_tailcall_poke(void)
> > > > +{
> > > > +	struct tailcall_poke *call, *test;
> > > > +	int err, cnt = 10;
> > > > +	pthread_t thread;
> > > > +
> > > > +	unlink(JMP_TABLE);
> > > > +
> > > > +	call = tailcall_poke__open_and_load();
> > > > +	if (!ASSERT_OK_PTR(call, "tailcall_poke__open"))
> > > > +		return;
> > > > +
> > > > +	err = bpf_map__pin(call->maps.jmp_table, JMP_TABLE);
> > > > +	if (!ASSERT_OK(err, "bpf_map__pin"))
> > > > +		goto out;
> > > Just curious. What is the reason having bpf_map__pin() here
> > > and below? I tried and it looks like removing bpf_map__pin()
> > > and below bpf_map__set_pin_path() will make reproducing
> > > the failure hard/impossible.
> > yes, it's there to share the jmp_table map between the two
> > skeleton instances, so the update thread changes the same
> > jmp_table map that's used in the skeleton we load in the
> > while loop below
> 
> This does make sense.
> 
> > 
> > I'll add some comments to the test
> 
> Thanks for explanation. Some comments are definitely helpful!

np, also looks like I should move this to prog_tests/tailcalls.c,
will send new version with that

thanks,
jirka


> 
> > 
> > jirka
> > 
> > > > +
> > > > +	err = pthread_create(&thread, NULL, update, call);
> > > > +	if (!ASSERT_OK(err, "new toggler"))
> > > > +		goto out;
> > > > +
> > > > +	while (cnt--) {
> > > > +		test = tailcall_poke__open();
> > > > +		if (!ASSERT_OK_PTR(test, "tailcall_poke__open"))
> > > > +			break;
> > > > +
> > > > +		err = bpf_map__set_pin_path(test->maps.jmp_table, JMP_TABLE);
> > > > +		if (!ASSERT_OK(err, "bpf_map__pin")) {
> > > > +			tailcall_poke__destroy(test);
> > > > +			break;
> > > > +		}
> > > > +
> > > > +		bpf_program__set_autoload(test->progs.test, true);
> > > > +		bpf_program__set_autoload(test->progs.call1, false);
> > > > +		bpf_program__set_autoload(test->progs.call2, false);
> > > > +
> > > > +		err = tailcall_poke__load(test);
> > > > +		tailcall_poke__destroy(test);
> > > > +		if (!ASSERT_OK(err, "tailcall_poke__load"))
> > > > +			break;
> > > > +	}
> > > > +
> > > > +	thread_exit = 1;
> > > > +	ASSERT_OK(pthread_join(thread, NULL), "pthread_join");
> > > > +
> > > > +out:
> > > > +	bpf_map__unpin(call->maps.jmp_table, JMP_TABLE);
> > > > +	tailcall_poke__destroy(call);
> > > > +}
> > SNIP

