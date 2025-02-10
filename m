Return-Path: <bpf+bounces-50978-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB76A2EEA5
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 14:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D32C63A1B91
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 13:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E839D230991;
	Mon, 10 Feb 2025 13:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ebe4epgr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BC622E3F7;
	Mon, 10 Feb 2025 13:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739195235; cv=none; b=AV/XmUmCNWJAFzBSRcjBvUrdWyKv50cCIuPfzkxfDD74SonFkOPZeQ2NpXeSHqJgAFCSSIFoveGKSLGimpcHyTBnAbmDOk9SFUYm0dPdgroq59vO4YCHYcsyYSIYN8xAihK2rZQ45P0joVcO+Zf0WRU+FHeGOevO7YBbqdYrbAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739195235; c=relaxed/simple;
	bh=8mwmEo6FmaGsKwNYXI4GJ857v7frasERjv80clOnvDc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XttJ8UtXKAyvyvAE2Al8AaGyusnkM8t0nMaeSG7loYVxzgWNNWa8nJjrSlKIHQS0yi5z8mrJl3WCpAYMSbQj52VKNUAvip3xBkwMSoEyN8kxGoK/SceaNRjQCPsqqrmuUTY2GCN/Kc3ZT/CfpmK8IQPJEQsk6Ig8d66LzBg0/WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ebe4epgr; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38dcb33cba1so1515523f8f.2;
        Mon, 10 Feb 2025 05:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739195232; x=1739800032; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EJO6wTtYDcc4Uk17wc/tbU2dxXofVYT/Cfh+PATg574=;
        b=Ebe4epgrkrBjMmNchwqf/tFUPqhSOPa8+4g9V9IbYUKuqcMvHU1qBRj5hl6l1zyEcZ
         S4KRr3oFim4ElP+eigQNBCWTfY/OQqEwfxToBjksRZhRjQWTC5ieRz3rNRr4EPsOTpcp
         GJUQhkqMHbiXPiyDsXdCJTOYemukStYVhXExeAmfWX0dH2s96C966Ur/zk+NDnZQRYpz
         L47xhPSrTeWXkubkX9AcXBMfdKjS/lvXH9m+t+FfaBDcdwePXOrE6rraw0+jdGrPADZu
         b3LLaCEBmfurgWxrfEhtf+kaaKNAkkc7KQIPNqxfcYSmTo3MouLqh85CIoRfsv1+feoF
         ssOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739195232; x=1739800032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJO6wTtYDcc4Uk17wc/tbU2dxXofVYT/Cfh+PATg574=;
        b=L32a9+ZtdPhe/bnWfHI2RUE9kDXGaMWIrZYZzPYRMZZ2dEJaOpnUl5Pd3b9T4iNejf
         AwlKwO7Bq4GJaqv7D39fSBZaOTyruYEq0cChlblUqmqYwCl0+hTvXvf4uPYNt3spp2kt
         wyFcWL6GetK0WZP3NKr+z8iATaVOk26NjM0FOIrfGRXiflTcOu/OLPSW2mMOm6+iK5Ko
         oE+WJ4XOowey0KpkoUEoExnp02pM9OmJgLwoGoPAX1T1E7Re06gE5T0RHs7+imezcvHG
         9VEjSqT++mC8D6yenESO39F3fNqQ0Ossc35el/VINlXYE66+H1d8W0AZkmcAvaeof2/R
         dQBw==
X-Forwarded-Encrypted: i=1; AJvYcCUb+mfTPYgxOzLUIn1eSUZNFiOkXsyL8/Ivg/BDeFkpFvYAxKSViNMcsY1U8rsw76rqCa+eqWBGJVI4Kcsr@vger.kernel.org, AJvYcCXmpVF0V47Y1EjdPcAlYPAdnM5qP9WemY7mgX/02wUkM0DiJzhebE31xGKBj3oUxdO+KQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmgzxntjfePw5cpudOmJC2evhDEsTZgDY6G1gmZxJYTaKtiUt0
	YCID1JWWehqjlGiBWdLI76FfPeILmljx5ZkUQuzY7bJ/ZqywQgkb
X-Gm-Gg: ASbGncvmBEftBk9I7Gkz12YJiyhpszW0ZTHKJNT94hyyc06591qQ0Y/xrp6utw8AvsQ
	ZzDcGYztNzvEK0I8B3H+gK0aZdWrsn+cmqxEpoNz7HxzbPB3Fc4tU5pu79korPUD1nQYYnzn7Tt
	N6xGbyFu+R4/aQ1ZocIp4OnZmMJEfzTXinoKxwTn0I3I4So25IsnFlWcn5zanoHtkqu53vG9I42
	0hYU4x5UEWXa/lRiWNTn1BUAOXUtKRs3TAbQZ/88KxiX97xUau9ccPlE40T5C+7Uyq9p6SKQyhc
	iQ==
X-Google-Smtp-Source: AGHT+IFyhT1x9aESyLH9Zl5FODdtgAXO6AQKj2bRRSGZZyFo6k4K/MGt9RxO7/bsMxW+3Mtws+kbXQ==
X-Received: by 2002:a05:6000:1865:b0:386:1cd3:8a03 with SMTP id ffacd0b85a97d-38dc9346494mr10104705f8f.32.1739195231813;
        Mon, 10 Feb 2025 05:47:11 -0800 (PST)
Received: from krava ([173.38.220.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dd07fa80csm8162788f8f.13.2025.02.10.05.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 05:47:10 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 10 Feb 2025 14:47:08 +0100
To: Tao Chen <chen.dylane@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, haoluo@google.com, qmo@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 4/4] selftests/bpf: Add
 libbpf_probe_bpf_kfunc API selftests
Message-ID: <Z6oDXNpqmwHo6lKh@krava>
References: <20250210055945.27192-1-chen.dylane@gmail.com>
 <20250210055945.27192-5-chen.dylane@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210055945.27192-5-chen.dylane@gmail.com>

On Mon, Feb 10, 2025 at 01:59:45PM +0800, Tao Chen wrote:
> Add selftests for prog_kfunc feature probing.
> 
>  ./test_progs -t libbpf_probe_kfuncs
>  #153     libbpf_probe_kfuncs:OK
>  Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> 
> Signed-off-by: Tao Chen <chen.dylane@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/libbpf_probes.c  | 118 ++++++++++++++++++
>  1 file changed, 118 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c b/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
> index 4ed46ed58a7b..fc4c9dc2cbed 100644
> --- a/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
> +++ b/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
> @@ -126,3 +126,121 @@ void test_libbpf_probe_helpers(void)
>  		ASSERT_EQ(res, d->supported, buf);
>  	}
>  }
> +
> +static int module_btf_fd(char *module)
> +{
> +	int fd, err;
> +	__u32 id = 0, len;
> +	struct bpf_btf_info info;
> +	char name[64];
> +
> +	while (true) {
> +		err = bpf_btf_get_next_id(id, &id);
> +		if (err && (errno == ENOENT || errno == EPERM))
> +			return 0;
> +		if (err) {
> +			err = -errno;
> +			return err;
> +		}
> +		fd = bpf_btf_get_fd_by_id(id);
> +		if (fd < 0) {
> +			if (errno == ENOENT)
> +				continue;
> +			err = -errno;
> +			return err;

nit, return -errno ?

jirka

> +		}
> +		len = sizeof(info);
> +		memset(&info, 0, sizeof(info));
> +		info.name = ptr_to_u64(name);
> +		info.name_len = sizeof(name);
> +		err = bpf_btf_get_info_by_fd(fd, &info, &len);
> +		if (err) {
> +			err = -errno;
> +			goto err_out;
> +		}
> +		/* find target module btf */
> +		if (!strcmp(name, module))
> +			break;
> +
> +		close(fd);
> +	}
> +
> +	return fd;
> +err_out:
> +	close(fd);
> +	return err;
> +}

SNIP

