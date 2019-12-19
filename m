Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7CCE1270DB
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2019 23:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfLSWqR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Dec 2019 17:46:17 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33200 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbfLSWqR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Dec 2019 17:46:17 -0500
Received: by mail-qk1-f196.google.com with SMTP id d71so6423994qkc.0
        for <bpf@vger.kernel.org>; Thu, 19 Dec 2019 14:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Yv9v8BsNbfZxcMg2yrGtH7diMuTPxUeHHJ7rFKsMbY=;
        b=hiahCk2xag95zxNnvf4edRx0Srmpm2acc7+KVdKT7WCwVC65gHHEVEo2do6lMuWxge
         dZvAUp3Tbra3U4Kn9FT3/zp6/f5xc1mGYboGoZUjSdlQVYgaPKmDj2wMw7/77ufMQAio
         +MWW1N9PxyS08QHQ4WYwwXAeHy9TSP0SShrXg0a6KaQWirLo5V2/tgnp22viiRZIx++k
         Ood8t22uB1PBHBb8MUaPBSvdzsPWVFSHq6aCdFj6LHC9/I2yrWeRnpmc5M4C0q3sVp9K
         qc83mVjHqWsbGfqC3UhRSHLajutDJG6MVgoBlYb8upAvHkxLL2k1Bj+fRKm18LaL1cx/
         +ktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Yv9v8BsNbfZxcMg2yrGtH7diMuTPxUeHHJ7rFKsMbY=;
        b=O4eQ5JUBrwfsT8Z/P+TzFDGCEFLipWqHqmBLU0TjLLFngov1CC8pbDxUuDmCF9onBB
         yrsr5EFHJdKhjRQhGjVoS1mzu2uFVRXip8SKKyeYt7oWrdIiTd0miuLHL4lKmgFLXKfm
         tVAXElknOZsgo861xlrexYURUd0n9ZQo4Y8M6pTw3hveJ0yxzs8E8ENC2BXgImUGxFHy
         h5i+JrrFFdFlHVc10pd3bssDUEA6E2z8vCoUcdCBWXnAYBSQItyvphIB1HBTd2qyJRdz
         l1QjsKvu6/ubfgLy0obpGRStUOYtpuQX/YRpy2/OAwhjRP0VweS5cfBgGKXNf7e8f8it
         eQ5w==
X-Gm-Message-State: APjAAAXmSKt7xfd0GYJ1ZuwwTtitB2RfY3EYbd9pfP7/PBHEkLkXf/0R
        fsomp8yV1WKQPK2d8TXxDA0jz1tmbJhXhHguIcE=
X-Google-Smtp-Source: APXvYqy3rlrcvryF9hC6IJS6u3N5kpCz+oc/6XpdQQbJItk1oBX4nuqOMzOsNsPYmz2Hhy1hUMARF4+secAgDAly1uU=
X-Received: by 2002:a37:a685:: with SMTP id p127mr10997595qke.449.1576795576033;
 Thu, 19 Dec 2019 14:46:16 -0800 (PST)
MIME-Version: 1.0
References: <cover.1576741281.git.rdna@fb.com> <0ff19cc64d2dc5cf404349f07131119480e10e32.1576741281.git.rdna@fb.com>
In-Reply-To: <0ff19cc64d2dc5cf404349f07131119480e10e32.1576741281.git.rdna@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 19 Dec 2019 14:46:04 -0800
Message-ID: <CAEf4BzY9PTkBJPhJdX2iHhNZm8u3k5ygn2SQsxW89Z_+XKNiWQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 5/6] selftests/bpf: Convert test_cgroup_attach
 to prog_tests
To:     Andrey Ignatov <rdna@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 18, 2019 at 11:45 PM Andrey Ignatov <rdna@fb.com> wrote:
>
> Convert test_cgroup_attach to prog_tests.
>
> This change does a lot of things but in many cases it's pretty expensive
> to separate them, so they go in one commit. Nevertheless the logic is
> ketp as is and changes made are just moving things around, simplifying
> them (w/o changing the meaning of the tests) and making prog_tests
> compatible:
>
> * split the 3 tests in the file into 3 separate files in prog_tests/;
>
> * rename the test functions to test_<file_base_name>;
>
> * remove unused includes, constants, variables and functions from every
>   test;
>
> * replace `if`-s with or `if (CHECK())` where additional context should
>   be logged and with `if (CHECK_FAIL())` where line number is enough;
>
> * switch from `log_err()` to logging via `CHECK()`;
>
> * replace `assert`-s with `CHECK_FAIL()` to avoid crashing the whole
>   test_progs if one assertion fails;
>
> * replace cgroup_helpers with test__join_cgroup() in
>   cgroup_attach_override only, other tests need more fine-grained
>   control for cgroup creation/deletion so cgroup_helpers are still used
>   there;
>
> * simplify cgroup_attach_autodetach by switching to easiest possible
>   program since this test doesn't really need such a complicated program
>   as cgroup_attach_multi does;
>
> * remove test_cgroup_attach.c itself.
>
> Signed-off-by: Andrey Ignatov <rdna@fb.com>
> ---

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  tools/testing/selftests/bpf/.gitignore        |   1 -
>  tools/testing/selftests/bpf/Makefile          |   3 +-
>  .../bpf/prog_tests/cgroup_attach_autodetach.c | 111 ++++
>  .../bpf/prog_tests/cgroup_attach_multi.c      | 238 ++++++++
>  .../bpf/prog_tests/cgroup_attach_override.c   | 148 +++++
>  .../selftests/bpf/test_cgroup_attach.c        | 571 ------------------
>  6 files changed, 498 insertions(+), 574 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_attach_autodetach.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_attach_override.c
>  delete mode 100644 tools/testing/selftests/bpf/test_cgroup_attach.c
>

[...]
