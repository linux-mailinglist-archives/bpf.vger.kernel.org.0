Return-Path: <bpf+bounces-40295-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B90985724
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 12:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38C531C2121D
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 10:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F2315C12F;
	Wed, 25 Sep 2024 10:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqN45XQP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EE980043;
	Wed, 25 Sep 2024 10:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727260143; cv=none; b=L1dc0XvBWLKm8odV/gp4Ga4oyrtFXWm9K4+mhib3SmOSdT9gsymPzkKjBbYfXdj2uyO3g0ghrt8c6CY/mFZMFEDKyF2bDVp5mZVDj3wPi+FBvvXu7aDneQekWBP1Uj/RJhRZ8Uywal1WsZ/le675XBzJUe7jK8xHhyOXh09uJ94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727260143; c=relaxed/simple;
	bh=WSTBzxUvJq6F0Usmjl2MPcBTw/dOIOsfx06UxIbdrIw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBG3TS+8qUkYDdiiT5ovjrmsVXzCT/S59fqA/tJd85sGP7HxivYqTUGGj/3KP4oDb7ybuqKBWTEEcjzw8Jc7S3vfzEdgnRkvjxG5ixdSbnyZKnTrmgmzkrWktEJCGq7JaOzNIPMzz1ZEPSbGCNfICYaOaCnVxx9rxECUCTq0YF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqN45XQP; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8d43657255so1003097566b.0;
        Wed, 25 Sep 2024 03:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727260140; x=1727864940; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rgRvoMIG+H2UABKYQpKtkSjMbSmEhjOGY3wHBFIP/jY=;
        b=nqN45XQPwnsyjNjsv4hvGFdwy/xKEjqkJ9yyh8TYnASqUmNxPORHudToKPCAMoR7SV
         IIeCoTuw8Af7VWVMf/bBXnjvGxB7sVFEv7togfaa0spJgfieqQg0x2LvuTnT9tZfVlcu
         lYzfHIIG0Zi4atoQk5NzkF+mx98Rkcm59+dPuN3UEVCDlz/fGwOBAAr/Uwq+jDvrHYrH
         KJejlMTOiKkX69K/QYPAf7CBE6hXWKRj9KOfLmYJl1LWCa9DFhaZzpU/hQvZK4NUzUyS
         DXdBpMlKWX0hcGE6b4UI/58p8nb738iLgFNPbWyxtl0bSBwZkhxZYvREJlWxpxKje1Jy
         2W0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727260140; x=1727864940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rgRvoMIG+H2UABKYQpKtkSjMbSmEhjOGY3wHBFIP/jY=;
        b=iz8oBGWYf4ZhRux0bq2WXwpRto2UbBy56rXKLX/0m5Af6QTmXmc6NErdyhqPxv14gn
         q9EluCGAP0PKGedOkqtCT7ZNOTkDVDu4pLzR+5Qrw7MHyRiLQQsdDjija2sEzUuQdjk9
         INFtaXL5cfX836LoV/lkqNmytTjr7VYt33NMZB2eHs+962teh+QjxeegacB2ZWefg2dg
         0ZiC95DQSr55QKNyRoa+6KAwg+LTA+xBjuMk6wWu7eI5+SxOvkmjiY5qGV/Dd+hJCIdw
         WCpeIYg2YpaWubh/+13I1xRVry4IxHtvkaEysagTdv2yQqRpu6S8ugOmSUXZ+YINt5mN
         p/YA==
X-Forwarded-Encrypted: i=1; AJvYcCUfaTjzGjS/uZSLR9QZqo+VY/rKs0cQE7OZRyi6VLUQMWC8u8GzlKBxZMW+sTEJ06sDkUTzmEWrsUGSmFI7@vger.kernel.org, AJvYcCVhaNb0otU9XE8ncxk7bTEWBJ5xzk2uX3DP+vqy0OHctTDOltyNgwXJ8cxfCPzrPLXluag=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEW0oNzsaisl41uUfjzn/Y1jUIeIICn5N+JuN3xcqJMB7N5obm
	dnxuafg2F7Ik1NoHICX1sCSYsbmBPwovZURfjZUnSmx/bhPq/eP+
X-Google-Smtp-Source: AGHT+IG1iZOi0Ciw2oJSsAY2bWv+QP4F0kDoLn1prlDx5GTIthgqj9OpQujx4O+tP/xkUWkLdjVWZg==
X-Received: by 2002:a17:907:d05:b0:a86:96ca:7f54 with SMTP id a640c23a62f3a-a93a038408emr179678566b.21.1727260139391;
        Wed, 25 Sep 2024 03:28:59 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9392f50a3bsm194271666b.64.2024.09.25.03.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 03:28:59 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 25 Sep 2024 12:28:57 +0200
To: Tao Chen <chen.dylane@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3] libbpf: Fix expected_attach_type set when
 kernel not support
Message-ID: <ZvPl6Wo4cdihaQ0A@krava>
References: <20240914154040.276933-1-chen.dylane@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240914154040.276933-1-chen.dylane@gmail.com>

On Sat, Sep 14, 2024 at 11:40:40PM +0800, Tao Chen wrote:
> The commit "5902da6d8a52" set expected_attach_type again with
> field of bpf_program after libpf_prepare_prog_load, which makes
> expected_attach_type = 0 no sense when kenrel not support the
> attach_type feature, so fix it.
> 
> Fixes: 5902da6d8a52 ("libbpf: Add uprobe multi link support to bpf_program__attach_usdt")
> Suggested-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Tao Chen <chen.dylane@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> Change list:
> - v2 -> v3:
>     - update BPF_TRACE_UPROBE_MULTI both in prog and opts suggedted by
>       Andrri
> - v1 -> v2:
>     - restore the original initialization way suggested by Jiri
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 219facd0e66e..a78e24ff354b 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -7352,8 +7352,14 @@ static int libbpf_prepare_prog_load(struct bpf_program *prog,
>  		opts->prog_flags |= BPF_F_XDP_HAS_FRAGS;
>  
>  	/* special check for usdt to use uprobe_multi link */
> -	if ((def & SEC_USDT) && kernel_supports(prog->obj, FEAT_UPROBE_MULTI_LINK))
> +	if ((def & SEC_USDT) && kernel_supports(prog->obj, FEAT_UPROBE_MULTI_LINK)) {
> +		/* for BPF_TRACE_KPROBE_MULTI, user might want to query exected_attach_type
> +		 * in prog, and expected_attach_type we set in kenrel is from opts, so we
> +		 * update both.
> +		 */

s/K/U/ in BPF_TRACE_KPROBE_MULTI in above comment and 'kenrel' typo

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

>  		prog->expected_attach_type = BPF_TRACE_UPROBE_MULTI;
> +		opts->expected_attach_type = BPF_TRACE_UPROBE_MULTI;
> +	}
>  
>  	if ((def & SEC_ATTACH_BTF) && !prog->attach_btf_id) {
>  		int btf_obj_fd = 0, btf_type_id = 0, err;
> @@ -7443,6 +7449,7 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
>  	load_attr.attach_btf_id = prog->attach_btf_id;
>  	load_attr.kern_version = kern_version;
>  	load_attr.prog_ifindex = prog->prog_ifindex;
> +	load_attr.expected_attach_type = prog->expected_attach_type;
>  
>  	/* specify func_info/line_info only if kernel supports them */
>  	if (obj->btf && btf__fd(obj->btf) >= 0 && kernel_supports(obj, FEAT_BTF_FUNC)) {
> @@ -7474,9 +7481,6 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
>  		insns_cnt = prog->insns_cnt;
>  	}
>  
> -	/* allow prog_prepare_load_fn to change expected_attach_type */
> -	load_attr.expected_attach_type = prog->expected_attach_type;
> -
>  	if (obj->gen_loader) {
>  		bpf_gen__prog_load(obj->gen_loader, prog->type, prog->name,
>  				   license, insns, insns_cnt, &load_attr,
> -- 
> 2.25.1
> 

