Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398DA6105F2
	for <lists+bpf@lfdr.de>; Fri, 28 Oct 2022 00:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiJ0WvX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Oct 2022 18:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiJ0WvX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Oct 2022 18:51:23 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BE3814E5
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 15:51:22 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id b2so8884363eja.6
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 15:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FI6EydJ4+QguR5dL1swXn9daBBB3phwCKywO4y4SYPU=;
        b=U4o4gp5uy/ybLq2lUfZfUTO4wwbgJltnJ8zoYa/sRCkysQfXq11rLvj6sZcdNS73CC
         DmZxvs1hxRpUMA6iCuOyJaIKe0fu9/Gi8/yj29Gx20kMM4+io8QYpnaKdABj+devQEpW
         JCbSuIauz1+bFKsHKydPVohk/gBiHl33FiCKw86BZv104zLfh6Cp8bplweToiKp4nSZ9
         z+E5GHUvbV/A/UZroU2hH84hOEjW1BjWih/sRzr/Fp+HG6DIB2yOqcoizY1HKtdmOzEN
         gz9Pp3zlYaqvP8m85VyqylSXo46YzsuQcckpUdjXVwOchmqgtjX50ZwAMCA0MnA7M+dD
         zYzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FI6EydJ4+QguR5dL1swXn9daBBB3phwCKywO4y4SYPU=;
        b=nyvPjqhT9yrCyhfYNqQjLj/pbXeXpwKErpTUrhWkKcA3th/D0DGRsD5zPnmxNzsa+r
         qx9uLUudDUA0uafVfOOwojaqQwCv3K3JrYgt97fKzOuxit6V+S7pDcGEo/cf46fLxVAl
         1q7oK12H7sPy9QU658eUTpZx8TigkVLRfdPhcJ70pwrEGZnO1i6odrwXRs8fh3Mcn/os
         YDnPHpgor/kaZCd423URFJJ/OUQAwxKMzkSeUGojhI9XpFvSPDQDd1pcmjR9MFVvKU/9
         7S+S+zdZYCslH1xSM2NMZEojfohepviNLhzMvqyj6645e+7C3aFJMJ+B6Xny+BiWGWBC
         vjUQ==
X-Gm-Message-State: ACrzQf26wumlQyTawKgpVNBlKVbwZSm/Te3OSIPdvC973oZTyqmFUqtU
        U7XfhEmh+ldSb4uqMkaCTV8vBPjk/k5OSDsnNaM=
X-Google-Smtp-Source: AMsMyM59POp33xYZfI9fyZdNrOeQvT5wXkFJjgDuyh7sco+qovQYgtSBFVN3ykKfAfk6l/d3jLnZbz0xMTL91jYh5dU=
X-Received: by 2002:a17:907:75e6:b0:7a1:848:20cb with SMTP id
 jz6-20020a17090775e600b007a1084820cbmr27034012ejc.745.1666911080925; Thu, 27
 Oct 2022 15:51:20 -0700 (PDT)
MIME-Version: 1.0
References: <20221025222802.2295103-1-eddyz87@gmail.com> <20221025222802.2295103-9-eddyz87@gmail.com>
In-Reply-To: <20221025222802.2295103-9-eddyz87@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 27 Oct 2022 15:51:08 -0700
Message-ID: <CAEf4BzapsvxAjG0BYEG0umU4Hne7p6Hgpz6c04-BpQKwgvS+DQ@mail.gmail.com>
Subject: Re: [RFC bpf-next 08/12] kbuild: Script to infer header guard values
 for uapi headers
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com,
        arnaldo.melo@gmail.com
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

On Tue, Oct 25, 2022 at 3:28 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> The script infers header guard defines in headers from
> include/uapi/**/*.h . E.g. header guard for the
> `include/uapi/linux/tcp.h` is `_UAPI_LINUX_TCP_H`:
>
>     include/uapi/linux/tcp.h:
>
>       #ifndef _UAPI_LINUX_TCP_H
>       #define _UAPI_LINUX_TCP_H
>       ...
>       union tcp_word_hdr {
>             struct tcphdr hdr;
>             __be32        words[5];
>       };
>       ...
>       #endif /* _UAPI_LINUX_TCP_H */
>
> The output of the script could be used as an input to pahole's
> `--header_guards_db` parameter. This information is necessary to
> repeat the same header guards in the `vmlinux.h` generated from BTF.
>
> It is not possible to infer the guard names from header file names
> alone, the file content has to be analyzed. The following heuristic is
> used to infer guard for a specific file:
> - All pairs `#ifndef <candidate>` / `#define <candidate>` are collected;
> - If a unique candidate matching regex `${headername}.*_H(EADER)?` it
>   is selected;
> - If a unique candidate matching regex `_H(EADER)?_` it is selected;
> - If a unique candidate matching regex `_H(EADER)?$` it is selected;
>
> There is also a small list of headers that can't be caught by the
> rules above, 15 in total. These headers and corresponding guard values
> are listed in the `%OVERRIDES` hash table.
>

Instead of expecting naming pattern, why can't we just expect

/* some comments here */

#ifndef XXX
#define XXX
....
#endif

and extract XXX from such a pattern?

The harder part is skipping comments (but awk might help do this
easier), or we can just ignore all the lines before the first #ifndef.

WDYT?

> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  scripts/infer_header_guards.pl | 191 +++++++++++++++++++++++++++++++++
>  1 file changed, 191 insertions(+)
>  create mode 100755 scripts/infer_header_guards.pl
>

[...]
