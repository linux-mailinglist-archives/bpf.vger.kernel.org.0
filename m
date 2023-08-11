Return-Path: <bpf+bounces-7547-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 131737790DE
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 15:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C12652822AB
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 13:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD4029DEA;
	Fri, 11 Aug 2023 13:35:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A1963B3
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 13:35:51 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298F630CB
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 06:35:50 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fe4cdb72b9so17533965e9.0
        for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 06:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1691760948; x=1692365748;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AeZYkL63Yi1Fe2yaQWLWszFlVwbhuOdU+WXdjXuVqzY=;
        b=Tw03n5F65Wk9a5Kylw1P64R9UHjy4NaNj3qthBhEJaPcm+CiJHX2mH81PRSn1K0w5I
         u0FYFKuU8llmR4iHDnFdyVvs6GM3QpPOFbaPpG+DsZVBiLLglMbDZE8opotfW2YleFk4
         JTQeH55rWkiY8b+VcZMw1tuiGy6eIuXYhfYJS1kKBuLZ2ntcC5ZLGE8l9qyxruPFtU8o
         Nhhz+JnUUvRafPgptQ3P+qoDrq2EcDE5/e8Hl8lFVdh2z5NL00ZgNVPYGzU2TnQ1nATP
         RgkZGn/QPP8ga6H1cxMhnmWJCRButIdjJoDtYxX98EGkq7wFDfqLQ4TJsCyfiCZECC+9
         +XtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691760948; x=1692365748;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AeZYkL63Yi1Fe2yaQWLWszFlVwbhuOdU+WXdjXuVqzY=;
        b=jKkZMuxjfxkYStmy3lHYif1fIDdj1mcuaV5lPGgkV5UaIuVDlZn+jb+7KY8I6g2Vkg
         y9RggeOyCMVdt7YZ3QfsK8eGrxi0soGiRmrgRQ7DMpFNO4fqOIpgqKopxFBFYwtQpCup
         EthfNKiuTNzJzBvX9worZaB7cidNB5nkcOJx07ytD+FvgAZcy0ALFClX6wZ1Qke8VcWW
         gPQ9f12+s1ovwkNH+u3SaeaI4Cd77sqazDilIlJxgFjqKAJU9KY40T27T0rWPVVdCdsa
         X1CVX0ecPmnh9BdrgR9FFB/p69zJORLk7arEZgYPpVw//0gzy6vKRkl1v5E4eZrmd0a3
         znQg==
X-Gm-Message-State: AOJu0YzH4PPQvDhH3UwBiZLuHvbRfaQh/UGehdNTpBYhVbVNIQONeBwa
	GnH4FuqRkOzdzmwccV0Y4mZ7Eg==
X-Google-Smtp-Source: AGHT+IEgPmXM9fX0JFxbYQQ2LyN95oWDoOIhxPlsRUu3C2Ax7mK7xcaJjOnVzpN/S2z4i56QTZ3hHw==
X-Received: by 2002:a1c:f710:0:b0:3fa:99d6:47a4 with SMTP id v16-20020a1cf710000000b003fa99d647a4mr1617535wmh.22.1691760948661;
        Fri, 11 Aug 2023 06:35:48 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:2ee3:bf70:31be:c44b? ([2a02:8011:e80c:0:2ee3:bf70:31be:c44b])
        by smtp.gmail.com with ESMTPSA id d16-20020a1c7310000000b003fbe791a0e8sm5273310wmb.0.2023.08.11.06.35.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 06:35:48 -0700 (PDT)
Message-ID: <3b6e1bc6-be5e-4312-888d-04b3913d6e21@isovalent.com>
Date: Fri, 11 Aug 2023 14:35:47 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpftool: fix perf help message
Content-Language: en-GB
To: "Daniel T. Lee" <danieltimlee@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org
References: <20230811121603.17429-1-danieltimlee@gmail.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230811121603.17429-1-danieltimlee@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 11/08/2023 13:16, Daniel T. Lee wrote:
> Currently, bpftool perf subcommand has typo with the help message.
> 
>     $ tools/bpf/bpftool/bpftool perf help
>     Usage: bpftool perf { show | list }
>            bpftool perf help }
> 
> Since this bpftool perf subcommand help message has the extra bracket,
> this commit fix the typo by removing the extra bracket.
> 
> Signed-off-by: Daniel T. Lee <danieltimlee@gmail.com>

Fixes: c07ba629df97 ("tools: bpftool: Update and synchronise option list in doc and help msg")
Reviewed-by: Quentin Monnet <quentin@isovalent.com>

Thank you

