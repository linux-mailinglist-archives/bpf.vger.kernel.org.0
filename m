Return-Path: <bpf+bounces-47825-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1E6A00423
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 07:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 003011883E34
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 06:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E22C187555;
	Fri,  3 Jan 2025 06:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cP2V122T"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B339A17ADE8
	for <bpf@vger.kernel.org>; Fri,  3 Jan 2025 06:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735884859; cv=none; b=PxQn34ZAku2uu+5ZKDr78VEG7Vzf6WChu6cKQ0raF5tSeLc0zFJCqC8UhKhCha5TVxoiH5fzH9mNu+OpT309S1F5cRYDEnDN6dOMC+HlaqbrGsY2Du1wj+gyL0Jpr51fKX0w5xkZjXA1ih7nUhsbZuawtgyPB65wrZs9yIZNgas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735884859; c=relaxed/simple;
	bh=nlqeCGNpq1oMRCbrASyk8ibIyJazXtYq7ov8QXhTUbs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t6pC+h/lU+tE7ApmpsVCwEmhZbH0nGeJVGQ/FuAYPM46bvvQGaOPyfm+raIncNEVV1p75s3H1UpWJ+3WLPmc2KEM0me3BWVRiy9P5vecxLj6OjMeJ2FR4Jp7upnIMtGT4KzwM+kfVu0Z+VpdQlNu4C9XO0r8SCVReKQmNLyKrrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cP2V122T; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2efded08c79so13102889a91.0
        for <bpf@vger.kernel.org>; Thu, 02 Jan 2025 22:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735884857; x=1736489657; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sd1I5975qN4ROoRiBvkff6lGmiH8e0keopNk1F02+hc=;
        b=cP2V122T3yPm8IAlTXdQez7wHyssmVIlkp4b5BoTwHzGAd8VkUjFpDwI3M0heaI8g0
         QZN8UNxwWVZr9o6+BRObezI/RYuST4MMOMMOpXldAYe8FwWGEg9xKcbNP9ChqynlWIg9
         LLAxNBKgBZgmqeC5JRqh7bcjzMPvwdVbAHmpu8kIm3+Su8cHkTbCc7QwtqO0uRib3Rfc
         rtA3YykwS8T2gudi1gzqY1Uy2q11aIBouON9fc8Ynia5iS4gzv3Nwcgg1LYKVXufNhAO
         KI7irhVCGhVI73zbv8xmIS2wGpRzFAEcQY8KWSLQ+5db0W1qxNLvpc6SC4E4xAIxt+nt
         5gEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735884857; x=1736489657;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sd1I5975qN4ROoRiBvkff6lGmiH8e0keopNk1F02+hc=;
        b=T/nJ1bSOoE1UBdquOeZ/0PIMJQTSbB9jddRpVA+gcYaneFxyg6yWhX5AWIj/7TMiWJ
         +7ZliUpkRlz/A+k1J8h4KlFWSo498Dq5b37WBHhQtbdOPWr9B09Nash3UG03tlkKulZM
         8KHH6lNYQuzWPCkgNReqq8+SvOuncGvtvx99Xgc/Mqv9JvzZJfm2s8MuaohAjKFzzIYw
         n5mzJRmdCDSD4x0rp0RRE+b675oJXaCSwZKpz90EJ+4IXbICQa8um8+kjs78dV92bm/7
         kyrwaOEdHf3S0cqajUTBj9MbqYmpzKqfG5r7dgMl6y6xBRl6QNK4i2ey4bxgOKkvsnoR
         ndEA==
X-Forwarded-Encrypted: i=1; AJvYcCV5gnF5d5DBMIXd+quzIIbqkr4pM5LpKovwG1m3TmNwVeLUzuQurmYkgM0ZvnYpJABhagI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqbsrpMSirP/WYwnyLmMg+tcJYo3fcDixNCSSOvAoiIlnPeNVd
	LEmeaEotSoUlRhWFehFqM/wJqD+CZQIpn+H/qbWKDkJLuouIcnW0
X-Gm-Gg: ASbGncupOopaM1J/HMSP7vvsIig7N8TP0h0o5WLeZgnTsDmVPSEhujJE75jpXOIOSLt
	leCZONfVII4Ur+pE8MA5ZObyNvNfgD9cEhPg6CSjLZm1Ooq4baiPz5TbClY/ZqCEMEyIn1CSdET
	120ovPCY1ZkiVWo3Jt+5Uapm7ZmWCY/4z2knJPOLcPdzDbGSyIBPdtWehtLbCTb6qhlrfODlnDw
	XpzpXAaZ9fsZHypmbTsslPfwINFqW9VbMzLttQ99ruIoFYQkNgfjw==
X-Google-Smtp-Source: AGHT+IES6TC7PAgz0XGZ4/CMW4eFEu4nACkMRwnA3X7dEHZJyxlS88HkbAfT0MkE99KX3rf8ZsHpsA==
X-Received: by 2002:a17:90b:3cd0:b0:2ee:a76a:830 with SMTP id 98e67ed59e1d1-2f452eb3279mr74319999a91.24.1735884856855;
        Thu, 02 Jan 2025 22:14:16 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ee26b131sm32444673a91.44.2025.01.02.22.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 22:14:16 -0800 (PST)
Message-ID: <1983b3bd389865ddf33d80e9a990c6749eae29b9.camel@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Reject struct_ops registration that uses
 module ptr and the module btf_id is missing
From: Eduard Zingerman <eddyz87@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@meta.com, Robert Morris <rtm@csail.mit.edu>
Date: Thu, 02 Jan 2025 22:14:11 -0800
In-Reply-To: <20241220201818.127152-1-martin.lau@linux.dev>
References: <20241220201818.127152-1-martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-12-20 at 12:18 -0800, Martin KaFai Lau wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
>=20
> There is a UAF report in the bpf_struct_ops when CONFIG_MODULES=3Dn.
> In particular, the report is on tcp_congestion_ops that has
> a "struct module *owner" member.
>=20
> For struct_ops that has a "struct module *owner" member,
> it can be extended either by the regular kernel module or
> by the bpf_struct_ops. bpf_try_module_get() will be used
> to do the refcounting and different refcount is done
> based on the owner pointer. When CONFIG_MODULES=3Dn,
> the btf_id of the "struct module" is missing:
>=20
> WARN: resolve_btfids: unresolved symbol module
>=20
> Thus, the bpf_try_module_get() cannot do the correct refcounting.
>=20
> Not all subsystem's struct_ops requires the "struct module *owner" member=
.
> e.g. the recent sched_ext_ops.
>=20
> This patch is to disable bpf_struct_ops registration if
> the struct_ops has the "struct module *" member and the
> "struct module" btf_id is missing. The btf_type_is_fwd() helper
> is moved to the btf.h header file for this test.
>=20
> This has happened since the beginning of bpf_struct_ops which has gone
> through many changes. The Fixes tag is set to a recent commit that this
> patch can apply cleanly. Considering CONFIG_MODULES=3Dn is not
> common and the age of the issue, targeting for bpf-next also.
>=20
> Fixes: 1611603537a4 ("bpf: Create argument information for nullable argum=
ents.")
> Reported-by: Robert Morris <rtm@csail.mit.edu>
> Closes: https://lore.kernel.org/bpf/74665.1733669976@localhost/
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> ---

Looks like this fix had not landed yet.
I tried it and id does fix the error reported in the "closes" link.

Tested-by: Eduard Zingerman <eddyz87@gmail.com>

It was a bit hard for me to figure out what went wrong from the description=
,
could you please double-check my understanding below?
- when struct_ops program is attached,
  bpf_struct_ops_map_update_elem() scans every member of specific
  struct_ops type (e.g. struct tcp_congestion_ops) looking for fields
  with type 'struct module *';
- to find these fields BTF id of 'struct module' is used, this id does
  not exist when CONFIG_MODULES=3Dn, bpf_struct_ops_map_update_elem()
  does not check if 'struct module' BTF id is non-zero;
- bpf_struct_ops_map_update_elem() initializes 'struct module *'
  fields using a magic value BPF_MODULE_OWNER, this initialization
  would not happen if fields are not found;
- later bpf_try_module_get() is called by code specific to particular
  struct_ops, e.g. from tcp_cong.c:tcp_assign_congestion_control();
- the bpf_try_module_get() is implemented as follows:

    static inline bool bpf_try_module_get(const void *data, struct module *=
owner)
    {
    	if (owner =3D=3D BPF_MODULE_OWNER)
    		return bpf_struct_ops_get(data);
    	else
    		return try_module_get(owner);
    }

  if 'struct module *' fields are not correctly initialized as BPF_MODULE_O=
WNER
  the bpf_try_module_get() executes try_module_get() passing a bogus pointe=
r to it.

Assuming the above is correct, the fix lgtm.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]



