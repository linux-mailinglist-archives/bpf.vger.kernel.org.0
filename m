Return-Path: <bpf+bounces-18577-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 582C681C29A
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 02:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B1721C23FDD
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 01:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E3D23D8;
	Fri, 22 Dec 2023 01:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ty5Xu84B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF3F23B1
	for <bpf@vger.kernel.org>; Fri, 22 Dec 2023 01:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-35d82fb7e86so5625115ab.2
        for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 17:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703207610; x=1703812410; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3alXwihXWER6xNWA7W8O7yf+yrCdLcK7bgb7uBOHA90=;
        b=Ty5Xu84BsrrW9lphuFGjKizdKiVg6NK8lxh/KK4TR3EVfgbVOF6QPuJ7y2Uu/p9o54
         P09f145oBp0F7iYKNeDpRmomeENn77uvQGCs3yzE29E4PSv+1oqF+aoI2vSUoNQUD72N
         XVkU+jbAAlYE2GOLF6ngJHbkbakb+733QX7HdszhA7+CEuxM+8WEVR1InA8SIg1r/B5i
         d7mXePC9ZOHKa/iovW6ID1V2FsKE4JHLDHhU7aQVLQBaJYtMr8jSPaHu6rrlMun3S2PR
         3LMCGuqPGgmbIuWkoO95BETW26AVkXeJ+x8Q/h4lfaXRn7Qx4djFH+gOzOipfRD2Q9oV
         /6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703207610; x=1703812410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3alXwihXWER6xNWA7W8O7yf+yrCdLcK7bgb7uBOHA90=;
        b=ES8/h2Du9+GbJNjQd/lKiluCdvis4FXkfeTfaV4G1FyFzHtuyCI35o4cGV4xwquT7Z
         v0O8m9LSEnWxyZEdPeJVvQ1oA04dvpSvodmXGWEumUlzwH7pGSOO9FAgfNUlBMKB52oy
         NLq5SKeUtZuYo5imsBZdtH1foTg2OPcTqyJZYb3b3z2JOomApgkpmRFwQ9aynGDc9UXT
         STYah1rvPOvvISHQKTHZRYzMYV8K48t31eRB1CP2Q/xs91u1H71+E70ci5jCPF6H/paM
         PsyJRzM3HOxZpkBGgulmAlyW+Adygc7dIqwMPZlscsdsJU4QLGSgV5Bg3B8dug0dlS9G
         Wxjw==
X-Gm-Message-State: AOJu0YwYef92S0uwTS6rsc2ybUNFbx4KbY7bvpes1vpURHQDtUJNVZ+V
	1yhHXrBFmQswndAcRi6Q0N0=
X-Google-Smtp-Source: AGHT+IF53Ep2Kp/x1k7JWK/gDgz0QKaw1ah2W32rZY+5qWkNxrty3diKFN/uEXTFspvcd3QmwIK+ZA==
X-Received: by 2002:a05:6e02:1a0d:b0:35f:bf7a:a8b1 with SMTP id s13-20020a056e021a0d00b0035fbf7aa8b1mr595526ild.49.1703207609989;
        Thu, 21 Dec 2023 17:13:29 -0800 (PST)
Received: from MacBook-Pro-49.local ([2620:10d:c090:400::4:ec38])
        by smtp.gmail.com with ESMTPSA id m10-20020a170902db0a00b001cfcd4eca11sm2249060plx.114.2023.12.21.17.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 17:13:29 -0800 (PST)
Date: Thu, 21 Dec 2023 17:13:26 -0800
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 6/8] libbpf: move BTF loading step after
 relocation step
Message-ID: <jzw4oh2atn2lt6fu7atewdnklmtvojmljb7k4dzkiakbio7n67@l7m5ekf46imv>
References: <20231220233127.1990417-1-andrii@kernel.org>
 <20231220233127.1990417-7-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220233127.1990417-7-andrii@kernel.org>

On Wed, Dec 20, 2023 at 03:31:25PM -0800, Andrii Nakryiko wrote:
>  
> -static int bpf_object__sanitize_and_load_btf(struct bpf_object *obj)
> +static int bpf_object_load_btf(struct bpf_object *obj)
>  {
>  	struct btf *kern_btf = obj->btf;
>  	bool btf_mandatory, sanitize;
> @@ -8091,10 +8091,10 @@ static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const ch
>  	err = bpf_object__probe_loading(obj);
>  	err = err ? : bpf_object__load_vmlinux_btf(obj, false);
>  	err = err ? : bpf_object__resolve_externs(obj, obj->kconfig);
> -	err = err ? : bpf_object__sanitize_and_load_btf(obj);
>  	err = err ? : bpf_object__sanitize_maps(obj);
>  	err = err ? : bpf_object__init_kern_struct_ops_maps(obj);
>  	err = err ? : bpf_object__relocate(obj, obj->btf_custom_path ? : target_btf_path);
> +	err = err ? : bpf_object_load_btf(obj);

Here and in the previous patch:
-bpf_object__create_maps(struct bpf_object *obj)
+static int bpf_object_create_maps(struct bpf_object *obj)

Let's keep __ convention. No need to deviate for these two methods.
Otherwise above loading sequence looks odd and questions pop on why
one method with single underscore and others are with two.

pw-bot: cr

