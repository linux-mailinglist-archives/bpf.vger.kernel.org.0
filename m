Return-Path: <bpf+bounces-30097-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A1B8CAB71
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 12:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D60AB280D7C
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 10:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683FD6A8D2;
	Tue, 21 May 2024 10:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ta9WBynk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779FD56B7B
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 10:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716285901; cv=none; b=l2q93YduQaPVsfDAxbQDFPMMLxZZEZ1Dv9yMIOKjHFoDYJt4mcz20GydFkJzDWgDBBGywHkvoduuJ9oiounryehfK2Gmn5QEDvFJDmoVC/kKcTPMJ+qNIFIyay9MkeFtLs2rseFHcfhXwLVBiKSsbV/OCok2qRGyU+GCWc9w/wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716285901; c=relaxed/simple;
	bh=nzRli6yHPRK+K3BDw0Q0wBRaQCvBMZ15ek3OS5QGsTc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iw0FtIGVjI5YhIq/2ioDu2UcDlwJSy2KUpb9Tmlp4JGtHuDmlGBr/qU3SuRRcZDnf4D2Pfk8ygVbFibDLWLHWTEz8VUf7MZHmLGkdh829+ZKqGCEsabwbW3Vd+8h/cnGok160seM0iJPbRoEvpS0sdrjCjs09cpuEZZdIyOVkHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ta9WBynk; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57342829409so11948919a12.1
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 03:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716285898; x=1716890698; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sfZPIG+D2FkFNTJo2SxuXcaL7fDnWxs+j0dYYlvipoM=;
        b=Ta9WBynkaVcxdpUJ7KNsWigr1YgQgqBifXud/ahee51mRbd5qZOV6UfOwb4T4NGFdg
         tmHCjnKfssykdvI4lyFtUu3ejipv7sizP+nQPQmo7T1bOBPzBHW2EazJ52o093a7OXvf
         Y6iwQWK36ipOUK5bUs0LezxKbrh/WmQGTKJYvp76Y43lus+VB89Gu/MbdPEp1rkUn1Aw
         eI8VXMuNJtbWYsz7W5UsYvhvhrq+Tuia7pq1YocH5ShlVUEn0Li4WDvSDDb9bt7p1Ny4
         QbpB41IQST7TeFW87uMukroyCkEmf+EmHPkQXDpaTRO8wf/m2fszOx7DxIhF017I/M+R
         3WdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716285898; x=1716890698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sfZPIG+D2FkFNTJo2SxuXcaL7fDnWxs+j0dYYlvipoM=;
        b=O48tFTwrB0pdsEvMzwvuRejGtuwKevzpZOa5vL6VDxa7KkrzErlFORMzhpbrE4+KT4
         cAM5GL3ozMa9YxGXtLIKP8NPyxj/afO2pokJpenaoO0tDSXSCtYZKeB5Pvnu740V+npB
         IavfIRn1bpi5yj37khNWFzhQq9hjfc2AlOrFOnIrZJgk/LMtpLSqpVTR48YRhRDVIUb6
         zhsFrE511w8+REUrqPE+citas7zQsSk3gzRa7UimAzXRWl0ZRGd2HUFzMShjNjXWAIgA
         t46an2CTze8NmPfSJD4j5EXuiYBiCaeQw149lZbV217R857HGjfktAvLiJZSi60gNM9Q
         PM9g==
X-Gm-Message-State: AOJu0YwK++dVTYTkvVcpQ3POv6AAmThFYchVI4VjALTbFHDcXXEoNPgf
	Wws4W5KW1HlxBewRlBev+8k49dTj8bqmWOEeVu38pWpaP54SiQpyyXlW1g==
X-Google-Smtp-Source: AGHT+IHM07mG0hzbsFqA5JRfQyZxYKTXQvGQJpKVrSRuRqnPEMQImHfMz4/sOGmn3F2agkv7oMcmmQ==
X-Received: by 2002:a50:d583:0:b0:574:ecf3:f7d1 with SMTP id 4fb4d7f45d1cf-5752b2faab1mr8465895a12.0.1716285897848;
        Tue, 21 May 2024 03:04:57 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57827ae3172sm11802a12.33.2024.05.21.03.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 03:04:57 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 21 May 2024 12:04:55 +0200
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf 2/5] bpf: remove unnecessary rcu_read_{lock,unlock}()
 in multi-uprobe attach logic
Message-ID: <Zkxxx065g7Kg0Vl2@krava>
References: <20240520234720.1748918-1-andrii@kernel.org>
 <20240520234720.1748918-3-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520234720.1748918-3-andrii@kernel.org>

On Mon, May 20, 2024 at 04:47:17PM -0700, Andrii Nakryiko wrote:
> get_pid_task() internally already calls rcu_read_lock() and
> rcu_read_unlock(), so there is no point to do this one extra time.
> 
> This is a drive-by improvements and has no correctness implications.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  kernel/trace/bpf_trace.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 1baaeb9ca205..6249dac61701 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -3423,9 +3423,7 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
>  	}
>  
>  	if (pid) {
> -		rcu_read_lock();
>  		task = get_pid_task(find_vpid(pid), PIDTYPE_TGID);
> -		rcu_read_unlock();
>  		if (!task) {
>  			err = -ESRCH;
>  			goto error_path_put;
> -- 
> 2.43.0
> 
> 

