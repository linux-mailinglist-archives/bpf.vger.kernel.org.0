Return-Path: <bpf+bounces-39231-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D8E970DBD
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 08:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C463B21EFE
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 06:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20A5172BD8;
	Mon,  9 Sep 2024 06:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cbIfSESD"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475724C8D
	for <bpf@vger.kernel.org>; Mon,  9 Sep 2024 06:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725862124; cv=none; b=oLUaxnEXYmns6CzBMx+6jx6PcEq18FVauu3d1pay9tWTw50ik0YaKn7tRt7hS5sLI2iVrCikRcGdDdO6ug3c8mSaVDzevjhFpwJn+UaXtrOyrEYcZj19GKVZ5aAriIoG8J3p0V21NgG7ndXBm4HiHGpaZVPe4XppdqCJwiYbMb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725862124; c=relaxed/simple;
	bh=5xiu/iA5+PQeYUufikP0lk8lbJomd/g30BALJGepEcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t8wxUM8Zg6Wij6swbdG9o1e7HBPxY0KaLqRzohEGOnyf0NTwt4I1gT7cx+bW0B9P6Jp6qWYhWCvjODXwUIANj0V/oF28rnVxSOXHZVai3VGAoadg/U0rqKDrKPGzyrA5YKVyPnbNFQv57l4ByplCmWgyWP3FSrEly3w1NH/Q8Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cbIfSESD; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <72af9f28-709e-4f2f-bd63-8b2d54740815@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725862120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c8yOIQdvMN2kG5bV50fa9PNFpfILupkagZCONSN7C68=;
	b=cbIfSESDUsnNJMQjPIDNkNedsWy7WwPowdSys/dSNlbshNR/cOdROQCbJpgive8uiQBV8m
	pa4s+ztrX+6UC99QQesxiFh7EzPGbpxQmaV8TuDFGNZapqlyTD+D1airxbf1pC7amSwfZn
	lRQg1QHTulPh6cdEFzBSO4JSx4hGnXI=
Date: Sun, 8 Sep 2024 23:08:31 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Possible deadlock in pcpu_freelist_pop
Content-Language: en-GB
To: Cong Wang <xiyou.wangcong@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Priya Bala Govindasamy <pgovind2@uci.edu>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
 Hsin-Wei Hung <hsinweih@uci.edu>, Ardalan Amiri Sani <ardalan@uci.edu>
References: <CAPPBnEa1_pZ6W24+WwtcNFvTUHTHO7KUmzEbOcMqxp+m2o15qQ@mail.gmail.com>
 <CAADnVQLAHwsa+2C6j9+UC6ScrDaN9Fjqv1WjB1pP9AzJLhKuLQ@mail.gmail.com>
 <Zt34sPvu9mO4Tcgv@pop-os.localdomain>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <Zt34sPvu9mO4Tcgv@pop-os.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 9/8/24 12:19 PM, Cong Wang wrote:
> On Thu, Sep 05, 2024 at 11:40:06AM -0700, Alexei Starovoitov wrote:
>> On Thu, Sep 5, 2024 at 11:37 AM Priya Bala Govindasamy <pgovind2@uci.edu> wrote:
>>> SEC("kprobe/__pcpu_freelist_pop+0x58c")
>> We should disallow such recursion in the verifier.
>> All these "bugs" are hard to prioritize as bugs.
>> When people shot themselves in the foot there will be pain.
> diff --git a/kernel/bpf/percpu_freelist.c b/kernel/bpf/percpu_freelist.c
> index 034cf87b54e9..14c9fcf81ac6 100644
> --- a/kernel/bpf/percpu_freelist.c
> +++ b/kernel/bpf/percpu_freelist.c
> @@ -187,6 +187,7 @@ struct pcpu_freelist_node *__pcpu_freelist_pop(struct pcpu_freelist *s)
>                  return ___pcpu_freelist_pop_nmi(s);
>          return ___pcpu_freelist_pop(s);
>   }
> +NOKPROBE_SYMBOL(__pcpu_freelist_pop);

Maybe add a 'notrace' attribute to the function?

>
>   struct pcpu_freelist_node *pcpu_freelist_pop(struct pcpu_freelist *s)
>   {
>
>

