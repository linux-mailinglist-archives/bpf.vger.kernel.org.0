Return-Path: <bpf+bounces-58495-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF68ABC810
	for <lists+bpf@lfdr.de>; Mon, 19 May 2025 21:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ECC51B65DDC
	for <lists+bpf@lfdr.de>; Mon, 19 May 2025 19:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290D9213E76;
	Mon, 19 May 2025 19:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Skz5FWMK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27651DC997;
	Mon, 19 May 2025 19:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747684385; cv=none; b=id0Plxwuifz9Qds4iAdKdMSz6T2NqJ2/DsLuQRVy0l1EXF8Va2bmxIeQlPODYHHky7Gnwns24JOsozacJjdN54TV2rCK4EPzDqgyjBEVpEgdp7Yjp+7chxN8CnX/8WDZvqd+vSCrr0k7Q7DlAxw7Y9YiygWg4GlTaiiaRrUxK1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747684385; c=relaxed/simple;
	bh=GJjWCf/dE6EIwK2zl2af9t8fxnk0uK+2x2QGZAC2ias=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8553aBVXE448HC0RZgNFHxQ6XogRnvWuMvTZfb4n+S7D6iXFlR1PjiAnn1in99da01wwCYRCqBftm2ecUdCvFlY4b659P5KZjQ2emCdZ9zZ/4JODFTtoVjRqfyayxYz642F1EJRdaIekOxWkhZ5+23B190oGSkIqnLEGcHMD+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Skz5FWMK; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-232059c0b50so20257665ad.2;
        Mon, 19 May 2025 12:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747684383; x=1748289183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cfEl5gKVr3ig5EX/NUXc2HBqSWYk2BVTccrrysu9YwU=;
        b=Skz5FWMKXA4VZ8tU05qIby5/pEJhh+SS4MDBTEv/M1bGgUu+Sd9EhEvVeU513WTuRo
         WN5uRHvAg4s2UmV7R5YOq8KZ4u2LCqLbvSBBkln8X0G5UIxHda0OtV+wNIMitwCmSKuV
         Q4C8qoPq3GsWEh/GdCDUd7dTMaOELvM7YP3jRf/WMEAIQMXs0G+RqfDC2oCSLW4j15in
         j6gD7QNc0vDiRUYLabvrNUGYVYTwPQzcKD75WSw3bxBdPLfuzZWNR1vGYHLesxa36tAQ
         6dcc+heZUqfiF4cIUSWiDC/wehAFWlEsY8z2FsPl/ncd9TbJX1zF5liKx+ccHFUQz0VY
         ZUqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747684383; x=1748289183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfEl5gKVr3ig5EX/NUXc2HBqSWYk2BVTccrrysu9YwU=;
        b=fn3y9lxqiiVOV0iebv7lYnnjVJrF3Bz0ZHNaLpoIFwzgUNFuSlOy8AE66MwbhksKRI
         /T+JcZb6ofiTM1UxAP6yIBwmC2TPygg+6QxX2WUUk25dS8z9rJYCS31Bb0V93I3v9vMc
         tIK11hOAAXOQzNGUv31aSNhlxZOnic5dy4q2c45d6ZJW7GoX3NccZrsx97I4wT3b9YZ/
         tIpvle6XM0QEDGGOTQiE+HSvkDTVPlQ2RZKfsuSDpiCZ23npkn6V6/jzdxlNoPb+krly
         C5DYnm2gnqv9ZUcaYt6BCrhxe9xqTOnojgregff4foY+PzUCMHTXftUqVf/xsgQiYZpm
         G3KQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJTb57B4m/qsY2JVArKZ9SUDL/pli8UwaOxyAJoKFzXJD/FPdLE0m+OiI8g2AX83COu8bnomCi@vger.kernel.org, AJvYcCXO3OIyuSbuxqNC2RSuurZC9AgscCEsT5cCJ08EXiTM76PYLz1cDWVjbtiwKMXAhZGWj81USGkY4Jsn+s8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0b3BvGzGj1/OcV0j+hXE0KkbRTXtwnajVk4IMUFfMVp65ZiTe
	4ednTqL1OFXrK6HF8dSYPRn2G8y17jpHNzG1VatMu9XwZft2pZsmMcfD
X-Gm-Gg: ASbGncscgXiBm6wcWdaMFtN72JMYK3z/1sYITNQbzSgK0fMGK7mbI4hTcVpemjXUiy4
	6Or4Jps0DLEaqIvYktppXk8UGChtps1ifGF2tHcd7EiNvzlZE1CQZmgWWp0ijoNlzgx7Wvljr3n
	5pR1i+Gf+DixuStuHhSXQBSfTArGJ5h1u4+WxKoML8UwAqXymuoZLyw/Op/aik3spVi2zdzkT2m
	Wu5xhg+ZWybD7kfSqKT4EGizSQ3Hvh8jNEUY3ftDMU8D1l1ALFu+dhEn7lpEFVaLwpzErWBRYb3
	oe3IehmLiMvLFs7gQU1USNUgYG0o3Gi4ea/8Iqmu219ior3mfWXavddbeKxSzA==
X-Google-Smtp-Source: AGHT+IFC3Gu/VtV0c0rVVrNpv7I5JPBPT6pwWKUrXoeh1vBmhM8/LyUvP+4lJSuK2GS5VZmkFhsKsQ==
X-Received: by 2002:a17:902:e742:b0:223:4341:a994 with SMTP id d9443c01a7336-231de2e6c97mr170926535ad.9.1747684382726;
        Mon, 19 May 2025 12:53:02 -0700 (PDT)
Received: from gmail.com ([98.97.32.68])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4adb749sm63836205ad.55.2025.05.19.12.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 12:53:02 -0700 (PDT)
Date: Mon, 19 May 2025 12:52:57 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, Michal Luczaj <mhal@rbox.co>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v6] bpf, sockmap: avoid using sk_socket after
 free when sending
Message-ID: <20250519195257.bscfvzw2td7uoccv@gmail.com>
References: <20250516141713.291150-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516141713.291150-1-jiayuan.chen@linux.dev>

On 2025-05-16 22:17:12, Jiayuan Chen wrote:
> The sk->sk_socket is not locked or referenced in backlog thread, and
> during the call to skb_send_sock(), there is a race condition with
> the release of sk_socket. All types of sockets(tcp/udp/unix/vsock)
> will be affected.

[...]

> 
> Reported-by: Michal Luczaj <mhal@rbox.co>
> Fixes: 4b4647add7d3 ("sock_map: avoid race between sock_map_close and sk_psock_put")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

LGTM thanks for fixing the tag.

Reviewed-by: John Fastabend <john.fastabend@gmail.com>

