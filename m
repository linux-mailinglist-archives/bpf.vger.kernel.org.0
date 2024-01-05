Return-Path: <bpf+bounces-19124-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 439D982546D
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 14:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5837D1C21BCB
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 13:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676A82D602;
	Fri,  5 Jan 2024 13:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELvkEqBW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDD92D61F
	for <bpf@vger.kernel.org>; Fri,  5 Jan 2024 13:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40d60c49ee7so16012935e9.0
        for <bpf@vger.kernel.org>; Fri, 05 Jan 2024 05:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704461172; x=1705065972; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W6Yc4uLS6MsjDGbm4T2evQXyjJcRZR8gPV/fqHOth5I=;
        b=ELvkEqBWMIx5GtObQuj0hBDZP5u7gZ1YmjX9xm3WcDpFjZn6uBsxSUOg43k5ge6jn3
         IEXoIvX61hdywR3QBuoGswRbEmXg0K0DqiztyJA3wnB8JsIIji1S3yH21M7VM8zbGdRc
         9/IjSyROtsaTIHK2HY/rLPfcSrokrhalRCj+HgXGv7arMLes2SQKgZWMtYaNbhVkZTlN
         KFuzQyo4hslW2R57x9BjYAipmWPQBgoMiaeGr3LOVi1WOwp/tPRUC/9DiClAEhFwLIx2
         DocVUtweDp3srpWYsYwl1mxBjtIbn72dey/GxmsJHYAshkuxqYLQKgCKlpak4l4wF+wl
         hEyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704461172; x=1705065972;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W6Yc4uLS6MsjDGbm4T2evQXyjJcRZR8gPV/fqHOth5I=;
        b=owVJstTs43YhVOLr49StfxoiOO8UHfaGAe4NNlBBkSJMle6K3uwjz7FshFN3KlULCn
         NgM8FrzBJ2/+T7UDz//U/ahXtjO+/aCW4MXw/GIbQRbfdFPJc1fjhRKScWavbMsCHIdD
         lZXB3eQjdWF2dAmR0Z57b7wDixZiieXQV9fF6DL6HK0Phnbxcc2CGuMc4B1TLQ3ai+jV
         XtvbfrC4giYV5qbL+mrvEp4J4gxD5Deu2IOtfNlzcZ3+k+qijKvqkrB5RL/AIPdf13u2
         I5iMlRiPZomYE5VvH9b5s4LTzzDcKHBwM+zB8nB1QJE2k/a2ryUrC8/vHHMzsWNhuh4Z
         tGVg==
X-Gm-Message-State: AOJu0YyBN30Cb//1J66nDcjnFtdC54fvheOArE6sBIoM2Ct4/VODPhLk
	TTlBUpd3lBlaSJ3UuOzHogU=
X-Google-Smtp-Source: AGHT+IEKw5XAN+6PiCSeVEBXdpTtrMnlNX9sNynTFKslwg9DZIFpJ2zGd2pPxdn13ziqYjCOs9DM4Q==
X-Received: by 2002:a05:600c:19cb:b0:40c:de2:148c with SMTP id u11-20020a05600c19cb00b0040c0de2148cmr1133905wmq.47.1704461171433;
        Fri, 05 Jan 2024 05:26:11 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id j10-20020a05600c190a00b0040d8eca092esm1571262wmq.47.2024.01.05.05.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 05:26:10 -0800 (PST)
Message-ID: <2d2ed98e8d4c5386b03f5c04bab7c439c9bbaffa.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 3/3] selftests/bpf: Test the inlining of
 bpf_kptr_xchg()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Song
 Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, Yonghong Song
 <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Jiri Olsa
 <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
 houtao1@huawei.com
Date: Fri, 05 Jan 2024 15:26:09 +0200
In-Reply-To: <20240105104819.3916743-4-houtao@huaweicloud.com>
References: <20240105104819.3916743-1-houtao@huaweicloud.com>
	 <20240105104819.3916743-4-houtao@huaweicloud.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-01-05 at 18:48 +0800, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
>=20
> The test uses bpf_prog_get_info_by_fd() to obtain the xlated
> instructions of the program first. Since these instructions have
> already been rewritten by the verifier, the tests then checks whether
> the rewritten instructions are as expected. And to ensure LLVM generates
> code exactly as expected, use inline assembly and a naked function.
>=20
> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

Thank you for this adjustment.

