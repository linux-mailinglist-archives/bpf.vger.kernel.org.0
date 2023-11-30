Return-Path: <bpf+bounces-16284-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACA67FF4AA
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 17:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A38A1C20E51
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 16:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1986954F8B;
	Thu, 30 Nov 2023 16:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F1uTRRu+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B1E2D64
	for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 08:19:48 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso12312a12.1
        for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 08:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701361186; x=1701965986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Is7F/Sfd9ylycia+YjUucPeLJuNyhVybVoiP5aPb4u4=;
        b=F1uTRRu+qa/EMSoaLmpAJHcLnB5uJ6718savUC+1v16u2MwpX8PNWiWfRtCI/5dRA0
         q86wvFMu/4tIMFdOS1KBlQbOlK4vGF1s+P9eBo3EDTWnIktfH/nRBsNwYmzuYzfP9nk0
         t8mJ6Fg+AtYUhDO6WIEdg+rg0QttEbAhnhIVsm7/pMsxh4MoJ3rqPI1e0LFueJpw4A0K
         wlR8Nd7Uf0M4RNAKT6jNy9hUrh/GaFnkumLMjKYlMe6iLcA+0OL1gZ8Ee3rnh3OcjlXu
         tl/V2QClgsMBqusCKHZTIRcTPIZF6rKl45krIFO/zmzt6CkXkg7gROt8cuJNjGx6d8eG
         RVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701361186; x=1701965986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Is7F/Sfd9ylycia+YjUucPeLJuNyhVybVoiP5aPb4u4=;
        b=ZeCDlUwkmyg+jRmk3sfSsD7lrVJHRGWuJCrLNtsGgbzV6u41pUX2sHkXECF5LuGlF4
         QB+hc+YHIZMJTslScQtHAZRlBJr+iQIUqmjeimpFXNm6xtud8FjWKs+dqeBZqbf7IrWk
         ioz95bjkps0nED/yLT4bLy6S/nrYKMqSeZobVvtLNRw6dB76TARIcEqFI+9j2DGz7o2Y
         BTu9mXM4aeuMDTf75vuawOHNi/OWrnHGQdqRNpJPr/CLWmZ89oYQzAxoidQgk4Ud8riP
         CJMqEXMDV1Oo9SuDqv9VtVuFJNwb9EajP4s16/9H5ZuSyKOJhC/41pV80hR6oJkf5atb
         AZWQ==
X-Gm-Message-State: AOJu0Yyy03uN9jZ/LLLWFXZzvi+bMd8hnuX5IZXTQSTQDz8fIzFiYakb
	KJ1n3PPCDP2XZYLcAkXoQwvuyKYh/CjIYrC9A68hbg==
X-Google-Smtp-Source: AGHT+IEkIXZFjJZr/mqcoqsuXQvlwMcdbAprJKPrr9YE4lgr+ofCdqPVx1WKFdCWtM9jFqu/qUApE1ZClmbmWa3ddlM=
X-Received: by 2002:a50:d098:0:b0:54b:6b3f:4aa8 with SMTP id
 v24-20020a50d098000000b0054b6b3f4aa8mr181754edd.4.1701361186255; Thu, 30 Nov
 2023 08:19:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129234916.16128-1-daniel@iogearbox.net> <CANn89i+0UuXTYzBD1=zaWmvBKNtyriWQifOhQKF3Y7z4BWZhig@mail.gmail.com>
 <edef4d8b-8682-c23f-31c4-57546be97299@iogearbox.net> <6568b03cbceb7_1b8920827@john.notmuch>
 <CANn89iK9VrbRJsF2KoLfArv5Eu5d7Hyq-pSO4hmWuS_PNsM8dQ@mail.gmail.com>
In-Reply-To: <CANn89iK9VrbRJsF2KoLfArv5Eu5d7Hyq-pSO4hmWuS_PNsM8dQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 30 Nov 2023 17:19:35 +0100
Message-ID: <CANn89iJUwnYGKW3mgCX8_9hFwwBeDXrbsk-XwOtsM2u0J7cyMw@mail.gmail.com>
Subject: Re: pull-request: bpf 2023-11-30
To: John Fastabend <john.fastabend@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, jakub@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 5:04=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>

> Here is the repro:
>
> # See https://goo.gl/kgGztJ for information about syzkaller reproducers.
> #{"procs":1,"slowdown":1,"sandbox":"","sandbox_arg":0,"close_fds":false}
> r0 =3D socket(0x1, 0x1, 0x0)
> r1 =3D bpf$MAP_CREATE(0x0, &(0x7f0000000200)=3D@base=3D{0xf, 0x4, 0x4, 0x=
12}, 0x48)
> bpf$MAP_UPDATE_ELEM(0x2, &(0x7f0000000140)=3D{r1, &(0x7f0000000000),
> &(0x7f0000000100)=3D@tcp6=3Dr0}, 0x20)
>
> I will release the syzbot report, and send the patch, thanks.

Actually I will release the syzbot report, and let you work on a fix,
perhaps as you pointed out we could be more restrictive.

