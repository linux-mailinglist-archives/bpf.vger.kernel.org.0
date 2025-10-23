Return-Path: <bpf+bounces-71861-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FD0BFEC42
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 02:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E885B3A9094
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 00:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFDC1AA7A6;
	Thu, 23 Oct 2025 00:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0sDxcCy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015FF199230
	for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 00:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761181092; cv=none; b=seC/GK7Y/bAzP8FMZKmaLEhIx3AqfQmaL0e8C1M870tjGutEKfvCezHIf6k7/S4OcgEH0VHoLBpdfF09I4cVWsNRu8wsPWljmduX6u1DzLuQQ8U7XVBPZkqAmchMoIjiD6TINJ7v4Wuv4SV+dHH9uwB6OgWkpL1hbit25I5QS0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761181092; c=relaxed/simple;
	bh=Of4Mby2V000R0Um8GRUwijkP1Rf/33gAHJY4qe1+uM0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KzLm8DXyqa5282pniG7gmuaZ4+cv81NnEFy0MoBxwxeQaq3b8etcV3KcFIH4ctyPRrfu4qDJBv4Glggz5/m7+y8xwdzGibulizmeJCLmeygyLmJuMRrf0/tCh8sb8rRzlxBkAqfKEQOlqJXkw5a5n/V/SXhPBkeII8dhaZ3Vx30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0sDxcCy; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2698384978dso1436025ad.0
        for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 17:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761181088; x=1761785888; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IosP+Rw0+N/Ij2efQGvoXBeEuymjdaaMYJrT0TwtuTw=;
        b=S0sDxcCyGCQxEFoYjLJgjG912N1hDXbc9OdTDG5Vzh982RvQk50/oGy7LnKMjTTBRF
         cRXC0eq1XNB6o25Qh0CBLbncEgpG84iry5MQcSDW7DJBqKa1TF127xvTNtSqH/bMYppy
         WjTpNEwGTIUH9Vrch0jAc32LYDcCYfv2fbsRvpvXuElnWyvTF2N2TX4br+kzYWwiTaXg
         JjtJbuLpYRBJd946PKmf6kXPCOtYbrPhfl0NPAUr/ZImn+wKrrveXkDWZL75S7Tk3WNE
         SlCoet/hlSgt7Qdhio1opHFltG1G/6vUELSPn3MDCyF5Kf9VFJ9EIdkCUDOKTWYUwOes
         IQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761181088; x=1761785888;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IosP+Rw0+N/Ij2efQGvoXBeEuymjdaaMYJrT0TwtuTw=;
        b=rJGcmIgCqQK5kV2W7XLOLq93LRZqDejt0C9mR9hHT7BEYwmEO/yPK/EFr7rEPsmi8P
         OncfD7AUR+OhuWg56GuLpacU6Og4/WNOwONSwTRgxovJ1trCV8DngnIaa+AEKN3p52m3
         ECXlNRA43EU1CzeHcgh7k6ZCxwr/dX+53lrs5ukryCXJQDXbwro8bzCzroo3UOHU/HQm
         /+Abu0dYFeDahea2EBPdGlueoMoEeVIjiJqGHrWai7aFSEifrGm0quz50wp3pJdtFu1P
         /pYc9tTfVNlXS8VfvgVS+V1CaNzllnfo0Gz52FQivVOBtW8C0BGYJDyBxyVYeLwcUZe2
         ECVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPZyBDZbtaDKa99PAU0+y0oYIfYiDObvTJMzyweWrTsf/l+5nlYgdbIH7AHrDqJ84MWAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMskDZ0JqKEhXV0UAD5N7sesHZ2tNU3SWJhf2zEQR2zTolVzbQ
	XTSA1wMaarhkwfLLaPF13Np2p/4m0jeQZjnLEa41fWixeKAKEjI7WMzdO0PhAweKXc0=
X-Gm-Gg: ASbGncsOlEaugmz0rWjyFlhp5+6Zb4eVN2hFABfM5PeHmDJ6ZgtE48umwM7kP4tHVOr
	rpeHcfkrjfs9kSXNa823z/yXbWvNVXqzyP8pWG6OD5+o5zL3Qqow5+q3AJQOE5+8TxofHmxvHUG
	+ZgYZK5I4xufhVGG7yBCOrk4ufJFam0QNxkx7nOVzwqwSCmz6U0Gu6To1GDK0QWIq+aq/KSeDwA
	oU0T79ZHZWVrJkVV9EsR0dSpnk2PkLTR8ysOufcGszGIOcp5KQaF4a9DPZykx2s8pawDS9TbKmi
	RyqxxtoggV7akMOXbehNvTl9RcAALshHiBUZkcGCNZ3lxYW9FJGbR4ab3NEmzCCMEWMsL20LWBV
	AoP7Hrz9/ef9S0Ht499RniYLiVkCeGua/9HsCe15/yEICPUQN2iN7G7UV8TlPSAw9cHn12QqNQW
	Xnn/HCgb5Z5Q0aAkzFpEhRL0NojwmfVKEC40U=
X-Google-Smtp-Source: AGHT+IHRvFiXhqhKGhswaKrwdj+38rGDNO0O6flKY3N9ofH2ybrXS29OeON+Zuf+hfhjDs6kYlavFA==
X-Received: by 2002:a17:903:2345:b0:28d:1815:6382 with SMTP id d9443c01a7336-290cb65b674mr293772595ad.46.1761181088046;
        Wed, 22 Oct 2025 17:58:08 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:fa8d:1a05:3c71:d71? ([2620:10d:c090:500::7:b877])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946de00dc7sm4409255ad.39.2025.10.22.17.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 17:58:07 -0700 (PDT)
Message-ID: <f6b72d01a5de0e6cf651eb5fc0cabc9577de536e.camel@gmail.com>
Subject: Re: [RFC bpf-next 12/15] kbuild, module, bpf: Support
 CONFIG_DEBUG_INFO_BTF_EXTRA=m
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com, 
	yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	qmo@kernel.org, ihor.solodrai@linux.dev, david.faust@oracle.com, 
	jose.marchesi@oracle.com, bpf@vger.kernel.org
Date: Wed, 22 Oct 2025 17:58:05 -0700
In-Reply-To: <20251008173512.731801-13-alan.maguire@oracle.com>
References: <20251008173512.731801-1-alan.maguire@oracle.com>
		 <20251008173512.731801-13-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-08 at 18:35 +0100, Alan Maguire wrote:

[...]

> diff --git a/include/linux/module.h b/include/linux/module.h
> index e135cc79acee..c2fceaf392c5 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h

[...]

> @@ -8342,12 +8372,12 @@ static int btf_module_notify(struct notifier_bloc=
k *nb, unsigned long op,
>  {
>  	struct btf_module *btf_mod, *tmp;
>  	struct module *mod =3D module;
> -	struct btf *btf;
> +	struct bin_attribute *attr;
> +	struct btf *btf =3D NULL;
>  	int err =3D 0;
> =20
> -	if (mod->btf_data_size =3D=3D 0 ||
> -	    (op !=3D MODULE_STATE_COMING && op !=3D MODULE_STATE_LIVE &&
> -	     op !=3D MODULE_STATE_GOING))
> +	if (op !=3D MODULE_STATE_COMING && op !=3D MODULE_STATE_LIVE &&
> +	     op !=3D MODULE_STATE_GOING)
>  		goto out;

Removing this check leads to:

  case MODULE_STATE_COMING:
    ...
    btf_mod->btf =3D btf;
    list_add(new: &btf_mod->list, head: &btf_modules);

Even when `btf` is NULL. Why is it necessary?

> =20
>  	switch (op) {
> @@ -8357,8 +8387,10 @@ static int btf_module_notify(struct notifier_block=
 *nb, unsigned long op,
>  			err =3D -ENOMEM;
>  			goto out;
>  		}
> -		btf =3D btf_parse_module(mod->name, mod->btf_data, mod->btf_data_size,
> -				       mod->btf_base_data, mod->btf_base_data_size);
> +		if (mod->btf_data_size > 0) {
> +			btf =3D btf_parse_module(mod->name, mod->btf_data, mod->btf_data_size=
,
> +					       mod->btf_base_data, mod->btf_base_data_size);
> +		}
>  		if (IS_ERR(btf)) {
>  			kfree(btf_mod);
>  			if (!IS_ENABLED(CONFIG_MODULE_ALLOW_BTF_MISMATCH)) {
> @@ -8370,7 +8402,8 @@ static int btf_module_notify(struct notifier_block =
*nb, unsigned long op,
>  			}
>  			goto out;
>  		}
> -		err =3D btf_alloc_id(btf);
> +		if (btf)
> +			err =3D btf_alloc_id(btf);
>  		if (err) {
>  			btf_free(btf);
>  			kfree(btf_mod);
> @@ -8384,32 +8417,45 @@ static int btf_module_notify(struct notifier_bloc=
k *nb, unsigned long op,
>  		list_add(&btf_mod->list, &btf_modules);
>  		mutex_unlock(&btf_module_mutex);
> =20

[...]

Apologies for delayed response, will read through the rest of the
series and pahole changes tomorrow.


