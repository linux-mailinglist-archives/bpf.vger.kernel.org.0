Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4114A325A2C
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 00:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbhBYX1V (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Feb 2021 18:27:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbhBYX1U (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Feb 2021 18:27:20 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5921C061574
        for <bpf@vger.kernel.org>; Thu, 25 Feb 2021 15:26:40 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id x19so7171839ybe.0
        for <bpf@vger.kernel.org>; Thu, 25 Feb 2021 15:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5eiuwhc+4eGc7j1hKwgJtkTe/U+Mw7PLXZEisArUm3E=;
        b=gOMQLWMGR+ftmtHHfKpOxNN3325C82oDSr83C5qrGYjBU8AMzeISLh9Or9sC4tM/Mh
         u4CR+1qgX2bqREvXKbwsNMvs5Jvs/eDnh+ct5xyH8h1EPQuL9Ivh+FJN8adLlTAX9dFZ
         DRmqOrtkKJrXGCD/Uu1RcWfVAbHLhPCHXl46WO5Kk+QFI1Fn/buGxIXhli5cDtZMV4x7
         +4p1ZbD7DGzrVeFg34AEnKUuR5IzCx9I0TEf+Wp2JiaypmJm0vJ364Jnqv1txglen2sz
         3AKiXCDKBzZD0O2AkqUPpigGbKgu5FB16JIj+Iq4taspr3lt6AVQVCbTHxiWroIw9Ou3
         KIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5eiuwhc+4eGc7j1hKwgJtkTe/U+Mw7PLXZEisArUm3E=;
        b=tqlWAaz3l9aKk103+OdT0t8I/GwrvxlR0LTZ082KZTpjVkM3HiyoumKt2uhDaQY2ie
         v3BhxK2a89GRxBE9g21JHhbTyOrTcBpgL14wa6k+gBfrcYu6jqj4w1x3dvmuA+xkJYqZ
         +o7phSiOKLQtJNI65jJ7nNWvJtE9PU9lBIVLSNJQZWxDMZaY5ZUaQ2H4jjnHSa0rLNem
         FQGw9Nv7S9gEBiW6TA+Ak7onm/LfHgPh6clGWfdlwg3nYC2Jb0uw2N74P+jmqfdwX10W
         rPW+DKplpOflh1Opg3o6YNZD7aAlxcaup+v5C4Z5koVWJpEIXXKXHHC4MZeCW1bs4uAM
         E1Vw==
X-Gm-Message-State: AOAM531tPMJNfKDSX49VAspSDYEFQdtKqpl8lPc+sMHRJgbwW7ZmtTDS
        Irm+GURv61DC27tbyffSjQUemWpcgFyRWx+V2Uuy//FZzvc=
X-Google-Smtp-Source: ABdhPJzr7JXj0JVmnvd3yHgXiyIlFQ5ujkrRDwmz+66yKzR9iUu7Jn2X/S2ndc+zQ5rNINUDwy86bvvV9uiEnx8w7CE=
X-Received: by 2002:a25:cc13:: with SMTP id l19mr465283ybf.260.1614295600153;
 Thu, 25 Feb 2021 15:26:40 -0800 (PST)
MIME-Version: 1.0
References: <20210225073309.4119708-1-yhs@fb.com> <20210225073321.4121788-1-yhs@fb.com>
In-Reply-To: <20210225073321.4121788-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 25 Feb 2021 15:26:29 -0800
Message-ID: <CAEf4BzYsBdCayeshQCqGShNZtbuijoPJxPeazk-7K2+trSrKOg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 11/11] selftests/bpf: add arraymap test for
 bpf_for_each_map_elem() helper
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 25, 2021 at 1:36 AM Yonghong Song <yhs@fb.com> wrote:
>
> A test is added for arraymap and percpu arraymap. The test also
> exercises the early return for the helper which does not
> traverse all elements.
>     $ ./test_progs -n 45
>     #45/1 hash_map:OK
>     #45/2 array_map:OK
>     #45 for_each:OK
>     Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

same question about "classifier/", but otherwise:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  .../selftests/bpf/prog_tests/for_each.c       | 58 ++++++++++++++++++
>  .../bpf/progs/for_each_array_map_elem.c       | 61 +++++++++++++++++++
>  2 files changed, 119 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/for_each_array_map_elem.c
>

[...]
