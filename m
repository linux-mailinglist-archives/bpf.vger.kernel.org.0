Return-Path: <bpf+bounces-71640-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB38BF9022
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 00:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D0EF24E71F3
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 22:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684D0295DBD;
	Tue, 21 Oct 2025 22:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WeST61dA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53D42236F3;
	Tue, 21 Oct 2025 22:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761084603; cv=none; b=W8Ar6wmRzH08QreYpYFQ33GmdB690qEuTnyNcqUmp+uqmipBVoX16WbwOS6C9FNXcntg8vD4+SgCzgxfT6CP7bGKPBFkK1JbfxfNCRMVxyJT22E1MbDQbpZvRW46INieiOJYd/Nj8Y0cRMH+2xpzJt+BSQErL3Lk6AL+nxmX16s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761084603; c=relaxed/simple;
	bh=+URgYQvZ4HjcIzOvck2EDQ4xX/BMJW9uygZG+SutCuQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GnjFZLzZDlcIT8j9QE4s2ZEWA5j/feBw1MT4itM5t8BpN6WVncj6gHSsSMs2hVQ0pMr79/2m0hPunQ89yc7IlSIEEY5aZuSfHQS6XLtxHzRUmCxN5aN+R2MGmP4D2dA2jI71r4mqQGOE19b1nEL8L7k7b+PezF8rldKro0wmfN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WeST61dA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5F307C4CEF1;
	Tue, 21 Oct 2025 22:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761084602;
	bh=+URgYQvZ4HjcIzOvck2EDQ4xX/BMJW9uygZG+SutCuQ=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=WeST61dA0RZf5VVMjHVCLHYTZG0h80qVAReCT+Y0QaIDM6wCZbbWUbvYIb9VUhkDG
	 2n2K7362Hkf+BOTtVf6Dz3KMVy5ov+yVrYQHrLA1C+Xh+uppfxACMSszfaOmIJqJXf
	 bNO0ZiNLlgO16zzgUIsQljURj5GreNzsaHE2QJi07Ci8D6i4nf0rWdaYNpwQPvLLyN
	 EYoIE0LJ/k3jQu9KnJYQz5MfbYqIz+TQ7YR/QetUFxuflRj8R793buVdyju4Tc/0BA
	 utozF/UfPX+q9kUG0Y7Mt2SU9yAFtLWjNyZhFFuvnhpWsL81jJjBylpWdTaGfaAzC0
	 AzBC8nl3faqmw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A7DCCD1AB;
	Tue, 21 Oct 2025 22:10:02 +0000 (UTC)
From: Dominique Martinet via B4 Relay <devnull+asmadeus.codewreck.org@kernel.org>
Date: Wed, 22 Oct 2025 07:09:57 +0900
Subject: [PATCH] fs/9p: don't use cached metadata in revalidate for
 cache=mmap
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-mmap-regression-v1-1-980365ee524e@codewreck.org>
X-B4-Tracking: v=1; b=H4sIALQE+GgC/x2MQQqAIBBFryKzTlCxFl0lWkiONgtNRohAvHvW8
 vHffw0qMmGFVTRgvKnSlQfoScBxuhxRkh8MRplZK2NkSq5IxshYP1cGFazyY7OLh/EqjIGev7j
 tvb8F6eibYQAAAA==
X-Change-ID: 20251022-mmap-regression-f0f40d51046d
To: Song Liu <song@kernel.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
 Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 Tingmao Wang <m@maowtm.org>, Alexei Starovoitov <ast@kernel.org>
Cc: linux-kernel@vger.kernel.org, v9fs@lists.linux.dev, bpf@vger.kernel.org, 
 Dominique Martinet <asmadeus@codewreck.org>
X-Mailer: b4 0.15-dev-7be4f
X-Developer-Signature: v=1; a=openpgp-sha256; l=3352;
 i=asmadeus@codewreck.org; h=from:subject:message-id;
 bh=8U+bVWiUxykgXibHegqG5mO5sNY1PawdwUE7RKEEVBk=;
 b=owEBbQKS/ZANAwAKAatOm+xqmOZwAcsmYgBo+AS5EQJpnOD9lVhx8INJrvPAzWuAa4BAmWa0L
 wUP5lB9mkeJAjMEAAEKAB0WIQT8g9txgG5a3TOhiE6rTpvsapjmcAUCaPgEuQAKCRCrTpvsapjm
 cGyND/9j8uDuBNg3l93/NCpqQWdWjeMkPuaYEIlTz00a0mCP54AnDbbaHQQHeWg/Z+WHhIFkTCN
 IoH/1Zl5ku/UEbg3wjx6EicDxlL0Ocav1HYdIG4Wd3TnkZLmJ15mB896XSh4VUxL2aqzhdf1vzl
 5TVDMGsrveXJX9s+gY08iFOtltpegOJ07J01tFeIUlOd1k5J/AnRIGd6gl5JRJCm6EtGLc/m81w
 xZG4Q3ByYjqySviFBo9KqGPLvdKbpeBYSdcHOb2OKoJCuTohGg2ALdksvfQhflPxwV93p4ky30a
 RXptszZVc3lDeLx+fATTWXAp6LFgkNwUsMBnP0FfBltXkko/qblVv0f5jfCdv4JwGK/2qCqT/mA
 lihhGkrkyJ38ttDGU1Uw9ZLix80UhXmhCONL08aqr0CjY5z2i/unSwJEvBlJfjnFaVJ+bD0kbX1
 dnrtdCLrjTv9K9iT9dFwdNZjIl5wKP+zr7CZeGvlRFQLsNgSG/GDIdd6BaRgZXZK9T6PY4mihZj
 GHY4PGt+o+DfWKEi/XLuxcGgjNlXan8UBnH9W7MIqqeUvNKQIcZxpnulseHktuTFInBElzUiGZl
 TptoO9SWgR4TaDpEaRvtaxulhg8tijguOub3t5G5TB8pJWRkhRrKVpc/PD5PHaXMZaom+bBbOqz
 qTFMDNOj8T92FvA==
X-Developer-Key: i=asmadeus@codewreck.org; a=openpgp;
 fpr=B894379F662089525B3FB1B9333F1F391BBBB00A
X-Endpoint-Received: by B4 Relay for asmadeus@codewreck.org/default with
 auth_id=435
X-Original-From: Dominique Martinet <asmadeus@codewreck.org>
Reply-To: asmadeus@codewreck.org

From: Dominique Martinet <asmadeus@codewreck.org>

cache=mmap is a mode that doesn't cache metadata, but still has
writeback cache.
In commit 290434474c33 ("fs/9p: Refresh metadata in d_revalidate
for uncached mode too") we considered metadata cache to be enough to
not look at the server, but in writeback cache too looking at the server
size would make the vfs consider the file has been truncated before the
data has been flushed out, making the following repro fail (nothing is
ever read back, the resulting file ends up with no data written)

---
I was suspecting cache=mmap when I saw vmtest used that, and it's
confirmed with Song's reproducer...
This makes the repro work, would one of you be able to confirm this?
Once confirmed I'll send this to Linus directly

Thanks again and sorry for lack of cache=mmap tests :/

Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

char buf[4096];

int main(int argc, char *argv[])
{
        int ret, i;
        int fdw, fdr;

        if (argc < 2)
                return 1;

        fdw = openat(AT_FDCWD, argv[1], O_RDWR|O_CREAT|O_EXCL|O_CLOEXEC, 0600);
        if (fdw < 0) {
                fprintf(stderr, "cannot open fdw\n");
                return 1;
        }
        write(fdw, buf, sizeof(buf));

        fdr = openat(AT_FDCWD, argv[1], O_RDONLY|O_CLOEXEC);

        if (fdr < 0) {
                fprintf(stderr, "cannot open fdr\n");
                close(fdw);
                return 1;
        }

        for (i = 0; i < 10; i++) {
                ret = read(fdr, buf, sizeof(buf));
                fprintf(stderr, "i: %d, read returns %d\n", i, ret);
        }

        close(fdr);
        close(fdw);
        return 0;
}
---

Reported-by: Song Liu <song@kernel.org>
Link: https://lkml.kernel.org/r/CAHzjS_u_SYdt5=2gYO_dxzMKXzGMt-TfdE_ueowg-Hq5tRCAiw@mail.gmail.com
Reported-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Link: https://lore.kernel.org/bpf/CAEf4BzZbCE4tLoDZyUf_aASpgAGFj75QMfSXX4a4dLYixnOiLg@mail.gmail.com/
Fixes: 290434474c33 ("fs/9p: Refresh metadata in d_revalidate for uncached mode too")
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
 fs/9p/vfs_dentry.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/9p/vfs_dentry.c b/fs/9p/vfs_dentry.c
index f3248a3e54023489054337bf98e87a1d7b1fbafc..2f3654bf6275ffa802dc25b9a84bd61a62d5723c 100644
--- a/fs/9p/vfs_dentry.c
+++ b/fs/9p/vfs_dentry.c
@@ -78,7 +78,11 @@ static int __v9fs_lookup_revalidate(struct dentry *dentry, unsigned int flags)
 	v9inode = V9FS_I(inode);
 	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(inode);
 
-	cached = v9ses->cache & (CACHE_META | CACHE_LOOSE);
+	/* We also don't want to refresh attr here in writeback cache mode,
+	 * otherwise a write that hasn't been propagated to server would
+	 * incorrectly get the old size back and truncate the file before
+	 * the write happens */
+	cached = v9ses->cache & (CACHE_META | CACHE_WRITEBACK | CACHE_LOOSE);
 
 	if (!cached || v9inode->cache_validity & V9FS_INO_INVALID_ATTR) {
 		int retval;

---
base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
change-id: 20251022-mmap-regression-f0f40d51046d

Best regards,
-- 
Dominique Martinet <asmadeus@codewreck.org>



