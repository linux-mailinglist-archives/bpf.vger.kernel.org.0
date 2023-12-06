Return-Path: <bpf+bounces-16957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B52807C97
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 00:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6DE3281ADD
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 23:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FAD328CF;
	Wed,  6 Dec 2023 23:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="frfMqTYe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FE1D44
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 15:55:48 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-289d988a947so26679a91.0
        for <bpf@vger.kernel.org>; Wed, 06 Dec 2023 15:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1701906948; x=1702511748; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8ioixfZXRdrOh6hBuj+IGCCPeUDF31MruhCzIBSvtPg=;
        b=frfMqTYeAmfyN/QMFsODwFNBXyJEXuHZK7/GuWqV85l7wZik6Do5E6yGl+1GpypHXP
         VXxL60URir4iMZdc55ZnCAnYzuBTTpDd88gA9qRLsBZYc5nlgZKVCnzx9NbU1xcALwCz
         yhS2NxMx8i6aSugxd3y5oXGL8lmJ/3gVfWGEiOugG7eIgu0ntQY02w1FWPoDdPu2PqZE
         4tIoneqXlVy+fXHu9TQDelfA6C4KVDwqjQGhZH28V5c5/jf/8EIcIKfuBWZijJaKNOkh
         C2vFHRcd7DLoomzlAMLZ7DzkBU9xnu61FdON+HIZdfLMdLutJRlT6cBdRMVBlQ8Ib/Lr
         /LwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701906948; x=1702511748;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ioixfZXRdrOh6hBuj+IGCCPeUDF31MruhCzIBSvtPg=;
        b=Sl9Cwd0u6rLfOSK2LA2EbQfkBoMtruAvNiECQQP4f0Ypu9OWQ6qi4+QaykFDLUOolt
         8IrnZsCC6Jq4EA6NoRz8bx803tK7K8UpXPryxyp7WTVdF/vjf/8Qz1uRR+/we3JnwyYL
         BYulrA1mUD1QNnFWRkBuLJDPptsNhMKLmmll3rq/amIRpAM+0iSmxLRMgt0zp31AwCZC
         2W3WAElWGZvakUut3jd9mkvT4wat9pwgTGeL2K7RcnmglO9WcifiAe5i3GkcIoD0jboz
         Go2he9BnmXupBdfNTK5El12BaaIzI2SN31VpSUWZwB/BMo6z+g82FgqVPPei3BN4nhCC
         gsPg==
X-Gm-Message-State: AOJu0YxFrJt2sjfZ+BGSVBQn5vZ7O7sV/ECjrEcs2GFEVnCynzyVQBft
	4M70SmH/xbfbHJK2bppeuvfYFw==
X-Google-Smtp-Source: AGHT+IH4RBfMuZUIQDGUHTBkbgy1nx2Dp65ER39CnQABXNDh/8+Z4plHxRfGRvtVG/0D876wBT2R1g==
X-Received: by 2002:a17:90b:3b44:b0:286:815b:8c75 with SMTP id ot4-20020a17090b3b4400b00286815b8c75mr1449165pjb.16.1701906947681;
        Wed, 06 Dec 2023 15:55:47 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id cx14-20020a17090afd8e00b00286c1303cdasm7303pjb.45.2023.12.06.15.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 15:55:47 -0800 (PST)
Date: Wed, 6 Dec 2023 15:55:45 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Michal =?UTF-8?B?S291dG7DvQ==?= <mkoutny@suse.com>
Cc: Pedro Tammela <pctammela@mojatatu.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 cake@lists.bufferbloat.net, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Toke =?UTF-8?B?SMO4?=
 =?UTF-8?B?aWxhbmQtSsO4cmdlbnNlbg==?= <toke@toke.dk>, Vinicius Costa Gomes
 <vinicius.gomes@intel.com>, Petr Pavlu <ppavlu@suse.cz>, Michal Kubecek
 <mkubecek@suse.cz>, Martin Wilck <mwilck@suse.com>
Subject: Re: [PATCH 0/3] net/sched: Load modules via alias
Message-ID: <20231206155545.3ca3b2f6@hermes.local>
In-Reply-To: <53ohvb547tegxv2vuvurhuwqunamfiy22sonog7gll54h3czht@3dnijc44xilq>
References: <20231206192752.18989-1-mkoutny@suse.com>
	<7789659d-b3c5-4eef-af86-540f970102a4@mojatatu.com>
	<vk6uhf4r2turfxt2aokp66x5exzo5winal55253czkl2pmkkuu@77bhdfwfk5y3>
	<20231206142857.38403344@hermes.local>
	<53ohvb547tegxv2vuvurhuwqunamfiy22sonog7gll54h3czht@3dnijc44xilq>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/alJaYiBnMbJbkGX8ASSTb5n";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/alJaYiBnMbJbkGX8ASSTb5n
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 6 Dec 2023 23:49:14 +0100
Michal Koutn=C3=BD <mkoutny@suse.com> wrote:

> On Wed, Dec 06, 2023 at 02:28:57PM -0800, Stephen Hemminger <stephen@netw=
orkplumber.org> wrote:
> > It is not clear to me what this patchset is trying to fix.
> > Autoloading happens now, but it does depend on the name not alias. =20
>=20
> There are some more details in the thread of v1 [1] [2].
> Does it clarify?
>=20
> Thanks,
> Michal
>=20
> [1] https://lore.kernel.org/r/yerqczxbz6qlrslkfbu6u2emb5esqe7tkrexdbneite=
2ah2a6i@l6arp7nzyj75/
> [2] Oh, I realize I forgot to add v2 to today's posting.
>=20
>=20

So your using blacklist as workaround security method and the name confuses=
 it now.

--Sig_/alJaYiBnMbJbkGX8ASSTb5n
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEn2/DRbBb5+dmuDyPgKd/YJXN5H4FAmVxCgEACgkQgKd/YJXN
5H4msQ//bQpRE8MaxhEFPjgk6hhxd+8VBX3AF8SYclV67kaBLPnORN58blvGFVpR
jt+gbHGMyENxE3KXzowiyHcYayDrBJz3IswSKiFZgGTFiUZegH6/mwpfEZ77qd9R
II5Lqwc65AJWOlLvCXICUhvdCrAbyoIV+Draa6QZAz3hYILjXfVgDbIi1O7WI0S5
EcoyKP49Z3+TvakdNmgIV/XPkPQrbM6ipoeeYT1VUBhp2crFa68ISSjkjIlqDIhw
324Px5bmpOWrQfHUjBZnWyPUZpseRfKMhnd1czTRa/mRIFsZRr77O8/2XFp7IdLN
AMM1SuvfWj5jv8MSlR58Jf0/Us30X0ng4xAYIMx9ySFTqFK0sHN/84bgBermd/q6
ZGGTQR6jeMJw9phnLF7DUfZRlgs8QnqJ6KoddTyI7mF7yMbVpTvyT5EdWxEf5duY
IQf8b/ULKjsUankcEKQVM0hseAMEj0VTstA8bYiOpsrXPJGNenvOlp90E3hl/pBv
pM2Em+CpsJBabfXfwDqV9TcgpA8oCHgcuI+oDjJhY5PjIWT7+obMQSDpILntdAIM
UU28U81t1gl33s8XKcpNDGW9KUJv6j0/CUPX91FkWArt6DgF8zvbMGkICgndTHJT
6tBF/6G1G0mCvpdRPm133mx8j0SAA6dnJJvKM5fUjPikplpDoQo=
=Lgtk
-----END PGP SIGNATURE-----

--Sig_/alJaYiBnMbJbkGX8ASSTb5n--

