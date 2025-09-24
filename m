Return-Path: <bpf+bounces-69516-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A870B98BE3
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 10:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA1B5160BB2
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 08:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F488296BB2;
	Wed, 24 Sep 2025 08:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBe/CklQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDBC283CA3;
	Wed, 24 Sep 2025 08:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758701061; cv=none; b=BEWJzT3UwjOLraYTiNeCXJnfRu15HetebbPXaAO5oyixbvWMd6a96rBdJFHfg+Uf6ZhisxXxdTlI81wJSWC4ItuORuLW92iv3R4TmUAETFhhiaaxY5mtZe+UYJSXQXpo0upIveWk8aQqDdsHge85ya6V8+5m+A7WyFaUCkLIQc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758701061; c=relaxed/simple;
	bh=KUi4KNlx8m6QwUF7u4uAKipbp1lGT0rx7xr1UqzrtbQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gxQ7sicZPSlZMSKUrAphjWW1KD98IVd/nA0fhGaiJNOnzJ85IWeT9JayzSF3ND6bLvXzaYBiS/2ucdqi+eEGCKlG3Ry06GxlyndX2mk/3SrZ+SR2ZlzbezDtY/KBNyXtkX8FJdJyFmoLjRP2dM5OZeb8hyL6VNvynimW4kpy9o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBe/CklQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E38C116C6;
	Wed, 24 Sep 2025 08:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758701060;
	bh=KUi4KNlx8m6QwUF7u4uAKipbp1lGT0rx7xr1UqzrtbQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CBe/CklQWlDgxW9WCFauYOJrEzcV+ffeoHwt4UvmV0mBE+mHJN81GA3Hpp0t04XIE
	 nf8FiCSn84FJrKmnbns3xGbfr19z4twBhXLV3N7yC4oHrMt97oDUMMaA6j0/qTt6kI
	 zTnro/oXgyxR9tLKJfuUNIHSIKSVM5e0U20PEU6oXceXXWr/vHQC6Qh2Lg4o/MtHLo
	 xl3pOVk7G6yTdACRY9z/3oY8JYWWLuEr+7JRKFWXVMPXkgP7M2tirX9ISIb7XkrBho
	 hfjo51IkO4BIRvSfjuQI4K8WESPUWl276nNy0LFkybFUFuB2/r3moy5Ff3BwM5+4tA
	 h9rg1x/DbLUvA==
Date: Wed, 24 Sep 2025 17:04:16 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Feng Yang <yangfeng59949@163.com>
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org,
 bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
 haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
 kpsingh@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me,
 song@kernel.org, yonghong.song@linux.dev
Subject: Re: [BUG] Failed to obtain stack trace via bpf_get_stackid on ARM64
 architecture
Message-Id: <20250924170416.0874e56c2ce99a4de92e05b8@kernel.org>
In-Reply-To: <20250924062536.471231-1-yangfeng59949@163.com>
References: <20250924003215.365db154e1fc79163d9d80fe@kernel.org>
	<20250924062536.471231-1-yangfeng59949@163.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Sep 2025 14:25:36 +0800
Feng Yang <yangfeng59949@163.com> wrote:

> By the way, during my testing, I also noticed that when executing bpf_get_stackid via kprobes or tracepoints, 
> the command bpftrace -e 'kprobe:bpf_get_stackid {printf("bpf_get_stackid\n");}' produces no output. 

I think this is because the bpf_get_stackid is a kind of recursive
event from kprobes. Kprobe handler can not be reentered.

> However, it does output something when bpf_get_stackid is invoked via uprobes. 
> This phenomenon also occurs on the x86 architecture, could this be a bug as well?

Maybe if bpf_get_stackid() is kicked from uprobes, it is not recursive
call from kprobes, so it works.

So it is expected behavior, not a bug. Sorry for confusion.


Thank you,

> 
> Thanks.
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

