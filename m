Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB38E1DC187
	for <lists+bpf@lfdr.de>; Wed, 20 May 2020 23:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgETVpc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 May 2020 17:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728019AbgETVpc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 May 2020 17:45:32 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B99C061A0E
        for <bpf@vger.kernel.org>; Wed, 20 May 2020 14:45:32 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 142so5255947qkl.6
        for <bpf@vger.kernel.org>; Wed, 20 May 2020 14:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ImoIHuFvHoMO0gWqFgEtRwQa4LB065DY+2eyFbUKhZk=;
        b=Pw/4+OX0rQc4l8X1OWzfbfoj547x0qt3PJWfnvkZMxzmJLp6AE9o7Ix9Gg6Krt6kph
         RIQAjsVyxxNgZSb6nc7IPlcmZE7HyV3C4Hr6axUwX45kLyUzmg81/Jjg3FcXz8vCC4U1
         rbxP6lswF7OhiH/FFWqjKH7knweo1XH6SR861eXIyBxyRVd+mzme1NoHJSEb95uHNvwV
         dWzcIffKA/OmOCCrrnixom874Bh2A8/Rxc7ds1xAsidjhVsjiEFsUkn6P8K7Hu0aVuiS
         fhDsGAp/a5SnwWBRNDvzxPWcWeLvyQk7H2I7ZxDKpf5Xv4m3W1+jx+TveH4mBOiviDv+
         KOQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ImoIHuFvHoMO0gWqFgEtRwQa4LB065DY+2eyFbUKhZk=;
        b=LrHk6Rfc3xK442fl32gnMbK94f+U8ePMysPmvIaHb31IojxGSi2SXHE6NPUWognpk1
         J7mMJwJMF5oUd/cNmEyG0mP7cDt/NE0POa/ZT7R8HLku/MqUttDqEOzwtv7SdvnyK1La
         m4U5RNPqyfbdRmYe0sEFqvkkHa9T9YCfHpMuk04JcbJoC4oZdRkNxcvWN2/4jxSdqAQU
         sFmS0/3D8h0OjIHsrj1WQgAgdjpBl9zlpeq6w0ThgrXXspngL8n1vswDZQowOwVXFYQG
         jxPEjvAQN5Mx7YZurELyitnRWJePJqHuCm8V7+7eCrEIatwMfOgSBlyqEqvHMzQ/ZHMY
         35Ew==
X-Gm-Message-State: AOAM5318rzEbZ8SASoyylQx+TThXjYi7l79EQG33NOhqzGBiR0cQAoXV
        eUBxPUASqL6ctzR+ILOy7WG/p/ZRJ3LQ0a9FAvQ=
X-Google-Smtp-Source: ABdhPJx66027ZdoDLKaa1Lo+imZ7LSBtev7uoA+iy05pYxEqV8hoD7ba5f6QiFB4Klp3QoLxop84EwDrRVnYM1CBymY=
X-Received: by 2002:a05:620a:247:: with SMTP id q7mr947251qkn.36.1590011131656;
 Wed, 20 May 2020 14:45:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200519084957.55166-1-yauheni.kaliuta@redhat.com>
 <CAEf4Bzb-FjHtH9dyVtjZf7FYBB2BiPs0mK8ZoqH3B9iU5Hz7Mg@mail.gmail.com> <xuny7dx7nnbc.fsf@redhat.com>
In-Reply-To: <xuny7dx7nnbc.fsf@redhat.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 20 May 2020 14:45:20 -0700
Message-ID: <CAEf4BzZ8Sx3HLPag71dOLkfWJgiRbjGNc6HcMca9CcO=LWC4Tw@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: install btf .c files
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Jiri Benc <jbenc@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 19, 2020 at 11:16 PM Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
>
> Hi, Andrii!
>
> >>>>> On Tue, 19 May 2020 12:09:36 -0700, Andrii Nakryiko  wrote:
>
>  > On Tue, May 19, 2020 at 1:50 AM Yauheni Kaliuta
>  > <yauheni.kaliuta@redhat.com> wrote:
>  >>
>  >> Some .c files used by test_progs to check btf and they are missing
>  >> from installation after commit 74b5a5968fe8 ("selftests/bpf: Replace
>  >> test_progs and test_maps w/ general rule").
>  >>
>  >> Take them back.
>  >>
>  >> Fixes: 74b5a5968fe8 ("selftests/bpf: Replace test_progs and
>  >> test_maps w/ general rule")
>  >>
>  >> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
>  >> ---
>  >> tools/testing/selftests/bpf/Makefile | 3 +++
>  >> 1 file changed, 3 insertions(+)
>  >>
>  >> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
>  >> index e716e931d0c9..d96440732905 100644
>  >> --- a/tools/testing/selftests/bpf/Makefile
>  >> +++ b/tools/testing/selftests/bpf/Makefile
>  >> @@ -46,6 +46,9 @@ TEST_GEN_FILES =
>  >> TEST_FILES = test_lwt_ip_encap.o \
>  >> test_tc_edt.o
>  >>
>  >> +BTF_C_FILES = $(wildcard progs/btf_dump_test_case_*.c)
>  >> +TEST_FILES += $(BTF_C_FILES)
>
>  > Can you please re-use BTF_C_FILES in TRUNNER_EXTRA_FILES :=
>  > assignment on line 357?
>
> Do you mean this:

Yes, you can add my Acked-by: Andrii Nakryiko <andriin@fb.com>.
Test_progs flavors can be addressed separately, I think.

[...]
