Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1195545446
	for <lists+bpf@lfdr.de>; Thu,  9 Jun 2022 20:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244450AbiFISkY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Jun 2022 14:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbiFISkX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Jun 2022 14:40:23 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172AA114A84
        for <bpf@vger.kernel.org>; Thu,  9 Jun 2022 11:40:23 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id u26so38617695lfd.8
        for <bpf@vger.kernel.org>; Thu, 09 Jun 2022 11:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lVESkyK5NR3m77hA1vJx/HAnP4HsyLO2lJHvKHV5EhI=;
        b=N1fs1D3jVxo822n05GNT14N5G5Ag5jeVpCPv19/VFSox9EJiZ/GwXxGcJet4drkVni
         jWjX+mZFoGeEU82RFufji8vclYs2Wq5kgTO3sIBdP7ga1SgyWTDcGfoIsZmhuVSrM9r2
         GBGEUhX35GXtTtsj3AQ5oM2k8p3+VjCjrcDmgrcE70kFRF7u6l3cfRSQvJzM0nvEQYSr
         e3snfCvWa3FRrlmvP9IL3bIlpPWaggn+0qehbrmmoeZtv8VgV+eEqRlrpQCmxp/VqYwV
         UPw8aqXZd7FXIQArfxuwZE6ssNLdK7nrRF+EX1XPfsxjt5XPXt9KHc7+f5MXKdh0YpXX
         r4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lVESkyK5NR3m77hA1vJx/HAnP4HsyLO2lJHvKHV5EhI=;
        b=jg6osBz/gIBJesKxHsVMNK7mUqWPcGcCPdcrejHi5wU9fXbxAjshWHn6XQokrQDwNU
         mzR+DKj+6gcnNSSatHIAUULljmhGLM6tHSAcjL/pykweIzxrQRZHuT3eEU+m5c3WTuni
         qmlpIz5pscexWtqjVQUJe8xSjaDddPM6kBKh0NiFFRDQ/o9L3rOzuJkS6vkeKHm3GdZ4
         X7phVWoUWteR4ScsT+9piPmdDluFST7XLlZcqpzMYw4K4SfM3RBrsz/DoS5Ykay3tW13
         SpnzW77DoncB/EQ+jgH1qgl9MbfyZyBGG20jitsOgjjXJuKr0E3k8xT/5fZsC/U5fN3A
         wLhA==
X-Gm-Message-State: AOAM530yeMwBZH5wcp38acS92mux28o1dqB+jqRCq0++vleSuECAMMlw
        U9vZCG0TUQnc/kC/LrVhL8RF6puyooqg2Da3+p4=
X-Google-Smtp-Source: ABdhPJxzHnLRvQ1V1KnZ3o6SG4SK+2gZqeiZfn61ayeWhDM1Rz+LwOKicOvJF20MgNgJFaE9dKfsBjhR/erkESfk0WM=
X-Received: by 2002:ac2:44b3:0:b0:478:ea0b:ddff with SMTP id
 c19-20020ac244b3000000b00478ea0bddffmr25945751lfm.97.1654800021424; Thu, 09
 Jun 2022 11:40:21 -0700 (PDT)
MIME-Version: 1.0
References: <598AFF44-37E1-49B3-BEF6-ECC5743F4CCF@ens-lyon.fr>
In-Reply-To: <598AFF44-37E1-49B3-BEF6-ECC5743F4CCF@ens-lyon.fr>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 9 Jun 2022 11:40:09 -0700
Message-ID: <CAEf4BzaF_1+TP0T9yOZEYTTBJNxvjXz50opesviQtEth7RC5Ow@mail.gmail.com>
Subject: Re: vmlinux.h conflicts with bpf.h
To:     =?UTF-8?Q?Th=C3=A9ophile_Dubuc?= <theophile.dubuc@ens-lyon.fr>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 9, 2022 at 8:22 AM Th=C3=A9ophile Dubuc
<theophile.dubuc@ens-lyon.fr> wrote:
>
> Hello,
>
> I get errors when compiling my bpf application, because vmlinux.h seems t=
o conflict with bpf.h.
> If I include <bpf/bpf.h> or <bpf/libbpf.h>, I get tons of errors like

vmlinux.h is included from BPF-side source code. While bpf/bpf.h and
bpf/libbpf.h is included from user-space side. You shouldn't have an
application including both at the same time. And then vmlinux.h is not
compatible with most UAPI headers (that's a known limitation we are
hopefully will solve eventually), but it defines all the kernel types
down to __u32 alias, so you generally don't need other UAPI headers.

>
> >    In file included from .output/bpf/libbpf.h:18:
> >    ../libbpf/include/uapi/linux/bpf.h:54:2: error: redefinition of enum=
erator 'BPF_REG_0'
> >            BPF_REG_0 =3D 0,
> >            ^
> >    ../vmlinux/vmlinux.h:31938:2: note: previous definition is here
> >            BPF_REG_0 =3D 0,
> >            ^
>
>
>
> What I'm trying to do is use the function `bpf_map_get_next_key` to find =
an entry in a hash table, and that function is defined in bpf.h.
> I also tried using the `bpf_map__get_next_key` function from libbpf.h ins=
tead, but libbpf.h includes bpf.h so I get the conflicts anyway.
>
> I generated vmlinux.h using the `gen_vm_linux_h.sh` script from libbpf-bo=
otstrap/tools, and my Makefile is also the one from the bootstrap example.
>
>
>
> I feel like I am missing something but I can't figure it out (I am quite =
new to bpf) even by looking in this mailing list archive.
> If you have any idea of what's wrong, please let me know.
>
>
>
> Best regards,
>
> Th=C3=A9ophile
