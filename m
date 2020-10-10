Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD8F28A229
	for <lists+bpf@lfdr.de>; Sun, 11 Oct 2020 00:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388991AbgJJWzM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 10 Oct 2020 18:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731152AbgJJTxK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 10 Oct 2020 15:53:10 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F32C0613AA
        for <bpf@vger.kernel.org>; Sat, 10 Oct 2020 03:50:21 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id t20so5706944edr.11
        for <bpf@vger.kernel.org>; Sat, 10 Oct 2020 03:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=HC/gkB6iSKF4+yEdzyyM5VASOzrvfoYkCSUnVQ8RBKU=;
        b=tBVG9hXEgAoU/QAs22SWkvWV59bjbaejX8CxE5IoMlc0PzBxTyjbt8GJtOdpMuRIb8
         LOc2emYuchLsr4mqQXDZjM3FCF5V9B6qk2Nq9HADbt1FjFlUsbMfK195krPEFUK9T+oK
         0QXmjjpVW3z4BGQ6C57sFLgtbevM4DlCDqKZ5kj2ms1sU6ZpyFJwjUzMGqidil8y2Uy7
         FndkOucPWI6zOv0m3BYrJ6YlZJBNGWvl9MvgTjHnFfsHeWEtdpC3EtghgkgGazTilCFa
         LZQ+Wa5xey5aWvGvQkyG8YGlL4RCWWgc4+wnqmTJRpXUL3zYJgv+TB0WvuU3z/6Iw63g
         m+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=HC/gkB6iSKF4+yEdzyyM5VASOzrvfoYkCSUnVQ8RBKU=;
        b=TfIxf5dcNkBnWLLwzHzdyjs0/ncyFApsrH0Z+eZdeOdofxY+LNxHFLrVmY/TSJnhx5
         6Hg7b/cWJg2KgevWIhh5deS2usfo1DDOYf+bVS8KbUccbfu/YW10OhTf+qY7SvcqX5z9
         w2Jnwy0PPYYOMIO5K6M11r1DtiGgAbnhNNkjraA4aLnHDhw0cosdeIe1PZGHPqDO8VpX
         NT0nI0YlDL7MKhtg7+FYB0X/ceEaU2509fojGWWGMfCMj41S1pdqvT6kCLEga1S6NTj9
         Ylv01TT5Ep2n0r8S2ujURpxJlBUzrt1sIQMqcuik0RskVQXcLkPHkRCmSHB2wpVTW7IN
         FRnw==
X-Gm-Message-State: AOAM530E0MSOdjbUAsJ9+EaxCF+lh5Uo6j/sDTviQK7ZIOsydh2qTnSy
        /rM3j3I6WytSEzSLdFPpQYSEtPgP33CDUcjki08ihK7Aig==
X-Google-Smtp-Source: ABdhPJwc2V+HdmPm1gDuFTqNbYxh4tz2DHtmCMj6YlZNMri92UFr8G/wq64F1bIA0yC7AjUbsEncpJxFPMbfbG8+sOo=
X-Received: by 2002:a50:cbc7:: with SMTP id l7mr3904049edi.148.1602327019472;
 Sat, 10 Oct 2020 03:50:19 -0700 (PDT)
MIME-Version: 1.0
From:   "Daniel T. Lee" <danieltimlee@gmail.com>
Date:   Sat, 10 Oct 2020 19:50:03 +0900
Message-ID: <CAEKGpzh70f06iMQdR3B1LF3hMwHnB=x92fvfV8+smQObvKBF_w@mail.gmail.com>
Subject: Where can I find the map's BTF type key/value specification?
To:     bpf <bpf@vger.kernel.org>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        Martin Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I'm looking for how BTF type definition '__type(key, int)' is being changed
to '__uint(key_size, sizeof(int))'. (Not exactly "changed" but wonder how
it can be considered the same)

    __uint(type, BPF_MAP_TYPE_ARRAY);
    __type(key, int);          => __uint(key_size, sizeof(int))
    __type(value, u32);    => __uint(value_size, sizeof(u32))
    __uint(max_entries, 2);

Whether the specific map type supports BTF or not can be inferred from
the file in kernel/bpf/*map.c and by checking each MAP type's
bpf_map_ops .map_check_btf pointer is initialized as map_check_no_btf.

But how can I figure out that specific types of map support BTF types for
key/value? And how can I determine how this BTF key/value type is
converted?

I am aware that BTF information is created in the form of a compact
type by using pahole to deduplicate repeated types, strings information
from DWARF information. However, looking at the *btf or pahole file
in dwarves repository, it seemed that it was not responsible for the
conversion of the BTF key/value.

The remaining guess is that LLVM's BPF target compiler is responsible
for this, or it's probably somewhere in the kernel, but I'm not sure
where it is.

--
Best,
Daniel T. Lee
