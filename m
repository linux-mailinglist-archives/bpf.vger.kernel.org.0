Return-Path: <bpf+bounces-30507-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CA58CE891
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 18:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EAC01C20C59
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 16:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F002B12E1F9;
	Fri, 24 May 2024 16:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egwx1GtP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EB1381BB
	for <bpf@vger.kernel.org>; Fri, 24 May 2024 16:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716567630; cv=none; b=cDH36RDdBn+YgpCK9ZJUYiPfGN35Z81/yjKy22UMTvqsFmXQIzlTfv+j7w4o6/TQx0YxF6C24Bx3T1SL1oD5r2jVYU6jRoImBlK1Vzybb1RwS88q550MdE22/JJUba2qWuk65htf2P1JWKDlEGrv7NJ5LTiFaeEbQDxAJszD/Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716567630; c=relaxed/simple;
	bh=DOla+ptP6Lwd0bMFZq0BAmzVcix+OWvCI2sApqXgLx0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hEbTl+yx6LtKq/oyNToZOSpoPf1wGvFBwAIsUSxGF0wRJvyQpN1sh7Xy0WWoE8+mGCX5MCmAsd9GtWURlKVh2FtAdggxy9lwK8zpKWjX5ArS9QEMvZ65qUi6oMpSq7OrG/hjJYPihrn0kB8Bw7JKY2frqSXrMPgOs5Xlz+mG5PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egwx1GtP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E733CC2BBFC;
	Fri, 24 May 2024 16:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716567630;
	bh=DOla+ptP6Lwd0bMFZq0BAmzVcix+OWvCI2sApqXgLx0=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=egwx1GtP6BtYi/0nWcpQigBT46HUmFfXsvNKQvnyXjSgBYeVEG7NN5OQGA6PTwD7Y
	 Tu1rfHzKOwbtn15WzFCbfoYGJwLEEc8rLlecKnXPS2/4I0jY0N0KHKqhZ856oe919O
	 3+FHjXU9fWPFPxDrJJJF4V3YV+ISU1UQ0MkYAeFL6D1S72Q9j1X9ZvU/w27qrX89Sv
	 dYQO98X405FECE4oeSPyv/J5fxUjnggQsMQmmXzDFQbKIflUswKg7qlxwn28sl85y6
	 Sng1DsmR9ChVU+sbv/WzXlst+b9VHdEjuDMMIMm2sd6xAC0zd0R9lK/3ld3P+6xJ5o
	 BDiQUbGWmn+2A==
Message-ID: <a69b12ef-4ff9-482a-8039-0f977ccaae2d@kernel.org>
Date: Fri, 24 May 2024 17:20:25 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH bpf-next v5 8/8] bpftool: Fix pid_iter.bpf.c to comply
 with the change of bpf_link_fops.
To: Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org
Cc: sinquersw@gmail.com, kuifeng@meta.com
References: <20240523230848.2022072-1-thinker.li@gmail.com>
 <20240523230848.2022072-9-thinker.li@gmail.com>
Content-Language: en-GB
In-Reply-To: <20240523230848.2022072-9-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-05-24 00:09 UTC+0100 ~ Kui-Feng Lee <thinker.li@gmail.com>
> To support epoll, a new instance of file_operations, bpf_link_fops_poll,
> has been added for links that support epoll. The pid_iter.bpf.c checks
> f_ops for links and other BPF objects. The check should fail for struct_ops
> links without this patch.
> 
> Cc: Quentin Monnet <qmo@kernel.org>
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>

The bpftool change looks OK to me, thanks!
Although I wouldn't call it a "fix" (in the commit object).

Acked-by: Quentin Monnet <qmo@kernel.org>

