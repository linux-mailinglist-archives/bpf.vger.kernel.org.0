Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5DC11C758
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2019 09:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbfLLIUb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Dec 2019 03:20:31 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:8749 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728455AbfLLITf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Dec 2019 03:19:35 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5df1f8030004>; Thu, 12 Dec 2019 00:19:15 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 12 Dec 2019 00:19:22 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 12 Dec 2019 00:19:22 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 12 Dec
 2019 08:19:19 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 12 Dec 2019 08:19:19 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5df1f8070002>; Thu, 12 Dec 2019 00:19:19 -0800
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Al Viro <viro@zeniv.linux.org.uk>,
        Alex Williamson <alex.williamson@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Chinner <david@fromorbit.com>,
        David Airlie <airlied@linux.ie>,
        "David S . Miller" <davem@davemloft.net>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Paul Mackerras" <paulus@samba.org>, Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, <bpf@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <kvm@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-media@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <netdev@vger.kernel.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Jason Gunthorpe" <jgg@mellanox.com>
Subject: [PATCH v10 07/25] vfio: fix FOLL_LONGTERM use, simplify get_user_pages_remote() call
Date:   Thu, 12 Dec 2019 00:18:59 -0800
Message-ID: <20191212081917.1264184-8-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191212081917.1264184-1-jhubbard@nvidia.com>
References: <20191212081917.1264184-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1576138756; bh=8L6xDPC0B530xp/MTT0aA3xB5v7i2RtCewyab6Z4Hgg=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=SGfib4ttfpgjz9/QYG3Euiqqp7zCZFVjOccbcQ1UEoA0DpAdwToGph7IiLdNdqTm0
         fFwndsgdD8HfqnAW/YSRyzZKqyVYY9OLSf0YWY6Wf1haqQOu5Ok3SOBUdVTTsAt+VD
         njM7ow/1hvV8bDUoZdjqFjRlmGrsyYvmJdanPn63HcPlbmDS3RYcUupMmzP8/VWHp4
         Nk9KaAzbWYwzC+PRuacSt+edyr9CZV4T57ntv3JRbNcSUpVFgNL6MYhrXYJuId9e4S
         wFevbV4HmZdaBlvhOVO8m5KzGCbDpDqwlApYljJZR0DBxpazPAbwRD8llmQnSWX3NQ
         2GJ5VLQemysuA==
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Update VFIO to take advantage of the recently loosened restriction on
FOLL_LONGTERM with get_user_pages_remote(). Also, now it is possible to
fix a bug: the VFIO caller is logically a FOLL_LONGTERM user, but it
wasn't setting FOLL_LONGTERM.

Also, remove an unnessary pair of calls that were releasing and
reacquiring the mmap_sem. There is no need to avoid holding mmap_sem
just in order to call page_to_pfn().

Also, now that the the DAX check ("if a VMA is DAX, don't allow long
term pinning") is in the internals of get_user_pages_remote() and
__gup_longterm_locked(), there's no need for it at the VFIO call site.
So remove it.

Tested-by: Alex Williamson <alex.williamson@redhat.com>
Acked-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Jerome Glisse <jglisse@redhat.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 drivers/vfio/vfio_iommu_type1.c | 30 +++++-------------------------
 1 file changed, 5 insertions(+), 25 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type=
1.c
index 2ada8e6cdb88..b800fc9a0251 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -322,7 +322,6 @@ static int vaddr_get_pfn(struct mm_struct *mm, unsigned=
 long vaddr,
 {
 	struct page *page[1];
 	struct vm_area_struct *vma;
-	struct vm_area_struct *vmas[1];
 	unsigned int flags =3D 0;
 	int ret;
=20
@@ -330,33 +329,14 @@ static int vaddr_get_pfn(struct mm_struct *mm, unsign=
ed long vaddr,
 		flags |=3D FOLL_WRITE;
=20
 	down_read(&mm->mmap_sem);
-	if (mm =3D=3D current->mm) {
-		ret =3D get_user_pages(vaddr, 1, flags | FOLL_LONGTERM, page,
-				     vmas);
-	} else {
-		ret =3D get_user_pages_remote(NULL, mm, vaddr, 1, flags, page,
-					    vmas, NULL);
-		/*
-		 * The lifetime of a vaddr_get_pfn() page pin is
-		 * userspace-controlled. In the fs-dax case this could
-		 * lead to indefinite stalls in filesystem operations.
-		 * Disallow attempts to pin fs-dax pages via this
-		 * interface.
-		 */
-		if (ret > 0 && vma_is_fsdax(vmas[0])) {
-			ret =3D -EOPNOTSUPP;
-			put_page(page[0]);
-		}
-	}
-	up_read(&mm->mmap_sem);
-
+	ret =3D get_user_pages_remote(NULL, mm, vaddr, 1, flags | FOLL_LONGTERM,
+				    page, NULL, NULL);
 	if (ret =3D=3D 1) {
 		*pfn =3D page_to_pfn(page[0]);
-		return 0;
+		ret =3D 0;
+		goto done;
 	}
=20
-	down_read(&mm->mmap_sem);
-
 	vaddr =3D untagged_addr(vaddr);
=20
 	vma =3D find_vma_intersection(mm, vaddr, vaddr + 1);
@@ -366,7 +346,7 @@ static int vaddr_get_pfn(struct mm_struct *mm, unsigned=
 long vaddr,
 		if (is_invalid_reserved_pfn(*pfn))
 			ret =3D 0;
 	}
-
+done:
 	up_read(&mm->mmap_sem);
 	return ret;
 }
--=20
2.24.0

