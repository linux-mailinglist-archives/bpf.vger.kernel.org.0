Return-Path: <bpf+bounces-72977-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7498CC1E837
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 07:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89FC718921E6
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 06:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6ED3168E0;
	Thu, 30 Oct 2025 06:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VgZtj77E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D113019A2
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 06:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761804679; cv=none; b=Zd30PukAEQF45Ls6IIv4V69wFucq3CKZTKl82sC7aqkTA0ZY24S8tO1fToKZPMrlZv/XiKKguuSjNRytSL/pCkahj2gwOrWMc122MRLZZbZtKD+lapBA7jysfKeaLbQ8KXQ3/Hz9YetNcnwoIVt3bork026VsbCty/lT8GWRnoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761804679; c=relaxed/simple;
	bh=QdocTsWwqPCC5vykodfn2Jg1rhZ+qrsFLU9vZrTMO4g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ttpm7mX30areSWYJpPcPz99onkFfV2OqRZ+m7EO8xT4qjKd7bQBhkwm7RSZizhI4tT1+qiqcwLgX2QAvQcAcGLTKEM5wr1MFrUo5pQLB6RsyiCQ19ykEzY1qyR91mCrtEX4uPMRx8HS+n/zAixu1szM5RAJ5aWTSFdETvqYYxKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VgZtj77E; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-290a3a4c7ecso6162995ad.0
        for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 23:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761804677; x=1762409477; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vv+R4seUJBTjEv+BqyOlH6zqbBwjHB8AuHYCdt9SuRs=;
        b=VgZtj77ErQL+6zNoowb12SE7PvYl3KQxHsSSTP1y+Q0JXfxSyCr4BFOUkGBJGZFbDx
         V6lmhHOxE+UggdPHmkSxKER12x+PcAmXkuFDTL+c2Tn8rXSPLgBIfgyhJxJ4BXYelhLJ
         GW8dgRZIi7qoDd5iop4PLuAmwS18E0Od9vevy8MPFk6HNmY7B5R3yU4Pnkz4x2mGJwQL
         Rq6Xah/Oqk/IKiWLLtsaey5fLCRyLpD45tAXL0t40rwltFiPO7AuvTqvUCKOupnzvfvF
         9K6Qu6+1O3V9tMeQISLjM5RSL4UG6pf1u865KP3Zn6qltpRgy0ZAmlm2TwR5N+2mcnZv
         68cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761804677; x=1762409477;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vv+R4seUJBTjEv+BqyOlH6zqbBwjHB8AuHYCdt9SuRs=;
        b=sSFAoFh/E178BsKv1UWo60wmjKx6SzXZesNTWeBZwGjjsYmUgjGkrbiOloIj4lmjYP
         UwPz/5VjYqv+ohMFmwtooszjkp20BZDeB4IluuBuePKp0nsV7Qsdm/LU6kMGEnd+oAV5
         fWkfKzAQqTuTLhCzqATZooXZMR5pdCdftbfYh1BisnaBc2mTDERIfFnm2d7ZEgBTZjv2
         5BCM2Vds/3M/TW7fWLICEDNcYE0zv2+mxSlg2+kSGslksQgCt6ZOEXgdc2Y7dAda3Wp6
         zEoQzAExso90m83054LdSF2My9oVgDh92rtgf75f6Klveo+vjQ9yhp7GC0ChGpKrLarS
         a4/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVplPZNmm75YqO8T8LaNqyGOxCQgTOB+2jItwgUNbgIIxL6gsQbQyolHj+XHkH4/wgWH7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCfzwZxEjfECbRTXUGE2uu5Lz5GQwBzYD4xlzY2ccjgkvWJNzF
	mMGi5bPr2PKC1DqmVHEC1YkTVlYIAPw+QAsDyL8BdwA78cxVF9QhNDv6
X-Gm-Gg: ASbGncuQqi4GgDA3aniXg7vurRDCytI6YWstFHz3rTNB9iCh1g2Yh5UQJpablcdQYtt
	Zj15/ANsIvCt9MuUb6GEKjpb3964AbltERYzRerf6AIqMQSVFq6AtAmpz01evxuWw4HBH5fEEKB
	YEivQ/jqK8a7QHn0Sf+FbMpR2D0268keWyAqxew9USvbk8tiUrvAnQ07Q8NKgINMoAE3Hq1WXyn
	JlQWCEJaKxkeFqIaiEKJRs9mitnjjvmAYFMrFlqW0vLZCOQdgjs15PJykVs/PlVx2PeUC/GUm3/
	BkWYw2H881LADvcb0328XMEGp1aszjXjcti3eKfzH4qoAhXIwfkc7ksp5Au935CO+OsIiwSNKZm
	0DNaYhfjUN50VH5h4mXtbP0rD/GFuISB8LaH5spczCPmM+32wesSI0SreXgE1Ck3HgXzfhLNg
X-Google-Smtp-Source: AGHT+IGhxbWGxhv6KUnbxh+gMC2+wpZQA0QpDLgXpYFd/fAjDIGtYUlATrOKNxCSXndkFI1uBcfksQ==
X-Received: by 2002:a17:902:c94d:b0:24b:164d:4e61 with SMTP id d9443c01a7336-294edb9f7f0mr25199185ad.13.1761804676701;
        Wed, 29 Oct 2025 23:11:16 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d0acecsm171394115ad.38.2025.10.29.23.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 23:11:16 -0700 (PDT)
Message-ID: <99115d79a7808ca1290726561e36b64ec56e2a1e.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 0/8] bpf: magic kernel functions
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org, 
	andrii@kernel.org, ast@kernel.org
Cc: dwarves@vger.kernel.org, alan.maguire@oracle.com, acme@kernel.org, 
	tj@kernel.org, kernel-team@meta.com
Date: Wed, 29 Oct 2025 23:11:13 -0700
In-Reply-To: <50ddff79d33d6e2d57e104f610273d647530ddbc.camel@gmail.com>
References: <20251029190113.3323406-1-ihor.solodrai@linux.dev>
	 <50ddff79d33d6e2d57e104f610273d647530ddbc.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-29 at 17:44 -0700, Eduard Zingerman wrote:
> On Wed, 2025-10-29 at 12:01 -0700, Ihor Solodrai wrote:
>=20
> Do we break compatibility with old pahole versions after this
> patch-set? Old paholes won't synthesize the _impl kfuncs, so:
> - binary compatibility between new-kernel/old-pahole + old-bpf
> =C2=A0 will be broken, as there would be no _impl kfuncs;
> - new-kernel/old-pahole + new-bpf won't work either, as kernel will
> be
> =C2=A0 unable to find non-_impl function names for existing kfuncs.
>=20
> [...]

Point being, if we are going to break backwards compatibility the
following things need an update:
- Documentation/process/changes.rst
  minimal pahole version has to be bumped
- scripts/Makefile.btf
  All the different flags and options for different pahole
  versions can be dropped.

---

On the other hand, I'm not sure this useful but relatively obscure
feature grants such a compatibility break. Some time ago Ihor
advocated for just having two functions in the kernel, so that BTF
will be generated for both. And I think that someone suggested putting
the fake function to a discard-able section.
This way the whole thing can be done in kernel only.
E.g. it will look like so:

  __bpf_kfunc void btf_foo_impl(struct bpf_prog_aux p__implicit)
  { /* real impl here */ }

  __bpf_kfunc_proto void btf_foo(void) {}

Assuming that __bpf_kfunc_proto hides all the necessary attributes.
Not much boilerplate, and a tad easier to understand where second
prototype comes from, no need to read pahole.

