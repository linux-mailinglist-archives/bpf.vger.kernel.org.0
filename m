Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF6743BB54
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 22:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbhJZUCn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Oct 2021 16:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbhJZUCk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Oct 2021 16:02:40 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5891DC061570;
        Tue, 26 Oct 2021 13:00:16 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id z11so319346plg.8;
        Tue, 26 Oct 2021 13:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7mXH4LMOhz+HjNyTG/EoUfwnWkgzYGCXxLTjrH5YOX8=;
        b=W+t2mw2XstVE1S+r8d9Suhriut6GUm1jAZtYxho/fC7zETPU49wsNioPbMlNDSIWNz
         oKzGHfdocbEVumX1pQYT6vYOxDEcRWm5rFl1FdSMQeOYY19umNvnWwvc+7Hrd3GHlLbW
         U9IOvKE5nFFIYM0GgoUp6IyKGQ6Bqs+n5LgpnbB0+9xfclBL8QcQ3cjEH6InMT+IwvaK
         oIPg+0rEdx08pWFaDYvFe8PYR86KR4E3jLqrU6/1FVms84NxCi0ktGuZG7MtUT7W7pzX
         bD1wxmn41mB/E5VTGTt1FmgGQ0tt29tucd//QKldcP+Nexc5HjeuIhI74xQvcDIYZI7p
         Rg8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7mXH4LMOhz+HjNyTG/EoUfwnWkgzYGCXxLTjrH5YOX8=;
        b=MyQGx8K8XC92WqZlLnpWGrQAhZBF+Te7g937ZUJC4JR141t/Tv318rXvkGrLfb039G
         5fe9ZCyX+3YWm6/a/w3+JwbtahdglfAaanNXy7kl86OWa86vsB7GqPn4wvfuSZoIr/L1
         pYV/1P4Kd6hozTD2mxJaeOgbmcL308j7/TJO5oqmLV2phSJEU64yBUobsRd3xQFnRspo
         qGEEF4Lrs0AD91s2FKHArN7wceG6QzS+cYqiMyuGRjiQlH2uSrs/RSp1P4fZlspwpdYQ
         sVpb3Ec8r8ucpR05lu5LA7AZpEtk5zyZ8lYhirK25OLGN7RfnikmuPZQ5tn3Y/D0oeWx
         5EHw==
X-Gm-Message-State: AOAM532TDCKBKo5icOd0pLjh3EScq1+C1gvxkoDNKweZrlmNXjigaOb3
        r580ysptFzPpWqCbB1f/eWIDwQgEqcQzibhwSjY=
X-Google-Smtp-Source: ABdhPJxAdRtav5k5hLhxpvkOAUkUwEnw/3GgdNuTnV/+e5507D5pF+Poh0h0jbsJYkSFJuk3kPZ2dbIJ0Uci3A31xyI=
X-Received: by 2002:a17:90b:4a4d:: with SMTP id lb13mr957815pjb.122.1635278415776;
 Tue, 26 Oct 2021 13:00:15 -0700 (PDT)
MIME-Version: 1.0
References: <20211026120132.613201817@infradead.org> <CAADnVQJaiHWWnVcaRN43DcNgqktgKs3i1P3uz4Qm8kN7bvPCCg@mail.gmail.com>
 <YXhMv6rENfn/zsaj@hirez.programming.kicks-ass.net>
In-Reply-To: <YXhMv6rENfn/zsaj@hirez.programming.kicks-ass.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 26 Oct 2021 13:00:04 -0700
Message-ID: <CAADnVQ+w_ww3ZR_bJVEU-PxWusT569y0biLNi=GZJNpKqFzNLA@mail.gmail.com>
Subject: Re: [PATCH v3 00/16] x86: Rewrite the retpoline rewrite logic
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     X86 ML <x86@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 26, 2021 at 11:45 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Oct 26, 2021 at 11:26:57AM -0700, Alexei Starovoitov wrote:
>
> > It's a merge conflict. The patchset failed to apply to both bpf and
> > bpf-next trees:
>
> Figures :/ I suspect it relies on tip/objtool/core at the very least and
> possibly some of the x86 trees as well.
>
> I can locally merge tip/master with bpf, but getting a CI to do that
> might be tricky.

We have an ability in CI to supply few additional patches on top bpf/bpf-next
trees, but that's usually done for the cases where we've merged a fix into
one tree, but it's needed in both while bpf->net->linus->net-next->bpf-next
circle is still pending.

Does tip/objtool/core dependency relevant for this set?
Can you rebase the current set on top of bpf-next and send it to the list
just to get CI to run it? We won't be merging it into bpf-next, of course.
I'm mainly interested in seeing all that additional tests passing that
we have in bpf-next.
