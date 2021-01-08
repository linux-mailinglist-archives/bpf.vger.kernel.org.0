Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCC92EFACB
	for <lists+bpf@lfdr.de>; Fri,  8 Jan 2021 22:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbhAHVzu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Jan 2021 16:55:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:32822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbhAHVzu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Jan 2021 16:55:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C7D123AC0
        for <bpf@vger.kernel.org>; Fri,  8 Jan 2021 21:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610142910;
        bh=Hk0CcdSqbF4KFVlSIMVJ6KCBS/vMpc81zH5BVzJpxB4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QGSQpqkln/7Rg6AhjY8YfQPWBqjdq80LLwmsWLPIkIjAX/aQprBqjQiRss59E3zPB
         906nIByV9eLFRNcz+PTpjYtuIgXfnd5a6FuqA4SMK3U0TsjqyVGwPICSPq/DwANYrb
         owUP+PrDiAq4KG4FMZ/tmcEr1EbNthJ9OkAFECFA0igEA0DGF/d2Gghlx5btcsJqDT
         zhm7Ur1ZllYtCH7rpGH8DraFgUa0QA+61yp5IWzgQhLcS1eiC4/U7+DwxKSHquXHzg
         wznWIEUMeb62ZFLZnPsbSfF9YokL4rzoY3eg6QhqHTEKKQNBDEr5oZgmkeGc7nTOC1
         oR79kxb8nCZPQ==
Received: by mail-lf1-f51.google.com with SMTP id m25so26317577lfc.11
        for <bpf@vger.kernel.org>; Fri, 08 Jan 2021 13:55:09 -0800 (PST)
X-Gm-Message-State: AOAM531eaNggcg61ur5r/noisE+3fdixu7raIiD9Mr455Un0a/gG99WK
        OmX74VIIdFYShDj6xS5mdRrpL2go9uEEqp7RIVKbwQ==
X-Google-Smtp-Source: ABdhPJxHeVaZsDHkpkEu6hFJwhbFcv8avKT4mhcAQSev5tIWjsHZ9IgmwDJ+7RoulRb5BCyekcuCBBLYlkzXAidWCOo=
X-Received: by 2002:a19:5ca:: with SMTP id 193mr2552974lff.375.1610142907841;
 Fri, 08 Jan 2021 13:55:07 -0800 (PST)
MIME-Version: 1.0
References: <20210107041801.2003241-1-songliubraving@fb.com> <20210107041801.2003241-3-songliubraving@fb.com>
In-Reply-To: <20210107041801.2003241-3-songliubraving@fb.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Fri, 8 Jan 2021 22:54:57 +0100
X-Gmail-Original-Message-ID: <CACYkzJ4pvmMLx9NG3c3PHiU_nyYZZDuFkTC48GDezPA3onJZJQ@mail.gmail.com>
Message-ID: <CACYkzJ4pvmMLx9NG3c3PHiU_nyYZZDuFkTC48GDezPA3onJZJQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/4] bpf: allow bpf_d_path in sleepable
 bpf_iter program
To:     Song Liu <songliubraving@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        linux-mm@kvack.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Kernel Team <kernel-team@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 7, 2021 at 5:23 AM Song Liu <songliubraving@fb.com> wrote:
>
> task_file and task_vma iter programs have access to file->f_path. Enable
> bpf_d_path to print paths of these file.
>
> bpf_iter programs are generally called in sleepable context. However, it
> is still necessary to diffientiate sleepable and non-sleepable bpf_iter
> programs: sleepable programs have access to bpf_d_path; non-sleepable
> programs have access to bpf_spin_lock.
>
> Acked-by: Yonghong Song <yhs@fb.com>
> Signed-off-by: Song Liu <songliubraving@fb.com>

Acked-by: KP Singh <kpsingh@kernel.org>
