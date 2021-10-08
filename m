Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76CC3426F64
	for <lists+bpf@lfdr.de>; Fri,  8 Oct 2021 19:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbhJHRRm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 13:17:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:58962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229967AbhJHRRl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Oct 2021 13:17:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6BF0560F5D
        for <bpf@vger.kernel.org>; Fri,  8 Oct 2021 17:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633713346;
        bh=ZMuEv5tZYkfBLJgyNvxM2heDjoRFblwjpej95r9ttmk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=A8RrebesK4VPMH2pgUUIKdIbvcVYAde/UrcNxoIEVeEMMi468aesB5+0GE/BdVSoJ
         n6gOKVIxdO9nIFsxS2R+Q7LTdL9A2M05Dy0pBbHFessbfSxPlDv9PuyxDqNnCNXAt/
         7dFP4pQn68P3KyEURKszUl2jW+TH+aP97UkJYSKxJIafnL++tTtYdQYhSi9ODVv6i+
         JGLvPR7WQF5K8ZTyAIX8pUBYaEbmi/zMDJ9Apzqn9ZAfbe6/aDX9m4aOGQoneGNI0g
         aznLKcDIjrd7HU1QFIu59dG+DYyWuRZIyuRTw4szXV2Ck96oSC4gOSWUL+xZjoZguJ
         8IpWeWiHqlY2w==
Received: by mail-lf1-f52.google.com with SMTP id i24so40400171lfj.13
        for <bpf@vger.kernel.org>; Fri, 08 Oct 2021 10:15:46 -0700 (PDT)
X-Gm-Message-State: AOAM530Dy3OSbJMGjf78Er2BBeUd+yS64qyK7MJBj6i84Vci/6ilFa1b
        vtGpwHSU1xRj1QvDFvyz5ysfow34uY6HBhzdYPA=
X-Google-Smtp-Source: ABdhPJxLKrSDuGjvV7Y5NxU0w+cbenfVDX5IIZ1d/5sXhZeKu4BQyy/qvqzKFkmMLnQ6Cwim1NcGIjdIhZDvYv4pHwo=
X-Received: by 2002:ac2:41d4:: with SMTP id d20mr11777359lfi.598.1633713344735;
 Fri, 08 Oct 2021 10:15:44 -0700 (PDT)
MIME-Version: 1.0
References: <20211008000309.43274-1-andrii@kernel.org> <20211008000309.43274-7-andrii@kernel.org>
In-Reply-To: <20211008000309.43274-7-andrii@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Fri, 8 Oct 2021 10:15:33 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7eTu8VsxntNpoWa4UzMEk1oVCjEWEojQuLUp5-qLtqSQ@mail.gmail.com>
Message-ID: <CAPhsuW7eTu8VsxntNpoWa4UzMEk1oVCjEWEojQuLUp5-qLtqSQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 06/10] bpftool: improve skeleton generation for
 data maps without DATASEC type
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
> It can happen that some data sections (e.g., .rodata.cst16, containing
> compiler populated string constants) won't have a corresponding BTF
> DATASEC type. Now that libbpf supports .rodata.* and .data.* sections,
> situation like that will cause invalid BPF skeleton to be generated that
> won't compile successfully, as some parts of skeleton would assume
> memory-mapped struct definitions for each special data section.
>
> Fix this by generating empty struct definitions for such data sections.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Song Liu <songliubraving@fb.com>
