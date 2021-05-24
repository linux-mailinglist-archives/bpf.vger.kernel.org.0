Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA50638E25F
	for <lists+bpf@lfdr.de>; Mon, 24 May 2021 10:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbhEXIfZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 May 2021 04:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbhEXIfZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 May 2021 04:35:25 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689A1C061574
        for <bpf@vger.kernel.org>; Mon, 24 May 2021 01:33:57 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id r5so39510846lfr.5
        for <bpf@vger.kernel.org>; Mon, 24 May 2021 01:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ay8kNvVYf5sGoxxiUyGq2Q095ahiBNrAsaw8dMPDjGQ=;
        b=SyWgBI0l2zcGhIb3sBqm0wshVe4UOTLeqhk1YG/KSHrRHSGWYMXUYcxlJvFYwYx9ZK
         25vCfM0/41yHFShcKVM3gFZVqvzL6n4PwS+8E98Zn9zv0G6F7kD6W3UgLSRiQhKJY4rY
         pzgJOImr52uiG+D1z+F2s2MKCzInxaY1vpfbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ay8kNvVYf5sGoxxiUyGq2Q095ahiBNrAsaw8dMPDjGQ=;
        b=VRNnEPPJTPKLHMntXBMIgEc+XV3Thvia7yth9rFOsuUenNWdjfbzCVnNBqoBZtqZtC
         y8WCAaKCPQ4/zRSTY4NMCnGLY+neoCkAqT2d1AVwSiUC43D+QQ3HtEuYuvZweGbsMg2/
         6/aXYDbd14QZNn7fgEJXyeKkew45KN8yvOh+Mi+z3jUjYS7gJCWzyp7uxoCaiiugROWs
         Voh3y/W96YtBwQuf9mB6ZRUbYR62pWdPKhsTywhad2Uvr45PvyL23QpDCyak2CXKrfyP
         A9iSxmuT5Fk4Hnxrwn+hVrdz0rokYc8ec9DYKYPipqaqLLO4jtsmkBCD1POPjf8l9xlt
         E1uA==
X-Gm-Message-State: AOAM531Wk6yXpdVmrCiCBdSkQaSgVGtgTvKCHxD9JLgcW/X/KkKVqakd
        7+SxZyGRVtpy5MbeC+r2azu5qKOS/KwNlFjmx0qmJFBmFqQ=
X-Google-Smtp-Source: ABdhPJwQW4I80c5GKw34EDMlTfnmXCA/e3KDPMWlG6cOLQLuPMZdJ5+VVZfO+wXPw0Lp+tbffX4d5aqJOyacF9xjEd0=
X-Received: by 2002:a19:7416:: with SMTP id v22mr9975999lfe.13.1621845235755;
 Mon, 24 May 2021 01:33:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210522163925.3757287-1-yhs@fb.com> <aae741ff-d609-5796-d860-d234884f5ea2@fb.com>
In-Reply-To: <aae741ff-d609-5796-d860-d234884f5ea2@fb.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Mon, 24 May 2021 09:33:44 +0100
Message-ID: <CACAyw9-G56AC5D_wqTi6wURk2BFrF-buuLS1S0F-ngDukb9qEQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] docs/bpf: add llvm_reloc.rst to explain llvm bpf relocations
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 22 May 2021 at 17:44, Yonghong Song <yhs@fb.com> wrote:
>
> Daniel, John and Lorenz,
>
> Could you help check how the new relocation scheme
> may impact you? libbpf has a similar issue and is fixed by
>    https://lore.kernel.org/bpf/20210522162341.3687617-1-yhs@fb.com/
> In most cases, you should just change relocation enum number,
> no relocation resolution is changed.
>
> Please let me know. Thanks!

Thank you for the heads up :) cilium/ebpf currently doesn't look at
relocation types at all for better or worse. We simply collect
"well-known" sections like maps, programs, etc. and only process
relocations for these. So your change won't break cilium/ebpf, but it
makes me wonder whether we should check the relocation type.

Best
Lorenz

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
