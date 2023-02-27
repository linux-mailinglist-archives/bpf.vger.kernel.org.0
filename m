Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3896A4B42
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 20:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjB0Tiq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 14:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjB0Tip (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 14:38:45 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056CE265BC
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 11:38:16 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id ec43so30341175edb.8
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 11:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=drKBU9Do8MqxVQKAqcuLbgXJ1t0tOEixKheqFSC8JXI=;
        b=Rv1veC4QSCkE5avSLGwB8EqMoj9Tu2u8gcPlkcAdLg2yeXsnxLV8/vQBly0gHS59Cf
         Y+Q+nYnTOaTc35IAJ6gtJDY3ERX/WEwB++Zpm2lZY/BDwCr6C80zF20We+A/oaU++HeZ
         bYaDlXgFasQ3kEDznuE0VwsZWntd/J2u8dfA4N/O9Rt6b/qldo5QFDGK1/E/be4wU+3i
         dM9wGyiv/jf7IoaYgvkIEXWYNQ0+ip1XydvQD4Hc4amvAeVGdFy3WOteo4sHXSBXRfbM
         1gio4Tm5muS1cteCSvc0/OLGq7a2kMbMBKLqRcoYa0kQr84s1tMTOPwSoFYV9jM1vvgU
         jvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=drKBU9Do8MqxVQKAqcuLbgXJ1t0tOEixKheqFSC8JXI=;
        b=ITdQnTxPzyFsuTsnzSZ9lXhIlwMywFJ6xIvBrd322TeBQT40hGvU8RpmKvugs/tUQ6
         VMuirI9z7DY889W8cbtMfxjf2kJa4sA28BPKsSpsHT8p0O2gWsvxNk2VfLMU/lhnc9nc
         WNj1gTpD948D6+dWDbJ4Fy5nEmosj1ppA1jPD67ObE0h7xYASYoWwbAfknO8vC/n7toX
         tw05YQnUOAgYU81iniTu/5epUULzItmFSLLKny7OInUHta58+UMDs74sX1AF1hOcsVyr
         OFfqJhXt4cKxTLwoXyME3gVZn+CXTSLB4Tz7LV0JB1kbXxOwX8Iudp8mfk1+bNxk7HxL
         hTxQ==
X-Gm-Message-State: AO0yUKUhf+R2eHgn+39IrFjHMehhVdadheQWV2X59+VOJ3rWnOfxLhfe
        SP6gADaPlsR1glVmZYIxwOBVeebkpuGoV58//so=
X-Google-Smtp-Source: AK7set9XAb0Hyrh0CcIyenFT2GFkfjU2lmV/z+NQL2diF6esVldhOFoWA35hiDGTY46bLzE+QKOjmiA7ELINsoTat/s=
X-Received: by 2002:a17:906:b746:b0:88d:64e7:a2be with SMTP id
 fx6-20020a170906b74600b0088d64e7a2bemr16291683ejb.15.1677526670763; Mon, 27
 Feb 2023 11:37:50 -0800 (PST)
MIME-Version: 1.0
References: <20230223215311.926899-1-aditi.ghag@isovalent.com> <20230223215311.926899-4-aditi.ghag@isovalent.com>
In-Reply-To: <20230223215311.926899-4-aditi.ghag@isovalent.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 27 Feb 2023 11:37:38 -0800
Message-ID: <CAEf4BzbJ49BCBh8jwjq+kOLn=QQPxGpG2gb8+Gn3uJv9X6szhg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/3] selftests/bpf: Add tests for bpf_sock_destroy
To:     Aditi Ghag <aditi.ghag@isovalent.com>
Cc:     bpf@vger.kernel.org, kafai@fb.com, sdf@google.com,
        edumazet@google.com
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

On Thu, Feb 23, 2023 at 2:05 PM Aditi Ghag <aditi.ghag@isovalent.com> wrote:
>
> The test cases for TCP and UDP iterators mirror the intended usages of the
> helper.
>
> The destroy helpers set `ECONNABORTED` error code that we can validate in the
> test code with client sockets. But UDP sockets have an overriding error code
> from the disconnect called during abort, so the error code the validation is
> only done for TCP sockets.
>
> The `struct sock` is redefined as vmlinux.h forward declares the struct, and the
> loader fails to load the program as it finds the BTF FWD type for the struct
> incompatible with the BTF STRUCT type.
>
> Here are the snippets of the verifier error, and corresponding BTF output:
>
> ```
> verifier error: extern (func ksym) ...: func_proto ... incompatible with kernel
>
> BTF for selftest prog binary:
>
> [104] FWD 'sock' fwd_kind=struct
> [70] PTR '(anon)' type_id=104
> [84] FUNC_PROTO '(anon)' ret_type_id=2 vlen=1
>         '(anon)' type_id=70
> [85] FUNC 'bpf_sock_destroy' type_id=84 linkage=extern
> --
> [96] DATASEC '.ksyms' size=0 vlen=1
>         type_id=85 offset=0 size=0 (FUNC 'bpf_sock_destroy')
>
> BTF for selftest vmlinux:
>
> [74923] FUNC 'bpf_sock_destroy' type_id=48965 linkage=static
> [48965] FUNC_PROTO '(anon)' ret_type_id=9 vlen=1
>         'sk' type_id=1340
> [1340] PTR '(anon)' type_id=2363
> [2363] STRUCT 'sock' size=1280 vlen=93
> ```
>
> Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
> ---
>  .../selftests/bpf/prog_tests/sock_destroy.c   | 125 ++++++++++++++++++
>  .../selftests/bpf/progs/sock_destroy_prog.c   | 110 +++++++++++++++
>  2 files changed, 235 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_destroy.c
>  create mode 100644 tools/testing/selftests/bpf/progs/sock_destroy_prog.c
>

[...]

> +       n = send(clien, "t", 1, 0);
> +       if (CHECK(n < 0, "client_send", "client failed to send on socket\n"))
> +               goto cleanup;
> +
> +       start_iter_sockets(skel->progs.iter_tcp6);
> +
> +       n = send(clien, "t", 1, 0);
> +       if (CHECK(n > 0, "client_send after destroy", "succeeded on destroyed socket\n"))
> +               goto cleanup;
> +       CHECK(errno != ECONNABORTED, "client_send", "unexpected error code on destroyed socket\n");
> +

please don't use CHECK() macros, prefere ASSERT_xxx() ones

> +
> +cleanup:
> +       close(clien);
> +cleanup_serv:
> +       close(serv);
> +}
> +
> +
> +void test_udp(struct sock_destroy_prog *skel)

are these meant to be subtests? If yes, model them as such?

and in either case, make these funcs static

> +{
> +       int serv = -1, clien = -1, n = 0;
> +
> +       serv = start_server(AF_INET6, SOCK_DGRAM, NULL, 6161, 0);
> +       if (CHECK(serv < 0, "start_server", "failed to start server\n"))
> +               goto cleanup_serv;
> +

[...]
