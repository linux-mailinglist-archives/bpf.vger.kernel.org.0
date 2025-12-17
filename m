Return-Path: <bpf+bounces-76798-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC791CC59DF
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 01:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E75DE30393E6
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 00:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864E61F2B8D;
	Wed, 17 Dec 2025 00:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4YNLilq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03D21F0E25
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 00:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765932086; cv=none; b=qFdISsnU/3kNtYApwMH4mUetqEmq1ry5yZ9ublIcCxiy3/2l60K3Vd6IY5/a1bvN/7qHLPU8D/2Ltk9TD/6c5kGfAMbtodEYKcNVXhVpg14wJE6ACasOjILRVGas1OHCMQkWAwRiA7LkIElb3a2QKekIVC1YPWOagBL7vxAGFR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765932086; c=relaxed/simple;
	bh=ninaJWdnIK06+iT96Vj3+pZfsK5FwStkXwysNvvxo/w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cH5wF1DmpTvRiwBg87D9Oh0HxUJBCA843sajGjFULLsdX7AwdhFFpKxQP5PW/KsIvlRjSxeGo2e86dUHEEPvWI/ds6sZLTXTjmzHzN86XorluG6X1JB9hecRlf685oB3tijcD1E9p+NREtqP4jxPdUwC7oNOIMeSClMs4eqPCZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4YNLilq; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-29f0f875bc5so68611435ad.3
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 16:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765932084; x=1766536884; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eKRhCHqA4KzJ3KzT8dj/A13zB0iHy0mo0XKuZrhq1e8=;
        b=l4YNLilqer8qtRGuw/Ptzup2NfPiBDMXYw3OTsn79/0NvGKphQb4IhtLLp9V5084Ci
         isUFHy6V9NrZUTZAmpdeCHsYn7atFlYxJkdO+jd0gfEQDEd/9VzC3PQc0WIBtF9QvcZg
         2k2o9g6NN879X32uzp0lgrCeMt2+D/YICOWgPO4SLrhMPWZ8/Cv86UcAaT2NC+pGtn76
         acucKdwKmi98ER/TT+NQFRLb507liKDxQ1lbtCdARbXjdXgz4YeirKHqo/obMj5uJvaI
         LYOloAoH2jMkfAPrn0BhpB5kOJsQrrQX4ve2VYLAS77NljaedCEj7WCcLp3ugl1N+0DU
         /oVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765932084; x=1766536884;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eKRhCHqA4KzJ3KzT8dj/A13zB0iHy0mo0XKuZrhq1e8=;
        b=RPDaFq8+iEG95rPGy1Inci/DdhpQJrp3I2+ODzTr5gtlvIbZcZp61YmNT6Wim9osdd
         +hK4CXc9nN4kMPoeK5beiod8O52Tve9hgaPMIFswVfjhAV6yspIKayTZXbhOhnT3xJA8
         tvqbBBKgM8GeAiSvyJvnse2lNMhp9PheEyGBw1su6k0OjvdhAIyuJ+UtmnnlhSzVdrhV
         XIyVpKfOvEuwkf2lH2oWGcqN8r7xmbUBAwE0xZOq3xIi67WcISacvkgiBWwNo9teeBaF
         D3LKDxNfZF7x+iixZ6g2YDOTjRK9a+CoaJUwwaADv/8uV5mwLfC1gXIn6B/8hb77eU9P
         VdaQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2jJWcO4rF9TSCMe+6qCrRaj1cLSfEPVIlZYl5NMQP3HORacQD8tIja70z/vGCQp8MPDo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz7Q3KeoSfrSa4vyWc8id80KmEt/F21YixXNgD0KKRkCFKMxM0
	9mnQ8tYPcaI8rrk93WWkI6gfbSZkvfrCVS1bfYes4LnUwuce6joFT9Fz
X-Gm-Gg: AY/fxX5iZaqhx/enLkV/qA9rLkEo5ew4krpfZVA++2xoU/giyo2gcdSSQEA0lJ1+d+/
	TXVZSGJx4dutAr+xdhJzJa6he7ThhbaEEuZlkPtU1eSq83HFR+8RN7iLcoHCaXJfddg4IXsOlun
	SxV192a11Qwe59UqI9Bb54erfo1MuYuo1nv1PnhJ4CsPjCMX+D8Dt32aKZple4/VItLrjhXCDEN
	6FpWPgukbKGFKF9e8WtzfrGfaor3qf49eyM1ztUGXD2kcDMUocm8l+llIKucIRkUpBzVkKPyxdb
	Q2V7cnXksFwyKIKUNccxUujuHUrAOfCUjDJMaZc3lkS3scf5Wxo+L6kFOlAjeMwvPd6bvODGIcz
	kxQXENotnqvuZIIHC9kFnq+OnVffq9HgUZ7JAGet3eoo2jUAAkq8F02zLQO2DQr/IKczdO9/ME0
	hJfAOg10s2
X-Google-Smtp-Source: AGHT+IFLeEs4RQ4HKsSGG45v2vMCHtUkq0Vepx7Y0PLR1Pwx84tCrqcuQuv2SL91zgYgBjbFdD8ZOg==
X-Received: by 2002:a17:903:1a2b:b0:29f:299a:b6e2 with SMTP id d9443c01a7336-29f299ac2e2mr141225835ad.42.1765932083810;
        Tue, 16 Dec 2025 16:41:23 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a0833e24easm122971895ad.100.2025.12.16.16.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 16:41:23 -0800 (PST)
Message-ID: <0244da50ae77dfab30a8e49514761f5bba147768.camel@gmail.com>
Subject: Re: [PATCH bpf-next v9 07/10] btf: Verify BTF Sorting
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org, 
	andrii.nakryiko@gmail.com
Cc: zhangxiaoqin@xiaomi.com, ihor.solodrai@linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, pengdonglin
	 <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Date: Tue, 16 Dec 2025 16:41:20 -0800
In-Reply-To: <CAErzpms9K8h=76K9=SK_BmhR4hYetrztFpuQ8h8Q4HSZPguUng@mail.gmail.com>
References: <20251208062353.1702672-1-dolinux.peng@gmail.com>
	 <20251208062353.1702672-8-dolinux.peng@gmail.com>
	 <CAErzpms9K8h=76K9=SK_BmhR4hYetrztFpuQ8h8Q4HSZPguUng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-12-09 at 11:21 +0800, Donglin Peng wrote:

[...]

> > @@ -5889,6 +5943,8 @@ static struct btf *btf_parse(const union bpf_attr=
 *attr, bpfptr_t uattr, u32 uat
> >         if (err)
> >                 goto errout;
> >=20
> > +       btf_check_sorted(btf);
>=20
> I think there is no need to check sorting here, because the BTF in this
> code path is generated by the compiler. We only need to cover the cases
> of vmlinux and kernel module BTF.

Idk, we can teach compiler to sort BTF types one day.
Having this call shouldn't incur too much overhead, right?

> > +
> >         struct_meta_tab =3D btf_parse_struct_metas(&env->log, btf);
> >         if (IS_ERR(struct_meta_tab)) {
> >                 err =3D PTR_ERR(struct_meta_tab);

[...]

