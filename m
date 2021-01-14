Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5232F6DAC
	for <lists+bpf@lfdr.de>; Thu, 14 Jan 2021 23:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbhANWGd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jan 2021 17:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbhANWGd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jan 2021 17:06:33 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5560C061575
        for <bpf@vger.kernel.org>; Thu, 14 Jan 2021 14:05:52 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id b8so3641285plx.0
        for <bpf@vger.kernel.org>; Thu, 14 Jan 2021 14:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wUgYvY8oKdE3vIqZqcGoJhcy0h+YbWsnar8Vy45H+Zw=;
        b=Rd9jHYrSVUXCUh5LBL4lAM8F8G8OgyipJPKll16dm2Nq6G7LwGn88bawjaXil2i5kE
         X1pd4CoND9ovjDGpCGRcVDRv7vZftTtRFH4sVqxN5LVwKye4+EaAsQei8baaweCD/vFW
         wZXWCB1lXDPn0KTDSGnFwUIdecbEauhaZcviOoJ1UcrqWL1/nJlKNc6ThmYejFQl8vm6
         EDl2QjvOBqiVr3FBF1t2ZcCNs6RbxWuWLCH4rXMDe6WWC31uRjc+28QaJOUFPHcFq40y
         /yeVMnbeaU7uWN4k7oYO4zXD1Pn6fFZEUZYuKsR0cYHsxyDOrDt9tue29Z0t0IKx+xoz
         5ygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wUgYvY8oKdE3vIqZqcGoJhcy0h+YbWsnar8Vy45H+Zw=;
        b=HVXFLdKIvG4AX8txtkylwKAC7YVsiY18LHZqLbgyrdb4LMN8cdZhWJQ2u8BS/EAuRp
         76MXFQJTLWh2M8J8HI+gjeDbsi4SGR3pomSq/BWUD2e0Dl7cf+94Fg81pqfLcJ03wk27
         rYDkyLAW9V4GNq08VI58L9H8BZV6JibsVP+xNYlH8PlfR7Paq3SLePtfR6JnChTEmUO6
         cfOtBn5RgALbpb572OAqQ5Laqqx1L7Fhi21jh9DMsohtQYEyHO3E/1drAvgEFVHVSpgV
         zS5rCS6hP20JsluUSJd0Dq5tFQd1x++YBb4hCNXeaG0hmtjAenGjlWxhsJhWnEpfLhES
         tsNQ==
X-Gm-Message-State: AOAM530BtuB6Cbo9lTGwBb7ySe8bHZ8ouL2hFmY8dQtJ8DkDMBPdKQWt
        8V00GpfEBR7DagKFABC7e+uPoIpLkQQp+Abx6aO+7Q==
X-Google-Smtp-Source: ABdhPJybc1mnEOSz/+QA7bXuVM7o3AS0QB7BDUZsKrUmopd9KJuholI4kaLK3H5ZWdzv9+8W5KxM7v83TFqY8YlGLeQ=
X-Received: by 2002:a17:902:26a:b029:da:af47:77c7 with SMTP id
 97-20020a170902026ab02900daaf4777c7mr9613780plc.10.1610661952331; Thu, 14 Jan
 2021 14:05:52 -0800 (PST)
MIME-Version: 1.0
References: <20201204011129.2493105-1-ndesaulniers@google.com>
 <20201204011129.2493105-3-ndesaulniers@google.com> <CA+icZUVa5rNpXxS7pRsmj-Ys4YpwCxiPKfjc0Cqtg=1GDYR8-w@mail.gmail.com>
 <CA+icZUW6h4EkOYtEtYy=kUGnyA4RxKKMuX-20p96r9RsFV4LdQ@mail.gmail.com>
 <CABtf2+RdH0dh3NyARWSOzig8euHK33h+0jL1zsey9V1HjjzB9w@mail.gmail.com>
 <CA+icZUUtAVBvpU8M0PONnNSiOATgeL9Ym24nYUcRPoWhsQj8Ug@mail.gmail.com>
 <CAKwvOd=+g88AEDO9JRrV-gwggsqx5p-Ckiqon3=XLcx8L-XaKg@mail.gmail.com>
 <CAKwvOdnSx+8snm+q=eNMT4A-VFFnwPYxM=uunRkXdzX-AG4s0A@mail.gmail.com>
 <5707cd3c-03f2-a806-c087-075d4f207bee@fb.com> <CA+icZUXuzJ4SL=AwTaVq_-tCPnSSrF+w_P8gEKYnT56Ln0Zoew@mail.gmail.com>
 <CA+icZUXQ5bNX0eX7jEhgTMawdctZ4vkmYoRKDgxEMV5ZKp8YaQ@mail.gmail.com>
In-Reply-To: <CA+icZUXQ5bNX0eX7jEhgTMawdctZ4vkmYoRKDgxEMV5ZKp8YaQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 14 Jan 2021 14:05:41 -0800
Message-ID: <CAKwvOdn98zvjGaEy0O7uCb9AUZdZANCeSYpdti3U3uj4+V4dyQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Kbuild: DWARF v5 support
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Caroline Tice <cmtice@google.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Jakub Jelinek <jakub@redhat.com>,
        Fangrui Song <maskray@google.com>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Nick Clifton <nickc@redhat.com>, bpf <bpf@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 14, 2021 at 1:52 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> Today, I have observed and reported (see [1]) bpf/btf/pahole issues
> with Clang v12 (from apt.llvm.org) and DWARF-4 ("four").
> Cannot speak for other compilers and its version.

If these are not specific to DWARF5, then it sounds like
CONFIG_DEBUG_INFO_DWARF4 should also be marked as `depends on
!DEBUG_INFO_BTF`? (or !BTF && CC=clang)

>
> - Sedat -
>
> [1] https://lore.kernel.org/bpf/CA+icZUWb3OyaSQAso8LhsRifZnpxAfDtuRwgB786qEJ3GQ+kRw@mail.gmail.com/T/#m6d05cc6c634e9cee89060b2522abc78c3705ea4c
-- 
Thanks,
~Nick Desaulniers
