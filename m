Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35FDF1DB7E1
	for <lists+bpf@lfdr.de>; Wed, 20 May 2020 17:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgETPPy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 May 2020 11:15:54 -0400
Received: from sonic309-26.consmr.mail.ne1.yahoo.com ([66.163.184.152]:33755
        "EHLO sonic309-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726439AbgETPPx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 20 May 2020 11:15:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1589987752; bh=Zkd3rPDKtX3+qnFQjuOU8VFwF0nL19jUfZSYP4Q23R0=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=kkjK0TsXqKAHoENaKMCe5DQ5WVt+teqYZFSwjN8n6C0KLrUl05YAufGdMl7wuF2eKUbwjQs/DVbtDL6w8/2IWeNYwGNkHy2nEhwNiemtEAm8D6cCNO5TCFPlqBaBJRXUb6q37i22tmMRAdbVmZMQWMDjs6HrL0qg0f/O0GM2W+SN33RIND1IIbxhY7Z/CTRU0kgJAtGCKG04+zgahxzQp49QQ+ADyHiuZBpi3Bqc00Cj5kDCwmoOn1W2iC0OyUTmnm+P+8O26QSy+AZGIFCoafswkMXSfalviVVOCo83gnIGMHPHKTkDp61W1iKzugMXNXYZbusxTLY6OJ8pmxiMSQ==
X-YMail-OSG: w71mDs0VM1m_FD37UiNuOJh4sfafztJ3GFPf3cfwUmAiw74SqOqea_Q5wzAohwI
 b_tw5OkedXKObDxMPyVARBxDYyNX7m4s3yFpSC7FWoPFNxvKc8N40dTt8q9dgFpEg5xma2RdSsRx
 Y39ZpKozkVYVvoFy60gdUsHmYsXbt2kjvYpTAVa8rmy9BbWKYCM8hSe6_.Dnkmmqk6es1E62842r
 Pr6rELwQC6znto5cCkrCB72AtD8lU.9gLHq4MnIKJb1vjaXAbWUq6BfN_FMzsKbAn1JpOLjDBk7Y
 birYEmmeCVY0eZfZpmxI8qS3C.l9OYG3p0g7.rxQNAu033FG9eXgzrt7CpFLgIkodzc_dy3pBtqI
 zIBntmu5.8p2aEVKsns3k0cBfDXQvcdempClBpwhlRjh.miEwHBwTF0U_PbTvaRea8ZTYw6Vc8Sh
 U2DRynxTAPZuAtudPB1cTLyXynFXbajG7LDHL87hlPnw0u8LSBlicj_bBiBr_Mx0gwNQEuBn0aBT
 TZdAYa.zrQUb9tntQ9jGxlOBho6Ub.l2WWRWJoLwWU4jm5RcEXvONh3cfSNlR2M5M7yhamy6Gl89
 17TxRU5UMRPvpfRqU.ecOhvu1JriVPw9HGL1XO6wuKP_UZEtNp.gp3tF9VSQOtUtRR50LWYJMIyP
 gVjhJNojFxvYsBvoucKmlfRiPlmH9NdJWWLLC8pDY7bdxPA4Q4pECbdbi8Ptun.UvBCabhxesEzM
 IDdrXlyK8auysozw0NmBIBTl6UPNwWAQ7IbAH_jS8Pb..28rMNS.Re1OplTcu1DBXJ1vT8r74ASk
 6MBKOZMNY_cNsCSvvmA1owXQzW3iyLrj1qQ.1UOMMG5ctQTOk3EXcySospVoCrGvFsPteU01g5Ng
 LiHJwF4fTdX3qEhtenhzLRE4vprgPlroaZ9m38PZTpBEkw5rPEwRHLwa2RVwTkYBacZZWSUad21X
 x6LklUSetXgXrCbXFm81t_bNZSvij0FAHZy66o0LYh.V1Cg_T.DgMygF.U4vD1UODsZ7sfc6GBfC
 v238odETVRAJb1SJ4bv82IzQEXT3cFhS_ccOkaa.PziIFpP33ciGOc3Efk9Z6cEryn4RM2uKyrBp
 v.9GxEtFU_ymyj35eUFwJcHq_Z6ah9Q1gyw.hp5jiHOQ8t3a0RNISxnpO4CdFCNCe0UxNqO.4Nn2
 jJ4ty1GysVIZMStulBJwWC9Nsv9edsCy2uH2CD2vnQgxkm1KQl_1FdD4z6ev.YZZGQVZ7bYbUfy5
 NzW8qnNeyEaU1W84z0ieB686WUAPY6IanzbJ6hhnn6XpzaqiQeSTNVMTyNi0PBddqTtc2m8xjkEy
 SWK8oOfY_A7flGvRVeMHuxt.uyGlpZqKBv2iQdUlnszsttxvCLYBESgW_ReAKiNJlL7JS0DeNpXw
 8Uo8BFrRqM5gFzDh6JNDHxHyYYix6lGCPZf4hYg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Wed, 20 May 2020 15:15:52 +0000
Received: by smtp403.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 0128c7c60599331edfc261e07b768c5e;
          Wed, 20 May 2020 15:15:50 +0000 (UTC)
Subject: Re: [PATCH bpf] security: Fix hook iteration for secid_to_secctx
To:     KP Singh <kpsingh@chromium.org>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Anders Roxell <anders.roxell@linaro.org>
References: <20200520125616.193765-1-kpsingh@chromium.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <5f540fb8-93ec-aa6b-eb30-b3907f5791ff@schaufler-ca.com>
Date:   Wed, 20 May 2020 08:15:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200520125616.193765-1-kpsingh@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.15960 hermes_yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.6)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 5/20/2020 5:56 AM, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
>
> secid_to_secctx is not stackable, and since the BPF LSM registers this
> hook by default, the call_int_hook logic is not suitable which
> "bails-on-fail" and casues issues when other LSMs register this hook and
> eventually breaks Audit.
>
> In order to fix this, directly iterate over the security hooks instead
> of using call_int_hook as suggested in:
>
> https: //lore.kernel.org/bpf/9d0eb6c6-803a-ff3a-5603-9ad6d9edfc00@schaufler-ca.com/#t
>
> Fixes: 98e828a0650f ("security: Refactor declaration of LSM hooks")
> Fixes: 625236ba3832 ("security: Fix the default value of secid_to_secctx hook"
> Reported-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: KP Singh <kpsingh@google.com>

This looks fine.

> ---
>  security/security.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/security/security.c b/security/security.c
> index 7fed24b9d57e..51de970fbb1e 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1965,8 +1965,20 @@ EXPORT_SYMBOL(security_ismaclabel);
>  
>  int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
>  {
> -	return call_int_hook(secid_to_secctx, -EOPNOTSUPP, secid, secdata,
> -				seclen);
> +	struct security_hook_list *hp;
> +	int rc;
> +
> +	/*
> +	 * Currently, only one LSM can implement secid_to_secctx (i.e this
> +	 * LSM hook is not "stackable").
> +	 */
> +	hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list) {
> +		rc = hp->hook.secid_to_secctx(secid, secdata, seclen);
> +		if (rc != LSM_RET_DEFAULT(secid_to_secctx))
> +			return rc;
> +	}
> +
> +	return LSM_RET_DEFAULT(secid_to_secctx);
>  }
>  EXPORT_SYMBOL(security_secid_to_secctx);
>  
