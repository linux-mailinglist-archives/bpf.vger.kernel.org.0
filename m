Return-Path: <bpf+bounces-37571-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A92D9957C83
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 06:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 495801F2517C
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 04:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF36146A96;
	Tue, 20 Aug 2024 04:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZJyotmYl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C9752F88
	for <bpf@vger.kernel.org>; Tue, 20 Aug 2024 04:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724128763; cv=none; b=knyIj5TOCPRp3k1LfsQ0/fNeJZnkG6dUK2StclLJgejkKU5CNJi0WAcImXvOWF48W+Ykwplgrm9c/jX3KJfdgmIAC0gHH80EA1g/kYieG6pyMzZrlxPswD6wckezehmk/76J1129AEAZbIvGC8Th6tJWLUtpzz+DHBDeQtmxq/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724128763; c=relaxed/simple;
	bh=x8SXMFpjGPOwJ8LoO1Tb2GK4QZZAJ8O1PgsLSdeGr+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QnWfWI87P6nEWFbbAdo09SxmUAeBPRS9749bhefDJqklfS9RbW//NQ2oqpoWYKJkbrt6ZV/mPYl0aNlMUA2gm+835BHGgylaSeOmTJHJLROB4HxSMlGb2KUssBCfRJee8Tnl2AgzdVkVx2Do4UhDff85YW70SgBkpXeMwuPZRHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZJyotmYl; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e116a5c3922so4945444276.1
        for <bpf@vger.kernel.org>; Mon, 19 Aug 2024 21:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1724128760; x=1724733560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GVLG+2V5adXXHXUhEy1H242ae/Dt7QyF68DVBbvLxYY=;
        b=ZJyotmYlcmktT7Y5eaxIrPXLLseKZCnrb6yvg3rjYLURA4lLJ2KhCzdSYMra8BW0+b
         YL+npqe7ZocxL3Zv6CGTZMaWB6bzW7y2Y8iUCjYvCZtsFWozE7qT+RSqSXwPOtJQn87L
         ReB4Hf5glhQtClPlXANSeUHz5XaKdEBhqWNmCQ+jPelmuPoqr+rJZ8uOu2zF7TF+QXko
         uJFaI4TKOgnuU69w0b2Jq77zse21iXImnDfDXWSKjMJHDi837KSyFbZXblO/Z1UVBALK
         nftTxNU0CjTKDu8Yv9lFfJ+GoHaNwqf3/Pz80+iRDWzvUeWTumIuqPZz4S5hXZq+n6IC
         vNNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724128760; x=1724733560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GVLG+2V5adXXHXUhEy1H242ae/Dt7QyF68DVBbvLxYY=;
        b=XITDGHeVT99Ouwq81Ll8bo5QWUJtiPpyNe2eFsKBjXM6TEZr8N10hZ0oPqqBRRqWBb
         u382C0M5j2/UEXWgazzqrLu5hN6z4IdLa1c/DXcCRYopJOg/BKNhSpwwHMyPKo4sX8Hr
         eVNYOuxVzWJ20mUyfoPMsS37yGamnDYhdkW9S6RTmGUtnIUhYcmJ7l85UHNRE6V0PVIk
         VFxZwncs82wpcRpW0ikiKEqYiXsaiGI99dlKWaT5ypWgJGGMcO/YXX5wtnU62f6qhzc4
         HKHlYPwrolAOKxXBiZ65GNGFW5suR4771DmqsfmGIaHNcSQucY5d0/CG7VuEUdoGX+kE
         WwJg==
X-Forwarded-Encrypted: i=1; AJvYcCV6Pt9onvtNTQnBu47fK/zgSJnvesWlprHibGpLL25xxH5bVA2OhBMrhH4AM86PKv1wuyfbh3qzhog2IDcjZDa2OCsr
X-Gm-Message-State: AOJu0YwO1ZfQjC0kHDbZpcgU0KrHbYXc+Hn2nFYw2liC7bLJO5d1h2Jr
	DYKZVofaaKY1jiow6ZoxOhWhHBVp4PqIwg41C7pD3Kq4jPUXljbfbZN2VU1bh6+Duego/n7ypK5
	XqKQye2vdbNe9Xx12pD3sBSyls18mYiomrzvI
X-Google-Smtp-Source: AGHT+IHBZJsmdHe3NGOVgh/bOqPFH1XH+ZrKh82osDensmly2I3g0Bu1sbUvsfEwVI8fgR0Yf2jItzzaLoaJBzyFEoA=
X-Received: by 2002:a05:690c:2e90:b0:6b4:e3ca:3a76 with SMTP id
 00721157ae682-6b4e3ca3c9dmr80575167b3.19.1724128760224; Mon, 19 Aug 2024
 21:39:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816154307.3031838-1-kpsingh@kernel.org> <20240816154307.3031838-4-kpsingh@kernel.org>
In-Reply-To: <20240816154307.3031838-4-kpsingh@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 20 Aug 2024 00:39:09 -0400
Message-ID: <CAHC9VhS18-1+a1Ftep66-AX4Z_PVeSMr2D_jsG5njStWgFJRig@mail.gmail.com>
Subject: Re: [PATCH v15 3/4] lsm: count the LSMs enabled at compile time
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	casey@schaufler-ca.com, andrii@kernel.org, keescook@chromium.org, 
	daniel@iogearbox.net, renauld@google.com, revest@chromium.org, 
	song@kernel.org, linux@roeck-us.net, Kui-Feng Lee <sinquersw@gmail.com>, 
	John Johansen <john.johansen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 11:43=E2=80=AFAM KP Singh <kpsingh@kernel.org> wrot=
e:
>
> These macros are a clever trick to determine a count of the number of
> LSMs that are enabled in the config to ascertain the maximum number of
> static calls that need to be configured per LSM hook.
>
> Without this one would need to generate static calls for the total
> number of LSMs in the kernel (even if they are not compiled) times the
> number of LSM hooks which ends up being quite wasteful.
>
> Suggested-by: Kui-Feng Lee <sinquersw@gmail.com>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Acked-by: Song Liu <song@kernel.org>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> [PM: subj tweaks]
> Signed-off-by: Paul Moore <paul@paul-moore.com>

For future reference, it's fine to grab the commits that I previously
merged into the lsm/dev branch to use as a base, but you should
probably drop the merge edit notes (the stuff in the braces) when you
(re)post the patches.

>  include/linux/args.h      |   6 +-
>  include/linux/lsm_count.h | 128 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 131 insertions(+), 3 deletions(-)
>  create mode 100644 include/linux/lsm_count.h

--=20
paul-moore.com

