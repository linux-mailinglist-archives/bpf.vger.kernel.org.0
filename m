Return-Path: <bpf+bounces-29634-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7E48C3F69
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 12:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 557A1286FBB
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 10:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C51214C595;
	Mon, 13 May 2024 10:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pcN51dKz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB7714A623
	for <bpf@vger.kernel.org>; Mon, 13 May 2024 10:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715597849; cv=none; b=csCWv2LO+MXqwj2We01MewnyBJY7D3GnmnST9zryfVQGZTkzkH2VJ3IIjZGnOS/S4wBBEk6lJmOzSgwVVqPEDXV1fq/8NwguzDp8jc2FNUXpGjKGpGj8aHIU80yZK9K2J2QCvAQts3zI4RQguzHKpK6usJ/TFYZmt+F5Vy5yWzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715597849; c=relaxed/simple;
	bh=k98s7LuAq1EI0OjdngFT60qZrAqXYfIYZoAiT+Ifk2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KfCZs1qosK5M4G1oRPPc3pJ6xWCC7i6kqY/ttrJGHYOwyKXJltQsqbbZWR/+PoemY3O1S4mhdm06d55qos69YeWcw1AuC4cuBF1EHCy1j3nJ5qgKtW6j83AtqFdt36aGiuJ92SylQHollSJbBCP3mk1HgArQKrwo3eBJJyhiGCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pcN51dKz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F360C113CC;
	Mon, 13 May 2024 10:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715597848;
	bh=k98s7LuAq1EI0OjdngFT60qZrAqXYfIYZoAiT+Ifk2I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pcN51dKzgpFxK412etmKO6YJ2OpsoJY/1JpSei5khfuCihR7SgyZDDl2ETEG6AxK7
	 rUhExDb0M+n76QyihZ8HsIbK6vUFGfl0vVFbTe/KXGAmkSJzWpOPApNcbPR41yu8cR
	 Q/KGLTHqNWig8iZmptyzvZtu0+SHpWa9xNCvk9z/Q65Mr6SoU2VLQQfbe4BZPhxOdf
	 oa0xPVaWsbXp4UQgAEk1Vjgn4OLsRfUvXpstDPEUUNpQIrss94tGi42JWoeSuXhVWb
	 7iamCu+ArAj8vl4nd1IPdxofjz2GkVg3QOE+c6hHp1Bj5Di44uJFS4xbSYW8rXeTcc
	 U6rj/bZz1sE0g==
Message-ID: <3de5ad42-f677-4625-8fba-7bdc7a8909d1@kernel.org>
Date: Mon, 13 May 2024 11:57:20 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 bpf-next 04/11] bpftool: support displaying raw split
 BTF using base BTF section as base
To: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org,
 jolsa@kernel.org, acme@redhat.com
Cc: eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org,
 masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org
References: <20240510103052.850012-1-alan.maguire@oracle.com>
 <20240510103052.850012-5-alan.maguire@oracle.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20240510103052.850012-5-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-05-10 11:31 UTC+0100 ~ Alan Maguire <alan.maguire@oracle.com>
> If no base BTF can be found, fall back to checking for the .BTF.base
> section and use it to display split BTF.
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Acked-by: Quentin Monnet <qmo@kernel.org>

