Return-Path: <bpf+bounces-38920-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 890C696C7AA
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 21:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C58B1F25F57
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 19:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B541B1E6DCF;
	Wed,  4 Sep 2024 19:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xn5g/Vaf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA74F84A27;
	Wed,  4 Sep 2024 19:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725478662; cv=none; b=jsryxEc+/ExCYK/lNwHQ2+x0J83aMtlhtUxVd8ITwFqLBZVdJ5zTj5/1clDnWIf1uz83I48YmZX7Ixa68YvxMrvHa3jRi0JFCjt7KqqQczCtEssk8Ygp0+/ZfA24I0+UoqFTJr1uTjGmwhDlM/ER+vs9o4vTdpDX9KtBJKmgmAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725478662; c=relaxed/simple;
	bh=uKIOzaKPAr9lNVhKL2NgtNhIOnEwdzh7bilhImYr1YM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uUZBQuTpk0m+KxK6o25x272TNbYVmWYv88vsECUhbsbZsVhN9WFcCbOdqNQs/gjuPpjcfsXVDJP/gORAThMVun7O6Z3le3B9UmI6QYU7tXADU0sB6TmpFHLt+Mv7ZhT/4GlZeY8SiY6Dik/bOAl4qGwNgmp5UOlOeZilQaAMpNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xn5g/Vaf; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7177a85d092so1081687b3a.3;
        Wed, 04 Sep 2024 12:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725478659; x=1726083459; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=539JpYt3z4yAWF9FgRwuAOBj2XoJGZXhHjPZHfOy/vU=;
        b=Xn5g/VafTPx1QxBiteJFoaqHY/HuY1rKsvbxwPySdzkAeSrW64oUY3fWTP8nirukS8
         ChzI+vsZwRoO/AOLHEoUTzsnRI2Ld+x9SaCtEob9IA84T09CFaQFCDt1EF9x+KZwSsh7
         BUf07sP3b0aUh9qbB4iG/MZjPnO12b9ZfoAqAyttUEy3uaobXQjwVajvuUwxuz2qGtOq
         Q/KrwraYy/MQUVqDmLGLpWkslS/vRTmIKBw0ewvWaXKsXbFK++2xrrynQRXbOwS8Yxjd
         vdBA0eSgAS40/DNeHIQjt9hvCykbUHTHlIQAgkP0lVxEFMohEjVHEwsWauiFlIC/2oRP
         cg+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725478659; x=1726083459;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=539JpYt3z4yAWF9FgRwuAOBj2XoJGZXhHjPZHfOy/vU=;
        b=TETjx9Fr/ELk1F4SjSu+2pvVSOkzN2hLTRhXZR6P7dprSyPxNfwlsHmsG2ex+NGe6N
         xLUYuDetln8C7sngxos62fxNC99GQq0p+JBYcdQL/DOEztLID/Tn74iY7TBXawuu01zW
         YFNqvhRMhn4+YK3RguHVi/5SUod725kw12VB5DKDo20It6syDAPXbpZRDmXrGzzhYipB
         YmWeZnSnYkS/QTsbkiJy+HxoAiWy28bQN8RWgbX59zvXXRPB9pDlVNUtpLgwOlmQ6Msg
         FyW9HWExAPQaCCWdl+73HMT94WxlOVbW7U0xnrElU0oAzeJpE/mNXDTF80TmygXyIvFf
         UKfA==
X-Forwarded-Encrypted: i=1; AJvYcCWcmo7WrmMpiEP0FyZozv4ZIWCoD4D8lEoNTI+GP5gcJLLSi3aViO2NdG1J89I9JKvd2gi2f7LA@vger.kernel.org, AJvYcCXjQ1vb1J3z7g3Rq8DCmHk1ZhwGdK647khfSnSZyIG7mac0VZk/y/nuX1ZAUNuYYXcwMcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVum0kKmqYjmTsPoufsvTpfGbF8daaUsKRIsxK/XuHaKaf9z2N
	og/qchp0ikhyzv0W9OssFdczxDEpeq8WvzmiElJE0RNhNyaPthlE
X-Google-Smtp-Source: AGHT+IGVoOZOS5Yvkub7Juoan+1ICnFwIH/PkP8dmCe/hS+hO0jG6HWz+D6sHhnx1h9kFMw9lDR1og==
X-Received: by 2002:a05:6a20:c916:b0:1ce:d418:a45c with SMTP id adf61e73a8af0-1ced418a474mr13084964637.50.1725478659223;
        Wed, 04 Sep 2024 12:37:39 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71778520e66sm1986107b3a.21.2024.09.04.12.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 12:37:38 -0700 (PDT)
Message-ID: <fc9a03f1809cfdd80a9a8cb7b513e32302be5a43.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 03/10] selftests/bpf: Disable feature-llvm
 for vmtest
From: Eduard Zingerman <eddyz87@gmail.com>
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org, 
	linux-riscv@lists.infradead.org, netdev@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>, Puranjay Mohan
 <puranjay@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Pu Lehui
 <pulehui@huawei.com>
Date: Wed, 04 Sep 2024 12:37:33 -0700
In-Reply-To: <20240904141951.1139090-4-pulehui@huaweicloud.com>
References: <20240904141951.1139090-1-pulehui@huaweicloud.com>
	 <20240904141951.1139090-4-pulehui@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-09-04 at 14:19 +0000, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
>=20
> After commit b991fc520700 ("selftests/bpf: utility function to get
> program disassembly after jit"), Makefile will link libLLVM* related
> libraries to the user binary execution file when detecting that
> feature-llvm is enabled, which will cause the local vmtest to appear as
> follows mistake:
>=20
>   ./test_progs: error while loading shared libraries: libLLVM-17.so.1:
>     cannot open shared object file: No such file or directory
>=20
> Considering that the get_jited_program_text() function is a useful tool
> for user debugging and will not be relied upon by the entire bpf
> selftests, let's turn it off in local vmtest.
>=20
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---

I actually don't agree.
The __jited tag is supposed to be used by selftests
(granted, used by a single selftest for now).
Maybe add an option to forgo LLVM linkage when test_progs are compiled?
Regarding base image lacking libLLVM -- I need to fix this.


