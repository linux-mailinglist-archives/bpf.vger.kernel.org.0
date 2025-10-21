Return-Path: <bpf+bounces-71619-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB2BBF83E5
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 21:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BCB2E345AA4
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 19:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BB7351FB6;
	Tue, 21 Oct 2025 19:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VgDg+E5h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80693338903
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 19:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761074742; cv=none; b=B3oeqgQmwgQW5s8WfK8ZjX+IDsxpFxzLQnAumSRNQmH53KCxVCDO50sE88eK4/fqzB3UnrMb7mu6v8PHOqpBYVD/teyXSB7Q2mA6cWyWC34fOJji6jGjYqPk+WG6T4vo0qSQao4ljvt+WmS17NKsewrweJAooeTC2K+cAOb62nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761074742; c=relaxed/simple;
	bh=wqec2+ABibcr8VcSYc2xp0yVhyOyV8nAcecaldXZm4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHd1mjH98wuG6sBWW/6cZ40D9zc65X6fVIfvGjqiGiqgK8kwn12ep3DPI8JaiDS1+6BsONu2I4LCSDH/i3oggFDB4Mb95gE2Z5e6cXGvA6CTki62HXRJc/nNHX25kshE3LfQtzmljFmOmuDFUnY8b40AQD4za23DbaGQxD5x6zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VgDg+E5h; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3ee15b5435bso5839964f8f.0
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 12:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761074739; x=1761679539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RhJs7O4nePIdqciTBuGyuEE9/QBas0kVH8Ybi4VCiE4=;
        b=VgDg+E5h2yQT9B53uUHT6FFZ6FBxBLpeKDlTY/6AjvKlmDfR303+bTyW0oA9fyCg54
         5CtxBgh1k3vsTjCQlg6XZz82eCdaJ+1h+VOJLh4qHtNi0Z5kFnLaMchYvK5p5NUbp/Fj
         CHkd0CD3Plj8BJTROrYKv41hx34/KXkc3XsWX3/q7xCVU8XqOa6sMwS/tADqWccbGsdx
         IBswgkC3g+cTj3YHgPORbTXe745XnX3buJPIYYdNzFyaohIQ6QqGPuE8U/NFApRE5w99
         rXutmiQLt7B18pfJ3OkC0gR4dC1Fq+qBVO7GTCXF69dJEruWVgdNqz0PHpqh+1sY1VZS
         pO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761074739; x=1761679539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RhJs7O4nePIdqciTBuGyuEE9/QBas0kVH8Ybi4VCiE4=;
        b=k0mpKgLUUrjXKfku3VCADGs+0S01d/QWzw6BZ4GmHSkv4IOzsS/UmLCpgr7zXlE8CY
         9L4lu+pCWCUcvp9o059IH05VFLfnivYgutIkGa/Vah0GEX3aPhD0Y1lgeCayOdxMaBvu
         erlCyBWE1FcR8Bw6bQ/bJc/uMiRvQuNwOgZTX1Mo8u2lj3YW77QJkKwu/RtYEJ0PmxRV
         RG0AcHwN+TTWFHnrf4u4RccSbiZQqfWIZudg6jhN9HQp5Ls34aV1o7l2KGDPhl6146Y/
         VHUUg9+eglUtfzXwH7dce8AHUoPsvqDRWU8AfkgkPLMyKb8uoLTPH+KhNoecr26v4OT2
         xnLg==
X-Gm-Message-State: AOJu0YwFj9iah7M61Qk7/VMBHTG+hYVENx6o/fX/GbpcVAKpiQg2/fYM
	uEY2+MkJzoXhs1N8Qip59yz9lrzwuJM4AY7p7/SUJn0H0mkDIxRsAiJ4
X-Gm-Gg: ASbGncuPrkIr/HqyshqiqUBxgQA1cfzIh1/y2ToEIBYeP+GNXJUdNezbm4ATMIKMuzT
	7rDAes3G9fhkox6t8/4xrUbMzRZAJz+dobgw9U6U9tFIdn5YrPbPq7AwbMgZUULHilUnMaaSGZ5
	uZfqPQRshjN0UhTtUsv6KMhGDgG2mhEIZm6uOQWlQM0/y+BFyiJH6KQTG4PadBXeI3fY9nk+VO9
	hLWA8kJEcD/+t4zS3Jv4gWueqQEZIx3rZUzYPByX/TGc9KoyI2RU40vTUypHj81ZcXs67HmZnZf
	nbBw2mszax8VBQkNAwpP+5C+XI4rnJHHaBd8+BiSJaPXe2swiMVlQFDjWwlzcEmGvvuxjW4evMD
	42u0y9WExORVaux3bB5ptAIYWhYiSZC9jp/U63EyIEDwqEMUnY1ude68YPVyCK6KV7ro6nrpZJ4
	tziXrSEytpcmY8ZuVlfZaG
X-Google-Smtp-Source: AGHT+IEVe+/ZczpfQssOWA8WKKWU+s//BRMMC44d9iHxLEtLD24ojueeoPlOEfVyD4M3uheeAj4pOA==
X-Received: by 2002:a05:6000:2c01:b0:428:3b8c:4690 with SMTP id ffacd0b85a97d-4283b8c47c1mr8023661f8f.20.1761074738601;
        Tue, 21 Oct 2025 12:25:38 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a976sm22099427f8f.32.2025.10.21.12.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 12:25:38 -0700 (PDT)
Date: Tue, 21 Oct 2025 19:32:18 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v6 bpf-next 12/17] bpf, docs: do not state that indirect
 jumps are not supported
Message-ID: <aPffwozAdFGGgyc3@mail.gmail.com>
References: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
 <20251019202145.3944697-13-a.s.protopopov@gmail.com>
 <83225612f07f1d0f2f488efaee9c075b44e8cc03.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83225612f07f1d0f2f488efaee9c075b44e8cc03.camel@gmail.com>

On 25/10/21 12:15PM, Eduard Zingerman wrote:
> On Sun, 2025-10-19 at 20:21 +0000, Anton Protopopov wrote:
> > The linux-notes.rst states that indirect jump instruction "is not
> > currently supported by the verifier". Remove this part as outdated.
> > 
> > Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> > ---
> >  Documentation/bpf/linux-notes.rst | 8 --------
> >  1 file changed, 8 deletions(-)
> > 
> > diff --git a/Documentation/bpf/linux-notes.rst b/Documentation/bpf/linux-notes.rst
> > index 00d2693de025..64ac146a926f 100644
> > --- a/Documentation/bpf/linux-notes.rst
> > +++ b/Documentation/bpf/linux-notes.rst
> > @@ -12,14 +12,6 @@ Byte swap instructions
> >  
> >  ``BPF_FROM_LE`` and ``BPF_FROM_BE`` exist as aliases for ``BPF_TO_LE`` and ``BPF_TO_BE`` respectively.
> >  
> > -Jump instructions
> > -=================
> > -
> > -``BPF_CALL | BPF_X | BPF_JMP`` (0x8d), where the helper function
> > -integer would be read from a specified register, is not currently supported
> > -by the verifier.  Any programs with this instruction will fail to load
> > -until such support is added.
> > -
> >  Maps
> >  ====
> >  
> 
> Nit: bpf/standardization/instruction-set.rst needs an update,
>      we don't have anything about `JA|X|JMP` in the "Jump instructions"
>      section there.

Ah yes, thanks.

Also, there is a limitation listed in the llvm doc that -O0
can't be used due to absence of indirect jumps. I wonder if
there should be more limitations introduced since the doc
was written. (I've tried, briefly, to compile selftests with -O0,
but this fails for other reasons, and I didn't have time to dig
into this.)

