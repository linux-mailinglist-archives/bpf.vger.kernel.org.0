Return-Path: <bpf+bounces-31280-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 404248FA70D
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 02:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1744289845
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 00:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B663863A5;
	Tue,  4 Jun 2024 00:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPGdAIDH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338B85382
	for <bpf@vger.kernel.org>; Tue,  4 Jun 2024 00:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717461138; cv=none; b=LZJFh/kVyux1VZkSki+Lbxl5r95AO1u7FulyTyKT+g1tOBi0QpnCDQl8EF3Ik9lGT+GCR2WXS5pfRGFogHP8HvQ9rbbuyuZtothkYiVaOQhw+yaWM1R8xevHHWl0CGrqN/pe1Ox/Lr6e11fx+Pwvsi88joH8E/pBW1+/HdzF6JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717461138; c=relaxed/simple;
	bh=Y71e4qUYopt2xcRXtU07p6cb55dgho/lnUhVawjyws0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ORTSNxC+SlEH/M8D1GyfIvSf9S9syzPOhvtCfIBdHldqKD+T5NTgFSrEXCM31T6ZV7abVmXKobax3yCmqoJs0MdhoajspN3BhkO+AiBMnmcQAQjBQzlKUw3klhUnS1qyi0OJS+w+lxW063wILO6iqFKinbewFkKCYZ6l57yrO/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPGdAIDH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C24AC2BD10;
	Tue,  4 Jun 2024 00:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717461137;
	bh=Y71e4qUYopt2xcRXtU07p6cb55dgho/lnUhVawjyws0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XPGdAIDHABatAA+ewDK6tpHJ9TonAg0ynNwA4idoLl47+4e2Xfspml8oQSFdQohsW
	 BUQ8+kCHwvFre9aTFF/EGD6F4FSrYTDUmqhmTj265epDFatqS0y2wZRXRrunfD5zc3
	 2r3Seh3/YOKbJZX29q0qqI8HfA6ab6G6fKQBBKc+ETI1JMpkEPuV5YNPMFQNRziP+I
	 uoq8xDpjwW6+jZsL4kRT6w7SGvFbkdinVO+CeDg6aBJE5PRMx9AdYrkq4N+e4Z7V1N
	 yJmMAxmgtFNMVuUFUJAxdx6ocdnEcSxh8E4xMMg99mue0afgxzVTHty1wJF4gRDvAa
	 C4qtxRtjHtUZA==
Message-ID: <a9509c88-c9c7-42a0-a03a-2371e27ea7b6@kernel.org>
Date: Tue, 4 Jun 2024 01:32:14 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH bpf-next 4/5] bpftool: use BTF field iterator in btfgen
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org
Cc: alan.maguire@oracle.com, eddyz87@gmail.com, jolsa@kernel.org
References: <20240603231720.1893487-1-andrii@kernel.org>
 <20240603231720.1893487-5-andrii@kernel.org>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20240603231720.1893487-5-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/06/2024 00:17, Andrii Nakryiko wrote:
> Switch bpftool's code which is using libbpf-internal
> btf_type_visit_type_ids() helper to new btf_field_iter functionality.
> 
> This makes bpftool code simpler, but also unblocks removing libbpf's
> btf_type_visit_type_ids() helper completely.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Thanks for the bpftool update, it looks good.

Reviewed-by: Quentin Monnet <qmo@kernel.org>

