Return-Path: <bpf+bounces-14115-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE547E0963
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 20:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 105DAB21490
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 19:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B56D22EF9;
	Fri,  3 Nov 2023 19:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0Zm2w37"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E10225A8
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 19:19:41 +0000 (UTC)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF78910CC
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 12:19:35 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c50cf61f6dso34299891fa.2
        for <bpf@vger.kernel.org>; Fri, 03 Nov 2023 12:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699039174; x=1699643974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=85PB9Fhh/TaHpsfCw62uKWHoL10nzV/VBnJWvjPoASI=;
        b=U0Zm2w37IWMW97RfB0h+fD2MRCHN+DxAiAVzqz31iNYKE4oSRnB/lfLdSoGm2+k4Lk
         /HWtB6W6OCmi2Si/bD3nXO0m2Sx1jy+/Sb3MvdTHQA7WyxOFamXn1Lp7r0Ln6ksktHnj
         c22qhxIDVA/MVUD4qGhbkWplol9NL34tNGTn3UvDqDyAYUGWx9PqzihMtlaTJ6T/Ouj5
         KPiXdy0xGY8v5HsZuwbgfYXXOiSOlHspulzBc++8oZwDhSFZuyb+BM3Gw7Wo6ReCuu24
         LYd57mmS+uVvWS57Z+2EcbTWYiWDqeuzkXIJSn7lnbzRmEjMkVVTzM2BdBN3NzmtRPI8
         aILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699039174; x=1699643974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=85PB9Fhh/TaHpsfCw62uKWHoL10nzV/VBnJWvjPoASI=;
        b=NmFiHQJpPpRuMZLP2+duUF+3Pc7ZWF4QUbxtlKDksDqnoyoaMjVgpGlAbBfEm+DzOK
         mIPlFDthnlwebGdUBX8w2l/HcYvWltYLUfJGbvID+2ZdTg4jUjS3dufGeJycZL41va6r
         saZvlkVc2fSQeDQNYQhqXd8ard1NmNIqxi8fG/aG4ehpjuEcfKmplrxhPGlHY1elIXg3
         rwREJlcocJA5ajqsj23z9+zbzySsrchmBVg0tAwyWNSWF4PA0yQIpRyvxqdCECpdyD1g
         RD+LE6Bq6CEDmAM8605IrO6XKG1idB3nCIqctp+hWTpK93413DSIUs/o6YRzzFL4q1lQ
         IAdw==
X-Gm-Message-State: AOJu0YwSDiOOjn0Nz0lWNSHD8qznJjfReUQbiF5WP2J3NBlGL+zHxWd9
	O3eayaiwcxQCvYeGkLU5u67brl4nysdeuejqvGK6Ebo64a4=
X-Google-Smtp-Source: AGHT+IFWlXpclfQe8s78F1Yj2N2JzQdIgGOllly+PT+8F6Fq3qnss3M4Nf5KGdzBZuiwMT6gDYZURfKjmEMwRQMt7qk=
X-Received: by 2002:a05:6512:5c8:b0:509:4a02:1205 with SMTP id
 o8-20020a05651205c800b005094a021205mr3996522lfo.46.1699039173603; Fri, 03 Nov
 2023 12:19:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103000822.2509815-1-andrii@kernel.org> <20231103000822.2509815-8-andrii@kernel.org>
In-Reply-To: <20231103000822.2509815-8-andrii@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 3 Nov 2023 12:19:22 -0700
Message-ID: <CAADnVQLXVXfY-pJj0_xSdoOEPnPtQgxzxzEDxFjLki=n80zZAg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 07/13] selftests/bpf: BPF register range bounds tester
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 2, 2023 at 5:08=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org> =
wrote:
>
> +enum num_t { U64, U32, S64, S32 };
> +#define MIN_T U64
> +#define MAX_T S32

I haven't finished the review of the whole patch yet.
Quick thoughts so far.
Can you change above to:
enum num_t { U64, first_t =3D U64, U32, S64, S32, last_t =3D S32 };

1. min/max names kept confusing me while reading the diff.
   I read MIN_T is a smaller (minimal) type which is 32-bit.
2. reusing enums without LOUD macro names is easier to read.

and similar with _OP macros.

