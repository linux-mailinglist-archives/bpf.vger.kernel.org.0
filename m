Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2F95F02C6
	for <lists+bpf@lfdr.de>; Fri, 30 Sep 2022 04:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiI3CcX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Sep 2022 22:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiI3CcW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Sep 2022 22:32:22 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BD8121127
        for <bpf@vger.kernel.org>; Thu, 29 Sep 2022 19:32:22 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id f193so3046865pgc.0
        for <bpf@vger.kernel.org>; Thu, 29 Sep 2022 19:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date;
        bh=MYTTq+XsMJYQ1g/WHUUHjaLYhRqVmlNLe944tatCqkc=;
        b=fxMSOQrzPvVMn2sQ4hJ+x/kI9AXW3NLD48x/XizAjQHV3xMRHwD43iqt5P7IB9lIeW
         TBSr6EN7oU1YqHBbAznCQkeKelDExzLu3q9CesC0QoFFdWI/r4IhKMlZY8PmxlFOMwmE
         fOM5KdmEBFC4hzRDX0QzgOtoC/CK0ZIPn0MdqhKPa+z4vgV2DBS3pCqRQHt5kW/E1Tcx
         hjNJRchXZjygNrsUKfNsFYJqFOADgkyhXJwgVxtlaq5jGKvwlUzxztBKKja5cQEI8t/o
         SWQ+w54Prv5ZYUBBq12I0JyZvndo0kRqDUtamAzfutwO/1dAewwuxns+wZ8SZF/sHg0D
         yMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date;
        bh=MYTTq+XsMJYQ1g/WHUUHjaLYhRqVmlNLe944tatCqkc=;
        b=IbpE4OeyhBcmdHKuqdOC5FndLHgoifhLTWL0L+CsJCcWJMC0AyiVo2Jd4b8zOJ7bvS
         rO4HOFq1dwenPqrLQ3r9JbqXuZTNIYJv8Ie1Pa8Hwcktxp1IUgmxantrzSClzuSirAJk
         M5u7YgRKyo1/XqZJ5gbS0SJQ1ZYPzCq9GTthBtn7L55tq4yvmBHkAnoM8li9u7qb5sQ7
         45YEi+BuJRA6LLN8ehCOcwIWAf3A8KyFI6qTB5ip4izw6Xx7BB2wwJkYgcMBMbMUP337
         lJ9iFLVlDUrLGs+6qjKHiLExvbmMT2kZ+cVKfiJGQoDfR2VuGZsCqWRIjSqURNqkGcWv
         8rTQ==
X-Gm-Message-State: ACrzQf1hJza+AVimmyo/kSk3NSRWMOxXSDNri5hoTF3zE/4fML8PALoX
        J7T654tWB1mq5DT5duuUDMg=
X-Google-Smtp-Source: AMsMyM60a/GnKn2C3nZGYZjjEUniKE9wxtebBrkE8tIC06wIEPWLVhepk4QXsL8zpayNYiz5F5wDgw==
X-Received: by 2002:a62:2983:0:b0:54e:7cd5:adb3 with SMTP id p125-20020a622983000000b0054e7cd5adb3mr6552773pfp.38.1664505141753;
        Thu, 29 Sep 2022 19:32:21 -0700 (PDT)
Received: from localhost ([98.97.42.14])
        by smtp.gmail.com with ESMTPSA id 21-20020a630a15000000b0042b291a89bfsm624288pgk.11.2022.09.29.19.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 19:32:20 -0700 (PDT)
Date:   Thu, 29 Sep 2022 19:32:18 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Anne Macedo <annemacedo@linux.microsoft.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Isabella Basso <isabbasso@riseup.net>,
        Paul Moore <paul@paul-moore.com>,
        Anne Macedo <annemacedo@linux.microsoft.com>
Message-ID: <63365532d416f_233df20899@john.notmuch>
In-Reply-To: <20220929160558.5034-1-annemacedo@linux.microsoft.com>
References: <20220929160558.5034-1-annemacedo@linux.microsoft.com>
Subject: RE: [PATCH] libbpf: add validation to BTF's variable type ID
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Anne Macedo wrote:
> If BTF is corrupted, a SEGV may occur due to a null pointer dereference on
> bpf_object__init_user_btf_map.
> 
> This patch adds a validation that checks whether the DATASEC's variable
> type ID is null. If so, it raises a warning.
> 
> Reported by oss-fuzz project [1].
> 
> A similar patch for the same issue exists on [2]. However, the code is
> unreachable when using oss-fuzz data.
> 
> [1] https://github.com/libbpf/libbpf/issues/484
> [2] https://patchwork.kernel.org/project/netdevbpf/patch/20211103173213.1376990-3-andrii@kernel.org/
> 
> Reviewed-by: Isabella Basso <isabbasso@riseup.net>
> Signed-off-by: Anne Macedo <annemacedo@linux.microsoft.com>
> ---
>  tools/lib/bpf/libbpf.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 184ce1684dcd..0c88612ab7c4 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -2464,6 +2464,10 @@ static int bpf_object__init_user_btf_map(struct bpf_object *obj,
>  
>  	vi = btf_var_secinfos(sec) + var_idx;
>  	var = btf__type_by_id(obj->btf, vi->type);
> +	if (!var || !btf_is_var(var)) {
> +		pr_warn("map #%d: non-VAR type seen", var_idx);
> +		return -EINVAL;
> +	}
>  	var_extra = btf_var(var);
>  	map_name = btf__name_by_offset(obj->btf, var->name_off);
>  
> -- 
> 2.30.2
> 


I don't know abouut this. A quick scan looks like this type_by_id is
used lots of places. And seems corrupted BTF could cause faults
and confusiuon in other spots as well. I'm not sure its worth making
libbpf survive corrupted BTF. OTOH this specific patch looks ok.

How did it get corrupted in the first place? Curious to see if
others want to harden libbpf like this.
