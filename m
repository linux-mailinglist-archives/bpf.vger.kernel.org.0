Return-Path: <bpf+bounces-79130-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD56DD280AB
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 20:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 787C43030AC4
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 18:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA7A3B530D;
	Thu, 15 Jan 2026 18:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mw5u/Cb4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8646A214A9B
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 18:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768503179; cv=none; b=ZTrk3o8Csn0aChCs6b98li3vjl77CZmRuxKr11BsuXNHrMs/0umsnMzbPWMm7gcaGUoiTK4sa/TogpG/Aw99hLhVWtwbLAGGC1MIFyA5XS9pO4h09tHyMLzbUaeOppmGSuvJrAcRwAoQqhBjyCM4kiJ1hTV79Kh+NSXmT5cIReU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768503179; c=relaxed/simple;
	bh=GK8dfjZb/iQYscKyU7AZCwNhZkFG/slojnCBvoIg1r0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gh50lbYdO0GFuwqcoQZT9R0/ZZSmeBihbhsYitRwzHcuhmbe0EuyUxeyTFLw92O4nLcF6xKBoD1AWz0moJPXTX0ZB5Ftw3xjVgYKHWilexNcU8QpPuwgFrRMuZ8qmBEw7cCiNwcVFW+B8Vf0L3/GYPUd8vIKAKMeUqRJoDa9Dfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mw5u/Cb4; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-350fd09fdd0so1242016a91.0
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 10:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768503178; x=1769107978; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nuRnK6v+THA8EMuQwdCqiwUBSoTg/diTmevZF3L//tk=;
        b=mw5u/Cb4aYs9fr2BzmDmUy0W+KRTpSJo1DSfXa+n5A4fMQ5JWeXiSus4HxtlVvOmum
         8G3K2KY0x7C1JxohQ+PUsy9uXhI62zcOIxk26Lrh3aJ+2CFdfPEmBIAZGsjCAMZsPp/A
         RVHutEATddqCpc2SPePme+T/tBm+130hfG2+YDkgdBpVSiX+ciWCMtenrBBO13QZix0F
         649w6fuNJ1R2PgG6a7Cen7gNfAWOSGb4fKTChUknQ7UCsLvQbmDyY/9MeLZxC4sd5HJs
         bFA1wJAZeZdL64ku5GI1wZ5J0+YlmxpYBNXGyTVrr2L/N/+4+gLUWBiTT1d4T9xwgQ1v
         MNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768503178; x=1769107978;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nuRnK6v+THA8EMuQwdCqiwUBSoTg/diTmevZF3L//tk=;
        b=Y9ZaDD1yvNUliemJCP7WWaGIlLRrbH9ardRwKYtX8MsY4+NX8oBlAX9ysCIovs8Elr
         CAuxMZJrxobyZTcfJGdmxQvDWny0ok5gVbWAgT6/Y0SF7FNMM6BCK2q6VtyuZF0I9Av8
         NVZd9e5IpyyYixSNsgN81EHQIdO/UhPmUALqjF2RAk8rfCaSfN4KRfHFRU5ynR8bzvi1
         NXGtqs1tkRDYkNGRl9CnZIb/3b/hn45pFUXY5KsMa6Ic5Itbq5PCkp6Rff3gY2dvvb8H
         3D0FbjPqNnDJ9nXwN/yRqQa/C4JWpJsUlDMX5q9EITju51cpN2nahc0WTJKCeqxr4JZ0
         rnJg==
X-Forwarded-Encrypted: i=1; AJvYcCU9CQPbYfPAcBwuuuZAB3irpBImY+0XztKn/X2cdyev3JQQAzAVDuIvkfhqU0M4XqwibBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhXplEcfD8eAo4p8uIS7aahk0rm+ApwR7C1TzJP7iHXiTrGoBy
	1HPsDaVfUGDD9suI48ASbfkNP2HB5/o1lDrOrwbWB60syN0moQLo2NQ3
X-Gm-Gg: AY/fxX76pUE4ibkuqu6EJ4OD26/Tspjvw00YAxay+S82A+t1oUxdjSHhkrPhjaQwNL/
	Etj1lRix+KTnQZP6kYPZg+IcFsU18wToBsaf7uM22eKc2ysmrJy5lFwE/T3qxsmzPanhBd263kT
	Wps3E5UVyBKboiVi3s80HOZxokZ8JJXeO6I8bVO4dL97uZ0UVqOzJ9vz+IcpRjZZDOALX2aEi4d
	VVJ6LilozWhxyAQ3w1U1g7IVOljaR43rnz0cl55Rt8QPhtPucBPs1UPZYvmHYrPtNAELU7eJJMj
	DMZNWChiw5IJUKY5R2PuWMh91GiAk2gXr6dSjDWIDsMOLvxMeMSz5ZG7jbzFAO7S8pP8ihMgzwB
	0pQgfNC4aSIxz4Azo08mqwfhiPTFFFaV9cPPPaOYzLwZEob0pQjdJcyECEvadk/JHE0jPZ0IQZO
	Pw4m5eEe6YIBT4iwKMjFuf4l08YYZfITaR8JnirUte
X-Received: by 2002:a17:90b:2b86:b0:34c:9cec:3898 with SMTP id 98e67ed59e1d1-352678d9b78mr3573117a91.13.1768503177800;
        Thu, 15 Jan 2026 10:52:57 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf3791e4sm148416a12.31.2026.01.15.10.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 10:52:57 -0800 (PST)
Message-ID: <aa4cc54a3a0796b16d2d5e13142d104fa5a483e1.camel@gmail.com>
Subject: Re: [PATCH] bpf/verifier: optimize precision backtracking by
 skipping precise bits
From: Eduard Zingerman <eddyz87@gmail.com>
To: wujing <realwujing@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>,  Hao Luo <haoluo@google.com>, Jiri
 Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Qiliang Yuan <yuanql9@chinatelecom.cn>
Date: Thu, 15 Jan 2026 10:52:54 -0800
In-Reply-To: <20260115150405.443581-1-realwujing@gmail.com>
References: <20260115150405.443581-1-realwujing@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-01-15 at 23:04 +0800, wujing wrote:
> Backtracking is one of the most expensive parts of the verifier. When
> marking precision, currently the verifier always triggers the full
> __mark_chain_precision even if the target register or stack slot is
> already marked as precise.
>
> Since a precise mark in a state implies that all necessary ancestors
> have already been backtracked and marked accordingly, we can safely
> skip the backtracking process if the bit is already set.
>
> This patch implements early exit logic in:
> 1. mark_chain_precision: Check if the register is already precise.
> 2. propagate_precision: Skip registers and stack slots that are already
>    precise in the current state when propagating from an old state.
>
> This significantly reduces redundant backtracking in complex BPF
> programs with frequent state pruning and merges.
>
> Signed-off-by: wujing <realwujing@gmail.com>
> Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
> ---

__mark_chain_precision already stops propagation at states boundary.
States are introduced often, so I don't think this patch solves a real
world problem. In any case, the correct place to put such checks is
the bt setup code in __mark_chain_precision:

  static int __mark_chain_precision(...)
  {
	...
        func =3D st->frame[bt->frame];
        if (regno >=3D 0) {
                reg =3D &func->regs[regno];
                if (reg->type !=3D SCALAR_VALUE) {
                        verifier_bug(env, "backtracking misuse");
                        return -EFAULT;
                }
		>>>>> add a condition here <<<<<
                bt_set_reg(bt, regno);
        }
	...
  }

But unless you see real measurable performance improvement,
I don't think the code should be changed.

[...]

