Return-Path: <bpf+bounces-61575-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D9FAE8F12
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 22:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CFF43B587A
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 20:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA621FE47B;
	Wed, 25 Jun 2025 20:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9CMqm+J"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2D128F4
	for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 20:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750881700; cv=none; b=rQdfPfdC7DEUoI0YzWlhZNlB4UhFLIK6KE8pmH8ZbTH3U0uZaOOASA/+mhZziKHMKjDyAGT/w8lADga1LF1kT08eTvg94TfLYmaU1GuKP05Un4TrSE2iZwDb+7Xob7eENaj9YYV3ZuBZG60RQrUVFbaJaow1FY15eRnfhnleqQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750881700; c=relaxed/simple;
	bh=SEFMVreaMerKvE1z/RjDXGTc8MKcb6pzBaK7BhzK/lg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=amB/v7vC7jIG6/RQ26+7oSeUrY0+cjxZDr0NVH2Xuzxa1Q/WssffXlqtVbFblfim6KDeRBd+lIgGcQGzjaSyZ/Q0GHee76yU5Wv72TU31hFAYsVM1GkMePrKbxKRHy4Og7mz30N+cK7XdyojdbeVpNVtqdugC2/2I3DBMlvCQDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9CMqm+J; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-748f54dfa5fso310169b3a.2
        for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 13:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750881698; x=1751486498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQhifObJh6x9lI4hQaZt3Fok/eLtx/HGg1O+z0kIcho=;
        b=f9CMqm+Jmu4oFPbGqmbeFMYhR3VLRzK/EonPfUJ0M1mCesWWSuW3DyKp/aQ66+7HXt
         lF5E42PN4CfaeYIB7sv2xGCJ6TbiQ6aKWykCa/pNyLWYgMBAbEQsG8fpKYq7ex1ssP1p
         VbIQD/IwPsUQ8bqFx+SDO1U/DsXEbCZ0OpMigq2bq8k8Moz5qYTapbD5sp4SNVuHvNDl
         DL8tUMsjqvSq8STYDvPCr5HxsQRsZa/bHxPcnPjvL9V9ByrJ8Ay4dhC7u1REKRn2p6SI
         DEBYIOgz0EW4TE3gn65EIY1I37OIxOlxJ4Xw2hQ43mgXpTFNGxOcEKbonc5AGN7ghkND
         WJgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750881698; x=1751486498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HQhifObJh6x9lI4hQaZt3Fok/eLtx/HGg1O+z0kIcho=;
        b=py8sini+eRRPBzRYihQVeDcmVu1m+a8wlD3mJMOn4hzlRj33KBjIi0SMgfy5SiSPiz
         vonYjARRAeSx6KnTUQkeK2HZz5uIc8pOA9H9odJt/D/0Q5Um7kLv6u1j4siypJkDgqhR
         swe9zFFiCHRka4dPSNyaclFXox0fzeFJrIo4OsoO/nkXCXNDdESubU5dRcCcmABhwHVp
         L9VHfm++iMUwmN6wTr0W0xZP6rLQEL61bv1l5yqsSHTjR5XQQX7NQE3Ficte2UIYUK9g
         B+V93qZlYrPjjd1JVL37zZZJ5GK67OpgIGR6cmxR5vysHyI9ypIsfTWwaZJJsGVM5WjL
         8x3Q==
X-Gm-Message-State: AOJu0YzhgR1uksNWwuVIVDMiATOUERAq6bJYiCSUh2kbpSIA0aye6lhc
	zt/ugTEScnvf+XgpV+K8SFUrq/+TpkbaVXs2FIACSuUpfToNC/I8/3lCCkp6XC827ENUHhWdvQs
	rmzmdvqFE+WNSuOnWAU3lO1qRI2jdS38NHDwRLQo=
X-Gm-Gg: ASbGncvtmKaY6QmhQO82RUTqeQZtqCSII63gm9Tl18tPW+hJnDQUkP4eSJPsfE0lznH
	DApqDVL74dt5+x0MlZO/N0n9IKIOQX5D8pyOZVlCfGCx6iEoIMFxBqzCBrblzKk8PpbzV8jxHxK
	qrygc/cyB7emuhRKj33FU6mr0Md24KEuaJ7nhgYe2KCrQjgGFG/o/fUgeaaCM=
X-Google-Smtp-Source: AGHT+IGHhsy2iL/ZvE4QpY9bkMZzpH1Cbd+z4H0SgMkUBfdw3ZfHvgRn6zMuP0z+/6X+6vkXGZR33D9ther+BUQSJmQ=
X-Received: by 2002:a17:90b:288f:b0:311:eb85:96df with SMTP id
 98e67ed59e1d1-315f2676b34mr6675408a91.17.1750881697859; Wed, 25 Jun 2025
 13:01:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624031252.2966759-1-memxor@gmail.com> <20250624031252.2966759-10-memxor@gmail.com>
In-Reply-To: <20250624031252.2966759-10-memxor@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 25 Jun 2025 13:01:25 -0700
X-Gm-Features: Ac12FXygh3XnuBapRN2_Laa2N4kUNJsmpIu1TcwOM5s66U1hD60A2lPaZ95qHwc
Message-ID: <CAEf4BzbT-Hv_82rUOXdmnDNXck8mbmEtYL8R6rowAk64-Ak_0g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 09/12] libbpf: Add bpf_stream_printk() macro
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 8:13=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Add a convenience macro to print data to the BPF streams. BPF_STDOUT and
> BPF_STDERR stream IDs in the vmlinux.h can be passed to the macro to
> print to the respective streams.
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  tools/lib/bpf/bpf_helpers.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> index a50773d4616e..76b127a9f24d 100644
> --- a/tools/lib/bpf/bpf_helpers.h
> +++ b/tools/lib/bpf/bpf_helpers.h
> @@ -314,6 +314,22 @@ enum libbpf_tristate {
>                           ___param, sizeof(___param));          \
>  })
>
> +extern int bpf_stream_vprintk(int stream_id, const char *fmt__str, const=
 void *args,
> +                             __u32 len__sz, void *aux__prog) __weak __ks=
ym;
> +
> +#define bpf_stream_printk(stream_id, fmt, args...)                      =
       \
> +({                                                                      =
       \
> +       static const char ___fmt[] =3D fmt;                              =
         \
> +       unsigned long long ___param[___bpf_narg(args)];                  =
       \
> +                                                                        =
       \
> +       _Pragma("GCC diagnostic push")                                   =
       \
> +       _Pragma("GCC diagnostic ignored \"-Wint-conversion\"")           =
       \
> +       ___bpf_fill(___param, args);                                     =
       \
> +       _Pragma("GCC diagnostic pop")                                    =
       \
> +                                                                        =
       \
> +       bpf_stream_vprintk(stream_id, ___fmt, ___param, sizeof(___param),=
 NULL);\
> +})
> +
>  /* Use __bpf_printk when bpf_printk call has 3 or fewer fmt args
>   * Otherwise use __bpf_vprintk
>   */
> --
> 2.47.1
>

