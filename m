Return-Path: <bpf+bounces-22828-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B6886A490
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 01:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D40B41F23B37
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 00:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA34A34;
	Wed, 28 Feb 2024 00:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsiRaTlY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1126A79D1
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 00:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709081432; cv=none; b=jgbckfX+AwotfKdfnAkBVr+9sZxi76xU6OOk2ZXlCOBY0lIxjPFv9XevDENz5dyZ4fR3ZPz+BRhwS7FUl0PUNzxhzcdZXZF+wEy4qV8AaySwJFvv3oOuB1YjO62l2Ivp/lDF9bl7dASpwESf4ZzUMSrAWyQiXxG+3yaZWouhtco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709081432; c=relaxed/simple;
	bh=REjV3SMTqKrpqofov4EV8BSfdE8lAqtX3xcaia9jClQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bIworqbJA4MLpeiQrcjs+Nyk25MW4QzoZqRZbRo051Ca9ICxagfc64ZggmH0c5EXstIREJOinTuYoC/qCvpgv+IPHvcaNV0wlPs7LogIdfuPUBcZndOYt9AK/oWIsBrRgqgw35rikQcYLXERGAMZFbzy3Ubx1HYCwUjAtRUSIuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KsiRaTlY; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51316d6e026so877332e87.1
        for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 16:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709081429; x=1709686229; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pjNSudLtnQqae6BLU0mH758FdBXezkBiLWc9ubx0lf0=;
        b=KsiRaTlYbMuEEdznoOHuUduXLLXG6bBp85b8DdDgmi+kvcBHj2orj7kzKchh6XhLUi
         rgfR3FBEaRXvQ/LG9Zr8M5//4nnTRSgQYyle4iYKpO372+cKtD96s194p70ZORIfhm5V
         z8E/QaxwizXAdYDqgCLbJVdbySoOgGDIieB6t8oJY7JhG9uLj1OJ4Kbcihh0dZGrdpyh
         2fLdF3UeZaQpsPSRpckBf/AomtHaNyhtBYhM/1onKiazhT0pc0ZDbG4+Tm97MTtRdE3l
         eGeP3gwspptmSAOBYfk3xUkoIve9+GNxeW0dP8mwRCbwLcY8oF6zyMiQzmAHaYOTBoKV
         Y05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709081429; x=1709686229;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pjNSudLtnQqae6BLU0mH758FdBXezkBiLWc9ubx0lf0=;
        b=ZDfJvwiE8aPqV4pIYCXEaxeRcQU5VviQcH+QZct8YXmCu+ihBH9c+USrnDuNre7fjR
         Z8lQRIUoh02cO15MKK+rJnQFphOkoxmlXrb7MsgMWOUdOwVDxlk+OC7sSCamdO1BviT8
         X522NP52eNTIG40PApKIWPOw/gpMMxWUJxdSxNJg5E2nFLKCqi7cy5wAMM/OaEcxW+at
         qHV+ijSXukGUUWOddNAITTpgmYNm6TIb2FJdARo1McqQP2507fkSqkMnUV8z/qhgNlS5
         LCLBIA7/7HzLGGeeAGqagR0mw93cJcw8SPnHkNe+xt6XszbX/F0leuJlonPTeZeXgPIz
         6x7A==
X-Forwarded-Encrypted: i=1; AJvYcCXMS92/Cdi3Htj8/5cM4QhXwWqB4aCma3IC3ziv5YmibeM6fQOtS4uqD3cSGt+7ZV+XlRRBeOgGn6g9GMl1sRXqwFVz
X-Gm-Message-State: AOJu0YwN8JCXVdi7kv3fZPBO0pbMjLClL+jth0kwj850EgWlZcC1aocT
	KupjzbZAjXCmETmXQyV1acL1eRnDX01EO8bkJCtBPCwjZzn8yKbv
X-Google-Smtp-Source: AGHT+IHOTdua5wLVbrDHmeBtSbkvno+H7P2XdF9NQ0MLfU3+pd+ATXDOOldf5bzIK04gepE5kA/+bQ==
X-Received: by 2002:a05:6512:3da9:b0:512:aa52:5cce with SMTP id k41-20020a0565123da900b00512aa525ccemr9080865lfv.12.1709081428996;
        Tue, 27 Feb 2024 16:50:28 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id gw7-20020a170906f14700b00a3eb1b1896bsm1275499ejb.58.2024.02.27.16.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 16:50:28 -0800 (PST)
Message-ID: <2712124d54b2e00cae77c6412834e6861bf17054.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 7/8] libbpf: sync progs autoload with maps
 autocreate for struct_ops maps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kui-Feng Lee <sinquersw@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yonghong.song@linux.dev, void@manifault.com
Date: Wed, 28 Feb 2024 02:50:27 +0200
In-Reply-To: <3d784a4f-7d90-442e-8c4a-fb0f40134e35@gmail.com>
References: <20240227204556.17524-1-eddyz87@gmail.com>
	 <20240227204556.17524-8-eddyz87@gmail.com>
	 <ec9d8997-f5a2-44b6-9bc4-2caaf19df8a9@gmail.com>
	 <c9395bfd3cbd27ec5280d2e55abc6a6186fc663a.camel@gmail.com>
	 <7adcc642-4dec-425a-b198-14bbc0416f21@gmail.com>
	 <f6b6bf33c1fa379fcaba9ceaeb841a275cdbdc68.camel@gmail.com>
	 <3d784a4f-7d90-442e-8c4a-fb0f40134e35@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=mQGNBGKNNQEBDACwcUNXZOGTzn4rr7Sd18SA5Wv0Wna/ONE0ZwZEx+sIjyGrPOIhR14/DsOr3ZJer9UJ/WAJwbxOBj6E5Y2iF7grehljNbLr/jMjzPJ+hJpfOEAb5xjCB8xIqDoric1WRcCaRB+tDSk7jcsIIiMish0diTK3qTdu4MB6i/sh4aeFs2nifkNi3LdBuk8Xnk+RJHRoKFJ+C+EoSmQPuDQIRaF9N2m4yO0eG36N8jLwvUXnZzGvHkphoQ9ztbRJp58oh6xT7uH62m98OHbsVgzYKvHyBu/IU2ku5kVG9pLrFp25xfD4YdlMMkJH6l+jk+cpY0cvMTS1b6/g+1fyPM+uzD8Wy+9LtZ4PHwLZX+t4ONb/48i5AKq/jSsb5HWdciLuKEwlMyFAihZamZpEj+9n91NLPX4n7XeThXHaEvaeVVl4hfW/1Qsao7l1YjU/NCHuLaDeH4U1P59bagjwo9d1n5/PESeuD4QJFNqW+zkmE4tmyTZ6bPV6T5xdDRHeiITGc00AEQEAAbQkRWR1YXJkIFppbmdlcm1hbiA8ZWRkeXo4N0BnbWFpbC5jb20+iQHUBBMBCgA+FiEEx+6LrjApQyqnXCYELgxleklgRAkFAmKNNQECGwMFCQPCZwAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQLgxleklgRAlWZAv/cJ5v3zlEyP0/jMKQBqbVCCHTirPEw+nqxbkeSO6r2FUds0NnGA9a6NPOpBH+qW7a6+n6q3sIbvH7jlss4pzLI7LYlDC6z+egTv7KR5X1xFrY1uR5UGs1beAjnzYeV2hK4yqRUfygsT0Wk5e4FiNBv4+DUZ8r0cNDkO6swJxU55DO21mcteC147+4aDoHZ40R0tsAu+brDGSSoOPpb0RWVsEf9XOBJqWWA+T7mluw
 nYzhLWGcczc6J71q1Dje0l5vIPaSFOgwmWD4DA+WvuxM/shH4rtWeodbv iCTce6yYIygHgUAtJcHozAlgRrL0jz44cggBTcoeXp/atckXK546OugZPnl00J3qmm5uWAznU6T5YDv2vCvAMEbz69ib+kHtnOSBvR0Jb86UZZqSb4ATfwMOWe9htGTjKMb0QQOLK0mTcrk/TtymaG+T4Fsos0kgrxqjgfrxxEhYcVNW8v8HISmFGFbqsJmFbVtgk68BcU0wgF8oFxo7u+XYQDdKbI1uQGNBGKNNQEBDADbQIdo8L3sdSWGQtu+LnFqCZoAbYurZCmUjLV3df1b+sg+GJZvVTmMZnzDP/ADufcbjopBBjGTRAY4L76T2niu2EpjclMMM3mtrOc738Kr3+RvPjUupdkZ1ZEZaWpf4cZm+4wH5GUfyu5pmD5WXX2i1r9XaUjeVtebvbuXWmWI1ZDTfOkiz/6Z0GDSeQeEqx2PXYBcepU7S9UNWttDtiZ0+IH4DZcvyKPUcK3tOj4u8GvO3RnOrglERzNCM/WhVdG1+vgU9fXO83TB/PcfAsvxYSie7u792s/I+yA4XKKh82PSTvTzg2/4vEDGpI9yubkfXRkQN28w+HKF5qoRB8/L1ZW/brlXkNzA6SveJhCnH7aOF0Yezl6TfX27w1CW5Xmvfi7X33V/SPvo0tY1THrO1c+bOjt5F+2/K3tvejmXMS/I6URwa8n1e767y5ErFKyXAYRweE9zarEgpNZTuSIGNNAqK+SiLLXt51G7P30TVavIeB6s2lCt1QKt62ccLqUAEQEAAYkBvAQYAQoAJhYhBMfui64wKUMqp1wmBC4MZXpJYEQJBQJijTUBAhsMBQkDwmcAAAoJEC4MZXpJYEQJkRAMAKNvWVwtXm/WxWoiLnXyF2WGXKoDe5+itTLvBmKcV/b1OKZF1s90V7WfSBz712eFAynEzyeezPbwU8QBiTpZcHXwQni3IYKvsh7s
 t1iq+gsfnXbPz5AnS598ScZI1oP7OrPSFJkt/z4acEbOQDQs8aUqrd46PV jsdqGvKnXZxzylux29UTNby4jTlz9pNJM+wPrDRmGfchLDUmf6CffaUYCbu4FiId+9+dcTCDvxbABRy1C3OJ8QY7cxfJ+pEZW18fRJ0XCl/fiV/ecAOfB3HsqgTzAn555h0rkFgay0hAvMU/mAW/CFNSIxV397zm749ZNLA0L2dMy1AKuOqH+/B+/ImBfJMDjmdyJQ8WU/OFRuGLdqOd2oZrA1iuPIa+yUYyZkaZfz/emQwpIL1+Q4p1R/OplA4yc301AqruXXUcVDbEB+joHW3hy5FwK5t5OwTKatrSJBkydSF9zdXy98fYzGniRyRA65P0Ix/8J3BYB4edY2/w0Ip/mdYsYQljBY0A==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-27 at 16:12 -0800, Kui-Feng Lee wrote:
[...]

> It only has to scan once with an additional flag.
> The value of the autoload of a prog should be
> true if its autoload_user_set is false and autocreate of any one of
> struct_ops maps pointing to the prog is true.
>=20
> Let's say the flag is autoload_autocreate.
> In bpf_map__init_kern_struct_ops(), it has to check
> prog->autoload_user_set, and do prog->autoload |=3D map->autocreate if
> prog->autoload_user_set is false and autoload_autocreate is true. Do=20
> prog->autoload =3D map->autocreate if autoload_autocreate is false I thin=
k=20
> it is enough, right?
>=20
> if (!prog->autoload_user_set) {
>      if (!prog->autoload_autocreate)
>          prog->autoload =3D map->autocreate;
>      else
>          prog->autoload |=3D map->autocreate;
>      prog->autoload_autocreate =3D true;
> }

Since the full thing is moved to load phase I was hoping to make do
w/o changes to struct bpf_program. To have it more contained.
E.g. the code below apperas to work (needs more testing):

--- 8< -------------------------------------

static int bpf_object__adjust_struct_ops_autoload(struct bpf_object *obj)
{
	struct bpf_program *prog;
	struct bpf_map *map;
	int i, j, k, vlen;
	struct {
		__u8 autoload:1;
		/* only change autoload for programs that are
		 * referenced from some struct_ops maps
		 */
		__u8 used:1;
	} *refs;

	refs =3D calloc(obj->nr_programs, sizeof(refs[0]));
	if (!refs)
		return -ENOMEM;

	for (i =3D 0; i < obj->nr_maps; i++) {
		map =3D &obj->maps[i];
		if (!bpf_map__is_struct_ops(map))
			continue;

		vlen =3D btf_vlen(map->st_ops->type);
		for (j =3D 0; j < vlen; ++j) {
			prog =3D map->st_ops->progs[j];
			if (!prog)
				continue;

			k =3D prog - obj->programs;
			refs[k].used =3D true;
			refs[k].autoload |=3D map->autocreate;
		}
	}

	for (i =3D 0; i < obj->nr_programs; ++i) {
		prog =3D &obj->programs[i];
		if (prog->autoload_user_set || !refs[i].used)
			continue;

		prog->autoload =3D refs[i].autoload;
	}

	free(refs);
	return 0;
}

------------------------------------- >8 ---

