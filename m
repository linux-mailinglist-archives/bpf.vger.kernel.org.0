Return-Path: <bpf+bounces-75240-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BB0C7AB58
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 17:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A256E361293
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 16:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81E62E7BB2;
	Fri, 21 Nov 2025 16:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TxdrtkYp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="r8w/kSCQ"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ED528C864
	for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 16:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763741176; cv=none; b=WJarsyAr5pC2UckIGaEbsz4e3mWLyLKpYGpH8tPlw4UwA5gnXRb5ZN8UJvcA5r4d32hAJLhcK7MdhiVRCwDs3dCVTKpfQ2KnsI90Mr6649LaadeY0wXgMrqqcF9mHScCAP5Ihho4X05TMREH1wf8WbZJthCCG7onqw6fYPjJTrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763741176; c=relaxed/simple;
	bh=aswMdYs/Vr0iM3hCQ82AElwkwQIlk4Q3Md8Sb8eSuVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=diyUMLEOu2ZVQTMqEPzzBWgHNyRyDSJRJE0LYkdz9nAR7c/LuSoSmmEs2WU+MiKw3eF9WUw2Ebch0pqjLaX5PY0EovodfOk5Td4cEBA7a+q2M0zbCHMLqBKsxeZtwD88KFflPmgFdUsbhS1eXqyAaSvlDMD4yMlzkcE1BdLrplU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TxdrtkYp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=r8w/kSCQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763741173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rHT7U7qQncnr+CMjMZqEW+bDwFOFz+ggr1axUXIahIA=;
	b=TxdrtkYpjeFWNnSR1k06qNz2cn71ZBIZYcdrdRoN7FON7AYY44Rinv89cpNpr8Nwncvcsg
	79GBVQ6S5P1CryP7yxpK/A9k2HywGf0Rw8OkSi3c/R5A2MsO0A/MjI/03Oz3aZ3VDB28L/
	1dHvaxeXCn2w+4SkBE/OXgrsVZjHEnM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-XnkpqZDgPcOiTzVfTNbLpw-1; Fri, 21 Nov 2025 11:06:11 -0500
X-MC-Unique: XnkpqZDgPcOiTzVfTNbLpw-1
X-Mimecast-MFC-AGG-ID: XnkpqZDgPcOiTzVfTNbLpw_1763741170
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42b2ffe9335so1558042f8f.1
        for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 08:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763741170; x=1764345970; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rHT7U7qQncnr+CMjMZqEW+bDwFOFz+ggr1axUXIahIA=;
        b=r8w/kSCQbuD6WfHR5+TwoX/walxDfNWncjsHf7d4HYS7LNWMpRlHx1XR67LfRngw/R
         PS5MuEKji6YOz6dlhGoRWXZzKos7yPrdtjcd50++8z2OJ/okMPbdbiIgC2u+Qid3J96f
         bXAwuey14EtQ9EAstbjgjwf8ZIeTfy/ToLm1vx5BZp0vXAnF1qmGgU6PpkpzOzUJhhgt
         5mkWJMAhjlJunKdo/7BzRXzl9BxB1WXL3AP7jBi5pgTfUjMTuPDuc8SME1HH4VUr5eAH
         NoUgcgUAAAeHLytsfdddZ+QAumgnOJgoAL3fMeNOu16JhywoOMvOy/xDZDBTd+vrNsz6
         ne5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763741170; x=1764345970;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rHT7U7qQncnr+CMjMZqEW+bDwFOFz+ggr1axUXIahIA=;
        b=pBIfPVWscRrcpg/ZT2KY05VIjq2y6se9Qqbb6IyxoLuYtr4tUp6iqwRXrQytdew3+P
         EML7gs0vt2oMQ9V00/H/nwgNcKj5fMVZefbDcZ23JXTKTMuDZVaqcye1zfH1tVQvZM/4
         uG2Z9jkqDlY5bh3O2VXk1/Il07Fr7UfVDMEsLawtcw1zs9gHyYoYuoGyoCfVj9JH5vDY
         TBpT1or5VA2hPOqbkXHumnuDNZJppZv4utszWWQSaKlL8yazgTXTLU/7wLvWhtNWpZFF
         FbGhnnX1T6uQuKSGjQpYQxYxoYDowt1ytq+cCkHtbgWLGFSXdLJCiJ2IZfSYRBLotLyK
         P8EQ==
X-Forwarded-Encrypted: i=1; AJvYcCU86JCzMvhlgtJgtXEOmmNbINa/E4I1StSS1MRyufNK/leUGVIV+ay5HtR/exlBO7NLGi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YznIOq7uz86pSPlpqeZCSVJU0c7jqoMVIuPaSoJ5r5zoV5PmRax
	O9MbAuFV4EO92z3sL2tpWxAXew2s3CTG1TurRvLTLCPAcL3Qfkfy1HWJarowmsiwjWJMrTLlHh1
	h+TpVPOXBKReXjujuHJM9N4H7ECZHw0ym9H+NkQMCuyrdh+RiMLy7
X-Gm-Gg: ASbGncvrBF030LfK80UGCDSMxgEOJrShN/JvPbVT0i2h90O+GqwfIi9g5nEQoEBL+BC
	YXT+UNukPKXowbQCgamn0p63cWXdB3rZyXDD7r2aCSyRb8ubQBpVoNorn8lf4idE94fKQSHMBAZ
	knmoASHKlYwDgsgTBc4PWyrS1k2JGJ4nLyHOdZkOE7+p8AeGsRjA1ltCHPdlJDr5xNI2UtuTrk5
	pw/2la8eB5YJ+0htUYRcj7Fb3/87Av0pWxt6xp1tRwIXaxvOLM/jfeS04WSIcVWnsas0Zvc+s3j
	82fx48OoxmxBz4AbKQktnOb+DLep06bzKi6QXX3vHDJFMzwHW0EWUdiOB8oKkrCweml56l5voQi
	YdH6yiHvktTDFCZxijQPGsSG3xYwyE3V44yhL5LXL3yU=
X-Received: by 2002:a5d:5f95:0:b0:42b:52c4:663a with SMTP id ffacd0b85a97d-42cc1ac9d17mr3082497f8f.11.1763741169604;
        Fri, 21 Nov 2025 08:06:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGON2FEwIGaqia60wBxqJtsr7vpj0fOoPfIuTO43FfevLFZybM2n6jgwKP1+iMvYkckySgn5Q==
X-Received: by 2002:a5d:5f95:0:b0:42b:52c4:663a with SMTP id ffacd0b85a97d-42cc1ac9d17mr3082447f8f.11.1763741169083;
        Fri, 21 Nov 2025 08:06:09 -0800 (PST)
Received: from [192.168.0.102] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fa35b7sm12037358f8f.20.2025.11.21.08.06.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 08:06:07 -0800 (PST)
Message-ID: <2bcc2005-e124-455e-b4db-b15093463782@redhat.com>
Date: Fri, 21 Nov 2025 17:06:05 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 1/4] bpf: crypto: Use the correct destructor
 kfunc type
To: Sami Tolvanen <samitolvanen@google.com>, bpf@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250728202656.559071-6-samitolvanen@google.com>
 <20250728202656.559071-7-samitolvanen@google.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <20250728202656.559071-7-samitolvanen@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/28/25 22:26, Sami Tolvanen wrote:
> With CONFIG_CFI_CLANG enabled, the kernel strictly enforces that
> indirect function calls use a function pointer type that matches the
> target function. I ran into the following type mismatch when running
> BPF self-tests:
> 
>   CFI failure at bpf_obj_free_fields+0x190/0x238 (target:
>     bpf_crypto_ctx_release+0x0/0x94; expected type: 0xa488ebfc)
>   Internal error: Oops - CFI: 00000000f2008228 [#1]  SMP
>   ...
> 
> As bpf_crypto_ctx_release() is also used in BPF programs and using
> a void pointer as the argument would make the verifier unhappy, add
> a simple stub function with the correct type and register it as the
> destructor kfunc instead.

Hi,

this patchset got somehow forgotten and I'd like to revive it.

We're hitting kernel oops when running the crypto cases from test_progs
(`./test_progs -t crypto`) on CPUs with IBT (Indirect Branch Tracking)
support. I managed to reproduce this on the latest bpf-next, see the
relevant part of dmesg at the end of this email.

After applying this patch, the oops no longer happens.

It looks like the series is stuck on a sparse warning reported by kernel
test robot, which seems like a false positive. Could we somehow resolve
it and proceed with reviewing and merging this?

Since this resolves our issue, adding my tested-by:

Tested-by: Viktor Malik <vmalik@redhat.com>

Thanks!
Viktor

The relevant part of dmesg:

    [ 1505.054762] Missing ENDBR: bpf_crypto_ctx_release+0x0/0x50 
    [ 1505.060306] ------------[ cut here ]------------ 
    [ 1505.064971] kernel BUG at arch/x86/kernel/cet.c:133! 
    [ 1505.069984] Oops: invalid opcode: 0000 [#1] SMP NOPTI 
    [ 1505.075085] CPU: 129 UID: 0 PID: 42861 Comm: kworker/u688:24 Tainted: G           OE       6.18.0-rc5+ #3 PREEMPT(voluntary)  
    [ 1505.086437] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE 
    [ 1505.091794] Hardware name: Intel Corporation GNR-WS/GNR-WS, BIOS GWS_REL1.IPC.3663.P19.2506271437 06/27/2025 
    [ 1505.101674] Workqueue: events_unbound bpf_map_free_deferred 
    [ 1505.107291] RIP: 0010:exc_control_protection+0x19a/0x1a0 
    [ 1505.112648] Code: d8 b9 09 00 00 00 48 8b 93 80 00 00 00 be 81 00 00 00 48 c7 c7 53 09 b2 a0 e8 c2 74 1c ff 80 a3 8a 00 00 00 fb e9 fb fe ff ff <0f> 0b 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 
    [ 1505.131474] RSP: 0018:ff714c596fe17ce8 EFLAGS: 00010002 
    [ 1505.136742] RAX: 000000000000002e RBX: ff714c596fe17d08 RCX: 0000000000000000 
    [ 1505.143924] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ff2a470fbe458240 
    [ 1505.151111] RBP: 0000000000000003 R08: 0000000000000000 R09: ff714c596fe17b70 
    [ 1505.158293] R10: ff2a470fbc07ffa8 R11: 0000000000000003 R12: 0000000000000000 
    [ 1505.165478] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000 
    [ 1505.172661] FS:  0000000000000000(0000) GS:ff2a47101c091000(0000) knlGS:0000000000000000 
    [ 1505.180805] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033 
    [ 1505.186600] CR2: 00005564968dd250 CR3: 0000001e45a22005 CR4: 0000000000f73ef0 
    [ 1505.193782] PKRU: 55555554 
    [ 1505.196533] Call Trace: 
    [ 1505.199026]  <TASK> 
    [ 1505.201171]  asm_exc_control_protection+0x26/0x60 
    [ 1505.205923] RIP: 0010:bpf_crypto_ctx_release+0x0/0x50 
    [ 1505.211023] Code: 00 eb ee 89 c2 eb d7 31 c0 5b c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <0f> 1f 40 d6 0f 1f 44 00 00 48 8d 57 28 b8 ff ff ff ff f0 0f c1 47 
    [ 1505.229849] RSP: 0018:ff714c596fe17db8 EFLAGS: 00010202 
    [ 1505.235118] RAX: ffffffff9f7917d0 RBX: ff2a46f0ce98cc20 RCX: 000000008200019e 
    [ 1505.242301] RDX: 0000000000000001 RSI: ff2a46f0dd55ff30 RDI: ff2a46f0e8662280 
    [ 1505.249483] RBP: ff2a46f0ce98cc20 R08: 0000000000000000 R09: 0000000000000001 
    [ 1505.256666] R10: 000000008200019e R11: ff2a46f0c5573bc8 R12: 0000000000000000 
    [ 1505.263849] R13: ff2a46f0ce98cc00 R14: ff2a46f0dd55ff30 R15: ff2a46f0e8662280 
    [ 1505.271035]  ? __pfx_bpf_crypto_ctx_release+0x10/0x10 
    [ 1505.276135]  bpf_obj_free_fields+0x10c/0x230 
    [ 1505.280451]  array_map_free+0x56/0x140 
    [ 1505.284243]  bpf_map_free_deferred+0x95/0x180 
    [ 1505.288646]  process_one_work+0x18b/0x340 
    [ 1505.292705]  worker_thread+0x256/0x3a0 
    [ 1505.296497]  ? __pfx_worker_thread+0x10/0x10 
    [ 1505.300813]  kthread+0xfc/0x240 
    [ 1505.304000]  ? __pfx_kthread+0x10/0x10 
    [ 1505.307792]  ? __pfx_kthread+0x10/0x10 
    [ 1505.311584]  ret_from_fork+0xf0/0x110 
    [ 1505.315297]  ? __pfx_kthread+0x10/0x10 
    [ 1505.319089]  ret_from_fork_asm+0x1a/0x30 
    [ 1505.323059]  </TASK> 

> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  kernel/bpf/crypto.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/crypto.c b/kernel/bpf/crypto.c
> index 94854cd9c4cc..a267d9087d40 100644
> --- a/kernel/bpf/crypto.c
> +++ b/kernel/bpf/crypto.c
> @@ -261,6 +261,12 @@ __bpf_kfunc void bpf_crypto_ctx_release(struct bpf_crypto_ctx *ctx)
>  		call_rcu(&ctx->rcu, crypto_free_cb);
>  }
>  
> +__bpf_kfunc void bpf_crypto_ctx_release_dtor(void *ctx)
> +{
> +	bpf_crypto_ctx_release(ctx);
> +}
> +CFI_NOSEAL(bpf_crypto_ctx_release_dtor);
> +
>  static int bpf_crypto_crypt(const struct bpf_crypto_ctx *ctx,
>  			    const struct bpf_dynptr_kern *src,
>  			    const struct bpf_dynptr_kern *dst,
> @@ -368,7 +374,7 @@ static const struct btf_kfunc_id_set crypt_kfunc_set = {
>  
>  BTF_ID_LIST(bpf_crypto_dtor_ids)
>  BTF_ID(struct, bpf_crypto_ctx)
> -BTF_ID(func, bpf_crypto_ctx_release)
> +BTF_ID(func, bpf_crypto_ctx_release_dtor)
>  
>  static int __init crypto_kfunc_init(void)
>  {


