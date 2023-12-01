Return-Path: <bpf+bounces-16439-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CF48012F4
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 19:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ED81281ED6
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 18:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D1B4EB28;
	Fri,  1 Dec 2023 18:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l1e1JoKx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D022593
	for <bpf@vger.kernel.org>; Fri,  1 Dec 2023 10:43:58 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50bb8ff22e6so3650286e87.0
        for <bpf@vger.kernel.org>; Fri, 01 Dec 2023 10:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701456237; x=1702061037; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SBFJ4kOnx3MvpRRvi2gT0ANsP3NBf0EkjZDiypiCECU=;
        b=l1e1JoKxMrnnmJYLSXzPLJM18vsXK9nqWiXnFKxD6HCvu0oHlEO67Exp4474ZpWuF/
         +EfV3lu8Om6nfB9jZpjV1VxMS9sFdQwnkw0vO5AHUKjyVWj0vckTW3pNZ09WaC4z6+WY
         pbv4mTNZW9SIJ0gtO20NqTIoD/tK2lXhoKv+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701456237; x=1702061037;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SBFJ4kOnx3MvpRRvi2gT0ANsP3NBf0EkjZDiypiCECU=;
        b=ni80yHIvgvgKJlgSVkNskQ7jzgxo9L5Rk4YEEDAue8x3JgD7sLwdK0JIQ5UqAfcA4E
         5ltKhrAsmH/RaVio/S8+G/ZuXiNLDNbH3t8yhP+MRx+P2U0vTWZMJcyaK1dyDqqUk118
         Frj/iQswH7UvUoKgcRnaWyccnbWm7wt30ZkWfZXuk0WOj+jFSYSQDqPNlZBYO0AAzn3P
         iGlY4v85h8e85Eqd/seej4J53AdOAlVrCCccf+6AGc+JnwaxZKf11D6HknVXapzom/QM
         L+M6CvkvY6pafERR4KOxyLvSFa2F8Ai2k1dhwYygrXrQPezl9NO7ZzRw+ugqJM2L9e12
         4Xiw==
X-Gm-Message-State: AOJu0YxrTuZlP1GL5hC+sY5742YqWQrO+4kf65ijc0BiEDRefQY/aem1
	QKSR8bqeoipsTSUFufh3U8Fd6fSvFVXuoefWAIP2IhpVrS2LJzUN8234sg==
X-Google-Smtp-Source: AGHT+IEZ2THW1pBIivmR2mIuvKeulSJ/syqouKTnVlKRw7eHeD/fKNXxO+hXk1a13VB1QzQ5/Cxzhh2GOppZYPxnPyo=
X-Received: by 2002:ac2:46db:0:b0:50b:d341:4f6c with SMTP id
 p27-20020ac246db000000b0050bd3414f6cmr1245003lfo.6.1701456236928; Fri, 01 Dec
 2023 10:43:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201094729.1312133-1-jiejiang@chromium.org>
In-Reply-To: <20231201094729.1312133-1-jiejiang@chromium.org>
From: Mike Frysinger <vapier@chromium.org>
Date: Fri, 1 Dec 2023 13:43:19 -0500
Message-ID: <CAAbOSck08P21QzTcwANR5+dxvf7_rWfArDNOfzhcOj1FF01FcQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Support uid and gid when mounting bpffs
To: Jie Jiang <jiejiang@chromium.org>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Acked-by: Mike Frysinger <vapier@chromium.org>

