Return-Path: <bpf+bounces-16382-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51110800D1B
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 15:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51CDA1C20B7C
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 14:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305BE3D992;
	Fri,  1 Dec 2023 14:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPxB7u9D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67561700
	for <bpf@vger.kernel.org>; Fri,  1 Dec 2023 06:25:23 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a1a22b7f519so76143366b.2
        for <bpf@vger.kernel.org>; Fri, 01 Dec 2023 06:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701440722; x=1702045522; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1G+1KDDtZY0ZAy0sDJUrklL0CIlj8MUddz//nOg7B/4=;
        b=gPxB7u9D6g4K7JV50EcpsQva05kXYoL9zWRkCTnRihAzWfr7XgCqh0gbygHbBD5rT5
         ISLQ3VqQCBSGO7XNf65TuPUNtUVnrgOjto8y1BrLRweqxpJsbbxMc8Vrr9m5DRxYmD/B
         iN+XSfx0OUAwyl2jdRBdUUxAysvrIdxqrX/dG52qM7oxDGabe416IFBPi3w3QQKbvS0z
         2NdOHa2gC74jdU95gW9eTwBdLFDbZ+UNBDxDm+vScJ7jRQMBQPHhKECpSSV8HgZHcJIr
         fC1foueMb9K5O//5TbThwCdUjfkmopIqKkUW6siFs1Ip8JdCGwyBRUcl2DcMMMhsBHcK
         o1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701440722; x=1702045522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1G+1KDDtZY0ZAy0sDJUrklL0CIlj8MUddz//nOg7B/4=;
        b=en4qHW8MRRoV74DwDHch5/m6cyIcbgfVFc7EJxJK0Xn+69126NgWRP0uYHZGpr3G5h
         /rS/+WSacNRumUj4xQ2XOUfa4Qtj08P0ObDrkKZ5KAoR4rHtlcghsp6wS7VLGZ/N/7SS
         AQilI+tk0WeXpB9xiym5SsfSQqpKGR1HVkwuZ9wkEU3v/5zkDBTHzpXpfnYtUuWQ0ddC
         +b42AVdJrTMsy2SnAKUITd8uC1jIAlCxBBnydZUISnfM900y2l1WspzZ1pHmH60BqAjC
         usHA0KywHpGlWhZNCaUrIlRbcrHHGUgcIEL5ALYeqc3shbZpq4rID1W0WE/mxWGXWv5I
         c1Ng==
X-Gm-Message-State: AOJu0YyTZIjh4w8KvwDBvOKBDmej6JK8RqKrwnmGpgC/QSY44TL96Xjh
	8mivTkYONlb2T6yMdOYxZiQ=
X-Google-Smtp-Source: AGHT+IGHOzcbgzHQPWq2jOfnYU9f+Y+XeQick5aVzv76FG9NflCvMnM6cNvTcgdSLWPXW14+e1OjAQ==
X-Received: by 2002:a17:906:2288:b0:a19:740a:5885 with SMTP id p8-20020a170906228800b00a19740a5885mr486992eja.41.1701440722125;
        Fri, 01 Dec 2023 06:25:22 -0800 (PST)
Received: from erthalion ([2a00:20:6005:5771:fa16:54ff:fe6e:2940])
        by smtp.gmail.com with ESMTPSA id jg41-20020a170907972900b00a046a773175sm1946384ejc.122.2023.12.01.06.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 06:25:21 -0800 (PST)
Date: Fri, 1 Dec 2023 15:21:43 +0100
From: Dmitry Dolgov <9erthalion6@gmail.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, dan.carpenter@linaro.org
Subject: Re: [PATCH bpf-next v4 3/3] bpf, selftest/bpf: Fix re-attachment
 branch in bpf_tracing_prog_attach
Message-ID: <20231201142143.i66qvk262a7zqg2h@erthalion>
References: <20231129195240.19091-1-9erthalion6@gmail.com>
 <20231129195240.19091-4-9erthalion6@gmail.com>
 <ZWim7zRLA-cgVQpr@krava>
 <ZWkNBR-1RF8r4deG@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWkNBR-1RF8r4deG@krava>

> On Thu, Nov 30, 2023 at 11:30:29PM +0100, Jiri Olsa wrote:
> AFAICS we can't do anything here, because program was loaded for tgt_prog but we
> have no way to find out which one.. so return -EINVAL, like in the patch below

Yep, makes sense. Is that fine if I include this patch into the series
with you as an author, with signed-off and everything?

