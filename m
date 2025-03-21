Return-Path: <bpf+bounces-54521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C45E4A6B3B6
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 05:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15FC57AA0C8
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 04:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0231E833F;
	Fri, 21 Mar 2025 04:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AEBRVxEH"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFCD1DF248;
	Fri, 21 Mar 2025 04:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742531814; cv=none; b=Dt9wxCWZmLAscXXVLAxG8Ydm9hBLa/gGVKO94qiMeUbEn8XYj6sDdMb3uOtjpCGIo0hp2uIqbrx13Socy9ecmq8YA3oIOofIQZTDbOrfiyhbMY8mo9Jy75NzWJOCfvQMA3sDuc6e8n3jzdGAROs1bloiEvFahDNNQ62KnGmOfmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742531814; c=relaxed/simple;
	bh=t0i7SiFUWByjspuwZXWi2oX+opfdd37i61RQzSXbxd4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fp7MDbRxwuCubBOm87LMAgjoRhqcBsQTAbNVl+SRIG/7ETwzFYZIOISG+6dvn2VjcTa3yx0Zqtwh4UkOflLgRGPRRCvxJbtICIDeCILBXOcsgoqo5JTU+fuD4VV+1rFwFZnQP1awID/GB3qz+4j3cStgbf5/e/AAjlzktFSOwdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AEBRVxEH; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Z3pCP
	xJVXUUIxdhsJWQMXxWW0e4Bl3BXgVM1YB2G9Vw=; b=AEBRVxEH2NGvW5hB8z5F6
	LWvOhF1bHllsstptTw5do9/ZWVcza3pHKg9vY+VTCVPlPUJnQdKoreBMhii96f6l
	DjhqyQWd2rBYHdAcfPCyT1PCkyUDlmNJZ0KW7TXJ1MUFL2eeL8HqKlHO9HFDzAFU
	zI/ginTmlW/IE3w9ooFaPI=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3zxSh7NxnVIVvAw--.47506S2;
	Fri, 21 Mar 2025 12:35:46 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: song@kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	mathieu.desnoyers@efficios.com,
	mattbobrowski@google.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	sdf@fomichev.me,
	yangfeng59949@163.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH] bpf: Remove duplicate judgments
Date: Fri, 21 Mar 2025 12:35:43 +0800
Message-Id: <20250321043543.174426-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAPhsuW4iVUdwhgDsnwy0oeiPhdfMSrRfEcXSFHw7bqXtBVzPyQ@mail.gmail.com>
References: <CAPhsuW4iVUdwhgDsnwy0oeiPhdfMSrRfEcXSFHw7bqXtBVzPyQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3zxSh7NxnVIVvAw--.47506S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFyxur13GFyDAFWDAF48Xrb_yoW8XF45p3
	y7Ar90vr1vyw47XrsYyws8J3Z7Kr1rWrWkWr97t343Zr45u39rtFWxGFy5K3s3Zryakay7
	Xw42q39IkFy7Aa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUoOJnUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiwgMXeGfc6olCWQAAst

On Thu, 20 Mar 2025 09:45:17 -0700 Song Liu <song@kernel.org> wrote:
>
> On Wed, Mar 19, 2025 at 8:23 PM Feng Yang <yangfeng59949@163.com> wrote:
> >
> > From: Feng Yang <yangfeng@kylinos.cn>
> >
> > Most of the judgments also exist in bpf_base_func_deto, remove them.
>
> "Most" of them also exist is not enough. Please make sure that this does
> not introduce any behavior change. For example, we should not remove
> return of bpf_perf_event_read_value_proto.

in trace/bpf_trace.c:
const struct bpf_func_proto *bpf_get_perf_event_read_value_proto(void)
{
	return &bpf_perf_event_read_value_proto;
}
in bpf/core.c:
const struct bpf_func_proto * __weak bpf_get_perf_event_read_value_proto(void)
{
	return NULL;
}

And weak symbols will be covered
nm vmlinux | grep bpf_get_perf_event_read_value_proto
ffffffff814b90e0 T bpf_get_perf_event_read_value_proto
ffffffff814b90d0 T __pfx_bpf_get_perf_event_read_value_proto

So the return of bpf_perf_event_read_value_proto can be done through the bpf_base_func_proto function.
bpf_base_func_proto
	......
	case BPF_FUNC_perf_event_read_value:
		return bpf_get_perf_event_read_value_proto();

I think this can be removed.

> For future patches, please read Documentation/bpf/bpf_devel_QA.rst
> and follow rules for email subject, etc. For example, this patch should
> have a subject like "[PATCH bpf-next] xxx".

Thank you very much for your suggestion. I will pay attention to it next time.

> Thanks,
> Song



