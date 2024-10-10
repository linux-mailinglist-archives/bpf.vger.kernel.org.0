Return-Path: <bpf+bounces-41608-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9093998F39
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 20:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 081151C202D5
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 18:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EEF19D078;
	Thu, 10 Oct 2024 18:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgt+wmrk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9AB18CBE5
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 18:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728583367; cv=none; b=FVg+8YMU0CCOE6pr1hHSE9o97wfaditlqpjEYcp6IRxQ2Gii4rYAH+57EFyvnD5lpES4cGhlH/0J1647O5CfAMMAOfkbytXD14k4WDvqSGMRuoCh+crycsY0GlCL8XsHz02SGFgYdKQ83aleiDiG7LNU7baPSZmYIGVg9B0cR2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728583367; c=relaxed/simple;
	bh=aNjHGJt0r9PbQ+O/HzUZMt0ldOrUPq9HCJnYHfq5fM0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y6p8Su//q0CNC5rPITy6ntf7yrliIbrBagzYYbTxyNPt78n+AjMMA1MB8DPt4cbhmtU6rYWpgbAgSo7jAjS4v0B0y/W7rcL7PRk0PNU3k7FjuggQrIpE7xMlI29AAJZScoT/6EDKHCzHQv+gc960W04+0ZkEBN9xjiy1ioPgbrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cgt+wmrk; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71dfc250001so1075701b3a.2
        for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 11:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728583366; x=1729188166; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w0CNx4gQNplxPcLKHELfkILdyyUie1T8OUZ83SnxnX8=;
        b=cgt+wmrkOoTRvB1QYfaU7BFb6qEK4AaoJoGRkeM3H04RW4SPwpeE0GLML2d2BywHoX
         GM6K9W/gcOpHv81PECxdUGXE9EasAoMA4F58fhnubF4kSs/bWao5+5kx53W3+3Xtk5DI
         LXoXkFNmPBVO1snMvdyADaf6ANuIE0lgWHojypAUZ89GiAS1q75C2iV7uMgsC2252B9f
         PKYT/MYgF9qBZvU4ugIg144zIINDPAcsqynKqXbsB8Nek5GYuWfL1PgLunLqbHbpmHRL
         cnqxbnLh8dX1D6XwFlbwHmn8iALQS++pkyaCJX0Oq/4+y82xX7dJ1UqCiIqYn0gCT0jp
         gqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728583366; x=1729188166;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w0CNx4gQNplxPcLKHELfkILdyyUie1T8OUZ83SnxnX8=;
        b=fpCv+Ti2mj7OFQ2fOkOIP0Ytm3ELYnAeuY3zLuWGUjBPLA+ZYS4z1xHE6dqaUz6w4A
         c6SJiJDvNmH3i1A46wiNm2LMa48VWjiuZveRV1wFv3JVc/BW5ZE3+mR38OrYWehXHnEJ
         st1E/eizOn0VN96LryTKBYB/WeWPYDygg3+swvjHdhR5VX+wKWAXamVTn0fhtf5ja/mn
         zRfV9XNyB7Y5VzlGdW/LLKGXSSHgQ1eyUig7KQpRg5ZC7N+Cl6/nApMKUjl7sYBfDVlq
         RO54/YCklwv2rJD1JfL6IdmpR5Hq1qQvPrcPC/VMd5T+4vpjWmyblg5OqIGth9mTY7WQ
         EwcA==
X-Forwarded-Encrypted: i=1; AJvYcCVeIoN/dUEh4oZDvkbSW7YU1bV6dpFpuX+kvjwuevfKq2haTaTHt9aQV9BZtfBcs4v3Njc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYNFbM5N8LLDUgfuPMycn1qLLeFO5QmBbIXIMSkiPgiS3M47dX
	588BhEbvIz0J9MPzxMDxqYq7nWglpeNNYcBuUJ8aYqdXa+Q69E7Y
X-Google-Smtp-Source: AGHT+IGsp+iHTFpKbIYmG//42tyk3yUucm0Nu3RXNLUaQSoeu7drhAUhJVV6IIpvT1ZkfWJoSa3IvA==
X-Received: by 2002:a05:6a21:6b0a:b0:1cf:2438:c9e3 with SMTP id adf61e73a8af0-1d8ad7c8b0emr6625857637.16.1728583365698;
        Thu, 10 Oct 2024 11:02:45 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a:193c:dda:1f58:b7b8? ([2620:10d:c090:600::1:1f0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2aa99a2dsm1298522b3a.106.2024.10.10.11.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 11:02:45 -0700 (PDT)
Message-ID: <47dda61b85917e864eab5cde7e16723a5884ce69.camel@gmail.com>
Subject: Re: [PATCH bpf-next 03/16] bpf: Parse bpf_dynptr in map key
From: Eduard Zingerman <eddyz87@gmail.com>
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Song Liu
 <song@kernel.org>, Hao Luo <haoluo@google.com>, Yonghong Song
 <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa
 <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
 houtao1@huawei.com, xukuohai@huawei.com
Date: Thu, 10 Oct 2024 11:02:37 -0700
In-Reply-To: <20241008091501.8302-4-houtao@huaweicloud.com>
References: <20241008091501.8302-1-houtao@huaweicloud.com>
	 <20241008091501.8302-4-houtao@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-10-08 at 17:14 +0800, Hou Tao wrote:

[...]

> diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
> index 645bd30bc9a9..a072835dc645 100644
> --- a/kernel/bpf/map_in_map.c
> +++ b/kernel/bpf/map_in_map.c

[...]

> @@ -45,9 +45,13 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
>  		 * invalid/empty/valid, but ERR_PTR in case of errors. During
>  		 * equality NULL or IS_ERR is equivalent.
>  		 */
> -		struct bpf_map *ret =3D ERR_CAST(inner_map_meta->record);
> -		kfree(inner_map_meta);
> -		return ret;
> +		ret =3D ERR_CAST(inner_map_meta->record);
> +		goto free;
> +	}
> +	inner_map_meta->key_record =3D btf_record_dup(inner_map->key_record);
> +	if (IS_ERR(inner_map_meta->key_record)) {
> +		ret =3D ERR_CAST(inner_map_meta->key_record);
> +		goto free;

The 'goto free' executes a call to bpf_map_meta_free() which does
btf_put(map_meta->btf), but corresponding btf_get(inner_map->btf) only
happens on the lines below =3D> in case when 'free' branch is taken we
'put' BTF object that was not 'get' by us.

>  	}
>  	/* Note: We must use the same BTF, as we also used btf_record_dup above
>  	 * which relies on BTF being same for both maps, as some members like
> @@ -71,6 +75,10 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
>  		inner_map_meta->bypass_spec_v1 =3D inner_map->bypass_spec_v1;
>  	}
>  	return inner_map_meta;
> +
> +free:
> +	bpf_map_meta_free(inner_map_meta);
> +	return ret;
>  }
> =20
>  void bpf_map_meta_free(struct bpf_map *map_meta)

[...]

