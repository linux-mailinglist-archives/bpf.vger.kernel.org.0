Return-Path: <bpf+bounces-76924-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB79CCC9B2E
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 23:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D9CDA300C509
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 22:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D1A311596;
	Wed, 17 Dec 2025 22:26:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CFE287276;
	Wed, 17 Dec 2025 22:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766010386; cv=none; b=Erj/uJWnI8oO6omfF+SYH1sQvQJdpFZHt/VlNQwku9pY6I8iCSBc/wuWl0lREoFwwg6OvnpCtqd/3mNQFxURH/HR9xqQyLzEH6HGO9TkHSDUrdcPJPyJnBor2CAHQGkOjTXkFoz+OuyTghE0ETiKInZU5sf9mvwJxEYQGdtvJns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766010386; c=relaxed/simple;
	bh=4YznakJw+kC0vFnT9CnLZi47NaSZObtLNgrEKgofxTU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HSEfT2jQSKdxCk3yuhGSaMqByQhRwQID1rd4okuETo2759vip/NjhqLtG2TZdFnlVQHIWEvBYfzXvH6eteEEpyzjSsGPIdn2PzjLC4b6Sz5AFhxrJiFE7ZR9yLv2ykJqWBm/jg+OvMiz4Obfrc74EgjkCI0xuPOEiD7p1sZ99f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 19A258AFF3;
	Wed, 17 Dec 2025 22:26:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id BB07720011;
	Wed, 17 Dec 2025 22:26:10 +0000 (UTC)
Date: Wed, 17 Dec 2025 17:27:47 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Maurice Hieronymus <mhi@mailbox.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 georges.aureau@hpe.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3] kallsyms: Always initialize modbuildid
Message-ID: <20251217172747.2a333460@gandalf.local.home>
In-Reply-To: <20251210170347.28053-1-mhi@mailbox.org>
References: <20251210170347.28053-1-mhi@mailbox.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ptq8o68qjes4pu4f8da78ee5nnxfnihm
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: BB07720011
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+hoL+qqMM0vf3HHIXEf6+/t4+c7/SWdYE=
X-HE-Tag: 1766010370-923308
X-HE-Meta: U2FsdGVkX19F7zz1mgQWDtQzVAqZJv6M27fcHoRJ0xIYyA5BjRtpRQAI29iibHPUhi1YEmAYqHNkNRMH1ngER/1DHWlJtc46RUqAJ4r29EvnNNMJRzPZdXJGJ646FAvjVVjI4ERTI04g9P24CzpOGlY//hWQvau9E0/D+hY6TIFfvteRyh4bbRWDCiktdXxTuhSrvIqT+voFTWQ0bNSoWv5XqSTFzzYluLV7UiPTYplwfNs7HDcJTNa5S8WB+y7E30g+RhYT7H/eDKS/pQl2VD8ZwyMmiYteQs241v5GC+bDLjIJiPwfmhtJd/HR+Gyj8URr1ruZqBeJgeO0tF2TETGyDfsm57uJ7F/wJZvXYOOcktsvh9Yl7wB1SzMYEbMO

On Wed, 10 Dec 2025 18:03:45 +0100
Maurice Hieronymus <mhi@mailbox.org> wrote:

> @@ -7761,6 +7761,12 @@ ftrace_mod_address_lookup(unsigned long addr, unsigned long *size,
>  		if (ret) {
>  			if (modname)
>  				*modname = mod_map->mod->name;
> +			if (modbuildid)
> +#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)

IS_ENABLED() is for use within C code. This should simply be:

#ifdef CONFIG_STACKTRACE_BUILD_ID

-- Steve

> +				*modbuildid = mod_map->mod->build_id;
> +#else
> +				*modbuildid = NULL;
> +#endif
>  			break;
>  		}
>  	}


