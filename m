Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8F95ECC0E
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 20:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbiI0STj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 14:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiI0STi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 14:19:38 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFCA5FC0
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 11:19:32 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id bj12so22399311ejb.13
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 11:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=0zODCicjuWF3s0/MqrrHjtnvQlTEwnoBjfRItL1Ism8=;
        b=Hj7fb01bn1EOG+zml3cKESlIg6aOTJdYrP88UcShVWtR62PEoWXUSnibpv5PeVpqgj
         esW/K1zjLlS35HZlGOb8k0eybcvep2lTOGegvE8hnq6NWBbiRuTVT+yB+IF1bjquNB8w
         sthFrhMCM+xX8ZjpjRkz9pLWkys/KdQ20KlrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=0zODCicjuWF3s0/MqrrHjtnvQlTEwnoBjfRItL1Ism8=;
        b=ksVorn4B2Fuo7ON4XaNukFdMnGj1t7S6xyj0aT0vVTYLnMmkRAu/1pyoVFtqXoc10i
         6QBmFBJqthwyUsS4yk85xHwt++6SXrm1C21ld9xCGdmKGQPie/HB+pdnTER9nG9N3CRB
         T24tBPUXWu3/ORwXRay8ENWkNI6pHKLS8Olh5wvybDhQgjhtZLD419VsBQM4iPAueCW2
         7xfojuN+3d6avMsKyLCZK3uU4nP7/E7gRLxasFzRmh+Uj51yFPrd2pJYHYlSP4LC8Wve
         8jhBjie3trn7+Go/OOw5hXl4VVd63ecpdMqCR16Ht2eNAA9DeWukK2PGfn1RecohvrAc
         jJVg==
X-Gm-Message-State: ACrzQf3NcWh6gGJn09ZEdpWKZd4NHAqK5NhfJGK4AiVaRatG4phy/Wk9
        o7mKa536NVI0onIalebQMyeW9mK1GOtt3KjGq36/jw==
X-Google-Smtp-Source: AMsMyM5vNghVhEE/FP6mOqV+8atrlFIDqLpV76QcI9hRS0RrRr8zQ+77iQvwFmv1xxrokvn1SFgT+MH5b76sipcSDA8=
X-Received: by 2002:a17:906:4fd1:b0:787:434f:d755 with SMTP id
 i17-20020a1709064fd100b00787434fd755mr2485254ejw.356.1664302770861; Tue, 27
 Sep 2022 11:19:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220926231822.994383-1-drosen@google.com> <20220926231822.994383-4-drosen@google.com>
In-Reply-To: <20220926231822.994383-4-drosen@google.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 27 Sep 2022 20:19:19 +0200
Message-ID: <CAJfpegsC6=HhYALdU_4vSEmxPCxNNPS4NkcDyU6E1y7N_rqhJw@mail.gmail.com>
Subject: Re: [PATCH 03/26] fuse-bpf: Update uapi for fuse-bpf
To:     Daniel Rosenberg <drosen@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@google.com>,
        David Anderson <dvander@google.com>,
        Sandeep Patil <sspatil@google.com>,
        linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@android.com, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 27 Sept 2022 at 01:18, Daniel Rosenberg <drosen@google.com> wrote:

> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index d6ccee961891..8c80c146e69b 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -572,6 +572,17 @@ struct fuse_entry_out {
>         struct fuse_attr attr;
>  };
>
> +#define FUSE_ACTION_KEEP       0
> +#define FUSE_ACTION_REMOVE     1
> +#define FUSE_ACTION_REPLACE    2
> +
> +struct fuse_entry_bpf_out {
> +       uint64_t        backing_action;
> +       uint64_t        backing_fd;

This is a security issue.   See this post from Jann:

https://lore.kernel.org/all/CAG48ez17uXtjCTa7xpa=JWz3iBbNDQTKO2hvn6PAZtfW3kXgcA@mail.gmail.com/

The fuse-passthrough series solved this by pre-registering the
passthrogh fd with an ioctl. Since this requires an expicit syscall on
the server side the attack is thwarted.

It would be nice if this mechanism was agreed between these projects.

BTW, does fuse-bpf provide a superset of fuse-passthrough?  I mean
could fuse-bpf work with a NULL bpf program as a simple passthrough?

Thanks,
Miklos
