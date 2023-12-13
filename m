Return-Path: <bpf+bounces-17644-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE5981088E
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 04:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FFBAB210B6
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 03:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F476126;
	Wed, 13 Dec 2023 03:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3z9119O"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA561AB;
	Tue, 12 Dec 2023 19:08:37 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-67ef933fcd6so931986d6.3;
        Tue, 12 Dec 2023 19:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702436917; x=1703041717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WT5xUh4doWq/ianBipKMlatMlg97Is+7s6m8E9vVkss=;
        b=Z3z9119OrLHnULsvmtKASozsLbYk+UznIe7/Dxeo74Rrc0PQ9HincTBzbUflE2T1i2
         OC3S/VbKvK4EbcAm10kmkx6TdzbsVTS3bGQKoMfvnVD6Ms1u8xublE4H5Xs9CM8oJWn0
         gugK+ZSHmOiN9ar7HJ/Luix6ExTdMtQLBF1OL2LfW421XdwTS+b3vj8/0BtAK4/Ubjoi
         56TELiSHr27BCnp6Yjnzs4a9rgaBhGPhqkQHFLit0E2W/iRbQsdUunxik7LhDlYGh/Rq
         DvyV3x89OTXylZ3KeN/dxMnMsnL2S8hcASV9ZmFBM2r5aO/HtlWIN0bnL1qF+QQzBR/j
         WlXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702436917; x=1703041717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WT5xUh4doWq/ianBipKMlatMlg97Is+7s6m8E9vVkss=;
        b=mmYLbRuS43X5ErQ86mqgkZLHukHLNA7iam+RCulAXgGuzItY1idaujOGnK79KxTF24
         Jpz2ITmQbEjPhBCTUdWGxLGjclhBqi2p3sslfrZqPc4PKQLCvAPkmlN4jcS5oN1SThX1
         uANVjOpazNd57cOhARJNlSH+dkawPb0hBd/kC2/uPkDDtoO63Wyb3bY007e274dBtoj+
         bjbrvaWDyBEPn+WC1fWyRGtI0nsdCpM/XJ8QzxPHcRySdBtj6CgtdK+n3eTYIS3R28bS
         OWC9XtIx/T6owdeHVExc21TpNrGbVoI6Fuxo88PsOPSd+JZopQ0aM2rxINDxSZ++v5IW
         rL1g==
X-Gm-Message-State: AOJu0YyFlS4+i8fTr+QBYKJFXYydX3zhMEnaqxHFHSXMJ8Oc25hKGLJK
	ri9mrm8gRiENAu6dixtX1rnVcV9P9cjdHU9SLTY=
X-Google-Smtp-Source: AGHT+IHrOzvh+dce4+YrqB4Uzeg9y9N2MCzEqNN4IWhwg3YUrYMtjn2CHqv/9CqUghgXh3xMcDzGX7LJewoSfGkAMyE=
X-Received: by 2002:a05:6214:1fd9:b0:67e:b878:8e48 with SMTP id
 jh25-20020a0562141fd900b0067eb8788e48mr7556838qvb.39.1702436917085; Tue, 12
 Dec 2023 19:08:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208090622.4309-1-laoar.shao@gmail.com> <20231208090622.4309-6-laoar.shao@gmail.com>
 <CACYkzJ7Eg=bG5Vr8eiXyLq+hto2KpnzhgRrw3eiJiqeJSs4w_w@mail.gmail.com>
In-Reply-To: <CACYkzJ7Eg=bG5Vr8eiXyLq+hto2KpnzhgRrw3eiJiqeJSs4w_w@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 13 Dec 2023 11:08:00 +0800
Message-ID: <CALOAHbCfrvLhbJAMKip+G2hxhiyYB5b3we+ovKjWhovggJ2deQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] selftests/bpf: Add selftests for set_mempolicy
 with a lsm prog
To: KP Singh <kpsingh@kernel.org>
Cc: akpm@linux-foundation.org, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, omosnace@redhat.com, mhocko@suse.com, ying.huang@intel.com, 
	linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
	bpf@vger.kernel.org, ligang.bdlg@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 3:22=E2=80=AFAM KP Singh <kpsingh@kernel.org> wrote=
:
>
> On Fri, Dec 8, 2023 at 10:06=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > The result as follows,
> >   #263/1   set_mempolicy/MPOL_BIND_without_lsm:OK
> >   #263/2   set_mempolicy/MPOL_DEFAULT_without_lsm:OK
> >   #263/3   set_mempolicy/MPOL_BIND_with_lsm:OK
> >   #263/4   set_mempolicy/MPOL_DEFAULT_with_lsm:OK
> >   #263     set_mempolicy:OK
> >   Summary: 1/4 PASSED, 0 SKIPPED, 0 FAILED
>
> Please write a commit description on what the test actually does. I

will do it.

> even think of something simple that mentions a BPF LSM program that
> denies all mbind with the mode MPOL_BIND and checks whether the
> corresponding syscall is denied when the program is loaded.

It does. Additionally, it verifies whether the mbind syscall is denied
with different modes, such as MPOL_DEFAULT."

--=20
Regards
Yafang

