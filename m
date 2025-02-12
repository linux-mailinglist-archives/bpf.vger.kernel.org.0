Return-Path: <bpf+bounces-51259-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA88A32881
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 15:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E54121884F55
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 14:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63A120F08A;
	Wed, 12 Feb 2025 14:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQs0rJiJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EFD27180B;
	Wed, 12 Feb 2025 14:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739370841; cv=none; b=n8gnlZ6ejqRj/K45T70gImacNEr5wfUlqfH9TSnNitJ8CHK70vUMGCSPe98L88hnPEWGukZICn1i1A4tf3SazQVma+DbO4DVZjEjSuU/frnVcztZbOfF3cUB+11ox775MiiAOy+SBowmMrHmEjAdXd7ElHVPF5mgwofeDOIDnQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739370841; c=relaxed/simple;
	bh=QgYvjfxo+X0cHfwEov1X2s9rPdFbVkrA5z+AnagMuOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kOP8DS7U9nWWrNB1QlgUdW54PFitNl3YzES5Rs9s4O6qHiezhMBjIVJjeEd1CWCRsPw8vtA0YWVYVXK9VQa737qbnr+NG4wbHFwayQ9Pedg8fg8FQ2NuUvEvIIen1dxYZWMQwxArS4h9qzeVX5wlhFaB9w6SiDhR8hlSbkOGOOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQs0rJiJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F985C4CEE2;
	Wed, 12 Feb 2025 14:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739370840;
	bh=QgYvjfxo+X0cHfwEov1X2s9rPdFbVkrA5z+AnagMuOI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pQs0rJiJgEDjvCI0l0pvtk7cVsUWXVzfgvuDvcYJbfawVHOB8VItrau5u1c2Xfmyw
	 KEloyytS+zW6NNycj2g4xnIIAUPfQSHYxbAjtIX5Pp33ShfIwhkyqkFdDUpfV5pC4z
	 FzlPZ5Y9mkT2dLBAoUYeojbjtaK6sRjgobKdUGJK7i1H0TL9glkuUEu8hf3haEBvd2
	 KbENN44fThevG4yHP3DiMjg4whfNu9+u4eNzU7OKtFMCwEu0VJcTcAUxcl0HtReQZO
	 XLJi9MgFGZe9mHhwiXsEITD1Mew7oS+GhzUlGYjL0GWWYpfk5aLcwQeQrTzZHxATeW
	 6U+CVlZwTuB8A==
Message-ID: <1ad40918-8b5b-43fb-bd32-66db7825726e@kernel.org>
Date: Wed, 12 Feb 2025 14:33:56 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4] bpftool: Check map name length when map
 create
To: Rong Tao <rtoax@foxmail.com>, andrii@kernel.org, ast@kernel.org
Cc: rongtao@cestc.cn, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>,
 "open list:BPF [TOOLING] (bpftool)" <bpf@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <tencent_B44B3A95F0D7C2512DC40D831DA1FA2C9907@qq.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <tencent_B44B3A95F0D7C2512DC40D831DA1FA2C9907@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-02-12 20:45 UTC+0800 ~ Rong Tao <rtoax@foxmail.com>
> From: Rong Tao <rongtao@cestc.cn>
> 
> The size of struct bpf_map::name is BPF_OBJ_NAME_LEN (16).
> 
> bpf(2) {
>   map_create() {
>     bpf_obj_name_cpy(map->name, attr->map_name, sizeof(attr->map_name));
>   }
> }
> 
> When specifying a map name using bpftool map create name, no error is
> reported if the name length is greater than 15.
> 
>     $ sudo bpftool map create /sys/fs/bpf/12345678901234567890 \
>         type array key 4 value 4 entries 5 name 12345678901234567890
> 
> Users will think that 12345678901234567890 is legal, but this name cannot
> be used to index a map.
> 
>     $ sudo bpftool map show name 12345678901234567890
>     Error: can't parse name
> 
>     $ sudo bpftool map show
>     ...
>     1249: array  name 123456789012345  flags 0x0
>     	key 4B  value 4B  max_entries 5  memlock 304B
> 
>     $ sudo bpftool map show name 123456789012345
>     1249: array  name 123456789012345  flags 0x0
>     	key 4B  value 4B  max_entries 5  memlock 304B
> 
> The map name provided in the command line is truncated, but no warning is
> reported. This submission checks the length of the map name.
> 
> Reviewed-by: Quentin Monnet <qmo@kernel.org>
> Signed-off-by: Rong Tao <rongtao@cestc.cn>

Looks good to me, thank you!
Quentin

