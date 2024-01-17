Return-Path: <bpf+bounces-19739-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E16830B83
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 17:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 312B4289C18
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 16:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300FD224F6;
	Wed, 17 Jan 2024 16:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t9xcNGIo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FE9224DE;
	Wed, 17 Jan 2024 16:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705510396; cv=none; b=VBMB7GrQmCE9Pql8eyuhVgx0TKjdfs1rzv+zS8qaymYRx1FpxLs8tQh/Brb4iBDsnqtsRX1eFp5So9x6MQ+ajhUshu+01GJOS/hQWl36O0rn+DZa70YxaSwZveJ1jgfc/rv7dn9NR3nGQ7fmBbxgz3S3p4Ssts6VMS6WK2lQ7WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705510396; c=relaxed/simple;
	bh=VecUnNaZ+QCKE0wQUuBzSLiw4fD7vVNCEKLBsl42xn4=;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding; b=aMmz+DXeIHG3ZlEpbGWWSeX5ytVTpqtRLpXAGF5F+LVerjxM2UV/2kRS4SxSAuxTvEwLLmDyW2R4d526x4iHiMn6SxzBrD+sB7WFmCxqPUaVZRJOM7B76VsQUhxyKEE1LMvd8W3Pk58MSn1JQzXdl5dtbb5Mug+AYblaTLh1vnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t9xcNGIo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B08C43390;
	Wed, 17 Jan 2024 16:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705510396;
	bh=VecUnNaZ+QCKE0wQUuBzSLiw4fD7vVNCEKLBsl42xn4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=t9xcNGIoio6D5Rcau26Tjj/EIJErFWMXImrFpmxPEhT9s4PMu0x7MlqlDKL5cUI9j
	 jEzGynTiL1uxRWuZJcjs8n7lp8M/auKrLTbbsatNRPs3Q+SFj2oFv5jPUHpUl/B0TQ
	 OG0aIakiNZUsEJGFY3dA/oh86e1TfEKx3lua6OFcw1S6rr8DaXQZJqq2E3zDM75E/l
	 dCMG8/XuV8YXf6k5dReyWnvcHUyhaCDWZIswL8oy386zwywKmqd4a1jw27BEE8C9X1
	 yJENvVFLc8HhnkNZ6hc/ogwEn9bGnPweJo8RLME9jahFNjrGueLRBYmt+gX3+xY4kW
	 vvpHEawvu7z2A==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ccb4adbffbso127096961fa.0;
        Wed, 17 Jan 2024 08:53:16 -0800 (PST)
X-Gm-Message-State: AOJu0YykGZ2VRb/OqZdDDtp6da69JB+VNfZfx6naEWnJjFVdnsmMPdWA
	d3bPjMhFG935tGFRNM5flCrSgQMIjNhN7z1j68M=
X-Google-Smtp-Source: AGHT+IFG1WfxxVqMrzCo6IY1NlFsqpx8I80fJU4OlAhiLFW94U0EoenPknpkBDRpX0jFES7sey+7sK/5wwG1jyF3gvk=
X-Received: by 2002:a2e:8401:0:b0:2cc:7ed4:118f with SMTP id
 z1-20020a2e8401000000b002cc7ed4118fmr4100965ljg.72.1705510394367; Wed, 17 Jan
 2024 08:53:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117111000.12763-1-yangtiezhu@loongson.cn> <20240117111000.12763-3-yangtiezhu@loongson.cn>
In-Reply-To: <20240117111000.12763-3-yangtiezhu@loongson.cn>
From: Song Liu <song@kernel.org>
Date: Wed, 17 Jan 2024 08:53:02 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5RjHLvBv8Ezcir1H_bfnzSrodhuDwLXW1_xjuLt8wAzA@mail.gmail.com>
Message-ID: <CAPhsuW5RjHLvBv8Ezcir1H_bfnzSrodhuDwLXW1_xjuLt8wAzA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/3] libbpf: Move insn_is_pseudo_func() to libbpf_internal.h
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 3:10=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> Currently, insn_is_pseudo_func() is only used in libbpf.c, move it
> to libbpf_internal.h so that it can be used in test_verifier, this
> is preparation for later patch.
>
> Suggested-by: Song Liu <song@kernel.org>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Acked-by: Song Liu <song@kernel.org>

