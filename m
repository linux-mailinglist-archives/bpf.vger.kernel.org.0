Return-Path: <bpf+bounces-34391-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4605092D284
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 15:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06EFF28687B
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 13:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C368E192B6B;
	Wed, 10 Jul 2024 13:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oo4fQxMW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E50B192492;
	Wed, 10 Jul 2024 13:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720617193; cv=none; b=BvOYOUuT6c80nSkIrlnmH/7kOWrtkw0lNBEncLeg0cam12JdenTj22PSZRlqNpx/d1+rP521VHWKMJD3IBcVAIyfevG1LVBIcjIkuVBlxV6eSsH5IpPr545JhmxUV/ZfdD/0l7SqWzHdsd9MiEJbOGIPi9AWRuEq4ROaUnoP2Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720617193; c=relaxed/simple;
	bh=zCaQdqZBJFT4gxEEVN4/H11OcPWzcWbQmu1IHR8AFpw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cUCfbBrazqx6bwLPhBgqbBP2nd9zQk6BYq6RC9W1Btv3rNCclQ3Ph5NczFKSzi9JoUsflwDo7HBFoOydjzbj8gNB4GkNfv6tYJu/X4zCl9+xZ31/NsLbrVku2yEmkOqwIKa4ZmrgDSgv9JgySh0ab/2uponrGgiCicAM4VQiJFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oo4fQxMW; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4255fc43f1cso41028325e9.0;
        Wed, 10 Jul 2024 06:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720617190; x=1721221990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ClC/41ii/Jwdd0JFhRS2Ltf02XtoLofkYPVITfrJ0ow=;
        b=Oo4fQxMWZlvR03YhVPsX3P3SqYYWXEs2Cs3X0fF7zBa4AIg6lQAoih7veN+xwZu/kw
         ATnQSn60lqR9ZnLDGCdrO0DreulNJ+xQKFSLubdp3e0m/sb0ja2BMcvROml4uZiMQCXn
         uRd+U3m03JOfIZfXW+M36kcaG1ftZ8sKCDfZlPtrd01DiY3wA2bFYFwAtk1x5sFNyJ+O
         7oGhsDbJ9IBQcMXUTxjWWX4DRKBxD2+LbV6iIhxiqkoXIc5V2UvxjciXubZFcet1KrdF
         P15ApNBhirTcmzSwhe1tcmqBs0EbFO3T0e/zExI+Am7EtZynefHjqxT7MX2uMZzkGv3v
         hp1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720617190; x=1721221990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClC/41ii/Jwdd0JFhRS2Ltf02XtoLofkYPVITfrJ0ow=;
        b=l3GOXxoOXhNh86aONtwVj5AOrr/ozRdYQawr3ThMSHtX0Tje0sWrJjLqPlEdiqvx8g
         bYRg/HwNHrONVow68wnjxjbmDkKXm+a2UIIDAdWiW1Cg6VfnGbBzZTEXjgKtNr1P4eOk
         UZmSBPejCoORddex9+N8v1Xag5sXSVYV/FWkKRBlhoWeKQexNyljcsdTZdQA9+LvIUQZ
         GV/n9ga5j7ER9ilLQcbuUIauAX8EsjXzsgZ5wYl2UQTnsz0AjdIgXwb2nW0SNXT4p457
         jLWVY4mJFZHOYxF34tciLiLWSFJAYaNtqxr0eFa/8rO0OXQEq0CDQgG9uCNEMczqVqK1
         C/Zg==
X-Forwarded-Encrypted: i=1; AJvYcCVvNP9GrcF1Z4DULRg/4YhYbSC1UtLFzf1TE62CV5cl33OvhRVf4XNj32FCzq4yJPP0ysrLeIe1yKt8BMshWY+KCyHmihDVkV92Ul4SvFVrCmWnemruoLdBaga4176e2W6CqHcCRL4qZMFbTjWltQCUm5CWoJ8wVyuoLV75ne2507wjYogj
X-Gm-Message-State: AOJu0YzSk7W0ovSCprk2a4Un6S5ZIKqFtaSZOX2eomGaFISAitkrDdii
	mb2vgc9SFuLruAdYuwmdldePug9W4o8nyUwKvzA171ipG5FWvQpOl6Z7XQ==
X-Google-Smtp-Source: AGHT+IGeeXk0ZxOzfSM9z0/UBGrmHJ4VGVUi/2TU63DfgS1g8nxcs31IR6zYXDNlrRCFBfwjwwrvfg==
X-Received: by 2002:a05:600c:6c59:b0:425:7c5f:1bac with SMTP id 5b1f17b1804b1-426707e3295mr42193445e9.21.1720617189698;
        Wed, 10 Jul 2024 06:13:09 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42797d0921fsm296025e9.28.2024.07.10.06.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 06:13:09 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 10 Jul 2024 15:13:07 +0200
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: mhiramat@kernel.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>
Subject: Re: [PATCH bpf-next] bpf: kprobe: remove unused declaring of
 bpf_kprobe_override
Message-ID: <Zo6I47BQlLnNN3R-@krava>
References: <20240710085939.11520-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710085939.11520-1-dongml2@chinatelecom.cn>

On Wed, Jul 10, 2024 at 04:59:39PM +0800, Menglong Dong wrote:
> After the commit 66665ad2f102 ("tracing/kprobe: bpf: Compare instruction

should be in Fixes: tag probably ?

> pointer with original one"), "bpf_kprobe_override" is not used anywhere
> anymore, and we can remove it now.
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>

lgtm, cc-ing Masami

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  include/linux/trace_events.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index 9df3e2973626..9435185c10ef 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -880,7 +880,6 @@ do {									\
>  struct perf_event;
>  
>  DECLARE_PER_CPU(struct pt_regs, perf_trace_regs);
> -DECLARE_PER_CPU(int, bpf_kprobe_override);
>  
>  extern int  perf_trace_init(struct perf_event *event);
>  extern void perf_trace_destroy(struct perf_event *event);
> -- 
> 2.39.2
> 
> 

