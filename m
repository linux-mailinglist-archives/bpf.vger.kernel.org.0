Return-Path: <bpf+bounces-20332-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A854C83C629
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 16:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EEAD1F21CDA
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 15:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD7573160;
	Thu, 25 Jan 2024 15:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VX3axazP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B976E2C9;
	Thu, 25 Jan 2024 15:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706195517; cv=none; b=HBhaIxKFvaZGLigIF8sb/wyBa6zwECbSDMGhCzWHMVKqDnqg9Vj+IgcZ6FbbiHf4wcqaa/oHDed3kMX9z+N7Zd1Gz7cflQMUvbaOBHouTaeoD3SHEAyAYxNOH51E42dr+nH9TfNpiLBqxb0W1VP4E1S9aMcnqoUBb5xAlnv5a2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706195517; c=relaxed/simple;
	bh=mzMOuqXTq4zCUMMK/K2C/+HNWBvw8RALwJlnW72830A=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ShZal1LwVHp5r67a0WRZRLd2b3Milmq6YDlNAAOUViAN35H6n24oNSDZGPmtw6pzoUH+ahsmHmWU2Wi2t6G2jFiIIfj3D6uouPFDPqYb4IfIWawEf/roUq9p2QooFuxF3A4OFVKFH5acOLh4nRiDlVwgFVIf7agdO2c1lrfzuEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VX3axazP; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e7065b692so73641005e9.3;
        Thu, 25 Jan 2024 07:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706195514; x=1706800314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GUvl1REbEUd6BLP3pDMwPlzTx9j7ZW9jZ3MWQ9/tcz0=;
        b=VX3axazPlyFUmYuDEEkw+xtrxFIkiqdSPAYHeVXGUhBz48ECULgjDf40aSif9EIixL
         ISgJ3kl3JCnH2jgZ8oOpfBSWpkujV2VTF0TwecOtgX++3rS901YnV/FACx60xRgnu23T
         7F3RL1/j3lwDrY5mTx+UbvtK3RJeO3eN6+23uhgWyc1HIUG7+hKv7Vcip7+0ySVhdRQH
         qHhPM8lboD8wzdTLY8+WGwkbJoZE77sqyDTCu5suXezPTX44ZaZ2XapcxbNXMa1oz1l4
         ShMawQQZWeQmyJGIakegnftMWHK/zlMiLIcnHfpQciSIypHgToMNPP/neXkWVg5jq6cx
         VHtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706195514; x=1706800314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GUvl1REbEUd6BLP3pDMwPlzTx9j7ZW9jZ3MWQ9/tcz0=;
        b=d7J4jq+1aj3N8gO8h8ZXvyCYE9EsB1YBQ1UkmeKTLCx29ZclSamsfA3/fwHAkUBZs+
         cv9Hwz4I0fa/7aSD8wLlb6T4GoHOIjDKfnyfXSA5Ea7k60E6i4f5Mdk883yRSyJ0ta9a
         u/cNpsvM+G4D/1Vh7DTre1jLytEjaWFH7PQHfDNb6NVfIDEPMHxLWinXvNh6HC4fN9V9
         zzH3FcoDZwp9btetdlPNKUxu7aS/svetbLgkrpIhKHtj+7G4/Ug3FCMJgeos8YYjaAhZ
         4oi1A1OIaZpwOFiVVWNJubV/tumkTQIc4IHPTzkPge7gWRgq4cT++ivWYYtzOm/W/edV
         xRqQ==
X-Gm-Message-State: AOJu0YwUhNsXf+Wxa364hiUDMYgSW7JsLk9FA3q6xI8Fl9nrKvEs0dMh
	7dDXJlqtPHXM9LuRdVQtxqO3MTCdRNdgYzWInoezEnVYbE6YRmlE
X-Google-Smtp-Source: AGHT+IGLT7Hf2eaNt5e2aNLHGjHeIelPf8TJtASTb4bi2ksEIb1W7zTEDnc6u5Ree+0Xvs/4dFCvew==
X-Received: by 2002:a05:600c:1396:b0:40e:7e28:e5c8 with SMTP id u22-20020a05600c139600b0040e7e28e5c8mr605036wmf.6.1706195514252;
        Thu, 25 Jan 2024 07:11:54 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a17-20020a5d5091000000b003392d3dcf6dsm12011392wrt.0.2024.01.25.07.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 07:11:53 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 25 Jan 2024 16:11:51 +0100
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Florent Revest <revest@chromium.org>,
	linux-trace-kernel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alan Maguire <alan.maguire@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v6 32/36] fprobe: Rewrite fprobe on function-graph tracer
Message-ID: <ZbJ6NxkjWEP5adru@krava>
References: <170505424954.459169.10630626365737237288.stgit@devnote2>
 <170505462606.459169.1375700979988728260.stgit@devnote2>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170505462606.459169.1375700979988728260.stgit@devnote2>

On Fri, Jan 12, 2024 at 07:17:06PM +0900, Masami Hiramatsu (Google) wrote:

SNIP

>   * Register @fp to ftrace for enabling the probe on the address given by @addrs.
> @@ -298,23 +547,27 @@ EXPORT_SYMBOL_GPL(register_fprobe);
>   */
>  int register_fprobe_ips(struct fprobe *fp, unsigned long *addrs, int num)
>  {
> -	int ret;
> -
> -	if (!fp || !addrs || num <= 0)
> -		return -EINVAL;
> -
> -	fprobe_init(fp);
> +	struct fprobe_hlist *hlist_array;
> +	int ret, i;
>  
> -	ret = ftrace_set_filter_ips(&fp->ops, addrs, num, 0, 0);
> +	ret = fprobe_init(fp, addrs, num);
>  	if (ret)
>  		return ret;
>  
> -	ret = fprobe_init_rethook(fp, num);
> -	if (!ret)
> -		ret = register_ftrace_function(&fp->ops);
> +	mutex_lock(&fprobe_mutex);
> +
> +	hlist_array = fp->hlist_array;
> +	ret = fprobe_graph_add_ips(addrs, num);

so fprobe_graph_add_ips registers the ftrace_ops and actually starts
the tracing.. and in the code below we prepare fprobe data that is
checked in the ftrace_ops callback.. should we do this this earlier
before calling fprobe_graph_add_ips/register_ftrace_graph?

jirka

> +	if (!ret) {
> +		add_fprobe_hash(fp);
> +		for (i = 0; i < hlist_array->size; i++)
> +			insert_fprobe_node(&hlist_array->array[i]);
> +	}
> +	mutex_unlock(&fprobe_mutex);
>  
>  	if (ret)
>  		fprobe_fail_cleanup(fp);
> +
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(register_fprobe_ips);
> @@ -352,14 +605,13 @@ EXPORT_SYMBOL_GPL(register_fprobe_syms);

SNIP

