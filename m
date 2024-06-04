Return-Path: <bpf+bounces-31391-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6EA8FBF85
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 01:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D8271C22A05
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 23:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E16614D2A4;
	Tue,  4 Jun 2024 23:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fawe8hIk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FE21411EB;
	Tue,  4 Jun 2024 23:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717542207; cv=none; b=i5byORIWWWrMRz+KxX7XJVZF2oAkP0KwPy1iv+5dwOGSrcOYVqmQPkQaYIqCGZDM+tKtPM8DgIfP5RDiZjcYJ6UDGJ1Iw4pIOU7aijInw4BI0kVLEV2sBOPYJGQzBfA4ZEv6kQQKxaqo7UVpqGkJNFzjt8+XhIEJOhKRK6RevpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717542207; c=relaxed/simple;
	bh=5wkVe6B4f2jQUdzLRlr/m4oXjiHPg+lAbnzfBuLuHzQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=VkT0iHH5A0ut6nhhq9yNDkOhZtd5N1u+N19afKfKEeNBWd4DsuECRZ3mmppxmrrmYuIse2Px+tDazLy1X9h2OnYu+a0BnuiLBJ017arsu7yuwqhW2ljFXjtbE49rZKge6BE2tVeHC4K7YJRXdGIyUKnPCPYRoE6mBZWw3P2A7wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fawe8hIk; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-795186ae415so71801585a.2;
        Tue, 04 Jun 2024 16:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717542204; x=1718147004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KC9O4YKxf14DXjmcYeFKj4Ou4wMzUtvv21s1nhGSQwg=;
        b=Fawe8hIkfDG3x10MgX/NBe3IsjsOdZDH9RUGnaYgkEZhBWs5ubXaJJETsGO1DMno5b
         N6EfX4J84AcDMFIlvbwZNcECXJQclwdmthnseCDgDe+ed4roTCsKhxKiEtf0/GFpAWdW
         pDCmcO4D4QfSsZhxPEWc8bWbQwSbBkEnbPJJoPTkDka23LhHUMr1hxbgGIvyB8mIxOm5
         UYi6QNrOkrOTK3bdLnHT2okTCACSTapHsuFaudkRb1RkAe6fbKxlLvkN1nb63eMUcYlG
         tpKn8ZAnj5Qj9fVHiYg4fcyKmQqv3YTovbnM1Ux216HyFjjnnugkGJH8nQiTI22HhC0b
         p8EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717542204; x=1718147004;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KC9O4YKxf14DXjmcYeFKj4Ou4wMzUtvv21s1nhGSQwg=;
        b=w+/UC94Jb2RjTL9IUlSxjn4hxj1uFEo4khfirKQ554RULEaCicUehP4X/dhBgOKgRh
         4CGDDRaJkLVEC22DLp58V1bOR7McR50GU4cwBu5hELQNiJV/trM53ivCmUjYLCFwgNg+
         aqbbfJOQo44CJsqyjVkN1b6a3sVA5wzy+2xBB38wQ0VFSniipYkjo3DptOqaHdH4xCqC
         mQ5OarYrLKSAvbGuUQ7N7FvkaP6YO8VqQ7n2vUzihORGyfVxcBg+279TyL3uGbsVC6M3
         ktGsXNoNyF+rct31RYQmpktVgk8m49+eOj8GmKAWxeipZfvY5velZm1wfPmAQDDqrisl
         QDbg==
X-Forwarded-Encrypted: i=1; AJvYcCXmbLpVT9aHRQMcWZU6aboQhQcKyBqTfSyII/W2FJ0FCKoDT0ifOu0wdz9t+ffbSmcT2cM85WewNJsZ0usYuFaP2bnWAnqGMlGlKQ7hePUduR2RsYWXIihe/XJg
X-Gm-Message-State: AOJu0YxPczNSRtbDNPyZOryRJAoqTrWYmX+1OtvMIJIxPb5kwfp2pdNo
	wPxjOJCYqJffe+A6OTu4JP1sXoMiQXXClI6S9E/S9y9cEmHMwcP7
X-Google-Smtp-Source: AGHT+IEqHACDMttGWwYUmx4jXqyHaql+/7merGsB1owjlaJHNPveRIW0rUybeUG6JzMYbEubYWdeFw==
X-Received: by 2002:a05:620a:4ce:b0:795:22be:ce with SMTP id af79cd13be357-79523d3869dmr86024385a.21.1717542204376;
        Tue, 04 Jun 2024 16:03:24 -0700 (PDT)
Received: from localhost (112.49.199.35.bc.googleusercontent.com. [35.199.49.112])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794f2f11fa5sm399451385a.38.2024.06.04.16.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 16:03:23 -0700 (PDT)
Date: Tue, 04 Jun 2024 19:03:23 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>, 
 magnus.karlsson@intel.com, 
 bjorn@kernel.org, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 netdev@vger.kernel.org, 
 maciej.fijalkowski@intel.com, 
 bpf@vger.kernel.org
Cc: Magnus Karlsson <magnus.karlsson@gmail.com>, 
 YuvalE@radware.com
Message-ID: <665f9d3ba5a1a_2c0e4d29423@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240604122927.29080-1-magnus.karlsson@gmail.com>
References: <20240604122927.29080-1-magnus.karlsson@gmail.com>
Subject: Re: [PATCH bpf 0/2] Revert "xsk: support redirect to any socket bound
 to the same umem"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Magnus Karlsson wrote:
> Revert "xsk: support redirect to any socket bound to the same umem"
> 
> This patch introduced a potential kernel crash when multiple napi
> instances redirect to the same AF_XDP socket. By removing the
> queue_index check, it is possible for multiple napi instances to
> access the Rx ring at the same time, which will result in a corrupted
> ring state which can lead to a crash when flushing the rings in
> __xsk_flush(). This can happen when the linked list of sockets to
> flush gets corrupted by concurrent accesses. A quick and small fix is
> unfortunately not possible, so let us revert this for now.

This is a very useful feature, to be able to use AF_XDP sockets with
a standard RSS nic configuration.

Not all AF_XDP use cases require the absolute highest packet rate.

Can this be addressed with an optional spinlock on the RxQ, only for
this case?

If there is no simple enough fix in the short term, do you plan to
reintroduce this in another form later?

