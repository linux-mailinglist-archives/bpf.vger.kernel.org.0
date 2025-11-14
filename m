Return-Path: <bpf+bounces-74596-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 783C6C5F91B
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 00:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 64CC4357E63
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 23:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C460306D58;
	Fri, 14 Nov 2025 23:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTHrX7wE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932A97261B
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 23:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763162062; cv=none; b=iWWb84/z0WzVhR4ycG01JVc2StOPzt3BNp1aqrPg6Ak2+V0FPWqXrdl5h5Lv/Ui4PHfHXB6Xdi9/AH6SCcsiJqnGHKoDR8+Jje6Zi0v8eAxBzuQRGAcIdnnhn5uqpcWK6EfOSCrG7IFj1GWX2/QTCmTH6L8g1wt6IhEoobZ8+sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763162062; c=relaxed/simple;
	bh=A8qRLw6Hbx66aMdXpwepwcyloa/AcKP/iENTuIPls8s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LWg6kXyfOWpPWs71ITsOumAf006p9DHlA7MQNHMiLTd7YXcaVlcToK4/+O/kbjkEgluEp9jBvVysKjityH070a0RnF3jrz0IwkY7EHCWbybWidR8A3hKjqhlsSeDgh/gKIcdr+TIpydsER3xGaP7GXpqjcJjwkdg1V5OtqY9TpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTHrX7wE; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-295548467c7so29013625ad.2
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 15:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763162061; x=1763766861; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A8qRLw6Hbx66aMdXpwepwcyloa/AcKP/iENTuIPls8s=;
        b=CTHrX7wEPI/m1IIoXRQ3H9HaAyQY8lmMB1sMEu4NdSjPxTqpMB8emNs6LRpMhMVOjO
         gcyaCU7cdKAyENfVke9oqQ8UFGXv13zwwIFGe1GdGSKznizsPT6cbsYpAF5D4dXjUcue
         /py29sIZZmOy7gmf9PQ7cf2h2PPsWjBFYmNDX1wMb3nQV2ZzvGuRIdCQvPwVdeFrgkVL
         yvuMKLGa/tGocwhv9VhqYpL2KzFissSCK4psPbRyFQxNAzMnIGWSgfmWgAjB3ABhe1nx
         LY4gbe8SFAs9krlWOlX0wxUPBGtylPyHs19NhZ4LswycmF7HeWsp1LMvuzXQK6oszrxQ
         80Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763162061; x=1763766861;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A8qRLw6Hbx66aMdXpwepwcyloa/AcKP/iENTuIPls8s=;
        b=isbpzUPh6ec+GDneC2A1lv9W+RVNVqQ6bIKNFoi1+UFeSgBVlEZsnog/iTM/rfkS5P
         00htRojQYls150FSiK3BpM2T+pNIVsbl1a46tr59GAvQBry7IPJxijGZLLxjWZgnq2is
         l28MNLKwSC3wXjj41NA8OqpTG4xEJPj0uMbSmcyE99eDqSE6Bv7UGEnLy6rh/h13b/aU
         R5797P1x4oGPqrm2hbKfnotxXTmAvzQSgoWKfb02N8R1yTmxAIg1FU8d/vQz7sLNdFxv
         Sj00/tBGc9dv8vO0psWqwVFR6Ln4+hSV5i8EmhuL8DQXiHWXbFNg/Hy5zc74fbUs47lP
         BeRA==
X-Forwarded-Encrypted: i=1; AJvYcCXc1w/6LFlwwA/CVxldW9P67s//zJ74XFRBXKZJYkPeIFXRBaKRThOk/WFvbRnLdipFssA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY2WHR2PbOATQ21eGyof7U5nUXZDIHNcMTRlcn/xqLFjKjGnb4
	o2EkMe8uYMlPbmrUB9VJqmY4avE/FiFJQBCev3UWckEjSaGC8ePxyxKj
X-Gm-Gg: ASbGnctp5TyZ4GgI9RG6VCoelvBIdCngeVvWhAkLlqc4Hef2NKdWNF6tOEb8FFyBrqg
	nofkNDTPJsll7O43L7Vi1i9lRg6E1g0K1IklNrzoeb1GHn8REFEbaUFsT5aBFtBSLFsUWtOqnx8
	EuhIZ5Ny1MoCOQmnLV8PNEVzvtKvy5NsCs4x/5S3uHLFpyRyguKP8EpdQJVRMlPZTfieXvTYIfm
	WPE3NRAmtSDVU8uw/nUUEF4MvYnCT5zGTABQnCWOlk6eXkWHEQDBnxXPA6fMW/xeZI5cJHGPyU1
	W7+C9UfgLwH8897YoThJb/egZPpSCgiA+jfh4TQP3htarQLoSK1cT4xJmFsUePEYIpAGURNmZl2
	ygxnzjUm2GzOYr+aIjNgSKfvBTtBbZeXnDbES6z+Fl3ZCBySDbcoPjzb280pjaH+mxgfoX49Y2F
	z/K1d9R4Ig
X-Google-Smtp-Source: AGHT+IHtj/37pOGhzlnTY8wvsuRbJHALTtQnc+ELdtezyZXGNgvBYtn0DBhI+HwI++mc37rCe/9e3Q==
X-Received: by 2002:a17:903:120a:b0:28e:756c:707e with SMTP id d9443c01a7336-2986a72e30emr53656965ad.33.1763162060818;
        Fri, 14 Nov 2025 15:14:20 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b9250cda04sm6206121b3a.19.2025.11.14.15.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 15:14:20 -0800 (PST)
Message-ID: <0d189513013887b93a3645f95d043965c3359840.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3] bpf: verifier: Move desc->imm setup to
 sort_kfunc_descs_by_imm_off()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau	 <martin.lau@kernel.org>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, 	kernel-team@meta.com
Date: Fri, 14 Nov 2025 15:14:17 -0800
In-Reply-To: <20251114154023.12801-1-puranjay@kernel.org>
References: <20251114154023.12801-1-puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-11-14 at 15:40 +0000, Puranjay Mohan wrote:
> Metadata about a kfunc call is added to the kfunc_tab in
> add_kfunc_call() but the call instruction itself could get removed by
> opt_remove_dead_code() later if it is not reachable.
>=20
> If the call instruction is removed, specialize_kfunc() is never called
> for it and the desc->imm in the kfunc_tab is never initialized for this
> kfunc call. In this case, sort_kfunc_descs_by_imm_off(env->prog); in
> do_misc_fixups() doesn't sort the table correctly.
> This is a problem for s390 as its JIT uses this table to find the
> addresses for kfuncs, and if this table is not sorted properly, JIT may
> fail to find addresses for valid kfunc calls.
>=20
> This was exposed by:
>=20
> commit d869d56ca848 ("bpf: verifier: refactor kfunc specialization")
>=20
> as before this commit, desc->imm was initialised in add_kfunc_call()
> which happens before dead code elimination.
>=20
> Move desc->imm setup down to sort_kfunc_descs_by_imm_off(), this fixes
> the problem and also saves us from having the same logic in
> add_kfunc_call() and specialize_kfunc().
>=20
> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

