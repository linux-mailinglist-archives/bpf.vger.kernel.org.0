Return-Path: <bpf+bounces-53715-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F50A58E74
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 09:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E5DD16A1E4
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 08:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B131D224222;
	Mon, 10 Mar 2025 08:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBKSanEa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0A313EFF3;
	Mon, 10 Mar 2025 08:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741596317; cv=none; b=eiBCL5gnpgieNEARKuA5c2yRe6AkaiPlhDiRzvtL9HrIV/Hs2x9YcuStiqMiAWD5qLcXGkjgwVW7lwmgPpHeRB/G6jFoRhOlgj1yN4q0mPHwXzx5gRydDKppchuVFnRVyrY/a8WxKMfcWaXF94AwWZ12d4+YeaDTxxu/kMVkgF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741596317; c=relaxed/simple;
	bh=lddKzbfpx98/8kDPxZOcCF7xGNJXxIRPwIiexX8u/00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oM5ApvjRYzF0WflKjihbTVaOfE76k14+BqUqXDJJkiQyH04z1YWvfMl4sdZ1X3mKfQSd+M71B/oUDvDPLtadoyFuSfiA3FpgypYzA0cT4Ca+FzIbmvSi6zPYETCPF0H3pmVYEpeX1S3G1hEZKuOPShmzPVOkmTW/7hjUNenw+K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBKSanEa; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3912e96c8e8so2073279f8f.2;
        Mon, 10 Mar 2025 01:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741596314; x=1742201114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lddKzbfpx98/8kDPxZOcCF7xGNJXxIRPwIiexX8u/00=;
        b=HBKSanEaK2+ps4DQhrtJguFVJt0qYPkHT/ouGGHUNp9I7uSs0zl0ax1JbeBlHtobqa
         58n1MMjcjAooIhJjin05rszmQVknCIlTbrPONIDXV0e6/Q/mlX3GwnubYc0+Vv/BpID9
         vbQlyxx2HHLg1wNsyCIiv9cJm4tcWjY+KJzJhSFe2XwbvnZ7gBPO3MfynLLPxQ1QXKfN
         DyeIQ8zpORTYUJFtEZ7DOFC5izPdR+3zbkGAymtmzLklf48LL0Ed9JRrndAc6Dvvr9CD
         ZTRFOuniyQJ4sWnsZ8Fj14BPUS6smlMF/3QWnXsox5nmO3hxNKApCwVZ0yHJokUuDzjF
         l7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741596314; x=1742201114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lddKzbfpx98/8kDPxZOcCF7xGNJXxIRPwIiexX8u/00=;
        b=K+iX1c+rQeA7u20K2azPk/Q8YfcsE00aiFSAc79lnwr+JviXOTTbpzUk5pDUtToD+u
         A5gEWBQVrqPscs7mYMuiigowAjg2Whmitv7qvF8VPHa/WATK6sxuzjQ+yl4ZypbnW3dj
         TRyGyqte22be+raGbb8sjskoOIKnGJStYNvJwDtF3vpyvm4r+Q5fYhKTuueo0AGrLznU
         Si43kFhFyagro0gQ+/46UWbekVmaF3KzzqfYPdot9huW92yb/5qW1cwLFz7H4aE2kd4i
         0XNOz6y6t4NL/5/qSPXuQaLa/C7tDTZSYbZehlqRpUnRzBuzK7oa6yx5fcZeGRBECdvb
         YToA==
X-Forwarded-Encrypted: i=1; AJvYcCWxZO8kMwKQNmrYzoEAojm2jlB3XfFm7OanJXXQdqC29Ai6UZm8Gkq3RXtTELkQAcmoK18C18vZdBdAMk4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdrjs8meyAYx+lySsUeSWk9VjDgz5zPXqDhWnmK8nvYuKqjnxt
	LlokNPAIPPGIiqOKgQOliEd3aQ9nTFFjJ68Cb5GObdIaeHbQshT3ZVHn+LXlJtyHzUTYGzcQAQ8
	275iDnlaA7x0E7hqFhDZYIfhNSiWZfnh+HTI=
X-Gm-Gg: ASbGncvgZyBNgi7lB4xhaOTI+M057s+skWfJ5bgjtR3+Hm7rYQ/hDd0IEqAPmjajjuU
	+FGd6y16tLSG3N0imUEsM/SRSjhYGX53RAVALfonybCRhcmx086t2CeTP3MRMcxmt9eZqrqiHBD
	SE7t8YaYMAWnDvzf5Wmrs53Ysheg==
X-Google-Smtp-Source: AGHT+IFEx8AcEmbNUmd8171dY06sa7Kl9VvYiawTamgrCvSljOZ8Amr1oHjAAU/XAf3WHX842EZpogQVCVJ8/fFOj3c=
X-Received: by 2002:a5d:47cd:0:b0:385:ee40:2d88 with SMTP id
 ffacd0b85a97d-39132d16d9fmr7628938f8f.3.1741596313743; Mon, 10 Mar 2025
 01:45:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7bc80a3b-d708-4735-aa3b-6a8c21720f9d@linux.ibm.com>
In-Reply-To: <7bc80a3b-d708-4735-aa3b-6a8c21720f9d@linux.ibm.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 10 Mar 2025 09:45:02 +0100
X-Gm-Features: AQ5f1Jo2Dphy2oOaebDEMMCHMoyiatIiqoUQT2XGCXbtdwr676kUmEEDbrwoibw
Message-ID: <CAADnVQLUxTjYuvwyO0CMS5=e0YqmP525+EDfJX-=dH55g8XTXg@mail.gmail.com>
Subject: Re: [bpf-next] selftests/bpf fails to compile
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Hari Bathini <hbathini@linux.ibm.com>, Saket Kumar Bhaskar <skb99@linux.ibm.com>, 
	Alexei Starovoitov <ast@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 8:32=E2=80=AFAM Venkat Rao Bagalkote
<venkat88@linux.ibm.com> wrote:
>
> Greetings!!!
>
> selftests/bpf fails to compile with below error on bpf-next repo with
> commit head: f28214603dc6c09b3b5e67b1ebd5ca83ad943ce3
>
> Repo link:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/
>
> Reverting below commit resolves the issue.
>
> Commit ID: 48b3be8d7f82bea6affe6b9f11ee67380b55ede8

...

> If you happen to fix the issue, please add below tag.
>
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>

Not quite. The issue is likely that your llvm is too old.
Please upgrade.

