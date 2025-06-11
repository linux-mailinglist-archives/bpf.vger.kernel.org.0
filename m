Return-Path: <bpf+bounces-60349-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F1AAD5CBC
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 18:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01CD17AD6C0
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 16:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9AF20CCE5;
	Wed, 11 Jun 2025 16:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLuluV7/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25B92063D2
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 16:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749660930; cv=none; b=OveAioTTIhvfv5GsBwpaEUgBIGkYbDNZqev6tDr5B3YelT5q/g3nyHLgRNdUqoBwh6hR4KpN0lvWfWBM4j8fg7XNcA/+y2PNUDPw9g+IsQDZ4t8evHsF3wfWX6EDW0/V9TbSi1KpcLt3Ikhqh6yTQ8OWLkZWZF7TvgookeeD0UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749660930; c=relaxed/simple;
	bh=Xv6tvFakwJmTCAjL8YFGoEHqmk8dZREGM2vZmzyBtV0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AiVowXQTYxDv6uy9esIucXE4/mE++bWSj44nJeDWBaO83SeLO0SW0uxFTDiFDyidJ9CVpalMPDOhyDJQpxMUuDm1z0V15xTDLwC3XkBw+fwmJevcM3xdeKEHb/ZYles73ynZx8Tt6dqe2wOsBquSXMmYvOSscD4THGGIJhpVKZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RLuluV7/; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b2f645eba5dso927825a12.1
        for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 09:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749660928; x=1750265728; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6YUf1w+fEIWG11KY2DEoaOtB3/VrCBMJj5PHUfcMfuc=;
        b=RLuluV7/PVw2na81Pm3L7ivJ8ca8Bm1D+raWoRbMGI6wL4W858NXTdhlh+pJ2/J7jk
         IUvv8TxwouhfPk3NUKrTp741vu2Dv1zrQyeopdb3Duwg+QoyLUf/I5sgV4eopMo590o3
         7iLSAMAb0oAb5wBK+2zkbDDRLWnkRelA5+UVlNenKFyKcm1u7dTeq4/ywOsD/z9wol71
         GuRSwCulIWPgjpDf6JlY0GMC88l+8/NXvA9EUjQN82IxjjpfTdb/tyrxxD09MMuu1sQe
         BRWtOs+5OElUm0OAybBmLgjQo3kL+A3+9D7YoPjPFjN2as/RYoZnX8Nx3Lc5LdwUi1kV
         ++fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749660928; x=1750265728;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6YUf1w+fEIWG11KY2DEoaOtB3/VrCBMJj5PHUfcMfuc=;
        b=CqsQwR64JP5dt1EMviQV5JFjGCJSsoiLLJUFFNOh2fyNar0U8RLnNN2YrOvAyhOWY5
         964gyPPcBx6j9Q9d+i4aJw+zsvDofUZTTI5FyA0WawYxOD9tecNMc6f1sf9bB6OcbUaD
         6szxh7DCqvX1MzpFhEQcvdE00EBvP5R3awcbAgqNPVFNfoLp4I6r398bImJxWK43GbIN
         oO+shSYN0c7NjAkWnb9YsDLGqiCo0fzfhnYne2y26Herv6F/JNsT8OhKIudIJeClHfoK
         9zua6SE28zeQ5BNMR3kkqTwrKvMgTkPluCfWZVXg/CvJtg6plHjfzvUlkxpGgj4kEZ0P
         AgBg==
X-Forwarded-Encrypted: i=1; AJvYcCXQBr120UAzHUBMM10jCf43B3uvPJOoq4TXyEbT1PI/78UbXdFh8E/W+5LKsXGeAIbTZWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq+XBvnsQeZvFJydvepz2MPnqBHNNPWfKQ/QlCms48Ze4m7N0F
	qd+C57jVD1QXnUD/9hx1rCWfmur9o55SiDi5f7tB0DPhgtApQ+fZDTs7oykBuiYd
X-Gm-Gg: ASbGnctP2dtJAQ5jnnatY5STUJ1Q+VxFBSSAxZm2paAb4DaHpH9mSRcN5YnZYNscdGG
	uO1JmDZ53gF4rXKfAbo54NM7zlNgZfxTJvwy/GxjW5HRFbNfc7SbqG8x6vS6cZX6f1nZnsGynFo
	+xlUxxZoK3+FmnvOCJHvdJHIv3+acA9AF8u9MpjRvI1G+t4157UwU+BFI2D2uIY941t0luq6ANM
	dMSljTgGPOHBMK67ugWoz33wdomsTA1wijGsdQxxYywdj9KIx49ZwchoN16crPtklQDJVOzqdlk
	Y5vz3m3jbQD7qkqCc2uWmKd7RYptlJc5mljPnXZ5nCd8+W/aUTMmnI7CUATsBNAGMxOc
X-Google-Smtp-Source: AGHT+IH10aecWF2LpoIzcjU7kWkQ8k/uPvl8HI4GnnKbkkjkYfLQOFRiQUnZzGY+En3pthnpiDpUHQ==
X-Received: by 2002:a17:90b:3c09:b0:2ff:556f:bf9 with SMTP id 98e67ed59e1d1-313bfd7b08bmr232632a91.4.1749660927898;
        Wed, 11 Jun 2025 09:55:27 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::647? ([2620:10d:c090:600::1:4050])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313b201f6f8sm1541650a91.27.2025.06.11.09.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 09:55:27 -0700 (PDT)
Message-ID: <c2119657fe9047612ec066057ead9c6a95946183.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/3] selftests/bpf: support array presets in
 veristat
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Wed, 11 Jun 2025 09:55:25 -0700
In-Reply-To: <7914de29-4510-4eb2-8baf-31f131565877@gmail.com>
References: <20250610190840.1758122-1-mykyta.yatsenko5@gmail.com>
	 <20250610190840.1758122-3-mykyta.yatsenko5@gmail.com>
	 <4ff2fafb99131f599901580eac96dca34ca20cc0.camel@gmail.com>
	 <c1cb9bd3-c99d-4af3-bbcc-2ff3c2250ca1@gmail.com>
	 <8134154a25af0153411c263df923acd350253c25.camel@gmail.com>
	 <7914de29-4510-4eb2-8baf-31f131565877@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-06-11 at 14:32 +0100, Mykyta Yatsenko wrote:
> On 6/11/25 13:21, Eduard Zingerman wrote:
> > What do you think about a more recursive representation for presets?
> > E.g. as follows:
> >=20
> >    struct rvalue {
> >      long long i; /* use find_enum_value() at parse time to avoid union=
 */
> >    };
> >   =20
> >    struct lvalue {
> >      enum { VAR, FIELD, ARRAY } type;
> >      union {
> >        struct {
> >          char *name;
> >        } var;
> >        struct {
> >          struct lvalue *base;
> >          char *name;
> >        } field;
> >        struct {
> >          struct lvalue *base;
> >          struct rvalue index;
> >        } array;
> >      };
> >    };
> >   =20
> >    struct preset {
> >      struct lvalue *lv;
> >      struct rvalue rv;
> >    };
> >=20
> > It can handle matrices ("a[2][3]") and offset/type computation would
> > be a simple recursive function.
> >=20
> Yes, this looks cleaner, if we want to support multi-dimensional arrays,
> recursive representation works well.

I coded a scketch of an implementation [1] and it looks like for the
same amount of code or slightly less the support for multi-dimensional
arrays can be gained. And code looks a bit simpler, but that's subjective.

> A minor problem is that we don't have BTF at parsing time, so
> resolving enums early won't be possible.

My bad, the name of the enum constant would be necessary.

---

Anyways, I read through the code in this patch-set and am now
convinced that it works.

[1] https://gist.github.com/eddyz87/a96e6b2e1697f19f6e74c5621ecc48c2

