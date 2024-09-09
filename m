Return-Path: <bpf+bounces-39302-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E5B971401
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 11:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65DF71C22845
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 09:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE23A1B3B08;
	Mon,  9 Sep 2024 09:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tcA1quiN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A5A1B29D3;
	Mon,  9 Sep 2024 09:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725874874; cv=none; b=Js3nrh6+5OyOCffDq80Ay5H+heoNPv9j5EbsoX1YcbHFcWBsn7Ul+Bv8ZsmNhGfDNm/wQi/W8KOJ1hpaM635puFIqDOGumC6XEPSQe7LpSDa73VPR9Ikhks7auE648uaQNbiQJEYJATaQMXDlUmf46OGGT+5IYu9/6ajdk3N544=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725874874; c=relaxed/simple;
	bh=pkuo1csbHDYlTGyd+KtjwzetfD6TOMsvww/CPUsB8bE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=drZHL7DZ6R2J+ctwXzApMIQDoiaddpuCbYRRfwq92a/Oa3N5wNgzPY3VHaxYmXcS1d3j/LjbLk5GaX0TZG8LxbDvf9GkidYeZh0KfDqz9M2QBwQcmXZ0IKnvYQ4B50BO/j/Y3PHvc5zG5m4CBo1XySsw7nWvXV6kD48DVzdPauY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tcA1quiN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF1FC4CEC5;
	Mon,  9 Sep 2024 09:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725874873;
	bh=pkuo1csbHDYlTGyd+KtjwzetfD6TOMsvww/CPUsB8bE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tcA1quiNPkyLDkes9e/PoDrYVAqf5k1/WtfxTHvAbiuHI3ftSewqHqBn3XFdZH4ON
	 z1koPTCo7KxmBtQgj9qhw3Yz5kDdVKh8znDwyPZa3dhk0+OjkI4X7MR/XjncgrENNx
	 P5OaNjmNw76sw7ogrHIOK+tT4t4juNbDB6+Q5cZlB4aL5pEtSXE7XkCdRosjQQzyph
	 C3akNYcV+TagIcTbWlpCsF3igomVuycCa2JF8c1PvZSRIKYC9BxhOTsxBQ4R3q8wsJ
	 7/gnGPaVcvdGaC4PkKGL6hUfEwPd+l/IFms+wgBXuY9rc2jU8H3Q5dt7P5Jm9oY1mC
	 DOhW6V9uanVsA==
Message-ID: <768ffd38-228a-4200-80b5-7083c18fff2a@kernel.org>
Date: Mon, 9 Sep 2024 10:40:50 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] bpftool: Fix typos
To: Andrew Kreimer <algonell@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
References: <20240909092452.4293-1-algonell@gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20240909092452.4293-1-algonell@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/09/2024 10:24, Andrew Kreimer wrote:
> Fix typos in documentation.
> 
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Reported-by: Quentin Monnet <qmo@kernel.org>
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>


Thank you.

Acked-by: Quentin Monnet <qmo@kernel.org>

