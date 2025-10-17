Return-Path: <bpf+bounces-71228-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DB8BEACFB
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 18:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79D6A1AE06A8
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 16:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFF52C0F9A;
	Fri, 17 Oct 2025 16:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GKN0mRz2"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0C429B777
	for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 16:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760719318; cv=none; b=Mv/cWGJsFNLcLA5oEGPWUsM96YzYbhGeHxoJp/TY6TwUGC8rKuclpjshNfZoTSWjgWKh5vzeZF3z2o9RWbZUO0iEqT6N1ytdM9POuzyiQCp5eUOlzjv/DWAF1pn3hleKv3FT4eWRODiy/lN1iwAjbi5Igw/nEON3O+d7sNCJXUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760719318; c=relaxed/simple;
	bh=i+RAb8nLWnnpf2YhYzIJxmsBxFjoaO5PIxloEoEaZxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LOUF7WqlYEb5Hl+wmW2RWqQSKod4SaB+jdhC8E4wL/hgnhBg/46u0B29ZPt0ieAu77BT3WmrM/b2/N2v218gX76sJPt1OsO0bj5/+E0zomwREKe9JG5h6priH2ZptpAQgTiGxG3MYK9Eg3PT/+ygxlgXQtpfecsYOY/oQF9Bpfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GKN0mRz2; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0a63577d-b096-4189-8888-409c0503dbf5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760719314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/fxSqtliVjhv/7zwLJMeitd3igvaB6fVVKuCtAXw4wY=;
	b=GKN0mRz2C/73xDE6mAz2tBQ8VwnX2NUchZFwoeZ2p004lqinM/gLuVXUCPUiuaMBASfjdr
	5ZctYUNzDlqK/k24gWjpBoTby+7XjcZTip9c0F0NXTkGzkvQBJFwU4HfJ5fRbrj0VZ2ajj
	LHZw1ya8QtCPoAaDUev7Z7FxKrE5cgc=
Date: Fri, 17 Oct 2025 09:41:45 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] selftests/bpf: Fix redefinition of 'off' as different
 kind of symbol
Content-Language: en-GB
To: Brahmajit Das <listout@listout.xyz>
Cc: andrii@kernel.org, bpf@vger.kernel.org, eddyz87@gmail.com,
 linux-kernel@vger.kernel.org, yangtiezhu@loongson.cn
References: <40982e43-84c5-481b-9a9a-0b678ef7e6e7@linux.dev>
 <20251017155450.4016595-1-listout@listout.xyz>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20251017155450.4016595-1-listout@listout.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 10/17/25 8:54 AM, Brahmajit Das wrote:
> This fixes the following build error
>
>     CLNG-BPF [test_progs] verifier_global_ptr_args.bpf.o
> progs/verifier_global_ptr_args.c:228:5: error: redefinition of 'off' as
> different kind of symbol
>     228 | u32 off;
>         |     ^
>
> Suggested-by: Yonghong Song <yonghong.song@linux.dev>
> Signed-off-by: Brahmajit Das <listout@listout.xyz>

Please add more context in the commit message about where the
redefinition of 'off' comes from.

Also, please replace [PATCH] to [PATCH bpf] so CI can do proper testing.
So in the next revision you can have [PATCH bpf v2].

With the changes in the above, you can carry my ack.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
> Please refer: https://lore.kernel.org/bpf/5ca1d6a6-5e5a-3485-d3cd-f9439612d1f3@loongson.cn/
> ---
>   .../selftests/bpf/progs/verifier_global_ptr_args.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c b/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
> index 6630a92b1b47..1204fbc58178 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
> @@ -225,7 +225,7 @@ int trusted_to_untrusted(void *ctx)
>   }
>   
>   char mem[16];
> -u32 off;
> +u32 offset;

[...]

