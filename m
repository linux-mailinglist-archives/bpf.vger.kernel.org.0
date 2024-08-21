Return-Path: <bpf+bounces-37781-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EAC95A7DE
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 00:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4172B284255
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 22:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE5817C22E;
	Wed, 21 Aug 2024 22:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHZVQAYA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967DA1779BC
	for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 22:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724279903; cv=none; b=PsAuyJVSYfP4IQAXM06LuLA8Ry4EKzjUwUre6ayYpU2jpRR7Pbff6SLokH1Q1ErpToh4bdniW2qWqlmVxvgFID72FBr5Ll7iIcLz9R9Pk2jNf9nhK9NJwM68Bhu2sTzbMvJ2xrUA1Qa692JzSjg/WQ3uJ44YoVtQhSF77E04OqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724279903; c=relaxed/simple;
	bh=VwpHKcCAjlMPHDfZtZ5SSUgfXCjLQYilD/sgbB7oE8w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uXFJu3Cgk13eQgI9AtMuhA3uPx0LHky5c/EBreR3sIV+9y5wyzRCU82gho2XoMHsHIElthJkszVPI9aK3f45Xr2a8dpgkhCfMNqcxrB0uNZRESKpAQX5d37KDaZqRENvg7O5fOuUpGmwW4CKqvLiVIxirrYmAdLHwslF9kaCvNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eHZVQAYA; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7142014d8dfso152394b3a.3
        for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 15:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724279902; x=1724884702; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VwpHKcCAjlMPHDfZtZ5SSUgfXCjLQYilD/sgbB7oE8w=;
        b=eHZVQAYAE9FdpErz7YcnizABsNuXBUajb0Ptfm02xcIMRSInMmvR9PgLUo+n011vuq
         l4XGt72RLQHw/hjD/OFCmHDY/bTkEj5UY2eSQPCepsOmDCmk3UroP0HrGNXM3SEEJiRV
         5aeupuXRgwjBOVgtlucI1+Sf0mVtmKSw/kJVQwIFnldzQMGiTyk1kQX1JWeeOqv3D103
         AieZUwbhLWDwSWfdI7XLAYgcIByXFF301h9sjkpH/AtLwQ2KgjzV+Ak04P6SlnFvNsiP
         j7qodPP8IUS6EvxJZUZiYOenrci5KYBTDpqHgKeHOwMew72ECO2rDWdVHnKFwqdP9qYM
         Tnog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724279902; x=1724884702;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VwpHKcCAjlMPHDfZtZ5SSUgfXCjLQYilD/sgbB7oE8w=;
        b=ru4NiBtExaCtpu/WYcX0PrYZL5050WkY+PDRPRHMwFcZBUUdTS5p4UEfMbb05L5f//
         Exuw3q3gyn01lVYCsz7TyzSSBjBEylt6myCVh5JE7SfQQ5Cs88d6iG+YsbghVjswPFSg
         bhvjOfY2L3/UZJHzVM9k2eL0ZEPdu7IbSr23e0WENOcryPs+AO9z4XIyb5hjofeLnjCZ
         4HUFVeX7nha2Lnn9onzZSR6KbkMjRyeFXiHUlBvSzIYFy3f9gubInlqPTs9AsLLVy7bu
         N8ymhNP94y/oVJMn7XxM697jUGVfKEtgBA5Am5vv3Amhv4iclqk3OT5nbDBwx1aJHdgf
         NDxg==
X-Gm-Message-State: AOJu0YzLNuVzA6DMNYCVpTvCDcytYKi1SCWQYwKuH9Na4COFME52csaR
	l6+89jvz91Sa8NCkjx3ZTJ/r7cPCYwK3fT8Iwm0bBaJHv+5G/gaA
X-Google-Smtp-Source: AGHT+IEXkaG/8Ijv5AAclWq4UvKENyc06HQSUFpVNzlx4CBXMHJspuGGzuAyTSK/+sdMgC0Z64Dg6g==
X-Received: by 2002:a05:6a00:1aca:b0:710:7efe:a870 with SMTP id d2e1a72fcca58-7143670f497mr14611b3a.19.1724279901771;
        Wed, 21 Aug 2024 15:38:21 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143424f942sm159902b3a.65.2024.08.21.15.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 15:38:21 -0700 (PDT)
Message-ID: <d3d8f8e7c357404143f6fae6f4ac077c404821d2.camel@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: bpf_core_calc_relo_insn() should verify
 relocation type id
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, ast@kernel.org
Cc: bpf@vger.kernel.org, andrii@kernel.org, daniel@iogearbox.net, 
 martin.lau@linux.dev, kernel-team@fb.com, yonghong.song@linux.dev, Liu
 RuiTong <cnitlrt@gmail.com>
Date: Wed, 21 Aug 2024 15:38:16 -0700
In-Reply-To: <b377eda1c4cd9d6c4ad1c3d6cbed9cb1e14242f9.camel@gmail.com>
References: <20240821164620.1056362-1-eddyz87@gmail.com>
	 <CAEf4BzYxrD-sEe2UE7HBFBAOxd1gW9cYLwjxjTKH8_vdxQzO_Q@mail.gmail.com>
	 <a36a3307e4102c8f05df4e1d9fd44fc7b4f77c32.camel@gmail.com>
	 <CAEf4BzZ9sYeYANVNd1RDZWc_4EqS4cpsc+DfSqnLBp9Qfh0VaA@mail.gmail.com>
	 <98527d7adc2cc4880524caecc2f6e6d022bac210.camel@gmail.com>
	 <CAEf4Bza9Y-JO0MeomB9S+6tOr-rRp0kDe_-1_tf2ArNddfUEpA@mail.gmail.com>
	 <b377eda1c4cd9d6c4ad1c3d6cbed9cb1e14242f9.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-08-21 at 15:32 -0700, Eduard Zingerman wrote:

[...]

> Just spent more than an hour trying to figure out why passing real
> program name (char *) does not work.
> I'll think on a refactoring, but that is for another series.

I passed env->prog->aux->name there, and pr_warn caused corruption
of the aux structure. Sigh.


