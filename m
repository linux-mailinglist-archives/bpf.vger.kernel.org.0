Return-Path: <bpf+bounces-41956-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AFB99DCEE
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 05:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B19B01C202E8
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 03:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B24171E68;
	Tue, 15 Oct 2024 03:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Kg2gBM0G"
X-Original-To: bpf@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC82916B38B;
	Tue, 15 Oct 2024 03:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728963651; cv=none; b=g+zeNsMe2z4HgeIuu5I1BGpswDWfJifZ5y/aZXbQvQgqqLbCEM+GiohXiS08zo4+GCKU1ai6akdw6LsTvU92k/bRaxHIgjkUmMse8VKPOEcMPqRr6g5dwnUvmbLe2/gqUutClg5rMBBYQY/pQy2Cj2P2/2+ClE1uhNz7mCIRBMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728963651; c=relaxed/simple;
	bh=m1BIgydw+BK/Cu+/JPGs9ohupKxofVR0Don2K73xLHY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=eerD1H/FQsbOOBJxriuiQpaesvO89/Yz43orseudlhlK83tLjmN2xxCP9bPNKyuIrxDX4TpxzDxCO432gsBUx0pcslKWJHko/lywyBaAxUvjlpdR2eYsqy75Kr4jxxcEq8wvHAT6oQn0y0xTidNA2idgbk4QYYN34+4cxji7V2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Kg2gBM0G; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728963646; h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
	bh=SoE4b6Fh2i+wNz9A6qzp58ws/Tpioj00Mn3o6HsCXi4=;
	b=Kg2gBM0GaZMDJo5asC2IudkdV1Vf33pRhwXRV3ALDkfHcwaid/AkOC164RM1F4ihl1wXIcFCxtqA5+gB6K2VPhO6FdbdMkOclrz5c70lvnP8HZ8k1FZ5O89s9dcC3lNukEOru59eIj0yEM3jVjPhBc0qiclVjcRqGUNbDRX/Tic=
Received: from smtpclient.apple(mailfrom:mqaio@linux.alibaba.com fp:SMTPD_---0WHBoqmQ_1728963644 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 15 Oct 2024 11:40:45 +0800
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH] uprobe: avoid out-of-bounds memory access of fetching
 args
From: maqiao.mq <mqaio@linux.alibaba.com>
In-Reply-To: <20241014145808.GA8567@redhat.com>
Date: Tue, 15 Oct 2024 11:40:34 +0800
Cc: linux-trace-kernel@vger.kernel.org,
 rostedt@goodmis.org,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 mathieu.desnoyers@efficios.com,
 namhyung.kim@lge.com,
 linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C45A2710-BAC4-42FF-93A6-C0165A3EC446@linux.alibaba.com>
References: <20241014061405.3139467-1-mqaio@linux.alibaba.com>
 <20241014145808.GA8567@redhat.com>
To: Oleg Nesterov <oleg@redhat.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)



> 2024=E5=B9=B410=E6=9C=8814=E6=97=A5 =E4=B8=8B=E5=8D=8810:58=EF=BC=8COleg=
 Nesterov <oleg@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Sorry, currently I don't have time to even try to read this patch, =
just
> one note below...
>=20
> On 10/14, Ma Qiao wrote:
>>=20
>> @@ -979,6 +980,11 @@ static struct uprobe_cpu_buffer =
*prepare_uprobe_buffer(struct trace_uprobe *tu,
>> 	ucb =3D uprobe_buffer_get();
>> 	ucb->dsize =3D tu->tp.size + dsize;
>>=20
>> +	if (WARN_ON_ONCE(ucb->dsize > MAX_UCB_BUFFER_SIZE)) {
>> +		ucb->dsize =3D MAX_UCB_BUFFER_SIZE;
>> +		dsize =3D MAX_UCB_BUFFER_SIZE - tu->tp.size;
>> +	}
>> +
>=20
> Then you can probably kill the
>=20
> 	if (WARN_ON_ONCE(ucb->dsize > PAGE_SIZE))
>=20
> check in __uprobe_trace_func(), no?
>=20
> Oleg.

Thanks for reminder, I will remove it in v2=

