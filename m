Return-Path: <bpf+bounces-71477-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 838CDBF3FA5
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 01:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D03A94EABB4
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 23:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509662F5311;
	Mon, 20 Oct 2025 23:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kd3khTiy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7513B2F0671
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 23:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761001317; cv=none; b=AaodrmUM+6/VXd0e3qPgJXkQ5XyhxLzY0SzLMI6T1YsY8GlCFPXFpesNyeZlUQFiiLo90tFA6b8JkNsGrQIOP3aKo2U4sStajKNTTvF5/uZ0Wpo3qk4rzuY/Vq3bHg5kAnujLOhFEAzRkpeiNn0aLbuJWSURrFbGrth6MNcU2F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761001317; c=relaxed/simple;
	bh=AkGI5RxqpGDlwEWWAeLO3thEZECBb+hudXGd2BDzlio=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kkenwNOwwTX9J4OVN3z+X942or4FbX0axobJI07hgK8APC6BD+2P7KJxXARKUrNvK+t+oH71/3Re+vXmkFQpKGZaVo8lgaLSGDP/VvTXUyqzURbWuwwyVrUw1nrzK4ZJxmlrsozqgkNb5lTH0s5xBhdeSem1YuRxxU3CFFgbVR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kd3khTiy; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b57d93ae3b0so3201177a12.1
        for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 16:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761001316; x=1761606116; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gcqDqxr9taQEEnrBSRMwp/EtxTsHEzgQy2SyoMlVGpg=;
        b=kd3khTiyPqYda/0uIhwcJHiTITmbIvPSdL7Q70NbaKZ8q0m+RhyaocPFfWdIr6CF6u
         3pvQjCf6qgE2WP8XGugOUOr8AiN8eon6yHaI1SYjqRCMyYNGUiMSqvuWbU3e8/7g9jFd
         vjUFSZ+lax2unsJ0zzU0q0t2/FIQaRcOOkXKJ8mZfCHJ8YWj/sfzvPCpkRywjic0mJci
         naRwEwdUTUOJeCx2PaEzbuLCAZKCotwKNCoEMVFWKPtRbqsjajCdkmNTYnFMsdH2+gqx
         88onqNcv2RmeGmJX1L7QCcEFueIXmw2wpWChvA+MmLCIBmb5Dhvk5x4pfUhaD6G5LiJU
         2big==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761001316; x=1761606116;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gcqDqxr9taQEEnrBSRMwp/EtxTsHEzgQy2SyoMlVGpg=;
        b=bSpbJ0DBQ18S3BgKvQaZpc6ScQOnZrXlQcJZWDA6qtBHZpGn7O1j9lB9XToSkbA1bk
         2hhVsGrMmhWuxU7G1yhH01/8QbpBiSopKlBO8oCp+4ACOQOUbq6hCtCnQhOdCYVwZ4O7
         20blxKhTNjzolL48mbiEWjCxgVC0wvlaYUvo/GvprP6YpyDhFG1oEKGlFvx810GqBHHW
         +OknM5yDDdHXPi3eVNb3ZpwuicImqVBhI5pN2qUi62JnNLBpKnWDgeyTUlgRvayNqBro
         QBO7HnOAD3pSK83QU3/pBwD9K+VeLZijyMK73672kF6N/15C6Jcz6MZ8eSk3GsdJDAyT
         eHJg==
X-Forwarded-Encrypted: i=1; AJvYcCVjz+GLU2pzttIgn1alXRwNQ1UuCLR1Z+KtqQK1SIgDQTnadzwZ7rvAP1MyVB9Nk065hQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJHcWSWAbNtIj9cFbixX7d1LqRg5ar2vmUuByJm5CYTFBv+zBc
	AG40EFO76XOjPqGB/5CrGOamROzURXX8OfTNAftMOg3rsqEjSSpy5nFl
X-Gm-Gg: ASbGncunosRuzAcptcQZJAUbc1YN+0MFyqwbkVgephOh3ub+jX9mB7Nq3unNnXbjx9J
	SW/ArmbRyxOQA9wHhf52fv2rt1PDIii7X+Lu2nUTsF7Ziyz7S34VGH3oI/D+EhVfm8BIrxP+bA+
	qM6b6VNegrEvJhgYC562XNin0YrRn+vxRfuUPY2/31TUzDXdkwj9u/QTwCd9B7LQ4MwEbKYxD/w
	oJ3Oy0MVWmch+efQQZlSrS/XLf0rSVM7L10dlbsLdaqq1ApZBPyCFtboffU0HcTOZICpREDI/Wz
	ApBZjmhRr90pb+TJ+MKeFpzIe2nmQAZcA54SVw0DslIq+LMS387ksqLFjjYfxTP0GUhbbLQI6kJ
	YD3MegZBJ1Oy5xgh7YYKQHHRe8ZKGyC56ZO8ryMstZDQPflwR2CsnMIQqdcGF4MqLX/WdZTiYOT
	P3Adsime2Q1wQaTjS9aLzfbeFRZmnRzfjQa4c+a93Q71mNhLE=
X-Google-Smtp-Source: AGHT+IG9OQSL4TFzCDwMDfJXRUkAZXk7L4N5swSoiYIBmN4M5DSRNNwPgi//gWccVvJZjWJTSbHMTw==
X-Received: by 2002:a17:902:f610:b0:261:1521:17a8 with SMTP id d9443c01a7336-290c9ca6b06mr187411705ad.16.1761001315548;
        Mon, 20 Oct 2025 16:01:55 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:badb:b2de:62b2:f20c? ([2620:10d:c090:500::4:1637])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246fdc0desm91299655ad.47.2025.10.20.16.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 16:01:55 -0700 (PDT)
Message-ID: <6bf95bb54fdc4048854951270fc22972da1e1b4f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 02/10] bpf: widen dynptr size/offset to 64
 bit
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Mon, 20 Oct 2025 16:01:53 -0700
In-Reply-To: <20251020222538.932915-3-mykyta.yatsenko5@gmail.com>
References: <20251020222538.932915-1-mykyta.yatsenko5@gmail.com>
	 <20251020222538.932915-3-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-20 at 23:25 +0100, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>=20
> Dynptr currently caps size and offset at 24 bits, which isn=E2=80=99t suf=
ficient
> for file-backed use cases; even 32 bits can be limiting. Refactor dynptr
> helpers/kfuncs to use 64-bit size and offset, ensuring consistency
> across the APIs.
>=20
> This change does not affect internals of xdp, skb or other dynptrs,
> which continue to behave as before, and does not break binary
> compatibility.
>=20
> The widening enables large-file access support via dynptr, implemented
> in the next patches.
>=20
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

Hi Mykyta,

Please don't drop acks.  Each time you drop ack, I need to compare old
and new patch versions to see if anything changed.

And I'll repeat myself, in case there would be a v4:

  > Nit: still think that mentioning that this change does not break
         binary compatibility is important.

This was a question we had to think through before taking this route.
And given that AI got confused with v2 regarding this, the fact is not
obvious.

Thanks,
Eduard

[...]

