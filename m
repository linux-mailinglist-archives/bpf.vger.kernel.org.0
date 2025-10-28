Return-Path: <bpf+bounces-72652-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE56C17671
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 00:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D29261C61726
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 23:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6083090CB;
	Tue, 28 Oct 2025 23:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UkzEfhND"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC56F30595D
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 23:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761695478; cv=none; b=YPsOa831z1QFyq+lavQfSrpAq+atKPiXHgiGe0iylDtcBaZvUabfMjZDTs6SvePkAN6PfVNDWdjEUSQVUpmrv/0XcfT/OYTnsft7IAylYwWA9mzue1U6O2AoYKKapHq56aItX+zKiJWZR/lW4Nsqizuil3p29w2qtVrmZjQW4/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761695478; c=relaxed/simple;
	bh=zhqXyFTzb2t3B9Dp9QKvidvf264lh5WpAlH4hAvSPD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rj2HgrXX3ItGbpqTR5RnzpD0byYdAq05TDuRAfjrsroQ4DBTgXes2iRJPIARS6A8TaRbL0nICuSnMNldWdxpM8Au62lJKSfGdemQlEpdrDuBxyX3He1KqCpGYtczWulcoexYS41IwlMVqyADZRPblqItv33g7Tp42MSmDSbnQkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UkzEfhND; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b6271ea3a6fso4511654a12.0
        for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 16:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1761695476; x=1762300276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ss0xsZDTL1rwOqKY2yzsfuodL2zhm4Ktw8Z3rrAQsGY=;
        b=UkzEfhNDOI4hVT+WamU8fqMGB9FrUvGfuKcSbaHvegckZ9zP6y4Yrwst354JzTjOSk
         Lbgt9QCNkK7CQgDSn1+jxRQYIBcTf+EVKx1aM3Zun67d9BQSwqqoD4HxamTemJF1n/a+
         8tgy/mxiAldyfChZ/2Iev9s0dJYrsSxMQAeBCt8TrAXpBH1UQ5W8HAV1YcAlHyoJj3ZM
         RblBbdWQynfmkfk30BNCmizTbP9Ge7zKdNkDCDVgRDXE3VXdIg30YK5Bm9t2HsiyD3pK
         I4tESZAcyPyuymA6GNWnrDilZruHGQn1KDwSWmjDA3XKjgWoS28+Leso/Vihl0HsiG13
         JgOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761695476; x=1762300276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ss0xsZDTL1rwOqKY2yzsfuodL2zhm4Ktw8Z3rrAQsGY=;
        b=slzTo+dJm5Q5PP6S73tDU7s61jb10P9wkA1X/U343Bs9wW3gx1o31r3IVTnJUwCXnc
         yMv2IiFUuRJu0MHi2IBAIyLADEUiuhUfgJYYcVkzbAHfsSXDQkuTaPjlX0GRuItCgiOC
         sIGY9BQSHOYTAylSmm7Mc4NJ1XEhUjj7cNgqoHwqYDxUhzm6JF4ssqDwIfr3BU42Hrqu
         n5jwq/invpXtXuUDaDFCE46LoVwTZf3ia7vbTZmt7j2VRWbJWj6ct3h7dyOxyOYTQ2Zi
         sCXmcawDAaYtbqzsRGvH2MvCbzFlJQ+y11SovIL6tY5DpOHi1BtmrkT34CO6PSe/Nr9f
         zBIg==
X-Forwarded-Encrypted: i=1; AJvYcCWwYq4kE2hqWdr2uu4PcDrS7lrMpJs5CE/DHqzdMDoYFve64n+saKA0X+LW4dp2g8o01so=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQNZ/0zq1FHuzEEXaIf6joGJU4ut6cSGW32e2aIkhd55hYEqj1
	dW5WiFbx/wPj1UFj+d8ijxiFsOGd5LipqGa5NMXKxTlXcU9AgODXdHEQZNyyHXykwN1u0RXADDm
	WpBFRCQ/iSck4Ur1Nmj5ZE1ZG9TvKfyIeyO4jOUkY
X-Gm-Gg: ASbGncvLQ2jISCmHq+fZdDqeMGzwaKJMhueWBjKZc5frduRC6j/Dm8xGHfQIdhuagXb
	NXHlLGhT9b6Ft/3p998HnFknRLKtNWjP2DafM2i7OHLQmHEPaV7578USSP0fU+nfA8jAjqmRK1T
	BW+MPgU/WtXEft+4WoG6c1L4XV8oazJwA3t/KSZAgRM+DQZbUxrW0ALQjI1n3BaN89hW6JXOvva
	6y8pCdpUps+xcsQygYW+htZRwWQeNfepUkknS6lycJdofxOa5606JL08Oai
X-Google-Smtp-Source: AGHT+IEQNyH4/UIhryBKstXm8OFaWiuLlbUq8UQcH5+4F6rsLQi06Pj91sWwNLFBJTsNKL1LL+PFGKuePdALOMKBWdA=
X-Received: by 2002:a17:903:32c1:b0:267:99bf:6724 with SMTP id
 d9443c01a7336-294deebc1a4mr13124835ad.31.1761695475463; Tue, 28 Oct 2025
 16:51:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk> <20251028004614.393374-35-viro@zeniv.linux.org.uk>
In-Reply-To: <20251028004614.393374-35-viro@zeniv.linux.org.uk>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 28 Oct 2025 19:51:04 -0400
X-Gm-Features: AWmQ_bn3uluZWrDfxLWehWBukesK9g25bn5Thq9tyHBU2hJYs5NTI3fvunVput8
Message-ID: <CAHC9VhRa011jL86779TBk8FK-pcWinLkSkQ1MoxGyyfJg5SMgA@mail.gmail.com>
Subject: Re: [PATCH v2 34/50] selinuxfs: new helper for attaching files to tree
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	brauner@kernel.org, jack@suse.cz, raven@themaw.net, miklos@szeredi.hu, 
	neil@brown.name, a.hindborg@kernel.org, linux-mm@kvack.org, 
	linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, kees@kernel.org, 
	rostedt@goodmis.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, 
	borntraeger@linux.ibm.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 8:46=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> allocating dentry after the inode has been set up reduces the amount
> of boilerplate - "attach this inode under that name and this parent
> or drop inode in case of failure" simplifies quite a few places.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  security/selinux/selinuxfs.c | 160 +++++++++++++++--------------------
>  1 file changed, 66 insertions(+), 94 deletions(-)

Looks fine to me, thanks Al.  If for some reason the rest of the
patchset doesn't go anywhere, let me know and I can take this patch;
it seems like a nice improvement independent of the rest.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com

