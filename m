Return-Path: <bpf+bounces-72375-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DF763C117FD
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 22:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6051B4F53F7
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 21:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630BD328622;
	Mon, 27 Oct 2025 21:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RMgmYanv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1507D328B44
	for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 21:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761599632; cv=none; b=H7dLPAM+k1FQHpJMgGIHhHIKoZd08GnqxNBjgsCusJYh0qnPVVeaTrw/rfaWXHYJH9FXNoIgP9hsBF5Uoi5JBv21m6uqI6A/DEP6v1DAEZUTcj0YfQGRqCSXtXNYoOyOhZi41uFkAC1obPZicpem4MGK0j6OEvkE/Zs+Kh7RAc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761599632; c=relaxed/simple;
	bh=4EweoHeGLGjUekzAwEp/mlNRn2hhfYJFvwlGhd4n4o4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a4yTMPOmk9pYWgOfCKWHV4BjPDyTJelSsPwgPdJnEdTF6AhzuCzWAICjQ/k/d70/tssfNOQcjHtPgYPKS7PCWg79h1Jc7QEI4sHlwjjbyC+N6keR+l0yz0enuaGXA8punw5wRSp37XyDdtt3yAdXrgrG7qWhUmrEYjYpvOxAQUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RMgmYanv; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b593def09e3so3134370a12.2
        for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 14:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1761599630; x=1762204430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1jrVXvo1sxS+kkD4SiBb2KgPCsJAsQQlPep2kWwdt0Y=;
        b=RMgmYanvHEyCPMxFVECnC+ybax57zDdptmZCtkTu9ss7NzCCmSHn48dtPY1CkmI3lO
         OH8snjWMadQQWTN5ICUm0Yx7lI3p7Aq5+O4DppWrEoKOMzt2UmimOu91kHCNX/Dwf79L
         Ei1fjLIqd8DWj83fkGjNFArKXHr50NfvPuWeEkxOa4xf2NGqyH2s9moSymaPwcmwA5mc
         TBry2k11ac7rG9C+SkqOezYe4v4LAMMNQjCyMFzHk34i6HCouAnrmd4Dyf8ZptvFEPGy
         SAMZ0vZpmJck9Sx8IOMrD6G1XwcFAwZrVp6sbequUTXVIgaIFocE/doEvYDb6J2VL+HM
         4GJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761599630; x=1762204430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1jrVXvo1sxS+kkD4SiBb2KgPCsJAsQQlPep2kWwdt0Y=;
        b=eOkYSNf93YA8yQYg7MDloEiUAFbMTWbya2PvvUjnhRgyorp3EK2QT/VOkaUo0lreHe
         j23k9LLU4wc33o6SdD7Jw1GW+4fwY1RqZCpvDy6IhKoUBpG99AuIY1qWpwf8jcSwuj5v
         0krE44HvfYqdj4CygSEueaChsMjLb0+dzRH76DwBs47bTb0iiwIE5K6AhPMvbXpnNA8b
         idcB4gsNOOs9jZYhvJRGW/86PAr3XUMnhsj9DkBihkKy4ZX1m+pMCKiGDnAA4rT/Wtdd
         68hxNMfjZxQgpUkqfA7ONP/ST5lYWdt/bbMt33McRVkIxlKwCaLUxyIiAK8moVlMlKJB
         sVkA==
X-Gm-Message-State: AOJu0YxqQ/+HmXW6MdHO0+dIjO3PdWLjEB3Lq1MR634KEcf7P6AHz1M6
	D2Ll+SuVNY7fDRfDrm60ZPr/MjNt3XsqX5WKbpeVzvBBvJehuaYrfsGyxlsOJm+bqUOSVBrwJBg
	i/r1+EcUWidjSCsmx9abU1AyLhor1i09BcJSQL+zL
X-Gm-Gg: ASbGnctCcOSPL9NodI0pc1yJak0tGu941xIOFXeru67lEzPqHZM97j9mSbA0Cm7wpzK
	kDNbdUwxCJKhhMZ/+s2mMH9KWPl/3HAnfuizTh4ykXFyhBnJ4xAxWk6uczxKGAZdXvfRHiBejVn
	lteGOLuGIBpbyn2uw7Q98v3CPTz93mXRsjQ2OGyx5D0Vp+1bAN/ko0acPX7q97t7xHUGAGNXTpT
	S68g+yN5FK8McXxpzLTN+00DIctWe3gkJdE8JnKqP68uOhxlwUfL13BxSpnIqo8i7qSPmThaWdp
	2DyQMw==
X-Google-Smtp-Source: AGHT+IEwaQ9u7CDQcWu0C61kO6NbEn+57lxKy7x1+QqIy435OFjjlqJSAAMqjBFL4hOzhA13sQ/5CCGEn1QvdUhFskA=
X-Received: by 2002:a17:903:32c9:b0:267:44e6:11b3 with SMTP id
 d9443c01a7336-294cb500981mr13977335ad.45.1761599630068; Mon, 27 Oct 2025
 14:13:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251025001022.1707437-1-song@kernel.org>
In-Reply-To: <20251025001022.1707437-1-song@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 27 Oct 2025 17:13:38 -0400
X-Gm-Features: AWmQ_bmI3jMDm7ZEMCwy3hCYNaQKhc6ZPkcP0O-rsrnQwkrNmYQ0qY0p4ovzgaI
Message-ID: <CAHC9VhTb2p3DL_knRgFyDv396BwH-KhwR0cBhqLQ-KdgcA1yLw@mail.gmail.com>
Subject: Re: [RFC bpf-next] lsm: bpf: Remove lsm_prop_bpf
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com, 
	kpsingh@kernel.org, mattbobrowski@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, john.johansen@canonical.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 8:10=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> lsm_prop_bpf is not used in any code. Remove it.
>
> Signed-off-by: Song Liu <song@kernel.org>
>
> ---
>
> Or did I miss any user of it?
> ---
>  include/linux/lsm/bpf.h  | 16 ----------------
>  include/linux/security.h |  2 --
>  2 files changed, 18 deletions(-)
>  delete mode 100644 include/linux/lsm/bpf.h

You probably didn't miss any direct reference to lsm_prop_bpf, but the
data type you really should look for when deciding on this is
lsm_prop.  There are a number of LSM hooks that operate on a lsm_prop
struct instead of secid tokens, and without a lsm_prop_bpf
struct/field in the lsm_prop struct a BPF LSM will be limited compared
to other LSMs.  Perhaps that limitation is okay, but it is something
that should be discussed; I see you've added KP to the To/CC line, I
would want to see an ACK from him before I merge anything removing
lsm_prop_bpf.

I haven't checked to see if the LSM hooks associated with a lsm_prop
struct are currently allowed for a BPF LSM, but I would expect a patch
removing the lsm_prop_bpf struct/field to also disable those LSM hooks
for BPF LSM use.

--=20
paul-moore.com

