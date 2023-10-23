Return-Path: <bpf+bounces-12971-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 158B07D2993
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 07:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 219F31C209BD
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 05:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8644C93;
	Mon, 23 Oct 2023 05:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kr9xtAcX"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0F15231
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 05:12:00 +0000 (UTC)
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31950DF
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 22:11:59 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-457c2b6713fso2685224137.1
        for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 22:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698037918; x=1698642718; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UBsxpGWK+5ENJuSPcOHODQjfrGIRBTJcvRWPCFrxcaw=;
        b=kr9xtAcXpvwF9GxsjA2yQzOvfJ3BAHkWua1+Gb37RZs44lQ55rACiup3zBI1CllgWs
         2GjDmhm3sgZ+WaFDK85EjT2N4ovQTPjjJGfYoeR6Un1K49OPk2uFgZaVosmeJnlI433M
         Ia+13VP9bn1LbCTkPc6LS4jegQ+XR9A1PdwIANJ68ZeFhFzhZsyI/Jj7QTnRiyAxEBtC
         GXj8mVEGf4K/5TXGJzfsM1QXaFM5Xfg59ikk9oV/r+HAsMUWAl1KlyWtMaD9q4gSTXEJ
         5BSg9WlbL6p7oF+B5vAaobGHXA7bIhOzItEhs0BH4ASOlX7gKacJeE81Ze9pF1XfB/pm
         otHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698037918; x=1698642718;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UBsxpGWK+5ENJuSPcOHODQjfrGIRBTJcvRWPCFrxcaw=;
        b=W12V+Htbm7dWZe1eVylzyI04dz2CO27dh9iCtWms+M4SaObIziBHVK3hmOq7kunMEs
         0Yeo8b2itRDOMmjP8YjfPTH8/JjAiW3y3GwV1ndBTJa4bAZtQFiVryCsQaWVdlsFiP0D
         7FVAY8Deu14otrEwQodvTdQ4KkfKnyXSa2prO1N8/cbaynTd443vKMtl2oC7Vc5hu+m4
         CoMKgy4/wqUAMAPIKwMknT/AsM+NuXyWXP+L6UYFsnkTLKm5AE/ZlTrn+i/nwXIyRiWr
         dNM4NquZ19Hb6wKIzPrcbhC9NPveL/Wi4OPCzQDmgZqvGwKIm4V57viXKD13nlYXIyeP
         WBPg==
X-Gm-Message-State: AOJu0Yzk0xB4DLromTFXZhSBOQqNK4bWIGrLECSgKO4ZWuEMPmV1+fFr
	Rj4T+uNnt7vYFFYC5hQBFZixCvZwYwRrmg2wp00DiESy4rk8Kw==
X-Google-Smtp-Source: AGHT+IGCFlrJd0FB15gRiDjRDWau6fhdCZxa9s3QM7X05B5/E9jsANB84euUqTSbit3/spnt3+A1aQcljrjzMiIyzV8=
X-Received: by 2002:a67:cb94:0:b0:457:6867:aafb with SMTP id
 h20-20020a67cb94000000b004576867aafbmr3807608vsl.11.1698037918082; Sun, 22
 Oct 2023 22:11:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: sunilhasbe@gmail.com
From: sunil hasbe <sunilhasbe@gmail.com>
Date: Mon, 23 Oct 2023 10:41:46 +0530
Message-ID: <CABfcHotwAEFraonQVhra82kzDK_3sFRqjQRg-WeVyzKkZHmJ5w@mail.gmail.com>
Subject: Need help in bpf exec hook for execsnoop command
To: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,
We are using ebpf hooks to get the process and its arguments when it
is calling exec. We are using ebpf execsnoop open source utility to
track all exec. Most of the time it works correctly, but in certain
cases (very less) it fails to get the argv[0] and argv[1]. E.g. in
below case, we are opening a new session into existing tmux session
which forks/exec a new process like this
"/usr/lib/x86_64-linux-gnu/utempter/utempter add tmux(1852218).%8".
However execsnopp is unable to get all the arguments which a userland
utility is able to get based on the cmdline for thar process. We have
used proc_connector as well to track all the processes which is able
to get the command line properly.


proc_connector process
FORK:parent(pid,tgid)=1852218,1852218   child(pid,tgid)=1935154,1935154 [tmux ]
FORK:parent(pid,tgid)=1852218,1852218   child(pid,tgid)=1935155,1935155 [tmux ]
EXEC:pid=1935154,tgid=1935154   [Uid:   0       0       0       0]      [-bash ]
EXEC:pid=1935155,tgid=1935155   [Uid:   0       0       0       0]
 [/usr/lib/x86_64-linux-gnu/utempter/utempter add tmux(1852218).%8 ]


/usr/sbin/execsnoop-bpfcc
bash             1935154 1852218   0 /bin/bash
utempter         1935155 1852218   0   tmux(1852218).%8


Upon debugging this further, we are suspecting if there is anything
related to how the parent process is forking/execing and updating its
arguments. As most of the times execsnoop is working perfectly fine
but only for few processes it fails to get the argv[0] and argv[1]. We
inspected the syscall__execve and found that argv[0], argv[1] is empty
and argv[2] is having correct value as tmux(1852218).%8.

We have seen this issue on kernel version on 5.15 on ubuntu20. Any
pointer would be very helpful on this.

Regards,
Sunil

