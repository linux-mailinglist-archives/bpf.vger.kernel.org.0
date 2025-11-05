Return-Path: <bpf+bounces-73671-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D4734C36C14
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 17:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A603541831
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 16:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D07F33C50C;
	Wed,  5 Nov 2025 16:22:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA3133B6E7;
	Wed,  5 Nov 2025 16:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762359730; cv=none; b=gJqOkyxgJzxdqNEuCKGh1YnFsxBDw6U989w/Tw1HOa2jEqXhuUNsy0zb5QA6HaYcbC2cuRXoof23LNm70PfNkP2FiaxC3gXMvzcWpfkuPWZzUH7mbd3bfeaypHmihMAJDO/HuDUFGDADS4Ykc+dfwO2DY2ftnTXOR4zCfX40ExM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762359730; c=relaxed/simple;
	bh=tPUBcz6wnYsgnuiwKCaxQWvpoQSY/3aWfVi03XYff9o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dN315qH5+zVNfbvRLbzHfV8C2Cha8cNver/dP1wE6Y46E87YojqYTWl5fk+LDk7q9yHL6ti1cd17HGGlPYNlKr8jT8Yk5QgT4sbqxQ4MLaS6wThjKHDegheLQzQQLDsJvoZZ/e4Q+EwiA1vLxucBC0au2SHCdVLRKlTYBPM+Cfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 4225C1601A6;
	Wed,  5 Nov 2025 16:21:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 4094C1D;
	Wed,  5 Nov 2025 16:21:56 +0000 (UTC)
Date: Wed, 5 Nov 2025 11:22:04 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Petr Pavlu <petr.pavlu@suse.com>, Alexei Starovoitov <ast@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] kallsyms/ftrace: Set module buildid in
 ftrace_mod_address_lookup()
Message-ID: <20251105112204.4b0ab3d9@gandalf.local.home>
In-Reply-To: <20251105142319.1139183-5-pmladek@suse.com>
References: <20251105142319.1139183-1-pmladek@suse.com>
	<20251105142319.1139183-5-pmladek@suse.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4094C1D
X-Stat-Signature: 77sznrhaz1sftejznges1tjcrx55jmnc
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18roVEuMlC6V+iO6y3+SEQU7Yq4Z2pL21E=
X-HE-Tag: 1762359716-106494
X-HE-Meta: U2FsdGVkX1+aGzgUQI5G7y6JzBPfxwADzqKUMXneejcwqgPP46obC+lPX4V0xiEOkCLpBcNjwK+bKksvmylU8bQYG52nKUZjEwQDwPA2JZ+/WjRQqjuzOdtqbamz/4lR7pk2J+4EwPxUZYUCAZklOa12kN5uobqf/wMhBoV8nIsvKPT2JNarVZPJEtYlLutKySecvjo8gaYYdMEY/XgtSNZnjLpt/L/qI1NRSWSMRooMO3f6LvYWh6lutIqqPHlqzAsB+2ah9eQY8V2rVBTbcnHm0J2rq8ftFcFSJr121qIUc0wqNtkvlApxxmmmitHVl1/tRitcjhinehRLG+/gXkSqSiKcC28y8LOuu2YWR7WinDBea39co4BP0Sh1HX8EUMXE03McZ0YN2e0CRVaKm2Z32aelwJK+OYIT8YiDOFs4oP5jC+fskMg/HFZ7YwJeP22ND09KsvO6ujutXtQsmA==

On Wed,  5 Nov 2025 15:23:16 +0100
Petr Mladek <pmladek@suse.com> wrote:

> __sprint_symbol() might access an invalid pointer when
> kallsyms_lookup_buildid() returns a symbol found by
> ftrace_mod_address_lookup().
> 
> The ftrace lookup function must set both @modname and @modbuildid
> the same way as module_address_lookup().
> 
> Fixes: 9294523e3768 ("module: add printk formats to add module build ID to stacktraces")
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  include/linux/ftrace.h | 6 ++++--
>  kernel/kallsyms.c      | 4 ++--
>  kernel/trace/ftrace.c  | 5 ++++-
>  3 files changed, 10 insertions(+), 5 deletions(-)

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

