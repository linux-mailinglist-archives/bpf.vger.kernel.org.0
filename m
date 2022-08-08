Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9673A58CCD6
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 19:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244207AbiHHRli (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 13:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243868AbiHHRlX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 13:41:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D34FDEC5
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 10:40:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9B880B8105F
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 17:40:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CEA2C4347C
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 17:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659980439;
        bh=VNh6CmjijPgqdF3Pt5Mp1wyR31XHB83bEMO7A3Uy6Y8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X4meTR5MYvVxaHTeIrWLG1oxj+WevfW8H7iRJrG+fzI6IIUGkr3aucmnsZ7kT8PRB
         2qZhZyPDRlhkOUHTEcYHCVlq+1zrS2NX1uuq9in7qQa48KCy8Jn9WVR0E2e7nOrS2R
         SNBterFRLglSTwfOm0Qk21jDyaozrcOg955/trX2bE5pTH9nzo9Bt4R29k8lxXvbuT
         qrzxsqYc+PSEjIZ9Z+iTrmbXHLyZjhB+zrsbFC29wggLpQ4xNUm6/xv3QfN/yVFeId
         im9/p+GwjvbqB2xk7eHJ2BJQ3QoEjEIgNjCpkhK2AYP8hd+/RzRz9GlFv1JaEuAm5U
         89Mj5CydTyxkQ==
Received: by mail-yb1-f176.google.com with SMTP id n8so14792192yba.2
        for <bpf@vger.kernel.org>; Mon, 08 Aug 2022 10:40:39 -0700 (PDT)
X-Gm-Message-State: ACgBeo0rQ+PFN5q5BpsBKrOFl4YzJrd7Ute//GknQvJc4A0ZI0M5Fha/
        oPhoL5AKPbUkCJvaFnvTcJ4SJDaU5PWLEo9ZNfg=
X-Google-Smtp-Source: AA6agR5naVhXEQrwU/GQIy0UUSSztH1XqQpiOiVMm0OTecOnStneKZEfI6obG6lrD8WkvnoZVe80h7Js+6xjSeFhbXs=
X-Received: by 2002:a25:55c5:0:b0:670:96cb:a295 with SMTP id
 j188-20020a2555c5000000b0067096cba295mr16167924ybb.449.1659980438382; Mon, 08
 Aug 2022 10:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220808140626.422731-1-jolsa@kernel.org> <20220808140626.422731-2-jolsa@kernel.org>
In-Reply-To: <20220808140626.422731-2-jolsa@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Mon, 8 Aug 2022 10:40:27 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4GKZ8_6mwGwTDjkGx_0TSzzBvvV-EsmfVBXCobMEnDzw@mail.gmail.com>
Message-ID: <CAPhsuW4GKZ8_6mwGwTDjkGx_0TSzzBvvV-EsmfVBXCobMEnDzw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 01/17] bpf: Link shimlink directly in trampoline
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 8, 2022 at 7:06 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> We are going to get rid of struct bpf_tramp_link in following
> changes and cgroup_shim_find logic does not fit to that.
>
> We can store the link directly in the trampoline and omit the
> cgroup_shim_find searching logic.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/bpf.h     |  3 +++
>  kernel/bpf/trampoline.c | 23 +++--------------------
>  2 files changed, 6 insertions(+), 20 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 20c26aed7896..ed2a921094bc 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -841,6 +841,8 @@ struct bpf_tramp_image {
>         };
>  };
>
> +struct bpf_shim_tramp_link;
> +
>  struct bpf_trampoline {
>         /* hlist for trampoline_table */
>         struct hlist_node hlist;
> @@ -868,6 +870,7 @@ struct bpf_trampoline {
>         struct bpf_tramp_image *cur_image;
>         u64 selector;
>         struct module *mod;
> +       struct bpf_shim_tramp_link *shim_link;
>  };

Hi Stanislav,

Is it possible to have multiple shim_link per bpf_trampoline? If so, I guess
this won't work.

Thanks,
Song

[...]
