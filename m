Return-Path: <bpf+bounces-79533-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9621D3BD49
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 02:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42DEA305BA1D
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 01:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4877925C802;
	Tue, 20 Jan 2026 01:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLQYljRs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DC61DE8AD
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 01:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768874021; cv=none; b=ALEk4hycARCF+Zev0zdMpoaGdZh2Tdb/UwCYJ8OGqyBaDuRuTPyXteegOhgDwzaGHTaIWt09VbqIGBKKu9kB+s+jDINJaj/Tbvhe1z/5z/vgsaj3DygQybsHTcHee7+BRzH75u3aQLQAabrrdq0GxdH+/t0MQ0D4nKHZPAN8gtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768874021; c=relaxed/simple;
	bh=i1WO9N6rU0xpki4AMmuxeFJwY3NuYqDajYqJEs2eZ5E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hFkUaLxi69r1ttEFF0aUbHdxyc0ZEW3Y6n7Q8t0WyRjziDcI1FuzL6rzmBg5aoXm+7NH0PTYpPPjKrHKBCISKWbZg4HJZjSKa/eYgbd/2eA+pdPM9kF6RXJM4eqFds8IP6NtE5fA0jKKW7Rvvalfd2BAubbSA5bK1ayUwWqVmts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CLQYljRs; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2b6a93d15ddso4691600eec.1
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 17:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768874020; x=1769478820; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i1WO9N6rU0xpki4AMmuxeFJwY3NuYqDajYqJEs2eZ5E=;
        b=CLQYljRsK41jCN1C9CCcUlt1VL/xy5VKsRxOO4m6cpcErGdn4kN1NypQRYdukQuayf
         elq5VT6DCNI12PZEylQgcKa1CPIoiR1ze/jc0R1zM0duI7XQoPp/9Lk6UU+wswim2Esn
         y/XeXYE6EqQYv94OPQp+5wC9aHPbzkYtcPEb1UDGEOR/e4BcLpNWxSkkl+MXQSyPd42Y
         Qhg4Je7jau7bVTf7BtWEiyyLBrMLwk9bPxsgwMsooFsNf4KE46BtTF8MgXiozzM9mkGh
         ZbTnTRvA0IG3kOyw1ykMd35JC+uo8wNPfpa/m6axzG9nG1THI9mzYgWQ6VJaguNdOtPp
         ECMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768874020; x=1769478820;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i1WO9N6rU0xpki4AMmuxeFJwY3NuYqDajYqJEs2eZ5E=;
        b=f03kLhuO3QtmQaIMSC90z++knQZ/tYnmhSf3y05LuZ6zECMAr1RFAIFfPmK+lRxIEw
         c+wD7OiVV7zyL4alKZcz5TG6OqTmJnZW7waDTZR8mWV/NNxzoazdt3UQYPCMGmMZqZVi
         gPJZgD1rxNVe9mCKQiLVQI0jyu+FasQiAmFhP9vfQ0z+raYZ9/NwyyxwHnW5xG8mcMpO
         XkJc1pmo+laKxpDE/b+xFc+hmDV4VQ4YxWJoQqRlqZREeA7D82L86wraLjs/EY7boKOD
         QBoq3cpxrOqNokQrkq38ymHRnfVJ2o5sriID4Q47GehK7AnF75jdABKIKFgN6y50lFGj
         BBYw==
X-Forwarded-Encrypted: i=1; AJvYcCWg3FA7OJabefZuFZuLK27kVJyjnvK8UHQ8tzL3Ycbrb53j2joGUvj5b6KD8TdJhav1ctk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4uUSm7ydXR5JktYQEweyLUouJsk43TAcQebTfUwBl7KRWlphJ
	4dfxeac1OLTNPQyxe5v5btHa9l/j43OAUkor2CTvHaYIgIVnpbufFpnS
X-Gm-Gg: AZuq6aLbeLOmajcwJ6yPxGIEU9McMcGvr3uqPh74FTVOpWbdPQ1sRumy4/InWHyDrAb
	U5A8FFrbVoO8P5bvSzxsGOCfJhgkQ+kXnUGDT6xSU4yhX6f2Gu0rpfVikeK8USkXC/4ceSvMpaZ
	oy2WMxNtyPK7yiowWP2ZnO1KBrJm9F1amL1dLCP87l26blyEGcrWkH/qH9auAmrHigELmxncFhP
	SSLEOLXqozxYu/TXq0GARW/GkyuVWOi2qQ7YClkWgIKEYbp6lsLsObAPpvtX2kqecTP85T0Bjhf
	rgvNwuSlAjZVaojuc3EBtNTrPyFuH5YR5eRk7ChDtUdIXq5MLewcvmuzCZmjlJP8EQnzS5vrS7T
	EFP0HaTmNjDSbkdQEhWiElfak26aAQzMBsYydRMeUDjzTPM5e4D8xhEh0pqQw/T3LWZYg7pUL4R
	tnaZJ2PPFcYQUiSYA4zSqBxUvnwTq+NtbC7BnYsAcBwLWuS/qEA4UmGmvWTg7+FpuugQ==
X-Received: by 2002:a05:7300:7fa0:b0:2b0:52cc:fe69 with SMTP id 5a478bee46e88-2b6fd5d8080mr245088eec.5.1768874019541;
        Mon, 19 Jan 2026 17:53:39 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:4cd6:17bf:3333:255f? ([2620:10d:c090:500::aa81])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502d22sm15337923eec.10.2026.01.19.17.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 17:53:39 -0800 (PST)
Message-ID: <20f8eb981471544d6cd62d8ce35713f615f6f395.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 10/13] bpf: Migrate bpf_stream_vprintk() to
 KF_IMPLICIT_ARGS
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>, Alan
 Maguire <alan.maguire@oracle.com>, Benjamin Tissoires <bentiss@kernel.org>,
 Jiri Kosina	 <jikos@kernel.org>, Amery Hung <ameryhung@gmail.com>,
 bpf@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, 	sched-ext@lists.linux.dev
Date: Mon, 19 Jan 2026 17:53:36 -0800
In-Reply-To: <20260116201700.864797-11-ihor.solodrai@linux.dev>
References: <20260116201700.864797-1-ihor.solodrai@linux.dev>
	 <20260116201700.864797-11-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-01-16 at 12:16 -0800, Ihor Solodrai wrote:
> Implement bpf_stream_vprintk with an implicit bpf_prog_aux argument,
> and remote bpf_stream_vprintk_impl from the kernel.
>=20
> Update the selftests to use the new API with implicit argument.
>=20
> bpf_stream_vprintk macro is changed to use the new bpf_stream_vprintk
> kfunc, and the extern definition of bpf_stream_vprintk_impl is
> replaced accordingly.
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

