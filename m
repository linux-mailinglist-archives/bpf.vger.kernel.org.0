Return-Path: <bpf+bounces-30827-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DEF8D3345
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 11:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FC651F25E3B
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 09:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B678016A386;
	Wed, 29 May 2024 09:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NghQR9Gc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369A316A375;
	Wed, 29 May 2024 09:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716975693; cv=none; b=p5RyNoHoAJeDGr0cr246+NgiU3lOZDbDU8lAVTbyTviOkUElO3YJmZjCef6MwTR6adIipZ3SxJisGEn569HmYWEn0wBhPCJThGAzgEig7QiJLHgzv4kTa0R4sAncrKE5YGNMwMnIY7zx87da3CNTLE7QYKjf9/e/EVSMOUVOeoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716975693; c=relaxed/simple;
	bh=uir9LFW50J4kp4Duy6Ppyxb5DdxOsTxyGiQdBZqAzR8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FE/obeTHbqLzUWx+7kPqLxSoRhc4AlGEm0Kjn9aQ1IZXeCj+ZwZfGNncfl6f1D/CLu2tcT7VkjSNV2Vg0u5nLadu8GVXcpgya/6e0zKXNfo1lvx6VUOW0zVo3fLMT//iP/Dn8GVUVnZjWJ+l4Cq6Zd/JXXws2YJepNMtJGzDIqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NghQR9Gc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E69BC2BD10;
	Wed, 29 May 2024 09:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716975692;
	bh=uir9LFW50J4kp4Duy6Ppyxb5DdxOsTxyGiQdBZqAzR8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=NghQR9GcPFym7Ye0xUvNEdcm2BliFOBrPccsChz71UUsd5/+PmDIrPK1jexIdphWz
	 k3eqy8NYXh82zI6F6JX7saXnx+mABFVAyxRfD1R+cCtP2wsOufnfA/HCitcrFF3zPC
	 4AkVP4mMFiD13IsEhcfJLGRawnKfDh27Ym1WgSPudsJuSXmseDhAbphoyMqncllW9q
	 YhqXJSRGVoCBtS3sZFBBP+T8wrlZ9H6LNypRj1pp7gnyT56ur5gynRW9ESXPklSri/
	 9l9E0a9L58NS1AwI53DoaOBc4icUAk3Z2tnP+4JO+cEEdQyevffKOj7AbpND/geAnA
	 WudziyTLhiUAw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Xiao Wang <xiao.w.wang@intel.com>, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, luke.r.nels@gmail.com,
 xi.wang@gmail.com, daniel@iogearbox.net
Cc: ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, pulehui@huawei.com,
 puranjay@kernel.org, haicheng.li@intel.com, Xiao Wang
 <xiao.w.wang@intel.com>
Subject: Re: [PATCH bpf-next v4 2/2] riscv, bpf: Introduce shift add helper
 with Zba optimization
In-Reply-To: <20240524075543.4050464-3-xiao.w.wang@intel.com>
References: <20240524075543.4050464-1-xiao.w.wang@intel.com>
 <20240524075543.4050464-3-xiao.w.wang@intel.com>
Date: Wed, 29 May 2024 11:41:28 +0200
Message-ID: <87ikyx2bw7.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Xiao,

Xiao Wang <xiao.w.wang@intel.com> writes:

> Zba extension is very useful for generating addresses that index into arr=
ay
> of basic data types. This patch introduces sh2add and sh3add helpers for
> RV32 and RV64 respectively, to accelerate addressing for array of unsigned
> long data.

This patched slipped! Apologies for the slow reply.

Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

