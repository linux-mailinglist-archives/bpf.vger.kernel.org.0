Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E6C36AF8E
	for <lists+bpf@lfdr.de>; Mon, 26 Apr 2021 10:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbhDZINm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Apr 2021 04:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbhDZINm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Apr 2021 04:13:42 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB51BC061574
        for <bpf@vger.kernel.org>; Mon, 26 Apr 2021 01:13:00 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id l22so55656621ljc.9
        for <bpf@vger.kernel.org>; Mon, 26 Apr 2021 01:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/5sZfAWMd+ikiAV3bLd2cK6LOqVMDPgtaZ3fFQ7MIjo=;
        b=cFcaMvZYSdjF2f34XTseTA7smvlQAITftRJQdb51QRoTJ8TNFudos3QdbLm/1nfZOF
         DrrppnG6FuhBd6RYaaFUjCSnlCLHSgMbpgHzt6215bGkj/O4pbymcb6VVyV0mMGPc1Yb
         YYlfnxmetIahF53kLJ6xeYsaBNv3Vw52VYLDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/5sZfAWMd+ikiAV3bLd2cK6LOqVMDPgtaZ3fFQ7MIjo=;
        b=WQiv4igbvbcBYlCR4bVmdj3EhjDfU2vpamL81FbRFg962+kFd+wXzLzs6L8geBuvfH
         Cd+69xlWHihlWoiRYtCabcj5PTygassoGDS8W37Km+TsSZ2jdhHU/fTztUmYA48LnsIw
         i38ewv2mTCkdf1yE4BRcriIqCAIBQcyhMOKDRdYrD6V7V8IZ8ikD1Cm0hnSu9+80brqK
         isjm/yvApVa9/1jJL2pRD7VLr2l911Ro0CtziTa/RxCxSEaRIVXGd7H/SjdQk5fsiQU5
         ZGcLNiXZGF8LMWkrug8BTzGOl63vKCtHddzeIHlcgDv1ZBaz6KHqkaIH90DRoBPykA52
         SfGw==
X-Gm-Message-State: AOAM531oqzRKdPpGetFCAwvQm8kpRaQjPQSRTJsUNwoPe7WlTJuGpI1T
        bAhQX2sAbO9IviZqyYc5MzkcTw4BBi6kawNZGz42MA==
X-Google-Smtp-Source: ABdhPJxEHRXvZWbIteNosiutZAq75uXJOWKFpitGwuYHp/kosW/z13xxA/NMtqpkwsMIHDFFPNPU7u/7oSW2baD3snk=
X-Received: by 2002:a2e:b4ba:: with SMTP id q26mr11866288ljm.223.1619424779352;
 Mon, 26 Apr 2021 01:12:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210423233058.3386115-1-andrii@kernel.org> <20210423233058.3386115-5-andrii@kernel.org>
In-Reply-To: <20210423233058.3386115-5-andrii@kernel.org>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Mon, 26 Apr 2021 09:12:48 +0100
Message-ID: <CACAyw9_RqR9m8zBTTO+qKzs9K86sthbHRjGH2m0yyE7zvNFYSg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/5] selftests/bpf: fix field existence CO-RE
 reloc tests
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 24 Apr 2021 at 00:36, Andrii Nakryiko <andrii@kernel.org> wrote:
>
> Negative field existence cases for have a broken assumption that FIELD_EXISTS
> CO-RE relo will fail for fields that match the name but have incompatible type
> signature. That's not how CO-RE relocations generally behave. Types and fields
> that match by name but not by expected type are treated as non-matching
> candidates and are skipped. Error later is reported if no matching candidate
> was found. That's what happens for most relocations, but existence relocations
> (FIELD_EXISTS and TYPE_EXISTS) are more permissive and they are designed to
> return 0 or 1, depending if a match is found. This allows to handle
> name-conflicting but incompatible types in BPF code easily. Combined with
> ___flavor suffixes, it's possible to handle pretty much any structural type
> changes in kernel within the compiled once BPF source code.
>
> So, long story short, negative field existence test cases are invalid in their
> assumptions, so this patch reworks them into a single consolidated positive
> case that doesn't match any of the fields.
>
> Fixes: c7566a69695c ("selftests/bpf: Add field existence CO-RE relocs tests")
> Reported-by: Lorenz Bauer <lmb@cloudflare.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Lorenz Bauer <lmb@cloudflare.com>

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
