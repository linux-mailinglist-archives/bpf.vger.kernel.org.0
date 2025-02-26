Return-Path: <bpf+bounces-52611-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E50EA4542D
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 04:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04A781792DD
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 03:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12680266F16;
	Wed, 26 Feb 2025 03:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WU1ghHo1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3772E218821
	for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 03:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740542130; cv=none; b=kCXx5bOyR7WluIgI9HnFr80J/AF61N/ymWD2O2S292GFLLm2tLow+7hOlgNSspMigd8f18k/bLELbwVePjPViF3gnW2KQA1sCg/H0XIWJtj5IQyNw5ZeKBvP1Tc6DUODPxEa1r4hu+XnxddyTgEOMnAOyWO1aj+RurM6los63Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740542130; c=relaxed/simple;
	bh=1MoH/isgfO1p/6JR3oZxwfeBTzokrQ7e0Lck1ZyRuTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P8aJuXullP0hRFVyqknqW55pq0XEGT8CEgAuQHCXE+ze9Gq/BqqcuAt1jVoshNYj9WMx4yKXjlCxn2FssLF6ks/hXnUBt2zMr3fbxR0crYJprH4bxq10sEVPeZPty8lNaUvUydudMrNH5OaZYByrJTTAapD1GB9Sgjzrft3qylw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WU1ghHo1; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e86b92d3b0so23375006d6.2
        for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 19:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740542128; x=1741146928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/xnT6YMnq/lGIu5efT6IAES7aZ3cKaCka3kbURt/vTo=;
        b=WU1ghHo10bNNawdezoXSuJIu9jiemcbTlBsLnOJsW+4eAUiVyhJDlkku5YVIqGr1FT
         R6Lwwc5cOuD9Bw5in5iksmpkb/J62GHXGCtHczq8vWu/lZ3QGTb+yk/sQGev/xGmDk+f
         DGPuNCFR3P3Zv3j2MiInoS/ymaclV31JxnHvvkuKF3JXaeTCN4heb293b3gecT64G5Lm
         eLIaifhQRvXqaLu/AS1UTn4NFkCHOYUki/FLMJbmKPBEW6rjSIbnYrjG2UeZYnNUVwPm
         eXTD5A/mMia9k0h6bgh6VkzQYNrxytoDvmNKiOrV6EqoN/a65a4Fv7rq8nKKP+HhMSnU
         9jFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740542128; x=1741146928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/xnT6YMnq/lGIu5efT6IAES7aZ3cKaCka3kbURt/vTo=;
        b=skd80agtfq1u0zM8MmovasGaPW+sZppTnNPGroPeq7uxpiUChx/TDZPPz07gpgAUkS
         5r98S2ZvrZLqdKaw+t1OS74z1plEa2CpmBAggKhOxpCICSgY7/qfVy5RfznZwQpxq2vQ
         6a4Vr1ThZtnhHER3i2U2isVBfO8twRRAEs/A6mincOld7AUbIZPhUejrbo4qD4YFJQy3
         6+dx/vQHtgehhC/2gsCAMxmOPQK12HZr5knJcDaZO12hkKpnjoy3vWBcX7kZPQHdTU8g
         zMra7hjFTzUS4+w9JCx1xmnoE/yCaC7AShKyEVTwhPpVmliyiwMzMEH6K/1UFahQhNpc
         2nTg==
X-Forwarded-Encrypted: i=1; AJvYcCV6atECn8UEcmJaYEz1Fh0czgwXhqZ5//kIXuKmUeVydE849vOEq1isnGaQjNFQhBfwAPU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9pT+PtOGeB24hw/rxu9HXHs1irMANWjHoq9AZdWJIiHi1QfwX
	nWkk94b8a+H0UXHwLujI17J1tPfLI4epuFYw5nyYZV7uA6bX+XaJc1fAwDIUQ6ZGEAZ0A6cgEHd
	WQ/ycwSK8NS26YtCeNDlViAIxjO8=
X-Gm-Gg: ASbGncuCLeoF3s3Ugql6AJVdbsQ1KQakmjsnUdFG8GnY1I6w1mto8YTG5NgcQzpiYYU
	N8Srrfw3eWheHYkI+9hK9CHe5dCLSdeCZxIOPXo1Oq5fmxIr60WMKm1YzC9iNxGcmyLndMkX1Ny
	aU4QgH4cTp
X-Google-Smtp-Source: AGHT+IFalwQ7T3aEUBfTvGFobFZ9LSmZHtfMwYtjzYIKMqrk1cusqPJcVjSov6mgvqPg/1YmnV/GwhYdve32qRa0ESY=
X-Received: by 2002:a05:6214:daf:b0:6e4:3eb1:2bde with SMTP id
 6a1803df08f44-6e87ab6dcc1mr79836836d6.19.1740542128022; Tue, 25 Feb 2025
 19:55:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224114606.3500-1-laoar.shao@gmail.com> <20250224114606.3500-2-laoar.shao@gmail.com>
 <20250225175207.2q3c74ggwiw6lwsl@jpoimboe>
In-Reply-To: <20250225175207.2q3c74ggwiw6lwsl@jpoimboe>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 26 Feb 2025 11:54:51 +0800
X-Gm-Features: AQ5f1JrrvvrO9fvnuwJFOXHN7FfqmpbVmlPuqyY4eZSqSnRE8twbul_LVC6MFgg
Message-ID: <CALOAHbA+7v=676Dh=m+a2Fm6UsRrRzC4A_bMZyLcah2BJA+tSQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] bpf: Reject attaching fexit to functions annotated
 with __noreturn
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, peterz@infradead.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 1:52=E2=80=AFAM Josh Poimboeuf <jpoimboe@kernel.org=
> wrote:
>
> On Mon, Feb 24, 2025 at 07:46:05PM +0800, Yafang Shao wrote:
> > +BTF_SET_START(fexit_deny)
> > +#define NORETURN(fn) BTF_ID(func, fn)
> > +NORETURN(__fortify_panic)
> > +NORETURN(__ia32_sys_exit)
> > +NORETURN(__ia32_sys_exit_group)
>
> Why not just sync with the objtool noreturns.h?  Now we have two
> hard-coded lists instead of one.  These are guaranteed to diverge.

For details, refer to Alexei's response here:
https://lore.kernel.org/bpf/CAADnVQ+zLZKyrNGnGQDThasdS6cvM-FheN5Ttz23pF5ttb=
Gasw@mail.gmail.com/.

We cannot simply reuse the objtool noreturns.h file because BTF is
limited to handling only existing functions.

--
Regards

Yafang

