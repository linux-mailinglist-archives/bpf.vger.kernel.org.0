Return-Path: <bpf+bounces-29974-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B72B8C8D87
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 23:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 199982818ED
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 21:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C43D3C489;
	Fri, 17 May 2024 21:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPteD+iY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD24A1A2C20
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 21:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715980169; cv=none; b=jf51Cr8PvUh9IDvc5j4VBZfQBQ9ZYC6s19OdYgQVbI3jdgKyLW/TQGpvs401VzysrtkjYCCl7SbtZl9l0tywlnXGMD2IOXAL7cnahsRMmWXADuqI0l1Fp/vRHWSSydz/MlXtZ5MW9uiDwAB6Pj/AVkvA2qAl7czLo8JBcfEJh98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715980169; c=relaxed/simple;
	bh=RYihW01ykllOBfYBYSAHPiL1TtA0huMEWUUZ4Yoryjw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AshcM4belXmTttuoFTgHk7aZ5RCJlT2sV49iJfmwWhDY7TtW8GvzepkMMPek7rc4AZ+lCBOT9mmkhaiu3/hcHDoFtWs6zQ9LayQhUTnGOgiB8ca1arsYgzrYNvePPjkyuV8QX01O0MWTpM3961XV4Fjq86urVLgfRrkTcAdhvTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPteD+iY; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ee5235f5c9so21925745ad.2
        for <bpf@vger.kernel.org>; Fri, 17 May 2024 14:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715980167; x=1716584967; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5dTw3MelLgS/tHqB0Dj9EtJCPQCqjgyrlgrzMHGs4Jc=;
        b=jPteD+iYu3F13rI5LvQMcA177HBbvrOp8WWjxQLmFjzobCCj9d+fU9WNqi2Kl/jxii
         eOpdZKfYueTlidxv8NDlYkl88kd7psgtz6udhu9WZknEtxB90Nx43G2lmxNj+jA0xGzw
         mPC8eyL9A3IeiJlOjYokBBu0bVHfpn3t6WSm0pZp3GeCG1A8GTMkwuOQetoTv/OCxeKU
         3P6hHFmk+Gt4eyNBcKECf1J1OwAIJuwq0YzDB21FQBg27awOWaluIKAJDCvh4yxfI/iB
         Yf1CpDlRJka3uQDUc0dUey2H7TbJMSNcPJ/e/tMCXoBFcX66ruq+DZ5Uk11TpXkR5WzX
         dfCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715980167; x=1716584967;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5dTw3MelLgS/tHqB0Dj9EtJCPQCqjgyrlgrzMHGs4Jc=;
        b=YApAONycEFYPaPsPsHA3IahPe+wbRhUVqn1s+sehQBtTML494kNuROtlCuD3onD0K7
         BNm3f0/nMQ2pylnerZjMK84D0n7Bcm23TVbGgKG5QYcvukVhQvApIUHg5h0/OZvNR4Jt
         soDvvbaZfvxg2yu6Y7xQaMcvMh1bPUBUIUWphe0KKJpYQC6UtithAgpF9lU6mtvR6nPc
         g+1oaopcXDgXTRnUG5zsFit68Y8ZhOQekZM3ToUEmrIBm4dy3AUXb48Z7smP/hlSS5Eb
         poghhgq6S9+eATcWnGoofjmWdDupavvj1Mpf/ySYhoP++Hu9Fc6xfWy6ASRd0XmHcbz1
         xe3A==
X-Forwarded-Encrypted: i=1; AJvYcCWz/gocUu/OxpTdyol2n7sWEq203adJHWQ/ZJoO125A9cj3BwFHdV4NzeG2+vXqkKadO39CFjZMvJ05vhQoo3qU1NJk
X-Gm-Message-State: AOJu0YzN6pHeY4aBMddixaVBNF/m1Q0FpR5YSJTV9QJZYnCeb+QIcp8n
	N2Bg8s0kDxrW0M2UWYLJISH+M/z2E2lUQ9VHyD84H/SnN4KWi0xR
X-Google-Smtp-Source: AGHT+IEk0DUWhcge0DvoC2wcasaHbR6ntvkErQLdaOqTHglZf9Z+3vzsz1PFG5C5I3HguyeJ2VApWA==
X-Received: by 2002:a17:902:d485:b0:1e4:200e:9c2b with SMTP id d9443c01a7336-1ef43d15794mr299602825ad.21.1715980166976;
        Fri, 17 May 2024 14:09:26 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160::3424? ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bad8a89sm161767995ad.102.2024.05.17.14.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 14:09:26 -0700 (PDT)
Message-ID: <4df9f4e6357cc0c8e1b2d3ad0384bee164571399.camel@gmail.com>
Subject: Re: [PATCH v4 bpf-next 00/11] bpf: support resilient split BTF
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org,
 jolsa@kernel.org,  acme@redhat.com, quentin@isovalent.com
Cc: mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev,  song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com,  kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, houtao1@huawei.com,  bpf@vger.kernel.org,
 masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org
Date: Fri, 17 May 2024 14:09:25 -0700
In-Reply-To: <20240517102246.4070184-1-alan.maguire@oracle.com>
References: <20240517102246.4070184-1-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-05-17 at 11:22 +0100, Alan Maguire wrote:
[...]

> Changes since v3[3]:
>=20
> - distill now checks for duplicate-named struct/unions and records
>   them as a sized struct/union to help identify which of the
>   multiple base BTF structs/unions it refers to (Eduard, patch 1)

Hi Alan,

Sorry, a little bit more on this topic.
- In patch #1 two kinds of structs get BTF_KIND_STRUCT declaration
  with size: those embedded and those with ambiguous name.
- In patch #7 btf_relocate_map_distilled_base() unconditionally
  requires size field for BTF_KIND_STRUCT to match.

This might hinder portability in the following scenario:
- base type is referred to only by pointer;
- base type has ambiguous name (in the old kernel used for base BTF
  generation);
- base type size is different in the new kernel when module is loaded.

There is also a scenario when type name is not ambiguous in the old
kernel, but becomes ambiguous in the new kernel.

So, what I had in mind when commented in v3 was:
- if distilled base has FWD for a structure and an ambiguous name,
  fail to relocate;
- if distilled base has STRUCT for a structure, find a unique pair
  name/size or fail to relocate.

This covers scenario #1 but ignores scenario #2 and requires minimal
changes for v3 design.

An alternative would be to e.g. keep STRUCT with size for all
structures in the base BTF and to compute "embedded" flag during
relocation:
- if distilled base STRUCT is embedded, search for a unique pair
  name/size or fail to relocate;
- if distilled base STRUCT is not embedded, search for a uniquely
  named struct, if that fails search for a unique pair name/size,
  or fail to relocate.

If we consider above to much of a hassle, I think v3 design + size
check for STRUCT is better because it is a bit simpler.

Wdyt?

[...]

