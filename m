Return-Path: <bpf+bounces-34006-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B46892949E
	for <lists+bpf@lfdr.de>; Sat,  6 Jul 2024 17:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CBF71C21A6E
	for <lists+bpf@lfdr.de>; Sat,  6 Jul 2024 15:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A33E13AA42;
	Sat,  6 Jul 2024 15:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BJ8pW5Cg"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F79757E5
	for <bpf@vger.kernel.org>; Sat,  6 Jul 2024 15:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720280471; cv=none; b=Ch5jGa0kIkpNXf967kfH/Vmw/e3fFdzxLy2xXS6HbxVE/jQ/0QQ1qH3RMNUcrghaujPjOhTGjApWu7ChjtzH7shnuIZSzaoB0bAq9hi1FCcqt6F5EmSgdDjY4Q/eMkYZWc9mUuOP0DL6c5eYBFdeoSqNtN4FDiEDf2Uxo/EVANM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720280471; c=relaxed/simple;
	bh=M9jRDBpbXwZ4EmwaQHnuGlnqvEpiyG3lM49RlqDVwbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PXbjCZs5ojFHPNpaDFeZLMK0s2mSAxiNmgQFtesbeDjKPPboLuD38J2R6W3Khe0Zzotakv0snfhAA+ciRRGajap0+6pROw5V2yqdcbqZHsSpuC7nc3Z5DYIJ2Lsae05eX6lAmitoFEeVIec1Ph/WF1VbjEo3cmZPJAHl8mZpuYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BJ8pW5Cg; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: dan.carpenter@linaro.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720280466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VHyX+ItlOF80ZtMIh6eOxVSUOn43OMD99j3+D49eFXM=;
	b=BJ8pW5CgQiMSF9nGLg3xKq2Nn38oV8dpQ+4hEKBu8lC+ozyGcn7toD/hvL5perN/YhKSbi
	i0koOgsQf6LzOsG+xd0U6r/OKJYYatMPoFak7BHcVKr/FZvGu44FBscUah4Sk+89qr5rzP
	iMqBP8zvY4LLUCbgFtjJrZtx6hvZBs4=
X-Envelope-To: brauner@kernel.org
X-Envelope-To: ast@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: andrii@kernel.org
X-Envelope-To: martin.lau@linux.dev
X-Envelope-To: eddyz87@gmail.com
X-Envelope-To: song@kernel.org
X-Envelope-To: john.fastabend@gmail.com
X-Envelope-To: kpsingh@kernel.org
X-Envelope-To: sdf@fomichev.me
X-Envelope-To: haoluo@google.com
X-Envelope-To: jolsa@kernel.org
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: kernel-janitors@vger.kernel.org
Message-ID: <40958285-12dc-4beb-8085-53f0bb35a989@linux.dev>
Date: Sat, 6 Jul 2024 08:40:55 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: remove unnecessary loop in
 task_file_seq_get_next()
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Christian Brauner <brauner@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <ZoWJF51D4zWb6f5t@stanley.mountain>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <ZoWJF51D4zWb6f5t@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 7/4/24 8:19 AM, Dan Carpenter wrote:
> After commit 0ede61d8589c ("file: convert to SLAB_TYPESAFE_BY_RCU") this
> loop always iterates exactly one time.  Delete the for statement and pull
> the code in a tab.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

LGTM. Thanks for the cleanup.

Acked-by: Yonghong Song <yonghong.song@linux.dev>


