Return-Path: <bpf+bounces-11427-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD8D7B9B51
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 09:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 492152819D8
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 07:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3612D5398;
	Thu,  5 Oct 2023 07:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5h3XukV"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28F17F
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 07:21:39 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15567AA1
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 00:21:38 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9ae75ece209so119348666b.3
        for <bpf@vger.kernel.org>; Thu, 05 Oct 2023 00:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696490497; x=1697095297; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OF9de+66V7cTs1htVRXvPbU3jrhnGUFk8XM+b7CnNvk=;
        b=W5h3XukVknqEXhS58Zfy59ZiVIQythcBB4IYGzjP2yBMH4pacgm4mPcJT+aIv59A4/
         MfZkvpI0J3YQHpMvJeTcFQKT4GjjA3JaqYGFtYYsr48iQvukYLR65lD21x48Uafbk4if
         UvWiVDZOvcSOm85z4USA1Or4NmwhAfpVW/KAKlFTaat5nzaRA9qTHxC4EQ5UajeZtIjH
         ipEbKqz4z0J+eDprVLPQFyqo0cXpE6xdRV1oqzNQywULrsMMurV+jS0QOZSwdHa4zLdB
         RcmOUro5v0HHAlrTawQLLDpBqkAdmeUy11l/BUG8X/3bxhyBlhjlqnwHcGQ/nAI9Se7+
         1PiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696490497; x=1697095297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OF9de+66V7cTs1htVRXvPbU3jrhnGUFk8XM+b7CnNvk=;
        b=ofLKVjzK2u+p5yCDUWAFC1mcBfVCOxmOTFX912e3smHmYJqyKeqooqx5am3znNcyI0
         9XY8xhHZ0aOJieTinEjZi04LJvm7Y4XqvBKVQRRtQGzECR52d0mtQJxKb51ppocjzt4G
         UQto+gMhPNOXOXycsIkL9L9ObArkMlXo0KQdtTMv3wU5hjfBSqkGE1srvjr99nLbS6lN
         jHUx6f6DK9IwibaNdJV4Outl5kTsZJmRx+A1xAnn/lWqy9PWpPoSo0SX4d9ufg8oLI0s
         7UFuX/DDPIf6zN0ib/p59Ts7f39Eii8F83UV4ykSSF5IDUNc6l88PWb/LAllUt332MKe
         Brng==
X-Gm-Message-State: AOJu0YzVTjXfeVJTEF+OeKo3ttBleGblKzQk+44SvznLlYxAak+04853
	O1X5UrLDaDPYAJGdoCzZbik=
X-Google-Smtp-Source: AGHT+IEtdIopoc7VsFZJKadW1DTnWQX2NqXXDRX107Iz27FxDuGbH1rpIqtEtpIf0xca4xjydedunA==
X-Received: by 2002:a17:907:2ccf:b0:9a1:f73b:90ce with SMTP id hg15-20020a1709072ccf00b009a1f73b90cemr4146083ejc.54.1696490496815;
        Thu, 05 Oct 2023 00:21:36 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id p26-20020a1709060dda00b0098921e1b064sm667666eji.181.2023.10.05.00.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 00:21:36 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 5 Oct 2023 09:21:34 +0200
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: don't truncate #test/subtest
 field
Message-ID: <ZR5j/g2rC+isVCwy@krava>
References: <20231004001750.2939898-1-andrii@kernel.org>
 <20231004001750.2939898-3-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004001750.2939898-3-andrii@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 03, 2023 at 05:17:50PM -0700, Andrii Nakryiko wrote:
> We currently expect up to a three-digit number of tests and subtests, so:
> 
>   #999/999: some_test/some_subtest: ...
> 
> Is the largest test/subtest we can see. If we happen to cross into
> 1000s, current logic will just truncate everything after 7th character.
> This patch fixes this truncate and allows to go way higher (up to 31
> characters in total). We still nicely align test numbers:
> 
>   #60/66   core_reloc_btfgen/type_based___incompat:OK
>   #60/67   core_reloc_btfgen/type_based___fn_wrong_args:OK
>   #60/68   core_reloc_btfgen/type_id:OK
>   #60/69   core_reloc_btfgen/type_id___missing_targets:OK
>   #60/70   core_reloc_btfgen/enumval:OK
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  tools/testing/selftests/bpf/test_progs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> index 4d582cac2c09..1b9387890148 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
> @@ -255,7 +255,7 @@ static void print_subtest_name(int test_num, int subtest_num,
>  			       const char *test_name, char *subtest_name,
>  			       char *result)
>  {
> -	char test_num_str[TEST_NUM_WIDTH + 1];
> +	char test_num_str[32];
>  
>  	snprintf(test_num_str, sizeof(test_num_str), "%d/%d", test_num, subtest_num);
>  
> -- 
> 2.34.1
> 
> 

