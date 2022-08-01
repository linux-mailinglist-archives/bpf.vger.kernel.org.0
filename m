Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD29586D49
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 16:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbiHAOwa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 10:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbiHAOw3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 10:52:29 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC19E82;
        Mon,  1 Aug 2022 07:52:28 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id c185so8540874iof.7;
        Mon, 01 Aug 2022 07:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l7ojz6Jr8VoXsOFJvjo5w+Wh1LaqUsoO8fMGMvKg3Yo=;
        b=djC127ULTFz4xJs8CmEcWzLu4J4dGN6sIoZ4sCuEpJ139tX8RkfyfYCEab4tz2nw4H
         uUK4NXxBShUg+KTl+QZg34fr57E+KWdj2TPnICQAM48h92c8Xr6NaMopq0xv1DfMdJGZ
         e56LZDh20rFVkrbYhdNNhcKnaTiP5skHBnOGLt9vhZxIpAfbmiNufHvMmm+66HRopi3Y
         Kh9oh+EhiMoSR73fSp9fSPSN2qMj641B4VGL3VmjvK4Z7zOv5XJEMlM+4W3WHCRJxObN
         aY+/Ae6/7BPZA8DPkkbpy3TjCYpBnu13khO59FpTlExf2+gRDVJfKz5MpNnrxK0CE9Am
         j6GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l7ojz6Jr8VoXsOFJvjo5w+Wh1LaqUsoO8fMGMvKg3Yo=;
        b=6vOi6z50Q0XKVM7oBa3caDmX6za3JzmhNXX4m+8DT2QP07RSW0RTMe64sqz6ttpOeZ
         wDxLwvuieNEoKwOIDLQqaxfo0+QiJlDryn28OCUxJSEMSbXAj/y1xTbn7UTq+eO6xfAj
         gLEqlm5cgRMbXmISkjIOZjWDUiaB8yd3mHoDy4S4He+iStEo0x6+FeK0HSZ8i+ZAyM8N
         Nx6/7WoPXFAfiyyRFkgS2NwK/AlvbZmaPWKe+cN1+PV26qy0UaiWOp1q65BCjsDqwXFi
         rDcf2OCaGAmgM0zI/8nNP8pfgxMa3BALClUqnNmocFV5u1KICTO3RA8t8KOPY6S69kxy
         ZX9Q==
X-Gm-Message-State: ACgBeo0rD3trcrD0u4/NAHrBSmteDEtPCfwU7A87xNLoZIZFKSfKOBgO
        wBt/H7B9SbZSHKg92WeR97Ds0j+5CPDNHReigHZYunFa
X-Google-Smtp-Source: AA6agR65Jkd0CJqIPC/14yJ+f24+zSh7iwI09gLN6VifIf6m70t5zlhNppdoBrDxMo6rZxSakZ2cSjFM3XumU2/wILY=
X-Received: by 2002:a05:6638:381d:b0:342:7727:50ad with SMTP id
 i29-20020a056638381d00b00342772750admr1753941jav.206.1659365548059; Mon, 01
 Aug 2022 07:52:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1659209738.git.dxu@dxuuu.xyz> <abd424ee71675e3008acd4a2c1fd136cb7dbf8be.1659209738.git.dxu@dxuuu.xyz>
In-Reply-To: <abd424ee71675e3008acd4a2c1fd136cb7dbf8be.1659209738.git.dxu@dxuuu.xyz>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Mon, 1 Aug 2022 16:51:52 +0200
Message-ID: <CAP01T75LMwpz3ZPSUgtX2_RDUhB33djJmJs8W--Qh4H8J9iNsQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add connmark read/write test
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, linux-kernel@vger.kernel.org
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

On Sat, 30 Jul 2022 at 21:40, Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> Test that the prog can read/write to/from the connection mark. This
> test is nice because it ensures progs can interact with netfilter
> subsystem correctly.
>

Commit message is a bit misleading, where are you writing to ct->mark? :)
The cover letter also mentions "reading and writing from nf_conn". Do
you have patches whitelisting nf_conn::mark for writes?
If not, drop the writing related bits from the commit log. The rest
looks ok to me.


> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  tools/testing/selftests/bpf/prog_tests/bpf_nf.c | 3 ++-
>  tools/testing/selftests/bpf/progs/test_bpf_nf.c | 3 +++
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_nf.c b/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
> index 317978cac029..7232f6dcd252 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
> @@ -44,7 +44,7 @@ static int connect_to_server(int srv_fd)
>
>  static void test_bpf_nf_ct(int mode)
>  {
> -       const char *iptables = "iptables -t raw %s PREROUTING -j CT";
> +       const char *iptables = "iptables -t raw %s PREROUTING -j CONNMARK --set-mark 42/0";
>         int srv_fd = -1, client_fd = -1, srv_client_fd = -1;
>         struct sockaddr_in peer_addr = {};
>         struct test_bpf_nf *skel;
> @@ -114,6 +114,7 @@ static void test_bpf_nf_ct(int mode)
>         /* expected status is IPS_SEEN_REPLY */
>         ASSERT_EQ(skel->bss->test_status, 2, "Test for ct status update ");
>         ASSERT_EQ(skel->data->test_exist_lookup, 0, "Test existing connection lookup");
> +       ASSERT_EQ(skel->bss->test_exist_lookup_mark, 43, "Test existing connection lookup ctmark");
>  end:
>         if (srv_client_fd != -1)
>                 close(srv_client_fd);
> diff --git a/tools/testing/selftests/bpf/progs/test_bpf_nf.c b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> index 84e0fd479794..2722441850cc 100644
> --- a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> +++ b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> @@ -28,6 +28,7 @@ __be16 sport = 0;
>  __be32 daddr = 0;
>  __be16 dport = 0;
>  int test_exist_lookup = -ENOENT;
> +u32 test_exist_lookup_mark = 0;
>
>  struct nf_conn;
>
> @@ -174,6 +175,8 @@ nf_ct_test(struct nf_conn *(*lookup_fn)(void *, struct bpf_sock_tuple *, u32,
>                        sizeof(opts_def));
>         if (ct) {
>                 test_exist_lookup = 0;
> +               if (ct->mark == 42)
> +                       test_exist_lookup_mark = 43;
>                 bpf_ct_release(ct);
>         } else {
>                 test_exist_lookup = opts_def.error;
> --
> 2.37.1
>
