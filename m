Return-Path: <bpf+bounces-28136-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2208B60CE
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 19:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B53EB2327B
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 17:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA011292E1;
	Mon, 29 Apr 2024 17:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYwR+8Vn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CB971727
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 17:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714413308; cv=none; b=VmP9XslzLa0a7voG08YP1D8tpwpfYaeULb8M8wzahEa+PeLBPoZYqFKZiHGFplPxiy8gm87gMyOwpaCMExD/oMr7he4OsW98dO3XLoQ4CVg6882CDhruwJRUYCNB2Cmso5tOP6mnFLi2Wyk2wO7uWNMkvdasL3dG7mlmyn2vpCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714413308; c=relaxed/simple;
	bh=3JZw4a8U3pM+dB/cNPKggjrurZ5QSCBJGpszEUE9/qc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lefY6wa7DX6HOIvxNGNnh+R2LYXQb/OzBLP16bcLKdKWMrXd7zsUJP5pwCQuLUcez6FAexVU2wuc4/Vb3q2oa4Yjx2D84Sa05fNC1wNGB+8mdWF4ip0cNxMkrpUJe0AwK4pIhPNK/vWUZK8rbg0VTTwbE/eKEX+67XYftRj11fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYwR+8Vn; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-56e1baf0380so5977874a12.3
        for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 10:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714413305; x=1715018105; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tzprSUNOWKTdvd7eZWGG3cMP/HuVDTDmWw68Q40dyMY=;
        b=LYwR+8Vn0J8i6w2A4WTATiAeNILDuGbCkZqchdxfgS0SWaE/duobOS5DrXUKLfBAz4
         anxRjqu7kH9V62wTjWrdTm+zujnDA2I4hHvArNJ4aqoNuQfL3GV1uOhlURN8VvD2MbX7
         ttl3dh6bI/gQEJZl6gr/lmOcquLlsesmSI0up16BpGukl6fyTHJmZUoirfVthk11ehJV
         U21u+MIdhndKeQbcqGdLazVTacwwEhedMD/w82lfthi7B2nFjdgEAPKZO7cNR+SN1hYO
         Kecmv9IMuYfSaSNK2j0z4NEX1AX3nEdAW+GHtyVQsKgsmqynBaQKi8Kp/a0PQSiz38xW
         CgCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714413305; x=1715018105;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tzprSUNOWKTdvd7eZWGG3cMP/HuVDTDmWw68Q40dyMY=;
        b=lrN5U92EsaxSN/1DU4NwFaYtVLUwH8U4QYdjLkGP/Kr5Y//3WDmFrV0/dTJDewWqaO
         naPs5CE8ntLJAcfML++LbivYOyYnf1ReBvqPn6VKCPtKoQhWfT1zrcX/jlecAfaC4zTC
         tdfv60QXO2cxEhIqoe/7AXH6PocYQMHByeryNX6VpTEyH3ehR5lmAyWzvIPBEH8MzhYV
         O8nsQjkglcPqaSpQwH3nRL/4IL4Cydn0LGmTH+sFcXNOnqfxyHsq2XnVWVYLrBL3lWi7
         w7UI2cOHEg2jlw53LwZRaeyDXAiabYWhNxH4gC42FBG6PbCVRDY1qTJw/HMhIL5tQM4l
         R/Mg==
X-Gm-Message-State: AOJu0YxqjqD8X7xYk9g3k6rqY117Ha0p91Q41HjJ6jsP9I3LrZzHctJG
	UFIpNXcRrOYs1dtp4trZlf5VJUBa+TKvxd+7VE3NqTuWNrZ4BC9cHXwDmYt+A3OVCLrzODwY9s9
	jM2OplTcZYe+eUDKDKxdg7nFSxlRI3Tpk
X-Google-Smtp-Source: AGHT+IHXr6e/Qdn0obtbvdpFV5/oY8D/e5lGj0ERr3sEnWuEzfd5K9Mg7scPAZUI5f9b9HD3prDHv8BH+RcRAHn6+68=
X-Received: by 2002:a17:906:1c49:b0:a58:8d83:b527 with SMTP id
 l9-20020a1709061c4900b00a588d83b527mr248541ejg.12.1714413304972; Mon, 29 Apr
 2024 10:55:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429165658.1305969-1-sidchintamaneni@gmail.com> <20240429165658.1305969-2-sidchintamaneni@gmail.com>
In-Reply-To: <20240429165658.1305969-2-sidchintamaneni@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 29 Apr 2024 19:54:28 +0200
Message-ID: <CAP01T75xFSzFw1FjRmmNY42LtJh9abndNY=4TE+5=DcA3Lh6qw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] Added selftests to check deadlocks in queue
 and stack map
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, daniel@iogearbox.net, 
	olsajiri@gmail.com, andrii@kernel.org, yonghong.song@linux.dev, rjsu26@vt.edu, 
	sairoop@vt.edu, Siddharth Chintamaneni <sidchintamaneni@vt.edu>
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Apr 2024 at 18:57, Siddharth Chintamaneni
<sidchintamaneni@gmail.com> wrote:
>
> From: Siddharth Chintamaneni <sidchintamaneni@vt.edu>
>
>  Added selftests to check for nested deadlocks in queue
>  and stack maps.
>
> Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@vt.edu>
> ---

Forgot to remind in the previous reply, but:
For the patch subject, use 'bpf:' prefix for kernel patches, and
'selftests/bpf:' for selftests, see the commit logs in bpf-next for
examples.

>  .../prog_tests/test_queue_stack_nested_map.c  | 48 ++++++++++++++
>  .../bpf/progs/test_queue_stack_nested_map.c   | 62 +++++++++++++++++++
>  2 files changed, 110 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_queue_stack_nested_map.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_queue_stack_nested_map.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_queue_stack_nested_map.c b/tools/testing/selftests/bpf/prog_tests/test_queue_stack_nested_map.c
> new file mode 100644
> index 000000000000..731e958419eb
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/test_queue_stack_nested_map.c
> @@ -0,0 +1,48 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +#include <network_helpers.h>
> +
> +#include "test_queue_stack_nested_map.skel.h"
> +
> +
> +static void test_map_queue_stack_nesting_success(bool is_map_queue)
> +{
> +       struct test_queue_stack_nested_map *skel;
> +       int err;
> +       int prog_fd;
> +
> +       LIBBPF_OPTS(bpf_test_run_opts, ropts);
> +
> +       skel = test_queue_stack_nested_map__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "test_queue_stack_nested_map__open_and_load"))
> +               goto out;
> +
> +       err = test_queue_stack_nested_map__attach(skel);
> +       if (!ASSERT_OK(err, "test_queue_stack_nested_map__attach"))
> +               goto out;
> +
> +       if (is_map_queue) {
> +               prog_fd = bpf_program__fd(skel->progs.test_queue_nesting);
> +               err = bpf_prog_test_run_opts(prog_fd, &ropts);
> +               ASSERT_OK(err, "test_nested_queue_map_run");

Maybe you can also check the ropts.optval to ensure we get -EBUSY?
I.e. return the value of map push/pop from the program and then check
it here?
It can be set in a global variable from the program triggering the
deadlock, and then you could return the value back as the return value
of the program.
If fentry has restrictions on the return code, you could try other
program types which work in test_run_opts (like SEC("tc")), there are
many examples in selftests using such programs.

> [...]
>
>

