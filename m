Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE62264A82
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 19:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgIJRAP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Sep 2020 13:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbgIJQ6t (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Sep 2020 12:58:49 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317AEC061796
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 09:58:49 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id 195so4507860ybl.9
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 09:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XbsAP5bzmT5z2vU/d0JgAIbhMrvKZIbLgjgZusXXXTc=;
        b=u2fDhy1XslVrZBzmRNM+dmV/HURrUKPH31wIORc4i8BUis0dWL2Oi9+zaq/RX7Lgsb
         hzVui5icwuo7D5nEPPLSx6V/1c3N6cdqgrPCmE0463mx8HPj71pjk3VJEfUsppoEs9wr
         QRL8LnE/XGcu/C62RnCBFELaxAhMYJPRCOrcvGUkJtz7gtTSq/OGAaXdmSdIZYlWb2GT
         08CtMvmO5gi+sqRfjLH5/OiyD15bznzfkaCxPZzmvUXP8GYsYP+of9BmsLe1nJtsq5We
         fcZyn2znNNd18Qrq3saLCCx/LAi1vBN4YzN3QKZX/pyJcvnj5gOlmBqRTH7PIpNyH//x
         KLLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XbsAP5bzmT5z2vU/d0JgAIbhMrvKZIbLgjgZusXXXTc=;
        b=dtHejSS+cq/f6U0jH9GjAOL74WcssIYN4VXL/8LTk/oaXaWzKJ2y0oH6ufJzSCE9y0
         DaHCPuMEhwXmveh/bJo6yIx8tbngbZTRK6ibjIb1KRz0UCvPgQwtYASyjzafr4ZS3MIi
         6jcX//uWQpdVvXNhzdNFy/HrMxZ7ln4BSJgTTztjliYcDh53mbvmx9xvgbMe8ZdBpvO5
         8FOyIiC5A5ajytO4hC5T1OwAgXp5bxULjkaQH99Ifwa8rIz2AH+NLAx0c0EWIAbobiJi
         RZWqJPLjp+PSfmZs+5ZxQRO88tJHykzxJnhKJmm3k2/tlLCDu2MbN4SIwcOQseA/zQ7x
         4Rdw==
X-Gm-Message-State: AOAM530PEhLZJIhO9/F5UGLMAUQbnDIZnHvY0RmHw4XxJ7zJ1mLkara6
        jrV0uawKqi8pZgPHNSQEBAu1tAzsfLWh97klWSc=
X-Google-Smtp-Source: ABdhPJxGE04gel5C07Er5vNWSuOv2N0CP87lGGSNyMdxUkwc4QFPH+NqMaQUg9caoZr0gKSaN+V9ngk9XSFcix4r8bA=
X-Received: by 2002:a25:ef43:: with SMTP id w3mr12710974ybm.230.1599757128413;
 Thu, 10 Sep 2020 09:58:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200909232443.3099637-1-iii@linux.ibm.com>
In-Reply-To: <20200909232443.3099637-1-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 10 Sep 2020 09:58:37 -0700
Message-ID: <CAEf4BzYQ+81D4VgrOjTuX-1a1HgPBNq+zsX-te44Wa4=97Yqpg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/3] Fix three endianness issues in test_progs
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 9, 2020 at 6:59 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> This series fixes three test_progs failures on s390, all of which occur
> because of endianness issues.
>
> Ilya Leoshkevich (3):
>   selftests/bpf: Fix endianness issue in test_sockopt_sk
>   selftests/bpf: Fix endianness issues in sk_lookup/ctx_narrow_access
>   selftests/bpf: Fix endianness issue in sk_assign
>
>  .../selftests/bpf/prog_tests/sk_assign.c      |   2 +-
>  .../selftests/bpf/prog_tests/sockopt_sk.c     |   2 +-
>  .../selftests/bpf/progs/test_sk_lookup.c      | 264 ++++++++++--------
>  3 files changed, 151 insertions(+), 117 deletions(-)
>
> --
> 2.25.4
>

Ilya,

libbpf Travis CI setup does only a build of libbpf for s390x right
now. But we additionally have a test that builds the latest kernel and
selftests and runs them in qemu. All this is implemented for x86-64
right now. But if you'd like to spend some time to set this up for
s390x as well, please let me know. You'll be able to detect issues
like this much earlier.
