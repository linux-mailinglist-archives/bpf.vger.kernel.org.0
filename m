Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92EBE5A3A9E
	for <lists+bpf@lfdr.de>; Sun, 28 Aug 2022 02:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbiH1AZM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 27 Aug 2022 20:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiH1AZM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 27 Aug 2022 20:25:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223441A07D
        for <bpf@vger.kernel.org>; Sat, 27 Aug 2022 17:25:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A433560EC8
        for <bpf@vger.kernel.org>; Sun, 28 Aug 2022 00:25:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A1DC43140
        for <bpf@vger.kernel.org>; Sun, 28 Aug 2022 00:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661646310;
        bh=sweShQ61LtekFM40yYQjlFAj+7T2XgJI4jRDJIumN1U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XftaRUJCXkcH8AIWi9Mb/X14EOa3Cfx9eQ2yDgpIwdEjV0wpnjhj5dPD2f3THJiKV
         0TdbtjFS+ZGytUorxkC+OVSEV13jCwPtI77qdq4YBVDxI4t7F5S+f6k/VllD57Bxqb
         Vr1bTTrD1hhr1MyyrOfg4eO/fSNjU3Cf9em+WH82GbjLyuwSGe2rOCir+7uR2t60ew
         hSRWtuv9tBdXQzPMYwkB/GVnkUpmeJZiyEMIINHeaWjXa7AdQi4RDo0B8ShuUyg/TZ
         LQRIIxI/nABJ0cTyT4mlETLsm5eoFHZZpgHbXcGzDfNXoNTUUOsJ7H6JFQu8rMvQvG
         OnfYzRuXdh7+w==
Received: by mail-qt1-f182.google.com with SMTP id cb8so3913641qtb.0
        for <bpf@vger.kernel.org>; Sat, 27 Aug 2022 17:25:09 -0700 (PDT)
X-Gm-Message-State: ACgBeo3ofX/q3Qaz5TkS9eYSoMBTdjLvJArkr9DJbZ9U1upXT2Ca73BK
        0z1nH/WjhcScFUZDS/c4qpnZ20Qteim//4IFtVjV1Q==
X-Google-Smtp-Source: AA6agR7c0gyC8B49Pi5GMSiuNxrdau3LBkgAOtJn0snnMSkmgCxPVv66I25tl7pcvD2iO4+n/hHeobGrLjdngoZkkpA=
X-Received: by 2002:a05:622a:4cf:b0:344:54e1:c1fe with SMTP id
 q15-20020a05622a04cf00b0034454e1c1femr5086376qtx.250.1661646308724; Sat, 27
 Aug 2022 17:25:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220827100134.1621137-1-houtao@huaweicloud.com> <20220827100134.1621137-2-houtao@huaweicloud.com>
In-Reply-To: <20220827100134.1621137-2-houtao@huaweicloud.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Sun, 28 Aug 2022 02:24:58 +0200
X-Gmail-Original-Message-ID: <CACYkzJ7r_i9+XaE-WJzJao2J4=1fH39Xb4u4o733ZtLwxh0WPg@mail.gmail.com>
Message-ID: <CACYkzJ7r_i9+XaE-WJzJao2J4=1fH39Xb4u4o733ZtLwxh0WPg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/3] bpf: Propagate error from
 htab_lock_bucket() to userspace
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Hao Luo <haoluo@google.com>, Hao Sun <sunhao.th@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <oss@lmb.io>, houtao1@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Aug 27, 2022 at 11:43 AM Hou Tao <houtao@huaweicloud.com> wrote:
>
> From: Hou Tao <houtao1@huawei.com>
>
> In __htab_map_lookup_and_delete_batch() if htab_lock_bucket() returns
> -EBUSY, it will go to next bucket. Going to next bucket may not only
> skip the elements in current bucket silently, but also incur
> out-of-bound memory access or expose kernel memory to userspace if
> current bucket_cnt is greater than bucket_size or zero.
>
> Fixing it by stopping batch operation and returning -EBUSY when
> htab_lock_bucket() fails, and the application can retry or skip the busy
> batch as needed.
>
> Reported-by: Hao Sun <sunhao.th@gmail.com>
> Signed-off-by: Hou Tao <houtao1@huawei.com>

Please add a Fixes tag here

> ---
>  kernel/bpf/hashtab.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 6fb3b7fd1622..eb1263f03e9b 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -1704,8 +1704,11 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
>         /* do not grab the lock unless need it (bucket_cnt > 0). */
>         if (locked) {
>                 ret = htab_lock_bucket(htab, b, batch, &flags);
> -               if (ret)
> -                       goto next_batch;
> +               if (ret) {
> +                       rcu_read_unlock();
> +                       bpf_enable_instrumentation();
> +                       goto after_loop;
> +               }
>         }
>
>         bucket_cnt = 0;
> --
> 2.29.2
>
