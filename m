Return-Path: <bpf+bounces-49293-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0B1A16F3B
	for <lists+bpf@lfdr.de>; Mon, 20 Jan 2025 16:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CCFB3A6631
	for <lists+bpf@lfdr.de>; Mon, 20 Jan 2025 15:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5151E572A;
	Mon, 20 Jan 2025 15:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="WhbCaTTN"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E0D1E5710
	for <bpf@vger.kernel.org>; Mon, 20 Jan 2025 15:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737386959; cv=none; b=qzVVsvlqkeIOksdig+qpFFsNl9NJvozXCERu+C7pXdOhlv0wMC3WWo6avUM/dBGameKCm1IN+fzjO3ao9E8s7VuT1VUeAOqAQNslLS8lu/Ylj3vHFVC4qQavAjLXK96rYTbKzGIX5Lqj7t8rl+rXr5qiZF15n5j4oL0ssUnUZEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737386959; c=relaxed/simple;
	bh=L1RqdFZcmiFUTB4F3O+yurla90viyKkBrF+KgdK1wek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jPN1t+JcsfHIDepRRCGsbXJjGwgJ3/SOFBBfAaITOHe5Gb8+loHFJMI48ZcO6gDnflgBAbE1rIYH5J8MLNxjbPkTYjLZFAULl7YZR0brKcae8LmxxyZw6fGMdiM3sYX909rH0GWA/qcU0Bp1yqS+36sDqYWw5W/z0kvk5g/XiyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=WhbCaTTN; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=gDQNI9iN5x4mwsHbBW6jEpfH6cy2AMV7w/8mkg6XnEE=; b=WhbCaTTNTA90I5jmjsUodPoP6z
	BASd4RFKRq1PhJDSuyAZgrm3XQ+RzDSZa6RkYFt9ruST8krfuaK68wLUs4i4ozOZldivQ9AA/tHiY
	cNVp6ffcoucn0reYjj6n/lmjKG1pKZRhw0hnmL8S753zYzf1Q4/3ZvLIcFKuqZv4gGYIoty/SGz2K
	Hw6xezA5GGPbczd6rvbmRvwtjSY1C2SIfdbXCtZISah/CQG9PIt3VMfkY+IG0puylGbS25hts/E6k
	6Mot30F9Df0FwfhctybiQUaU7KQ3HCXHBJBmMd3UaFxNPqXbcjkggAexeQd3KGPSTvEBx/QUcXjY3
	963FpaNQ==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1tZtiB-000BCb-D2; Mon, 20 Jan 2025 16:29:11 +0100
Received: from [85.1.206.226] (helo=[192.168.1.114])
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1tZtiB-0001B9-0f;
	Mon, 20 Jan 2025 16:29:11 +0100
Message-ID: <0056055b-338a-49f1-b6bf-fa11440cb959@iogearbox.net>
Date: Mon, 20 Jan 2025 16:29:10 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/3] bpf: Remove 'may_goto 0' instruction in
 opt_remove_nops()
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20250118192019.2123689-1-yonghong.song@linux.dev>
 <20250118192029.2124584-1-yonghong.song@linux.dev>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <20250118192029.2124584-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 1.0.7/27524/Mon Jan 20 10:37:47 2025)

On 1/18/25 8:20 PM, Yonghong Song wrote:
> Since 'may_goto 0' insns are actually no-op, let us remove them.
> Otherwise, verifier will generate code like
>     /* r10 - 8 stores the implicit loop count */
>     r11 = *(u64 *)(r10 -8)
>     if r11 == 0x0 goto pc+2
>     r11 -= 1
>     *(u64 *)(r10 -8) = r11
> 
> which is the pure overhead.
> 
> The following code patterns (from the previous commit) are also
> handled:
>     may_goto 2
>     may_goto 1
>     may_goto 0
> 
> With this commit, the above three 'may_goto' insns are all
> eliminated.
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>   kernel/bpf/verifier.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 963dfda81c06..784547aa40a8 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -20187,20 +20187,25 @@ static const struct bpf_insn NOP = BPF_JMP_IMM(BPF_JA, 0, 0, 0);
>   
>   static int opt_remove_nops(struct bpf_verifier_env *env)
>   {
> +	const struct bpf_insn may_goto_0 = BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, 0, 0);
>   	const struct bpf_insn ja = NOP;
>   	struct bpf_insn *insn = env->prog->insnsi;
>   	int insn_cnt = env->prog->len;
> +	bool is_may_goto_0, is_ja;
>   	int i, err;
>   
>   	for (i = 0; i < insn_cnt; i++) {
> -		if (memcmp(&insn[i], &ja, sizeof(ja)))
> +		is_may_goto_0 = !memcmp(&insn[i], &may_goto_0, sizeof(may_goto_0));
> +		is_ja = !memcmp(&insn[i], &ja, sizeof(ja));
> +
> +		if (!is_may_goto_0 && !is_ja)
>   			continue;

Why the extra may_goto_0 stack var?

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 245f1f3f1aec..16ba26295ec7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20185,16 +20185,19 @@ static int opt_remove_dead_code(struct bpf_verifier_env *env)
  }
  
  static const struct bpf_insn NOP = BPF_JMP_IMM(BPF_JA, 0, 0, 0);
+static const struct bpf_insn MAY_GOTO_0 = BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, 0, 0);
  
  static int opt_remove_nops(struct bpf_verifier_env *env)
  {
-       const struct bpf_insn ja = NOP;
         struct bpf_insn *insn = env->prog->insnsi;
         int insn_cnt = env->prog->len;
+       bool is_ja, is_may_goto_0;
         int i, err;
  
         for (i = 0; i < insn_cnt; i++) {
-               if (memcmp(&insn[i], &ja, sizeof(ja)))
+               is_may_goto_0 = !memcmp(&insn[i], &MAY_GOTO_0, sizeof(MAY_GOTO_0));
+               is_ja         = !memcmp(&insn[i], &NOP, sizeof(NOP));
+               if (!is_may_goto_0 && !is_ja)
                         continue;

>   		err = verifier_remove_insns(env, i, 1);
>   		if (err)
>   			return err;
>   		insn_cnt--;
> -		i--;
> +		i -= (is_may_goto_0 && i > 0) ? 2 : 1;

Maybe add a comment for this logic?

Thanks,
Daniel

