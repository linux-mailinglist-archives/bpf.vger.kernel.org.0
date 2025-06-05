Return-Path: <bpf+bounces-59755-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E43FBACF1F5
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 16:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2A253B0898
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 14:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B501DC9B8;
	Thu,  5 Jun 2025 14:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEygzrRf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E65615DBC1;
	Thu,  5 Jun 2025 14:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749133508; cv=none; b=cX1gmN/b3gxSE87a6HrqoOZ+xGC/ABb4A71L9YMUZcRY15IKNWlanfGQnYkuo1RHhm2SB7jZEUnPi8XECDnpdH6GjITzqCFBPF0LB8D5AiXAk5ztsncz3wXgqE+AomhC92krTeVya0Rb2LDLKT2znoM78b6lxWyWsXIb+Ss99GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749133508; c=relaxed/simple;
	bh=1hPIlsrNsl+45wh7cNZIvl0GeyoSxulCp7FX15MTo+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WslPjkByMg8sE/8KJCmFA9/WUuNFyOiDzNa4O0Ta9HWnx1bR01iDuyZE7vHHbDKVDodYb2b8NuQzjUSKsc7wqGuw3emB8RwC24Cm2sm9OH04N24rJ2P/vxQIYz4CAYB5shVpuyApTBCVxXjGRPnzGwhsHQWAqCgB4DbLXAPuRsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aEygzrRf; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-23035b3edf1so9883305ad.3;
        Thu, 05 Jun 2025 07:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749133506; x=1749738306; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+pFlKswJoY6P2XiNr0PqOnuFgA3sLrQBP5t6JTGgE2o=;
        b=aEygzrRftb9ZGtXuovGZKV78ftzlsflMhb9s+atyOqtks+qlCrvF2kdn7wgibB5Kyp
         9gdwyyxurLJ0OiVtAUCls6ovWpACrThiZ6PoKlm7G6tBqyPcmvI+L9UXUTB/JgzY/YXD
         LZrw9ZMNrIFAZHubE3/ASn6nogyfEW9NT61V/g6RAlaHuhVzsYc6QevqG/DVnsREgnRl
         uzlI9U4L+cHSkJyass0vMRi2ICLAOjLKwvsZHCNH8j6CTyfhKJ229Vr8LknW7vGVpET3
         TXGVjW2UlQUspGhxmn/5ROcZb+DeBg/PpV2wPRu0min+H4fu5yQiXaf0KfUp81i2ebmt
         12GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749133506; x=1749738306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+pFlKswJoY6P2XiNr0PqOnuFgA3sLrQBP5t6JTGgE2o=;
        b=O90OV7e9zS/GDF95VydmDwJBR6TFx+kLQutCrpGVKM7ERwsf7uZ0hybO3UsF2Hfk84
         /JdWUpgTY2Lf6TPRKgRRZUBYZGp6jgs/PPTsTjafgKW4M56YGFO7GwcM2brB79sLPlcD
         7DwQ+Ul/AzxxEA7387xkGnxNkoPHa+w1sayqvjLfL7CrMCto+N4+y2/a4IGZo3iv7cRK
         ryKlHtUU889wRtlgS/CUqcM6KZ8i7R/Sj0j+CHxmFYXDViZzoK3OwXosQGWkVaAC8Ulc
         umiJ4vzDipkyDfOzZzgc6INgk102W8xh6uKoJGD/jjcvv+qZCUsU0FzqN59ZHC7HQDDf
         mjvA==
X-Forwarded-Encrypted: i=1; AJvYcCWhJjBUVbDhrfm4x0HJZuNg19AJ5oX1kxjzrmLsIs4Zdg3CCUCJAyQP+WxFEfb4EKVbCOMEXfEJ@vger.kernel.org, AJvYcCX6RZo3KWZWn8ZsnWXkUTU4WTw4hiMTvZo6M/oqZXXBfileKXWgPdGuWprzjixobDvalxeRjbauCTcAEjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeVfflqHvm+DlxBwmx70VVWDyuB0t5paaZMLkgTPaxcWWTxLQ6
	zHQPEk23r2Bs50tXIMCHjyKHhNWJKk7qWon6ag1nxi+ndzOpo4uve5PZkWaLwA==
X-Gm-Gg: ASbGncuQn4epr8RN+KE9FjA0luPDkQlJVx+5IxWau3+WCuxZBKXNACPyPflWmNiHebW
	+hXk0CsoCelv9oityXTtcFH8SlIdgVo6+FhW/yeFrLOi+R5yiNRRNaDzUs0L8UNBYTMjyXwgEGj
	v0tc91iCDMgOgbUSI7lg3h88YOLlHp7v4tdY1VpKHGOiCEV4H/aHq9r54eHxCQx+V/ynib/a83K
	xcpBe2NyhTyjaMYZwqDTOCy6KIx2W/mhO9Nm+hBKSAJatrDwhMSm7ePzUOPMYm6f71d0Nhjyrmx
	dH8MNcLdODXTmRhjsLgqenE+WcXGENo+zRflu1MNb6eBhV2ZFslDHBZgxr0OrQ==
X-Google-Smtp-Source: AGHT+IFrBIEMgXDVVN0JFzsrx9ZHWUFzHY6I2msZa2Zg3LKqUQhvxhhRstpjP3bkwkgpP1HV2dLqmQ==
X-Received: by 2002:a17:902:cec4:b0:224:910:23f6 with SMTP id d9443c01a7336-235e1518937mr100031975ad.45.1749133506248;
        Thu, 05 Jun 2025 07:25:06 -0700 (PDT)
Received: from gmail.com ([98.97.41.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cd34edsm120316355ad.126.2025.06.05.07.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 07:25:05 -0700 (PDT)
Date: Thu, 5 Jun 2025 07:24:48 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, Jakub Sitnicki <jakub@cloudflare.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v1] bpf, sockmap: Fix psock incorrectly pointing
 to sk
Message-ID: <20250605142448.3llri3w7wbclfxwc@gmail.com>
References: <20250523162220.52291-1-jiayuan.chen@linux.dev>
 <20250528234650.n5orke2yq55qnoen@gmail.com>
 <fefe50c6ec558074ec7de944175cec82bb426f10@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fefe50c6ec558074ec7de944175cec82bb426f10@linux.dev>

On 2025-05-29 02:42:14, Jiayuan Chen wrote:
> May 29, 2025 at 07:46, "John Fastabend" <john.fastabend@gmail.com> wrote:
> 
> 
> 
> > 
> > On 2025-05-24 00:22:19, Jiayuan Chen wrote:
> > 
> > > 
> > > We observed an issue from the latest selftest: sockmap_redir where
> > > 
> > >  sk_psock(psock->sk) != psock in the backlog. The root cause is the special
> > >  behavior in sockmap_redir - it frequently performs map_update() and
> > >  map_delete() on the same socket. During map_update(), we create a new
> > >  psock and during map_delete(), we eventually free the psock via rcu_work
> > >  in sk_psock_drop(). However, pending workqueues might still exist and not
> > >  be processed yet. If users immediately perform another map_update(), a new
> > >  psock will be allocated for the same sk, resulting in two psocks pointing
> > >  to the same sk.

[...]

> > 
> > Can we add this to sk_psock_stop where we have the TX_ENABLED bit
> > 
> > cleared.
> 
> 
> 
> Thanks, I just add SK_PSOCK_TX_ENABLED checking at the start of sk_psock_backlog().
> Every works fine, and truly no more flag needed !
> 
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 34c51eb1a14f..83c78379932e 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -656,6 +656,13 @@ static void sk_psock_backlog(struct work_struct *work)
>         bool ingress;
>         int ret;
> 
> +       /* If sk is quickly removed from the map and then added back, the old
> +        * psock should not be scheduled, because there are now two psocks
> +        * pointing to the same sk.
> +        */
> +       if (!sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED))
> +               return;
> +
>         /* Increment the psock refcnt to synchronize with close(fd) path in
>          * sock_map_close(), ensuring we wait for backlog thread completion
>          * before sk_socket freed. If refcnt increment fails, it indicates
> 

Thanks. Please submit an official patch so we can get it merged.

