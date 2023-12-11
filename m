Return-Path: <bpf+bounces-17450-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E7380DC19
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 21:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AA9B1F21A62
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 20:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4895467A;
	Mon, 11 Dec 2023 20:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHVb+AM3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47319A6
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 12:54:01 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1d069b1d127so29393755ad.0
        for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 12:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702328041; x=1702932841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSLdxk1xYJi8XV7T64TjhQSbSV1r8d9wRQxKdsHf1ic=;
        b=JHVb+AM37Q1GTXjUXy8mp93ryNM3RGWu1qIms+JeOxonFrAIp7cWN/EMEXNi6yutdI
         zc8Jdov+uulDsWL8VV5t9rkxGxSbX2lEAUb3hqXQ8npsdqKCaS1P6sKh60FvZ7THwjZC
         jOnpVug/4MTop8PfrPppAg79peT8ftJjOxvX+tcB1VFwTsEa1JsKX8nDT0TrtZfchM6h
         lWt1FZWOddrHy5iKrqIk5x3UClaTAH8+YvbjQcCQzC+GFYZTXCDnQeNcKpwtRFEOBThs
         O4aB9rWSbXENgJu+ZWPImfmz/5B8TMkBcEs0ptlaZSA2sHYmGvWA/925ZtKnxdbxKDgi
         Bdbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702328041; x=1702932841;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wSLdxk1xYJi8XV7T64TjhQSbSV1r8d9wRQxKdsHf1ic=;
        b=fysWYtIGGeP5b/3jmCZvD+8fYQtgmcWrF4vAUamSKGlALLIc2FbT4QBpNwhHw0unlI
         1EKsqw4FwovrO4o/G7BeVrZpj1bDcBJL3VDEyVQGNv2ddtW2h5KbgNSfQ+guQvdYRkjM
         pTKRJkZxQgoKn7MSVqZ5TnaBoLkYwdaBcrVL2MqQ3e4MhKsQ32H4Usg+w5qUtSF3sxRv
         nbccXHtqwCRDLpVZTAEtHhJXCgYiw+8RXMIq7El5XRDGgCIwLgVoE+nSkCPfvmbEw7Rx
         s3nc005hFOy+YdIAgGb2h85Rv2l+ix2iZEXMvRN+Xyir9G4JcVyrLm8WVzc28JwRc1nV
         Ctcw==
X-Gm-Message-State: AOJu0Yzqr9zvSYHy+aPOuX+llMi80rNgPfsOVhIEnvn1dNCaL/6y9hPL
	ZPnhYqQ0/EPwM4c8LMW4EDs=
X-Google-Smtp-Source: AGHT+IHR32GVIHvu2/SwaEkfoSF/iI4TNj9meSjn+za+/8WbRczy5/+7bQv1y2oODy8LI3MGTeCGiw==
X-Received: by 2002:a17:902:d48d:b0:1d1:cb49:abec with SMTP id c13-20020a170902d48d00b001d1cb49abecmr2312132plg.52.1702328040678;
        Mon, 11 Dec 2023 12:54:00 -0800 (PST)
Received: from localhost ([98.97.32.4])
        by smtp.gmail.com with ESMTPSA id l7-20020a170902f68700b001d1d8f654ccsm7047873plg.31.2023.12.11.12.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 12:53:59 -0800 (PST)
Date: Mon, 11 Dec 2023 12:53:58 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 bpf@vger.kernel.org, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 martin.lau@kernel.org
Cc: andrii@kernel.org, 
 kernel-team@meta.com, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Alan Maguire <alan.maguire@oracle.com>
Message-ID: <657776e6aa5dd_edaa20849@john.notmuch>
In-Reply-To: <20231211174131.2324306-1-andrii@kernel.org>
References: <20231211174131.2324306-1-andrii@kernel.org>
Subject: RE: [PATCH v3 bpf-next] selftests/bpf: validate eliminated global
 subprog is not freplaceable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Andrii Nakryiko wrote:
> Add selftest that establishes dead code-eliminated valid global subprog
> (global_dead) and makes sure that it's not possible to freplace it, as
> it's effectively not there. This test will fail with unexpected success
> before 2afae08c9dcb ("bpf: Validate global subprogs lazily").
> 
> v2->v3:
>   - add missing err assignment (Alan);
>   - undo unnecessary signature changes in verifier_global_subprogs.c (Eduard);
> v1->v2:
>   - don't rely on assembly output in verifier log, which changes between
>     compiler versions (CI).
> 
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Acked-by: John Fastabend <john.fastabend@gmail.com>

