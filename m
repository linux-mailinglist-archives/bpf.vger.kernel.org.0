Return-Path: <bpf+bounces-29592-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 385968C305B
	for <lists+bpf@lfdr.de>; Sat, 11 May 2024 11:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E63C2281C43
	for <lists+bpf@lfdr.de>; Sat, 11 May 2024 09:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FBA535BF;
	Sat, 11 May 2024 09:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtdhGO+0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293352F56
	for <bpf@vger.kernel.org>; Sat, 11 May 2024 09:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715419478; cv=none; b=m2riY/mjTh+A0TYWGzSwQtIU/ve8H8OoBhu0eKFDvjq2NfE6gRqoYYwkxS92cjUQnWURbUbCdWP6TR8tm42Mba0seNJh0cmG0FJbYy1F6jKxM/WOT7PzMCYNXBjf0SZ1w79EmnfiF40ZlyBYt5CIeOQJsYzqS8dTz+wZsp0djTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715419478; c=relaxed/simple;
	bh=grla4Duvwg7tq9nyjpyVRhG1LuJe9M6sEv+SCCHgykI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pVOmaqtiSikpx8a89kTLzySbcRoa/GLU3kdKFX1pQWvrjNFEHJH395JYq+8KlWV5NhxmIfTpI9yLKujXw54GR7KjdIrhx7AgSe3K6OLJmea05RJHPWEt8lTtUgDHzArNPzz2p3cZIosm+m7OdIl0LUNq/3zfpe8vzBG5zbmW64U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OtdhGO+0; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1ed96772f92so24043315ad.0
        for <bpf@vger.kernel.org>; Sat, 11 May 2024 02:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715419476; x=1716024276; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JEECd+QBSR9UooV+XYAZ/HglBD6a08TevTA+wRHV9Cg=;
        b=OtdhGO+09LkE+AkmPF5xbAi3BaRpTsCgouP7ig1jN5+TfVlseh6T6AjG7kfsnYkalU
         rIrbz+DMriEjaJoGzQS5AoTy+sGMX9qk6v3LSGzwHhnnwZIKFMIB1EJvw6cUJQHrhFGa
         HefUcO3P34BYSOe3fDHxfsRG1OXHwjqoMiTJws38Q2D+cY9KBsxkOCduUCbYHkqYwlLn
         eQhUCbp+nyZalz1WO96NAqUJQ+5rYfHPkg1UPV+FBa47wDVliNM3TDx1f5PQbxUWHq1z
         pqv685aWCTC9PHb7q0jP29D1yNX+CpRQNieauEUw8svuWWyubY3dUBdTufPGP1iL7oR8
         0nkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715419476; x=1716024276;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JEECd+QBSR9UooV+XYAZ/HglBD6a08TevTA+wRHV9Cg=;
        b=IATC+MgSVnM/XU/Y4kuEjVJp7Bgyj2WKFYv3VpmobTEWzCStMiCgyLFxw+CEwMJkWG
         uWJKWvh2j5959VM0nfSQmWh9E7/wsXrN2vwHNJIcba0w3wBFz37maiKFqSBE7yaDPzsZ
         EZTuhACEx/B/0IJdk9DF9/0wgsCsU9ZyKXR9mUXfbj5nFXpJtrYvvKxkI6Ochlke5CB9
         hMcIIQawLNVltCw1ec4CNbWI2euX02bKGQ43eGU6DszmpChvwesSUl+TKq25JXJG/7Zo
         GsY/OYeOLUl7ymER+V00j+e20PjTaDmCN9NWzJPqF0sJeUTtzRRki4VnHfzVDJMSQxpV
         mQsA==
X-Forwarded-Encrypted: i=1; AJvYcCXC/cmRyFiPszr3HC4aClltqD0zZCkxaX97zY/dg8DpL4K9OyQiwVkd4lncQs7NLbJRHvIKDYrCDvQqy+TuxHf6dGCG
X-Gm-Message-State: AOJu0YyyrVWl2k6KYmc8HM/6I0M/Dz56mRGGi3Ul58xUnn7AHkwITlIe
	lHBDN9mFEpLJd327N6VyH8MIr/G5zwMy2eNYOLC7JWajOK/Ey0Dk
X-Google-Smtp-Source: AGHT+IGZyz5Fk4Xa7RCN5tlz7TW6Kp4auq/qem+0uzI6dyNx/o21udkiS6RAIo2CL488pgPakBizkg==
X-Received: by 2002:a17:902:e54c:b0:1e4:342a:b351 with SMTP id d9443c01a7336-1ef43c0e8fdmr62609245ad.4.1715419476403;
        Sat, 11 May 2024 02:24:36 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160::3424? ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c036d47sm45138085ad.182.2024.05.11.02.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 02:24:35 -0700 (PDT)
Message-ID: <65f5bac3ad49c1136259b0361cfb5180dd372d83.camel@gmail.com>
Subject: Re: [PATCH dwarves] btf_encoder: add "distilled_base" BTF feature
 to split BTF generation
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org,
 jolsa@kernel.org,  acme@redhat.com, quentin@isovalent.com
Cc: mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev,  song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com,  kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, houtao1@huawei.com,  bpf@vger.kernel.org,
 masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org
Date: Sat, 11 May 2024 02:24:34 -0700
In-Reply-To: <20240510104847.858922-1-alan.maguire@oracle.com>
References: <20240510104847.858922-1-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-05-10 at 11:48 +0100, Alan Maguire wrote:
> Adding "distilled_base" to --btf_features when generating split BTF will
> create split and .BTF.base BTF - the latter allows us to map references
> from split BTF to base BTF, even if that base BTF has changed.  It does
> this by providing just enough information about the base types in the
> .BTF.base section.
>=20
> Patch is applicable on the "next" branch of dwarves, and requires the
> libbpf from the series in [1]
>=20
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>=20
> [1] https://lore.kernel.org/bpf/20240510103052.850012-1-alan.maguire@orac=
le.com/
>=20
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> diff --git a/btf_encoder.c b/btf_encoder.c

[...]

> @@ -1297,7 +1298,7 @@ static int btf_encoder__write_elf(struct btf_encode=
r *encoder)
>  		if (shdr =3D=3D NULL)
>  			continue;
>  		char *secname =3D elf_strptr(elf, strndx, shdr->sh_name);
> -		if (strcmp(secname, ".BTF") =3D=3D 0) {
> +		if (strcmp(secname, btf_secname) =3D=3D 0) {

Nit: comments in this function still refer to '.BTF' section.

>  			btf_data =3D elf_getdata(scn, btf_data);
>  			break;
>  		}

[...]

