Return-Path: <bpf+bounces-11398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC797B8B83
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 20:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 100611C20901
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 18:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D2C219EC;
	Wed,  4 Oct 2023 18:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4cHhSwb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DD521110;
	Wed,  4 Oct 2023 18:55:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD6BC433C9;
	Wed,  4 Oct 2023 18:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696445746;
	bh=g/yzBkH2Lp29tPfDBqNp+9Elc+zqCeoJYNIVCamPD2Q=;
	h=From:To:Cc:Subject:Date:From;
	b=U4cHhSwb0LbjLA0qPOmmG7XGfwhLrdUKNdOP6jb0JmroYvkDlGxxFYbdBHNbhzXNH
	 iovfoJxTxBNF3fgWoxKD5rhfozOY+7XT8L1cOwcimaEFAuQea9kFSm7ljzuINveJng
	 8O/TRaYWLsMFAu0WZqR+Ej7+BaviQVOBsP8mffc2SqReX6OXjtiZTmCmLoR9/saHwB
	 c5rjkuCRPMb/Q55YD3oJLDC2dFLpMza5Y6vaUnEAxOls8VOQTB4gdTGSQ3fEJfeL1x
	 KMOBQbkmXFBlyX1vgIb23wb+t56+wSAOGwpJ/lOlOTTFlZfD0AdwHSMDPWo5mfkyr4
	 HgGj4IVfBzhTQ==
From: Jeff Layton <jlayton@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Sterba <dsterba@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>,
	Jeremy Kerr <jk@ozlabs.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,
	Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Mattia Dongili <malattia@linux.it>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Brad Warrum <bwarrum@linux.ibm.com>,
	Ritu Agarwal <rituagar@linux.ibm.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mark Gross <markgross@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	David Sterba <dsterba@suse.com>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Ian Kent <raven@themaw.net>,
	Luis de Bethencourt <luisbg@kernel.org>,
	Salah Triki <salah.triki@gmail.com>,
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Jan Harkes <jaharkes@cs.cmu.edu>,
	coda@cs.cmu.edu,
	Joel Becker <jlbec@evilplan.org>,
	Christoph Hellwig <hch@lst.de>,
	Nicolas Pitre <nico@fluxnic.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Yue Hu <huyue2@coolpad.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Jan Kara <jack@suse.com>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Christoph Hellwig <hch@infradead.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Bob Peterson <rpeterso@redhat.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <muchun.song@linux.dev>,
	Jan Kara <jack@suse.cz>,
	David Woodhouse <dwmw2@infradead.org>,
	Dave Kleikamp <shaggy@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Anton Altaparmakov <anton@tuxera.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Bob Copeland <me@bobcopeland.com>,
	Mike Marshall <hubcap@omnibond.com>,
	Martin Brandenburg <martin@omnibond.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Iurii Zaikin <yzaikin@google.com>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Anders Larsen <al@alarsen.net>,
	Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Ronnie Sahlberg <lsahlber@redhat.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Phillip Lougher <phillip@squashfs.org.uk>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Evgeniy Dushistov <dushistov@mail.ru>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Eric Paris <eparis@parisplace.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-usb@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	autofs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	codalist@coda.cs.cmu.edu,
	linux-efi@vger.kernel.org,
	linux-erofs@lists.ozlabs.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	gfs2@lists.linux.dev,
	linux-um@lists.infradead.org,
	linux-mtd@lists.infradead.org,
	jfs-discussion@lists.sourceforge.net,
	linux-nfs@vger.kernel.org,
	linux-nilfs@vger.kernel.org,
	linux-ntfs-dev@lists.sourceforge.net,
	ntfs3@lists.linux.dev,
	ocfs2-devel@lists.linux.dev,
	linux-karma-devel@lists.sourceforge.net,
	devel@lists.orangefs.org,
	linux-unionfs@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	reiserfs-devel@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	linux-trace-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-bcachefs@vger.kernel.org
Subject: [PATCH v2 87/89] fs: rename inode i_atime and i_mtime fields
Date: Wed,  4 Oct 2023 14:55:28 -0400
Message-ID: <20231004185530.82088-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename these two fields to discourage direct access (and to help ensure
that we mop up any leftover direct accesses).

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/fs.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3ca610d42176..84fdaf399fbe 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -671,8 +671,8 @@ struct inode {
 	};
 	dev_t			i_rdev;
 	loff_t			i_size;
-	struct timespec64	i_atime;
-	struct timespec64	i_mtime;
+	struct timespec64	__i_atime;
+	struct timespec64	__i_mtime;
 	struct timespec64	__i_ctime; /* use inode_*_ctime accessors! */
 	spinlock_t		i_lock;	/* i_blocks, i_bytes, maybe i_size */
 	unsigned short          i_bytes;
@@ -1517,23 +1517,23 @@ struct timespec64 inode_set_ctime_current(struct inode *inode);
 
 static inline time64_t inode_get_atime_sec(const struct inode *inode)
 {
-	return inode->i_atime.tv_sec;
+	return inode->__i_atime.tv_sec;
 }
 
 static inline long inode_get_atime_nsec(const struct inode *inode)
 {
-	return inode->i_atime.tv_nsec;
+	return inode->__i_atime.tv_nsec;
 }
 
 static inline struct timespec64 inode_get_atime(const struct inode *inode)
 {
-	return inode->i_atime;
+	return inode->__i_atime;
 }
 
 static inline struct timespec64 inode_set_atime_to_ts(struct inode *inode,
 						      struct timespec64 ts)
 {
-	inode->i_atime = ts;
+	inode->__i_atime = ts;
 	return ts;
 }
 
@@ -1547,23 +1547,23 @@ static inline struct timespec64 inode_set_atime(struct inode *inode,
 
 static inline time64_t inode_get_mtime_sec(const struct inode *inode)
 {
-	return inode->i_mtime.tv_sec;
+	return inode->__i_mtime.tv_sec;
 }
 
 static inline long inode_get_mtime_nsec(const struct inode *inode)
 {
-	return inode->i_mtime.tv_nsec;
+	return inode->__i_mtime.tv_nsec;
 }
 
 static inline struct timespec64 inode_get_mtime(const struct inode *inode)
 {
-	return inode->i_mtime;
+	return inode->__i_mtime;
 }
 
 static inline struct timespec64 inode_set_mtime_to_ts(struct inode *inode,
 						      struct timespec64 ts)
 {
-	inode->i_mtime = ts;
+	inode->__i_mtime = ts;
 	return ts;
 }
 
-- 
2.41.0


