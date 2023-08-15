Return-Path: <bpf+bounces-7847-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 110F677D697
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 01:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 397BD1C20DBC
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 23:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F3A1AA60;
	Tue, 15 Aug 2023 23:20:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F0917AD9
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 23:20:35 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B91E7A
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 16:20:33 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fe1d462762so54933205e9.0
        for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 16:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692141632; x=1692746432;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rjlPZEzSqDJhHjOX2uK7rQdBzBOv8J5AkaiN7MVRV/s=;
        b=puEtCLPXcPwvMWczaNwsCIINolBj+SM86ZC+HvGEJxSJoQzqJvuP/+F2fbX/bbg8g9
         kH7mRjJQTnYy5ZJLO/qJBvyo8A3Wh06m+Q19K1CjWiKiW9MMoor8XM4XrFMmd+qrTDe2
         iRGRLilE02zNrPADW63Sai4t5SWF6MO6WKHL2u9hoWk85MEzkP7cEK8EOKh3Zuf7nDNO
         LILwfCrxX11eHXJlVWkLtwqdr8AUaGxm8oh9yTKIrG42KYd7b/lfvGNmXhoY9XIHo4/f
         Mrh4rDJl+2Vkhrf4wwNyqQXm7uDTNaC85u/XHm3xrgtAUIt3KO5jDEWf2vcf25Vp7i2E
         CpxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692141632; x=1692746432;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjlPZEzSqDJhHjOX2uK7rQdBzBOv8J5AkaiN7MVRV/s=;
        b=c3ZjQCls9+kP2hPnmOvTzE6ahH5RJS3DxT4OPahUIzpeJnXYowfnb8emIgOK/uWGNI
         4E02+eLSKSPIkoaS9bptiik0uHdbSzratoxZ2Aa2Fjvu/L9EhYR/PNnSLtuf53Ccz7dJ
         C80npDofLiCba4MQ0ramZmD8UWpw40BjzkSsiNHI4gVHJRFioQ+NQSbdBXko+oyikjqT
         gqCaSaVdWEDmOHZZ0i2VtQMGHKH9DjFEd8JVEqKNDhruAAARLvhFteHBGIC98xkGCj7/
         WVMHHDCJLHO48tqhWK+PP5ZVOOsdcToJr8P22aVjKDqwvJyUftXfdHw8vzX7aSzjOoYh
         QVeA==
X-Gm-Message-State: AOJu0Yz2TNeQQvJ4nYi1L4Zoc9aN0/khd6y9ekrtJCg/Xixuj2BYZ/bn
	oWXyVvIGuuPvVJVEnAuc0Cg=
X-Google-Smtp-Source: AGHT+IF0BzYjQ/eAgTbATdXyCtFzMbkPTtI78tnXM/1htfqUNjdNwZ84cuXhiIJmZw3iUyC/NSqSyw==
X-Received: by 2002:adf:e28b:0:b0:318:7bb:e9af with SMTP id v11-20020adfe28b000000b0031807bbe9afmr103774wri.55.1692141632050;
        Tue, 15 Aug 2023 16:20:32 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id d15-20020a056402516f00b005256771db39sm3064713ede.58.2023.08.15.16.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 16:20:31 -0700 (PDT)
Message-ID: <1c33c4e5866c36ae5cec80df77f05009c95f078a.camel@gmail.com>
Subject: [Question] test_skeleton selftest build failure on LLVM main
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yhs@fb.com>, "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: bpf@vger.kernel.org, david.faust@oracle.com
Date: Wed, 16 Aug 2023 02:20:30 +0300
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Yonghong, Jose,

I've noticed today that LLVM main started producing an error when
compiling selftest test_skeleton.c:

    progs/test_skeleton.c:46:20: error: 'in_dynarr_sz' causes a section typ=
e conflict with 'in_dynarr'
       46 | const volatile int in_dynarr_sz SEC(".rodata.dyn");
          |                    ^
    progs/test_skeleton.c:47:20: note: declared here
       47 | const volatile int in_dynarr[4] SEC(".rodata.dyn") =3D { -1, -2=
, -3, -4 };
          |                    ^
    1 error generated.
      CLNG-BPF [test_maps] test_sk_storage_trace_itself.bpf.o
    make: *** [Makefile:594: /home/eddy/work/bpf-next/tools/testing/selftes=
ts/bpf/test_skeleton.bpf.o] Error 1

The code in question looks as follows:

    ...
    const volatile int in_dynarr_sz SEC(".rodata.dyn");
    const volatile int in_dynarr[4] SEC(".rodata.dyn") =3D { -1, -2, -3, -4=
 };
    ...

In fact, it could be simplified to the following example:

    #define SEC(n) __attribute__((section(n)))

    const int with_init SEC("foo") =3D 1;
    const int no_init SEC("foo");

And error is reported for x86 build as well:

    $ clang -c t.c -o /dev/null
    t.c:4:11: error: 'no_init' causes a section type conflict with 'with_in=
it'
        4 | const int no_init SEC("foo");
          |           ^
    t.c:3:11: note: declared here
        3 | const int with_init SEC("foo") =3D 1;
          |           ^
    1 error generated.

The error occurs because clang infers "read only" attribute for
section "foo" when `with_init` is processed and "read/write"
attributes for section "foo" when `no_init` is processed.
The attributes do not match and error is reported.
(See Sema::UnifySection, `diag::err_section_conflict` diagnostic).

The culprit is revision [1] which landed today. The main focus of that
revision is C++ and handling of structure fields marked as `mutable`.
However, it also adds a new requirement: for global value to be
considered "read only" it must have an initializer
(the `var->hasInit()` check in [2]).

GCC can handle the example above w/o any issues.
The relevant part of the C standard [3] is "6.7.3 Type qualifiers",
but it does not discuss sections, the only section-related sentence
that I found is:

> 160) The implementation can place a const object that is not
>      volatile in a read-only region of storage. Moreover, the
>      implementation need not allocate storage for such an object if
>      its address is never used.

Which does not make example at hand invalid.

Although `const` values w/o initializer do seem strange they might
have some sense if, say, linker materializes these definitions with
something useful.

Thus, it appears to me that:
- test_skeleton.c is ok and should not be changed;
- revision [1] introduced a bug and I should bring it up with upstream.
 =20
What do you think?

Thanks,
Eduard

[1] https://reviews.llvm.org/D156726
[2] https://github.com/llvm/llvm-project/compare/main...llvm-premerge-tests=
:llvm-project:phab-diff-550097#diff-edac6256ac508912a16d0165b2f8cf37123dc2f=
40a147dca49a34c33f1db13ddR14366
[3] https://www.open-std.org/jtc1/sc22/wg14/www/docs/n3088.pdf


