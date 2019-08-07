Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 079F38556C
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2019 23:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730128AbfHGVtZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Aug 2019 17:49:25 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46960 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbfHGVtZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Aug 2019 17:49:25 -0400
Received: by mail-qt1-f196.google.com with SMTP id h21so89947865qtn.13
        for <bpf@vger.kernel.org>; Wed, 07 Aug 2019 14:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C9nOF+aM1OeB3dJye5a3F7o9X6YnqK1OfFaN6GevuaE=;
        b=Qn2gW8hf1uX7HDOua5EjDyI8BuFj6deum2goAMriZ9pY9fydcK9HokcrIoQS3zgWHV
         /lcIKgUSyBmisihFyc0AEkWvM0RIIPsJWUWZnT1AGNQ3bJpfOKdOj9PVVfpvLWsilJ9v
         8V/zhMwtsuvS9q3iTu4IfFQGdKT+4hM8HbxTRwncgwNQNXkuoUNMaOi+bDUOUfcV4UMF
         kEkY/0OCh1a6XpUfnG9Vbelk+R30ES2gHbYQWwnHqiePLn6DtTGligLf1HBgarkZR0tf
         Sw0MSYLQfOi/tLdXmo1L2pA+E0AjhYwV6g+mdlBR3ZrHN25imZ5QPoB1qCDQAYmm4Pag
         ywDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C9nOF+aM1OeB3dJye5a3F7o9X6YnqK1OfFaN6GevuaE=;
        b=YEDuO0ZNCuASzFbBbt+OrxmpBptYxeoo6xjQpRwM5gmJrK53EoMVbjthhzrm3aBZBw
         pnA03KQMc495yDrm4AEKb5WIbKMPR7n5xjp0TkYqflEgYBu2ie5R54Vbdd5z9EDb6gzc
         3LR30aY5Aiey+gnyQ5Tb8crxNwhfL2lfCfFyvIR2+aAQd+VYdSNDnq20YTOytL58Dg3o
         Dgk6egXruFIbUvsaZQwGHlMfkLuOa/gyBSiZ6hU6DToohgd11kCqwoKRKIUOtjOlcXph
         lw5SLrzyY8ueUYZYRHyyy0CX8sx+CMEN6KqjCQwjpBpdsDa8Qt/OZguwtEgYqfQ9YuN9
         ll3Q==
X-Gm-Message-State: APjAAAWC5/9TOxUaAxhrA6bFt7QxNZdSb418JZ9Mk3A3WtxSxr8BRwf0
        3zd/t7LMDsvGk4E8XGHRzAA7Odf8/KBzqQPlA10=
X-Google-Smtp-Source: APXvYqwTFjJb7Vd39/dCvmN8d/RMOCpCHzvoogRYmGwDkNB006wpek2lOdD1uLWRmWW7aoIjtGztPsLGAxJ/bZAB+CU=
X-Received: by 2002:a0c:c107:: with SMTP id f7mr10203720qvh.150.1565214564154;
 Wed, 07 Aug 2019 14:49:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190806234201.6296-1-dxu@dxuuu.xyz> <20190806234201.6296-2-dxu@dxuuu.xyz>
In-Reply-To: <20190806234201.6296-2-dxu@dxuuu.xyz>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 7 Aug 2019 14:49:13 -0700
Message-ID: <CAEf4Bza1+n+1fUu6gJZqy5YxoyV6UD9BrfkS7e7uuRdJ443EBQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] tracing/kprobe: Add self test for PERF_EVENT_IOC_QUERY_KPROBE
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 6, 2019 at 4:42 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> ---
>  tools/include/uapi/linux/perf_event.h         | 23 ++++++++++
>  .../selftests/bpf/prog_tests/attach_probe.c   | 43 +++++++++++++++++++
>  2 files changed, 66 insertions(+)
>
> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
> index 7198ddd0c6b1..4a5e18606baf 100644
> --- a/tools/include/uapi/linux/perf_event.h
> +++ b/tools/include/uapi/linux/perf_event.h

Please split header sync into separate patch, this will cause problems
syncing libbpf to Github.

> @@ -447,6 +447,28 @@ struct perf_event_query_bpf {
>         __u32   ids[0];
>  };
>

[...]

>         ssize_t base_addr;
> +       struct perf_event_query_kprobe kprobe_query;
> +       struct perf_event_query_kprobe kretprobe_query;

Add = {} and avoid using memsets below.

>
>         base_addr = get_base_addr();
>         if (CHECK(base_addr < 0, "get_base_addr",
> @@ -116,6 +119,46 @@ void test_attach_probe(void)
>         /* trigger & validate kprobe && kretprobe */
>         usleep(1);
>

[...]
