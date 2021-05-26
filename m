Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A358391D1D
	for <lists+bpf@lfdr.de>; Wed, 26 May 2021 18:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbhEZQhA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 May 2021 12:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbhEZQg7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 May 2021 12:36:59 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65791C061574;
        Wed, 26 May 2021 09:35:26 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id b13so2909417ybk.4;
        Wed, 26 May 2021 09:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j0uvaQGcER05ZRle2g37z1ECZICIa5KxoO42YJFCmTk=;
        b=nY3EiE5IpursClMbB6da4Fur24jm0oWTs6BayJsNGihIqGcYuDbyQPPPnuzYBztjTK
         oZAyrLO7K3F3bK/H3rw9IXebyTp+mKhAs3n+lnyuHyaZw6JZU5kB+LpoaLMPq4nt5LgZ
         uTo3jKI+Vf4ssJUDCC18W8S8Fgw9fhIXhIT02flO29EoXtRww7FJuD9pkpxUHCk2ZDuV
         w54h6gkdVEIUdAYyF98Yh9hY31NdL693MDBgGAyghlTEQmur0C1NJx+oK5GujCtwPCrT
         8VUdqsXxEGU8DBEHynveSlGtUSFO8vXcjkYfm5U1xuhhcciDx2aU24WvTa7n4I5JvIsx
         SL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j0uvaQGcER05ZRle2g37z1ECZICIa5KxoO42YJFCmTk=;
        b=Uyad42BTSbdSZR1ZU+92gjiCY2YNAEVbXs4nNjYEiE7BSf/tZP8mi5TBrBYW1JudNE
         FyEMG//HLC4xABCPBcNj6Dqnnc5TRsJZkvhqSm70JR34S7Pu7WgLnmPCp4+CK4wGHL/g
         d5yO4w0hq1FAbIUai+UvU0H0k8GUPfWfRr/PkYI/GJoCsI0vzmISFN8z0KYuoaRbpy3L
         FTrrUZ4W9v63qNQBslrooiUgARw8aqZMKOFIxzYmYySjW8NqiEWlWzomSPG/fQXpME37
         FQHEEkmR01uDnArN7Q6YmMohnSaiRBJ30HJXhjfT+uQ3nrBY9TXdd7a/erQ+5OZtWz60
         A+NQ==
X-Gm-Message-State: AOAM530Rf+yD5qNVWDNWCycFJKp5WH6MYQZBNMltD2pMKCdIyGAFL/d/
        JXgsarj20K858xEysgVcEs9H9VKpqzxWc9TP8/Y=
X-Google-Smtp-Source: ABdhPJymBrTFcEBZ89h+/lAm5QM6SvzD1WvE5ac0okFHTq3BnhoMj94o/kVzCTtuw+utL4xXJ9NdhPNZfLNjlWr0NfI=
X-Received: by 2002:a5b:286:: with SMTP id x6mr54025495ybl.347.1622046925710;
 Wed, 26 May 2021 09:35:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210525201825.2729018-1-revest@chromium.org> <f3e6c21e-8d6e-2665-770c-65f9b98ccf93@iogearbox.net>
 <CABRcYmKhmxUXgDa-Mr5_fNB7R-U11h4bGwFdj1pKx3hxB_mW2g@mail.gmail.com>
In-Reply-To: <CABRcYmKhmxUXgDa-Mr5_fNB7R-U11h4bGwFdj1pKx3hxB_mW2g@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 26 May 2021 09:35:14 -0700
Message-ID: <CAEf4BzZpRL-n0V_JaHrkrOyPgNx+_RR9cQ2fiOfVuQ=Qew11kQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2] libbpf: Move BPF_SEQ_PRINTF and BPF_SNPRINTF to bpf_helpers.h
To:     Florent Revest <revest@chromium.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 26, 2021 at 8:01 AM Florent Revest <revest@chromium.org> wrote:
>
> On Wed, May 26, 2021 at 8:35 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
> >
> > On 5/25/21 10:18 PM, Florent Revest wrote:
> > > These macros are convenient wrappers around the bpf_seq_printf and
> > > bpf_snprintf helpers. They are currently provided by bpf_tracing.h which
> > > targets low level tracing primitives. bpf_helpers.h is a better fit.
> > >
> > > The __bpf_narg and __bpf_apply macros are needed in both files so
> > > provided twice and guarded by ifndefs.
> > >
> > > Reported-by: Andrii Nakryiko <andrii@kernel.org>
> > > Signed-off-by: Florent Revest <revest@chromium.org>
> >
> > Given v1/v2 both target bpf tree in the subject, do you really mean bpf or
> > rather bpf-next?
>
> I don't have a preference, it's up to you :)
>
> On one hand, I see no urgency in fixing this: BPF_SEQ_PRINTF has been
> in bpf_tracing.h for a while already so it can wait for another kernel
> release. Applying this to bpf-next would do.
> On the other hand, BPF_SNPRINTF hasn't made it to a kernel release yet
> so we still have a chance to do it right before users start including
> bpf_tracing.h and we'd break them in the next release. That's why I
> tagged it as bpf.
>
> The patch applies cleanly on both trees so if you prefer landing it in
> bpf-next it's fine by me.

I think it should go through bpf-next. It's not really a bug fix. And
we are not going to break anyone with this move. And libbpf 0.4 is
officially released without this change anyway. So, bpf-next.
