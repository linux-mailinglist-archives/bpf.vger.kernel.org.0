Return-Path: <bpf+bounces-26290-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8069E89DB4D
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 15:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED92D1F215AF
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 13:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715991369AD;
	Tue,  9 Apr 2024 13:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEvSu4ju"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D5813541E
	for <bpf@vger.kernel.org>; Tue,  9 Apr 2024 13:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712670631; cv=none; b=VF5HLp5isgHyR/dWCqEpQ0TzAgW4NFy3bn6NsGOh0IK+GEJvtmAOt31PzRVOBY2zROwR9hDNK3okWM8vm2U/cHlpG9jSuOLLHRY257wGXPR9+aSrc3k/OmH2Lr3iSzfoUF0Keug/wykyr6fH46kYXqAe+AzpM8n1IxaYfyN4Uh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712670631; c=relaxed/simple;
	bh=XAe3YHuCp1MxLfpbBVvys1tP167PIp2vU5KOYemC4Zk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=saEA9uBLNU51WYjNihA3JAfCefDe7xLJ+hJe6F1wDZVd3QXgKHVMGOw3x0EujKlE1n9dEXBIBaCrMo7LjXIxwPEdXsmWmsfuYlorhVLohzjCrT7Wq/WyeMLkdwDelGnOAy1LFRc5d+l8v/HtyRwiIRzeSmyzPyXH7COsnBRL0xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bEvSu4ju; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4169d7943bcso8192465e9.0
        for <bpf@vger.kernel.org>; Tue, 09 Apr 2024 06:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712670627; x=1713275427; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vmyLlWsdutqt1BZIogQfnDJk4OUDWneV/VxFKQTFwxI=;
        b=bEvSu4juglqIUfRKIWtCXPCLhTnM0kqkckma56IKB56DrTJBL2i/glmTQzb43dhfzB
         8RdBHThJgFexAatEKojgzk3FeKEXBhuoWLdnONlPqRDJvUrHMvURa5A1ITQtUkeUr1MW
         pL2QrStP83KfPQ/WIloSwQxP2sg1cQPeIo7NJj48mg/CTiT4klb6mCCGDzujvtXPTW5I
         FyXYdbsMhEgp1F+aVeXaFhpR7uRZVXbqmJ/WFvx63QCKSbOf02dqSvUhF4OTMlDgv9fG
         T5DIfRK2lAjrOSzEo7L+R75AjYQxKzIWWAppe6gzK6sj+4hsQIOBaahEw+hUwWfvqDS6
         Lp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712670627; x=1713275427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vmyLlWsdutqt1BZIogQfnDJk4OUDWneV/VxFKQTFwxI=;
        b=UcDtBGEY+wwAuDT9o8YAVItfgV+eAIHnXZprsIvHgqPxteo2tn6yUQQIZ0bSh6Q8+d
         7RxshMP2Z064gLKFZTOgeRhEZtf9VY1Rq/XS08fzdfNsi8NoVUUfMfovOgo2E1GLRLnO
         bVGTgGvfdiM3Jz/YYEp+BjZE+8s+0aS2CVjnF28ou3G0RawJ6qIUe7JiNouVAvF3EeRv
         Q7JHC0VptI13VKrmyht2q0Rjsfd6aO0Q9ljoAkhOSwg3j+uAFJ/24Lf1G5VG6RZJ+8IN
         yWjQ1Snha9AlUZnBvPSsCxHX9UlXgTZM4yzH3a2n93tvfScczzx6qxNJg1AFr75tvFLt
         6pYA==
X-Gm-Message-State: AOJu0YyHi7MC5g1jsvoxzmEvCT+1aPB4Ugq9r4WZtJkZWLiHty5Ft8iA
	W9AwsQydqOJva07uh7I5XZXnSHH4Q9JaXksLJnfm4+vY4T9zMv1B
X-Google-Smtp-Source: AGHT+IFcJoFMGjD1AM+ZtMiXZEsBWnFgzUIQ2Yv3Fg/e7XubJ3/ItKdu2W97K8ofu1dSGalu/vrHeg==
X-Received: by 2002:a05:600c:138a:b0:415:52df:4db1 with SMTP id u10-20020a05600c138a00b0041552df4db1mr11329113wmf.7.1712670627382;
        Tue, 09 Apr 2024 06:50:27 -0700 (PDT)
Received: from krava ([2a02:168:f656:0:bbb9:17bc:93d7:223])
        by smtp.gmail.com with ESMTPSA id bg8-20020a05600c3c8800b00414807ef8dfsm17389935wmb.5.2024.04.09.06.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 06:50:27 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 9 Apr 2024 15:50:24 +0200
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Add read_trace_pipe_iter function
Message-ID: <ZhVHoEkQUS0TCbyl@krava>
References: <20240409123601.1592655-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409123601.1592655-1-jolsa@kernel.org>

On Tue, Apr 09, 2024 at 02:36:01PM +0200, Jiri Olsa wrote:

SNIP

> +int read_trace_pipe_iter(void (*cb)(const char *str, void *data), void *data, int iter)
> +{
> +	char *buf = NULL;
> +	FILE *fp = NULL;
> +	size_t buflen;
> +
> +	if (access(TRACEFS_PIPE, F_OK) == 0)
> +		fp = fopen(TRACEFS_PIPE, "r");
> +	else
> +		fp = fopen(DEBUGFS_PIPE, "r");
> +	if (!fp)
> +		return -1;
> +
> +	 /* We do not want to wait forever when iter is specified. */
> +	if (iter)
> +		fcntl(fileno(fp), F_SETFL, O_NONBLOCK);
> +
> +	while (getline(&buf, &buflen, fp) >= 0 || errno == EAGAIN) {
> +		cb(buf, data);
> +		if (iter && !(--iter))
> +			break;
> +	}

hm, using this in some other changes shows that the original code
is not completely right and we need this change as well:

+       while ((n = getline(&buf, &buflen, fp) >= 0) || errno == EAGAIN) {
+               if (n > 0)
+                       cb(buf, data);

I'll send new version

jirka

> +
> +	free(buf);
> +	if (fp)
> +		fclose(fp);
> +	return 0;
> +}
> +
> +static void trace_pipe_cb(const char *str, void *data)
> +{
> +	printf("%s", str);
> +}
> +
> +void read_trace_pipe(void)
> +{
> +	read_trace_pipe_iter(trace_pipe_cb, NULL, 0);
> +}
> diff --git a/tools/testing/selftests/bpf/trace_helpers.h b/tools/testing/selftests/bpf/trace_helpers.h
> index d1ed71789049..2ce873c9f9aa 100644
> --- a/tools/testing/selftests/bpf/trace_helpers.h
> +++ b/tools/testing/selftests/bpf/trace_helpers.h
> @@ -33,6 +33,8 @@ struct ksym *search_kallsyms_custom_local(struct ksyms *ksyms, const void *p1,
>  int kallsyms_find(const char *sym, unsigned long long *addr);
>  
>  void read_trace_pipe(void);
> +int read_trace_pipe_iter(void (*cb)(const char *str, void *data),
> +			 void *data, int iter);
>  
>  ssize_t get_uprobe_offset(const void *addr);
>  ssize_t get_rel_offset(uintptr_t addr);
> -- 
> 2.44.0
> 

