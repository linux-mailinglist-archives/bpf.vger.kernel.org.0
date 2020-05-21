Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C961DD3CA
	for <lists+bpf@lfdr.de>; Thu, 21 May 2020 19:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730226AbgEURDp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 May 2020 13:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729988AbgEURDo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 May 2020 13:03:44 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD928C061A0E
        for <bpf@vger.kernel.org>; Thu, 21 May 2020 10:03:43 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id r125so4837174lff.13
        for <bpf@vger.kernel.org>; Thu, 21 May 2020 10:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ew0kZUPk0BgP09EW/saWsne7B1PB0XlgOPX+v8mF828=;
        b=Q/QUHx2BsUdp4L4Num0cZqdUm9x9cZuKHcdDMEZulNkGYIY30ansF09oaqM0uZmKHa
         f+A3nX51k9m0tBJo2SVamyJEKmUDhrLv7zdpXuY4136zxCqzlMh0Ypkc9j5WASXjvkF7
         q/KaBBq83mwljVG14D/Bdm/T06e7UaaLINjnlNkgXRqbc4RuRNnJ9kliakyZHIj4QoUn
         ME2zP2b3vtWBdipM3qAQKZCXdrEF4AigEs3vBpP6EwDvWAMyTg658Cbn6elU3aPVwNRB
         8uQUEioIw5DRP9DDeRWQa3/0wVjQBfT0HbUyVdcg5S/6Y7EVaaT17XmZXOC++EGpNzzQ
         PR6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ew0kZUPk0BgP09EW/saWsne7B1PB0XlgOPX+v8mF828=;
        b=Kh4DmLNSMi/tJIIMmPeGYzjtPsEwcaq65n7/kiraogn43tDwJBDiisZVY3yP9DTJtI
         vul5Z6AXAiYEBs7FSB800y+hasRGVdVvYpsPg18Z3VGY57vWnKOmsIhWwckJIbnA5N4T
         MHXRVJkxUSCF1NfSUBAALdkSmW3ALY/U5ri6wCaBrVyIj+1AH/SINCWiKb1YF7BIt3yq
         xL0TbQ9xlp8K5ALa8rg5EOqzeV2uEINVHSas5OFhW/zwrGkCPr2LIC8+WthvE5BHLM3D
         huKyuYLyOVhGblEgDeMxbCpHnY6d2mh5cKjYUPIHue/DcHOhNK9a1wKWatiq8WFl+u2L
         DGIw==
X-Gm-Message-State: AOAM532zmEuXr8j5TLa5SonQpPHdKxaDBjpWRAKMbRhVeGOdl0eH4gBJ
        s+vt/GxoBGCw9ERSRX/IgNq7SJtQHrfUoZbl4qQ=
X-Google-Smtp-Source: ABdhPJy1QPlYRGepHUbC1KBIwi7C42dnCwOEqBFTvjNmSGIg5CXSLHSrkq9oZpq57edsp2fVChCEpZOd8dBS6OS2/yI=
X-Received: by 2002:a05:6512:6ce:: with SMTP id u14mr5434687lff.157.1590080622164;
 Thu, 21 May 2020 10:03:42 -0700 (PDT)
MIME-Version: 1.0
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 21 May 2020 10:03:30 -0700
Message-ID: <CAADnVQJwqH2XFnTeXLnqbONtaU3akNh9BZ-tXk8r=NcGGY_noQ@mail.gmail.com>
Subject: accessing global and per-cpu vars
To:     haoluo@google.com, Andrii Nakryiko <andriin@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, olegrom@google.com,
        Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

here are my notes from the bpf office hours today.
Does it sound as what we discussed?

Steps to add incremental support to global vars:
1. teach libbpf to replace "ld_imm64 rX, foo" with absolute address
of var "foo" by reading that value from kallsyms.
From the verifier point of view ld_imm64 instruction will look like it's
assigning large constant into a register.
The bpf prog would need to use bpf_probe_read_kernel()
to further access vars.

2. teach pahole to store ' A ' annotated kallsyms into vmlinux BTF as
BTF_KIND_VAR.
There are ~300 of them, so should be minimal increase in size.

3. teach libbpf to scan vmlinux BTF for vars and replace "ld_imm64 rX, foo"
with BPF_PSEUDO_BTF_ID.
From the verifier point of view 'ld_imm64 rX, 123 // pseudo_btf_id'
will be similar to ld_imm64 with pseudo_map_fd and pseudo_map_value.
The verifier will check btf_id and replace that with actual kernel address
at program load time. It will also know that exact type of 'rX' from there on.
That gives big performance win since bpf prog will be able to use
direct load instructions to access vars.

4. add bpf_per_cpu(var, cpu) helper.
It will accept 'var' in R1 and the verifier will enforce that R1 is
PTR_TO_BTF_ID type
and it's BTF_KIND_VAR and it's in per-cpu datasec.
The return value from that helper will be normal PTR_TO_BTF_ID,
so subsequent load instruction can use it directly.
Would be nice to have this helper without BTF requirement,
but I don't see how to make it safe without BTF at the moment.
Similarly bpf_this_cpu_ptr(var) helper could be necessary or
we may fold it into cpu == BPF_F_CURRENT_CPU as a single helper.
