Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A046368FC52
	for <lists+bpf@lfdr.de>; Thu,  9 Feb 2023 02:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjBIBAf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Feb 2023 20:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjBIBAa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 20:00:30 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FDD23136
        for <bpf@vger.kernel.org>; Wed,  8 Feb 2023 17:00:29 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id dr8so1923752ejc.12
        for <bpf@vger.kernel.org>; Wed, 08 Feb 2023 17:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=50m0VllkfU/uIUgFLJrSeqgXpiIv+NJozcf4RIsJp5k=;
        b=SduBwBJlAQ0izfNEPj+53ORAfcndrJYAZ3AtuKZ8KpzCT/mAdH3IGNEZR6/35M6CRk
         wipBrsNXFiU6Ww+xW1rSTafbbY7Negrs3EY+S6xFO/Y/fy/1moHe9g09JDSvhzLL+zgz
         2QTlhbimCTJlOG8thS/R9DD0cmz/WpZdjnZS4jke6KFztElJJiqg+mP/IGl9QlEZ04Lp
         Hc1Nq7Rn3QblD+jSv9Ml90WSLgiclP5+E0Ds2LZhp8PY1wXEWuCvdP21JLlJlJiBopU1
         PPOAjQJDNiTc/c38J5Q/XIzJq3cB0AIQCdYIjBj1JT656+x/hMqGw9ADn+vtCDeOe2qG
         cQOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=50m0VllkfU/uIUgFLJrSeqgXpiIv+NJozcf4RIsJp5k=;
        b=QVh5zz9KJ81jEzoKFMOZ8Vi0QiIlpV1lDhnghJvLsboqN3UZ5jneNnFklNfjIpmlHs
         jqOtk2CEX0BI5qjJpg5n338Y4N2+kuURR6/T0MDpvr6nSLQwWnkgCCplELX/pry0hFC+
         Y3lTHs93zcAdFdod3C7fNyndxp68z/JycpnOabMQF9JRy8JMCkykeIKAdKzJmXBJ0VRB
         uFw+O9dczab4fBzvc+wVoRsK0sdrIpu3dYpdH5MfJXWV0YfOCt7EwNkPAHgs4p7K48mC
         B7aROTER76Oqsif9aYQkN+1aJsgnO5lLDyx9jwDhLhHD8tsBPs4T19w8UkDuQ5RWAw3L
         zHXA==
X-Gm-Message-State: AO0yUKUrkCf/2Cpmtl9F57rsYuAYkgXTQKmN0XKPp9+CMeYS33xrjQgE
        59F3ADvLobv3lBIVpmAhNXslGp85NvThj2f1y4k=
X-Google-Smtp-Source: AK7set9GbP745CFubdQ6vbq1+J5o4iMZhasfXGNkSjHoR2ArY9xYkuPUJd4gkYfzKOGHkDzbj8FtEcJxFQsQ4I+Q8lM=
X-Received: by 2002:a17:906:aec1:b0:889:8f1a:a153 with SMTP id
 me1-20020a170906aec100b008898f1aa153mr123517ejb.15.1675904427995; Wed, 08 Feb
 2023 17:00:27 -0800 (PST)
MIME-Version: 1.0
References: <20230208205642.270567-1-iii@linux.ibm.com> <20230208205642.270567-3-iii@linux.ibm.com>
In-Reply-To: <20230208205642.270567-3-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 8 Feb 2023 17:00:16 -0800
Message-ID: <CAEf4BzaUXnjbye9LU2xhUqpNak0dbDA1FK4fbTrcs4DOXEtUqQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/9] tools: runqslower: Add EXTRA_CFLAGS and
 EXTRA_LDFLAGS support
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
> This makes it possible to add sanitizer flags.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tools/bpf/runqslower/Makefile | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/tools/bpf/runqslower/Makefile b/tools/bpf/runqslower/Makefile
> index 8b3d87b82b7a..4ff4eed6c01d 100644
> --- a/tools/bpf/runqslower/Makefile
> +++ b/tools/bpf/runqslower/Makefile
> @@ -13,6 +13,12 @@ BPF_DESTDIR := $(BPFOBJ_OUTPUT)
>  BPF_INCLUDE := $(BPF_DESTDIR)/include
>  INCLUDES := -I$(OUTPUT) -I$(BPF_INCLUDE) -I$(abspath ../../include/uapi)
>  CFLAGS := -g -Wall $(CLANG_CROSS_FLAGS)
> +ifneq ($(EXTRA_CFLAGS),)
> +CFLAGS += $(EXTRA_CFLAGS)
> +endif
> +ifneq ($(EXTRA_LDFLAGS),)
> +LDFLAGS += $(EXTRA_LDFLAGS)
> +endif
>

can't we do this unconditionally? If those variables are not defined,
Makefile will substitute empty string, no?

>  # Try to detect best kernel BTF source
>  KERNEL_REL := $(shell uname -r)
> --
> 2.39.1
>
