Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862A9672824
	for <lists+bpf@lfdr.de>; Wed, 18 Jan 2023 20:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjART2Z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Jan 2023 14:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjART2Y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Jan 2023 14:28:24 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C63254113;
        Wed, 18 Jan 2023 11:28:23 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so23142wms.2;
        Wed, 18 Jan 2023 11:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CyUR5YUMm8ysaAa5DWj670ggKcKYPCTZKk4awAgiO1I=;
        b=jEiGMsYrAxCjCLHs6mkQRY+H0loWMOrPpIXi1xkSgx//vqy9s+DozWfgjSS4YBRZBs
         MtHd3ILPtW2L3CSBBpV7fwzVyyasFhif6BaagMScsM10cwqj34DAnecbPHQ3g3qaZylV
         BOK+XkMpujyyYY1flwZ5ef1MvNyiKhVcAHfBwO61evwXCkrreDof6lpvLAtEm5wlmCD2
         CNnu0Nykkr2AbmJlXwgPf1lWdkjNVz+izsra+0L3KHH9il/gIgUrRF8z9t4JCDyT0pHA
         5PC+tL/QI5wOYSz42qniVZWNiLATcIzp+3DxOAKnG46f0ANvCW3rwKhcSDBi34NCO1iJ
         xodg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CyUR5YUMm8ysaAa5DWj670ggKcKYPCTZKk4awAgiO1I=;
        b=l89NevF1q/ea5uPvhrB2jJPaJY+n2Vf66OMiwDv+a3HAMoU6ehqIza115H7YrVzxeM
         gxbOrIeP03nBnDOMnzY8GeDzvDsoovc5Av19PXNPprtp2jG/HG2z1+MLgJ/8DRmVZZkk
         iJwxVxiVQoZ/GuZ2QL252M7ctMFrSxjWsSIuTaRZjGmYbUFjaifjyFWr2FjpwSxlHZ1+
         VQEN59vswQfbifDkuHhnRX5m4yladz6+SOxjHh0A7n1HOayeF2f/O1vNKKqYCYq0W2W1
         9np8thfVAVdLC9BIrZJ8ObITgWjhpNDLnQYnP8E9Cp6FvgbnsmU1SPCR+WqhOiUSFwXS
         40Qg==
X-Gm-Message-State: AFqh2koGNIDzGJNSLhMAZeB8FBod8sXiISWoPrqydYRsr7KOec82yHdb
        J9Gk7Nn6N8qIwPFVCbcJT3k=
X-Google-Smtp-Source: AMrXdXulDIOu6MQaY7fUorwFYHMU0SwJNoQe3B8HRZ22ZyxAxesr3erXMXwcA+pNQZqED4LmDew5rA==
X-Received: by 2002:a05:600c:5d1:b0:3d0:761b:f86 with SMTP id p17-20020a05600c05d100b003d0761b0f86mr7756738wmd.28.1674070102037;
        Wed, 18 Jan 2023 11:28:22 -0800 (PST)
Received: from [192.168.1.113] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id z6-20020a05600c0a0600b003d04e4ed873sm3398843wmp.22.2023.01.18.11.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 11:28:21 -0800 (PST)
Message-ID: <701abf4bbf5b7957a24d2f164c643e1d9f586fad.camel@gmail.com>
Subject: Re: [PATCH] tools: bpf: Disable stack protector
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Peter Foley <pefoley2@pefoley.com>,
        Quentin Monnet <quentin@isovalent.com>,
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
Date:   Wed, 18 Jan 2023 21:28:19 +0200
In-Reply-To: <20230114-bpf-v1-1-f836695a8b62@pefoley.com>
References: <20230114-bpf-v1-1-f836695a8b62@pefoley.com>
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

On Sat, 2023-01-14 at 18:00 -0500, Peter Foley wrote:
> Avoid build errors on distros that force the stack protector on by
> default.
> e.g.
>   CLANG   /home/peter/linux/work/tools/bpf/bpftool/pid_iter.bpf.o
> skeleton/pid_iter.bpf.c:53:5: error: A call to built-in function '__stack=
_chk_fail' is not supported.
> int iter(struct bpf_iter__task_file *ctx)
>     ^
> 1 error generated.
>=20
> Signed-off-by: Peter Foley <pefoley2@pefoley.com>
> ---
>  tools/bpf/bpftool/Makefile    | 1 +
>  tools/bpf/runqslower/Makefile | 5 +++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index f610e184ce02a..36ac0002e386f 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -215,6 +215,7 @@ $(OUTPUT)%.bpf.o: skeleton/%.bpf.c $(OUTPUT)vmlinux.h=
 $(LIBBPF_BOOTSTRAP)
>  		-I$(or $(OUTPUT),.) \
>  		-I$(srctree)/tools/include/uapi/ \
>  		-I$(LIBBPF_BOOTSTRAP_INCLUDE) \
> +		-fno-stack-protector \

While working on clang patch to disable stack protector
for BPF target I've noticed that there is an option to
disable default configuration file altogether [1]:

  --no-default-config

Should we consider it instead of -fno-stack-protector
to shield ourselves from any potential distro-specific
changes?

[1] https://clang.llvm.org/docs/ClangCommandLineReference.html#cmdoption-cl=
ang-no-default-config

>  		-g -O2 -Wall -target bpf -c $< -o $@
>  	$(Q)$(LLVM_STRIP) -g $@
> =20
> diff --git a/tools/bpf/runqslower/Makefile b/tools/bpf/runqslower/Makefil=
e
> index 8b3d87b82b7a2..f7313cc966a04 100644
> --- a/tools/bpf/runqslower/Makefile
> +++ b/tools/bpf/runqslower/Makefile
> @@ -60,8 +60,9 @@ $(OUTPUT)/%.skel.h: $(OUTPUT)/%.bpf.o | $(BPFTOOL)
>  	$(QUIET_GEN)$(BPFTOOL) gen skeleton $< > $@
> =20
>  $(OUTPUT)/%.bpf.o: %.bpf.c $(BPFOBJ) | $(OUTPUT)
> -	$(QUIET_GEN)$(CLANG) -g -O2 -target bpf $(INCLUDES)		      \
> -		 -c $(filter %.c,$^) -o $@ &&				      \
> +	$(QUIET_GEN)$(CLANG) -g -O2 -target bpf $(INCLUDES)		\
> +		 -fno-stack-protector 					\
> +		 -c $(filter %.c,$^) -o $@ &&				\
>  	$(LLVM_STRIP) -g $@
> =20
>  $(OUTPUT)/%.o: %.c | $(OUTPUT)
>=20
> ---
> base-commit: 97ec4d559d939743e8af83628be5af8da610d9dc
> change-id: 20230114-bpf-918ae127b77a
>=20
> Best regards,

