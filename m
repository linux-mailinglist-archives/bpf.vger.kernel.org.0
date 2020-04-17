Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F32B1AD46A
	for <lists+bpf@lfdr.de>; Fri, 17 Apr 2020 04:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729245AbgDQCYI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Apr 2020 22:24:08 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:57315 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728969AbgDQCYI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 16 Apr 2020 22:24:08 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 6D7DA580694;
        Thu, 16 Apr 2020 22:24:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 16 Apr 2020 22:24:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=j7uOIyaUtmiDGZuoZsMKodKEmp
        ZENeznYoKSaWM7KV4=; b=TvZlMGGPaOwNxFqDjQZxdcB1aD0edPmGgyl/ExjWA1
        y/qjuQkOgisNTmceRAHFTAAT1oR4KUzFEeXxS3ruC73EUvIoUJo3GqhsrxCT96Xd
        WCug7l1pP+ik3asPlhjoH8LoadiDqWN62uofO1GOwhxLXlR9OXG+iVEK3pvAbYbD
        8253gcD07HpqE0dXxlFOz/dvzXxaN6BpWL+AXr4n+oBjqKiNBX6awgZCaFCEaxLr
        0AGlhOzvtGvDyM4/zDwiK05y9GOb8Hw/r1zjU3p8DC39t8nlXwUTEvGd7f+xghX0
        8Vn6wk10LbSgKONbb059E56j8KIffJb0xxRf51wGCeZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=j7uOIyaUtmiDGZuoZ
        sMKodKEmpZENeznYoKSaWM7KV4=; b=zHF9nk9eDpE87PX2SKNi3k8wIA4e9B3Qw
        /OoCaARQgit1hqD+ZPcu57PncOEfu9laOu4/W5dSVrkEbt333NZ+MGW5PWWjGgod
        d5OM3FHRH1g9Etxf2uzEnrnGMQzjfo/AoDKJXY2gs6YVgumAFyjxabZpQhG/mQoR
        xa1fyfeN0UO4wduQQjyuluV+Dta95AvEXFOSEtL61qcJ+Zqd/j+ZHj6/G2k09y4z
        bEmosQ7Eh2lRaWP70H8BVkrKSocn/QZzn4RqLdxN4M5SuaqtRRJqyR2CshIa2RNQ
        UDmL1y33Mth6I9ub926nqKPudndKDRMO7DxtVc6PxrazlQw7gCNzg==
X-ME-Sender: <xms:RhOZXg8tJhOKdij9k98UR7hz1eVU9F3BKEJfdq74WxUz1YcR4AQltQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrfeeigdehkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecuogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenfg
    hrlhcuvffnffculddujedmnegovehorghsthgrlhdqhfeguddvqddtvdculdduhedtmden
    ucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhivghluc
    giuhcuoegugihusegugihuuhhurdighiiiqeenucffohhmrghinhepghhithhhuhgsrdgt
    ohhmpdhsphhinhhitghsrdhnvghtpdhgihhthhhusgdrihhonecukfhppeduieefrdduud
    egrddufedvrdegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:RhOZXq9V1fwbcIbqLP_uhFilsRpCkoMiPlx4YP_Me8X4Jrf9zl29pg>
    <xmx:RhOZXmHUYy8ky2NiIxcTs41Le0wwGh4h-9QXzOcB7uj1Xq7IE0uZ6g>
    <xmx:RhOZXpaZbfIId1Wfg66FMmj0z5QUqnqKUOLL4V04RN56nNY9GH5YEQ>
    <xmx:RhOZXtTzL2Y8-vV5boYpY1mmIBk8eXhLW4z5H4SqbzR0a5m1-qKQ6w>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (unknown [163.114.132.4])
        by mail.messagingengine.com (Postfix) with ESMTPA id A0F76306008B;
        Thu, 16 Apr 2020 22:24:04 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Xu <dxu@dxuuu.xyz>, bpf@vger.kernel.org, kernel-team@fb.com,
        jolsa@kernel.org, brendan.d.gregg@gmail.com,
        andrii.nakryiko@gmail.com, ast@kernel.org
Subject: [RFC] uapi: Convert stat.h #define flags to enums
Date:   Thu, 16 Apr 2020 19:23:15 -0700
Message-Id: <20200417022315.1931959-1-dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF Type Format (BTF) is especially powerful for tracing tools like
bcc and bpftrace. It allows tools to know about kernel data structures
and layouts without having to parse headers. Headers are problematic
because (1) they do not always come installed on production / user
systems, (2) headers may not always describe the correct struct layout
due to compile time flags, and (3) can be tricky to parse [0][1].

As BTF becomes enabled on more systems [2], it becomes more desirable to
have BTF contain everything a tracing tool needs. BTF overhead is quite
minimal (~1.5MB) [3] so using BTF in lieu of parsing headers is very
attractive.

While BTF already contains almost everything tracing tools need (eg
structs, enums, unions, function signatures, etc.), it is missing a lot
of flags. The reason is that most flags are defined as preprocessor
macros and are thus invisible to the compiler when it generates debug
info.

However, there is a solution: we can convert macro flags into enums.
This would be quite a complicated and long running task so I'm hoping
this patch can start a discussion. I'm sure I haven't fully considered
the implications so hopefully we can discuss it.

This patch, when applied to a kernel with BTF, allows bpftrace to "see"
the flags [4]:

    # bpftrace --btf -e 'BEGIN { printf("%d\n", S_IRWXG); }'
    Attaching 1 probe...
    56
    ^C

[0]: https://github.com/iovisor/bcc/pull/2133
[1]: https://github.com/iovisor/bcc/pull/2547
[2]: https://www.spinics.net/linux/fedora/fedora-kernel/msg07746.html
[3]: https://facebookmicrosites.github.io/bpf/blog/2018/11/14/btf-enhancement.html
[4]: https://github.com/iovisor/bpftrace/pull/1274

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 include/uapi/linux/stat.h | 99 +++++++++++++++++++++------------------
 1 file changed, 53 insertions(+), 46 deletions(-)

diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
index ad80a5c885d5..658446fc5a20 100644
--- a/include/uapi/linux/stat.h
+++ b/include/uapi/linux/stat.h
@@ -6,17 +6,19 @@
 
 #if defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2)
 
-#define S_IFMT  00170000
-#define S_IFSOCK 0140000
-#define S_IFLNK	 0120000
-#define S_IFREG  0100000
-#define S_IFBLK  0060000
-#define S_IFDIR  0040000
-#define S_IFCHR  0020000
-#define S_IFIFO  0010000
-#define S_ISUID  0004000
-#define S_ISGID  0002000
-#define S_ISVTX  0001000
+enum {
+	S_IFMT    = 00170000,
+	S_IFSOCK  = 0140000,
+	S_IFLNK	  = 0120000,
+	S_IFREG   = 0100000,
+	S_IFBLK   = 0060000,
+	S_IFDIR   = 0040000,
+	S_IFCHR   = 0020000,
+	S_IFIFO   = 0010000,
+	S_ISUID   = 0004000,
+	S_ISGID   = 0002000,
+	S_ISVTX   = 0001000,
+};
 
 #define S_ISLNK(m)	(((m) & S_IFMT) == S_IFLNK)
 #define S_ISREG(m)	(((m) & S_IFMT) == S_IFREG)
@@ -26,20 +28,22 @@
 #define S_ISFIFO(m)	(((m) & S_IFMT) == S_IFIFO)
 #define S_ISSOCK(m)	(((m) & S_IFMT) == S_IFSOCK)
 
-#define S_IRWXU 00700
-#define S_IRUSR 00400
-#define S_IWUSR 00200
-#define S_IXUSR 00100
+enum {
+	S_IRWXU   = 00700,
+	S_IRUSR   = 00400,
+	S_IWUSR   = 00200,
+	S_IXUSR   = 00100,
 
-#define S_IRWXG 00070
-#define S_IRGRP 00040
-#define S_IWGRP 00020
-#define S_IXGRP 00010
+	S_IRWXG   = 00070,
+	S_IRGRP   = 00040,
+	S_IWGRP   = 00020,
+	S_IXGRP   = 00010,
 
-#define S_IRWXO 00007
-#define S_IROTH 00004
-#define S_IWOTH 00002
-#define S_IXOTH 00001
+	S_IRWXO   = 00007,
+	S_IROTH   = 00004,
+	S_IWOTH   = 00002,
+	S_IXOTH   = 00001,
+};
 
 #endif
 
@@ -135,21 +139,23 @@ struct statx {
  * These bits should be set in the mask argument of statx() to request
  * particular items when calling statx().
  */
-#define STATX_TYPE		0x00000001U	/* Want/got stx_mode & S_IFMT */
-#define STATX_MODE		0x00000002U	/* Want/got stx_mode & ~S_IFMT */
-#define STATX_NLINK		0x00000004U	/* Want/got stx_nlink */
-#define STATX_UID		0x00000008U	/* Want/got stx_uid */
-#define STATX_GID		0x00000010U	/* Want/got stx_gid */
-#define STATX_ATIME		0x00000020U	/* Want/got stx_atime */
-#define STATX_MTIME		0x00000040U	/* Want/got stx_mtime */
-#define STATX_CTIME		0x00000080U	/* Want/got stx_ctime */
-#define STATX_INO		0x00000100U	/* Want/got stx_ino */
-#define STATX_SIZE		0x00000200U	/* Want/got stx_size */
-#define STATX_BLOCKS		0x00000400U	/* Want/got stx_blocks */
-#define STATX_BASIC_STATS	0x000007ffU	/* The stuff in the normal stat struct */
-#define STATX_BTIME		0x00000800U	/* Want/got stx_btime */
-#define STATX_ALL		0x00000fffU	/* All currently supported flags */
-#define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
+enum {
+	STATX_TYPE		= 0x00000001U,	/* Want/got stx_mode & S_IFMT */
+	STATX_MODE		= 0x00000002U,	/* Want/got stx_mode & ~S_IFMT */
+	STATX_NLINK		= 0x00000004U,	/* Want/got stx_nlink */
+	STATX_UID		= 0x00000008U,	/* Want/got stx_uid */
+	STATX_GID		= 0x00000010U,	/* Want/got stx_gid */
+	STATX_ATIME		= 0x00000020U,	/* Want/got stx_atime */
+	STATX_MTIME		= 0x00000040U,	/* Want/got stx_mtime */
+	STATX_CTIME		= 0x00000080U,	/* Want/got stx_ctime */
+	STATX_INO		= 0x00000100U,	/* Want/got stx_ino */
+	STATX_SIZE		= 0x00000200U,	/* Want/got stx_size */
+	STATX_BLOCKS		= 0x00000400U,	/* Want/got stx_blocks */
+	STATX_BASIC_STATS	= 0x000007ffU,	/* The stuff in the normal stat struct */
+	STATX_BTIME		= 0x00000800U,	/* Want/got stx_btime */
+	STATX_ALL		= 0x00000fffU,	/* All currently supported flags */
+	STATX__RESERVED		= 0x80000000U,	/* Reserved for future struct statx expansion */
+};
 
 /*
  * Attributes to be found in stx_attributes and masked in stx_attributes_mask.
@@ -162,13 +168,14 @@ struct statx {
  * semantically.  Where possible, the numerical value is picked to correspond
  * also.
  */
-#define STATX_ATTR_COMPRESSED		0x00000004 /* [I] File is compressed by the fs */
-#define STATX_ATTR_IMMUTABLE		0x00000010 /* [I] File is marked immutable */
-#define STATX_ATTR_APPEND		0x00000020 /* [I] File is append-only */
-#define STATX_ATTR_NODUMP		0x00000040 /* [I] File is not to be dumped */
-#define STATX_ATTR_ENCRYPTED		0x00000800 /* [I] File requires key to decrypt in fs */
-#define STATX_ATTR_AUTOMOUNT		0x00001000 /* Dir: Automount trigger */
-#define STATX_ATTR_VERITY		0x00100000 /* [I] Verity protected file */
-
+enum {
+	STATX_ATTR_COMPRESSED		= 0x00000004, /* [I] File is compressed by the fs */
+	STATX_ATTR_IMMUTABLE		= 0x00000010, /* [I] File is marked immutable */
+	STATX_ATTR_APPEND		= 0x00000020, /* [I] File is append-only */
+	STATX_ATTR_NODUMP		= 0x00000040, /* [I] File is not to be dumped */
+	STATX_ATTR_ENCRYPTED		= 0x00000800, /* [I] File requires key to decrypt in fs */
+	STATX_ATTR_AUTOMOUNT		= 0x00001000, /* Dir: Automount trigger */
+	STATX_ATTR_VERITY		= 0x00100000, /* [I] Verity protected file */
+};
 
 #endif /* _UAPI_LINUX_STAT_H */
-- 
2.25.2

