Return-Path: <bpf+bounces-58347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCA7AB8F21
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 20:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBC093A26C6
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 18:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1B92853E2;
	Thu, 15 May 2025 18:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mc2c4Pth"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AA928469D;
	Thu, 15 May 2025 18:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747333875; cv=none; b=UIeOi6wx4CtpnRb0CnNCcuRbP/2MKWpB+v5Ym6Gk3PewFElnBFHTyYPDYgYiFj1BBgycG9Rb6E+JXD4deJue32xLPT5FAW188Hjpz/xjtJ8ksJi+FvUFhIp8c+B0WcLhp3J3TOPVzKSnBQD8i/U/Ue/o3zJQGlHAzR3Cg9Ix5ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747333875; c=relaxed/simple;
	bh=V6rVl2MUL74b08/nShEq7cCkERzRMRshlzLbhmNnQ+M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xl/Plvux5QTSviR14IPcrEzUkhvIygTntfS0TV/anrWs6E02/5LlJzMFB414d0QC3q/y0tjuW0cd+miuGvZJsj/oL3WJXmECw335pnSoqlj9jQHllc9AR8SNPMh8+zdGsee0rHSpT+fmHquBArytdfz1mtQ22Wa3cCPl3WJJ5YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mc2c4Pth; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b0b2d0b2843so1015344a12.2;
        Thu, 15 May 2025 11:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747333873; x=1747938673; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V6rVl2MUL74b08/nShEq7cCkERzRMRshlzLbhmNnQ+M=;
        b=Mc2c4PthL7zLQimOWfiOzdY/66hta7ybX42W94Ogk+5scBNUV4VyTie6MuIKNSz6BQ
         GxfNRBcYAzJRPP2lBlhAekadEeA4ytD4dP5v3xTozVd5P3qaS5c7+LCIjewAZUPVSBH4
         +0NzQ3cUhgi2B1AE/09Dnfo938pcVHpF8mndFMmCwC4BE5vzJ/gPl6ycPM9FdL+1jflm
         krN8NcvnLVBwkBc8MLd5vYIn0Wkyfs34NLiY7RzESIpHUR/iEw+/qqQvYPZHzNu9EQWN
         ulW1Isa6OVdAME8u1nmgvYFaGXb6Bwgo+L5hM3IUACiB/U5yJI2D4jr9KO4142MTsikZ
         wrKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747333873; x=1747938673;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V6rVl2MUL74b08/nShEq7cCkERzRMRshlzLbhmNnQ+M=;
        b=noo3aWR7Asoy28VkTX7IdhU5HisFmTBrRDreMaHhnAQzoZdQxkemeniAL0sHwwIh6o
         PN09OWdJ4Cq/3CHsS7bD5uvKSvtUMh53yZmSxWZ9N4RKdz8vmjcw3MrHfiXdJyz/h4UR
         6XSUiZXwui7mGLQkKLn6LLWfNXVzTCUZLaE5AktNl59JzZGG1sKyw2aur4RJ/9LktO5R
         7/u5aV8ICf25hIEpfqWjXZtrrjUQue8c7Cfksp3bcUtY1lC/9KXDQQmjclDRCMTYAVre
         AsAssVWhEMLAP6DmA4ceqoAIbVw8acxZAGe7UYnHZZd2ockfH94ENQdrHxzeJn5dZ2lo
         4L2A==
X-Forwarded-Encrypted: i=1; AJvYcCU1dZt4PQJdhV1zsS/mzlX+oUYf8y7NiSnl1QuNsG59OSS0XF4A4EcFbPSs7LF1IRZSyRbyK5syklyGPtsl@vger.kernel.org, AJvYcCV+lEmAt3ZO1mpxUMCUsnaP1sPk89Ae01+JrKD4WplvQJLCAonaubBbU1Ri0pzIC6ynDFUD9srdmrYd/l2tRfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRAT27R8/AVT4xspNQf+srCMcgnspUaZeapjVjULJqTDCEMW3v
	rW03qZ6pxb6HjdhGBEp9Vk8WanL7XLYnPpU5Od1t2c5wmg7ZZpQ17/JU
X-Gm-Gg: ASbGnctPnPEeORZSoNvHfoEi7XSY/xuYjW0XbZ/Wto1mMNGdD5KRv39xemZJS4uZwHo
	jgzYVnLcuxQa9/fIPSgc5XYO6bcof//IozEDYEOpi6BFS4syVVAIn/aX2n7Nng5sPwhoKwx+vWt
	nhqL08hV4AfLYU80cMctrlIfBIteaxA7CBcEBuLrlK5OCcjKfnZQhkIjuWqSrGp9sCNyd7+Dt4I
	IK5eVgfIdxHdCA9gFM9Ab10zGcDr5k/BK8aHLz97YmHwep5e+gFaSvVtrykeCu96dsmlHPL/qpJ
	Qt6YIhnwsfNPfs2kUiTGcVITAU+gneGewmAh4CwyZkoqXvM7OW5cfTTKdg==
X-Google-Smtp-Source: AGHT+IH6OY+7lX78qJzXX8XUmWkJnOnPaGJh9q4L+Bcz6Vd9CB0IOhsuPWAb1U3MJhxd+KmPtBkNvg==
X-Received: by 2002:a17:902:ce87:b0:223:653e:eb09 with SMTP id d9443c01a7336-231d438a294mr6291995ad.7.1747333872812;
        Thu, 15 May 2025 11:31:12 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4e98018sm917875ad.155.2025.05.15.11.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 11:31:12 -0700 (PDT)
Message-ID: <c36245a48149a12180ec710c65d317a12cdfa020.camel@gmail.com>
Subject: Re: [REGRESSION] bpf verifier slowdown due to vrealloc() change
 since 6.15-rc6
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kees Cook <kees@kernel.org>, Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, Andrii Nakryiko
 <andrii@kernel.org>,  Ihor Solodrai <ihor.solodrai@linux.dev>, Andrew
 Morton <akpm@linux-foundation.org>, Michal Hocko	 <mhocko@suse.com>,
 Vlastimil Babka <vbabka@suse.cz>, Uladzislau Rezki	 <urezki@gmail.com>,
 linux-kernel@vger.kernel.org, 	linux-hardening@vger.kernel.org,
 regressions@lists.linux.dev, Greg Kroah-Hartman	
 <gregkh@linuxfoundation.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Pawan Gupta
 <pawan.kumar.gupta@linux.intel.com>
Date: Thu, 15 May 2025 11:31:09 -0700
In-Reply-To: <202505150845.0F9E154@keescook>
References: 
	<20250515-bpf-verifier-slowdown-vwo2meju4cgp2su5ckj@6gi6ssxbnfqg>
	 <202505150845.0F9E154@keescook>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-05-15 at 08:47 -0700, Kees Cook wrote:
> On Thu, May 15, 2025 at 09:12:25PM +0800, Shung-Hsi Yu wrote:
> > Bisect was done by Pawan and got to commit a0309faf1cb0 "mm: vmalloc:
> > support more granular vrealloc() sizing"[2]. To further zoom in the
>=20
> Can you try this patch? It's a clear bug fix, but if it doesn't improve
> things, I have another idea to rearrange the memset.

I tried this patch on top of the commit 82f2b0b97b36 ("Linux 6.15-rc6").
W/o the patch I observe the slowdown, test times out after 120 seconds,
with the patch test finishes in 3 seconds.

[...]

