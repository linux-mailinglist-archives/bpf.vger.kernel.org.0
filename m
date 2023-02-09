Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D437E68FC5B
	for <lists+bpf@lfdr.de>; Thu,  9 Feb 2023 02:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjBIBDf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Feb 2023 20:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjBIBDe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 20:03:34 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE9A12851
        for <bpf@vger.kernel.org>; Wed,  8 Feb 2023 17:03:33 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id r3so689400edq.13
        for <bpf@vger.kernel.org>; Wed, 08 Feb 2023 17:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KGIT0L6AEvodw795ztROXOhTSxLUeDrFPXprGfxUA9M=;
        b=QhZg7l2BYMFzG/6vwCgFPGcQE5hijY0AcRpyFFyCt8strqMqwLiIF5iKv8K9rWdnjL
         i+BRCiVPoqYw99JLPcZM5VKz2My/TJ5y5XTQDBdBMW7Z5ZZmMeV4ujshUnlUuhmCi9ob
         St6V0vPtBBpEMHWwctwh8dsukDYbx/YYgyIlRdaoEmbi3cEWLhsshe1xZn5C+ba2OCVN
         eisNWIlzznbLumiOAnKHBo5RLKCtlxK48hpWyZTutnrfR1URYfn0Ftmp4VLbvvWTJp+g
         UorpwfXz214s5NW1FcysAAIXj7TTjYE8CqjfxL/CoijVly6a9PROhdXYq9+KxCmCiZFe
         EO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KGIT0L6AEvodw795ztROXOhTSxLUeDrFPXprGfxUA9M=;
        b=Ioy6BWKW1Kr/6RAXhrTH1EWFAhLyajbhnHH5z/2YwqAyL8nc4XNTCezlb+N40L8r5T
         3MKoi/YeIEGoexuLqQsqQkENEXC5k0eJF7do7XXy52420+raK1SvEU2dpTED7Hjtz0Gt
         Yzh1ph3Y9qobRu9r0cMbV5dKEhIZHiUhTLG/eaUT5NLOnGOs31jqug8nrHTsgc/XxI80
         xoqbjAq5VP7u3SfWVkFHKINC0echSgKHm23+By0KvNs2Rv+AsMUZLPfZaGfBPzqUrNyN
         gNAo0I8Voc+OWFWnbFu98dUlVYEyjrggWYSi0oCrWPQx1Ul0THgalPkgjMlglWtd1x/l
         rI8w==
X-Gm-Message-State: AO0yUKXBMbKwI5J5KGup/PW5iXbhn3eT9AB18IzunA+JsZs3YTOCOGL/
        L4OXIL4fdQdgoEMM+ekZ4r+ZlRDp/hpWu0ptVzc=
X-Google-Smtp-Source: AK7set879pzCfNCVP40ZBnY8zj9ZnqT/0Gv1+xE8STMmtsiBTm9QPH1FZA8nv/f3phwrxB9Ko8dqDSe9ZXz8qY342fI=
X-Received: by 2002:a50:9f43:0:b0:4ab:1712:b268 with SMTP id
 b61-20020a509f43000000b004ab1712b268mr294060edf.5.1675904612380; Wed, 08 Feb
 2023 17:03:32 -0800 (PST)
MIME-Version: 1.0
References: <20230208205642.270567-1-iii@linux.ibm.com> <20230208205642.270567-5-iii@linux.ibm.com>
In-Reply-To: <20230208205642.270567-5-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 8 Feb 2023 17:03:20 -0800
Message-ID: <CAEf4BzbWjs7N=cQF2PYXKeDG2dB8JKrV0Jw=i_rvVxm4Kv02Aw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/9] selftests/bpf: Forward SAN_CFLAGS and
 SAN_LDFLAGS to runqslower and libbpf
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
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

On Wed, Feb 8, 2023 at 12:57 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> To get useful results from the Memory Sanitizer, all code running in a
> process needs to be instrumented. When building tests with other
> sanitizers, it's not strictly necessary, but is also helpful.
> So make sure runqslower and libbpf are compiled with SAN_CFLAGS and
> linked with SAN_LDFLAGS.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tools/testing/selftests/bpf/Makefile | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 9b5786ac676e..c4b5c44cdee2 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -215,7 +215,9 @@ $(OUTPUT)/runqslower: $(BPFOBJ) | $(DEFAULT_BPFTOOL) $(RUNQSLOWER_OUTPUT)
>                     OUTPUT=$(RUNQSLOWER_OUTPUT) VMLINUX_BTF=$(VMLINUX_BTF)     \
>                     BPFTOOL_OUTPUT=$(HOST_BUILD_DIR)/bpftool/                  \
>                     BPFOBJ_OUTPUT=$(BUILD_DIR)/libbpf                          \
> -                   BPFOBJ=$(BPFOBJ) BPF_INCLUDE=$(INCLUDE_DIR) &&             \
> +                   BPFOBJ=$(BPFOBJ) BPF_INCLUDE=$(INCLUDE_DIR)                \
> +                   EXTRA_CFLAGS='-g -O0 $(SAN_CFLAGS)'                        \
> +                   EXTRA_LDFLAGS='$(SAN_LDFLAGS)' &&                          \
>                     cp $(RUNQSLOWER_OUTPUT)runqslower $@
>

I wouldn't do it for runqslower, we just make sure that it compiles,
we don't really run it at all. No need to complicate its build, IMO.

>  TEST_GEN_PROGS_EXTENDED += $(DEFAULT_BPFTOOL)
> @@ -272,7 +274,8 @@ $(BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)                 \
>            $(APIDIR)/linux/bpf.h                                               \
>            | $(BUILD_DIR)/libbpf
>         $(Q)$(MAKE) $(submake_extras) -C $(BPFDIR) OUTPUT=$(BUILD_DIR)/libbpf/ \
> -                   EXTRA_CFLAGS='-g -O0'                                      \
> +                   EXTRA_CFLAGS='-g -O0 $(SAN_CFLAGS)'                        \
> +                   EXTRA_LDFLAGS='$(SAN_LDFLAGS)'                             \
>                     DESTDIR=$(SCRATCH_DIR) prefix= all install_headers
>
>  ifneq ($(BPFOBJ),$(HOST_BPFOBJ))
> --
> 2.39.1
>
