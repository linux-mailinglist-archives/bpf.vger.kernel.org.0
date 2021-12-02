Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56439466DC0
	for <lists+bpf@lfdr.de>; Fri,  3 Dec 2021 00:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357831AbhLBXcb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Dec 2021 18:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356555AbhLBXca (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Dec 2021 18:32:30 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9941C06174A
        for <bpf@vger.kernel.org>; Thu,  2 Dec 2021 15:29:07 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 71so1276969pgb.4
        for <bpf@vger.kernel.org>; Thu, 02 Dec 2021 15:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xl0URjeRZCr8cruzb+51b8odvHZJRKehhoiv6w8TR6w=;
        b=hgFq8HPAxjpeC+pheXQMBNPh9u7q3vV51LCjsDBC3GnHAdN25dIAYpBJ8LLLAKpOl9
         /4WhZ75i3QIyDyPbeRWCvl+nVTGWxQqJePnv9kTHTuk/v3j/zKNkai/7U6vHzTtW0hQ1
         hc5gGXwhECPQBTJqiiy3kLFTw27zhvy9rccbBQR/G87q+vH5WtpGtrmJZ6zo+PIdfEX4
         4XO7rFlS+fpn34dRCjjbj1U2FxQHB/8k4Ex0xoSUKLd88xl2uF8qYxAemXnGL423aPey
         6ujRj7b2Mrx5tX58VqjPRjvjiueEpkzX73PGozXvS0Wuxm+gKy572Jo2HoSpwvUVO0a2
         310A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xl0URjeRZCr8cruzb+51b8odvHZJRKehhoiv6w8TR6w=;
        b=KQjguGiiI4OHvtA+s/RMmCEGvYnKzdekf4imGIXCl9MjV2VcznZQqJSFwjKk4r4Qfq
         5ZriY/+RAmNODvMaTk1Q852UFlXxfrPbIY8M2KkUNby28upqKUhg/IqxMeOHJI92+V1y
         ogMCRJr+UugDM7Oyuyn+xvgTi2+kHcnE4cZlWog2vnvwSH56A6FwejzP3Ykb8v41Jzid
         PFc//O8H9PRfFjt8B2Is6hlKA7CWv2dP1Y//i+BkA6be5OYOO2QPYwHhK2BA5BNGEjDG
         xAXwmknUhPRhNfUYXjzDi9LSO/FiUYvPkjzW9z5CECDLSsSuHG/N9C+ib30XCutIBTT+
         WlgQ==
X-Gm-Message-State: AOAM530G3UAj+FmqQ12eU8nogxwLKNkF3P7qTuqEmPCuLQdqaNHg8W1o
        nOj5kG8zGRM4mQMsQdItyxPfS/te5bTjeGG5G8ICoSNOp14=
X-Google-Smtp-Source: ABdhPJzhzQ8qvkgvHKHOHHL2d4v/O6Ui4l19RM/iEiI4wEPHwZGBQv4jA/y1ocC80renJpvETHEsYH19KARYwf1eG64=
X-Received: by 2002:a05:6a00:1583:b0:49f:dc1c:a0fe with SMTP id
 u3-20020a056a00158300b0049fdc1ca0femr15547261pfk.46.1638487747358; Thu, 02
 Dec 2021 15:29:07 -0800 (PST)
MIME-Version: 1.0
References: <20211201232824.3166325-1-andrii@kernel.org> <20211201232824.3166325-2-andrii@kernel.org>
In-Reply-To: <20211201232824.3166325-2-andrii@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 2 Dec 2021 15:28:56 -0800
Message-ID: <CAADnVQ+u12cF=8OnRkL3REsrusvf+XjOrEoUD78rDxJ3sJCeVg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/9] libbpf: use __u32 fields in bpf_map_create_opts
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 1, 2021 at 3:28 PM Andrii Nakryiko <andrii@kernel.org> wrote:
>
> Corresponding Linux UAPI struct uses __u32, not int, so keep it
> consistent.
>
> Fixes: 992c4225419a3 ("992c4225419a libbpf: Unify low-level map creation APIs w/ new bpf_map_create()")

That was not a correct tag.
It should have been:
Fixes: 992c4225419a ("libbpf: Unify low-level map creation APIs w/ new
bpf_map_create()")

I fixed it while applying.
I have the following in my .gitconfig
[core]
        abbrev = 12
[pretty]
        fixes = Fixes: %h (\"%s\")

and use it this way:
git log -1 --pretty=fixes sha
