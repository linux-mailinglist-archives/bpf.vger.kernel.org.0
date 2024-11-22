Return-Path: <bpf+bounces-45482-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D429D65BA
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 23:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C97928225D
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 22:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EB71CB528;
	Fri, 22 Nov 2024 22:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJRxYAVw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4EF1C5799;
	Fri, 22 Nov 2024 22:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732313870; cv=none; b=Y0BNzlSNAcyx/8izA/f+jJ1dqEtRIPX/jlUYzQ9zYEucNhE6pvuqOOXsCNgvRNXHo/DUFVsFcAoXUdZuAH4KmDVrT9B5aYXiIcuTAuuAuMj/lksmQUk+Jinu51lilazfjMeriRott/rMPs4qfUKDExtuXg3cn7Y8jSuvtrKArqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732313870; c=relaxed/simple;
	bh=9KLPixWlyoIEAo3UX5SmGomASPN/KNoEJb7Ng39Mcpk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tvt9yXTpIlsq+n2+rWMI7lTKDlOJFSFlJfL+3Q+3Q4xn2pzRfgaGmUqUnuZ1Jwi9DjPhIjld5XeOKWkz+XD/I/ZXpSMyRa8PBRfOELhf4cyiQvq7RGacNYSYMjzUqCvapeLEpgN10r+fS2x8Pb7qxEFfJwoJKfIktA88vrQ4VN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJRxYAVw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 471A0C4CED0;
	Fri, 22 Nov 2024 22:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732313869;
	bh=9KLPixWlyoIEAo3UX5SmGomASPN/KNoEJb7Ng39Mcpk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=lJRxYAVw8m3SjtJLm0q/kFVSERR2e/LErZyjcNecPu7prbuP69hTiWgDsDnT68uQ6
	 l1/NCDIaVQbUsWSB27BUHx4hrDGmg/zV5dUw7zbvdImDJWGLSkgAxEpc1X5F85u+yY
	 i7IbwyrMbbu/zZUR6NNnfLlKAq2jO3A37HaBeueYByLfuzH7WfbIhtLgNFSJtZJcva
	 Dhi1eMXem1v5H2jBt3TUUxUKQsACu86Zs2T00a2dzG1jBoyaLt0kpbDXmmXgcB7yfQ
	 5Sx1gB3xxf8RP0JAbm2ZdRcUqvYpRuLNJBnOCEc6Vu9VTTjiO3NjwJcpvJVmDr9iiW
	 /A0wRpMjEYOYg==
From: Namhyung Kim <namhyung@kernel.org>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
 Hao Ge <hao.ge@linux.dev>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Hao Ge <gehao@kylinos.cn>
In-Reply-To: <20241113030537.26732-1-hao.ge@linux.dev>
References: <ZzOJOEpyAc92462-@x1> <20241113030537.26732-1-hao.ge@linux.dev>
Subject: Re: [PATCH v2] perf bpf-filter: Return -ENOMEM directly when pfi
 allocation fails
Message-Id: <173231386925.85365.8829270554421454686.b4-ty@kernel.org>
Date: Fri, 22 Nov 2024 14:17:49 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 13 Nov 2024 11:05:37 +0800, Hao Ge wrote:

> Directly return -ENOMEM when pfi allocation fails,
> instead of performing other operations on pfi.
> 
> 

Applied to perf-tools-next, thanks!

Best regards,
Namhyung


