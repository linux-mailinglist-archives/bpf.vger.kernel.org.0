Return-Path: <bpf+bounces-17048-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE768094F6
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 22:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 535A71F21161
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 21:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2DF840ED;
	Thu,  7 Dec 2023 21:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpWXPe6l"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AAD122;
	Thu,  7 Dec 2023 13:57:36 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a1f0616a15bso125561866b.2;
        Thu, 07 Dec 2023 13:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701986254; x=1702591054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1UBPKwUkAU+wrKbpjbMF7X3FH5KwgZqLzR/JtIscjY=;
        b=bpWXPe6lJsMhRC/P3uZcEkNboF6VGbfA6/c9wvShblv4DQCIYAHaSlXc332R6hp9vK
         WZRSNIKBTtWKwZcztaRLfSyweHiohun94hzGvwo5KpOOoZ/StcG4Ev2SQcZI61G51MQl
         YdwTbMvCnPtiHAr3mA7vyBVVv7djZxIZ/Cut61laXvF0hUrAjwdYIo4RtkPM48DrrdWM
         SZmGV1f8g4lsfe+Yi+8bgDkbcqchEY4AEsZtSnIBgtxJDxJ8M3RPgnTSJXyajKgfqUZz
         GjqKpMAt3f0/Kk7aDcMcPgAyA10ZofSOfPVkCiWuCA6xq5ZoYdUcbNTnMYELbW6cfd4D
         Yc8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701986254; x=1702591054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1UBPKwUkAU+wrKbpjbMF7X3FH5KwgZqLzR/JtIscjY=;
        b=wA83vsEWZV77E0u2dpAkPekFjMsgPXveFabJZiOZbx5uct21wAcjLn4XopaA3qsEOv
         3hhg2Ik0Y8F1CA4j/kIrspKB4Bee0zF75QeUIOs/PN+XiN6D/fqGAjpz893hsp4X52Gq
         hZstfQUEEDwD0Ner/XswFYXGYl2lMGaq2YWkIvZ7WGFj02NwuMtxhcwhuyxyUgNFrPEx
         eKgFn32F+tGMvQLdFqrVIMY4E4g9tgTHNJz4oBus+UKgzuzxxx0GrB71AdWXveYbaKca
         5ZwXHbJk6W3KeehA70SI79bDu7X5ilk93jqu67apQr8n846pT2tEoevWyNIIrcrqI7p/
         UGTg==
X-Gm-Message-State: AOJu0YyQSmnJkA+IF+vpcSQ1k5rVjltazHedtlo3durri+v6umUGHmVs
	98bw0AcSGgwWpiI1Yg3gsxBcLvSfu9JNHNXo460=
X-Google-Smtp-Source: AGHT+IH9pQ0kFIBWnVfD34zZ6fGAqbnvAM0QYuLJ/wbuApqcs59iOKHO+XR0uOCqrX4RrCDTseHCa2NN+Lq+rQcGOw0=
X-Received: by 2002:a17:906:2201:b0:a19:a19b:78a5 with SMTP id
 s1-20020a170906220100b00a19a19b78a5mr2307052ejs.104.1701986254278; Thu, 07
 Dec 2023 13:57:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208084758.67fbd198@canb.auug.org.au>
In-Reply-To: <20231208084758.67fbd198@canb.auug.org.au>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 7 Dec 2023 13:57:21 -0800
Message-ID: <CAEf4BzZJPir0e47D==r9NB=fNyT2vSSGhUFyfYfAkmeJVKnP6Q@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the bpf-next tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Andrei Matei <andreimatei1@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 1:48=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org.=
au> wrote:
>
> Hi all,
>
> Commit
>
>   ec32ca301faa ("bpf: Add verifier regression test for previous patch")
>
> is missing a Signed-off-by from its author.

My bad for not noticing this, I'll fix it and force-push, sorry.

>
> --
> Cheers,
> Stephen Rothwell

