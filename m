Return-Path: <bpf+bounces-54288-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AD8A66FC7
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 10:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91C7B7AB6C9
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 09:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF76C207651;
	Tue, 18 Mar 2025 09:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awoEb9+k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92701F7076;
	Tue, 18 Mar 2025 09:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742290149; cv=none; b=sX+8mvIkz/fod+Eqpu91ZjfxTKpqf+6DsAEVpwmi9WGOUbX5i++bD58v7tvoP6WOA4FNMMi0nUeSHcDiuKUn3/aq+9KB+WOH8Npth5XdQuJyGEj+8qAoQQCRCcx91KjiVXoznEUGSPD/M/QQVgYBOMyPpcxGgxUfYD3Kz5XyCJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742290149; c=relaxed/simple;
	bh=2qBjmznq1yxclhNc22321OIhP8JBIRyHVbCr37RtpJ8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+QDN6hoWPVA1jzDNT/vXvYTOANqhP6vjJuU1Ym5RLkcrV4xDf6N+rvQh8UgAWC5GsPWWgXZXq4hj0MTJXidytRxa206fEpCeNljftJw2c0IvKvG03hikv9SkQT7zujvOu6yJ2meNfwhN6Nk7Ze9qrjrf3Yo205eIGipfhf59B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awoEb9+k; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-abf3d64849dso886261666b.3;
        Tue, 18 Mar 2025 02:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742290142; x=1742894942; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CfYRUaR8TFfRTdNpizQImMSrpAxBqbpJU5vBwCxwKsI=;
        b=awoEb9+kCJtPjVqffk4sE1ygdgiCdnqEBYzgOgObOaXgtqjN//r5D7VJTOUwqIzNbg
         KHGsae8W3RwgSZY7Dg2cRLSBZ3LEVEWr6RVEHTaFLxJdgEANiJ6QG4ArjUzXM5Vdm50P
         Gn+DRergee5gpZsPY2TopKZ0eMM0mQdEHEz0J5kiZeo5Q0GyZ883XMBTtOwx95nwlMzD
         T2GVliS4oG2HLhpDBmBNaIBzp53QAXll2x8GQdX2/SSh0L5yy/o/pq2K5wUpC2lHS3cw
         DDj3ejxxnaFWClSjXv59y8nh68Q6H8SuLN6vmL2XePyvSuSxUgsm2fmMcPJxsyDRuTzf
         WTiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742290142; x=1742894942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CfYRUaR8TFfRTdNpizQImMSrpAxBqbpJU5vBwCxwKsI=;
        b=CA3oZsTE146sDu8p0O/ZMZU9RZojtSIScWGep6CLIMMnSoIUFMGaiUcL3ibQgzzYxM
         8dQXgNPcXnPxm2z/CT59DVFVJBGemQcgZVBuxC3IkMuorq1iitbsW6Grhu0971IZCHKV
         GKI+CwVkwXmxWstgG2T5X81g2lAxah7jTuH29s78YS5W/PibbhJ4ymZkAEfgmUAYeTml
         3ofsD2v5Flmc8+US7yKyM1ZE/VF+HH1E6V7+utrYtyTg7L51WZkYx9kFoxOnrR6pe0WM
         TEEQ0ZRj/BILQCOTm5fIXbJKKydyyTu7C0HeTwKPF3UYJS++bciJcvtc5tHBOWyoCtPW
         nwMg==
X-Forwarded-Encrypted: i=1; AJvYcCWAv3WpEId+xIQUD1bq5WbRWXB3Hi+BqxhhkYqO7qEwtLnjnpVsREqadNsskhjhMMbvXJU=@vger.kernel.org, AJvYcCWS3RGdLOhvhzC+GsDBhNTs4WI+ZiaGBKq+DawPpgCuyWOlQeC8l1c2xxvV4r9aPs6fLM3ajKKpd5eCMO8H@vger.kernel.org
X-Gm-Message-State: AOJu0YyNnuccbrMU1NnNyS+lNCsdy4iDw/iUipIdZBAeXlk+B8H5BJnN
	YnyIInBRXB6AnovItSLMFcStryBNhsI29josEvPyVxO6CDLV4OtV
X-Gm-Gg: ASbGncurdGwDQ0TdGG0l6h7uKB/r85QG4/FcIjh9Bv8lo5u2fy4lIt4ACVRNK8qNttc
	3FhDLldNqxTVpg4O/9pZGLKdFoI7sac2e2wpqmE2c40UqmsLclQd88zktFhwj5MUVgovu9sE30k
	at9I4ab/KwbqumEVPJCBuB6KGz10jtfxPtDOY8DSpvna0JxamqsnQS7du1b2hBldoPLF2f6ySZT
	YjP3saFawEQvmzBRtEYVuZenPES2rFsWV1aTDflSe6JRf3JrOzRsS2/KiKwTDtRnUPms5XaIHKW
	97urMQcXKgN6AD0zQPRi7DxN7WcRCPE=
X-Google-Smtp-Source: AGHT+IFFCFRv+mprZJcwv9+fjSIo6wAeuo7BlVvF4Ez6bzS6MoVGAbFfEgNnkTcYKdxeoiGWxCbjjw==
X-Received: by 2002:a17:907:d92:b0:ac1:e444:f063 with SMTP id a640c23a62f3a-ac330267225mr1621030866b.14.1742290141802;
        Tue, 18 Mar 2025 02:29:01 -0700 (PDT)
Received: from krava ([173.38.220.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147e9166sm822096166b.56.2025.03.18.02.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 02:29:01 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 18 Mar 2025 10:28:59 +0100
To: Tao Chen <chen.dylane@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	brauner@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf: Define bpf_token_show_fdinfo with
 CONFIG_PROC_FS
Message-ID: <Z9k8216IwpMZnHaA@krava>
References: <20250318062557.3001333-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318062557.3001333-1-chen.dylane@linux.dev>

On Tue, Mar 18, 2025 at 02:25:57PM +0800, Tao Chen wrote:
> Protect bpf_token_show_fdinfo with CONFIG_PROC_FS check, follow the
> pattern used with other *_show_fdinfo functions.
> 
> Fixes: 35f96de04127 ("bpf: Introduce BPF token object")
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  kernel/bpf/token.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
> index 26057aa13..104ca37e9 100644
> --- a/kernel/bpf/token.c
> +++ b/kernel/bpf/token.c
> @@ -65,6 +65,7 @@ static int bpf_token_release(struct inode *inode, struct file *filp)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PROC_FS
>  static void bpf_token_show_fdinfo(struct seq_file *m, struct file *filp)
>  {
>  	struct bpf_token *token = filp->private_data;
> @@ -98,6 +99,7 @@ static void bpf_token_show_fdinfo(struct seq_file *m, struct file *filp)
>  	else
>  		seq_printf(m, "allowed_attachs:\t0x%llx\n", token->allowed_attachs);
>  }
> +#endif
>  
>  #define BPF_TOKEN_INODE_NAME "bpf-token"
>  
> @@ -105,7 +107,9 @@ static const struct inode_operations bpf_token_iops = { };
>  
>  static const struct file_operations bpf_token_fops = {
>  	.release	= bpf_token_release,
> +#ifdef CONFIG_PROC_FS
>  	.show_fdinfo	= bpf_token_show_fdinfo,
> +#endif

there's many more of such cases.. I'm not sure if it makes sense to fix that,
because it does not break the build and only save space for !CONFIG_PROC_FS
kernels

jirka


>  };
>  
>  int bpf_token_create(union bpf_attr *attr)
> -- 
> 2.43.0
> 

