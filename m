Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 765BF43E81A
	for <lists+bpf@lfdr.de>; Thu, 28 Oct 2021 20:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhJ1STY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Oct 2021 14:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbhJ1STX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Oct 2021 14:19:23 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CCAC061570
        for <bpf@vger.kernel.org>; Thu, 28 Oct 2021 11:16:56 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id o12so17586069ybk.1
        for <bpf@vger.kernel.org>; Thu, 28 Oct 2021 11:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tF+4PYrmcuZpjL995Czlz9aZU9RRpup9HW/DIg1VO/g=;
        b=FAXe5UwKRCnxrGDwnXnBqdVOzmSSBIrUcrZSeysSx/dWxGjlCB8xKeBlz2Fnoyc2cr
         t20sV7bT3PbMMxnsCagYgblVHDyH8eIpyCxJk4nG53DrADknNTzudl/r0nWenG/FuXR4
         ruR6aJXEUiTsIHTwGRo+Kj9xtmyShq09bTnwn8AisFuTNeNB478qLyZXk7KV1xIFMlsq
         WHpMSNdpO8hUzT98QZusU7O++HT/8ytMpkdBL1PgXF7qvbrrsXjOnb+ufjU7RLFxb7mR
         pwxmMqljYIHPKn9E0ddQL3nlqaMxu1N9lPtx2qencXtgjpDHIk2mqU8xj2KQwkH/7xvU
         nSVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tF+4PYrmcuZpjL995Czlz9aZU9RRpup9HW/DIg1VO/g=;
        b=e6GbtCBvLU27SCBfRaCmw/oi0mdh3GPde6FA7LizZWzBtSdSVKSfEEqPWIRxthrUQZ
         ZEQJpkEPYQZavJXDjQW8DgxODbS2/fgh0gIxrZp3etNuTSx/7P5AR905wxVgJPmWNbE2
         YikB5J+p9489AzjT/QtbPE+5T5Ms/eO+50shvHQWAq+w5F0Cxn1XHbE9KZbcTMlBqq9V
         X92ZaflvE+951VPeMY6cy/PYL4Jz3WJCByROBA/nhYExcsqYaPhSoO1yX3KSOZAhZ1Dc
         mtEyQgadAM65b34aHP4ZS83LwEXaXIZXmIuNNL538L0cMOVpbzIBuOQnESRe48/q65qP
         Me1Q==
X-Gm-Message-State: AOAM533bAPCV9RVsSN2G1hc5bPNoOVyqjIyou281e5Funj4HU2ixUleD
        xtXfvcin3q2zVkk8jkK3Vj9HuOyYezdE7xFYVyc=
X-Google-Smtp-Source: ABdhPJyJt666BZ5HCuaOR2lrC81LqjM54kJjkAZT/Iu2ngJGpYqrwoJPGKTqYNkWgbObe7uQgDAUAP6rcH24WV8bhFY=
X-Received: by 2002:a25:afcd:: with SMTP id d13mr6845225ybj.504.1635445015540;
 Thu, 28 Oct 2021 11:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <20211027234504.30744-1-joannekoong@fb.com> <20211027234504.30744-4-joannekoong@fb.com>
In-Reply-To: <20211027234504.30744-4-joannekoong@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 28 Oct 2021 11:16:44 -0700
Message-ID: <CAEf4BzaJZmaVDZH80yeV+3opRTAUhq++D7SQsGfV-uyDYGdXyQ@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 3/5] selftests/bpf: Add bloom filter map test cases
To:     Joanne Koong <joannekoong@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 27, 2021 at 4:45 PM Joanne Koong <joannekoong@fb.com> wrote:
>
> This patch adds test cases for bpf bloom filter maps. They include tests
> checking against invalid operations by userspace, tests for using the
> bloom filter map as an inner map, and a bpf program that queries the
> bloom filter map for values added by a userspace program.
>
> Signed-off-by: Joanne Koong <joannekoong@fb.com>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  .../bpf/prog_tests/bloom_filter_map.c         | 204 ++++++++++++++++++
>  .../selftests/bpf/progs/bloom_filter_map.c    |  82 +++++++
>  2 files changed, 286 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/bloom_filter_map.c
>  create mode 100644 tools/testing/selftests/bpf/progs/bloom_filter_map.c
>

[...]
