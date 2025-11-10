Return-Path: <bpf+bounces-74109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE4FC49A43
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 23:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 387994EFE6E
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 22:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D352F0C7C;
	Mon, 10 Nov 2025 22:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mI11pCJO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7975C23E320
	for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 22:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762814479; cv=none; b=p7QzvG2cnALI5qgGh6kKtwjv+AnB2lfNLOZVpYOz1ueWWM1Jvgfibn5LqlM5k18rfMXw0MuUDFZnKSN5V30BaT0eyB4GpF3kJw7+RhrzHa1DlnnbODj548RfJJ9UZ/z5DlywV8FszHdkQ9o3A6qHz4ZevYgAZ+APi7WZKhRA6wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762814479; c=relaxed/simple;
	bh=okNOORu/lmN5UNbsZPnsNSLoAA0dk4lTm7t688EICLU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTOqOrwKt3AgX17smEdAXgIVkM31JC2K03XszyJmtnEwSSqRu3x2Eh280h0GQqmh/a0hUV5liNoTQ9Jn34LvpIHrymVvo7z3dKB2STzy9n3XMiTyR2uuR1YOAhbZkc0aqwSvs7wuAO4ZGL2jLqP1T2r78ijOfjI8Z28f7yUvCq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mI11pCJO; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64088c6b309so5646225a12.0
        for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 14:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762814476; x=1763419276; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hy3DRtjQseWH8sSySHjHEiCHuYld/nXxCZdq01rPWwQ=;
        b=mI11pCJOXZWW2p/wPWf+tBiAF4qxoV3mNy4+tXHlw0upNIqm7KVCA0OmXZB2LUBkXm
         rzt6XTqtIjmSZe0ja1/JKOxYLdytUZDXeWigVvkaSU7+RFbx4RJsbOi0J3V9/h7L6r8V
         dKNZAukz28sOxzL4OcEowGt8BHk34dSEi2lXACTlRg4FOsjO+pbsLshyyfEfAGvp4gQt
         jzqAyZf74wxbTKTY+Hv2sbYg97Njubyh+GtCCSA8RyBW+x5/5Tv6u0mI5RXCiPQSlWfM
         n36g9oAjkL/eu0ju3/tnh69vSjKZFnJnJe3M2uc07IKbkj+Z59q1dL6rI93EuWjigF/y
         t0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762814476; x=1763419276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hy3DRtjQseWH8sSySHjHEiCHuYld/nXxCZdq01rPWwQ=;
        b=LulzDA+EV8AwNKXCZRL8xt6zvugwNH/JqTU49u8RVmk8gR3CXvgJ36507SPGGVsOzr
         DWWzVvtqTQPn/uawVjcbLp10Yjg1XiBshaAj+gQUjv2VF/ebUwqAB2SRIXmeTTDACLyB
         OhW2k6PG+L0ilWlveFpVkvlLnahpcZppYL9vNIT/DmyzzBG6pGeXJXBtVxL8KihAk75v
         4hzP0Rr0KoW7HuGp9Ca3Z8x1zxmLDzuDmbRfumjfLxxiXr+YHz30o6TIn70eHM5trPYA
         Si6Ifh7jCyT7Zsoft36wkUPnFCu8oDs6SXdJzwds/AIz6G7s2hSRwkovMnrfG4bkqXKY
         2f9w==
X-Forwarded-Encrypted: i=1; AJvYcCVWorDKVZrDQGMKALOmisl/mCWAk/0LI2mJ2bockvs6pzfjaMqHeGG/wBmvKV2oeUCqRCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsFDQBSOPqEBdW5PtMFHz4l1hDBe7D4bZF34XWmx/YgfJUc0YP
	N8af4EFshCWatkPtLyC0pX6HZHSzg130s7GGdxAGkAhYPEHle2CyO2+0
X-Gm-Gg: ASbGnctsftSINcWm7v0Iq1emb3b+FTEnLnhK0YCDIFJjFl0fvHL/pqzVTVe3xpOePDx
	CkvyohJyvc2YdPFOg/pe7u4VYpU21KM2m0TJqOWDWx1yy6avj/d8UdtXh1+ijvwHA8lmsSXwN7c
	bzUXy/0b8jSoda4uyQH9IpQqQLO7G1Ci3YNtGetf6DzVTWNsOTPYoJf0t8VYR7p402yNqhG2ptz
	TtaAGRKYB3m6K/8+qkeb/8DK3khf0sGW0T2MqUykjZlZPXnIJ/xOqlYA56ZD0XRQhMIxq7BclgJ
	obl3+jpy2Dh1PJutHo9A4hjdt20Uo7s2DVlNbxBzG9bSZqZ7AiKI4J7/NXTu2XCejZDXdDA5JCz
	W18qk6MzlRp/W76cpdwUrBG61872FuqWs11am4JP5HDtfjGnC40R089IBXUJwRAtpfbFxSWAnYE
	ykIsIynIm3J8l9
X-Google-Smtp-Source: AGHT+IEdCNnJArmT88Dy24wvZrQSZRRx6rM0pDkfV8nrA7AwoMe17Vp9sJfSj0pDcqFVKzMMqcvg5A==
X-Received: by 2002:a17:907:3e08:b0:b72:5a54:1720 with SMTP id a640c23a62f3a-b72e058f3acmr1065004666b.57.1762814475569;
        Mon, 10 Nov 2025 14:41:15 -0800 (PST)
Received: from krava (37-188-233-172.red.o2.cz. [37.188.233.172])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf9bd72bsm1199771366b.49.2025.11.10.14.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 14:41:15 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 10 Nov 2025 23:41:10 +0100
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: rostedt@goodmis.org, jolsa@redhat.com, mhiramat@kernel.org,
	mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
	jiang.biao@linux.dev, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] ftrace: avoid redundant initialization in
 register_ftrace_direct
Message-ID: <aRJqBkYtMAhhO1yQ@krava>
References: <20251110121808.1559240-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110121808.1559240-1-dongml2@chinatelecom.cn>

On Mon, Nov 10, 2025 at 08:18:08PM +0800, Menglong Dong wrote:
> The FTRACE_OPS_FL_INITIALIZED flag is cleared in register_ftrace_direct,
> which can make it initialized by ftrace_ops_init() even if it is already
> initialized. It seems that there is no big deal here, but let's still fix
> it.

good catch

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka


> 
> Fixes: f64dd4627ec6 ("ftrace: Add multi direct register/unregister interface")
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  kernel/trace/ftrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 42bd2ba68a82..efb5ce32298f 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -6043,7 +6043,7 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
>  	new_hash = NULL;
>  
>  	ops->func = call_direct_funcs;
> -	ops->flags = MULTI_FLAGS;
> +	ops->flags |= MULTI_FLAGS;
>  	ops->trampoline = FTRACE_REGS_ADDR;
>  	ops->direct_call = addr;
>  
> -- 
> 2.51.2
> 
> 

