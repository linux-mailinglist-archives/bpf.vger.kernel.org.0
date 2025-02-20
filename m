Return-Path: <bpf+bounces-52112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B313A3E81B
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 00:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4985422F74
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 23:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D5026562A;
	Thu, 20 Feb 2025 23:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/vwstI0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E567D1EB1B9
	for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 23:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740093051; cv=none; b=tIF9rIRC0Kn8wrz3R4CVn4lA54b8WAUWNVDYxUPFRlgC0w9sIoXRY1nScoL0fnxIIoQnMRr+L1LLYINcJh7kiRdkGd3OPaRrUhBrOjb+DmpU+4XaRYLuKTHnP8ibng4SeyHORvNh8g5X6CzSdLZCcVaBOy55wkIhardXldKx4PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740093051; c=relaxed/simple;
	bh=mMEibHhv+CwC8KNgx2lNVWiZHzhShjHPnes7h3xE/w4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FJ8klkcnqjJ8g6Jfk7YzXbChCpjBZwkyynWbQ1kzvvEX1LzOWGGB5SWTk9uYAKz+naMIa5CCIr5dsAW7gCAos5lPaF+Gawzy3mGNgV2AndC3kPgDeuRdK5F/6HCuRD4+pxQ9BfIJj/AER+pZIBLv95PJ7aCGSVyNlPB9xMn8CN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/vwstI0; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-220d398bea9so22127675ad.3
        for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 15:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740093049; x=1740697849; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ck3LYCddOV6FPxSYm6WNrH9Cl/UlQk6rqr6NfxvdeVA=;
        b=Q/vwstI0Bk7LyZjgMePzo7LUo0IaewcJYr/jvwizZ7Rsh1YaoVCeZTK5TYGbj/CNyQ
         h9CnhZU2matw7v5Y1MU+1HXwZU9SYjtJwTdZQBYs19hiC/DWopPg7YRDKQmsYqqQG1jA
         QPUO78iLgEQPOfImhjHQnesv6WD8EfgN/Uwwj7hwqjG9WQs95mLdLWGKiPwOHFMK5Mw6
         zEEQ2dTh0Skj7W0spz4AsDMp0VriARETJeha7byaQ5q9LByucNYGOQWFjGL8y48SKxgy
         cNOH0Lk6ch9E+GvgFXXxVqwdsoITQopADR0fF8z7tcBQ17trJiIGfoy6IdchrB77RpXI
         g3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740093049; x=1740697849;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ck3LYCddOV6FPxSYm6WNrH9Cl/UlQk6rqr6NfxvdeVA=;
        b=mtJaTGQnWJpGk1J7T/60UbG4FViVtLPzdMtAwlA9gUFgwJXzGbrqPuKKQzGinyoOdq
         jA0R/yBmZIzpaOpSohFcKzRv1QYy3vWK+w0wdgcb0clAjPn+Xz/ghQ+0WzJkGa8FTyXH
         06SliwOO4DfRJMwJmUCc/bFZfyy2GQC/HX6sWZQPK/EI/hfsfhe/FqXXQ6bVAZLHKgR+
         nKe4KC4TlDEApeb8Sx3RBqC1r5RM78Rbkq1I+AzzL25GBY/UNTPBajTkmcE81xDILbtM
         70LS6/FJ4SE4Gjhdht7CpfEvPjcH/L2bjn6zbjgvG6Q/jMGFkZMEcqLtLSDAN3bQShBm
         J2bw==
X-Forwarded-Encrypted: i=1; AJvYcCUw6zuIiw+AD10swLqszZeyoy4aBkmV9ydATjh/+P8P60XkvBZ5JaC4PY+alpMZMFv45VA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFY/AbVq6Y5B47X5Zoi+LSPAPXCqVV7FGmJXrYBgSKtYOVHK91
	q+qUmhGj2dLK5uKw2613b3Y21ghCetK61b3CJjnVGjNF6/XO2hrU
X-Gm-Gg: ASbGncu88AuLHfkkSrS+DCP6WeUw2899p/drnj/0GRiaIe8zuzKWqCSbSq3FTNDQHea
	lFGM5lmfpAJ9tQIR5zmHzgNLKxKVz2XcpvvkcDvkddAj2N4wLUsaMsleKf8y4T0WGvGwCy8KZBO
	X+m3SP69TBQGZ8uNsx/pue0RcyNuRvEJtmTtpmSPqIyWPaqE6KMA8pYXeid9Lbu3ftALdTw5bGB
	tzmziG8qpLm52eNF05pV6aexBzLql24LuK2Sj9ZaboeJMSCE8ZnA3KfcFiHIZeQla8lPKmHBa1E
	MjDcQNZw4v9m
X-Google-Smtp-Source: AGHT+IG0NPgogFgRzANt80DEOVH0sU1ZoU+mU862IrliX+mKJwEW58GZAQcPArGIqLbREMwGKbJI9w==
X-Received: by 2002:a17:903:2f8f:b0:220:d7f9:9ea8 with SMTP id d9443c01a7336-221a10ee47amr7302525ad.26.1740093048797;
        Thu, 20 Feb 2025 15:10:48 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324244d5bbsm14215807b3a.0.2025.02.20.15.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 15:10:48 -0800 (PST)
Message-ID: <e83d842e9f6c5cb6f98fd8cb760ec1c8e17e419a.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Test gen_pro/epilogue
 that generate kfuncs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, alexei.starovoitov@gmail.com, 
	martin.lau@kernel.org, kernel-team@meta.com
Date: Thu, 20 Feb 2025 15:10:43 -0800
In-Reply-To: <20250220212532.783859-2-ameryhung@gmail.com>
References: <20250220212532.783859-1-ameryhung@gmail.com>
	 <20250220212532.783859-2-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-02-20 at 13:25 -0800, Amery Hung wrote:

[...]

Given that prologue and epilogue generation is already tested,
it appears that it would be sufficient to add only two tests:
'test_kfunc_pro_epilogue' / 'syscall_pro_epilogue'.
Not sure if testing prologue and epilogue generation separately adds
much value in this context, wdyt?

[...]

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 6c296ff551e0..ddebab05934f 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -606,6 +606,7 @@ s32 bpf_find_btf_id(const char *name, u32 kind, struc=
t btf **btf_p)
>  	spin_unlock_bh(&btf_idr_lock);
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(bpf_find_btf_id);

I think this is not necessary, see below.

[...]

> @@ -1410,6 +1493,13 @@ static void st_ops_unreg(void *kdata, struct bpf_l=
ink *link)
> =20
>  static int st_ops_init(struct btf *btf)
>  {
> +	struct btf *kfunc_btf;
> +
> +	bpf_cgroup_from_id_id =3D bpf_find_btf_id("bpf_cgroup_from_id", BTF_KIN=
D_FUNC, &kfunc_btf);
> +	bpf_cgroup_release_id =3D bpf_find_btf_id("bpf_cgroup_release", BTF_KIN=
D_FUNC, &kfunc_btf);

Maybe use BTF_ID_LIST for this?
E.g. BTF_ID_LIST(bpf_testmod_dtor_ids) in this file, or
     BTF_ID_LIST(special_kfunc_list) in verifier.c?

(Just in case, sorry if you know this already,
 BTF_ID_LIST declares are set of symbols with special suffix/prefix,
 at build time tools/bpf/resolve_btfids looks for such symbols and patches
 their values to correspond to BTF ids of specified functions and structure=
s).

> +	if (!bpf_cgroup_from_id_id || !bpf_cgroup_release_id)
> +		return -EINVAL;
> +
>  	return 0;
>  }
> =20



