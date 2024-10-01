Return-Path: <bpf+bounces-40655-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AA098BAB3
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 13:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 155C81C21DC6
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 11:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0031BF311;
	Tue,  1 Oct 2024 11:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhdrTGwk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466421885A4
	for <bpf@vger.kernel.org>; Tue,  1 Oct 2024 11:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727781219; cv=none; b=PdoCiFK3X7/VzVl+BpfMHOfqKVuxuDEG7QhR9Q8k8lvIvFwIRAnxAEpG8SWJ6kh9lhG502hM8lAusi6fLn5XlL1ogzGw9OMUpSirgnRcBYq2XiAz0YznuIajT142EN5nZUbX3/A/QJvUwFJXl/SyOzUKnLMoxiYTv08DqvHYYbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727781219; c=relaxed/simple;
	bh=j/ow1SqXaXWd3ngspyFoIzfvJ2QE2LBwzTdiDoVMWuk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r0WGztEn4ii8+N6V70Cgq0xgvYw2JvLq/jB1XL3qdLCjoIAOCC2It7Bo9s+GNob4W8SIDYLnSK9mP72CPBqbc3rjJeRMQyoVzbpRdYT3fXwtlC9630KrK5vsIZ9Z320+9N5Tbu0KPbXOCr2HJgf59shALZoCLtn2dCzQN6tEqec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PhdrTGwk; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-718d6ad6050so4503937b3a.0
        for <bpf@vger.kernel.org>; Tue, 01 Oct 2024 04:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727781217; x=1728386017; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=de4D0FxaB1tCbU62T1FcqZG1iq6lvQ00dIOq54kdNUU=;
        b=PhdrTGwkiD6ZFAMdxpdg8+NwiRIdw7wcQ0xKTaU3QS497fXZO/S0Jw7m4g85x3y2uk
         SLiuAh8pU/bd3ydHfnFr53qbs0CfhhBwWBpmyhbuCQtaSTNE2XMOMOX3pNoRscE2B/ug
         24FLBaR8NVxUECVfbQID+/oMVm4RT4b8/wBOeJDhehmH0WKwBgP87MSCrZbyVOpNfUUJ
         RMYlGZWXYqcpQhXfovdAk+YZ2kHL1/RVHhQHSrRxlvlkugkLbTVrHameC+FgcdVovsYb
         PK5wXUFNoROchHHxtmuyxZ2o782pI9h1OWXJ5/QtcE4hOI8fyHortDuokX0xDk0704P4
         B7SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727781217; x=1728386017;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=de4D0FxaB1tCbU62T1FcqZG1iq6lvQ00dIOq54kdNUU=;
        b=v+j9R7EZ1v653FaJ9+g2LgQPGfNYaCX7lAjd/E9Rik6/eKhqs09J+QB5hDDyMIBu4T
         XDROenTo+HWZeskIPk3M6lCBuPkU2dHD19KdQ0k9ZsDlwDbE3k+ry9yGCw+Z5lH93mxH
         5yHamuGw5KJHVG7O/JBrJUItzgZcVdkPwE4VxjF3inMSQpNi1fHgEVEMKe+VV5wZaD7Y
         jrpyIJvYsB2HCj4lldH3Z9JU4yveeaVm7CHaQN2ffSG5KUokWgQphClkP7MLQqQfelba
         xqszhX69FxAXcCSv4p0JAevwYTvv73HZ+mGIhN7Yy7NdWp5D+dJN7TC/d7XlPvDpqglN
         EEjw==
X-Forwarded-Encrypted: i=1; AJvYcCU5vmgI96RmgPMfHtTVI+YH6LtVaK0la6Rt8C6ZyuFArINctU7ZTTqrQQ5QWsDQizX/eRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmhCLhDkEGWACGEW5jwi5GR0DIPmzzUqF9v08m4hqpjKaGnCCe
	uPYxfteWN/sskp1PbjOMMRf353iul4nW3X+hV34Aqkr30crUvnJB
X-Google-Smtp-Source: AGHT+IFTBdNCigXfX07ohCF6veETP0rhuFMOW29fKEck+QBX7ITgh1nt35/NIagt3BdS6ozo2Y3TDg==
X-Received: by 2002:a05:6a00:3d02:b0:717:8e49:37ce with SMTP id d2e1a72fcca58-71b2604c1d8mr22671032b3a.21.1727781217396;
        Tue, 01 Oct 2024 04:13:37 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264bebedsm7771894b3a.85.2024.10.01.04.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 04:13:36 -0700 (PDT)
Message-ID: <916f579cce8397b45790b1db68ad2a61cce4dfd8.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 1/4] bpf: Prevent updating extended prog to
 prog_array map
From: Eduard Zingerman <eddyz87@gmail.com>
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 toke@redhat.com,  martin.lau@kernel.org, yonghong.song@linux.dev,
 puranjay@kernel.org,  xukuohai@huaweicloud.com, iii@linux.ibm.com,
 kernel-patches-bot@fb.com
Date: Tue, 01 Oct 2024 04:13:31 -0700
In-Reply-To: <20240929132757.79826-2-leon.hwang@linux.dev>
References: <20240929132757.79826-1-leon.hwang@linux.dev>
	 <20240929132757.79826-2-leon.hwang@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-09-29 at 21:27 +0800, Leon Hwang wrote:

[...]

> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 79660e3fca4c1..4a4de4f014be9 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -947,16 +947,29 @@ static void *prog_fd_array_get_ptr(struct bpf_map *=
map,
>  				   struct file *map_file, int fd)
>  {
>  	struct bpf_prog *prog =3D bpf_prog_get(fd);
> +	bool is_extended;
> =20
>  	if (IS_ERR(prog))
>  		return prog;
> =20
> -	if (!bpf_prog_map_compatible(map, prog)) {
> -		bpf_prog_put(prog);
> -		return ERR_PTR(-EINVAL);
> -	}
> +	if (!bpf_prog_map_compatible(map, prog))
> +		goto out_put_prog;
> +
> +	mutex_lock(&prog->aux->ext_mutex);
> +	is_extended =3D prog->aux->is_extended;
> +	mutex_unlock(&prog->aux->ext_mutex);
> +	if (is_extended)
> +		/* Extended prog can not be tail callee. It's to prevent a
> +		 * potential infinite loop like:
> +		 * tail callee prog entry -> tail callee prog subprog ->
> +		 * freplace prog entry --tailcall-> tail callee prog entry.
> +		 */
> +		goto out_put_prog;

Nit: I think return value should be -EBUSY in this case.

> =20
>  	return prog;
> +out_put_prog:
> +	bpf_prog_put(prog);
> +	return ERR_PTR(-EINVAL);
>  }
>

[...]

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index a8f1808a1ca54..db17c52fa35db 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3212,14 +3212,23 @@ static void bpf_tracing_link_release(struct bpf_l=
ink *link)
>  {
>  	struct bpf_tracing_link *tr_link =3D
>  		container_of(link, struct bpf_tracing_link, link.link);
> -
> -	WARN_ON_ONCE(bpf_trampoline_unlink_prog(&tr_link->link,
> -						tr_link->trampoline));
> +	struct bpf_prog *tgt_prog =3D tr_link->tgt_prog;
> +
> +	if (link->prog->type =3D=3D BPF_PROG_TYPE_EXT) {
> +		mutex_lock(&tgt_prog->aux->ext_mutex);
> +		WARN_ON_ONCE(bpf_trampoline_unlink_prog(&tr_link->link,
> +							tr_link->trampoline));
> +		tgt_prog->aux->is_extended =3D false;

In case if unlink fails is_extended should not be reset.

> +		mutex_unlock(&tgt_prog->aux->ext_mutex);
> +	} else {
> +		WARN_ON_ONCE(bpf_trampoline_unlink_prog(&tr_link->link,
> +							tr_link->trampoline));
> +	}
> =20
>  	bpf_trampoline_put(tr_link->trampoline);
> =20
>  	/* tgt_prog is NULL if target is a kernel function */
> -	if (tr_link->tgt_prog)
> +	if (tgt_prog)
>  		bpf_prog_put(tr_link->tgt_prog);
>  }

[...]


