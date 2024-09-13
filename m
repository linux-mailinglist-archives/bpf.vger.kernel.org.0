Return-Path: <bpf+bounces-39832-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D7997817B
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 15:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E841B2451F
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 13:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBB31DA62A;
	Fri, 13 Sep 2024 13:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/NGqr5H"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6FD43144;
	Fri, 13 Sep 2024 13:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726235334; cv=none; b=n1jcT4u83j3pc1pezYKJ/fY7Jzxo1lm0CrSn+6yaZCL2J6FWSec4PjGncXI6xJb8B5+xk/mhWYrJUl8RHaHGFXaen4+afYiieDdZi5TcjQCrGBnLrY4rq1oVgqddWMLxHAOYaGKCV658e5q0IPy3B6csKxbs+5KB0Zg6ufwSqaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726235334; c=relaxed/simple;
	bh=w9FExomQkO9zLed5+T4zKe7DEkRTD9fEAbX+qeHNS4o=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvi8FlFGkfytNQUXU00MMLnJLhysXs1v+iuXpXlWfkc2Z7z5nCfh4InYPuocPTTpjZUNatY8anUyNXq/hiGjE11KA6E1eXK/UVTcd00U/JG21Bw30VcWYJ8E42LeT/dQ1JO3VIM8V+KCgZCscHAUa3GJRHA894/JlD/5eY8g3fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/NGqr5H; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53654e2ed93so2567769e87.0;
        Fri, 13 Sep 2024 06:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726235330; x=1726840130; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qoTX/lGS0Vd1haNlwbKVAGI/z8WWxdqBKXR6G9V4jtU=;
        b=B/NGqr5HRz3uMZUe9BBud/TV8aRnlYPBgq+UDrc4cGqEZYqFy+DA8Z70jKXtdtVGL+
         42rvmsL6TpWcAMNoAlmDovsVdvPSuBgHa9YsYlUmXwEIYT7jk7xxWtgVXM1tOkhNqpxY
         OUYTUQ1itOeXEDEdhRyNZy3qPyxdyrYkS7dKMeSU+vppJJ3GSpcqC1jp8jvZolFJp446
         s8hIVCfOUApix34yeFp+wwbCZqrqnYNLB2KhYDfggqpkFiDBh5aybOOdH7z9lnzkYTiI
         qRSnHUsKrd8w+cFr0CqMa794jp3dXd3sFlrNECs1Hv8AMh6eQPbzSzIZa7q/tSCxcOdA
         W0VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726235330; x=1726840130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qoTX/lGS0Vd1haNlwbKVAGI/z8WWxdqBKXR6G9V4jtU=;
        b=QMd2m6sMPtDkVcL3uePmogiZcsUsOF7ABAlwKgJwCiNjOChL7mvG8UFXgufTyYuKhP
         VSnS2WIJdFjA+MtV9fEs1wvjoN7zRoWPfKdjUydhMwQumB6PJJD5bfN6NzdE9U4edDHI
         H97zG75KTzwy0JSZoNiIuRbnbxShSYHqkdhkklvDMV+kOGKR5m1XKitKeNMQKgp2GBMl
         EKpcspKPlktFr4wHL2U/5EepmKtZPcEY/N3thR4EVHHQTn3vhrfb6HHV7sNunpfVvBPn
         1kmE86QYlDnHACy2hak7hjrt2Etd/aFmHhNUowI5XFrnrALWQ7gYyXtuVWPf0VrTKRdu
         Txmw==
X-Forwarded-Encrypted: i=1; AJvYcCWywM1F9WF8zaSSnbofbC8c5o+Vd92aCarr+wL2cWNO1jbhhCd0TcFCswCysYm3Hen6cLI=@vger.kernel.org, AJvYcCX3eyr9yEnOtqtVrllo1QqOQbrLsqMIbTUg+miaKxbb0SuXolbuKekEYae/GgWSzzdYRxORpSvTxPfChr78@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8tFvF/HUWQvzqGLWG1iuwUBr0+Cc1r3ZrWOse2och4KbCF8HO
	Y/RNT2LwoH0XslIVz19s3+FP7PFPPo5nS5q2WNrgkylWemrNEn00
X-Google-Smtp-Source: AGHT+IE6PX99BZKkzzTURystMGMFz8NkzEnOs36bsRarMxVipYoi3GfMiI0aeU4VKeXVzd9tFr9CQA==
X-Received: by 2002:a05:6512:4013:b0:52c:842b:c276 with SMTP id 2adb3069b0e04-53678ff49cdmr4297716e87.53.1726235329599;
        Fri, 13 Sep 2024 06:48:49 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25a258a3sm868657566b.89.2024.09.13.06.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 06:48:49 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 13 Sep 2024 15:48:46 +0200
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
Subject: Re: [PATCH bpf-next] libbpf: Fix expected_attach_type set when
 kernel not support
Message-ID: <ZuRCO3_075wY2zbG@krava>
References: <20240913121627.153898-1-chen.dylane@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913121627.153898-1-chen.dylane@gmail.com>

On Fri, Sep 13, 2024 at 08:16:27PM +0800, Tao Chen wrote:
> The commit "5902da6d8a52" set expected_attach_type again with
> filed of bpf_program after libpf_prepare_prog_load, which makes
> expected_attach_type = 0 no sense when kenrel not support the
> attach_type feature, so fix it.
> 
> Fixes: 5902da6d8a52 ("libbpf: Add uprobe multi link support to bpf_program__attach_usdt")
> Signed-off-by: Tao Chen <chen.dylane@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 219facd0e66e..9035edf763a3 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -7343,7 +7343,7 @@ static int libbpf_prepare_prog_load(struct bpf_program *prog,
>  
>  	/* old kernels might not support specifying expected_attach_type */
>  	if ((def & SEC_EXP_ATTACH_OPT) && !kernel_supports(prog->obj, FEAT_EXP_ATTACH_TYPE))
> -		opts->expected_attach_type = 0;
> +		prog->expected_attach_type = 0;
>  
>  	if (def & SEC_SLEEPABLE)
>  		opts->prog_flags |= BPF_F_SLEEPABLE;
> -- 
> 2.25.1
> 

good catch! thanks

I can't remember why it was needed, perhaps we should go back to where it 
was before?

I'm guessing prog->expected_attach_type might not get updated properly and
that might cause issues, not sure

thanks,
jirka


---
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 219facd0e66e..df2244397ba1 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -7353,7 +7353,7 @@ static int libbpf_prepare_prog_load(struct bpf_program *prog,
 
 	/* special check for usdt to use uprobe_multi link */
 	if ((def & SEC_USDT) && kernel_supports(prog->obj, FEAT_UPROBE_MULTI_LINK))
-		prog->expected_attach_type = BPF_TRACE_UPROBE_MULTI;
+		opts->expected_attach_type = BPF_TRACE_UPROBE_MULTI;
 
 	if ((def & SEC_ATTACH_BTF) && !prog->attach_btf_id) {
 		int btf_obj_fd = 0, btf_type_id = 0, err;
@@ -7443,6 +7443,7 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 	load_attr.attach_btf_id = prog->attach_btf_id;
 	load_attr.kern_version = kern_version;
 	load_attr.prog_ifindex = prog->prog_ifindex;
+	load_attr.expected_attach_type = prog->expected_attach_type;
 
 	/* specify func_info/line_info only if kernel supports them */
 	if (obj->btf && btf__fd(obj->btf) >= 0 && kernel_supports(obj, FEAT_BTF_FUNC)) {
@@ -7474,9 +7475,6 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 		insns_cnt = prog->insns_cnt;
 	}
 
-	/* allow prog_prepare_load_fn to change expected_attach_type */
-	load_attr.expected_attach_type = prog->expected_attach_type;
-
 	if (obj->gen_loader) {
 		bpf_gen__prog_load(obj->gen_loader, prog->type, prog->name,
 				   license, insns, insns_cnt, &load_attr,

