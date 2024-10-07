Return-Path: <bpf+bounces-41096-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D3D9926BF
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 10:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4D5A1F236CB
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 08:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD06189910;
	Mon,  7 Oct 2024 08:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZTvOAEO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5603188703;
	Mon,  7 Oct 2024 08:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728288862; cv=none; b=je2vQKCFdVu1xDcrZdv9UlP4j1pS276Q0eOScVoc9K4kQhE7gYEzHrp3jVeXgXc6LiIMWIba4nPuLwKEFU+dmHA9etMlsdEPoIN5AxdItboIGPJVj+KLOE20CX7vcatDCVPyceRCZQ1OJVCD1zZ1rRbUuFxxXAjALugf9wUPEM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728288862; c=relaxed/simple;
	bh=0dHsn5AKt3+vrWVeXhxuAHt6CjDcnQ4CE77K4iwRzj4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qstgs0N3Br1UYAo25SmZcKBh5X/Jk8l6Thm0lbBdlTtpsHBKbkjqMemgfrbQdR6Rfx81B+K/iKAFZa2MTMRQ8QPT6JvXfDMPkiFV0OPv/q4MxoyZitpktLsDG5yqi+gyiLjylQk5tDJBMkQ5HWSyrjb4l6iAp4y5JX+SQbGWTmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZTvOAEO; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5398e33155fso5087897e87.3;
        Mon, 07 Oct 2024 01:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728288858; x=1728893658; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zP4DtY1rjF+iji3d8m0rUx3C0bdgECm6J3nu+9UeSvI=;
        b=kZTvOAEOo/BS056NR3vNlTk8D1yn0Py2phduNvWgWhaoZt9+fterkd5ohpMkgFTm8P
         DuW3vwYQPQD3EnN3TQPYCdcw7sG1fzVdB7ZXRhQ5HMKQJMg/Zdtr2LomFxDSvZJ6aCV3
         aRtpBg1UGMB+ZvEm3I0j0D3cBYuiXnF+Pv4FXF5+UbUqfDRQtKutC9HSNn94cEnymY+C
         0ufBlaK7kk4jxyx5q8VqYcbwz5VRNSguRVXZrriynUZ3pIMGKL1hlE/dg//jX8Ta0yDt
         6GVviKfeRHYbpGC9GBTJEnQTgXC7upwvesUHoIERIBhzcLe3jSkr7Ul0A4EfyUcl4Hrl
         guZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728288858; x=1728893658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zP4DtY1rjF+iji3d8m0rUx3C0bdgECm6J3nu+9UeSvI=;
        b=cbpEbgeuA0GZTNQ7oYoI+5CsPIHLGrn+p8KcgGPoQJNUf93b3z5pszm+FPFpe5QP5z
         2oi1Wtg83aZbLS+aX7NmK6f7rk6gF1ncPv5EavQ7Rul3WxaCRpf//41zIk9tDvpWmyq7
         uIJ38eE5sSJRJjGPzZ9V5iIjGMRKwermNdTX0DAgSw23R1ugYLmDgW4jfEQmswk4Wa0z
         IRts2fXCWBN80F1lcdXdoWSWVvcR+AdoWChS+MXQzSD4uaWeJ7cK8OUKx0tOEedgv+od
         rhybKfDl4HVAeosUr5Obrm/YzHiCyKUM3J2Ddl5oqYgvNqymo21il//wAVo3X7d/tGT/
         JmVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqDq/8hoqu7dh0BsDm3aWc8b5mDrgeKHjrGBlSN8DdCqykU5ZuIQSZCqQdA6+ZdyeYjxpOeJbvrQ==@vger.kernel.org, AJvYcCXjQs5hwmLrMiOfDcrTwg/kAqtnF0MPysw2X2xD+F82tqAQfboo1SwujScdCLJRCz3vLPVpoCd3yb7d4NdTqUqL@vger.kernel.org, AJvYcCXzXOeOEFQ/xvupu1/ifVF46yO1kx6od8Jn7IWoXjdfaZ4R404249douYZydm5JhMGdYu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS7s/LoFOIRRayBTsO4K/fMquGb//PsEJBIdoJ1riWRY4xXTlP
	6FQwyK4om/vYarrOa+d8162o4QBVdbNvyt6zypXAwBOIFxLtNkvX
X-Google-Smtp-Source: AGHT+IGCddJ9i2C9Vou+3D6SNluuZprw4xxzbYzIBdft66MpYGHjLuJHCVqeIP6EWR9ZZm5oAs3skg==
X-Received: by 2002:a05:6512:3b24:b0:536:73b5:d971 with SMTP id 2adb3069b0e04-539ab9e1953mr4844934e87.38.1728288857511;
        Mon, 07 Oct 2024 01:14:17 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99420bcc1esm258507666b.199.2024.10.07.01.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 01:14:17 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 7 Oct 2024 10:14:15 +0200
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, bpf@vger.kernel.org,
	dwarves@vger.kernel.org, linux-debuggers@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCH dwarves] btf_encoder: fix reversed condition for matching
 ELF section
Message-ID: <ZwOYV5HuGlezOFJR@krava>
References: <20241005000147.723515-1-stephen.s.brennan@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241005000147.723515-1-stephen.s.brennan@oracle.com>

On Fri, Oct 04, 2024 at 05:01:46PM -0700, Stephen Brennan wrote:
> We only want to consider PROGBITS and NOBITS. However, when refactoring
> this function for clarity, I managed to miss flip this condition. The
> result is fewer variables output, and bad section names used for the
> ones that are emitted.
> 
> Fixes: bf2eedb ("btf_encoder: Stop indexing symbols for VARs")
> 
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> ---
> 
> Hi Arnaldo,
> 
> This clearly slipped by me in my last small edit based on Alan's feedback, and I
> didn't run a full enough validation test after the last tweak since it was "just
> some small nits".
> 
> (His code review suggestion was not buggy... I introduced it as I shoddily
> redid his suggestion).
> 
> Sorry for the bug introduced at the last second - feel free to fold this into
> the commit or keep the commit as a monument to the bug :)
> 
> Thanks,
> Stephen
> 
>  btf_encoder.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

nice ;-) lgtm

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 201a48c..5954238 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -2137,8 +2137,8 @@ static size_t get_elf_section(struct btf_encoder *encoder, uint64_t addr)
>  	/* Start at index 1 to ignore initial SHT_NULL section */
>  	for (size_t i = 1; i < encoder->seccnt; i++) {
>  		/* Variables are only present in PROGBITS or NOBITS (.bss) */
> -		if (encoder->secinfo[i].type == SHT_PROGBITS ||
> -		    encoder->secinfo[i].type == SHT_NOBITS)
> +		if (!(encoder->secinfo[i].type == SHT_PROGBITS ||
> +		     encoder->secinfo[i].type == SHT_NOBITS))
>  			continue;
>  
>  		if (encoder->secinfo[i].addr <= addr &&
> -- 
> 2.43.5
> 
> 

