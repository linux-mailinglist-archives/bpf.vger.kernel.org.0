Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3F5690F05
	for <lists+bpf@lfdr.de>; Thu,  9 Feb 2023 18:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjBIRRd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Feb 2023 12:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjBIRR2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Feb 2023 12:17:28 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D3566EC9
        for <bpf@vger.kernel.org>; Thu,  9 Feb 2023 09:17:26 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id jg8so8468246ejc.6
        for <bpf@vger.kernel.org>; Thu, 09 Feb 2023 09:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fo82YNkdVX9z9RYOxQu5aQBHSokhQG8AohIMC2Dw6l4=;
        b=EZEyChzAJ0ykLoKM+xGKbWNx17S591Id+MAJSKo9MRwh/QKhfOLJ8M/IesKdRZqSsW
         TGoOxVJpywS9VL2U7ScEbZ7r/XhWo/hmtINd79Vhnglvb7r63fpu+XuollEGlbuR98s/
         naVWeJf9H4vxbhQfgpC0BIODI4dUJhmSsE2ArtHz1XQNsDJUcTzew8ixehW5F64QdsQR
         GERjj/pzXIx/he/1lB5qJRW8LLrsVoNSC5NOaCQtsJCZstngTCO4CX2QXi3zF/AIICiX
         mzn3BrBJxFZjw8ETIG4fuaxQcJPDpxfM/odHC829PEBJZQ6SJdEwSzDCIJezVysf3AlC
         uFCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fo82YNkdVX9z9RYOxQu5aQBHSokhQG8AohIMC2Dw6l4=;
        b=z4GY+IftKKb5bSxnuUXzaqSFeACKR4nUluyF85g+YFEFkBCdACWplQxpStH58QXMgt
         RHJJW7SaWDbpG9PUdaEGeByuPN0gKX9EHLMtCCefUJ32mWtht4fuy6ww4OWhTk9Nvfwv
         cXxZQj+2SFFmfOdnO23I3IV00RpbdPunFO3GunhVExaMn3eZioRFHd7wl+rsVngV8AiA
         Otj2mZTbS8RC9alnpfRv7GeofZ+lidWRf953zxIJCOjc769kwZaiiHEbuQp7gn9Ema/G
         t47qA/J5m6XKD9VAfwfG13r4aQcy4vf2+kk1qeFPQT0ng67qb9z0hET1Wc/We97S56Ds
         dWvQ==
X-Gm-Message-State: AO0yUKXpD9evJCmKat1tyeG//1oDv3HJCvJkPwMT80I2DsFPfbaVQKNu
        Ly01x+5VXIDRPj7NTPKQywYmY8mDWDzr9OBNNXk=
X-Google-Smtp-Source: AK7set8boTowieXlcQKRuu6EuWduoE+0ZorIsz+s+ZXnQJFpquy3fm9oC06vkHig0MNYC4S6NF8tCmoEONYFcNqgi5M=
X-Received: by 2002:a17:906:5a60:b0:8aa:bdec:d9ae with SMTP id
 my32-20020a1709065a6000b008aabdecd9aemr1785196ejc.12.1675963045338; Thu, 09
 Feb 2023 09:17:25 -0800 (PST)
MIME-Version: 1.0
References: <20230208205642.270567-1-iii@linux.ibm.com> <20230208205642.270567-5-iii@linux.ibm.com>
 <CAEf4BzbWjs7N=cQF2PYXKeDG2dB8JKrV0Jw=i_rvVxm4Kv02Aw@mail.gmail.com> <804f5a8ef91933c3796e61ad1e51c1c4fe261d27.camel@linux.ibm.com>
In-Reply-To: <804f5a8ef91933c3796e61ad1e51c1c4fe261d27.camel@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 9 Feb 2023 09:17:13 -0800
Message-ID: <CAEf4BzbtxDC7hBg1Mbx32+CZSMvcaK3mNkeNN3AqhdT=pYZ-Uw@mail.gmail.com>
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

On Thu, Feb 9, 2023 at 1:55 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> On Wed, 2023-02-08 at 17:03 -0800, Andrii Nakryiko wrote:
> > On Wed, Feb 8, 2023 at 12:57 PM Ilya Leoshkevich <iii@linux.ibm.com>
> > wrote:
> > >
> > > To get useful results from the Memory Sanitizer, all code running
> > > in a
> > > process needs to be instrumented. When building tests with other
> > > sanitizers, it's not strictly necessary, but is also helpful.
> > > So make sure runqslower and libbpf are compiled with SAN_CFLAGS and
> > > linked with SAN_LDFLAGS.
> > >
> > > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > > ---
> > >  tools/testing/selftests/bpf/Makefile | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/Makefile
> > > b/tools/testing/selftests/bpf/Makefile
> > > index 9b5786ac676e..c4b5c44cdee2 100644
> > > --- a/tools/testing/selftests/bpf/Makefile
> > > +++ b/tools/testing/selftests/bpf/Makefile
> > > @@ -215,7 +215,9 @@ $(OUTPUT)/runqslower: $(BPFOBJ) |
> > > $(DEFAULT_BPFTOOL) $(RUNQSLOWER_OUTPUT)
> > >                     OUTPUT=$(RUNQSLOWER_OUTPUT)
> > > VMLINUX_BTF=$(VMLINUX_BTF)     \
> > >
> > > BPFTOOL_OUTPUT=$(HOST_BUILD_DIR)/bpftool/                  \
> > >
> > > BPFOBJ_OUTPUT=$(BUILD_DIR)/libbpf                          \
> > > -                   BPFOBJ=$(BPFOBJ) BPF_INCLUDE=$(INCLUDE_DIR)
> > > &&             \
> > > +                   BPFOBJ=$(BPFOBJ)
> > > BPF_INCLUDE=$(INCLUDE_DIR)                \
> > > +                   EXTRA_CFLAGS='-g -O0
> > > $(SAN_CFLAGS)'                        \
> > > +                   EXTRA_LDFLAGS='$(SAN_LDFLAGS)'
> > > &&                          \
> > >                     cp $(RUNQSLOWER_OUTPUT)runqslower $@
> > >
> >
> > I wouldn't do it for runqslower, we just make sure that it compiles,
> > we don't really run it at all. No need to complicate its build, IMO.
>
> runqslower is linked with target libbpf, which is instrumented.
> This produces undefined symbol errors, since MSan runtime is expected
> to be a part of an executable.

ah, ok then, never mind

>
> [...]
