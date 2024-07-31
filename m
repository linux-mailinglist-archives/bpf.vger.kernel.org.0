Return-Path: <bpf+bounces-36169-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F8F94377D
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 23:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 166B41C21FD6
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 21:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F400614F123;
	Wed, 31 Jul 2024 21:02:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62693F9C5
	for <bpf@vger.kernel.org>; Wed, 31 Jul 2024 21:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722459757; cv=none; b=sZ/oBzDMJtBbv+iGNp01gB0RwRP/CsqGydiXqgi06n4Oiank2BjN946JEcUUc+nQraoxmEPxL3Wq8V2qiHulTKrLx9fOj/T5/TxH2WHGekQq//0lYq08ksyuIkS1olC/azQ6ocRmJKSOpd8GuN3RmMjHYoZcPbym1sBL3xSSFoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722459757; c=relaxed/simple;
	bh=clY/bfqKCJEHYihetMz9R9IT5V3X31/D//p0MbxJ08w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qo2Zi0j+t8FoyinUy53r7KwKeaHl0wD75pcD8kDPgv4Doxxta3TntEEVuBVVFtLILXSu4xE+X13NN/MQHSwqPso2NdDkjlbStD+WbG3rbIrnefSm61nz+NCdOPgquWaG9Bc9yzqGKdPjad/6c6NMUyQf4XmoP/mI93XJ8riJgeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fc52394c92so54326635ad.1
        for <bpf@vger.kernel.org>; Wed, 31 Jul 2024 14:02:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722459755; x=1723064555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/VzzIWY8iaG1dOUfh4BmTtHn6w7ZRJUkwf8GZS2bdw=;
        b=ev1Xg4Nv2CNrGJvvHq8sBXsVJftVfeSa97akYQP1jTF8nAdq5E+aeGB9KgrVJqGkLE
         w74HyWQa+0Zd5yjwU1+pmDHDiuRGrmN60IeY3TgyMPtYjZRQNFCRTn+b+KomxRBMM4Ql
         OPZMcjOVuIBFxn7Mws5Dc+0/jlq7UikjoMCiogNfSvPug5HCaye4AOm0Kwi2aF0ydGWE
         f0Oe5LwgnN+rY36DgZpij4AUw5zcaGncR2wKKBANme2Ctfa+Jgqa0Fn/9MxAcVEd2ayI
         Y5/2lgra1ZbcFVTfCk2dfxY8lOTZfVtg7Bw6mW6bUOCXXTV99tbc7nQ/4+Lx6y+TA3nC
         nKzg==
X-Gm-Message-State: AOJu0YxQhuuJhUIa71iDi5B+m6ZfdVCg+5UUxdDZL+i5XHnVIwSJR4ad
	oUVb+sx4p8hGkvTKGzdsFYrEQ9hbJWp892hcOlaF9N9YpY57nzk=
X-Google-Smtp-Source: AGHT+IEWYbdEeb0owmkkbEyLMg7Q/XGX7sHbAOa0pPYTwC/P5LAgHgTJflyNo2a2SGFLeDMCAlzGGQ==
X-Received: by 2002:a17:902:e54e:b0:1fc:327a:1f42 with SMTP id d9443c01a7336-1ff4ce5881amr7055365ad.6.1722459754830;
        Wed, 31 Jul 2024 14:02:34 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c8c9d3sm125309875ad.3.2024.07.31.14.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 14:02:34 -0700 (PDT)
Date: Wed, 31 Jul 2024 14:02:33 -0700
From: Stanislav Fomichev <sdf@fomichev.me>
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
	song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
	geliang@kernel.org, sinquersw@gmail.com, kuifeng@meta.com
Subject: Re: [PATCH bpf-next v4 3/6] selftests/bpf: netns_new() and
 netns_free() helpers.
Message-ID: <ZqqmaXpz_xlc6ZJn@mini-arch>
References: <20240731193140.758210-1-thinker.li@gmail.com>
 <20240731193140.758210-4-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240731193140.758210-4-thinker.li@gmail.com>

On 07/31, Kui-Feng Lee wrote:
> netns_new()/netns_free() create/delete network namespaces. They support the
> option '-m' of test_progs to start/stop traffic monitor for the network
> namespace being created for matched tests.
> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>  tools/testing/selftests/bpf/network_helpers.c | 26 ++++++
>  tools/testing/selftests/bpf/network_helpers.h |  2 +
>  tools/testing/selftests/bpf/test_progs.c      | 80 +++++++++++++++++++
>  tools/testing/selftests/bpf/test_progs.h      |  4 +
>  4 files changed, 112 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
> index a3f0a49fb26f..f2cf43382a8e 100644
> --- a/tools/testing/selftests/bpf/network_helpers.c
> +++ b/tools/testing/selftests/bpf/network_helpers.c
> @@ -432,6 +432,32 @@ char *ping_command(int family)
>  	return "ping";
>  }
>  
> +int make_netns(const char *name)
> +{

[..]

> +	char cmd[128];
> +	int r;
> +
> +	snprintf(cmd, sizeof(cmd), "ip netns add %s", name);
> +	r = system(cmd);

I doubt that we're gonna see any real problems with that in the tests,
but maybe easier to use apsrint and avoid dealing with fixed 128-byte
string?

> +	if (r > 0)
> +		/* exit code */
> +		return -r;
> +	return r;
> +}
> +
> +int remove_netns(const char *name)
> +{
> +	char cmd[128];
> +	int r;
> +
> +	snprintf(cmd, sizeof(cmd), "ip netns del %s >/dev/null 2>&1", name);
> +	r = system(cmd);
> +	if (r > 0)
> +		/* exit code */
> +		return -r;
> +	return r;
> +}
> +
>  struct nstoken {
>  	int orig_netns_fd;
>  };
> diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
> index cce56955371f..f8aa8680a640 100644
> --- a/tools/testing/selftests/bpf/network_helpers.h
> +++ b/tools/testing/selftests/bpf/network_helpers.h
> @@ -93,6 +93,8 @@ struct nstoken;
>  struct nstoken *open_netns(const char *name);
>  void close_netns(struct nstoken *token);
>  int send_recv_data(int lfd, int fd, uint32_t total_bytes);
> +int make_netns(const char *name);
> +int remove_netns(const char *name);
>  
>  static __u16 csum_fold(__u32 csum)
>  {
> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> index 95643cd3119a..f86d47efe06e 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
> @@ -1074,6 +1074,86 @@ int compare_stack_ips(int smap_fd, int amap_fd, int stack_trace_len)
>  	return err;
>  }
>  
> +struct netns_obj {
> +	char nsname[128];
> +	struct tmonitor_ctx *tmon;
> +	struct nstoken *nstoken;
> +};
> +
> +/* Create a new network namespace with the given name.
> + *
> + * Create a new network namespace and set the network namespace of the
> + * current process to the new network namespace if the argument "open" is
> + * true. This function should be paired with netns_free() to release the
> + * resource and delete the network namespace.
> + *
> + * It also implements the functionality of the option "-m" by starting
> + * traffic monitor on the background to capture the packets in this network
> + * namespace if the current test or subtest matching the pattern.
> + *
> + * name: the name of the network namespace to create.
> + * open: open the network namespace if true.
> + *
> + * Return: the network namespace object on success, NULL on failure.
> + */
> +struct netns_obj *netns_new(const char *name, bool open)
> +{
> +	struct netns_obj *netns_obj = malloc(sizeof(*netns_obj));
> +	int r;
> +
> +	if (!netns_obj)
> +		return NULL;
> +	memset(netns_obj, 0, sizeof(*netns_obj));
> +
> +	strncpy(netns_obj->nsname, name, sizeof(netns_obj->nsname));
> +	netns_obj->nsname[sizeof(netns_obj->nsname) - 1] = '\0';

Same here. Seems easier to have "char *nsname" and do
netns_obj->nsname = strdup(name) here. Trimming the name, in theory,
is problematic because do do remove_netns(netns_obj->nsname) later
on (with potentially trimmed name).

But, again, probably not a huge deal in the selftests. So up to you on
whether you want to address it or not.

