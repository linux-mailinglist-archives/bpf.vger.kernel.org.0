Return-Path: <bpf+bounces-38483-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEDF9651A5
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 23:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E62E21F24F94
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 21:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFE01BD018;
	Thu, 29 Aug 2024 21:15:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DCC1BA89A
	for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 21:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724966139; cv=none; b=HMUeNvwHE3kCVd61113hR6a1LHaTFIef68neGmYqk4Hv+Jpv0yJMZgMhBTBc70KRyBwWqmoZWMD0Njgvs6EC4FxK7Elgf3fq1spw6S3bVt539bWNSjj1sA8a8VrIlSv/Hs4ZvLDHTn16qFWS/7igeNz2Y1RWY4GK5ZqEd6WVddg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724966139; c=relaxed/simple;
	bh=tputmP5ZEfI/0KC40QeaUhvafMbClegCdsTzmjM3ZU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdq+pr6LYQhKGLU9y+sCcPZ+7C06a2siSO194W91LPdLJYw4WtzEoIDT4o2N8pToIseKMgkSWQdQG22oe2SC23sRn5IbZ37FY0tRE80w5UzUt6l/DuSdqRIKuTOPof1r7HGJbxA/OcRb4xwRvclbAWK5Q00iYc2wDcCcE7JPBK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7cd9cfe4748so906174a12.2
        for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 14:15:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724966136; x=1725570936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EXoZn1wEjEk7X+9Lp6rEywsmItfFUbTf5ejf2cNEXkU=;
        b=WSLCSfLkyc6eU0LO+0nnWvqLBpYUT8L+S6xzhjVAPmbQWpoAKRXTCumhdcTypvjPoU
         BPxOvbbCdEZiOadE0N57pbQ7fA464IS0a5K03Yux1jOJKk+FeK5kcMACezq5Egtz0Aw0
         IAXuV+gsd4FTv1YnA0kw0TAfzMpUcKJ7AF2vld+4sAtpC6fZAlt5lNRferbDd5v+nMJE
         dSrkVlMJZ2V4UV0qxM2ZfKsaJquyWWJclfDRrdUOD7SCCFpFiSH8BclMk/Nv6HZyD8Df
         pmw/3W1TmqE51PuCdfjBNPPj9VYgtcDHkQpNKG3Ems5YWDu98ELgCY/CKJn6t/sVKYq9
         SgFA==
X-Forwarded-Encrypted: i=1; AJvYcCVnM+YJEt+C4JTK9wvDMsKU25fOB/pTf/Lo0AYrDNQ+0xRMh0ekVdrZv4c/OC8waNyspwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcoNL0RlmGki0DYMk5lVjOUtrKthFdUp6g0FNXYcXFjjJuVNK1
	3HcJS8u6fzE2ZOolPcvPhJAboEOsWVzA35kYCsh1vHIDxcYuVhI=
X-Google-Smtp-Source: AGHT+IGRXGFDABM+tXJjBbSFVRiAXp24fB1MsRmGHTmU+dyMZqvZ92GCFtYGTlzyhq5fdoobNdHA+g==
X-Received: by 2002:a17:90b:4b0a:b0:2d3:b970:e4d4 with SMTP id 98e67ed59e1d1-2d856503a4emr4271485a91.38.1724966136364;
        Thu, 29 Aug 2024 14:15:36 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8445d5a83sm4756481a91.4.2024.08.29.14.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 14:15:35 -0700 (PDT)
Date: Thu, 29 Aug 2024 14:15:34 -0700
From: Stanislav Fomichev <sdf@fomichev.me>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH -next] bpf: Use sockfd_put() helper
Message-ID: <ZtDk9juU30-rIOQ_@mini-arch>
References: <20240829085040.156043-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240829085040.156043-1-ruanjinjie@huawei.com>

On 08/29, Jinjie Ruan wrote:
> Replace fput() with sockfd_put() in bpf_fd_reuseport_array_update_elem().
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Can you resend with a proper [PATCH bpf-next] tag? 

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

