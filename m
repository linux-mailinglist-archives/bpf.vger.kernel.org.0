Return-Path: <bpf+bounces-11053-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C52747B232E
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 19:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id A33221C20B84
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 17:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE2C51251;
	Thu, 28 Sep 2023 17:06:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED5213AFB;
	Thu, 28 Sep 2023 17:06:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B31C433C8;
	Thu, 28 Sep 2023 17:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695920779;
	bh=DNM/VlOuUT51G0bnMvXw+94sqfHee3c68K5vLwQuau4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=T1EG9wCsmdavqbCDgZQmRYDY2hTjqQ8HvqU7HakqZRoba0+m8x7Xb0PPxNH54fTbK
	 gxOvKBrhR/NUHAqOFYLgQFvCS4fbqqpdpyJ0meCz+VJBZB5WwUDXaofxixCnDwGA2b
	 xVhvTR3lvjwhcUNCr4cL+zM4prum42dBj/EqssN3wQ5xwZohTtnO5wenm4djJ5rTsg
	 au+O/I2DWLjGqSGQ9+pJFDrXNkgJ5uSZlH8zfxoOHymWjEqjSumVZbYplcXqZfm3+f
	 KDfZ0aAr31be94G8szYCClaMWLFdZEYGpG76Y3w4tHoT3E7mgxWznMj5HFQTi8O+xa
	 SaKUjb/2UX2Ww==
Message-ID: <af047e4a1c6947c59d4a13d4ae221c784a5386b4.camel@kernel.org>
Subject: Re: [PATCH 86/87] fs: switch timespec64 fields in inode to discrete
 integers
From: Jeff Layton <jlayton@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Alexander Viro <viro@zeniv.linux.org.uk>,
  Christian Brauner <brauner@kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, David Sterba <dsterba@suse.cz>, Amir
 Goldstein <amir73il@gmail.com>, Theodore Ts'o <tytso@mit.edu>,  "Eric W.
 Biederman" <ebiederm@xmission.com>, Kees Cook <keescook@chromium.org>,
 Jeremy Kerr <jk@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Heiko Carstens <hca@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>, Todd Kjos
 <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes
 <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren
 Baghdasaryan <surenb@google.com>, Mattia Dongili <malattia@linux.it>,
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, Jason
 Gunthorpe <jgg@ziepe.ca>,  Leon Romanovsky <leon@kernel.org>, Brad Warrum
 <bwarrum@linux.ibm.com>, Ritu Agarwal <rituagar@linux.ibm.com>, Hans de
 Goede <hdegoede@redhat.com>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Mark Gross <markgross@kernel.org>, Jiri
 Slaby <jirislaby@kernel.org>, Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet
 <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, 
 David Sterba <dsterba@suse.com>, David Howells <dhowells@redhat.com>, Marc
 Dionne <marc.dionne@auristor.com>,  Ian Kent <raven@themaw.net>, Luis de
 Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>,
 "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,  Chris Mason
 <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, Xiubo Li
 <xiubli@redhat.com>,  Ilya Dryomov <idryomov@gmail.com>, Jan Harkes
 <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, Joel Becker <jlbec@evilplan.org>,
 Christoph Hellwig <hch@lst.de>, Nicolas Pitre <nico@fluxnic.net>, "Rafael J
 . Wysocki" <rafael@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Gao Xiang
 <xiang@kernel.org>, Chao Yu <chao@kernel.org>,  Yue Hu
 <huyue2@coolpad.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, Namjae Jeon
 <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, Jan Kara
 <jack@suse.com>, Andreas Dilger <adilger.kernel@dilger.ca>, Jaegeuk Kim
 <jaegeuk@kernel.org>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
 Christoph Hellwig <hch@infradead.org>, Miklos Szeredi <miklos@szeredi.hu>,
 Bob Peterson <rpeterso@redhat.com>, Andreas Gruenbacher
 <agruenba@redhat.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, Mikulas Patocka
 <mikulas@artax.karlin.mff.cuni.cz>,  Mike Kravetz
 <mike.kravetz@oracle.com>, Muchun Song <muchun.song@linux.dev>, Jan Kara
 <jack@suse.cz>,  David Woodhouse <dwmw2@infradead.org>, Dave Kleikamp
 <shaggy@kernel.org>, Tejun Heo <tj@kernel.org>, Trond Myklebust
 <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, Chuck
 Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, Olga
 Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
 <tom@talpey.com>,  Ryusuke Konishi <konishi.ryusuke@gmail.com>, Anton
 Altaparmakov <anton@tuxera.com>, Konstantin Komarov
 <almaz.alexandrovich@paragon-software.com>, Mark Fasheh <mark@fasheh.com>, 
 Joseph Qi <joseph.qi@linux.alibaba.com>, Bob Copeland <me@bobcopeland.com>,
 Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg
 <martin@omnibond.com>, Luis Chamberlain <mcgrof@kernel.org>, Iurii Zaikin
 <yzaikin@google.com>, Tony Luck <tony.luck@intel.com>,  "Guilherme G.
 Piccoli" <gpiccoli@igalia.com>, Anders Larsen <al@alarsen.net>, Steve
 French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, Ronnie
 Sahlberg <lsahlber@redhat.com>, Shyam Prasad N <sprasad@microsoft.com>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, Phillip Lougher
 <phillip@squashfs.org.uk>, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Evgeniy Dushistov <dushistov@mail.ru>,
 Chandan Babu R <chandan.babu@oracle.com>, "Darrick J. Wong"
 <djwong@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota
 <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  Hugh Dickins
 <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, John Johansen
 <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, James
 Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Stephen
 Smalley <stephen.smalley.work@gmail.com>, Eric Paris <eparis@parisplace.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org,  platform-driver-x86@vger.kernel.org,
 linux-rdma@vger.kernel.org,  linux-serial@vger.kernel.org,
 linux-usb@vger.kernel.org, v9fs@lists.linux.dev, 
 linux-afs@lists.infradead.org, autofs@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
 codalist@coda.cs.cmu.edu, linux-efi@vger.kernel.org, 
 linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, gfs2@lists.linux.dev, 
 linux-um@lists.infradead.org, linux-mtd@lists.infradead.org, 
 jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org, 
 linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net, 
 ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev, 
 linux-karma-devel@lists.sourceforge.net, devel@lists.orangefs.org, 
 linux-unionfs@vger.kernel.org, linux-hardening@vger.kernel.org, 
 reiserfs-devel@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, linux-trace-kernel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, bpf@vger.kernel.org, Netdev
 <netdev@vger.kernel.org>,  apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org,  selinux@vger.kernel.org
Date: Thu, 28 Sep 2023 13:06:03 -0400
In-Reply-To: <6020d6e7-b187-4abb-bf38-dc09d8bd0f6d@app.fastmail.com>
References: <20230928110554.34758-1-jlayton@kernel.org>
	 <20230928110554.34758-2-jlayton@kernel.org>
	 <6020d6e7-b187-4abb-bf38-dc09d8bd0f6d@app.fastmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-09-28 at 11:48 -0400, Arnd Bergmann wrote:
> On Thu, Sep 28, 2023, at 07:05, Jeff Layton wrote:
> > This shaves 8 bytes off struct inode, according to pahole.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>=20
> FWIW, this is similar to the approach that Deepa suggested
> back in 2016:
>=20
> https://lore.kernel.org/lkml/1452144972-15802-3-git-send-email-deepa.kern=
el@gmail.com/
>=20
> It was NaKed at the time because of the added complexity,
> though it would have been much easier to do it then,
> as we had to touch all the timespec references anyway.
>=20
> The approach still seems ok to me, but I'm not sure it's worth
> doing it now if we didn't do it then.
>=20

I remember seeing those patches go by. I don't remember that change
being NaK'ed, but I wasn't paying close attention at the time=20

Looking at it objectively now, I think it's worth it to recover 8 bytes
per inode and open a 4 byte hole that Amir can use to grow the
i_fsnotify_mask. We might even able to shave off another 12 bytes
eventually if we can move to a single 64-bit word per timestamp.=20

It is a lot of churn though.
--=20
Jeff Layton <jlayton@kernel.org>

