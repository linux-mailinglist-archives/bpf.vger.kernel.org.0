Return-Path: <bpf+bounces-17058-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CDC809699
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 00:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 540F51F212D6
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 23:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8A05731B;
	Thu,  7 Dec 2023 23:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="L2m78iNi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA701713
	for <bpf@vger.kernel.org>; Thu,  7 Dec 2023 15:30:21 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-7b459364167so54328539f.2
        for <bpf@vger.kernel.org>; Thu, 07 Dec 2023 15:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1701991821; x=1702596621; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qMzV6rito0IVod3bZImEbgc3/1q8nnlDU+92MtlIeos=;
        b=L2m78iNiAOt78txlSXrI86z5XrI8GEqP7GXFGyGxn22DE02xych9ikj8E+Wm+PG1EO
         UZf/2wp3BZ/DA+9Fn3nf+a8TBJxib4nPwwws+asfmibkuwr9bYnc9GwMziIuTtORXN3I
         AhBCfsRIRNqNHgRvftW3xiSnEwk2eQqCDR9WjAHR4V1uuPZpLcdZYOVb9B0ZrLilWtSN
         g/qdPHTzu+/QyfJouJrrcO8gnVQRH/x9Ny7BDdV8AXMe6z795+didMx0yK6UwyPps8BW
         JviP0Fz2vce8UQfIZLHf2bQPh5SnJtM8/DkjQncEQ/eWSh9u1h7IJcRUXkrp+lEGKH8T
         lZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701991821; x=1702596621;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qMzV6rito0IVod3bZImEbgc3/1q8nnlDU+92MtlIeos=;
        b=P2RzxmzbhGS8xTJPuicDoLETYtU/9a34j0kU23KzzHv9a7Ja9VPBSipc0WY3jhpLKC
         pPC84vrrFCt/i4gZF/20V+KPUmacCiuMWSeC8n9v4apQ9Q58Fx6NqHNP2KYunAtfMRh4
         jwLrBOFr0vFjGKVJfEBSgBbS8h7BvE3h1fp6EyeXPYpJQGdH2sUAZWKxRIjaCP3h5Jxr
         pFqeyUH9CRFHzFPikgLuE3gW/hKUaYIaRK1vCIEo4VQuzG2KkthacY9Qlkeb7mrL+CtB
         +AKGiaz28iAgFG1YXwqvNszHUgqQmA4x1FYgemKf+DNwY1I/7TIfKOLWDDEPdA192KXV
         xkaQ==
X-Gm-Message-State: AOJu0Ywk91PbohCHgrdmvETgSrUcfhwsI2yKC6lpQNDuyEuL/wlXJ7YO
	ukdlWToGkukqVAu78CcXN7SOkA==
X-Google-Smtp-Source: AGHT+IEKm1QqA41tQFNxwbmF1NNcyUcKYN0XrqIPpXNsDRDOYJzy+2Yni/yRG+WGFTakK0mvUWCxOg==
X-Received: by 2002:a6b:ea14:0:b0:7b7:475:5b2d with SMTP id m20-20020a6bea14000000b007b704755b2dmr1223723ioc.8.1701991820802;
        Thu, 07 Dec 2023 15:30:20 -0800 (PST)
Received: from CMGLRV3 ([2a09:bac5:9478:4e6::7d:47])
        by smtp.gmail.com with ESMTPSA id y4-20020a5ec804000000b007b0684e260dsm189878iol.2.2023.12.07.15.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 15:30:20 -0800 (PST)
Date: Thu, 7 Dec 2023 17:30:17 -0600
From: Frederick Lawler <fred@cloudflare.com>
To: KP Singh <kpsingh@kernel.org>
Cc: revest@chromium.org, jackmanb@chromium.org, bpf@vger.kernel.org,
	kernel-team@cloudflare.com, linux-security-module@vger.kernel.org,
	paul@paul-moore.com, laoar.shao@gmail.com, casey@schaufler-ca.com,
	penguin-kernel@i-love.sakura.ne.jp
Subject: Re: BPF LSM prevent program unload
Message-ID: <ZXJViQDsdj7Bg4e9@CMGLRV3>
References: <ZW+KYViDT3HWtKI1@CMGLRV3>
 <CACYkzJ5iyiUi_3r439ZMRnjM2f9Wd0XYoGJYQY=aXJ4QmX7e-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACYkzJ5iyiUi_3r439ZMRnjM2f9Wd0XYoGJYQY=aXJ4QmX7e-A@mail.gmail.com>

On Thu, Dec 07, 2023 at 03:01:33PM +0100, KP Singh wrote:
> On Tue, Dec 5, 2023 at 9:39 PM Frederick Lawler <fred@cloudflare.com> wrote:
> >
> > Hi,
> >
> > IIUC, LSMs are supposed to give us the ability to design policy around
> > unprivileged users and in addition to privileged users. As we expand
> > our usage of BPF LSM's, there are cases where we want to restrict
> > privileged users from unloading our progs. For instance, any privileged
> > user that wants to remove restrictions we've placed on privileged users.
> >
> > We currently have a loader application doesn't leverage BPF skeletons. We
> > instead load BPF object files, and then pin the progs to a mount point that
> > is a bpf filesystem. On next run, if we have new policies, load in new
> > policies, and finally unload the old.
> >
> > Here are some conditions a privileged user may unload programs:
> >
> >         umount /sys/fs/bpf
> >         rm -rf /sys/fs/bpf/lsm
> >         rm /sys/fs/bpf/lsm/some_prog
> >         unlink /sys/fs/bpf/lsm/some_prog
> >
> > This works because once we remove the last reference, the programs and
> > pinned maps are cleaned up.
> >
> > Moving individual pins or moving the mount entirely with mount --move
> > do not perform any clean up operations. Lastly, bpftool doesn't currently
> > have the ability to unload LSM's AFAIK.
> >
> > The few ideas I have floating around are:
> >
> > 1. Leverage some LSM hooks (BPF or otherwise) to restrict on the functions
> >    security_sb_umount(), security_path_unlink(), security_inode_unlink().
> >
> >    Both security_path_unlink() and security_inode_unlink() handle the
> >    unlink/remove case, but not the umount case.
> 
> IMHO this is the best option. Here:
> 
> * BPF LSM Program = MAC Policy
> * Removing / detaching / updating programs = Updating MAC policy
> 
> The decision around who can update MAC policy can be governed by the
> policy itself a.k.a. implemented with BPF LSM programs.  So we can
> update hooks (as suggested here inode_unlink, sb_unmount, path_unlink)
> to only allow this action for a subset of users (e.g. CAP_MAC_ADMIN or
> even further restricted)
> 
> While, I think this may be doable with existing LSM hooks but we need
> to probably have to cover multiple hook points needed to prevent one
> action which makes a good case for another LSM hook, perhaps something
> in the link->ops->detach path like
> https://elixir.bootlin.com/linux/latest/source/kernel/bpf/syscall.c#L5074
> 
> What do you think?

That's what I was thinking for option (4) "introduce a
security_bpf_prog_unload()". Anyway, I agree. Paul brought up a good
point that he'd like to see more discussion around this idea [1].
Mucking with the mounts (see below) is a bit of a mess, and there could
still exist other methods for unloading I'm not aware of yet.

Yesterday I whipped up a hack such that: 

	mkdir -p /run/fs/bpf-lsm
	mount -t bpf none /run/fs/bpf-lsm
	./load-policies /run/fs/bpf-lsm

Where the implemented hooks inode_unlink & sb_umount look for a "bpf"
filesystem type on the struct super_block for the mount, and then check
for a xattr or UUID to hone in on _just_ that special mount point. This is
so we can still umount /sys/fs/bpf. This hack so far is working out
quite well.

xattr is still under development, thus the UUID idea (we're still exploring
unique-path-agnostic identifiers). I also didn't prove the UUID
idea yet. For instance, I wouldn't want the UUID to change on mount
--move or mount -o remount.

Apropos the reboot problem, the idea is to force a reboot for policy change
for now. And then eventually leverage xattr + IMA, or something else to prove
the loader binary + progs once these features are available. Policy
versioning is also an idea we're floating around for handling the update
case with the loader to avoid reboot.

This is all to say, I think there is a use-case here for a new hook to
simplify the unload problem at least.

[1] https://lore.kernel.org/all/CAHC9VhSRdXLeJvS3tOmAAat+h8G7_cvAYnFvbrTwgG+sC+PRYg@mail.gmail.com/

+cc: discussion contributors
> 
> - KP
> 
> >
> > 3. Leverage SELinux/Apparmor to possibly handle these cases.
> >
> > 4. Introduce a security_bpf_prog_unload() to target hopefully the
> >    umount and unlink cases at the same time.
> 
> 
> 
> >
> > 5. Possible moonshot idea: introduce a interface to pin _specifically_
> >    BPF LSM's to the kernel, and avoid the bpf sysfs problems all
> >    together.
> >
> > We're making the assumption this problem has been thought about before,
> > and are wondering if there's anything obvious we're missing here.
> >
> > Fred
> >

Fred

P.S. This is an awesome discussion :) Thanks everyone!

