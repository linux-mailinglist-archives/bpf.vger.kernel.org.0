Return-Path: <bpf+bounces-58073-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E05DAB481B
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 02:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA4A38C3E54
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 00:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA5A290F;
	Tue, 13 May 2025 00:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0IKT0Cn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9381380
	for <bpf@vger.kernel.org>; Tue, 13 May 2025 00:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747094669; cv=none; b=IElKggaDCFvb8jrWM31NgrVBrLjECq7jzLtRjbpyYmvVLsRnV43U3nvmYBLJb00aSsSmDOd3o5K5ScDXWcnq5reGOOgt1PlbfxdFakugtordlOSzzgmLW2JPne05V18imZ1cUBtWeHvFIkREw430pMpLOAg4GChUz/55uYipq1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747094669; c=relaxed/simple;
	bh=kA6tFUWKtOoupAh7psLUfg6TM3aVCwV0UdZukmSwXog=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Epn6WIgKisAauAxtBJJ1sGGIj38mB+fPnI4mQR4ryjTUNWd4/GC1bUhpA5QHjtoQD4pfc+ey/ILm98SebMIy8tsUAQ2g69PTYaR+CByDd+S7ByNefCiOu+9+oMXt7J/AaqrpE2QzD7Z0sztlkHBa+wAhEuza/cQmjopIfynxzkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0IKT0Cn; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22fb6eda241so52014775ad.1
        for <bpf@vger.kernel.org>; Mon, 12 May 2025 17:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747094667; x=1747699467; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ej6ZEsB96ttWvCLNsxcJlCCafTLXUhIm23likenQ08w=;
        b=H0IKT0Cn6er14mVrxxEY0WE/OLKCX8YiLJwWKzW/qivyP4L0GnbOdA5erWKqFmVTcL
         O6MAd/P2zKDD7Vf4ZLz4ECyEzNf4mD3p56YOTuQm21kTzazU8WxSYQEVkyU9HjM9xHfL
         3/cG6LoIrgSZvZa/1ABWmdHzULa+chpSPEeGaNGKB/aNxVTkD3+dRZ033WwwsPVDhOE5
         bjNg7Ng9s74GhV0h6m8pduOHqgqVY3I8ewcZ5LSs6MzwcP+Qljzzx47zFsDZgmNXp+zk
         20IweIew66wRXRRZcylIHTU3SsJssqiPHntrNqf07iPg7VcdveKTvkKQzoC58YSReB2z
         KGkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747094667; x=1747699467;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ej6ZEsB96ttWvCLNsxcJlCCafTLXUhIm23likenQ08w=;
        b=WpgF2v93p8NmC0CXANBf7efaHESxDqwDKIwoaY/8IWYwy8lyk0ROq0ZECjLf5kesK8
         2VZD6zh77DhqT5IFxxgMhl0eMwpGARRCyxE6JDx13mFfX+mFEh+fZXO5SJ4u90o9PIRc
         Wnhu84O3iz3Gyz7o8HD/mE2RJdeVoLoxkHExK6t21pLI2swRA8EN9eFnEH1x09N6byLK
         xwA1VtHdOHE7mcqz4zCW9F1yoXtbF+lj94oajL5DiUXelMaQXcwOf8pyfFKZMCM7Kql4
         X7/4HYMRAdMR94q9KZTLgtYSNrcDEEEeNItqu1h4tgsaYr8FzHMNLEqYvMWUOzzK97df
         h3og==
X-Gm-Message-State: AOJu0YwrJfMs5RD4AZyrzsR/xBbMh2OV84WU5BD8VZFc1sMHks7KEf1x
	1k/TBNDxO7tYYIfFV8f8bM+AABokCQvWax6fNdlGumjnXi0B/bTr
X-Gm-Gg: ASbGncuMwQB2oGuT9oMhiounQw/bbQdXVZLgYi68oDjUSsEpKXXCjARHKknT+kRhGe+
	dNrgNJsGKmUmbY7RUfUNJYD5InJiXfmAn34JZMytebbcQzfPbq6TVXa1Ei4NGkeD9FZbJLQqXfS
	qup0hfHCuVaW5S3nBYWJSuAfzDQwoSU9oCJbq5PkYKzh0uoQkLCISf0Xb2W78sOWsdpcCi1WV+b
	PzNKGlC5pIHWicPS9XgEtpHGDSvf7kf8iZEATpButsVeiPd4C2Mw9Km+CxTBpBQDqNHFsMxMT/r
	1JjkipbwcUs6it0DePJd95s/cegUIaFkMQuR8ESgN7+4ixxp/hh893mPl1w=
X-Google-Smtp-Source: AGHT+IGM7hzcSZGuGiyS754Vn+i88sOY1PcM8eVe031EQnpOKEmoJeO797qi9ib1Jc8u38STDpahMw==
X-Received: by 2002:a17:903:32c2:b0:224:376:7a21 with SMTP id d9443c01a7336-22fc91aec84mr196347475ad.42.1747094666960;
        Mon, 12 May 2025 17:04:26 -0700 (PDT)
Received: from ezingerman-mba ([2620:10d:c090:500::6:10d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc7742d3csm69290705ad.74.2025.05.12.17.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 17:04:26 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Raj Sahu <rjsu26@gmail.com>
Cc: bpf@vger.kernel.org,  ast@kernel.org,  daniel@iogearbox.net,
  andrii@kernel.org,  martin.lau@linux.dev,  song@kernel.org,
  yonghong.song@linux.dev,  john.fastabend@gmail.com,  kpsingh@kernel.org,
  sdf@fomichev.me,  haoluo@google.com,  jolsa@kernel.org,  djwillia@vt.edu,
  miloc@vt.edu,  ericts@vt.edu,  rahult@vt.edu,  doniaghazy@vt.edu,
  quanzhif@vt.edu,  jinghao7@illinois.edu,  sidchintamaneni@gmail.com,
  memxor@gmail.com,  sidchintamaneni <sidchintamaneni@vt.edu>
Subject: Re: [RFC bpf-next 1/4] bpf: Introduce new structs and struct fields
In-Reply-To: <20250420105524.2115690-2-rjsu26@gmail.com> (Raj Sahu's message
	of "Sun, 20 Apr 2025 06:55:19 -0400")
References: <20250420105524.2115690-1-rjsu26@gmail.com>
	<20250420105524.2115690-2-rjsu26@gmail.com>
Date: Mon, 12 May 2025 17:04:22 -0700
Message-ID: <m2msbh1im1.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Raj Sahu <rjsu26@gmail.com> writes:

Hi Raj,

Sorry for delayed response, finally got to read through this series.
Please find a few comments below and in patch #3.
I understand that things are in an incomplete state atm.

[...]

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index ba6b6118cf50..27dcf59f4445 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c

[...]

> @@ -135,6 +160,16 @@ struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int size, gfp_t gfp_extra_flag
>  	mutex_init(&fp->aux->dst_mutex);
>  
>  	return fp;
> +
> +free_per_cpu_state:
> +	kfree(termination_states->per_cpu_state);
> +free_bpf_termination_states:
> +	kfree(termination_states);
> +free_bpf_struct_ptr_alloc:

Nit: In verifier code base such exit labels are usually collapsed as one,
     as free() functions can handle NULL arguments.

> +	free_percpu(fp->active);
> +	vfree(fp);
> +	kfree(aux);
> +	return NULL;
>  }
>  
>  struct bpf_prog *bpf_prog_alloc(unsigned int size, gfp_t gfp_extra_flags)
> @@ -282,6 +317,13 @@ void __bpf_prog_free(struct bpf_prog *fp)
>  		kfree(fp->aux->poke_tab);
>  		kfree(fp->aux);
>  	}
> +
> +	if (fp->termination_states) {
> +		kfree(fp->termination_states->pre_execution_state);
> +		kfree(fp->termination_states->per_cpu_state);
> +		kfree(fp->termination_states);
> +	}
> +

Does this need special handling in core.c:bpf_prog_realloc ?
Also, is it possible to use alloc_percpu_gfp()/free_percpu() functions
for these fields?

>  	free_percpu(fp->stats);
>  	free_percpu(fp->active);
>  	vfree(fp);

