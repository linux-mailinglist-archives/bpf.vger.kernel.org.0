Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B4266BE91
	for <lists+bpf@lfdr.de>; Mon, 16 Jan 2023 14:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjAPNDD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Jan 2023 08:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjAPNCi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Jan 2023 08:02:38 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9131EFEE;
        Mon, 16 Jan 2023 04:59:59 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id bk15so10412208ejb.9;
        Mon, 16 Jan 2023 04:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IAZguNTJVi/a6qoNeng/AApLOsYaM+FNkT6jN5FeRBo=;
        b=fcpft07FKnXkA5Fdv/XkfosHhmd2dr3mQUQXXiiyNlTXFZa6ui4wATziWFKR5vfMUw
         z/yU7/3iI6h3icE9LDf3LFg/j3RA3qWjF8HkLmjvyATJQvDl+tRBzbX5W+WaHRHVsuuN
         YFPLiXzPJy8RcIS9gwAO3g3xE3m9HMZP/XY7s4krb9ylVkCed/cQlCVShPABSUvUMoX0
         ZLyfehF3K1+0JxvaAflqmqqc7NPE2rvkCnu8phW74qL0JiX2NQQA3AmcXSfawCRAmhHE
         hvVVX1nRtZKy/HT/UsCW4AbBpxSkwww35EgYq5HodIohOP2fdJoUp+mgkBT7zp0qY52P
         yuHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IAZguNTJVi/a6qoNeng/AApLOsYaM+FNkT6jN5FeRBo=;
        b=djK814+R3w78/jiJ5h2t5D4ymqIt1B5BGOC2AIq7xc6gDuF5CfmPWqMhvYzU4AZPdP
         2gjU3nvaPGu3hXQPI0vP1hETgze2HED4jmVf6X0HiufpW6rKwmVI4pgMfrbeW4kk2ynC
         K4PWfFXkjKy0DMFUfCESMIAERWu3/Xe3/lo4HfXyXgwvA93K2ITSZy+8lGA6aQoIl7H/
         3w3jxRxuw1hW/XJIKj9zmyg4oB8asUVRRbcWN7O4YVWlJCEcA15n/yAVmOht2RADORza
         aHcN65RMXtCmIwzS7G1VOfGZUArm5cqyPM9AURsi28115zeX9ACH+VgrC53qA0ghsQVx
         qE1g==
X-Gm-Message-State: AFqh2kroWzXziC2vq7/x9eRwOj7R7MMa2RNMEKw5UnoH7bJwcGRIdvdc
        V7z0i//bnmWgJ5ziV8P0aOFW44i+Je1zYQ==
X-Google-Smtp-Source: AMrXdXt+KIsbGtUUAJ5IN1palYinCuWmotGeAPr4XqskjrlDpAxK8fm5qeFPnzEf8newqhjWwz99zg==
X-Received: by 2002:a17:907:b68c:b0:870:4986:2ce with SMTP id vm12-20020a170907b68c00b00870498602cemr4795680ejc.58.1673873998114;
        Mon, 16 Jan 2023 04:59:58 -0800 (PST)
Received: from [192.168.1.113] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id lj1-20020a170906f9c100b0078d22b0bcf2sm11734515ejb.168.2023.01.16.04.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 04:59:57 -0800 (PST)
Message-ID: <194f38f2dc7d521375e5a660baaf1be31536be9a.camel@gmail.com>
Subject: Re: [PATCH] tools: bpf: Disable stack protector
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Quentin Monnet <quentin@isovalent.com>,
        Peter Foley <pefoley2@pefoley.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Date:   Mon, 16 Jan 2023 14:59:56 +0200
In-Reply-To: <cb03b745-26b8-706c-de40-80ae991e29fd@isovalent.com>
References: <20230114-bpf-v1-1-f836695a8b62@pefoley.com>
         <cb03b745-26b8-706c-de40-80ae991e29fd@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 2023-01-16 at 10:30 +0000, Quentin Monnet wrote:
> 2023-01-14 18:00 UTC-0500 ~ Peter Foley <pefoley2@pefoley.com>
> > Avoid build errors on distros that force the stack protector on by
> > default.
> > e.g.
> >   CLANG   /home/peter/linux/work/tools/bpf/bpftool/pid_iter.bpf.o
> > skeleton/pid_iter.bpf.c:53:5: error: A call to built-in function '__sta=
ck_chk_fail' is not supported.
> > int iter(struct bpf_iter__task_file *ctx)
> >     ^
> > 1 error generated.
> >=20
> > Signed-off-by: Peter Foley <pefoley2@pefoley.com>
> > ---
> >  tools/bpf/bpftool/Makefile    | 1 +
> >  tools/bpf/runqslower/Makefile | 5 +++--
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> > index f610e184ce02a..36ac0002e386f 100644
> > --- a/tools/bpf/bpftool/Makefile
> > +++ b/tools/bpf/bpftool/Makefile
> > @@ -215,6 +215,7 @@ $(OUTPUT)%.bpf.o: skeleton/%.bpf.c $(OUTPUT)vmlinux=
.h $(LIBBPF_BOOTSTRAP)
> >  		-I$(or $(OUTPUT),.) \
> >  		-I$(srctree)/tools/include/uapi/ \
> >  		-I$(LIBBPF_BOOTSTRAP_INCLUDE) \
> > +		-fno-stack-protector \
> >  		-g -O2 -Wall -target bpf -c $< -o $@
> >  	$(Q)$(LLVM_STRIP) -g $@
> > =20
>=20
> For bpftool, a similar patch was already submitted and merged to the
> bpf-next tree last Friday: 878625e1c7a1 ("bpftool: Always disable stack
> protection for BPF objects").
>=20
> > diff --git a/tools/bpf/runqslower/Makefile b/tools/bpf/runqslower/Makef=
ile
> > index 8b3d87b82b7a2..f7313cc966a04 100644
> > --- a/tools/bpf/runqslower/Makefile
> > +++ b/tools/bpf/runqslower/Makefile
> > @@ -60,8 +60,9 @@ $(OUTPUT)/%.skel.h: $(OUTPUT)/%.bpf.o | $(BPFTOOL)
> >  	$(QUIET_GEN)$(BPFTOOL) gen skeleton $< > $@
> > =20
> >  $(OUTPUT)/%.bpf.o: %.bpf.c $(BPFOBJ) | $(OUTPUT)
> > -	$(QUIET_GEN)$(CLANG) -g -O2 -target bpf $(INCLUDES)		      \
> > -		 -c $(filter %.c,$^) -o $@ &&				      \
> > +	$(QUIET_GEN)$(CLANG) -g -O2 -target bpf $(INCLUDES)		\
> > +		 -fno-stack-protector 					\
> > +		 -c $(filter %.c,$^) -o $@ &&				\
> >  	$(LLVM_STRIP) -g $@
> > =20
> >  $(OUTPUT)/%.o: %.c | $(OUTPUT)
>=20
> This one looks good, thanks!
>=20
> I note a few more places in the repository where we compile to BPF using
> clang. Given that there have been patches to add -fno-stack-protector at
> several locations already, have you checked if any of these also need
> the flag, by any chance, so we could fix this once and for all?
>=20
> $ git grep -l 'target bpf ' | egrep -v '(Documentation|bpftool)'
> kernel/bpf/preload/iterators/Makefile
> samples/bpf/Makefile
> samples/bpf/test_lwt_bpf.sh
> tools/bpf/runqslower/Makefile
> tools/build/feature/Makefile
> tools/perf/Makefile.perf
> tools/perf/util/llvm-utils.c
> tools/testing/selftests/bpf/Makefile
> tools/testing/selftests/net/bpf/Makefile
> tools/testing/selftests/tc-testing/Makefile

A bit tangential, but since BPF LLVM backend does not support the
stack protector (should it?) there is also an option to adjust LLVM
to avoid this instrumentation, WDYT?

