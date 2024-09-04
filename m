Return-Path: <bpf+bounces-38859-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 860B396B0B3
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 07:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B860B1C218C4
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 05:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A261083CD9;
	Wed,  4 Sep 2024 05:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w1xRgjfp"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5E7824AC
	for <bpf@vger.kernel.org>; Wed,  4 Sep 2024 05:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725429193; cv=none; b=HImsc1B91YxnzyDlkF5JLQZPXwSWLd9rJld8LYO5PiD3HbuLIZUwrcmV6RkbL63CsG+ZW792LkGdqEkhL/TAmeNf2ORBprX+hoYBhpTOMnnwsy/AAnYfJmGseJ+NiAmuZ7zKvRaiJRCDfZjZNHJX2E5tDlRUD9ifaea9Ak/IQdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725429193; c=relaxed/simple;
	bh=fhTk26mDkyDUGVzuskSKnbdiVruN+y+HMzLsb2ser20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hNAd+AhIII7qS1lz6VUgh56a4jvD/1tJJ+0dvo129gMa5n4DKPwRHsz/rqq1RsWfWOQzBfUZB416aPJOjwTK6kChPjLo2Kr9CFzE1oWEmP4Iw9tL8oOkSf43qq3fhpbvFe7f+t2jcGs4JIx1HxKOKkcogN+IxCFb6IOpu2VVzs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w1xRgjfp; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d09692a9-20d0-42a0-a4a5-aa3c21ed9451@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725429188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fhTk26mDkyDUGVzuskSKnbdiVruN+y+HMzLsb2ser20=;
	b=w1xRgjfpN8Z3Uu7j4hjrWTOpdPt5zAGyDVd5Kq9SfoQbzx3raP27I1X4a2q1ZN2L/Gd9F1
	Dt/aSCMDfhftM6qed7ayC51eHw8kq5aMynE0W3R0jzL32L8lgTaCXIamfno5vkLWL4MHW4
	zCVQ7rFS7bOiIeh3mFwcjDB2IJwsiXs=
Date: Tue, 3 Sep 2024 22:52:57 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 8/8] selftests/bpf: Support cross-endian
 building
To: Tony Ambardar <tony.ambardar@gmail.com>, bpf@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Quentin Monnet <qmo@kernel.org>
References: <cover.1725347944.git.tony.ambardar@gmail.com>
 <419d9f3b772a09f1db62b9bc484cb1e69336a444.1725347944.git.tony.ambardar@gmail.com>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <419d9f3b772a09f1db62b9bc484cb1e69336a444.1725347944.git.tony.ambardar@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 9/3/24 12:33 AM, Tony Ambardar wrote:
> Update Makefile build rules to compile BPF programs with target endianness
> rather than host byte-order. With recent changes, this allows building the
> full selftests/bpf suite hosted on x86_64 and targeting s390x or mips64eb
> for example.
>
> Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>

LGTM.

Acked-by: Yonghong Song <yonghong.song@linux.dev>


