Return-Path: <bpf+bounces-63468-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 628EDB07C42
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 19:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED6491AA743B
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 17:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8472F5C5A;
	Wed, 16 Jul 2025 17:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="GSqxG92C"
X-Original-To: bpf@vger.kernel.org
Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C129E2F5333
	for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 17:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752687891; cv=none; b=FTxm/5oWqb7f5NtolF+vonCjY/CM36iyicDdEKIWYscPAh2kdib9Gtn9bPgokIi+zI7U6r8R7bIbr8LOCmBE6hRPeCsIgqC2duJ1MRM49MRdDt3/HMMTTumy6L2iD2JEHnV5bNC5h3g16729O3k9QndCWm8ncuyjxCQQsUjGsYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752687891; c=relaxed/simple;
	bh=lHL6mA5vEOF2TTCPv3OzQP9b1XYTmlGMZzh/0sQN8Q4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UUNxdsu8gsayaTJJSrXljV+BkWTJqeqUownhGe5GRou9ZBKZiKwB1GBwYcXm/CCEBhf28m7LY/ksroyZ7u89RqO42jh8+k/cXMmkUgGDlchZONT+DMjdRK4RDSyJ0uUJ/c5A/6A06980Mf1fvDRa21ijzp8/hzD8j1AvFdaJsJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=GSqxG92C; arc=none smtp.client-ip=66.163.184.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1752687887; bh=2L60XZ38mt2Rbvt5E6l5iFD0yBmFUuA+nQRy1etxf/M=; h=Date:Subject:To:References:From:In-Reply-To:From:Subject:Reply-To; b=GSqxG92C2yDm8TWYMehrEzGU1YxMTa5Euf0n8l8Z+nrHoCNugWFO3x8rPBb+BAYaZEVijSBWGNGHjP8tNBgXYx1Nh8+5MMbKodtBoH1IzkVCVJTw565QIrrZCO/2CELNCPAgEOgX2R+2BIKr15zSkacg89e3nI6k8+Q+nj248c68pocm1/cD9Nqm1vC7hLA6i1H94GSdJiRuTHSOLD5aekXLtRo72ngteA+uQVMhXHe41RlS+0/zK5nU/N07ipA9Ei0UeLBYItDOa2hYATuLbPkt8RnHalTFHSySZOXsYEMaI9Sr7/SiVqEOpakeiVcuJBHZs+NT+AU8YN9j4qI+Cw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1752687887; bh=znJNjoomwGN52YNHgi/ufUPGtJ7ZQV1ulsoR8yKa06q=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=pNzRpaEi93KyIz2n+j4QE2hDaJHZ6KlLCDEY9iKcU80oogtTiOmS5Z0BZPZxyeGPTdaHX7+8spTTCBc6AksmQWUbIfXdreeErGFgWHXO3WRElSwLk3O134epSvt34HGwwZHf6ZlXx/KMjlFn538mON824uzQcnPQzcDJHTNKVuR5si0y2zQ9wcbRKeFdt43xUT18P+X2I7zzg8fnrhldw9zzot/BXF+ukvDGjtz/wlXgd7zIdg+zd5B1aWij09PzjEtPMkz/d4fgLkKqaiOON761Fzgdh0JIPMR41S5HaSf+rm37SIsLLWWKzyNp9LWmpVxwoHN37TzUbYrYj44mpg==
X-YMail-OSG: IM9MO7cVM1l4AUPZNd_lnYRH9r6DWZ26U813jlUvG4cTPAIS6wnYAQfUlOcubq_
 MqfXiKxZL4vNJ3ofOlD3A4r4HkrYGEIpxGPRxiQ5vwqIhdztu_DmC91TOETROMGjKhtlur1maO1G
 hpkMOZ5ssfgfYFj95..wYBOhZgUwXKO0kkm7nrKrO8.RrR4yj8zwabt7NwCcCiRSq9LNwbzQ2K5b
 tsxSPY.LFie.K3qCbvJS24WB5yONZJWf26jKbaoCyVB_6YaWQ85hUHiLFovWV5LPTZnNiCvEju1J
 IPkV_BUlzywLP1u98aDNyysnMBbHj4AMpS5Gk3hUbCB3DvoWZxENfKem0yKmA.eZemZc7nQtJ2lY
 OE1SzX72mlKtYvaUd03UekRU3LQjyjCdhjitTNDfjLa.6SKKTiK_5wQakYPeZxm_TbGTuOYetqMt
 2GfAsj3wAasDalcEAetz36VcAAeLumPVqK1OvJeFunhGb9Fm5HrCKw1SxHxP.K7kdeXrKiTvZcK6
 TL6IeF4JnRwq0IhIuFfC1EUqxV0fbHI7kDx0ACw7HCUk.XzacAbJOMv8XyGBLMI3vl0Umqrqvlyz
 W7tE42IVT2Qy.TZ.EhZa6Lj5LQ4THt0rE8Gf9ZrYT0yKOAVHPimu6ybIAPmavWfj9AwzxgGXM0xz
 0._Ump7O0ha_GDpwjz74qTRyIA8EZ.alTyCmEddEIpSOeGG8X_CJAjeeKk9V38vzYVw2oktKa6_2
 _Gn7d_Xr2sETXyF5qFIJUxz25lgDnN4bi37uGLTsZ8.FkCRFc_.0ZRWG7IrpRUT8Cl0AnKuO1IRB
 b4R6.gRkvth01pnj_j2I7Fla8c8Jg2qnX4ZPMN57Hzn_InIIV8yi2OsExg_EUKEtCgzGZpLDVOp1
 9I8EoBcq6T.T6DrFtFYQjGE6Zki7OhuzJ_uOibId1BPcczr4YxNQ.1Y6SgaFUCGx6wap0chKa3xR
 7B_NXWbbgv8txAgeo_Ud12Vp5hF1.QIWoGx6jj4GlTt7yAnuLwqieFFHyzvqa7PYZbKpvdlKh8zz
 TX4m0MOGb9kecK9a6WnRs8zE0BiDKQ5ZsVzpqeVsl32jLTukjsTz18la6.Q4uicoBtk2LDjwgg4I
 msXA.QQMbw08BhOLQWtMFVuv2BNmGq69C77KwhsTVehhe3V4l8bLV1TUj8d2kK0H72q3yo2HA.k2
 S6z.Y4SLnx99tML2NaN7tIPlcpUYd6oQfdCZmFhde74n0qZfAQLOi68lgac2USzgeOUc8DNB7BWe
 OEDo.tZp_xG5iTAyjDd9aovEvKhy3uK0lgrfMQriwsd87D1BCP7mxu6VN_V.P6K4FP1OFmp0DWeT
 _SqVrI9LSmp6CRr2Sl2WRLv1FswsIIYq9FIRqeIckAcfdQ.XmIcDq3KwmZfjIcM1aZfnNuujRA.Z
 zC8d.7ACBvwJwTpso2Ud8BTtlS.W6AnTHE_GWqPzJrYSWn4b8pYrYRADaHAErMNPp_hHFBKE3odw
 IbcE75M69hqhC.tPre1UIJhgdP1.eFLhaajFYO6pfPJJet8ptF.QKVt4xFgS7ihspPr4TOnLzXrW
 LOrB1_ApUnpOhPayd2C_Eh_dHPAFc8tXi6mVOUz2oJf8dIp38IVBz.Q2JvzE_PDVMe_CqmwAckxw
 IOODJhgdjLbu4stUPNOdycMGxN0GtZ.c6DVfu7AvxmZfcFHNrss1NpaOaYtG1exwDjyaWRFsGLCA
 yvsl9SpqNUy49EqoyGB7O5O77_zc6DzzHfaUtNFNraSXLYRBkGSe8CRXWM7QMA.rhzx0Dw3Ji94C
 NapfnS0iimGqL4Myuew96vQX1NyGuAIYOvHM_xwaZAb8w3DLqDn5w31u.ixABMw4.3Gt82u7FGPv
 DD8lhroPKNOu55koA_lAaBiIOxlxTSGn2HVZ_3kAnhgy07F.zUNRFarp4bHYOuN8RP7vjomRPaZr
 LtyrFFGad2928oOCw61ZEc9jDZb05DP8ThAffczHjJSvScH_DyRfLB.iXDvvj79n7bGx.A_kHrLM
 bsv0GweJI7iCfz_1dMIAq2NS5yXAWT0vTO8e5Hi2LTgK8kqkWIcsOi6GEr7sF4xqtJ3dqJKWJu8j
 CsQJ8nHNb3BGdDd06Bg1irBb1btJ15D3TBRIaCpaD3XOH6Mg4D7JSqBA5Yn9f36LztoW0HKOW3Oo
 60JyHYyPbGbfYpND9x.J5.HZt5IStsc6NFaGUBps1KrfjHhneBwvgR972m2UPO4SYt5Z1wCSY1hn
 _ujVRGhYyxR6WO_NMgDArvVdySzjacZHznHm7AgZUj7cXhc3FPkzDOqRA3REeoW9xFgcvrVI.qkq
 ox1KiEd9PSbrcPeqS
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: ab211010-51db-402c-8669-5606c02dc1e8
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Wed, 16 Jul 2025 17:44:47 +0000
Received: by hermes--production-gq1-74d64bb7d7-mh87r (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1729b5b9fab1b142744e6c8191afc52f;
          Wed, 16 Jul 2025 17:44:45 +0000 (UTC)
Message-ID: <f1816e37-56f5-43de-8a52-129a2952c355@schaufler-ca.com>
Date: Wed, 16 Jul 2025 10:44:43 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lsm,selinux: Add LSM blob support for BPF objects
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>,
 John Johansen <john.johansen@canonical.com>,
 =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 selinux@vger.kernel.org, bpf@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20250715222655.705241-1-bboscaccy@linux.microsoft.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250715222655.705241-1-bboscaccy@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24187 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 7/15/2025 3:25 PM, Blaise Boscaccy wrote:
> This patch introduces LSM blob support for BPF maps, programs, and
> tokens to enable LSM stacking and multiplexing of LSM modules that
> govern BPF objects. Additionally, the existing BPF hooks used by
> SELinux have been updated to utilize the new blob infrastructure,
> removing the assumption of exclusive ownership of the security
> pointer.
>
> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> ---
>  include/linux/lsm_hooks.h         |   3 +
>  security/security.c               | 120 +++++++++++++++++++++++++++++-
>  security/selinux/hooks.c          |  56 +++-----------
>  security/selinux/include/objsec.h |  17 +++++
>  4 files changed, 147 insertions(+), 49 deletions(-)
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 090d1d3e19fed..79ec5a2bdcca7 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -116,6 +116,9 @@ struct lsm_blob_sizes {
>  	int lbs_xattr_count; /* number of xattr slots in new_xattrs array */
>  	int lbs_tun_dev;
>  	int lbs_bdev;
> +	int lbs_bpf_map;
> +	int lbs_bpf_prog;
> +	int lbs_bpf_token;
>  };
>  
>  /*
> diff --git a/security/security.c b/security/security.c
> index 596d418185773..8c413b84f33db 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -283,6 +283,9 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
>  	lsm_set_blob_size(&needed->lbs_xattr_count,
>  			  &blob_sizes.lbs_xattr_count);
>  	lsm_set_blob_size(&needed->lbs_bdev, &blob_sizes.lbs_bdev);
> +	lsm_set_blob_size(&needed->lbs_bpf_map, &blob_sizes.lbs_bpf_map);
> +	lsm_set_blob_size(&needed->lbs_bpf_prog, &blob_sizes.lbs_bpf_prog);
> +	lsm_set_blob_size(&needed->lbs_bpf_token, &blob_sizes.lbs_bpf_token);
>  }
>  
>  /* Prepare LSM for initialization. */
> @@ -480,6 +483,9 @@ static void __init ordered_lsm_init(void)
>  	init_debug("tun device blob size = %d\n", blob_sizes.lbs_tun_dev);
>  	init_debug("xattr slots          = %d\n", blob_sizes.lbs_xattr_count);
>  	init_debug("bdev blob size       = %d\n", blob_sizes.lbs_bdev);
> +	init_debug("bpf map blob size    = %d\n", blob_sizes.lbs_bpf_map);
> +	init_debug("bpf prog blob size   = %d\n", blob_sizes.lbs_bpf_prog);
> +	init_debug("bpf token blob size  = %d\n", blob_sizes.lbs_bpf_token);
>  
>  	/*
>  	 * Create any kmem_caches needed for blobs
> @@ -835,6 +841,72 @@ static int lsm_bdev_alloc(struct block_device *bdev)
>  	return 0;
>  }
>  
> +/**
> + * lsm_bpf_map_alloc - allocate a composite bpf_map blob
> + * @map: the bpf_map that needs a blob
> + *
> + * Allocate the bpf_map blob for all the modules
> + *
> + * Returns 0, or -ENOMEM if memory can't be allocated.
> + */
> +static int lsm_bpf_map_alloc(struct bpf_map *map)
> +{
> +	if (blob_sizes.lbs_bpf_map == 0) {
> +		map->security = NULL;
> +		return 0;
> +	}
> +
> +	map->security = kzalloc(blob_sizes.lbs_bpf_map, GFP_KERNEL);

Some of the blobs use kmem_cache_alloc(). You should consider if that
might be right for you.

> +	if (!map->security)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +/**
> + * lsm_bpf_prog_alloc - allocate a composite bpf_prog blob
> + * @prog: the bpf_prog that needs a blob
> + *
> + * Allocate the bpf_prog blob for all the modules
> + *
> + * Returns 0, or -ENOMEM if memory can't be allocated.
> + */
> +static int lsm_bpf_prog_alloc(struct bpf_prog *prog)
> +{
> +	if (blob_sizes.lbs_bpf_prog == 0) {
> +		prog->aux->security = NULL;
> +		return 0;
> +	}
> +
> +	prog->aux->security = kzalloc(blob_sizes.lbs_bpf_prog, GFP_KERNEL);
> +	if (!prog->aux->security)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +/**
> + * lsm_bpf_token_alloc - allocate a composite bpf_token blob
> + * @token: the bpf_token that needs a blob
> + *
> + * Allocate the bpf_token blob for all the modules
> + *
> + * Returns 0, or -ENOMEM if memory can't be allocated.
> + */
> +static int lsm_bpf_token_alloc(struct bpf_token *token)
> +{
> +	if (blob_sizes.lbs_bpf_token == 0) {
> +		token->security = NULL;
> +		return 0;
> +	}
> +
> +	token->security = kzalloc(blob_sizes.lbs_bpf_token, GFP_KERNEL);
> +	if (!token->security)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
>  /**
>   * lsm_early_task - during initialization allocate a composite task blob
>   * @task: the task that needs a blob
> @@ -5684,7 +5756,16 @@ int security_bpf_prog(struct bpf_prog *prog)
>  int security_bpf_map_create(struct bpf_map *map, union bpf_attr *attr,
>  			    struct bpf_token *token, bool kernel)
>  {
> -	return call_int_hook(bpf_map_create, map, attr, token, kernel);
> +	int rc = 0;
> +
> +	rc = lsm_bpf_map_alloc(map);
> +	if (unlikely(rc))
> +		return rc;
> +
> +	rc = call_int_hook(bpf_map_create, map, attr, token, kernel);
> +	if (unlikely(rc))
> +		security_bpf_map_free(map);
> +	return rc;
>  }
>  
>  /**
> @@ -5703,7 +5784,16 @@ int security_bpf_map_create(struct bpf_map *map, union bpf_attr *attr,
>  int security_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
>  			   struct bpf_token *token, bool kernel)
>  {
> -	return call_int_hook(bpf_prog_load, prog, attr, token, kernel);
> +	int rc = 0;
> +
> +	rc = lsm_bpf_prog_alloc(prog);
> +	if (unlikely(rc))
> +		return rc;
> +
> +	rc = call_int_hook(bpf_prog_load, prog, attr, token, kernel);
> +	if (unlikely(rc))
> +		security_bpf_prog_free(prog);
> +	return rc;
>  }
>  
>  /**
> @@ -5720,7 +5810,16 @@ int security_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
>  int security_bpf_token_create(struct bpf_token *token, union bpf_attr *attr,
>  			      const struct path *path)
>  {
> -	return call_int_hook(bpf_token_create, token, attr, path);
> +	int rc = 0;
> +
> +	rc = lsm_bpf_token_alloc(token);
> +	if (unlikely(rc))
> +		return rc;
> +
> +	rc = call_int_hook(bpf_token_create, token, attr, path);
> +	if (unlikely(rc))
> +		security_bpf_token_free(token);
> +	return rc;
>  }
>  
>  /**
> @@ -5763,7 +5862,12 @@ int security_bpf_token_capable(const struct bpf_token *token, int cap)
>   */
>  void security_bpf_map_free(struct bpf_map *map)
>  {
> +	if (!map->security)
> +		return;
> +
>  	call_void_hook(bpf_map_free, map);
> +	kfree(map->security);
> +	map->security = NULL;
>  }
>  
>  /**
> @@ -5774,7 +5878,12 @@ void security_bpf_map_free(struct bpf_map *map)
>   */
>  void security_bpf_prog_free(struct bpf_prog *prog)
>  {
> +	if (!prog->aux->security)
> +		return;
> +
>  	call_void_hook(bpf_prog_free, prog);
> +	kfree(prog->aux->security);
> +	prog->aux->security = NULL;
>  }
>  
>  /**
> @@ -5785,7 +5894,12 @@ void security_bpf_prog_free(struct bpf_prog *prog)
>   */
>  void security_bpf_token_free(struct bpf_token *token)
>  {
> +	if (!token->security)
> +		return;
> +
>  	call_void_hook(bpf_token_free, token);
> +	kfree(token->security);
> +	token->security = NULL;
>  }
>  #endif /* CONFIG_BPF_SYSCALL */
>  
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 595ceb314aeb3..8052fb5fafc4d 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -7038,14 +7038,14 @@ static int bpf_fd_pass(const struct file *file, u32 sid)
>  
>  	if (file->f_op == &bpf_map_fops) {
>  		map = file->private_data;
> -		bpfsec = map->security;
> +		bpfsec = selinux_bpf_map_security(map);
>  		ret = avc_has_perm(sid, bpfsec->sid, SECCLASS_BPF,
>  				   bpf_map_fmode_to_av(file->f_mode), NULL);
>  		if (ret)
>  			return ret;
>  	} else if (file->f_op == &bpf_prog_fops) {
>  		prog = file->private_data;
> -		bpfsec = prog->aux->security;
> +		bpfsec = selinux_bpf_prog_security(prog);
>  		ret = avc_has_perm(sid, bpfsec->sid, SECCLASS_BPF,
>  				   BPF__PROG_RUN, NULL);
>  		if (ret)
> @@ -7059,7 +7059,7 @@ static int selinux_bpf_map(struct bpf_map *map, fmode_t fmode)
>  	u32 sid = current_sid();
>  	struct bpf_security_struct *bpfsec;
>  
> -	bpfsec = map->security;
> +	bpfsec = selinux_bpf_map_security(map);
>  	return avc_has_perm(sid, bpfsec->sid, SECCLASS_BPF,
>  			    bpf_map_fmode_to_av(fmode), NULL);
>  }
> @@ -7069,7 +7069,7 @@ static int selinux_bpf_prog(struct bpf_prog *prog)
>  	u32 sid = current_sid();
>  	struct bpf_security_struct *bpfsec;
>  
> -	bpfsec = prog->aux->security;
> +	bpfsec = selinux_bpf_prog_security(prog);
>  	return avc_has_perm(sid, bpfsec->sid, SECCLASS_BPF,
>  			    BPF__PROG_RUN, NULL);
>  }
> @@ -7079,69 +7079,33 @@ static int selinux_bpf_map_create(struct bpf_map *map, union bpf_attr *attr,
>  {
>  	struct bpf_security_struct *bpfsec;
>  
> -	bpfsec = kzalloc(sizeof(*bpfsec), GFP_KERNEL);
> -	if (!bpfsec)
> -		return -ENOMEM;
> -
> +	bpfsec = selinux_bpf_map_security(map);
>  	bpfsec->sid = current_sid();
> -	map->security = bpfsec;
>  
>  	return 0;
>  }
>  
> -static void selinux_bpf_map_free(struct bpf_map *map)
> -{
> -	struct bpf_security_struct *bpfsec = map->security;
> -
> -	map->security = NULL;
> -	kfree(bpfsec);
> -}
> -
>  static int selinux_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
>  				 struct bpf_token *token, bool kernel)
>  {
>  	struct bpf_security_struct *bpfsec;
>  
> -	bpfsec = kzalloc(sizeof(*bpfsec), GFP_KERNEL);
> -	if (!bpfsec)
> -		return -ENOMEM;
> -
> +	bpfsec = selinux_bpf_prog_security(prog);
>  	bpfsec->sid = current_sid();
> -	prog->aux->security = bpfsec;
>  
>  	return 0;
>  }
>  
> -static void selinux_bpf_prog_free(struct bpf_prog *prog)
> -{
> -	struct bpf_security_struct *bpfsec = prog->aux->security;
> -
> -	prog->aux->security = NULL;
> -	kfree(bpfsec);
> -}
> -
>  static int selinux_bpf_token_create(struct bpf_token *token, union bpf_attr *attr,
>  				    const struct path *path)
>  {
>  	struct bpf_security_struct *bpfsec;
>  
> -	bpfsec = kzalloc(sizeof(*bpfsec), GFP_KERNEL);
> -	if (!bpfsec)
> -		return -ENOMEM;
> -
> +	bpfsec = selinux_bpf_token_security(token);
>  	bpfsec->sid = current_sid();
> -	token->security = bpfsec;
>  
>  	return 0;
>  }
> -
> -static void selinux_bpf_token_free(struct bpf_token *token)
> -{
> -	struct bpf_security_struct *bpfsec = token->security;
> -
> -	token->security = NULL;
> -	kfree(bpfsec);
> -}
>  #endif
>  
>  struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
> @@ -7159,6 +7123,9 @@ struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
>  	.lbs_xattr_count = SELINUX_INODE_INIT_XATTRS,
>  	.lbs_tun_dev = sizeof(struct tun_security_struct),
>  	.lbs_ib = sizeof(struct ib_security_struct),
> +	.lbs_bpf_map = sizeof(struct bpf_security_struct),
> +	.lbs_bpf_prog = sizeof(struct bpf_security_struct),
> +	.lbs_bpf_token = sizeof(struct bpf_security_struct),
>  };
>  
>  #ifdef CONFIG_PERF_EVENTS
> @@ -7510,9 +7477,6 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(bpf, selinux_bpf),
>  	LSM_HOOK_INIT(bpf_map, selinux_bpf_map),
>  	LSM_HOOK_INIT(bpf_prog, selinux_bpf_prog),
> -	LSM_HOOK_INIT(bpf_map_free, selinux_bpf_map_free),
> -	LSM_HOOK_INIT(bpf_prog_free, selinux_bpf_prog_free),
> -	LSM_HOOK_INIT(bpf_token_free, selinux_bpf_token_free),
>  #endif
>  
>  #ifdef CONFIG_PERF_EVENTS
> diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
> index 6ee7dc4dfd6e0..9f935ed9a761f 100644
> --- a/security/selinux/include/objsec.h
> +++ b/security/selinux/include/objsec.h
> @@ -26,6 +26,7 @@
>  #include <linux/lsm_hooks.h>
>  #include <linux/msg.h>
>  #include <net/net_namespace.h>
> +#include <linux/bpf.h>
>  #include "flask.h"
>  #include "avc.h"
>  
> @@ -237,4 +238,20 @@ selinux_perf_event(void *perf_event)
>  	return perf_event + selinux_blob_sizes.lbs_perf_event;
>  }
>  
> +#ifdef CONFIG_BPF_SYSCALL
> +static inline struct bpf_security_struct *selinux_bpf_map_security(struct bpf_map *map)
> +{
> +	return map->security + selinux_blob_sizes.lbs_bpf_map;
> +}
> +
> +static inline struct bpf_security_struct *selinux_bpf_prog_security(struct bpf_prog *prog)
> +{
> +	return prog->aux->security + selinux_blob_sizes.lbs_bpf_prog;
> +}
> +
> +static inline struct bpf_security_struct *selinux_bpf_token_security(struct bpf_token *token)
> +{
> +	return token->security + selinux_blob_sizes.lbs_bpf_token;
> +}
> +#endif /* CONFIG_BPF_SYSCALL */
>  #endif /* _SELINUX_OBJSEC_H_ */

