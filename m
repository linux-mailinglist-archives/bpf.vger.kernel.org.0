Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD3A415CDE
	for <lists+bpf@lfdr.de>; Thu, 23 Sep 2021 13:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240565AbhIWLfn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Sep 2021 07:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240596AbhIWLfm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Sep 2021 07:35:42 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3286C061574
        for <bpf@vger.kernel.org>; Thu, 23 Sep 2021 04:34:10 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id x27so25446369lfu.5
        for <bpf@vger.kernel.org>; Thu, 23 Sep 2021 04:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZrHIqupyja6BqfZOryNjnC3QTK4H8aRov/Xqv0jJTUE=;
        b=SwBh/Gga/YeBih7FlLDUG/VdCj+UKTFmdC2tZkCx4e5Xk0lW6wJl+1pn5GgoartB2u
         cCRYiOEb/01Bqv4nirWP+7nn1oa6en1WV0MNgLLgkNhLL2JhoXsvue/YZE5t7OSTO5k+
         4uEFESnfIIvEV9jLOmw1kFJ5BN3bCT2Ivj4so=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZrHIqupyja6BqfZOryNjnC3QTK4H8aRov/Xqv0jJTUE=;
        b=z9a6kBYMTqYTJo8LN87EhcCoOk3ScyAzctPwC7NNod2hpOI0ypz/82O9+cTsCe72uJ
         XPRE2UtejJlQncHrfMxhnZZJsEDP3WGruQy5NM4dxveWEPhHwxgK13kxLia9acMzqETz
         rvyn5NrMbkTkVlYqH6alJpHxhsWDxek9Q5nXAXEQB63zEoebSN8uAAVqI7URv3egROtx
         WuRkbn88ikL6rCf8MeKW6g+BgiRCqEg5WdQWV5kfX2oq/bA5IdPuvp+IQCaewHyqusUg
         OSY37dYc1PTyEB7AQ9MORu/dubwIn1hSN4L7WS+EcsKW03EHb6KTR79XO0O7FS7eeC67
         YALw==
X-Gm-Message-State: AOAM533PWQVuV0N/5UTh5mNv3yJFnY+DYv8zDIXlVV4qUjAJdsJ95B9H
        we56rqaNBLwVw1x3rZlLctwrwFCMeyMvYKWEyrEL3Q==
X-Google-Smtp-Source: ABdhPJyuorgeU0j3vGm/Nl5nphV0v8uJ7Xnrqoc77x8xCXB2hQvoNJjuTm+KzAoKT6rPSkTJCf2eAeLfSR5tJ7QJj4U=
X-Received: by 2002:a2e:8852:: with SMTP id z18mr4725644ljj.412.1632396849339;
 Thu, 23 Sep 2021 04:34:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210917215721.43491-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20210917215721.43491-1-alexei.starovoitov@gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Thu, 23 Sep 2021 12:33:58 +0100
Message-ID: <CACAyw98puHhO7f=OmEACNaje0DvVdpS7FosLY9aM8z46hy=7ww@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 00/10] bpf: CO-RE support in the kernel.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        mcroce@microsoft.com, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 17 Sept 2021 at 22:57, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Hi All,
>
> This is very early RFC that introduces CO-RE support in the kernel.
> There are several reasons to add such support:
> 1. It's a step toward signed BPF programs.
> 2. It allows golang like languages that struggle to adopt libbpf
>    to take advantage of CO-RE powers.
> 3. Currently the field accessed by 'ldx [R1 + 10]' insn is recognized
>    by the verifier purely based on +10 offset. If R1 points to a union
>    the verifier picks one of the fields at this offset.
>    With CO-RE the kernel can disambiguate the field access.
>
> This set wires all relevant pieces and passes two selftests with CO-RE
> in the kernel.
>
> The main goal of RFC is to get feedback on patch 3.
> It's passing CO-RE relocation into the kernel via bpf_core_apply_relo()
> helper that is called by the loader program.
> It works, but there is no clean way to add error reporting here.
> So I'm thinking that the better approach would be to pass an array
> of 'struct bpf_core_relo_desc' into PROG_LOAD command similar to
> how func_info and line_info are passed.
> Such approach would allow for the use case 3 above (which
> current approach in patch 3 doesn't support).

+1 to having good error reporting, it's hard to debug CO-RE failures
as they are. PROG_LOAD seems nice, provided that relocation happens
before verification.

Some questions:
* How can this handle kernels that don't have built-in BTF? Not a
problem for myself, but some people have to deal with BTF-less distro
kernels by using pahole to generate external BTF from debug symbols.
Can we accommodate that?
* Does in-kernel CO-RE need to account for packed structs w/ bitfields
in them? If relocation happens after verification this could be a
problem: [1].
* Tangent: libbpf CO-RE has this res->validate flag, which turns off
some checks for bitfields. I've never fully understood why that is,
maybe Andrii can explain it?

Lorenz

1: https://lore.kernel.org/bpf/CACAyw9_R4_ib0KvcuQC4nSOy5+Hn8-Xq-G8geDdLsNztX=0Fsw@mail.gmail.com/

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
