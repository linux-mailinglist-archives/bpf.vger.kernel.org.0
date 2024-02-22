Return-Path: <bpf+bounces-22510-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5551085FEBF
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 18:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1035028A1CD
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 17:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F848154BEC;
	Thu, 22 Feb 2024 17:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGTWG4k4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010A2153BD5
	for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 17:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708621765; cv=none; b=dlS475/WqLqp7sP0i70bwCm5QKKA61AgafQpnX3LMws4+rIuT/8tdzdNXKJox+G7umoSc3BqsLLRCQgJSKym0DLs4o93suAvFVls1cV0wN5BMoQV1bbIiFRLvI9J4dkPdl8hxPPISIQefr1Y7/gjotealodMomLicKMAsTJoNDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708621765; c=relaxed/simple;
	bh=7fNvw2w/0YCKU/5cO1A1EYyAkNH7LVYOznnUzvsjNkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NEdkSrIuVJVB+h6+actsz9FpoK+gzQ5svmmHfubYInMUZYtGCOwZTXVg+nLfw+qEQKvsUU/7VouzQvvzeX9ovFE44vV4FyeR3ZqED3cm9LNzkLq1eUNg49bJpv0ncz5i3o86FtccHSz0ZIkrB0YuyID3mub1rAHNx3ndJZOMVDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LGTWG4k4; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33d90dfe73cso19260f8f.0
        for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 09:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708621762; x=1709226562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWJ5IgaXI9oB8PDuNTR3xa+p/K3crCcJtlVMiaixrBo=;
        b=LGTWG4k4+9uYAGUkv/WlidCPnS5iCMJ4cLvjuaVduVEMPCGv33KvX//gZGzp1VjRGj
         8rRD61YLS2A2xojP8r+QVCtbY5aDMolEA7kofiCK7mP7C5g6oebMj6yQwEhJsJqY/BSE
         EJ/P94wGAqD56Yjuwr96e1GxVbIUGQaaOC/9oSdRLeSaveduXf/4PUYdc9Rwf6raQ0CW
         n8wZqW3VAzAHzsJmK7bd6SCBxf7M4GFmCMVyZK7rarnv3vmLKjS3dlKUryTbyvcn6xms
         9IIR7YWf12+/4Eqw6tZk1iI6Tz+W0hzmwe0V5MKq48KXn7TqUdb+17/JR//IoFztkBGe
         /plQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708621762; x=1709226562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LWJ5IgaXI9oB8PDuNTR3xa+p/K3crCcJtlVMiaixrBo=;
        b=iWXuAvaeKXBiH799kDK6YHuD1LnqZf72ECbRmjgFsilHefsP8M1v1H2Wo4+a+Rl/5n
         BfvzPHp8NRwtbvHn12p5WdnUpdhM+TCsuJnQkDMEp07oScsO2xZnzL3XwGBdFVlyOSid
         +vvIwYebPBu6PyQ4Mx8GRBL1PCH2q2CV3xdOPiZHS2gWSeoz+1EVC95q4mUMc/StTEIp
         29UdpbVd5eoypIh10zgtWRv1VHZCSw9wQhQLOH8Z2EGewVDe7aLblqF/Atk9OSGUEd0U
         MeZJU3L3Q5NRH/YcmiH5ktUORM/iNy51MHj5R/YdKvKpvpIJGzR8XlBfjrBKGQ4OJJiW
         a/Xg==
X-Forwarded-Encrypted: i=1; AJvYcCXb1zl7g+zlIGTP5XU1b2orgckhYcVeys8mst2Mpb0SVdE3lLjCv2OSSA50qu+Y5NEVXGelwutzTsWK832U/yXJ6r/H
X-Gm-Message-State: AOJu0YxYc9PglTT+i6qG1fI8Emj0uG9MLWrXeEy3eUadasF9MkYZ8yVN
	NYnKubqq++kV+1kB7ZoIYFWMA8/Rd+w6OcE5FqZOk3tYflNMR29FvvZe6laPYWmiCu/1eNT19cI
	oO0LtxqnWjn3aqLzvZ/CNJR0buqmZHc0s
X-Google-Smtp-Source: AGHT+IF3f97DXmYh07Mhi9eTIOYVTqDX1qlnsgRXet803c0Dilvsop6Hz6vFL+FW1Yp0nFNhq7FpGs/jJuQiae2F1rk=
X-Received: by 2002:a5d:59aa:0:b0:33d:9dd9:c23e with SMTP id
 p10-20020a5d59aa000000b0033d9dd9c23emr1485735wrr.0.1708621762222; Thu, 22 Feb
 2024 09:09:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221173535.16601-1-dthaler1968@gmail.com> <20240221180448.GC57258@maniforge>
In-Reply-To: <20240221180448.GC57258@maniforge>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 22 Feb 2024 09:09:10 -0800
Message-ID: <CAADnVQJsWgaRL-6Ndo9XTuYmDOOiXSFGAMnVmU723=qxE4f3dg@mail.gmail.com>
Subject: Re: [Bpf] [PATCH bpf-next] bpf, docs: Fix typos in instruction-set.rst
To: David Vernet <void@manifault.com>
Cc: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>, bpf <bpf@vger.kernel.org>, 
	bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 10:05=E2=80=AFAM David Vernet <void@manifault.com> =
wrote:
>
> On Wed, Feb 21, 2024 at 09:35:35AM -0800, Dave Thaler wrote:
> > * "BPF ADD" should be "BPF_ADD".
> > * "src" should be "src_reg" in several places.  The latter is the field=
 name
> >   in the instruction.  The former refers to the value of the register, =
or the
> >   immediate.
> > * Add '' around field names in one sentence, for consistency with the r=
est
> >   of the document.
> >
> > Signed-off-by: Dave Thaler <dthaler1968@gmail.com>
>
> Thanks for the cleanup.
>
> Acked-by: David Vernet <void@manifault.com>
>
> > ---
> >  .../bpf/standardization/instruction-set.rst   | 72 +++++++++----------
> >  1 file changed, 36 insertions(+), 36 deletions(-)
> >
> > diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Do=
cumentation/bpf/standardization/instruction-set.rst
> > index 868d9f617..56b5e7dad 100644
> > --- a/Documentation/bpf/standardization/instruction-set.rst
> > +++ b/Documentation/bpf/standardization/instruction-set.rst
> > @@ -178,7 +178,7 @@ Unused fields shall be cleared to zero.
> >  As discussed below in `64-bit immediate instructions`_, a 64-bit immed=
iate
> >  instruction uses two 32-bit immediate values that are constructed as f=
ollows.
> >  The 64 bits following the basic instruction contain a pseudo instructi=
on
> > -using the same format but with opcode, dst_reg, src_reg, and offset al=
l set to zero,
> > +using the same format but with 'opcode', 'dst_reg', 'src_reg', and 'of=
fset' all set to zero,
> >  and imm containing the high 32 bits of the immediate value.
>
> nit: Can we make sure these columns are all wrapped to 80 characters?
> This can be done in a follow-up for the whole document later.

Fixed up while applying,
but let's not reformat the whole doc.
Many tables are 100+ chars and it's fine.

