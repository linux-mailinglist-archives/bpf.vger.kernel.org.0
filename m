Return-Path: <bpf+bounces-50375-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB49AA26B9F
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 06:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F6121614B8
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 05:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9461FF1CE;
	Tue,  4 Feb 2025 05:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkMGIz1k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587B31F8EEF;
	Tue,  4 Feb 2025 05:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738648703; cv=none; b=LXLt9rKAWiUf+tZGs3h3r8uIiJtDWwYfF5OkYBRkW+OVjRB+OvtsCpbP0i8Pjg7uu+kdAothNWUMHYuhRVTZRGMpSrpLV26XEuhYAF1Nahr4AVr4QXps+laN+XjNGsUglTPPqv+7kPaLygVs/09x5vpKal8zLu1jsyceMgJUr38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738648703; c=relaxed/simple;
	bh=caj/VCaYRYsf3N6t0/iXwaJ6ct/zX5GomeHbT2ZFEbw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fr1w5r2iTXJsYZdQAK0SB+cZUWAT+KHHXW/qiqBbcvOyInpTjAcVdeCbORvdafl4aYlJePVN44l8l1hJpzXrNlholZDeJJpUtTSapr+FCjcmGyQvme3joJqA/RbVTmcAdQ1484GXZrxZvqBt7xboZ68k9rHQzYMiD6r6DhFn0po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IkMGIz1k; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21634338cfdso28294935ad.2;
        Mon, 03 Feb 2025 21:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738648701; x=1739253501; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ieIl7YG1CDgTVGHB5bXAGkZnSM//u3Wh3Tw0yNYmwzk=;
        b=IkMGIz1kYL6GUrjq2F6P/Qzy5dQP10+2KU+UItVROTg9HZY4EBjs/oCIbq7MjFThZD
         S6vhXBd/PnoDw9Ik0ZM+fp2X3BHE64wy3ldePqlU+Rybo1h26xs5v8PNft2IymNN2yPh
         Me0zQBjxmMfnMl7snfC83uVdIUn/WjK2cIDHbblgdpaWTcaurjD5DDsRyFi58pV8pWqP
         G7by3+C19bF2LaOvXtzVS9JPG3XX195WA1MKSHb5eXljiZyQZE4AquRE3tcuTIzoZYCK
         J4FPOmbI0YsK5XVgygSHulFroZ3u0GDGCkzZqDECF4ZPA8ars/lM5xlF9gh6CeoN0gH0
         fOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738648701; x=1739253501;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ieIl7YG1CDgTVGHB5bXAGkZnSM//u3Wh3Tw0yNYmwzk=;
        b=f92LbpDjPI64NMWJdkp8r1ioiX+aF/xRDWSgxWIi9SMCkt9olsez8owe9lMp6Yl09s
         wcNaBTauJHQon+bagCrD0cHLD1xbwxS7BlO6g+3LvLR6JB7VilCnF5YUKWRzsOMHfSxl
         hJ4cIhnO59bU9/DVeQvnnFynYj+37eem/m6Pzyx/hITVF4eb8ebUq5M1vGqy02ik9yZ/
         Tqf8jXZ2Wiy3HGobkJLfa9oqXVMJYS2sylbLt7ugvyfdctFOBraGSgplaFeURIOB80Cv
         xN0gq9iR7vKgtpx21WiesO6+kQRSvSZWZ61y0OdlGxtlKps2OJRjqioDvaN6o8rlJzIK
         tjxA==
X-Forwarded-Encrypted: i=1; AJvYcCVoNMsASIPzCvbit0TsZtZSoIhsbgx3Y3vz0j0HfUj4JNl/1AVsOQFTh8FpPDezBygOZeG/4yM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0s7ih9xVrJLiK5dQifc8KzIC171P0KPqTDiY9KT5t1kZsqM92
	l8ErR0lZJQfiupPKWWzL0qiJF4urFbhWqzF2Nd5MKNft36LQinCP
X-Gm-Gg: ASbGncvob7Z2xJdtEkZTMYx6kQoCaZEKc7Fh1Jqp+jiJkS+F3JSg8AWAWNkK7EdIf8D
	LoOsw9wHlfIB9PgOpsRrXG+RvT4FME6fgUIzrlM6ZYknuMk6worT6JT7T5dOjmv5ueBzK0m8nqm
	ghKYXIlHnAF0EMTCtvH2w+KgWBm/QCh/4zs7WCzV8a+nM1Rt4LZpIb4CHdsa1840gKvj4KbUWTy
	wrukhLM+/0khlbZz6iIvZzPHTTkfB5OphLc5cAXpFl+w0JZuvgZbHBD015t+YdPwxkSTnQ2qddy
	XaUBR4eqz34L
X-Google-Smtp-Source: AGHT+IHUz5lpux36ScAjqul9q75/McM5SX7G6Xu1H4nyYVyqVGc6A5lXZqTOYNTJXa6axeFBe+tSDg==
X-Received: by 2002:a05:6a21:348b:b0:1e1:bdae:e045 with SMTP id adf61e73a8af0-1ed7a535e98mr42184459637.23.1738648701565;
        Mon, 03 Feb 2025 21:58:21 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe6a1a78asm9479783b3a.164.2025.02.03.21.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 21:58:21 -0800 (PST)
Message-ID: <857a9d504cccaf046d869c34a85e970513a403af.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 18/18] selftests/bpf: Test attaching bpf
 qdisc to mq and non root
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	alexei.starovoitov@gmail.com, martin.lau@kernel.org, kuba@kernel.org, 
	edumazet@google.com, xiyou.wangcong@gmail.com, cong.wang@bytedance.com, 
	jhs@mojatatu.com, sinquersw@gmail.com, toke@redhat.com, jiri@resnulli.us, 
	stfomichev@gmail.com, ekarani.silvestre@ccc.ufcg.edu.br,
 yangpeihao@sjtu.edu.cn, 	yepeilin.cs@gmail.com, ming.lei@redhat.com,
 kernel-team@meta.com
Date: Mon, 03 Feb 2025 21:58:16 -0800
In-Reply-To: <20250131192912.133796-19-ameryhung@gmail.com>
References: <20250131192912.133796-1-ameryhung@gmail.com>
		 <20250131192912.133796-19-ameryhung@gmail.com>
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

[...]

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c b/tools/t=
esting/selftests/bpf/prog_tests/bpf_qdisc.c
> index 7e8e3170e6b6..f3158170edff 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
> @@ -86,18 +86,125 @@ static void test_fq(void)
>  	bpf_qdisc_fq__destroy(fq_skel);
>  }
> =20
> +static int netdevsim_write_cmd(const char *path, const char *cmd)
> +{
> +	FILE *fp;
> +
> +	fp =3D fopen(path, "w");
> +	if (!ASSERT_OK_PTR(fp, "write_netdevsim_cmd"))
> +		return -errno;
> +
> +	fprintf(fp, cmd);

I get the following error message when compiling these tests using
clang 19.1.7:

<kernel>/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c:97:14: error: f=
ormat string is not a string literal (potentially insecure) [-Werror,-Wform=
at-security]
   97 |         fprintf(fp, cmd);
      |                     ^~~
<kernel>/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c:97:14: note: tr=
eat the string as an argument to avoid this
   97 |         fprintf(fp, cmd);
      |                     ^
      |  =20

> +	fclose(fp);
> +	return 0;
> +}
> +

[...]


