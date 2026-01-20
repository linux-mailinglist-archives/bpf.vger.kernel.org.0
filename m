Return-Path: <bpf+bounces-79529-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9483ED3BD3C
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 02:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B42730BED9C
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 01:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8E127B35B;
	Tue, 20 Jan 2026 01:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZc0aiur"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14E8285CB6
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 01:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768873750; cv=none; b=pNOSem/KgBvSlPDMtqmgVTfvARabUmnymIZsRHjkCLJzscb7lQC984bAEQ2tTbr4L74snle35SOwlHswrrC8RBZMIvOdrSkLCmuSB9Kn6uCYLpr7biHp7WG00a+f6JwSpym9Mvy5Se/HbnPiezZsG7pemNske6rEPLpzfHKDTKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768873750; c=relaxed/simple;
	bh=P4vH0k+7XsEwT791gaUby6dSyltbIn6BS1tA5QY+bp0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tkf6ituXlYgPIM8sdxbi/IN/mQl9pk2mCO1R0HL2C2aDEfR5umFFrUcEWandwPwgcC3ZFRsQEOXAwtLULoNIZbm4InxTOWfrAf0r+5a6KEtyP7l9LxzeRUb8XW036oU6MvmJ/RBSQVDkjJuBe2ujKTh8qQ8v/wLtCkoUTQHJwvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZc0aiur; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2b6f5a9cecaso824501eec.0
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 17:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768873748; x=1769478548; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xjg5AkPxw0MOdaWLN3zWHsbO0Z52mOb9jRmich2qKiA=;
        b=VZc0aiurXJglCX5Bvo4EyS6XjGi4RyyKqHFXtaSUI8XkqZfQB2ZqB9OZBcd4lE9lS3
         g28yi5HCMbs60z6dv/kaCrfUgF/FBP7wnAHdLMxte+OAQw0NofmHrdo6Tg0vmVW+PMcz
         z/Gz0XjHPAjIYSuXvDvGdZCCqv9+NHMzlD8pVn+BDQ/HZGblTGOY/MdzSWWDmsLlplBS
         bYrDfFOVRB1SDol0/BtVEUFzDxwvXDaFTT+72yYGxHbL77ncYL196Mv5sXhE7v1IR/ki
         OQrhrBQGIKRZssh9TqKRvLDRS52ufFjXHqInH9RC+bFV+8h1S3MVuj5KWtShvYXD53xb
         xWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768873748; x=1769478548;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xjg5AkPxw0MOdaWLN3zWHsbO0Z52mOb9jRmich2qKiA=;
        b=TeVosHnVKsMVepUfhirHFe+b40wk79MhK2tUcLH/qBBmPno4tHoXEz2taHH+wbeFOR
         n0w2M65RqXS2O3aHsjf6+uClnzGvfmMqWdNRi+t8mgrw8NgbmNONPK7lm79KqyxexPvI
         Wbhqm2lrIg3nWZBWmK4jbKboJZ1IgXJY4ncByjxoi1HKQPQUVNznjBPpWtSFay2xXhec
         HQR1llV0hbK0fBdiqp54Ju4UXJ1FzBRTEh4M/cBecBohD1Sv18nll/kWA9hxa7C8VQoU
         ic4cvkxGxdkJQ1rHC2j16ulNnqsRHSNvSfGaPtMxI17EnbdhYtNzCpcOW3UvOqyGcabE
         TeDw==
X-Forwarded-Encrypted: i=1; AJvYcCXx8Qy6jLfDhbtAUYMbftrpBv+tpdtDC4tmAN86HaTxv28Vpcb9Sb7EnhaxYHzSrr/jod0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEHX5KK3pMnCQYyzmFYlVsHYSVh27gNw+zkMY3fykum3awNR1N
	88+LnYnqHkxyNXNBxRxBr1/3j+qUisvbV2KgLwIcA97Oa92eUHQNaRAE
X-Gm-Gg: AZuq6aId9Bh3RZBkj3ct+EWC3rYUMhsfwvWZkZouAzo+B1GbLdj4syHvaRL6erY+zvJ
	9QFpPB7gFiiewDyHIPPocFxlEMCICyHn5cCxBxXCUPmpUIHj5uvZgE/jTUS2hSZz7UrPidMbZOF
	CPvVAyLEaEzMHjYxPqT+EAL1D1hi40Z2ao4ronkZ1ko0d4NL+AEKpofi9LNgkEL756jmWn9h83n
	WB0icduMWlkF+JcdsJYW/JnXGtCbqCM5uYZ7nKTrdKqKJMoOffDPi1SjkwPQZel93hAtV3OYMfl
	CVlx+bZrXcUNFRIJY850PBvkh55xY/bT4N7GFnwDenRm3Y+UuBa2JPy9reCTPnuuA+4gEqJEanK
	+7c3kRjj/5jrUNDDVhL9Elp7RkSQfGI8JWYYJhgha4k/eSPTnjtqrDiVejdTEm/5GlOuKd9OGDu
	2mpcYfCuM0v4NqYw8M/wb7zjGoKbuL4Q3ykowqLI8MlV3d5IoepoRtHriO2yGh3j6A7g==
X-Received: by 2002:a05:7300:c608:b0:2ab:c279:9dce with SMTP id 5a478bee46e88-2b6fd623ef7mr293270eec.7.1768873747978;
        Mon, 19 Jan 2026 17:49:07 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:4cd6:17bf:3333:255f? ([2620:10d:c090:500::aa81])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502d22sm15327177eec.10.2026.01.19.17.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 17:49:07 -0800 (PST)
Message-ID: <088b071d1a43b403123d772f56ce033e91cb4252.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 00/13] bpf: Kernel functions with
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
Date: Mon, 19 Jan 2026 17:49:05 -0800
In-Reply-To: <20260116201700.864797-1-ihor.solodrai@linux.dev>
References: <20260116201700.864797-1-ihor.solodrai@linux.dev>
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

[...]

> v1->v2:
>   - Replace the following kernel functions with KF_IMPLICIT_ARGS version:
>     - bpf_stream_vprintk_impl -> bpf_stream_vprintk
>     - bpf_task_work_schedule_resume_impl -> bpf_task_work_schedule_resume
>     - bpf_task_work_schedule_signal_impl -> bpf_task_work_schedule_signal
>     - bpf_wq_set_callback_impl -> bpf_wq_set_callback_impl

Just to clarify my understanding, this is a breaking change, right?
E.g. bpf_stream_vprintk_impl is no longer in vmlinux.h and on a load
attempt an error is reported:

  kfunc 'bpf_stream_vprintk_impl' is referenced but wasn't resolved

Maybe call it out explicitly in the cover letter?

