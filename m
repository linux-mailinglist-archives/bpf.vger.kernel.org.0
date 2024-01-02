Return-Path: <bpf+bounces-18781-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB738220D1
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 19:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 811E81F233B7
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 18:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01A6156DF;
	Tue,  2 Jan 2024 18:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SV1cIHWx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC37C156CB
	for <bpf@vger.kernel.org>; Tue,  2 Jan 2024 18:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a27cc66d67eso253528366b.2
        for <bpf@vger.kernel.org>; Tue, 02 Jan 2024 10:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704219355; x=1704824155; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ScHUp9/Gh3WUk/feWEu4Sei3hPbTAKSlrPDR3KVglDQ=;
        b=SV1cIHWxj3lv2s7aRMevJOBxZYuoLLNzSNiVH1/2ah9KQjXT/9hShdyF+ZtYIrYGp9
         yQ5fQYhWrra2YT3yCe7rV7YSgYVDMnQMF79JMlfDiF/xMziLgeBd2Iw5TvojiLHUDQIp
         HSz+K9hsLEB4bXRGA2HsO+jX8s04iCGYs3ro/z48rkLuUUETEAg/hgc2VqELZ27E4KdD
         M5dwPMvxFw9ZhdNXQliHnca6UF2ENhynJHAzKuUfvwutDlIBxoplzHUQxqDXViP8VTHJ
         Be5PojAhr+tsMdn9FpyV2pRzicUE22OtWcXvB60CoHLzsnfcDvRRtVIW73H3pEPGuZR1
         6uyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704219355; x=1704824155;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ScHUp9/Gh3WUk/feWEu4Sei3hPbTAKSlrPDR3KVglDQ=;
        b=S7Qyl+jm3QCkNzVP1/LEgn/KWMyQFDUzQRo8m0iWXYMvWktZh5rMAzjQE3fJn6L2BT
         nxqLbp+47VyG1OepeRLZZIVJ5PxOCFFHe5zM/oKI8yxXVILcqefHq5ZHbBkhoISlf9UK
         w9KmZok8Pv4k+ttr82VoLIAH33CT/dsg7r7S9QTgMdtawtSqtSzv49cjRVt8piWCJFDo
         KDBcjlAi47CzbTk8c3m9BdbuR7o923H0sfvC3MDEJC3wnWtDbGlCLKz4Jd/Zo/5ajjLM
         o73zHOovRIvDKiivr+zB9G5iCHaTXOnKjQXIJknxODubFy6daVFkkOhYmJGUk/F8g+ah
         opow==
X-Gm-Message-State: AOJu0YwMZhD/9WUqo7raJ+zkeiPyCWgx8Z0BkKt8Vit5oc5vpYDdrXfc
	CNypwz+5MIkS3nlrsMjATXM=
X-Google-Smtp-Source: AGHT+IFgejqXlmY4zO4WJHh49A1CURYeS2KUC7l/+LyLnb7HRsPPQRwyVEvB7aRjMqhT0KMgKEQVbQ==
X-Received: by 2002:a17:907:6d09:b0:a28:3398:c14 with SMTP id sa9-20020a1709076d0900b00a2833980c14mr1086606ejc.31.1704219355039;
        Tue, 02 Jan 2024 10:15:55 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id d8-20020a170906304800b00a26a5f80d07sm5487768ejd.14.2024.01.02.10.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 10:15:52 -0800 (PST)
Message-ID: <f47459fd23f40d3ef65972bfd708ed61e5cf69ec.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Support inlining bpf_kptr_xchg()
 helper
From: Eduard Zingerman <eddyz87@gmail.com>
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Song
 Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, Yonghong Song
 <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Jiri Olsa
 <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
 houtao1@huawei.com
Date: Tue, 02 Jan 2024 20:15:50 +0200
In-Reply-To: <20231223104042.1432300-2-houtao@huaweicloud.com>
References: <20231223104042.1432300-1-houtao@huaweicloud.com>
	 <20231223104042.1432300-2-houtao@huaweicloud.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2023-12-23 at 18:40 +0800, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
>=20
> The motivation of inlining bpf_kptr_xchg() comes from the performance
> profiling of bpf memory allocator benchmark. The benchmark uses
> bpf_kptr_xchg() to stash the allocated objects and to pop the stashed
> objects for free. After inling bpf_kptr_xchg(), the performance for
> object free on 8-CPUs VM increases about 2%~10%. The inline also has
> downside: both the kasan and kcsan checks on the pointer will be
> unavailable.
>=20
> bpf_kptr_xchg() can be inlined by converting the calling of
> bpf_kptr_xchg() into an atomic_xchg() instruction. But the conversion
> depends on two conditions:
> 1) JIT backend supports atomic_xchg() on pointer-sized word
> 2) For the specific arch, the implementation of xchg is the same as
>    atomic_xchg() on pointer-sized words.
>=20
> It seems most 64-bit JIT backends satisfies these two conditions. But
> as a precaution, defining a weak function bpf_jit_supports_ptr_xchg()
> to state whether such conversion is safe and only supporting inline for
> 64-bit host.
>=20
> For x86-64, it supports BPF_XCHG atomic operation and both xchg() and
> atomic_xchg() use arch_xchg() to implement the exchange, so enabling the
> inline of bpf_kptr_xchg() on x86-64 first.
>=20
> Signed-off-by: Hou Tao <houtao1@huawei.com>

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

