Return-Path: <bpf+bounces-59359-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F6CAC9476
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 19:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C664C3B8FE2
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 17:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117202367A3;
	Fri, 30 May 2025 17:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHU9WOTk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE812D600;
	Fri, 30 May 2025 17:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748625343; cv=none; b=qMpf3w3zEb7E35pR1j2Go1IZmIWt6i2gq1bTZhh8vJ0e1VBCZBKXI4fG1TYtgchaiZE79CyMJaeXYugyU6hd3tISgDGevjGoQNySvdmWwcPcq0t6sSbWiP+wBqU4yhVhEd81hZgti2qxnCOwXoT4GbD1n4b99L9dWv5JUGUuXSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748625343; c=relaxed/simple;
	bh=aV56R5LwjSjBEB8PaKsoUC7GH8MBZvupl6e+frIn6ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jXTHkbdTjf8fd03t9c4LXgYpdurnCe7V0WsHIXXdjsnFoB53YpT61T712uY7wbWxzsY7JLPZ68cmKglEfij1FFbEiSXxYnBrdjTRvWwHlKCrN95DRldMh6rdHY6kS1sfcjMvrMIjDI9pnoDdiGogdlUK8iWC7O0AqS16r3qUkxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IHU9WOTk; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2301ac32320so23262005ad.1;
        Fri, 30 May 2025 10:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748625341; x=1749230141; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QDA88krRjjfrMHi8XF/SJ2xvUb8o9K3lPrI4lhdku/U=;
        b=IHU9WOTkvMV2/HQUfMUAJ9dULJpkSutkqzOB1Kw1A8znfAOFSn5GpVI+WJIyHkoxFH
         MRy3fv4jm9lJxGnf8gw4VJ6Y0ChyBoIsV1YMSi1dv+8R59U5VnOpqCsO8cxAMfAyu0rO
         Dwm9vM1CrniPREFjTTw0LDnkzW/r/KZYcnnD4lH6iy35b3Tl2Yo++PWUsS1nCmTzHYR4
         Fwtlhuui4VtegCQVwUqrzDAYV8NtzejklfHP0V4fKyp57Cb3jShjEKfgDfBiFcImX/mB
         PSptsdD61hudlBmSL3jymqjrOTQ4t9yUoKPXfLxXvZcrvJfFqbFqoBSzZY3BXhwhiq/2
         xyKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748625341; x=1749230141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QDA88krRjjfrMHi8XF/SJ2xvUb8o9K3lPrI4lhdku/U=;
        b=mEuT4ykDY5YUhLggLyQ70O4lvBCl1PTQyAu+RAjc2CMx1jtQ7cd7ydU7pM/zrp8fIj
         cPK7TbtkU6XVXFT1QCcCAg6YEnW0TVB1VkqqJ/RXclKYNrNxiygZk0R0ZtTX8kOt7dna
         GEgBtSAsnt8sXrN7a1VEdkMYCqVMOOhhjl0WfltTioiodRTy57gkdElWnDuPXznEwJoK
         TcJ6K/Ec2XjoWTICrXsNxgpVKq5hJpRzk/BFIMjZD2GLWgWGA2emoxaNn743h5ZGoS81
         ectJ1iZjEJbrtbDttIyEQ0X4N9qWgYl+pu1xOLH39NEiv9OcSvU0TBokGiSpG1/MmJeG
         52ow==
X-Forwarded-Encrypted: i=1; AJvYcCVbD1uB+yvHEdY1ZdjZ+F5FU0/TksWczzyWTrPHSDZ4ce2pM7cbzBI1FP50BR+Hghr8vB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmX+S5Ou5U7BsKcH1bh3csLBtcybJ2AZgwjnMa3jg6MRMLikuE
	ZfFGaCK342OOnc/TLplEDIFZhFXY4dRr3JQX/XE55qW1h2N1vT3IfVvF
X-Gm-Gg: ASbGnctY/IJbjo2Mb/6UswvcdRu/V7DCzBsQGG+8Cnd7SKRInkHz0D3KUH8NBq/QXXP
	YAB1cSt0D9B0y4vtVO+9sJv1oN3jQzmyrmhFWMiU7nJhTfzXRV+hbMpmPCzmvZX8d5TjDcIlnQ+
	OWSiQf++fxsMvr8Ro4cqbONxBOtQaJXJxcKU6k/0Lb9dFlb3kVgT0YSYeq88XyhXUwsCTcuURzA
	Msye3UAm5SlqoALc+Yip8KSUjZIMxPqdTeVFPhBygCtkq9EuePatCduqfl1LODZgl4gR0vhgzG2
	+zEPwCr/vMcloYzIukpZNTyHP1nrpiS08OBlrlJUWCekbzqZ2Lvv
X-Google-Smtp-Source: AGHT+IEZOOT4dL0X2Z0+F4OyrfSAYhBTvXNYp5t4nXsCToEPeTv6MlGSUWlLEh+HNbXi8qOSJSExew==
X-Received: by 2002:a17:902:e888:b0:234:c8f6:1b10 with SMTP id d9443c01a7336-235291ef73bmr71615125ad.28.1748625341284;
        Fri, 30 May 2025 10:15:41 -0700 (PDT)
Received: from gmail.com ([98.97.39.137])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cf9380sm30815835ad.203.2025.05.30.10.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 10:15:40 -0700 (PDT)
Date: Fri, 30 May 2025 10:15:30 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, zhoufeng.zf@bytedance.com,
	jakub@cloudflare.com, zijianzhang@bytedance.com,
	Cong Wang <cong.wang@bytedance.com>
Subject: Re: [Patch bpf-next v3 3/4] skmsg: save some space in struct sk_psock
Message-ID: <20250530171530.lqnim5gh3egiddkc@gmail.com>
References: <20250519203628.203596-1-xiyou.wangcong@gmail.com>
 <20250519203628.203596-4-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519203628.203596-4-xiyou.wangcong@gmail.com>

On 2025-05-19 13:36:27, Cong Wang wrote:
> From: Cong Wang <cong.wang@bytedance.com>
> 
> This patch aims to save some space in struct sk_psock and prepares for
> the next patch which will add more fields.
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
> index bf28ce9b5fdb..7620f170c4b1 100644
> --- a/include/linux/skmsg.h
> +++ b/include/linux/skmsg.h
> @@ -85,8 +85,8 @@ struct sk_psock {
>  	struct sock			*sk_redir;
>  	u32				apply_bytes;
>  	u32				cork_bytes;
> -	u32				eval;
> -	bool				redir_ingress; /* undefined if sk_redir is null */
> +	u8				eval;
> +	u8 				redir_ingress : 1; /* undefined if sk_redir is null */
>  	struct sk_msg			*cork;
>  	struct sk_psock_progs		progs;
>  #if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
> -- 
> 2.34.1
> 

Reviewed-by: John Fastabend <john.fastabend@gmail.com>

