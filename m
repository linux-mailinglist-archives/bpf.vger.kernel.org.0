Return-Path: <bpf+bounces-77971-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F2FCF9442
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 17:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 886CE3064616
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 16:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4F1337109;
	Tue,  6 Jan 2026 16:03:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF8521D590;
	Tue,  6 Jan 2026 16:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767715395; cv=none; b=LJmwDEr6reBSx9W1ClgbBIWsLvtYfuhhJsN2Byw8+WH+GE3KkbW6RqkjjCQpsLsvlEaAO96AqcqXjedDZ6svG7CWIUg6TTtFlOJyMcmsoHzFAFYyKpPqKdmEoNO0gZ98GkFRauPmMaOP31v2WNFN7RWvmy0Oz5DRTAD6sqp7piE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767715395; c=relaxed/simple;
	bh=1uCe5s/d537zHC8VxNaiuQFq01bkKuh5qVX/xRNx5qs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jtj0SohvvOGl9WVFJ7THj7Iuujf5X27YE2jcJlaolXk6hUIbYUgcajtABcrUdFhWwicmhQi2/PQzn5vixn5O7N4mPwD6UZcAKxORAfq9AMRmWtkkSshU0yLQ6H773ie2LbI7+kztOOEIsqDTZelGBP0IjcAVciKf8zcfrxQA4BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 411A91AA7A3;
	Tue,  6 Jan 2026 16:03:10 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id DAC252002C;
	Tue,  6 Jan 2026 16:03:07 +0000 (UTC)
Date: Tue, 6 Jan 2026 11:03:32 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Tomas Glozar <tglozar@redhat.com>, Crystal Wood <crwood@redhat.com>,
 Ivan Pravdin <ipravdin.official@gmail.com>, Costa Shulyupin
 <costa.shul@redhat.com>, John Kacur <jkacur@redhat.com>, Tiezhu Yang
 <yangtiezhu@loongson.cn>, linux-trace-kernel@vger.kernel.org (open
 list:Real-time Linux Analysis (RTLA) tools), linux-kernel@vger.kernel.org
 (open list:Real-time Linux Analysis (RTLA) tools), bpf@vger.kernel.org
 (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: Re: [PATCH v2 13/18] rtla: Fix buffer size for strncpy in
 timerlat_aa
Message-ID: <20260106110332.4b46ed80@gandalf.local.home>
In-Reply-To: <20260106133655.249887-14-wander@redhat.com>
References: <20260106133655.249887-1-wander@redhat.com>
	<20260106133655.249887-14-wander@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 74jxxefxp4aiqxn7za7cbgbh7hhpr6me
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: DAC252002C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19LlWeM5YVkEL5nf4GQjc2j68V9r2EESkU=
X-HE-Tag: 1767715387-91106
X-HE-Meta: U2FsdGVkX19Lzgmc72zj7tANIJGAdWubUS/ZEXquaGlxLBibrrcCiyrvI54PcGos1U+gLOG8i4dmAmfUt2bUQaSnvDyXxILKv7FCt6osAsGuoJLKM6X6kO4JiDWxFmFPNAR7qmjG5Bv2S05eMcOqQH7F/+OLckYGCvjCvRNHaKPuhU+FSCr85PeYiSWv41vrtcDwUC93qLZNHwPxrLQNPyXpJpymYqatIQN4aRGaBGij/bK60YN6s0aG/cJGg7mcOTmL6LspwpogM/XV0teaRNxc8eq1eUdBYOx1HE+bniPzaGxupOQUwImK+d3HQ5GuQBCNcyNxA0x6IbeHkG2xjnxzYjKIxqxh

On Tue,  6 Jan 2026 08:49:49 -0300
Wander Lairson Costa <wander@redhat.com> wrote:

> The run_thread_comm and current_comm character arrays in struct
> timerlat_aa_data are defined with size MAX_COMM (24 bytes), but
> strncpy() is called with MAX_COMM as the size parameter. If the
> source string is exactly MAX_COMM bytes or longer, strncpy() will
> copy exactly MAX_COMM bytes without null termination, potentially
> causing buffer overruns when these strings are later used.

We should implement something like the kernel has of "strscpy()" which not
only truncates but also adds a null terminating byte.

> 
> Increase the buffer sizes to MAX_COMM+1 to ensure there is always
> room for the null terminator. This guarantees that even when strncpy()
> copies the maximum number of characters, the buffer remains properly
> null-terminated and safe to use in subsequent string operations.
> 
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> ---
>  tools/tracing/rtla/src/timerlat_aa.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/tracing/rtla/src/timerlat_aa.c b/tools/tracing/rtla/src/timerlat_aa.c
> index 31e66ea2b144c..d310fe65abace 100644
> --- a/tools/tracing/rtla/src/timerlat_aa.c
> +++ b/tools/tracing/rtla/src/timerlat_aa.c
> @@ -47,7 +47,7 @@ struct timerlat_aa_data {
>  	 * note: "unsigned long long" because they are fetch using tep_get_field_val();
>  	 */
>  	unsigned long long	run_thread_pid;
> -	char			run_thread_comm[MAX_COMM];
> +	char			run_thread_comm[MAX_COMM+1];

The reason why I suggest strscpy() is because now you just made every this
unaligned in the struct. 24 bytes fits nicely as 3 8 byte words. Now by
adding another byte, you just added 7 bytes of useless padding between this
and the next field.

-- Steve


>  	unsigned long long	thread_blocking_duration;
>  	unsigned long long	max_exit_idle_latency;
>  
> @@ -88,7 +88,7 @@ struct timerlat_aa_data {
>  	/*
>  	 * Current thread.
>  	 */
> -	char			current_comm[MAX_COMM];
> +	char			current_comm[MAX_COMM+1];
>  	unsigned long long	current_pid;
>  
>  	/*


