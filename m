Return-Path: <bpf+bounces-76405-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A12FCB27F2
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 10:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 083A0302444B
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 09:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6B6302773;
	Wed, 10 Dec 2025 09:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9Z+ONSK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCD0302167
	for <bpf@vger.kernel.org>; Wed, 10 Dec 2025 09:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765357781; cv=none; b=SApquuTIeRLeuXjDEveEbO91s/pCfuRXdRAjhUoEIh9whIaeBxPjBw6z/Y6/awCFhQKsKo3BUIX5WfdlNlZzEFGyvj6tnRTvHQO2xhXt5Afg7MBPO/BSxocVh1xIqZ/1dbtfdFICS9+0i8caEj/P7tOrgYbm4dLKYq7HVALmJVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765357781; c=relaxed/simple;
	bh=mSk1+IaaBFsnpMnGgdyrply/x4zP71St7NveAAjxw9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jCpB3x/O5GM9buJaILMCSAtWxTHIcIL1zga2N+oWflj03Q29G7VFpsRYKSWcc1W1iv7b1hlRjUcVujMup55Ov93btV+55Xuq5sPt04U+rgFtqFoIcIKcm0BQ567EystLhRNqX5x+rVc7ufBrJDu+NFomuw6E1tmJKfpy6fZ1J18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9Z+ONSK; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42b47f662a0so308444f8f.0
        for <bpf@vger.kernel.org>; Wed, 10 Dec 2025 01:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765357778; x=1765962578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSk1+IaaBFsnpMnGgdyrply/x4zP71St7NveAAjxw9M=;
        b=H9Z+ONSKI6Nmpufr6By3cKAbXB4te0eAj+JVb/spOJdaXrU4aQFdQJ03j5DL58gMLN
         0NsozTUp1J3kLDyDuWHULdXsSsIXr2/r4h2paujIOkm114OJ0UGba7nRUmXIhfN2Qz9r
         O+qgGNMMhmvGnFMKsW8gu6XPQ7yAbLA7kNs3v407Rxu5WwJz4ZPdHEXa+oiRf75YQEzb
         Yb6NWCgwovEYe5VILEm/KuRSj/MihYGI7vorlb1vUV/z3acN9KJmjRTojP9/yfH1n1oz
         ydHhYxh4DQ41Nktx/Au0kvZ2TcYapy5eRs8j4J6B8G8RlxR1j9DdeH+2TByyArqP9Y6p
         FZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765357778; x=1765962578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mSk1+IaaBFsnpMnGgdyrply/x4zP71St7NveAAjxw9M=;
        b=HdXKNhM5EDat985gvEJq24d4MjxaJEiJdI0h+EcmzkZKjSv2+LGRJ20lYV6gxUPqRb
         bFWVJvZSKC3Q+aYJ7XYSJsz1hUpwUQBr90RGwi9mkgyXNgKlrzuHOtooUdGVS2mj3KRk
         WPMjFjwv1V1KB3XZDnV9NxF2ZDvMcKEZGKMl+vJ4ESEXJMnmvqYyHoGSJ8D8LRHJIvf9
         15BNQHtjVnlvAV3gu/jWKYaJ/z5WQZJ/KiG+pCbwyuoUesefemA+lsfOiVqHgt0Txguu
         DfVlMbip1yRqL/9Yy9LNiHmoYFejInSLAZUb501alCJtFhQZwvNn1i6kyWTnfncQmNb5
         fRVQ==
X-Gm-Message-State: AOJu0YzmODyq48AoUgUO1NUgmb770DXX5ZGTFw5lY4+JpDBQcp5YrWJN
	u9HNUqNo489BOsQEQXp1waTv1/aF9l+IWInXoniW7leIf4/lVaSy4LfiJStEHh+wkiCPvZFgQuT
	VzuNQhwIVpY7RWS+gV752LFeOiILQIs8=
X-Gm-Gg: AY/fxX7g5xVMDpPgY99+ZllAEHfqE2g/4PpX5z61xwhiPgNcg7j0Is2vDXfe4F1Ky3+
	wu6/oCVx/2mEtz4H9+yLyOX7o4Hh+odkvVDRRvHMCpbh9+jCC0fEI2tdr4T/xWjzrC9A22FJHan
	6CLFALZPSyWIxsZjEX5mVxWtx0PQcnXDYTwrbPqPfGB7w6i8DV0D0JUC15Zj9lOQuf7f3ZHcZwB
	u7iYYT2LJIvcYi0y96XwanwXdN1X5I9eQr/jiVHwAscHenQFAQquBYCVbedXIszDwYI/lM2
X-Google-Smtp-Source: AGHT+IHrNzGo91fxFd7V0RP0JdbIPKi51Pei7Z7w0VLclkeP3Ktaa73dT7450+PBZzppmplxPrjhin2GLB6TQTv3IOE=
X-Received: by 2002:a05:6000:2dc9:b0:425:6fb5:2add with SMTP id
 ffacd0b85a97d-42fa0856bebmr5280088f8f.19.1765357777636; Wed, 10 Dec 2025
 01:09:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aTfNjDu1Lbc-LPtO@linux.ibm.com>
In-Reply-To: <aTfNjDu1Lbc-LPtO@linux.ibm.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 10 Dec 2025 18:09:26 +0900
X-Gm-Features: AQt7F2qiPxL5QW44BXCUlHBjF2e1TIQhrwrO2p1Gu0BWbxZkt2W_nWtdFjCdC8w
Message-ID: <CAADnVQ+bhnsvhSiSkFnE2nkkKDwnec76AfSyksc+km2wokiUgw@mail.gmail.com>
Subject: Re: [BUG] poweprc64/bpf: bpf arena broken after kmalloc_nolock() change
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Puranjay Mohan <puranjay@kernel.org>, Puranjay Mohan <puranjay12@gmail.com>, 
	Hari Bathini <hbathini@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 4:20=E2=80=AFPM Saket Kumar Bhaskar <skb99@linux.ibm=
.com> wrote:
>
>
> This is because powerpc currently does not support 128-bit cmpxchg and
> in-turn kmalloc_nolock() but new range tree implementation unconditionall=
y
> uses kmalloc_nolock().
>
> Can use of kmalloc_nolock() be avoided for now or made conditional on
> availability of arch support for it? I=E2=80=99m ready to implement a pat=
ch
> aligned with your preferred course of action.

we're going to use kmalloc_nolock() everywhere and will remove
bpf_mem_alloc() completely.
So please implement __CMPXCHG_DOUBLE for ppc if possible
or just wait and hope that Vlastimil will change slub to use sheaves
unconditionally.
Then __CMPXCHG_DOUBLE won't be necessary, but sheaves-everywhere
is not a 100% certainty. Hopefully it will work, but there is risk.

