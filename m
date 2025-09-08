Return-Path: <bpf+bounces-67803-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77570B49CD3
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 00:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86BEF1B251D0
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 22:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCEE2EAB7F;
	Mon,  8 Sep 2025 22:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdqUYpqG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C28417E0;
	Mon,  8 Sep 2025 22:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757370500; cv=none; b=eR0w8HzqIgL27gd0OV5niTlJwSYYmNEblu1N07NFqN6i44t9pIETvjCn+rzil8rSiyHG9TAP4JKrJ5ROdD8YPePrLq9+vSJIEQPfNiv7d7lPYhwAodCoivX/tpKotwmYquFXEXjkLJeflyMKbpKb1e/yhJWCsoqj+E2Dz8TBtJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757370500; c=relaxed/simple;
	bh=m4yQKmO+d3v3uARMNsQcQ6nCmZN/cPeNtIkoOGqQ/Yg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UERIXkiVLCUA2l6QgHVhM2U5N2kTQA521BGKCTl/cXW5v14I11bnLdOY9/JSjaiw98vOW1I68mQ6mXrURHpawxdXvw+lRcmxaONMOXNlAvkhgylCMDCVSgOBzpuREugy1Pn+d0IEsJp8Q2mB4OehL8lH6LP4Sy7AlSCPD+oFSwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdqUYpqG; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-71d60110772so45525967b3.0;
        Mon, 08 Sep 2025 15:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757370498; x=1757975298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4yQKmO+d3v3uARMNsQcQ6nCmZN/cPeNtIkoOGqQ/Yg=;
        b=MdqUYpqGKD6K9DGYWy5SUDFuQqtEy/bPipX4kxPsufgwg/FTI4hdC0zChPdJJYXx7V
         LKwjrqlHCUw/DrRTdOuc+zh9PUKaL7aTyBYAkDXXyYbhp4589MQHvOfIf0dmzUdrX8zQ
         J7UARJNRJLA/5WuFnA0IaFEQ44r9Vkmzsb0CzcOsfpByRkOcmBbW3EBmyqwIBETFglo8
         2KIbnjAsmMAFRd5o+vj914wiwsbxSk80sbCy3XAh7/jp3VD+FxeW1PUwSdfa8TGXp9HN
         nIUhqwcMhDOiOYMYOy3NhdnrzfncobSM/WO6vyOGNwEUi0E1mgv6CMAx1X1Scvyfkq2n
         Jwvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757370498; x=1757975298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m4yQKmO+d3v3uARMNsQcQ6nCmZN/cPeNtIkoOGqQ/Yg=;
        b=a0ap0t52TvbJMpbgfuik6EvxGA5BT0p2AQigBO9ZUsOoG/pfdNUXvf3XqaBqKeDqdR
         IGTRXa17s3amCgwy+sz7lwgBj3Ynp+80HCwiIfw9B1sjhKp0CuYzMEawsruegRORAUkQ
         faIyg87/cOp5vZPzdIFdnZWDKTlkOchzaBwj8vctKSBDUWvUyV+DMaQi8ryfUPmja682
         by7oqMbW+put1DZSSA+iv2vDnqsnCMqKdY+LEUuuYUKl/ygUPHCzpnS2YHwhuUwiX01w
         4vMT0lyuCzj3qXBBlbQdY2dQQTrodgby7NAw8hQM8dUYkvWyODymFQNfDg7mZgqLnOa1
         A0Ig==
X-Forwarded-Encrypted: i=1; AJvYcCWExz8PlixVi40xdODx08gLv9ENnTe5M3UBEGNJt6DWrrkHXKMTPjk2f/XAZO8JjUzUJ9TuZPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiKLPHGoRbZLFXUIH6UFhJOCHzSrtyHCyRfr3mMmKHh+vMo5I3
	mcLKvL0QYc4aNaLuKpUtQKuw1+ETlYtZi2DVslCafjB6QghrN3+E25asPvxO1gE28v//sus19Lb
	P4ddZ+jACdrZ+YOMjQW8itRFVVf+/QEA=
X-Gm-Gg: ASbGncsd/xhjaTSld3vxzwif6a8BOsYfb0IsVHj5AEWxyJZdWLilQPvLsXFBa/OXdS4
	sR2/thf8qWPr/BRHnt+oHpGkxn8dnt9ppBip2qJxC5b7I/vBvXftRPlqWPSJrh7m7d0QTq85BfP
	tdpFYYl8WuZX52crP+ZxXZkTxvW8Ox4jKLR86fViMP2fWCfApOnWJ2c6tqOmbIKfhrEnqFxn1Y8
	G+KW4Ej/A1fFQnlnUo=
X-Google-Smtp-Source: AGHT+IEyXaJaECKXGoaCNZp5YdtfSWlBqqNX+36MeRel19gaqZvr/5W8qHzO5AmXIx6DhodWR99eMU3qvA4054OSino=
X-Received: by 2002:a05:690c:46c1:b0:719:edff:65a3 with SMTP id
 00721157ae682-727f652c203mr73481847b3.29.1757370497946; Mon, 08 Sep 2025
 15:28:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905173352.3759457-1-ameryhung@gmail.com> <20250905173352.3759457-4-ameryhung@gmail.com>
 <54cddbbd-1c0d-467a-af49-bb6484a62f26@linux.dev>
In-Reply-To: <54cddbbd-1c0d-467a-af49-bb6484a62f26@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 8 Sep 2025 15:28:05 -0700
X-Gm-Features: Ac12FXxeGt0TQEa2ZLqz3ofugznPj3MR6j0O5O-_zFdoaOprDQZ--x0GvxIwdfs
Message-ID: <CAMB2axP=fUpeCnKGRCJtqU9cdrtv6M9WDFUMjpmFvEZdj_+g2A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/7] bpf: Support pulling non-linear xdp data
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, kuba@kernel.org, 
	stfomichev@gmail.com, martin.lau@kernel.org, mohsin.bashr@gmail.com, 
	noren@nvidia.com, dtatulea@nvidia.com, saeedm@nvidia.com, tariqt@nvidia.com, 
	mbloch@nvidia.com, maciej.fijalkowski@intel.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 12:27=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 9/5/25 10:33 AM, Amery Hung wrote:
> > An unused argument, flags is reserved for future extension (e.g.,
> > tossing the data instead of copying it to the linear data area).
>
> > +__bpf_kfunc int bpf_xdp_pull_data(struct xdp_md *x, u32 len, u64 flags=
)
>
> I was thinking the flag may be needed to avoid copy. I think we have rece=
ntly
> concluded that bpf_xdp_adjust_head can support shrink on multi buf also. =
If it
> is the case, it is probably better to keep a similar api as the
> bpf_skb_pull_data which does not have the flags argument.
>

Make sense. I will remove flags.

