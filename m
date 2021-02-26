Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53CB432698F
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 22:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhBZVag (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Feb 2021 16:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbhBZVad (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Feb 2021 16:30:33 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F23C06174A
        for <bpf@vger.kernel.org>; Fri, 26 Feb 2021 13:29:52 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id e2so5052737ljo.7
        for <bpf@vger.kernel.org>; Fri, 26 Feb 2021 13:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5WySLb0xHZAtS0rVSIBns7cIKZeKtQYVj2GY7nDu7AU=;
        b=fStmHG1O2rbmCMZELSKbQDs5qAXGkMDnYmJRfXHsFTNJ8JomNURin1HlfPC8QI9g2f
         amt9dW70PaFLx+kfM/AdOjm8/DlJ5aq/G69tGQhu7/M7JY8A3iIi+yKxwsbLA2tOisa1
         0xfylvPu7VFtqu1HlZrNII6iN0+mtXNMiXsNonL+tT0gs01Z6zAIbXUwxgcBm38rZmTk
         fY5XATjzhHh8Yo9Q3B+smrjbyJCwfU1Jk6/3WLF/dCs5JNZz4z0T9KJqJSSxP8fgJSf7
         k+ziBJIlKtgE9B5kQVE2He/DXMkVMw7YZO/Y2ERb3KdW7iMsdl6tOxNksdCuHbakEpVS
         1kJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5WySLb0xHZAtS0rVSIBns7cIKZeKtQYVj2GY7nDu7AU=;
        b=T6dIewpPvAnblnkX6yLRrYNK33cziHN0T9oPK3ZpT03EgBriuf7Sn7sK/eqdEtSLNs
         wPsCzHR1ceS9mbOHij2rGDWyCh/l6dZD2+aOa2Wi13BheQbXLeO4mWGv0/AWqL7XIpC4
         NJExjdWEbzlObjTO1opfdoksvoRHEnGxbrTE42hLK3EB/1zUIEIri+UX4e9BJSYZq3Ag
         VG1nUtAMGrhWwn7WHvA4wdfXR+MrVzlpm8AP8BYY6Hjbt+CsZcznSyKLrKVse1bm+lzs
         7H6Qj2REy/aJdObR6QVP7IJiTxcA+cP0w6HmeivVemNvDIxUBE1Z4uGSelw0lae+tQPi
         EUMg==
X-Gm-Message-State: AOAM531K346gq2l0g6fGOOADK11q2CBLtHBEdZtD0bFTV8FJp8UsI8yZ
        WQGh5aNSpY9SW+GMN3mP+4enDZflpEa4BOQbx+I=
X-Google-Smtp-Source: ABdhPJzTzLmdt/+bvUpU/rIZqjyUM4k3BNTYY7c6xCe58EWaHiMmXpQq9x/UFVq6r2dDAkHfFK56AiLiwefFVpFRjFM=
X-Received: by 2002:a2e:964e:: with SMTP id z14mr2792131ljh.204.1614374991345;
 Fri, 26 Feb 2021 13:29:51 -0800 (PST)
MIME-Version: 1.0
References: <20210226204920.3884074-1-yhs@fb.com> <20210226204925.3884923-1-yhs@fb.com>
In-Reply-To: <20210226204925.3884923-1-yhs@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 26 Feb 2021 13:29:40 -0800
Message-ID: <CAADnVQ+WuEpDBeZw48uiDbJS26hZGaaoQ9wRM-0tpNeohP6Vpw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 05/12] bpf: add bpf_for_each_map_elem() helper
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 26, 2021 at 12:49 PM Yonghong Song <yhs@fb.com> wrote:
> + *
> + *             The following are a list of supported map types and their
> + *             respective expected callback signatures:
> + *
> + *             BPF_MAP_TYPE_HASH, BPF_MAP_TYPE_PERCPU_HASH,
> + *             BPF_MAP_TYPE_LRU_HASH, BPF_MAP_TYPE_LRU_PERCPU_HASH,
> + *             BPF_MAP_TYPE_ARRAY, BPF_MAP_TYPE_PERCPU_ARRAY:
> + *                 long (*callback_fn)(struct bpf_map *map, const void *key,
> + *                                     void *value, void *ctx);

This part was causing errors and warnings in bpf-helpers.rst.
I fixed it up while applying.

Thanks a lot for the great work! Really exciting feature!
