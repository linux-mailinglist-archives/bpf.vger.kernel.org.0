Return-Path: <bpf+bounces-50379-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BF9A26BA7
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 06:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C6D3163DAE
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 05:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EA01FFC75;
	Tue,  4 Feb 2025 05:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Werf05iR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A081FC118;
	Tue,  4 Feb 2025 05:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738648772; cv=none; b=k2mt013Bl6D69EftukDI5P3eOW27zjCdqSYjdR1/pHNalHAjrqOfp67zh5swmTyKwJEril24kD53eoHSMZZYA84B41qkwkujZB0I30bXRcaQ6EQk0Gn/WYNrwZVAaJp0OwPbFPHemRP1i9nGopM2vLjnmTxJd7utgagh3dueqBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738648772; c=relaxed/simple;
	bh=YvJJqW7TaKi0eSKa8wnMpxSCNLJ8GlEcpP/9lwDvTiU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=izD6bNyuv3ZMi+b2oIylLWFouD7eAATbQ2VjPCOk/FjVTAzuPHOKedkUfF39HmM4cNmhP2NHXIItkwNtupRy2lPxunr8WU1bIywVudHkNjrMBBG7Mgna3VVXs9v4PEavRPa0cng1159ORv2dTrVxahFe22w5+faeSR8/e0vu8Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Werf05iR; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21628b3fe7dso94727845ad.3;
        Mon, 03 Feb 2025 21:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738648770; x=1739253570; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Zyy7tXzVYMEK0fqrjp3PFLwkjg6kJJKmOr7DrNL1OSg=;
        b=Werf05iRBQxChkzBdNG97erqh3aiZWoj2feMboquXFyqZTM1Y9FR0gu/mwssH4ripS
         mPrFZnL9TdjNtVf5gs+f0X8n++dBj0seOUQPcRH1cvIGniD5M5qnZEv2XUOVCOUieMJg
         nf+/tKN9NIrvar0R/Ez4nG0EWxbPa3zORLL+pvDxWwcLY86mZjrthWCXor3XhBNfZkLf
         Cdvn0DpXVqwUiH8AaqdSbljfCDaW55hwRh8Ji8yU1y9Hc5dC9L1wpi5Smeduolftf0n0
         jcnpOyx+9UbBx4gHA/E4G6BGYgwmQ7OV+yYZzUGh1V1RBuU9m1g1Gc7Y/HbCad3iHQzT
         55/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738648770; x=1739253570;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zyy7tXzVYMEK0fqrjp3PFLwkjg6kJJKmOr7DrNL1OSg=;
        b=B/Q7QF7aj3rd84/wwjwX+hWqPjilnmDhfsxFMf48Ukw/Y1oczz9/siKkRI4sDqP1JG
         M9rpL3T/OYBdyekr6c+auiMgEcdCBLfo0Anbrafvo8Gmw+r6z10o2sPQiGn4xMcCHvqP
         VhvrDe5/2EsOaWTzRVzyi4/F2sF4CiO9Wlv36UT67BRZ/odFKILg5BAHQm4MMm7h6SEz
         ji6zCpGHPtuo3r3LesMHZpyK19grXGwVFui0AXygA3l1lgaYgIDk2YB48Wj3jqqF3vu6
         0lqGhYFiqhfypYVI0c5CoMgat3LxxUKWjCiyg5X8NZnMi44gC6H0f59KJr0gbxCYl4/w
         pGhw==
X-Forwarded-Encrypted: i=1; AJvYcCWh4nwsqlUB43VFTWHftJNqT9Rqlf+y/tQtJNvoSLHc/dvZuBJt3DFGypQ/fZmx6vxDy33AQq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqIOdNBqG/5ggdNqEpAUtTk0jsGMPBPMCJCTtIsw+OZICP/QvU
	A8iCfR5LvJIKEcNg0mAzGs8mJtcFxzrIEOh9vZb84gHwHIrj+U15
X-Gm-Gg: ASbGncvTazJGGF4+4Rr3btjhON0pft+jLbyil3hmRG13xY6X5G+Wt+cF+MfPQmR6SMv
	DonJ32yfF2HaS4JG87sgE86MbXqTe0SeHZ5WZnJhEXZD/MqiACNOC7lUnxyq69ZEVfwCeQSU18V
	vzQL6drItInWqM6qCFEaJFcrhQ4adAedVaA7Bthe+6yZ5V3YSyt5K7C85C8FD6sGSnPbgZuRZNO
	iosKV2tj1DTTogNTXmurYg+wLv+E7j+VkJ51vjmTYOJMGK68EXU7I+X2I6V49RvQw1zuOzgJkC9
	2YBvfgrWJjYW
X-Google-Smtp-Source: AGHT+IF2KtlghTD8uA7j8gYT76ijkv4nqYL12itEmuqyBpE4/RPk1cO+cTvPehMFpz7ZnKqilL1noA==
X-Received: by 2002:a17:902:f607:b0:216:410d:4c67 with SMTP id d9443c01a7336-21dd7ddde7emr422037375ad.41.1738648769839;
        Mon, 03 Feb 2025 21:59:29 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de31ee753sm86578255ad.3.2025.02.03.21.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 21:59:29 -0800 (PST)
Message-ID: <f0f90bdb8ddc66b05f9f4fa0fb56464d57178526.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 10/18] bpf: Search and add kfuncs in
 struct_ops prologue and epilogue
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	alexei.starovoitov@gmail.com, martin.lau@kernel.org, kuba@kernel.org, 
	edumazet@google.com, xiyou.wangcong@gmail.com, cong.wang@bytedance.com, 
	jhs@mojatatu.com, sinquersw@gmail.com, toke@redhat.com, jiri@resnulli.us, 
	stfomichev@gmail.com, ekarani.silvestre@ccc.ufcg.edu.br,
 yangpeihao@sjtu.edu.cn, 	yepeilin.cs@gmail.com, ming.lei@redhat.com,
 kernel-team@meta.com
Date: Mon, 03 Feb 2025 21:59:24 -0800
In-Reply-To: <20250131192912.133796-11-ameryhung@gmail.com>
References: <20250131192912.133796-1-ameryhung@gmail.com>
		 <20250131192912.133796-11-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-01-31 at 11:28 -0800, Amery Hung wrote:
> From: Amery Hung <amery.hung@bytedance.com>
>=20
> Currently, add_kfunc_call() is only invoked once before the main
> verification loop. Therefore, the verifier could not find the
> bpf_kfunc_btf_tab of a new kfunc call which is not seen in user defined
> struct_ops operators but introduced in gen_prologue or gen_epilogue
> during do_misc_fixup(). Fix this by searching kfuncs in the patching
> instruction buffer and add them to prog->aux->kfunc_tab.
>=20
> Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> @@ -20397,6 +20412,10 @@ static int convert_ctx_accesses(struct bpf_verif=
ier_env *env)
>  				return -ENOMEM;
>  			env->prog =3D new_prog;
>  			delta +=3D cnt - 1;
> +
> +			ret =3D add_kfunc_in_insns(env, epilogue_buf, epilogue_cnt - 1);

Rant: the -1 here is a bit confusing, it is second time I forget that
      last instruction of the epilogue has to be some kind of control flow,
      and last instruction of the prologue has to be first instruction
      of the program.

> +			if (ret < 0)
> +				return ret;
>  		}
>  	}
> =20

[...]


