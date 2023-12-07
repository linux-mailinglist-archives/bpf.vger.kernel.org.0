Return-Path: <bpf+bounces-16978-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A57807E79
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 03:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BDC91C20AAB
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 02:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1806B186D;
	Thu,  7 Dec 2023 02:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wy1xGRJH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B0CD4B;
	Wed,  6 Dec 2023 18:28:52 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-67a8a745c43so4137036d6.0;
        Wed, 06 Dec 2023 18:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701916131; x=1702520931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mtFw1FsFxNwKLLVddoY90mv92jjTqbL5KywFRcAFLnI=;
        b=Wy1xGRJHOUo7RxGSnU4jo5nRx3F+NZcN/hbLDgA8QNdfqkBAukRFYueSNBMqcwLAKD
         B+un6NhtuMeLIlEsW7kaFsPwrakdb/LRwzIoXs83iPulRuDUtoLWB6SOfgm/OS1joHDx
         v9BL0XxRkgGg5qtA1fEWlas7QfQ0b+MtRR9zDuHdSXL0nSs38K30AAtnuBwn3GSyAfTe
         yNn27fs/U0mwYh0Mt9gPXD3gERPQ5szcZrBy102g0JwjA5Tld7VoJcovOCEufkSPyXVO
         sRKk1ayCcAGii6cimrQKjqzEyl4IR4AofbRNtXfaHi8FAhXjNXY28oQmmBJvSIivSZr9
         j2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701916131; x=1702520931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mtFw1FsFxNwKLLVddoY90mv92jjTqbL5KywFRcAFLnI=;
        b=hpv3y/opo0iEzIO2J3b/3kB9fiQ9ErLS8s1199HKGp03KHmV/ENb3nsKVN+ndnYXcD
         4zOTHKTVRFvgeuzqwC41OLYTwp0h7aRneKS/gZOf8qNjzhywRN7Ls3iCM/TmWwoVIcH/
         NCHcFUddhpEqa4LBSJ3LoMOeqRByfrPsFHDpwdBiTP5zmWkkzydeDi5E2igTlTisQg2k
         /PdZf4ryR+NdbPRGD+2Ozsb1/JU2IPZWGPKE4Ss4Nm5L+bRcdkfr2UrhDbVx8OS0FzMF
         Ctk86Z5bYdnP5Q3HQrTwjamIkwzxsiTnXRHyVIDp8btb73UHctSMakks8A9AIwrCY81m
         zhgA==
X-Gm-Message-State: AOJu0YztArkji+2qCbqeHvbSzPPvWFEegCkTItKmn6GHN08NPpHU7iQV
	uR5dAXOCXCU3l925+BJ/ATF7EUOtVf/G0hm3DJU=
X-Google-Smtp-Source: AGHT+IESc7x5nouGdgTpjnwagzjmXUj/y/bV0oYK5V/c5dPrxOJICw2m46mZ4ADN3hrtsJ3iJSPUrOo5EM2pMCDxSrg=
X-Received: by 2002:a05:6214:1c0b:b0:67a:a72d:fba6 with SMTP id
 u11-20020a0562141c0b00b0067aa72dfba6mr5929895qvc.36.1701916131333; Wed, 06
 Dec 2023 18:28:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZW+KYViDT3HWtKI1@CMGLRV3> <CALOAHbANu2tq73bBRrGBAGq9ioTixqKgzpMyOPS3NMPXMg+pwA@mail.gmail.com>
 <ZXCNC8nJZryEy+VR@CMGLRV3>
In-Reply-To: <ZXCNC8nJZryEy+VR@CMGLRV3>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 7 Dec 2023 10:28:14 +0800
Message-ID: <CALOAHbAfixyvA5HpOXgqS32G-5p4Z=OXRso7_isz2fNKk76mmg@mail.gmail.com>
Subject: Re: BPF LSM prevent program unload
To: Frederick Lawler <fred@cloudflare.com>, Paul Moore <paul@paul-moore.com>, jmorris@namei.org, 
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: kpsingh@kernel.org, revest@chromium.org, jackmanb@chromium.org, 
	bpf@vger.kernel.org, kernel-team@cloudflare.com, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 11:02=E2=80=AFPM Frederick Lawler <fred@cloudflare.c=
om> wrote:
>
> On Wed, Dec 06, 2023 at 10:42:50AM +0800, Yafang Shao wrote:
> > On Wed, Dec 6, 2023 at 4:39=E2=80=AFAM Frederick Lawler <fred@cloudflar=
e.com> wrote:
> > >
> > > Hi,
> > >
> > > IIUC, LSMs are supposed to give us the ability to design policy aroun=
d
> > > unprivileged users and in addition to privileged users. As we expand
> > > our usage of BPF LSM's, there are cases where we want to restrict
> > > privileged users from unloading our progs. For instance, any privileg=
ed
> > > user that wants to remove restrictions we've placed on privileged use=
rs.
> > >
> > > We currently have a loader application doesn't leverage BPF skeletons=
. We
> > > instead load BPF object files, and then pin the progs to a mount poin=
t that
> > > is a bpf filesystem. On next run, if we have new policies, load in ne=
w
> > > policies, and finally unload the old.
> > >
> > > Here are some conditions a privileged user may unload programs:
> > >
> > >         umount /sys/fs/bpf
> > >         rm -rf /sys/fs/bpf/lsm
> > >         rm /sys/fs/bpf/lsm/some_prog
> > >         unlink /sys/fs/bpf/lsm/some_prog
> > >
> > > This works because once we remove the last reference, the programs an=
d
> > > pinned maps are cleaned up.
> > >
> > > Moving individual pins or moving the mount entirely with mount --move
> > > do not perform any clean up operations. Lastly, bpftool doesn't curre=
ntly
> > > have the ability to unload LSM's AFAIK.
> > >
> > > The few ideas I have floating around are:
> > >
> > > 1. Leverage some LSM hooks (BPF or otherwise) to restrict on the func=
tions
> > >    security_sb_umount(), security_path_unlink(), security_inode_unlin=
k().
> > >
> > >    Both security_path_unlink() and security_inode_unlink() handle the
> > >    unlink/remove case, but not the umount case.
> > >
> > > 3. Leverage SELinux/Apparmor to possibly handle these cases.
> > >
> > > 4. Introduce a security_bpf_prog_unload() to target hopefully the
> > >    umount and unlink cases at the same time.
> > >
> >
> > All the above programs can also be removed by privileged users.
> >
>
> I should probably clarify the "BPF or otherwise" a bit better. Even a
> compiled in LSM module? If so, where can I find a bit more information
> about that?

Uncertain if it's feasible using the LSM module.
+security exports for help.

>
> We are aware of some of the shortcomings of policy cfg for the AppArmor &
> SELinux case.
>
> > > 5. Possible moonshot idea: introduce a interface to pin _specifically=
_
> > >    BPF LSM's to the kernel, and avoid the bpf sysfs problems all
> > >    together.
> >
> > Introducing non-auto-detachable lsm programs seems like a workable
> > solution.  That said, we can't remove the lsm program before it has
> > been detached explicitly by the task which attaches it.
> >
> > >
> > > We're making the assumption this problem has been thought about befor=
e,
> > > and are wondering if there's anything obvious we're missing here.
> > >
> > > Fred
> > >
> >
> >
> > --
> > Regards
> > Yafang
>
> Fred



--=20
Regards
Yafang

