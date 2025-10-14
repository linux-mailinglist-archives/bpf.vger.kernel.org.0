Return-Path: <bpf+bounces-70903-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE85BD9611
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 14:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 90AB43542CA
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 12:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABDA313543;
	Tue, 14 Oct 2025 12:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbEmLxNY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E97B29DB88
	for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 12:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760445579; cv=none; b=LSmv5pTIgZE1AL1KCdhEHyTLT8brQi6YEhOBn1I3wRw9Ek7Zv4AtsMpSdK7C4jQekehYFy9h+KrilMgrRkWnf2Nfxu0onaFq8TIrkr7iT9M+IXSsoAa7wPdrirqJyBK/moe6bLffbX2O94TPCa/gwtYM+mdh8p5v7v7Vjxbs0m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760445579; c=relaxed/simple;
	bh=Nh8d18yC3F1kVol5wJ2x8b4hEbrylXUjjaWq7mzK5pU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dGox1RX/Cwj33B2V0Ifxe5PnHZ71tas1HT1rLUE1WoF9sKnAedBBtOVXgwVFYqAGMbnptbD+CluxjgBaE+HAj/F1oHDmmwUD5RhMyw2NIsqwIcvo7ms9w1gVC6/0LLzJxtvumlBRlHvPSvBamYb+qJjKrwobF94mxieDLWdhu04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WbEmLxNY; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b3d5088259eso788289066b.1
        for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 05:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760445576; x=1761050376; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iOKsSRK0fMY53Nno3tXGDrP+nfAG/MScFpySFc8rN2Q=;
        b=WbEmLxNYEeVpBmJQNFGLvmO8pi3NWaNjeh6F6rAwtXlkmC5Zq0y8HvuxTu72loa3Qk
         0DPqZHspoSktweJ5z4WdeAOZO7kqV9gEE4vt/fJyhAL/yIkWd0fnkPp+TqSaqlRh08Xp
         f1cSecJ53U1r5nHoE7cJ2OFKWeCv0184VJ73HAO6ySVdd6V9jWy67k4oJqMk0brNpFHU
         LgUy44vgJFjCkUdFZm3HUWrbYAAHsDPOoFtazbJcRe5w6P8miNArs3IYwkLSUiXbH86+
         EC+Yd3cjwYO1/d05ixrBm2l6q/dSuBrY1EAdOt15gOoPPQBKl22FW8Xl66QJtxeDvYqb
         nnZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760445576; x=1761050376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOKsSRK0fMY53Nno3tXGDrP+nfAG/MScFpySFc8rN2Q=;
        b=i7kXXvmr+EftRVY/gveearLsG3THy6IZk6saUd5AXyHD67umPWnufvTkjhPOXGM6lJ
         y4t7MdEQKuyG2xcf201vhd+s8sUwSmJ65Oy5spHFk8mv/NwLaZZLHR+Zjw2h5ykzwN7L
         25ydoujvOazjUshgN18Ix8Qh/Lbv51Su1qabsR3JV7Qvt1dzCjMXsO+4oRHe8AV7pVdz
         KFr3B9ICKtXHTqR+ls7fSABAaq42+UT0WGpJWdb+HZkvl5dItuLn1RaThtEAGXaULM2Y
         c5IUClocRajzvf3d8LFilbojdKInLWMflSBc3x3e2Zfk+V5U3USGYTpWI0+XVq3dY8T8
         FEdQ==
X-Gm-Message-State: AOJu0YxWA+Qpn7f/ZO7PPnHHqKgptFHsQqL6vl3B6+IEeepN/8n6d6u5
	hPmzjRX8hts/wzAR1kN+Ua5JebPAUCA/7bu4/KG8G5RCnwUU3/TCpJBk
X-Gm-Gg: ASbGncsmAQ74Jd9pYLcBTrA/BOR9H/b84TZFwHEusaGwlclYib5MHcST524Qf9bbnWp
	uf2cCyV+zLB1Fw1o9tu3kywCZWoEaQObVnvm+H/qyGcWegrzh439hEFvhlxr9Dt7D2er6QMF/eQ
	sOOoK2W490r8so0YND50dBE/GmT5Db1TcHI+Tm3/2vsU+ZX7V3zReE4U0Liz2X1fWipLc1rmVwK
	eTBHA09GUtliVewM/htPFSkEAGfWU5RNITGJHv9gKwonV2rB7/qEsIz1yv4//9zesEex8OlF04Y
	te/kz8F+55E7jAXmxbcqiro4LUHytXjOoAS3JA8zmGaYCvnELO7D+2VWbQNGzAwht+ZYXaS7nUW
	O0n5WIljzkCOZWp0=
X-Google-Smtp-Source: AGHT+IF+gfoV6etSNY7UeTP7Wc3+ofAlLWgPgvHBVhEL5oHqglkksCzccfY0Fb9cv0GW9CsFU/0Fqg==
X-Received: by 2002:a17:907:25c9:b0:b45:a88e:d6de with SMTP id a640c23a62f3a-b50ad132c58mr2337451366b.65.1760445575586;
        Tue, 14 Oct 2025 05:39:35 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::31e0])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a5c134141sm11098458a12.34.2025.10.14.05.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 05:39:35 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 14 Oct 2025 14:39:33 +0200
To: Xing Guo <higuoxing@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, ast@kernel.org,
	sveiss@meta.com, andrii@kernel.org
Subject: Re: [PATCH] selftests: arg_parsing: Ensure data is flushed to disk
 before reading.
Message-ID: <aO5EhTBn9Oq_MP2C@krava>
References: <20251014080323.1660391-1-higuoxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014080323.1660391-1-higuoxing@gmail.com>

On Tue, Oct 14, 2025 at 04:03:23PM +0800, Xing Guo wrote:
> Recently, I noticed a selftest failure in my local environment. The
> test_parse_test_list_file writes some data to
> /tmp/bpf_arg_parsing_test.XXXXXX and parse_test_list_file() will read
> the data back.  However, after writing data to that file, we forget to
> call fsync() and it's causing testing failure in my laptop.  This patch
> helps fix it by adding the missing fsync() call.
> 
> Signed-off-by: Xing Guo <higuoxing@gmail.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/arg_parsing.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c b/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
> index bb143de68875..4f071943ffb0 100644
> --- a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
> +++ b/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
> @@ -140,6 +140,7 @@ static void test_parse_test_list_file(void)
>  	fprintf(fp, "testA/subtest2\n");
>  	fprintf(fp, "testC_no_eof_newline");
>  	fflush(fp);
> +	fsync(fd);


could we just close the fp stream instead flushing it twice?

maybe something like below, but not sure ferror will work
after the fclose call

jirka


---
diff --git a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c b/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
index bb143de68875..5a4c1bca2a1e 100644
--- a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
+++ b/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
@@ -139,10 +139,10 @@ static void test_parse_test_list_file(void)
 	fprintf(fp, "testA/subtest # subtest duplicate\n");
 	fprintf(fp, "testA/subtest2\n");
 	fprintf(fp, "testC_no_eof_newline");
-	fflush(fp);
+	fclose(fp);
 
 	if (!ASSERT_OK(ferror(fp), "prepare tmp"))
-		goto out_fclose;
+		goto out_remove;
 
 	init_test_filter_set(&set);
 
@@ -160,8 +160,6 @@ static void test_parse_test_list_file(void)
 
 	free_test_filter_set(&set);
 
-out_fclose:
-	fclose(fp);
 out_remove:
 	remove(tmpfile);
 }

