Return-Path: <bpf+bounces-72382-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CCEC11DEE
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 23:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8E78734CEB3
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 22:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78992E6127;
	Mon, 27 Oct 2025 22:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qzIe9YG6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DAD2F5473
	for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 22:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761605131; cv=none; b=qjJIX554TFwtq1OP7LN33MVBI6ySoblqnP9naKmMSM7HQGXGe1Er9cNE/E7haCbvJdrGKfpmEZzTZKveyvWSL1URKR8cci0wmKJrtEqgImZeS/vsuXl7CgeE7HAPi61DflrYcQ9qS4DC28bx1DKb2WRYNU3dmt21e280Nfj/VGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761605131; c=relaxed/simple;
	bh=MzekvaBxqzCTIOaqmW2QGZ9OLZMQ5s6TtJvJNVKtffA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hn0p5TcnFLg66h6ziv0hmXPagZE2X8uIZQR+MElx3pEJ81GaHL6cB9il2ma/8odkBhVucjFRCNQ92MuJB+tEAOBKamH+RR/HToWvCHWT7TKwFfVXUN2C601XlnULYe9er0MxtjVpmraNS9tGayLkHQcnMy6vwIho7HBCOv5YRHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qzIe9YG6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F664C19421
	for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 22:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761605131;
	bh=MzekvaBxqzCTIOaqmW2QGZ9OLZMQ5s6TtJvJNVKtffA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qzIe9YG6i1b2MC+6IPWBqa6IWADt/354RwLaj6Czyf/NYdQar1Jt4I8RVwfLxHonR
	 xtQC+LO1vJAtU53m8oIsvnWKcbWYrFScdKgvarhSdMGzpNikYMOZ82/Qdbvpt+74gH
	 zMKnuZXFjxwklIliNKybJntjTuahqSwPwHQcLrY5R3HzC2/hDpa7z+rColGZDE6EXk
	 klQXuHyHBZQyjKBEGF1tDZf8pjegpHPtDqtkBpSdhFHKrey4WH+MxtmxSnsLffRDsi
	 caD5c+Ev5vln/7n7jQPv/JhSQq+pH/0GPEjZr5Q4EoWpYu9XDo3+HE8sscXk9giD2K
	 p9ktKcYqkB9qw==
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4eba313770dso28992491cf.3
        for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 15:45:31 -0700 (PDT)
X-Gm-Message-State: AOJu0YwhRnaLjcxO3Em57t67yPvmby/08x6Vq4RkTkkTii6LqVMxum51
	cg2ng9CtQt6Aw8pd1SvZiQAiRSeL4ERYOxGi9h+JWXm07OEMVDfj3O4VHpa5aEhvMzCNK/m1Yal
	N3R+A2THOzVqsVgI7X2hngB5h9+qFQAE=
X-Google-Smtp-Source: AGHT+IEcX0DwJ6LoYUg47sZ0IcXXgpk9xiTYJdHyAcmsWVhGl1PokArKqBeTkvsuiKfBamYohf+YGYUjKzZgMLppQVA=
X-Received: by 2002:a05:622a:4c0f:b0:4eb:9fad:8b4f with SMTP id
 d75a77b69052e-4ed075eb4famr19479011cf.61.1761605130177; Mon, 27 Oct 2025
 15:45:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251025001022.1707437-1-song@kernel.org> <CAHC9VhTb2p3DL_knRgFyDv396BwH-KhwR0cBhqLQ-KdgcA1yLw@mail.gmail.com>
In-Reply-To: <CAHC9VhTb2p3DL_knRgFyDv396BwH-KhwR0cBhqLQ-KdgcA1yLw@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Mon, 27 Oct 2025 15:45:18 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6O96aJbZptVY754tQ1-C_JtH8PwS1oZX6a1Tch7ehEkg@mail.gmail.com>
X-Gm-Features: AWmQ_bl38fPXDA690MppliPLheSL177BkxdQbbb4ElOx6ChpvbND7oMhlAAAttI
Message-ID: <CAPhsuW6O96aJbZptVY754tQ1-C_JtH8PwS1oZX6a1Tch7ehEkg@mail.gmail.com>
Subject: Re: [RFC bpf-next] lsm: bpf: Remove lsm_prop_bpf
To: Paul Moore <paul@paul-moore.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com, 
	kpsingh@kernel.org, mattbobrowski@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, john.johansen@canonical.com, 
	eparis@redhat.com, audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 2:14=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Fri, Oct 24, 2025 at 8:10=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> >
> > lsm_prop_bpf is not used in any code. Remove it.
> >
> > Signed-off-by: Song Liu <song@kernel.org>
> >
> > ---
> >
> > Or did I miss any user of it?
> > ---
> >  include/linux/lsm/bpf.h  | 16 ----------------
> >  include/linux/security.h |  2 --
> >  2 files changed, 18 deletions(-)
> >  delete mode 100644 include/linux/lsm/bpf.h
>
> You probably didn't miss any direct reference to lsm_prop_bpf, but the
> data type you really should look for when deciding on this is
> lsm_prop.  There are a number of LSM hooks that operate on a lsm_prop
> struct instead of secid tokens, and without a lsm_prop_bpf
> struct/field in the lsm_prop struct a BPF LSM will be limited compared
> to other LSMs.  Perhaps that limitation is okay, but it is something

I think audit is the only user of lsm_prop (via audit_names and
audit_context). For BPF based LSM or audit, I don't think we need
specific lsm_prop. If anything is needed, we can implement it with
task local storage or inode local storage.

CC audit@ and Eric Paris for more comments on audit side.

> that should be discussed; I see you've added KP to the To/CC line, I
> would want to see an ACK from him before I merge anything removing
> lsm_prop_bpf.

Matt Bobrowski is the co-maintainer of BPF LSM. I think we are OK
with his Reviewed-by?

> I haven't checked to see if the LSM hooks associated with a lsm_prop
> struct are currently allowed for a BPF LSM, but I would expect a patch
> removing the lsm_prop_bpf struct/field to also disable those LSM hooks
> for BPF LSM use.

I don't think we need to disable anything here. When lsm_prop was
first introduced in [1], nothing was added to handle BPF.

Thanks,
Song

[1] https://lore.kernel.org/linux-security-module/20241009173222.12219-1-ca=
sey@schaufler-ca.com/

