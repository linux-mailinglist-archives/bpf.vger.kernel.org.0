Return-Path: <bpf+bounces-14122-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B9F7E0A8C
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 21:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9370F281FA1
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 20:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873DF22EEC;
	Fri,  3 Nov 2023 20:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1OYlXTG"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EC31D699
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 20:59:26 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14409D53
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 13:59:18 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-543456dbd7bso6965353a12.1
        for <bpf@vger.kernel.org>; Fri, 03 Nov 2023 13:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699045156; x=1699649956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5W9lSDJO8fwv+IPZX1odI1VoWlpD0qf+u1GxHI3cXy4=;
        b=X1OYlXTGq4bdB/k7HOja7mvgIEPi2pPU80UA7oGRKT/sukEE6uvT++PwB1ppY57ZF+
         fibcCI7PPmCda74ADbX/aho5yUV7TvxeS53lrBiERuxBMKVgENaYtbY4b+dV+J1Rfe/T
         NLCToISebj3+Ee585zf1TOuoF9bLQIY/0BrLyiDZ2axIYYU7G5EyBb2QzD0AXd0TRmQU
         N7reTjitlonKwIjTpGq2nziiS9/T3AlbjBIL8adgjlglrd7b2U2zuA898R1nkKJaXlVM
         GnYCSlQSVs8GMF2WMPBqz7u9U+k4opUArju7mQvsMx16Rb5kuJdxB2jCf5eVE5Hj98HZ
         gM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699045156; x=1699649956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5W9lSDJO8fwv+IPZX1odI1VoWlpD0qf+u1GxHI3cXy4=;
        b=oAX09pMQhCaoN1gYfBqeRlgaWgBVps6n8Wfuu9wFjFgwcVxaKH9pspwBq7Lz3y6vYD
         Jfz1O87bXKXrg+ZQVWX++DwB72kk/HgwZWehUUA0mJtB9dqOrbrFJ6vA1irKBw7owc3o
         LWHBbrwDpGfnKbI5AlXNB/s3qTI5RVaaznMhdDiqG8ME6rA+3QHtWSMZPzrQ+URRdFCp
         90xhfrXCbc+L0E+Bw+EtEw5y8G6qh9tTgZkHyy8Xdzg23GIjfh8zQg6v9jXXzLJoaHJr
         D5b1t2Skl+YEUb0YacBGpn6dvdorwz/G3kRPdx8qg9aWF43cE2EE+Py80jzYz4yixs8F
         oTcg==
X-Gm-Message-State: AOJu0YzPmzStmYLVF03Rppb2zFElnqLR54YBCZ0gIJgJl9f3cAh2RNLC
	COn4AbMNhD+lA1wJ+KrowMwUAC6c4/SYT1UMQ0k=
X-Google-Smtp-Source: AGHT+IFr8W0BBLUYo91LLBBrPWZsGoBud3ZlMFwV85MzRuCi98u+NIPXSybhr/olaVQYKA0akqt4ORcn5UBusz8Xwng=
X-Received: by 2002:a17:907:3e14:b0:9dd:e124:4b39 with SMTP id
 hp20-20020a1709073e1400b009dde1244b39mr632733ejc.10.1699045155986; Fri, 03
 Nov 2023 13:59:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103000822.2509815-1-andrii@kernel.org> <20231103000822.2509815-3-andrii@kernel.org>
 <a8b287efb678249f0dff828a724385b36923144f.camel@gmail.com>
In-Reply-To: <a8b287efb678249f0dff828a724385b36923144f.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 3 Nov 2023 13:59:04 -0700
Message-ID: <CAEf4BzZ_qAf2+9hiKo0bDx=_ayXZyMmz5QBUmyCYDrk97k__hg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 02/13] bpf: generalize is_scalar_branch_taken() logic
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 3, 2023 at 9:47=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Thu, 2023-11-02 at 17:08 -0700, Andrii Nakryiko wrote:
> > Generalize is_branch_taken logic for SCALAR_VALUE register to handle
> > cases when both registers are not constants. Previously supported
> > <range> vs <scalar> cases are a natural subset of more generic <range>
> > vs <range> set of cases.
> >
> > Generalized logic relies on straightforward segment intersection checks=
.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> (With the same nitpick that '<' cases could be converted to '>' cases).
>

Ok.


> > ---
> >  kernel/bpf/verifier.c | 103 ++++++++++++++++++++++++++----------------
> >  1 file changed, 63 insertions(+), 40 deletions(-)
> >

[...]

