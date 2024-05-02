Return-Path: <bpf+bounces-28461-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5D58B9EC2
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 18:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EE26B24B58
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 16:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1795115E5C7;
	Thu,  2 May 2024 16:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWbMUVeQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC2E1553BB
	for <bpf@vger.kernel.org>; Thu,  2 May 2024 16:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714667990; cv=none; b=RenP+qacMBr+HWNlD8IQSI9KxFNddnbwbUtt/rtkUb8P351kLvPfmaxJMfUULJ3BK+miOLqGxrAjRDdGMSnF8kXrF3SGt8HAoBQPk+uBokv3BKjdkXDxnrCHRcAK3MvQjO37SpCWiESCgfXtGrbOy6HV1dcDZcAC9HAhnBQvI/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714667990; c=relaxed/simple;
	bh=v6MiBTlIpCSh3z396eKc53/d3SlKRNmd/FtG/o+2Mb0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qpIlBgen3ETI/UXzG2dsrl4RfZXxhUM+tkH+XdoRmmAOcANN51WpuRrQluGYA2V6auJgCqqosZvt6GU2tvtAGGqvUo9NkGkq9hq+8e6fiWb6jItzqhODluA0RDqTXp0E/Pqrryvcu7FwH25c1thB0ep/sWnzvFkNDYzpgZSaoII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWbMUVeQ; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2b2768f5bb4so2619303a91.0
        for <bpf@vger.kernel.org>; Thu, 02 May 2024 09:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714667989; x=1715272789; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v6MiBTlIpCSh3z396eKc53/d3SlKRNmd/FtG/o+2Mb0=;
        b=XWbMUVeQSNHIHsRb7aVNey+9TVzKzBUkRrSAnDwu8mQB47p6567tFkJ88kK7Z4q0/W
         X2o+QW4ilNQdP52mer9RocptdvlAcl11pM8TktKG1zU5Driyb5Q9I4EZHwASKTyccAWT
         8jcgvkIs6Qxs7X0OCcgHiGSAJvXemAZEiOLJMY00NaItX9rj5fZiLLyd1qS2V1tlmhaF
         baEibjLdjueZXPfNGKcZFVO2y039ZL0XXeWfTNs+85RdsJ9kcOkRLfvu0NAfqwNjJBVa
         RwHiqciifgQwz5j55/5lT1SqNZJ5Oopt+Csf1LKINMgKTyfxiWjXVrlaPwcNqkoIkrce
         wsDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714667989; x=1715272789;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v6MiBTlIpCSh3z396eKc53/d3SlKRNmd/FtG/o+2Mb0=;
        b=YUiyxyuHf+FjSFDNJY+6aAmOkziyTkYx+nckFaXMgBgd00i5y+6X1rJSoH7dFF8kk7
         /7QXpbC6dKLaIcbFTCB9V7GRwDZ59Y6FXAoQETzjB10RWT5mN+fiJOGVmWnuL3MDJck+
         rlLKBQmjSO+PfutT/xwNa8/WUrFnTLU6h8LvRwTmM0JEyHBxHw28/HJxD5ysGJ+QLjlt
         f3YqrMDH/bjJ5yoNTjzx0+V0iNH0X864Xs0bdA1FyvY5+Id3fUYn2pNEhsK8NQVJFh8J
         KeWaEddjRiP8LajEUxh7BnCJ+xmfP/GQmx4+zAKcUMSKY+jRrX1EqchzNtupi4pJo0rT
         UO1g==
X-Forwarded-Encrypted: i=1; AJvYcCX/6Qba/UC4NSl3e67zJF6CxLM9aR0qkSjXnHsb6uxXc+hceuSMBkyGWJSBlUcUQh3aVZgu0KKUhOQybTR/chxHfGRv
X-Gm-Message-State: AOJu0YyVSuXu9d/vzRICW/S1MSwUlWmFSL6qnvJxizuTUWLQmGeDhlVA
	lAiCZIAiB2HnMsSMqidBgyJUtkC0DAr8Hagfr2KoDBhgPmrJTrc/
X-Google-Smtp-Source: AGHT+IExTR75hEX9K4hKaxCOs6BEc0vB3cF4atfVKHWIlvLxqUoMMUdDEAvhdc1mnXMq4q1FHfIv+Q==
X-Received: by 2002:a17:90b:238f:b0:2b2:1514:b79d with SMTP id mr15-20020a17090b238f00b002b21514b79dmr283191pjb.31.1714667988614;
        Thu, 02 May 2024 09:39:48 -0700 (PDT)
Received: from ?IPv6:2605:8d80:4c3:8aa3:a6b4:2cc7:9867:3518? ([2605:8d80:4c3:8aa3:a6b4:2cc7:9867:3518])
        by smtp.gmail.com with ESMTPSA id t14-20020a17090ad50e00b002b409f41604sm365190pju.0.2024.05.02.09.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 09:39:48 -0700 (PDT)
Message-ID: <21a0516c0ce86941f9cc6b95d978e9d7ab071ba1.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 09/13] libbpf: split BTF relocation
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alan Maguire
	 <alan.maguire@oracle.com>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, jolsa@kernel.org, acme@redhat.com, 
 quentin@isovalent.com, mykolal@fb.com, daniel@iogearbox.net,
 martin.lau@linux.dev,  song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com,  kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, houtao1@huawei.com,  bpf@vger.kernel.org,
 masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org
Date: Thu, 02 May 2024 09:39:43 -0700
In-Reply-To: <CAEf4BzYnw3n_qHGCBGPxYw1Q1S8d+uF62MybJakgcAG9=CF-Bw@mail.gmail.com>
References: <20240424154806.3417662-1-alan.maguire@oracle.com>
	 <20240424154806.3417662-10-alan.maguire@oracle.com>
	 <CAEf4BzYr8ONqLuH0q+FFJijx3ADrqn464pf8E4A3s+uJ03cyVQ@mail.gmail.com>
	 <8483cbf7-6729-471c-8aa8-f88c9e306fe5@oracle.com>
	 <CAEf4BzYnw3n_qHGCBGPxYw1Q1S8d+uF62MybJakgcAG9=CF-Bw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-04-30 at 10:41 -0700, Andrii Nakryiko wrote:

[...]


> Speaking of sorting, Mykyta (cc'ed) is working on teaching *bpftool*
> to do a sane ordering of types so that vmlinux.h output is a)
> meaningfully (from human POV) sorted and b) vmlinux.h overall is more
> "stable" between slight changes to vmlinux BTF itself, so that they
> can be more meaningfully diffed. This is in no way related to sorting
> vmlinux BTF data itself (sorting is done on the fly before generating
> vmlinux.h), but I thought I'd mention that as you are probably
> interested in this as well.

Oh, well...
I have a sorting pass already, it is here:
https://github.com/eddyz87/dwarves/tree/sort-btf
Would be a bit simpler, if moved inside libbpf and uses internal APIs.


