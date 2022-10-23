Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F6260974F
	for <lists+bpf@lfdr.de>; Mon, 24 Oct 2022 01:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiJWXgh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 23 Oct 2022 19:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiJWXgg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 23 Oct 2022 19:36:36 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7C65C9C9;
        Sun, 23 Oct 2022 16:36:35 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id y12so5131369edc.9;
        Sun, 23 Oct 2022 16:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pUumQOe9bJsMEPG18mOM6dqw1ZwD1MCcqdns6DdBtO8=;
        b=HMACr+fvuZCReaF06SqU2f4GapjMr3hfNCibM02+aUHWYvkEJbulK2g64NoHN2lAbA
         g0Okm/inJ88ut5H4fsqjKHQN0QCb6VhfQbzhJIbTPBIBmdCWunGb1ZSxISnMVkydseWq
         IMRKBDiYAFJlf9CMgAe6kVpnTw7qqvmg1uN33pVdlRvtg9YOTHWUNV7Iyx4xQrWuayJA
         XobixWm1Bi/XdZ8x3jvM9yZmEEwC5ePZmlSNlvl03BZbBJfDpE80ZqNGoZgocot76cdI
         soGf6kEEPP6PIPfdLk4v0NU4uaU5EjYdmU0eqywtDkmirAS/GFcjxcUqVAf5Q7Bc87WW
         ZQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pUumQOe9bJsMEPG18mOM6dqw1ZwD1MCcqdns6DdBtO8=;
        b=fA5ixp8BmtyYCkw/EgycbGs/Ahl8lpjsjG5leOgp6GhIgvUnA/85iPvLBpwLtaWwBL
         7nJ/F+OqeVwk6IQZ85ZZxTXk7GkuuvTdAjMt43xnIrHuVHyxRbKdHZUvjTd0Teq628GV
         hSfOc2cnY3XzYtVJdl0N/guM+p4tTu6ClISqQY8cC/sX9t8w+mTYqa5XGi29oFYk3k0s
         QBTWMyivzYsGu9SVagRhrVr7te92cSZNco3Y8ftlLcPWBEQBDfxea0ATYmw8YU3j8cqf
         fbO4bXJ9P4fh5hMVuIWNiB3aKt/3hNPwuddPxsVc7kZoQ5ZXLOyAPAeK5GGFnJrvImoy
         t6PQ==
X-Gm-Message-State: ACrzQf1QMlu1NVjoqhuxqH/Az5O0C1ne4y/BCGh5ynH5hnUHEstwsETt
        qublHEn2GOfRLEDwk9N1sN15LkAvo01WQ8FtVTk=
X-Google-Smtp-Source: AMsMyM5nQLkNgE5RCfp+uYGuEJRhE6OfnHkWFNph6cLrHR3UPibU2wiAiX/3/U5tt+x+rLDrcEOULsaPjV2tozbTki8=
X-Received: by 2002:a17:906:fe45:b0:788:15a5:7495 with SMTP id
 wz5-20020a170906fe4500b0078815a57495mr25463636ejb.633.1666568194070; Sun, 23
 Oct 2022 16:36:34 -0700 (PDT)
MIME-Version: 1.0
References: <20221021164626.3729012-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20221021164626.3729012-1-roberto.sassu@huaweicloud.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sun, 23 Oct 2022 16:36:22 -0700
Message-ID: <CAADnVQJHDboosqTy5LTHJtJaWJCWn9rv09jmd_sMgeV_OVQjGg@mail.gmail.com>
Subject: Re: [RFC][PATCH] bpf: Check xattr name/value pair from bpf_lsm_inode_init_security()
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     KP Singh <kpsingh@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, bpf <bpf@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        nicolas.bouchinet@clip-os.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 21, 2022 at 9:57 AM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> BPF LSM allows security modules to directly attach to the security hooks,
> with the potential of not meeting the kernel expectation.
>
> This is the case for the inode_init_security hook, for which the kernel
> expects that name and value are set if the hook implementation returns
> zero.
>
> Consequently, not meeting the kernel expectation can cause the kernel to
> crash. One example is evm_protected_xattr_common() which expects the
> req_xattr_name parameter to be always not NULL.

Sounds like a bug in evm_protected_xattr_common.

> Introduce a level of indirection in BPF LSM, for the inode_init_security
> hook, to check the validity of the name and value set by security modules.

Doesn't make sense.
You probably meant security_old_inode_init_security,
because the hook without _old_ doesn't have such args:
int security_inode_init_security(struct inode *inode, struct inode *dir,
                                 const struct qstr *qstr,
                                 initxattrs initxattrs, void *fs_data);

> Encapsulate bpf_lsm_inode_init_security(), the existing attachment point,
> with bpf_inode_init_security(), the new function. After the attachment
> point is called, return -EOPNOTSUPP if the xattr name is not set, -ENOMEM
> if the xattr value is not set.
>
> As the name still cannot be set, rely on future patches to the eBPF
> verifier or introducing new kfuncs/helpers to ensure its correctness.
>
> Finally, as proposed by Nicolas, update the LSM hook documentation for the
> inode_init_security hook, to reflect the current behavior (only the xattr
> value is allocated).
>
> Cc: stable@vger.kernel.org
> Fixes: 520b7aa00d8cd ("bpf: lsm: Initialize the BPF LSM hooks")
> Reported-by: Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  include/linux/lsm_hooks.h |  4 ++--
>  security/bpf/hooks.c      | 25 +++++++++++++++++++++++++
>  2 files changed, 27 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 4ec80b96c22e..f44d45f4737f 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -229,8 +229,8 @@
>   *     This hook is called by the fs code as part of the inode creation
>   *     transaction and provides for atomic labeling of the inode, unlike
>   *     the post_create/mkdir/... hooks called by the VFS.  The hook function
> - *     is expected to allocate the name and value via kmalloc, with the caller
> - *     being responsible for calling kfree after using them.
> + *     is expected to allocate the value via kmalloc, with the caller
> + *     being responsible for calling kfree after using it.

must be an obsolete comment.

>   *     If the security module does not use security attributes or does
>   *     not wish to put a security attribute on this particular inode,
>   *     then it should return -EOPNOTSUPP to skip this processing.
> diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
> index e5971fa74fd7..492c07ba6722 100644
> --- a/security/bpf/hooks.c
> +++ b/security/bpf/hooks.c
> @@ -6,11 +6,36 @@
>  #include <linux/lsm_hooks.h>
>  #include <linux/bpf_lsm.h>
>
> +static int bpf_inode_init_security(struct inode *inode, struct inode *dir,
> +                                  const struct qstr *qstr, const char **name,
> +                                  void **value, size_t *len)
> +{
> +       int ret;
> +
> +       ret = bpf_lsm_inode_init_security(inode, dir, qstr, name, value, len);
> +       if (ret)
> +               return ret;
> +
> +       /*
> +        * As the name cannot be set by the eBPF programs directly, eBPF will
> +        * be responsible for its correctness through the verifier or
> +        * appropriate kfuncs/helpers.
> +        */
> +       if (name && !*name)
> +               return -EOPNOTSUPP;

bpf cannot write into such pointers.
It won't be able to use kfuncs to kmalloc and write into them either.
None of it makes sense to me.

> +
> +       if (value && !*value)
> +               return -ENOMEM;
> +
> +       return 0;
> +}
> +
>  static struct security_hook_list bpf_lsm_hooks[] __lsm_ro_after_init = {
>         #define LSM_HOOK(RET, DEFAULT, NAME, ...) \
>         LSM_HOOK_INIT(NAME, bpf_lsm_##NAME),
>         #include <linux/lsm_hook_defs.h>
>         #undef LSM_HOOK
> +       LSM_HOOK_INIT(inode_init_security, bpf_inode_init_security),
>         LSM_HOOK_INIT(inode_free_security, bpf_inode_storage_free),
>         LSM_HOOK_INIT(task_free, bpf_task_storage_free),
>  };
> --
> 2.25.1
>
