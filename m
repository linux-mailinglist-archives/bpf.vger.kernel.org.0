Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C7E621A1D
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 18:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbiKHRJj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 12:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234341AbiKHRJi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 12:09:38 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18891D32F
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 09:09:37 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so13611574pjs.4
        for <bpf@vger.kernel.org>; Tue, 08 Nov 2022 09:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XG/4G4JhpwRv2exmf1UiTL1jH5AaecpN8Sj8XhWfOIs=;
        b=XCZb+418L1/qjceocnhXKrBgKXIBB0gU/WNAzan50fom1/EyRlcMvFLsabIkmXLGlu
         iLwCNA7WhR5DAQ7PY+oxruKP98bA/gFEMp5zLRj4FFO8Gr0lrRSPVh1PMh+I0FxmwVk9
         H00KeucUmcRr+HgqNB7CeQ9iPM1z/NxYsvZVpRFnAoqm/+PElXChhlFMwIRkaMs85HQs
         v8haE5GCHH2NEF6/SotH57Oo7jzMu+VCMJJdR0hQKhqKLt0HNroBQdGGKuT0dNI5R5DU
         mNRUkyKZo/XVVCNUKfEH6ccHwfQJudq315/+yv/WQxTC38yj7Ch+9D+BkvE0X4N8uphb
         1E6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XG/4G4JhpwRv2exmf1UiTL1jH5AaecpN8Sj8XhWfOIs=;
        b=tEMcA71u9bO4dNaoDVGXbOlnYKOe1I7P8zOwEL8UGU7SgCPZSsvWwvPGRM1ora4I6N
         KGSDKNnq7ub4H/PXtBwXZknkTSLdh+KmP+vxR4kwBMWTx0xAOiqCek9+biRHJoj2v23u
         5ycL8qHHqX7DWekyj6jGoNVYKz8AL5D5doWRjN73mLyNuEkwRz3wvI9vOPskSwnpTW8y
         wzX7ZgqyIHfTan0yNtDzbmIxgQtIuadKf3kovlJt9RlKghiXngjJWE7vfRW2EAoS7cey
         V4wrYwHWsLCrlz0QO/55zNK7TtzlTbFkiZ/Rnf53IPmfaBCL87AQhlP2gWd3K3XBG8ts
         le+g==
X-Gm-Message-State: ACrzQf3SwYoPHqpOOu9HS50Y7AO7jo0JSR9VmCjY5Pfyo2M4/MGyWozx
        YKk2qiAVCvBzrx4OM9UIkzw=
X-Google-Smtp-Source: AMsMyM7/7u8/RYmv/+VSrVLA7L0Rl37cU1Fn6fOAAlaX/kXYCe/er0Z/ATDp5S8vH/GFR3VCl//CEQ==
X-Received: by 2002:a17:903:41cd:b0:182:f36b:3221 with SMTP id u13-20020a17090341cd00b00182f36b3221mr1022756ple.36.1667927377081;
        Tue, 08 Nov 2022 09:09:37 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id d25-20020aa797b9000000b0053e4296e1d3sm6602882pfq.198.2022.11.08.09.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 09:09:36 -0800 (PST)
Date:   Tue, 8 Nov 2022 22:39:31 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v2 4/8] bpf: Add kfunc bpf_rcu_read_lock/unlock()
Message-ID: <20221108170931.b75qdoy2ysjp4xwo@apollo>
References: <20221108074047.261848-1-yhs@fb.com>
 <20221108074109.263773-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108074109.263773-1-yhs@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 08, 2022 at 01:11:09PM IST, Yonghong Song wrote:
> Add two kfunc's bpf_rcu_read_lock() and bpf_rcu_read_unlock(). These two kfunc's
> can be used for all program types. A new kfunc hook type BTF_KFUNC_HOOK_GENERIC
> is added which corresponds to prog type BPF_PROG_TYPE_UNSPEC, indicating the
> kfunc intends to be used for all prog types.
>
> The kfunc bpf_rcu_read_lock() is tagged with new flag KF_RCU_LOCK and
> bpf_rcu_read_unlock() with new flag KF_RCU_UNLOCK. These two new flags
> are used by the verifier to identify these two helpers.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  include/linux/bpf.h  |  3 +++
>  include/linux/btf.h  |  2 ++
>  kernel/bpf/btf.c     |  8 ++++++++
>  kernel/bpf/helpers.c | 25 ++++++++++++++++++++++++-
>  4 files changed, 37 insertions(+), 1 deletion(-)
>
> For new kfuncs, I added KF_RCU_LOCK and KF_RCU_UNLOCK flags to
> indicate a helper could be bpf_rcu_read_lock/unlock(). This could
> be a waste for kfunc flag space as the flag is used to identify
> one helper. Alternatively, we might identify kfunc based on
> btf_id. Any suggestions are welcome.
>

It can be done similar to this change:
https://lore.kernel.org/bpf/20221107230950.7117-17-memxor@gmail.com
So compare meta.func_id to special_kfunc_list[KF_bpf_rcu_read_lock].

