Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816E962B120
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 03:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiKPCMF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 21:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiKPCL4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 21:11:56 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61B463A4
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 18:11:54 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id v17so15137353plo.1
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 18:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KlG4izqruLI+eVPwVb56QneDoxM3cuNDHZ53g4ubPvM=;
        b=Ak9MCLAvA2GBPRXf0QBz6QKrrowDoM9d1dTD+sXsUAWbcp+kpQheB6n2mD1QlNNrfF
         FNfgRgVZY6B5+u0zmvXEYLoKORqQZh0IpXnG8CayJQ7ElwlsJOw5J+fGhTJHt9lO5B6G
         X9skKmfj5EQhfW2pDH63UN37Ub+EphKq4h+3t2sK0+PyIJKn9ICzFwKFwMd0gmdeYehb
         0WulDrrj+hUyycJkydMEdIpc+y/CkeKcRsCHlOoo96aak/WwMhB/Tn542xGRMx00reEI
         sJFjrxgOtZS1lemrcrZkR69bdc65tFvLq8CBRUcwXAt8QOEoehFQ9ovUQUcdnnrzIN+O
         rkpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KlG4izqruLI+eVPwVb56QneDoxM3cuNDHZ53g4ubPvM=;
        b=bLHRH6I/nOJpEb1QMDQU8LC/ejQ1KaEOkf8tfcnbjc5tZegRr9i27Z8Op4atw0kJn8
         GSrg6AJBoTvXumJH7XZIjd/fgel/P7mxb+8SxdsE/QQyS/KGakxb4BHHGUAioiTW8NjY
         k44j7xNw4SnfJRZ+3PqV3n/RB2acAOm/sXWFQF2YMw0r9dzAZxBmjn3TWDPQ54vUgukO
         1HQ8qaOVCNjpfHl4j3Yxo9D/saBERUf91SMUsFxt8dTfXApHnexh1OBlhdXBa931mlyG
         EEOKanBsdV523Nc6D066AucyjipBqT7DRKs64RwPuRrJptH0Isi4q8SIHzDQXVkllymf
         HJ+Q==
X-Gm-Message-State: ANoB5pm9ZXier3cGjRRSsoltZ6Xdcyy6ljY9ALUNSpUoRYCcA51N9LLU
        MHcjlFdbJ7yjmT04LMXNCJM+XfvtQAjT/qhNNAlH
X-Google-Smtp-Source: AA0mqf7co3DQZqD8OdQJKEOz+zPQP8Krnul8up1/TRUoFzIhYtr4pGe1QxnzuRC2rDaXkKuBQ9Hkzm6/dN0BeRSPgdo=
X-Received: by 2002:a17:902:74c1:b0:186:c3b2:56d1 with SMTP id
 f1-20020a17090274c100b00186c3b256d1mr6809971plt.15.1668564714386; Tue, 15 Nov
 2022 18:11:54 -0800 (PST)
MIME-Version: 1.0
References: <20221115175652.3836811-1-roberto.sassu@huaweicloud.com> <20221115175652.3836811-2-roberto.sassu@huaweicloud.com>
In-Reply-To: <20221115175652.3836811-2-roberto.sassu@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 15 Nov 2022 21:11:43 -0500
Message-ID: <CAHC9VhQjnwbFgAoFgTaLQP7YnNDNyP1i0i8H++HZWj930pW=-A@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/4] lsm: Clarify documentation of vm_enough_memory hook
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, revest@chromium.org,
        jackmanb@chromium.org, jmorris@namei.org, serge@hallyn.com,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 15, 2022 at 12:57 PM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> include/linux/lsm_hooks.h reports the result of the LSM infrastructure to
> the callers, not what LSMs should return to the LSM infrastructure.
>
> Clarify that and add that returning 1 from the LSMs means calling
> __vm_enough_memory() with cap_sys_admin set, 0 without.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: KP Singh <kpsingh@kernel.org>
> ---
>  include/linux/lsm_hooks.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 4ec80b96c22e..f40b82ca91e7 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1411,7 +1411,9 @@
>   *     Check permissions for allocating a new virtual mapping.
>   *     @mm contains the mm struct it is being added to.
>   *     @pages contains the number of pages.
> - *     Return 0 if permission is granted.
> + *     Return 0 if permission is granted by LSMs to the caller. LSMs should
> + *     return 1 if __vm_enough_memory() should be called with
> + *     cap_sys_admin set, 0 if not.

I think this is a nice addition, but according to the code, any value
greater than zero will trigger the caller-should-have-CAP_SYS_ADMIN
behavior, not just 1.  I suggest updating the comment.

-- 
paul-moore.com
