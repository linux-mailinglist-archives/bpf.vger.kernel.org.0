Return-Path: <bpf+bounces-45888-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 435AD9DECBC
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 21:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89968B21738
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 20:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206D715B547;
	Fri, 29 Nov 2024 20:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1L4xm+Q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA321465BA;
	Fri, 29 Nov 2024 20:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732912685; cv=none; b=OofRNxUtzsNgeFjwv9YNalkQdJDYCUG+BEIhD69E+238WHPhSYMfMWCLNtVp6chtMNZYxWO74nvXMUjk4ojBrIO5Tomz9Ooy30wYrIASEA8DuWQ1uGR/UZ2wL438FFYOtiLZEpwY2VYVdd0rI4B2w5NWBzGUtpJ4S0sk2rsrt58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732912685; c=relaxed/simple;
	bh=ZIqMYahkHwjge8RZTL5V2XCluEQubDOzJedjRuHy/JQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=seAlLappezW6C8sZ52LJBPff6ic/UKc763xnBU6gGmlb+vm/pS1LybuvMP6tTq96E6ot76lfYZA2SEfmhm5Xhs79hSFQ+B2v0KBqcPCkoRY8c1IMsqts9VgTSWbTOOAWZKFkDzqt/brQuXinhtTbphU+xtng9z/FRNYkEnmaIAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1L4xm+Q; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7ea8c4ce232so2024927a12.0;
        Fri, 29 Nov 2024 12:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732912683; x=1733517483; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ErLXNYdv1u6XL+S0yUSo8Bzv6R7DIT5UVoCwg3ONCIM=;
        b=Z1L4xm+QN9tqgKrbKQUPuX3MAPDIS5/8ZRK9DIgbjuqLH3YqK/TfRJPRwWTbxKyphf
         MDklVIrs2faXlrbd7UnDvA6FbykLB2ba1SeS/xB/KlMWEtDJSwtriJtdAeYZqdLZc9LA
         3zOEjnQwh4a/N+c3KHOeg8/WABGeU8+QmfDX9GtBUq2OBibARDxOsAJjXdV57OV8s71q
         Sku/Uy2HEuYmmPSnJxBQA1jtMgCoTnEYfC/jzZ7rs/U+g4H0LqANyrBLog9fpipgBUEH
         o6gcl6IHddSABOA4+pZoo0zl/CviZl3/DP/TO7GTyAuvpRN178tmv8sXAarJQITXEhRF
         HJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732912683; x=1733517483;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ErLXNYdv1u6XL+S0yUSo8Bzv6R7DIT5UVoCwg3ONCIM=;
        b=NmJB847qZxbY5fEAtfG+HIhPwszRLYK2ux5qA6f/XCs/68s6izkNJsIdP1/UzoQMyB
         ytVVIL3mYXOLu5khDEg7Pss0yzYzdqyN8VI5N4B5dbPACv7/txrmUkRnTUOg56oaA3f9
         n0+xSpZ/R4uViXi9Hmnx/K9OXknV3j9izUQliFRBVV7+hbliZwnZVsR8dtzvgxQV9rZW
         I5hCmtUpMHOUmJ6BIFagT5UADk1wHKJ3jwJmPpnfsawejOkj39IeitAQ+2PPrPzuyxYr
         CrQQaJlX7rj/56ia+sGr2yegRwDZY2F+aXER1sqGdb7JoWlZqVjKBIEbwpQUN4BCZLBV
         SUDg==
X-Forwarded-Encrypted: i=1; AJvYcCUlzgLJjbnf6DpKCfn09D5tRFKzTmX8RreWGvjiwewEoVj5P/d3rBXkAn418OG3SS3+y8VtwTsi@vger.kernel.org
X-Gm-Message-State: AOJu0YxuB2zDYJPBM9sL0zXOY5C+ARgfBiL/1vXO0GwM1uz4cHYK1UFw
	LeaOLK27jUGohQh8MZfSjPRH+ZeqfS13Il+LEB5scrzG/ty8dshM
X-Gm-Gg: ASbGncuMevbzzgIjmnLHDOkBq7+AOK0CVapK6nlEEVh7I01t0syH6Ingeb5NGfqczE+
	0ND9YC85OZfP6J6Hf9d43ifeNOag0cLgXWJotmTD3INxAovrEY8OmhfjtS7ocMcogH7Ab4eccgy
	GOZWPr84/oChZ6+8rUE8umxDkRMts50chJK9bOuYUrZDGqEWC94u6M5NwnpHV/clE4YjMlz29cc
	jnTD1PKpSXJ63Yh48CZYNfm04fQFG1GF+rpZmAL1yjvo98=
X-Google-Smtp-Source: AGHT+IGBoE6g4l84S49G8fsa88Jd43qoGw8ZuPoTmR3dBofZuUPPwzfwaAKJssBNO0jBl40v5mxWMQ==
X-Received: by 2002:a05:6a21:39a:b0:1db:f00e:2dfe with SMTP id adf61e73a8af0-1e0e0b7fc01mr17600932637.39.1732912683254;
        Fri, 29 Nov 2024 12:38:03 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7254176f634sm3901726b3a.59.2024.11.29.12.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 12:38:02 -0800 (PST)
Message-ID: <39b3f6f04838b96e858effc09e01d7b29c529f2e.camel@gmail.com>
Subject: Re: [RFC PATCH 3/9] btf_encoder: separate elf function, saved
 function representations
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@pm.me>, dwarves@vger.kernel.org, 
	acme@kernel.org
Cc: bpf@vger.kernel.org, alan.maguire@oracle.com, andrii@kernel.org, 
	mykolal@fb.com
Date: Fri, 29 Nov 2024 12:37:57 -0800
In-Reply-To: <20241128012341.4081072-4-ihor.solodrai@pm.me>
References: <20241128012341.4081072-1-ihor.solodrai@pm.me>
	 <20241128012341.4081072-4-ihor.solodrai@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-11-28 at 01:23 +0000, Ihor Solodrai wrote:
> From: Alan Maguire <alan.maguire@oracle.com>
>=20
> Have saved function representation point back at immutable ELF function
> table.  This will make sharing the ELF function table across encoders
> easier.  Simply accumulate saved functions for each encoder, and on
> completion combine them into a name-sorted list.  Then carry out
> comparisons to check for inconsistent representations, skipping functions
> that are inconsistent in their representation.
>=20
> Thre is a small growth in maximum resident set size due to saving
> more functions; it grows from
>=20
> 	Maximum resident set size (kbytes): 701888
>=20
> to:
>=20
> 	Maximum resident set size (kbytes): 704168
>=20
> ...with this patch for -j1.
>=20
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

I like what this patch does, a few nits below.

Note:
this patch leads to 58 less functions being generated,
compared to a previous patch, for my test configuration.
For example, functions like:
- hid_map_usage_clear
- jhash
- nlmsg_parse_deprecated_strict
Are not in the BTF anymore. It would be good if patch message could
explain why this happens.

[...]

> +static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder)
> +{
> +	struct btf_encoder_func_state **saved_fns, *s;
> +	struct btf_encoder *e =3D NULL;
> +	int i =3D 0, j, nr_saved_fns =3D 0;
> +
> +	/* Retrieve function states from each encoder, combine them
> +	 * and sort by name, addr.
> +	 */
> +	btf_encoders__for_each_encoder(e) {
> +		list_for_each_entry(s, &e->func_states, node)
> +			nr_saved_fns++;
> +	}
> +	/* Another thread already did this work */
> +	if (nr_saved_fns =3D=3D 0) {
> +		printf("nothing to do for encoder...\n");
> +		return 0;
> +	}

Nit: this function is called from pahole_threads_collect():

	static int pahole_threads_collect(...)
		for (i =3D 0; i < nr_threads; i++)
			...
			err =3D btf_encoder__add_encoder(btf_encoder, threads[i]->encoder);
			...

	int32_t btf_encoder__add_encoder(struct btf_encoder *encoder, struct btf_e=
ncoder *other)
		...
		btf_encoder__add_saved_funcs(other);
		...
=09
      maybe move call to btf_encoder__add_saved_funcs() to pahole_threads_c=
ollect()
      outside of the loop? So that comment about another thread won't be ne=
cessary.

> +
> +	printf("got %d saved functions...\n", nr_saved_fns);
> +	saved_fns =3D calloc(nr_saved_fns, sizeof(*saved_fns));
> +	btf_encoders__for_each_encoder(e) {
> +		list_for_each_entry(s, &e->func_states, node)
> +			saved_fns[i++] =3D s;
> +	}
> +	printf("added %d saved fns\n", i);
> +	qsort(saved_fns, nr_saved_fns, sizeof(*saved_fns), saved_functions_cmp)=
;
> +
> +	for (i =3D 0; i < nr_saved_fns; i =3D j) {
> +		struct btf_encoder_func_state *state =3D saved_fns[i];
> +
> +		/* Compare across sorted functions that match by name/prefix;
> +		 * share inconsistent/unexpected reg state between them.
> +		 */
> +		j =3D i + 1;
> +
> +		while (j < nr_saved_fns &&
> +		       saved_functions_combine(saved_fns[i], saved_fns[j]) =3D=3D 0)
> +				j++;
> +
> +		/* do not exclude functions with optimized-out parameters; they
> +		 * may still be _called_ with the right parameter values, they
> +		 * just do not _use_ them.  Only exclude functions with
> +		 * unexpected register use or multiple inconsistent prototypes.
> +		 */
> +		if (!encoder->skip_encoding_inconsistent_proto ||
> +		    (!state->unexpected_reg && !state->inconsistent_proto)) {
> +			if (btf_encoder__add_func(state->encoder, state)) {
> +				free(saved_fns);
> +				return -1;
> +			}
> +		}
> +	}
> +	/* Now that we are done with function states, free them. */
> +	free(saved_fns);
> +	btf_encoders__for_each_encoder(e)
> +		btf_encoder__delete_saved_funcs(e);
> +	return 0;
> +}

[...]

> @@ -2437,16 +2470,8 @@ out_delete:
>  	return NULL;
>  }
> =20
> -void btf_encoder__delete_func(struct elf_function *func)
> -{
> -	free(func->alias);

Nit: it looks like func->alias is never freed after this change.

> -	zfree(&func->state.annots);
> -	zfree(&func->state.parms);
> -}

[...]


