Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5BD240449A
	for <lists+bpf@lfdr.de>; Thu,  9 Sep 2021 06:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350436AbhIIEsd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Sep 2021 00:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349701AbhIIEsd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Sep 2021 00:48:33 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F90EC061575
        for <bpf@vger.kernel.org>; Wed,  8 Sep 2021 21:47:24 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id z5so1391240ybj.2
        for <bpf@vger.kernel.org>; Wed, 08 Sep 2021 21:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RGrS7llLezAMLWn83stvqFuI4jL1T8E+Xsk/8ss0hwQ=;
        b=LRiVo5UdmLIxM9gR/ce/rv1JjhMFGWusDji98F1PcSj9QnJLd/4ioPvLhi4dZpb8bn
         2TJ4pkr+LxWNjLmngq/UWgfxnWPu3AMm/cf4VwFNM8riskv7mAv9dean0+nFlBivX54S
         LRVhhMUI6fQW9slQKCHlwKw6rsUeM6lvzUN9n07ihnXccSoDD1gKyUmCK6F8YhYuzT2W
         iT6WhQzvCN59N9WGd+Z737wipC5rOWXrAn+p46Ha6UpKDIqtcoZ1hATjpVPRiq8MKSHk
         33kI0Gk800XVg0Yfm6KyczYw23JiaLkAQuUD3g+sZRto3c3LrUlIuiXeY1+L3CmBo39b
         y6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RGrS7llLezAMLWn83stvqFuI4jL1T8E+Xsk/8ss0hwQ=;
        b=tytr4aZSQGigfhfZAXaXEFWZUH1TxrohSpmBXOzQESPZXXsXhKiRWyyoUi29a1Gg4n
         be3ffwa2HBp6vJVfaW9fYpMuKwiuo9rNQtgxr/Zu9RoRFsUJNR1j9OaRZcGl7jmepxw0
         7zNkdlNoS1LsNmRQT9cs4GEGaTn5xOLNXQGuxbHf3wOKztX3GEhMlwF76vMOiIAoABg/
         M8eArPyeMwZm0c2pLPr8EBiXrPsNCN6s5+A3gu0MZKmT6iDC1Zo7dTiZE13cYLDS0BKz
         Ii7O0RpIgRZYtzR57u+47+6N/ROCMIc/X6Zq9NRsSh5i6jRCY9p+SHhY+sHwh6ZBsmUT
         MB9Q==
X-Gm-Message-State: AOAM530qmeqJVhhoVDamH8tLQ1YNVmiX10hSC3NKX8jnJOeqAX9xNVtn
        tQ8CPiSf+nza5u+Y9a5oYxGCNezcOnhqGZK7zvk=
X-Google-Smtp-Source: ABdhPJxjwvj9KB2RVdu43LjdnyNYDRpXA120SlV0Wwso1hgArJaH9ivKcJnDYozyvqnLKkWIlBwLwgKPLWto1RtT/tw=
X-Received: by 2002:a25:3604:: with SMTP id d4mr1293866yba.4.1631162843952;
 Wed, 08 Sep 2021 21:47:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210906165456.325999-1-hengqi.chen@gmail.com> <20210906165456.325999-2-hengqi.chen@gmail.com>
In-Reply-To: <20210906165456.325999-2-hengqi.chen@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 8 Sep 2021 21:47:13 -0700
Message-ID: <CAEf4BzaAzXEWX_8XJ5+E-TXJiMgBdbZzTSW3TH7bm5m=Z4nRJg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Replace bpf_{map,program}__next
 with bpf_object__next_{map,program}
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 6, 2021 at 9:55 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
> Replace deprecated bpf_{map,program}__next APIs with newly added
> bpf_object__next_{map,program} APIs, so that no compilation warnings
> emit.
>
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---

LGTM, but the subject for this patch (and a few others you've
submitted) is very long. I think the recommendation is to keep them
shorter than 78 characters or something like that. Maybe use something
like "selftests/bpf: switch to new new bpf_object__next_program APIs"?

>  tools/testing/selftests/bpf/prog_tests/btf.c              | 2 +-
>  tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c    | 2 +-
>  tools/testing/selftests/bpf/prog_tests/select_reuseport.c | 2 +-
>  tools/testing/selftests/bpf/prog_tests/tcp_rtt.c          | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>

[...]
