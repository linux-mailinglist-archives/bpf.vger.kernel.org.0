Return-Path: <bpf+bounces-15496-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D41F17F2472
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 04:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1788CB21A2F
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 03:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52981427E;
	Tue, 21 Nov 2023 03:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nViiEbTa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414159C
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 19:01:27 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-332ce50450dso57824f8f.1
        for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 19:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700535685; x=1701140485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1pstbD97kHcUgQjbvFy5NbfJUOFlMjG8/d//91HchM=;
        b=nViiEbTaMnHRN7BmX/13sll5rn8tj6R49q97vOeLJNGm2ajlpk8fRuqgdmOpMrC6S4
         0HaOlC2zI+z/mm1D/MzuEack3S/pcedPgtdHhwwJU9ysKOpkCMNJUp0bIJtjP3v+uaOg
         7KmFiPRPNBYiQWBKvXpLRSCmj6kEwr43hzYk4K4p0x0Wq+oCzBSuGCVT9JvBeBr9ijP6
         S1hEGLdrtKtTDvBYbWbenDO3YC7nlqUbkKuMJFSUm8u+YRVEQbmhlyjXGRjwDFeHsQEB
         1q/RAdMRG2qm/JXFGDU+M2TG/Q8RKdeXANuyBQlUHfxN5JP/dn93v8YVRwvFD1T/SXUK
         gJuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700535685; x=1701140485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x1pstbD97kHcUgQjbvFy5NbfJUOFlMjG8/d//91HchM=;
        b=cVSE8OrM7kDbqA5sIH326UI9gt2KRYlTwprG7dZYpN+Oq9AITgjGfxdbOwCfn2Lkaz
         iFGFE6U5ytw9HEzb1jTQlurJHFQhChqOZAQHtP+e5tIEt7/PBncJ1IVH6sj9UMBNvJb8
         AnoDAw9O24oQKFUoyOCFuaOXXluqW8pyHbclBzzXFCM9UcVFs2D2XyMZMLZPvf7YDh4i
         KHmL8gXowLnRAf3JF/YDkEroVsIzHNxAOkcAS+NESXuZPRm0OuNWHfWRmhxZghghRc20
         pHfcYOAAjm2AgAsrVeziiCTdQQJU4cV4jWi0DOptcdMindDY//f3hRr5DoZUQCj8F0LD
         N40A==
X-Gm-Message-State: AOJu0YziRo69RwBUEAuHwJVew0zg7gsuVNSDEYK+IbmMlgfFYR+ij6GA
	XkO2d0rIeWzNRCyKy0MZ3wzZCxjLp540LnkNzFQ=
X-Google-Smtp-Source: AGHT+IF+VGcZrzhX+WwiwbWl+eyW3FzdiV2UsC8XMKAfrVcCLjDvNUWMB705CBlWub5S5aHagvOGQXrXbr812uR4qlc=
X-Received: by 2002:a5d:540a:0:b0:32f:7f2c:de2e with SMTP id
 g10-20020a5d540a000000b0032f7f2cde2emr5785907wrv.36.1700535685410; Mon, 20
 Nov 2023 19:01:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121020701.26440-1-eddyz87@gmail.com> <20231121020701.26440-7-eddyz87@gmail.com>
In-Reply-To: <20231121020701.26440-7-eddyz87@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 20 Nov 2023 19:01:13 -0800
Message-ID: <CAADnVQJv8gm4KH9mROdU9BEcxh3UrdpZTn3WKTbB1_Abp-QzDQ@mail.gmail.com>
Subject: Re: [PATCH bpf v4 06/11] bpf: verify callbacks as if they are called
 unknown number of times
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Andrew Werner <awerner32@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 6:07=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> Closes:
> https://lore.kernel.org/bpf/CA+vRuzPChFNXmouzGG+wsy=3D6eMcfr1mFG0F3g7rbg-=
sedGKW3w@mail.gmail.com/

The url needs to be on the same line as 'Closes:' tag.
I fixed it up while applying.

