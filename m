Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43DA76D890F
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 22:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbjDEUth (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Apr 2023 16:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbjDEUtg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Apr 2023 16:49:36 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F41A1BF
        for <bpf@vger.kernel.org>; Wed,  5 Apr 2023 13:49:34 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-54bfce685c1so32059737b3.1
        for <bpf@vger.kernel.org>; Wed, 05 Apr 2023 13:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1680727773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pWPy9H+by09Lc7YU/CRUS1UICIUAlLK+lHzVatngeE=;
        b=B3041m78p7E6ryUg79fJRRVjBHF6S5BGYn5Vxoe4WzJgWCwBFKMhH3uCrn1/jJZWeS
         NXL4m6wLhrcYN8Cq+JD9SYut3PwbUIAvvnyWIsyR4gtqbKFLTA4ut4VA+q54zO0CEnvn
         NwZn2DeWuS1gOoYvfcIQU+VbqBTOmwV8Xs0cWCB7OYPx22b47dy3J6jpF7Mhe2SukCUT
         vtyztoHiaW1wpek56l3thVBng3IVX+R6LFPLTIhNA75IEwUltMDMC4F9hI9m9gxYURRZ
         noi73sXaKEWbUT4DnrKeFoRs9BbqSnAf7R2DrdsWNWeP5E9GfbnBUjlymoBdW5qqnskd
         4UJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680727773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5pWPy9H+by09Lc7YU/CRUS1UICIUAlLK+lHzVatngeE=;
        b=sOoaDxUIGJxb+8VDMODH2DvdrxHLXd2wJB9F/F8N7bYGUUL0pkoZFIE4xF0D3n8b/l
         jt86q/gLzBZf/DyZo1JORX9Io/fpI5p/6wjTow3zCmoLqFPV4N4CLpWCRDTdP6Tp7SmF
         r2QTBAVlmTjsTFZkcaZvSbxbRV/7laUW04gCswlM3B1il/Q2GoQWbLpihq/8Gl9zk3l0
         0mxLd8Y/gZXSy/ouRN/knyGcvEBNNnr2QacLYpMwp/JCgEK6qfSs4EMsUkXlzQ+C/+Oh
         XwLNbWUtSbph/pEV0YfLvq2rc/3ivkYpST6PStb0f17lpIQ9gahWSG5ayokIsZZt7jX7
         Ahjw==
X-Gm-Message-State: AAQBX9dTurdtLipoIzwRqBI30dnKv9jnCTF9PZVg0zoiKaQLPIteen5j
        kiqpZ0WpQN9kfE3A2NPoMA6cplffWDUeQ4hk/SxB
X-Google-Smtp-Source: AKy350YJj7FMbHWmT59qEFH/cQJBdm+KmHto/nwnR0zUZtFhRoG0MUVWwyxqKH3jKCnaogS2NEmGimPdd7MjJk49mRI=
X-Received: by 2002:a81:9902:0:b0:545:632d:e78b with SMTP id
 q2-20020a819902000000b00545632de78bmr2838427ywg.0.1680727773518; Wed, 05 Apr
 2023 13:49:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230331123221.3273328-1-roberto.sassu@huaweicloud.com>
 <20230331123221.3273328-3-roberto.sassu@huaweicloud.com> <CAHC9VhSbGdij6xz9D49my37kD9qYrBmh2x7=cNFFDL2dZ=EZTw@mail.gmail.com>
 <5dbb9430-1e26-ec12-26a2-3718c84e33c2@schaufler-ca.com> <7549b624-421e-30b9-ca99-de42929354c7@huaweicloud.com>
 <CAHC9VhTsSUM6_g5+ZOqZ=P6307hCAJW+-xEc4fKQcymPs5pYjQ@mail.gmail.com> <83ddfcb9-b4a6-71b4-a20c-62f484c8e040@schaufler-ca.com>
In-Reply-To: <83ddfcb9-b4a6-71b4-a20c-62f484c8e040@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 5 Apr 2023 16:49:22 -0400
Message-ID: <CAHC9VhTO02CGUt0DUUmx=TUYS7Q81fas_Qy5miOFonaye0NEmw@mail.gmail.com>
Subject: Re: [PATCH v10 2/4] security: Allow all LSMs to provide xattrs for
 inode_init_security hook
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>, zohar@linux.ibm.com,
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

On Wed, Apr 5, 2023 at 4:43=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
> On 4/5/2023 12:59 PM, Paul Moore wrote:
> > On Wed, Apr 5, 2023 at 5:44=E2=80=AFAM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> >> On 4/5/2023 4:08 AM, Casey Schaufler wrote:
> >>> On 4/4/2023 11:54 AM, Paul Moore wrote:
> >>>> On Fri, Mar 31, 2023 at 8:33=E2=80=AFAM Roberto Sassu
> >>>> <roberto.sassu@huaweicloud.com> wrote:
> > ..
> >
> >>>>> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.=
c
> >>>>> index cfcbb748da2..8392983334b 100644
> >>>>> --- a/security/smack/smack_lsm.c
> >>>>> +++ b/security/smack/smack_lsm.c
> >>>>> @@ -52,6 +52,15 @@
> >>>>>   #define SMK_RECEIVING  1
> >>>>>   #define SMK_SENDING    2
> >>>>>
> >>>>> +/*
> >>>>> + * Smack uses multiple xattrs.
> >>>>> + * SMACK64 - for access control, SMACK64EXEC - label for the progr=
am,
> >>>> I think it would be good to move SMACK64EXEC to its own line; it too=
k
> >>>> me a minute to figure out why SMACK_INODE_INIT_XATTRS was set to '4'
> >>>> when I only say three comment lines ... ;)
> >>>>
> >>>>> + * SMACK64MMAP - controls library loading,
> >>>>> + * SMACK64TRANSMUTE - label initialization,
> >>>>> + * Not saved on files - SMACK64IPIN and SMACK64IPOUT
> >>>>> + */
> >>>>> +#define SMACK_INODE_INIT_XATTRS 4
> >>>> If smack_inode_init_security() only ever populates a single xattr, a=
nd
> >>>> that is the only current user of SMACK_INODE_INIT_XATTRS, can we mak=
e
> >>>> this '1' and shrink the xattr allocation a bit?
> >>> If the parent directory is marked with SMACK64_TRANSMUTE, the access
> >>> rule allowing the access has the "t" mode, and the object being initi=
alized
> >>> is a directory, the new inode should get the SMACK64_TRANSMUTE attrib=
ute.
> >>> The callers of security_inode_init_security() don't seem to care.
> >>> I can't say if the evm code is getting SMACK64_TRANSMUTE or, for that
> >>> matter, SMACK64_EXEC and SMACK64_MMAP, some other way. The older syst=
em
> >>> allowed for multiple Smack xattrs, but I'm not clear on exactly how.
> >> If you like to set an additional xattr, that would be possible now.
> >> Since we reserve multiple xattrs, we can call lsm_get_xattr_slot()
> >> another time and set SMACK64_TRANSMUTE.
> >>
> >> I think, if the kernel config has CONFIG_EVM_EXTRA_SMACK_XATTRS set,
> >> EVM would protect SMACK64_TRANSMUTE too.
> >
> > Ooookay, but can someone explain to me how either the current, or
> > patched, smack_inode_init_security() function can return multiple
> > xattrs via the security_inode_init_security() LSM hook?
>
> It can't.

I didn't think so.

To be really specific, that's what we're talking about with this
patch: the number of xattrs that smack_inode_init_security() can
return to the LSM hook (and EVM, and the caller ...).  If it's only
ever going to be one, I think we can adjust the
'SMACK_INODE_INIT_XATTRS' down to '1' and save ourselves some
allocation space.

--=20
paul-moore.com
