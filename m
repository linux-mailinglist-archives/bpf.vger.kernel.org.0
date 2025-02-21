Return-Path: <bpf+bounces-52151-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A255BA3EC12
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 06:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6759017BE59
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 05:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3901E0DBA;
	Fri, 21 Feb 2025 05:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCVkHSAU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9648F6E
	for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 05:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740114381; cv=none; b=qRMyct0+C+bqCx8g3Ut9pajmvyMZl/Fqr7lvLLZxobau6sGTWp4QDLgtbfrXes+/hLz1YTRWEE+K2TuwCm4m6W4aKbz+/HsUqqCLsk1kzoUUIgW7shJLS2dTyeoMr3DEgbsr77yN8huyvWEQMN4/VyuLSKCyyhZ5+9Mk/0nHcZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740114381; c=relaxed/simple;
	bh=ceDhQXYf7Z5UDsIVMDKQrtGWzQe4qgJqXm3HmvE8zwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FO4QPF3VOEAV5bByRpUl9KD7rDcNHevy545u110/bKUjL7Dym+s/zna8rpResXSbrYZBAVHHFtDN382RpwhShPpZ5fT+isB6XoCIQocTHVDhYjTgOhX8YOslbPXOeprQHjGnYTmR00f9K8B9bLGqR4dbkC6JJ/IJQoKx9yZqfaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCVkHSAU; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e53c9035003so1405890276.2
        for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 21:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740114378; x=1740719178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDNr8LITH8ze7YUbFKgnumh2D7qP0YIqaF/0LpONNAA=;
        b=jCVkHSAUj/Eb0i3fjgB154uJmj5zOhhCoip7Oj3+PO4KnhUvrXWy+tpeDf+hahkf6n
         sy5FT9/lodFzStFp+ZWsLG/pzfq6JFUA38xwt7//Qzsoz7uAvdhphWSCY9o+wnLsa1Tf
         vLY4ohzVi7PlRKq5AT7uPkdmEhYsptFxZ5xzrnPJhsdZGq8oB5dB6ucplR0jacC/W0hH
         FEbpNZTlM031oOJdb8FW+usSqWNBhQgIdLzTct755J1DKilS4iFDfm0Xdiu7tOuOXXAt
         zPRmp0Pvcx0M6AXIqf9BKJJLCuL0MzeROcATCR3v9Hav4y6A3MmqbmkfwyvJeWBmjX1r
         hI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740114378; x=1740719178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vDNr8LITH8ze7YUbFKgnumh2D7qP0YIqaF/0LpONNAA=;
        b=tQiZgpGqSqdVQlh4BSyL/hJsdXHOycnGSQ+a0LnB70ZAjIO4MC1cgx5H2vcV4YE6Q/
         mJo0rCSgtBrCQ7Gloq9OWOAG8LWbY28KfMvTiXLA83AuvlLFaucm0wtijIJFCAkwdkbN
         WU1b3LD0r0sKqUBSoLHbcw5tjovdJuhKVPnBrSztYTDUUl9yYmw77ejjhZExQbzsMu9P
         kLY/hRj1ICwdZvvSzYHWuzRSEuibMhSNDhqD+jajgWcnjl+CUEVrUfSFqzmCl5INnNwP
         1kp4ksXgSyuJ4lVvWEeSysJC6f5JcW4gqDQmScXlPm5bSRbOtEn0dj3LlH+I3wKDhsln
         ra0A==
X-Gm-Message-State: AOJu0YxpwSilf6sG1HaHu5dYcjk6GbBVPJ6UFDw12vfLQXTJv8WIDiUe
	QkO+MV9paCr52ELFRyK/LzlB14ruuHR+m8T2bBRkekjPxVSk9Mc48cgfmzHqSF2P8EUuUg9xcp4
	CCZ7tEJDYtTRSUR+YRDkKNUfqs20=
X-Gm-Gg: ASbGncvyDDE8Q8mZsUR+jBXjDrnkEyIZMPR4xACD58PF3YFZFSx1YTrSzdX4FVpfZmE
	dh9dp76hqDIPTwoWmzMg9C8qTgF+9gho+I0BVSNkVc2K5Lgk8C3OHfn1Mvvlfgf9hMTBBmJyRaa
	lJ1gNbJn4=
X-Google-Smtp-Source: AGHT+IF33uulAUWi2uOvNCZKEbj6u4PMuvDmVyshqx26V6nNO5t0k4qcSQANPzKwts/NzUuRNIG0ap/8pPa4hCWpR3I=
X-Received: by 2002:a05:6902:1084:b0:e5e:fdc:b593 with SMTP id
 3f1490d57ef6-e5e245e997bmr1854839276.13.1740114378299; Thu, 20 Feb 2025
 21:06:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220212532.783859-1-ameryhung@gmail.com> <20250220212532.783859-2-ameryhung@gmail.com>
 <e83d842e9f6c5cb6f98fd8cb760ec1c8e17e419a.camel@gmail.com>
 <CAMB2axNXpctJ8M9VgWJPFWKsMGt-u1cnt_KdXW=wBDNi6npBiA@mail.gmail.com>
 <CAMB2axMjLRNeH=4cm+M5kTKr6b47tOgjCKXVHVXTKbbf6z09TQ@mail.gmail.com> <88897fb139f903b9d0aae3291602d1df35b31ea7.camel@gmail.com>
In-Reply-To: <88897fb139f903b9d0aae3291602d1df35b31ea7.camel@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 20 Feb 2025 21:06:07 -0800
X-Gm-Features: AWEUYZkHXvHj0e2ik_EfmdhkxOiwuFUebIiIZnV5valabNst-gSeAGLXD6T_UJg
Message-ID: <CAMB2axMdFK4cCndpaGR_8nSfe4ypzX35vqW=CysOwTuKndxDsw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Test gen_pro/epilogue that
 generate kfuncs
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	alexei.starovoitov@gmail.com, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 7:02=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2025-02-20 at 17:05 -0800, Amery Hung wrote:
> > On Thu, Feb 20, 2025 at 3:34=E2=80=AFPM Amery Hung <ameryhung@gmail.com=
> wrote:
> > >
> > > On Thu, Feb 20, 2025 at 3:10=E2=80=AFPM Eduard Zingerman <eddyz87@gma=
il.com> wrote:
> > > >
> > > > On Thu, 2025-02-20 at 13:25 -0800, Amery Hung wrote:
> > > >
> > > > [...]
> > > >
> > > > Given that prologue and epilogue generation is already tested,
> > > > it appears that it would be sufficient to add only two tests:
> > > > 'test_kfunc_pro_epilogue' / 'syscall_pro_epilogue'.
> > > > Not sure if testing prologue and epilogue generation separately add=
s
> > > > much value in this context, wdyt?
> > > >
> > >
> > > Agree. I will only keep the syscall_pro_epilogue test.
> > >
> > > > [...]
> > > >
> > > > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > > > index 6c296ff551e0..ddebab05934f 100644
> > > > > --- a/kernel/bpf/btf.c
> > > > > +++ b/kernel/bpf/btf.c
> > > > > @@ -606,6 +606,7 @@ s32 bpf_find_btf_id(const char *name, u32 kin=
d, struct btf **btf_p)
> > > > >       spin_unlock_bh(&btf_idr_lock);
> > > > >       return ret;
> > > > >  }
> > > > > +EXPORT_SYMBOL_GPL(bpf_find_btf_id);
> > > >
> > > > I think this is not necessary, see below.
> > > >
> > > > [...]
> > > >
> > > > > @@ -1410,6 +1493,13 @@ static void st_ops_unreg(void *kdata, stru=
ct bpf_link *link)
> > > > >
> > > > >  static int st_ops_init(struct btf *btf)
> > > > >  {
> > > > > +     struct btf *kfunc_btf;
> > > > > +
> > > > > +     bpf_cgroup_from_id_id =3D bpf_find_btf_id("bpf_cgroup_from_=
id", BTF_KIND_FUNC, &kfunc_btf);
> > > > > +     bpf_cgroup_release_id =3D bpf_find_btf_id("bpf_cgroup_relea=
se", BTF_KIND_FUNC, &kfunc_btf);
> > > >
> > > > Maybe use BTF_ID_LIST for this?
> > > > E.g. BTF_ID_LIST(bpf_testmod_dtor_ids) in this file, or
> > > >      BTF_ID_LIST(special_kfunc_list) in verifier.c?
> > > >
> > > > (Just in case, sorry if you know this already,
> > > >  BTF_ID_LIST declares are set of symbols with special suffix/prefix=
,
> > > >  at build time tools/bpf/resolve_btfids looks for such symbols and =
patches
> > > >  their values to correspond to BTF ids of specified functions and s=
tructures).
> > > >
> > >
> > > Ah yes. It is an artifact when I was testing a patch for generating
> > > kfunc in module btf. But since there is no use case, I removed that
> > > part. I will change it to BTF_ID_LIST. Thanks for catching this.
> > >
> >
> > Actually when I use BTF_ID_LIST with a kernel kfunc, I got the warning
> > below. Since it was not able to resolve the btf id, the test program
> > failed to load as the generated byte code will contain invalid kfunc
> > id.
> >
> >   BTF [M] bpf_testmod.ko
> > WARN: resolve_btfids: unresolved symbol bpf_cgroup_release
> > WARN: resolve_btfids: unresolved symbol bpf_cgroup_from_id
> >   MOD      bpf_testmod.ko
> >
> > I am not familiar with how resolve_btfids work, specifically when
> > building a kernel module. Do you have any suggestions?
>
> Looks like there is no way.
> resolve_btfids is called for module as follows:
>
>   resolve_btfids -b <path-to>/vmlinux bpf_testmod.ko
>
> Where -b specifies base BTF.
> However, the bpf_testmod.ko has .BTF.base section, where distilled BTF
> is stored. In such case tools/bpf/resolve_btfids/main.c:elf_collect()
> overrides base passed from command line, and uses .BTF.base instead.
> However, `bpf_cgroup_release` is not referenced in bpf_testmod.c,
> thus it does not get into distilled BTF. Hence, its id remains unresolved=
.
> And it cannot be referenced in bpf_testmod.c, because it is not an
> exported symbol.

I see. Thanks for the explanation!

>
> So, for this particular case there are only two options: resolve id
> dynamically, as you did, or use a kfunc internal to this module
> instead (which should simplify the test, imo).
>

Currently, generating module kfunc in pro/epilogue is not supported
due to the complication in resolving insn->off of the kfunc call. I
have one patch that test how it can work. But after some discussion
with Martin, we think we can revisit it when there is a struct_ops
module that wants to do so. I will keep the current dynamic btf id
resolution in the next respin over using module kfunc unless people
think we should support it now.


> The broader question if want a capability to use BTF_ID_LIST referring
> to kernel functions from modules remains open.
>
> [...]
>

