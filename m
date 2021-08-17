Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 512503EE498
	for <lists+bpf@lfdr.de>; Tue, 17 Aug 2021 04:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbhHQCsQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Aug 2021 22:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233438AbhHQCsQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Aug 2021 22:48:16 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DC1C061764
        for <bpf@vger.kernel.org>; Mon, 16 Aug 2021 19:47:43 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id m193so36719040ybf.9
        for <bpf@vger.kernel.org>; Mon, 16 Aug 2021 19:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xXvvHjMknDMoa1uY0kgWlDc/DO0w5lT1y2ZChMYCrqo=;
        b=fCJi41/HaGwUaNZdd5l4HS5vDQ+vtGWdI1o+lFjj/VRvej7aep4Z+/oLcnqjHsGqxv
         ex/psgjtD+CmTSf2Oz0D9pA9aiw2Twry3fyoPBai7hIjFm4yQJK+WIwYv4PdJRSyxELY
         LkF3rV5kdqzxlPOiHaMJplIEfuMmlIhBSf1R/U+uILaW5eD0MxQJpvUv1kURivGHlB+D
         z3Hevc3RCzrepW3mtZNs1EYeIEzmJYoq+pYEoG0atRRIdrILGVFeepDCZeF4jmMZjZNY
         Uwx1CjAs/5yMzG6qP6O+EXAy0N9kAh/lU/5+JGzG8dbjbuqd4DMHY89c/gdtZRV9U1fu
         ZHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xXvvHjMknDMoa1uY0kgWlDc/DO0w5lT1y2ZChMYCrqo=;
        b=AbXtIylJh5Ln9uDslVx9T/D9xDQqMmfOEB/jFksiHdDEKW8q3PhfIdxeJAGh6IMkEq
         ri8blTY3s1I8YaEyAdy5FNMZG9xeE9SFbaBby2baZDbm/hk3rz0Uq9UfCcGdfs0ahSvG
         Lh7vP+6AEUkUoCC/LmGpcy2djPI0CdjMUCipgnLP+u/dudLs/MuszfPK4VYRyPam9cQH
         xIZ90vA3Z0/9MQzVIpEAbak+0ihWxTOo+x4W20xeIFA8Obk07SsD38EV20wUZamhQwlY
         NBkARsWOAR3x+aHlb4+VXzrKVjiwpx9y80RFOAkZFGvIm65i4vbbZeB7ZRwc4qor9bHO
         VC0A==
X-Gm-Message-State: AOAM531qpizVdCx5QHwxVlU5rXN9Q9TvqDYJ9CTelvuGm3gGl1IydWM6
        vAj+PDkDmhXEAVdzVxrgvPdA/Z15wwWOntzADb4=
X-Google-Smtp-Source: ABdhPJxeHHuGuT0D7OleWWHUHX+m/OH/+URQHh97hzxWMIKteF1XHY7Gqo2Q7V5VpR3yt+oAVLSYf4T7OydDE63cCrE=
X-Received: by 2002:a25:4091:: with SMTP id n139mr1531116yba.425.1629168463023;
 Mon, 16 Aug 2021 19:47:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210817010310.2300741-1-fallentree@fb.com>
In-Reply-To: <20210817010310.2300741-1-fallentree@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 16 Aug 2021 19:47:32 -0700
Message-ID: <CAEf4BzbKSFx7LNzM3MXCbCm-CSrNvgTbN5zzCXTQYPYi9Ts2SQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 0/4] selftests/bpf: Improve the usability of
To:     Yucong Sun <fallentree@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, sunyucong@gmail.com,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 16, 2021 at 6:03 PM Yucong Sun <fallentree@fb.com> wrote:
>
> This short series adds two new "-a", "-d" switch to test_progs,
> supporting exact string match, as well as '*' wildchar. It also cleans
> up the output to make it possible to generate allowlist/denylist using
> grep.
>

You seem to have lost part of the cover letter subject line?

s/wildchar/wildcard/

> Yucong Sun (4):
>   selftests/bpf: skip loading bpf_testmod when using -l to list tests.
>   selftests/bpf: correctly display subtest skip status
>   selftests/bpf: also print test name in subtest status message
>   selftests/bpf: Support glob matching for test selector.
>
>  tools/testing/selftests/bpf/test_progs.c | 93 ++++++++++++++++++------
>  tools/testing/selftests/bpf/test_progs.h |  1 +
>  2 files changed, 72 insertions(+), 22 deletions(-)
>
> --
> 2.30.2
>
