Return-Path: <bpf+bounces-14649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB957E7454
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 23:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B77CCB20E22
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 22:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A3238FAA;
	Thu,  9 Nov 2023 22:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Thc6LsUC"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67DC38F94
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 22:26:01 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BB21FF6
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 14:26:01 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9c53e8b7cf4so235966466b.1
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 14:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699568759; x=1700173559; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o038q8091HgkKP9ei6sx1/f9BfbG5POUjkZPACnHTKw=;
        b=Thc6LsUC6M9Rbt9Obr+Yr3x3X/s8BNoJIko348nYQrq0yYGCjubdOf96fEvw5BItN9
         W+CR2JN8u+eBk/npsBgU208PPY+zRAaDEvKLJ2YL0ND2wXulrWALdoKDiZBq2D9Jf0ay
         FG47v/vFbITe04X85zdyZB4FK+KNNSNS9AzgCR+TBtb+Ehv3k9ycUrLwtVw5AGuykZ41
         jjT+kyGTDe1kEx3cm8ms5b31YnztLd52lOSKNRdMklRTi71TU38Y5zOx+juwbBsVB0qr
         f1gq8pQG1N+06/3dX0WUBXVghPUhKbGCR75FGAjs0ArHRszxmc3ma9Kzg6EdxiW/kOzR
         V9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699568759; x=1700173559;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o038q8091HgkKP9ei6sx1/f9BfbG5POUjkZPACnHTKw=;
        b=ObDHYfAtHCUMW/3Hfeg+rcPj9GpkYSMhEe1SXCNYucy5/zfO/Dgbxkl7nDJflpvAQO
         AUa0Dr7+zAenYDpbLmJn06wy1EUo8NdL+hRq4AM1ZxBrH3b/7uhg4E540OBGctZ0sQ6q
         q/2p47NjYcHNyZ3Z0aTrIfl/nmsOpHzRaFb2i8fcKdYichcG16439MYxEPPo05UF1CGj
         ZZnK/ypoLYIqxRfALokmvRLhUodza+ZCDSGZj6tfrQipbwrbFkWqGmJqzG5Z86/tMHnY
         65032MtgU4wAmmp2Ex7QasFAuXyUxkBVHJ3lHBef2fXU84YtizEcNHQKqy5riwzdAF0x
         l28g==
X-Gm-Message-State: AOJu0YxmgVZcjUxqrBxpDetK4uDzgJ4WCzEov+Nw9A6qE18HNB/IGdfh
	912u0LgYfXtg9XuTI5ewHFdvrsPf9DM=
X-Google-Smtp-Source: AGHT+IHBaor88mRKCB2cgwsYTOwoGkiegzP4z5lHaaLOWDsvL732yGXqhgeSjAFy5BPzB2B/JQD4jg==
X-Received: by 2002:a17:907:7eaa:b0:9ad:9225:ced2 with SMTP id qb42-20020a1709077eaa00b009ad9225ced2mr4347455ejc.62.1699568759323;
        Thu, 09 Nov 2023 14:25:59 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id z17-20020a170906669100b009920e9a3a73sm3098282ejo.115.2023.11.09.14.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 14:25:58 -0800 (PST)
Message-ID: <c55eea6901c2ba2d404717b69c8a1e5b885991eb.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/4] bpf: handle ldimm64 properly in check_cfg()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com, Hao Sun <sunhao.th@gmail.com>
Date: Fri, 10 Nov 2023 00:25:57 +0200
In-Reply-To: <20231108231152.3583545-2-andrii@kernel.org>
References: <20231108231152.3583545-1-andrii@kernel.org>
	 <20231108231152.3583545-2-andrii@kernel.org>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-11-08 at 15:11 -0800, Andrii Nakryiko wrote:
> ldimm64 instructions are 16-byte long, and so have to be handled
> appropriately in check_cfg(), just like the rest of BPF verifier does.
>=20
> This has implications in three places:
>   - when determining next instruction for non-jump instructions;
>   - when determining next instruction for callback address ldimm64
>     instructions (in visit_func_call_insn());
>   - when checking for unreachable instructions, where second half of
>     ldimm64 is expected to be unreachable;
>=20
> We take this also as an opportunity to report jump into the middle of
> ldimm64. And adjust few test_verifier tests accordingly.
>=20
> Reported-by: Hao Sun <sunhao.th@gmail.com>
> Fixes: 475fb78fbf48 ("bpf: verifier (add branch/goto checks)")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

