Return-Path: <bpf+bounces-12607-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B967CE789
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 21:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E76C9B211CB
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 19:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C9A450CC;
	Wed, 18 Oct 2023 19:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVdqhlsu"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487421F16B;
	Wed, 18 Oct 2023 19:18:25 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B32AB;
	Wed, 18 Oct 2023 12:18:24 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c9b7c234a7so62366965ad.3;
        Wed, 18 Oct 2023 12:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697656703; x=1698261503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NG8xDx7terS9QmCT7NO8n1XBkFKCFD9jcbOnlRt+1sE=;
        b=IVdqhlsuEeCvj7ajTysNzvgvMso/qXMJp5sCpFMd2NqTEoiREMa8BmaCRipvsMGlg+
         /PYk+AOSH0xoLjRpRV75NRI9UtzZDxGBl2o1tCwsPni6iRYzjFaU9fnA1UyowXnryz+4
         sIRtwTdM3VYxbeZcfPaTUOH7nWh+kNqoUBdTMS3VZLQzhimxhNx7NQgNZMit+WTDlX9s
         ZEYGVM6jWh0FH7WDX9D//gTMES9pWlroS4LiOC82NHXd8GTVotANaKKTsr8hGSREV5fV
         QTu4HkaLa3fEpVyI4riHRqexqxY1OdeJTEwR2GQQUi4+N0cS7aUKL8Oij2Kl1gorZMa5
         qB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697656703; x=1698261503;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NG8xDx7terS9QmCT7NO8n1XBkFKCFD9jcbOnlRt+1sE=;
        b=c3Xo21YfJQI1woV8Plavg+fFUHiwybw4/IIDeoBaRU96AKSBTKqMika5hCDxvBVDsC
         ylw4PfO8ZwmVwZxHleLdZKHDcH/OhI2HY5zQX9VCoTNf8DABnTX/Xx66i3GpBnLe0ex5
         KSQ0PkP28x5PH5n04rBI04Qbtr5J8w03Q3CWx6ZUHVQmF0iMVOjkHsVN1+v4kSoAd0FW
         SSpOm3YFXPd7e6VFBWIOCVanKnySp6wPXz8K/WDkl+6iNFXMkBezfHpFY1JAc/AyDOHR
         okNbMrha/nVr4n2tGmYp5ylc1SPPBKAmjMvlD9qw9Y7dD6t9gxu3UVQhMUYRWaww+0vO
         Oapg==
X-Gm-Message-State: AOJu0YwZBDa2MWFwXwLI+lCfIsDp9DHkO11hm91MtdcjWv10+kEe1djm
	EoEXqkTXegqpdFC6it0UYds=
X-Google-Smtp-Source: AGHT+IHn7rNC99r0ByBx32gdk/BLbwNNlRWv/DFUH2OGhQqUimXjSgIsEMHnKxp+O9tcFEGeaYBEbQ==
X-Received: by 2002:a17:902:f549:b0:1ca:754a:692e with SMTP id h9-20020a170902f54900b001ca754a692emr400672plf.30.1697656703324;
        Wed, 18 Oct 2023 12:18:23 -0700 (PDT)
Received: from localhost ([2605:59c8:148:ba00:f357:1d39:9540:831f])
        by smtp.gmail.com with ESMTPSA id p9-20020a170902bd0900b001c7283d3089sm270654pls.273.2023.10.18.12.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 12:18:22 -0700 (PDT)
Date: Wed, 18 Oct 2023 12:18:21 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, 
 John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 bpf@vger.kernel.org
Message-ID: <65302f7d693a8_b74c20846@john.notmuch>
In-Reply-To: <CANn89iL0f+RWFm1FuNmKjoeMTMZQZHW8=83ZQnUxiY8B6hHxrg@mail.gmail.com>
References: <8f99194c698bcef12666f0a9a999c58f8b1cb52c.1697557782.git.pabeni@redhat.com>
 <CANn89iL0f+RWFm1FuNmKjoeMTMZQZHW8=83ZQnUxiY8B6hHxrg@mail.gmail.com>
Subject: Re: [PATCH net] tcp_bpf: properly release resources on error paths
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet wrote:
> On Tue, Oct 17, 2023 at 5:50=E2=80=AFPM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> >
> > In the blamed commit below, I completely forgot to release the acquir=
ed
> > resources before erroring out in the TCP BPF code, as reported by Dan=
.
> >
> > Address the issues by replacing the bogus return with a jump to the
> > relevant cleanup code.
> >
> > Fixes: 419ce133ab92 ("tcp: allow again tcp_disconnect() when threads =
are waiting")
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> =

> Right :)
> =

> Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.

Reviewed-by: John Fastabend <john.fastabend@gmail.com>=

