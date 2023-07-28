Return-Path: <bpf+bounces-6221-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F81A767201
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 18:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B658C2825CA
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 16:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A442B14A9B;
	Fri, 28 Jul 2023 16:38:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E72912B95;
	Fri, 28 Jul 2023 16:38:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F1EC433C7;
	Fri, 28 Jul 2023 16:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690562298;
	bh=QH7hp5FWLsXo2pDL9wfVn1CIklN7IUhElBbQmw6PYSw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CLnxif0By9jZ5NFy6QaS2iZHMRexLnQTf4BY34FmVJVn1/ArFm7G3PMUexfsVncOb
	 S+lGrzD+5u2JKoOXE6L3D830/PGA8XfbT1IM7vqvDMef/VcsG5NfbvQznsgCwiKh+m
	 KR0WyatsfNVUV/GboBrUh4rHTVTmoW4Hiemd6rIk9MVsuGWiB2E+ri5Mg19DsWT0uj
	 2m8qlJbzlPfmo2GOFuL0To1lbd/3C7sCLp96ZPHHFm4NBTUMX8nQ6AlKU2tYQemF0m
	 NakrwagJR0TowLCKK8WCaREeyZw2luJzKIW7rP7v+M3OoxhYW65MvWSYJFbq5FsJqL
	 Wv+oGFBVINhEQ==
Date: Fri, 28 Jul 2023 09:38:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn.topel@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Alexei
 Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko
 <andrii@kernel.org>, Song Liu <song@kernel.org>, Hao Luo
 <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>, Daniel
 Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, houtao1@huawei.com
Subject: Re: [PATCH bpf-next 1/2] bpf, cpumap: Remove unused cmap field from
 bpf_cpu_map_entry
Message-ID: <20230728093817.58d5b187@kernel.org>
In-Reply-To: <ZMOuzBkjFGzHjJNI@krava>
References: <20230728014942.892272-1-houtao@huaweicloud.com>
	<20230728014942.892272-2-houtao@huaweicloud.com>
	<ZMOuzBkjFGzHjJNI@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Jul 2023 14:04:28 +0200 Jiri Olsa wrote:
> nit, should it have Fixes: cdfafe98cabe ?

I don't think so, Fixes is for people backporting fixes.

