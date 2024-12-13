Return-Path: <bpf+bounces-46863-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAFC9F109F
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 16:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E138282C50
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 15:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9071E1C3F;
	Fri, 13 Dec 2024 15:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpJBlqs6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C4C1B412E;
	Fri, 13 Dec 2024 15:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734102943; cv=none; b=esGEKIWUlqZ9B0NEoUMiVTk0NyWNu0BASesCT+0Ll4tKUMmBWsHx07b7extzrKYAYF48PRvKWZWM+P8xnNIZPRJb4iT6+Ul4vzCzZgW11eaUGU33bvfy2bnkwGn4zL8Y+3eO3N2tl//qG0SCPsR7567YhZzzJ99F9/GK5sVir3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734102943; c=relaxed/simple;
	bh=IFBihjxjSO3ryqGZq8IhhW8YEEel1WiqKn3Ctn7WHeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qVdXbU1bVR2lUfhdSWyDYiTD1DtBFQ8kme7R/hDpNrz8lE7RLvXXXMi2IplRniG3Q5d4xGudjw9YPEDJTpXi3L6Nchq8TPzzmndq8044cugOx8PkDFBOHDErTUMnucqKb+d/MNVcDDAsrENc5bvIWJIOAx5vHmTyyrC1XfGrHVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpJBlqs6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D370EC4CED0;
	Fri, 13 Dec 2024 15:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734102943;
	bh=IFBihjxjSO3ryqGZq8IhhW8YEEel1WiqKn3Ctn7WHeA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NpJBlqs6x3Fc0j+tcb1gthIMu01i2CPG9RHxpF6zkAw7pQreYDc3pMLcjoBQ/W1is
	 Mdga6EzvvvD+GrWioMhZI6GIycVy4thcXuurI8dazRctMZua0+FkOYL1d0td4cJzWA
	 /tMUPwlDSyogSjjqDJXyaCM+PMlECl8INJY0CjmhY5Bpj85lUYIP2X9hMrqSrIvdvS
	 uBgFMYR1MRT9sm8Yvanvl6edmrh8Z2TTJK8kvdWOs4lukRPRzlVkXB1TDtE29z88Mu
	 IKt14fOs8Owih0tkGcacJmTNUmNW8pfBsBvr9ZMWJNOH8MYXMBhQ81nYqeAbdzsC6+
	 VTAWdXJIFICxw==
Message-ID: <6bc3d112-920a-43c7-a1ab-d43769194d90@kernel.org>
Date: Fri, 13 Dec 2024 15:15:38 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 1/4] bpftool: man: Add missing format argument
 to command description
To: Daniel Xu <dxu@dxuuu.xyz>, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net
Cc: martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, andrii.nakryiko@gmail.com, antony@phenome.org,
 toke@kernel.org
References: <cover.1734052995.git.dxu@dxuuu.xyz>
 <d5ca200da5a39f31ed34b9b90772e17476764f50.1734052995.git.dxu@dxuuu.xyz>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <d5ca200da5a39f31ed34b9b90772e17476764f50.1734052995.git.dxu@dxuuu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-12-12 18:24 UTC-0700 ~ Daniel Xu <dxu@dxuuu.xyz>
> The command description was missing the optional argument. Add it there
> for consistency with the rest of the commands.
> 
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>


Reviewed-by: Quentin Monnet <qmo@kernel.org>

Thanks!

