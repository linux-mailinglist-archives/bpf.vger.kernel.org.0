Return-Path: <bpf+bounces-20081-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6302838C50
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 11:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C1201F28082
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 10:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E9F5C8F5;
	Tue, 23 Jan 2024 10:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v7kov1za"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7693744C8B
	for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 10:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706006645; cv=none; b=B/4LF2Wb3QDwP/DONp4JllPLIGe53tlkg5eUv/ATxWPGD4m+9wcbrtSX5QVvpa6l4d7kfOzYCY6XghW1NAa4KBZYQ32ZFBN5w9WTYn2Xm0d/VxO5T1f+572s6VXIUoUQzpQhe2yFJ9LzrDsvTmP8amJWuNGBYw4dlSOVux1dIpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706006645; c=relaxed/simple;
	bh=owjwXZ4lDmhtd+6GYl0HthmiP7pYxi+Tot3nEKdu/5I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QZzoNAeCc1clMIab1rr08o9z3BJmJrvl5WwGhQTsthmUGVvNrdq2ntETPITHXa/Tf5tl7GcJQP0fyVax5961+8T5GMWcV+npz/jOQET3eCr9TfEdetECPBzhGmHFVLmo5OHhbDKFtOWIMwY52VhcHZ2/HlE2AY/xBbHZKub1Onc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v7kov1za; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e9d4ab5f3so44865445e9.2
        for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 02:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706006642; x=1706611442; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7sEz8Ayy15queeSCtOxrmiZSqSLdn/Cd3vOQwxygfPk=;
        b=v7kov1zao9Mh1dbm3M/hehldOSeDLzd5gmNO3aW9pn7t/Sc6Uf3+gE9jLtkPwiXmXy
         czB0BgbdMpnztAvsxvqNtFeJkMynhbS//HF+ak6DoFcEB/7GaVeOql01Mg1Ebdy7nlaV
         hjwNTneOw9MQBKywZiecjcdfEVllXWJpLnZ7ctPplLY94vQkDZSJKMGFW+PofjMN5ae1
         gTCRLImXSXyYUU324n6MH+FskQ05MAhXhcm1EemSCgvhIJlRSHsd1OAExmu6gqwvwFiN
         pojIAGdq/K3ywSDoVbKeJO5KrFLu+WbDck95p50GvENSkDJ0F6Bfr8UJnmEgnTRbvg0k
         TDVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706006642; x=1706611442;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7sEz8Ayy15queeSCtOxrmiZSqSLdn/Cd3vOQwxygfPk=;
        b=otVeHICyidp0swOGnUb0PdGoXr5IbcRi1+BHUFz+9KMHnihzp4TI3r9xsLiaWnPWjM
         kq0N+9UuOn8z4cQUo1XYlO1/ZpZZKTVzQSRfYWwYD4WfVx9W6b2Z+niXCKWqEuwZMKrD
         5oxpVAG8ghNXSREpb5I+9PPNtyzOR4DHJuz2xae2tIUdzFv3F9cVUL+hNdizVDGYyqYK
         oV0p+836pfIWaBiD9svbZv2o8Yl3/Lu2OebGHwHLuam3i4eDqJ+dULBN/zhzah1VXEhq
         1zZ9QuG78OJ/LLN+yPuOT+i/AimaS+FTisKGr/9qDsakZqPag1CcCXLhSbKSLp9iNtTM
         +mug==
X-Gm-Message-State: AOJu0Yxlkxz7HqKQwuaTZ4pWMb0tJ3Qlv4vY4LO1IWe8Y0j5s8GNNl4H
	2ryRgQxbF8ZJCNyknOK8Xl4cyKSnwA/FtZjR3iWMKpKjpq2qMTgfUu+bSMQOZPQ=
X-Google-Smtp-Source: AGHT+IFXchbiBU9NxhPx5agpTc0hv7An/mAWKrbtob1lskchIRR+egyxl8gr+R4XOWqEjGh43JnE8A==
X-Received: by 2002:a05:600c:3ba2:b0:40e:5f54:b909 with SMTP id n34-20020a05600c3ba200b0040e5f54b909mr409259wms.88.1706006641645;
        Tue, 23 Jan 2024 02:44:01 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id e30-20020a5d595e000000b00339237a2752sm9798658wri.33.2024.01.23.02.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 02:44:01 -0800 (PST)
Date: Tue, 23 Jan 2024 13:43:58 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: daniel@iogearbox.net,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: bpf@vger.kernel.org, Mathias Krause <minipli@grsecurity.net>
Subject: [bug report] bpf: Add fd-based tcx multi-prog infra with link support
Message-ID: <c46a511a-0335-44f5-b6ae-6ad71d6ef012@moroto.mountain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Daniel Borkmann and Benjamin Tissoires,

I've included both warnings because they're sort of related and
hopefully it will save time to have this discussion in one thread.  I
recently added fdget() to my Smatch check for CVE-2023-1838 type
warnings and it generated the following output.  I'm not an expert on
this stuff, I'm just a monkey see, monkey do programmer.  I've filtered
out the obvious false positives but I'm not sure about these.

The patch e420bed02507: "bpf: Add fd-based tcx multi-prog infra with
link support" from Jul 19, 2023 and f5c27da4e3c8 ("HID: initial BPF
implementation") from Nov 3, 2022 introduce the following static
checker warnings:

drivers/hid/bpf/hid_bpf_dispatch.c:287 hid_bpf_attach_prog() warn: double fget(): 'prog_fd'
drivers/hid/bpf/hid_bpf_jmp_table.c:427 __hid_bpf_attach_prog() warn: fd re-used after fget(): 'prog_fd'
kernel/bpf/syscall.c:3985 bpf_prog_detach() warn: double fget(): 'attr->attach_bpf_fd'
kernel/bpf/syscall.c:3988 bpf_prog_detach() warn: double fget(): 'attr->attach_bpf_fd'
kernel/bpf/syscall.c:3991 bpf_prog_detach() warn: double fget(): 'attr->attach_bpf_fd'
kernel/bpf/syscall.c:4001 bpf_prog_detach() warn: double fget(): 'attr->attach_bpf_fd'

drivers/hid/bpf/hid_bpf_dispatch.c
   256  noinline int
   257  hid_bpf_attach_prog(unsigned int hid_id, int prog_fd, __u32 flags)
   258  {
   259          struct hid_device *hdev;
   260          struct device *dev;
   261          int fd, err, prog_type = hid_bpf_get_prog_attach_type(prog_fd);
                                                                      ^^^^^^^
fdget() here

   262  
   263          if (!hid_bpf_ops)
   264                  return -EINVAL;
   265  
   266          if (prog_type < 0)
   267                  return prog_type;
   268  
   269          if (prog_type >= HID_BPF_PROG_TYPE_MAX)

We're doing checks to ensure that prog_type is correct

   270                  return -EINVAL;
   271  
   272          if ((flags & ~HID_BPF_FLAG_MASK))
   273                  return -EINVAL;
   274  
   275          dev = bus_find_device(hid_bpf_ops->bus_type, NULL, &hid_id, device_match_id);
   276          if (!dev)
   277                  return -EINVAL;
   278  
   279          hdev = to_hid_device(dev);
   280  
   281          if (prog_type == HID_BPF_PROG_TYPE_DEVICE_EVENT) {
   282                  err = hid_bpf_allocate_event_data(hdev);
   283                  if (err)
   284                          return err;
   285          }
   286  
   287          fd = __hid_bpf_attach_prog(hdev, prog_type, prog_fd, flags);
                                                            ^^^^^^^
But then we look it up again so it's not necessarily the same file.

   288          if (fd < 0)
   289                  return fd;
   290  
   291          if (prog_type == HID_BPF_PROG_TYPE_RDESC_FIXUP) {
   292                  err = hid_bpf_reconnect(hdev);
   293                  if (err) {
   294                          close_fd(fd);
   295                          return err;
   296                  }
   297          }
   298  
   299          return fd;
   300  }

kernel/bpf/syscall.c
    3956 static int bpf_prog_detach(const union bpf_attr *attr)
    3957 {
    3958         struct bpf_prog *prog = NULL;
    3959         enum bpf_prog_type ptype;
    3960         int ret;
    3961 
    3962         if (CHECK_ATTR(BPF_PROG_DETACH))
    3963                 return -EINVAL;
    3964 
    3965         ptype = attach_type_to_prog_type(attr->attach_type);
    3966         if (bpf_mprog_supported(ptype)) {
    3967                 if (ptype == BPF_PROG_TYPE_UNSPEC)
    3968                         return -EINVAL;
    3969                 if (attr->attach_flags & ~BPF_F_ATTACH_MASK_MPROG)
    3970                         return -EINVAL;
    3971                 if (attr->attach_bpf_fd) {
    3972                         prog = bpf_prog_get_type(attr->attach_bpf_fd, ptype);
                                                          ^^^^^^^^^^^^^^^^^^^
From my understanding then this prog might not be the same prog which
we detach from later...

    3973                         if (IS_ERR(prog))
    3974                                 return PTR_ERR(prog);
    3975                 }
    3976         } else if (attr->attach_flags ||
    3977                    attr->relative_fd ||
    3978                    attr->expected_revision) {
    3979                 return -EINVAL;
    3980         }
    3981 
    3982         switch (ptype) {
    3983         case BPF_PROG_TYPE_SK_MSG:
    3984         case BPF_PROG_TYPE_SK_SKB:
--> 3985                 ret = sock_map_prog_detach(attr, ptype);
                                                    ^^^^
here.  Because instead of re-using prog we look it up again.

    3986                 break;
    3987         case BPF_PROG_TYPE_LIRC_MODE2:
    3988                 ret = lirc_prog_detach(attr);
    3989                 break;
    3990         case BPF_PROG_TYPE_FLOW_DISSECTOR:
    3991                 ret = netns_bpf_prog_detach(attr, ptype);
    3992                 break;
    3993         case BPF_PROG_TYPE_CGROUP_DEVICE:
    3994         case BPF_PROG_TYPE_CGROUP_SKB:
    3995         case BPF_PROG_TYPE_CGROUP_SOCK:
    3996         case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
    3997         case BPF_PROG_TYPE_CGROUP_SOCKOPT:
    3998         case BPF_PROG_TYPE_CGROUP_SYSCTL:
    3999         case BPF_PROG_TYPE_SOCK_OPS:
    4000         case BPF_PROG_TYPE_LSM:
    4001                 ret = cgroup_bpf_prog_detach(attr, ptype);
    4002                 break;
    4003         case BPF_PROG_TYPE_SCHED_CLS:
    4004                 if (attr->attach_type == BPF_TCX_INGRESS ||
    4005                     attr->attach_type == BPF_TCX_EGRESS)
    4006                         ret = tcx_prog_detach(attr, prog);
    4007                 else
    4008                         ret = netkit_prog_detach(attr, prog);
    4009                 break;
    4010         default:
    4011                 ret = -EINVAL;
    4012         }
    4013 
    4014         if (prog)
    4015                 bpf_prog_put(prog);
    4016         return ret;
    4017 }

regards,
dan carpenter

