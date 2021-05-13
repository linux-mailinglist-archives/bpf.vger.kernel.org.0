Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88CC037FF9E
	for <lists+bpf@lfdr.de>; Thu, 13 May 2021 23:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbhEMVKQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 May 2021 17:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbhEMVKO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 May 2021 17:10:14 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1461C061574
        for <bpf@vger.kernel.org>; Thu, 13 May 2021 14:09:02 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id e128so759888ybf.6
        for <bpf@vger.kernel.org>; Thu, 13 May 2021 14:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hJAWl72w8rp7GN+CV559nO5m/QY9ah8/QxE4SQ181aU=;
        b=a8wbtm2oXYmTCpShn1bUdi9zpqE0DcAxJYre6xNLMd6mZdrzScydhbiCoU7v86vWXt
         KmRPsZaq/+OlBR6UXHKvg/b9/ssRVCi18TjgqOapxLFu5rhJ/ldLUc88lp+e1cGXVzGt
         W10FlyJK2h8QN/Xi522kufmRjZow9UIjKWVoiYvA0kSuM/hbKyEl2Fec/5f01PpQpQwx
         WsyJnIq9VmgrlaY59NetR94yOqqm+hjpOfVPgERxSCJPk1/tLBhZ1pGNIAp9QGGEW1jL
         D0lXjDl4gCoQ97+2DZXSPQHg+cAcyqqGcnWQwyy5IdXqw2/uaxPSgFhBzvwdCC1THlca
         76FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hJAWl72w8rp7GN+CV559nO5m/QY9ah8/QxE4SQ181aU=;
        b=mTsH0n1IltZLxiq++vNEzw44DehxitQdAsw9ub5R9gGuSdJQ7PLZjuDNeP3w8A+TSP
         bl9uSXJT4nqdfhN1tXDEWlL9ixrui5jH1EJTEeD26JbPJIO2mkd0dsCMrNTOup+1t20A
         +MHbbZ8Ro9SUSAcR6iCblBw3sPGGbZgN4pbmEEYjyNWuFpwONORhZBh4C1jeSYAMIc3m
         8bh26EQmuv/YfkTodZSTOR0GAqnwOGGQTXBlrrWncFI6FylTFE8k+B1tU1n+gj19E9sa
         DdWoIV665kbZOJ3NoFtiL1SjZ65SwYIIBYenZi0R1ZNucsF5kAe0yfkG0hA8VjqaI4MC
         YnCw==
X-Gm-Message-State: AOAM531NcaV+B7Yf9m42l46PYFmsBijXXqtIry+KFHeQV9MBmeaQXefO
        HmvwNzTbYlPKxwMK5RIXtLKdxOej/vEa7SI/eMYvKFlkNPY=
X-Google-Smtp-Source: ABdhPJxFOrTMvsfU+7Us9eJIhXprQOI+fLGU6O+p88MlxI4RuLb0O8pLJCcoYq5Ja8OgpLNIU991BZkkYVQtRNxkses=
X-Received: by 2002:a25:ba06:: with SMTP id t6mr56600707ybg.459.1620940142271;
 Thu, 13 May 2021 14:09:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210512213256.31203-1-alexei.starovoitov@gmail.com> <20210512213256.31203-11-alexei.starovoitov@gmail.com>
In-Reply-To: <20210512213256.31203-11-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 13 May 2021 14:08:51 -0700
Message-ID: <CAEf4Bzb6p7pGsUsxu_X9472x+B8ByLc6i7M4Em=K-kLgpUzrvQ@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 10/21] bpf: Add bpf_sys_close() helper.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        john fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 12, 2021 at 2:33 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Add bpf_sys_close() helper to be used by the syscall/loader program to close
> intermediate FDs and other cleanup.
> Note this helper must never be allowed inside fdget/fdput bracketing.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  include/uapi/linux/bpf.h       |  7 +++++++
>  kernel/bpf/syscall.c           | 19 +++++++++++++++++++
>  tools/include/uapi/linux/bpf.h |  7 +++++++
>  3 files changed, 33 insertions(+)
>

[...]
