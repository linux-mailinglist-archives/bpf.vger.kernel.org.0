Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A59E32C495E
	for <lists+bpf@lfdr.de>; Wed, 25 Nov 2020 21:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731077AbgKYUxb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Nov 2020 15:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730178AbgKYUxb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Nov 2020 15:53:31 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADEDC0613D4
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2020 12:53:30 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id t6so4979575lfl.13
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2020 12:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WRHUas+qqlE3yKLxY6WdUMf+VH6XociCkccVND7X7oU=;
        b=ahrR9YDO70cAP1Gzh4bLmHIWwKmE7J2khaRypnVZ27l5n+ZVCZn1pmx+ku0leJIUyq
         1e1HCNZTWjoVYJCN76aPEYRdHStEN+PVjpt7DdMpyho7JiYdsjsbgquhPpN4QcLYYHaI
         bzQCuaH6iIk09ZyjJai19fQXXlOlxcHzOu/6v/6ddlywiNIMq4SIW7yKQQafV/U85bJV
         XO3zUtuEyTS6akUbKPCh5Q3/Bv0fmooVGLXe4LY26J+MQDJv/T0EMDqht20ywU5zQ5Z1
         ih9WbJGLFs96dxH92Fv2FPVylfV9iXKhDflqADMAEQrZWlxJtkkKAYepVHXS9DO+rj9T
         FV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WRHUas+qqlE3yKLxY6WdUMf+VH6XociCkccVND7X7oU=;
        b=oKWu0ZQhY9zx64DnOuchqcZkuF5ly7X4UrFPDc2UWyCviwtU9X8N7HG5xBMxCkISgg
         c785LWwXEyh0rfINgNk+ltOmiLgrSFrjuZWGwv+CqzYIHTdpbIPOiC+ItRsCv39okpXW
         cPEnQM0C0J4P7aENu4DXGN7GDtgSyv+09q3wkUGTMjDCaYbVYIwy7usL3X1GVfhyHdcD
         RuHX4KitGIjI9nq57QdruAH43WoOJM+lz4P1g7zJYqVykkwFfnfQnmADzsnNFGGHPxoi
         FW49iaxJOloeJhOlpuiviGrH2Gu+AUi7W5Wg4ND8wkxn78VcIZWOJbcw1lg+PY754xNA
         NpGA==
X-Gm-Message-State: AOAM5326e4LWckI1TOVQpaX0EE972136vOhAx2yj2fgXnA4yTYgEPmeB
        fb/PQrngyAFn/57Oz8+u+j3LfoK44/Bq8QZUpMw=
X-Google-Smtp-Source: ABdhPJxqHZGe5FyMxycIom3zwcgAzrI0z4+hYBf8fIUI75c9wESZzuGTBl222c39S7dBMjuanRhj2X1e9w9Y/ZWt7bY=
X-Received: by 2002:a19:4194:: with SMTP id o142mr19449lfa.196.1606337609143;
 Wed, 25 Nov 2020 12:53:29 -0800 (PST)
MIME-Version: 1.0
References: <20201125202404.1419509-1-kpsingh@chromium.org>
In-Reply-To: <20201125202404.1419509-1-kpsingh@chromium.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 25 Nov 2020 12:53:17 -0800
Message-ID: <CAADnVQLrXjitW30nCq0N9+Tt_XzOkP5g0AcGp+wdQ0hyKiXCfQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Add MAINTAINERS entry for BPF LSM
To:     KP Singh <kpsingh@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 25, 2020 at 12:24 PM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> Similar to XDP and some JITs, also added Brendan and Florent who have
> been reviewing all my patches internally as reviewers. The patches are
> still expected to go via the BPF tree / list / merge workflows.
>
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---
>  MAINTAINERS | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index af9f6a3ab100..09c902bee5d2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3366,6 +3366,17 @@ S:       Supported
>  F:     arch/x86/net/
>  X:     arch/x86/net/bpf_jit_comp32.c
>
> +BPF LSM (Security Audit and Enforcement using eBPF)
> +M:     KP Singh <kpsingh@chromium.org>
> +R:     Florent Revest <revest@chromium.org>
> +R:     Brendan Jackman <jackmanb@chromium.org>
> +L:     bpf@vger.kernel.org
> +S:     Maintained
> +F:     Documentation/bpf/bpf_lsm.rst
> +F:     include/linux/bpf_lsm.h
> +F:     kernel/bpf/bpf_lsm.c
> +F:     security/bpf/

I'm not sure what's the value of the additional entry.
bpf has many different components. This is just one of them.
Your maintainer of bpf_lsm responsibilities stay the same
regardless of the entry in the file.
