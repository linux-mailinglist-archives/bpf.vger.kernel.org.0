Return-Path: <bpf+bounces-29335-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F19C8C19FB
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 01:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0055F1F22AE2
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 23:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E334412D776;
	Thu,  9 May 2024 23:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHG0j9zp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674B512838D
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 23:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715297975; cv=none; b=RF7XlYemb8cHdQOYd6ZzoTpiCFbrZY5Epm6p/ZSxB/AWSLEXK6zCFB/c/0oPNqJiXM/mlILVeQTYjF3m0OWDGBAydGNSJ3fQYNZILFrg3fwy5GazPXK8B7OEZn1T1M50ExFJ9YSDYwVX4QDMdDqN3Lk4SvL7lo8aCDmOOoEWbrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715297975; c=relaxed/simple;
	bh=LI40IudIaXCycqRc+K8vCPt+iWCPncA1ZnUhn8PY5Qc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jB0cuQJITUNNKOJMiNLWzfKUPBghhlYskaSnEHff9qADQIIGQ17oa1WM58HSCludqGu8TzL7qQlQRXbZANwh6YKGrTh5uQaW8YxVNQp9l8yRYVqkszpA4elos+e4R6+MsJPbfyW1yfMSGQgS9JiKi1wGcnH/2aGy4Y6Jk880Lyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHG0j9zp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448B3C116B1;
	Thu,  9 May 2024 23:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715297974;
	bh=LI40IudIaXCycqRc+K8vCPt+iWCPncA1ZnUhn8PY5Qc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AHG0j9zpy6l73EsUJnOwdbcIbS2VP21k9jhhBsVrRkYkQkdh2FG0NmdLrodH94A6N
	 Qmr2tor4laflIVLsCpDSlgjdeSwcVrauHFgtt/P+FhvaPrtHUgVW0m8OnSmLxN/1cj
	 7gWvvHOgJRTiRd3+ZeLV7TuRKw818RJBvr4eMRuovrj1qoubrH3aN+wlnPF5k1ySg+
	 GURaUw1T5pbbI34o1k/uyQBHbBVlD6i0Gp76a4Y4IaJZFw0NwC64QeQUd9rVrUViFk
	 6c/GstCAE8XXl5vc+S/ovul/xbQuxR8vQRFuUKzbd+HR8ggXdEWyAaz7NHcx9qe7bo
	 7vMhbP0BXd3HA==
Message-ID: <abc638ce-7985-4c43-82a5-7d1589d42305@kernel.org>
Date: Fri, 10 May 2024 00:39:31 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2 bpf-next] bpftool: introduce btf c dump sorting
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Kernel Team <kernel-team@meta.com>, Mykyta Yatsenko <yatsenko@meta.com>
References: <20240509151744.131648-1-yatsenko@meta.com>
 <CAEf4Bzbfiii8yamOoMgoQjswvvrehF8crUK_4zJ8AA1tmHWoxQ@mail.gmail.com>
 <fa464ad7-4af3-4c25-a786-0f6b5c9d260e@kernel.org>
 <CAADnVQKUZtOjMKWq9OxmLVH=zShnOF7DNCmncK+qFkTpdRz9dg@mail.gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <CAADnVQKUZtOjMKWq9OxmLVH=zShnOF7DNCmncK+qFkTpdRz9dg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/05/2024 00:24, Alexei Starovoitov wrote:
> On Thu, May 9, 2024 at 4:09 PM Quentin Monnet <qmo@kernel.org> wrote:
>>
>> Nit: Most variables in the file are declared in "reverse-Christmas-tree"
>> order (longest lines first, unless there's a reason not to). Could you
>> please try to preserve this order, here and elsewhere, for consistency?
> 
> I so hate this nitpick.

Yes, I've seen you push back before; I was wondering if you'd react on
this one. I don't mind too much about the ordering, to be honest. To me,
this is mostly a matter of consistency in the file.

> I'll start introducing non-rev-xmas tree everywhere just
> to stop this madness.

That's maybe not necessary :), at least as far as I'm concerned. I'm
fine with dropping this for future reviews (starting with the current one).

Quentin

