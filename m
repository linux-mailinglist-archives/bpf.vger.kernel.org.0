Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DA3645044
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 01:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiLGAWE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 19:22:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiLGAWE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 19:22:04 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B319442DB
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 16:22:03 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id w23so15532187ply.12
        for <bpf@vger.kernel.org>; Tue, 06 Dec 2022 16:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nZhJ0nE0ZA5jKgN6BxcI03RxJNuTqmjNb4Wo31gNIu8=;
        b=edSzeXolpnKR8kADHnUK5zDys8w7c/jQPn2qCC6ekRSfaXbFtqBwv0XoZxBORA0zTl
         ChqrF6t4xh14HtTCdCUDCNhISCwfi/5unLVxR43QJ9F4+06QN81+fejH9KA76DnF/GcK
         SiQk4RONCboetv53VudXNWYOI9arbADgrCvt1c/z0xcGdj9k7pyXNFrWlMW9ICDAaOey
         otqVF9lR2b5yofFVCsI10JLo3NZU9eqHGlbKkUsvFpHBHXpuvKWVAl6ipTmhgIgp336s
         0G+bm6I69oD22pqtkxqRrnnBcnYLrrlrc7WAm0MqWDyxEbOfQgALUIRQtRyh4v3ucelw
         HZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nZhJ0nE0ZA5jKgN6BxcI03RxJNuTqmjNb4Wo31gNIu8=;
        b=xIsuT2crJbAk2cY9EbZ1V30kML8dcwBHZy9HzC6/hlgM4+qrbZmdGxSt1KXfJD+UM9
         bgleP3uKVnqMNnF1GobJj6Qc7bnlVB32L6hd5QNak9NvKdPpjxeRBsC0tJa/woN9zSg3
         zSA06RYV4raNE1ZxlvVOzQNyjXDbtxyqlwXpTqUvjOsZHZgngHE+50BWavAG0ATNfyw8
         SvQyRwKOyocLTqlFbVp9l8/aP6KYIqS/LaOqhrpe2ontDr9VAG/YYdWGwZn5SPKmMYVk
         NpC9Vl80Torxp0hbm497QyHLVG8eis2/WD5fb2XcsICJahXj67nY7Gq7YSc2Yls/ZMpi
         s5uQ==
X-Gm-Message-State: ANoB5pnclNBK3VgMHRvmPPmgipZoJqxHddqkZvtVV3wL5Jo2Na1TpBJw
        nYwRw7uwBli6KZEqJtFwrJoMNCzrnkCudlbJixcp
X-Google-Smtp-Source: AA0mqf6cvEPgX23p93rWiv3bSVkuS1vJ7qoNkXPGDUutb2voDjMTIY23GZ6EZ4OWKfWGlLTZ9MT0ToagGrwU5HpQmL0=
X-Received: by 2002:a17:902:9892:b0:186:c3b2:56d1 with SMTP id
 s18-20020a170902989200b00186c3b256d1mr73317153plp.15.1670372522573; Tue, 06
 Dec 2022 16:22:02 -0800 (PST)
MIME-Version: 1.0
References: <20221128144240.210110-1-roberto.sassu@huaweicloud.com> <20221128144240.210110-3-roberto.sassu@huaweicloud.com>
In-Reply-To: <20221128144240.210110-3-roberto.sassu@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 6 Dec 2022 19:21:50 -0500
Message-ID: <CAHC9VhRx=pCcAHMAX+51rpFT+efW7HH=X37YOwUG1tTLxyg=SA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] lsm: Add/fix return values in lsm_hooks.h and fix formatting
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     casey@schaufler-ca.com, omosnace@redhat.com,
        john.johansen@canonical.com, kpsingh@kernel.org,
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

On Mon, Nov 28, 2022 at 9:43 AM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Ensure that for non-void LSM hooks there is a description of the return
> values.
>
> Also, replace spaces with tab for indentation, remove empty lines between
> the hook description and the list of parameters, adjust semicolons and add
> the period at the end of the parameter description.
>
> Finally, move the description of gfp parameter of the
> xfrm_policy_alloc_security hook together with the others.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  include/linux/lsm_hooks.h | 221 ++++++++++++++++++++++++--------------
>  1 file changed, 138 insertions(+), 83 deletions(-)

Thanks Roberto, I've merged this into lsm/next with one small tweak (below).

> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index c35e260efd8c..6502a1bea93a 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -677,7 +695,7 @@
>   *     indicates which of the set*uid system calls invoked this hook.  If
>   *     @new is the set of credentials that will be installed.  Modifications
>   *     should be made to this rather than to @current->cred.
> - *     @old is the set of credentials that are being replaces
> + *     @old is the set of credentials that are being replaces.

Might as well change "replaces" to "replaced".  I'll go ahead and fix
that up during the merge.

-- 
paul-moore.com
