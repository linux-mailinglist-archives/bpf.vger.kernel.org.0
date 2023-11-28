Return-Path: <bpf+bounces-16037-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F5D7FB8A2
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 11:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 909421C21360
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 10:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08044642C;
	Tue, 28 Nov 2023 10:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGAJf/G2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E965182;
	Tue, 28 Nov 2023 02:53:23 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40b399a6529so22920475e9.1;
        Tue, 28 Nov 2023 02:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701168802; x=1701773602; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jHeRUHjNgcHkAoNUOrB2gZOKHhIEPCIVSV2fuslJNro=;
        b=RGAJf/G2Po5XSEGRT1DGAbV0DxzhtijBRa98A6qAJyfQt5Qi3dDkbuAQIrV6omSjT+
         1Ee8kx3XiZM+F+FcR9WukkVfuXw/PqcUXnE7Pv7UhMGsqA7KDTV1F+owebyfNg/Diab4
         QkAPvirezS/iSOY0j287UDZydKjl3QJLwUd22AwMb3DMIlypBQc6yOJGrOWP99w/1qFO
         YTyiKRIXynoq1m0VSZM2mrieav6VH3RYGutWFoBVx+rRzp/2S0fSUS49GQB1qCInn+vd
         0OZ4TPGV8yO2ExylpPRSS/Vkih7jGTFL75UmGfYkgcERTX8RNPgbFxFw8Ow5ztfPklyu
         kroQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701168802; x=1701773602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jHeRUHjNgcHkAoNUOrB2gZOKHhIEPCIVSV2fuslJNro=;
        b=cw1wef+vFgRtZMmdtn89Mq4bJBWp40G/b0rCn/MlvavttB/k/kpf9KxXOL4eBmAjP2
         ajoXMpDPx3ScPS53kczsjsQqH7wsvwuW+aksXfdYT4cQKB/atRwVeNIBW8ipBPF/7FG3
         KNkxsuvyhUrC6+y+yaToM06pfpLK6JqtLlfLTQiwrmZ7N5I1+zyAJv259gLZs7Cyqb06
         +cmEAxtWKXEm57lxwSirB5iOMhFOYi+ufqTXKQWCuyGDq/8uhTi18AEzN5tlxKQr+2LK
         Ackom6pQeE6j+roaGixpuV2vVIn//7oy+EPgxCGzwkMvrRnM8lNo0ggA1eUNRXTXblKS
         I46Q==
X-Gm-Message-State: AOJu0YzssKV8T0N93CuQqkenzP9QKwJ7AhGAl+tdLrPbnuedmsDFDCOs
	2uS0zfCoT0R2JXPwm641Ito=
X-Google-Smtp-Source: AGHT+IHAtXvi+k2SNzavvcAHSEfDOl1eBAxYx48aeh6/aYmJAhtMVGM/zG7vKgoWiQ3XVkMolR/AzQ==
X-Received: by 2002:a5d:40cd:0:b0:333:224:48d with SMTP id b13-20020a5d40cd000000b003330224048dmr4670459wrq.33.1701168801641;
        Tue, 28 Nov 2023 02:53:21 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id d15-20020adff84f000000b00333097fc050sm2112498wrq.1.2023.11.28.02.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 02:53:21 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 28 Nov 2023 11:53:19 +0100
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
Subject: Re: [PATCH v3 28/33] fprobe: Rewrite fprobe on function-graph tracer
Message-ID: <ZWXGn3_5pN-0fniR@krava>
References: <170109317214.343914.4784420430328654397.stgit@devnote2>
 <170109352014.343914.17580314660854847955.stgit@devnote2>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170109352014.343914.17580314660854847955.stgit@devnote2>

On Mon, Nov 27, 2023 at 10:58:40PM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Rewrite fprobe implementation on function-graph tracer.
> Major API changes are:
>  -  'nr_maxactive' field is deprecated.
>  -  This depends on CONFIG_DYNAMIC_FTRACE_WITH_ARGS or
>     !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS, and
>     CONFIG_HAVE_FUNCTION_GRAPH_FREGS. So currently works only
>     on x86_64.
>  -  Currently the entry size is limited in 15 * sizeof(long).
>  -  If there is too many fprobe exit handler set on the same
>     function, it will fail to probe.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  Changes in v3:
>   - Update for new reserve_data/retrieve_data API.
>   - Fix internal push/pop on fgraph data logic so that it can
>     correctly save/restore the returning fprobes.

hi,
looks like this one conflicts with recent:

  4bbd93455659 kprobes: kretprobe scalability improvement

jirka

