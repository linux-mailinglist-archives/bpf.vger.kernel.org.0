Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 731ED2A9EF8
	for <lists+bpf@lfdr.de>; Fri,  6 Nov 2020 22:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbgKFVRF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Nov 2020 16:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbgKFVRF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Nov 2020 16:17:05 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3BAC0613CF;
        Fri,  6 Nov 2020 13:17:04 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id l2so3863692lfk.0;
        Fri, 06 Nov 2020 13:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WkGrV/BbVtUkmTGpKSoHOJ3tmEgalZorpuSoBRbJCuQ=;
        b=nfrOhidemVObwN1hMd9w38JhMRHc8c/4JsZZp0QYvmq/i7vBh1E/QTIFFjhzoaeHT8
         bKPeJhg/6NLRpqt7ZhZ33qia+f9BehobVXaSv14mkpQzTKHf4GNUiYlsa1cJ564gCLbu
         Ks562QH5mKAgM5+W23AfyCDMEHqs3ygmHLHBJ5ERKg5KggstXnUhdUH9haCpW/poqldw
         nb8g0/Em2TSunfPotj/4P96bQWMju2OVL8dtrnZMRY3zrFgoXp90m+a7HXYEqXoMra4Y
         LB8sqp1xS5N1zM5B5d3PzJSWu5NZ+V+v2ocjrF5mgBPq82Lj2XSMYYllnF5wb6xqfQ3a
         ELZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WkGrV/BbVtUkmTGpKSoHOJ3tmEgalZorpuSoBRbJCuQ=;
        b=cd4RjhNSVSgMNv+LAssc4MlqA1FGXBIRL+equQeR86UUj2nJwnW3QVRdn8hpD7lyyJ
         BTc44OntVn+1U/IcVjMfFATjvivSEr94ZmSgazNqU+KtfPZRf/RsNbgTqgF74Bm/gPZ8
         w69pHGvq5U6I488Tk9UQYFPma2gLj1GDyNbHPWe9aVCUXK/hSVsL98poWC/me1gr0w35
         Peqp9WOZ1JDVqFlHwmlhpKd7UOZr93SrjGChoQJQi8VAfHWcUQynrdJMybC/YWq+bxZS
         Abd/jQ/U/tvaOy/etuQPsTsJW/QEXWjrXjkktSrvkyPld9K8g9fbPdxPP7Vr2jGbWQ6h
         /AaA==
X-Gm-Message-State: AOAM5309F5qRKuspTzLtAjWqSGRMf84gMFcCumEUrOT22ocGTfrQdcOu
        xm2vevJQ6ls/dj41pJQ640qZlnGKbi4jvE5sOVl1l/H1
X-Google-Smtp-Source: ABdhPJyfVXD4ZNlc08tGDQHN9GdKpru9VbQBM0VrXDAAliNrmnbyv+4LpRsT5Yxl8VIbnGJ0B8sZZvtKrP24glAYnHo=
X-Received: by 2002:ac2:5f42:: with SMTP id 2mr1489911lfz.263.1604697423379;
 Fri, 06 Nov 2020 13:17:03 -0800 (PST)
MIME-Version: 1.0
References: <20201105230651.2621917-1-kpsingh@chromium.org>
In-Reply-To: <20201105230651.2621917-1-kpsingh@chromium.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 6 Nov 2020 13:16:52 -0800
Message-ID: <CAADnVQJzT_NxggEXpkno+raB2=3=bc7-ZmkR5-hB1dGkoPB_Vg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Update verification logic for LSM programs
To:     KP Singh <kpsingh@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 5, 2020 at 3:06 PM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> The current logic checks if the name of the BTF type passed in
> attach_btf_id starts with "bpf_lsm_", this is not sufficient as it also
> allows attachment to non-LSM hooks like the very function that performs
> this check, i.e. bpf_lsm_verify_prog.
>
> In order to ensure that this verification logic allows attachment to
> only LSM hooks, the LSM_HOOK definitions in lsm_hook_defs.h are used to
> generate a BTF_ID set. Upon verification, the attach_btf_id of the
> program being attached is checked for presence in this set.
>
> Signed-off-by: KP Singh <kpsingh@google.com>

I've added Fixes tag and applied to bpf tree.
