Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7CC620A2F
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 08:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbiKHHbT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 02:31:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiKHHbS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 02:31:18 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEF8165B8
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 23:31:17 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id f27so36297266eje.1
        for <bpf@vger.kernel.org>; Mon, 07 Nov 2022 23:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xZmYc9iYKBTyEZcsaQr4WgOBZaXbquJpomSY7+RTeWM=;
        b=j3kMr3RJokCRsybjJfcPbX222mqsoSrjeDImldEUHU9law3QE4zDBLU/Rzbq1Lo2o2
         HVE9qn0PA7oyqFtSf90GG7ZaN9mvgH328ADSiSfbPKa8uS4jkKF7RmKyadthIC/iu/yd
         BtdD9dSgFj/Ahb5mLvwR/4A/WCsOPJ+maM0E7nRhERIRuCbR0SNaOGz1NE3LvUsOSAe6
         RcDZM6haSYwfpUROrChSuQumLvFet9Q/R9Ww0isns9LxDj0aaDUB7RHt09XUuF61VqbA
         4JVyzXiz/KqsUAitPlpbrmok7LMBRDRcqPdO3l3xB8t4T03sRJ9hITJbyIHm99qCtOvQ
         WVCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xZmYc9iYKBTyEZcsaQr4WgOBZaXbquJpomSY7+RTeWM=;
        b=PS92bYU2mBk8vxF7CDDZX0R64IfGD2Fi5epgHT5sjJm3BUlUfyF6H1YSlB+nez6Lmd
         fR+FbBRo7vSM1PRuKRqVqCF/WY/i6HDr6tl7xuGctPlsgskPXq0K5VNR32jgmKv01dy4
         Oe6JzcyDoLgu3RIVP+BB4+kPuAk0TEn25jtRKLMKCe+aByeouf+0gh9n17uaWSNtW2lQ
         GXbn/mH2dp1yiISaT1rmyDJ2UWyoh+bEmQioCmoioICARaG3Cm7zPTCWekDZFwXbg2cA
         YgtV11V/U+n6GXerzjIAYo3gIUMAZcJd5CeaKQaar8rYA5UWVxXkBUycfvekv9kuUe5P
         LmpQ==
X-Gm-Message-State: ACrzQf1+ter6SZjvPDNJCf8CUNc9WhlgLdyNfHosNRZpcjJhgmkYkH4r
        aDdCQqoEjsxW2z1BC29jB32MTyscR0yZwmyNgWA=
X-Google-Smtp-Source: AMsMyM7CElExos3tIzMk/XYoJloBV95R5/AAiNa734OhXN4II73mkzYZJ74BgkqQDavmkS/u80qyw5jdljYQ7b8o8qs=
X-Received: by 2002:a17:906:3b88:b0:78d:513d:f447 with SMTP id
 u8-20020a1709063b8800b0078d513df447mr939209ejf.708.1667892676247; Mon, 07 Nov
 2022 23:31:16 -0800 (PST)
MIME-Version: 1.0
References: <20221106202910.4193104-1-eddyz87@gmail.com> <20221106202910.4193104-2-eddyz87@gmail.com>
 <CAADnVQJNFqGE+5b9kicHnfxd37bpeCJV1Cz+5rXi-vt8imTMaQ@mail.gmail.com> <CAEf4BzZ8KFneEJxFAaNCCFPGqp20hSpS2aCj76uRk3-qZUH5xg@mail.gmail.com>
In-Reply-To: <CAEf4BzZ8KFneEJxFAaNCCFPGqp20hSpS2aCj76uRk3-qZUH5xg@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 7 Nov 2022 23:31:04 -0800
Message-ID: <CAADnVQJtXsNtiARFKb6_Jc8i7EgMjsJu+AtEbaZTC=i6AWdT2w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] libbpf: hashmap interface update to long
 -> long
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
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

On Mon, Nov 7, 2022 at 4:47 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> +
> +#define hashmap__find(map, key, value) ({
>                          \
> +               _Static_assert(value == NULL || sizeof(*value) ==
> sizeof(long),                 \
> +                              "Value pointee should be a long-sized
> integer or a pointer");    \
> +               hashmap_find(map, (long)key, (long *)value);
>                          \
> +})

Well, that's a different story :)
