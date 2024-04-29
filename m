Return-Path: <bpf+bounces-28139-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 548508B60DF
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 20:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0907E2819C0
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 18:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B6F127E24;
	Mon, 29 Apr 2024 18:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9ByUOg/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDB48614C
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 18:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714414050; cv=none; b=KXW0pVxp/dxIeirJ9ghVSxqTMEPOpQEDyxcsPrXAzKSmGu8KhM/hzeWJmGb/091uQQvpjd1AKsPWc6spUaVV3vuwEiEdX743tMQ4fRBcN+U1ZamtyQ1eMIDQx0/f5/WkQ4XsY8yQ81lgribno2tNzgn4UkkFu3afLZzb7tA9ZIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714414050; c=relaxed/simple;
	bh=GhrT+EmUwZ+izili30YpiHfd93a5lJ7mOC/TDq2aFvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XEwilhuIF7sUh+zoQlMmlReCJjB5LhfW0V19xS+iU/HEvFtH2icoN5S/YibUQ+QzBDYSGdROwoq//JMiEGyyxoK4wKQseoDm+e/tnFJGD/p+3h+bSo+jqwknLJcHikS2n/JfQPrO33Lid9pjp2nA2L3p61jrULFbosXqApaMpEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D9ByUOg/; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-61be4b986aaso5865167b3.3
        for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 11:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714414048; x=1715018848; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HNs6JOErxbYp4BQ1eukryQa+GtJ9vcKKvZg4SDyxGKU=;
        b=D9ByUOg/V7VUtVNUktO51DpRBV6feducB6/20lQMYf/oQQNBolWzOAXnqsr4CDcug3
         i1Z/GkAMT4iUSw1fXQRAaZg0bHM8wwzU5DexpgSiiWBcNxQKsXQysVapiAF3a4KAdprf
         xwhqvQ9x6i/MyS1N/Tt67Qyvnvi8LN6lQVx2btRbI+eTztTzlLdp1ydcUSJa3s4zl592
         TuyKtl3nWG7C83/7hYtvNMYU3MZHya/ljTKvrChNx6kH0ycQboc2eEGa+OMlyhcS3wZt
         eputa4JzYpI1qLbMQzvHJjhJBun7kPye+p0sMMSgdkTtOF7V77LXlTpubG2HPElXNXg5
         22QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714414048; x=1715018848;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HNs6JOErxbYp4BQ1eukryQa+GtJ9vcKKvZg4SDyxGKU=;
        b=RqqzxbbzstE8KxXisNmBnctZRYiRBr6zZoZ09xS7ockmDul0txX1R87AvAT30JIYUl
         aVZDWDgTGP3no93hKlVrqZPhvzAWHfBS1lbzGV6OM71TIHWlx0fcXLVwXx7gdZF2Tr1d
         opUQSkIv8QFB24sfHqnOqLyE0MpkdhJVjIaVh/5hwMWyQEOG5EOL0SUYem1+GNQ+UcTT
         qLQjE7O3xEZfA9RyMnLfFLz6fBKFofsAHKRznsoVw6EscZfk1dD7n7rCCpPwKyU1w4qB
         B1VWmyg3xxJbTYs74YbGmLw9l0vFpKMPMBpaIR+ClDopDZfThiFU4hMfflTCpS8Vvp6G
         iiIA==
X-Gm-Message-State: AOJu0YzvfRRecIwHMqA1cZHyPjRQPNY7uVqRVGelSmdf0WOwOJRURf+9
	AsJ6MSn6EYeg05fBGPt8GaWw9uYGMSlgVU4RAzKdVvo72XbLXY75ksTIztKwIoqgzeg0CB38pPD
	A1OvDGsCtHxsR5tz0XvlFu5uVDr8=
X-Google-Smtp-Source: AGHT+IH2eMwvAgyt+HrWavjhoYfFX95HYDZ5f9NGvyTpT0IPOA8rPEuWU72HOSxy3Tv6Fc00GFeT/OHvsJZlI+ag2wc=
X-Received: by 2002:a05:690c:6413:b0:61a:e50c:1940 with SMTP id
 hr19-20020a05690c641300b0061ae50c1940mr12060257ywb.7.1714414048315; Mon, 29
 Apr 2024 11:07:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429165658.1305969-1-sidchintamaneni@gmail.com>
 <20240429165658.1305969-2-sidchintamaneni@gmail.com> <CAP01T75xFSzFw1FjRmmNY42LtJh9abndNY=4TE+5=DcA3Lh6qw@mail.gmail.com>
In-Reply-To: <CAP01T75xFSzFw1FjRmmNY42LtJh9abndNY=4TE+5=DcA3Lh6qw@mail.gmail.com>
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Date: Mon, 29 Apr 2024 14:07:17 -0400
Message-ID: <CAE5sdEiNH6=GfMag8qCQbun3XmvLunVLmK2ab-1XjvjP1dUFiA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] Added selftests to check deadlocks in queue
 and stack map
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, daniel@iogearbox.net, 
	olsajiri@gmail.com, andrii@kernel.org, yonghong.song@linux.dev, rjsu26@vt.edu, 
	sairoop@vt.edu, Siddharth Chintamaneni <sidchintamaneni@vt.edu>
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Apr 2024 at 13:55, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> On Mon, 29 Apr 2024 at 18:57, Siddharth Chintamaneni
> <sidchintamaneni@gmail.com> wrote:
> >
> > From: Siddharth Chintamaneni <sidchintamaneni@vt.edu>
> >
> >  Added selftests to check for nested deadlocks in queue
> >  and stack maps.
> >
> > Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@vt.edu>
> > ---
>
> Forgot to remind in the previous reply, but:
> For the patch subject, use 'bpf:' prefix for kernel patches, and
> 'selftests/bpf:' for selftests, see the commit logs in bpf-next for
> examples.

Thanks, I will do that in the revision.

>
> >  .../prog_tests/test_queue_stack_nested_map.c  | 48 ++++++++++++++
> >  .../bpf/progs/test_queue_stack_nested_map.c   | 62 +++++++++++++++++++
> >  2 files changed, 110 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_queue_stack_nested_map.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/test_queue_stack_nested_map.c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/test_queue_stack_nested_map.c b/tools/testing/selftests/bpf/prog_tests/test_queue_stack_nested_map.c
> > new file mode 100644
> > index 000000000000..731e958419eb
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/test_queue_stack_nested_map.c
> > @@ -0,0 +1,48 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <test_progs.h>
> > +#include <network_helpers.h>
> > +
> > +#include "test_queue_stack_nested_map.skel.h"
> > +
> > +
> > +static void test_map_queue_stack_nesting_success(bool is_map_queue)
> > +{
> > +       struct test_queue_stack_nested_map *skel;
> > +       int err;
> > +       int prog_fd;
> > +
> > +       LIBBPF_OPTS(bpf_test_run_opts, ropts);
> > +
> > +       skel = test_queue_stack_nested_map__open_and_load();
> > +       if (!ASSERT_OK_PTR(skel, "test_queue_stack_nested_map__open_and_load"))
> > +               goto out;
> > +
> > +       err = test_queue_stack_nested_map__attach(skel);
> > +       if (!ASSERT_OK(err, "test_queue_stack_nested_map__attach"))
> > +               goto out;
> > +
> > +       if (is_map_queue) {
> > +               prog_fd = bpf_program__fd(skel->progs.test_queue_nesting);
> > +               err = bpf_prog_test_run_opts(prog_fd, &ropts);
> > +               ASSERT_OK(err, "test_nested_queue_map_run");
>
> Maybe you can also check the ropts.optval to ensure we get -EBUSY?
> I.e. return the value of map push/pop from the program and then check
> it here?

make sense.I will do that.

> It can be set in a global variable from the program triggering the
> deadlock, and then you could return the value back as the return value
> of the program.
> If fentry has restrictions on the return code, you could try other
> program types which work in test_run_opts (like SEC("tc")), there are
> many examples in selftests using such programs.
>
> > [...]
> >
> >

