Return-Path: <bpf+bounces-40074-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DBF97C2C3
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 04:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B52901C210E7
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 02:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C036B1DA4C;
	Thu, 19 Sep 2024 02:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sb0ya/pA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB979F9CB;
	Thu, 19 Sep 2024 02:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726711514; cv=none; b=gk0EG3RpGL4VCQeFVuWEE6qShJI4PCnfmSdYZBzSWdS2LIFje6g6BDnTVNgiNVX2Wrbrh42OtfIsZ2szNHVX34RyDgN0F2UyaOEGSG7xJ4Q3FX7ADgx9WP0TeC8axy1jRMPlP8hmizdiOjUcrpuHheMeOkkcc4veA0zkZqkjHzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726711514; c=relaxed/simple;
	bh=N8FdTUGuNmyq2lJnYRM2xWPYHgj7Ddsxz1LbksvKpKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H1rhHJ+QLKO3Hxsuxv77yKhCyXgrwkEh7ro2teStzMrT0cVdJ+LIrzZlMN5cKavOGo9ardWqJAicJjtZLt9MVVLdVnXXubNLWPePxkeBcMxfvv3AU33JpTlA3U+7JyiAiFK8BXl4Qp8IvHjxC1JVZKqe0biwSqZKh8hJ7eeggWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sb0ya/pA; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20570b42f24so4420785ad.1;
        Wed, 18 Sep 2024 19:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726711512; x=1727316312; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZDcfVUFW8U6sCU8KMMZQLNLYtDHuq8VjwOV5ohHb+s=;
        b=Sb0ya/pA6O8ttMQy0IVQGUq6CHt6CqSOTo3cNbAEzD2PAz0SYJzG+5vnz05DBwK+bB
         7U4IAAJP6g48ll0Jsoys5Fw+gJMUnzloNTjFtXWmTObvrUZwUZMOFeUyUosBZmBhK7So
         SFBEmpyJzcS9vzlpzPprS1Ivk5AXKyT5YAV4lod7KW7P5W5qivSKWp4PoEyv5mVvJriB
         sMjXlGYw03CVshRPJi7p6tSTix2BKyYpm87ryYUBvsKAi8vqtcGrXalcuQ7IPJPAaWrf
         DYm0tG4ZkufLDcl54Qg6DlnxjwL3FA1G8XW9V2LZsc3mtt7H7SsX/k7B5I3BS23kRufL
         vrNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726711512; x=1727316312;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GZDcfVUFW8U6sCU8KMMZQLNLYtDHuq8VjwOV5ohHb+s=;
        b=EXvN3D9uAklY9eEoEerZeT7NbRd798VrcyxPqF2/EjPwwrPnCypZa4axFBgPls59+x
         W2u90ikRR0d511OkP9EzcBj1MXpppXUNjZszEbEZ8GljG5K74QsFvkrdrdIYdjsgy+9E
         plqgcCHJf3uy49XBP3ifMU/gf8m+EdV7BiyOPWCSmjxWY7p9LYbjqo7hhC5wyB2ufURq
         D1ZRLcoocWCd9ba3Oviacp40VhANzd3CBeFBdsGXtH4n94aEZVRIzYBz1gqKt+iy1DY1
         2M2HfWbdxfTsuTm/Az4S0U4fqerIoKmchXOMy/S09UxTox3TNCoU9Mtd25mhY/HkpbTs
         bKZg==
X-Forwarded-Encrypted: i=1; AJvYcCXL1vxvbhmIm5l2pcwYEqAresRffxxF5P4vgXvAsQV0G1gp84YbMtGbQpKJC7Z4l/V7ormwReXH9kBHr8s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3MAdeBDCDTXAgvNkjZ9y+XK40cjOwsESm9chCGkcTgjz2onDK
	/76MdMaHF264bwv1cz8O3gkcKlxZT53Ypf7SXb5JyXFQdSdt4gTW
X-Google-Smtp-Source: AGHT+IF4E97Dq5yWY5wvxtNtVfE2yTUsUnMNtZ5I5HWN1h1PX0a+yOSHv7UiQtzqHc3Jzgo5UcswbA==
X-Received: by 2002:a17:902:da85:b0:205:3aa8:f22f with SMTP id d9443c01a7336-2076e3f8e09mr391127755ad.46.1726711511886;
        Wed, 18 Sep 2024 19:05:11 -0700 (PDT)
Received: from [0.0.0.0] ([154.16.27.191])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db499935c5sm8086893a12.68.2024.09.18.19.05.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2024 19:05:11 -0700 (PDT)
Message-ID: <8bcac2c4-80fc-4807-9e77-5dc253b10568@gmail.com>
Date: Thu, 19 Sep 2024 10:05:03 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3] libbpf: Fix expected_attach_type set when
 kernel not support
To: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240914154040.276933-1-chen.dylane@gmail.com>
From: Tao Chen <chen.dylane@gmail.com>
In-Reply-To: <20240914154040.276933-1-chen.dylane@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2024/9/14 23:40, Tao Chen 写道:
> The commit "5902da6d8a52" set expected_attach_type again with
> field of bpf_program after libpf_prepare_prog_load, which makes
> expected_attach_type = 0 no sense when kenrel not support the
> attach_type feature, so fix it.
> 
> Fixes: 5902da6d8a52 ("libbpf: Add uprobe multi link support to bpf_program__attach_usdt")
> Suggested-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Tao Chen <chen.dylane@gmail.com>
> ---
>   tools/lib/bpf/libbpf.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> Change list:
> - v2 -> v3:
>      - update BPF_TRACE_UPROBE_MULTI both in prog and opts suggedted by
>        Andrri
> - v1 -> v2:
>      - restore the original initialization way suggested by Jiri
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 219facd0e66e..a78e24ff354b 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -7352,8 +7352,14 @@ static int libbpf_prepare_prog_load(struct bpf_program *prog,
>   		opts->prog_flags |= BPF_F_XDP_HAS_FRAGS;
>   
>   	/* special check for usdt to use uprobe_multi link */
> -	if ((def & SEC_USDT) && kernel_supports(prog->obj, FEAT_UPROBE_MULTI_LINK))
> +	if ((def & SEC_USDT) && kernel_supports(prog->obj, FEAT_UPROBE_MULTI_LINK)) {
> +		/* for BPF_TRACE_KPROBE_MULTI, user might want to query exected_attach_type
> +		 * in prog, and expected_attach_type we set in kenrel is from opts, so we
> +		 * update both.
> +		 */
>   		prog->expected_attach_type = BPF_TRACE_UPROBE_MULTI;
> +		opts->expected_attach_type = BPF_TRACE_UPROBE_MULTI;
> +	}
>   
>   	if ((def & SEC_ATTACH_BTF) && !prog->attach_btf_id) {
>   		int btf_obj_fd = 0, btf_type_id = 0, err;
> @@ -7443,6 +7449,7 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
>   	load_attr.attach_btf_id = prog->attach_btf_id;
>   	load_attr.kern_version = kern_version;
>   	load_attr.prog_ifindex = prog->prog_ifindex;
> +	load_attr.expected_attach_type = prog->expected_attach_type;
>   
>   	/* specify func_info/line_info only if kernel supports them */
>   	if (obj->btf && btf__fd(obj->btf) >= 0 && kernel_supports(obj, FEAT_BTF_FUNC)) {
> @@ -7474,9 +7481,6 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
>   		insns_cnt = prog->insns_cnt;
>   	}
>   
> -	/* allow prog_prepare_load_fn to change expected_attach_type */
> -	load_attr.expected_attach_type = prog->expected_attach_type;
> -
>   	if (obj->gen_loader) {
>   		bpf_gen__prog_load(obj->gen_loader, prog->type, prog->name,
>   				   license, insns, insns_cnt, &load_attr,

Hi, guys, please review this patch again, the previous versions:
v1:
https://lore.kernel.org/bpf/20240913121627.153898-1-chen.dylane@gmail.com/
v2:
https://lore.kernel.org/bpf/20240913164355.176021-1-chen.dylane@gmail.com/

-- 
Best Regards
Dylane Chen

