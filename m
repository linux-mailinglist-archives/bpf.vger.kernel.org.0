Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F352F316F
	for <lists+bpf@lfdr.de>; Tue, 12 Jan 2021 14:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbhALNTn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jan 2021 08:19:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:39356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbhALNTn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jan 2021 08:19:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7718122CAF
        for <bpf@vger.kernel.org>; Tue, 12 Jan 2021 13:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610457542;
        bh=QxlCETtS32k+LPaY4zcT2sQ1SLQcnpm7zzvGTTnqbqo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=o1BGpwDgszIQ84SVFvKUiBRPzgymnLd1mZEIV9uBxRv5pn8MVHSU+hWSusJ4TEg4Y
         KZN8RLZCDCKHWVW1MbRFovNc/unm6SJhYDZrGtwoagT7utSdRiLsJ1SBDStIg52Bya
         q+rP9XwtkVMuMHB6VhDCAqCmAaEuHXCn0d4bAl5/o/F9QuoOtI/LKEbRgzxXFGiI2t
         Q0mKnU4n/OIKurtHNlRi0uUcUaVwZp31mAf68rWQq/YcFObjxlhVdyDs5dtkHPRYUh
         yEQ+jDq5PmCBuW+Ny2kyVJjxR85LFEjb4lkIR1YXByYHccoU5rTmr9Hi7/CAtqZWuN
         BsrJcYIDdkqKw==
Received: by mail-lj1-f180.google.com with SMTP id b10so2796976ljp.6
        for <bpf@vger.kernel.org>; Tue, 12 Jan 2021 05:19:02 -0800 (PST)
X-Gm-Message-State: AOAM532goL8RZU80CwLi1MWYsSERl77bspTGaj+b/Nr4EShxuAm70SY7
        3Wqw/WPSsfVQbcJeVBD38Z3Mi3XvxWa+0JaYGJJbSg==
X-Google-Smtp-Source: ABdhPJxDGMjjn+fCOS2eJetLCjYzgB4ZdWzfeMVxV9oCWbuQAobM2wY6nLdXx6Y05vz40WLfAvac9VF/ZcMI2yCDeOQ=
X-Received: by 2002:a2e:b5dc:: with SMTP id g28mr2024861ljn.112.1610457540650;
 Tue, 12 Jan 2021 05:19:00 -0800 (PST)
MIME-Version: 1.0
References: <20210112123422.2011234-1-jackmanb@google.com>
In-Reply-To: <20210112123422.2011234-1-jackmanb@google.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Tue, 12 Jan 2021 14:18:48 +0100
X-Gmail-Original-Message-ID: <CACYkzJ55cA5STdeeXuhNEAmNi3QzLznirm1onkXHQyAJqcL_-A@mail.gmail.com>
Message-ID: <CACYkzJ55cA5STdeeXuhNEAmNi3QzLznirm1onkXHQyAJqcL_-A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Clarify return value of probe str helpers
To:     Brendan Jackman <jackmanb@google.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Florent Revest <revest@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 12, 2021 at 1:34 PM Brendan Jackman <jackmanb@google.com> wrote:
>
> When the buffer is too small to contain the input string, these
> helpers return the length of the buffer, not the length of the
> original string. This tries to make the docs totally clear about
> that, since "the length of the [copied ]string" could also refer to
> the length of the input.
>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>

Acked-by: KP Singh <kpsingh@kernel.org>
