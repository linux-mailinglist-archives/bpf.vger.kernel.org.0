Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB42314112
	for <lists+bpf@lfdr.de>; Mon,  8 Feb 2021 21:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234850AbhBHU5I (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Feb 2021 15:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233528AbhBHUzH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Feb 2021 15:55:07 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082C6C061786
        for <bpf@vger.kernel.org>; Mon,  8 Feb 2021 12:54:27 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id v123so15898755yba.13
        for <bpf@vger.kernel.org>; Mon, 08 Feb 2021 12:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AgvlvcpRDItZKh4j06G9GSofoxMNyUts5zcCe8XyHGc=;
        b=OwdsZ3nI4U15QOZDfz3nN7ypTXTQ/5Szaz60WtTiWEKT7qpf+tf71DhJhODHQZjPR4
         KOtCLtQ3qJEVYYtvX+0VR8DWZCHZlbh/L9RH2sO/2p5C1NKsTfm3LTkWNOCkfkQZdM6n
         3xUZhsQC1mEsB0CM1Ew2TemtCunax9ToNhPfOfcae41T4jqoSfZXA0sgyrUrkaLVjjcH
         uWLn32rTu/DIk0Ki1BVC/n0Z/UV1zLUYVVHjIBLFoctIEMAD64TUKv9HFM5ZrzgtP4kF
         7djpmRoHMM6NEGWED7Vyud13ZzFuYMnwgjHCEnlZq37UBcEtnqs75eODrXHV3XxdyTd7
         cahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AgvlvcpRDItZKh4j06G9GSofoxMNyUts5zcCe8XyHGc=;
        b=B16KlcKLOyEfaQeCrLPqznxzml6BX+FV8D9S7tDodi4U8Rl5PmC5yxGWjJiUKN0U0t
         e93cplJv+nYanrCz0E7D5tggyAq1GYlXjNwSkASP6lRAPh03xT0/JvWssNuUWvegLsUo
         UM/OniD87VC+6gagI4CD86zfcE7U2FCeDUvi/E/Mg/UZVIB7irgxwhEnDWfqNmXSElpp
         2coRLJb6pcuoAu74/yz2knpZxmNGe0TKXDznyTSA3J+cCwNT8jxKsL9zPvVDS+1Sf6NM
         FtU0wUI6eOBI1vgLo6/QBqNdqGrV9JXrK0Qz9tw+6nhGl/6rucUQnyiIyUvhq23y5cPY
         D0hA==
X-Gm-Message-State: AOAM531pYQeeVuqtDJdFxZ6Jq+lioV1R1DEEyAdcA3gWrztLjBtwfL6w
        gEH/7xqDg7t7KrdPlpyMZ9bcQvyan4YX2aTBYx4=
X-Google-Smtp-Source: ABdhPJyCKRZAT1C3aytAKZKQ8Z76gRL2SVaBVJBhYKpWJvs+ooQ/v52Qm5eV+Vt81sCj6AIRnEWiyyxmkPTkJLqlCJ0=
X-Received: by 2002:a25:f40e:: with SMTP id q14mr28230274ybd.230.1612817666389;
 Mon, 08 Feb 2021 12:54:26 -0800 (PST)
MIME-Version: 1.0
References: <20210206170344.78399-1-alexei.starovoitov@gmail.com> <20210206170344.78399-5-alexei.starovoitov@gmail.com>
In-Reply-To: <20210206170344.78399-5-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 8 Feb 2021 12:54:15 -0800
Message-ID: <CAEf4BzaprNESjgFRMSs7W1KMcW1Pt9rXU2F9kdEKM966trjO8A@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/7] selftest/bpf: Add a recursion test
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Feb 6, 2021 at 9:06 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Add recursive non-sleepable fentry program as a test.
> All attach points where sleepable progs can execute are non recursive so far.
> The recursion protection mechanism for sleepable cannot be activated yet.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  .../selftests/bpf/prog_tests/recursion.c      | 33 +++++++++++++
>  tools/testing/selftests/bpf/progs/recursion.c | 46 +++++++++++++++++++
>  2 files changed, 79 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/recursion.c
>  create mode 100644 tools/testing/selftests/bpf/progs/recursion.c
>

[...]
