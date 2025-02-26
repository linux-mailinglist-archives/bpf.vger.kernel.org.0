Return-Path: <bpf+bounces-52642-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6FAA46143
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 14:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CC593AC244
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 13:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE26E21D5A9;
	Wed, 26 Feb 2025 13:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="exvMi3xv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6ED21A421
	for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 13:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740577763; cv=none; b=e+T4P/WZyIMLdzuRr11XFh9O/DOEkQAUAoK0gvuw0DatpBiQaytBB3UOtNo6pHmsWmJ1I+F0WPu7Cghtn9dLLQkcXkaYkmNoZgkxV1fE0jvyOoCxFhjhdl0tVh0QehusXpwoFPqsrksZm9MeIOy3jHPg+9pKBmirPo69UC08AOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740577763; c=relaxed/simple;
	bh=7Sjqx+lWiFFlcoTpiTe2+WbeyQkokQywUdjL2faY724=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fnPnTyG31ymIl7+itLigGSh4QNjsnTEyxaRMMcCF51g5EqpL8I6lBwyoFhxy5Zbc2fAZG6OGGVNdiKBN8EgR45AW4Zd5ct6P7qVr9hDIDik6d26oDGYzukYQbbm6NMK/pdVdt8Sk8lungfnz5otIN8A0IFW16m60zof5EgDO+w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=exvMi3xv; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5ded6c31344so9669391a12.1
        for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 05:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1740577760; x=1741182560; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6f2oUbpNnWs5FWgzYsSndrQ+qrKeORdGmzd9Kwn/DJU=;
        b=exvMi3xvYTG2817siDBcUqaxZvH9a1vFnosoduHpqaEYhQQRxKX1uKm270C+YSE7BD
         +CLtXFANXEW9FaDAUTRq/LobVn5VORLg2tlKHH3Sg0mRVbrRSYqQVGM5Xq0CkGmGWLpq
         C9BNLQED49ifq88iPtsn30RrT2Zv+3XRC7riSTMz/tmPIhWN1Hx0vG8EcRzSC5kLJIvb
         R7Pnq3YkId0DxZoAok5NDGHBxVqPlzv0WpANS3l9ifSOXXzMrrAOrBfDJ2kOVOsmRX80
         3Nllc8kOstG+/GwpH/PjMbwBmP7Kv0X3BXJCRxzM5XPD8tTsENkp8kIi0yvulBMdFLEs
         5OUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740577760; x=1741182560;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6f2oUbpNnWs5FWgzYsSndrQ+qrKeORdGmzd9Kwn/DJU=;
        b=o2EdzfaGQaXgxeCDKHKkN7f9V8Lla6nEQlhuV+mfPOfDUt8W2JzZG5wdNw/Kd3Lrun
         y9uZv+MrqHVT2b+3ZAzfuCNGswW2zuJ4eF68KxZqyOyINxQXmVC7RGjAownhgUpM2VKC
         kWopWNQObpBJRER1fBG65/D9H0j0SZdcfIxauuOBpi5j4FJWaFsNc/D93Ai3ZNof5szf
         5unG1NCD4tiB7vV06T5gVQrilIgnWaYj2z5OM/5rTOtEeXOA0mqPd9hk1KY7oVZhyuXH
         tHcUopXONDvn7S433QSbEKpbgVnmCY8Zf/6+VaSevlwIXft95T+7pX9gIismJ8J+Ye+U
         1MjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwBlqe8SRl8ll/HZLP4KFg0/sTw81RenjFFBP+zOXQFLGu0OcNeearl/Z6sWUecpjRxYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiSF4P+y0rh6O6hgPjWyhIJuYY5ItB8uVVwAP5rGaK0vXkeFYr
	DDXIrPMdhcNadAnJQ4RIRkl+sCkVnzugPyZIDcKoVnmJpuaSnodd+i4MKwi2qr0=
X-Gm-Gg: ASbGncsqMtF8g64iaUWqDNO6rz7vxZKQY76vORlEt1wDxJy5Mwo/oxPczO48G3GipL0
	8AogN5lM4ulOF4FH3stoClSwyzLaEd1c3ozK9FGaDpVwSjuYLT3+mNGuoXqesYBkNFjBxfICruJ
	r10kBIxGj5evxdpxYUeaL5ZKblDF5WZhFLSC+AS9kxjR76mqxVD22LStVuaPOpur23YW77ErpVF
	VAN5LdD08aCE/iaJXwrGAx6nXtijLd6toe6RtZ/hycY4Tf3RgVliB5NaPkF/7DE+TJDlDHd+nHn
	GaJRMf6HKOa4wzs92aJ68LDOBc8CZKWBNIQ=
X-Google-Smtp-Source: AGHT+IF/g6bbTd7C6qwckxi2v5TGUNH2Ooq2NC0xGM9g91hQFRyQNdoBE7TwzGOd8cpZlq0Esto7cA==
X-Received: by 2002:a05:6402:238f:b0:5e4:9348:72e3 with SMTP id 4fb4d7f45d1cf-5e49348799cmr9524629a12.21.1740577759419;
        Wed, 26 Feb 2025 05:49:19 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:506a:2dc::49:ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1cd564esm328612266b.21.2025.02.26.05.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 05:49:18 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org,  bpf@vger.kernel.org,  john.fastabend@gmail.com,
  zhoufeng.zf@bytedance.com,  zijianzhang@bytedance.com,  Cong Wang
 <cong.wang@bytedance.com>
Subject: Re: [Patch bpf-next 3/4] skmsg: use bitfields for struct sk_psock
In-Reply-To: <20250222183057.800800-4-xiyou.wangcong@gmail.com> (Cong Wang's
	message of "Sat, 22 Feb 2025 10:30:56 -0800")
References: <20250222183057.800800-1-xiyou.wangcong@gmail.com>
	<20250222183057.800800-4-xiyou.wangcong@gmail.com>
Date: Wed, 26 Feb 2025 14:49:17 +0100
Message-ID: <87ldtsu882.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Feb 22, 2025 at 10:30 AM -08, Cong Wang wrote:
> From: Cong Wang <cong.wang@bytedance.com>
>
> psock->eval can only have 4 possible values, make it 8-bit is
> sufficient.
>
> psock->redir_ingress is just a boolean, using 1 bit is enough.
>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> ---
>  include/linux/skmsg.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
> index bf28ce9b5fdb..beaf79b2b68b 100644
> --- a/include/linux/skmsg.h
> +++ b/include/linux/skmsg.h
> @@ -85,8 +85,8 @@ struct sk_psock {
>  	struct sock			*sk_redir;
>  	u32				apply_bytes;
>  	u32				cork_bytes;
> -	u32				eval;
> -	bool				redir_ingress; /* undefined if sk_redir is null */
> +	unsigned int			eval : 8;
> +	unsigned int			redir_ingress : 1; /* undefined if sk_redir is null */
>  	struct sk_msg			*cork;
>  	struct sk_psock_progs		progs;
>  #if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)

Are you doing this bit packing to create a hole big enough to fit
another u32 introduced in the next patch?

