Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D198C446EFE
	for <lists+bpf@lfdr.de>; Sat,  6 Nov 2021 17:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbhKFQkv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 6 Nov 2021 12:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbhKFQku (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 6 Nov 2021 12:40:50 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7875CC061570
        for <bpf@vger.kernel.org>; Sat,  6 Nov 2021 09:38:09 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id o6-20020a17090a0a0600b001a64b9a11aeso5576147pjo.3
        for <bpf@vger.kernel.org>; Sat, 06 Nov 2021 09:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CaGHul4eJPKtBsZJpeQuTBn4wYI9daTBcPk9Iz82f/U=;
        b=LJ/AMX88WfaAyH1tKVvD/Sn0mYYFi4LdakTRZ7G5cm3E2Bi4shsR/54WQan0q98A9j
         uJr6gipfSY84e1VWaig8lbc1mwpsWSFqwnp15+W3sny6/Do86kfCWCTqmeN7XugOF67S
         japK10f3ikt1dqyIK30vSd3aLAC1f6rpmJiNmCthU528QTTjdL9G953IuWop91o1983R
         CzT61mSRIT7BUKs2roJ4IZ/kzr0ZVDSbgXu2AbMm33PApAo9nN4JAlrEMPegJug9WZAh
         XCmgbf+MU9RTkzsF11zec3CaVQGUWbDexbhYu1xyAbaMyB2FfSQyrc2NGwfwyxCR6yVb
         0F2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CaGHul4eJPKtBsZJpeQuTBn4wYI9daTBcPk9Iz82f/U=;
        b=6q86mYoRpxDkyMmHzfFzvI7V6B+kzmxERgNNMh3e4RKXqRbOLR6tmKfUgFDCTWpHr0
         nJL53FHFx4xtYXWij8nag9K+tl2UOYQ28B6qCzYzViIOsJNI0ksjqpPJ/5B/CDenVbd0
         f0Jp/XxpEyy8fpUWSyDRSbGzSM2ePD3dILOK6TK6YZZeX9o+d+0NkQnpMEpEeC/e1nWI
         iGzP+AS7Pzg/dLgd/vPnl1TQdIbnU/+gHN1M6YJ2bkEAX3qQBurAB7oaQhpGC+EcwReQ
         h4El/e8GLoi5y82RQJ+yYq6OkMo6DD4q48emgKM8R0Oeok2ZTmEbhNjfUeN9i1YkYr34
         ZCcA==
X-Gm-Message-State: AOAM531eT6fzKvB/TMTS6RbWtuO0fizRgse4SWfIe2OarOZZUP2wOfXZ
        86LK2RS/f6ydN4Bu9dnXyzakpgjz/wZBTarLmyo=
X-Google-Smtp-Source: ABdhPJyPx9wo5X0uTR9JzarmjZZm0uEdwBc984UXagasYjng+SJv/LLvE6XX2xW4qDfY8G3CHbfaFPClICdfpeeFIQo=
X-Received: by 2002:a17:903:2306:b0:141:e52e:457d with SMTP id
 d6-20020a170903230600b00141e52e457dmr40712868plh.3.1636216688981; Sat, 06 Nov
 2021 09:38:08 -0700 (PDT)
MIME-Version: 1.0
References: <20211105191055.3324874-1-andrii@kernel.org>
In-Reply-To: <20211105191055.3324874-1-andrii@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sat, 6 Nov 2021 09:37:58 -0700
Message-ID: <CAADnVQJ6REFCJZYCLzk0NNqo5p9C5KpOmko9REaF1KYkBEaa9w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: fix non-C89 loop variable declaration in gen_loader.c
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 5, 2021 at 12:11 PM Andrii Nakryiko <andrii@kernel.org> wrote:
>
> Fix the `int i` declaration inside the for statement. This is non-C89
> compliant. See [0] for user report breaking BCC build.
>
>   [0] https://github.com/libbpf/libbpf/issues/403

I'd prefer to fix bcc and/or its derivatives instead.
It's year 2021.
