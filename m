Return-Path: <bpf+bounces-42815-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5349AB65A
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 20:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6F41284DBD
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 18:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5321CB316;
	Tue, 22 Oct 2024 18:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQ1DvgYy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F308812B93;
	Tue, 22 Oct 2024 18:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729623442; cv=none; b=fJ9QYI4e2WqN9O7NbHg1tpUecXrAhpCP0WSE4FD7CqCADYP4fqtdGBVTbnE7FbKxCLy+ASvSId9+DwIusYRtiEqMFiwSbQkczgYWzIAOurgYHsTELb74IYbY0DIj/PiP+AEW3K7MxEM2flcZO+bjnUxXjvFipKVYzAb/0MlfEfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729623442; c=relaxed/simple;
	bh=FP6NhQzU88Gw+cNSMoZhunN/QvG8wC+g93oTC3G3Fcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smOi0p/AHKQ9uDoFCJ2CITAuSmX3NyZyYRq3zmI22ShOLVwOEG2deLoKyKcK+J+PdHDcdDhUVoQuh1PeWyUYxg+UlouXCYSTLtjLrFG/A361hhgn9lr10YfB5dAzid1/8D0cyWSQT/Uizw2TbARDHnzttrgVmQO/BJVw6Aj1ve4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQ1DvgYy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57DCBC4CEC3;
	Tue, 22 Oct 2024 18:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729623441;
	bh=FP6NhQzU88Gw+cNSMoZhunN/QvG8wC+g93oTC3G3Fcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XQ1DvgYyKkws4PU9HvAvrE2fPI7pUcTlGtIZuzIFppAmMLQtR7rtYelwD7JK8Lx6f
	 AvoJ0BAXZQ9ofbxg/W1D3eaFreHrQUPj01Jp4GTBTFITysSdBABxfLmLt9oWNpLvBm
	 PPiBsMIjLfGqh8aeo3jcMA7DUPtWqN1tj3dsx5AjtN5FCmXftAMJJt18g6zrVoEhMo
	 fI5ZmgXyNhuylkrFsY/ri2HCkAmGumQ2dIP0I6ArZ8EQCo0pCfZ+A2xNdgapx62HxW
	 izFuZlaAYqxWaDjBXOWV1eJGEHSQb2ZSUSWQuhga8zQG1fC0RuJVZ+Db0V+7JlyN3v
	 ygIOpyLqWj1rw==
Date: Tue, 22 Oct 2024 08:57:20 -1000
From: Tejun Heo <tj@kernel.org>
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: void@manifault.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	andrii@kernel.org, mykolal@fb.com
Subject: Re: [PATCH] selftests/sched_ext: add order-only dependency of
 runner.o on BPFOBJ
Message-ID: <Zxf1kLZdj1tOtozZ@slm.duckdns.org>
References: <20241021231648.921226-1-ihor.solodrai@pm.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021231648.921226-1-ihor.solodrai@pm.me>

On Mon, Oct 21, 2024 at 11:16:52PM +0000, Ihor Solodrai wrote:
> The runner.o may start building before libbpf headers are installed,
> and as a result build fails. This happened a couple of times on
> libbpf/ci test jobs:
>   * https://github.com/libbpf/ci/actions/runs/11447667257/job/31849533100
>   * https://github.com/theihor/libbpf-ci/actions/runs/11445162764/job/31841649552
> 
> Headers are installed in a recipe for $(BPFOBJ) target, and adding an
> order-only dependency should ensure this doesn't happen.
> 
> Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>

Applied to sched_ext/for-6.12-fixes.

Thanks.

-- 
tejun

