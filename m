Return-Path: <bpf+bounces-18412-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 705D781A6D3
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 19:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AA03286060
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 18:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC95D482DC;
	Wed, 20 Dec 2023 18:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jW4svYPA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7769482D8
	for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 18:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40d352c826eso78565e9.0
        for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 10:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703096749; x=1703701549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpOPgyj6yatdDTu3V04mni+n4f0ufBd6Aratlssz/FE=;
        b=jW4svYPACxcD5F81b4oe0liWvOTHkBzKSm5w6PNFHjYO9fUj9e3y5wRO5S7Qq5gDLr
         Xv2znSdlV8maWHXh+d4u8yczsEmSrzudqvYakuswkYzRzplBnNawJfE3zX9CH5Ylf0Uj
         SQAi2dcXq/LQejNyMQrMydhclbwScK+/PX3Em2JNrC4vbH0ihFo4N7szh5lb2Abz0hyO
         bCTRj+5OIAnobHdWClkZ/4ucCYO2uQ159MUREq1OMh3cyhvFDCHz9bM8spdNTavdQMJv
         m0Y3v1ygfu2Q+qgiQLT7FxWn7/X5pJlRH7QON/9K4SWkD66vZTIDZqIuKB9rN1bkGaOe
         IdKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703096749; x=1703701549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fpOPgyj6yatdDTu3V04mni+n4f0ufBd6Aratlssz/FE=;
        b=n+PnrEEKG+mWDpQrb8alb2a9M1NT34g6CccTgcBbo3fAdQ0iC3Be3oQ8sNXqJjjBDD
         0+DACUdgYh9/+a+ZwdPtDteJGy4vaFPqUfYqhipoX1g9EKJdZKeFoaK3UWIYRFW1TmYV
         yZFMkdFApYDVMfB54x1WQuC9w77CyNgVChilL5QXBKWwhhOYumASa/9LSzxjTACJ0rSO
         /Zz4lBvIn2jwG8J2pBp1OV322JAeSxaJM2GgRBVQlAxvuAuKtxw9Xsaxd+U0dFtUQMbz
         9k9XnUR0zpNGyFF4EGqjVCMzmFfQFuQiomaOk8XIEtthkSX1xQq3xxaL89h3JiKdJcth
         t+6A==
X-Gm-Message-State: AOJu0YzJV5r08WbmU4WuAEmc49nDm2HeNUJkVmeqKpcbLHuykWV+3VYj
	kEdhw/H1x7oeos54FCon2PjYpfhrrwWncYHojtj2qJcn
X-Google-Smtp-Source: AGHT+IE4jd0o62dcjw5A/TVfqcyUZ+hBXrpV777iyN10krm3Z8DIfSe8h8q6T6rrh5Ikx8BfXsCfQc5ekpG79EcgNIg=
X-Received: by 2002:a05:600c:5185:b0:40c:48c2:f531 with SMTP id
 fa5-20020a05600c518500b0040c48c2f531mr74378wmb.42.1703096748729; Wed, 20 Dec
 2023 10:25:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219135615.2656572-1-houtao@huaweicloud.com>
 <20231219135615.2656572-3-houtao@huaweicloud.com> <7f682450-e165-26a9-1247-ef1440d9b7a2@iogearbox.net>
In-Reply-To: <7f682450-e165-26a9-1247-ef1440d9b7a2@iogearbox.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 20 Dec 2023 10:25:37 -0800
Message-ID: <CAADnVQKZAsLhZEd8E4_jODJq=V+DexcVCrmifvYNaFwpcbXLgw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf, x86: Don't generate lock prefix for BPF_XCHG
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Hou Tao <houtao@huaweicloud.com>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, 
	Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 6:58=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 12/19/23 2:56 PM, Hou Tao wrote:
> > From: Hou Tao <houtao1@huawei.com>
> >
> > According to the implementation of atomic_xchg() under x86-64, the lock
> > prefix is not necessary for BPF_XCHG atomic operation, so just remove
> > it.
>
> It's probably a good idea for the commit message to explicitly quote the
> Intel docs in here, so it's easier to find on why the lock prefix would
> not be needed for the xchg op.

It's a surprise to me as well.
Definitely more info would be good.

Also if xchg insn without lock somehow implies lock in the HW
what is the harm of adding it explicitly?
If it's a lock in HW than performance with and without lock prefix
should be the same, right?

