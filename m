Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E976095ED
	for <lists+bpf@lfdr.de>; Sun, 23 Oct 2022 21:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbiJWT7v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 23 Oct 2022 15:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiJWT7t (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 23 Oct 2022 15:59:49 -0400
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D090F12772
        for <bpf@vger.kernel.org>; Sun, 23 Oct 2022 12:59:45 -0700 (PDT)
Received: by mail-qk1-f177.google.com with SMTP id j21so5082236qkk.9
        for <bpf@vger.kernel.org>; Sun, 23 Oct 2022 12:59:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+4AG9zYBOfoXIWmhNXxMXehcIp0R/cvjreavlPr6oNw=;
        b=WDRhdMG5+uGtAeJw356CnHqtuBKA5b9DWJZTwumXd6OV9o1YggE/ODc1WXBKOp/EuP
         Reb4j3BFenp61uzLwxkffslMJGAWsoiw4G9CWrENTuFk7PcbPF9U6c5Vre08LYnOZhar
         leZNhAFPBWdyyiHKJMZGKmlpj23hqyD5NfMgFVwHMHBbXd36VaIch7cXvLZIiE2osCrS
         iKXW1c9FL+NTW2kUCeFzYydrAw23/dYZfTwdcxi/T8B7kINMwaUc74/tcbhiHldFGkAz
         g/ThzNSnV89aaFWdHGTS0Cz38O1D3bMru2H1rgbKg66UmabqqKt49+Re1co0t/VT9pYW
         sUQg==
X-Gm-Message-State: ACrzQf0kcMILiVAWcY5IwGitQG1Oqp/vpY9EGUy0mhpkPJZbM94tx2AW
        xt1c3AHYySrPkx4K0KPXOuM=
X-Google-Smtp-Source: AMsMyM4GxTVWKka/WIjDVJwvZlvzAC+gzIQ89Ux3kA/QnaLv41qwPcTvqYpVU6BdzQG9P2/1tin8ow==
X-Received: by 2002:a05:620a:204d:b0:6ec:7d7:c267 with SMTP id d13-20020a05620a204d00b006ec07d7c267mr20369463qka.590.1666555184810;
        Sun, 23 Oct 2022 12:59:44 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::3f58])
        by smtp.gmail.com with ESMTPSA id d4-20020ac81184000000b00359961365f1sm11484476qtj.68.2022.10.23.12.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 12:59:43 -0700 (PDT)
Date:   Sun, 23 Oct 2022 14:59:39 -0500
From:   David Vernet <void@manifault.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next v4 1/7] bpf: Make struct cgroup btf id global
Message-ID: <Y1WdK/1vmt/LBbQc@maniforge.dhcp.thefacebook.com>
References: <20221023180514.2857498-1-yhs@fb.com>
 <20221023180519.2858371-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221023180519.2858371-1-yhs@fb.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Oct 23, 2022 at 11:05:19AM -0700, Yonghong Song wrote:
> Make struct cgroup btf id global so later patch can reuse
> the same btf id.
> 
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  include/linux/btf_ids.h  | 1 +
>  kernel/bpf/cgroup_iter.c | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
> index 2aea877d644f..c9744efd202f 100644
> --- a/include/linux/btf_ids.h
> +++ b/include/linux/btf_ids.h
> @@ -265,5 +265,6 @@ MAX_BTF_TRACING_TYPE,
>  };
>  
>  extern u32 btf_tracing_ids[];
> +extern u32 bpf_cgroup_btf_id[];
>  
>  #endif
> diff --git a/kernel/bpf/cgroup_iter.c b/kernel/bpf/cgroup_iter.c
> index 0d200a993489..c6ffc706d583 100644
> --- a/kernel/bpf/cgroup_iter.c
> +++ b/kernel/bpf/cgroup_iter.c
> @@ -157,7 +157,7 @@ static const struct seq_operations cgroup_iter_seq_ops = {
>  	.show   = cgroup_iter_seq_show,
>  };
>  
> -BTF_ID_LIST_SINGLE(bpf_cgroup_btf_id, struct, cgroup)
> +BTF_ID_LIST_GLOBAL_SINGLE(bpf_cgroup_btf_id, struct, cgroup)
>  
>  static int cgroup_iter_seq_init(void *priv, struct bpf_iter_aux_info *aux)
>  {
> -- 
> 2.30.2
> 

Acked-by: David Vernet <void@manifault.com>
