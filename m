Return-Path: <bpf+bounces-61029-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE35ADFC21
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 06:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0C9A7ACABF
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 04:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C2923AE83;
	Thu, 19 Jun 2025 04:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENjMH3TD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2F554764;
	Thu, 19 Jun 2025 04:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750305692; cv=none; b=oY/z+K2MhLtTW7WYY39FpFlZ3vkZhQ3ntWVCG1d/MrXsQfOEbysJYsnk8FBwQRCtz8geRN+41XkJorKJcY19RmOOJA5OWIZZy0BAcjzJfj/pL0ikkIWx9Gi9jCzSp1FWnKT5GRWoqailpgeXpGsIqp/JCHYXwaOtpiDgSgu0p8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750305692; c=relaxed/simple;
	bh=hahMQkDWS7jX4uay08kdq9BXQXzcA58U3ONHZSjrlzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gR3E1aJEFEeGLSU0icSoogExeMjWz2zDYI3uPYCON2bK6yeYyzbAlMzaTMjWFHYS8jOgzLjLruknEk4+z/cyRMsXLvZ9vGjUOxro2G05z1NSGu43ZoH1bJNPaiK/7UJe77VHPH5IUVca31wMHOGz075xOq+e3I0lkRF6BFkCPms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENjMH3TD; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b0b2d0b2843so279362a12.2;
        Wed, 18 Jun 2025 21:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750305690; x=1750910490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLa9WFnQF7IF2o8/2afKYfV+hsgtkELDJuA6/xkxYHY=;
        b=ENjMH3TDDf2nm+dWFOiw8B4eNNcahFzCRE49mLn3xhfJ91Y0iQOeCzXmSvWuvlI31w
         wPKh+QU8QfEmWFHYqVVFWPaunIOLeFES7D9QCqNugjUejJl3NfF2XUx8pk19vp0kLeCc
         hbyGrhWiTZ3qAgXpgqWB6KShRCzcpxm1plHR8rO1yqcxPgcxikC6NBuTkkSiSgG/ZRXh
         rb8wKPvtq1HL4gGaiUKj4FcCFf1kdAfzdWLdwOeCfAYMhY2diNzFSe98AgRsStJPRDzZ
         xsD7GOv1Qt7aKrBaqyPHmshjque8yH21xcOE5TtReRQXELX4MhHymCTBqVoB0kRjFHJO
         nsbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750305690; x=1750910490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hLa9WFnQF7IF2o8/2afKYfV+hsgtkELDJuA6/xkxYHY=;
        b=W1XyIQQMCBFqM/LOUoyGsj+xvFivCZpzcIXyAH8zhtKXYKa7iuvgJJFDzd+Y17r5nZ
         o08n1MtN4b43q6hr2dgxYr3E/p0VpWLvV6FjJfud/HP27+RcSZRykwrb0+RXm8ECMwti
         injAVL0dyMS7dqC1UCYBKyFZOP6s/i0fIomKDm7sGhqkeTcO6GSw4BwYASKnSNakrog8
         crVAk1ELLSd9SB1HFmwHu8lmpxcvgZpvCynJYZFyELM4d3JA4Siz5RKYMtPl1aLoEusl
         skk/MXgyGD4vTUXK2ZSXU0SdbA7zzJ00eCaHd8tWnnwUZ3ZlQTBNYgWs/fBJoK2/x35q
         auwA==
X-Forwarded-Encrypted: i=1; AJvYcCUTN9AI/ImAf9YxNl0L02TVlKzglOF6XtNRWD3bgy68Kciop+kSgvBA7e8uF4ifnJ0R3m1uMJC3pCNNBgcCxQ3q2H4Mrq8o@vger.kernel.org, AJvYcCVGSxf1aQdSuiWBAfMdldnB2Ceu47nb/hq/i3hW0HOvoWulLQz46Ej9H2VWtNxk7T12QOvqMkPx@vger.kernel.org, AJvYcCW3nfFzDPdfDQDhMnz0WcGKylOqjjkwpgSCASM66cZai/jHrfRcEYnf/GOBTKTbSqxpO+k18TGevQ==@vger.kernel.org, AJvYcCW4ClejFv8and/AK4ru7bGvaDMgCQSX0hklMzo4qC0QFEtz3C/prO0pNPuq0DWKLPIh85o=@vger.kernel.org
X-Gm-Message-State: AOJu0YydsehUq73b0c+X5QEzssqLEZjguMPQNSVOZyM6HS4pZaAMS+Tm
	DHWuZyqWa8ghvNbXmfMLSck1Cl7qt0lCilxbW7L/vfEV41t42RaEDHY=
X-Gm-Gg: ASbGncvy/F4/7DXqIPBvG+d2gx7Js67wy0AuOtP0XgFkjpF0+baMyEVPEAaEj4gDLpM
	U2MJilbTY5BjqDuZBE73pCeOQ9inQ6aTWEotQtZzuMQ7ZHFrGDL64j1tv3gzSDXnNOd+mycpReX
	Ki+iemu8bOH6QiPZszoPoXmfmo+bUFKJQpOKAShwY2LooXHm79WklVQOR2FQXQTGTwICtX1h/mr
	92FlvzxnYQpwzt5bkY6Wl8M5cCJcNZpmxlUXs9/PY0e8SBVnm8a14wfEDWK28AwtziRu8SqTOCI
	mO6tRhXFl+L/Ms9mGCzjJ3OyxUhYNrr4TR60mHDSM77hpwJrQA==
X-Google-Smtp-Source: AGHT+IEQxR9zmQ3AFhwx3xJxjctnoZsDPTAbaxJRuMZQaaUyg03ATv9MiuAh8dr7PJaCWTmD3uUZFQ==
X-Received: by 2002:a17:90b:3805:b0:313:2768:3f6b with SMTP id 98e67ed59e1d1-313f1daf338mr28392518a91.27.1750305690013;
        Wed, 18 Jun 2025 21:01:30 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a318733sm949862a91.38.2025.06.18.21.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 21:01:29 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: paul@paul-moore.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	casey@schaufler-ca.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	gnoack@google.com,
	haoluo@google.com,
	jmorris@namei.org,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	kuni1840@gmail.com,
	kuniyu@google.com,
	linux-security-module@vger.kernel.org,
	martin.lau@linux.dev,
	memxor@gmail.com,
	mic@digikod.net,
	netdev@vger.kernel.org,
	omosnace@redhat.com,
	sdf@fomichev.me,
	selinux@vger.kernel.org,
	serge@hallyn.com,
	song@kernel.org,
	stephen.smalley.work@gmail.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH v2 bpf-next 0/4] af_unix: Allow BPF LSM to filter SCM_RIGHTS at sendmsg().
Date: Wed, 18 Jun 2025 21:00:29 -0700
Message-ID: <20250619040127.1122427-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <CAHC9VhRWi5QdRgU-Eko4XZ9A2W2o3uhVAagVkhu1eT18qAWdkg@mail.gmail.com>
References: <CAHC9VhRWi5QdRgU-Eko4XZ9A2W2o3uhVAagVkhu1eT18qAWdkg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Paul Moore <paul@paul-moore.com>
Date: Wed, 18 Jun 2025 23:23:31 -0400
> On Sat, Jun 14, 2025 at 4:40 PM Kuniyuki Iwashima <kuni1840@gmail.com> wrote:
> > From: Paul Moore <paul@paul-moore.com>
> > Date: Sat, 14 Jun 2025 07:43:46 -0400
> > > On June 13, 2025 6:24:15 PM Kuniyuki Iwashima <kuni1840@gmail.com> wrote:
> > > > From: Kuniyuki Iwashima <kuniyu@google.com>
> > > >
> > > > Since commit 77cbe1a6d873 ("af_unix: Introduce SO_PASSRIGHTS."),
> > > > we can disable SCM_RIGHTS per socket, but it's not flexible.
> > > >
> > > > This series allows us to implement more fine-grained filtering for
> > > > SCM_RIGHTS with BPF LSM.
> > >
> > > My ability to review this over the weekend is limited due to device and
> > > network access, but I'll take a look next week.
> > >
> > > That said, it would be good if you could clarify the "filtering" aspect of
> > > your comments; it may be obvious when I'm able to look at the full patchset
> >
> > I meant to mention that just below the quoted part :)
> >
> > ---8<---
> > Changes:
> >   v2: Remove SCM_RIGHTS fd scrubbing functionality
> > ---8<---
> 
> Thanks :)
> 
> While looking at your patches tonight, I was wondering if you had ever
> considered adding a new LSM hook to __scm_send() that specifically
> targets SCM_RIGHTS?  I was thinking of something like this:
> 
> diff --git a/net/core/scm.c b/net/core/scm.c
> index 0225bd94170f..5fec8abc99f5 100644
> --- a/net/core/scm.c
> +++ b/net/core/scm.c
> @@ -173,6 +173,9 @@ int __scm_send(struct socket *sock, struct msghdr *msg, stru
> ct scm_cookie *p)
>                case SCM_RIGHTS:
>                        if (!ops || ops->family != PF_UNIX)
>                                goto error;
> +                       err = security_sock_scm_rights(sock);
> +                       if (err<0)
> +                               goto error;
>                        err=scm_fp_copy(cmsg, &p->fp);
>                        if (err<0)
>                                goto error;
> 
> ... if I'm correct in my understanding of what you are trying to
> accomplish, I believe this should allow you to meet your goals with a
> much simpler and targeted approach.  Or am I thinking about this
> wrong?

As BPF LSM is just a hook point and not tied to a specific socket,
we cannot know who will receive the message in __scm_send().

Also, the hook must be after scm_fp_copy(), otherwise struct file
is not yet available there.

Another way I thought of was to reuse LSM hook in sk_filter()
(SOCK_STREAM needs to add it), but it returns 0 even when we drop
skb, which will be less preferable.


BTW, I was about to send v3, what target tree should be specified in
subject, bpf-next or something else ?

