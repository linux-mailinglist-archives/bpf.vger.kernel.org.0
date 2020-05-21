Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D2F1DD66C
	for <lists+bpf@lfdr.de>; Thu, 21 May 2020 20:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbgEUS67 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 May 2020 14:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729603AbgEUS67 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 May 2020 14:58:59 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECEDC061A0E
        for <bpf@vger.kernel.org>; Thu, 21 May 2020 11:58:59 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id a23so6401510qto.1
        for <bpf@vger.kernel.org>; Thu, 21 May 2020 11:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SkT32RVtASIP8CGRtZRQGHPZetvexkw0Tk4FcVWqhjg=;
        b=NLBndha66Sy1yrsslaj01OFsquN9NR9Sev1Ta0Rk/Hid8wn2NLGK11mLkL6bsP6ZqY
         zsrIgnAwcrCplfX1hLlydMpnDojF026r6/At060fM7HrWFKKQAkXXKJlI2waf9Cp/M8G
         PyZLilF3jsSjqFfOQ7rxsCCBemxXC8PQ1TyRxgnsEnWr1kBaEgoVrgFdq15zYDszxIXb
         JAve4oGyrD7BI6E2I0bYKl8qSkdtx7Qi58Hs5WBfTnOxRl94WchUFNZ37gVKkhvdOqPG
         FRczQXsXkXk0T3N3WMJfEQBjoYQpvWH0ziuCB92aeGLCFly2CnVM2TG4JksD6QgGRYqi
         kMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SkT32RVtASIP8CGRtZRQGHPZetvexkw0Tk4FcVWqhjg=;
        b=uPHyDhM0V/OOD8CYOOH3DcMlHtrgkjb1ipQb6PkzpKTU5BeCJevU9Oe+tQtpgE50nb
         UnmqSD5ObMuLUJKqXNbL7SzsZhPPZIGfZo79DerbYvOQlP4PyLGW4zpTHMVjsKPjBQsu
         hyerKJ7syYsjKaZw/pnKmlsAdAMi0p2GGdRqaHuzzALWQ3iBKE9eQGeXqKDPGaR7iivq
         xvJayOq5HOdnZhVPvUDrnsE0DDiZO8Z/UhzqwQ44BT8/F+f57YqFRzDFurc/j5UnqHAM
         nF4TF1C52RwaaJwzBAVeVSGNE/xA+jxbv9+p92MwPbrWLoZErvhXybDo1AGOu4YMmuFE
         0Jzg==
X-Gm-Message-State: AOAM53089i1bIiBSqWXLbXA+NTtlWW4OiiyNRdUHDvhfMeaPraO1inyk
        MlQYicX0DZlJ5S0uKnUHdKL/kLBTRFdpRygerIvNFEPw
X-Google-Smtp-Source: ABdhPJypriRPlj0CvQ6ikRZJeO6l4De45Vb/eg1K6EF8duX9O/XM5vOQ5sN4M0N5MKMyISo0vKdboclZMtDzmF8Fdkc=
X-Received: by 2002:ac8:3a42:: with SMTP id w60mr2170488qte.141.1590087538460;
 Thu, 21 May 2020 11:58:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAADnVQJwqH2XFnTeXLnqbONtaU3akNh9BZ-tXk8r=NcGGY_noQ@mail.gmail.com>
In-Reply-To: <CAADnVQJwqH2XFnTeXLnqbONtaU3akNh9BZ-tXk8r=NcGGY_noQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 21 May 2020 11:58:47 -0700
Message-ID: <CAEf4BzZVVgMbNE4d7b5kPUoWPJz-ENgyP1BfC+h-X29r1Pk2fA@mail.gmail.com>
Subject: Re: accessing global and per-cpu vars
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     haoluo@google.com, Andrii Nakryiko <andriin@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, olegrom@google.com,
        Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 21, 2020 at 10:07 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> Hi,
>
> here are my notes from the bpf office hours today.
> Does it sound as what we discussed?
>
> Steps to add incremental support to global vars:
> 1. teach libbpf to replace "ld_imm64 rX, foo" with absolute address
> of var "foo" by reading that value from kallsyms.
> From the verifier point of view ld_imm64 instruction will look like it's
> assigning large constant into a register.
> The bpf prog would need to use bpf_probe_read_kernel()
> to further access vars.

yep

>
> 2. teach pahole to store ' A ' annotated kallsyms into vmlinux BTF as
> BTF_KIND_VAR.
> There are ~300 of them, so should be minimal increase in size.

I thought we'd do that based on section name? Or we will actually
teach pahole to extract kallsyms from vmlinux image?

There was step 1.5 (or even 0.5) to see if it's feasible to add not
just per-CPU variables as well.

>
> 3. teach libbpf to scan vmlinux BTF for vars and replace "ld_imm64 rX, foo"
> with BPF_PSEUDO_BTF_ID.
> From the verifier point of view 'ld_imm64 rX, 123 // pseudo_btf_id'
> will be similar to ld_imm64 with pseudo_map_fd and pseudo_map_value.
> The verifier will check btf_id and replace that with actual kernel address
> at program load time. It will also know that exact type of 'rX' from there on.
> That gives big performance win since bpf prog will be able to use
> direct load instructions to access vars.

yep

>
> 4. add bpf_per_cpu(var, cpu) helper.
> It will accept 'var' in R1 and the verifier will enforce that R1 is
> PTR_TO_BTF_ID type
> and it's BTF_KIND_VAR and it's in per-cpu datasec.
> The return value from that helper will be normal PTR_TO_BTF_ID,
> so subsequent load instruction can use it directly.
> Would be nice to have this helper without BTF requirement,
> but I don't see how to make it safe without BTF at the moment.
> Similarly bpf_this_cpu_ptr(var) helper could be necessary or
> we may fold it into cpu == BPF_F_CURRENT_CPU as a single helper.

separate helper sounds better to me, both from usability stand point,
as well as not using extra register unnecessarily
