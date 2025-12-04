Return-Path: <bpf+bounces-76049-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7190ECA43EC
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 16:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1E1330F7029
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 15:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72842D3731;
	Thu,  4 Dec 2025 15:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRVSfs1Q"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C3428980F;
	Thu,  4 Dec 2025 15:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764861499; cv=none; b=jesDxnFwiheghykw3vZudwGoEGuiLGwu2cAeg3kv0qS+TfoITLRK/oBMZIl9LJDW7EokNn2/zQfT6gLpVfmZrvxIs5muL2ZomaYWn/BAV4v51RP50HTUOUmvzld1xq4kU9EYB+Y4DtVOGn91RMLd+tHe5psyMToKF+SupOcIF7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764861499; c=relaxed/simple;
	bh=lsTB+3F5NNRh88GewC3pRUVD6kdoP9tuMFgeipxXeq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggq7IxqpncLaEOzGFbpPhgD70h4cfpekG3Fp13Fj9uUIuIKoguWqUmpA0SF17lskAeASm0zFP+DqssAYTObLPUw8MxJrXOehSdMEDmZxHsUJyWk5IZ8zQcJeQKraQk2mIbOId7XfDsOHXGDN6YNiAcqIqJFWgAcXj5qLkvqqLdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRVSfs1Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A70C116B1;
	Thu,  4 Dec 2025 15:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764861499;
	bh=lsTB+3F5NNRh88GewC3pRUVD6kdoP9tuMFgeipxXeq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gRVSfs1QriUvDl3yVHEE0V9L/uf+xTuHtX1lglua2/C4kppN1wAE7ANQyiD4ZJcHN
	 dnci2n9ymhnoQ0jY6A1Z4jJ3qOgNjTn5w4/68NxV//NbBbDHxRWgONWkhXFaNiR794
	 pLeK57Hlzs253CoJ4wSTLERMO5lJN+5MWHcNa7Q/fr9QNJWsSYtbTp0kDbDtf5KE0s
	 Tzusjf7C28ap4eym30iJlhdv8AocFdjl7cOEdRM6DowDR1kzh6pK8atXTrzzPTC1Jb
	 tdTraWzHlEDANk6HZEEkdhOlP4CtG8ryS8CXhH4GgWAWEyWozCz5FmfDux5JHZvyiN
	 XsNFS0jpN/UTA==
Date: Thu, 4 Dec 2025 08:18:16 -0700
From: Tycho Andersen <tycho@kernel.org>
To: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: kees@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>,
	Andrei Vagin <avagin@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	=?iso-8859-1?Q?St=E9phane?= Graber <stgraber@stgraber.org>
Subject: Re: [PATCH v2 4/6] seccomp: handle multiple listeners case
Message-ID: <aTGmOGTNndl3oTk7@tycho.pizza>
References: <20251202115200.110646-1-aleksandr.mikhalitsyn@canonical.com>
 <20251202115200.110646-5-aleksandr.mikhalitsyn@canonical.com>
 <CAEivzxf0a8EDzVJ+j7FLuarKHrCRPUtS9Z+tQ4se9E+xHvE0Fg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEivzxf0a8EDzVJ+j7FLuarKHrCRPUtS9Z+tQ4se9E+xHvE0Fg@mail.gmail.com>

On Wed, Dec 03, 2025 at 04:29:49PM +0100, Aleksandr Mikhalitsyn wrote:
> On Tue, Dec 2, 2025 at 12:52 PM Alexander Mikhalitsyn
> <aleksandr.mikhalitsyn@canonical.com> wrote:
> >
> > If we have more than one listener in the tree and lower listener
> > wants us to continue syscall (SECCOMP_USER_NOTIF_FLAG_CONTINUE)
> > we must consult with upper listeners first, otherwise it is a
> > clear seccomp restrictions bypass scenario.
> >
> > Cc: linux-kernel@vger.kernel.org
> > Cc: bpf@vger.kernel.org
> > Cc: Kees Cook <kees@kernel.org>
> > Cc: Andy Lutomirski <luto@amacapital.net>
> > Cc: Will Drewry <wad@chromium.org>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Shuah Khan <shuah@kernel.org>
> > Cc: Aleksa Sarai <cyphar@cyphar.com>
> > Cc: Tycho Andersen <tycho@tycho.pizza>
> > Cc: Andrei Vagin <avagin@gmail.com>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Stéphane Graber <stgraber@stgraber.org>
> > Reviewed-by: Tycho Andersen (AMD) <tycho@kernel.org>
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> > ---
> >  kernel/seccomp.c | 33 +++++++++++++++++++++++++++++++--
> >  1 file changed, 31 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> > index ded3f6a6430b..262390451ff1 100644
> > --- a/kernel/seccomp.c
> > +++ b/kernel/seccomp.c
> > @@ -448,8 +448,21 @@ static u32 seccomp_run_filters(const struct seccomp_data *sd,
> >
> >                 if (ACTION_ONLY(cur_ret) < ACTION_ONLY(ret)) {
> >                         ret = cur_ret;
> > +                       /*
> > +                        * No matter what we had before in matches->filters[],
> > +                        * we need to overwrite it, because current action is more
> > +                        * restrictive than any previous one.
> > +                        */
> >                         matches->n = 1;
> >                         matches->filters[0] = f;
> > +               } else if ((ACTION_ONLY(cur_ret) == ACTION_ONLY(ret)) &&
> > +                           ACTION_ONLY(cur_ret) == SECCOMP_RET_USER_NOTIF) {
> 
> My bad. We also have to check f->notif in there like that:

For my own education: why is that? Shouldn't
seccomp_do_user_notification() be smart enough to catch this case (and
indeed, there is a TOCTOU if you do it here?)?

Thanks,

Tycho

