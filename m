Return-Path: <bpf+bounces-66574-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD66AB370B7
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 18:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 362BB360035
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 16:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3843128B7CC;
	Tue, 26 Aug 2025 16:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMT7G2t4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D198275865
	for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 16:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756226885; cv=none; b=bZX9g7UzhKlgUQGh9LEAxtkdNA96+mQsW2JM3p5fD+ITI1qMJrWEm5qbwHq2uXLXQKil+c4qXu1TD5FN4ES4EUbbHCAl8NgC4IxVZnHwmulLbFJyn0ROuNwLDQafPruy9ggomFCkLGr2LfPhqv6BfDsRWQmP9s7rWRyUIV2ZyHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756226885; c=relaxed/simple;
	bh=pa5/azMV0KDV86EaTjOT74w7HGE3cS45g1e+bibKKr8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FchUVV7zqibg/b3wuB9rFIYhpmci3XSIYtp0ypZamoGYlj87gvPlTDJGM95qRLjS6wmetz+j1fKMD7nuQKKpGFbiUXkEBRI/095lcZa5ocpZDczmccQ4Sd4GDrp0SSc6/V3XVMtBwsk0gS9o6ZPWIDbZah48/qp2FeAx5rPd31c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eMT7G2t4; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-246ef40cf93so18170655ad.0
        for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 09:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756226884; x=1756831684; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NDEMBDGfkYne0k4p2x1D4pGF2lS2f7gO4jnCzN6lv1k=;
        b=eMT7G2t4O9E4AYL7Jg77H5nbS0JytAaiw+kXYKmpLvUIXoBAqGNb2T8xz9CTnPy3Sd
         +ZAlQYMyzY1NMIOZYnLzg6bD5CoDJr18OkjPUToQfFOwGIvIAAzRUgP2RN4mK9yba/JJ
         G0NAk+kR85+7X9f/fZW6fqe18q2odWIXVJAm7cMKgp9reLIcu+fNqdKdLYxIozYDlfmQ
         +yq4U1aUy9FJvkw8mWs6gQZa/FothQxLwKVCx2LYQyxRJVVHnHy8wbRyuVuslCL4bgkl
         MME2rgO310axjZ2lsMJvyf80nUiRx5EcGKctyjQtAgEyoRi52Gcjwq1h3jxx8yNO6cKK
         KxhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756226884; x=1756831684;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NDEMBDGfkYne0k4p2x1D4pGF2lS2f7gO4jnCzN6lv1k=;
        b=DCtSqXHgaz73GjppMVOhyioTg39k0wUQRLgWZvLiDb9xk4YrSlj+SqwVtU9XWTFdHD
         nQAJe5zjVAWYlUca9aGNbiSruP0CGzyKG/2615GDMkX4lew5n6O77qmq1kju4G9i5XcL
         ZkcJSncb1lOBe3NXPoDtxD3mm9CjAXiJN0NrnGrIqf073AsoaQDP8q0ATUiWtkHOLyqg
         bctJb/8rjI8RGNiLdx50Um6jc6d7QIN4+jWlYuFdkQrBryjnLjq+gyQdkOOkDp2Y5JpM
         At7+zxrIm5lzCuUVMS7FsGjplHvV7hDphzSiNBY3sN4XUlmqkNI8iF96+bg/QsxpcJ9b
         PKNw==
X-Gm-Message-State: AOJu0YyQGQXLRsRiRbk+5z22anLyVNLfEnCYuMOyk2gSHXQl6mzapM0l
	Nh1LrCmmfTg0+o1MPwXWitxkGLyY+6mE9P/T5bGw60u6O+mTO8vhfIm7Wmx69DP+
X-Gm-Gg: ASbGncsVtkLoElOTrPaFJfUfkMybexyOrFuEojMLnT5MvTKvASpg8VBF1dxdWA7NnMW
	Mww6JUW08mEQcOWPiei+H4EMLTkGWe2es3HNFpkbu6o+tjCCq3wWCfikl/LIyWBAPWteyM7T1U3
	9gbxX9/dl4L+nc6hd2//K8SoJukWa3JgNbv09+sNTz2PH4b7uyfVScAHGTzN2oftT42VOvyDUxM
	uDAxk25DNr/G9v3+DdMH8lXjGli4NNYBfT+FNfbvkjtaDuJXZUlzysFiKEkWLp+oV24mQyhLFa5
	/kbRVpy2QsBXxAMo5BBLaZYA/DfiohvCXYPQOi2UISZQ7Z4UxIE7Y3W6RYR8pQFT+pDBiooyFjQ
	I0KtgOiVrZGVl0nlZ2kA=
X-Google-Smtp-Source: AGHT+IE99fJPgAX139hyymiIJLtLqekqFJVHyVCxzi+DlZeSkCsaolQkhttVepx6dpAaKyFSYLhYPw==
X-Received: by 2002:a17:902:c406:b0:248:79d4:93b6 with SMTP id d9443c01a7336-24879d49805mr24898715ad.47.1756226883706;
        Tue, 26 Aug 2025 09:48:03 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466889f188sm100572215ad.146.2025.08.26.09.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 09:48:03 -0700 (PDT)
Message-ID: <d92ec2c0eefbdf2e5bce1309b3673f1113d602d3.camel@gmail.com>
Subject: Re: [PATCH v1 bpf-next 10/11] libbpf: support llvm-generated
 indirect jumps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko	 <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>,
 Daniel Borkmann	 <daniel@iogearbox.net>, Quentin Monnet <qmo@kernel.org>,
 Yonghong Song	 <yonghong.song@linux.dev>
Date: Tue, 26 Aug 2025 09:47:56 -0700
In-Reply-To: <aK3mAGopUQX6T2z4@mail.gmail.com>
References: <20250816180631.952085-1-a.s.protopopov@gmail.com>
	 <20250816180631.952085-11-a.s.protopopov@gmail.com>
	 <69306a9742679ae8439fab4b415e3ca86683e61d.camel@gmail.com>
	 <aK3dnUhX2aYw6//s@mail.gmail.com> <aK3mAGopUQX6T2z4@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-08-26 at 16:51 +0000, Anton Protopopov wrote:

[...]

> Just in case, this chunk is
>=20
> @@ -6418,6 +6524,17 @@ bpf_object__append_subprog_code(struct bpf_object =
*obj, struct bpf_program *main
>         err =3D append_subprog_relos(main_prog, subprog);
>         if (err)
>                 return err;
> +
> +       /* Save subprogram offsets */
> +       if (main_prog->subprog_cnt =3D=3D ARRAY_SIZE(main_prog->subprog_s=
ec_off)) {
> +               pr_warn("prog '%s': number of subprogs exceeds %zu\n",
> +                       main_prog->name, ARRAY_SIZE(main_prog->subprog_se=
c_off));
> +               return -E2BIG;
> +       }
> +       main_prog->subprog_sec_off[main_prog->subprog_cnt] =3D subprog->s=
ec_insn_off;
> +       main_prog->subprog_off[main_prog->subprog_cnt] =3D subprog->sub_i=
nsn_off;
> +       main_prog->subprog_cnt +=3D 1;
> +
>         return 0;
>  }
>=20
> (In v2 it will either change to realloc vs. static allocation, or disappe=
ar.)

Thank you, filtered out whitespace changes when reading the patch yesterday=
.

