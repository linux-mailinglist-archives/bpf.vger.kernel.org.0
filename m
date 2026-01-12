Return-Path: <bpf+bounces-78555-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C347D1340A
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 15:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5131F302BD2F
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 14:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEEE26FA5A;
	Mon, 12 Jan 2026 14:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HxKCXCEn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE58D241CB2
	for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 14:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768228629; cv=none; b=qmoL+Hf+DrNkUs96nHY5GzCvY3I+cucT/TkfC97allwQVSrMrheoUhO/O+rprBxsF9m++wMRGlEfW7btZdUoGMtE4HzcV7Vo2cWAZESqNYYpj02fEQMnpmpUFKLkSDaoZdzJXlo78aOkIvNspLkflUIfMWONeW61ZhIWiHlZKlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768228629; c=relaxed/simple;
	bh=iyqqznUqDL99OwJCEkrsF2iVykllrm4FsNPCyAuRMwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DF1VDTtqBUN3e70yJBBtPRgiJAHrtOY2IJDqeK7VYpT2d8qQ0MQg2rp2+V35rEFVZqF3RdTnpOaxIVR+sck8k3Q9OqWWRgDAaeYi6a0TnUmhS4s+86XBBZ5SKvh+bnfSWSyi09yIuxLtjqykJDz7oCC4WC3QHZhqeEVKFcBQzPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HxKCXCEn; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-432d2670932so2746511f8f.2
        for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 06:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768228626; x=1768833426; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gusj9aT7RaX3C9uGASncaxKiTRdOev9W3ScVaZSC4iY=;
        b=HxKCXCEnI49Qz4IQaghPBJuui1rlMR6Novwc99GHqU+DzA2GaaTSHU0BmrzVdrjoR0
         eaJfAzUC0RPWV3NJ3dAm7K4H5ny9qutM5lWev7HR6nAwHlWZ222AgweMPQO1Pk4ZQ2/c
         927hsXyAyGVY5f9lK0+0f5jSUCbYNy+Q+zvBu1EG//K7ZGUb0WZAj8LIpQJEuaYR0xGr
         S/ADOD4neNCly69JA/OBFTtTVbHlCYWBXvPAD40FLZRPusoLLzlNVgM4hYtl7lA3HcSf
         Ew0d2xha43Q3Zw25P0OfIN5XwuIZDFWAF751T2FBGekiJw+zOfXVAX2cnH7DpNk0CKmM
         9XXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768228626; x=1768833426;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gusj9aT7RaX3C9uGASncaxKiTRdOev9W3ScVaZSC4iY=;
        b=YD0inafJFiuHa0Y8mon2IfpvvV6QerUdBbbzKOR/imsbJsw9RyYosrNgzaCFUZHIBk
         YK7EsGH3cMqpdc7zzqIIIJBJPWG2MJ8LHJ5Hez/pZ78csUW15BGui0OSfBBZQZgjiLOB
         wfUUJuAfDmI2kr1qiop61KVa0uGr+8Pyeh1D8D+P3zm7/QksG+ACgx7hAvBAaFLPy20+
         wJxWTPffySjoLCKmFFRzhwfpy29aPxawy8ZiLKP3fgn7flsDkwRlNx4f03295zV2UAlN
         Ww1yCPRhQy2Azz00DMvlBA2PptdP2DQ+dMP7n8YjB2m2YsS4fpvgKw7JwTpeX5lrsCeU
         ijfA==
X-Forwarded-Encrypted: i=1; AJvYcCXYmZxscWKV3LqaTlqDA3HC+e/A8aKU5sI5Z8YKmgjptqM1CEQVEzsJJbaeogwm+TQD+vA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlNq1Ca7rrra8gFbTCYFHIVHjoqsN8ku+STSleX+I6LGWZtTlh
	4a5rdKQL6H3h2uKZmjABNwDxBx4+ToAYRXwtCKTP4zIlZQC8vO2HU65oUR/VInuxEEk=
X-Gm-Gg: AY/fxX6t7CWpUWjTb2n0LJLXZ9PJfCA9BJp2uJWEHmRwNUcGMk6/8l3+aOZ/3QsMR/m
	Z2l4eRpmCrqM2o4XQXLUHM4XkElYhFjBn3+DgGnPnBHaJcbaRNRPKU7hnApf89zXWqyEni/Hs/F
	TrRNyMavqmgchb2CQH5Rn/R51q2QKCtdfchBIWOhQirm3SAUMCAUV4YoOe8GG4BSNfjYgOqXoqW
	BhwnqAarUvMgl2H+h9lxMBVaOxJPKkUqgudAlZEu5zqiXd6GMs4eubdPPchDMwUhwLTnvWy2bN9
	tlrFNhySPhxQ0+w66EHvsHwKMslAENbcmavYQBTgV36At1g/wWiaGOkju1IyRHGUB1GbTAsjeTM
	7Bk2r4cGzjJHydq7EVqO9V8+ZEmpC63NVN+6SyXg60G2aBRDsgxjM14c5zKT0YKANWftH1qv9aH
	aq0wIvXc4WD5OKPu3Vt71CEgksWeR7XQ==
X-Google-Smtp-Source: AGHT+IFmm1oEKKdZV8ZlNXFTTJqlKJkxSdN4HcGz/P7O+LQJVZm9Zz54Me3GJnG5+SbV8c+kl57MWg==
X-Received: by 2002:a5d:5f94:0:b0:432:5bac:3915 with SMTP id ffacd0b85a97d-432c37c87e4mr21260896f8f.39.1768228625843;
        Mon, 12 Jan 2026 06:37:05 -0800 (PST)
Received: from [10.0.1.22] (109-81-1-107.rct.o2.cz. [109.81.1.107])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ff0b2sm38877725f8f.42.2026.01.12.06.37.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 06:37:05 -0800 (PST)
Message-ID: <d683a5c5-51ad-4b8e-bf8e-6a0526f7c9c1@suse.com>
Date: Mon, 12 Jan 2026 15:37:04 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module: Fix kernel panic when a symbol st_shndx is out of
 bounds
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org, bpf@vger.kernel.org,
 linux-kbuild@vger.kernel.org, llvm@lists.linux.dev
References: <20251230183208.1317279-1-ihor.solodrai@linux.dev>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20251230183208.1317279-1-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/30/25 7:32 PM, Ihor Solodrai wrote:
> The module loader doesn't check for bounds of the ELF section index in
> simplify_symbols():
> 
>        for (i = 1; i < symsec->sh_size / sizeof(Elf_Sym); i++) {
> 		const char *name = info->strtab + sym[i].st_name;
> 
> 		switch (sym[i].st_shndx) {
> 		case SHN_COMMON:
> 
> 		[...]
> 
> 		default:
> 			/* Divert to percpu allocation if a percpu var. */
> 			if (sym[i].st_shndx == info->index.pcpu)
> 				secbase = (unsigned long)mod_percpu(mod);
> 			else
>   /** HERE --> **/		secbase = info->sechdrs[sym[i].st_shndx].sh_addr;
> 			sym[i].st_value += secbase;
> 			break;
> 		}
> 	}
> 
> A symbol with an out-of-bounds st_shndx value, for example 0xffff
> (known as SHN_XINDEX or SHN_HIRESERVE), may cause a kernel panic:
> 
>   BUG: unable to handle page fault for address: ...
>   RIP: 0010:simplify_symbols+0x2b2/0x480
>   ...
>   Kernel panic - not syncing: Fatal exception
> 
> This can happen when module ELF is legitimately using SHN_XINDEX or
> when it is corrupted.
> 
> Add a bounds check in simplify_symbols() to validate that st_shndx is
> within the valid range before using it.
> 
> This issue was discovered due to a bug in llvm-objcopy, see relevant
> discussion for details [1].
> 
> [1] https://lore.kernel.org/linux-modules/20251224005752.201911-1-ihor.solodrai@linux.dev/
> 
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr

