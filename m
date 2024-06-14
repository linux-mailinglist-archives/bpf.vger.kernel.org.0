Return-Path: <bpf+bounces-32187-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 761C1908E7D
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 17:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 289E41F2783C
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 15:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5466616F845;
	Fri, 14 Jun 2024 15:16:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812A717B437
	for <bpf@vger.kernel.org>; Fri, 14 Jun 2024 15:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718378173; cv=none; b=NhN7CtKlDhKPxCFF1Kzx1Om2+C+8pgVS6nRvbs1PxLN90ukVUVKmS/wFBf/64lLbStVLBoIaruAntwUCfTKMX1GNNrj6uthVXH5tJekTRKYHz80XmsNrn7UJQD85q1lLjjVB9Fxnspm2vEt3OJyOCNOpbu0aF7rsz/vcWTbwP3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718378173; c=relaxed/simple;
	bh=d9q8NhmHT7fhQbN8sORGWV+zeXsbe/oYJmEtluU60qA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kL/t77gBLTdpywK/WQ73BYnUztdUodXHxyIoOPzh0YpPWMK7p6ZW7hBD1ONYrv4dEMbI7QvCpYIMCSomN1jQ9daOQ8StK9pkszhLUe8o0SZtXfrP2rXR7+sSJg8yzUDU1FDlxbRUBkO1chISK0nOa+lu5Q4Rk3t9iA0sg0HAMyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav116.sakura.ne.jp (fsav116.sakura.ne.jp [27.133.134.243])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 45EFFQvn027838;
	Sat, 15 Jun 2024 00:15:26 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav116.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp);
 Sat, 15 Jun 2024 00:15:26 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 45EFFQEA027835
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 15 Jun 2024 00:15:26 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <52d3d784-47ad-4190-920b-e5fe4673b11f@I-love.SAKURA.ne.jp>
Date: Sat, 15 Jun 2024 00:15:24 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf: don't call mmap_read_trylock() from IRQ context
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <4b875158-1aa7-402e-8861-860a493c49cd@I-love.SAKURA.ne.jp>
 <3e9b2a54-73d4-48cb-a510-d17984c97a45@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <3e9b2a54-73d4-48cb-a510-d17984c97a45@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/06/08 20:04, Tetsuo Handa wrote:
> On 2024/06/08 19:53, Tetsuo Handa wrote:
>> inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
> 
> Oops, "inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage." example was
> found at https://syzkaller.appspot.com/text?tag=CrashReport&x=14f0179a980000 .
> 
> Then, do we want to
> 
> -	if (in_hardirq()) {
> +	if (!in_task()) {
> 
> instead?
> 

"inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage." upon unlock from IRQ work
was reported at https://syzkaller.appspot.com/bug?extid=40905bca570ae6784745 .


