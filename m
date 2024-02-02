Return-Path: <bpf+bounces-21000-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7171846695
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 04:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFC301C24B61
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 03:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68417D285;
	Fri,  2 Feb 2024 03:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQQZtt4i"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8253DDF4C
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 03:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706845252; cv=none; b=KJOw6DaSTQOmlRwnIeEAW/hmTvmtNdXYh2eFnKdyOPugBeR/sV7CfOv7Xh+See9mI/f0roxOTrhOMvtejHMzChyv8ytvGm33geSzGWBFh9sRO7LTF7mQoRXC26JHb6UvaMlS32sSolNWDSUg8vy3HSPSCNCwW/64Mw1LvzZ5/yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706845252; c=relaxed/simple;
	bh=AUtyO0u9qswX6DW+W4kYsTqNpg9r1ZVnVxLex3qQynM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=joMLeJsRouebFbA1oCo7nqZ1uAX9O65uSemCyXrDSrujrBOLNhmUGZfh/kadebIgGZ1pyX7k7rT9v06OJRJwKXDwxlgJHsmTIIKsM5b6XvK3CqtE9hiErt0hdrH7h6g1nPrhX8/r83yrGFOi7sHDSR+WftnAm6W5c5iQ7UnEBDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQQZtt4i; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3be90c51299so1009614b6e.0
        for <bpf@vger.kernel.org>; Thu, 01 Feb 2024 19:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706845249; x=1707450049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aaFNAD3s7CZLeGJAkgIP2i9Uq/f9SHOfbY60E3JDrm8=;
        b=OQQZtt4iM7BorZ6iiawf+2X5FhGh/2M3fgYpxcvbg2D3AuBkkASCrRa9IqRyEur6hx
         51RbxQoPZuCFrZCueMdKeqNwcRZp+UI1RqNrKfvRj3g5iM4fqYESTBod3azRD/VQldqD
         OSDdvFP52XgRS0OYntF17tV3/12dC1CI8RU+GGVdzgOYHu7cDogONbfdI3M8fkeoC/wZ
         ruaqA2lEZo++pNz8AxVj2RTwFGBJMocqKUHic30PvgUL312+v6KntkPfCfHoJ8G4h7p7
         wcJYWWwfVGHgjvNEUOj5xU2HTnHQaJ+JUaZuIxy/M8SuY0Xd7/Uvr7AP4YQqrsW5Okgb
         AERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706845249; x=1707450049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aaFNAD3s7CZLeGJAkgIP2i9Uq/f9SHOfbY60E3JDrm8=;
        b=P9zZnrVA2jzIiRnlrxXrINydcmDtZEQ4bIjYbvFU9MQTYgnzJGIUm6iz9dZTp2UrSk
         ZQvSm6x33+g3/n0/iR3Ubn6y/YhxNJ0WA5EQU5SaHmCk47ZJsERIgzDYxS4xo2u9SWs7
         FJ4W/9/+EH6xsgAo+rXdxXPkje1XkZqqPM/g9PUWTx9TY8m+aaVoXFzStcQmwYw3BN9e
         gbFw3wq9TXv3CwJmgSb+57AOYnq4YFdYRPg443X8h61LHkxoYvblyFLJg2oPDi+4VUXM
         FB5AiHf0C5GxTZbilgXCNNVVhXurxEM54waZqdrHwxPLdv9ErEBgmwTDGSuDxaMJ0cti
         qklw==
X-Gm-Message-State: AOJu0YwmB0xCtmkHcVu2pwyFMKCA+1NyYQrdo6r5LI2lDk2dxOLWfnMV
	Bj+sC5V5ZhCTxybUREWlqe9TeCpO0BOte3OyYIDMEHVNBw5iY9JzhJztfP6A+tHx5cn2Z/a/Lsy
	EEZm3IIUvqY1k4FQIoJyQmGr6LPFOKpDw1vAklUEV
X-Google-Smtp-Source: AGHT+IGhDW64I5P+rADU9coWNBUXZcrlWPIuISkooPExF2pKEJ3J3ySoB+gbOjFFSRs3/N7qbJ7y/n6UFBGtE36YSYQ=
X-Received: by 2002:a05:6808:218e:b0:3be:260:6278 with SMTP id
 be14-20020a056808218e00b003be02606278mr7666041oib.42.1706845249389; Thu, 01
 Feb 2024 19:40:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Lucien Wang <lcnwed@gmail.com>
Date: Fri, 2 Feb 2024 11:40:38 +0800
Message-ID: <CAHViUT2y81_JHsuSDfH9Vu_KRbanvmGY_1Bs4jfrGyZPGHCbdg@mail.gmail.com>
Subject: There has a backport bug between v5.10.79 and v5.10.80 when run bpf
 selftest "test_sockmap" on 5.10 lts kernel
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Kernel version=EF=BC=9A16ad71c250c1 (HEAD -> linux-5.10.y, tag: v5.10.209,
origin/linux-5.10.y) Linux 5.10.209

Bug reproduced steps=EF=BC=9A
1.  cd (kernel source tree root)/tools/testing/selftests/bpf
2.  make test_sockmap ; make test_progs
3.  ./test_sockmap
# 1/ 6  sockmap::txmsg test passthrough:OK
# 2/ 6  sockmap::txmsg test redirect:OK
# 3/ 6  sockmap::txmsg test drop:OK
# 4/ 6  sockmap::txmsg test ingress redirect:OK

After "# 4/ 6  sockmap::txmsg test ingress redirect:OK" display from
terminal, the main process stucks and sends nothing.
4. In other terminal run " ps fax |grep sockmap " ,below is output
  13076 pts/0    S+     0:00  |           \_ ./test_sockmap
  13129 pts/0    S+     0:00  |               \_ ./test_sockmap
  13130 pts/0    Z+     0:00  |               \_ [test_sockmap] <defunct>
  13237 pts/1    S+     0:00              \_ grep --color=3Dauto sockmap
Obversely, because of child process 13129 sleep, so the main process is stu=
ck.

My research:
I use Bisection method to find the bug patch " c842a4c4ae7f bpf:
sockmap, strparser, and tls are reusing qdisc_skb_cb and colliding
"(on linux-5.10.y branch), it backport from v5.16-rc1 ,
It must due to merge high patches incompletely, Please take a few
moment for this.

