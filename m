Return-Path: <bpf+bounces-16888-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB08807344
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 16:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D28928200F
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 15:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BCB3EA8C;
	Wed,  6 Dec 2023 15:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="OKc9LBDf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C893D49
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 07:02:39 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-35d725ac060so12177205ab.2
        for <bpf@vger.kernel.org>; Wed, 06 Dec 2023 07:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1701874958; x=1702479758; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L2AnbBnEG8V4eufKM5/dN5XVoRlU8rTjnTuCTdxmRLQ=;
        b=OKc9LBDf7/n479e0GrzhPnrNsELNFTvQNvINQmEkjkKGhiTR/Utpn/vI78qUCmDQsU
         /uPg6ePzN28tyNwxi7Rvz0VxJtlj+xul6IUEEqRokpgDkOV+f7pUg9poHs6FhhxSzYRO
         t27AfpoCNMsYJ5maEP5zFdb4osN6R7RZ2ErXzmB36cdeq0Z3eW/BGMAklzEOLIOGWs8H
         i/tgQggmQr5/s4De6dXiIqtC6alSrYV/JrfpD07wW6tXUkNKFxC2Yc1o22rz0rCR6Ta6
         8wDlaSEZvSawCJhs9jkVcQRuE2zAGzfaiORVr1gwh0rxF3aFbduJH8t35O1WW8K1iQ+V
         R1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701874958; x=1702479758;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L2AnbBnEG8V4eufKM5/dN5XVoRlU8rTjnTuCTdxmRLQ=;
        b=L0YRIOeM5rXAcyAG0eRellGL9qrhf7ySDzcu5iWrbU4DduCJn5uk+QGuzkdj7O7eJM
         V+pX1S1lSqC5CKfY3AUn95PHi9EU1NRrfmmeMN/IVhLEB1arghdCpzyWTWJncPc3YKT+
         CEvD5TNtOj9el0piMKeO6H13qOpuYSIzJRR0vsoeHFJhbm48fQpYlcWftJpejV8RzGMH
         vCkVS5kXTyLARxCpiVeMVd/dLaCB1E4MBWEYCb8jpgcNHvMJJzlVuewWyapQnPUIf4FU
         F3pWI/59aihAtjWSdfYeXdH2Vd1wIOJMnUuhxkiE/T5Ve+N9JLcE2MukZrLZD2zHQYDZ
         eOrA==
X-Gm-Message-State: AOJu0YxvZFkQZs2OxNsXjObPv6YfNFJkTgVr8mWgEHWqHrdbCc3OlJol
	vBl/otJ0stSSuYgDSpF+vQYBug==
X-Google-Smtp-Source: AGHT+IEtzocuoRGd5ib09OVUA+e3oxOgKfs6UGS8boeoHv6+G91sOzMx4xTDb2zYoRsyQny2JBUKSg==
X-Received: by 2002:a05:6e02:803:b0:35d:52b1:a498 with SMTP id u3-20020a056e02080300b0035d52b1a498mr1190363ilm.28.1701874958468;
        Wed, 06 Dec 2023 07:02:38 -0800 (PST)
Received: from CMGLRV3 ([2a09:bac5:9478:4e6::7d:58])
        by smtp.gmail.com with ESMTPSA id fz20-20020a0566381ed400b00468ea2264e1sm2736481jab.73.2023.12.06.07.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 07:02:37 -0800 (PST)
Date: Wed, 6 Dec 2023 09:02:35 -0600
From: Frederick Lawler <fred@cloudflare.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: kpsingh@kernel.org, revest@chromium.org, jackmanb@chromium.org,
	bpf@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: BPF LSM prevent program unload
Message-ID: <ZXCNC8nJZryEy+VR@CMGLRV3>
References: <ZW+KYViDT3HWtKI1@CMGLRV3>
 <CALOAHbANu2tq73bBRrGBAGq9ioTixqKgzpMyOPS3NMPXMg+pwA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbANu2tq73bBRrGBAGq9ioTixqKgzpMyOPS3NMPXMg+pwA@mail.gmail.com>

On Wed, Dec 06, 2023 at 10:42:50AM +0800, Yafang Shao wrote:
> On Wed, Dec 6, 2023 at 4:39 AM Frederick Lawler <fred@cloudflare.com> wrote:
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
> >
> > 3. Leverage SELinux/Apparmor to possibly handle these cases.
> >
> > 4. Introduce a security_bpf_prog_unload() to target hopefully the
> >    umount and unlink cases at the same time.
> >
> 
> All the above programs can also be removed by privileged users.
>

I should probably clarify the "BPF or otherwise" a bit better. Even a
compiled in LSM module? If so, where can I find a bit more information
about that?

We are aware of some of the shortcomings of policy cfg for the AppArmor &
SELinux case.

> > 5. Possible moonshot idea: introduce a interface to pin _specifically_
> >    BPF LSM's to the kernel, and avoid the bpf sysfs problems all
> >    together.
> 
> Introducing non-auto-detachable lsm programs seems like a workable
> solution.  That said, we can't remove the lsm program before it has
> been detached explicitly by the task which attaches it.
> 
> >
> > We're making the assumption this problem has been thought about before,
> > and are wondering if there's anything obvious we're missing here.
> >
> > Fred
> >
> 
> 
> -- 
> Regards
> Yafang

Fred

