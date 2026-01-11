Return-Path: <bpf+bounces-78506-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 207E8D0FDF4
	for <lists+bpf@lfdr.de>; Sun, 11 Jan 2026 22:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F0F63060EF2
	for <lists+bpf@lfdr.de>; Sun, 11 Jan 2026 20:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288332652B0;
	Sun, 11 Jan 2026 20:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxLhH+rc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7109825EF87
	for <bpf@vger.kernel.org>; Sun, 11 Jan 2026 20:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768165175; cv=none; b=SY0RDylAmzy0G7alBCD7ugvnmroTZTlQfkeGm/xAu6teBWvVTSsLGSqraOSoRUtq5tAt8SNsu/DEJcmNgbCBRVSuXBrS9Yl6uOu0Mf7sb9fIVOByz8/oUBmT9KcUZU39JmJ9ZWJ1VUMvLcqdULodDzrk5Nw/CPH248eV6DCQmOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768165175; c=relaxed/simple;
	bh=9cMqLVdnlfr5VoREHhzueSPLC6rLwb22tF8EKySvNfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GL/flYsw9L9KzXv0CVDrHxP3TnBV2BacxjnNChRhnWIbLZKHRBLy4PjHVyNGkbdFdVyAddggm1yO2ZbFJLYiBZdK/MEkMgYHQ3ZYCmp251py0s4MBVrHcmn05iVpjoBJYfr+pg7lOPPqUtSjjvzVqrN3rhdO8RERL4v22UMHPzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxLhH+rc; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1205a8718afso6349203c88.0
        for <bpf@vger.kernel.org>; Sun, 11 Jan 2026 12:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768165173; x=1768769973; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tk5+OCorRg8A3Jr2MKWpFXAr4+NCiPUyLmkpARaUCDQ=;
        b=QxLhH+rczBwu7O99XrLJ4B85+QG6P6FfwOzfRZAKSK0XIUp1FS9bFEu0r7ycZLpFtK
         cvtK0oUsIg4IIo4PJ3BYy/m1Vq7E+7sB59VgLWfNJPqVOdWPiHwd1Tnnus8QJMu+lgfV
         6GXi/YQsLIHTWBoWHeUnHNHdU2fwhJSycQjLd+RUwHmVcKX9TpPjFqpzvudi7oTWcjN7
         M1dKH3rD1OXd2z919THnxGikrZiXDOzXi9TJntooGQUG0YFUNNLG/MQ0DKKr7h0Oqjl5
         eRKF5dHihWiQgFhzv4NXuzNlgt61yNmhIgLtYccBIYdj2UV34ooZdme51PAGyRzGWuQy
         zr0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768165173; x=1768769973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tk5+OCorRg8A3Jr2MKWpFXAr4+NCiPUyLmkpARaUCDQ=;
        b=hblUxN23f71qH8m8i6QZ5YI/wkUQV0F20rlqW/QshzfH/CivvQweltHjVGzLVYV3ay
         JrjEf4zyHqqSrzQPeSkJkRSXpsz91ccvzyStsXwaXgBGitnP2LhsJWKB11yzJLutwG76
         h+wdnPA3b3tqxy0piacVnrYKUgVxt7zu8BpENPC16oyjTPmE37rOKKbpIYYmRilOGm/H
         9vGujoozFe2BVkeZQox0JApNiEKr1K9viX0YzrXsnZsy4wG77EbDQ4HOlI3R5cxhiEeQ
         aaBbLQ1euHd5hQ6r6fWIiOjax6i8peSaZgft3d2CM4YQLN4Nu2nQRJ/h5QnFpVfYBnjM
         TiZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVubAD8FeU+vye5H2EJTSDqIefxq6w3r/tsD4F3xmqVc/mqt4fMvGwW5pzmme8xmmhbJH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEQ+3QWkhBPMweVCNjCQbGRwKCDYvffmx9AwgZwTqWxPmebTEi
	5qRBIm8h4fvSuxeRuKID8wCv6DrnkLKFoPWY5qdISuWRlr30oaWspP8=
X-Gm-Gg: AY/fxX5vxjUtr/NHUte+nWphX+oKRgLOga+/BBZoDWJQJULX+6to607rWGwxI3lFVHe
	DO7bNPHDknq740gjtkhqQrCcrW3VfMArLgAZdd74WhX9zVKKopudhqyLemlbH6EY1K6+meQVZMu
	NHcVm6Qt3CqeJIVXGgIB141qR2YYgUUyFdKuaZ0W70su4cg+JC2VbXZGP0wCU1JBHN0WUP+sJJ3
	04WH6eHLmu5PZbChfUqEjOw0m1yEcwqZyt0SjTjEWPw//09MKzkmlebmdENBQEZjA+3cVpVmbfS
	+xqeFItnjvFnvij/qVtMgYwoj/jJxC3Ez/AhlgQehAa6yMeUTBk1a3MnUnVDD3QXLyHpdBVvenU
	XIwUdCF9P+vcuTRXNDzB/BOjkf7yuJXSwaDsBU4T9yRnvFhQcx7BfUudpfq5ssTOVVSP5c/FiV0
	vDMC+YjlkNb8SgnfT+lbcw7ouwyZeauGLuKrV8dVq6PlcPPJgnHwiwQUCxH+AU6rKubvuORp2wK
	4J25w==
X-Google-Smtp-Source: AGHT+IEdltKZuIXPtfMp5G6LJA7IDXw/XJYLJeSYppqof2AJjZUPjmPHEVu+QC8ZZUWWmYmGwG65vg==
X-Received: by 2002:a05:7022:620:b0:11b:a73b:2327 with SMTP id a92af1059eb24-121f8b7b38dmr14826869c88.30.1768165173249;
        Sun, 11 Jan 2026 12:59:33 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f248c239sm19093739c88.9.2026.01.11.12.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 12:59:32 -0800 (PST)
Date: Sun, 11 Jan 2026 12:59:32 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, razor@blackwall.org, pabeni@redhat.com,
	willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
	martin.lau@kernel.org, jordan@jrife.io,
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
	dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v5 13/16] selftests/net: Add bpf skb forwarding
 program
Message-ID: <aWQPNM5Sh1QNKtp7@mini-arch>
References: <20260109212632.146920-1-daniel@iogearbox.net>
 <20260109212632.146920-14-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260109212632.146920-14-daniel@iogearbox.net>

On 01/09, Daniel Borkmann wrote:
> From: David Wei <dw@davidwei.uk>
> 
> Add nk_forward.bpf.c, a BPF program that forwards skbs matching some IPv6
> prefix received on eth0 ifindex to a specified netkit ifindex. This will
> be needed by netkit container tests.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  .../selftests/drivers/net/hw/.gitignore       |  2 +
>  .../selftests/drivers/net/hw/nk_forward.bpf.c | 49 +++++++++++++++++++
>  2 files changed, 51 insertions(+)
>  create mode 100644 tools/testing/selftests/drivers/net/hw/nk_forward.bpf.c
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/.gitignore b/tools/testing/selftests/drivers/net/hw/.gitignore
> index 46540468a775..9ae058dba155 100644
> --- a/tools/testing/selftests/drivers/net/hw/.gitignore
> +++ b/tools/testing/selftests/drivers/net/hw/.gitignore
> @@ -2,3 +2,5 @@
>  iou-zcrx
>  ncdevmem
>  toeplitz
> +# bpftool

nit: "# bpftool" is not needed here?

