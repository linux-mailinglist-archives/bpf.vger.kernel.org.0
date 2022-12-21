Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68662652DD2
	for <lists+bpf@lfdr.de>; Wed, 21 Dec 2022 09:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234547AbiLUIUX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Dec 2022 03:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbiLUITO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Dec 2022 03:19:14 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DB2F7D
        for <bpf@vger.kernel.org>; Wed, 21 Dec 2022 00:19:04 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id fc4so34900343ejc.12
        for <bpf@vger.kernel.org>; Wed, 21 Dec 2022 00:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dBq4MDAYU8P3TQxXQ+GvWJ7e/76/+RNM194/qXKfxg8=;
        b=qkYLWLisd1o6ovGOtSoMnN5ZA85p2sCDH6rhsUZuwn4nfHMrg9kXXVSv6RFbk9kC79
         0n4NjKh5JfXH2j5qozmsOmP/S891I4iyjpUYlSrr2k6LQiPh7fDDE6rFXXU20I73oNfa
         Ba4bGTQ7BL/qepEbCuvpo1N1SQkIPzUg5xlRsRSCflhZ4VUOsWpD8wc4citMy6HP0Hwi
         9/59WQujIcF+Fibyse2lflHjZINpGrE4VUyDsHJOrUVgv4/ypPx+MLw0jY//n3lwao9Z
         NWY4FGHLa1LwqUwFX7e3OHpJwY8fjAh6KlEgzYd9C69lWoCoTXbYJwDYpG4aw4PAKR5Z
         3BGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dBq4MDAYU8P3TQxXQ+GvWJ7e/76/+RNM194/qXKfxg8=;
        b=3KgzjiNcJrbbja4yTxeQHErDp056NJeVqbVpjwKJv18A6+SKgiZ3VsvSC7cCyukCjT
         qUqtMkVL/YoQDfD7LLJ0XfRmnhgKm5iqhuO7HRmeGdrzjGKvYGkm4Zd2itiI2wIqsKUt
         jo7zJZQ6zibxVo/gNwulv4EcMHLHghMKB6hzRf7PM7ZxHBFUZ1dm8V51StO7a2sPhXcE
         jOEk1FUiRFnVPwnAhsInrggwfMNEq7zN5dG7ypBbLEnB8TiPUGQzL5CKhzd8ZthZNjbT
         L7rBaG4FtuO7+qYw9YF4PHSIRy+56QKfwmXWaHuT04CWuLPpDvQqu54/hoeQ8YGNIq9D
         MyPQ==
X-Gm-Message-State: AFqh2kovXUhrMlyQzQm7is/pq3Ycj85DmfKuycBhyenGpCHLu0W/K79v
        q28yaudYIiiXXIZA1EBb7prd/zpOjLQp5XOO29ATkp6qTgI=
X-Google-Smtp-Source: AMrXdXvRC454rQapUL7UOfkeJuwDIw8BHPWqetPHPE1WFbBOIldn4hEdKsfXOd3zS1P/DeHc5QcW5xkSKQSpOMtEDGk=
X-Received: by 2002:a17:906:f209:b0:7fd:f0b1:c8ec with SMTP id
 gt9-20020a170906f20900b007fdf0b1c8ecmr45007ejb.114.1671610742036; Wed, 21 Dec
 2022 00:19:02 -0800 (PST)
MIME-Version: 1.0
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 21 Dec 2022 00:18:50 -0800
Message-ID: <CAEf4BzYEx4Ta8UynZ40nenz3O1eaJ_=VdDUkzWhwwqn5K6=+WQ@mail.gmail.com>
Subject: [ANNOUNCEMENT] libbpf v1.1 release
To:     bpf <bpf@vger.kernel.org>
Cc:     Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Libbpf v1.1 has been released ([0])!

It's been almost 3 months since v1.0.1 release, and as you can see
from the changelog below, v1.1 doesn't add much new functionality.
Instead, there is a rather large number of various bug fixes and
improvements, all over the API surface, improving usability and
stability of the library.

Which seems like a good thing and is a sign of libbpf's maturity and
completeness.

Thank you to all the contributors that are constantly making libbpf a
better BPF loader library!


## User space-side features and APIs:

- user-space ring buffer (`BPF_MAP_TYPE_USER_RINGBUF`) support;
- new [documentation
page](https://libbpf.readthedocs.io/en/latest/program_types.html)
listing all recognized `SEC()` definitions;
- BTF dedup improvements:
  - unambiguous fwd declaration resolution for structs and unions;
  - better handling of some corner cases with identical structs and arrays;
  - mixed enum and enum64 forward declaration resolution logic;
- `bpf_{link,btf,pro,mapg}_get_fd_by_id_opts()` and
`bpf_get_fd_by_id_opts()` APIs;
- libbpf supports loading raw BTF for BPF CO-RE from known search paths;
- support for new cgroup local storage (`BPF_MAP_TYPE_CGRP_STORAGE`);
- libbpf will only add `BPF_F_MMAPABLE` flag for data maps with
*global* (i.e., non-static) vars;
- latest Linux UAPI headers with lots of changes synced into include/uapi/linux.

## BPF-side features and APIs;

- `BPF_PROG2()` macro added that supports struct-by-value arguments;
- new BPF helpers:
  - `bpf_user_ringbuf_drain()`;
  - `cgrp_storage_get()` and `cgrp_storage_delete()`.

## Bug fixes
- BTF-to-C converter fixes:
  - better handling of padding corner cases;
  - `btf__align_of()` determines packed structs better now;
  - improved handling of enums of non-standard sizes;
- USDT spec parsing improvements;
- overflow handling fixes for ringbufs;
- Makefile fixes to support cross-compilation for 32-bit targets;
- fix crash if `SEC("freplace")` programs don't have `attach_prog_fd` set;
- better handling of file existence checks when running as non-root
with enhanced capabilities;
- a bunch of small fixes:
  - ELF handling improvements;
  - fix memory leak in USDT argument parsing logic;
  - fix NULL dereferences in few corner cases;
  - improved netlink attribute iteration handling.

[0] https://github.com/libbpf/libbpf/releases/tag/v1.1.0
[1] Full Changelog: https://github.com/libbpf/libbpf/compare/v1.0.1...v1.1.0

-- Andrii
