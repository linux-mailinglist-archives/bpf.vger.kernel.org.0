Return-Path: <bpf+bounces-16843-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2888806534
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 03:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E8E02822AC
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 02:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E984D63CB;
	Wed,  6 Dec 2023 02:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FnaPDHT4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F262129
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 18:43:27 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1eb39505ba4so3097772fac.0
        for <bpf@vger.kernel.org>; Tue, 05 Dec 2023 18:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701830606; x=1702435406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bIq5aoiDrEqeZ9oSyh+OxgaO3ApzW7R6kmkO1etVAcE=;
        b=FnaPDHT4rlrxDZ5IWUqMQdZ12gy/ok/e9zGy+2V1FfB7d5TUtTlJ3aPBpZOql/dCf6
         q98TmINwZ7nQx9tg9NBVNtq6B7Mu+g1y4YfOTUqUJj8KKjV0KZSVQ5O56epey+SP2WmO
         Sc617Nz1vItUd9EOL0Fe8n1ZNZctQyFZVyDLWJkq22iYrD6v+3OHeQwZAbHG7AGuuf5x
         A+U9wmNUqnE6x54/xStO/ykQw5zmHVWEaCjpREkHhR2QXDyG37pt6bqsmKWzHERTTW9a
         HPt+sUpbwHAoVmgvheL6eE04CuKhk0k0ae/Wqoo/3eR6WdcdiY2QI4uRiaEbqKEL5XCM
         IhVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701830606; x=1702435406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bIq5aoiDrEqeZ9oSyh+OxgaO3ApzW7R6kmkO1etVAcE=;
        b=gbmLJHZ4oJl3w1Q0Aagej66cFdlzh06D5j1Hk21hG1OAfD8spWaqmruOK4KTNx9OUG
         gnbh74TpccV6KaOeWZdqAwRhIETWU/oulVU23dhYyEDksI4a+QZGIi2Oa+rmS5lDzEbV
         YHYQJ17fRrChCoIRUEYVphmfQBZ0foBEvrMcX9Bn20VNu/L8JfE++/z4lFxh+1s3/LyC
         yUPSx0qB487Rf6/E2J2xseved23CI5kYPw9AjmC1vbTOV9EqiPiLcS5IuvJxRQT3L9b1
         wOslE9yz/YlTT9s1oxsQyO6VAkiu/SIOCZ7WGbKnDCNBYocrzfzLMNt/PIvxD+x5RPr4
         D3wg==
X-Gm-Message-State: AOJu0YwgSobSIg6+c1IX1IwDBgLb9by3bql1uWQEgGMyx0N2vlMcHJ4x
	RY4udellzJuMKU4Z5CrB5nrynNrGlKHUIQNDugjJvHYX5Bo9aA==
X-Google-Smtp-Source: AGHT+IGt0yLM9cGyKdskbxJlMpz8Kns9liKz1AHaW2wD1e48Fmp74do6ZaKPqOVfxYbpzmo2+8NEtol0ShXYerF9xxM=
X-Received: by 2002:a05:6870:330e:b0:1fb:75b:99c5 with SMTP id
 x14-20020a056870330e00b001fb075b99c5mr167049oae.116.1701830606522; Tue, 05
 Dec 2023 18:43:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZW+KYViDT3HWtKI1@CMGLRV3>
In-Reply-To: <ZW+KYViDT3HWtKI1@CMGLRV3>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 6 Dec 2023 10:42:50 +0800
Message-ID: <CALOAHbANu2tq73bBRrGBAGq9ioTixqKgzpMyOPS3NMPXMg+pwA@mail.gmail.com>
Subject: Re: BPF LSM prevent program unload
To: Frederick Lawler <fred@cloudflare.com>
Cc: kpsingh@kernel.org, revest@chromium.org, jackmanb@chromium.org, 
	bpf@vger.kernel.org, kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 4:39=E2=80=AFAM Frederick Lawler <fred@cloudflare.co=
m> wrote:
>
> Hi,
>
> IIUC, LSMs are supposed to give us the ability to design policy around
> unprivileged users and in addition to privileged users. As we expand
> our usage of BPF LSM's, there are cases where we want to restrict
> privileged users from unloading our progs. For instance, any privileged
> user that wants to remove restrictions we've placed on privileged users.
>
> We currently have a loader application doesn't leverage BPF skeletons. We
> instead load BPF object files, and then pin the progs to a mount point th=
at
> is a bpf filesystem. On next run, if we have new policies, load in new
> policies, and finally unload the old.
>
> Here are some conditions a privileged user may unload programs:
>
>         umount /sys/fs/bpf
>         rm -rf /sys/fs/bpf/lsm
>         rm /sys/fs/bpf/lsm/some_prog
>         unlink /sys/fs/bpf/lsm/some_prog
>
> This works because once we remove the last reference, the programs and
> pinned maps are cleaned up.
>
> Moving individual pins or moving the mount entirely with mount --move
> do not perform any clean up operations. Lastly, bpftool doesn't currently
> have the ability to unload LSM's AFAIK.
>
> The few ideas I have floating around are:
>
> 1. Leverage some LSM hooks (BPF or otherwise) to restrict on the function=
s
>    security_sb_umount(), security_path_unlink(), security_inode_unlink().
>
>    Both security_path_unlink() and security_inode_unlink() handle the
>    unlink/remove case, but not the umount case.
>
> 3. Leverage SELinux/Apparmor to possibly handle these cases.
>
> 4. Introduce a security_bpf_prog_unload() to target hopefully the
>    umount and unlink cases at the same time.
>

All the above programs can also be removed by privileged users.

> 5. Possible moonshot idea: introduce a interface to pin _specifically_
>    BPF LSM's to the kernel, and avoid the bpf sysfs problems all
>    together.

Introducing non-auto-detachable lsm programs seems like a workable
solution.  That said, we can't remove the lsm program before it has
been detached explicitly by the task which attaches it.

>
> We're making the assumption this problem has been thought about before,
> and are wondering if there's anything obvious we're missing here.
>
> Fred
>


--=20
Regards
Yafang

