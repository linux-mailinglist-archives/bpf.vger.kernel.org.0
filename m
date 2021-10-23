Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5524A4380DC
	for <lists+bpf@lfdr.de>; Sat, 23 Oct 2021 02:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbhJWAIK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Oct 2021 20:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbhJWAIK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Oct 2021 20:08:10 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32016C061764
        for <bpf@vger.kernel.org>; Fri, 22 Oct 2021 17:05:52 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id f4so1096529plt.3
        for <bpf@vger.kernel.org>; Fri, 22 Oct 2021 17:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1wnukwjfP6JMtc7TdzxD35Z+rxMuu+2nDn1OW4p/lsY=;
        b=UYe9ivjJ2GfQ/BARflw5JZfaEMJAAOppK5UE2RCrV1ktL0eIuflqSiQFlR92m8Ve8e
         HyFmVEuFP8etuw3SsBPNWYOKmfvHzKIT2pSPBXcxiRvO/KAnKVOeT0LxJc/qFKyRWcRU
         YYgS+y45YICNW5P6EhFs17+OugRsN0smDJpOm97M2S/I7II+kLm17AqpYBSso669AH47
         LaiMOtKhOuxoMz/X1VCPKdW8e5szI7B5DddJ9xkhMIPYYdfrbCdIH4/O5tVlIM2wre0a
         be5lBHDGWjP1fyGgYNZs8+8qWtjDAdBFdvyJXgZVU9xcLDI7TFpOFwNnugwIcs8+Qjq5
         fSkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1wnukwjfP6JMtc7TdzxD35Z+rxMuu+2nDn1OW4p/lsY=;
        b=GPGKns31+pdxMNbujK+srF6iGcX9n+cydQysInnCsr+tABkFE9aBOS0+bb3V5pdKcE
         kQS7R8x4JMPH+qf/HONm3pc2W3xu/4X/LZhABKEtf/rkxjp2J21wMNit8AyYNM0s7sjU
         UhuaC80cg7uQfboXwOoQkuwP4vdm39SlRWUfK4ZrePu1OybFC1xeW06Klm/YtE/OpDDf
         1KX8VhjAcQ/cOM08qOpyofv06Q+ZsuljPNZNk4kY+S6bYVsNnG4BDjHYe8ayk4sK37Kg
         jgcDtGROrMnqh1Hm6dFPaag9tlUlK6SNO2NlDhyGuePtaF0Dh0XmiETFiOXDN3aT2sBX
         xFhg==
X-Gm-Message-State: AOAM533ioHV149DNNHfZUSfixweDLME8x3XhxdxLV2hLjjHVEcYOZNsH
        Dt4eJJJs39DX9n57uy1Ss34Ygli8sBRRqPQDBcQ=
X-Google-Smtp-Source: ABdhPJyFVYS2Xmk6d1fbaAQ2LfHjmotWHF53CrrxHq5LeoRNJUjFdX/NNUzNvVqIVlJvdSm+L/MRANg70jbJlG3F3Xo=
X-Received: by 2002:a17:902:7246:b0:138:a6ed:66cc with SMTP id
 c6-20020a170902724600b00138a6ed66ccmr2921990pll.22.1634947551559; Fri, 22 Oct
 2021 17:05:51 -0700 (PDT)
MIME-Version: 1.0
References: <20211021195622.4018339-1-yhs@fb.com>
In-Reply-To: <20211021195622.4018339-1-yhs@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 22 Oct 2021 17:05:40 -0700
Message-ID: <CAADnVQJd7F+9RiONS8Lo_QFkh2Ck7BeGVNAvAopmBMsDeTmEwQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/5] bpf: add support for BTF_KIND_DECL_TAG typedef
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 21, 2021 at 12:56 PM Yonghong Song <yhs@fb.com> wrote:
>
> Latest upstream llvm-project added support for btf_decl_tag attributes
> for typedef declarations ([1], [2]). Similar to other btf_decl_tag cases,
> func/func_param/global_var/struct/union/field, btf_decl_tag with typedef
> declaration can carry information from kernel source to clang compiler
> and then to dwarf/BTF, for bpf verification or other use cases.
>
> This patch set added kernel support for BTF_KIND_DECL_TAG to typedef
> declaration (Patch 1). Additional selftests are added to cover
> unit testing, dedup, or bpf program usage of btf_decl_tag with typedef.
> (Patches 2, 3 and 4). The btf documentation is updated to include
> BTF_KIND_DECL_TAG typedef (Patch 5).
>
>   [1] https://reviews.llvm.org/D110127
>   [2] https://reviews.llvm.org/D112259

Applied. Thanks
