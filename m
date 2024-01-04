Return-Path: <bpf+bounces-19072-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3345B824A66
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 22:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7216B245EA
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 21:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD092C847;
	Thu,  4 Jan 2024 21:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ok6K8gvc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8347F2C848
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 21:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-427ca22a680so5589251cf.3
        for <bpf@vger.kernel.org>; Thu, 04 Jan 2024 13:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704404242; x=1705009042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TswUjOEAhg3N75qmaiYjejtfwKdXhO5F6QGd/S4RM8M=;
        b=Ok6K8gvcELhRDhffY4a7Grals/CAIC3nFzkppm+6pLgxa4iMK5ov1kobIb8INgKM1Z
         eBI2299XUxr4IJvodPts44xk1nHgxGUvUmKKSUiRsxwHnDub78aUSLFdj4weJooBUDMN
         vR8KumsSf1kdUQCQ16vl0Fj2KdLe+VUqGlF3+WzIHSsY79KmiGVLAZ0onsW1jRwS6Wfp
         NZ8yAM7KLCuEZcdcFrve/rwwCnVigHCGhRPaWQTH84mJ13MKwZ5ZAtj+Pf/0kFsKxFyC
         RGtME8yuJalZDSfJloj5w1ClDQ/PN3aBoE4traVJnrgHfX3LGKLh+Oz105UaJiQsNbkA
         NiqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704404242; x=1705009042;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TswUjOEAhg3N75qmaiYjejtfwKdXhO5F6QGd/S4RM8M=;
        b=WDt5Zuo9qpWTay+zvU8mjFnxaPMAakTmd/sgwWcQEpvJZPUeKDDV/IQ2LB557Cj1P5
         GDsqM82BbvStFDWBzdt2dLVaCUWGPrTuX5Hw0gBw62v8hBEH8ZJL/VgfIEUiC9FiZdDO
         FJwtyh+shuC7ZcCBwoxPGL8FS+RpOVD6pG76axgrS7MSVafIXSFV+kWvtb1tA0axglGV
         urfOcydQGTvRtxBLZRYhLo/fYQoJgHhCv7ntNN1LT1nimM1x3NY21QpI0XQ0pqzD6Djj
         EuQYQHDw1EegQ3lKbXOousVoZauSqqBp2vHM+OiMd6AmG6CII9MvXDomdBW+AP7maxAH
         FOUQ==
X-Gm-Message-State: AOJu0YwHSaST6HsU2etZFaif8WjGYMtmT52kcWcQ2+TrByG3eQj+qPYs
	/o+7u8ILwV3tyIwaorOQioCIDfvaG/37
X-Google-Smtp-Source: AGHT+IEqQCvG0d1qLwZSXx6BUFsh2kTk1sltZq/ydyyKWzPyHDyyuuYt5TRZ5ga6etj9++TPegC8SA==
X-Received: by 2002:ac8:5bc2:0:b0:427:ea89:dd78 with SMTP id b2-20020ac85bc2000000b00427ea89dd78mr1540779qtb.73.1704404242327;
        Thu, 04 Jan 2024 13:37:22 -0800 (PST)
Received: from [192.168.1.31] (d-65-175-157-166.nh.cpe.atlanticbb.net. [65.175.157.166])
        by smtp.gmail.com with ESMTPSA id w26-20020a05622a191a00b0042839736d9fsm150064qtc.19.2024.01.04.13.37.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 13:37:22 -0800 (PST)
Message-ID: <0d9f51e9-7e07-48dd-bf18-ea28ab6b1e83@google.com>
Date: Thu, 4 Jan 2024 16:37:21 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: add inline assembly helpers
 to access array elements
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, mattbobrowski@google.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240103153307.553838-1-brho@google.com>
 <20240103153307.553838-3-brho@google.com>
 <CAEf4BzbKT3LbHQSFwpAfoJuhyGy2NpHk7A6ivkFiutN_jnKHYg@mail.gmail.com>
From: Barret Rhoden <brho@google.com>
In-Reply-To: <CAEf4BzbKT3LbHQSFwpAfoJuhyGy2NpHk7A6ivkFiutN_jnKHYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/3/24 14:51, Andrii Nakryiko wrote:
>> +
>> +/*
>> + * Helper to load and run a program.
>> + * Call must define skel, map_elems, and bss_elems.
>> + * Destroy the skel when you're done.
>> + */
>> +#define load_and_run(PROG) ({
> does this have to be a macro? Can you write it as a function?

can do.  (if we keep these patches).

i used a macro for the ## PROG below, but i can do something with ints 
and switches to turn on the autoload for a single prog.  or just 
copy-paste the boilerplate.

>> +       int err;                                                        \
>> +       skel = array_elem_test__open();                                 \
>> +       if (!ASSERT_OK_PTR(skel, "array_elem_test open"))               \
>> +               return;                                                 \
>> +       bpf_program__set_autoload(skel->progs.x_ ## PROG, true);        \

thanks,

barret



