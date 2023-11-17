Return-Path: <bpf+bounces-15245-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9743C7EF689
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 17:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42BAB1F2704F
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 16:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE483EA9A;
	Fri, 17 Nov 2023 16:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQwtPj7n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC21194
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 08:47:09 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9e4675c7a5fso309193966b.0
        for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 08:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700239628; x=1700844428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EcnQ2ixn2lgPeVq7jDq3yXx/72wD/YdNVcCLGtfVHwQ=;
        b=gQwtPj7nJp6dVBu3k4nPsbBnCPJVt95wtD308LSjY46zuq6YXelIAi4fOS5/Od0+ve
         UVOhfUBJVHbAYGwyysYxTYiIF7RHBXjUkD//dHOSEO+I2hTNsf3FQdzfS4Umt/2J0GlK
         P+MgqjBq0ffOCRlkjIppsWdrQjhTvwhEknvTFwklmXM/sx5PmWfXDrNwssezZn8tVGrP
         /CFNtWX2wKaAxZlIMudDN4nSfnXahAWW7PmPZ/iQ5JJxVbyNNRY3VEbHLc+MTXUPlf0g
         2yWwA3aALAd7kaHchuZR7LNazJ6elhCfQ4C7FOS8Ik7nQsaBeHuIAXPWMOEAfipDGaW0
         jITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700239628; x=1700844428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EcnQ2ixn2lgPeVq7jDq3yXx/72wD/YdNVcCLGtfVHwQ=;
        b=VSn4OmTiikNm3YP+FVS0ui9drsHqLy1wXR77YfTnRRkae3P/j6rPG56fDsr6Rh6UoE
         igOLFNXBiEoL7VG50G2K4AmjU83262r4kclB0qWUB7AUIlQwHtXkEnGqn4Su8c9VlHND
         NseBViSueuCaW7tstCQ8NHDrYGDJ5lKRepTcvMJXOf9/sFyIRzcWthzw9PKE051qOm8r
         Us+Cf30oHOeDNJMktve9Ennt/ezsrioC3vFDQ+xY3wSbKkOGEo8mrzb98HdL1gJnsP3O
         CegkNdYTAQCMhHu7/zTlAaHtmEG1SRECAXQ2xycbs6gwG3BZQ47iRqeu/huUP2nVdouP
         R+ZQ==
X-Gm-Message-State: AOJu0YwZ99XjMovHhHoJld40tfw2f03h1gichSGX9nFvjnjhx+MN/INk
	QdlVSojzZIOUmHYCDXeM5xEZt02BgPr/S7SV4Rg=
X-Google-Smtp-Source: AGHT+IHxrQRa2exj4O3j+VjVGw9wZNnTEDlcDTO/5CaCRFbAYhU0Iit2oqq3zoO1RWHbSplwawkWYpOOen1fS2uX4v8=
X-Received: by 2002:a17:906:ecea:b0:9bf:6200:fe33 with SMTP id
 qt10-20020a170906ecea00b009bf6200fe33mr14127371ejb.16.1700239627812; Fri, 17
 Nov 2023 08:47:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116021803.9982-1-eddyz87@gmail.com> <20231116021803.9982-8-eddyz87@gmail.com>
In-Reply-To: <20231116021803.9982-8-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 17 Nov 2023 11:46:56 -0500
Message-ID: <CAEf4BzbsCbXPf3ViBBtt0ayYh_PoAYy1tiECGY0x7ieLi=7LEA@mail.gmail.com>
Subject: Re: [PATCH bpf 07/12] selftests/bpf: tests for iterating callbacks
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, memxor@gmail.com, awerner32@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 9:18=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> A set of test cases to check behavior of callback handling logic,
> check if verifier catches the following situations:
> - program not safe on second callback iteration;
> - program not safe on zero callback iterations;
> - infinite loop inside a callback.
>
> Verify that callback logic works for bpf_loop, bpf_for_each_map_elem,
> bpf_user_ringbuf_drain, bpf_find_vma.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/verifier.c       |   2 +
>  .../bpf/progs/verifier_iterating_callbacks.c  | 147 ++++++++++++++++++
>  2 files changed, 149 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/verifier_iterating_=
callbacks.c
>

Great!

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]

