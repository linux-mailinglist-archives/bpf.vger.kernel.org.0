Return-Path: <bpf+bounces-62549-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B69AFBB31
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 20:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52D483BDAFC
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 18:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46622264A65;
	Mon,  7 Jul 2025 18:52:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05F7219311;
	Mon,  7 Jul 2025 18:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751914361; cv=none; b=hizhsYjPYbGKYDMSMr77MwxpD/6CIOtiWS5P1gZT7hcZ4VynwPT8sXBsiEY4XVoaQE8wh1Hf4z/rBzlqih7vM63HhfGbXrDYvrlpHInR12q/pzPKCxM/agX9vsKDODNAm9L+xE37RB39pkiHxy/bNbFzXZftX9KyLlMMxZT3Cv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751914361; c=relaxed/simple;
	bh=+9uNWNwUoOguNrh0MWB0aDiKzTBk8vpWgi+MvD5HvaA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nfmniIhFXI3iYXBzcCzhBQI3zwIxmIJNBIVTfwfC9DzDxPI7XXwFNwR3NAt6bb/oNir3O30Lt1giTDdnD0tsIIjFBYeJMJugKDGvMp9DW3I70cRlqxbh+MJtX4UKN9zVy/77HWJev62hY8b2TZbeVCzF37N1m5hsJ9wn/n+mqGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id B17AF1A02AF;
	Mon,  7 Jul 2025 18:52:31 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id A39946000A;
	Mon,  7 Jul 2025 18:52:29 +0000 (UTC)
Date: Mon, 7 Jul 2025 14:52:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: alexei.starovoitov@gmail.com, jolsa@kernel.org, bpf@vger.kernel.org,
 Menglong Dong <dongml2@chinatelecom.cn>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 04/18] ftrace: add reset_ftrace_direct_ips
Message-ID: <20250707145228.43c669f6@batman.local.home>
In-Reply-To: <CADxym3YaHGxQ7AORGka1CV+KpnPOknohP9a6zi=3RSPXYBKC-g@mail.gmail.com>
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
	<20250703121521.1874196-5-dongml2@chinatelecom.cn>
	<20250703113001.099dc88f@batman.local.home>
	<CADxym3YaHGxQ7AORGka1CV+KpnPOknohP9a6zi=3RSPXYBKC-g@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 95a8k6ienbz8rqbrctynjw3ezmx355qx
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: A39946000A
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18Mfh5tsCyW2yAj7VkmmhrAhpOV5HeX750=
X-HE-Tag: 1751914349-443376
X-HE-Meta: U2FsdGVkX19TYR69O3Hdm/4ht9uO86N3LmzV5jWzVaB0EkVyRqHPW54KBGNipbjT4qeTnoSR+/RgBlYz/+07ycDukYP+pSXOU5gFLQbiOXVJilKWvEzBYWT2Rz73WlV8AHy7baQssxv9cYYSVQjXeRnGygFn1DzUQeJBW3y1SV+H1jnwsl+fZv8eVd+4ntBlHaqHmo+la2HIUNO2T7SHlSr/zI9kQV0XDmBChpOwo4D4IHjM/aj8fHHhWIGJ61ztE7fmR7BTQjviJ1HnWP9cxdTcD9tdjEpolhqFSd9CAh432MNl6zwEsxHIaHzGUqbyk+YH3jOf5he9Sm7mP8j+BLN42nLfxsUU

On Fri, 4 Jul 2025 09:54:52 +0800
Menglong Dong <menglong8.dong@gmail.com> wrote:

> > What exactly do you mean by "reset"?  
> 
> It means to reset the filter hash of the ftrace_ops to ips. In
> the origin logic, the filter hash of a direct ftrace_ops will not
> be changed. However, in the tracing-multi case, there are
> multi functions in the filter hash and can change. This function
> is used to change the filter hash of a direct ftrace_ops.

The above still doesn't make sense to me.

Can you explain more what exactly you are doing at a higher level? To
me "reset" means to set back to what it originally was (which usually
is zero or nothing).

-- Steve

