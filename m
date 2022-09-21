Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956555BF1DA
	for <lists+bpf@lfdr.de>; Wed, 21 Sep 2022 02:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiIUAQN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Sep 2022 20:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiIUAQN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Sep 2022 20:16:13 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5793D5B6
        for <bpf@vger.kernel.org>; Tue, 20 Sep 2022 17:16:12 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 29so6290973edv.2
        for <bpf@vger.kernel.org>; Tue, 20 Sep 2022 17:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=kfaIidjhPEFv7JIhnK4MsTVGmdkBFkAnyoMHd0ScYmM=;
        b=BL5VprEWGVNSHztR1NGRy45earGsygjxoPF5XM/dfnisyAeXkrRCeIcZHXnbEffyFU
         1v5Eo2aZVDV2RjVtBv67z+yc3cu62MmRI8XUUxudsVsQ+U2teyZJWFEOwKbH4j23qPTX
         cmfUty6+kqSZqgOmFSEAjX9Q6cKibrPa7ViBsXkXuUKtFs8I6l3ZcP7SHWjFn674CX+X
         9mKisE85YhSdn2Cm2pVKpdm5GheV/oowtKr2rdDaXL40asixvoHhljZ/VpIGrOyjAM8Q
         E4vpZeRvBNr0nzjZ/J3pBNZAnd2rs6kYuZurEHQG3PdcVcTKbXgYXYlqb7tHVkCGmkux
         4qtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=kfaIidjhPEFv7JIhnK4MsTVGmdkBFkAnyoMHd0ScYmM=;
        b=uU0Qw+UbqgnZ16+yvFEcF44f9WQ7BFvex9UBvWzVtBithje5seOdv0myU2FCf3P2P7
         QnQGvaZMgjb8NQFA5hTtd7qK43AmtNeoxbedWK77Mk5+P43VgFHz3SZEL3Xof5CHiabk
         fNRnqaZKLLxKjFQ++69jiURIa3+/iAHHMvk0amlSd4WxPqLyK8OHxDpZ/eXb5HmW812p
         2hCf3JZionIc5umirUd19Pe5OBYIj/oeTYxUtwDzG+EmifY207/PRsq8CWr9ABiDbz5U
         rZ+05ME9yyIBbkoTxXUObXgJCd/8s8bgoSzV/XUNKJCckTFhhCqDOscrXcnpwRVBbPwr
         RzWA==
X-Gm-Message-State: ACrzQf0mQVAU1tUxGqq0bmBYdTPfGWRC65LwfRNJ/1sUL4X2nA3s2TcF
        zp7qLTzx8IKHDInOSJSwI0T+vWf622NMQDOi0zk=
X-Google-Smtp-Source: AMsMyM4ppNlvxPGw4QZR66BPDtl5/T/dRk7jVjc6urW9Sw9FZfQI2MQ+k11Dxay1fkAqkYNCvlyVNEsfNToLDmgET9A=
X-Received: by 2002:aa7:de9a:0:b0:44d:8191:44c5 with SMTP id
 j26-20020aa7de9a000000b0044d819144c5mr22563292edv.232.1663719370491; Tue, 20
 Sep 2022 17:16:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220920052045.3248976-1-arilou@gmail.com>
In-Reply-To: <20220920052045.3248976-1-arilou@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 20 Sep 2022 17:15:58 -0700
Message-ID: <CAEf4BzZ4NqN8e+7W03BWZvaNJ6s=u09vaC_siTh7P6UZrDGvfw@mail.gmail.com>
Subject: Re: [PATCH bpf v1] Fix the case of running rootless with capabilities
To:     Jon Doron <arilou@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        Jon Doron <jond@wiz.io>
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

On Mon, Sep 19, 2022 at 10:21 PM Jon Doron <arilou@gmail.com> wrote:
>
> From: Jon Doron <jond@wiz.io>
>
> When running rootless with special capabilities like:
> FOWNER / DAC_OVERRIDE / DAC_READ_SEARCH
>
> The access API will not make the proper check if there is really
> access to a file or not.
>

This is very succinct and doesn't explain why access() doesn't work. I
had to read the man page for access() to (hopefully) understand what's
going on. Please elaborate a bit more and maybe quote man page:

       The check is done using the calling process's real UID and GID,
       rather than the effective IDs as is done when actually attempting
       an operation (e.g., open(2)) on the file.  Similarly, for the
       root user, the check uses the set of permitted capabilities
       rather than the set of effective capabilities; and for non-root
       users, the check uses an empty set of capabilities.

       This allows set-user-ID programs and capability-endowed programs
       to easily determine the invoking user's authority.  In other
       words, access() does not answer the "can I read/write/execute
       this file?" question.  It answers a slightly different question:
       "(assuming I'm a setuid binary) can the user who invoked me
       read/write/execute this file?", which gives set-user-ID programs
       the possibility to prevent malicious users from causing them to
       read files which users shouldn't be able to read.

So if I understand correctly, access() is self-limiting itself
artificially, while in practice target file can be totally readable
due to caps or effective user ID differences.

Please try to summarize this in the commit message.

> Signed-off-by: Jon Doron <jond@wiz.io>
> ---
>  tools/lib/bpf/libbpf.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 50d41815f431..df804fd65493 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -875,8 +875,9 @@ __u32 get_kernel_version(void)
>         const char *ubuntu_kver_file = "/proc/version_signature";
>         __u32 major, minor, patch;
>         struct utsname info;
> +       struct stat sb;
>
> -       if (access(ubuntu_kver_file, R_OK) == 0) {
> +       if (stat(ubuntu_kver_file, &sb) == 0) {
>                 FILE *f;
>
>                 f = fopen(ubuntu_kver_file, "r");
> @@ -9877,9 +9878,10 @@ static int append_to_file(const char *file, const char *fmt, ...)
>  static bool use_debugfs(void)
>  {
>         static int has_debugfs = -1;
> +       struct stat sb;
>
>         if (has_debugfs < 0)
> -               has_debugfs = access(DEBUGFS, F_OK) == 0;
> +               has_debugfs = stat(DEBUGFS, &sb) == 0;
>

I found in total 5 access() uses in libbpf, can you please update the
other 3 as well? Thanks!


>         return has_debugfs == 1;
>  }
> --
> 2.37.3
>
