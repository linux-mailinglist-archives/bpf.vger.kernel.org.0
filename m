Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C43353CB093
	for <lists+bpf@lfdr.de>; Fri, 16 Jul 2021 03:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbhGPByU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Jul 2021 21:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbhGPByT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Jul 2021 21:54:19 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B01C06175F
        for <bpf@vger.kernel.org>; Thu, 15 Jul 2021 18:51:24 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id q16so13347848lfa.5
        for <bpf@vger.kernel.org>; Thu, 15 Jul 2021 18:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hWCsW3gRHTktR8SbYQ9MH1bcIy0RPBNbJeb6suvazPY=;
        b=aNaa9SSnc48vWNR+2EC9k5Wc/52xTh8QIoPyg1fouLfZxWhbRSr3Sza+6VRnlXSdGw
         sjZF1rbNgmLUTfL1saYppkOuzSGO6jLEhjVMRiqS3ERdaLvjuD3weA+rRSndcgn1fHNL
         qbiZ8KJaiZUQsrYhCbV9CIFPmWC1bK/0mgPuEQybb99h88BvNw+QnR2U/T5F9mZByKEs
         y90OeBH7J4v74/mg7qQ5d7cgvnHeHMkoShrCwyvucYX4O7X23hBinmnBNBhh9vY2dgNP
         Rv1YTJC/xpkU6NVJihLj7S/XNLGc8NqvTzs+3lm8XIHvFR62FWfnFo/pGWaa58C+r/7k
         6QmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hWCsW3gRHTktR8SbYQ9MH1bcIy0RPBNbJeb6suvazPY=;
        b=I0TKPPD+eILpXgfM0Esw3Kh0PAo+r/3jNcqUI6KcAoaI+5JUlKP2q7K5D/ea6ZdcXD
         vpu/up6ZVO3KMcafoT+QPlzeB2ZZ+JGU/B/jC21Djacy1Nsjas8HbNe1adosccauZ8bV
         eJHJs4WTFHpma2yoTnS73iqh2lXRvuX5mDi9Ct8SKmZdLT9Ub4cChpPApGb4PZlxk8ej
         IMTCPynFyZQfYRq4BpQkpgKB/k0jUMQ1pL1hKkjKe1E//2yrX4yDsJlcgfnQMlTYtezQ
         N7UY1kbLXX5ltty5VbFeXzdDv9D5KKza4hmhYB4MF7UYc3mHJQTahwMdh3p7oIocfU7p
         OAtw==
X-Gm-Message-State: AOAM533cxz2uU4KuxfpasqTOZ9QGfIXNnpVfPgdaDWUJpoypdvEtWXdK
        g1PNCiAyATwqvDMdHzmxc3yFYBf5gQYS31K5uuo=
X-Google-Smtp-Source: ABdhPJzJu0qh5qE/ugMmA5DzykyJYbomR+Ysta8/StkW+j/Y5zfqxMEQHGPG4rIHhH1hws5QVQzjm3FiaK4KZwLUA2g=
X-Received: by 2002:a05:6512:3138:: with SMTP id p24mr5780017lfd.214.1626400282753;
 Thu, 15 Jul 2021 18:51:22 -0700 (PDT)
MIME-Version: 1.0
References: <aa97c776-9a82-9acc-fb13-dd082fdcaa61@gmail.com> <CAEf4BzaMcWGt+eqEqQdpJ_s5Zv80ziCA+vo5fa5HmaZmwBvh6A@mail.gmail.com>
In-Reply-To: <CAEf4BzaMcWGt+eqEqQdpJ_s5Zv80ziCA+vo5fa5HmaZmwBvh6A@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 15 Jul 2021 18:51:11 -0700
Message-ID: <CAADnVQKH2ViNN6QQJR3Fzo2+k+GmVu=nwAREPjuLZ6_HS8-XMg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] tools/lib/bpf: bpf_program__insns allow to
 retrieve insns in libbpf
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Lorenzo Fontana <fontanalorenz@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 15, 2021 at 2:40 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Jul 13, 2021 at 11:34 AM Lorenzo Fontana
> <fontanalorenz@gmail.com> wrote:
> >
> > This allows consumers of libbpf to iterate trough the insns
> > of a program without loading it first directly after the ELF parsing.
> >
> > Being able to do that is useful to create tooling that can show
> > the structure of a BPF program using libbpf without having to
> > parse the ELF separately.
> >
>
> So I wonder how useful is getting raw BPF instructions before libbpf
> processed them and resolved map references, subprogram calls, etc?
> You'll have lots of zeroes or meaningless constants in ldimm64
> instructions, etc. I always felt that being able to get instructions
> after libbpf processed them is more useful. The problem is that
> currently libbpf frees prog->insns after successful bpf_program__load.
> There is one extra (advanced) scenario where having those instructions
> preserved after load would be really nice -- cloning BPF program (I
> had use case for fentry/fexit). So the question is whether we should
> just leave those prog->insns around until the object is closed or not?
> And if we do, should bpftool dump instructions before or after load?
> Let's see what folks think.

Same here. I understand the desire, but the approach to expose half baked
instructions isn't addressing the need.
