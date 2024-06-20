Return-Path: <bpf+bounces-32551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7090E90FAD2
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 03:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C735B22470
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 01:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD2E11712;
	Thu, 20 Jun 2024 01:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmUt6j1m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3F2EEAA;
	Thu, 20 Jun 2024 01:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718846343; cv=none; b=MD561CoKXhzLN04rR+s2J3o+Bi8SQA9QnUcbfv9GK2326IFV9bmFsK5vem3nYj1lBtj4NkuQQY6xDe13SRW62zg/0FtW/Bs5x1lwXUqzD5IyKeDOr7dQ/Z1D85KRSxCVuUJoMytXtuPRlbenE6LKVGZ86A8a1/EV+ckAdKFpE80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718846343; c=relaxed/simple;
	bh=CiVOVivRlQIu24Ixw0rbOHAen0kjuJ5zDGUPi3OSZXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CWdWNayFXqjS9VWODuKa1JfJZ9snPYfQyDd+5kDYXgGSUP+q+0vgjrSQNgnG5nhojZhiPT34BtKIyQc5uGOY+BwxVeCOGidtfIYuNh+PbPyivGij5dmwzDJneyz/SxYkqz32VaIr9B5gxVSUjYplwzAUjhHyl/bWRQcqHOuDZ1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UmUt6j1m; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4217d451f69so3791385e9.0;
        Wed, 19 Jun 2024 18:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718846340; x=1719451140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDHT6yLRB/v0oglM9yUXjYWVmzlOS187SihTeCnHq4k=;
        b=UmUt6j1mzbqDEwWnU8Jc7PeSmB6pjyKD2Z1CyZCM9YzQf6gt8gQWZHWL4HotQ1THDR
         s08cHYDMsofHu7d4xKEuLD14OFYWWtK3CCwpIGCAYqHZymV5oMUHgDghwOyy4wuFo/DZ
         TdF4ytInqOCLSI2Bq+PusmLO98q4v09iK6Wb6raaHv34hE/nNR+wZ2ih4x4nCK+5p6YD
         VUhSRgYLCXRPYD6e/M1Db4NDSKsxshyPqly+sQKeNPZtsyrygzU7+uyy83iAcUhr4/x/
         li+x/M/yk5G/9y9uROjamtzjo2rtFwaAFlb1/kisbapBrgKOa1Z47yM5/h/bU3qJzJ+v
         hE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718846340; x=1719451140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uDHT6yLRB/v0oglM9yUXjYWVmzlOS187SihTeCnHq4k=;
        b=T8NJf8TWR9jTIaY4xejO07EyJRCY65o3I14HlXD7VsqXz4zrb9uvEkmfMZChjzZz5U
         Taxa6pI+uZhxAuNciuQmMtjnMq28qMyAk7qkCmP53ugtej+6RFGgqalpzTOm+p8GU5oB
         tmvXe/CyfjlMYDZV4rMWBsI16TrWg1M1t5zcGXKsE3NBqcSqfMsCO3dmVb05+boOm6s4
         e1DXXLoolhloX+JKqVORZgJ4YI2qba67JNAzjO2QmrlP3qwce6t7kCcfZTL0bxVjy9Fm
         3ZW/nNOhFao/EN22eQz+cN11sm2isNjEWKKFxOkdSmUgTbyYViUv7I2N/fMKydTG3fDu
         5F9w==
X-Forwarded-Encrypted: i=1; AJvYcCWDee1KhIr3Zg1uzB9H4uKNqnL4lLiswjuSF2/0c4PMQE5hbfVQ1JVWLGpKWyxr/mcUuYltBUPoXVkMxBl5SVzinCp+akPze/82HWPS/C3vTwoQRWwidmF9UmNZPdF/1d5rXwLhCg+gJ5ila5H7SThJPm7nglmhlTR4asQ84VpgCVArXxCc
X-Gm-Message-State: AOJu0YxlqClnXeE+QH7eKmoaGhlyPYOXg1KiBD2uBQMu4ZqWC/EjP/QQ
	/G+EQlYXGO7C5kVFWZYTwHElaJRfs4MBjW1wCL5YzatUrRXs3GUWvEnAU+KWozswveo0PktHdql
	sn9xMcr/n1r8hiF4ITJfNLeZ6Y58=
X-Google-Smtp-Source: AGHT+IGKhQCbJwrXTD1wLMTOnHS2G1M40SRH7cHaBrBenjcNqfuIlq6OJO1UBMN5+xHWxsPf3hslz7XTNojTJbBeuO4=
X-Received: by 2002:a05:600c:6a09:b0:421:eecc:2404 with SMTP id
 5b1f17b1804b1-424751809e3mr29825415e9.24.1718846339564; Wed, 19 Jun 2024
 18:18:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620-fault-injection-statickeys-v2-0-e23947d3d84b@suse.cz> <20240620-fault-injection-statickeys-v2-5-e23947d3d84b@suse.cz>
In-Reply-To: <20240620-fault-injection-statickeys-v2-5-e23947d3d84b@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 19 Jun 2024 18:18:48 -0700
Message-ID: <CAADnVQLKRAa5_-JUEZwwbrbySDekVdSgEp0UqgqbVfqsgfYjQg@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] bpf: do not create bpf_non_sleepable_error_inject
 list when unnecessary
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 3:49=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> When CONFIG_FUNCTION_ERROR_INJECTION is disabled,
> within_error_injection_list() will return false for any address and the
> result of check_non_sleepable_error_inject() denylist is thus redundant.
> The bpf_non_sleepable_error_inject list thus does not need to be
> constructed at all, so #ifdef it out.
>
> This will allow to inline functions on the list when
> CONFIG_FUNCTION_ERROR_INJECTION is disabled as there will be no BTF_ID()
> reference for them.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  kernel/bpf/verifier.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 77da1f438bec..5cd93de37d68 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -21044,6 +21044,8 @@ static int check_attach_modify_return(unsigned lo=
ng addr, const char *func_name)
>         return -EINVAL;
>  }
>
> +#ifdef CONFIG_FUNCTION_ERROR_INJECTION
> +
>  /* list of non-sleepable functions that are otherwise on
>   * ALLOW_ERROR_INJECTION list
>   */
> @@ -21061,6 +21063,19 @@ static int check_non_sleepable_error_inject(u32 =
btf_id)
>         return btf_id_set_contains(&btf_non_sleepable_error_inject, btf_i=
d);
>  }
>
> +#else /* CONFIG_FUNCTION_ERROR_INJECTION */
> +
> +/*
> + * Pretend the denylist is empty, within_error_injection_list() will ret=
urn
> + * false anyway.
> + */
> +static int check_non_sleepable_error_inject(u32 btf_id)
> +{
> +       return 0;
> +}
> +
> +#endif

The comment reads like this is an optimization, but it's a mandatory
ifdef since should_failslab() might not be found by resolve_btfid
during the build.
Please make it clear in the comment.

