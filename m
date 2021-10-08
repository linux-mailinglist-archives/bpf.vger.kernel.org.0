Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A227426478
	for <lists+bpf@lfdr.de>; Fri,  8 Oct 2021 08:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbhJHGJE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 02:09:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:40478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229548AbhJHGJE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Oct 2021 02:09:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B46B960FC1
        for <bpf@vger.kernel.org>; Fri,  8 Oct 2021 06:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633673229;
        bh=Vwe0NwN30p4jbfZymjoouA3v+3K45ozydpdRy7xoidk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qTamDy7h4hnwYsbqKe7ZxvIZbmU2yGgSLeVwPDXi/w97JcikrS+aWuJzcvKF5MRXG
         TXzMNBrPMi+86iwjkpBmuvBPInEpSbPTziLxwhrNaOpiosV5spuljEqVtemEY0abs1
         VrRN7LfzM6bJRv780YZKJqod6xXde9SyAR1vgY70q/QwiUAfdVyuy6bzhNGileOnTd
         Vt3US8ua0zslW9VMXV0T2odZFNG3Nk/OGQqvFtSP6gVZV9amr/dCCMny4tlbF0Fc0G
         a7fuRHwuKHLwdjutcjU57HSaxpwSCsxGczsqbrrY4uLvJK9he1fVgMt76CzEKvs4nM
         Kpjj1aySTT1sQ==
Received: by mail-lf1-f52.google.com with SMTP id n8so32865768lfk.6
        for <bpf@vger.kernel.org>; Thu, 07 Oct 2021 23:07:09 -0700 (PDT)
X-Gm-Message-State: AOAM532zSxbNcdcd3kfjgNbt/zMQoKbhuexei85T7p+VZAMsd6l1QOfL
        07v0wUEwhEKTQa4nR6udvRwiMkom2jvwcdTUZjk=
X-Google-Smtp-Source: ABdhPJxqKw1prkolM3Kwo42GymsTAuruhaY13/BSRbSm4z/f00UFn3gA6ZJNQrnn4gD3MI7W8kvJCiahlw0so045W+s=
X-Received: by 2002:a2e:711d:: with SMTP id m29mr1470393ljc.299.1633673228097;
 Thu, 07 Oct 2021 23:07:08 -0700 (PDT)
MIME-Version: 1.0
References: <20211008000309.43274-1-andrii@kernel.org> <20211008000309.43274-3-andrii@kernel.org>
In-Reply-To: <20211008000309.43274-3-andrii@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Thu, 7 Oct 2021 23:06:57 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4Ep9KOqXNF8AL3M_MKfMepqrGVo=F5ekZ6_F3A9a7WhA@mail.gmail.com>
Message-ID: <CAPhsuW4Ep9KOqXNF8AL3M_MKfMepqrGVo=F5ekZ6_F3A9a7WhA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 02/10] libbpf: extract ELF processing state into
 separate struct
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 7, 2021 at 5:04 PM <andrii.nakryiko@gmail.com> wrote:
>
> From: Andrii Nakryiko <andrii@kernel.org>
>
> Name currently anonymous internal struct that keeps ELF-related state
> for bpf_object. Just a bit of clean up, no functional changes.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Song Liu <songliubraving@fb.com>
