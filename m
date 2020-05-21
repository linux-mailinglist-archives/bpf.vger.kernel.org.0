Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D165F1DC560
	for <lists+bpf@lfdr.de>; Thu, 21 May 2020 04:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgEUCvC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 May 2020 22:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbgEUCvC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 May 2020 22:51:02 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92833C061A0F
        for <bpf@vger.kernel.org>; Wed, 20 May 2020 19:51:01 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id q2so6377998ljm.10
        for <bpf@vger.kernel.org>; Wed, 20 May 2020 19:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mfPmF8CZW8EXsBz+QWv7G7NwnU9zJQy+FUFmHM3B2mE=;
        b=ut9X6Y4aY/BBoqcE4I/bMDJscYI+ssyMALJE7nSNW8pUhCt6oxF8faCKhGqXVSC1hA
         7KJvY1WAkWdtCWSkMOci2E6DnBwk28JPT4Abn5NV9Wds+JsHuVPTD1UE9jEu/txFM/bU
         ciUT2qYOKh13+IhFMCVJrYIf7LJ5gWfJpjD0opr1/cZBXvXrPc87FjM7pSKica9QCrOj
         CDPR8AgGKde+/h3gPBNA84Ml7u3C1Q93bEr4F4WIe6ElkYghp5OpQyOjFY7+EVESoUyu
         Hv/NjCTRBccxgWPEZtOHKrLuWh4cBs2q60AWNPUPtdKdJUVqGbke6DnIrObRILJ3f9GM
         AqGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mfPmF8CZW8EXsBz+QWv7G7NwnU9zJQy+FUFmHM3B2mE=;
        b=XZob0o9pY0CAUe2s2gH4SbGcb+uDNo2R+isjNyqXfgNLPbjlLopXOTxE2Carg7weBk
         K0kHdltaeMLnswf9H0gUmWu9DUL3dnQPgAIP45q84C9Mdu2PW5IjO3beUsS+kB4XDiQw
         OAmgU01sRnIcMH4LixL8bWKqLpJ4Cj7KR0RRFFmivNS8bOVihqt2dhTirdi+KpjHLYeC
         uy//liNfb55u7vDQ8BkeetdevD4RU6s4e0wRw8M7QxJPnoHh6WGXljpAkVQwQ4jXOEcv
         ETxBpY38OSnbc1sy+D3lHU15VSINYxFD908o/16svlhHFFDYBl9qE6RRuu687TNhviCI
         LLPA==
X-Gm-Message-State: AOAM530Z8A2EHMir+BArtW31pes3oh0/fIb6E4aC0Igmo9ec/PWBmWvd
        KhzYygHoKzZgd//h3efRJO1YIhVi4KyH9FmDichS3Q==
X-Google-Smtp-Source: ABdhPJwfbj9o5yrn6xw2Lu2H3OcYejKsUW8kSMaSfUHPzs2h2gQlO0YtY/Jp0YSHRxYkttkk5WxyMfdYopr0Y6DLOf4=
X-Received: by 2002:a2e:91c3:: with SMTP id u3mr2071288ljg.365.1590029458705;
 Wed, 20 May 2020 19:50:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200519053824.1089415-1-andriin@fb.com>
In-Reply-To: <20200519053824.1089415-1-andriin@fb.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 21 May 2020 04:50:32 +0200
Message-ID: <CAG48ez2HZfjCKG+coVq2k9eE_Hm0rsdQE=O=5nVyKL80QncVZA@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: prevent mmap()'ing read-only maps as writable
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 19, 2020 at 7:38 AM Andrii Nakryiko <andriin@fb.com> wrote:
> As discussed in [0], it's dangerous to allow mapping BPF map, that's meant to
> be frozen and is read-only on BPF program side, because that allows user-space
> to actually store a writable view to the page even after it is frozen. This is
> exacerbated by BPF verifier making a strong assumption that contents of such
> frozen map will remain unchanged. To prevent this, disallow mapping
> BPF_F_RDONLY_PROG mmap()'able BPF maps as writable, ever.
>
>   [0] https://lore.kernel.org/bpf/CAEf4BzYGWYhXdp6BJ7_=9OQPJxQpgug080MMjdSB72i9R+5c6g@mail.gmail.com/
>
> Suggested-by: Jann Horn <jannh@google.com>
> Fixes: fc9702273e2e ("bpf: Add mmap() support for BPF_MAP_TYPE_ARRAY")
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

Reviewed-by: Jann Horn <jannh@google.com>
