Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF4240BC8B
	for <lists+bpf@lfdr.de>; Wed, 15 Sep 2021 02:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhIOAWb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 20:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhIOAWa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 20:22:30 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CAAC061574
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 17:21:12 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id c6so1906278ybm.10
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 17:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zQbhMCfqZ3RiwtDjEZIWH92epgMfg4uSMfBxwg/xOs0=;
        b=oQXKRLWDVVOBnFOUEtF+8H0IiqsMOu/c78Dy62r7uZjjVuXONv/hWjwHDFyiMaZEu+
         lbB4U1DQrscBhCq9tGPW4TZygVH/JX6Q355ACjvMgVtQkGeuP/rdGe1/dIik3/CYthZc
         bI/imEL/e1zIQXuTesa4BIglbjseMtiuebgk2gAGPTjA3hAgqba++Jrx5Dg3BVswBHM4
         Z2QDn2F/DV7ZQas+Ion6nBDPc0WbDaKZiu6ZFYmHc+9Dh101RKrvw95amGOZ5h3hwTOP
         DN7LIRe4foJBQ8IdE9QviOPyAMXT3/GBRguB6YkrK7Nh+wfsMtw9IJnhtJRhVAZF4EAR
         yMDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zQbhMCfqZ3RiwtDjEZIWH92epgMfg4uSMfBxwg/xOs0=;
        b=qBo8dnPDpL1KCCuaGYqS0bN/5iH9ppDRbiul0tvUkmNszOAkpwrKkRDwAHKCEGUaDy
         NFpgdiKFZS8ASo5A8m8xZ7FlOtjVhgG5AlojgoYBnIxG1eStKIAOajZuQ0lqZFRtb894
         Cc/CqVRSGw7+fjdTft8b01w+p4MO5REmgeDiB91gYJS4rmhj6INua1IoUyx077wfopvq
         tf1YsfX75XWlddJFPoVB7xooVu2lJINpHh8RQitRy7RUx8CN7q3RMPsFfq/pJxtfG6lO
         JjmoWyG57+V7FhrztvL7o4jXGn7hklgF+HJV2PUn8Ni1Wxhj/Oq1Bokz2ZrlrJeWKh4z
         AOow==
X-Gm-Message-State: AOAM533yBu5HjXp6d4CHQeAJBlPBcwW96LGsFr1O2I82mh/5owRpeDef
        Yl6J/Bq4TROs5gHs/kskMSi60iRaB/pVn2s0mPg=
X-Google-Smtp-Source: ABdhPJzk8fjkxBuqiO/EE/Ij5BX/QzNy03z1IH1plHlPuxVHGa1j+P3p6sgrIGRwm4r41jq9sLCZhmAbZF4lb1QE4xc=
X-Received: by 2002:a25:9881:: with SMTP id l1mr2421796ybo.455.1631665272119;
 Tue, 14 Sep 2021 17:21:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210914223004.244411-1-yhs@fb.com> <20210914223052.248535-1-yhs@fb.com>
In-Reply-To: <20210914223052.248535-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 14 Sep 2021 17:21:00 -0700
Message-ID: <CAEf4BzZXHHQq8KT6wJM-m-E8OxfvFTMUUTLZoBLSP8o8LLU0FQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 09/11] selftests/bpf: test BTF_KIND_TAG for deduplication
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 14, 2021 at 3:30 PM Yonghong Song <yhs@fb.com> wrote:
>
> Add unit tests for BTF_KIND_TAG deduplication for
>   - struct and struct member
>   - variable
>   - func and func argument
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

Great that it worked as expected.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/testing/selftests/bpf/prog_tests/btf.c | 192 +++++++++++++++++--
>  1 file changed, 175 insertions(+), 17 deletions(-)
>

[...]
