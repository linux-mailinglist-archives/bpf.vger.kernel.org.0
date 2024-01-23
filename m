Return-Path: <bpf+bounces-20090-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDFD8390B3
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 15:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D48DF1F21DEB
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 14:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674CC5F853;
	Tue, 23 Jan 2024 14:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gM8ngd9h"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6681A5F84C
	for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 14:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706018409; cv=none; b=Uc036vPY7649N+zxSVTfQVBQvulmv265iN2JgHPQ7xuz8Rd/4AAT43+jWF3dNx5P1SHI7j0BPj/XmHUIjb6Agf/M0/I7Rdia/90aQJQEOBpPDYwTrB3ho2z4gs0NMxVDO8aaj2FdOvMaLYoPPEvshxQ+D6DAEEfxYvS8aGgLcZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706018409; c=relaxed/simple;
	bh=jAdOEmsF97iKzLAoD7TXc795S/y+QOHp138fJpVqCJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oUCCC7p3BESZ69H5X1NehJ8zDjQaqKBnuUiuGZ/J78yRvsknLSFulDZvMDbWvf0b9zzmjpu0pJ20n8Yc3bei1YZh8YifNtcguZTQkMUAsk9qLNcUy93CDqT7Vk1FWlaMkBVuyMWd9o0hT4Mg8C/+TvB8TVreHNO5rLYAx7Btd3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gM8ngd9h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706018406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ljv/X7uYbbsqV2Uor8Gra6l6cjIKTAhCsOzrjLB+io=;
	b=gM8ngd9h8RonTzkTqc8b3coU/2VW1RJNoa53PPgWqsGP8H/LIPNJl8E7SGceqLHDadIngX
	V4trKO4VJqnNY4GFR8DP8F/Qv9JwjO9K0d7/f4PXLglFWJ9c3GamHFhjKIb8NFLxHbJztR
	fkdpoBrM9FXiFgJ8PFlHip8KIzOk3ao=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-MN1uDnc9ODa6MEPxwLFbUg-1; Tue, 23 Jan 2024 09:00:05 -0500
X-MC-Unique: MN1uDnc9ODa6MEPxwLFbUg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a2cb0d70d6cso193608266b.2
        for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 06:00:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706018403; x=1706623203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ljv/X7uYbbsqV2Uor8Gra6l6cjIKTAhCsOzrjLB+io=;
        b=baoPkv/o2E7FLzM9ApuCm3jETUELcPi2Ufs401fOYoQ5f17+HnAKctGxGttFCDByWg
         tIYWeESJ0xmnMWoXyBV2IOwpOFzEgUYwlkidvjt5pKPjgvmEarzUXPrC7IgHFAHfLBMJ
         GF+H8tvC19FWJfwTt1zqFVn6gOgVxOYGKcs540zD2e2fU3Jta2gA9rlIBRxHy9GhL6zX
         Uv05yd7KQudwuc6AMbfGBt+TwjQNX7hEOHi+P+g29uNOW37+A+ArOavVt7GuLow/L4en
         /1FyZd8Y077UnaXEXlyBczz/WUHRj1R9EZQo5q3MLr2UsAwAn+8/XIY3cS0uA0aESnBC
         iydg==
X-Gm-Message-State: AOJu0Yzd1FlwUpvalRVzSGTpsvl84Mnr4bbntUUYIHkEgSQ6+wDP/8ue
	8VVlg2QFtGVPp5792i1WPsBarw7pqzheEPwWrUfkhwAfHcDFGTW+0BGyWQZn6v/xwshyCOchPOW
	shEePFrLTUrdqVNSO8VyknIWTx1E44FeSi6EAJmxrDTMcLJrC8uopdFswGO40NorB5Gt7TkjNY7
	PG5It2eeDkqRcGwWwHA0BpOPZmYa99xOMUwiw=
X-Received: by 2002:a17:907:c207:b0:a30:1084:5a99 with SMTP id ti7-20020a170907c20700b00a3010845a99mr2019173ejc.95.1706018403333;
        Tue, 23 Jan 2024 06:00:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0Sp2H2I93EczvNszOSEBjw8WNNNIMuLtMz6TKwolFSbbbGG1yaPmrMoLsi2wuo8cVTLByzphCgtgz8G3pJUc=
X-Received: by 2002:a17:907:c207:b0:a30:1084:5a99 with SMTP id
 ti7-20020a170907c20700b00a3010845a99mr2019162ejc.95.1706018403037; Tue, 23
 Jan 2024 06:00:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c46a511a-0335-44f5-b6ae-6ad71d6ef012@moroto.mountain>
In-Reply-To: <c46a511a-0335-44f5-b6ae-6ad71d6ef012@moroto.mountain>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Tue, 23 Jan 2024 14:59:51 +0100
Message-ID: <CAO-hwJJ8vh8JD3-P43L-_CLNmPx0hWj44aom0O838vfP4=_1CA@mail.gmail.com>
Subject: Re: [bug report] bpf: Add fd-based tcx multi-prog infra with link support
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: daniel@iogearbox.net, bpf@vger.kernel.org, 
	Mathias Krause <minipli@grsecurity.net>, Jiri Kosina <jikos@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dan,


On Tue, Jan 23, 2024 at 11:44=E2=80=AFAM Dan Carpenter <dan.carpenter@linar=
o.org> wrote:
>
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

Not sure why e420bed02507 would introduce the warning in HID-BPF. The
double fget() you analyzed was present before that commit.

>
> drivers/hid/bpf/hid_bpf_dispatch.c:287 hid_bpf_attach_prog() warn: double=
 fget(): 'prog_fd'
> drivers/hid/bpf/hid_bpf_jmp_table.c:427 __hid_bpf_attach_prog() warn: fd =
re-used after fget(): 'prog_fd'
> kernel/bpf/syscall.c:3985 bpf_prog_detach() warn: double fget(): 'attr->a=
ttach_bpf_fd'
> kernel/bpf/syscall.c:3988 bpf_prog_detach() warn: double fget(): 'attr->a=
ttach_bpf_fd'
> kernel/bpf/syscall.c:3991 bpf_prog_detach() warn: double fget(): 'attr->a=
ttach_bpf_fd'
> kernel/bpf/syscall.c:4001 bpf_prog_detach() warn: double fget(): 'attr->a=
ttach_bpf_fd'
>
> drivers/hid/bpf/hid_bpf_dispatch.c
>    256  noinline int
>    257  hid_bpf_attach_prog(unsigned int hid_id, int prog_fd, __u32 flags=
)
>    258  {
>    259          struct hid_device *hdev;
>    260          struct device *dev;
>    261          int fd, err, prog_type =3D hid_bpf_get_prog_attach_type(p=
rog_fd);
>                                                                       ^^^=
^^^^
> fdget() here
>
>    262
>    263          if (!hid_bpf_ops)
>    264                  return -EINVAL;
>    265
>    266          if (prog_type < 0)
>    267                  return prog_type;
>    268
>    269          if (prog_type >=3D HID_BPF_PROG_TYPE_MAX)
>
> We're doing checks to ensure that prog_type is correct
>
>    270                  return -EINVAL;
>    271
>    272          if ((flags & ~HID_BPF_FLAG_MASK))
>    273                  return -EINVAL;
>    274
>    275          dev =3D bus_find_device(hid_bpf_ops->bus_type, NULL, &hid=
_id, device_match_id);
>    276          if (!dev)
>    277                  return -EINVAL;
>    278
>    279          hdev =3D to_hid_device(dev);
>    280
>    281          if (prog_type =3D=3D HID_BPF_PROG_TYPE_DEVICE_EVENT) {
>    282                  err =3D hid_bpf_allocate_event_data(hdev);
>    283                  if (err)
>    284                          return err;
>    285          }
>    286
>    287          fd =3D __hid_bpf_attach_prog(hdev, prog_type, prog_fd, fl=
ags);
>                                                             ^^^^^^^
> But then we look it up again so it's not necessarily the same file.

Right. I did not want to have a too complex error code path there and
so I did not keep a fget() around :(

And I did not think this would be an attack vector (even if I have a
hard time getting how this could be used).

I'll send a patch later today to fix this.

>
>    288          if (fd < 0)
>    289                  return fd;
>    290
>    291          if (prog_type =3D=3D HID_BPF_PROG_TYPE_RDESC_FIXUP) {
>    292                  err =3D hid_bpf_reconnect(hdev);
>    293                  if (err) {
>    294                          close_fd(fd);
>    295                          return err;
>    296                  }
>    297          }
>    298
>    299          return fd;
>    300  }

Cheers,
Benjamin


