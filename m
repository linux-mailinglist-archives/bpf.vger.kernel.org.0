Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF85623B1A
	for <lists+bpf@lfdr.de>; Thu, 10 Nov 2022 06:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiKJFCT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Nov 2022 00:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiKJFCT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Nov 2022 00:02:19 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34552165A6
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 21:02:17 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id a13so1420873edj.0
        for <bpf@vger.kernel.org>; Wed, 09 Nov 2022 21:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kaV0BbvpIy/0LDBs+pCO9W9XyXVj1dABuJc0LFqLr6c=;
        b=GIQor+3V7adPeTYd8L11CdRw0EqdBWvt1xpkJPe44ygzlT3RXWSFSqHCTi/UQo3cr/
         QNeyPLN4zsw1+8KGNA5D8+VGQa+6Mzo7zzhAv29gu829hr27LH9QOfD6vgQR5E6ln31p
         oLz8/H6s2CL/A1A3V8pPwHpxfqSlDGInwRYMnA7IAgBN4tgfgv4kxH4Zln655akQVEH0
         xnRvG25QaUuDNE0QVXinLo3k3vYPzr+Ug0phHZMJtyNjDCl/P4ZgQfiMjDMauRKLi8mV
         fmOtF4JJBsDr6ZnUaKIdxTaFcWdGksULGbgOOAhDa9NK7lbMAiIlc2lDwb9sjMGvl9bH
         +/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kaV0BbvpIy/0LDBs+pCO9W9XyXVj1dABuJc0LFqLr6c=;
        b=fvttc0jvz1Ex7tLPKzDcWXONYb9j8vQxwlJKkDYf4apFihjbUlHiCyZrS9v/7y6ofY
         ELvz8yTcZCCXdrrXZKDYZXFhw+ABVbqLivimeAnD22QDAUHnzR+RL+ot+5CqAF9KrNUS
         zksJ+Ne/qpCEmnH9XmLoVZgughoIKW+teECk5y7qmgnIwzNUJBHcP92AvKMmT/LnS8+x
         f+ZhO1gf2h+5Ohs96M57XrBk5K9bijC2uzTQFaMieGf16NXjLXLuUptotIVogIoOw4XN
         N3MHsAQJMW8dnO+GOiGQJFWWJ0PpiybhliX2Rz73JTiLpXC71tg06Pb8QVr8qAslAbQO
         v/0w==
X-Gm-Message-State: ACrzQf2p0c5rw7G7k23Hn6akqzcN61mWvPSRaygEtXbYn177cGqK+XrR
        qv8roNamgR3KP3pAnKq87tujRej7Xp1u5a2+DFk=
X-Google-Smtp-Source: AMsMyM6TDAC9gGbX/0aJOKZZheBtWFGwOwwQNRcqKD1VE0croYL+aTZb0KHQxI6qu5nnY2MxXeVE3y+ilYp0AY68EBc=
X-Received: by 2002:aa7:d58f:0:b0:461:524f:a8f4 with SMTP id
 r15-20020aa7d58f000000b00461524fa8f4mr1658847edq.260.1668056535461; Wed, 09
 Nov 2022 21:02:15 -0800 (PST)
MIME-Version: 1.0
References: <20221108153135.491383-1-eddyz87@gmail.com>
In-Reply-To: <20221108153135.491383-1-eddyz87@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 9 Nov 2022 21:02:03 -0800
Message-ID: <CAEf4BzYHJYbm-BY3JLnREKZ27ZMUHQ-1UN3xbSyt1LfCNzgvEw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/3] libbpf: btf_decl_tag attribute for btf
 dump in C format
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com
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

On Tue, Nov 8, 2022 at 7:32 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> Support for clang's __attribute__((btf_decl_tag("..."))) by
> btf_dump__dump_type and btf_dump__dump_type_data functions.
> Decl tag attributes are restored for:
> - structs and unions
> - struct and union fields
> - typedefs
> - global variables
> - function prototype parameters
>
> The attribute is restored using __btf_decl_tag macro that is printed
> upon first call to btf_dump__dump_type function:
>
>  #if __has_attribute(btf_decl_tag)
>  #define __btf_decl_tag(x) __attribute__((btf_decl_tag(x)))
>  #else
>  #define __btf_decl_tag(x)
>  #endif
>
> To simplify testing of the btf_dump__dump_type_data the
> prog_tests/btf_dump.c:test_btf_dump_case is extended to invoke
> btf_dump__dump_type_data for each DATASEC object in the test case
> binary file.
>
> Changelog:
> v1 -> v2:
> - prog_tests/btf_dump.c:test_btf_dump_case modified to print DATASECs
>   using btf_dump__dump_type_data;
> - support for decl tags applied to global variables and function
>   prototype parameters;
> - update to support interleaved calls to btf_dump__dump_type and
>   btf__add_decl_tag (incremental dump);
> - fix for potential double free error in btf_dump_assign_decl_tags;
> - styling fixes suggested by Andrii.
>
> RFC -> v1:
> - support for decl tags applied to struct / union fields and typedefs;
> - __btf_decl_tag macro;
> - btf_dump->decl_tags hash and equal functions updated to use integer
>   key instead of a pointer;
> - realloc_decl_tags function removed;
> - update for allocation logic in btf_dump_assign_decl_tags.
>
> [v1]  https://lore.kernel.org/bpf/20221103134522.2764601-1-eddyz87@gmail.com/
> [RFC] https://lore.kernel.org/bpf/20221025222802.2295103-4-eddyz87@gmail.com/
>
> Eduard Zingerman (3):
>   libbpf: __attribute__((btf_decl_tag("..."))) for btf dump in C format
>   selftests/bpf: Dump data sections as part of btf_dump_test_case tests
>   selftests/bpf: Tests for BTF_KIND_DECL_TAG dump in C format
>
>  tools/lib/bpf/btf_dump.c                      | 186 +++++++++++++++-
>  .../selftests/bpf/prog_tests/btf_dump.c       | 198 ++++++++++++++++--
>  .../bpf/progs/btf_dump_test_case_decl_tag.c   |  65 ++++++
>  3 files changed, 427 insertions(+), 22 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/btf_dump_test_case_decl_tag.c
>
> --
> 2.34.1
>


with your other patch set applied this doesn't apply cleanly anymore,
please rebase and resubmit
