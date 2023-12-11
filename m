Return-Path: <bpf+bounces-17434-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D9280DAA7
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 20:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CC41B21547
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 19:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBFE524D3;
	Mon, 11 Dec 2023 19:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6vwcsLS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B0EC0
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 11:12:50 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a1c7d8f89a5so647668666b.2
        for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 11:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702321969; x=1702926769; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eTl9MgLVTnYYPxsT0hvLkZ1khXu+ylByBNKroLiWNBY=;
        b=F6vwcsLS16DqAbOVFcoW2snVbDKQRwzr2WHmhCRTsY+OQRhXREQwNmoYwwTDstENW7
         Mw5JLahQIiCGN8bcN4Qds8gTzcrgdc/Kap8JhIIPBoWnUcFbZapwbppWVJhgLebQvaTH
         Ltg2eYhLgXfiVK6EMoNFhaQBJLeqOML3h0MCxswxaAVuMnViBOrFJFaYbjxZJNKGcDtP
         9WByoSYxkRkq+JgNL5lEf2dUoeKFZBd0SDRvXjBdjr3lVKttg9rpkoetGzIJ1EXzathR
         yYUlyZJMN+ifO0jZrrmC9QArrk7y2qGF8MyyPH4EI+8H+IL2+1HEguORMZxBfuQkEO9v
         i3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702321969; x=1702926769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eTl9MgLVTnYYPxsT0hvLkZ1khXu+ylByBNKroLiWNBY=;
        b=A3MK2o/uT/sisbipayxhyaDo+8p+eliPU4FMXMfpEWjni9VjZZ17IO9clR7gNEkgi1
         +wJ6/Y+zS5f8lpeX/J+eawiNo5hVou2NG4YBR/Wlq+Bs3tJN+FEo04+NoiDhaqKEuGtl
         EZTA5aXhkqQxRYcMUMLVMRSqV2sYtF9YySVq8gzA/gb94qvs8M8VNwQ+VNX2oK54R6dw
         MfUepUE4KEUlG1pOEGZxABPC/VWW5XpCd6aHhmDfQt/DRCd5X6MOpGHBLq3BlhL5UqNl
         Z24S+vtrpwI+oKeP/8JwJp7aus1WyR5Kup6niUI/SNXri/lUn0H8HoegQifA032X8fHu
         VNAQ==
X-Gm-Message-State: AOJu0YxgQECCYKO2DU3KYIOSXrcPx3skJcXXGFOCElzzFALeniNQE2Eh
	DvtnWtigVkuIYjbAvtT2AH58rpxsQdM9OA==
X-Google-Smtp-Source: AGHT+IHN+yaPAeow9MGnS2he+ToczwHE88jA5g2lV6xqQaSp2VsczRDeW6mREu9gGsBGK9nMdCSOeQ==
X-Received: by 2002:a17:906:c115:b0:a19:2139:acb1 with SMTP id do21-20020a170906c11500b00a192139acb1mr3086736ejc.45.1702321969060;
        Mon, 11 Dec 2023 11:12:49 -0800 (PST)
Received: from erthalion.local (dslb-178-012-113-064.178.012.pools.vodafone-ip.de. [178.12.113.64])
        by smtp.gmail.com with ESMTPSA id tf7-20020a1709078d8700b00a1f7852c876sm4255381ejc.185.2023.12.11.11.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 11:12:48 -0800 (PST)
Date: Mon, 11 Dec 2023 20:09:06 +0100
From: Dmitry Dolgov <9erthalion6@gmail.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, dan.carpenter@linaro.org,
	asavkov@redhat.com
Subject: Re: [PATCH bpf-next v7 2/4] selftests/bpf: Add test for recursive
 attachment of tracing progs
Message-ID: <20231211190906.e6itzmvgfi5hsjxo@erthalion.local>
References: <20231208185557.8477-1-9erthalion6@gmail.com>
 <20231208185557.8477-3-9erthalion6@gmail.com>
 <ZXcA6Z3IWVH1xPk_@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXcA6Z3IWVH1xPk_@krava>

> On Mon, Dec 11, 2023 at 01:30:33PM +0100, Jiri Olsa wrote:
> > +		/*
> > +		 * The first prog in the chain is going to be attached to the target
> > +		 * fentry program, the second one to the previous in the chain.
> > +		 */
> > +		if (i == 0) {
> > +			prog = tracing_chain[0]->progs.recursive_attach;
> > +			prev_fd = bpf_program__fd(target_skel->progs.test1);
> > +			err = bpf_program__set_attach_target(prog, prev_fd, "test1");
> > +		} else {
> > +			prog = tracing_chain[i]->progs.recursive_attach;

> perhaps also the bpf_program__set_attach_target call does not need to be
> in the if path, I think it should work with NULL for attach_func_name as
> long as we provide attach_prog_fd

Just have tried that, but it didn't work -- when loading, libbpf tried
to search for XXX in BTF.

> I wonder now with just 2 skels the test might be easier to read
> without the loop, but I dont have strong opinion about that

Yeah, I was pondering that too. But eventually I came to the conclusion
that the difference for readability would be marginal, and went with
keeping the loop.

