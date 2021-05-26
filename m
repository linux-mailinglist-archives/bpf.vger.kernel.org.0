Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACFA7391B07
	for <lists+bpf@lfdr.de>; Wed, 26 May 2021 17:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235249AbhEZPCr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 May 2021 11:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235131AbhEZPCq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 May 2021 11:02:46 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A63AC061756
        for <bpf@vger.kernel.org>; Wed, 26 May 2021 08:01:15 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id o10so1132038ilm.13
        for <bpf@vger.kernel.org>; Wed, 26 May 2021 08:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o56rC1D1EYCkJ8az8fZ/Ykdr6QvQu4dlGEhkAT9xEQ4=;
        b=LV0uxZXP+xhPLsKXCZlaIyQK6goOnbpEC0qb8oCBEc+g7hvE7tprs6quUMDvad29UQ
         OHP0FjU4rXTlJKB1LGAVWCLgpcqUe06CMFq8qxOXsntZZY5Nej2YVcbg6OACSLS+tGSg
         qbgJGE+WH1DLbGQ29X+PV+HQGv3BM1XXw6Xuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o56rC1D1EYCkJ8az8fZ/Ykdr6QvQu4dlGEhkAT9xEQ4=;
        b=SW3vKOGq7y8gpFKtRhUM8dWP6Cct2Pk+TZrJV7mOjl7AqlBg7RvAwpJz8hRcBWlZSe
         7jok34dMs9Md3ALct7u0Reo2j1wO0iZnODTNbz4oS+UaR1pJyjFS/6aocfz/R9f9QrmB
         srx/x3b9HKfTSaoE/rKStFS0S6xP/cW2AOMt/yo/rHuGCXp2LvUK71QT/tCQH+TTQXQc
         cW0GkO8j3qwKwgiVyDbIh5WPHKPgD5beLAkAbwl49nUBa3vv+lIEyj5vWgxO/tSQJha1
         BJ4j7z3Mfj3GpFL4x3fFH+3lwSDuSMPeh//jMF5DXSjBh930JDYPbwOhWuPbF56hwE7c
         tmLg==
X-Gm-Message-State: AOAM5314+WxVQP/TPoGYkA1F5Bt03AMy4dGZ12yyonItKDV/BCxi3YOU
        WGYgG0AFn4iiNO/gHl5jvVUbY/gbzvZVsMvxz/yxpw==
X-Google-Smtp-Source: ABdhPJxq5pQ0JPZoAAWgQQhfcfxdhKDRfcWZyz8IxSxM53O0RjA2jT6/nBOoxGI7K2mAaSRaKlMNJ+6xetcpJB+eFtA=
X-Received: by 2002:a92:c5aa:: with SMTP id r10mr29639423ilt.89.1622041272982;
 Wed, 26 May 2021 08:01:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210525201825.2729018-1-revest@chromium.org> <f3e6c21e-8d6e-2665-770c-65f9b98ccf93@iogearbox.net>
In-Reply-To: <f3e6c21e-8d6e-2665-770c-65f9b98ccf93@iogearbox.net>
From:   Florent Revest <revest@chromium.org>
Date:   Wed, 26 May 2021 17:01:02 +0200
Message-ID: <CABRcYmKhmxUXgDa-Mr5_fNB7R-U11h4bGwFdj1pKx3hxB_mW2g@mail.gmail.com>
Subject: Re: [PATCH bpf v2] libbpf: Move BPF_SEQ_PRINTF and BPF_SNPRINTF to bpf_helpers.h
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 26, 2021 at 8:35 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 5/25/21 10:18 PM, Florent Revest wrote:
> > These macros are convenient wrappers around the bpf_seq_printf and
> > bpf_snprintf helpers. They are currently provided by bpf_tracing.h which
> > targets low level tracing primitives. bpf_helpers.h is a better fit.
> >
> > The __bpf_narg and __bpf_apply macros are needed in both files so
> > provided twice and guarded by ifndefs.
> >
> > Reported-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Florent Revest <revest@chromium.org>
>
> Given v1/v2 both target bpf tree in the subject, do you really mean bpf or
> rather bpf-next?

I don't have a preference, it's up to you :)

On one hand, I see no urgency in fixing this: BPF_SEQ_PRINTF has been
in bpf_tracing.h for a while already so it can wait for another kernel
release. Applying this to bpf-next would do.
On the other hand, BPF_SNPRINTF hasn't made it to a kernel release yet
so we still have a chance to do it right before users start including
bpf_tracing.h and we'd break them in the next release. That's why I
tagged it as bpf.

The patch applies cleanly on both trees so if you prefer landing it in
bpf-next it's fine by me.
