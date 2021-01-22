Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3E47301010
	for <lists+bpf@lfdr.de>; Fri, 22 Jan 2021 23:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbhAVWej (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jan 2021 17:34:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:38214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729855AbhAVWeX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jan 2021 17:34:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB26023AA1
        for <bpf@vger.kernel.org>; Fri, 22 Jan 2021 22:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611354819;
        bh=uEpvD96tWcat/Dhjsboc8KcFrUlWjIqjdqBATng0ZIE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RM7lLLs2y2584/lY+Lax4ET+BNerAZIbGHcDDXPva3GHSdujnALdi+OzW1dWBMDJb
         cDHZcVWCJKHTFGQxNAH+BlKmiKjeRqcygCm1hDA2/XxeCmKWCkNUHo4sV5LZK+S2Il
         pYU7EulEbzP23v0NQVr4d3pTAURp1BnSKbNxs7D9r2qNeKzt9Hcbv5blNY4WG5uWW5
         GYl++TrzcD9tHBcIgUmNH3JRGH5lABbm1K6rXgLxXQohEeXGEpvVb7tqtPZkeNUgcd
         fjPnzjcLgV21LxW0hdCkGcR0DlLRwcufRBfQkXtwaz48oFRtPOBh0ddwRh5Mqyja6r
         I8VVHfR4dJp/Q==
Received: by mail-lj1-f178.google.com with SMTP id a25so7177562ljn.0
        for <bpf@vger.kernel.org>; Fri, 22 Jan 2021 14:33:38 -0800 (PST)
X-Gm-Message-State: AOAM532WtumrNt4UXvD1TwbPKo9cBilB95skHhMyk/t7puD3Z197EbT8
        /7sLqBIROcWp0Rh/CUu7FUvug9nCQEaKykdb8CyOZQ==
X-Google-Smtp-Source: ABdhPJwMj1N+Iqqglo06Li/iSweJcrBrd6oY1WBmInh5vbzzo0ZcaAODlHptVUHsj9RlFretP+NHltWh1ZQhtL/rakE=
X-Received: by 2002:a2e:2c11:: with SMTP id s17mr945935ljs.468.1611354816974;
 Fri, 22 Jan 2021 14:33:36 -0800 (PST)
MIME-Version: 1.0
References: <20210122123003.46125-1-mikko.ylinen@linux.intel.com>
In-Reply-To: <20210122123003.46125-1-mikko.ylinen@linux.intel.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Fri, 22 Jan 2021 23:33:26 +0100
X-Gmail-Original-Message-ID: <CACYkzJ6sMBvZ_ZG9++jwpQ+JQL3PL02okhD0O5Ftz4Hd7jEC3Q@mail.gmail.com>
Message-ID: <CACYkzJ6sMBvZ_ZG9++jwpQ+JQL3PL02okhD0O5Ftz4Hd7jEC3Q@mail.gmail.com>
Subject: Re: [PATCH] bpf: Drop disabled LSM hooks from the sleepable set
To:     Mikko Ylinen <mikko.ylinen@linux.intel.com>
Cc:     bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        KP Singh <kpsingh@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 22, 2021 at 1:32 PM Mikko Ylinen
<mikko.ylinen@linux.intel.com> wrote:
>
> Networking LSM hooks are conditionally enabled and when building the new
> sleepable BPF LSM hooks with the networking LSM hooks disabled, the
> following build error occurs:
>
> BTFIDS  vmlinux
> FAILED unresolved symbol bpf_lsm_socket_socketpair
>
> To fix the error, conditionally add the networking LSM hooks to the
> sleepable set.
>
> Fixes: 423f16108c9d8 ("bpf: Augment the set of sleepable LSM hooks")
> Signed-off-by: Mikko Ylinen <mikko.ylinen@linux.intel.com>

Thanks!

Acked-by: KP Singh <kpsingh@kernel.org>
