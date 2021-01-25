Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE2530295D
	for <lists+bpf@lfdr.de>; Mon, 25 Jan 2021 18:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731289AbhAYRyY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Jan 2021 12:54:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:40084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731185AbhAYRxt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Jan 2021 12:53:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A75422583
        for <bpf@vger.kernel.org>; Mon, 25 Jan 2021 17:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611596727;
        bh=myD5RTOQTdAr23NbC1OH5P/i8LKkC7Cr6EEuikK6Z0o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KIl7Cq9B7m2TcFI2dhRj2UKHMP9GIPDZcWMPbVjOKsTKZiS3wO+mTvbgX8nosj9Wd
         c/Ta11U5ANIu5l52dzaNgvzHFz4NabQoJ9G2onDiNAmgQNzkJQyR7BOTr0wNinhJl7
         O5i7Gif6WGBG/I8CSkSAOlpHb7Uyz7aD2FXvuTUbXS7yQVCF3Euuwmug9T7DiHbpGo
         XX+TcSz3OS72odQlLrPsgfkGOtSNG1gt1tTY3BXUEQckARl74+2fDknTuxwB/qiAkd
         SlnY10PyguCJu3Us9XSOa0sWsY9TACTA3PCLRGGiPnJ47SfGZL66CFdc6GNvp5d9XX
         4ve26sdRbYsSw==
Received: by mail-lf1-f49.google.com with SMTP id o10so18990976lfl.13
        for <bpf@vger.kernel.org>; Mon, 25 Jan 2021 09:45:27 -0800 (PST)
X-Gm-Message-State: AOAM5316IqlZrcnS4I4xxPl7t3nWZ4AfOH5WNau2uPkUa/Fm35Did8nc
        R48oeYN7Gc7RD1myjUCy+i9zCgDwfgm74qahslNmrQ==
X-Google-Smtp-Source: ABdhPJz15eO+UVnMY3v5jjV58H+Z0oDwDj2CMx13QiBnNiaU4NpqSEPz6pW7IqWl7i3RZt0vzOF+XDpYU8VftAcBPwg=
X-Received: by 2002:a19:3fd3:: with SMTP id m202mr768171lfa.550.1611596725562;
 Mon, 25 Jan 2021 09:45:25 -0800 (PST)
MIME-Version: 1.0
References: <CACYkzJ5i6DNxY3D3SqiO_LO2HBbA-EgPFdK8ZBcFNmTVWweucg@mail.gmail.com>
 <20210125063936.89365-1-mikko.ylinen@linux.intel.com>
In-Reply-To: <20210125063936.89365-1-mikko.ylinen@linux.intel.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Mon, 25 Jan 2021 18:45:14 +0100
X-Gmail-Original-Message-ID: <CACYkzJ7G0Bt=25sm5pTzYOb=0hbi-3AtkUitpF6bjXryQs=f5g@mail.gmail.com>
Message-ID: <CACYkzJ7G0Bt=25sm5pTzYOb=0hbi-3AtkUitpF6bjXryQs=f5g@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: Drop disabled LSM hooks from the sleepable set
To:     Mikko Ylinen <mikko.ylinen@linux.intel.com>
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@google.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 25, 2021 at 7:39 AM Mikko Ylinen
<mikko.ylinen@linux.intel.com> wrote:
>
> Some networking and keys LSM hooks are conditionally enabled
> and when building the new sleepable BPF LSM hooks with those
> LSM hooks disabled, the following build error occurs:
>
> BTFIDS  vmlinux
> FAILED unresolved symbol bpf_lsm_socket_socketpair
>
> To fix the error, conditionally add the relevant networking/keys
> LSM hooks to the sleepable set.
>
> Fixes: 423f16108c9d8 ("bpf: Augment the set of sleepable LSM hooks")
> Signed-off-by: Mikko Ylinen <mikko.ylinen@linux.intel.com>

Acked-by: KP Singh <kpsingh@kernel.org>
