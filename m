Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6B9686EAD
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 20:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbjBATKn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 14:10:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjBATKm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 14:10:42 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A967241F0
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 11:10:42 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id a23so223016pga.13
        for <bpf@vger.kernel.org>; Wed, 01 Feb 2023 11:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6ilVhJc0KLaqYnWcVF2XM/01kZ5HMNBRjsvcGb6cfig=;
        b=Vof8VT7+R99GRr4Zp5nO/gYx5VOCsXms2LfF7NNN6i2WZzpvDV7nHXdawp3ox3qAD2
         C18J8JBT6tiMZnIMZ22WNgEs5WNRbsEFppuwWfH2jKbc6MkmGt1bXmsV+J3W+ItUTjMu
         ZM9jqgc5kiJ3iirH0HXxLAfdlaEJyF4iFprmXWJCRy+q6XMID1ajLiuwgDIwNpmEL3uY
         /qW17kORqcUfBKZ4jE3DmaxowVnAjwy1/KjFGO0rsatoo7NWCMwT/Jxlgn0Oyly11l/v
         C2n2+yjXplD0wLBnqWa4Hzr07cCazfJp9w1x182/mEcdDdQ8s2MoGUYs+s9IchQaJRkY
         2B7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ilVhJc0KLaqYnWcVF2XM/01kZ5HMNBRjsvcGb6cfig=;
        b=oxHZCY/qF470t3hY6qU2Thowy1vuZO+KTUY7+SeiDlEe6n6mVep9yvYrUQBhug356m
         Uvpb4tcB+WoK68fkeq7ar11gGC7tTVJMz515uekF6eFE1t0lg4gq64EwJPHy8Yvrc8TV
         hFkL7Vb2lMlCka6nCXcZUqmOkhybRCutSDnGichxjX28s/n3yIRXEOPSKswRUW0q2DMM
         FYKzC9hjyLNMS2eP7bIBI/7Q0JnhwCRIVtTvvw4GQ4mbjavI220CrdpBqLr2smgPZTbh
         oLqOsFSwi8oxW5pmLrcrA0dc37o8SD9q3RzEUJmIR3+DrOt+DnuGc4zjGbaEyIQbNZ2A
         Xa0w==
X-Gm-Message-State: AO0yUKXa8wdB7QLoWJEyMSnRqd8xskBRPIp5LQ1vRboO3vLFfn0UE/+C
        sYnVrTyouDwWgZploCb+Xrznu5mlNyxmEvne7hW5Hw==
X-Google-Smtp-Source: AK7set8goKUSoGkjWGVqXqgWWcQEZYI0hUhX1EATDo3o3SV+MZjzebVUz/ZYkOyZlmBkTPVDaGW9HGFtC9aOKQKhoTc=
X-Received: by 2002:aa7:94b9:0:b0:593:1253:2ff5 with SMTP id
 a25-20020aa794b9000000b0059312532ff5mr802084pfl.14.1675278641256; Wed, 01 Feb
 2023 11:10:41 -0800 (PST)
MIME-Version: 1.0
References: <167527517464.938135.13750760520577765269.stgit@firesoul>
In-Reply-To: <167527517464.938135.13750760520577765269.stgit@firesoul>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 1 Feb 2023 11:10:29 -0800
Message-ID: <CAKH8qBt3XjsvhJfmkEpFxTOVPYNdLnrBOHZ9ekLM30hq6y4GEA@mail.gmail.com>
Subject: Re: [PATCH bpf-next V1] selftests/bpf: fix unmap bug in prog_tests/xdp_metadata.c
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, martin.lau@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, dsahern@gmail.com, willemb@google.com,
        void@manifault.com, kuba@kernel.org, xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 1, 2023 at 10:13 AM Jesper Dangaard Brouer
<brouer@redhat.com> wrote:
>
> The function close_xsk() unmap via munmap() the wrong memory pointer.
>
> The call xsk_umem__delete(xsk->umem) have already freed xsk->umem.
> Thus the call to munmap(xsk->umem, UMEM_SIZE) will have unpredictable
> behavior that can lead to Segmentation fault elsewhere, as man page
> explain subsequent references to these pages will generate SIGSEGV.
>
> Fixes: e2a46d54d7a1 ("selftests/bpf: Verify xdp_metadata xdp->af_xdp path")
> Reported-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>

Good catch, thank you!

Acked-by: Stanislav Fomichev <sdf@google.com>

> ---
>  .../selftests/bpf/prog_tests/xdp_metadata.c        |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> index e033d48288c0..241909d71c7e 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> @@ -121,7 +121,7 @@ static void close_xsk(struct xsk *xsk)
>                 xsk_umem__delete(xsk->umem);
>         if (xsk->socket)
>                 xsk_socket__delete(xsk->socket);
> -       munmap(xsk->umem, UMEM_SIZE);
> +       munmap(xsk->umem_area, UMEM_SIZE);
>  }
>
>  static void ip_csum(struct iphdr *iph)
>
>
