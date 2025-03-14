Return-Path: <bpf+bounces-54015-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D27DA6071F
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 02:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C28517F550
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 01:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D7718B03;
	Fri, 14 Mar 2025 01:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzdesJAE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7C62E339D;
	Fri, 14 Mar 2025 01:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741916614; cv=none; b=Y+IK/lJSlme1XZ8KyocCBtfhaOMImQWXkU/hEp1po9aE7Q83W6cECzY9dMPfLK3Zsdj4KaVE30zbdpfLgQGwd5loOLoc58JYzvYd2BBPaMRSaCob5yrvtEGyNqcgoJhhdXkrUa1vniwOD76e8HDwQo02K1KN4OiwlzKtKW5k+fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741916614; c=relaxed/simple;
	bh=7RHX64kB6L5zZnSsq9XWlzLEE9ni5PnEDZMNaBb4b7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qO8OC7in+Nqt9Pgxj2pxTFWIdKz7UcFh/jjrL1Ru0NJqniI8/cFm7zHp84mx3l36uH7gY/bvZOGu4p3OQSh7vUeGOmj2IZ8s9bFg6g0yrsEmxPhbYauCH3Fj0tvLO0Solk151Fukxkovz0CdRXL1SHdxZGhtat61VlI/qloGpVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KzdesJAE; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6ff1814102aso22625767b3.1;
        Thu, 13 Mar 2025 18:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741916612; x=1742521412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7RHX64kB6L5zZnSsq9XWlzLEE9ni5PnEDZMNaBb4b7k=;
        b=KzdesJAEXCcXk5L7J2wr+l9h0NDB+4LW2ZBGb+WasMTJh3cFTO7EIVdJwz/kqX13qn
         +jbWwuc/5nkzoeay6Um/rLniJhQYgU7TORF7uWG0DU60QJAXv2ufCA8ZFahlMv8Ry5WK
         b/SoUMBwR7Md0XrxJwOvoD4L7QF8X6zh6A+z8Luig2bNV6Sc+ISZF+SpF8uFDyLFiFE0
         axmoC7hPhv2IkOKJTGn5ZX8LruX8mypgSVZN9b0JDrEmKTOh2loC2PyXaK4GnHMH85rC
         v2RxC/JagneOo0qOGa9jFQO+NNHkm2V7tNxC5u7d+1KFhvihwtTP4zzmYyidDiTgu2zB
         WEhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741916612; x=1742521412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7RHX64kB6L5zZnSsq9XWlzLEE9ni5PnEDZMNaBb4b7k=;
        b=gWUQw+oKM/phXajoBpKCy0RFznx4RFGcIXcl+TCyZT5QkCSy5GhwBS9XhRJk4tp8Uv
         iqdWUsIO2Melmtl+tLccuI0r/aLAVacvgW/upmocDsUUi2r0pFL7uCd6ZcMzXdLR/laJ
         cHHxiJJW1CrPZYGRlw/zsjRISt9nqfW/7s9Xr5FFHyOOwVRqe/HNzmjQgYEuG+atrOMY
         NWGHMtahxW17TBSHfJq3MQzOcsbT5IPSS3Fwh1WzYGo4/aZARGyuDIlg49+55zvAP1Tw
         k4eeA2RF94dPBQlpc9vX6g5NN6YQi/rD69+GuySzyyzCkQ/vJrep1rM9jb+jmpvT6v+1
         qmJg==
X-Forwarded-Encrypted: i=1; AJvYcCVcC3PHA79PyexvXPb1B6xLkJzr4uK9IwYWN0/Mid9gZFSIubG8c3YWh3ffRC5jmz0C/us=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVN65V0iGYocvilHGFUncCAh6iUm2+vL4uwGHLoLeli9Vk9VAK
	C0JWrcXgBTqxJpfTih056SEawhAl4i3SXWgf/QBEGImB8HoqBmScuUxIAMAzl2GigMIZ6sPlZkN
	k39lAff259mVMg82oVNy4Nfr7duM=
X-Gm-Gg: ASbGncsFc8QhRVbeuu+8klkkK7NsN8gW5F5CaiLUaoxIj0HkTRrfvyosED+4WNEAzx7
	gYpRb7Y4GEFIpFR8IxrPmB2gLtQvbu8AVcAPABB+/iPPrkeqwuAmfE2peug8iVfI85zU/OMhw/w
	dkrt1CmeJVpu6WONua/3PItvoLfw==
X-Google-Smtp-Source: AGHT+IGUJ4aP0hePZiMxUGR9tz8OoACIZnRJ3VvZxUuk3k1va+6HTzXiQvyx0+1ekpjFN38JDEE031wR1551BlHOUJI=
X-Received: by 2002:a05:6902:4911:b0:e5b:12f7:cda2 with SMTP id
 3f1490d57ef6-e63f88769e4mr744084276.13.1741916611943; Thu, 13 Mar 2025
 18:43:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313190309.2545711-1-ameryhung@gmail.com> <87bju4u2r1.fsf@toke.dk>
In-Reply-To: <87bju4u2r1.fsf@toke.dk>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 14 Mar 2025 09:43:20 +0800
X-Gm-Features: AQ5f1JqrV8ZdwXvOwa8e8kvh79vEjMEfm_Y60SrjYs1v33oToKgFHRkpUeyEZck
Message-ID: <CAMB2axO+==foKE3vBsyDAxbgZVz1S0iocAinr7bYWGye+z8yCQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 00/13] bpf qdisc
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, alexei.starovoitov@gmail.com, martin.lau@kernel.org, 
	kuba@kernel.org, edumazet@google.com, xiyou.wangcong@gmail.com, 
	jhs@mojatatu.com, sinquersw@gmail.com, jiri@resnulli.us, stfomichev@gmail.com, 
	ekarani.silvestre@ccc.ufcg.edu.br, yangpeihao@sjtu.edu.cn, 
	yepeilin.cs@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 3:52=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@redhat.com> wrote:
>
> Amery Hung <ameryhung@gmail.com> writes:
>
> > Hi all,
> >
> > This patchset aims to support implementing qdisc using bpf struct_ops.
> > This version takes a step back and only implements the minimum support
> > for bpf qdisc. 1) support of adding skb to bpf_list and bpf_rbtree
> > directly and 2) classful qdisc are deferred to future patchsets. In
> > addition, we only allow attaching bpf qdisc to root or mq for now.
> > This is to prevent accidentally breaking exisiting classful qdiscs
> > that rely on data in a child qdisc. This limit may be lifted in the
> > future after careful inspection.
>
> Very cool to see this progress!
>
> Are you aware that the series has a mix of commit author email addresses
> (mixing your bytedance.com and gmail addresses)?
>

Yes. I have changed my affiliation so some recently added patches use
another email.

Thanks for reviewing!
Amery

> Otherwise, for the series:
>
> Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>

