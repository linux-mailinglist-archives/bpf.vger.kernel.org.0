Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC81461D990
	for <lists+bpf@lfdr.de>; Sat,  5 Nov 2022 12:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiKELHP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 5 Nov 2022 07:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiKELHK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 5 Nov 2022 07:07:10 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E66FD16
        for <bpf@vger.kernel.org>; Sat,  5 Nov 2022 04:07:08 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id b124so7664904oia.4
        for <bpf@vger.kernel.org>; Sat, 05 Nov 2022 04:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hwpkk+0T3P7HDP5wdM1o198qFAkFJjUu8As78+dhPDo=;
        b=VzX5D/AMfYuXk8B1NImOWU76p+n63couNJv2zROK4ioXMf5Umfc82z7Y8WC1IdpfCb
         K/aQHFcdwupQyQ1gTo3Bxyqtu0iWUAxl+qXFZAYBe15kTU8cSxhCm/sxElB2KwcrRaD2
         g4laGbGDwGZw4lTGa/zZnZD6ia36IACzVozYagEHHfVpr5iT34NhA4yLhYOj0EIcRIRy
         1jfusp6zrktbWz8fC/YKeMB4/7rQ5W1KBbCqHhrQA8QkviDmA/XM/kfMWzHJcJJjh4li
         b6pviADGaFdiFE9IN/ztt28oHYQsKVEp114QtopqYysR3I5P6z39DUe7u9NYdeybFA/I
         Wg5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hwpkk+0T3P7HDP5wdM1o198qFAkFJjUu8As78+dhPDo=;
        b=yNA+I4Yhby2fDQDEwlsT5i8t30q0WDRZ+S0guQE2sclt1fgrs2kVPn38Zohn0UuBxl
         4NywcEBAG6Iq20l/MDV5fNta2YDl5uKrDEs09IwoA25OPtLyd62HissSswLdMCedAdfj
         c2a3lFVZxTvmu8ekFANZWCXQGE+qWabtVBkDKOV/MSt3uYNkMWuEn41ksAYqK7QT1oiP
         9TLqU8vKHTJLnOCgjprZcYJT23U8zNCix88C8+hdu4ngQtvqPerjqN5NyD2oBuCfrnLt
         0hX6YRvDtXEmPDhUnejbqPEuibqmBOkJkTOJ9wt1n1ULjXgXFVl8HNChK7e4iyxKkyjq
         lItg==
X-Gm-Message-State: ACrzQf1+z7/xsZb68tuWHTrbpJLy4qT3eMwIQkGtDGTOnSun9FP4Uw+8
        Z5h6XCENYx242g5xvM+g2nRbhjvP1wRUXEV1SFz5
X-Google-Smtp-Source: AMsMyM4h86Z7+DifOdakoXbvzOvFpefVV62Tmw35gZfVtpz/r5d6FTw0gmgJK537ZLi++bwykSq3eG7z6EOBVOXntzw=
X-Received: by 2002:a05:6808:1441:b0:35a:4a2d:673b with SMTP id
 x1-20020a056808144100b0035a4a2d673bmr8164462oiv.172.1667646428242; Sat, 05
 Nov 2022 04:07:08 -0700 (PDT)
MIME-Version: 1.0
References: <Y1lElHVQGT/1Pa6O@archlinux>
In-Reply-To: <Y1lElHVQGT/1Pa6O@archlinux>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 5 Nov 2022 07:06:56 -0400
Message-ID: <CAHC9VhRoRQQO5v1J1r_dA6kO0AnC1WvpBGONEe-weJ_=vnntJA@mail.gmail.com>
Subject: Re: [PATCH v4] evm: Correct inode_init_security hooks behaviors
To:     Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>
Cc:     linux-integrity@vger.kernel.org, philippe.trebuchet@ssi.gouv.fr,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, casey@schaufler-ca.com, davem@davemloft.net,
        lucien.xin@gmail.com, vgoyal@redhat.com, omosnace@redhat.com,
        mortonm@chromium.org, nicolas.bouchinet@ssi.gouv.fr,
        mic@digikod.net, cgzones@googlemail.com,
        linux-security-module@vger.kernel.org, kpsingh@kernel.org,
        revest@chromium.org, jackmanb@chromium.org, bpf@vger.kernel.org,
        roberto.sassu@huaweicloud.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 26, 2022 at 10:30 AM Nicolas Bouchinet
<nicolas.bouchinet@clip-os.org> wrote:
>
> From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
>
> Fixes a NULL pointer dereference occurring in the
> `evm_protected_xattr_common` function of the EVM LSM. The bug is
> triggered if a `inode_init_security` hook returns 0 without initializing
> the given `struct xattr` fields (which is the case of BPF) and if no
> other LSM overrides thoses fields after. This also leads to memory
> leaks.
>
> The `call_int_hook_xattr` macro has been inlined into the
> `security_inode_init_security` hook in order to check hooks return
> values and skip ones who doesn't init `xattrs`.
>
> Modify `evm_init_hmac` function to init the EVM hmac using every
> entry of the given xattr array.
>
> The `MAX_LSM_EVM_XATTR` value is now based on the security modules
> compiled in, which gives room for SMACK, SELinux, Apparmor, BPF and
> IMA/EVM security attributes.
>
> Changes the default return value of the `inode_init_security` hook
> definition to `-EOPNOTSUPP`.
>
> Changes the hook documentation to match the behavior of the LSMs using
> it (only xattr->value is initialised with kmalloc and thus is the only
> one that should be kfreed by the caller).
>
> Cc: roberto.sassu@huaweicloud.com
> Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> ---
> Changes since v3:
> https://lore.kernel.org/linux-integrity/Y1fu4jofqLHVDprT@archlinux/
>
> * Fixes compilation error reported by the kernel test robot.
> ---
>  include/linux/lsm_hook_defs.h       |  2 +-
>  include/linux/lsm_hooks.h           |  4 ++--
>  security/integrity/evm/evm.h        |  1 +
>  security/integrity/evm/evm_crypto.c |  9 +++++++--
>  security/integrity/evm/evm_main.c   |  7 ++++---
>  security/security.c                 | 31 ++++++++++++++++++++++-------
>  6 files changed, 39 insertions(+), 15 deletions(-)

...

> diff --git a/security/security.c b/security/security.c
> index 14d30fec8a00..79524f8734f1 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -30,7 +30,11 @@
>  #include <linux/msg.h>
>  #include <net/flow.h>
>
> -#define MAX_LSM_EVM_XATTR      2
> +#define MAX_LSM_EVM_XATTR                                \
> +       ((IS_ENABLED(CONFIG_EVM) ? 1 : 0) +              \
> +        (IS_ENABLED(CONFIG_SECURITY_SELINUX) ? 1 : 0) + \
> +        (IS_ENABLED(CONFIG_SECURITY_SMACK) ? 1 : 0) +   \
> +        (IS_ENABLED(CONFIG_BPF_LSM) ? 1 : 0))

...

> @@ -1091,9 +1095,11 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
>                                  const struct qstr *qstr,
>                                  const initxattrs initxattrs, void *fs_data)
>  {
> +       int i = 0;
> +       int ret = -EOPNOTSUPP;
>         struct xattr new_xattrs[MAX_LSM_EVM_XATTR + 1];
>         struct xattr *lsm_xattr, *evm_xattr, *xattr;
> -       int ret;
> +       struct security_hook_list *hook_ptr;
>
>         if (unlikely(IS_PRIVATE(inode)))
>                 return 0;
> @@ -1103,15 +1109,26 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
>                                      dir, qstr, NULL, NULL, NULL);
>         memset(new_xattrs, 0, sizeof(new_xattrs));
>         lsm_xattr = new_xattrs;
> -       ret = call_int_hook(inode_init_security, -EOPNOTSUPP, inode, dir, qstr,
> -                                               &lsm_xattr->name,
> -                                               &lsm_xattr->value,
> -                                               &lsm_xattr->value_len);
> +       hlist_for_each_entry(hook_ptr, &security_hook_heads.inode_init_security,
> +                            list) {
> +               ret = hook_ptr->hook.inode_init_security(inode, dir, qstr,
> +                               &lsm_xattr->name,
> +                               &lsm_xattr->value,
> +                               &lsm_xattr->value_len);
> +               if (ret == -EOPNOTSUPP)
> +                       continue;
> +               if (WARN_ON_ONCE(i >= MAX_LSM_EVM_XATTR))
> +                       ret = -ENOMEM;

It would really like to see us get rid of the MAX_LSM_EVM_XATTR macro
and determine the array size similar to what we do with the security
blob sizes.  The macro definition is a kludgy hack that is bound to
get out of sync at some point and this extra checking inside the hook
is something we should work to remove.

> +               if (ret != 0)
> +                       break;
> +               lsm_xattr++;
> +               i++;
> +       }
>         if (ret)
>                 goto out;
>
>         evm_xattr = lsm_xattr + 1;
> -       ret = evm_inode_init_security(inode, lsm_xattr, evm_xattr);
> +       ret = evm_inode_init_security(inode, new_xattrs, evm_xattr);
>         if (ret)
>                 goto out;
>         ret = initxattrs(inode, new_xattrs, fs_data);
> --
> 2.38.1

-- 
paul-moore.com
