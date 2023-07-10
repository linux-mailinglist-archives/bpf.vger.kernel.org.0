Return-Path: <bpf+bounces-4619-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2D674DD0D
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 20:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E83B1C20AE7
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 18:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A8814291;
	Mon, 10 Jul 2023 18:05:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61131427B
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 18:05:12 +0000 (UTC)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB24412B
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 11:05:09 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-57764a6bf8cso60310367b3.3
        for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 11:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689012309; x=1691604309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EB5CFdTYWApS8YMHOsiv0TiQQf51kpScKMC8hHDqG8g=;
        b=PRUSckhb2w2tvQVVqKRnAyFmh/xH4DVarLn2tfQUHuZsRmlUdlaoZS4tZ/DtqvuCcC
         vw7wH9gSaid4XnJN8d0feAmFI+jdpMwX19vdHLHSWTT/aaIB+ces3ILY4kHUkuLjXoHQ
         CmEpOHNRRSFnNjUm0goZkW6P579aehUi1pSQtU87E+sxiJeekPKGmihjBe2w1IN/vS5h
         SSeoBmil9Z+t5D3S1+K20tHmPDDQdCz0gPzjlQBkR3Kw6vrkkebxGQd93XdCw+eVSM5A
         bv/ahQVscDhIR+kBLYh6Q/z5/MEcwbba/IK44dTuptfxx2eLDdO7uulqpaNx7DtWj5qb
         B3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689012309; x=1691604309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EB5CFdTYWApS8YMHOsiv0TiQQf51kpScKMC8hHDqG8g=;
        b=aUIhqxmRxvO818c+I2RMFSk/Djyya2NmzzClRCs19D8f9Mj4WwIPof+WCTV0JMKICw
         0VhzWPJ+qW/EqLlAvPtaplnhLuNQ41Y5nsqT93EeW/Flh6BCAj1+aOyS6CbeSYqxdbyH
         5JwKjpQJBs5frooMELWO4f+8Gb8bE/vjieBmgcIOM7+L2ZzSqHn4x4mFDEUD0faV6ZEb
         e56Mpi+LX3FjTwq9sa3ny+svpq9INibO0Xi2A67QOy28euVezFOlNDi5Aor0A5E2VIO8
         Dj6Skhy6qJnvDby5R4CxmMaH77HXeMD3b4/QDsTiH+728s47M3rSPpjKOzCNLEkO2Gdj
         T0BA==
X-Gm-Message-State: ABy/qLZll+Zx7jS0CmI6NOGElB0DV1rYacw4CCfaW/0Ju5qN3Opqzq9B
	NPIYu3qH6F5B9zvKxdjtWYOlbKObqj8LIU43cVED
X-Google-Smtp-Source: APBJJlEXMnAXAqgSe2gS4I8jMdsUlxV2m1S0LePICnU+VtDinyOkis46Y0X2+XrvApiiB580t/Us4PR4QCI8RZeUqGA=
X-Received: by 2002:a0d:cc47:0:b0:577:a46:26e5 with SMTP id
 o68-20020a0dcc47000000b005770a4626e5mr12504009ywd.31.1689012309085; Mon, 10
 Jul 2023 11:05:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230610075738.3273764-2-roberto.sassu@huaweicloud.com>
 <1c8c612d99e202a61e6a6ecf50d4cace.paul@paul-moore.com> <a28c8fce-741b-e088-af5e-8a83daa7e25d@schaufler-ca.com>
 <CAHC9VhSNqzVpHcDw59a2CznaME1078SJWuEcqJx=R5PQgSjTDg@mail.gmail.com>
In-Reply-To: <CAHC9VhSNqzVpHcDw59a2CznaME1078SJWuEcqJx=R5PQgSjTDg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 10 Jul 2023 14:04:58 -0400
Message-ID: <CAHC9VhSFy6wf+7DXrG=6CXZC4RrpTeP2sQezX0BPc95fxGAWxQ@mail.gmail.com>
Subject: Re: [PATCH v12 1/4] security: Allow all LSMs to provide xattrs for
 inode_init_security hook
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, 
	jmorris@namei.org, serge@hallyn.com, stephen.smalley.work@gmail.com, 
	eparis@parisplace.org, linux-kernel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, kpsingh@kernel.org, 
	keescook@chromium.org, nicolas.bouchinet@clip-os.org, 
	Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 7, 2023 at 5:44=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
> On Fri, Jul 7, 2023 at 12:54=E2=80=AFPM Casey Schaufler <casey@schaufler-=
ca.com> wrote:
> > On 7/6/2023 6:43 PM, Paul Moore wrote:
> > > On Jun 10, 2023 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> > >> Currently, the LSM infrastructure supports only one LSM providing an=
 xattr
> > >> and EVM calculating the HMAC on that xattr, plus other inode metadat=
a.
> > >>
> > >> Allow all LSMs to provide one or multiple xattrs, by extending the s=
ecurity
> > >> blob reservation mechanism. Introduce the new lbs_xattr_count field =
of the
> > >> lsm_blob_sizes structure, so that each LSM can specify how many xatt=
rs it
> > >> needs, and the LSM infrastructure knows how many xattr slots it shou=
ld
> > >> allocate.
> > >>
> > >> Modify the inode_init_security hook definition, by passing the full
> > >> xattr array allocated in security_inode_init_security(), and the cur=
rent
> > >> number of xattr slots in that array filled by LSMs. The first parame=
ter
> > >> would allow EVM to access and calculate the HMAC on xattrs supplied =
by
> > >> other LSMs, the second to not leave gaps in the xattr array, when an=
 LSM
> > >> requested but did not provide xattrs (e.g. if it is not initialized)=
.
> > >>
> > >> Introduce lsm_get_xattr_slot(), which LSMs can call as many times as=
 the
> > >> number specified in the lbs_xattr_count field of the lsm_blob_sizes
> > >> structure. During each call, lsm_get_xattr_slot() increments the num=
ber of
> > >> filled xattrs, so that at the next invocation it returns the next xa=
ttr
> > >> slot to fill.
> > >>
> > >> Cleanup security_inode_init_security(). Unify the !initxattrs and
> > >> initxattrs case by simply not allocating the new_xattrs array in the
> > >> former. Update the documentation to reflect the changes, and fix the
> > >> description of the xattr name, as it is not allocated anymore.
> > >>
> > >> Adapt both SELinux and Smack to use the new definition of the
> > >> inode_init_security hook, and to call lsm_get_xattr_slot() to obtain=
 and
> > >> fill the reserved slots in the xattr array.
> > >>
> > >> Move the xattr->name assignment after the xattr->value one, so that =
it is
> > >> done only in case of successful memory allocation.
> > >>
> > >> Finally, change the default return value of the inode_init_security =
hook
> > >> from zero to -EOPNOTSUPP, so that BPF LSM correctly follows the hook
> > >> conventions.
> > >>
> > >> Reported-by: Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>
> > >> Link: https://lore.kernel.org/linux-integrity/Y1FTSIo+1x+4X0LS@archl=
inux/
> > >> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > >> ---
> > >>  include/linux/lsm_hook_defs.h |  6 +--
> > >>  include/linux/lsm_hooks.h     | 20 ++++++++++
> > >>  security/security.c           | 71 +++++++++++++++++++++++---------=
---
> > >>  security/selinux/hooks.c      | 17 +++++----
> > >>  security/smack/smack_lsm.c    | 25 ++++++------
> > >>  5 files changed, 92 insertions(+), 47 deletions(-)
> > > Two *very* small suggestions below, but I can make those during the
> > > merge if you are okay with that Roberto?
> > >
> > > I'm also going to assume that Casey is okay with the Smack portion of
> > > this patchset?  It looks fine to me, and considering his ACK on the
> > > other Smack patch in this patchset I'm assuming he is okay with this
> > > one as well ... ?
> >
> > Yes, please feel free to add my Acked-by as needed.
>
> Done.  Thanks Casey.

I'm merging the full patchset into lsm/next right now.  Thanks for all
your work on this Roberto, and a thank you for everyone else who
helped with reviews, testing, etc.

--=20
paul-moore.com

