Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2A94A0433
	for <lists+bpf@lfdr.de>; Sat, 29 Jan 2022 00:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344542AbiA1XXd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Jan 2022 18:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344371AbiA1XXd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Jan 2022 18:23:33 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7731AC06173B
        for <bpf@vger.kernel.org>; Fri, 28 Jan 2022 15:23:32 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id z19so14675575lfq.13
        for <bpf@vger.kernel.org>; Fri, 28 Jan 2022 15:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BpeLydjX5mOwOQX9R670hKq9JulnJSBkl4SUh8O11MY=;
        b=Hb+TGmMvM9ZaqMs0MXpw21TZWY5oc3Ca0AS9ceIyJLluSthVZQ1JTqlS/ZNVSPJJr1
         Zqczd1tT+GAVHTJgDIOrm9BHXFDtBgjfCEPn67hv/Lkl0BGAIPCZugZ5u9h/AvwBhkbw
         bm6dQf15V9sn3lU9zucftVhpeYNICN9fzkVMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BpeLydjX5mOwOQX9R670hKq9JulnJSBkl4SUh8O11MY=;
        b=1HIdqTLEUcnQP/4OK+fWTl1r3l9+ABGdP0bwjY7a2KdKCZQPRdq2rDU6YtcwLzrlGf
         4Lfj2t9cwPyWSIDfDSVwUcKYXgbia8uTGTt/GzKyySVl8vMtSpI8XO/4FXaNmqDlWvkd
         qI0mQpII/2isKy34M0wMXhKt5rsaligZRgNuESpdIZrVyL4/dEy41TMS30ftWEWNYtCT
         CyEkGnQbOpMbivpXLaAH3MLV7m8wlkM1f2TCaaNc/E7p+8jIfemKaqCcXg8zuTBZNPKK
         buO9uyqRyEvkZHCtK91GBUkdSjdi8zgVOZWwkhBPXcRiF0e5sLj5WkZZR7onKv82Ktbw
         RfSA==
X-Gm-Message-State: AOAM533EVeejwYdoMfcbL6HnFBGHO2XRl0w2cH0uXh6EC5KUEAwQ2Df1
        AfPHFpMMXNYr+zPV85Tt4hQZBuGLOEf0ZGhvBskFNQ==
X-Google-Smtp-Source: ABdhPJwGKwWgwIXALKcMpTiqcG4Etcmn/HsEoinSQiEMWX2IckTTegVkfoHBs/bumIDZoektOJXBdxAc3TZT45uJ/II=
X-Received: by 2002:a05:6512:3a95:: with SMTP id q21mr7280463lfu.569.1643412210624;
 Fri, 28 Jan 2022 15:23:30 -0800 (PST)
MIME-Version: 1.0
References: <20220128223312.1253169-1-mauricio@kinvolk.io> <20220128223312.1253169-10-mauricio@kinvolk.io>
In-Reply-To: <20220128223312.1253169-10-mauricio@kinvolk.io>
From:   =?UTF-8?Q?Mauricio_V=C3=A1squez_Bernal?= <mauricio@kinvolk.io>
Date:   Fri, 28 Jan 2022 18:23:19 -0500
Message-ID: <CAHap4zsWqpTezbzZn7TOWvFA4c2PbSum4vY1_9YB+XSfFor21g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 9/9] selftest/bpf: Implement tests for bpftool
 gen min_core_btf
To:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Rafael David Tinoco <rafaeldtinoco@gmail.com>,
        Lorenzo Fontana <lorenzo.fontana@elastic.co>,
        Leonardo Di Donato <leonardo.didonato@elastic.co>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 28, 2022 at 5:33 PM Mauricio V=C3=A1squez <mauricio@kinvolk.io>=
 wrote:
>
> This commit implements some integration tests for "BTFGen". The goal
> of such tests is to verify that the generated BTF file contains the
> expected types.
>

This is not an exhaustive list of test cases. I'm not sure if this is
the approach we should follow to implement such tests, it seems to me
that checking each generated BTF file by hand is a lot of work but I
don't have other ideas to simplify it.

I considered different options to write these tests:
1. Use core_reloc_types.h to create a "source" BTF file with a lot of
types, then run BTFGen for all test_core_reloc_*.o files and use the
generated BTF file as btf_src_file in core_reloc.c. In other words,
re-run all test_core_reloc tests using a generated BTF file as source
instead of the "btf__core_reloc_" #name ".o" one. I think this test is
great because it tests the full functionality and actually checks that
the programs are able to run using the generated file. The problem is
how do we test that the BTFGen is creating an optimized file? Just
copying the source file without any modification will make all those
tests pass. We could check that the generated file is small (by
checking the size or the number of types) but it doesn't seem a very
reliable approach to me.
2. We could write some .c files with the types we expect to have on
the generated file and compare it with the generated file. The issue
here is that comparing those BTF files doesn't seem to be too
trivial...

Do you have any suggestions about it? Thanks!
