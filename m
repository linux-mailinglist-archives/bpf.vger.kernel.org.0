Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51881E3226
	for <lists+bpf@lfdr.de>; Wed, 27 May 2020 00:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391125AbgEZWOC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 May 2020 18:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390125AbgEZWOB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 May 2020 18:14:01 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F3EC061A0F
        for <bpf@vger.kernel.org>; Tue, 26 May 2020 15:14:00 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id z1so5504424qtn.2
        for <bpf@vger.kernel.org>; Tue, 26 May 2020 15:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g2P8B8LAS18qjSBl4hxGv80ASo2ujlVK+KjwBqFrkfM=;
        b=MbvLx9saGQ1kra0Icek6c84/XIaOjnqB8uay79Hoyv9zY1vAwBCEGP/+1cIfrw4bKk
         MhWr7wHCZBIJJwpDDCvZ7cz0/IZBaxYNHHYmrPTDrDg9y3/LB1vPIHNoZ0hfbnrkPSM1
         cS9mu6CRwnhAzQbhxCCYXgYuk6+RJ9I6SHz8H25RN0E7KkFoXgkEvHEiSrjBc/zC/bzz
         UtDs8+sUP0OCeX4ifWnmnKieMDJZrd1ervoLQIPMrkqtroprXqgX8Cds27rzEffAlqGU
         HBfl+ZPbkHPAMm5t59Z6DwlR6aH85VP2BBf0Vyart2GyJTRddX30eR+8WTCKuRwf9oVN
         gKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g2P8B8LAS18qjSBl4hxGv80ASo2ujlVK+KjwBqFrkfM=;
        b=juQRn30x49IyaUeKMXX5WQ8RVe8aIx8+/rkQfAeV3JLwrvlrpeHZch8ldUWlExQ3Rx
         ksQ0piSLxmhq2Yubrgfs59n8yrfc4l2oTu81GNyXD+NgqeeC1eghIaAlusfvlTDnriCf
         ABZCwoszBXgh2ZjX36aEfqXH2hAFt6tLqEeILM37XiFa0Oige17M723r23/1FsfsDOhu
         N75EnwZd76ap8Y7H0WB5XS3fPGUsLuOMhOLOhYP8OIajuOwWo3XhYk5L/MxbBUQFW68C
         OVGCtZY23C1bqCtxwRzWiWlsACMAg8/3CFthDM/kWlYB4hwwh9JCepZ4nWeh0OBMk4np
         9f5Q==
X-Gm-Message-State: AOAM533AlaFhRnrJCXGhCiMfDPsbuLoJ0IiVDvMwOExsLusuYWSjOleb
        Zi3ecf9S9FPOepQOO4yV2X3DIqBuqihHQacciuY=
X-Google-Smtp-Source: ABdhPJy6dej4pF86ONY/EAPmBCvFeimND9nLPddLOkNO1lE9pUE9UeT52FxjI8O1JGE8LbTZVAASzkA+2DeXQ5/9hxM=
X-Received: by 2002:ac8:2dc3:: with SMTP id q3mr1048599qta.141.1590531239653;
 Tue, 26 May 2020 15:13:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200522041310.233185-1-yauheni.kaliuta@redhat.com> <20200522041310.233185-6-yauheni.kaliuta@redhat.com>
In-Reply-To: <20200522041310.233185-6-yauheni.kaliuta@redhat.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 26 May 2020 15:13:48 -0700
Message-ID: <CAEf4BzbOJFXhWL6PSstWoqadEY4qzG4uA66kt8+KLK+8c0ye0g@mail.gmail.com>
Subject: Re: [PATCH 5/8] selftests/bpf: add output dir to include list
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Jiri Benc <jbenc@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 21, 2020 at 9:14 PM Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
>
> Some headers (skel) are generated in the output directory and used
> for build (test_cpp.cpp), so add it to the list (as well as
> CURDIR) otherwise out of tree build is broken.
>

So this is needed only for test_cpp, right? Because test_prog's tests
are built with a special rule changing their workdir to the one that
contains proper skeleton. Let's just add -I$(OUTPUT) to test_cpp rule
instead of adding it to every single .c build rule? If we later still
need this, then we should consider adding it widely.


> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> ---
>  tools/testing/selftests/bpf/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 1ba3d72c3261..efab82151ce2 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -22,7 +22,8 @@ LLVM_OBJCOPY  ?= llvm-objcopy
>  BPF_GCC                ?= $(shell command -v bpf-gcc;)
>  SAN_CFLAGS     ?=
>  CFLAGS += -g -rdynamic -Wall -O2 $(GENFLAGS) $(SAN_CFLAGS)             \
> -         -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)          \
> +         -I$(CURDIR) -I$(abspath $(OUTPUT))                            \
> +         -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)                      \
>           -I$(TOOLSINCDIR) -I$(APIDIR)                                  \
>           -Dbpf_prog_load=bpf_prog_test_load                            \
>           -Dbpf_load_program=bpf_test_load_program
> --
> 2.26.2
>
