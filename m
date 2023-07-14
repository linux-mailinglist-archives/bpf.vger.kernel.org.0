Return-Path: <bpf+bounces-5041-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C15CB7542A0
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 20:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D34C28220D
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 18:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FAC154A0;
	Fri, 14 Jul 2023 18:34:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD13F13715
	for <bpf@vger.kernel.org>; Fri, 14 Jul 2023 18:34:54 +0000 (UTC)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA372680
	for <bpf@vger.kernel.org>; Fri, 14 Jul 2023 11:34:51 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-346258cf060so16815ab.0
        for <bpf@vger.kernel.org>; Fri, 14 Jul 2023 11:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689359690; x=1691951690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MoxXHdLDuf7uBFW6SzS0r7koKHamZIMQJhfLSozBhPo=;
        b=CoJVUT8LU2AtfsX0295LW0wALbl6vjYJVVvw4PYNsoOUACUrTE5e7vF2/JNBuTVytu
         1YN5mfJ5LmOjGrkFWCjokami+/m/20rMXkXJE+kyg8lWJV1fM/eT2A5BSdTJVC10fUVP
         m/jcur+F1HfXOrnBNG3g4Z19YMly7vmf9OEGqCUncUEzhxkpRosdoOP4mfNJoabA4aFt
         bFSjNtQ8UDmaME5akhRaiUq6QjCF6ow/oqaG67xGj8OmK0bkihegJlrVL02S3uaHb+gx
         KJOLY1eELEHcsQjQJkzgzu2IlUsCPPJn84DLtUo2c4kVvsCgeYxQ7CLrtnN9yNYVzjuO
         7vsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689359690; x=1691951690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MoxXHdLDuf7uBFW6SzS0r7koKHamZIMQJhfLSozBhPo=;
        b=dRJvhOm9BvmaAo3YVkuyG5gQYPZXGMAbgrxCfv2Og/sbKbVC02ijp0Em1AdpCuAdlU
         vyhNCIaNPePpf0hCJz3Ow+XkaDAbEdnF1vz/0p7xrxsTAO5Bou7BvOIuLGdSSV3u40gi
         Lffs71GJ1rv5YmiLiz2kOZPT3Uf7dXoMbxhoU0nrM8oQwTktMWxyYbwXlCIl0oOsyakB
         EEXJyWGYm5oG0onbY0VmXfFiUQVTM2LlyBjPkM41NXyFywINqd5aFUv4ke+nOiMasrxd
         zWH+FZQGT/2uX+kD5TnKKC7kchIVNn2mDi5Op9aMcqqQUEuwAGMo1JgXHm66OpM/fqHD
         KA5Q==
X-Gm-Message-State: ABy/qLYANW3J7Fsa1Z2ok72QxgVWuf6wgPT/1gCCSq6OfLv3xRHJlgju
	B1UJWUezR+JTBk17rGMAj7kn+cJw4XrgnHx57j7oGg==
X-Google-Smtp-Source: APBJJlFBXB7QiI9ztuQ6QNS2GQgouY4NGeveevYonN6Nbqt7+SK1nGopO9WtPJnQWR/2BpnoHFgPXaVz7Pqdzg6CKF4=
X-Received: by 2002:a05:6e02:1a61:b0:33d:8f9f:9461 with SMTP id
 w1-20020a056e021a6100b0033d8f9f9461mr972322ilv.18.1689359690226; Fri, 14 Jul
 2023 11:34:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1687443219-11946-1-git-send-email-yangtiezhu@loongson.cn> <1412dbaf-56f4-418b-85ea-681b1c44cc26@app.fastmail.com>
In-Reply-To: <1412dbaf-56f4-418b-85ea-681b1c44cc26@app.fastmail.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 14 Jul 2023 11:34:38 -0700
Message-ID: <CAP-5=fWmPQ9vtH1t9pSPCPBiOFxQQe43C7Bk4amLS08ASAnwGg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Unify uapi bitsperlong.h
To: Arnd Bergmann <arnd@arndb.de>, Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	loongarch@lists.linux.dev, Linux-Arch <linux-arch@vger.kernel.org>, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023 at 8:10=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Thu, Jun 22, 2023, at 16:13, Tiezhu Yang wrote:
> > v3:
> >   -- Check the definition of __BITS_PER_LONG first at
> >      the beginning of uapi/asm-generic/bitsperlong.h
> >

Thanks for doing this cleanup! I just wanted to report an issue I ran
into with building the Linux perf tool. The header guard in:
tools/include/asm-generic/bitsperlong.h
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/too=
ls/include/asm-generic/bitsperlong.h

Caused an issue with building:
tools/perf/util/cs-etm.c
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/too=
ls/perf/util/cs-etm.c

The issue was that cs-etm.c would #include a system header, which
would transitively include a header with the same header guard. This
led to the tools/include/asm-generic/bitsperlong.h being ignored and
the compilation of tools/perf/util/cs-etm.c failing due to a missing
define. My local workaround is:

```
diff --git a/tools/include/asm-generic/bitsperlong.h
b/tools/include/asm-generic/bitsperlong.h
index 2093d56ddd11..88508a35cb45 100644
--- a/tools/include/asm-generic/bitsperlong.h
+++ b/tools/include/asm-generic/bitsperlong.h
@@ -1,6 +1,6 @@
/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __ASM_GENERIC_BITS_PER_LONG
-#define __ASM_GENERIC_BITS_PER_LONG
+#ifndef __LINUX_TOOLS_ASM_GENERIC_BITS_PER_LONG
+#define __LINUX_TOOLS_ASM_GENERIC_BITS_PER_LONG
#include <uapi/asm-generic/bitsperlong.h>
@@ -21,4 +21,4 @@
#define small_const_nbits(nbits) \
(__builtin_constant_p(nbits) && (nbits) <=3D BITS_PER_LONG && (nbits) > 0)
-#endif /* __ASM_GENERIC_BITS_PER_LONG */
+#endif /* __LINUX_TOOLS_ASM_GENERIC_BITS_PER_LONG */
```

I'm not sure if a wider fix is necessary for this, but I thought it
worthwhile to report that there are potential issues. I don't think we
can use #pragma once, as an alternative to header guards, to avoid
this kind of name collision.

Thanks,
Ian


> > v2:
> >   -- Check __CHAR_BIT__ and __SIZEOF_LONG__ rather than
> >      __aarch64__, __riscv, __loongarch__, thanks Ruoyao
> >   -- Update the code comment and commit message
> >
> > v1:
> >   -- Rebase on 6.4-rc6
> >   -- Only unify uapi bitsperlong.h for arm64, riscv and loongarch
> >   -- Remove uapi bitsperlong.h of hexagon and microblaze in a new patch
> >
> > Here is the RFC patch:
> > https://lore.kernel.org/linux-arch/1683615903-10862-1-git-send-email-ya=
ngtiezhu@loongson.cn/
>
> I've applied these to the asm-generic tree now
>
> Thanks,
>
>    Arnd

