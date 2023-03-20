Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2946C1489
	for <lists+bpf@lfdr.de>; Mon, 20 Mar 2023 15:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbjCTOTF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Mar 2023 10:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbjCTOTE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Mar 2023 10:19:04 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470621FC2
        for <bpf@vger.kernel.org>; Mon, 20 Mar 2023 07:19:02 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id y20so15123732lfj.2
        for <bpf@vger.kernel.org>; Mon, 20 Mar 2023 07:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679321940;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xE8NstYkj7OxjVSD0/eaukkdcptPrrqv3VHuak4Otf4=;
        b=ofbhtYI9m2WxJk0VZ9ojJSmdB6Uh8Dvhlrw0DhNbWAO4jnEzSxOely6hEHgacmxGjm
         MGbTJPkMyB30rMtnYVkTiihah6gLu2zys6Qo5oGYZ1vkG+PC7NV1ReSS0Hrc64Nv+trY
         pyDUzk1R1QcAv12cX94xyn7xfnHCgU9KVe0vHRnGi2zD65k042FwPwG/DuI0X5lj4PQl
         CXDL28BP8sfNbBVO90lFF07DHFKghcxfrCvuXWLhCuVQkUdMCQdUcwIrt+Qm5tvsn6hH
         oMNbUr+INJ6KUlmaFWOomXrHEdrjk9ZKLp+eU1P4FXz7fuwKLvVXpsFh0iJzJigM0JE9
         lhfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679321940;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xE8NstYkj7OxjVSD0/eaukkdcptPrrqv3VHuak4Otf4=;
        b=o+WMRqgoDpGL+wrdRgIKLrWf89pgE3wM/YKkQzdEpws5DTHoaJD2K7/bS+AenbcE9p
         hTFdHpIuUGYVEQOfB6JK4K5+bBR2OSZ5UqTTsixpH+CXHVCOdsKxv2WNPtpWi/MQMKE6
         P7mNx7cyL+Na/+a8kz87Ye1HQCoDmopMoq5RYWsDypMuS1Gkm6QfuWJHtcapAlILhId8
         NtUKs/jfGnxY5IuHMg6edkX7AsNhWlOlOMUaV+9avewnE0Bl4+TV1H5C+wNgSqoeL+3f
         Y7w4RdHbu7iGSmLk6yYr+5trw4zN0twQ0g4rDEAimA7RZcKL7GQMLTD6vhfQH5EDcHsR
         hYFw==
X-Gm-Message-State: AO0yUKUuRJ1jZgErkms7hMQQxSBq6wB/Nj2jGuSPNlIZa2+Bnleq+EfO
        ZUIejBaoP2ukTwRTE/PZXXs=
X-Google-Smtp-Source: AK7set+jpkZhjhcIQdHp2xmLtLG1ZrsjjwMQleIPFF6KNhqeqPgCZseJ9S578Xxzp7EUeEgxr6oYIQ==
X-Received: by 2002:ac2:5fef:0:b0:4ea:e640:2a58 with SMTP id s15-20020ac25fef000000b004eae6402a58mr35479lfg.42.1679321940305;
        Mon, 20 Mar 2023 07:19:00 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id d1-20020ac25ec1000000b004d5813386fdsm1700803lfq.139.2023.03.20.07.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 07:18:59 -0700 (PDT)
Message-ID: <a16c0bc28b0e252263ad689571e14015733cdd77.camel@gmail.com>
Subject: Re: [PATCH bpf-next 0/2] error checking where helpers call
 bpf_map_ops
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     inwardvessel <inwardvessel@gmail.com>, bpf@vger.kernel.org,
        andrii@kernel.org, yhs@meta.com, ast@kernel.org
Cc:     kernel-team@meta.com
Date:   Mon, 20 Mar 2023 16:18:57 +0200
In-Reply-To: <20230318011324.203830-1-inwardvessel@gmail.com>
References: <20230318011324.203830-1-inwardvessel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2023-03-17 at 18:13 -0700, inwardvessel wrote:
> From: JP Kobryn <inwardvessel@gmail.com>
>=20
> Within bpf programs, the bpf helper functions can make inline calls to
> kernel functions. In this scenario there can be a disconnect between the
> register the kernel function writes a return value to and the register th=
e
> bpf program uses to evaluate that return value.
>=20
> As an example, this bpf code:
>=20
> long err =3D bpf_map_update_elem(...);
> if (err && err !=3D -EEXIST)
> 	// got some error other than -EEXIST
>=20
> ...can result in the bpf assembly:
>=20
> ; err =3D bpf_map_update_elem(&mymap, &key, &val, BPF_NOEXIST);
>   37:	movabs $0xffff976a10730400,%rdi
>   41:	mov    $0x1,%ecx
>   46:	call   0xffffffffe103291c	; htab_map_update_elem
> ; if (err && err !=3D -EEXIST) {
>   4b:	cmp    $0xffffffffffffffef,%rax ; cmp -EEXIST,%rax
>   4f:	je     0x000000000000008e
>   51:	test   %rax,%rax
>   54:	je     0x000000000000008e
>=20
> The compare operation here evaluates %rax, while in the preceding call to=
=20
> htab_map_update_elem the corresponding assembly returns -EEXIST via %eax:
>=20
> movl $0xffffffef, %r9d
> ...
> movl %r9d, %eax
>=20
> ...since it's returning int (32-bit). So the resulting comparison becomes=
:
>=20
> cmp $0xffffffffffffffef, $0x00000000ffffffef
>=20
> ...making it not possible to check for negative errors or specific errors=
,
> since the sign value is left at the 32nd bit. It means in the original
> example, the conditional branch will be entered even when the error is
> -EEXIST, which was not intended.
>=20
> The selftests added cover these cases for the different bpf_map_ops
> functions. When the second patch is applied, changing the return type of
> those functions to long, the comparison works as intended and the tests
> pass.
>

Looks like this fixes commit from 2020:
bdb7b79b4ce8 ("bpf: Switch most helper return values from 32-bit int to 64-=
bit long")

To add to the summary: the issue is caused by the fact that test
program uses map function definitions from `bpf_helper_defs.h`, e.g.:

    static long (*bpf_map_update_elem)(...) 2;

These definitions are generated from `include/uapi/linux/bpf.h`,
which specifies the return type for this helper to be `long`
(changed to from `int` in the commit mentioned above).
That's why clang does not insert sign extension instructions when
helper is called.

Interesting how this went under the radar for so long, probably
because user code mostly uses `int` to catch return value of map
functions.

That commit changes return types for a lot of functions.
I looked through function definitions and verifier.c code for those,
but have not found any additional issues, except for two obvious:
- bpf_redirect_map / ops->map_redirect
- bpf_for_each_map_elem / ops->map_for_each_callback

These require similar changes.

Also, the documentation is inconsistent as well.
For example, `int bpf_map_update_elem(...)` is mentioned in:
- Documentation/bpf/map_sockmap.rst
- Documentation/bpf/map_xskmap.rst
- Documentation/bpf/map_cpumap.rst
- Documentation/bpf/map_devmap.rst
- Documentation/bpf/map_sk_storage.rst
- Documentation/bpf/map_bloom_filter.rst
- Documentation/bpf/map_queue_stack.rst

And `long bpf_map_update_elem(...)`:
- Documentation/bpf/map_sockmap.rst
- Documentation/bpf/map_array.rst
- Documentation/bpf/map_hash.rst
- Documentation/bpf/map_lpm_trie.rst

Tested-By: Eduard Zingerman <eddyz87@gmail.com>

> JP Kobryn (2):
>   bpf/selftests: coverage for bpf_map_ops errors
>   bpf: return long from bpf_map_ops funcs
>=20
>  include/linux/bpf.h                           |  10 +-
>  kernel/bpf/arraymap.c                         |   8 +-
>  kernel/bpf/bloom_filter.c                     |  12 +-
>  kernel/bpf/bpf_cgrp_storage.c                 |   6 +-
>  kernel/bpf/bpf_inode_storage.c                |   6 +-
>  kernel/bpf/bpf_struct_ops.c                   |   6 +-
>  kernel/bpf/bpf_task_storage.c                 |   6 +-
>  kernel/bpf/cpumap.c                           |   6 +-
>  kernel/bpf/devmap.c                           |  20 +--
>  kernel/bpf/hashtab.c                          |  32 ++---
>  kernel/bpf/local_storage.c                    |   6 +-
>  kernel/bpf/lpm_trie.c                         |   6 +-
>  kernel/bpf/queue_stack_maps.c                 |  22 +--
>  kernel/bpf/reuseport_array.c                  |   2 +-
>  kernel/bpf/ringbuf.c                          |   6 +-
>  kernel/bpf/stackmap.c                         |   6 +-
>  kernel/bpf/verifier.c                         |  10 +-
>  net/core/bpf_sk_storage.c                     |   6 +-
>  net/core/sock_map.c                           |   8 +-
>  net/xdp/xskmap.c                              |   6 +-
>  .../selftests/bpf/prog_tests/map_ops.c        | 130 ++++++++++++++++++
>  .../selftests/bpf/progs/test_map_ops.c        |  90 ++++++++++++
>  22 files changed, 315 insertions(+), 95 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/map_ops.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_map_ops.c
>=20

