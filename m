Return-Path: <bpf+bounces-56551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C063DA99BF6
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 01:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 222135A374B
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 23:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081F322F771;
	Wed, 23 Apr 2025 23:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rfy2pXGV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30643185B48;
	Wed, 23 Apr 2025 23:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745450426; cv=none; b=HX8RoJ1FFJH0ROtBc8u+R1SDoEUHl0emJn7kitzPaBZbxHe/F5FosgO+1+U3VfitHJmAvqUgQfKH4nGtWnNoWSXg62FnuZk5aRAh4VRVruUuSZfNM1P10Rel9BpA0jKcIQo476L8oWtfz6G5vrc9JOe9cZrMKKcv0LRxWIbQHoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745450426; c=relaxed/simple;
	bh=PoLdUM8YKELkgIWFMosRaUPk5GGn1/ct137NlwZgwT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DRX8zy7yIvjq3KhTc/3VoxP/A6BCmXYOGmoEdQ/qRu1GqrMjmcWMQ+4cYDM9V+fIY8UoGvxhNoxtPVagO2K7sJ+8vhehafY2UGowNCTTBZ4VE/NQ0huU7s/7Nvjv3MpGwhR7Z+Fb6NnL7eX4UAM8BxRongwZ+Gw/MzKjMV4jqQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rfy2pXGV; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22c336fcdaaso4342965ad.3;
        Wed, 23 Apr 2025 16:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745450424; x=1746055224; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=abKOlY2sTzPQ/TusDqq4nfLYAhPWi10xulEUiXcfDms=;
        b=Rfy2pXGVWbNXH8Uz5YRbqYELc4fFQZPcEubltlUMmlbnHqXcdN0lG1X9dcP7u6Wu38
         1L3dNwW5kTPiZ73ks6sQYJegl/cNWvkREEM5bO8dfaeUuWUeZCgQm3zMYDEBZZv8/sQK
         mh8JiLD1O2EJ1K8F1JbhIuytLPNNlI8+RZGQDm/r92HxhLC0mwk8uPiJyb3M9/kf0yA7
         6sBtLF0q/Tatvjaq5gzqKC29RUig6uREfY3V1sAuxlRZDd5ZSpdCnBu0hPYNErMKEF4L
         iwx+nxWFVr1xQt653PhcO6CwYvBGxlSu4LMxS37gTgahopQ9HUitCcgeGJesJpmaOXps
         2efQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745450424; x=1746055224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=abKOlY2sTzPQ/TusDqq4nfLYAhPWi10xulEUiXcfDms=;
        b=EstKwIZhWx/slVoJPDBc6mPa3DaKWVnjJ4fxbjUSsXgXi1hc9nxXmmEse4chNJ/LHj
         M8rC3QPdZb9TOoD3ahCUDcJpJUW6D8fGX6/2rrlOyG9rm7y2QzZlyOy2UMP/JqzLfM7M
         KvICIe8yd9bcNUXtOgRAqmR59kz7AOrlJCpUC9qj+IKRi8WgI1mgJ4cEKBF8k1vuS22U
         4env8ep9OS/U/pu4yJxtS5xFpoeM6MgGNa2uAwRYcNJupPAXfEobUQ8FTFxnqaoeYK+X
         bsecVgXAn0RkIBMbf/cK7/qBhTVdqCHClTuRyIp25uvGKmIsO5TtpYRxrOkZ3NVk1t1F
         2PwA==
X-Forwarded-Encrypted: i=1; AJvYcCULA/gU0bk3awnjlM1IOvqjGtelLfXwgugKINO3/9CWhS+JxmlCAi5u98F+8qgOPE0zKsNAf0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxngTO9DO9+Xz6WBg/srPC0fITBHZtrK5WVshYYU47PV5nG1GEJ
	L/iAmipQ6cxX/Xz2I1sVLlp4KSbpflCkkKin/B6fSHuZ08+pO5hN
X-Gm-Gg: ASbGnct/+nEE2DwyW2oNqDw+acGb1RBh0YF4hqEIhyuqCIo4043WvTmnqck+5zP0TFr
	RHaDLLPzmszJ8PWh+uTaCRPAGws0weHIKhJAe/wU/NB1ggLVQFv5pgFhQ7MtqoXI3dpgY4sXMtS
	LjazOLu5yQU03umTCj8vPmm3QpBMNNRyLdYfBK/LiPU26bS26o4lIxsOEJFTpmonToqUGJR5Tfj
	cSpgEWk63zUeVi5Zo8oQFc1Nkl8n8RUH6lssSQ4L9VHUSKV8oZXaG2cnWYk6xmXR7tGqNrN67OV
	I6v0u66Yvj4hGeiDQ1IgjJuPqECRL7u+CsNw77XSm8qI
X-Google-Smtp-Source: AGHT+IFwr/EOTneSy/MmI0i3yAi+UxHPrsKvpXlN5lYnm/9UOJ1O9hTphUC9vPeDl7EtkGpDOhXteg==
X-Received: by 2002:a17:902:e741:b0:220:ec62:7dc8 with SMTP id d9443c01a7336-22db3bd5c77mr5348925ad.2.1745450424348;
        Wed, 23 Apr 2025 16:20:24 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d770d6sm246945ad.17.2025.04.23.16.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 16:20:23 -0700 (PDT)
Date: Wed, 23 Apr 2025 16:20:22 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com, andrii@kernel.org,
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next/net] bpf: net_sched: Fix using bpf qdisc as
 default qdisc
Message-ID: <aAl1tm5rwB0kq1/Y@pop-os.localdomain>
References: <20250422225808.3900221-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422225808.3900221-1-ameryhung@gmail.com>

On Tue, Apr 22, 2025 at 03:58:08PM -0700, Amery Hung wrote:
> Use bpf_try_module_get()/bpf_module_put() instead of try_module_get()/
> module_put() when handling default qdisc since users can assign a bpf
> qdisc to it.
> 
> To trigger the bug:
> $ bpftool struct_ops register bpf_qdisc_fq.bpf.o /sys/fs/bpf
> $ echo bpf_fq > /proc/sys/net/core/default_qdisc
> 

Good to see eBPF Qdisc's can be default as well.

> Fixes: c8240344956e (bpf: net_sched: Support implementation of Qdisc_ops in bpf)
> Signed-off-by: Amery Hung <ameryhung@gmail.com>

Acked-by: Cong Wang <xiyou.wangcong@gmail.com>

Thanks!

