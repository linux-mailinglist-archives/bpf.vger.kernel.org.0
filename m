Return-Path: <bpf+bounces-66481-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6669B35008
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 02:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 590DA16A4A5
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 00:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E7214A0B5;
	Tue, 26 Aug 2025 00:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkxLB3gj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD3938DEC;
	Tue, 26 Aug 2025 00:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756167087; cv=none; b=NY7bTW4dS0sc/rUk4v5WJkqAOyIosCizrFloDTvCp0vVnzFfbltaMY8p+7R2IvIoDAVspTb8EmA7PyMOyP3741CdvfrdtwvmBD+tCioHmKLySmn5te07TrHyIuxRUFKBENJuYk8VTyW6VUKpJJaUGvqrF0SV83H55G/maMCriUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756167087; c=relaxed/simple;
	bh=yRUOkAV+jE3BgB9eUA3z2aiZgVmYsWZlzqeDqZiKH/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RITUP2/aeaBSD7HDnfb5rN6eCl56ImecSl8GLis2dCZ3ahICUtXurBIQlMEJK2OEAySjq1q05nV9g36jeXbC/PPKhsIwkPHuri68Q5btJzZTvutoynV1IwQXeApOBGTDlZq5h8fgM55yKjLRpZ0xARbFRlr7GXIaHjKmv/rl2Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FkxLB3gj; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3e7c238bc0eso19487245ab.3;
        Mon, 25 Aug 2025 17:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756167085; x=1756771885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRUOkAV+jE3BgB9eUA3z2aiZgVmYsWZlzqeDqZiKH/A=;
        b=FkxLB3gj5nFPzdIxHx5hnG6A9mKRUwSKAfKJ1Che0IaRiWGp/9rpBr1Qadh62eSwVi
         U2Zn6rrO+Mno7tCQl9/VKgj20YUu1ozl99bTuiCt6tteuepa5hy0UMrzevghQmRM685D
         Dw2WC44SEmoX0eaHxODrZTkbSDE+4pDnnjfU8IUguXO1aiNeNNBvNPhJWE281HLwTkyc
         WtyuaIQVHHRdj+AP+nxeG6Yriurve8UZr5dwlTbfZIAsu8fAGJ8aMNthKp4R1m9+gzU7
         VZCHgeIZtAyAE5/hP8fm6Bo51h0GOIhp5A9mngT8wIiDKSc8Nq1Zt+EZcGTQrKyX/XRW
         IrAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756167085; x=1756771885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yRUOkAV+jE3BgB9eUA3z2aiZgVmYsWZlzqeDqZiKH/A=;
        b=j+bJcplMFUvhPf3uYVPmwZVzG7XVBPq+IwMx+cdEFdEfPuywuRNNynJwOXRgVFB3li
         UyxH3y+mN2xfBRcdMeiW/iC/d7DCaxDScGyKqJnXjFNCynyvB2BJdsKGC0t7ba0dWB2+
         NfigY+TsIKFbj3NLJKR0Qh4ltJxGBs8g1PjeC3x+D4TvjRXn4avMEZ4a0DTHe8YaOWkV
         q290pgsU1tIjxjPg1rHbfyMb/dQNPipGEyrygqccq7uRYiLqtlZRl0XGG6NEr890ofcw
         itIjCNOaRgkJqL/6XMBH31qV65lEwIfUoxd3FqJlqAymQo/X9uUEtswx6ujroHJN3mSq
         Ry+Q==
X-Forwarded-Encrypted: i=1; AJvYcCV705CMH6u00En+BObmhHNaQbAn9QAMcr3beptmnLcCoQOMNeHtKch0cXHQsQ2GUn1UTb4=@vger.kernel.org, AJvYcCWYfBVlokQRlZ6lwn0MrkqUW5C5/aMsz335SKswjWh6FhsRFouaTQ5ofFXFpgV0ORXLqyZKioeb@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9CeDt9ZIn1tB0rpeRjd2LuXnRrj9JUk3EzwLL3ab0MnAIB+wa
	e+eGKV3kiHuGOMFeTwlYsBzdX52sXF9XjIdIGxA0p5kuhvlOKaTyBJ8z/fPpHF4M1rHaraHiRkP
	D0mUbmnup7MAcGhtkRbfMehCY8m0l/7Y=
X-Gm-Gg: ASbGncv456zpO1dqOR6QLXjAoR3lshG5tdkzEmGdxQkR3Jh0txojXhXKObeXnrq6Zmu
	91ZW3O0dFaFAFkkw64rpxIuyjaZ06FhRybZcpC91qn6Tmq7P81SPHeaa6MwLaney1ctaqqnvCW5
	DSQ5Rj/q4WgB2gBb+40AY7maRaJIOKUVmwgFEf00JtSyIv8G0r0xV4ov7Eu4vA3MX1swyuKqv/r
	a1Bj8UWTVdc6+mMhQ==
X-Google-Smtp-Source: AGHT+IEYRL7PeaWKLreW+WH+hP9Z1KOFupmYb770pN08nvCcv0o7HZkypWOC3E8YAJtN2dFlmizYUISSivy+cADrfuQ=
X-Received: by 2002:a05:6e02:4414:10b0:3e9:eec4:9b69 with SMTP id
 e9e14a558f8ab-3e9eec49e75mr113137745ab.32.1756167084878; Mon, 25 Aug 2025
 17:11:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825135342.53110-1-kerneljasonxing@gmail.com>
 <20250825135342.53110-3-kerneljasonxing@gmail.com> <aKzTPW4fQ11fqb+b@boxer>
In-Reply-To: <aKzTPW4fQ11fqb+b@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 26 Aug 2025 08:10:48 +0800
X-Gm-Features: Ac12FXwr0O9nXSqhuu5dgAKn2exjFm09Oe5vFU4xod2Ufs_nq-Y_VsblHuGiCuE
Message-ID: <CAL+tcoA-Y0J14U2b4irzqY+-jAcUCVZvEizLACJfZANb85XzNQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/9] xsk: add descs parameter in xskq_cons_read_desc_batch()
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	horms@kernel.org, andrew+netdev@lunn.ch, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 5:19=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Mon, Aug 25, 2025 at 09:53:35PM +0800, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Add a new parameter to let generic xmit call this interface in the
> > subsequent patches.
> >
> > Prior to this patch, pool->tx_descs in xskq_cons_read_desc_batch() is
> > only used to store a small number of descs in zerocopy mode. Later
> > another similar cache named xs->desc_batch will be used in copy mode.
> > So adjust the parameter for copy mode.
>
> Explain why you couldn't reuse tx_descs as-is. Pool can not work both in
> copy and zero-copy modes at the same time so I don't see the reason why
> you couldn't reuse this for your needs?

Oh, right, spot on. I can reuse them instead of creating similar
wheels. Let me try this way.

Thanks,
Jason

