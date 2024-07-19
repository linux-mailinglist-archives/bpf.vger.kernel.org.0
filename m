Return-Path: <bpf+bounces-35104-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7DE937BC2
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 19:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 614501C21811
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 17:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889B9146A99;
	Fri, 19 Jul 2024 17:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOtbl7u8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E2C1B86D5
	for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 17:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721410909; cv=none; b=T/0yPG95OxZUAqPc1sD5VL4LoSsSX8oE8W52zNjjccc2j22waJtvjaBgM4MnnDboAtdFHAsGYSQykntp3KcJaMUTwEpthd7en/felBvkwuubPDd+mZCbdbnxFGTmkfkOTzhC0RVC4xnQJjkTgRfVEyYfS9dfFPWR4kLK/P/ZqGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721410909; c=relaxed/simple;
	bh=8cTEvIvzHG8l1PZrnSvVQ8cLk/xCahltQVMwJoY1tp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o0K22bazHFaOyfMx2ohO0TAolAdoXr5PyQAJvBImmrkTP29QdfWQNzrRhTO8dWNtoZusA1p5wAgJF5V0Ui7OEUvUaAJEcfmvj4mAxfIOOyAQgYSDIwgtGckvB6I1HUZ9eVp+cdUzNO6dUCMtPCBxXlyv59uTTngxa/sxV6Yl+A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YOtbl7u8; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70b07bdbfbcso874947b3a.0
        for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 10:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721410907; x=1722015707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cVB4rqB8ZRYeZ5MEObGR7G6LOcaBuFJfmh+Mhe1ZwGQ=;
        b=YOtbl7u81IdsjAojXDS45nwMaWYKDI94PuHjQqOUB9xL06jWrcOw1ORzQb8up+5EQb
         oz8sUaiwvqNLVrDFE+n7DH/n1E19y6Rp+A8U+KkhtKEXK/eBmv33qU5WwBhLM2idohuS
         eL3IwkLPqHThQUp91zu/1TWE1/4PrlslsIEpaks7n+IRAo/jZPB24/QrgTOJAl9wkJ7p
         7QCA5hteFP4/5AWBlqnFxrzTRzMmqXQCncxItjBKN7PL8ldgGNfgt6q7NC9Qm3WYFcNr
         L2kTxOiLB2wdETE+R/GvUXg/HaHsS3eF8/kAsSkvT6wYMuvw9Hd21DURYffQIQA/PjE1
         I9Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721410907; x=1722015707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cVB4rqB8ZRYeZ5MEObGR7G6LOcaBuFJfmh+Mhe1ZwGQ=;
        b=L7n2qL9QBBW3s8kef2TJTZmwwZ68BECQJVxgZp9DF+cZtD57Sqfq/7P0Pbspmeqc+l
         vWOp+reJQsuSnWdit5W10mwtjlDqj8LpuLfBMN/OFK4Xumtx6SI8ZLm5FxHxlUlfyG5y
         7+5khA79umzeeCoz2fe4mqv36+UDJe/FpjQ74Cg5w0lQzrzCLJacVBltjxWfZA6DPERs
         tNeWm0Hy/iRxFVlbZKOVyvi8lFWpTQdrgcIOssERJrIfvt4ds3zoxXd5hqljbYFYFcrl
         sGb1VxrA7nPvk7tUmMh8cGF1v0LyGMQIZ9vfub0nbMc/aZkziiEwMAk8NGfnRDTxbz+R
         zaBA==
X-Forwarded-Encrypted: i=1; AJvYcCVGuGshrDZMWRqAzEJRaLgArlpZZFoDHqtvwuxbwKAXN4M7S1n1I0TRdtvy18SfbGovrAvGgrgV/l7SBDqcxkXQDJPa
X-Gm-Message-State: AOJu0YyMlM61yj3XHxPI37OetRjaJINiKpJPIOiGbHsEQ3Cr1KXQdmDO
	Vt8lPZyPvAZFNkAVlYqpAZGXFFw8fFjxMQ/M6fIc7hFDj4H2zPqHF52xR9IkEqzsspYXU9CDgqU
	IjJ1yXOi3E+7SlJKq01biiCU3xf4=
X-Google-Smtp-Source: AGHT+IFNQQXiYAzszQpYnnJ/Bi4I0LWVHL3LZznwLVIPuRS9MF2muY1QLUv8kD/4HPGOTbVBDSz0cDCxkaLHlTFKHEk=
X-Received: by 2002:a05:6a20:12d5:b0:1c0:e619:bdb2 with SMTP id
 adf61e73a8af0-1c423b0bcedmr633742637.14.1721410906935; Fri, 19 Jul 2024
 10:41:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718132750.2914808-1-jolsa@kernel.org> <20240718132750.2914808-2-jolsa@kernel.org>
In-Reply-To: <20240718132750.2914808-2-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 19 Jul 2024 10:41:33 -0700
Message-ID: <CAEf4BzbBfD3cDzoTbuv9B8Ah-ZBsucePsWCJuevcYgqj3wT=aQ@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 1/2] selftests/bpf: Add uprobe fail tests for
 uprobe multi
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 6:28=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Addig tests for checking on recovery after failing to

typo: Adding

> attach uprobe.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../bpf/prog_tests/uprobe_multi_test.c        | 109 ++++++++++++++++++
>  1 file changed, 109 insertions(+)
>

LGTM, thanks for adding these failing test cases! CI is failing, so
please check what's wrong

pw-bot: cr

> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b=
/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> index bf6ca8e3eb13..da8873f24a53 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> @@ -516,6 +516,113 @@ static void test_attach_api_fails(void)
>         uprobe_multi__destroy(skel);
>  }
>

[...]

