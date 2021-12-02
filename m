Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5319B465B97
	for <lists+bpf@lfdr.de>; Thu,  2 Dec 2021 02:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343896AbhLBB2j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Dec 2021 20:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354286AbhLBB2i (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Dec 2021 20:28:38 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2A0C061574
        for <bpf@vger.kernel.org>; Wed,  1 Dec 2021 17:25:16 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id x32so68761279ybi.12
        for <bpf@vger.kernel.org>; Wed, 01 Dec 2021 17:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HMyzpbPsNiWYA/EBW9/7FeR8yspZbzYTF65AcecCEl0=;
        b=c6qPTIXOtWEkONIUJWkzGR9/F8f79uv/6GQIXkuTYvLAsEqgzD5SdZvSUlHWrkIOru
         abHN8S3fnhuxYtE+pH0Qh3zUK8slYt6m66cWoUfYJ4wm+AAkqxVcHb2Liip/aacKqwAy
         JiMVmzP2bg9RHPN02uVx8mf2YuYCvNdFIr9wRd9Jzvufq6/YmIlQwrQv2Z2rt9JkkbsX
         i2vaVW6YZGShaNn4rop4PWO3neckxvZ4MB14oi4Q/nfeGCmyWRsvNmccP+O/945k4INX
         RWwRk37uJx4a5bzAGvpe9D5XO6qHrLPij9NJ/lA+1nubNvjwQ8hxhD5UDJavipXjbL9C
         GB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HMyzpbPsNiWYA/EBW9/7FeR8yspZbzYTF65AcecCEl0=;
        b=xEriPg0JPQi6Wk/LKblTF6LT0grhpWROPwsA7VdJvI4OMJAa0bS7694x1neQ9Qk+Te
         Cu02s6jqNjn85UqYD1l8sY/wS5ZLmtKM9D+an37iL6qTo2J7OwJoKBzz3g1zAGNzKhl4
         ciPY24WKA7PL64LyE638sm1Wz42Ny4G+VXSkDqurlg2UftrS1MEmiW4s1BB6UwOFOC+O
         UgL7ULJF3MgRwopH5+eHJKJHynhxlB0I1zQdbu2a1RIKo/RZ1oT7cRdyhtKyycDF61SD
         PzT4LcihBLAI/Rr1hGTKpfDXK6QhQYeH4gbODcUqobimi4dYk9wPFvm7bS1tVIfNIn4D
         WV0w==
X-Gm-Message-State: AOAM530VSK7ODmfvqJ/pn72q/Zi8UxJILcfi+fx2bgpksaEVVny2KGGf
        w5S0wrC8Qb4ffbBI0ALMwr/XbEBLGkCw4W6nnXo=
X-Google-Smtp-Source: ABdhPJwToj3rFxsu7ZK0xHxueNs5mnp88rKDVRMtfQYvw33Nkb2Eca21rUD4wcz5SFHbGlNBlroKYI8npzslaJUYgDE=
X-Received: by 2002:a05:6902:1006:: with SMTP id w6mr12998794ybt.252.1638408316138;
 Wed, 01 Dec 2021 17:25:16 -0800 (PST)
MIME-Version: 1.0
References: <20211201181040.23337-1-alexei.starovoitov@gmail.com> <20211201181040.23337-9-alexei.starovoitov@gmail.com>
In-Reply-To: <20211201181040.23337-9-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 1 Dec 2021 17:25:05 -0800
Message-ID: <CAEf4Bza+HxbG5FTPOCCKWqF-OfuoF94YMZP9Rqyz+dML-NuzbQ@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 08/17] bpf: Add bpf_core_add_cands() and wire
 it into bpf_core_apply_relo_insn().
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 1, 2021 at 10:11 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Given BPF program's BTF root type name perform the following steps:
> . search in vmlinux candidate cache.
> . if (present in cache and candidate list >= 1) return candidate list.
> . do a linear search through kernel BTFs for possible candidates.
> . regardless of number of candidates found populate vmlinux cache.
> . if (candidate list >= 1) return candidate list.
> . search in module candidate cache.
> . if (present in cache) return candidate list (even if list is empty).
> . do a linear search through BTFs of all kernel modules
>   collecting candidates from all of them.
> . regardless of number of candidates found populate module cache.
> . return candidate list.
> Then wire the result into bpf_core_apply_relo_insn().
>
> When BPF program is trying to CO-RE relocate a type
> that doesn't exist in either vmlinux BTF or in modules BTFs
> these steps will perform 2 cache lookups when cache is hit.
>
> Note the cache doesn't prevent the abuse by the program that might
> have lots of relocations that cannot be resolved. Hence cond_resched().
>
> CO-RE in the kernel requires CAP_BPF, since BTF loading requires it.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Looks correct as far as I can tell.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  kernel/bpf/btf.c | 346 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 345 insertions(+), 1 deletion(-)
>

[...]
