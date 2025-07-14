Return-Path: <bpf+bounces-63192-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCE8B03F66
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 15:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF38B3B5FFE
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 13:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB4F221F29;
	Mon, 14 Jul 2025 13:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pQUnRcg8"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CF12F22
	for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 13:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752498969; cv=none; b=n/GSQlZuHeRPtouQQ+SiGeMavF8kQt0aVKFp2DVffA4S19Gd3a+/LK7R9w9jrEpCH8kTJJuLXV6y161Vco6iUAiQccdfjKFLy3psuSE84ZEKVY2QW8PY6LOsib4+JAGlbKkorQnmMa70oduUEPz9QPGC5ZGDKfjWcTXohiXjeRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752498969; c=relaxed/simple;
	bh=uNySO4lrbvjnur5E+Fbnn4kIAnHeOJOxR0gDtx4P1Jo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hGe+BmvCOuoNayA/vjDjxOTFOHutqQ2X4FLXFs3xp0QlVF9qCYOr3wxJI7/Y5cRktotDGRtEzYO7cTZKmzEXgYUfVPOupT2N6yY8bpzkS8+6Qmwzyj0YklgElSIfwTJCPDxJ3+ePlLGbugyMcmq5s28fig2AAvU2ccfz7jwEyXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pQUnRcg8; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f580b139-a08b-4705-addd-31f104fd570c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752498961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cwvkiriw30wqyfBkgssYOekF5g8YqkH87P9dXphqWRE=;
	b=pQUnRcg80CPnSfkpWkKdM8t1njWTWpnOW0i/rQBEWtj5gatjUJ5Ki7EGxzIpK3xq4CN5ID
	SZEXd1V+Ih+SbNQr1OT85+rNtB1tI+BWCqs7eGRGT9EI2bmO8Ty1dqQdbyj9j+lfA/jygF
	gA2No1YVlGl0PSGZITIaYhW7wHod23M=
Date: Mon, 14 Jul 2025 21:15:45 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf: Add struct bpf_token_info
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, willemb@google.com,
 kerneljasonxing@gmail.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250711094517.931999-1-chen.dylane@linux.dev>
 <CAEf4BzZzsqu1=Q-3+6uJvgvKd52o+FR=DFp28w+vT5knP9NyCQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <CAEf4BzZzsqu1=Q-3+6uJvgvKd52o+FR=DFp28w+vT5knP9NyCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/7/12 01:10, Andrii Nakryiko 写道:

Hi Andrri,

> On Fri, Jul 11, 2025 at 2:45 AM Tao Chen <chen.dylane@linux.dev> wrote:
>>
>> The 'commit 35f96de04127 ("bpf: Introduce BPF token object")' added
>> BPF token as a new kind of BPF kernel object. And BPF_OBJ_GET_INFO_BY_FD
>> already used to get BPF object info, so we can also get token info with
>> this cmd.
>>
> 
> Do you have a specific use case in mind for this API? I can see how
> this might be useful for some hypothetical cases, but I have a few
> reservations as of right now:
> 
>    - we don't allow iterating all BPF token objects in the system the
> same way we do it for progs, maps, and btfs, so bpftool cannot take
> advantage of this to list all available tokens and their info, which
> makes this API a bit less useful, IMO;
> 
>    - BPF token was designed in a way that users don't really need to
> know allowed_* values (and if they do, they can get it from BPF FS's
> mount information (e.g., from /proc/mounts).
> 
> As I said, I can come up with some hypothetical situations where a
> user might want to avoid doing something that otherwise they'd do
> outside of userns, but I'm wondering what your motivations are for
> this?
> 

Sorry for the delay. Recentlly, i tried to use bpf_token feature in our 
production environment, in fact, bpf_token grants permission to prog, 
map, cmd, etc. It would be great if it could indicate which specific 
permission is the issue to user. So i wanted to provide a token info 
query interface. As you said, "mount | grep bpf" may solve it, but
functionally, can we make it more complete?

>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>> ---
>>   include/linux/bpf.h            | 11 +++++++++++
>>   include/uapi/linux/bpf.h       |  8 ++++++++
>>   kernel/bpf/syscall.c           | 18 ++++++++++++++++++
>>   kernel/bpf/token.c             | 30 ++++++++++++++++++++++++++++--
>>   tools/include/uapi/linux/bpf.h |  8 ++++++++
>>   5 files changed, 73 insertions(+), 2 deletions(-)
>>
> 
> [...]


-- 
Best Regards
Tao Chen

