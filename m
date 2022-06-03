Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6B853CC1A
	for <lists+bpf@lfdr.de>; Fri,  3 Jun 2022 17:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245396AbiFCPO1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Jun 2022 11:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245397AbiFCPO0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Jun 2022 11:14:26 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABC85047D
        for <bpf@vger.kernel.org>; Fri,  3 Jun 2022 08:14:25 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id er5so10550612edb.12
        for <bpf@vger.kernel.org>; Fri, 03 Jun 2022 08:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X3noosLwoWOsxQcTBZb6SHxCLsqhFs8TEusaeBwPZiI=;
        b=pam5/u0t7bfUPfGgsxN027Yndmb+XQKtIZ1k0KlJL+9OtSwak2H8FBgtIsbOTg3Rhb
         lMWRN24f2hAninZATUrX/AYqLLf3ZGjy4G0Gu1UYnbm1Bikdokf3b7+2Ox5SvYmet65j
         CluL4BOIF7NjrXSxPeyAEDDHx99zQf9M9yGAu9xFkYOiKPLIBh/BZEdcHpg7GdxNZzob
         uuno14sfb9KiEWZBRMBPRLvRUmKl9HZ3ea/yHPWYy8DIAl0jmISgkQFvRFR+pYkjARiT
         YUAA5BRZv8uGeWxVjJWKzdGngxEMSLzaybZxOtp9pA6TrGiohQGHIPUi7YemI61wa18E
         xJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X3noosLwoWOsxQcTBZb6SHxCLsqhFs8TEusaeBwPZiI=;
        b=Yqc9DXZeF0uQIydPbYEUsuEoHRjyXWBj5CEor68Cw82RRZJK0aOaPpWxjhdcELlhNe
         tsu0lLyeIlCL8mdsjpJoRvpoUu8aIWHAXk41p62xLz1EQjNr4qccEesLkLI7FVp9R2Om
         MF8FvpxkZXwDniqRLUDSAQ+gf4PtJPEno4lBddFRIOi+xJAab5DxmmhE9rvGhcMd7rSm
         K+VJahzpTXGOEZugB5zFiVO+rEYRRceVqaZq9r1N8vhFU+4w3A2kY8XU3mYfSBG6YQHy
         UP31ZspWkeDWPfLnqiDFgCoMobmDDDdy4aJMkl1JKeuDytKzHanpUCjRwau4svMsTYOW
         dydQ==
X-Gm-Message-State: AOAM5337S7x0HSc6v4rMRkOUClYOJJ3GQgtRnX8z5JDn4CgR/3kPnSnC
        2bMN3L3N9DBtJbUx78iTUd7lm3S34t+2NmQBgvI=
X-Google-Smtp-Source: ABdhPJxhHcOT92fRxgVvJ+VXgUfEuMZYs80jyMIxAND5z4b/DRzQfcEQYQTy2EC/xCyYRwX/O9+E1iwO78lPZi/4rno=
X-Received: by 2002:a05:6402:4145:b0:42d:842a:f916 with SMTP id
 x5-20020a056402414500b0042d842af916mr11158440eda.357.1654269263646; Fri, 03
 Jun 2022 08:14:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220603015855.1187538-1-yhs@fb.com> <20220603020019.1193442-1-yhs@fb.com>
In-Reply-To: <20220603020019.1193442-1-yhs@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 3 Jun 2022 17:14:11 +0200
Message-ID: <CAADnVQJgH6X66Rg0Z5v8pTsnfZBsHeaEko6rYv=ON6RQ+2FVPA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 16/18] selftests/bpf: Add a test for enum64
 value relocations
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 3, 2022 at 4:00 AM Yonghong Song <yhs@fb.com> wrote:
> +
> +SEC("raw_tracepoint/sys_enter")
> +int test_core_enum64val(void *ctx)
> +{
> +#if __has_builtin(__builtin_preserve_enum_value)
> +       struct core_reloc_enum64val_output *out = (void *)&data.out;
> +       enum named_unsigned_enum64 named_unsigned = 0;
> +       enum named_signed_enum64 named_signed = 0;

libbpf: prog 'test_core_enum64val': relo #0: unexpected insn #0
(LDIMM64) value: got 8589934591, exp 18446744073709551615 ->
18446744073709551615
libbpf: prog 'test_core_enum64val': relo #0: failed to patch insn #0: -22
libbpf: failed to perform CO-RE relocations: -22
libbpf: failed to load object 'test_core_reloc_enum64val.o'

Is it failing in CI because clang is too old?
CI will pick up newer clang sooner or later,
but the users will be confused.
The patch 17/18 that updates README certainly helps,
but I was wondering whether we can do a similar trick
to what Andrii did in libbpf and make the error more human readable?
