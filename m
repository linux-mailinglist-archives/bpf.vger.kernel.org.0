Return-Path: <bpf+bounces-8150-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D57E77825A1
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 10:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87A63280F40
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 08:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B302113;
	Mon, 21 Aug 2023 08:37:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C5C1C10
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 08:37:56 +0000 (UTC)
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A648CC6
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 01:37:33 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id 4fb4d7f45d1cf-5256d74dab9so3734869a12.1
        for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 01:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692607033; x=1693211833;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6HaArZ1yuOuUVgJfN+Em/WZ0y1nLztJumiZOMwN9IBs=;
        b=hoFFF451pVdI/RLjSMa0b70ker82ySNugx9n02QBCMEEK5YxMuSdeu9xBYWE4VzuQO
         hMB8CIywlk21W6JhHf/9RiHqu2VdzpXQlLDUWl+lgh+EoqdsB4JkXOaQoZkSwA5Ukfio
         KwIwp8VGE5EJjOhtp0IP0favupJOXt6cotBLOHqiJJhtryL+crqq3yyX1KgitqnvfYP4
         yjAS9B0kAZPTfqSLN0n5NWI/xlF2au9A01gJ5AQ1QOliXIG2wk7VXgwG+fAIKZKoo4uC
         Hx4cuGcTUtNpPkXAf74bhRIaj1/ajD3iuSfaNyvI51/a0dbFPLnWZ83QGR1k6CbfrExJ
         F09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692607033; x=1693211833;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6HaArZ1yuOuUVgJfN+Em/WZ0y1nLztJumiZOMwN9IBs=;
        b=VAgyYgudhKUuKGTDiBOrOQkPnnA81yxOrTujCGnJSzBTLj1zAbOENAvIZbYZ89Xqxw
         0K7AVMHkmfINJsn4uNAY5GyAkTusECc5ZNLULe+3m3EzIwDmC0UNU+99QMBU+1WJD856
         pOOe0YQolZ2Yj2xEO0FQHUu9MJuygZg3C/EqEIEg/f90UxXithHMXVvVNPzQQ4jHF6nT
         q1DwbjPTkVRIb9VnGttNuqbi8W6NXhe3kyNwNSHk3J1N3DfxtTtkIaXQm8T5iUeyJUN8
         dsHkkH5lxBv3pUoIpreCn9J2AKf0t2DF1oToNXAVJqDMgIE3CQFK0YUApTghO/iBFA0g
         Z+Dw==
X-Gm-Message-State: AOJu0YwvjWFanzOESevuEw5X9ltsWvT2A2vvT0Nfqx+S67VaTgCi0QzZ
	jaF9qHqvtoMyd7sf7jAA/s38cDrIq90qFzrrpMk=
X-Google-Smtp-Source: AGHT+IGgiKQtoQY24GEjIp/sBUAuPoNG4AN1a7qtPoyXJ/d3Fbr6txE8nEDFqaHIrgx01ekrKlYFNSRQ8dQRdBOrR04=
X-Received: by 2002:aa7:dd14:0:b0:523:4bfa:b450 with SMTP id
 i20-20020aa7dd14000000b005234bfab450mr3649878edv.27.1692607033355; Mon, 21
 Aug 2023 01:37:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230821000230.3108635-1-yonghong.song@linux.dev> <20230821000235.3109245-1-yonghong.song@linux.dev>
In-Reply-To: <20230821000235.3109245-1-yonghong.song@linux.dev>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 21 Aug 2023 14:06:37 +0530
Message-ID: <CAP01T75QuVkb_FLv1MJo5Mm0UcXVOESVx3Uwyjxcu=JEBvN7JA@mail.gmail.com>
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Add a failure test for
 bpf_kptr_xchg() with local kptr
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 21 Aug 2023 at 05:33, Yonghong Song <yonghong.song@linux.dev> wrote:
>
> For a bpf_kptr_xchg() with local kptr, if the map value kptr type and
> allocated local obj type does not match, with the previous patch,
> the below verifier error message will be logged:
>   R2 is of type <allocated local obj type> but <map value kptr type> is expected
>
> Without the previous patch, the test will have unexpected success.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

