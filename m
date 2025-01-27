Return-Path: <bpf+bounces-49847-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 367D9A1D35C
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 10:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9380B164D8B
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 09:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5861FDA65;
	Mon, 27 Jan 2025 09:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="MB2RZKiU"
X-Original-To: bpf@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.119])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DB433C9;
	Mon, 27 Jan 2025 09:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737970199; cv=none; b=kNl4UXPE7T4Gi3EkmWWyfNaHuYvo9/+JlhFI7k/aZySdbUWXgOiyn5PzjO6BjRNQzp4SgP4hfIL5RPdt/OTOlVQB6SBBK4tlHrpoNrBZ/7WrfPwsRVJH4VkHwc0u0UvT7E8Greq8gvXm07PCIJSVTVn/hyJXVwezE7wdFQGy3N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737970199; c=relaxed/simple;
	bh=RMUcP6RD6A/+8he6KE8AV8M6wiSsaKrOnU0KUJWn2Ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tGZqA5oOAiXq09n1FE+RYg8VeRgYyBY+lP30gY0ZkDaWCpnYqZj5U8DB/bcj/HNzr2vuRVlT8JIZRtlTNhOExIMh0HM+pj87TUPmaRbA837Zb51GF6r9r6eNXPG884OD9JCKBaUz/rO4yUMF6OBgtRrF8MdpMFSgp53d7UvAL+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=MB2RZKiU; arc=none smtp.client-ip=212.42.244.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1737970195; bh=RMUcP6RD6A/+8he6KE8AV8M6wiSsaKrOnU0KUJWn2Ho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MB2RZKiUyL5rhoonBeRiVKoMudi0JZN6NQERRzZpZvmcBveCb0cvxfPvLyg9ow9sD
	 sDf5Jy/HYALnxyNg14JrOH9zoglUNuAO3OnXV7z83DJwR+sZqmv8ioc7z2sgQSMOwS
	 fKL9IX5WKK1dk5NfG/CrBy3dfY6ToFv/3u1S07wI=
Received: from [212.42.244.71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.52.1)
	(envelope-from <n.schier@avm.de>)
	id 67975213-35e9-7f0000032729-7f000001c11a-1
	for <multiple-recipients>; Mon, 27 Jan 2025 10:29:55 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Mon, 27 Jan 2025 10:29:55 +0100 (CET)
Received: from l-nschier-nb (unknown [IPv6:2001:9e8:9fa:e101:5fb1:76a5:fd66:46b3])
	by mail-auth.avm.de (Postfix) with ESMTPSA id C12658049B;
	Mon, 27 Jan 2025 10:29:54 +0100 (CET)
Date: Mon, 27 Jan 2025 10:29:53 +0100
From: Nicolas Schier <n.schier@avm.de>
To: Jinghao Jia <jinghao7@illinois.edu>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Ruowen Qin <ruqin@redhat.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH bpf v2 2/2] samples/{bpf,hid}: fix broken vmlinux path
 for VMLINUX_BTF
Message-ID: <20250127-adept-outstanding-hippo-b33d64@l-nschier-nb>
References: <20250123081950.173588-1-jinghao7@illinois.edu>
 <20250123081950.173588-3-jinghao7@illinois.edu>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250123081950.173588-3-jinghao7@illinois.edu>
X-purgate-ID: 149429::1737970195-BF44F833-D5A8F460/0/0
X-purgate-type: clean
X-purgate-size: 1091
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean

On Thu, Jan 23, 2025 at 02:19:50AM -0600, Jinghao Jia wrote:
> Commit 13b25489b6f8 ("kbuild: change working directory to external
> module directory with M=") changed kbuild working directory of bpf and
> hid samples to samples/{bpf,hid}, which broke the vmlinux path for
> VMLINUX_BTF, as the Makefiles assume the current work directory to be
> the kernel output directory and use a relative path (i.e., ./vmlinux):
> 
>   Makefile:316: *** Cannot find a vmlinux for VMLINUX_BTF at any of "  /path/to/linux/samples/bpf/vmlinux", build the kernel or set VMLINUX_BTF like "VMLINUX_BTF=/sys/kernel/btf/vmlinux" or VMLINUX_H variable.  Stop.
> 
> Correctly refer to the kernel output directory using $(objtree).
> 
> Fixes: 13b25489b6f8 ("kbuild: change working directory to external module directory with M=")
> Tested-by: Ruowen Qin <ruqin@redhat.com>
> Signed-off-by: Jinghao Jia <jinghao7@illinois.edu>
> ---
>  samples/bpf/Makefile | 2 +-
>  samples/hid/Makefile | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Nicolas Schier <n.schier@avm.de>

