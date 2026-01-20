Return-Path: <bpf+bounces-79524-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA880D3BCD1
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 02:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A792A3026AF1
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 01:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568A523AE62;
	Tue, 20 Jan 2026 01:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cu0pqrrR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B386A500971
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 01:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768872255; cv=none; b=Kwq0pgZrRMIwAfnakSEkoZWMXpAdag6TpF7YnxLSqmTiecrgz/hxeLwallQnMJRKmG42hpEvrSfqhWosPvM2rXqC5PriBxgTr2Yves3UGVfFZDgkMdQBFx7f1vPjuksHMEKLfjsz4ur68lgUxPLIWvw4rpMsHpekUDBYP9lCmuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768872255; c=relaxed/simple;
	bh=K2u+8I8vFl8w6PFempls3Trwb1N9W/IlCRI2yJ03b+E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pTH+IFaimVANss1Snmym4FkWA9k3R/r4YPyJYEx76nxm2VlVKqs0nBRwHC/6uskPoVCtjMgAPXT0NCUsy4BdDCM5/ccO+h8lWtKpvEECPpUXj0auY/RWXT1UKf1tkYKoUC3qImgO1a7ywdgvksAyOLkqCOuz5qr3zH8U/w/4Z8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cu0pqrrR; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2b4520f6b32so6495365eec.0
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 17:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768872254; x=1769477054; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K2u+8I8vFl8w6PFempls3Trwb1N9W/IlCRI2yJ03b+E=;
        b=Cu0pqrrRn4g9gvCGG6mdGckAmOr67Rys5omGogFXdfmZ22wMz3WUBHiGuYzgUY30un
         Zq+q3SonQlukG8Gds4q6sombav07r82irNYlqa2UFhQPob88kvqZEQj1Su9HOzLwmtbJ
         cLU4zfaIpzkMvywarOTHTwfsCXMJi+hwD6ssWw8/L/EdrxbxujeXrwFrQUQuGLbIbqYH
         3e/4dNiS5/gMHLn1hz2EwIvV57gahdZ2zqK9SB30Wu58kUVcHKd57mo+A9VanvMpbyyz
         0EDIduv2p7mEyr8qZMoICLSSyXv4/Ceu4IC9oUYObmNaVA8A5hEXlmFIP52ZSOivb2/c
         vogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768872254; x=1769477054;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K2u+8I8vFl8w6PFempls3Trwb1N9W/IlCRI2yJ03b+E=;
        b=CAQLo3hiH2jHG6G376tVmKXH5ae205rkW1MB8HeXwm3xJnB/2talnBaeZR/CylALeg
         OK2U8ZTZ2uYsoT7uQXyb54rD3ei3E7p0n4ckbUot3Mu4IxZClzDi3BILbimOgzsf3WFq
         TmPb7S7c8EJfLBn6c/GUqF+/ZeRyZS7J0J8JY3pm3j7A//+PHAUpMjqr6bd4JeGfSeMr
         /M8a9wZI7RyvMGsJAozGRHoRcoCxa7fdu9pq6aRta7knTmbrJ3iv42lQEJaRUE22VJQD
         hrFmDSfKcuUrgM2oZyQ7BHXxiYkLXRRxembBJKGv/06gY0a8xIXqTXrNZFBEuvBn7c1/
         VaMA==
X-Forwarded-Encrypted: i=1; AJvYcCUKYSSvkuwrtazmHDM2Au7DQ1JvLZ87/ldK6BBrraNmZ5z739MJX4yEQxNrj9ARcOlRdW8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynpk4Mjf8Tmvss6pS+OEH6ya5ujOT2hrsomXGWMXsbLYDk5Qy9
	Vld/lQT4B+F2otOom0LE4Nx+N3iaZ2mAy9evmxajqTuYKq3ta7BfqtTE
X-Gm-Gg: AZuq6aLqSRNL8B8nEkSY6QT+xNjmi8HukLSRSV3hXo/E5fKhhS5Wttky9FkNxivAvnZ
	06CYYWCbMugSSzDbBWp+ImUyfhduRsUb0ymrSFYSTbO7jyS/9vZ63q7BDTPn2129KykIt+PiACV
	3+RJ1K/rSMdsNBc0JvOQPWfRr1CgNpZbjkYa3ODNeFtz5TMcUWH+jPUh45lnm5yhCjf6/EDf2KT
	dY0k0Mkrdb4Qx9r574mQJzEH6SMMrGPo1qxVZrOgQmLIikIB+FiX6sj/z6zWHSYLJmasZMl/4fv
	E7NxhdBiFHSJDQIJfEPX0vGPXx+1pyFrvhlZ9XiqSrwetBy1yHf9mrZdYeUb4upqIMnj21dl0kF
	/QD7p9MAcwMUmkIFqwIOXrH93LFTKZ1+VgoP7W3LbtngFNxSA9jdje9RXAbe2mx4niRgAPGc41U
	YBnlcZKzNIHbryaMLgdHzc/Tawl9hSAiIYi7O/5UL020S8nh49hDr3RVcL/FcKNFBWGd4XqrpNW
	MEp
X-Received: by 2002:a05:7300:d517:b0:2a4:4884:e03d with SMTP id 5a478bee46e88-2b6fd607c0cmr162693eec.11.1768872253889;
        Mon, 19 Jan 2026 17:24:13 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:4cd6:17bf:3333:255f? ([2620:10d:c090:500::aa81])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b34c11dasm16997017eec.2.2026.01.19.17.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 17:24:13 -0800 (PST)
Message-ID: <375028a228138e2657efe0603d7818d36dc83f63.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 06/13] selftests/bpf: Add tests for
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
Date: Mon, 19 Jan 2026 17:24:11 -0800
In-Reply-To: <20260116201700.864797-7-ihor.solodrai@linux.dev>
References: <20260116201700.864797-1-ihor.solodrai@linux.dev>
	 <20260116201700.864797-7-ihor.solodrai@linux.dev>
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
> Add trivial end-to-end tests to validate that KF_IMPLICIT_ARGS flag is
> properly handled by both resolve_btfids and the verifier.
>=20
> Declare kfuncs in bpf_testmod. Check that bpf_prog_aux pointer is set
> in the kfunc implementation. Verify that calls with implicit args and
> a legacy case all work.
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

