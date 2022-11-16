Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4CB162B13B
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 03:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbiKPCXQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 21:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbiKPCXP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 21:23:15 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8182FC06
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 18:23:15 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id m6-20020a17090a5a4600b00212f8dffec9so1080371pji.0
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 18:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J4P5R+pdJzfRaQ+AiQYGJf7nLDcFIhpzWyHRJ4pEd7k=;
        b=0xeei+KEJma8+7bCjJrBSqZjdASMgcsxxs7iBDy5axKbfmOawgDdQntBJX9iA0y3Ge
         G6Gy1lMN7tVXY2Erbb76siigFkxaswLs7VYRgoTjaGshahNNjOqjwx5v5wJRytpY8Xd5
         tVNEa2x58PhBlszKhe0120hr6QLpbK0xrUE9DHxnKTjbryjEExS+/FQTTo2Y+MwW4JxO
         YmtV7aKAch9dQQBlV4USkMttE26WXWzNrXEvNs0Fpp/ejI47FEjJXb3CdRF93FhNYge2
         hGhEO1az74j7uWL6nd2Nd1m458v15dGCsAYKs7BvVaZHg8M+3N1enW67CqhgyJLVbLv8
         SdKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J4P5R+pdJzfRaQ+AiQYGJf7nLDcFIhpzWyHRJ4pEd7k=;
        b=bo/7QPYkFi86rpyHoij8NjFglY07ZPHbTMidAQuM0C2b5boEqV/kH13ws0LXnNVXPM
         pcu4RRVDX2e/IYJgJkKbtjdDZ/kdm7+mgCu9xFOLOhuzUrmr6W6WG4VZSDC6ennmEJ+D
         8ZPLErAmiH0CNBAP1mepI8drx5zGzNiYKZtqtSF/ydMArMIKnq4J8UAVtlLXREhsIFEl
         2+8Fl360I/WAbjO5kzDO1Gkj+COg+92I50ZSgDIJcPermi6mrHRx9eov1vBNnEkrTpXq
         9CbQZa/ighg2gsdTu6753pjDEgGjiXLnTdeDh2haK8OtslgBIiuj+Ke3wuQ4ydRWQR0o
         +u2A==
X-Gm-Message-State: ANoB5plkjG3Wn1/otQYRRTN8FalXlD+0IlQbGiKeGSqb4kleoY954HHM
        nLMoAL+XXWXXsMkN5gluIYBkzipyGAbqeMaxe0m0
X-Google-Smtp-Source: AA0mqf4tyxqZL6dNinYLGxLglLTMkXwHLPOJ0/bfZpgKfism41nxlS7vrc0NoFjHNkpVYJJZvklKnBS1D73LJ26ZaSs=
X-Received: by 2002:a17:902:74c1:b0:186:c3b2:56d1 with SMTP id
 f1-20020a17090274c100b00186c3b256d1mr6847477plt.15.1668565394715; Tue, 15 Nov
 2022 18:23:14 -0800 (PST)
MIME-Version: 1.0
References: <20221115175652.3836811-1-roberto.sassu@huaweicloud.com> <20221115175652.3836811-3-roberto.sassu@huaweicloud.com>
In-Reply-To: <20221115175652.3836811-3-roberto.sassu@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 15 Nov 2022 21:23:03 -0500
Message-ID: <CAHC9VhQjtU0DFoVGav-nBh-09QXh+X=Cf8RgJz6nAjvcyNQ-5A@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/4] lsm: Add missing return values doc in
 lsm_hooks.h and fix formatting
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
> Ensure that for non-void LSM hooks there is a description of the return
> values. Also replace spaces with tab for indentation, remove empty lines
> between the hook description and the list of parameters and add the period
> at the end of the parameter description.
>
> Finally, replace the description of the sb_parse_opts_str hook, which was
> removed with commit 757cbe597fe8 ("LSM: new method: ->sb_add_mnt_opt()"),
> with one for the new hook sb_add_mnt_opt.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  include/linux/lsm_hooks.h | 123 ++++++++++++++++++++++++++------------
>  1 file changed, 86 insertions(+), 37 deletions(-)

...

> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index f40b82ca91e7..c0c570b7eabd 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -176,18 +183,22 @@
>   *     Set the security relevant mount options used for a superblock
>   *     @sb the superblock to set security mount options for
>   *     @opts binary data structure containing all lsm mount data
> + *     Return 0 on success, error on failure.
>   * @sb_clone_mnt_opts:
>   *     Copy all security options from a given superblock to another
>   *     @oldsb old superblock which contain information to clone
>   *     @newsb new superblock which needs filled in
> - * @sb_parse_opts_str:
> - *     Parse a string of security data filling in the opts structure
> - *     @options string containing all mount options known by the LSM
> - *     @opts binary data structure usable by the LSM
> + *     Return 0 on success, error on failure.
> + * @add_mnt_opt:
> + *     Add a new mount option @option with value @val and length @len to the
> + *     existing mount options @mnt_opts.
> + *     Return 0 if the option was successfully added, a negative value
> + *     otherwise.

I really appreciate the effort to improve the LSM hook comments/docs,
but the "sb_add_mnt_opt" hook was removed in 52f982f00b22
("security,selinux: remove security_add_mnt_opt()").

-- 
paul-moore.com
