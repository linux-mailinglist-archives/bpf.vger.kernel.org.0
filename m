Return-Path: <bpf+bounces-35486-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA7793AE43
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 11:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E94051F2429F
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 09:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A46150981;
	Wed, 24 Jul 2024 09:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L24uemp/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD16D1CAA1;
	Wed, 24 Jul 2024 09:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721811933; cv=none; b=HBOqa0EhuB+osAu+UXujy3M9MuLV6WG+26Fd7XUiICJh8nN4HOnp0tu47Mn0tmCse8KGpvy1WkRaBQunMgfkfUQsf+4QBER/FwnNn4jXh8RxfKWfq17eaxPXy97es3kaFcOho3BOZjYwofH0fTpzaHVMbf/BYM55ttzIakdPryE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721811933; c=relaxed/simple;
	bh=8I+FXfJmeDCyyC5A4w02CLEjfXqIyyBoChONKhpwa/o=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=M4CrbcNoawY3rxmE7iXPhTEyXW+LrNE5KMon2uY2o/JbHwll4zfJerjt7F/3R2J+7JV8AK/IdCEkMGelrqUC6bkYJ+2EdLot5tRUniUK3nG7kBbmgUa7dAlHNFzXG/P2tz8LSusrF4qnhjCcemng4dceZiWPPuWu+b/xZPJtFsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L24uemp/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07106C32782;
	Wed, 24 Jul 2024 09:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721811933;
	bh=8I+FXfJmeDCyyC5A4w02CLEjfXqIyyBoChONKhpwa/o=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=L24uemp/GunUljlTv95O2FAAwDZL+u59MYEGt4ITJLrtRwiriOM2G+GtfrUO7YBJM
	 yQ/6nM/YOQwAAQya3vm+EmMEfMqMBhcmmyaEdnRofVhW1+w3ZJ0MytK833U5/kwU/G
	 vz+jbUED6xeT8GEdpkRN8VWGerIAE1v0sk4hdV9VRAgP2C3o7tI3zsJiJVQKP9mxvK
	 XbPaMsfm8ndsNPs5Vi765RKz9gZxlpeMTfX92NcGdSMlYSPSuD3ih/WXBZOLaD4obl
	 EIPCK1UfaJeCDo7CasWOEvoBRJuzC8F/+Ooamzt6M3q6xFoiDoJ7aVLMHlEjqne9eR
	 5DEHuBe6izfyA==
Message-ID: <cfb36a61-1f50-49c0-8e63-950728c9a0a0@kernel.org>
Date: Wed, 24 Jul 2024 10:05:29 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH v2] tools/bpf:Fix the wrong format specifier
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240724085242.9967-1-zhujun2@cmss.chinamobile.com>
Content-Language: en-GB
In-Reply-To: <20240724085242.9967-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-07-24 01:52 UTC-0700 ~ Zhu Jun <zhujun2@cmss.chinamobile.com>
> The format specifier of "unsigned int" in printf() should be "%u", not
> "%d".
> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> ---
> Changes
> v2:modify commit info
> 
>  tools/bpf/bpftool/xlated_dumper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated_dumper.c
> index 567f56dfd9f1..3efa639434be 100644
> --- a/tools/bpf/bpftool/xlated_dumper.c
> +++ b/tools/bpf/bpftool/xlated_dumper.c
> @@ -349,7 +349,7 @@ void dump_xlated_plain(struct dump_data *dd, void *buf, unsigned int len,
>  
>  		double_insn = insn[i].code == (BPF_LD | BPF_IMM | BPF_DW);
>  
> -		printf("% 4d: ", i);
> +		printf("% 4u: ", i);


Please see feedback on v1 and address the warning.

pw-bot: changes-requested

