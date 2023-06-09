Return-Path: <bpf+bounces-2257-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2688A72A405
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 22:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFE19281A19
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 20:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA532109E;
	Fri,  9 Jun 2023 20:02:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50347408DB
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 20:02:45 +0000 (UTC)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7314935B5
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 13:02:42 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-ba81f71dfefso2140734276.0
        for <bpf@vger.kernel.org>; Fri, 09 Jun 2023 13:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1686340961; x=1688932961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jb7kmIJ78WGnLMav5i+xZLlOrus/ZxdVSVcHyy9hLLg=;
        b=DlIKZ/VHrKUpO2Ruqi1H9V3yDa+sFYerKIPGUX9PHS4xrJLaRUSo3NtLuHKYBJwddE
         xVqc1R18LoVHtJmgi2SKj2e6dap7lU5USZo962luZ/poSZUwwXa8gt7335QVIMVHkdbW
         PHzSgVmkZ+BfJLGcPMe8V1g/QXdiEYIsqS+Zhy5GQzYceUxeoWDkYSi3lvxgDXIx+uE4
         WRRV9npY9MHhttTF7A18B75IFq7OIvnQ8/6d5al6EDstkHiVFIgMaP0AXpPzxhaGawfk
         TU11+2gF9bxpgngzZ3M4hnh8N1zf30Y8Gd/Ky1M8dI7ocH7XVC9pcKoigK2F8sODhWcJ
         NQyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686340961; x=1688932961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jb7kmIJ78WGnLMav5i+xZLlOrus/ZxdVSVcHyy9hLLg=;
        b=UlU/bEdxhsvouJnnRPqFAbgNXk2WNRqkVSh4MKzu1Z6JC6JrodV5KDlwy2pVTn5e+b
         tD3j4TN8N3a6wNV97Z20svrUmmwcfuHGQnE8TjqawmeJO8GZ8G7d6fKWSO0McGFTIfP6
         XSwg0nDRtCWPtmVGGOOggkZ5tr1c1/MuuH86WtUkKeJkYhRgWrEDXJrit9xygPak2vwd
         HpTIzKXwX1+ipsrJ1mQus80xAA1fNvWX0j5YL5S0w6xktZqWAo5VZu1SLMDFR4uGD5T0
         on3nsrFFN6mXGoNj0rCb/arHR3zC6Uz4mCUTI6EuUQJyKI0crm2GR2J5XrP3C/OQG9lJ
         PsoQ==
X-Gm-Message-State: AC+VfDxfxfOdkYQ+R8vqEGDpK+ih1G+ys8PjvoxSa4+/MIpymNRT8tN4
	y7oyUPRQ/w5D1d08IwMwWPPFcbBMY3+U9Vocm/4Q
X-Google-Smtp-Source: ACHHUZ7rmrRCrUZ0haUXcy0N+nTByEJE0/JjILyGhKzjvy3rs70180x1qFA8CGOP1sgZPkprMvc1K/Mdbp7sZJVH8cQ=
X-Received: by 2002:a81:5a54:0:b0:569:51d4:e723 with SMTP id
 o81-20020a815a54000000b0056951d4e723mr2309140ywb.36.1686340961163; Fri, 09
 Jun 2023 13:02:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230603191518.1397490-1-roberto.sassu@huaweicloud.com> <20230603191518.1397490-2-roberto.sassu@huaweicloud.com>
In-Reply-To: <20230603191518.1397490-2-roberto.sassu@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 9 Jun 2023 16:02:30 -0400
Message-ID: <CAHC9VhS8A2=dKu3qX4XpqeMmjqFSWpTczt8j88AswnZ86VZjEQ@mail.gmail.com>
Subject: Re: [PATCH v11 1/4] security: Allow all LSMs to provide xattrs for
 inode_init_security hook
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org, 
	serge@hallyn.com, stephen.smalley.work@gmail.com, eparis@parisplace.org, 
	casey@schaufler-ca.com, linux-kernel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, kpsingh@kernel.org, 
	keescook@chromium.org, nicolas.bouchinet@clip-os.org, 
	Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jun 3, 2023 at 3:16=E2=80=AFPM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Currently, the LSM infrastructure supports only one LSM providing an xatt=
r
> and EVM calculating the HMAC on that xattr, plus other inode metadata.
>
> Allow all LSMs to provide one or multiple xattrs, by extending the securi=
ty
> blob reservation mechanism. Introduce the new lbs_xattr_count field of th=
e
> lsm_blob_sizes structure, so that each LSM can specify how many xattrs it
> needs, and the LSM infrastructure knows how many xattr slots it should
> allocate.
>
> Modify the inode_init_security hook definition, by passing the full
> xattr array allocated in security_inode_init_security(), and the current
> number of xattr slots in that array filled by LSMs. The first parameter
> would allow EVM to access and calculate the HMAC on xattrs supplied by
> other LSMs, the second to not leave gaps in the xattr array, when an LSM
> requested but did not provide xattrs (e.g. if it is not initialized).
>
> Introduce lsm_get_xattr_slot(), which LSMs can call as many times as the
> number specified in the lbs_xattr_count field of the lsm_blob_sizes
> structure. During each call, lsm_get_xattr_slot() increments the number o=
f
> filled xattrs, so that at the next invocation it returns the next xattr
> slot to fill.
>
> Cleanup security_inode_init_security(). Unify the !initxattrs and
> initxattrs case by simply not allocating the new_xattrs array in the
> former. Update the documentation to reflect the changes, and fix the
> description of the xattr name, as it is not allocated anymore.
>
> Adapt both SELinux and Smack to use the new definition of the
> inode_init_security hook, and to call lsm_get_xattr_slot() to obtain and
> fill the reserved slots in the xattr array.
>
> Move the xattr->name assignment after the xattr->value one, so that it is
> done only in case of successful memory allocation.
>
> Finally, change the default return value of the inode_init_security hook
> from zero to -EOPNOTSUPP, so that BPF LSM correctly follows the hook
> conventions.
>
> Reported-by: Nicolas Bouchinet <nicolas.bouchinet@clip-os.org> (EVM crash=
)
> Link: https://lore.kernel.org/linux-integrity/Y1FTSIo+1x+4X0LS@archlinux/
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  include/linux/lsm_hook_defs.h |  6 +--
>  include/linux/lsm_hooks.h     | 20 ++++++++++
>  security/security.c           | 71 +++++++++++++++++++++++------------
>  security/selinux/hooks.c      | 17 +++++----
>  security/smack/smack_lsm.c    | 25 ++++++------
>  5 files changed, 92 insertions(+), 47 deletions(-)

...

> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index ab2b2fafa4a..069ac73a84b 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -63,8 +64,27 @@ struct lsm_blob_sizes {
>         int     lbs_ipc;
>         int     lbs_msg_msg;
>         int     lbs_task;
> +       int     lbs_xattr_count; /* number of xattr slots in new_xattrs a=
rray */
>  };
>
> +/**
> + * lsm_get_xattr_slot - Return the next available slot and increment the=
 index
> + * @xattrs: array storing LSM-provided xattrs
> + * @xattr_count: number of already stored xattrs (updated)
> + *
> + * Retrieve the first available slot in the @xattrs array to fill with a=
n xattr,
> + * and increment @xattr_count.
> + *
> + * Return: The slot to fill in @xattrs if non-NULL, NULL otherwise.
> + */
> +static inline struct xattr *lsm_get_xattr_slot(struct xattr *xattrs,
> +                                              int *xattr_count)
> +{
> +       if (unlikely(!xattrs))
> +               return NULL;
> +       return xattrs + (*xattr_count)++;

I would have tried to avoid the pointer math by writing the above like
the line below:

  return &xattrs[(*xattr_count)++]

... but I wouldn't worry about that, what you have is fine; I only
mention this in case you need to respin this patchset for some other
reason.

--=20
paul-moore.com

