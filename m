Return-Path: <bpf+bounces-20084-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EC7838FC1
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 14:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54C8D1F264B8
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 13:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA325FDD4;
	Tue, 23 Jan 2024 13:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="N4JjVyk4"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DDA60248
	for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 13:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015729; cv=none; b=JSFBdk54iSTq375XYuhknrDij8mKOEOCzXkzwQq0VRosHJHmaBp0AiYQWuN3Q7c1OPEgfs5lHlNMDdZK1LpIVm06zRrdpiBCiUrminsxtj+Kc5Qo7EfuQqJdQG0LHpqS18D4tS8mn0ehMtjHu1l6FtDPkE63IRyj1KjPxQsXUpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015729; c=relaxed/simple;
	bh=M+VhKqH9tmrfCamt9jQYIe0AslgZkcHSPIugbic5y/8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=emTSm/yCdTem37vnFd+xyO8LQhaDxrbNZ4AVf+CDN5WTdItcwoUzeKdK/eXdyrTJCOtk3FA7uX1IPalj0arEa3MHdmfB9+tPg3JHxpSlPy5KIZW8TwGrbmA69Z9ovz0o2K5MsLK6lgL1WBP1SCwZcn6tBJkal8xtW4Jn20RFiEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=N4JjVyk4; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=yNmTmqPO0Ve3Q/+Hp7iVnUvYuk7oGeZuR8hQ/0yVpnU=; b=N4JjVyk4cXzvcktObr1f1IbmWF
	/HZv5CJsmNMEfcc6xN9NQe5h/RDYfuy+OxLMde0P5fghT22yUO4GM7sh301UD0Fu8Tqn/ptrjEUhL
	qlEYY0TOBimGqookgRWUklnqK7vcddyuDzs863HFApYfScJ0Xyn26bdsK8iGRTzqq+46zE+e3VG8C
	Cyd99tnTQp8Wf4IZF0L0d3W8E5HYldJl1jICrzkn47yMaXyjeUbpoLmlOiea4aNbSzKc7dlXgZL+W
	DPLhzlgk+ircxkQhVYfiodN2J/CcUBPUEP1E+9S6aNm/Kgj3WtMlF9nOrXGuifV2aJ1/F/aVW8/F6
	68XnugTw==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rSGcX-000ClV-NX; Tue, 23 Jan 2024 14:15:17 +0100
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rSGcX-00091k-DU; Tue, 23 Jan 2024 14:15:17 +0100
Subject: Re: [bug report] bpf: Add fd-based tcx multi-prog infra with link
 support
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: bpf@vger.kernel.org, Mathias Krause <minipli@grsecurity.net>
References: <c46a511a-0335-44f5-b6ae-6ad71d6ef012@moroto.mountain>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <d31ca459-5fcf-9e88-03dc-42e9fc10028a@iogearbox.net>
Date: Tue, 23 Jan 2024 14:15:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <c46a511a-0335-44f5-b6ae-6ad71d6ef012@moroto.mountain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27163/Tue Jan 23 10:42:11 2024)

Hi Dan,

On 1/23/24 11:43 AM, Dan Carpenter wrote:
> Hello Daniel Borkmann and Benjamin Tissoires,
> 
> I've included both warnings because they're sort of related and
> hopefully it will save time to have this discussion in one thread.  I
> recently added fdget() to my Smatch check for CVE-2023-1838 type
> warnings and it generated the following output.  I'm not an expert on
> this stuff, I'm just a monkey see, monkey do programmer.  I've filtered
> out the obvious false positives but I'm not sure about these.
> 
> The patch e420bed02507: "bpf: Add fd-based tcx multi-prog infra with
> link support" from Jul 19, 2023 and f5c27da4e3c8 ("HID: initial BPF
> implementation") from Nov 3, 2022 introduce the following static
> checker warnings:
> 
> drivers/hid/bpf/hid_bpf_dispatch.c:287 hid_bpf_attach_prog() warn: double fget(): 'prog_fd'
> drivers/hid/bpf/hid_bpf_jmp_table.c:427 __hid_bpf_attach_prog() warn: fd re-used after fget(): 'prog_fd'
> kernel/bpf/syscall.c:3985 bpf_prog_detach() warn: double fget(): 'attr->attach_bpf_fd'
> kernel/bpf/syscall.c:3988 bpf_prog_detach() warn: double fget(): 'attr->attach_bpf_fd'
> kernel/bpf/syscall.c:3991 bpf_prog_detach() warn: double fget(): 'attr->attach_bpf_fd'
> kernel/bpf/syscall.c:4001 bpf_prog_detach() warn: double fget(): 'attr->attach_bpf_fd'


[...]
> kernel/bpf/syscall.c
>      3956 static int bpf_prog_detach(const union bpf_attr *attr)
>      3957 {
>      3958         struct bpf_prog *prog = NULL;
>      3959         enum bpf_prog_type ptype;
>      3960         int ret;
>      3961
>      3962         if (CHECK_ATTR(BPF_PROG_DETACH))
>      3963                 return -EINVAL;
>      3964
>      3965         ptype = attach_type_to_prog_type(attr->attach_type);
>      3966         if (bpf_mprog_supported(ptype)) {
>      3967                 if (ptype == BPF_PROG_TYPE_UNSPEC)
>      3968                         return -EINVAL;
>      3969                 if (attr->attach_flags & ~BPF_F_ATTACH_MASK_MPROG)
>      3970                         return -EINVAL;
>      3971                 if (attr->attach_bpf_fd) {
>      3972                         prog = bpf_prog_get_type(attr->attach_bpf_fd, ptype);
>                                                            ^^^^^^^^^^^^^^^^^^^
>  From my understanding then this prog might not be the same prog which
> we detach from later...

Thanks for double checking, Dan! This branch above is only accessible when
bpf_mprog_supported(ptype) holds true which is as of today BPF_PROG_TYPE_SCHED_CLS.

>      3973                         if (IS_ERR(prog))
>      3974                                 return PTR_ERR(prog);
>      3975                 }
>      3976         } else if (attr->attach_flags ||
>      3977                    attr->relative_fd ||
>      3978                    attr->expected_revision) {
>      3979                 return -EINVAL;
>      3980         }
>      3981
>      3982         switch (ptype) {
>      3983         case BPF_PROG_TYPE_SK_MSG:
>      3984         case BPF_PROG_TYPE_SK_SKB:
> --> 3985                 ret = sock_map_prog_detach(attr, ptype);
>                                                      ^^^^
> here.  Because instead of re-using prog we look it up again.

So we never enter into this switch case given the ptype.

>      3986                 break;
>      3987         case BPF_PROG_TYPE_LIRC_MODE2:
>      3988                 ret = lirc_prog_detach(attr);
>      3989                 break;
>      3990         case BPF_PROG_TYPE_FLOW_DISSECTOR:
>      3991                 ret = netns_bpf_prog_detach(attr, ptype);
>      3992                 break;
>      3993         case BPF_PROG_TYPE_CGROUP_DEVICE:
>      3994         case BPF_PROG_TYPE_CGROUP_SKB:
>      3995         case BPF_PROG_TYPE_CGROUP_SOCK:
>      3996         case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
>      3997         case BPF_PROG_TYPE_CGROUP_SOCKOPT:
>      3998         case BPF_PROG_TYPE_CGROUP_SYSCTL:
>      3999         case BPF_PROG_TYPE_SOCK_OPS:
>      4000         case BPF_PROG_TYPE_LSM:
>      4001                 ret = cgroup_bpf_prog_detach(attr, ptype);
>      4002                 break;
>      4003         case BPF_PROG_TYPE_SCHED_CLS:
>      4004                 if (attr->attach_type == BPF_TCX_INGRESS ||
>      4005                     attr->attach_type == BPF_TCX_EGRESS)
>      4006                         ret = tcx_prog_detach(attr, prog);
>      4007                 else
>      4008                         ret = netkit_prog_detach(attr, prog);

... only these two detach functions above.

>      4009                 break;
>      4010         default:
>      4011                 ret = -EINVAL;
>      4012         }
>      4013
>      4014         if (prog)
>      4015                 bpf_prog_put(prog);
>      4016         return ret;
>      4017 }

Thanks,
Daniel

