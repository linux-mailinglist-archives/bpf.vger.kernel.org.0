Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50AD4413C8D
	for <lists+bpf@lfdr.de>; Tue, 21 Sep 2021 23:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235263AbhIUVgR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Sep 2021 17:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235457AbhIUVgQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Sep 2021 17:36:16 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC61C061574
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 14:34:47 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id f22so2323201qkm.5
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 14:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u2QmCRLlCudop2tt0V2Jd3SpsetYx3ib4Nkawx79DrA=;
        b=BQGU4Ia8unX/3qkM+YcGs2GCYpmpBT4irzFcnL9AxW480hK98LCB/wPJqXBYqlHIOL
         8dDcEqWOvNU0Y99u0mhqAbZuxaA+wIoR9c4YDaBo/sh9LUG5TUndj3TMxT+QnFWoqQMV
         LomQgO6sznVKsSGB2s3oc3Vt5ckWr5PgDbsZquLBLm2uxMJAxPsN0J2Xc4YyzRYy+rUV
         5DzKyJ/RqyLM5exyNxmBCSVQXp2WgtMAuSeOFm5LNwkpF1IPYZ+qpZdsiJu+Jv4uUMXw
         8wejSLwVyeJvPPiSYwDldzLeBh+HhJ19LFMtKPCw6EqXUymxyoHYyDFf+RAXRvubEZSF
         9gDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u2QmCRLlCudop2tt0V2Jd3SpsetYx3ib4Nkawx79DrA=;
        b=7Ig3Tj4EkzzM5W1A3PDFkGjWwlbXnYHmjCLdJDoaWTkWqfDtw6zTTn8PJXQyFX1UR/
         U890p0M2h3tY/UKMUHKhiVf90H5ixmeC6qb8JwrtVkTCcQ+OZ7mnez/TeqCrB5uTD3gu
         5UVRHENFlD3NONmCtgsO0g72SIUdxHRf8KR+igW26Llj/UNZK/RFPjbeQ5VGtvEDORoi
         nNZ2bK9qKPgGaWI9XbVmsl2/LbKzWVcD5YYxGkONRSd6WUr1CnQ6lt9/lgfSC+ZaHK8F
         XPVO11GzTUwx+yRqDH7Ua0XBLpV4T8Gbmc4SYmVJ81ugXNbqR+QlfTwJHrlRzuuQCMHO
         uMtg==
X-Gm-Message-State: AOAM5326W7uGBNxJTwXiOYvb+chl0FZzky5OOh9hPmBveO3hNRLznxO9
        srbIRmEsBAjqisSDOyXTwjES/GO1JVXs4byn/Rc=
X-Google-Smtp-Source: ABdhPJxtyTuXo9vO42Jt5sS7HrW4OQmEuJLoOqKuSdEwaGnf1JAhe61j7O492FQkKdOO7wH24otk/4B8X0kfopXidxk=
X-Received: by 2002:a05:6902:724:: with SMTP id l4mr37281197ybt.433.1632260086751;
 Tue, 21 Sep 2021 14:34:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210917215721.43491-1-alexei.starovoitov@gmail.com> <20210917215721.43491-5-alexei.starovoitov@gmail.com>
In-Reply-To: <20210917215721.43491-5-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 21 Sep 2021 14:34:35 -0700
Message-ID: <CAEf4BzYmayUDDkSoab-_A8c9Oo1OLX7KdqNQkfZz2Xsw_qLOEw@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 04/10] bpf: Add bpf_core_add_cands() and wire
 it into bpf_core_apply_relo_insn().
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        john fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>, mcroce@microsoft.com,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 17, 2021 at 2:57 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Given BPF program's BTF perform a linear search through kernel BTFs for
> a possible candidate.
> Then wire the result into bpf_core_apply_relo_insn().
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  kernel/bpf/btf.c | 149 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 147 insertions(+), 2 deletions(-)
>

[...]

> +       /* If candidate is not found in vmlinux's BTF then search in module's BTFs */
> +       spin_lock_bh(&btf_idr_lock);
> +       idr_for_each_entry(&btf_idr, mod_btf, id) {
> +               if (!btf_is_module(mod_btf))
> +                       continue;
> +               /* linear search could be slow hence unlock/lock
> +                * the IDR to avoiding holding it for too long
> +                */
> +               btf_get(mod_btf);
> +               spin_unlock_bh(&btf_idr_lock);
> +               err = bpf_core_add_cands(&local_cand, local_essent_len,
> +                                        mod_btf,
> +                                        btf_nr_types(main_btf),
> +                                        cands);
> +               if (err)
> +                       btf_put(mod_btf);
> +               goto err_out;

this couldn't have worked properly for modules, missing {} ?

> +               spin_lock_bh(&btf_idr_lock);
> +               btf_put(mod_btf);
> +       }
> +       spin_unlock_bh(&btf_idr_lock);
> +
> +       return cands;
> +err_out:
> +       bpf_core_free_cands(cands);
> +       return ERR_PTR(err);
> +}
> +

[...]
