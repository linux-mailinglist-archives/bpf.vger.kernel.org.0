Return-Path: <bpf+bounces-44666-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDF29C6114
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 20:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 355F1283EDD
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 19:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DA12185B3;
	Tue, 12 Nov 2024 19:13:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx.der-flo.net (mx.der-flo.net [193.160.39.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE335218316
	for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 19:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.160.39.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731438825; cv=none; b=NGAp2qaipjeIOI34YHLVEX0dILtqmvjuJHohU69HJY1SkSPm39oYs1i2dQcFKfpaSMfN3/ZGBoS7BljbmmXyJWAPxZ4mmgUcwFJPD5yufILOWGFoQCsqBGcid+ndGMixe0HR90wfZo0i3xGO2LHPvMqT53iaiUgN5EJQc/iNFVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731438825; c=relaxed/simple;
	bh=HAkEslaWbzvbDsTRvjr+utZUIyDnIXogZFNJO1XxHMw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDXZavHzW0O6rBXhE4v7vaW+XLXUWpfbDe7ZAAjTD8dd78wZru6yDCZ3y3XGDlddnFFdXyK+WFx8H3WWPlzdULDaVZkKgXH54rD3/tYMLFcu2EiPLPg/bzahHTuYKfmlHKsz2oCr/yPhpnj32uXaBu4JW8qfwmAKT0Z207D2ubA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=der-flo.net; spf=pass smtp.mailfrom=der-flo.net; arc=none smtp.client-ip=193.160.39.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=der-flo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=der-flo.net
From: dev@der-flo.net
Date: Tue, 12 Nov 2024 20:13:33 +0100
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Hou Tao <houtao@huaweicloud.com>, bpf <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>, Kees Cook <kees@kernel.org>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	Martin Kelly <martin.kelly@crowdstrike.com>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	yikai.lin@vivo.com
Subject: Re: [bpf-next 0/2] bpf: Add flag for batch operation
Message-ID: <ZzOo3ZTefm8Pf6st@der-flo.net>
References: <20241110112905.64616-1-dev@der-flo.net>
 <a917cefe-28d5-ceeb-5cfa-4fbb8f9a3c9d@huaweicloud.com>
 <CAADnVQKKaNkmyCX5EwL+k0YZXFFrT4v+QtwDX6_7d7oJXjp=UQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKKaNkmyCX5EwL+k0YZXFFrT4v+QtwDX6_7d7oJXjp=UQ@mail.gmail.com>
Fro: Florian Lehner <dev@der-flo.net>

On Mon, Nov 11, 2024 at 07:01:26PM -0800, Alexei Starovoitov wrote:
> On Mon, Nov 11, 2024 at 6:15 AM Hou Tao <houtao@huaweicloud.com> wrote:
> >
> >
> >
> > On 11/10/2024 7:29 PM, Florian Lehner wrote:
> > > Introduce a new flag for batch operations that allows the deletion process
> > > to continue even if certain keys are missing. This simplifies map flushing
> > > by eliminating the requirement to maintain a separate list of keys and
> > > makes sure maps can be flushed with a single batch delete operation.
> >
> > Is it expensive to close and recreate a new map instead ? If it is
> > expensive, does it make more sense to add a new command to delete all
> > elements in the map ? Because reusing the deletion logic will make each
> > deletion involve an unnecessary lookup operation.
> 
> +1 to above questions.

There is an eBPF map, that a variable number of eBPF programs use, to access
common states for a variable number of connections. On predefined events, a set
of keys is deleted from this map. This set can either be all keys or just a
subset of all keys - but it is not guaranteed that this set of keys still exists
in this eBPF map.
The current work around is to use bpf_map_lookup_and_delete_batch(), as this
operation continues on missing keys and clears all requested keys from the eBPF
map. The noticeable downside of bpf_map_lookup_and_delete_batch() is the memory
requirement that comes with the lookup and allocation for the values.

> > [..] If it is
> > expensive, does it make more sense to add a new command to delete all
> > elements in the map ?

It felt like bpf_map_delete_batch() was introduced for this use case. So adding
a new command was not considered.

> 
> In addition:
> 
> What is the use case ?
> Are you trying to erase all elements from the map ?
> 
> If so you bpf_for_each_map_elem() and delete elems while iterating.

bpf_for_each_map_elem() could be an option if the map should be flushed
completley, but in most cases only a subset of keys should be removed from the
map.

> 
> This extra flag looks too specific.

Sure, the proposed flag is focused on the delete operation. What could be the
requirement to make it less specific?

> 
> pw-bot: cr

