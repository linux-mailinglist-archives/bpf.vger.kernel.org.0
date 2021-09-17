Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF5FA40F0EE
	for <lists+bpf@lfdr.de>; Fri, 17 Sep 2021 06:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbhIQEOT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Sep 2021 00:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244389AbhIQEOP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Sep 2021 00:14:15 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CC3C061574
        for <bpf@vger.kernel.org>; Thu, 16 Sep 2021 21:12:53 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id f3-20020a17090a638300b00199097ddf1aso9127078pjj.0
        for <bpf@vger.kernel.org>; Thu, 16 Sep 2021 21:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oWaYCxVsQMBBYFwpyw8SzO1m6IBjFiAWDFl87yK5rqg=;
        b=c86ywUUUyEWeBiE4OQ9egwKeVAaXUKJ7v3JfkMXHQB4f4kNB9sJwSoDIaQUKj7Kj6+
         /RBZYF1qGR+WP+vzy+K2mlIuWyOPx+gCA7tC+Odv4YxWgYOHfMbnCFEcc4VOXcLnESxO
         JM5hCEOd7vRzzonvQ6X0MXjSAph2fJ8rNz+g1FpdlSDJUWFLy0Tyt2mDj3TbQEUYWCpG
         c9IF5yb1MfWCqS2ilBpJTPMmO0kU8tAHA3Ql4FQAjpCQF3u0vgtjYDiyCGU2L2dQKMYc
         /UTjRFsxfFNuoGmXcM8JFETzOsi/hx1E86qxIa5FGIf8ne+LXs0jnIoatcDtl38jkTZU
         8Xww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oWaYCxVsQMBBYFwpyw8SzO1m6IBjFiAWDFl87yK5rqg=;
        b=ATD509zu39ycc+P2b1ZOAfiCJQc8e7xDF7VUhS2/d7Uu0gKzRP32DXptGaXJ52TK2w
         M6hlX0DHNdvk2AUnoI5jzH4iSy3YqEEVrTWCfv/B8b6+wGxT1kiL2yQav114mTa9pq+c
         d8Qh2kgx9bQ5va3Un50u63BrKt6yKoduoy/kcszkvBfNHuSFQoP8aFEoGZEOIInVVCct
         zUJt5iSl+NKXJJ1c1p3Oz+M8cBlgJs2ALTR3XiSVKDYXzOHUp6jG491FDeB6H/7+jhIz
         n6PcPRwXgDIpKnrWi5yVhttyboOjsHAanLvk6bPCR4+nK94UF7V+Qv+SZxSefAgun/iB
         HC6g==
X-Gm-Message-State: AOAM530f0zCJoddAHmZN7KpDtEoJDC1vSGuT2Y0oLf/NeWMPuuYZyEhd
        Eq5HFFBnCWLGePEt1jF8Ubv79U+hZEHQsebkGz4=
X-Google-Smtp-Source: ABdhPJzNXcAJ4c6ioelScu78h9AEhtzZkQl4gCsEUQQxXMEp4NITlBy6TnOn7qzsQOgxp/2Mmgq47Z1Vugjky241+QA=
X-Received: by 2002:a17:90a:1944:: with SMTP id 4mr8543468pjh.62.1631851972784;
 Thu, 16 Sep 2021 21:12:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210909133153.48994-1-mcroce@linux.microsoft.com>
 <20210909133153.48994-3-mcroce@linux.microsoft.com> <20210909182301.javodesbocpianzd@ast-mbp.dhcp.thefacebook.com>
 <CAFnufp3Gx11kknVZhZ+MxdpYJKg6awiCpssFoyUcyFrvQ8=eqw@mail.gmail.com>
In-Reply-To: <CAFnufp3Gx11kknVZhZ+MxdpYJKg6awiCpssFoyUcyFrvQ8=eqw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 16 Sep 2021 21:12:41 -0700
Message-ID: <CAADnVQ+j2zZecHSuc46HZ=wYmwqFEqDuO=xgfirguKKUWAJCBg@mail.gmail.com>
Subject: Re: [RFC bpf 2/2] btf: adapt relo_core for kernel compilation
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 16, 2021 at 6:22 PM Matteo Croce <mcroce@linux.microsoft.com> wrote:
>
> How can we share the helpers source too instead of duplicating it?

Ideally. Yes.
Andrii pointed out that libbpf's btf.h is installed,
so it's part of libbpf api.
Therefore it's safer to rename kernel helpers with equivalent meaning
instead of risking libbpf renames.

>
> Indeed, I found a small difference between the userspace and kernel code.
>
> In tools/lib/bpf/btf.h we have btf_is_mod() which returns true for
> { BTF_KIND_VOLATILE, BTF_KIND_CONST, BTF_KIND_RESTRICT },
> while in kernel/bpf/btf.c we have btf_type_is_modifier() which returns
> true also for BTF_KIND_TYPEDEF.
>
> Which is the right one?

btf_is_mod() is part of libbpf btf.h, so we cannot change it.
btf_type_is_modifier() is kernel internal helper.
It doesn't need to change and doesn't need to match.
The equivalent helpers are
skip_mods_and_typedefs() in the libbpf
and
btf_type_skip_modifiers() in the kernel.
In this case it's probably better to search-and-replace in libbpf.
In most other cases kernel search-and-replace will be necessary.
For example:
btf_type_vlen->btf_vlen
btf_type_member->btf_members
