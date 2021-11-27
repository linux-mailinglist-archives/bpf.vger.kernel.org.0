Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A18045FB8C
	for <lists+bpf@lfdr.de>; Sat, 27 Nov 2021 02:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbhK0Bzw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Nov 2021 20:55:52 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:46484 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbhK0Bxv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Nov 2021 20:53:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3667660B50
        for <bpf@vger.kernel.org>; Sat, 27 Nov 2021 01:50:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E662C004E1
        for <bpf@vger.kernel.org>; Sat, 27 Nov 2021 01:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637977837;
        bh=EzxpS/69ex23EoS1UlroIlaVgObdcvhQKaHMHykQ6dI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kczy4F8wDThswjWk5gvszCVFPWK5N/yXqbXkODFiM9oJO/qN8+rCALSHZ0r/GxXXv
         0AQIWiF2ifVs5mPbMDbxQjhgCsG6HpIbB7gsop5sNGqkOXwjtXyoq4TV3ZR7jDYpcP
         CM7RaxyCD5MDSaO7dHu+vDrKKuGdQcq78f0MnQ+dYh4ETCXvXtAjFVD5lUjEW/1oLn
         R+MUBtSQJi9Eagunhjn1XXm8GlAnnLv5ji/tNcdPKpdG83V6REbY+O5KHE7NURF9ZH
         Qj+4GCFIKfff24lNgLiEaPt1iVGfepPUW9FATE4fSxa5DkQ52je6il8dzkp733qGua
         yUZcm6QBAldAA==
Received: by mail-yb1-f180.google.com with SMTP id e136so24465755ybc.4
        for <bpf@vger.kernel.org>; Fri, 26 Nov 2021 17:50:37 -0800 (PST)
X-Gm-Message-State: AOAM5302bjc+pJBXHxreoWCbbBqnNPpWkOFqLZIby8Gl7fDnyFMovCWY
        iWaf2vcNtB3Ej0oRHGFpLMtHVyxvHY2n6Sq5jBQ=
X-Google-Smtp-Source: ABdhPJxuFb07Alisrkoao6XyRafVK60lMgOI9EnSMPdjHLaIaNtx2ui37FHTfv359Zu/lqk5iw4Kpbf0NXKFclrS3is=
X-Received: by 2002:a25:bfca:: with SMTP id q10mr20190772ybm.68.1637977836764;
 Fri, 26 Nov 2021 17:50:36 -0800 (PST)
MIME-Version: 1.0
References: <20211122235733.634914-1-memxor@gmail.com> <20211122235733.634914-3-memxor@gmail.com>
In-Reply-To: <20211122235733.634914-3-memxor@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 26 Nov 2021 17:50:25 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5Eazo5M5e43gYdv7P2wrbbMjGPn46ShxkbxS9TdmriSA@mail.gmail.com>
Message-ID: <CAPhsuW5Eazo5M5e43gYdv7P2wrbbMjGPn46ShxkbxS9TdmriSA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/3] libbpf: Avoid double stores for
 success/failure case of ksym relocations
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 22, 2021 at 3:57 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Instead, jump directly to success case stores in case ret >= 0, else do
> the default 0 value store and jump over the success case. This is better
> in terms of readability. Readjust the code for kfunc relocation as well
> to follow a similar pattern, also leads to easier to follow code now.
>
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Acked-by: Song Liu <songliubraving@fb.com>
