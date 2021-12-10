Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C991046FAC9
	for <lists+bpf@lfdr.de>; Fri, 10 Dec 2021 07:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbhLJGwC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Dec 2021 01:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234605AbhLJGwC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Dec 2021 01:52:02 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D72FC061746
        for <bpf@vger.kernel.org>; Thu,  9 Dec 2021 22:48:27 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id v203so19127936ybe.6
        for <bpf@vger.kernel.org>; Thu, 09 Dec 2021 22:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fdyNQRZ123yty6VFd0ljwzvm3l462AsKAATjawQEQ5I=;
        b=XUs8xQ5wN2cok4N8+RWLzUMZ1jdHhNCXFvVIUWSBGytdQn69zzGNEFsGzPd4yM179o
         mcHzBt1z+EMp4alzExbxYmewSyP9lIhh0/5u4ca81aTKxYwqDyMyOt7DqY4XhsTFaE1G
         FMpZPZGQL7Am00XA/si9xKq2vBOfKeftb2JQZ/jTBPLOPpcSso0vgOnkP2BLZkeDN80k
         38gHLXRN2CwV/SQvl3EvTlllv3RfHfwx5Tk3gEIbtDYKTMCbyK6S98iVAfPgu31qww9F
         rl/uqctgmhcwXQ33WqdsjwbtRE5n2IiVF/GFciAz8ELyT7J/qkuGIW1qiVuvhrDxuyaJ
         MwoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fdyNQRZ123yty6VFd0ljwzvm3l462AsKAATjawQEQ5I=;
        b=eLNRi0NQDIwHx5lr+TwojzRsGs8RAp1hnoFdbzXSUzNSw9SBuRol+Ctik+mM5yaxxS
         DArLXhc7kTDrzQGr/DedSmnSwBHlHRGGZzCS8smp8QGURDX37lLdOerfg3Vqps56yFYa
         JOFJCl36QVzANCZnhOrTiT8+shJyglnC9yi7AkcWGPnMhi1RcZi3Tw/vhcHy4S9u3nvc
         4pQF+i3xADLGTUjRSVOva0y+08/wHgd7EQa0gJWiKiHp71LP0VdLeeGJSwVfUulrXBs9
         G6igDISENrCHD6Q91/eGAIxUjLi+mGk7P6kDqHixBFAUPUS9JaWmMYf+eGhd7/0YMXAu
         +upA==
X-Gm-Message-State: AOAM530xVEFeluwqKSB7Rqf17QO1rGekrkSdVRRpC4Na5M9fZcOEdM7Y
        IzlAim7IlZWWpKhSCL8WILiSP0tNMV/7p5qsgtnLjIuhePBLNg==
X-Google-Smtp-Source: ABdhPJwLtGShnzw2uRdigNyHTbITsubmV01dl9BPehlYRzgWAUHVo93B1JSWpGu+Vg5Tg0Ap7lopALt0KXYyCsqwJZ0=
X-Received: by 2002:a25:4cc5:: with SMTP id z188mr12238316yba.248.1639118906658;
 Thu, 09 Dec 2021 22:48:26 -0800 (PST)
MIME-Version: 1.0
References: <20211210063112.80047-1-vincent@vincent-minet.net>
In-Reply-To: <20211210063112.80047-1-vincent@vincent-minet.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 9 Dec 2021 22:48:15 -0800
Message-ID: <CAEf4BzbRqsi_0fBYK2S-huurKic1X1hDcJYX=0sDCVpvp669gg@mail.gmail.com>
Subject: Re: [PATCH] libbpf: fix typo in btf__dedup@LIBBPF_0.0.2 definition
To:     Vincent Minet <vincent@vincent-minet.net>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 9, 2021 at 10:31 PM Vincent Minet <vincent@vincent-minet.net> wrote:
>
> The btf__dedup_deprecated name was misspelled in the definition of the
> compat symbol for btf__dedup. This leads it to be missing from the
> shared library.
>
> This fixes it.
>
> Signed-off-by: Vincent Minet <vincent@vincent-minet.net>
> ---
>  tools/lib/bpf/btf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index e171424192ae..9aa19c89f758 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -3107,7 +3107,7 @@ int btf__dedup_v0_6_0(struct btf *btf, const struct btf_dedup_opts *opts)
>         return libbpf_err(err);
>  }
>
> -COMPAT_VERSION(bpf__dedup_deprecated, btf__dedup, LIBBPF_0.0.2)
> +COMPAT_VERSION(btf__dedup_deprecated, btf__dedup, LIBBPF_0.0.2)

Took me a while to even see what changed, it's so subtle :( Thanks for
catching this!

How did you run into this problem? Are you using btf__dedup() for
something? Can you please share some details?

Added

Fixes: 957d350a8b94 ("libbpf: Turn btf_dedup_opts into OPTS-based struct")

and pushed to bpf-next, thanks!

>  int btf__dedup_deprecated(struct btf *btf, struct btf_ext *btf_ext, const void *unused_opts)
>  {
>         LIBBPF_OPTS(btf_dedup_opts, opts, .btf_ext = btf_ext);
> --
> 2.33.1
>
