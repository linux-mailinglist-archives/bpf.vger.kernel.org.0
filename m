Return-Path: <bpf+bounces-28407-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0DD8B90D6
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 22:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B68751C21819
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 20:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A61165FCA;
	Wed,  1 May 2024 20:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="gpgH3Rvt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1F2165FBA
	for <bpf@vger.kernel.org>; Wed,  1 May 2024 20:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714596470; cv=none; b=GjDcy0ZgrPIFuA5aTC4qISNQAIac+go6cgXtRCD7sK9f05byAbAO5Hjm6gs8VtSDJjgP/1bAGwNS9LMyYmvPSdIk6C036DlYwj/VLvQayTMN3+ShqT+RErW1VdJ9CELLEom9e6WxYYqL1x3Rp/fmmt4PFVWmZXfA7ydYK5L3IDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714596470; c=relaxed/simple;
	bh=ra1d6k+dPLwUnrnNIckVGDJJ8lliajlQVTK90DkxH3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a3A2UeGnd81QRjaIh9GRU1iLMGDrnZP3j6Cmvh4LCicrCL3a34yHqPobMfYK2tqblx/e93vFR3H6dxjM3eTJpY5nERORraWoQn763UyWzgavW/jbwJf74DWwFQIgzHwudHJEdM/eFzXkELGCqzZM3Mqn/E3TNyGawIrZF7gyG7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=gpgH3Rvt; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-61be4b986aaso35003967b3.3
        for <bpf@vger.kernel.org>; Wed, 01 May 2024 13:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1714596468; x=1715201268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+PTRDKy8eCh7IoM5KV0mi1ceXwqoykRHY4lJtZB0kY=;
        b=gpgH3RvtZYGw+ehS9sDjZywyTGvxgtr+CsG/iYIp1RP2kH9I5ZGN4Iirt8M6IbLEDd
         bS0N+UYIhG6F/JmgoaA1EyvpyN7jV/5HCgLSVhOSbcgJqIP1RhEOHICKCUY/gbHVzta6
         nfw+cRGHAWNv/p5i2tsDwfk8Klj+48tJnTmK21WsKLMCcnIWDz6HCVEbX4NVX88Ps/fB
         oNPigxEi3/l14dujgguG9nykyLMMekTAuW9pyaRhQ5KMPIvVmYj8VIA5JHtxqhx7c8IR
         WRrNqZG4YPacFIV4AiN95uj8cBb94VRX9LK5BGKvSCOu5kMF+fb7ZLAm34Jmh1XvjFaR
         BDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714596468; x=1715201268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5+PTRDKy8eCh7IoM5KV0mi1ceXwqoykRHY4lJtZB0kY=;
        b=a0cmXcYlbMlIJk7SqJiXPPgC8x4mT2vmaGBl0VIWAp4eHGDgLJZhuxe2m6PhSvL5wT
         bh29t0fywf/eDi0iPHHlrGSKVMq/o2frMcQyb3K6QRFTkOK1cGAgaLiw95I0KinF+WAz
         5EklMTln3tNexaiC7FFnqTj6DTqd3P73JLpHenTWW/Zld9hQCPKYGYMTisAxXjmEEzNg
         G8CY/0qI4eSDcXD7qrZMjIjNHDsXnYV0jltDdquHK7lyQQzsGJn+LA/iJo11oocttBVm
         3YUBBZm62jqzFkXQiY+kGx5uvW0B2VtEFIz5zZEP7ELi/SgBKb1oe6Sf+yud09U3UTKX
         CrXA==
X-Forwarded-Encrypted: i=1; AJvYcCWPA9s6zmCf18/NIgIY7wNbydigJvcVcXx4lM/Wp/JqSzOsHgcKpeHx4du7U3xSYCiE4cLtArbsGex28HZb71yC1IEp
X-Gm-Message-State: AOJu0YxqHF58vHogItC54SSeR80fnANtkgvDGu/ub5ZeTb5fEkG7KSP1
	0dQZSJm10E6D6q7LHgWeBCu8LN1VXSX7yDBhYi2Xg/c4mQ9gF9UKYaALwycaFD8H91nomFD/cjt
	YB/RMB0dnmgnvSrAnftJHNRZ9+Nd+cPppuOzh
X-Google-Smtp-Source: AGHT+IHOwjK39aAkCf1U1a1zITPFDSZFgBnRkiLpnvhJSWgbMTwWHIaF/yZdq1CGwHLPTrZin8UvRonaWrA3BNBSiHg=
X-Received: by 2002:a05:690c:dc3:b0:61b:3356:a679 with SMTP id
 db3-20020a05690c0dc300b0061b3356a679mr69311ywb.17.1714596468387; Wed, 01 May
 2024 13:47:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429114636.123395-1-fuzhen5@huawei.com> <CAHC9VhTCFOCE0E-en3HnNkPVRumzWRPcrJMF-=dxke53dOv1Gg@mail.gmail.com>
In-Reply-To: <CAHC9VhTCFOCE0E-en3HnNkPVRumzWRPcrJMF-=dxke53dOv1Gg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 1 May 2024 16:47:37 -0400
Message-ID: <CAHC9VhT0=Useuop92s4J9CGNpXa54r4NYnY9DOTnGmoo0hNv5w@mail.gmail.com>
Subject: Re: [PATCH -next] lsm: fix default return value for inode_set(remove)xattr
To: felix <fuzhen5@huawei.com>, linux-security-module@vger.kernel.org
Cc: casey@schaufler-ca.com, roberto.sassu@huawei.com, stefanb@linux.ibm.com, 
	zohar@linux.ibm.com, kamrankhadijadj@gmail.com, andrii@kernel.org, 
	omosnace@redhat.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	xiujianfeng@huawei.com, wangweiyang2@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 1, 2024 at 12:02=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Mon, Apr 29, 2024 at 7:47=E2=80=AFAM felix <fuzhen5@huawei.com> wrote:
> >
> > From: Felix Fu <fuzhen5@huawei.com>
> >
> > The return value of security_inode_set(remove)xattr should
> > be 1. If it return 0, cap_inode_setxattr would not be
> > executed when no lsm exist, which is not what we expected,
> > any user could set some security.* xattr for a file.
> >
> > Before commit 260017f31a8c ("lsm: use default hook return
> > value in call_int_hook()") was approved, this issue would
> > still happened when lsm only include bpf, because bpf_lsm_
> > inode_setxattr return 0 by default which cause cap_inode_set
> > xattr to be not executed.
> >
> > Fixes: 260017f31a8c ("lsm: use default hook return value in call_int_ho=
ok()")
> > Signed-off-by: Felix Fu <fuzhen5@huawei.com>
> > ---
> >  include/linux/lsm_hook_defs.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Adding the LSM list as that is the important list for this patch.

It's also worth noting the discussion below from earlier this year.  I
just spent a little bit of time working on a different solution which
I personally find more acceptable; I'm building a test kernel now,
assuming it works I'll post it as a RFC.

https://lore.kernel.org/linux-security-module/20240129133058.1627971-1-omos=
nace@redhat.com/

--=20
paul-moore.com

