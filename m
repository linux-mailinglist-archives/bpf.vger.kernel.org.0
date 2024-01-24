Return-Path: <bpf+bounces-20156-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF11839E27
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 02:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C225FB28F8A
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 01:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B16C15BE;
	Wed, 24 Jan 2024 01:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NrX5U5jF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200361854;
	Wed, 24 Jan 2024 01:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706059150; cv=none; b=DHiJCG5tL44ROcA16DLaGT6GhkAdoJuFA3R4d+LCWFBDAKnw4ZY4y+XcpPcYk9dMfh9YWQgDXy4n35UvMk5kR7EoI4+QbZu4QmMyA9il0K9dG5/xpJnDSeIrvxQXW99gcbiGyrzCw1qeLOMXu5j1S+n1YyvMvHI8pBVGzwfE7go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706059150; c=relaxed/simple;
	bh=Rpc6VlcDnbMQpnlT7dJ8ZpIzB0df2U5hyEPssDpp8mg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X0BgTsogGLgS6/4umELRvocURBQqdso1Ae1mUiKJO5NB71XLntYajD4dXVgYY0VwDtlNdad0lCRPpWAN5dxNmpsgC1LvEEvYgsmLp0lWe+ZjA1wzlJA6XGJitlk9pYYn0S7VmyI7ZYeViS1v3t6KuvWOv4gX6HLxmB7wmoqOUQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NrX5U5jF; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-337d32cd9c1so4338977f8f.2;
        Tue, 23 Jan 2024 17:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706059147; x=1706663947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=23BMZPjmseE+NnJTiX5FEz+NfeKzQZWgWoSkE38xO34=;
        b=NrX5U5jF0H424NTgPrVBbHA5AmxqZ1G/nk+r6Ml9vql4O1MQfb5OrKdf0ecd7ErkP1
         Gae+1NjQLiRL4uyr0d7C9F2+IerLY4U/GbmT3QE4SG8wtFG40/BQiKRC07dNASznxAR+
         e4zGvUSczYrEl++Rd5mzR03BmWG4bscrAWEViMsHwB7WnSV/5pVXX/VZQiTeZ8NXxInE
         PPP2OVQ07KvpvJPzIo9l2zzcI1QuD8yEr6PspeNgjeC4ciXE5KNRcF/NXA8+e7k7za4K
         bCxIMOH/0xRTuC3U+oVEGRLpn9eMATZVih6xh+MIsllWZPTGaOfTTdcdUIsoPm83xMAv
         u03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706059147; x=1706663947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=23BMZPjmseE+NnJTiX5FEz+NfeKzQZWgWoSkE38xO34=;
        b=VWCudeZgchJWvjAgFUKJAHKzVWbXRPoAOkhFBp1sLlAxoai0W0J/B4oKjAMh7vVLj9
         HiTJgrFPbF+DelusXKsuJskb5T8p9GSOA4JmpHHaY+8i1ejrZMy9Xp+qdilJKtiES758
         blvb7sE5J2ZJftCVSxXHj00Yx9nzIqNr+EzPXmt2rNn3ig1ErNORSUroNvXBY2uf9ZKz
         29j2x7TUYnljEe7on4jYsEp7+FLBcCMZXFzCLpGIiYi+SfIQek70ci4jtYylFcys6FTA
         XtQMxo0+0pDiEXqI8V1mOoDE/JW0vVmasvMCdOM+LYNov/vNVXZyARpXZAdWcxz8oFtY
         jUzQ==
X-Gm-Message-State: AOJu0YwRdkXP1qIEyx5C0Z4Fq/9U1tY4zkGwJ0Q19ZFf0QUnhaosCZqh
	yXZgzQs4U+8ZKeWBbBrk4csy/1XOjE1kiUoOHUPFuBwCYmJPFxc+V59k79LZEp3c9y4ZGcaCMst
	gihHcQ8p/Sodlr0aIm9slxx7jJPf8LBMp
X-Google-Smtp-Source: AGHT+IFkQ3AUOOGgAw7byHYXU4wQvww+xPLx5fYGaP+kl3qDZhA7tHFM2gAlqvC3Xf+bEcEgD1bJ/300g3D++n4w1gY=
X-Received: by 2002:adf:f348:0:b0:339:30fd:cbb5 with SMTP id
 e8-20020adff348000000b0033930fdcbb5mr34670wrp.109.1706059146980; Tue, 23 Jan
 2024 17:19:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124121605.1c4cc5bc@canb.auug.org.au>
In-Reply-To: <20240124121605.1c4cc5bc@canb.auug.org.au>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 23 Jan 2024 17:18:55 -0800
Message-ID: <CAADnVQKBCpkwx1HVaNy1wmHqVrekgkd4LEZm9UzqOkOBniTOyw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the bpf-next tree with the mm tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 5:16=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the bpf-next tree got a conflict in:
>
>   tools/testing/selftests/bpf/README.rst
>
> between commit:
>
>   0d57063bef1b ("selftests/bpf: update LLVM Phabricator links")
>
> from the mm-nonmm-unstable branch of the mm tree and commit:
>
>   f067074bafd5 ("selftests/bpf: Update LLVM Phabricator links")
>
> from the bpf-next tree.

Andrew,
please drop the bpf related commit from your tree.

Thanks

