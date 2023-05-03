Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68ED6F5DE5
	for <lists+bpf@lfdr.de>; Wed,  3 May 2023 20:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjECS2w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 May 2023 14:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjECS2v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 May 2023 14:28:51 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503352680
        for <bpf@vger.kernel.org>; Wed,  3 May 2023 11:28:50 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b9a7766d1f2so6711049276.3
        for <bpf@vger.kernel.org>; Wed, 03 May 2023 11:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683138529; x=1685730529;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EZ/jGuqYbI8If8gOnXaeKTa2gI+Xs7Sbz/cjlu7FfLw=;
        b=27VimN5M6KTdi+VlALws3NLGjjODWrvWzKyvn61EOf1GwirSbPz05RBpIS2FmqO54p
         dm3Snoj3kb8mJJfDd8ukVudt+MtJvixRCqNpvNzo7MF8H4yMS0PW7wKuW0M15+5sVgJ2
         HCeRI28uC2b4uk9BR6segWUtTXd01VgzNT1HtBlLnMTHedYf4uBXY6TxfcOdcZFlEXj9
         vPrMTJQBboj74bBmIdA/YcRIgOEg717AXm1c8j5X+w1b8ufV8/SfiiJWfaZCO8rYssU7
         jAYQU12opZTxsOgz2rCXt0J0ocFyHTCMEcz9pI5ZIqiSeIFD0tWG7w8hTB+sudtiVfsV
         dApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683138529; x=1685730529;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EZ/jGuqYbI8If8gOnXaeKTa2gI+Xs7Sbz/cjlu7FfLw=;
        b=QMVE81EhcUAgbJlclasA3dGNl0fIVzyN12MQ561RCCz9MekXuO+eA+G+pVGagf1L7s
         X/S3aSnK3eabiYcbBrawDfrbB9izrRoiVVLttIcRwD7oYiWb6SmiHKxLzLU5YFfixlNn
         9hHLevJOudSoyXAiR7ZyXEV5e/aXwjVRg2T4LrttsD2dlIE5/0uHtCoon5NVOwF9iOlN
         5qcmJg/znAkUSB6bPeGal6Waa1+Cse1apydYJ6bhiaUvfBbXqMTdUTsaTb5gKn1W+L/r
         HFbkYsJ6ymW3+YE8KSS59SecOBuh47C741lVNNQ7GG+pxv9JVY095HLVc7OuyN4Clxyw
         xicw==
X-Gm-Message-State: AC+VfDy6hCovLPeV0T54jyVFUDZEUz946OOGDf7cAHAUn92Q8URlUjmH
        zJfT6nDdb9wZ+dn6rf/9oQg32co=
X-Google-Smtp-Source: ACHHUZ4Ns2eyWtzTY9XWeLEDabhawS/PJDJT8iiFHxPn1KSJPIByi6lGLXZmO7E/LMIYEi048fDV1Xg=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:2d27:0:b0:b9a:696a:770f with SMTP id
 t39-20020a252d27000000b00b9a696a770fmr13699499ybt.13.1683138529588; Wed, 03
 May 2023 11:28:49 -0700 (PDT)
Date:   Wed, 3 May 2023 11:28:48 -0700
In-Reply-To: <20230502230619.2592406-2-andrii@kernel.org>
Mime-Version: 1.0
References: <20230502230619.2592406-1-andrii@kernel.org> <20230502230619.2592406-2-andrii@kernel.org>
Message-ID: <ZFKn4JjmiGTHyWpj@google.com>
Subject: Re: [PATCH bpf-next 01/10] bpf: move unprivileged checks into
 map_create() and bpf_prog_load()
From:   Stanislav Fomichev <sdf@google.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 05/02, Andrii Nakryiko wrote:
> Make each bpf() syscall command a bit more self-contained, making it
> easier to further enhance it. We move sysctl_unprivileged_bpf_disabled
> handling down to map_create() and bpf_prog_load(), two special commands
> in this regard.
> 
> Also swap the order of checks, calling bpf_capable() only if
> sysctl_unprivileged_bpf_disabled is true, avoiding unnecessary audit
> messages.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/bpf/syscall.c | 37 ++++++++++++++++++++++---------------
>  1 file changed, 22 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 14f39c1e573e..d5009fafe0f4 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1132,6 +1132,17 @@ static int map_create(union bpf_attr *attr)
>  	int f_flags;
>  	int err;

[..]

> +	/* Intent here is for unprivileged_bpf_disabled to block key object
> +	 * creation commands for unprivileged users; other actions depend
> +	 * of fd availability and access to bpffs, so are dependent on
> +	 * object creation success.  Capabilities are later verified for
> +	 * operations such as load and map create, so even with unprivileged
> +	 * BPF disabled, capability checks are still carried out for these
> +	 * and other operations.
> +	 */
> +	if (sysctl_unprivileged_bpf_disabled && !bpf_capable())
> +		return -EPERM;
> +

Does it make sense to have something like unpriv_bpf_capable() to avoid
the copy-paste?
