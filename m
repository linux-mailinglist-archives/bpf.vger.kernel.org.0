Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83FA617FE0
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 15:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbiKCOpm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 10:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbiKCOpk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 10:45:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115816306
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 07:45:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3B4D61F04
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 14:45:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 150D5C43141
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 14:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667486739;
        bh=P29LhEw9WrkiY4fm7lLX7er4nbuMbW+5FA4EaJK5Uq0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EGfS6D73WS/y6B6oz8oBlKmK9qsJ0TNdZ7xSNKAJT9nFyhVO2mY2w5FXz8NPiMLp3
         nOQPcGcaeTNg0VFdyeoPF0W2XNg8m5ESzv0jzCvyqygcrH+3KcReJzCxBw7k/egUyf
         Kr95WXeWy5b5bp3JmQNhZChMO5ns1VTzC4ERu4u6Sn6ZpF4obrrc5KlyUgf250ac4M
         DwMAEhdli9yZAWDclGl4+3MQpGA9Z7zk0o+Wuw07Uv4m3rJ3eBA6aSd1ZGpCL2SE7f
         IXxNCqhiA/bEFJywz6dGBlpcwS9Uqky2v6M7xrgV+fq4AobrnJAvZVTtNrXNi2esdE
         YDyjUlWrsYORA==
Received: by mail-lf1-f45.google.com with SMTP id b2so3206699lfp.6
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 07:45:38 -0700 (PDT)
X-Gm-Message-State: ACrzQf0YqTpHl66AnqrKh1VwGWIYoxzOiBlPU0u8N3ICCC62O4DRt+D8
        NqEpviAkjH1ZYsRwIemuiY7Ia2IR4a6gtHxLoU95XA==
X-Google-Smtp-Source: AMsMyM6Njc+YgdKFoO868L7BsA9FLJtfNJXDzoYX+459WrWMRcISsNAZ0ufGzOjOIoS2PNUHeeXOz1XOdFXECyu8T4g=
X-Received: by 2002:ac2:5dec:0:b0:4af:ee74:aa82 with SMTP id
 z12-20020ac25dec000000b004afee74aa82mr11256860lfq.406.1667486737077; Thu, 03
 Nov 2022 07:45:37 -0700 (PDT)
MIME-Version: 1.0
References: <20221103072102.2320490-1-yhs@fb.com> <20221103072123.2325032-1-yhs@fb.com>
In-Reply-To: <20221103072123.2325032-1-yhs@fb.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Thu, 3 Nov 2022 15:45:26 +0100
X-Gmail-Original-Message-ID: <CACYkzJ65L=8jbGA3Z5H_2A=JvD4A_v6yQkFHEGZbfo2uRm5qOA@mail.gmail.com>
Message-ID: <CACYkzJ65L=8jbGA3Z5H_2A=JvD4A_v6yQkFHEGZbfo2uRm5qOA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/5] bpf: Enable sleeptable support for cgrp
 local storage
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 3, 2022 at 8:21 AM Yonghong Song <yhs@fb.com> wrote:
>
> With proper bpf_rcu_read_lock() support, sleepable support for cgrp local
> storage can be enabled as typical use case task->cgroups->dfl_cgrp
> can be protected with bpf_rcu_read_lock().
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  kernel/bpf/verifier.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>

nit: subject line: "Sleeptable -> Sleepable"

Acked-by: KP Singh <kpsingh@kernel.org>
