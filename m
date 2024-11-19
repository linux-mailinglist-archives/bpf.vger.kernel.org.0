Return-Path: <bpf+bounces-45182-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A974F9D26EC
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 14:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FF9C1F24247
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 13:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F5F1BDCF;
	Tue, 19 Nov 2024 13:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b="p70S1vxU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp1.tecnico.ulisboa.pt (smtp1.tecnico.ulisboa.pt [193.136.128.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD07F4778E;
	Tue, 19 Nov 2024 13:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.136.128.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732023061; cv=none; b=LHlAIAwd6UfbmCqg1KuVfBdujSqGR8zNUX1Pf6JM+rX/yAiteL91/SYTLNhKLiEJNx/oDgpwjuUCuk76dQKKJfmiJU6efg0MEI7Rpgs4AlLTzWoWekFHsIVySHhzCL8Yv0BhUCOJ1wmCXEcMYe7KSJsKP6xPjS1mSDqAJKvsZ1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732023061; c=relaxed/simple;
	bh=BAAE0j0xLXZnHfRXnAth5iMPF53rUMceNOeA+gjmmdY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=c90yD5w5mOkZr7Lpgv2CtGOX8l9adiPaxcct/JeD43v3F1QPTIGOdTE6cLIj+jEXpJsNS1HZsTgmzTFc/xgXqEbXZSXzjA3icLac3kieYOxlFoFo2+vyvVqTCGO9dvNT+cJiJ4x3EaM9b9ByV1VhJcXVPwl3efXcKiXzJ42U3tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt; spf=pass smtp.mailfrom=tecnico.ulisboa.pt; dkim=pass (1024-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b=p70S1vxU; arc=none smtp.client-ip=193.136.128.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tecnico.ulisboa.pt
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTP id 691E56002992;
	Tue, 19 Nov 2024 13:30:50 +0000 (WET)
X-Virus-Scanned: by amavis-2.13.0 (20230106) (Debian) at tecnico.ulisboa.pt
Received: from smtp1.tecnico.ulisboa.pt ([127.0.0.1])
 by localhost (smtp1.tecnico.ulisboa.pt [127.0.0.1]) (amavis, port 10025)
 with LMTP id 9GtfmMDcXrM3; Tue, 19 Nov 2024 13:30:48 +0000 (WET)
Received: from mail1.tecnico.ulisboa.pt (mail1.ist.utl.pt [193.136.128.10])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTPS id 149F360029B8;
	Tue, 19 Nov 2024 13:30:48 +0000 (WET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tecnico.ulisboa.pt;
	s=mail; t=1732023048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=26B60l0+7TcUSct9vhG4haf+xf9B94pU4CLtrv8j1qM=;
	b=p70S1vxUqazc4DCkAOnTsbStozfprOUGBj4DV8WecQLpDmLYIKx7GtTL7RElRchU3+pdK2
	9us1JVwCU0Gi1iR0/GQ5gDraKJmovmdgIsKsGgIl0Kej7rvEn/6MSwJHyxchOua0s6w2Kd
	8KKlRFaQy7bG0002NaAVcMaAQOYbS9k=
Received: from webmail.tecnico.ulisboa.pt (webmail4.tecnico.ulisboa.pt [IPv6:2001:690:2100:1::8a3:363d])
	(Authenticated sender: ist426067)
	by mail1.tecnico.ulisboa.pt (Postfix) with ESMTPSA id B2DF3360154;
	Tue, 19 Nov 2024 13:30:47 +0000 (WET)
Received: from a95-93-247-17.cpe.netcabo.pt ([95.93.247.17])
 via vs1.ist.utl.pt ([2001:690:2100:1::33])
 by webmail.tecnico.ulisboa.pt
 with HTTP (HTTP/1.1 POST); Tue, 19 Nov 2024 13:30:47 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 19 Nov 2024 13:30:47 +0000
From: =?UTF-8?Q?Sebasti=C3=A3o_Santos_Boavida_Amaro?=
 <sebastiao.amaro@tecnico.ulisboa.pt>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org
Subject: Re: uprobe overhead when specifying a pid
In-Reply-To: <ZzW-GWh7Iqp-AxGA@krava>
References: <66ba4183c94d28f7020c118029d45650@tecnico.ulisboa.pt>
 <ZzW-GWh7Iqp-AxGA@krava>
User-Agent: Roundcube Webmail
Message-ID: <dfdb91b06c3987e22a5f252324b55a4d@tecnico.ulisboa.pt>
X-Sender: sebastiao.amaro@tecnico.ulisboa.pt
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

I am using a normal SEC(uprobe) in the eBPF code. The workload is ycsb 
(with 1 thread) running against a cluster of 3 Redis nodes, I filter the 
uprobes for 3 pids (the Redis nodes).
When I profiled the machine with perf, I could not see glaring 
differences. Should I repeat this and send the .data here?
Best Regards,
Sebastião

A 2024-11-14 09:08, Jiri Olsa escreveu:
> On Wed, Nov 13, 2024 at 11:33:01PM +0000, Sebastião Santos Boavida 
> Amaro wrote:
>> Hi,
>> I am using:
>> libbpf-cargo = "0.24.6"
>> libbpf-rs = "0.24.6"
>> libbpf-sys = "1.4.3"
>> On kernel 6.8.0-47-generic.
>> I contacted the libbpf-rs guys, and they told me this belonged here.
>> I am attaching 252 uprobes to a system, these symbols are not 
>> regularly
>> called (90ish times over 9 minutes), however, when I specify a pid the
>> throughput drops 3 times from 12k ops/sec to 4k ops/sec. When I do not
>> specify a PID, and simply pass -1 the throughput remains the same (as 
>> it
>> should, since 90 times is not significant to affect overhead I would 
>> say).
>> It looks as if we are switching from userspace to kernel space without
>> triggering the uprobe.
>> Do not know if this is a known issue, it does not look like an 
>> intended
>> behavior.
> 
> hi,
> thanks for the report, I cc-ed some other folks and trace list
> 
> I'm not aware about such slowdown, I think with pid filter in place
> there should be less work to do
> 
> could you please provide more details?
>   - do you know which uprobe interface you are using
>     uprobe over perf event or uprobe_multi (likely uprobe_multi,
>     because you said above you attach 250 probes)
>   - more details on the workload, like is the threads/processes,
>     how many and I guess you trigger bpf program
>   - do you filter out single pid or more
>   - could you profile the workload with perf
> 
> thanks,
> jirka

