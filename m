Return-Path: <bpf+bounces-29649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E078C4579
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 18:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97EE01C212F8
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 16:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4751BF2A;
	Mon, 13 May 2024 16:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HF/3HU8u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8901AACC
	for <bpf@vger.kernel.org>; Mon, 13 May 2024 16:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715619558; cv=none; b=o+VWWsso8iaU5nNmyWWcIhDR97032rWyv6T+/kzmEZbb4iWxxbNwzLvhaUR6i9geIRo8LTJGZ3sxmWBpmrJwdBO6EuSd0pARD86EXhMf4jYwl/nq1/kea35qkAKg1tai/VFSOhAKYqriS03SuHjnu2PwMGG+dxC1dkJk3r4PmCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715619558; c=relaxed/simple;
	bh=qyKi6Jw3QGYAEKKliSPzW2pGrT+hbPN2OeAqTjUlnoI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j1NhGnD4SB2FzWlG/PgYDHmUjUlWpqbPq+ECngSrG1vxHq4SpQWx/wnZjtuHsSUWun+sOieFBOaIQniqlaYELCR3sW9oUhCs4eM991dAotus8DsPm7FkIieBtYpNPJqW2a+Gyuf+HxltNq4pdFy6uE7Skjh+GOqv+lHlLn1rv2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HF/3HU8u; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6f4d6b7168eso2405410b3a.2
        for <bpf@vger.kernel.org>; Mon, 13 May 2024 09:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715619557; x=1716224357; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I8En5s7tAj5rKtf3o176/lsJFTHTJP/q13C2cv6iF0g=;
        b=HF/3HU8uBrPGG4iEQtkeSnfE5nYP+0xBAS5FW3YCkmXubX4ZgqNH6Ool82ipUE3emf
         cN8ogquHoATHMylqjetua+9DExE9bOVlIqcxTTtZZ7XE+PNP42HF0kPE2WMobyho8iw9
         5kiSt9veiiZqJNnubCu/fzy6EPtpq+uwDffQ78VesYQ5ne1EdLfdc8+HoulXJhuBATO5
         PIlxixB4c3j0z1E9lf4M0thAwPB1lwa4WiqWxuTfA8DERde3hsC2z/+T20/saX4fhiIR
         AUamDXAC/QJwyO9QlK9mj40SEc4AoPjSAC4If1qWfYMn+78XwzVU95AiwebVUx1yRr+C
         24aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715619557; x=1716224357;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I8En5s7tAj5rKtf3o176/lsJFTHTJP/q13C2cv6iF0g=;
        b=jIVdyGtE+qIY3/qMnc42/IPD3y6Kw+VJjYeyelWkt9tXJlQ7gJsYMz0/Umc8Mmj79b
         ZeEf4zSRtjbJKGdj064HZ8GGM+4su1dWXTl5jj52W1amOk3NRNL6IrLyY4o7bRYZ6Nr4
         In8VkeLSCs4+V+tzipz7VIN0fNGEhUv2eXjSOVn2sEwD4vFoYAMZINMaRUqdmXsnsApw
         1BSfdXvizTD451d2vwcJR95PFac+xEeF20eCdWd+RaBKbsM1CBnVOk2oIGrOcNImG8wa
         V8dawsGzzJiRHtJ7ndypOJzvZlSS4DVX9GO1E85AIe6PsfyPXlKCqASahY00vOiwVJaf
         LHjw==
X-Forwarded-Encrypted: i=1; AJvYcCUKhk2WSuT2GCH+1Oq5qGVuTAl5dIVhcUOp3A0vBpr4bPecdjlDg/Jf35cep0U/6UemD3vF4X7RZrUpHzU0qoLfb4T3
X-Gm-Message-State: AOJu0Ywh4bJQbQIHcjMf3uCcansr6rOE9J5Y0+Gc5p87O0YWSTKkQ8On
	1NhczXVdg+WB2mYm5DmbH4J7szG8B0kuz5ultPzcfE0RLiq6vl0M
X-Google-Smtp-Source: AGHT+IGic9opNq2lGSEJau46tEILr/yDxrYN4XdujQN5YemLWqbISdZKbIjzYTyPfcF+aG+wNErKpQ==
X-Received: by 2002:a05:6a00:4b0a:b0:6ea:ed70:46b4 with SMTP id d2e1a72fcca58-6f4e0385ed4mr10766931b3a.29.1715619556235;
        Mon, 13 May 2024 09:59:16 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160::3424? ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2ae0f7fsm7573558b3a.120.2024.05.13.09.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 09:59:15 -0700 (PDT)
Message-ID: <9ebe310153e4ac0f52ea861a857950686f5f6f77.camel@gmail.com>
Subject: Re: [PATCH v3 bpf-next 03/11] libbpf: add btf__parse_opts() API for
 flexible BTF parsing
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org,
 jolsa@kernel.org,  acme@redhat.com, quentin@isovalent.com
Cc: mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev,  song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com,  kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, houtao1@huawei.com,  bpf@vger.kernel.org,
 masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org
Date: Mon, 13 May 2024 09:59:14 -0700
In-Reply-To: <5e2acba0-5860-4e6d-8b5f-bb63bd4d89f8@oracle.com>
References: <20240510103052.850012-1-alan.maguire@oracle.com>
	 <20240510103052.850012-4-alan.maguire@oracle.com>
	 <e161fa605db9eea0f55ccc724051bda6bcc7d058.camel@gmail.com>
	 <5e2acba0-5860-4e6d-8b5f-bb63bd4d89f8@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-05-13 at 17:25 +0100, Alan Maguire wrote:
> On 11/05/2024 10:40, Eduard Zingerman wrote:
> > On Fri, 2024-05-10 at 11:30 +0100, Alan Maguire wrote:
> > > Options cover existing parsing scenarios (ELF, raw, retrieving
> > > .BTF.ext) and also allow specification of the ELF section name
> > > containing BTF.  This will allow consumers to retrieve BTF from
> > > .BTF.base sections (BTF_BASE_ELF_SEC) also.
> > >=20
> > > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > > ---
> >=20
> > For the sake of discussion, what are the benefits of adding
> > btf__parse_opts(), compared to modifying btf__parse() to check if
> > .BTF.base is present and acting accordingly?
> > btf__parse() already does a guess if passed argument is an ELF or a
> > RAW file, so such guessing semantics seems to be a natural extension.
>=20
> It's a good idea. The only thing I'd say against it is that we already
> have existing semantics there that are well-established, and the
> .BTF.base scenario will be relatively rare, yet the check would I think
> be a tax all .BTF-only cases will have to pay. We'd presumably check
> .BTF.base, and if not present check for .BTF. So all callers of
> btf__parse() when accessing .BTF sections would be checking for
> .BTF.base first.

You are talking about the cost of scanning all sections in the ELF file, ri=
ght?
It looks like btf.c:btf_parse_elf() already scans all sections once,
maybe this code could be re-organized slightly to parse the base
if .BTF.base section is present?
Does not seem that this would incur a measurable runtime cost.

Or do you have something else in mind?

> In that context, it seemed to make sense to support an explicit request
> for a specific section (via btf__parse_opts()) rather than inducing
> overhead in existing checks. But again, if the overhead isn't seen as an
> issue, we could absolutely do it.


