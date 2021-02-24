Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDB3E3237D3
	for <lists+bpf@lfdr.de>; Wed, 24 Feb 2021 08:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbhBXHTa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Feb 2021 02:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbhBXHT1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Feb 2021 02:19:27 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80666C061786
        for <bpf@vger.kernel.org>; Tue, 23 Feb 2021 23:18:47 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id f4so881855ybk.11
        for <bpf@vger.kernel.org>; Tue, 23 Feb 2021 23:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NxbyaKrGpu4tvvyrlIAf54x18SWwOhRwOQTWlKA06co=;
        b=aec9VmSs+lS6RKRWkie6ZHwfS2xWu6FYLwScNzscHYUk21trXrbtlu8Hxma1+SGhX9
         91EBqroD4p3XAYOPCyTIA4T6IeYqpUwCa+N4815Zx/V8gJbqX5K4orIjoCt16TOSqH1D
         RARBieDSwY3C7ZGyRl+7ifnHkCnNGg/99y2uTC4dEWIgx9qrMMNwCVcJBKWyaA+oqNlS
         WSusy7PFadPiz7WVxLY27mqEbzZjfZVVCiE7K0FtWHQ9TgNVriomMYbMytVzQKR6J6Rq
         yhtkEgU7i965PRz84nVtSLPZvnCNuAnnUd9XuxTx3nUIi9t6RD8dId45Kls2wQLAcyzW
         HtdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NxbyaKrGpu4tvvyrlIAf54x18SWwOhRwOQTWlKA06co=;
        b=q7asB4RrNc1xjj1b+wjkHdRWmARmXK5xsW/Zx52X22l9AIq8b5kLkF4lhjY5hQRs+k
         86NmJFcTUYLLPXXn98tSa99cSG0tbU9NmJWjgyw2uqq6vMJMo6yyM15ltEZbWq4GayS1
         hiT8IG2nl38z4vnFnKaT97Uko1nOwQHAtr9fN4JccrNSTn0PcUr/wSpgZG3aLUaqhnIG
         tNYmhYPGJNQHTyJBoiJC48hu7DmidFiUIxkT89zs2/m3MWV6myfVF2pekm1d9foYvj0D
         Z/Os8gsFZIyerhn8LyZLOpF2eInr128TnCqCj5J26Zufr0k5OFtVA3eK4gb7MgFNhfIq
         6vcg==
X-Gm-Message-State: AOAM533nxled2YCYy4+LjiOiu95I1rVT4IKBCTl5mHp65L2QMahUfpvR
        /e2GgN51tRhkV6lEjnfLsW/HkIxGepTJo17IV1M=
X-Google-Smtp-Source: ABdhPJz1F9ZotKmU+EmEn/DzISuMvuHqGHG7RR7M74uwBX4p0v/+eaySZsmTBhqWRlKTWjbW/A8NJspLCBeJm1eF9eg=
X-Received: by 2002:a25:37c4:: with SMTP id e187mr47377505yba.347.1614151126701;
 Tue, 23 Feb 2021 23:18:46 -0800 (PST)
MIME-Version: 1.0
References: <20210222232451.84574-1-iii@linux.ibm.com>
In-Reply-To: <20210222232451.84574-1-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 23 Feb 2021 23:18:35 -0800
Message-ID: <CAEf4BzZ97LryiKX2K8vZhdbhW_SFUMDwkXpJyz89QVhLrYk+7A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Copy extra resources in the
 non-flavored build too
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 22, 2021 at 3:25 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> Building selftests in a separate directory like this:
>
>     make O=... -C tools/testing/selftests/bpf
>
> and then running:
>
>     ./test_progs -t btf
>
> causes all the non-flavored btf_dump_test_case_*.c tests to fail,
> because these files are not copied to where test_progs expects to find
> them.
>
> Fix by removing the flavored build check and using rsync instead of cp:
> cp fails because e.g. urandom_read is being copied into itself, and
> rsync simply skips such cases. rsync is used by kselftests elsewhere
> and therefore is not a new dependency.

So this leaves a bunch of non-ignored files in selftests/bpf directory:

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        btf_dump_test_case_bitfields.c
        btf_dump_test_case_multidim.c
        btf_dump_test_case_namespacing.c
        btf_dump_test_case_ordering.c
        btf_dump_test_case_packing.c
        btf_dump_test_case_padding.c
        btf_dump_test_case_syntax.c

We can add them to .gitignore, but that feels wrong, to be honest. Any
ideas how to fix this in some better way?

>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tools/testing/selftests/bpf/Makefile | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 044bfdcf5b74..192119f6aeb7 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -382,12 +382,9 @@ $(TRUNNER_EXTRA_OBJS): $(TRUNNER_OUTPUT)/%.o:                              \
>         $$(call msg,EXT-OBJ,$(TRUNNER_BINARY),$$@)
>         $(Q)$$(CC) $$(CFLAGS) -c $$< $$(LDLIBS) -o $$@
>
> -# only copy extra resources if in flavored build
>  $(TRUNNER_BINARY)-extras: $(TRUNNER_EXTRA_FILES) | $(TRUNNER_OUTPUT)
> -ifneq ($2,)
>         $$(call msg,EXT-COPY,$(TRUNNER_BINARY),$(TRUNNER_EXTRA_FILES))
> -       $(Q)cp -a $$^ $(TRUNNER_OUTPUT)/
> -endif
> +       $(Q)rsync -aq $$^ $(TRUNNER_OUTPUT)/
>
>  $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)                      \
>                              $(TRUNNER_EXTRA_OBJS) $$(BPFOBJ)           \
> --
> 2.29.2
>
