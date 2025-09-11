Return-Path: <bpf+bounces-68183-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B72B53B70
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 20:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08F543BA4E0
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 18:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1E0248891;
	Thu, 11 Sep 2025 18:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Amtlhr6R"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488982AD0C
	for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 18:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757615458; cv=none; b=LZsipoVl2lL5dgfIUDhISRyztr7fX3Gagmj9XVlTnjXwrIXoShdBjQxnmIOMCepaLONvRbEf5nbOmYZjuexgFvGGQiKTjjud+eInOdm2UZjTxIf9pvDalspaMQqHJCL+BKoqc79dK0YLQ8Py2G4ne15IlU2i1EMPtiiKm1oabzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757615458; c=relaxed/simple;
	bh=D4xoEWjxtXl1WSQzUa6wtezjLHao012q/8zWGXAQ1pg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WAoxhUuQVw9RDdIdWL2Llldc1UmoKCb3rrqT66gpa4CEBAgduqm39GvrVO9gtUPppJqOyBOiye7uusdoPcwFhFgLI/QSIgHx2GC3NWUWevpOd8wGAq6AL1GMdrejBBMsUyOa8WHpXgbMRKrFw8h/4GaFTr684IUAqQnE0xmd8J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Amtlhr6R; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-32b8919e7c7so1235797a91.2
        for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 11:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757615456; x=1758220256; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ysmOuvhxykO/xV2fpJug4vnta+v5qI60HFbzxHqtsyg=;
        b=Amtlhr6R5SFjeVFV+S7ruSXFaE1KdgUonZ82uRaKQ3lBu+LgKSgaQlxWBD9S/XcJqu
         CxatDs9mZoBCDwVN6c/u2JJwKcgueSzpzOG2z9RSoH8Wn5xVpCXBXu/m4LDW3o3GfNWs
         4hzB8aJkIMH/o+4xjvjnOaElC84fcvEozG0qlhzrCHMKGKYHRO5rVmRXtSK7zYRyY9kK
         +hYJ9qosmHW5Bs0bvCYZ4KVzYuqWThhOtnd6SzmdBS0XE1R9OxiMsSTdpYryKsrRthDg
         +rjp7n+DFCv1e17obE7mOBeRnQJ64E7JNGEfTrSmG+VK7Z8InnAgJWF7xgc4MvoXEqGq
         vmOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757615456; x=1758220256;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ysmOuvhxykO/xV2fpJug4vnta+v5qI60HFbzxHqtsyg=;
        b=O0yIWZCZoFSzZaYMO9nEtfZtjlZwem4RvMh451fm6IKrSsqe5djA3zWwPhWiTXdbyR
         yifUuIBLg7Lb6gRQ6QtxDUUllR7K22zoCRlL3+kZfby7CjcAlMem6wclvike2cdeINXD
         HmFg/C4irfogpPgTjipOsnyhX0A2XG50fWh3FTH5BtTUKbimbD+2XOKpnNdw6e2/tbg5
         lfx/Ir3gW4LWILXdos/0SVV9LxvJ2sTmsN8XcfPFh494tW0SzUwnkv5wZBdPh6zzJxLx
         XFiLHi9cDCeeCU3aSs0tLpDuSydDL8ngWiy3noD1FAwxuH4jgQrPT87eYeSzs/+MSqOo
         KWIA==
X-Forwarded-Encrypted: i=1; AJvYcCX5gZX/xLD830lyZUIp0p0uwQcH+d4EeN5Zxxmhu/sQX5Z0f9k3w8mWGyzRQ2zhyH8YK2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw514gP6gBsnzDuNBSbo5yHLH0L+inQFOXNujlYPgx0XGQldbfR
	ARkaL6iRaLhkurKW5GW+GpizplSXBuop48GlxGxfjGmAQ7lcrxEFtqkn
X-Gm-Gg: ASbGncsxj7uo3G0buIA2mQymO4lrZWborU/8F/1Cx6DRy5jodew5Hvz7VT7aXu74yUH
	eyaSBkmuWwHPhxwWrzH6eR8vE9zDYC9LGqX6yomlGXPL/GXYyXHa3PXDL0IMgIE3gfqyBr+HMPy
	7tTsmttTx4CeL4fMNBzDVRuYheQHw/7X3NIzP3mSLKNMQm89IHDTJBQ5XQ1pjMqq+rypKK085Vg
	fDYQUfdhA4TL3DZmFza1KKQgXWEhgVypHfw0HD55Sc03v34l+BT94hsDr4M1aVQ+wD6m0qlYcrX
	kTiyb+cEyfNLatGezjLy4uKfXiUvKLZcrZf+Hgl/bO8lRfCcVAAbeGK3KqLUp07YwgUD79bsw2V
	9mbhIQ/oNNgqB7U0e3pdWXkvfAXE+2tLjG7XqDExQ
X-Google-Smtp-Source: AGHT+IGyWH10TkkeW/IEvV1CfM54fIumBdtLvayth6bPRgzG1c9y4UTtOLOqtQwDznEtZgYQLACnQg==
X-Received: by 2002:a17:90b:58ed:b0:32b:7d2f:2ee5 with SMTP id 98e67ed59e1d1-32de4ed7900mr191198a91.16.1757615456522;
        Thu, 11 Sep 2025 11:30:56 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607a5f2ffsm2754312b3a.41.2025.09.11.11.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 11:30:56 -0700 (PDT)
Message-ID: <90ef59859542c88e371a222eca5e9a588d98d04b.camel@gmail.com>
Subject: Re: [PATCH bpf-next v7 2/6] bpf: core: introduce main_prog_aux for
 stream access
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend	
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev	 <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Xu Kuohai <xukuohai@huaweicloud.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon	 <will@kernel.org>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, 	bpf@vger.kernel.org
Date: Thu, 11 Sep 2025 11:30:53 -0700
In-Reply-To: <20250911145808.58042-3-puranjay@kernel.org>
References: <20250911145808.58042-1-puranjay@kernel.org>
	 <20250911145808.58042-3-puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-09-11 at 14:58 +0000, Puranjay Mohan wrote:
> BPF streams are only valid for the main programs, to make it easier to
> access streams from subprogs, introduce main_prog_aux in struct
> bpf_prog_aux.
>=20
> prog->aux->main_prog_aux =3D prog->aux, for main programs and
> prog->aux->main_prog_aux =3D main_prog->aux, for subprograms.
>=20
> Make bpf_prog_find_from_stack() use the added main_prog_aux to return
> the mainprog when a subprog is found on the stack.
>=20
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> @@ -120,6 +120,7 @@ struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int=
 size, gfp_t gfp_extra_flag
> =20
>  	fp->pages =3D size / PAGE_SIZE;
>  	fp->aux =3D aux;
> +	fp->aux->main_prog_aux =3D aux;

The fact that this needs to be added both here and in jit_subprogs is unfor=
tunate :(

[...]

