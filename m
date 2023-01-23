Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963FA67760C
	for <lists+bpf@lfdr.de>; Mon, 23 Jan 2023 09:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjAWIG7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Jan 2023 03:06:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjAWIG7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Jan 2023 03:06:59 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3E6125A1
        for <bpf@vger.kernel.org>; Mon, 23 Jan 2023 00:06:57 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id f12-20020a7bc8cc000000b003daf6b2f9b9so9951845wml.3
        for <bpf@vger.kernel.org>; Mon, 23 Jan 2023 00:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aL6GMUhJ7qT9WkP+FHwDNFbE3cVi6YLxMKB/VdDs2Cs=;
        b=ZEAN4Pe0J2FolKhXALWZtkdRDnirp0KTyc4vHbsOJtTcL0VHTwf2Ncv0KZsk+Zvz9J
         EF/4VkFbTEm1MUiR+rdBL7HQfwsJWZ9LrBJ0NtXsvUWW3jk/ov0gGr1neQBz2LS47jSt
         vPQRBAIv1pi1oCAqAfa50l47WugkB2+lz/39gAQikn3IIeNW1kKumTCiQA7Ry8weQFrA
         PzSMGUzyOEX22aBEPe3jx2vT/qJp55Anxc1yh86QqyxT7QHydYrut2Wt2go6+KV63zWC
         N9Eh5R4S8J9DYpXecT3hfAiV456yMUss7C/+DhOnZpsnM72S8yUwbnm53itdcx4KLRPB
         tqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aL6GMUhJ7qT9WkP+FHwDNFbE3cVi6YLxMKB/VdDs2Cs=;
        b=Eopfid6l5ARJZVbMW1izMNrqv5BACT4pgQqEChmR3gupfdqSp6uNKPauJxJJKWLsIp
         FNSEzHFE0MO6CMYjB27SikLlrx9usZ/Zlmg3CvwJ7ywvMbbTFRAJX/OaLBYkB05b9dtJ
         2XToZNmZ7qjZ2vonEsvpjWss5afsdluHRqIBKEgQjtNs7/ennrMs4S4B3iGvkGB1I4jr
         a3j6PFeoZXz1uKyA0CBVEFe1j/hN/F/nqOdlkSIWxTl2Tx3Mh2kGS/+Vi0m1QNwpXvlr
         TKesd6ZJHNWZTXmrQHSJpOZoE6LxdcYTMonFaj5VS+M3AxcLkeaXxbKQDW4rggIB9wBJ
         AKiQ==
X-Gm-Message-State: AFqh2kq1pGCMhtLrf6/yjHrI5zPveh2ro9oEMp6UIW4J3V28X37+R5U8
        aQv4Jmo5JguiEWURJWuu4sZLGvOFYU0=
X-Google-Smtp-Source: AMrXdXvvVOtgwndv4EY0SbFy59PhvP+7oKliFGx1L43ydFqmCacqtyGmsrG1tJXlG+Osubf+ZhmySw==
X-Received: by 2002:a05:600c:5386:b0:3da:f670:a199 with SMTP id hg6-20020a05600c538600b003daf670a199mr22910944wmb.36.1674461215785;
        Mon, 23 Jan 2023 00:06:55 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 2-20020a05600c028200b003cf6a55d8e8sm9777767wmk.7.2023.01.23.00.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 00:06:55 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 23 Jan 2023 09:06:53 +0100
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Kernel build fail with 'btf_encoder__encode: btf__dedup failed!'
Message-ID: <Y85AHdWw/l8d1Gsp@krava>
References: <57830c30-cd77-40cf-9cd1-3bb608aa602e@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57830c30-cd77-40cf-9cd1-3bb608aa602e@app.fastmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jan 22, 2023 at 10:48:44AM -0700, Daniel Xu wrote:
> Hi,
> 
> I'm getting the following error during build:
> 
>         $ ./tools/testing/selftests/bpf/vmtest.sh -j30
>         [...]
>           BTF     .btf.vmlinux.bin.o
>         btf_encoder__encode: btf__dedup failed!
>         Failed to encode BTF
>           LD      .tmp_vmlinux.kallsyms1
>           NM      .tmp_vmlinux.kallsyms1.syms
>           KSYMS   .tmp_vmlinux.kallsyms1.S
>           AS      .tmp_vmlinux.kallsyms1.S
>           LD      .tmp_vmlinux.kallsyms2
>           NM      .tmp_vmlinux.kallsyms2.syms
>           KSYMS   .tmp_vmlinux.kallsyms2.S
>           AS      .tmp_vmlinux.kallsyms2.S
>           LD      .tmp_vmlinux.kallsyms3
>           NM      .tmp_vmlinux.kallsyms3.syms
>           KSYMS   .tmp_vmlinux.kallsyms3.S
>           AS      .tmp_vmlinux.kallsyms3.S
>           LD      vmlinux
>           BTFIDS  vmlinux
>         FAILED: load BTF from vmlinux: No such file or directory
>         make[1]: *** [scripts/Makefile.vmlinux:35: vmlinux] Error 255
>         make[1]: *** Deleting file 'vmlinux'
>         make: *** [Makefile:1264: vmlinux] Error 2
> 
> This happens on both bpf-next/master (84150795a49) and 6.2-rc5
> (2241ab53cb).
> 
> I've also tried arch linux pahole 1:1.24+r29+g02d67c5-1 as well as
> upstream pahole on master (02d67c5176) and upstream pahole on
> next (2ca56f4c6f659).
> 
> Of the above 6 combinations, I think I've tried all of them (maybe
> missing 1 or 2).
> 
> Looks like GCC got updated recently on my machine, so perhaps
> it's related?
> 
>         CONFIG_CC_VERSION_TEXT="gcc (GCC) 12.2.1 20230111"
> 
> I'll try some debugging, but just wanted to report it first.

hi,
I can't reproduce that.. can you reproduce it outside vmtest.sh?

there will be lot of output with patch below, but could contain
some more error output

jirka


---
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 32e573943cf0..05ac3ced89e7 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -125,7 +125,7 @@ gen_btf()
 	vmlinux_link ${1}
 
 	info "BTF" ${2}
-	LLVM_OBJCOPY="${OBJCOPY}" ${PAHOLE} -J ${PAHOLE_FLAGS} ${1}
+	LLVM_OBJCOPY="${OBJCOPY}" ${PAHOLE} -V -J ${PAHOLE_FLAGS} ${1}
 
 	# Create ${2} which contains just .BTF section but no symbols. Add
 	# SHF_ALLOC because .BTF will be part of the vmlinux image. --strip-all
