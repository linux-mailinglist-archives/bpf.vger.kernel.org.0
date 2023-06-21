Return-Path: <bpf+bounces-3025-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA2F73858B
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 15:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B8592813BD
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 13:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E3C182A4;
	Wed, 21 Jun 2023 13:43:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1254E156D0;
	Wed, 21 Jun 2023 13:43:58 +0000 (UTC)
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEC9E6E;
	Wed, 21 Jun 2023 06:43:56 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230621134353euoutp02d57583f1260e1c228507969bf2dd64df~qsHaHGgl22310523105euoutp02y;
	Wed, 21 Jun 2023 13:43:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230621134353euoutp02d57583f1260e1c228507969bf2dd64df~qsHaHGgl22310523105euoutp02y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1687355033;
	bh=SetH/myydi6dk+ldkx72EVQztsegim0VSf5FSMMJW28=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=PTZBv1Kz5BEVObNa7leJ/yxGfQakTivesF5jb6tBj4a7mw0z2DwCV8KG/lz6Htp2A
	 zjthU/P8T1sIWZ42nVHC5ArvGqiQK48scKj0Re/P/DwFQFC0M/FPQnfLTFYC/Ucswv
	 L2oK3I/5AOGeZQ+wBCu+TIiCshDxA9TJNwfHFkfQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20230621134353eucas1p1dcc5fd6f5a9f46b250ca7cb322bfcb62~qsHZwC8jc0795907959eucas1p1j;
	Wed, 21 Jun 2023 13:43:53 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 7F.CE.42423.89EF2946; Wed, 21
	Jun 2023 14:43:52 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20230621134351eucas1p2f16d6185751b35072bbf7492517dd17b~qsHYhPi3_0645106451eucas1p2x;
	Wed, 21 Jun 2023 13:43:51 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20230621134351eusmtrp12ede84df94c73be5d139021f7caaec4e~qsHYfbU5Z3178131781eusmtrp1O;
	Wed, 21 Jun 2023 13:43:51 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-2b-6492fe98f38e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id B0.8C.10549.79EF2946; Wed, 21
	Jun 2023 14:43:51 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20230621134351eusmtip295329994762b412f6d02a3f47b794c24~qsHX0_Bhu0221102211eusmtip2V;
	Wed, 21 Jun 2023 13:43:51 +0000 (GMT)
Received: from localhost (106.210.248.248) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 21 Jun 2023 14:43:50 +0100
Date: Wed, 21 Jun 2023 15:43:48 +0200
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
Message-ID: <20230621134348.rcdzl7fi7yq2uj6h@localhost>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="nwcq3i6cyedok5cv"
Content-Disposition: inline
In-Reply-To: <878rcd2by5.fsf@intel.com>
X-Originating-IP: [106.210.248.248]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTa1ATZxSG59tddkM0do1Yv8HbCFItAi0dW45t6Vir7eroTMsPW53xEmVB
	WxKUiEV7SyUUBNSAg5GgyCVGI1cxRC4DakAQUISKAl4KQrCKmqhAFFEocbF1pv+e77zve+Y9
	Pz4RKdWI3EWbFdv4CIUszIMWU+aawcu+B4eTg9/v6v8YLKoAKL97g4KY0hEK+gdvMNBXXUvD
	/aonCA7du8iA3ZCIQH/hNgGO3DYCyvNtBLwsjSVhxJxEwt3C2FHfZTUFleoiBLZdQxT0aIpJ
	uGKdAC0Ddhryy2KIUa+agZ6aLgZ2d43QYI9eC006hwtEZxfQYKk9w0BC7zSILh5AcODkFEjT
	nCIgTRtNQPKgBkHnVXfIajMTcKj9A7AdngaDhhMM1DU6KMgvyCZgV8lxAi70x9BgbjmCoCKT
	AKPhGQODe8dBavzoFvuBNAJ2Pz1KgabeHx7r6xm4dvoWASlJj2h4FGdzgaazDS4Qe6QMwR3L
	HgoSWktouLnfQEHZixIGLCkVCHLyVKOF+7rJhTKu48FListNz0XclWvNJHe9a4Dk0nN/4nSq
	PTSXpmqmuIzq5dzzQW/OZGwnuITqXpLraQ7iKhwZFFequ8Vw5rNeXEZR5NcfrhZ/GsyHbd7O
	R7z32XrxpiRNJbXlkm9UbPclFxVqmR2PXEWYnY+Hqp8R8UgskrLHES7ub3ZxClK2H+HcjpWC
	0IdwfayKfJ3I6e6jBOEYwvrhFOJfl6midkwpRvi8toZ2RijWC3cmJRJOplkffPnBzVer3Fhf
	nNdmdXEGSPbPBTi2qBo5hUlsEFZnxTHxSCSSsAG4u1PpHEvYibgu1Uo5mWSjsLVRTzktJDsV
	HxsWOdGVnYOtdbRQ1BO3VmaP8S+43nSdELh9PO6ysQIvxqlHTUjgSbi31sQIPA037E98dQpm
	9yN8ZvgRIzxyEDb8PjC26ROsbrGOJT7HF7LO084SmJ2A2x5OFGpOwMlmLSmMJTjuD6ngfgfn
	/PWA0iBP3RuH6d44TPffYcLYB2eUP6H/N56HDZn3SYEDcX6+ncpAzAk0hY9UykN5pb+C/9FP
	KZMrIxWhfhvD5UVo9KM2DNc+KUGHex/7WRAhQhY0ezTcVZjThNwpRbiC93CTTC9KDpZKgmU7
	dvIR4esiIsN4pQVNFVEeUyTzAus2StlQ2Tb+B57fwke8VgmRq7uKSPuifGj9ouDxm1Yc3Fr/
	bdRHcxVGPEs7XPp369anxPS3lwWuuOJXaBIb63fGdK7URoUWTpborp4zFthC3FxXnXSsCuyd
	+ZXWS5l3Z69D913P6dA5x2UNIy+q2IL2RL3dpyUtkdznmeDVkl5itVYOWY5NbZ6foOduuvGJ
	6gxdzaR1M5bmoZyfrSHfz1vzrKMqvtKb3L5sZPIi8z35N9qkDQuzQ4LHOcb73G57y3vHb6cq
	/AMe7mtdc6bo3AY/a4B6YJGvfndHufTdGdyWkJnixnBjmbygYOlFz8cDv95d0ihd7GaeKw4J
	eq7vtK27akyan7ng/J61q+NM8udfWiVVZTuXn7DPGvKglJtk/t5khFL2D92Tjv8jBQAA
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTe0xTVxzHc+69va3GujtEvSIzrLJsQyiWh/4YymbcsrvNxM0EzXCiHdwp
	QVrWApkaHUKrUMRhEygrpgJaHPbBQ0DFwUxlIHNB5aniHBYUeaNQHGLbtXbLTPbPyed8z/f7
	ze+c5PBwr1quDy9BksLKJOK9AnI+cd3Rcj9I41DHr86f9YGq60MkXOspxeBkhZEES/pauGk2
	IHg2V4TD5ce9BCgvOQm4VF3DgcPNxRywq5u5MD3bywWVo4aAyQwlDsaawxj02y0kTFU6XEtT
	CwkjV58iuGZ0+dr7u0jQDB0m4OTQ71yYKDuG4J56kAvOPwYxOHPtAQYzxtsYXDaPY2C/dBSH
	qQeDHHDWncDhdMkMDo8rjyI4eUNBgL0nh4RGRTWCxkITCeMZcwQ8zKvFoWNgIXTaJkgw1ysx
	V1TBBdPPL3B42GzlQrbVSUJdrutWE5mxcFM7w4HM0xUkdF9gwNLyCxdGdOcQ5Az7QmatDUFB
	1VIoyjuPwcAPVg4UaTIx0Pdmc6CzbJKEsx0VCNSzeeiDXxHT0fkZ80x5nGD+HLUTjFFndEnd
	t3Bm7rkaMXetNpwZb2tFjM54gNGm55JMUfotgilu2sTY7rRhzPPZAKam/A7G5DQN459HxwjX
	yaSpKazfHqk8Zb1guwhChKIIEIaERQhFoWt3vBcSLgiOWhfP7k1IY2XBUbuEexrmfsOTrwd9
	p5lyonTU7q9C83g0FUYb+qcIN3tRekSnGyI9ui9dNd3F8fAi+kW3ilSh+S7PE0TXmBTIs6lF
	9HThDHK7COotuu/EMczNJBVI3xi9h7vZmwqiTbcHOO4ATrVF0IqxTtJ9sIjaQitKs7gqxOPx
	qbV0f5/cU2rA6Jz6updhPvU63frjwMvxcCqNftQwhrn9OLWcPuvguXEe9TY90Ep6Bl1J9zSe
	/ocP0lP2RygPLdK+UqR9pUj7X5FHDqBvO4b+L6+iy0pGcA+vp83mCaIYcc8hbzZVnrQ7SS4S
	ysVJ8lTJbmGcNKkauf5MXfPs+YtIN/xEaEEYD1mQvytprTTcRD6ERCphBd78N6rV8V78ePG+
	/axMulOWupeVW1C46xFP4D6L46SuDyhJ2SlaszpcFLYmYnV4xJpQwVL+J8lZYi9qtziFTWTZ
	ZFb2bw7jzfNJx14rj+b39kWHUfmOwWfLtqZtKGyK2bbxHWnDzMXEzE11On/O05KqRCx0eeQB
	ZXP9l2Oxm6vaskb2ZSyMexRZNmPSKg853/dTHrlq74oZ1dbtutUbW5zNDRgwtK/aMCeub7d2
	bKwONvM+1G1eqf0mkPatXcCUSFZsbeHXLo61Zx+q2h83zbdEPezeVZ4xaFI1bHkQ/ldfiGVs
	27vOj5fs32LjHLm7zP/rLzhj7UFXZj/1zzhlL8hv/Oin7G8XKy/c//7UxX1nkjQamyC49Yq+
	QFauN43qo1dszxO9GT/Sn39wSUJRaWxkSaC5O+as/fHWxEnbAi8/UbI5IumrxDv6hNwd00Jm
	SEDI94hFAbhMLv4bHgGuKMgEAAA=
X-CMS-MailID: 20230621134351eucas1p2f16d6185751b35072bbf7492517dd17b
X-Msg-Generator: CA
X-RootMTR: 20230621094824eucas1p2b6adfbd3f15ff3665674917f419b25d3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230621094824eucas1p2b6adfbd3f15ff3665674917f419b25d3
References: <20230621091000.424843-1-j.granados@samsung.com>
	<CGME20230621094824eucas1p2b6adfbd3f15ff3665674917f419b25d3@eucas1p2.samsung.com>
	<20230621094817.433842-1-j.granados@samsung.com> <87o7l92hg8.fsf@intel.com>
	<20230621130614.s36w4u7dzmb5d5p3@localhost> <878rcd2by5.fsf@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--nwcq3i6cyedok5cv
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 21, 2023 at 04:15:46PM +0300, Jani Nikula wrote:
> On Wed, 21 Jun 2023, Joel Granados <j.granados@samsung.com> wrote:
> > On Wed, Jun 21, 2023 at 02:16:55PM +0300, Jani Nikula wrote:
> >> On Wed, 21 Jun 2023, Joel Granados <j.granados@samsung.com> wrote:
> >> > Remove the empty end element from all the arrays that are passed to =
the
> >> > register sysctl calls. In some files this means reducing the explicit
> >> > array size by one. Also make sure that we are using the size in
> >> > ctl_table_header instead of evaluating the .procname element.
> >>=20
> >> Where's the harm in removing the end elements driver by driver? This is
> >> an unwieldy patch to handle.
> >
> > I totally agree. Its a big one!!! but I'm concerned of breaking bisecti=
bility:
> > * I could for example separate all the removes into separate commits and
> >   then have a final commit that removes the check for the empty element.
> >   But this will leave the tree in a state where the for loop will have
> >   undefined behavior when it looks for the empty end element. It might
> >   or might not work (probably not :) until the final commit where I fix
> >   that.
> >
> > * I could also change the logic that looks for the final element,
> >   commit that first and then remove the empty element one commit per
> >   driver after that. But then for all the arrays that still have an
> >   empty element, there would again be undefined behavior as it would
> >   think that the last element is valid (when it is really the sentinel).
> >
> > Any ideas on how to get around these?
>=20
> First add size to the register calls, and allow the last one to be
> sentinel but do not require the sentinel.
>=20
> Start removing sentinels, adjusting the size passed in.
This is a great idea! and I think I don't even have to adjust the size
because if I change the logic to stop on the sentinel or the size; so when
the sentinel is there, it will stop before the size. And when the
sentinel is not there, it will stop on the correct size.

There might be issues with indirection calls. And there might also be
lots of places where I need to adjust a for loop (as dan has pointed
out) but its worth a try for V2.

Best
>=20
> Once enough sentinels have been removed, add warning if the final entry
> is a sentinel.
>=20
> Never really remove the check? (But surely you can rework the logic to
> not count the number of elements up front, only while iterating.)
>=20
>=20
> BR,
> Jani.
>=20
> >>=20
> >> > diff --git a/drivers/gpu/drm/i915/i915_perf.c b/drivers/gpu/drm/i915=
/i915_perf.c
> >> > index f43950219ffc..e4d7372afb10 100644
> >> > --- a/drivers/gpu/drm/i915/i915_perf.c
> >> > +++ b/drivers/gpu/drm/i915/i915_perf.c
> >> > @@ -4884,24 +4884,23 @@ int i915_perf_remove_config_ioctl(struct drm=
_device *dev, void *data,
> >> > =20
> >> >  static struct ctl_table oa_table[] =3D {
> >> >  	{
> >> > -	 .procname =3D "perf_stream_paranoid",
> >> > -	 .data =3D &i915_perf_stream_paranoid,
> >> > -	 .maxlen =3D sizeof(i915_perf_stream_paranoid),
> >> > -	 .mode =3D 0644,
> >> > -	 .proc_handler =3D proc_dointvec_minmax,
> >> > -	 .extra1 =3D SYSCTL_ZERO,
> >> > -	 .extra2 =3D SYSCTL_ONE,
> >> > -	 },
> >> > +		.procname =3D "perf_stream_paranoid",
> >> > +		.data =3D &i915_perf_stream_paranoid,
> >> > +		.maxlen =3D sizeof(i915_perf_stream_paranoid),
> >> > +		.mode =3D 0644,
> >> > +		.proc_handler =3D proc_dointvec_minmax,
> >> > +		.extra1 =3D SYSCTL_ZERO,
> >> > +		.extra2 =3D SYSCTL_ONE,
> >> > +	},
> >> >  	{
> >> > -	 .procname =3D "oa_max_sample_rate",
> >> > -	 .data =3D &i915_oa_max_sample_rate,
> >> > -	 .maxlen =3D sizeof(i915_oa_max_sample_rate),
> >> > -	 .mode =3D 0644,
> >> > -	 .proc_handler =3D proc_dointvec_minmax,
> >> > -	 .extra1 =3D SYSCTL_ZERO,
> >> > -	 .extra2 =3D &oa_sample_rate_hard_limit,
> >> > -	 },
> >> > -	{}
> >> > +		.procname =3D "oa_max_sample_rate",
> >> > +		.data =3D &i915_oa_max_sample_rate,
> >> > +		.maxlen =3D sizeof(i915_oa_max_sample_rate),
> >> > +		.mode =3D 0644,
> >> > +		.proc_handler =3D proc_dointvec_minmax,
> >> > +		.extra1 =3D SYSCTL_ZERO,
> >> > +		.extra2 =3D &oa_sample_rate_hard_limit,
> >> > +	}
> >> >  };
> >>=20
> >> The existing indentation is off, but fixing it doesn't really belong in
> >> this patch.
> >
> > Agreed. But I actually was trying to fix something that checkpatch
> > flagged. I'll change these back (which will cause this patch to be
> > flagged).
> >
> > An alternative solution would be to fix the indentation as part of the
> > preparation patches. Tell me what you think.
> >
> > Thx
> >
> >>=20
> >> BR,
> >> Jani.
> >>=20
> >>=20
> >> --=20
> >> Jani Nikula, Intel Open Source Graphics Center
>=20
> --=20
> Jani Nikula, Intel Open Source Graphics Center

--=20

Joel Granados

--nwcq3i6cyedok5cv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmSS/pIACgkQupfNUreW
QU8FZgv+NJjIGObr29DU3w9gC84AcnW6dJTp9wHS00NxSXpo+c714JQ2xV0z8i/m
wZbyBR21D/CkjJCTL0pwjCh1xi+PdMHmpB9mDlQSxEg6i+fJXBb7GvWvkOfNagP8
Z2t/NzP/RPP+/BjBP3QOGNyQWgZ4Jl6lMvzlt0aJlHMx7/QD7PRgnNN3KYiFzB+I
FTf5QLbTT85TSPPoGBQCzF6Ych5vKNmIzRZxD2o1zPJFftGIcYOfYOC7vX/1tuOa
1l2+maHSi22uTAHFL3XKvcQBxuLeBCoAIgYOGeO0B+wApLgDVUdHb3PPMw74sOuD
RtgKG6gEgO937g+zKo5xP6M5iLH8xYavJRYPNGH5FBfL7DDROXI6t9tjBpvpUbPS
VQDducT3r8p7hbIhb+3MnRgJri1yF7SjRZF6iewJ9G3Rd7o8PlcLC3aTZLvilO9j
4YYKID1bOqsI9tcLY5oeM6HROqdmLhzFQQlzZCCz4Y/1XVO7ZKpJHP97wqBETkbq
DRVhBHDj
=lxdq
-----END PGP SIGNATURE-----

--nwcq3i6cyedok5cv--

