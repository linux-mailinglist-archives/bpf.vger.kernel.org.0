Return-Path: <bpf+bounces-13028-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B16867D3D01
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 19:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B079B20E39
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 17:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4DE1CA8D;
	Mon, 23 Oct 2023 17:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFf2vfB4"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171131BDCD
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 17:03:44 +0000 (UTC)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9B510A
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 10:03:43 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-507c91582fdso5212423e87.2
        for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 10:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698080621; x=1698685421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1FoRjFsvkj87Ut9eWd3W0pP9wKr1+EgchJk1zLXqHrg=;
        b=FFf2vfB4zPHmabg4ciij5Bfp9CeALZso42L361qF5B5qrJNiCGZAmqmx5EZoPziBW2
         uyePoZnZtonnA6Zp/LI7ioDvwaj2qAi4HClt8dlJbG46OsJL3DOiWNG6Fe6e61/Z8O5h
         mYtzEyMGTeKhofBMHhn2spbMYkl/Wf+GTt9ZSggadAK/l1h5+ETaDDTIQ5Dmoit9ZhOk
         gt/XBYmubbfT1q+ZsFFfPzivpojsbRFoP7sYrg2TuzIasDg9DPeeKyVEksXHnmLTpm4e
         X6W01W2f6730NS4y95FHRyyQ8z/ljaY+4iU/GTkKojPUdNb+c2cNjxlcCX0gN4EQYdzL
         +UqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698080621; x=1698685421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1FoRjFsvkj87Ut9eWd3W0pP9wKr1+EgchJk1zLXqHrg=;
        b=gbop8LVYYOOCIn39R07uKpipK80lOHEgTqnwF37ZkKAOalI2wU1gQc1gUKYFgDXdgw
         tG6I/x2j8FVVnKp2j/uHRqNqqTXtF5awWlYjMgs/CxrjolWYXcCJf1m61CBlvu7XNPDM
         wJTyuS3I4Vzf+x/8L1Quup/3YQQH+fIjyZowQd7kT95wfpVxILkqx4bBvFbbfyS9Y1ok
         8yPC/+aSl4r9jsMEiAJyFWTbFzyYUvFqo+WNXkXWg6zLa84RLLQD98kpXqNNWVzllm3Y
         h3cHyHDq/rIHKlhJV/8pQCcVnzcvk059leQ8P8w88OwVu8Mq3DVsXIpAqjCm5nzTkNqM
         hRCQ==
X-Gm-Message-State: AOJu0YywW4kRZJzaSD/IRzp8tnoyg77MmrGQk+MOZyfKtF9+3IGnSNrD
	zUsnYobKFzZuMYNB1T+AmEWFTlIJGCLcVYKjsy7xTXa/w48=
X-Google-Smtp-Source: AGHT+IH33VEiRzeq7iYOUi7Rd9pFck9FnLjl0A39Pz33w3AhwHmCeA8xx1uNts9jY5we9ewo0TP5Qzxz6cXUFazYXMs=
X-Received: by 2002:a19:ae17:0:b0:507:a58d:24ba with SMTP id
 f23-20020a19ae17000000b00507a58d24bamr6631511lfc.63.1698080621259; Mon, 23
 Oct 2023 10:03:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABfcHotwAEFraonQVhra82kzDK_3sFRqjQRg-WeVyzKkZHmJ5w@mail.gmail.com>
In-Reply-To: <CABfcHotwAEFraonQVhra82kzDK_3sFRqjQRg-WeVyzKkZHmJ5w@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 23 Oct 2023 10:03:29 -0700
Message-ID: <CAEf4Bzab7_N4s_+gJr9u_k+gU8XKkfmcnO7vGTGO4wD_kUZ+yA@mail.gmail.com>
Subject: Re: Need help in bpf exec hook for execsnoop command
To: sunilhasbe@gmail.com
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 22, 2023 at 10:12=E2=80=AFPM sunil hasbe <sunilhasbe@gmail.com>=
 wrote:
>
> Hello,
> We are using ebpf hooks to get the process and its arguments when it
> is calling exec. We are using ebpf execsnoop open source utility to
> track all exec. Most of the time it works correctly, but in certain
> cases (very less) it fails to get the argv[0] and argv[1]. E.g. in
> below case, we are opening a new session into existing tmux session
> which forks/exec a new process like this
> "/usr/lib/x86_64-linux-gnu/utempter/utempter add tmux(1852218).%8".
> However execsnopp is unable to get all the arguments which a userland
> utility is able to get based on the cmdline for thar process. We have
> used proc_connector as well to track all the processes which is able
> to get the command line properly.
>
>
> proc_connector process
> FORK:parent(pid,tgid)=3D1852218,1852218   child(pid,tgid)=3D1935154,19351=
54 [tmux ]
> FORK:parent(pid,tgid)=3D1852218,1852218   child(pid,tgid)=3D1935155,19351=
55 [tmux ]
> EXEC:pid=3D1935154,tgid=3D1935154   [Uid:   0       0       0       0]   =
   [-bash ]
> EXEC:pid=3D1935155,tgid=3D1935155   [Uid:   0       0       0       0]
>  [/usr/lib/x86_64-linux-gnu/utempter/utempter add tmux(1852218).%8 ]
>
>
> /usr/sbin/execsnoop-bpfcc
> bash             1935154 1852218   0 /bin/bash
> utempter         1935155 1852218   0   tmux(1852218).%8
>
>
> Upon debugging this further, we are suspecting if there is anything
> related to how the parent process is forking/execing and updating its
> arguments. As most of the times execsnoop is working perfectly fine
> but only for few processes it fails to get the argv[0] and argv[1]. We
> inspected the syscall__execve and found that argv[0], argv[1] is empty
> and argv[2] is having correct value as tmux(1852218).%8.
>
> We have seen this issue on kernel version on 5.15 on ubuntu20. Any
> pointer would be very helpful on this.

Check what error bpf_probe_read_user() returns. If it's -EFAULT, then
it's probably the case that user memory is not physically present in
memory and needs to be paged in, which is not allowed for
non-sleepable BPF programs. So you'd need to make use of
bpf_copy_from_user() and use sleepable BPF programs.

>
> Regards,
> Sunil
>

