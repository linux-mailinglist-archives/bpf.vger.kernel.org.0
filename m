Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C682648A22A
	for <lists+bpf@lfdr.de>; Mon, 10 Jan 2022 22:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244561AbiAJVwh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Jan 2022 16:52:37 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44270 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241465AbiAJVwh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Jan 2022 16:52:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D8300B8180E
        for <bpf@vger.kernel.org>; Mon, 10 Jan 2022 21:52:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1675C36AF4
        for <bpf@vger.kernel.org>; Mon, 10 Jan 2022 21:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641851550;
        bh=IMxkpo2WkVBDcJMl1/+rdaD8rw+g8IvPBclg7vp4uOM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PTrJ7KNRRd5VT0gAlGL8xOe6IjNPXsW+vUdgiVArAv06ByRUPFmclbSmmjRjG4fhk
         HwA8zvobWnjHQB2NFKS0Borww6hylkNuf6AFSI8ZoAW0qGqH2cxyYhC3G8w6u4zsLH
         qEIFy078loD9xSLoD8OMtG+JqRSFbdf+aqoRDQ+2brIkoCblohflI2+snpHLFzOy3b
         L2kCrZTfAPp9Dqdn+u5/1T/vBtYTB/QfsDIqpy1qVxOZLZInTwy1kiIjh6HmWyxc3a
         EjeC+uxpr383fdhCgmwiJc/Uj/teLDsweQIaLOZE548KY9X5yePXhN1SyIaxA7TLe5
         HK2hRtkL0qXqg==
Received: by mail-yb1-f175.google.com with SMTP id j83so41993007ybg.2
        for <bpf@vger.kernel.org>; Mon, 10 Jan 2022 13:52:30 -0800 (PST)
X-Gm-Message-State: AOAM530QFM93FD1PspZy9vT/5qvipIyKY1MUPepshPSaHwq/0BvdImx3
        FJmIdMKQQGce8ucgot0HfMS6cwWcb/CyNiUFUEo=
X-Google-Smtp-Source: ABdhPJySTgDyiG+REF5Was+jXfGH6D38Ny3k03FfV4JLRO5TpymLhTrSdv+9Jq9bTLQVae9NAntENmakroDwF9mp1lg=
X-Received: by 2002:a25:8d0d:: with SMTP id n13mr2349233ybl.208.1641851549683;
 Mon, 10 Jan 2022 13:52:29 -0800 (PST)
MIME-Version: 1.0
References: <202201060848.nagWejwv-lkp@intel.com> <20220108005854.658596-1-christylee@fb.com>
In-Reply-To: <20220108005854.658596-1-christylee@fb.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 10 Jan 2022 13:52:18 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5FQTLfs4P4GqMKxsakP82KuPGOrEcqX+zvAH1+VLf7aQ@mail.gmail.com>
Message-ID: <CAPhsuW5FQTLfs4P4GqMKxsakP82KuPGOrEcqX+zvAH1+VLf7aQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] Fix incorrect integer literal used for marking
 scratched registers in verifier logs
To:     Christy Lee <christylee@fb.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Alexei Starovoitov <ast@kernel.org>, kbuild-all@lists.01.org,
        kbuild@lists.01.org, Linux-MM <linux-mm@kvack.org>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
        christyc.y.lee@gmail.com, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 7, 2022 at 4:59 PM Christy Lee <christylee@fb.com> wrote:
>
> env->scratched_stack_slots is a 64-bit value, we should use ULL
> instead of UL literal values.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Christy Lee <christylee@fb.com>

The fix looks good to me. Thus:

Acked-by: Song Liu <songliubraving@fb.com>

However, the patch looks corrupted. Also, the subject is probably too
long (./scripts/checkpatch.pl should complain about it).

Thanks,
Song


> ---
>  kernel/bpf/verifier.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index bfb45381fb3f..a8587210907d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -616,7 +616,7 @@ static void mark_reg_scratched(struct bpf_verifier_env *env, u32 regno)
>
>  static void mark_stack_slot_scratched(struct bpf_verifier_env *env, u32 spi)
>  {
> -       env->scratched_stack_slots |= 1UL << spi;
> +       env->scratched_stack_slots |= 1ULL << spi;
>  }
>
>  static bool reg_scratched(const struct bpf_verifier_env *env, u32 regno)
> @@ -637,14 +637,14 @@ static bool verifier_state_scratched(const struct bpf_verifier_env *env)
>  static void mark_verifier_state_clean(struct bpf_verifier_env *env)
>  {
>         env->scratched_regs = 0U;
> -       env->scratched_stack_slots = 0UL;
> +       env->scratched_stack_slots = 0ULL;
>  }
>
>  /* Used for printing the entire verifier state. */
>  static void mark_verifier_state_scratched(struct bpf_verifier_env *env)
>  {
>         env->scratched_regs = ~0U;
> -       env->scratched_stack_slots = ~0UL;
> +       env->scratched_stack_slots = ~0ULL;
>  }
>
>  /* The reg state of a pointer or a bounded scalar was saved when
> --
> 2.30.2
>
