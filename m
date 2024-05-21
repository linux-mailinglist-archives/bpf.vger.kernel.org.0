Return-Path: <bpf+bounces-30134-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB1D8CB253
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 18:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A4FE1F22960
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 16:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156E31442F6;
	Tue, 21 May 2024 16:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWzoU0PZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8AB1CA80;
	Tue, 21 May 2024 16:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716309600; cv=none; b=e0C338iPyLdTUN/qILc/vdIjWK9pTgwQnaI7fPGyHH5WO2wPLY35JPYvnRiC7eJnCZNxPcAkmITXAOLZsFWhnaBiM3KQdJAG5/fdBirjzQRm3K/DaousxJ/pQNerVO5fEiGz3ydX60Ddlqub5AqZ30Fa3W76gGo6Av7mouLNZh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716309600; c=relaxed/simple;
	bh=DVQA79nAV89v/vOYQVh9+5YPKXdr+s2r4gOfo9ZPLpc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=URjMECeaIbkAOCIZoHVNmXyY3s+JYpBa4RFf1vfdASEi4bmYWttP2IxsnaKqwBhSThKRJ97fQrT6DqDCduEgWOGz0AWDdpBPxvsJb7T2HGcSCgVh5cm6xqw/zg/IkEcBW27xodGagqtjo0AB59zUD7kj4sPz2YQnlltowjlTJE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWzoU0PZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C43C2BD11;
	Tue, 21 May 2024 16:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716309600;
	bh=DVQA79nAV89v/vOYQVh9+5YPKXdr+s2r4gOfo9ZPLpc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=KWzoU0PZy2xmR2e8CBeSJLQmhF/d1L+1C+0YQj2XyBqFYvJ17jZL7lrKjrI9qkYBw
	 ttqikMltUBSFM+kdw5gTV/KOn63eq776q6j6RWaFnN//Dq4IFCe/8tBkcQ0mR5CCLx
	 A+mqNZtxTpDzEmVPzAApsWjLg1BgnIYxMY69WH2FdHWMG4gKwQ7m+fiQ8RCpLhirCc
	 7P8b9jj1WXz5hc+Earjs/zDbIjIDkCVo+rEqZOD2qM8Q7MN0BRkigcJtCsK9midVFx
	 kb+hQD5d1jPgzJcYqqpE3xSlbptbR+XxiWpwKL3RF7DZo1/EVnSIcL5zEvV/BnQe4O
	 3mGSkZw6dxQWQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Xiao Wang <xiao.w.wang@intel.com>, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, luke.r.nels@gmail.com,
 xi.wang@gmail.com
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, pulehui@huawei.com, haicheng.li@intel.com, Xiao Wang
 <xiao.w.wang@intel.com>
Subject: Re: [PATCH] riscv, bpf: Introduce shift add helper with Zba
 optimization
In-Reply-To: <20240520071631.2980798-1-xiao.w.wang@intel.com>
References: <20240520071631.2980798-1-xiao.w.wang@intel.com>
Date: Tue, 21 May 2024 18:39:56 +0200
Message-ID: <874jardspv.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Xiao Wang <xiao.w.wang@intel.com> writes:

> Zba extension is very useful for generating addresses that index into arr=
ay
> of basic data types. This patch introduces sh2add and sh3add helpers for
> RV32 and RV64 respectively, to accelerate pointer array addressing.
>
> Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>

This is dependent on [1], and given it hasn't been accepted yet, I'd
make this patch part of that series.


Bj=C3=B6rn

[1] https://lore.kernel.org/linux-riscv/20240516090430.493122-1-xiao.w.wang=
@intel.com/

