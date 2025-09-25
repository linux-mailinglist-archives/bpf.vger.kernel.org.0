Return-Path: <bpf+bounces-69654-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1461EB9CF68
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 02:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 504C232875F
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 00:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965182D8DB0;
	Thu, 25 Sep 2025 00:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmnOFBKE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D822D7DE6
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 00:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758761782; cv=none; b=S+dIoEaVbr/kIfANudV1FdKweM4vmAmWwR58YuuZHU0G8dBXgtKwdBLV8Fb4GtXrdJKOiwKIY361bYUDzS1ORZ2SKfFMSYPbrcIvw/AUVCx5GCybg2ZkfAVTcqrSQB++Z3MNZJ0mN0ydRABAXaI0iAF4kSzJ6HGCGF+og3r/zOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758761782; c=relaxed/simple;
	bh=mX6INriWejRKeV/G//8ic0/tfI0+R32fXWg4I9UX+TA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sa2WrGXTv6voHD1RiFqxCH3Z6uNwemlYa3Au4NFq1fXvmJRmArU4a78LT/WPuqfuTBHex2qR5QB3U8d7yWZKz86VrV9lYv5NMLNj++gxLPItyqmHowKzkOXyARHZDmRtnVqTRglYoTZl9MVhyuVqVDE1nJr9F1bojrhOs8i4n6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LmnOFBKE; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-ea3dbcc5410so351208276.2
        for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 17:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758761779; x=1759366579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6OaoaSI0ufd97cnRnxkA92AvR8C6GxXblYJSwWrjko=;
        b=LmnOFBKEA2SHSga2Gy8MaR2oHrQEmEVPbUKEzayfY/66r1y4oy7G+MGdU2MVW8uYqb
         uPb0pdgJv+Vv/5VoRByLALvXim6cRx0IpDDZGJFQWBfKlV/XYyNyM/5/1xYEoyhIGo3+
         pGbF7Fftyi99OG+bhfZRH2pTUcBZ6mY685RYyTgJSKsH7KWce8NQhKHUOJFnVGycY5j7
         y+JfRNdGow++nThfp8sshkPlBmeYoPIQJfSTK8fhH4qytoeOUYLa19EuaDO90DWJuwWg
         XPxhcm9XAKFbjLg60EFSxfwE0cOU1rHm0b4/KhMVLi1bSrTkl2wBhfUbEyKLCp6Z+vXB
         BJ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758761779; x=1759366579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q6OaoaSI0ufd97cnRnxkA92AvR8C6GxXblYJSwWrjko=;
        b=kkl2RtAEGeQxkHhDTHC2HDleA+8MLnGhjrZQkWx7+LdOMjqlrk2y4iYkVfqMBWCnnT
         TW+s9CCYhp9Gdss/8453//EVgo0QXxxWN6VJBO/fEV3q4wwOIHw8zgvRFvWdMWEPCfpc
         91XyWv1v5+q9Vvoo2nVRWm3IUQ/sHRaqwmJMHgRUSEs4btxJBHRXuig7w7uSYh8sgQeq
         16dokiywkUyNytIDLhUZeShHJ/GO36sbT6Ofby4fO+Rfov9Md5TSzW++RshC2z/BmOww
         wh9JeADc5a/gTLjKRgcwfof/lW7XzSjplmlqxDGLQ60pPtC6bmdLTPfut/FwaUHFOzij
         UAFA==
X-Gm-Message-State: AOJu0YzxlDQWqzCe7uWNL2SqPm8awslg3FFP+O2VXvuSmeBuBK61jWD7
	fXBTlfbtpmWQNxCfykGQ8GoaQoKh2ntt+DwOnbEbfgB0Z1AHPWJB9J9+AqMc3LoNXYnRBBa3/xU
	f9edGoA1z4G2zGY8UEAv064SjSpL0Tm8=
X-Gm-Gg: ASbGncsm1kBRAW3Idky+fDJ5Nuwnyu5bryNmFfOnExjEI+JizsbS2aPZJpta/Xd/6cL
	IjEMhlzkRHpc+kayYtRL9pDX2BiwSBDXzoYt5G2apNwd0+LZh5OAdYAfi2VaftR1eKZdd8VDpyJ
	PRs688PgQCc/OWdryt5TD6cu5u5n7G2ViGVgH28ZxviYjHB0x/lXvdQLypuXRCIjBAa7g6qheHh
	ORilkjPfpuSZalk5oMnvj3s8dtD5UYcPu7eQl27
X-Google-Smtp-Source: AGHT+IFgcRPcyol1t+usjIzlNyHAv8M4r+C+ZOx7LYDKRxogbF8wDH5IwaTwpGDQgVRTX3xqCI3pTJJ60ACg9S/p7Yg=
X-Received: by 2002:a05:6902:2089:b0:eae:987a:1e32 with SMTP id
 3f1490d57ef6-eb37fbfc092mr1795120276.16.1758761779385; Wed, 24 Sep 2025
 17:56:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924232434.74761-1-dwindsor@gmail.com> <20250924232434.74761-2-dwindsor@gmail.com>
 <20250924235518.GW39973@ZenIV> <CAEXv5_jveHxe9sT3BcQAuXEVjrXqiRpMvi6qyRv32oHXOq4M7g@mail.gmail.com>
 <20250925002901.GX39973@ZenIV> <CAEXv5_hEXggxe5EwSHV8SK21e6HNmfYFSE9kx=ojwEobtTTGLA@mail.gmail.com>
 <20250925004725.GY39973@ZenIV>
In-Reply-To: <20250925004725.GY39973@ZenIV>
From: David Windsor <dwindsor@gmail.com>
Date: Wed, 24 Sep 2025 20:56:08 -0400
X-Gm-Features: AS18NWBw4o9R2McXNk54g7ZfUjE76HZ6zEiUz3X5_jWTBum_bwxA5JL2dug5JMs
Message-ID: <CAEXv5_hD_4ON3MVBa7+gpapQs+Vkvo6Ln+BKT+Qz_S7x+Up6hg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add dentry kfuncs for BPF LSM programs
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, kpsingh@kernel.org, 
	john.fastabend@gmail.com, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 8:47=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Wed, Sep 24, 2025 at 08:44:24PM -0400, David Windsor wrote:
>
> > > You can safely clone and retain file references.  You can't do that
> > > to dentries unless you are guaranteed an active reference to superblo=
ck
> > > to stay around for as long as you are retaining those.  Note that
> > > LSM hooks might be called with ->s_umount held by caller, so the lock=
ing
> > > environment for superblocks depends upon the hook in question.
> >
> > Yeah good point about ->s_umount, why don't we just create a new "safe
> > dentry hooks" BTF ID set and restrict this to those and filter in
> > bpf_fs_kfuncs_filter, where there's existing filtering going on
> > anyway?
>
> Again, you can't just call dget(), stash the reference into a map and mov=
e
> on.  That's asking for UAF.

These can't be stored in a map (guaranteed by verifier during addr leak che=
cks)

