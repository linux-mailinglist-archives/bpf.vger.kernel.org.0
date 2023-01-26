Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9546F67C230
	for <lists+bpf@lfdr.de>; Thu, 26 Jan 2023 02:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjAZBIO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 20:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjAZBIN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 20:08:13 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EEE13D5D
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 17:08:11 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id v13so553595eda.11
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 17:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9ViWFvs3RBp6itGd80PspuEhuaKTWOL9bKjTSwU1nvI=;
        b=DSejQGlqsnLwRS6SAT+QdkIOxagMpKptg/SYq65CGWzoRgeSGHObEZLnhd++Pyxjdq
         KRbTUQIShLm+ZDLrvu23SXJZibB/PPVp1RfS2Tq1jS7YzPyyoIasFeeUuHw0nrHQM4n/
         eT/Y4KUPHB9UdGovpvcPc1RkD1Hc/6OYToiZDE7jxtA3vzGiJzZZBCTZYs9z/M8J005H
         uO3/IGL4YMFHacOEttOkX84cHEAEiLpmtRKDAPFfygD4ZFz5534Vr6IasXloLmWmkffD
         jqd1Leb4aNTJ+nFj/2f5P5HAuFEiVx28tcYMYVUiNnXHqYyAujyf7ceChePgslHANdm1
         NVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ViWFvs3RBp6itGd80PspuEhuaKTWOL9bKjTSwU1nvI=;
        b=kC4diSqKCRiaae/hF22sZcowA3eyvft/nfDFyL//t1aaMUAGPgZ3l/9LzDKGPvzfKk
         RujQx35OY7MxOekUjiac9sMFEH8w/FVSyuLqnypz06+b3Pug2JyrZtSL27mCDz/K+DO/
         Csxze1QK2SSxxBcYK3b9/Zk2mhhXa0zRDv3XeE1AC4R2VAOLPLoNyBYo5sZi5qiSBQaJ
         4bVwNBjtRCKDy+dPA6yVqWs3n9kFIwtCZMjIg5JTrpLgCh1HnIvPAO9nBVOOc5EJR7At
         0Df5tdnpnAUYRBevcLxGTtR5BGEzpj5MUOkNZ+JuDwUFQXyKDGWDl4LJ5RbGNjXp4je2
         lWiA==
X-Gm-Message-State: AFqh2koONIHdCjnlsyNDX+tgJJp9Ocggyoczu2MlnXxQx0X59wtFtMDi
        MxYl7z32DNopkodvux+dQ3wsoP8bKMywWUc3hQ5eqat7
X-Google-Smtp-Source: AMrXdXuSZVh8HSBQAJkQm+BGwpFh4OMO+wTfK0Os0fncxTXB7obSIppKLU1+x5GVQPm7BA99ILyI2/q0JYCMgBvYvC0=
X-Received: by 2002:a05:6402:5288:b0:49e:66b8:a790 with SMTP id
 en8-20020a056402528800b0049e66b8a790mr4342459edb.47.1674695290253; Wed, 25
 Jan 2023 17:08:10 -0800 (PST)
MIME-Version: 1.0
References: <20230125213817.1424447-1-iii@linux.ibm.com> <20230125213817.1424447-2-iii@linux.ibm.com>
In-Reply-To: <20230125213817.1424447-2-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 25 Jan 2023 17:07:58 -0800
Message-ID: <CAEf4Bzbxvg1a-kqvDeRmPcL2LDQf-cnRwoj4yds1u9JwAZ3HPg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 01/24] selftests/bpf: Fix liburandom_read.so
 linker error
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
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

On Wed, Jan 25, 2023 at 1:39 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> When building with O=, the following linker error occurs:
>
>     clang: error: no such file or directory: 'liburandom_read.so'
>
> Fix by adding $(OUTPUT) to the linker search path.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tools/testing/selftests/bpf/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index c9b5ed59e1ed..43098eb15d31 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -189,9 +189,9 @@ $(OUTPUT)/liburandom_read.so: urandom_read_lib1.c urandom_read_lib2.c
>  $(OUTPUT)/urandom_read: urandom_read.c urandom_read_aux.c $(OUTPUT)/liburandom_read.so
>         $(call msg,BINARY,,$@)
>         $(Q)$(CLANG) $(filter-out -static,$(CFLAGS) $(LDFLAGS)) $(filter %.c,$^) \
> -                    liburandom_read.so $(filter-out -static,$(LDLIBS))      \
> +                    $(filter-out -static,$(LDLIBS))                           \
>                      -fuse-ld=$(LLD) -Wl,-znoseparate-code -Wl,--build-id=sha1 \
> -                    -Wl,-rpath=. -o $@
> +                    -Wl,-rpath=. -o $@ -lurandom_read -L$(OUTPUT)

why moving to the end? it's nice in verbose logs when the last thing
is the resulting file ($@), so if possible, let's move it back?


>
>  $(OUTPUT)/sign-file: ../../../../scripts/sign-file.c
>         $(call msg,SIGN-FILE,,$@)
> --
> 2.39.1
>
