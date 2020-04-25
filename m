Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 460591B8592
	for <lists+bpf@lfdr.de>; Sat, 25 Apr 2020 12:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbgDYKTg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 Apr 2020 06:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726088AbgDYKTc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 25 Apr 2020 06:19:32 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C744C09B04B
        for <bpf@vger.kernel.org>; Sat, 25 Apr 2020 03:19:30 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id s30so10141303qth.2
        for <bpf@vger.kernel.org>; Sat, 25 Apr 2020 03:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yhgkDblJ6kuS2NzyTpV0otXE+gL6DJiipid5BbTEBrM=;
        b=NVqodb/xL3rXX892FRNxzgXwtT0FCUR1c5K2pylnT0Qt6fplduqWr4PHf32pT7NNFU
         OlwOjR5Zf7Cs6mBNdiha7a+oYCLDn8W0cRA8N/spPvk+beknj6l/VsHLTzrwr9iNd3cz
         7iRf+TQ76EnWFS+CxVhhVNI0by09ZJJxqCNEaZ5cKy7kFh+JqevUsJ0kU44hY1VCJbgR
         2IfXVCRAxtbuXft6N0741GJ5Hj3K3fmMjPCcLREi4YYzputdskpM4rQ97DXfu7HEoGOf
         F3fn2Fhp5eiIZ075AKrrPEl/0auuORf5Ud9raEMMp6LsxDZFwb6YMdhaDqjE75N0cwE3
         5Gtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yhgkDblJ6kuS2NzyTpV0otXE+gL6DJiipid5BbTEBrM=;
        b=ZhAmTgMm5JtCD+goQRK/BL9+eBRWpsPtrRukSsOUhqAM1M2VZ93ePIC8lvmWjSqIth
         LUhJQ8ekpc9yQbtFn6Jwegogq7rMoCH0mH3Gh+ZBud8TrQ19DYMYBn2VUehPyAKzpIRI
         kxGZXIkD73XfuNv4oV64toUDeKAXJN+77lvCf7fQWsmSxOP7BjbrL+LoV6KQSLe0Rk1/
         ATxFJI/pSEVbwVQP0jGQaicfdBg13umBtA+KaqyplhIrHYQP7n+g2xrm1KpVlL2vVFap
         pDhOJ703Q9TJvPI3T2CWwx+VCpaRInZ91u58T78WLctlmleLy7GcdYmkbUE+qYnRHPZP
         83SQ==
X-Gm-Message-State: AGi0PuaF/e3J8dYw2n9KiKewZYOYQZN43nKuWmeP0nL6/qq06RWx3fsC
        I6uWmftPB1dpbE/DIRV1zy8Consrt0jFWC9kL59bNQ==
X-Google-Smtp-Source: APiQypJg2EH+UxMCJiIlw7/oyCETvUIny+wa/DNI7c+EGj7nX4finA4EmWHhD/msYJh6Q9hUx7dfDsiwnQYsa9RcXzQ=
X-Received: by 2002:aed:3e22:: with SMTP id l31mr13842848qtf.290.1587809969734;
 Sat, 25 Apr 2020 03:19:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200424053505.4111226-1-andriin@fb.com> <20200424053505.4111226-8-andriin@fb.com>
 <34110254-6384-153f-af39-d5f9f3a50acb@isovalent.com> <CAEf4BzY9tjQm1f8eTyjYjthTF9n6tZ59r1mpUsYWL4+bFuch2Q@mail.gmail.com>
 <5404b784-2173-210d-6319-fa5f0156701e@isovalent.com> <CAEf4BzYZD2=XV+86DFfGvtfBEGkdHAEhxe7WebU2bm=okGJEcA@mail.gmail.com>
In-Reply-To: <CAEf4BzYZD2=XV+86DFfGvtfBEGkdHAEhxe7WebU2bm=okGJEcA@mail.gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
Date:   Sat, 25 Apr 2020 11:19:18 +0100
Message-ID: <CACdoK4+h6SjPe9XGbC5WWLcAhZoq9C3zcPEOe4PQ0TVzrDxiCA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 07/10] bpftool: expose attach_type-to-string
 array to non-cgroup code
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 25 Apr 2020 at 01:12, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

>
> Ah, I see what you are saying... I can just declare array as
>
> const char *attach_type_strings[__MAX_BPF_ATTACH_TYPE] = { ... }
>

That would address my concern, thanks!

> to prevent this. There is still this issue of potentially getting back
> NULL pointer. But that warrants separate "audit" of the code usage and
> fixing appropriately, I don't think it belongs in this patch set.

Agreed, we can keep that for later. My main concern for this review
was the other point above anyway.

Thank you,
Quentin
