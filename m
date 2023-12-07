Return-Path: <bpf+bounces-17040-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C490E809315
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 22:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8F42B20F2B
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 21:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E272B54FA3;
	Thu,  7 Dec 2023 21:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LyNnwWag"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34781716;
	Thu,  7 Dec 2023 13:08:19 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-59064bca27dso665121eaf.0;
        Thu, 07 Dec 2023 13:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701983299; x=1702588099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cT8aoY+rEUbS2cmho5uFAl6BrXELpVToy3OJdxx6OrM=;
        b=LyNnwWagJp0D7TbUx6FE+b6nvhHt1TJiXvBPdjailIhJcBWxw6alwEzS5ixQ9hRKsm
         /t4mg0W/VVLgZdeRAm5BA+htOhgkEB+gVHKL/l9TyMKj2ZKEBWSZ+yf0Y0uO8270/oI9
         pnI45uauZjL/tLe9FtjNV5cj0J9XNmrnmuh4OtNXjjzey6Fh+ugPnd3DjL2otnzrrX78
         mJk/LPn/QteA1jgzvx/JP1T5KkQJO6zdaWX/zMVwb9qE5gHeMG6Su0KKMAeMLa5bC4bu
         nTt4e2XjgsWk+2TVw4r6eKqV6i1RC0DUcu2TKhI0l41QIGVKxzuesqhQCh8bzxU7NxO5
         xdEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701983299; x=1702588099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cT8aoY+rEUbS2cmho5uFAl6BrXELpVToy3OJdxx6OrM=;
        b=YyHQeAVup2nwq8rqZQ6Pes/fBJVqX88rfosIB3skwpsnH4CgRPE3TbEC6e0IKsdrv5
         MWRtocPcwZzi0+kO4CQ3K0TYR4yUoQaZ+vgmZpV4m+7X0lPsWBSbQp9KGWQDwqxxTeNa
         CM6VtthyTzDqR7btZmCDi+B96qI8xYdpNQIM1gCnJJJobn3xWvFFeJYMxbOcJqQ6afZA
         cE/nH+lip1VJJri3KkaLZnHqwfK7LrqYQxPqEch0UilKNlek+mK4cGd7PipvSavBLhh+
         FEoZYx1MY/3Vu/1F5ct5bGyIlEl7CflUd/4jXnaWJhZg4PjQuG2b2A3rZyqCreMx75gR
         t7oQ==
X-Gm-Message-State: AOJu0YwfYb8HzqicPmHgvHDifsoRPaixQEdGgCZBg8rs7LyLJSDWT6VB
	tk8ggguUzYgQYwCYghUqdNRzDbO7t2lnsFs6E30=
X-Google-Smtp-Source: AGHT+IG83QhY+pRKk3BmyKEfFMPW4XrmoG6/c8wZ9DRo4O/G68kHGBkfM+q/nfwoojAXScdP2rjxHN46fkRs2UFh+lY=
X-Received: by 2002:a05:6820:1508:b0:590:69cf:d99 with SMTP id
 ay8-20020a056820150800b0059069cf0d99mr1980369oob.3.1701983299115; Thu, 07 Dec
 2023 13:08:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1701722991.git.dxu@dxuuu.xyz> <a385991bb4f36133e15d6eacb72ed22a3c02da16.1701722991.git.dxu@dxuuu.xyz>
 <ZXGx7H/Spv634xgX@gauss3.secunet.de>
In-Reply-To: <ZXGx7H/Spv634xgX@gauss3.secunet.de>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Thu, 7 Dec 2023 13:08:08 -0800
Message-ID: <CAHsH6GtmhP=hZcf2Qv=21dAOSb5dD4GDa+QYdLFz9_FsCZq6tA@mail.gmail.com>
Subject: Re: [devel-ipsec] [PATCH bpf-next v4 01/10] xfrm: bpf: Move
 xfrm_interface_bpf.c to xfrm_bpf.c
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, 
	Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com, 
	devel@linux-ipsec.org, eddyz87@gmail.com, edumazet@google.com, 
	Eyal Birger <eyal@metanetworks.com>, yonghong.song@linux.dev, kuba@kernel.org, 
	bpf@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Thu, Dec 7, 2023 at 3:52=E2=80=AFAM Steffen Klassert via Devel
<devel@linux-ipsec.org> wrote:
>
> On Mon, Dec 04, 2023 at 01:56:21PM -0700, Daniel Xu wrote:
> > This commit moves the contents of xfrm_interface_bpf.c into a new file,
> > xfrm_bpf.c This is in preparation for adding more xfrm kfuncs. We'd lik=
e
> > to keep all the bpf integrations in a single file.

This takes away the nice ability to reload the xfrm interface
related kfuncs when reloading the xfrm interface.

I also find it a little strange that the kfuncs would be available
when the xfrm interface isn't loaded.

So imho it makes sense that these kfuncs would be built
as part of the module and not as part of the core.

Eyal.

