Return-Path: <bpf+bounces-27258-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCC28AB62D
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 22:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58BEC284623
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 20:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FD82BAE0;
	Fri, 19 Apr 2024 20:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2SInC4u"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231631BF3D;
	Fri, 19 Apr 2024 20:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713560275; cv=none; b=iNMrbElPfeTT6d8zGfsm9FbUgrn/NFJg6PP/olEG+gEtd2bF/2aSLUqg5xgPwl3be54h+4NP2UjhMRw6Z8qEECZTFqX7mGE9rXDkqE7yrcVNkd/yc6Mx4A0vkkZSOw+l76YrRRSUalEdGlvi9VAM6kaLqy7TAydrPUmrir3mCUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713560275; c=relaxed/simple;
	bh=n+PHXhqMxr8LZfV3QG+hepPvmYWCnA1yhYga0lTXYgA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qxb0gDGHnILDSo7EiRiqXwZGCkgpbFdw8xYwCLXcS/s59ZYGs2ZKiBAoaE0ublCXNpjFp35zezsi2EzVHye66lctk4gy0tn3fu2VKsxmTR2DL2OKS71UFaOpivSjSds0koVowlWPDuTtr/Mi+lTBGx4NwZEuIkaLakjH+8iebMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2SInC4u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F169FC4AF07;
	Fri, 19 Apr 2024 20:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713560274;
	bh=n+PHXhqMxr8LZfV3QG+hepPvmYWCnA1yhYga0lTXYgA=;
	h=From:To:Cc:Subject:Date:From;
	b=S2SInC4uHuozReg0UkdTmoPJdfwDTcSFbUJpObmfuXhqYeRbcu8PJKie/B2IiyP90
	 o8ZO3O3yG2At8NGYtNvszjkwtGllzmzi/IXaDM7r6bcUemwEkh2VR8ysJHvvczmHBk
	 M/+VVpcBFeASdNgEC5H+Gg4qvQgQWy28kxRXHCiplgIQv64VTM0CJgWL+c5byiNhqP
	 10BSEig5Jfu9cW81nMksWjSyzWLQdYpZv3ODyp8KEWAQlml3SAvAf5P/z21ABC6A4l
	 QgpoVXUiAa6V37iKeA9tptC5n0Dg4FYnCK3V7RKn2Cl9s7+Niz+LktVTv4OKtQ83z6
	 Lam4JnD6s25XQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: dwarves@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>,
	bpf@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Daniel Xu <dxu@dxuuu.xyz>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCHES 0/2] Introduce --btf_features=+extra_features syntax
Date: Fri, 19 Apr 2024 17:57:43 -0300
Message-ID: <20240419205747.1102933-1-acme@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

	Please take a look if you agree this is a more compact, less
confusing way of asking for the set of standard BTF features + some
extra features such as 'reproducible_build'.

	We have this in perf, for things like:

⬢[acme@toolbox pahole]$ perf report -h -F 

 Usage: perf report [<options>]

    -F, --fields <key[,keys...]>
                          output field(s): overhead period sample  overhead overhead_sys
                          overhead_us overhead_guest_sys overhead_guest_us overhead_children
                          sample period weight1 weight2 weight3 ins_lat retire_lat
                          p_stage_cyc pid comm dso symbol parent cpu socket
                          srcline srcfile local_weight weight transaction trace
                          symbol_size dso_size cgroup cgroup_id ipc_null time
                          code_page_size local_ins_lat ins_lat local_p_stage_cyc
                          p_stage_cyc addr local_retire_lat retire_lat simd
                          type typeoff symoff dso_from dso_to symbol_from symbol_to
                          mispredict abort in_tx cycles srcline_from srcline_to
                          ipc_lbr addr_from addr_to symbol_daddr dso_daddr locked
                          tlb mem snoop dcacheline symbol_iaddr phys_daddr data_page_size
                          blocked

⬢[acme@toolbox pahole]$

From the 'perf report' man page for '-F':

        If the keys starts with a prefix '+', then it will append the specified
        field(s) to the default field order. For example: perf report -F +period,sample.

- Arnaldo

Arnaldo Carvalho de Melo (2):
  pahole: Factor out routine to process "--btf_features=all"
  pahole: Allow asking for extra features using the '+' prefix in
    --btf_features

 man-pages/pahole.1          |  6 ++++++
 pahole.c                    | 23 ++++++++++++++++-------
 tests/reproducible_build.sh |  2 +-
 3 files changed, 23 insertions(+), 8 deletions(-)

-- 
2.44.0


