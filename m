Return-Path: <bpf+bounces-16528-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 970C6801FA9
	for <lists+bpf@lfdr.de>; Sun,  3 Dec 2023 00:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47778280F58
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 23:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D2722338;
	Sat,  2 Dec 2023 23:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQGnhATT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D260FB
	for <bpf@vger.kernel.org>; Sat,  2 Dec 2023 15:09:54 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a18f732dc83so541696766b.1
        for <bpf@vger.kernel.org>; Sat, 02 Dec 2023 15:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701558592; x=1702163392; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZqZ+ZN+oWZsIzWWG+efNQUeekBfQiDHmm4Y4AyieyY=;
        b=KQGnhATTydJr6gzrPeS7xS1zlLuUTqFgud1Qs9qtFaUYucfNJQHAGehWtlzIZXI0I9
         vhc59FONTXuRJ6jxfbxWPTbImrJUog7UlOh5Z/tzz0v1nkV6uhFW9rrmbvjVnN4zJZR4
         Xo4tluzqcJDslviy5shb9LpCqLGdFLVSWokqTcqzUUJQlnWAR7zenqPJjuHr4Qr9nHC/
         jMI7IjJvOV8IFID0/DXmx5lDLWthY5CusOOFjP99uiI41CXutx8v4NjElUI4k0gxp2Zp
         1tGSBwW3FG/IRmQ9k7bRsz+vFT62tgVRuLQGSI1pCvt+avNTQfUe5dUKA1vhsiyHiVBa
         Eehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701558592; x=1702163392;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ZqZ+ZN+oWZsIzWWG+efNQUeekBfQiDHmm4Y4AyieyY=;
        b=Uy0yMh0uSIWpuwQ1t1xIzj9sVuqohCoCWi1JqTNsIsq20R6a5o2eCR9FfBwDGcACet
         axe0pOwPlE7WahaIxSZPp+kTbD3XbqZHIQfGekbN5YugMZ/m/K1kHqrza7D0Gwn2EdGH
         FpSTeDrH+rS7/84tN+2anvFFf9sQOAQeaQOHIrlMO6Juw6G5+7rElOxfk3yLYeWoXfgw
         Rbyuj0l9tuDmp7HvanqvDcVExylCLYFbqELb4eosP4So+EBEUsgQz2VeGbxSI7XsUZnB
         CiEE/NufLEW2jGKfC1cXdMJ4ztQrukK+HxISLmbsxupRzkWoTLpXKl9TOfuiP5fu5SZ2
         T/9A==
X-Gm-Message-State: AOJu0YwW3wopPYstIY68ezXSNYplwQP9/V+b3NcR51km6K5TDYBMkEvA
	zXEPn/779mksIAIRAbatYmE8H42kmO2tacTLcMfCWpum47g=
X-Google-Smtp-Source: AGHT+IGG337/euI1YzYA0TeIMGjEqTvM91fYbNlFJfJcYb1FXpKstZWgT6bmPt44Q1dw/x8+DAmis0aMFpbl1WSsTVI=
X-Received: by 2002:a17:907:2443:b0:a19:a409:37d7 with SMTP id
 yw3-20020a170907244300b00a19a40937d7mr23114ejb.48.1701558591420; Sat, 02 Dec
 2023 15:09:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231202230558.1648708-1-andreimatei1@gmail.com> <20231202230558.1648708-3-andreimatei1@gmail.com>
In-Reply-To: <20231202230558.1648708-3-andreimatei1@gmail.com>
From: Andrei Matei <andreimatei1@gmail.com>
Date: Sat, 2 Dec 2023 18:09:39 -0500
Message-ID: <CABWLsesV9FvmF+j3n8ZntcNCL1gbhKOg65a5NA8s5-ro=3cYYA@mail.gmail.com>
Subject: Re: [PATCH bpf v3 2/3] bpf: fix accesses to uninit stack slots
To: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Hao Sun <sunhao.th@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	kernel-team@dataexmachina.dev
Content-Type: text/plain; charset="UTF-8"

[...]

> --- a/tools/testing/selftests/bpf/progs/verifier_raw_stack.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_raw_stack.c
> @@ -5,9 +5,10 @@
>  #include <bpf/bpf_helpers.h>
>  #include "bpf_misc.h"
>
> -SEC("tc")
> +SEC("socket")
>  __description("raw_stack: no skb_load_bytes")
> -__failure __msg("invalid read from stack R6 off=-8 size=8")
> +__success
> +__failure_unpriv __msg_unpriv("invalid read from stack R6 off=-8 size=8")
>  __naked void stack_no_skb_load_bytes(void)
>  {

Please confirm that changing this program type is OK. I wasn't sure here.

[...]

