Return-Path: <bpf+bounces-1551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A982D718E3F
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 00:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43AE828163B
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 22:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AA940771;
	Wed, 31 May 2023 22:14:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FAD19E7C
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 22:14:19 +0000 (UTC)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB01E47
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 15:14:07 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-ba8cd61ee2dso2232759276.1
        for <bpf@vger.kernel.org>; Wed, 31 May 2023 15:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1685571246; x=1688163246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1mXm+9uLIvxYwyN0O9GdRX8Q16XpxPjqx3kAU0XOoV0=;
        b=gYnDBlElaWB7V6hFlQCDrVssCIXI7+yBRtbun0CV/vffPdCvHCQnjryKR2kLSmgOmK
         2jsHD3akLv6VqRCANKAyHvdtcStTC69fIO4LWoZKkXF83YjvnA/ryGHeTUKMzwo35EKS
         gFqKgLXtjdIRlGb/F2rH4YA9MNZaYKjHnaOzoi2Lymst9BSI5TmcgQ3pL3XJG0wyjyV+
         RhE3D6XuYhBLES3YpAnCgXp7wTBY8kQahaubx/D0NHAAmp2ZzhjyogY5xjBQZfCM+2lB
         Mm6XY+Zdaf5BXFq75tmYUOo9N/qG69gPpcPr45ITBwSGhKseamFxkKAvr+L+iXfQoMv/
         NjjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685571246; x=1688163246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1mXm+9uLIvxYwyN0O9GdRX8Q16XpxPjqx3kAU0XOoV0=;
        b=RR9a40sZW4/E0q3kiK4X1KqX2w2MjLMFfuo/8HH+x9btlmgYklppcL8XgmWGLGkWL1
         mBlEJ5VGgMJCjXkRZjW9XCGV14f9YtVYACZbe7cItDe+KOpe84tn6TX14Y+USa+Q1MIA
         m1W1H39JI0bSfkamS0lBGWu+452B6k5teTm1PgghLYjygNl5Xz0Jdz0ftIzaKuOgpzB4
         Uy+1KAB7k0s9/l7geVrfXLxSciendPti+2cEPO3vf5NvW8uG7IoPiU07UYX68DrwidoQ
         Xnd4gHpKzph0La0Xl26XGhXNhHjBTpLy3Ayt1pf7+9cP5scIclvjbM1HXy+ACBKBcN+7
         blhg==
X-Gm-Message-State: AC+VfDyEg+z5GJZQkdR/bqTN5bzXRe1qJ9iS0NgtNoz5jOQOX9Nm++Sy
	HEtbpxwfYl20sSlJaeIwCJbjDvo4Wj+89X9Y4dxl
X-Google-Smtp-Source: ACHHUZ6W6xMZjbfsh3GA/9bSdwgRt6B7PxdsSqmYwJEzbse/7y5frYRLMcpD5xI0njjiSUcSqtlaTSAAFyUXSScXWg4=
X-Received: by 2002:a25:508c:0:b0:b94:bbf2:19a3 with SMTP id
 e134-20020a25508c000000b00b94bbf219a3mr8184411ybb.18.1685571246124; Wed, 31
 May 2023 15:14:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230511142535.732324-1-cgzones@googlemail.com>
 <20230531140734.GA515872@mail.hallyn.com> <20230531140847.GB515872@mail.hallyn.com>
 <CAJ2a_DesiD+LU-aWOEWRkyc0rcmZ0Za5i6-rZX-kHP2GzQyuFg@mail.gmail.com>
In-Reply-To: <CAJ2a_DesiD+LU-aWOEWRkyc0rcmZ0Za5i6-rZX-kHP2GzQyuFg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 31 May 2023 18:13:55 -0400
Message-ID: <CAHC9VhQBuQ+yE1wmEYA4UcVwnRFXoyu9_4Qw5LWszUrkm_ornw@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] capability: introduce new capable flag NODENYAUDIT
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, selinux@vger.kernel.org, 
	John Johansen <john.johansen@canonical.com>, James Morris <jmorris@namei.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Eric Paris <eparis@parisplace.org>, 
	Christian Brauner <brauner@kernel.org>, Casey Schaufler <casey@schaufler-ca.com>, 
	Dave Chinner <dchinner@redhat.com>, Nathan Lynch <nathanl@linux.ibm.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Micah Morton <mortonm@chromium.org>, Frederick Lawler <fred@cloudflare.com>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>, 
	linux-kernel@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 31, 2023 at 2:34=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
> On Wed, 31 May 2023 at 16:08, Serge E. Hallyn <serge@hallyn.com> wrote:
> >
> > On Wed, May 31, 2023 at 09:07:34AM -0500, Serge E. Hallyn wrote:
> > > On Thu, May 11, 2023 at 04:25:24PM +0200, Christian G=C3=B6ttsche wro=
te:
> > > > Introduce a new capable flag, CAP_OPT_NODENYAUDIT, to not generate
> > > > an audit event if the requested capability is not granted.  This wi=
ll be
> > > > used in a new capable_any() functionality to reduce the number of
> > > > necessary capable calls.
> > > >
> > > > Handle the flag accordingly in AppArmor and SELinux.
> > > >
> > > > Suggested-by: Paul Moore <paul@paul-moore.com>
> > > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > >
> > > Reviewed-by: Serge Hallyn <serge@hallyn.com>
> >
> > Sorry, obviously I should have removed this, until the comment below wa=
s
> > answered :)
> >
> > > > ---
> > > >  include/linux/security.h       |  2 ++
> > > >  security/apparmor/capability.c |  8 +++++---
> > > >  security/selinux/hooks.c       | 14 ++++++++------
> > > >  3 files changed, 15 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/include/linux/security.h b/include/linux/security.h
> > > > index e2734e9e44d5..629c775ec297 100644
> > > > --- a/include/linux/security.h
> > > > +++ b/include/linux/security.h
> > > > @@ -67,6 +67,8 @@ struct watch_notification;
> > > >  #define CAP_OPT_NOAUDIT BIT(1)
> > > >  /* If capable is being called by a setid function */
> > > >  #define CAP_OPT_INSETID BIT(2)
> > > > +/* If capable should audit the security request for authorized req=
uests only */
> > > > +#define CAP_OPT_NODENYAUDIT BIT(3)
> > > >
> > > >  /* LSM Agnostic defines for security_sb_set_mnt_opts() flags */
> > > >  #define SECURITY_LSM_NATIVE_LABELS 1
> > > > diff --git a/security/apparmor/capability.c b/security/apparmor/cap=
ability.c
> > > > index 326a51838ef2..98120dd62ca7 100644
> > > > --- a/security/apparmor/capability.c
> > > > +++ b/security/apparmor/capability.c
> > > > @@ -108,7 +108,8 @@ static int audit_caps(struct common_audit_data =
*sa, struct aa_profile *profile,
> > > >   * profile_capable - test if profile allows use of capability @cap
> > > >   * @profile: profile being enforced    (NOT NULL, NOT unconfined)
> > > >   * @cap: capability to test if allowed
> > > > - * @opts: CAP_OPT_NOAUDIT bit determines whether audit record is g=
enerated
> > > > + * @opts: CAP_OPT_NOAUDIT/CAP_OPT_NODENYAUDIT bit determines wheth=
er audit
> > > > + * record is generated
> > > >   * @sa: audit data (MAY BE NULL indicating no auditing)
> > > >   *
> > > >   * Returns: 0 if allowed else -EPERM
> > > > @@ -126,7 +127,7 @@ static int profile_capable(struct aa_profile *p=
rofile, int cap,
> > > >     else
> > > >             error =3D -EPERM;
> > > >
> > > > -   if (opts & CAP_OPT_NOAUDIT) {
> > > > +   if ((opts & CAP_OPT_NOAUDIT) || ((opts & CAP_OPT_NODENYAUDIT) &=
& error)) {
> > > >             if (!COMPLAIN_MODE(profile))
> > > >                     return error;
> > > >             /* audit the cap request in complain mode but note that=
 it
> > > > @@ -142,7 +143,8 @@ static int profile_capable(struct aa_profile *p=
rofile, int cap,
> > > >   * aa_capable - test permission to use capability
> > > >   * @label: label being tested for capability (NOT NULL)
> > > >   * @cap: capability to be tested
> > > > - * @opts: CAP_OPT_NOAUDIT bit determines whether audit record is g=
enerated
> > > > + * @opts: CAP_OPT_NOAUDIT/CAP_OPT_NODENYAUDIT bit determines wheth=
er audit
> > > > + * record is generated
> > > >   *
> > > >   * Look up capability in profile capability set.
> > > >   *
> > > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > > index 79b4890e9936..0730edf2f5f1 100644
> > > > --- a/security/selinux/hooks.c
> > > > +++ b/security/selinux/hooks.c
> > > > @@ -1571,7 +1571,7 @@ static int cred_has_capability(const struct c=
red *cred,
> > > >     u16 sclass;
> > > >     u32 sid =3D cred_sid(cred);
> > > >     u32 av =3D CAP_TO_MASK(cap);
> > > > -   int rc;
> > > > +   int rc, rc2;
> > > >
> > > >     ad.type =3D LSM_AUDIT_DATA_CAP;
> > > >     ad.u.cap =3D cap;
> > > > @@ -1590,11 +1590,13 @@ static int cred_has_capability(const struct=
 cred *cred,
> > > >     }
> > > >
> > > >     rc =3D avc_has_perm_noaudit(sid, sid, sclass, av, 0, &avd);
> > > > -   if (!(opts & CAP_OPT_NOAUDIT)) {
> > > > -           int rc2 =3D avc_audit(sid, sid, sclass, av, &avd, rc, &=
ad);
> > > > -           if (rc2)
> > > > -                   return rc2;
> > > > -   }
> > > > +   if ((opts & CAP_OPT_NOAUDIT) || ((opts & CAP_OPT_NODENYAUDIT) &=
& rc))
> > > > +           return rc;
> > >
> > > Hm, if the caller passes only CAP_OPT_NODENYAUDIT, and rc =3D=3D 0, t=
hen
> > > you will audit the allow.  Is that what you want, or did you want, or
> > > did you want CAP_OPT_NODENYAUDIT to imply CAP_OPT_NOAUDIT?
> > >
>
> The new option should cause to issue an audit event if (and only if)
> the requested capability is in effect for the current task. If the
> task does not have the capability no audit event should be issued.
>
> The new option should not imply CAP_OPT_NOAUDIT since we want an audit
> event in the case the capability is in effect.
>
> I admit the naming is a bit confusing as CAP_OPT_NODENYAUDIT as well
> as the commit description contains a double negation (while the inline
> comment for the macro definition does not).
>
> Do you prefer naming the constant CAP_OPT_ALLOWAUDIT or CAP_OPT_AUDIT_ON_=
ALLOW?

I think we need a different name, although I'm struggling to think of
something ... I don't think ALLOWAUDIT is right, as I believe it
implies that it is needed to "allow" auditing to take place for the
operation.  AUDIT_ON_ALLOW is better, but it still seems like it would
be required if you wanted to generate audit records on a successful
operation, which isn't correct.  I think we need to focus on the idea
that the flag blocks auditing for denials.

CAP_OPT_NOAUDITDENY is pretty much what you have, but in my mind the
NOAUDITDENY shares enough with the existing NOAUDIT flag that it makes
a bit more sense.

I honestly don't know.  However, whatever you pick, make sure you
update patch 2/X so that the name of ns_capable_nodenyaudit() is kept
close to the flag's name.

--=20
paul-moore.com

