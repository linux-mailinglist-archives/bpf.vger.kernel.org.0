Return-Path: <bpf+bounces-16191-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AABD17FE3A5
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 23:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB5921C20DDA
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 22:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C09D38F94;
	Wed, 29 Nov 2023 22:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="dlPw3fmJ"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6221139
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 14:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ylC88CSwlcZyeD61AV0E9fFcHrgmxCCqKv6bTR5WEC0=; b=dlPw3fmJFGZAZPpE0uKKb5akQ3
	VIzdSesu5Fd9zqD0+w7/StnWEg0GcvCUwVvXc8GUFug2ZcEYN6sL70DAUb1u0k4TAYWR9QDLPUCnV
	+nDeaitdO/hzXQ+PzZzfYlVYkO0WxuGZpOiSYfF1M3MThKhlNzrtgcRWLRbBfI7WCQexXbFD1MB37
	QcgiZ4WHq/anCFdt8lUWr2Mf+wsQQ/UeWKfQA56FTvuSyFvD8P5jTn3JFmKwJjVAQ72ifBaekG/E+
	BqZZlBYXVZ7uQWAEMLrlhwiIN12KQRcovTv1FCGB+Slg4N+9/n/OL0Hrq2AP6Zb8olAqvCPJ3ZiRi
	X1NVVYyQ==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1r8TOt-0002F2-Bv; Wed, 29 Nov 2023 23:51:23 +0100
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1r8TOs-000SnX-UK; Wed, 29 Nov 2023 23:51:22 +0100
Subject: Re: [PATCH bpf] bpf: Fix a verifier bug due to incorrect branch
 offset comparison with cpu=v4
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20231129075409.2709587-1-yonghong.song@linux.dev>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <470e1b48-fea7-3f3d-b840-cc0613a930b0@iogearbox.net>
Date: Wed, 29 Nov 2023 23:51:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231129075409.2709587-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27108/Wed Nov 29 09:40:15 2023)

On 11/29/23 8:54 AM, Yonghong Song wrote:
> Bpf cpu=v4 support is introduced in [1] and Commit 4cd58e9af8b9
> ("bpf: Support new 32bit offset jmp instruction") added support for new
> 32bit offset jmp instruction. Unfortunately, in function
> bpf_adj_delta_to_off(), for new branch insn with 32bit offset, the offset
> (plus/minor a small delta) compares to 16-bit offset bound
> [S16_MIN, S16_MAX], which caused the following verification failure:
>    $ ./test_progs-cpuv4 -t verif_scale_pyperf180
>    ...
>    insn 10 cannot be patched due to 16-bit range
>    ...
>    libbpf: failed to load object 'pyperf180.bpf.o'
>    scale_test:FAIL:expect_success unexpected error: -12 (errno 12)
>    #405     verif_scale_pyperf180:FAIL
> 
> Note that due to recent llvm18 development, the patch [2] (already applied
> in bpf-next) needs to be applied to bpf tree for testing purpose.
> 
> The fix is rather simple. For 32bit offset branch insn, the adjusted
> offset compares to [S32_MIN, S32_MAX] and then verification succeeded.
> 
>    [1] https://lore.kernel.org/all/20230728011143.3710005-1-yonghong.song@linux.dev
>    [2] https://lore.kernel.org/bpf/20231110193644.3130906-1-yonghong.song@linux.dev
> 
> Fixes: 4cd58e9af8b9 ("bpf: Support new 32bit offset jmp instruction")
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>   kernel/bpf/core.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index cd3afe57ece3..74f2fd48148c 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -371,14 +371,17 @@ static int bpf_adj_delta_to_imm(struct bpf_insn *insn, u32 pos, s32 end_old,
>   static int bpf_adj_delta_to_off(struct bpf_insn *insn, u32 pos, s32 end_old,
>   				s32 end_new, s32 curr, const bool probe_pass)
>   {
> -	const s32 off_min = S16_MIN, off_max = S16_MAX;
> +	s32 off_min = S16_MIN, off_max = S16_MAX;
>   	s32 delta = end_new - end_old;
>   	s32 off;

These should all be converted to s64, no? E.g. further below
the test will never trigger then for jmp32:

        if (off < off_min || off > off_max)
                 return -ERANGE;

> -	if (insn->code == (BPF_JMP32 | BPF_JA))
> +	if (insn->code == (BPF_JMP32 | BPF_JA)) {
>   		off = insn->imm;
> -	else
> +		off_min = S32_MIN;
> +		off_max = S32_MAX;
> +	} else {
>   		off = insn->off;
> +	}
>   
>   	if (curr < pos && curr + off + 1 >= end_old)
>   		off += delta;
> 


