Return-Path: <bpf+bounces-12031-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C53777C6F0D
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 15:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58D1E282992
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 13:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFEA2940D;
	Thu, 12 Oct 2023 13:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJoE99eE"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5F427EE7
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 13:22:28 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207F6B8
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 06:22:27 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-405361bb9f7so10073505e9.2
        for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 06:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697116945; x=1697721745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8CZToky5azJ5+jZVKB2Thamw2tqhCm0WJnhiBDRzWYM=;
        b=UJoE99eEt024LhF2JZFBCYpZPzMmyHwVTOyirA0SjtmFTR3DyLaHW1DWSfCkunFSvL
         db9Epk0aTHvyUhqJH0RwbNzznnLKY4htPl6Xl8CPcpeat6niIxLM6kowvwxkFqNm4PsM
         0C2opwQ3RxQYv26qkoP2JFXuS6+cFB0qXw2CJSQoHVjfFvr/Eru/4o0Hz04uPQ0W8J00
         8aGLPaEMyJbRndyqEClm4/g1p37BXFkMPt0TLTaSovkpdIyuCT2nIGVQTmN7+j05MhHp
         F0HZz9AER6gbtEFM/6qic+lN/YINz/MwJBLKeROJHOU+y7+fxZ9lApChwvHca+NltU1B
         GLYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697116945; x=1697721745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8CZToky5azJ5+jZVKB2Thamw2tqhCm0WJnhiBDRzWYM=;
        b=PFireaaQtbYMvPMSc2swLz4vuajlkwO/FE5yP4teQNLyxKOW+AN3sazhnrGJhloqhI
         mtbjZFg6zRp6msKA7B1xJo8ZTZXGonAvn6W6fEZcWkj0vqr6djGY+Oz1FA4jerkcEeDI
         kr6qMmPdtWTZ+L/KyGGYksVmWgd1KW/glrNUALeF6360pbniEZ0WMgBYyshsZUYRuFtH
         3GqkW4LkTfSCMQTA+A/3MilSdEOfh1iVu85TadcXtCweaMy7OpFa9RU4Ofi+OghTMAbS
         /TJgoRDkEgfXjM0EdAbrY4j2jWQCPz4Hjk8ksPgn5OXgiWPOLVOr075iFnv5r40M4tjn
         7TMQ==
X-Gm-Message-State: AOJu0YyzAMe+S/NVOLz4Fy7tAbbDvMfaozmpyWVclVwWuVNMXNl2tOML
	WIrZP6qBfVJa1hBBpWObsJo=
X-Google-Smtp-Source: AGHT+IG4S+m9DIcP2qWIJvXLEpcXhmsC12FPFuQYaMDPaQ4S1+2XEQa3DpfE2YLLpxknYlP9XEHmkA==
X-Received: by 2002:a7b:c851:0:b0:405:3252:fe2 with SMTP id c17-20020a7bc851000000b0040532520fe2mr20474680wml.14.1697116945138;
        Thu, 12 Oct 2023 06:22:25 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id u7-20020a7bc047000000b004063cced50bsm19662036wmc.23.2023.10.12.06.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 06:22:24 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 12 Oct 2023 15:22:22 +0200
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 2/5] selftests/bpf: improve
 missed_kprobe_recursion test robustness
Message-ID: <ZSfzDk28TYohTv8z@krava>
References: <20231011223728.3188086-1-andrii@kernel.org>
 <20231011223728.3188086-3-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011223728.3188086-3-andrii@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 11, 2023 at 03:37:25PM -0700, Andrii Nakryiko wrote:
> Given missed_kprobe_recursion is non-serial and uses common testing
> kfuncs to count number of recursion misses it's possible that some other
> parallel test can trigger extraneous recursion misses. So we can't
> expect exactly 1 miss. Relax conditions and expect at least one.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  tools/testing/selftests/bpf/prog_tests/missed.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/missed.c b/tools/testing/selftests/bpf/prog_tests/missed.c
> index 24ade11f5c05..70d90c43537c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/missed.c
> +++ b/tools/testing/selftests/bpf/prog_tests/missed.c
> @@ -81,10 +81,10 @@ static void test_missed_kprobe_recursion(void)
>  	ASSERT_EQ(topts.retval, 0, "test_run");
>  
>  	ASSERT_EQ(get_missed_count(bpf_program__fd(skel->progs.test1)), 0, "test1_recursion_misses");
> -	ASSERT_EQ(get_missed_count(bpf_program__fd(skel->progs.test2)), 1, "test2_recursion_misses");
> -	ASSERT_EQ(get_missed_count(bpf_program__fd(skel->progs.test3)), 1, "test3_recursion_misses");
> -	ASSERT_EQ(get_missed_count(bpf_program__fd(skel->progs.test4)), 1, "test4_recursion_misses");
> -	ASSERT_EQ(get_missed_count(bpf_program__fd(skel->progs.test5)), 1, "test5_recursion_misses");
> +	ASSERT_GE(get_missed_count(bpf_program__fd(skel->progs.test2)), 1, "test2_recursion_misses");
> +	ASSERT_GE(get_missed_count(bpf_program__fd(skel->progs.test3)), 1, "test3_recursion_misses");
> +	ASSERT_GE(get_missed_count(bpf_program__fd(skel->progs.test4)), 1, "test4_recursion_misses");
> +	ASSERT_GE(get_missed_count(bpf_program__fd(skel->progs.test5)), 1, "test5_recursion_misses");
>  
>  cleanup:
>  	missed_kprobe_recursion__destroy(skel);
> -- 
> 2.34.1
> 
> 

