Return-Path: <bpf+bounces-35214-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5826B938B8A
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 10:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A8C42819F3
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 08:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A2016B3AC;
	Mon, 22 Jul 2024 08:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0/xGH9J"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B611684A7;
	Mon, 22 Jul 2024 08:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721638393; cv=none; b=e7ZPhq34qNSNJ5kXRSYOQAnxg33cEvTy/wdZnBaOCvG9OhmbfLy0HJ9hLxAxJe5A5JJfgKK0GZxfbPV/Z1QXT0vb/fLBuVK+oqbKCOISidAKmyZoahomlEMlGslX+8f6VA+6aucREWqahk23GNwaGECwWHQdx53UnSpEejzoJEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721638393; c=relaxed/simple;
	bh=y1yRWrvRLNtYpXWSf96WuRJhUzco+Pej1TdQBcny6YY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZcrJPzl+yu3oUjo6ehTp8g77MWLtATX/lQ4MmLR2NW8xK9vFIgGUSpu+r4TPZcjPuYDFXrN7CWtGMfFSxzUCBQFFKrPt+/hSuUA/J13Tf68r8FhZp4+XrgFddJeudE74vezExQjQdDvShQKMQA3penoKd7OG/Z0OblbJdxlRBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0/xGH9J; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52f04c29588so718520e87.3;
        Mon, 22 Jul 2024 01:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721638389; x=1722243189; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RjQKuOS8Mmoj1EwG/GAC7KkpAM6rBytEEbUs/s5SH1s=;
        b=E0/xGH9JOnEf+8ntEe4hScLy0XIhEenHBarTFSYEnkMdMnIQ33WchbHCb8GgOiOrjk
         yP8rxlGtSSZFjS605E+em2GR0vtPIrLtmAXeWMjifgLrEVb16TfgubdaUZ+3jTSgw2fw
         GfllcR/twPrFe5QMDBuyMqRR+gHW8eirpIdx/ttnEm0W36AzZ8uRqeoeYxV9pQiyLSfp
         uc7F6xQVwrgLVOrz+0G77AVxPyXCGqmZpgvYCfnmw1ON+WnMeNwzyyxfGT5c2FuMff9J
         skIeljt5Wttmr4q5URuJuhNiScydESiOXb3t/IBonw3bKjtF7SrmfIygDS6v7rseZz1S
         Wk6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721638389; x=1722243189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RjQKuOS8Mmoj1EwG/GAC7KkpAM6rBytEEbUs/s5SH1s=;
        b=Ah2i8A/EOHZTqUVsO3YgwmcR3D4SYpf/DD7vLZgNfRns9WJKt6w4e0HP/x/2m0yK6P
         xAsB/73dE/fqrEgQJ0VSs/9T5VMAiwsGm7BNJbvoTD7OS7gwcJZSQC4DHldIWkKROx1g
         X0Kk7g5cR7vcNxqujh6MTSv9Kps/rZsL7DY9NEEOP3hF60jxa8ZW9XxAWi63LnzttS12
         QjCZRsng0bCf+T6c2e/5yPfpGAe+8zdUbm63WnKjsLYVZj1Ux1Zrk+qsb2cYn0EPba3B
         baIpIRe0r9Z3ktGlWvKDKDLBSlCGyYPS4LBFgC7spHMyO1lXLpZiPX+/FVQfP7019Aqg
         7+HA==
X-Forwarded-Encrypted: i=1; AJvYcCXRMRBSUahgMgw8W6BDw/w9Y23icV8zXWp3kl41wS/SXtBO5ZuoDCdc26ACo6PyWV5DNY7EcpkNe9iCAtU18yCh+9dGm8se8U5OKluo
X-Gm-Message-State: AOJu0Yw28XU8AAhenP+QmFW4bz3KvSpCy1jX+3XkOAAQ1zxrc5uG1NR9
	mWTrwVEdP3haN10MuFyfmt9jTmSko2tCwzDfdva2geHie+ZXwf84
X-Google-Smtp-Source: AGHT+IHiNsKZG/7P+pDW+lYQXgxCqCa+SSXBU7aX0unXFLRIe/QTIE274ZFea1UWbDHgMET/oV5tTA==
X-Received: by 2002:a05:6512:2310:b0:52e:f410:fe43 with SMTP id 2adb3069b0e04-52efb852299mr4126804e87.39.1721638389132;
        Mon, 22 Jul 2024 01:53:09 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30c2f8a5fsm5746924a12.62.2024.07.22.01.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 01:53:08 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 22 Jul 2024 10:53:06 +0200
To: Liwei Song <liwei.song.lsong@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	vmalik@redhat.com, alan.maguire@oracle.com, friedrich.vock@gmx.de,
	dxu@dxuuu.xyz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/resolve_btfids: fix comparison of distinct pointer
 types warning in resolve_btfids
Message-ID: <Zp4d8mAt0RYtTAuc@krava>
References: <20240722083305.4009723-1-liwei.song.lsong@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722083305.4009723-1-liwei.song.lsong@gmail.com>

On Mon, Jul 22, 2024 at 04:32:59PM +0800, Liwei Song wrote:
> Add a type cast for set8->pairs to fix below compile warning:
> 
> main.c: In function 'sets_patch':
> main.c:699:50: warning: comparison of distinct pointer types lacks a cast
>   699 |        BUILD_BUG_ON(set8->pairs != &set8->pairs[0].id);
>       |                                 ^~
> 
> Fixes: 9707ac4fe2f5 ("tools/resolve_btfids: Refactor set sorting with types from btf_ids.h")
> Signed-off-by: Liwei Song <liwei.song.lsong@gmail.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  tools/bpf/resolve_btfids/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> index af393c7dee1f..b3edc239fe56 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c
> @@ -696,7 +696,7 @@ static int sets_patch(struct object *obj)
>  			 * Make sure id is at the beginning of the pairs
>  			 * struct, otherwise the below qsort would not work.
>  			 */
> -			BUILD_BUG_ON(set8->pairs != &set8->pairs[0].id);
> +			BUILD_BUG_ON((u32 *)set8->pairs != &set8->pairs[0].id);
>  			qsort(set8->pairs, set8->cnt, sizeof(set8->pairs[0]), cmp_id);
>  
>  			/*
> -- 
> 1.8.3.1
> 

