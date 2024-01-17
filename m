Return-Path: <bpf+bounces-19696-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D51782FDF6
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 01:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB05228BC76
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 00:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368F010EB;
	Wed, 17 Jan 2024 00:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cljT7i/o"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF463A55;
	Wed, 17 Jan 2024 00:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705450616; cv=none; b=HxN1bhtNb858ZCqiH6KgsRKYsCJYvL/C9GHK4WYxUSkRsF//J+h31vaPIi9Xf/2RepPXI4fh7BtzRDQR5rvbwt1XPZTCOPnOTJ0iIGR6IXSAuduDuCp9ymWS42V0x4VcaDedrmWxspg0FzpgVyIz7V9DFhon69wtPkVIYeKLb9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705450616; c=relaxed/simple;
	bh=s1Wosr1Yz4+fE3yShzY4jSzeR8e6PZ8kkpRIe2XUw8k=;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding; b=m86oYOjzXuPONhVHpHUA/jhcjbbrfFMjfrraMkMkgcIoTG/jchnKnmDswUG/z6/OHLVQJ2DPG+sE09wyJx3KnVOUUN3oa41WtGqbZv+PXY9obbSLjVFMFDcSgHMHUWSqt7IyMWc3WiGc8cGQz+2vXUfjGXBKENd/sOdRDXk2GZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cljT7i/o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E698C43390;
	Wed, 17 Jan 2024 00:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705450616;
	bh=s1Wosr1Yz4+fE3yShzY4jSzeR8e6PZ8kkpRIe2XUw8k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cljT7i/osYj4dPvAIMXNiMUHaZYXzZCqYlic+3/Ss9z8dcCqVzMkBgCkClOp9S8nl
	 gqYksh12NDRXsRprPrBq9XvSXVy3SF3htLkVXpOqoyPGh1JP+ZxKgd66uas8J36WR4
	 TVhFVnFLE30ns0cUl5tPjLlNwoNPs+n73yDJ1gfi3HHZAoFnKuYuTS7UgMuTjQ9cfD
	 xaFO6y6P8TAhlZD6Z9DRX5OE1PyG8ESKal3E+MCkZJaCCFJixK6DrFjewshCWyBSiM
	 TDDpPZ3B4JM9GiqHpGm5jYar5NdqfGf4XcoQIyfPL3dtuG8Gehsg6PYZRhQWpv1wu7
	 ul7zv8ll+fv3w==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50eabbc3dccso12221318e87.2;
        Tue, 16 Jan 2024 16:16:56 -0800 (PST)
X-Gm-Message-State: AOJu0YzJrbbGqZ36kOjm9NgKQ75RCB0RzXG2BH6nxMx0xT0HbeED4a6O
	Ug/+m6ZodRoPqcgbVyAR5oQB663GPUcQxLJDmQM=
X-Google-Smtp-Source: AGHT+IEwuAuSH+ab52qEU+/Q+aytBuKujDuD+Gj11BgMwh5e6sAVWuoqYWBrxCLG14cGqunKVEpol8ZI4v1oiL1Aj5k=
X-Received: by 2002:a05:6512:312a:b0:50e:bb33:840b with SMTP id
 p10-20020a056512312a00b0050ebb33840bmr1799166lfd.99.1705450614529; Tue, 16
 Jan 2024 16:16:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116045030.23739-1-yangtiezhu@loongson.cn> <20240116045030.23739-2-yangtiezhu@loongson.cn>
In-Reply-To: <20240116045030.23739-2-yangtiezhu@loongson.cn>
From: Song Liu <song@kernel.org>
Date: Tue, 16 Jan 2024 16:16:42 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7WmNJ1VX=3Th0kgP9MS2KezsftkkGJR--d8O7yDnT5iw@mail.gmail.com>
Message-ID: <CAPhsuW7WmNJ1VX=3Th0kgP9MS2KezsftkkGJR--d8O7yDnT5iw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] selftests/bpf: Move is_jit_enabled() to testing_helpers
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 8:50=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> Currently, is_jit_enabled() is only used in test_progs, move it to
> testing_helpers so that it can be used in test_verifier. While at
> it, remove the second argument "0" of open() as Hou Tao suggested.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> Acked-by: Hou Tao <houtao1@huawei.com>

Acked-by: Song Liu <song@kernel.org>

