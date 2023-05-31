Return-Path: <bpf+bounces-1514-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F96E71851A
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 16:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE3161C20EEC
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 14:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEBA14AB4;
	Wed, 31 May 2023 14:37:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA791C11
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 14:37:25 +0000 (UTC)
X-Greylist: delayed 900 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 31 May 2023 07:37:23 PDT
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2378AB2;
	Wed, 31 May 2023 07:37:23 -0700 (PDT)
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 06C79FEF; Wed, 31 May 2023 09:08:47 -0500 (CDT)
Date: Wed, 31 May 2023 09:08:47 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>,
	selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
	John Johansen <john.johansen@canonical.com>,
	James Morris <jmorris@namei.org>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Eric Paris <eparis@parisplace.org>,
	Christian Brauner <brauner@kernel.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Dave Chinner <dchinner@redhat.com>,
	Nathan Lynch <nathanl@linux.ibm.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Micah Morton <mortonm@chromium.org>,
	Frederick Lawler <fred@cloudflare.com>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>,
	linux-kernel@vger.kernel.org, apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v4 1/9] capability: introduce new capable flag NODENYAUDIT
Message-ID: <20230531140847.GB515872@mail.hallyn.com>
References: <20230511142535.732324-1-cgzones@googlemail.com>
 <20230531140734.GA515872@mail.hallyn.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230531140734.GA515872@mail.hallyn.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 31, 2023 at 09:07:34AM -0500, Serge E. Hallyn wrote:
> On Thu, May 11, 2023 at 04:25:24PM +0200, Christian Göttsche wrote:
> > Introduce a new capable flag, CAP_OPT_NODENYAUDIT, to not generate
> > an audit event if the requested capability is not granted.  This will be
> > used in a new capable_any() functionality to reduce the number of
> > necessary capable calls.
> > 
> > Handle the flag accordingly in AppArmor and SELinux.
> > 
> > Suggested-by: Paul Moore <paul@paul-moore.com>
> > Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> 
> Reviewed-by: Serge Hallyn <serge@hallyn.com>

Sorry, obviously I should have removed this, until the comment below was
answered :)

> > ---
> >  include/linux/security.h       |  2 ++
> >  security/apparmor/capability.c |  8 +++++---
> >  security/selinux/hooks.c       | 14 ++++++++------
> >  3 files changed, 15 insertions(+), 9 deletions(-)
> > 
> > diff --git a/include/linux/security.h b/include/linux/security.h
> > index e2734e9e44d5..629c775ec297 100644
> > --- a/include/linux/security.h
> > +++ b/include/linux/security.h
> > @@ -67,6 +67,8 @@ struct watch_notification;
> >  #define CAP_OPT_NOAUDIT BIT(1)
> >  /* If capable is being called by a setid function */
> >  #define CAP_OPT_INSETID BIT(2)
> > +/* If capable should audit the security request for authorized requests only */
> > +#define CAP_OPT_NODENYAUDIT BIT(3)
> >  
> >  /* LSM Agnostic defines for security_sb_set_mnt_opts() flags */
> >  #define SECURITY_LSM_NATIVE_LABELS	1
> > diff --git a/security/apparmor/capability.c b/security/apparmor/capability.c
> > index 326a51838ef2..98120dd62ca7 100644
> > --- a/security/apparmor/capability.c
> > +++ b/security/apparmor/capability.c
> > @@ -108,7 +108,8 @@ static int audit_caps(struct common_audit_data *sa, struct aa_profile *profile,
> >   * profile_capable - test if profile allows use of capability @cap
> >   * @profile: profile being enforced    (NOT NULL, NOT unconfined)
> >   * @cap: capability to test if allowed
> > - * @opts: CAP_OPT_NOAUDIT bit determines whether audit record is generated
> > + * @opts: CAP_OPT_NOAUDIT/CAP_OPT_NODENYAUDIT bit determines whether audit
> > + *	record is generated
> >   * @sa: audit data (MAY BE NULL indicating no auditing)
> >   *
> >   * Returns: 0 if allowed else -EPERM
> > @@ -126,7 +127,7 @@ static int profile_capable(struct aa_profile *profile, int cap,
> >  	else
> >  		error = -EPERM;
> >  
> > -	if (opts & CAP_OPT_NOAUDIT) {
> > +	if ((opts & CAP_OPT_NOAUDIT) || ((opts & CAP_OPT_NODENYAUDIT) && error)) {
> >  		if (!COMPLAIN_MODE(profile))
> >  			return error;
> >  		/* audit the cap request in complain mode but note that it
> > @@ -142,7 +143,8 @@ static int profile_capable(struct aa_profile *profile, int cap,
> >   * aa_capable - test permission to use capability
> >   * @label: label being tested for capability (NOT NULL)
> >   * @cap: capability to be tested
> > - * @opts: CAP_OPT_NOAUDIT bit determines whether audit record is generated
> > + * @opts: CAP_OPT_NOAUDIT/CAP_OPT_NODENYAUDIT bit determines whether audit
> > + *	record is generated
> >   *
> >   * Look up capability in profile capability set.
> >   *
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 79b4890e9936..0730edf2f5f1 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -1571,7 +1571,7 @@ static int cred_has_capability(const struct cred *cred,
> >  	u16 sclass;
> >  	u32 sid = cred_sid(cred);
> >  	u32 av = CAP_TO_MASK(cap);
> > -	int rc;
> > +	int rc, rc2;
> >  
> >  	ad.type = LSM_AUDIT_DATA_CAP;
> >  	ad.u.cap = cap;
> > @@ -1590,11 +1590,13 @@ static int cred_has_capability(const struct cred *cred,
> >  	}
> >  
> >  	rc = avc_has_perm_noaudit(sid, sid, sclass, av, 0, &avd);
> > -	if (!(opts & CAP_OPT_NOAUDIT)) {
> > -		int rc2 = avc_audit(sid, sid, sclass, av, &avd, rc, &ad);
> > -		if (rc2)
> > -			return rc2;
> > -	}
> > +	if ((opts & CAP_OPT_NOAUDIT) || ((opts & CAP_OPT_NODENYAUDIT) && rc))
> > +		return rc;
> 
> Hm, if the caller passes only CAP_OPT_NODENYAUDIT, and rc == 0, then
> you will audit the allow.  Is that what you want, or did you want, or
> did you want CAP_OPT_NODENYAUDIT to imply CAP_OPT_NOAUDIT?
> 
> > +
> > +	rc2 = avc_audit(sid, sid, sclass, av, &avd, rc, &ad);
> > +	if (rc2)
> > +		return rc2;
> > +
> >  	return rc;
> >  }
> >  
> > -- 
> > 2.40.1

