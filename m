Return-Path: <bpf+bounces-32477-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B96F90DFD3
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 01:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F3F7B22DDF
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 23:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FD417E476;
	Tue, 18 Jun 2024 23:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PcGhhXwN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4910413A418
	for <bpf@vger.kernel.org>; Tue, 18 Jun 2024 23:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718753083; cv=none; b=Rorr8/rZmrylLFsQGHZ+AvALQuI4GkCl1nmw8whrLp6bKUOfuHLhQCeqLeKIxlVSZqt04qMGMFUVx0iqp01VucCIaZowr2yofyNzTgYhLvA4LxpSLB3gYx9pYuZ5O9i2cyeKNpyYwfotzNHBzV8rA3DBVQHYo8ivbfGPy4Mj/+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718753083; c=relaxed/simple;
	bh=pQnwnDoOV6keN3ZIK/djjseZPCxwvcT8Ti3Pfn2BOXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EcWqrsIzYMJaL11DJ0Ev2b2fJgt8Toq0eFhRW2nXWkOAo52uXAGUqmmv7HaemVqEKFDr9cwkMF2jVbJ/esTIJfsymzvNuIp4sobHH9FgdbYhHQpfejoUAv9tItayKljKM4OBSqw3dUTMmX8aKr4mjEYxhzcWgouCUeUS2Plqshs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PcGhhXwN; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-6c5a6151ff8so4299794a12.2
        for <bpf@vger.kernel.org>; Tue, 18 Jun 2024 16:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718753081; x=1719357881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQnwnDoOV6keN3ZIK/djjseZPCxwvcT8Ti3Pfn2BOXc=;
        b=PcGhhXwNHO7kVtihU1t9Vh5GZK1VV7l6l+Z5J/fRNKkvFaGiS/E881ao3WdWR+yigO
         zDSzbRT9w96w/08+BvYmN8+h4+wJmQw602uDh3adx3EA2e8e6k7+R5eIp+U/suXbYxuO
         T3lKZxZqgR19CFuIAIG2IvndFOgoI7IFcnyIS9Xgu48BldkL47QHYd6d5oiCsMDmzru3
         rGbnlkvucg2JOMPJGkEwhtty1O3r5RxaODWHj04sQWFk1sfteXioBC++pBura/OrBtfU
         DZJ17zW4DyBKp0rnZ4BvbebXiVpjA89M6feLU83y/uTUhT4FibOHrVW7jdziLyAHOtn9
         x2oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718753081; x=1719357881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pQnwnDoOV6keN3ZIK/djjseZPCxwvcT8Ti3Pfn2BOXc=;
        b=LqANVA1AVHoyo5l1FMIPUW/SVKYCvqTIaDB8dmRlz2b/yqqBv1Jpgvs1F7OgUqXDz8
         1WS/zsdcR3sqIVrbhOol1WhRTkenADipgrAH0bZjJze41Rzn0lxqRQDExiDv1leeyKb/
         0ptjLZqnjXPWOyfVZm0ZyqcnTgYvCx3XZ1RGXze0DoNtF3GmryRYNjPAIRbx6BY7Nt8q
         eX83DU3ozp7icS1eJ6hbOfYmflL9Iss0d6ZcWQjYPUktABAXKois0WbbJ6Jm59jO89Dc
         ucihW0NFtnBBzbFtkvyF2H/LzX7jWsbxAqFLkZCgvVs++SzUBbtNebR563xMvIvh5ZsJ
         ydbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAyzbjwON+i26Hf1ZJZZDgNbrsiRvz4Ucd7N1OWFGeu5QkavXhGSH732VmVPcJLK/g1X0O72oDz2g1+WvVtdTErCkV
X-Gm-Message-State: AOJu0Yxeh995VNCNqT7Oh2AW1KCyMPagmLYaBYTrUqUXpFs8fbeGud9D
	i+7UZh/ByuucFQJPI6CtcJeN6thJ2xQiGT6JcqyQhpOq6fv/JoRr8f37mrW1SkLLLIyhGKw3lpW
	91k6Kv7INgBS4h8JG6a2ptpUMbAE=
X-Google-Smtp-Source: AGHT+IHuNGNjlHhrQZO2GL+pp6f6hjD8dVqZKTOze4eF7vlDtNqVA0+AyX3AKfoOj3ct/rfJnp3NgvPw1paHnphm0Sg=
X-Received: by 2002:a05:6a20:4a24:b0:1bc:bec6:f7a6 with SMTP id
 adf61e73a8af0-1bcbec6f940mr149844637.32.1718753081602; Tue, 18 Jun 2024
 16:24:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618162449.809994-1-alan.maguire@oracle.com>
 <20240618162449.809994-4-alan.maguire@oracle.com> <CAEf4BzZbn9-=7w8A99hkVFT1wKZ6LicBYSu-Z54Tb-eG7r1ffQ@mail.gmail.com>
 <05449fe120951ff8c02f96e20887348db1f505da.camel@gmail.com>
In-Reply-To: <05449fe120951ff8c02f96e20887348db1f505da.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 18 Jun 2024 16:24:29 -0700
Message-ID: <CAEf4Bzap8p4Bq=Uba-yD07LiBg312o7M_MHDt+r7NwZ736JVXA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/5] libbpf,bpf: share BTF relocate-related code
 with kernel
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org, acme@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, jolsa@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, mcgrof@kernel.org, 
	masahiroy@kernel.org, nathan@kernel.org, mykolal@fb.com, thinker.li@gmail.com, 
	bentiss@kernel.org, tanggeliang@kylinos.cn, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 4:16=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2024-06-18 at 15:53 -0700, Andrii Nakryiko wrote:
>
> [...]
>
>
> > > +# Some source files are common to libbpf.
> > > +vpath %.c $(srctree)/kernel/bpf:$(srctree)/tools/lib/bpf
> >
> > this is something new, what does vpath do? (sorry if this was
> > discussed before and I missed it)
>
> I was unfamiliar with this thing as well:
> https://www.gnu.org/software/make/manual/html_node/Selective-Search.html
> basically it allows to add a directory to dependency search path.
> An alternative would be to make a soft link, e.g. like with
> ./tools/testing/selftests/bpf/disasm.c

Cool, that seems quite useful, thanks!

>
> [...]

