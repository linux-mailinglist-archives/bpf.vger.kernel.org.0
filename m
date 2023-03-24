Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0719F6C8608
	for <lists+bpf@lfdr.de>; Fri, 24 Mar 2023 20:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjCXThK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 15:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjCXThJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 15:37:09 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908F06585
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 12:37:08 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id o197-20020a62cdce000000b0062be61a5e48so497360pfg.22
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 12:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679686628;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r14m9hc6AZ12axiL6vTet9m5cAa8svLf8Q1kmVCNnMc=;
        b=kBcSmNETfigk0mZmpH+43RcIghrt/uTTa/mbIngNF1EEKjC23b5RtB4LMXpUN208kR
         YH0inbLhn5tixErQf6jlF4VEURwx5sY9ME9j7SyNs1waakP6chcWtrlGmPtjC+FG/ktJ
         +ql8OLkVFSxxJADV2PMgd5DdeDwftYhPKyAVkOI7cSe37+rimpQ1RYWqa85I1vrffHrD
         YVVaNtDmOExxlV6sx76iZQmO17/VgpLFYf+CWdSR4hQFzdEvmFVug+HcR/TI5M31I73U
         AdEmehYySdkrxOkd0iuPyG4kRQF27KSxZwPRoo+aXicx+jFvwObB0kesLwozk6OknuM+
         aVyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679686628;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r14m9hc6AZ12axiL6vTet9m5cAa8svLf8Q1kmVCNnMc=;
        b=o7YyS/2NiDE3URjngP95H9rFWhP6CiYTudq5fiJYh3T2ijeQHjAshM8lyuhFcaNIsL
         HioAFtAfqxTuI6KxmyddI2u928w+/XFucUt/S9QwJX9H0/JSO53HpOYLHXQ3uaLed5o8
         g3qMbcaE0I0pDI/5ThCKZ7e0pVSSXWOv+xTxHMvIYGyA5I+AswR7noIYx6k2TdxSnLF6
         SgpFBQ3QY4PquuYxtYohDzPI0YuBKh6y0BQrRjXPyEx+80h02zJwVoBfQr5Urg/SAu2D
         k+RamLeMkXqAcHjgZFCfu3GckdjlPxwLJFG21c58yP6RA2RX0+aJNR777/Q8TwwSlqyu
         GHIA==
X-Gm-Message-State: AAQBX9eHgBSJfptdwusoPq/T4rHwUN3spelt2CilIR0y4ru66X/2bQdJ
        lbDXwAkeTanIQtsSIL0XwaZuWCc=
X-Google-Smtp-Source: AKy350Y2oeg6eAFG7yMO9WzRObeNRMHUA41QPA5lWeGAZnuvQtYcQe6rdloRviSz+2Qeyugmu9ozDKk=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:653:0:b0:503:7cc9:3f8d with SMTP id
 80-20020a630653000000b005037cc93f8dmr893189pgg.9.1679686628116; Fri, 24 Mar
 2023 12:37:08 -0700 (PDT)
Date:   Fri, 24 Mar 2023 12:37:06 -0700
In-Reply-To: <20230324184241.1387437-1-martin.lau@linux.dev>
Mime-Version: 1.0
References: <20230324184241.1387437-1-martin.lau@linux.dev>
Message-ID: <ZB374mah1ciIH7TH@google.com>
Subject: Re: [PATCH bpf-next] bpf: Check IS_ERR for the bpf_map_get() return value
From:   Stanislav Fomichev <sdf@google.com>
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com,
        syzbot+71ccc0fe37abb458406b@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/24, Martin KaFai Lau wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>

> This patch fixes a mistake in checking NULL instead of
> checking IS_ERR for the bpf_map_get() return value.

> It also fixes the return value in link_update_map() from -EINVAL
> to PTR_ERR(*_map).

> Reported-by: syzbot+71ccc0fe37abb458406b@syzkaller.appspotmail.com
> Fixes: 68b04864ca42 ("bpf: Create links for BPF struct_ops maps.")
> Fixes: aef56f2e918b ("bpf: Update the struct_ops of a bpf_link.")
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>

Acked-by: Stanislav Fomichev <sdf@google.com>

> ---
>   kernel/bpf/bpf_struct_ops.c | 4 ++--
>   kernel/bpf/syscall.c        | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)

> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index 6401deca3b56..d3f0a4825fa6 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -871,8 +871,8 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
>   	int err;

>   	map = bpf_map_get(attr->link_create.map_fd);
> -	if (!map)
> -		return -EINVAL;
> +	if (IS_ERR(map))
> +		return PTR_ERR(map);

>   	st_map = (struct bpf_struct_ops_map *)map;

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index b4d758fa5981..a09597c95029 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -4689,12 +4689,12 @@ static int link_update_map(struct bpf_link *link,  
> union bpf_attr *attr)

>   	new_map = bpf_map_get(attr->link_update.new_map_fd);
>   	if (IS_ERR(new_map))
> -		return -EINVAL;
> +		return PTR_ERR(new_map);

>   	if (attr->link_update.flags & BPF_F_REPLACE) {
>   		old_map = bpf_map_get(attr->link_update.old_map_fd);
>   		if (IS_ERR(old_map)) {
> -			ret = -EINVAL;
> +			ret = PTR_ERR(old_map);
>   			goto out_put;
>   		}
>   	} else if (attr->link_update.old_map_fd) {
> --
> 2.34.1

