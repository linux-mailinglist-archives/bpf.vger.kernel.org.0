Return-Path: <bpf+bounces-20070-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E22A68387D2
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 08:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2D2A285113
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 07:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DFC51C49;
	Tue, 23 Jan 2024 07:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YVYH9Pdo"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8EB7472
	for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 07:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705993922; cv=none; b=mvEw45kR1iVPSxkwC992W2/P/EyqsfG121fJgQfETpTrUgRx3ABDQkFGzqEzA0FfWeTlZU89YJbRN5Hg0aA9nSjCW/ysWBJc724WMl0bhrKl25vcMTZXzyqf8TXXf3cTuVPBhBiV5+kdJo+9jj7NYoLrSd5SRdOVzNEYmwD6dhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705993922; c=relaxed/simple;
	bh=8TLkKC95xxUcXS8HxMmhTHrmjiagTuWTnnP36E+JVpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o7NJ3+RVfsBinx7dLJAMT4NyqBq4/DBWmUPK/edpHb17sh3Cr4r9ucAMDgb253EUVQeuzWpbtfnQ1kO7WMvbsL5MYztUbl/oy3DJsuZ8sYIPkLgQ2i6lmrmAQU50wXsDoQcRFTmVjgiFRIfma2nAEj6GaV2KmjSAwlg+8sz2Fcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YVYH9Pdo; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a92ec3a9-10a2-40f5-83a4-81da51888d01@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705993918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yn0k9uMyZH7Ilmg0jV4IuHGUYfi2r0FQ3h6q1Wz25yY=;
	b=YVYH9PdoR8llDTT+DB6Tj43h3MzNQvuu+uxaM8J7+Axgl/yiErDO0gw7/fH3bE7nlMiWyp
	zZWPLzVE4Zl/X+xNfcq6f1wP9Jqe1UdlzG8IbCQ0lz69hATLS8r9pXPpigXfcj2cui8XG1
	bbQI9TBfbesJfrz1PMoRhbmZcisiqEI=
Date: Mon, 22 Jan 2024 23:11:51 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v17 11/14] bpf, net: switch to dynamic
 registration
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org, ast@kernel.org, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org, drosen@google.com
References: <20240119225005.668602-1-thinker.li@gmail.com>
 <20240119225005.668602-12-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240119225005.668602-12-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/19/24 2:50 PM, thinker.li@gmail.com wrote:
> @@ -1792,6 +1799,12 @@ static inline int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
>   static inline void bpf_trampoline_unlink_cgroup_shim(struct bpf_prog *prog)
>   {
>   }
> +static inline int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
> +					   struct btf *btf,
> +					   struct bpf_verifier_log *log) {
> +	return -EOPNOTSUPP;
> +}
> +

This part still does not look right. It is under the "#if 
defined(CONFIG_CGROUP_BPF)...".

No need to resend for now. I will try to adjust it unless I found other issues. 
Thanks.

