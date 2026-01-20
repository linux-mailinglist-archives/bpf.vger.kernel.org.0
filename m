Return-Path: <bpf+bounces-79531-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD19FD3BD43
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 02:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83BA5304C6DA
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 01:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E5519D071;
	Tue, 20 Jan 2026 01:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnCqPcg3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCC31917CD
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 01:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768873846; cv=none; b=m8Iz2iPlg6Q75HWkdfpRtQoc2galtdJFLtdhwXtGPJ8Aw4xEX86yLC3mNNdZxCmustXSihu8ayDm2KDFH0X7mUo3QHYnFrM3yinC2XFxQp9xeYXuUB+SMSap7jWrlHO+mzdv0b0dwEf3njewtJf4ZrafduRq4BpstAcdRnDsE3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768873846; c=relaxed/simple;
	bh=DAGvg3PHyxIqwyF//wG5u+HRfFiT9MhEqYWNnoz3UMg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Np7ChuY8zVqnWeKPtmYk5IAGYD3j+UwmS5tB8WK+X22doJaqQihBv7XPykTIyCJSfqHJarQDqHgqWPKjuNu9i7QPipSYC5IQ1sbAO9Ry0vy9tEmTPF9aS9kc5XdFL8aPiXws8oWK56v+WbP4nxWMLqcjrIPLuvIwOvNBvXAGsmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mnCqPcg3; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1233b953bebso5271140c88.1
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 17:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768873843; x=1769478643; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DAGvg3PHyxIqwyF//wG5u+HRfFiT9MhEqYWNnoz3UMg=;
        b=mnCqPcg3KC91NKLeFG5vkR5iHIU/5aRTKjqf/cKF2gxsFfVPGKkYQUr4qCcT8W31Xr
         OlndUT9pb7mnoxAYeoCRWq020W24uVjFQ/igIWhRL3owED0VxKLq2/MhnoPo1keR8yzh
         VP6fE7ViIfkO3Kyvs7g1eM9cmVlzI1WRhgnVED1OFr8Cktu6ik9WT4wHMz3DS47BMHJ3
         p6rEhMvwIxWaMMsRb+xYyno709QmER438CQeU7Dv7OXUzJoxl4F0+hm4R316mXppDUEa
         Kumwnwy66lSb88DvuK7xjWlOOCaBua9pEiL0kd/hEVnOd9rzo1dsL/yeF0OWnNusyaqB
         MrQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768873843; x=1769478643;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DAGvg3PHyxIqwyF//wG5u+HRfFiT9MhEqYWNnoz3UMg=;
        b=EpZRKcDnMqfpNUd89qmsaDMXJdKLGmmFAWNh0hLWehrjjwWUqH5TIkmRR24v3ydnw1
         V1+nBKUAuBpZ7HOTUDsJlCVyzSC/MQo3VlDXbzfRa0/Ou7bveDP7w0BX1gbQpOQllV6H
         39WKzmDDv/1K1GiBDG5AEBw9+1e/7xpwGPcZielGhOX8DxAP3hwn7RmDYleAquJ/V4qu
         aw06RmmGucUhfd3QgCNGo303Z76LbOD8k7dbcwaT4m9LfU4z16FPrkTSzA9vedhUzKC4
         o+Ts57dVWxuKSiLLgU55zNexxv3OoRpSd80ciiLZefAwjpK1/XTEsQ655lZ/FwvyNjji
         i7Gg==
X-Forwarded-Encrypted: i=1; AJvYcCXnIoc43DTrgb2UcJNd59mJUu2RJpDMaTUq2G9I/e0a7wsnPqWChDmf795nAjuG+CIH3K4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ+LgnchcuqDvb/3D1CRTXyMGS8df+yifnhYNRQaNGL6ZdTEEY
	siUVzqVsseEqyEB9kVIL5nnZWd5MVVCDrDhhDvbeyEyqcQrNSupcw6i7
X-Gm-Gg: AZuq6aJBqknqwrLkZLxAjsW9FEnpiQysu7CNkQe0YqN+LpU45JUMNNbfUJCwDI8hKVZ
	AvUuUA2JnmalDy5lPGwoKR0d0ZlU3Fru3Av7eOsNWpiW99r6uSVPCuNPgenGfFLmrSB0uiyJA1n
	ASDKln8SWM25pLljkpbMKQa/jdHcT9eGxhpMnqjTY0ax2RVyvH0HGuvF+4DOPX+aJDDfxHKbp2J
	XXx3P/qhvmMrhIzIKXFCB1UHnindT/yBy3h5CD2Xu84jXg5DMWqu0QdXKnlI+YiGEay3sJUk6Ah
	EROo0z1uzp+/rs7U6kuN81XrYllfCnpDIgWOIAgVoXVph9DlHhB2rahIB3RMBRU7KtkWiFC9Zfo
	WPs73ekmvXDb8wlPzcrCvooGrl3XBy3HoJqqZMkFzd7bahEmm+2WRVeUqtY3pWeOvhiMsKcXyuV
	YXvFd0jCj871mQjvDhNkNxhVuQilQz4uzwbDHDEslaS8ZpEjapHOoMeS1WOAHFUzVrpA==
X-Received: by 2002:a05:7300:b593:b0:2af:cd0a:ef75 with SMTP id 5a478bee46e88-2b6fdc9d3f9mr188077eec.34.1768873843209;
        Mon, 19 Jan 2026 17:50:43 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:4cd6:17bf:3333:255f? ([2620:10d:c090:500::aa81])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502c65sm14944257eec.8.2026.01.19.17.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 17:50:42 -0800 (PST)
Message-ID: <fef0169e1c694b8b7945fe6cfca984750ac9d2e2.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 07/13] bpf: Migrate
 bpf_wq_set_callback_impl() to KF_IMPLICIT_ARGS
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>, Alan
 Maguire <alan.maguire@oracle.com>, Benjamin Tissoires <bentiss@kernel.org>,
 Jiri Kosina	 <jikos@kernel.org>, Amery Hung <ameryhung@gmail.com>,
 bpf@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, 	sched-ext@lists.linux.dev
Date: Mon, 19 Jan 2026 17:50:40 -0800
In-Reply-To: <20260116201700.864797-8-ihor.solodrai@linux.dev>
References: <20260116201700.864797-1-ihor.solodrai@linux.dev>
	 <20260116201700.864797-8-ihor.solodrai@linux.dev>
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
> Implement bpf_wq_set_callback() with an implicit bpf_prog_aux
> argument, and remove bpf_wq_set_callback_impl().
>=20
> Update special kfunc checks in the verifier accordingly.
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

