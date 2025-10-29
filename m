Return-Path: <bpf+bounces-72659-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 345B2C177BE
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 01:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D867B4E07D4
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 00:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638F01DE4E0;
	Wed, 29 Oct 2025 00:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="evHEHdUk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC191DE4CE
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 00:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761696643; cv=none; b=YBlGaxxcY8+u+kvbkNWVeXG+Gak2DbO4Bua7icA4hOQOs9+m0Rb9ovEtnYQ2fpn+SGNHdOzsfga5A13H0BEsRhHcfwMm0R7MB83Bzv/eUm3LKLmnU27EXIDMOaPv7Ai8KNEPW/rNBtaV8L/ayVPq/6H6c8h+YOoA/Wk/CLev/yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761696643; c=relaxed/simple;
	bh=QloRiWksfwupmAUdBgNLV/svbMoFmzJRlSMrdXPaxnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lnXh9BfdK3QyPNvuTvtRGUpLWB2uHsJuiE6/ZHr80qaXuo5BSw1M+2JoCQwglSEgM/TcdepVoVKuMZuZ5QYy58JZkAmm3C6Rl82L4/bIUxKSrXuWMPjct0JRrhpJVB2o6ATVUaMq85Xj5W+Mb5f3gpAmU2gj4f71U25gW6ADAGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=evHEHdUk; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-33be037cf73so6884301a91.2
        for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 17:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1761696642; x=1762301442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAeYT3sIf5J+urxpWRZdGCYWbbcmjWbjfXki2vhXqBo=;
        b=evHEHdUkGc41clD3/HvS6TCsRDFkA9q6MEZ+Ee8ikmU90EW0nwK1uXakOJknKdIEYw
         UPOMfeEvBNhKrHjLjHr7xIYCpdId2KHIvvTrAsza0xQeogPNi8UwwvqaI96FT8ITZ8vQ
         uzFC0R7kneeJXGfF8/cqcxLa3ozJQN2E70B69L9NShTl9bB++pcLxc0q3bhCZ6JHhbk2
         c7LXeRcZcT65SzKjp7o+Ph+jEW+BDN8aORwZ2Q6/pPfvCmUIvEEXu+nEyBOVi1hFu8Rr
         SUBY5Gz0grZxmej8kpSYf3nSsLE60De2XMA1fzyVirRng1clt1tCPFYnLsbjXnIXjkwS
         8jyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761696642; x=1762301442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OAeYT3sIf5J+urxpWRZdGCYWbbcmjWbjfXki2vhXqBo=;
        b=S0wQ02Dl6jP9a1TezQQPTPrdl4NtBAtAbUUeUAoc4F13xH9M1IAEB/NFNRgl47esph
         lpxgXD+D7mLJYmAy/3jkQygbPxo7qZILiJpQMSVwqkmOVykisVp9B8hOLgz8hAWt9C0X
         YQSNuBCVgCZm9lEdPGmWs8TRv2ADuBt4l521DChyCwuoppU/WP+Av9OVcqc6NNvUPsKQ
         WTk3O+Z28zKYhY0VurLGWdBtL8HL3cIsVGn16dPTXAc8HcT2OrHAPZj+oekeS45WUpzX
         PJL+lffSgxG78V2Htx2CaCbOfbIa1F4nJPkgrHVihvTFMso+kzle+av0PEuWd+ZpgG0n
         eRQg==
X-Forwarded-Encrypted: i=1; AJvYcCWah7Jev0tyAcGFEkItcdxWEHO6UtFzEfhe/WgC+xuNeF8nso0Iv94NyOTS2eapsm4L2JI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfifYG4UIJwg6j8NIofi1EuxJYxBSTu+KTFdPCSoPLw5s4qtYG
	BmrpnHZjt8cIFoiUWAvQBct1iN3XX23Qv/K5JbrZf2G3kWYK4RkcrbO2RImRRpWu/ohySsnyUma
	aWh8iYHMozssStrNnwnVm7wpGSK37JAnlgo3AxqlG
X-Gm-Gg: ASbGnctxV/Zkl3g/YetriFrgaLDjtHr6ajdKHjLiIEYI+hZdk1ZarGxtXL0NSAfsWR3
	S/EgEOwP/tq2GKJNolNHj9gvlSLBorXeIazzdLghRc9+tphoIeuFSNQdH5/Jlh+rTwNFMufY2x5
	MR35tPQDZDZaOq4ozTNjzGpkX2TtGw49vzsq0mFfHeQ+YJeudOX+ruG/2xq0PbaFxr9Pg409XY5
	UGbOPLOlYPRGhO3fKB557ouET4GLlcqFy+UYQ1Sz4ATj6JlV/Kf/G1u1tNh
X-Google-Smtp-Source: AGHT+IGhjs8q4GiygXwr6DCqhQXMqWhNs5oaPfnq5KAn4id0agHe+xmdqRLWlZPNOFZ/N+dUgAnaM8QQHq+RXzkh3rE=
X-Received: by 2002:a17:90b:4c8c:b0:32e:d600:4fdb with SMTP id
 98e67ed59e1d1-3403a2a1014mr987268a91.18.1761696641654; Tue, 28 Oct 2025
 17:10:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk> <20251028004614.393374-49-viro@zeniv.linux.org.uk>
In-Reply-To: <20251028004614.393374-49-viro@zeniv.linux.org.uk>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 28 Oct 2025 20:10:29 -0400
X-Gm-Features: AWmQ_bnyVa46lrJnSEC4p7b8a6-fhgKBPo6xvMl8XVNnPJL6uMjYjs2dxSO45Ps
Message-ID: <CAHC9VhRX6kqFbbKuOoKOLLve6c+7TN3=fXHrtXyj=osfNYd+2A@mail.gmail.com>
Subject: Re: [PATCH v2 48/50] convert securityfs
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
> securityfs uses simple_recursive_removal(), but does not bother to mark
> dentries persistent.  This is the only place where it still happens; get
> rid of that irregularity.
>
> * use simple_{start,done}_creating() and d_make_persitent(); kill_litter_=
super()
> use was already gone, since we empty the filesystem instance before it ge=
ts
> shut down.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  security/inode.c | 33 ++++++++++++---------------------
>  1 file changed, 12 insertions(+), 21 deletions(-)

Much cleaner now.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com

