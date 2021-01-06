Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E392EC2E9
	for <lists+bpf@lfdr.de>; Wed,  6 Jan 2021 19:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbhAFSDZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jan 2021 13:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbhAFSDZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jan 2021 13:03:25 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE97C061575
        for <bpf@vger.kernel.org>; Wed,  6 Jan 2021 10:02:44 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id r9so3744788otk.11
        for <bpf@vger.kernel.org>; Wed, 06 Jan 2021 10:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=araalinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=O9paexg/4QiZCZb3EFCoKlCCUoHdKjdbDibhmVzYwpY=;
        b=ye//Q6T7RD9xNVARJ/UGz1szsKWvdSjAQyFK5Cg5DsdXC06ArrOaUNBBrvzgwPS7q6
         I4XUbkWVfrx15zjpaieyjwBRa0+A4kUvhD/36ql+qBO3+FuVi8e2m+8pEMxizXWCCSUC
         oaLIhUi6R60yM3KteRR3Y346Ofmn/JWNHp4qNAMwGOmyPdxYF2q5yfJMoqpc8S8hLI7t
         B6pYHN1TJhmNXx1DXhDNJP5o3E3+Tg7s8Tx9ZAyJyEWSupG80JEMyJyYhScP/sMYrPA0
         t+KlfkPjOKsdr/IA1CrZreujks3ymEolJlVA8E6DI91p9schpwKgQG2cLDNxSdq6qRKW
         h+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=O9paexg/4QiZCZb3EFCoKlCCUoHdKjdbDibhmVzYwpY=;
        b=dNe/h5rP6ukXf/Cuhp44/XVjfTs64N7inaNzTN6yazKDOpIbNk0xUl2Q0D8dyUbmK2
         OJsHPjcgFV4IhyjxicKqRq8i79iprYk7CqNKXnS9uyaczT8wQ/LpuQypIjXXT3PMV9qU
         X4evv4DL7+5sBKr5B640UBfYuwW0UKhqCo1UmlRsbsGF44/iL5LRIvsKcahAnyF/Mb8M
         t0bA3aJu2MFeS80fxH94F5aVqVrkaSzD4FzPgvCj0hGjAAzuOKFq2eJkSiWP3SKgqmlP
         4BDzUgpIXSsgn9xowpv06HK2VNl6WUIhxGvV8PGQSrQEN4xXs8EOvqFmm6JGp5RP2H2U
         nlng==
X-Gm-Message-State: AOAM533CxzYZoxZO4Xag13eFLnB9j0p19zMt5ecWslCCXvlJUt3HVOoS
        8QVZEUR1d0W48u7qzjXeMWRafLV/NfsWtImgEZbVZW08BwIAzOu5
X-Google-Smtp-Source: ABdhPJw9w285TvgyaFHQRFksZGMXcHVUT+sbMSVtdkrBPZo5hIO95Y779yO47DW5FuaeyKkrDyvfknX3WTkdV5db6hU=
X-Received: by 2002:a9d:6188:: with SMTP id g8mr4054321otk.299.1609956163880;
 Wed, 06 Jan 2021 10:02:43 -0800 (PST)
MIME-Version: 1.0
From:   Vamsi Kodavanty <vamsi@araalinetworks.com>
Date:   Wed, 6 Jan 2021 10:02:33 -0800
Message-ID: <CADmGQ+1euj7Uv9e8UyZMMXDiYAKqXe9=GSTBFNbbg1E0R-ejyg@mail.gmail.com>
Subject: [BPF CO-RE clarification] Use CO-RE on older kernel versions.
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Had a few questions on CO-RE dependencies and usage. From what I read
CO-RE needs a supported kernel version and be compiled with
`CONFIG_DEBUG_INFO_BTF=y`.

I also understand there are three pieces to enable CO-RE
functionality. (1) The BTF format. For efficient/compressed kernel
symbol table. (2) clang changes to emit the BTF relocations. (3)
`libbpf` changes to locate a BTF file and fix-up relocations. Once
these 3 steps are done the resulting byte code is no different from
non-CO-RE byte code.

Given this I am hoping the knowledgeable folks on this mailer correct
and guide me if I am stating something incorrectly.

(1) Is the kernel support requirement ONLY for the purposes of
generating and exposing the BTF file information on
`/sys/kernel/btf/vmlinux`? So that the eBPF CO-RE applications
`libbpf` can find the BTF information at a standard location?.

(2) If the answer to the above question is YES. Could the below
mechanism be used so that it works on all kernels whether they support
the `CONFIG_DEBUG_INFO_BTF` flag or not?.
       (a) Extract BTF generation process outside of the kernel build.
Use this to generate the equivalent BTF file for it.
       (b) Make changes to `libbpf` to look for BTF not only at the
standard locations but also at a user specified location. The BTF file
generated in (a) can be presented here.

This should provide us a way to enable CO-RE functionality on older
kernel versions as well. I tried to make the above changes and tried
against a 4.14 kernel and it did not work. Either I am not doing
something right or my assumptions are wrong.

Thanks in advance for your time. And I hope someone here can guide me
in the right direction.

Regards
Vamsi.
