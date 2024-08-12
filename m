Return-Path: <bpf+bounces-36881-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6941694EB58
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 12:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2595F2835A0
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 10:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3A3170A00;
	Mon, 12 Aug 2024 10:41:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B140816DEAD;
	Mon, 12 Aug 2024 10:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723459268; cv=none; b=ZMq88xbuPruWq9rE2NAYBW9HIBEfJdcObShHEqfwXKFNvMQhV8MEpGEGcp21cNPCmvMnkLNIXfC8BLzrMq8eQ/9tQXvK9p0pa0Pr0U/sIXITlXW//QOywfCsiL+YyxfQXJbVvBMhLMyo9jEHungW3O0iuvE5q1dRRfVRM56o8ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723459268; c=relaxed/simple;
	bh=mrKMVI6736FaMlR2FwpVoV8uktYgiiLL5X46u7/zEVs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M1mmVMlWfNVPvOFZYzDRLKAJr9ve+3iYAEQ9p0OEJYDcA8NKz8s3us4zCnwoyy8dWcIjJuxaMQjLdeUJ8qv7gvKohicjOvTMkb+60YSeDv/aMXThsK528sUeg16+Bp3iU2+Tp6JTpGlqpo09InI8L5a4x6hHL4KdzJBiGu/PdNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Sam James <sam@gentoo.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  Martin
 KaFai Lau <martin.lau@linux.dev>,  Eduard Zingerman <eddyz87@gmail.com>,
  Song Liu <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,
  John Fastabend <john.fastabend@gmail.com>,  KP Singh
 <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao Luo
 <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Nathan Chancellor
 <nathan@kernel.org>,  Nick Desaulniers <ndesaulniers@google.com>,  Bill
 Wendling <morbo@google.com>,  Justin Stitt <justinstitt@google.com>,
  "Jose E . Marchesi" <jose.marchesi@oracle.com>,  Andrew Pinski
 <quic_apinski@quicinc.com>,  Kacper =?utf-8?B?U8WCb21pxYRza2k=?=
 <kacper.slominski72@gmail.com>,  Arsen =?utf-8?Q?Arsenovi=C4=87?=
 <arsen@gentoo.org>,
  bpf@vger.kernel.org,  linux-kernel@vger.kernel.org,  llvm@lists.linux.dev
Subject: Re: [PATCH v2] libbpf: workaround -Wmaybe-uninitialized false positive
In-Reply-To: <3c9e6cbe-f768-48b1-9e37-779971fd1146@oracle.com> (Alan Maguire's
	message of "Fri, 9 Aug 2024 18:48:32 +0100")
Organization: Gentoo
References: <8f5c3b173e4cb216322ae19ade2766940c6fbebb.1723224401.git.sam@gentoo.org>
	<3c9e6cbe-f768-48b1-9e37-779971fd1146@oracle.com>
Date: Mon, 12 Aug 2024 11:40:58 +0100
Message-ID: <87mslija6d.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alan Maguire <alan.maguire@oracle.com> writes:

> On 09/08/2024 18:26, Sam James wrote:
>> In `elf_close`, we get this with GCC 15 -O3 (at least):
> [...]
>
> Would just initializing struct elf_fd be enough to silence the error
> perhaps, i.e.

Yeah, that WFM. Thanks, sent v3.

