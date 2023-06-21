Return-Path: <bpf+bounces-3016-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B54738462
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 15:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 915D11C20AED
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 13:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E744168DC;
	Wed, 21 Jun 2023 13:06:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF3C16407;
	Wed, 21 Jun 2023 13:06:23 +0000 (UTC)
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8069AE57;
	Wed, 21 Jun 2023 06:06:21 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230621130618euoutp029d7307487d761f7bf2f8f6f0c9e5bc6d~qrmmZaJYP1283412834euoutp024;
	Wed, 21 Jun 2023 13:06:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230621130618euoutp029d7307487d761f7bf2f8f6f0c9e5bc6d~qrmmZaJYP1283412834euoutp024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1687352779;
	bh=tF4riIzozstFHcZHBtz5SQAzztgzSEi85C6+BMxI57A=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=KizIn4h/+VubKpimOPqcdjHWTOSNrdxhq52NIdlcN6uvcXLAB6nFiyBh7t4SmSiCP
	 td604+vg7J45oRN7XVDY0MruktIM6Tfp+rbOoX3PpG3N0t8hckrvJWga2W8NV3jyeY
	 H1l5Lg0B87tZSR6VD/1dW5vkoQMqYyIu+p+NXDVs=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20230621130618eucas1p24a0ecfda837a4bd159368de20c0d1f69~qrml_A2lL0200602006eucas1p2B;
	Wed, 21 Jun 2023 13:06:18 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 84.F5.42423.AC5F2946; Wed, 21
	Jun 2023 14:06:18 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20230621130617eucas1p2525f138d93e3e4d0385cda670558b863~qrmlJMDn80596505965eucas1p2T;
	Wed, 21 Jun 2023 13:06:17 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20230621130617eusmtrp157908a4e096267c8ad2bfbaa7ff6b47e~qrmlGGTkZ0857208572eusmtrp1W;
	Wed, 21 Jun 2023 13:06:17 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-82-6492f5ca367b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id F1.B8.14344.9C5F2946; Wed, 21
	Jun 2023 14:06:17 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20230621130616eusmtip17e21dd5f7eca1289642f50e5db94443d~qrmkf0BdK0234302343eusmtip1d;
	Wed, 21 Jun 2023 13:06:16 +0000 (GMT)
Received: from localhost (106.210.248.248) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 21 Jun 2023 14:06:15 +0100
Date: Wed, 21 Jun 2023 15:06:14 +0200
From: Joel Granados <j.granados@samsung.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
CC: <mcgrof@kernel.org>, Russell King <linux@armlinux.org.uk>, Catalin
	Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Michael
	Ellerman <mpe@ellerman.id.au>, Heiko Carstens <hca@linux.ibm.com>, Vasily
	Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Andy Lutomirski
	<luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Russ
	Weight <russell.h.weight@intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Phillip Potter <phil@philpotter.co.uk>,
	Clemens Ladisch <clemens@ladisch.de>, Arnd Bergmann <arnd@arndb.de>, Corey
	Minyard <minyard@acm.org>, Theodore Ts'o <tytso@mit.edu>, "Jason A.
 Donenfeld" <Jason@zx2c4.com>, Joonas Lahtinen
	<joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, David Airlie
	<airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, "K. Y. Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>, Song Liu <song@kernel.org>, Robin Holt
	<robinmholt@gmail.com>, Steve Wahl <steve.wahl@hpe.com>, David Ahern
	<dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Sudip Mukherjee
	<sudipm.mukherjee@gmail.com>, Mark Rutland <mark.rutland@arm.com>, "James
 E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, Doug Gilbert <dgilbert@interlog.com>, Jiri
	Slaby <jirislaby@kernel.org>, Juergen Gross <jgross@suse.com>, Stefano
	Stabellini <sstabellini@kernel.org>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Benjamin
	LaHaise <bcrl@kvack.org>, David Howells <dhowells@redhat.com>, Jan Harkes
	<jaharkes@cs.cmu.edu>, <coda@cs.cmu.edu>, Trond Myklebust
	<trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, Chuck
	Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, Jan Kara
	<jack@suse.cz>, Anton Altaparmakov <anton@tuxera.com>, Mark Fasheh
	<mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, Joseph Qi
	<joseph.qi@linux.alibaba.com>, Kees Cook <keescook@chromium.org>, Iurii
	Zaikin <yzaikin@google.com>, Eric Biggers <ebiggers@kernel.org>, "Darrick J.
 Wong" <djwong@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
	Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Balbir
	Singh <bsingharora@gmail.com>, Eric Biederman <ebiederm@xmission.com>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Anil S Keshavamurthy
	<anil.s.keshavamurthy@intel.com>, Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, John
	Stultz <jstultz@google.com>, Steven Rostedt <rostedt@goodmis.org>, Andrew
	Morton <akpm@linux-foundation.org>, Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <muchun.song@linux.dev>, Naoya Horiguchi
	<naoya.horiguchi@nec.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Joerg Reuter <jreuter@yaina.de>, Ralf Baechle <ralf@linux-mips.org>, Pablo
	Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>, Roopa Prabhu <roopa@nvidia.com>, Nikolay
	Aleksandrov <razor@blackwall.org>, Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>, Miquel Raynal
	<miquel.raynal@bootlin.com>, Steffen Klassert
	<steffen.klassert@secunet.com>, Matthieu Baerts
	<matthieu.baerts@tessares.net>, Mat Martineau <martineau@kernel.org>, Simon
	Horman <horms@verge.net.au>, Julian Anastasov <ja@ssi.bg>, Remi
	Denis-Courmont <courmisch@gmail.com>, Santosh Shilimkar
	<santosh.shilimkar@oracle.com>, Marc Dionne <marc.dionne@auristor.com>, Neil
	Horman <nhorman@tuxdriver.com>, Marcelo Ricardo Leitner
	<marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, Karsten Graul
	<kgraul@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher
	<jaka@linux.ibm.com>, Jon Maloy <jmaloy@redhat.com>, Ying Xue
	<ying.xue@windriver.com>, Martin Schiller <ms@dev.tdt.de>, John Johansen
	<john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, James
	Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Jarkko
	Sakkinen <jarkko@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>, Christian Borntraeger
	<borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, "H. Peter
 Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Mike Travis
	<mike.travis@hpe.com>, Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>,
	John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau
	<martin.lau@linux.dev>, Yonghong Song <yhs@fb.com>, KP Singh
	<kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Waiman Long
	<longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, John Ogness
	<john.ogness@linutronix.de>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Daniel
	Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider
	<vschneid@redhat.com>, Andy Lutomirski <luto@amacapital.net>, Will Drewry
	<wad@chromium.org>, Stephen Boyd <sboyd@kernel.org>, Miaohe Lin
	<linmiaohe@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-s390@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <openipmi-developer@lists.sourceforge.net>,
	<intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-hyperv@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-raid@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-scsi@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-aio@kvack.org>,
	<linux-cachefs@redhat.com>, <codalist@telemann.coda.cs.cmu.edu>,
	<linux-mm@kvack.org>, <linux-nfs@vger.kernel.org>,
	<linux-ntfs-dev@lists.sourceforge.net>, <ocfs2-devel@oss.oracle.com>,
	<fsverity@lists.linux.dev>, <linux-xfs@vger.kernel.org>,
	<bpf@vger.kernel.org>, <kexec@lists.infradead.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-hams@vger.kernel.org>,
	<netfilter-devel@vger.kernel.org>, <coreteam@netfilter.org>,
	<bridge@lists.linux-foundation.org>, <dccp@vger.kernel.org>,
	<linux-wpan@vger.kernel.org>, <mptcp@lists.linux.dev>,
	<lvs-devel@vger.kernel.org>, <rds-devel@oss.oracle.com>,
	<linux-afs@lists.infradead.org>, <linux-sctp@vger.kernel.org>,
	<tipc-discussion@lists.sourceforge.net>, <linux-x25@vger.kernel.org>,
	<apparmor@lists.ubuntu.com>, <linux-security-module@vger.kernel.org>,
	<keyrings@vger.kernel.org>
Subject: Re: [PATCH 09/11] sysctl: Remove the end element in sysctl table
 arrays
Message-ID: <20230621130614.s36w4u7dzmb5d5p3@localhost>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="avrt2cz7yepdubk6"
Content-Disposition: inline
In-Reply-To: <87o7l92hg8.fsf@intel.com>
X-Originating-IP: [106.210.248.248]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2VTaUwUZxjuNzM7s6LQAWz8RJomC0pEQDE2vrbV1IhkPEirtmliWnErU7Ry
	ZRfrVWXlZgFZFxRYkMtyCFsQXDegViwiLKKILg0IXiBoQbrcroBggaGtSf89x/u8eZ8v+cSk
	TbLYTrwvIJiXBUj9JLQFpa8ZbXC9NaL2WdEyxoKhOYeAKsVqaCwuQmAeTyPhyp9tFFSU6UTQ
	HxpBglZ3goChC5M0DFXX0vDyxiACg7aNgfTu2wy80rZMue0vRJB+N5yCieZYGrpUl0hoGumj
	4a0+nIGumg4G9PFT6xs1r0RQVVvJQGyPPaSpLhLQmdAhgrTkMAJy22JEkG8sQaAeVSF4+ocd
	pKYYEJjO2oNhOIIGfVMmgt+yCRg9ORfeGEppuB3rD31n0giIMedSkHQmFEF/tEkExsvpNDzW
	vhVB4/V6EURlXkbwvCqeAlV2GAmxzeU09Md10FBdcoeCh4l5FNTXGCgIyxwkYaygVgSxp5IZ
	0MacF0HB7ecEnMtfAgOVO6C3q4gCZUIU+lzKGZu2cOaIkxSnzdAiztRQh7gM7VFOo4inuTTF
	PYrLqt7K6c4/ILjY6h6Sy+lWUNzD3ArElTxQ01yF5hHD6a8v5sKvtTJffrzT4jMf3m/fT7xs
	+brdFnvTSiLJIIPkUI3xCqFApfZKJBZjdhXO716uRBZiG7YA4fGzF2iBDCN86peRWTKEcGr2
	U5ESzZlJlHbkiwQjH+F23TXi36mbr6+SArmEcEd9IpqOUOxi/Drh9EycZl3w3d6H5DSez7ri
	X1s6Z1aR7P01OKqseiZgy27H4TnRzDS2ZFfj3MFQJGBrXJfaSU1jkj2Ei9vvMNMtSHYRzp8U
	T8tzWCdc8WKCEk51wM3XztECPoZv6VpnLsXsg3lYWa6eNTxwgymMEbAt7qnVzWJ7XJ8YRwmB
	RIQrJ/sZgRQhnHdihBCmPsXhTZ2zifXYkHOTFt7VCrf8ZS0caoXV+mRSkC1xdKSNML0EFz3u
	pVTIQfNONc071TT/VRNkF5x1ZZD+n7wM52W/JAW8FhcX91FZiClEC/gDcn9fXu4ewB90k0v9
	5QcCfN32BPqXoan/Wj9ZO1iOzvYMuFUhQoyqkONUuONCUSOyowICA3jJfMsPy9Q+NpY+0sNH
	eFmgt+yAHy+vQovElGSB5bK1dXtsWF9pML+f54N42T8uIZ5jpyBAXH1DErmw9L3vfj4edQrd
	/GC4Z+X6paZ1STLXtpDG4qD9Lqet92UV5Li4G+/tNB9ehyNN9ZrljHY47qBiYNsmo0lS6JTd
	edU7yf3J0S/6r6asvFzT8lVS2ERnymnViZDa0v0ec2/YW/2uXKZesbHO85OEbQ6PMre7jq85
	kmsKmvco+ZjqzeZAmWVGuc+Tcrtw50Jns01GW4b0orq83eH75yEbGsy7u71U36Tqlu7IyG1+
	v2tjoKfr4LOvne28WluDtw5obLvafww2ji7UnPT2+7aP/KFQ6Whea+1x6Zl3i2QyrHJbzAar
	VYcnxhTPvNBxJ9/Nekfrvbs8N1n33tmye9caseP9jySUfK/U3ZmUyaV/A+eJIRoqBQAA
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTfUxTZxTG9957e1s0aAcS7hB16eZgqIWilYMB5zI0Fzc30bklbgKd3KEb
	tKQFMnGaIjC1+AF1KgNC/CoIlEJZqzL8CkIpgwEq8m02oA75GBWhOMTCbm2WmeyfN7/3Oed5
	ct43OTzc7SrXi7dXmsjIpZI4ATmPaJytf7iqwaaOCRjt5YO+cYgEc8cFDPLLtSTUKIOgVVeK
	4NlMHg7Vj3sIyKiaI6Cq0sCBVNM5DtjVJi5MTvdwQTVrIODJoQwctIZUDAbsNSRMVMyyR209
	CSN3niIwa9m+ewMPSDg7lEpA/lATF6yFxxD0qge5MPdwEINL5j4MprSdGFTrxjCwVx3GYaJv
	kANzV7JxuHh+CofHFYcR5LekE2DvyCThZnolgps5ZSSMHZoh4FGWEYf7lgXQZrOSoPslA2Ot
	6Vwou/4Ch0emfi4c7Z8j4cpx9lXWtEhozZ3iQNrFchLar9JQU3+LCyMFJQgyh70hzWhDcEbv
	CXlZP2NgOdnPgbyzaRhoeo5yoK3wCQlF98sRqKez0IY6RN9v+5B+lnGCoH8ftRO0tkDLSu13
	cXrmuRrR3f02nB5rbkB0gXY/nas8TtJ5yrsEfa72I9rW1YzRz6f9aENxF0Zn1g7jW3fsFIbI
	ZUmJzJt7ZIrEUMEXIggUioJBGLgmWChaHbRrXaBY4L8+JIaJ25vMyP3XRwv3nO68jCWYBN91
	T5/nKFG5twq58Cj+GkrfX8RxsBtfg6gJa6hT96b0kw84TnanXrSrSBWax/aMI6qoqRZ3XoyI
	OlGS/7KL4C+n/j55+iWT/JVUy2gv7uBF/FVUWaeF4zDg/OZgKv2vNtJRcOdvo9IvHOE62JUf
	RGmeHkLO1D8QZb3QQjgLr1MNP1leMs5PpjJum1kDj+XFVNEszyG78H2oqkE74Rz1Larj5kXS
	yQeoCfufKAu5576SlPtKUu5/SU7Zj+qcHcL+J6+gCs+P4E4OpXQ6K3EOcUvQIiZJER8brwgU
	KiTxiiRprHC3LL4SsVtzxTRtuIaKh8eFNQjjoRr0NuvsryhtRV6EVCZlBItcl1SqY9xcYyT7
	Uhi5LEqeFMcoapCY/cZs3Mtjt4xdQWlilGhtgFi0Zm1wgDh47WqBp2t4whGJGz9Wksh8yzAJ
	jPxfH8Zz8VJiZ2NX1RkPLqyOXNKOKbsT7kUdOJwaOhM9aXEJ8857tkw8lSneeKbn1MSNhI/D
	l3oOPaxuCesMMPXuPO5htjARme8ZePuCLlvMn260Dezvur1yV6NldPhSdruvWr8dK530/PHX
	z0QnIlWGkXe//+COPmWpz5YNIz7vNH0dqqnWbt6eY/d/v2/plorxH5BdMb+A52lYn+aLfOoC
	Dm5+7vs4hZzu8NKE6D9ZybW+SNXcuEYujvLDVcc8Dp65Zp/8MqkgYr7RNNAcrZPOdhm/Kba8
	tqwvWpAT3lq+YPGKTEtYRFiZ56n8dePLF5Ra3riu3NbB2Vq/adOOhbyJ5N/EOU2f33pQvuWr
	KAGh2CMR+eFyheQfqa/esMoEAAA=
X-CMS-MailID: 20230621130617eucas1p2525f138d93e3e4d0385cda670558b863
X-Msg-Generator: CA
X-RootMTR: 20230621094824eucas1p2b6adfbd3f15ff3665674917f419b25d3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230621094824eucas1p2b6adfbd3f15ff3665674917f419b25d3
References: <20230621091000.424843-1-j.granados@samsung.com>
	<CGME20230621094824eucas1p2b6adfbd3f15ff3665674917f419b25d3@eucas1p2.samsung.com>
	<20230621094817.433842-1-j.granados@samsung.com> <87o7l92hg8.fsf@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--avrt2cz7yepdubk6
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 21, 2023 at 02:16:55PM +0300, Jani Nikula wrote:
> On Wed, 21 Jun 2023, Joel Granados <j.granados@samsung.com> wrote:
> > Remove the empty end element from all the arrays that are passed to the
> > register sysctl calls. In some files this means reducing the explicit
> > array size by one. Also make sure that we are using the size in
> > ctl_table_header instead of evaluating the .procname element.
>=20
> Where's the harm in removing the end elements driver by driver? This is
> an unwieldy patch to handle.

I totally agree. Its a big one!!! but I'm concerned of breaking bisectibili=
ty:
* I could for example separate all the removes into separate commits and
  then have a final commit that removes the check for the empty element.
  But this will leave the tree in a state where the for loop will have
  undefined behavior when it looks for the empty end element. It might
  or might not work (probably not :) until the final commit where I fix
  that.

* I could also change the logic that looks for the final element,
  commit that first and then remove the empty element one commit per
  driver after that. But then for all the arrays that still have an
  empty element, there would again be undefined behavior as it would
  think that the last element is valid (when it is really the sentinel).

Any ideas on how to get around these?
>=20
> > diff --git a/drivers/gpu/drm/i915/i915_perf.c b/drivers/gpu/drm/i915/i9=
15_perf.c
> > index f43950219ffc..e4d7372afb10 100644
> > --- a/drivers/gpu/drm/i915/i915_perf.c
> > +++ b/drivers/gpu/drm/i915/i915_perf.c
> > @@ -4884,24 +4884,23 @@ int i915_perf_remove_config_ioctl(struct drm_de=
vice *dev, void *data,
> > =20
> >  static struct ctl_table oa_table[] =3D {
> >  	{
> > -	 .procname =3D "perf_stream_paranoid",
> > -	 .data =3D &i915_perf_stream_paranoid,
> > -	 .maxlen =3D sizeof(i915_perf_stream_paranoid),
> > -	 .mode =3D 0644,
> > -	 .proc_handler =3D proc_dointvec_minmax,
> > -	 .extra1 =3D SYSCTL_ZERO,
> > -	 .extra2 =3D SYSCTL_ONE,
> > -	 },
> > +		.procname =3D "perf_stream_paranoid",
> > +		.data =3D &i915_perf_stream_paranoid,
> > +		.maxlen =3D sizeof(i915_perf_stream_paranoid),
> > +		.mode =3D 0644,
> > +		.proc_handler =3D proc_dointvec_minmax,
> > +		.extra1 =3D SYSCTL_ZERO,
> > +		.extra2 =3D SYSCTL_ONE,
> > +	},
> >  	{
> > -	 .procname =3D "oa_max_sample_rate",
> > -	 .data =3D &i915_oa_max_sample_rate,
> > -	 .maxlen =3D sizeof(i915_oa_max_sample_rate),
> > -	 .mode =3D 0644,
> > -	 .proc_handler =3D proc_dointvec_minmax,
> > -	 .extra1 =3D SYSCTL_ZERO,
> > -	 .extra2 =3D &oa_sample_rate_hard_limit,
> > -	 },
> > -	{}
> > +		.procname =3D "oa_max_sample_rate",
> > +		.data =3D &i915_oa_max_sample_rate,
> > +		.maxlen =3D sizeof(i915_oa_max_sample_rate),
> > +		.mode =3D 0644,
> > +		.proc_handler =3D proc_dointvec_minmax,
> > +		.extra1 =3D SYSCTL_ZERO,
> > +		.extra2 =3D &oa_sample_rate_hard_limit,
> > +	}
> >  };
>=20
> The existing indentation is off, but fixing it doesn't really belong in
> this patch.

Agreed. But I actually was trying to fix something that checkpatch
flagged. I'll change these back (which will cause this patch to be
flagged).

An alternative solution would be to fix the indentation as part of the
preparation patches. Tell me what you think.

Thx

>=20
> BR,
> Jani.
>=20
>=20
> --=20
> Jani Nikula, Intel Open Source Graphics Center

--=20

Joel Granados

--avrt2cz7yepdubk6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmSS9cQACgkQupfNUreW
QU/tWQv+LHqhRfLnActmTK06NicBnR3PUYRIMank4jSVG6jtvqu/VBMNmvKyRaeA
68kGzzIEbayPbBOL1M2GmrBgIaWp9OIWt4jKQeY4ARm9DcL2FWqUqLufGoPlwjX/
0GFjsIlBykddf6c3149Hf7D2Xz+hZyF8GgqMaIuty4hcNbIoeYs5zmwPaQmn+/q0
eoe07uBOs32ocQPIMJuRPMw6KSxHYOiWbNHxgQlIl7stObKOuvQXO2GLDgqHc13y
NKMTC6XNh4VAc7JHtrsEVEBiVro3IGh7cS5U5DK0jhlSLsRfJUkXmSO4H9EwGLBq
mWAl5Qr+YGnCrfE6jGc7uTM0etzscRGIlKIJ+7qcLgSfVgkqYeb5AmkZ8bvailD8
h66rr3XzwBKiQRaXpk6V7/IliqJcG7+N2yGsGJ3UXpvoF/1ieeb39kcSOFZ75BU5
USV/t5Fj0VqHetwv6dC5A8RLktlHNQZcTAXJkLL0QZ5xrmWC9kiIJ/EzJnCgJlSu
AwkfgT+P
=LLXc
-----END PGP SIGNATURE-----

--avrt2cz7yepdubk6--

