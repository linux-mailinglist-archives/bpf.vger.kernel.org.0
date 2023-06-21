Return-Path: <bpf+bounces-3066-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CAC73906C
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 21:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D8BE281781
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 19:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514C31C747;
	Wed, 21 Jun 2023 19:52:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84A91B90F;
	Wed, 21 Jun 2023 19:52:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C99C433C8;
	Wed, 21 Jun 2023 19:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687377165;
	bh=vTL4Y8a8sFEsX3Xqt4OIZCRU2/7UfNvPDdjp0N/3dJE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=tBqvzi0BueVyLSEbesqZv6Z2lEPP3VHDK/0ro+NhJgrWCN7POU/GnsfWmg+au/I1/
	 qhi//1NZGnRyBWC+DfSRBIODYBQomanDaEsbNql7Uti143OqrGRxW4LYitKm3HOUFm
	 3AFCsCq6C4olFaFCKGiCtIGy0tLgZnX0NusQlw4HgjVra9Ac5A8Ylg7+9/P0lUpR5a
	 +VLBtjm16h891O76lVM1Ta8bhTOaRz+hamckCGdfcbzLfSMEYWZEagHpIq+7Dm+VlU
	 f0RFgH+s7zmUzeMyOo6a8vBaboDD6pPbvwZcf5WIVyOhAezSg+L8WY3I+kat7Le9is
	 Pb20wj8vyk/yg==
Message-ID: <2a5a069572b46b59dd16fe8d54e549a9b5bbb6eb.camel@kernel.org>
Subject: Re: [PATCH 00/79] fs: new accessors for inode->i_ctime
From: Jeff Layton <jlayton@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>, Michael
 Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Arve
 =?ISO-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>, Todd Kjos
 <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes
 <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, Carlos
 Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>,
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, Jason
 Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Brad Warrum
 <bwarrum@linux.ibm.com>, Ritu Agarwal <rituagar@linux.ibm.com>, Eric Van
 Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck
 <linux_oss@crudebyte.com>, David Sterba <dsterba@suse.com>, David Howells
 <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, Alexander
 Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>, Luis de
 Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>,
 "Tigran A. Aivazian" <aivazian.tigran@gmail.com>, Eric Biederman
 <ebiederm@xmission.com>, Kees Cook <keescook@chromium.org>, Chris Mason
 <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, Xiubo Li
 <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Jan Harkes
 <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, Joel Becker <jlbec@evilplan.org>,
 Christoph Hellwig <hch@lst.de>, Nicolas Pitre <nico@fluxnic.net>,  "Rafael
 J. Wysocki" <rafael@kernel.org>, Tyler Hicks <code@tyhicks.com>, Ard
 Biesheuvel <ardb@kernel.org>, Gao Xiang <xiang@kernel.org>, Chao Yu
 <chao@kernel.org>,  Yue Hu <huyue2@coolpad.com>, Jeffle Xu
 <jefflexu@linux.alibaba.com>, Namjae Jeon <linkinjeon@kernel.org>, Sungjong
 Seo <sj1557.seo@samsung.com>, Jan Kara <jack@suse.com>, Theodore Ts'o
 <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, Jaegeuk Kim
 <jaegeuk@kernel.org>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Miklos
 Szeredi <miklos@szeredi.hu>, Bob Peterson <rpeterso@redhat.com>, Andreas
 Gruenbacher <agruenba@redhat.com>, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, Mikulas Patocka
 <mikulas@artax.karlin.mff.cuni.cz>,  Mike Kravetz
 <mike.kravetz@oracle.com>, Muchun Song <muchun.song@linux.dev>, David
 Woodhouse <dwmw2@infradead.org>, Dave Kleikamp <shaggy@kernel.org>, Tejun
 Heo <tj@kernel.org>, Trond Myklebust <trond.myklebust@hammerspace.com>,
 Anna Schumaker <anna@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Ryusuke Konishi <konishi.ryusuke@gmail.com>, Anton Altaparmakov
 <anton@tuxera.com>,  Konstantin Komarov
 <almaz.alexandrovich@paragon-software.com>, Mark Fasheh <mark@fasheh.com>,
 Joseph Qi <joseph.qi@linux.alibaba.com>, Bob Copeland <me@bobcopeland.com>,
 Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg
 <martin@omnibond.com>, Luis Chamberlain <mcgrof@kernel.org>, Iurii Zaikin
 <yzaikin@google.com>, Tony Luck <tony.luck@intel.com>,  "Guilherme G.
 Piccoli" <gpiccoli@igalia.com>, Anders Larsen <al@alarsen.net>, Steve
 French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, Ronnie
 Sahlberg <lsahlber@redhat.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom
 Talpey <tom@talpey.com>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Phillip Lougher <phillip@squashfs.org.uk>, Masami Hiramatsu
 <mhiramat@kernel.org>, Evgeniy Dushistov <dushistov@mail.ru>, Hans de Goede
 <hdegoede@redhat.com>, "Darrick J. Wong" <djwong@kernel.org>, Damien Le
 Moal <dlemoal@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>, Johannes
 Thumshirn <jth@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  Hugh Dickins
 <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, John Johansen
 <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, James
 Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Stephen
 Smalley <stephen.smalley.work@gmail.com>, Eric Paris
 <eparis@parisplace.org>,  Juergen Gross <jgross@suse.com>, Ruihan Li
 <lrh2000@pku.edu.cn>, Laurent Pinchart
 <laurent.pinchart+renesas@ideasonboard.com>, Wolfram Sang
 <wsa+renesas@sang-engineering.com>, Udipto Goswami
 <quic_ugoswami@quicinc.com>,  Linyu Yuan <quic_linyyuan@quicinc.com>, John
 Keeping <john@keeping.me.uk>, Andrzej Pietrasiewicz
 <andrzej.p@collabora.com>, Dan Carpenter <error27@gmail.com>, Yuta Hayama
 <hayama@lineo.co.jp>, Jozef Martiniak <jomajm@gmail.com>, Jens Axboe
 <axboe@kernel.dk>, Alan Stern <stern@rowland.harvard.edu>, Sandeep Dhavale
 <dhavale@google.com>, Dave Chinner <dchinner@redhat.com>, Johannes Weiner
 <hannes@cmpxchg.org>, ZhangPeng <zhangpeng362@huawei.com>, Viacheslav
 Dubeyko <slava@dubeyko.com>, Tetsuo Handa
 <penguin-kernel@I-love.SAKURA.ne.jp>,  Aditya Garg <gargaditya08@live.com>,
 Erez Zadok <ezk@cs.stonybrook.edu>, Yifei Liu <yifeliu@cs.stonybrook.edu>,
 Yu Zhe <yuzhe@nfschina.com>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Oleg Kanatov <okanatov@gmail.com>, "Dr. David Alan
 Gilbert" <linux@treblig.org>, Jiangshan Yi <yijiangshan@kylinos.cn>, xu xin
 <cgel.zte@gmail.com>, Stefan Roesch <shr@devkernel.io>, Zhihao Cheng
 <chengzhihao1@huawei.com>, "Liam R. Howlett" <Liam.Howlett@Oracle.com>, 
 Alexey Dobriyan <adobriyan@gmail.com>, Minghao Chi
 <chi.minghao@zte.com.cn>, Seth Forshee <sforshee@digitalocean.com>, Zeng
 Jingxiang <linuszeng@tencent.com>, Bart Van Assche <bvanassche@acm.org>,
 Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>,
 Zhang Yi <yi.zhang@huawei.com>, Tom Rix <trix@redhat.com>, "Fabio M. De
 Francesco" <fmdefrancesco@gmail.com>, Chen Zhongjin
 <chenzhongjin@huawei.com>, Zhengchao Shao <shaozhengchao@huawei.com>, Rik
 van Riel <riel@surriel.com>, Jingyu Wang <jingyuwang_vip@163.com>, Hangyu
 Hua <hbh25y@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,  linux-s390@vger.kernel.org,
 linux-rdma@vger.kernel.org,  linux-usb@vger.kernel.org,
 v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-afs@lists.infradead.org, autofs@vger.kernel.org, linux-mm@kvack.org, 
 linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
 codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org,
 linux-efi@vger.kernel.org,  linux-erofs@lists.ozlabs.org,
 linux-ext4@vger.kernel.org,  linux-f2fs-devel@lists.sourceforge.net,
 cluster-devel@redhat.com,  linux-um@lists.infradead.org,
 linux-mtd@lists.infradead.org,  jfs-discussion@lists.sourceforge.net,
 linux-nfs@vger.kernel.org,  linux-nilfs@vger.kernel.org,
 linux-ntfs-dev@lists.sourceforge.net,  ntfs3@lists.linux.dev,
 ocfs2-devel@oss.oracle.com,  linux-karma-devel@lists.sourceforge.net,
 devel@lists.orangefs.org,  linux-unionfs@vger.kernel.org,
 linux-hardening@vger.kernel.org,  reiserfs-devel@vger.kernel.org,
 linux-cifs@vger.kernel.org,  samba-technical@lists.samba.org,
 linux-trace-kernel@vger.kernel.org,  linux-xfs@vger.kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org,  apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org,  selinux@vger.kernel.org
Date: Wed, 21 Jun 2023 15:52:27 -0400
In-Reply-To: <20230621152141.5961cf5f@gandalf.local.home>
References: <20230621144507.55591-1-jlayton@kernel.org>
	 <20230621152141.5961cf5f@gandalf.local.home>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-06-21 at 15:21 -0400, Steven Rostedt wrote:
> On Wed, 21 Jun 2023 10:45:05 -0400
> Jeff Layton <jlayton@kernel.org> wrote:
>=20
> > Most of this conversion was done via coccinelle, with a few of the more
> > non-standard accesses done by hand. There should be no behavioral
> > changes with this set. That will come later, as we convert individual
> > filesystems to use multigrain timestamps.
>=20
> BTW, Linus has suggested to me that whenever a conccinelle script is used=
,
> it should be included in the change log.
>=20

Ok, here's what I have. I note again that my usage of coccinelle is
pretty primitive, so I ended up doing a fair bit of by-hand fixing after
applying these.

Given the way that this change is broken up into 77 patches by
subsystem, to which changelogs should I add it? I could add it to the
"infrastructure" patch, but that's the one where I _didn't_ use it.=A0

Maybe to patch #79 (the one that renames i_ctime)?


------------------------8<------------------------------
@@
expression inode;
@@

- inode->i_ctime =3D current_time(inode)
+ inode_set_current_ctime(inode)

@@
expression inode;
@@

- inode->i_ctime =3D inode->i_mtime =3D current_time(inode)
+ inode->i_mtime =3D inode_set_current_ctime(inode)

@@
struct inode *inode;
expression value;
@@

- inode->i_ctime =3D value;
+ inode_set_ctime(inode, value);

@@
struct inode *inode;
expression val;
@@
- inode->i_ctime.tv_sec =3D val
+ inode_set_ctime_sec(inode, val)

@@
struct inode *inode;
expression val;
@@
- inode->i_ctime.tv_nsec =3D val
+ inode_set_ctime_nsec(inode, val)

@@
struct inode *inode;
@@
- inode->i_ctime
+ inode_ctime_peek(inode)


