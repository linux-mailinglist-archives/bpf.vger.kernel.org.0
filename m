Return-Path: <bpf+bounces-20941-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9D08455D7
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 11:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0DC72870F0
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 10:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BE315B995;
	Thu,  1 Feb 2024 10:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="cY3+ffXC"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DED7F51A;
	Thu,  1 Feb 2024 10:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706785002; cv=none; b=u909x+fh+bg2fkV0pTH5xQNzc3uxCpcDzxKg3sJdFNszgA9KXuv6tjfkDNhumowaaR6emyrYbkMHZ88ovCA7pXqdWGOYRbaVPR0mGDN3tUXj8lSjtf5o5fFN3AcdY4Bxx8nr+LbkZKlo+oqvyNSeewaY+4Rki7YN7LcArYVmT4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706785002; c=relaxed/simple;
	bh=U/ddvYjcC5+BBA5QJNzKnHb5ymFoQN1gNLWC2tKQ4vc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=mBXFP+jBsn42KLNCR2YG6dix92JOnOIYBoQIxfUivifq9Kc19iIx0vitJ1dwC6gMDkVjMcyhGFR8txVsy+np8QlSjMViD6v+GGL9yq5aWkxmxLP/AKWhJGLVA2tsnHSkz4Q4CsDqQzi//fVf6GVvhLjJWIVBvrGlRwwi2n8Dt4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=cY3+ffXC; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Fg8rVU3Nxutr7U/048wbPXJuIttyCXN6sJ43lXpWKNM=; b=cY3+ffXCncX46QIb+bLqTW4C++
	YSycUE3fmafTktOZXwDJgxvvFFfhTo7Gmwqr8j0Oatho2JvZigHGEsWVwBqTcSGdKO5VmVy/8OO91
	hlj7LemAlYptFK5C7mvwC6orDXfIx+X9f5JDsTe5peahB9xvd4K4p0x+nydkKjkiZe8j7vnWL1a3j
	HYF3rfUYkhgOpdXT5+HuTkvuPODtZ91kFvJbcen737GZv9QKGaP/N1/zf8BduBWTSqCtYB5vg+lEA
	Fmc7FcizHQp3e286Rsm9E0cX/VxxMFJLfenKc80KOLrKrnhoWhnjVRzvxTyPxXxd2ooEzf33E8Pd3
	b1GxXCPQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rVUkG-0002ci-86; Thu, 01 Feb 2024 11:56:36 +0100
Received: from [81.6.34.132] (helo=localhost.localdomain)
	by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rVUkF-00006P-49; Thu, 01 Feb 2024 11:56:35 +0100
Subject: Re: [PATCH bpf-next v3 0/4] Mixing bpf2bpf and tailcalls for RV64
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, netdev@vger.kernel.org
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Luke Nelson <luke.r.nels@gmail.com>, Pu Lehui <pulehui@huawei.com>
References: <20240201083351.943121-1-pulehui@huaweicloud.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <1e7181e4-c4c5-d307-2c5c-5bf15016aa8a@iogearbox.net>
Date: Thu, 1 Feb 2024 11:56:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240201083351.943121-1-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27172/Thu Feb  1 10:40:50 2024)

On 2/1/24 9:33 AM, Pu Lehui wrote:
> In the current RV64 JIT, if we just don't initialize the TCC in subprog,
> the TCC can be propagated from the parent process to the subprocess, but
> the TCC of the parent process cannot be restored when the subprocess
> exits. Since the RV64 TCC is initialized before saving the callee saved
> registers into the stack, we cannot use the callee saved register to
> pass the TCC, otherwise the original value of the callee saved register
> will be destroyed. So we implemented mixing bpf2bpf and tailcalls
> similar to x86_64, i.e. using a non-callee saved register to transfer
> the TCC between functions, and saving that register to the stack to
> protect the TCC value. At the same time, we also consider the scenario
> of mixing trampoline.
> 
> In addition, some code cleans are also attached to this patchset.
> 
> Tests test_bpf.ko and test_verifier have passed, as well as the relative
> testcases of test_progs*.
> 
> v3:
> - Remove duplicate RV_REG_TCC load in epiloguei. (Björn Töpel)

Iiuc, this still needs a respin as per the ongoing discussions. Also,
if you have worked on BPF selftests which exercise the corner case
around a6, please include them in the series as well for coverage.

Thanks,
Daniel

