Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDDF6D878B
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 21:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbjDET7w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Apr 2023 15:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233862AbjDET7u (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Apr 2023 15:59:50 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7C34C15
        for <bpf@vger.kernel.org>; Wed,  5 Apr 2023 12:59:47 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id n125so43912745ybg.7
        for <bpf@vger.kernel.org>; Wed, 05 Apr 2023 12:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1680724787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=16oMn1NNzoMGhRBfxhPQbT5X5eCgj0j1VfPTFGPRXYA=;
        b=M6bRM2KlH9Lx5lsl1rif9t0ScqLJIdivfDowNos4t0MnSqxdPlWxdu1CtgPNVsf6PQ
         8U5VUfoOsmfJmq2XRa8ctGuBct1KIf4mat5CVl4r9vCtgWvPc73og4XPAPJKiOsAPB+Q
         TzbfcFogPV6U8zGTa4ijQ6IBjmsU6UYaRrrgV+MOlHiWQwISa6b0bt+EsHa7MUmooDWm
         1rx7Y/edmVIxZTJxu4jBKhmeO+u5C9tr4U0UPwgtrDnUgxq6zmZDc1w3LPqaQTij0hMF
         tRaNkccvCmTc4mjM2PROEHzoz75i9wuaWNb56YFKuf2qr5UxdsWp10j3px0yPT+mbFd2
         LPNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680724787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=16oMn1NNzoMGhRBfxhPQbT5X5eCgj0j1VfPTFGPRXYA=;
        b=7b7NYjl6Tp+oWkkLj2cDMZOtf6iUyn5XFsW/uL6lDn1FKFydxU8+Ti91TxSHnwT+bf
         xDGzS5ueLCj6Lfh3oMsDLCbGo69T24d4CRH1YNNtNwn8yICgvi6PW4cWXtRERbpxDOLD
         3bfhqhOYZrCNjIm+YS9rsP320YvDmwWf7dPMwXEQlDCGgQGTNBIA/LGPAiWyIBrdxmiT
         XX8Tb9UGKc8w6OXIlh1GVkJ4JWQ8C/cHR2TR9NdhbAJAZUwJaY5ou7o/cADw+ehW01Gp
         BIW1zz7mh46vgdP0DFRpF9S2RYqVLfOuw/H7rkKeSq7cne5lxSJOZCl3kDxg/r/eHju8
         Zi4w==
X-Gm-Message-State: AAQBX9dB8WQTbTjOedduL1zvCA7RRL97+NsDIEOCv3c8nal2nP87wR+s
        FNyhttJ1fxyzKSfo1+JhqIEcZB3gZyFT/auGN3wi
X-Google-Smtp-Source: AKy350Z4agPWqKP3S9SXcOAMKHENY/iZ5KsoGSPHS8QSL3pWzVPqwyrXG0+vzOYZvsNJa9+F9yj3Fqs4TEDZfwYCMxc=
X-Received: by 2002:a25:d707:0:b0:b68:7a4a:5258 with SMTP id
 o7-20020a25d707000000b00b687a4a5258mr390159ybg.3.1680724786891; Wed, 05 Apr
 2023 12:59:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230331123221.3273328-1-roberto.sassu@huaweicloud.com>
 <20230331123221.3273328-3-roberto.sassu@huaweicloud.com> <CAHC9VhSbGdij6xz9D49my37kD9qYrBmh2x7=cNFFDL2dZ=EZTw@mail.gmail.com>
 <5dbb9430-1e26-ec12-26a2-3718c84e33c2@schaufler-ca.com> <7549b624-421e-30b9-ca99-de42929354c7@huaweicloud.com>
In-Reply-To: <7549b624-421e-30b9-ca99-de42929354c7@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 5 Apr 2023 15:59:36 -0400
Message-ID: <CAHC9VhTsSUM6_g5+ZOqZ=P6307hCAJW+-xEc4fKQcymPs5pYjQ@mail.gmail.com>
Subject: Re: [PATCH v10 2/4] security: Allow all LSMs to provide xattrs for
 inode_init_security hook
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        bpf@vger.kernel.org, kpsingh@kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 5, 2023 at 5:44=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On 4/5/2023 4:08 AM, Casey Schaufler wrote:
> > On 4/4/2023 11:54 AM, Paul Moore wrote:
> >> On Fri, Mar 31, 2023 at 8:33=E2=80=AFAM Roberto Sassu
> >> <roberto.sassu@huaweicloud.com> wrote:

...

> >>> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> >>> index cfcbb748da2..8392983334b 100644
> >>> --- a/security/smack/smack_lsm.c
> >>> +++ b/security/smack/smack_lsm.c
> >>> @@ -52,6 +52,15 @@
> >>>   #define SMK_RECEIVING  1
> >>>   #define SMK_SENDING    2
> >>>
> >>> +/*
> >>> + * Smack uses multiple xattrs.
> >>> + * SMACK64 - for access control, SMACK64EXEC - label for the program=
,
> >> I think it would be good to move SMACK64EXEC to its own line; it took
> >> me a minute to figure out why SMACK_INODE_INIT_XATTRS was set to '4'
> >> when I only say three comment lines ... ;)
> >>
> >>> + * SMACK64MMAP - controls library loading,
> >>> + * SMACK64TRANSMUTE - label initialization,
> >>> + * Not saved on files - SMACK64IPIN and SMACK64IPOUT
> >>> + */
> >>> +#define SMACK_INODE_INIT_XATTRS 4
> >>
> >> If smack_inode_init_security() only ever populates a single xattr, and
> >> that is the only current user of SMACK_INODE_INIT_XATTRS, can we make
> >> this '1' and shrink the xattr allocation a bit?
> >
> > If the parent directory is marked with SMACK64_TRANSMUTE, the access
> > rule allowing the access has the "t" mode, and the object being initial=
ized
> > is a directory, the new inode should get the SMACK64_TRANSMUTE attribut=
e.
> > The callers of security_inode_init_security() don't seem to care.
> > I can't say if the evm code is getting SMACK64_TRANSMUTE or, for that
> > matter, SMACK64_EXEC and SMACK64_MMAP, some other way. The older system
> > allowed for multiple Smack xattrs, but I'm not clear on exactly how.
>
> If you like to set an additional xattr, that would be possible now.
> Since we reserve multiple xattrs, we can call lsm_get_xattr_slot()
> another time and set SMACK64_TRANSMUTE.
>
> I think, if the kernel config has CONFIG_EVM_EXTRA_SMACK_XATTRS set,
> EVM would protect SMACK64_TRANSMUTE too.

Ooookay, but can someone explain to me how either the current, or
patched, smack_inode_init_security() function can return multiple
xattrs via the security_inode_init_security() LSM hook?  I'm hoping
I'm missing something really obvious, but I can only see a single
Smack xattr being returned ...

--=20
paul-moore.com
