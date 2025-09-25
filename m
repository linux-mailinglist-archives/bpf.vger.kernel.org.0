Return-Path: <bpf+bounces-69652-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCFCB9CEA1
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 02:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE8CF19C7083
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 00:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB052D24BF;
	Thu, 25 Sep 2025 00:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bml3NIEv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2682D2488
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 00:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758761078; cv=none; b=MSYbI9WYVcUD6h3hxSTjLWckVrAphYVRpY8BHKt/gNLkGDMor8DdwDnlgMzO7cZ1lFKCuNQGTbfg+oliPkw4wf1d3Uu9HyPAq6X22jbCInOrU2AjpnFIXxxmOGYv2SA//lXXx4bwF0dQGRReTuCknRmXmK6Os0WYdS4MSF6C2s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758761078; c=relaxed/simple;
	bh=Z0Pgw6DbrPIEypZdEpibIJwSO2DkG0IXdkqXmO5fy8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W7asb19k5d1o22lyyNZ72Flo6G3lJdHrmmqbj7FVBryUopKYYIcIpkVbUhSOCYBBJW1oB56depxnVOAldJG9OFdbplTHESfVLp/adjaZr8q7eELhpIWEOdKQB/WtLvPP5M3F1I3NDm/84l6RVPefIZHJWGojnwobbMg4APg4mcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bml3NIEv; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-ea5c8833b15so421758276.1
        for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 17:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758761075; x=1759365875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GcKD6S8aofw7oAZ7c/lGRvBhYoMYKXS1JxMh/VvXmb8=;
        b=bml3NIEvJnBUIc1kJP3wAHKc2crVTgmqvDmNcNIDP0z6nIz2Q0Lp16At5CiO1wbVCk
         GKvhIQ1mttG0wgzlw4CqIc6+bJdL1VbyUP1fB3ZRqwdKYcl1ozttbW5ki2DfAFrL/8nf
         3h9Ewp6WUe0kTPWGnwtpjpcOCD0KISH49CItnFKo8wA6BhWT4CMPxdyysUElmleGad5l
         gh0z4wzM7VrZDmn+JZoGROUK3ny0iN7TZQc+dSbeA/Z9imvlcMBUD26XP7cdf9UoQ3NN
         75ztNgSpSU1S5+AaENLN/ynq8LIEhi9dzJKjVPYq4w5HPI1NKRw5b2AmsCsbg/tJ5jW2
         DikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758761075; x=1759365875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GcKD6S8aofw7oAZ7c/lGRvBhYoMYKXS1JxMh/VvXmb8=;
        b=TgKZTQbKT/2mF3plGR6rPkxUDyzLei0RuOJIMjBNfjqUj/Bi6BRJLQBZTCAcJywAGz
         0/HeLIrNAxEBuqBMg1tupAeKDWO6H4uxdoxwd/LEDCAmT/VgVo6SfcWr6gDheHRdpma9
         fPk8Hbwrzw2dBx4mei2pnKT8EyNpqMhR7EVB1SqFhUTr29xb5+myVXghR37gfYYtIHjU
         qHUnr/XKtPjYeMlEyQXbpCvp6g31ZaQdh3WLdSHv+pZGZT6xHIHQ9Q67AjiCDazVvSop
         I35M595kckB9kMuekos4EkyD3wY2HJjEJOGLIUeqR78onUkPCgavv4Xmh7p39KMaAhgt
         rBgg==
X-Gm-Message-State: AOJu0YyF5aBNR0XPTe6Ft2I8wFcojzGui+IofrHDtq9N+Mmwe30Prqf1
	JnIZtR0v45WQJqOvjnC6kI/u257Sic/nWkxD4m3yemYEa6DDBczWepLyjvsigUZRwUhBLIVS00k
	imF5qZ8R2ZMT1xkEotN8QhLlTXTWla2Q=
X-Gm-Gg: ASbGnctzIthiqnYejBGlbatRU4pw7cLUWpNFDC8+R2/K8Pg5eW58jKy991Fl1gJmmLs
	Vcsb5+vbeikAyGD6XS9+lvxq4Cv5l14uoPAoncwbLU7bXR3k0H3/aRUJksmxziTf7skv8mZrfQ3
	ayD7J804hHOPifPoXZwhpQdI6WgG1clofshVQuUfn41fg5aZgqi1KxiAzfLneiu6gQ8zx5mZIT9
	wthQncoxpsE1/IeHYt9ikb18Bsxt5OgKYz4Ud5G
X-Google-Smtp-Source: AGHT+IGPwxcmJ/F6M0fbyKlAHdtkVJzcZ/qUm1JE2dAlPJ4gk/LYmTsQfbIlGUshB10dV/BSdFi3LAjUox3NSPOyQ5w=
X-Received: by 2002:a05:6902:4202:b0:eac:cf24:889f with SMTP id
 3f1490d57ef6-eb37fcd8e89mr1355391276.53.1758761075589; Wed, 24 Sep 2025
 17:44:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924232434.74761-1-dwindsor@gmail.com> <20250924232434.74761-2-dwindsor@gmail.com>
 <20250924235518.GW39973@ZenIV> <CAEXv5_jveHxe9sT3BcQAuXEVjrXqiRpMvi6qyRv32oHXOq4M7g@mail.gmail.com>
 <20250925002901.GX39973@ZenIV>
In-Reply-To: <20250925002901.GX39973@ZenIV>
From: David Windsor <dwindsor@gmail.com>
Date: Wed, 24 Sep 2025 20:44:24 -0400
X-Gm-Features: AS18NWDXSuhO3uVQGoOdQ6qrAvEolUwAeJHd3mMcBA5ENzzIzHCfFsixbO1o2UI
Message-ID: <CAEXv5_hEXggxe5EwSHV8SK21e6HNmfYFSE9kx=ojwEobtTTGLA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add dentry kfuncs for BPF LSM programs
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, kpsingh@kernel.org, 
	john.fastabend@gmail.com, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 8:29=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Wed, Sep 24, 2025 at 08:08:03PM -0400, David Windsor wrote:
> > On Wed, Sep 24, 2025 at 7:55=E2=80=AFPM Al Viro <viro@zeniv.linux.org.u=
k> wrote:
> > >
> > > On Wed, Sep 24, 2025 at 07:24:33PM -0400, David Windsor wrote:
> > > > Add six new BPF kfuncs that enable BPF LSM programs to safely inter=
act
> > > > with dentry objects:
> > > >
> > > > - bpf_dget(): Acquire reference on dentry
> > > > - bpf_dput(): Release reference on dentry
> > > > - bpf_dget_parent(): Get referenced parent dentry
> > > > - bpf_d_find_alias(): Find referenced alias dentry for inode
> > > > - bpf_file_dentry(): Get dentry from file
> > > > - bpf_file_vfsmount(): Get vfsmount from file
> > > >
> > > > All kfuncs are currently restricted to BPF_PROG_TYPE_LSM programs.
> > >
> > > You have an interesting definition of safety.
> > >
> > > We are *NOT* letting random out-of-tree code play around with the
> > > lifetime rules for core objects.
> > >
> >
> > File references are already exposed to bpf (bpf_get_task_exe_file,
> > bpf_put_file) with the same KF_ACQUIRE|KF_RELEASE semantics. These
> > follow the same pattern and are also LSM-only.
>
> You can safely clone and retain file references.  You can't do that
> to dentries unless you are guaranteed an active reference to superblock
> to stay around for as long as you are retaining those.  Note that
> LSM hooks might be called with ->s_umount held by caller, so the locking
> environment for superblocks depends upon the hook in question.

Yeah good point about ->s_umount, why don't we just create a new "safe
dentry hooks" BTF ID set and restrict this to those and filter in
bpf_fs_kfuncs_filter, where there's existing filtering going on
anyway?

