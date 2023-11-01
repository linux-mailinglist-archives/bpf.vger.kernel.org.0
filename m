Return-Path: <bpf+bounces-13856-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C3B7DE836
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 23:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54AA41C20DC7
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 22:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7302F14AAD;
	Wed,  1 Nov 2023 22:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="miQiK/CI"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B0D18E18
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 22:42:50 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB2112B
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 15:42:48 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9d242846194so47683866b.1
        for <bpf@vger.kernel.org>; Wed, 01 Nov 2023 15:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698878567; x=1699483367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9P9I+JsW+U5rwOu6HOfX8QeRdhVFnbG4F8rQ8mGYRE=;
        b=miQiK/CIeQiiYkK0nzo32iyBBILYPxu8fPcWllXtYjgC3KalabmnYutLu0u8Jz5FYY
         IzM1Fhc4hmNcI17++j2tJigqzn8yhpWEd5LXDDUzK6S8ZZ7jirRu4Bxcpgl1kbsgEFQ5
         hNTg6hfiXwIKNMxFllThzUjQY5CQc28AGPftcHjOgtrv9Qp+P3eQnHt2jcPUIxtIBWD7
         lMTZIHGxgARFAz630w9h84OfjYis4Y0iwzOLhb4MLeWF1IzNDp6qLrmvtaMdZ0nAT8mG
         uwpwdcKlc/7xfI/9HZwapaqR8WBb3MesRst1cR0HMlxYLwouppWsYtalfNwvhETG0CK6
         Zahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698878567; x=1699483367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g9P9I+JsW+U5rwOu6HOfX8QeRdhVFnbG4F8rQ8mGYRE=;
        b=vJw8JjBN0GHM4h30yVd+BPuBqApl9XDePLa9WeMusFWA0vNqCUx6plY2+PILLT469p
         gw7p8db6Ge0cIMtywMKrgI8reY3oFqWcV3Q/0Xp/95T9Jp5akNBhLpLNeZ3WDEzyjCPs
         yxLIldVUTtoyaA7xnNf9s02oJnYIGmaWdnzRFuYxk/n3/5ZmPXvesDTZevsG+0yLR/4Y
         0VURDr7PRaLRWULhPuwCpuaROcXExFtm4TCj6cAFM3EnpPl+xSpX5LE1x7Xm0WljUsPJ
         8MFHYfYXouiNf+k2JthWxoyK83Y18EUy9Cpb0A/yLlN8cTuHw4Wn+F5q6t7T4Z5UQGgX
         jkpA==
X-Gm-Message-State: AOJu0YwkhnkAWDIuMN9dyMu0+iNH6xtKC7iFYuJgmhnyMcCmjIxkWFS0
	cJq2VgfbeLDcX/b+FQwPQUV1CydxYTGwXemgHuQ=
X-Google-Smtp-Source: AGHT+IFeiq38v2oGZd+1i7GNP4Yw6kgXplTfb+6bUYHVAxf9CK8tQr100eI5Xh/J999TBCK59QbMN5C/QjkKH/Ph6ro=
X-Received: by 2002:a17:907:1c0c:b0:9c7:59d1:b2c6 with SMTP id
 nc12-20020a1709071c0c00b009c759d1b2c6mr3620555ejc.11.1698878567117; Wed, 01
 Nov 2023 15:42:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN+4W8h3yDjkOLJPiuKVKTpj_08pBz8ke6vN=Lf8gcA=iYBM-g@mail.gmail.com>
 <e9987f16-7328-627d-8c02-c42c130a61a8@meta.com> <CAN+4W8hK9EEb7Qb2How+YwNkkz4wjRyBAK7Y+WcqBzA9ckJ5Qg@mail.gmail.com>
 <CAEf4BzaEPMVFfEYwHxje8sm+26bgeLJ+4hfdGNOMHd5bV8u9rw@mail.gmail.com> <CAN+4W8iTm-GS_-Wp=XjY1Txs09G7F4d3vcG_30WDOp-CpDKmCA@mail.gmail.com>
In-Reply-To: <CAN+4W8iTm-GS_-Wp=XjY1Txs09G7F4d3vcG_30WDOp-CpDKmCA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 1 Nov 2023 15:42:36 -0700
Message-ID: <CAEf4BzZQQiD5x0PRwGD32bE7izUxhPvRRQTMpifQZYvu+0mMkA@mail.gmail.com>
Subject: Re: bpf_core_type_id_kernel is not consistent with bpf_core_type_id_local
To: Lorenz Bauer <lorenz.bauer@isovalent.com>, Eduard Zingerman <eddyz87@gmail.com>
Cc: Yonghong Song <yhs@meta.com>, Lorenz Bauer <lmb@isovalent.com>, bpf <bpf@vger.kernel.org>, 
	Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 1, 2023 at 7:18=E2=80=AFAM Lorenz Bauer <lorenz.bauer@isovalent=
.com> wrote:
>
> On Tue, Oct 31, 2023 at 6:24=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > >
> > > Did you get round to fixing this, or did you decide to leave it as is=
?
> >
> > Trying to recall, was there anything to do on the libbpf side, or was
> > it purely a compiler-side change?
>
> I'm not 100% sure TBH. I'd like clang to behave consistently for
> local_id and target_id. I don't know whether that would break libbpf.
>

*checks code* libbpf just passes through whatever ID compiler
generated, so there doesn't seem to be any change to libbpf. Seems
like compiler-only change. cc'ing Eduard  as well, if he's curious
enough to check


> Lorenz

