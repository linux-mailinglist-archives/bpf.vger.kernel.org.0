Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09FCF193570
	for <lists+bpf@lfdr.de>; Thu, 26 Mar 2020 02:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbgCZB5E (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Mar 2020 21:57:04 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:45937 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbgCZB5D (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Mar 2020 21:57:03 -0400
Received: by mail-qv1-f67.google.com with SMTP id g4so2179272qvo.12;
        Wed, 25 Mar 2020 18:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XZom649rD9A2YiwpVukxYNVVAs0uWpwZ9GzmqDRwqNA=;
        b=bFB7g4KTIRH6+POAgAAyQQICNPW/diAa6HattO/B+IEPIPNsd2YUVkvVJwNRxLQnZo
         Rlqe021q/IiNZ4xDdUEbkkVrWeaGMSKyGHlmlALSJUgayaC+PGmoUBhtJ/MDAv5ET6Hn
         AFvfHjKApzJn4paZW5glsyUy9wW7FKbJp7qyueiNlwUtD3QicIexoQeUFuF1v0pRDY0F
         lzqL0LJJjetTRczXyn9f6fCaUcHwtvhY/XaO4fKzwnOHY5AuUgyDbzcPwN6H0maXwsux
         gP+FHyHCutE2oQzv6lzmmhszLMhdJIjLsisKrNi/zRWaYrvveABYl+2Bm1fHFulm/uzC
         p9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XZom649rD9A2YiwpVukxYNVVAs0uWpwZ9GzmqDRwqNA=;
        b=nckudXUkixhIOILWiE6oEINferSL+o2cDcXJcQHOfguYLcL+SWGXAMkMNbl4T0XlxY
         GPMEu1vymvyUpMAU47hIqu58oVCzjlSHIZJC4FxT4bzAQJ1J8P7ZI+nA6knACtflDjGs
         g+1alxOGx+dUId+VwF/RQsL0RNCwcxY0cPCpO+CKdGRE+Xc4K2MVnoGO2C6J20sD5fWW
         NzMxPVKld2bEwkJgQCh8uIOafX0f6316Ld6uqjMFVXQXL5eo8yJnf0LaVAraRWfHPqMQ
         sEk+ZbszZEeEfNOyDkTKuCrCNCY+2/TPDVZ9NnuilEs8KrqBFRaT+uuURFOLGA05cDe7
         J6og==
X-Gm-Message-State: ANhLgQ0Z44QlGxmqiwe9UcgIgpPiEXV4PR+BVVLAdHPQvs1W78e61mMG
        gqMYhaofNYvJjQGeXmwO83iZFM/j31Z0Tyz0y+g=
X-Google-Smtp-Source: ADFU+vtZRksw2950jnl8Q59zwV1JximIkDZpJC5LSSHjKcPw+tjw857VjjCYua+Tohc0vUPAb/rcbVGh3j5lAVJxEok=
X-Received: by 2002:a0c:ee28:: with SMTP id l8mr6023029qvs.196.1585187823033;
 Wed, 25 Mar 2020 18:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200325152629.6904-1-kpsingh@chromium.org> <20200325152629.6904-7-kpsingh@chromium.org>
In-Reply-To: <20200325152629.6904-7-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 25 Mar 2020 18:56:52 -0700
Message-ID: <CAEf4Bzbn3jAXPEBPWtxk6UUN9iWbmb_bnPYzSoA7du-Nz-Mbxw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 6/8] tools/libbpf: Add support for BPF_PROG_TYPE_LSM
To:     KP Singh <kpsingh@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>, Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 25, 2020 at 8:27 AM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> Since BPF_PROG_TYPE_LSM uses the same attaching mechanism as
> BPF_PROG_TYPE_TRACING, the common logic is refactored into a static
> function bpf_program__attach_btf_id.
>
> A new API call bpf_program__attach_lsm is still added to avoid userspace
> conflicts if this ever changes in the future.
>
> Signed-off-by: KP Singh <kpsingh@google.com>
> Reviewed-by: Brendan Jackman <jackmanb@google.com>
> Reviewed-by: Florent Revest <revest@google.com>
> Acked-by: Yonghong Song <yhs@fb.com>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  tools/lib/bpf/bpf.c      |  3 ++-
>  tools/lib/bpf/libbpf.c   | 39 +++++++++++++++++++++++++++++++++++----
>  tools/lib/bpf/libbpf.h   |  4 ++++
>  tools/lib/bpf/libbpf.map |  3 +++
>  4 files changed, 44 insertions(+), 5 deletions(-)
>

[...]
