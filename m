Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B405F62CBEE
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 22:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238402AbiKPVCy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Nov 2022 16:02:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239203AbiKPVCE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Nov 2022 16:02:04 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2087.outbound.protection.outlook.com [40.107.96.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0DF6A760;
        Wed, 16 Nov 2022 13:01:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BnFCUl2+ZZBjKhp8Yw/sA0RMyGSaQjI5cDg5ZyQHNA2Fb7wgGh5Ll3qMBPSSyR/TM+BUzP3T0P+ddIJ2p7DvvXQGXuvzOkE6q7u/BritceK22PEUpRfPIHPwEXzkbVboONgKHucJMxF/QDmUWXhqASI/d7FQFEjaLKJJCNzyVGWQEv/G935eVh7hCHwGx7cPtIdUYOcUS9M6wdBdbdcxiPEUcONxH0PtVU9z9nk3skBZH5vynrRNTV9Sd55pxON+YV6Eib1MlSJTFfWzLfAn/yXyOtKnu+eHleYNsC2Ir2zDWTtW2u2QD+R10cXqZixxIYFQUXoA7NcnUB3ujv7x+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=emokUZn2xeZIKdZ2/PrLDO3v0ATjKYJdHX3XwiIUri0=;
 b=EMHyImSGarjeqMBemKm/e2hHWvZWE4oesQj7ImyoLHeiVN81pQgb731HFWk3QFO5SveHnzNuTLhnrFHnaygja3CPphWtrXySrp8ZNDTLI75vUMoLScy29HRoxzANM+GgYiMRtTpYEdTAxYtCrpLRjOOkQlxqdOrPy0LxQd7j0ZlXkNt1SmerhvDSnj92yWIMOlYnv+QEqpXcRgw3vvIqO1aDmCei28pJBvrfsEFCnBJCm8wkJlbyRDa6YnlxKe3NHSN2w6uZsr1vK/0L1bCsD6QhdIf4oYWJp2UjJ5qIPXciqCX0LLqNEuLpj7pdyhx340MVqqvip1ST8UULVmNsfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emokUZn2xeZIKdZ2/PrLDO3v0ATjKYJdHX3XwiIUri0=;
 b=nU7KPLNwwcg5dES/poLF+4j5MnGbWKcEL0Taq2zDkEiG+gcQsa6OBBhk5UGwyCNY4hOmSPefmLDCvxx9Qsqv01JONojmEluwki7XEn1YmYWqelVysRlDSTcGQznXvDzF08M7pI74EuIDr21sLuRVqxiv7eBXZc/lkLXmdANkiHhYvCsi9zCjnx8sUT5ucAMZDPiZOMJNI/U6oCBu2bE8ttjg0iuGkafwnd82jvjrelR4xU89bs+Qv3Vjt2TJx5plL1nkOD4K2DMV9ACqLKlYbAEmXrGh0elrVJvurBzAWwV7ENQUKca8U2i6nJZxgTvWjcrHdQ2mHy1KW45b/h8SQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB7136.namprd12.prod.outlook.com (2603:10b6:510:22b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Wed, 16 Nov
 2022 21:01:03 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 21:01:03 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     bpf@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Anthony Krowiak <akrowiak@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jason Herne <jjherne@linux.ibm.com>,
        Joao Martins <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
Subject: [PATCH v5 10/19] iommufd: Data structure to provide IOVA to PFN mapping
Date:   Wed, 16 Nov 2022 17:00:46 -0400
Message-Id: <10-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
In-Reply-To: <0-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0017.namprd19.prod.outlook.com
 (2603:10b6:208:178::30) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB7136:EE_
X-MS-Office365-Filtering-Correlation-Id: fa97010a-39c1-4d7a-c79f-08dac815a912
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l7AI43JDZurarQjia1tSyo643UitIAKb/ji7Wgr87QhEbTk0iCMVqTTPS8BUQQHfyUzNVuDfGMoYp6a5+D++VPy+wWy+fuwA7SlbcYetD5/FUw4KKk/ZV9uJ9kA89ZgOze02eIwLC7SuORYdwtJoiU/SLoo8G7q3v3WV7EkgaUe0/KiOB0Ycm43dQUdXTeRXWnInEowTrdCbvNmc9Rk5u1KkdI9LDzRktkNmLVfhO3i1bQU+EB2KtVGnxknADCeJn5Ubf2PUFDVqChCUZXf6WYdBMpJ3cbDFgyJ1CZxzXaMpQUd0u3uIIxPUrmhHF8kRdpfBwZvlO0CgIw1kMDaeddnKn6PFLIjMhqqd8VfPaZlJ31VVw0l9qRiXsfL1s3YWIlxv6yakGtfgHF3nSesq0HSZ0kmYAs0M62EPKBmDuik+IDoGJM9dURJEYORl7JE3kINH55du8da3dsvduB2CG3BwgpzcLE//mlgbvz2dPCJuQnSivrdmFNAMorni3LkxkU2tJGi6/LbYbwRe8pyprWFf875BY4laGZXEdpXEb6u2MKa2SKcrmt+lRPtC6jCrWeM5qKh2iqkD2rERtXxBIOBt9o2ih+PKS7lIA5CmLIAD6BcAuXAOuDJExCrftzHxmohviDDsdFmxqWKK3MGFaYM+9MTVXnAqkAnnHNBW4nqBeaRS3Xivt1l3BiGxAp/D2UmnShbMjYqR+OHZShXZQFv6m+yqgJ0zQWguuLc31n74uYO2xsvKhJ3YeZnAogcd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(451199015)(36756003)(41300700001)(4326008)(8676002)(66556008)(6486002)(186003)(66476007)(86362001)(66946007)(2616005)(478600001)(26005)(316002)(6666004)(110136005)(54906003)(6506007)(921005)(6512007)(83380400001)(66899015)(2906002)(30864003)(7406005)(7416002)(8936002)(5660300002)(38100700002)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ji7VtRQs3XVbQ+Qpr+ljYZA97cdkZ/vJKyd4lA/bBWCvd55/v5tFneGZdaDv?=
 =?us-ascii?Q?0D7lCYkw9dYRFAVWlg+kv7noBHve/SGViMLsbczlfBVAeb/XHhZGhqQEywDR?=
 =?us-ascii?Q?ryqocbPyDZb5MTm9IkXoQdLzo6hq0zNwTmp3z/TSBrhqsLTHVzxLhxwv+0JC?=
 =?us-ascii?Q?qci8gPzhWJt/Eum2njPd/VM+GRFnyzSUO2IFHTVDOzj1cw/5LXOkGYaSeLOU?=
 =?us-ascii?Q?pArk8bXoP7cuTnBMa10O2rL/QKj+2wo8lJQ93R2cwJQwRUkL0BQVZ4bYnHZT?=
 =?us-ascii?Q?XALPq5pmvW+4Xq3pZuP2PjAbmtfMlWzhapBMhlcslBYKpzITqOhLYDoiswO2?=
 =?us-ascii?Q?3yeVpPpsCrn5KsQXlrmNU4N/dZ/5fnkrLqIDP3f3X9YLyZ2Rw6RIPNsaSNkm?=
 =?us-ascii?Q?lbUuPzxs1b4mCy+1S0hhwOetpnijZvoZEjC6mkb0znocxk5BYIpcRkXD1VDB?=
 =?us-ascii?Q?eRCyEO3j/gR8w7WcS3DFIxhdp/uUjLRK7W9IX2LvSf0Vy5A7VWYOrL1bxFfz?=
 =?us-ascii?Q?K0irQm7igSB8+6164Dsjr5hkiBvqscPLZt8z2D3msOt9S08KIErfdfff/QKz?=
 =?us-ascii?Q?u0N7O8dq4jgrhSNYjMV3eejGVIDLgMNPC87WiqqOQ6V9u/EHn5/yFuO+O+Sy?=
 =?us-ascii?Q?6bmySsrGG/K8ICD32ihQrmabAGZGdqBzsMMjjxPswDD+7rxNSFGhcIFICNMg?=
 =?us-ascii?Q?QM+AXX55qLc7C1B10CyIAdM8VQL3qDiCjIO2COiNwVz8HkaW0CZmdTv+1eS3?=
 =?us-ascii?Q?gQV+azacgeOqrfvGxk9r2Y7N5JYKArz9FNcgPAqZry2vS6aYpFcf6JadH47V?=
 =?us-ascii?Q?4fXJDIEEmfI+Sj8yQ19yY82xhtI3S34/lhgC/52phtORAdal5BETV+yPONJv?=
 =?us-ascii?Q?c4Df9sjH2w8eGQiCaRZ3ByZMKkPv2P5/h01ZoWto6dBBUMB8g3FmZ9go6sv0?=
 =?us-ascii?Q?KLI0qOZ8OsnzFyOA7jOwl7fi5csrTJhvqAfEKrNb1PQYnAhlBKcjfP+oaiD4?=
 =?us-ascii?Q?R+pb5+7kVVfwNZh79Ss5+dGlitaBmisoIMcPxhxmmfmS5BYHZi6xCZUmm9jR?=
 =?us-ascii?Q?xDFHfMFXx3VLZoKkVEw8gbCyMVATYj3dKzVNzydTxSo/lIZ1tlmMxVD8+C2u?=
 =?us-ascii?Q?yufKE8LyK5+1toR9LUWEbZIokp0vo29GWsC+00PIhZbNlldCMOXR4L60v55g?=
 =?us-ascii?Q?a+TClx4+1OtIYIlecWKxqfHvlmwOHaAZ+I4vApzc42JYe62DrhnHfzR1Y+mF?=
 =?us-ascii?Q?UAV21+vFhBoh9s21Wy3GuVAgbjIemOLGD7BvDPe1IDpprhEAbrzM31WSO2o8?=
 =?us-ascii?Q?YSf/p98mlReE62xkFk0b93YGAJgovX8z1xhDoXoD9X3TbjCAhMQ70y8QxYuG?=
 =?us-ascii?Q?Gh/gMJ1Al9ROYrzOlcBYb4Z+aQDb2EDEi4dlme96WcVqObPmRQZ1VVgNiG4g?=
 =?us-ascii?Q?itWwyC+eGFDeWrYZld3QsprHy1ZnffLNYyFMpamKVyIaqgad6esM8aaagWLH?=
 =?us-ascii?Q?1F7Wi100cMG6czdljcR2VgcvFzFKF5GPagfm98wmv/+ya2dONrvYrmW2mKy+?=
 =?us-ascii?Q?82Ttcrj7+LkrNCR6wp8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa97010a-39c1-4d7a-c79f-08dac815a912
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 21:00:58.7003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3KlgnU6n5z04jDmmpqpJfYDHkCDzU05ljq6a4dwGAiM+jviLNBoKl0tMFY7iyx/i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7136
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is the remainder of the IOAS data structure. Provide an object called
an io_pagetable that is composed of iopt_areas pointing at iopt_pages,
along with a list of iommu_domains that mirror the IOVA to PFN map.

At the top this is a simple interval tree of iopt_areas indicating the map
of IOVA to iopt_pages. An xarray keeps track of a list of domains. Based
on the attached domains there is a minimum alignment for areas (which may
be smaller than PAGE_SIZE), an interval tree of reserved IOVA that can't
be mapped and an IOVA of allowed IOVA that can always be mappable.

The concept of an 'access' refers to something like a VFIO mdev that is
accessing the IOVA and using a 'struct page *' for CPU based access.

Externally an API is provided that matches the requirements of the IOCTL
interface for map/unmap and domain attachment.

The API provides a 'copy' primitive to establish a new IOVA map in a
different IOAS from an existing mapping by re-using the iopt_pages. This
is the basic mechanism to provide single pinning.

This is designed to support a pre-registration flow where userspace would
setup an dummy IOAS with no domains, map in memory and then establish an
access to pin all PFNs into the xarray.

Copy can then be used to create new IOVA mappings in a different IOAS,
with iommu_domains attached. Upon copy the PFNs will be read out of the
xarray and mapped into the iommu_domains, avoiding any pin_user_pages()
overheads.

Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Yi Liu <yi.l.liu@intel.com>
Tested-by: Lixiao Yang <lixiao.yang@intel.com>
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 .clang-format                           |    1 +
 drivers/iommu/iommufd/Makefile          |    1 +
 drivers/iommu/iommufd/io_pagetable.c    | 1186 +++++++++++++++++++++++
 drivers/iommu/iommufd/io_pagetable.h    |   55 ++
 drivers/iommu/iommufd/iommufd_private.h |   52 +
 5 files changed, 1295 insertions(+)
 create mode 100644 drivers/iommu/iommufd/io_pagetable.c

diff --git a/.clang-format b/.clang-format
index 501241f8977664..78aba4a10b1bbc 100644
--- a/.clang-format
+++ b/.clang-format
@@ -444,6 +444,7 @@ ForEachMacros:
   - 'interval_tree_for_each_span'
   - 'intlist__for_each_entry'
   - 'intlist__for_each_entry_safe'
+  - 'iopt_for_each_contig_area'
   - 'kcore_copy__for_each_phdr'
   - 'key_for_each'
   - 'key_for_each_safe'
diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
index 05a0e91e30afad..b66a8c47ff55ec 100644
--- a/drivers/iommu/iommufd/Makefile
+++ b/drivers/iommu/iommufd/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 iommufd-y := \
+	io_pagetable.o \
 	main.o \
 	pages.o
 
diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
new file mode 100644
index 00000000000000..756d347948f0ec
--- /dev/null
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -0,0 +1,1186 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES.
+ *
+ * The io_pagetable is the top of datastructure that maps IOVA's to PFNs. The
+ * PFNs can be placed into an iommu_domain, or returned to the caller as a page
+ * list for access by an in-kernel user.
+ *
+ * The datastructure uses the iopt_pages to optimize the storage of the PFNs
+ * between the domains and xarray.
+ */
+#include <linux/iommufd.h>
+#include <linux/lockdep.h>
+#include <linux/iommu.h>
+#include <linux/sched/mm.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/errno.h>
+
+#include "io_pagetable.h"
+#include "double_span.h"
+
+struct iopt_pages_list {
+	struct iopt_pages *pages;
+	struct iopt_area *area;
+	struct list_head next;
+	unsigned long start_byte;
+	unsigned long length;
+};
+
+struct iopt_area *iopt_area_contig_init(struct iopt_area_contig_iter *iter,
+					struct io_pagetable *iopt,
+					unsigned long iova,
+					unsigned long last_iova)
+{
+	lockdep_assert_held(&iopt->iova_rwsem);
+
+	iter->cur_iova = iova;
+	iter->last_iova = last_iova;
+	iter->area = iopt_area_iter_first(iopt, iova, iova);
+	if (!iter->area)
+		return NULL;
+	if (!iter->area->pages) {
+		iter->area = NULL;
+		return NULL;
+	}
+	return iter->area;
+}
+
+struct iopt_area *iopt_area_contig_next(struct iopt_area_contig_iter *iter)
+{
+	unsigned long last_iova;
+
+	if (!iter->area)
+		return NULL;
+	last_iova = iopt_area_last_iova(iter->area);
+	if (iter->last_iova <= last_iova)
+		return NULL;
+
+	iter->cur_iova = last_iova + 1;
+	iter->area = iopt_area_iter_next(iter->area, iter->cur_iova,
+					 iter->last_iova);
+	if (!iter->area)
+		return NULL;
+	if (iter->cur_iova != iopt_area_iova(iter->area) ||
+	    !iter->area->pages) {
+		iter->area = NULL;
+		return NULL;
+	}
+	return iter->area;
+}
+
+static bool __alloc_iova_check_hole(struct interval_tree_double_span_iter *span,
+				    unsigned long length,
+				    unsigned long iova_alignment,
+				    unsigned long page_offset)
+{
+	if (span->is_used || span->last_hole - span->start_hole < length - 1)
+		return false;
+
+	span->start_hole = ALIGN(span->start_hole, iova_alignment) |
+			   page_offset;
+	if (span->start_hole > span->last_hole ||
+	    span->last_hole - span->start_hole < length - 1)
+		return false;
+	return true;
+}
+
+static bool __alloc_iova_check_used(struct interval_tree_span_iter *span,
+				    unsigned long length,
+				    unsigned long iova_alignment,
+				    unsigned long page_offset)
+{
+	if (span->is_hole || span->last_used - span->start_used < length - 1)
+		return false;
+
+	span->start_used = ALIGN(span->start_used, iova_alignment) |
+			   page_offset;
+	if (span->start_used > span->last_used ||
+	    span->last_used - span->start_used < length - 1)
+		return false;
+	return true;
+}
+
+/*
+ * Automatically find a block of IOVA that is not being used and not reserved.
+ * Does not return a 0 IOVA even if it is valid.
+ */
+static int iopt_alloc_iova(struct io_pagetable *iopt, unsigned long *iova,
+			   unsigned long uptr, unsigned long length)
+{
+	unsigned long page_offset = uptr % PAGE_SIZE;
+	struct interval_tree_double_span_iter used_span;
+	struct interval_tree_span_iter allowed_span;
+	unsigned long iova_alignment;
+
+	lockdep_assert_held(&iopt->iova_rwsem);
+
+	/* Protect roundup_pow-of_two() from overflow */
+	if (length == 0 || length >= ULONG_MAX / 2)
+		return -EOVERFLOW;
+
+	/*
+	 * Keep alignment present in the uptr when building the IOVA, this
+	 * increases the chance we can map a THP.
+	 */
+	if (!uptr)
+		iova_alignment = roundup_pow_of_two(length);
+	else
+		iova_alignment = min_t(unsigned long,
+				       roundup_pow_of_two(length),
+				       1UL << __ffs64(uptr));
+
+	if (iova_alignment < iopt->iova_alignment)
+		return -EINVAL;
+
+	interval_tree_for_each_span(&allowed_span, &iopt->allowed_itree,
+				    PAGE_SIZE, ULONG_MAX - PAGE_SIZE) {
+		if (RB_EMPTY_ROOT(&iopt->allowed_itree.rb_root)) {
+			allowed_span.start_used = PAGE_SIZE;
+			allowed_span.last_used = ULONG_MAX - PAGE_SIZE;
+			allowed_span.is_hole = false;
+		}
+
+		if (!__alloc_iova_check_used(&allowed_span, length,
+					     iova_alignment, page_offset))
+			continue;
+
+		interval_tree_for_each_double_span(
+			&used_span, &iopt->reserved_itree, &iopt->area_itree,
+			allowed_span.start_used, allowed_span.last_used) {
+			if (!__alloc_iova_check_hole(&used_span, length,
+						     iova_alignment,
+						     page_offset))
+				continue;
+
+			*iova = used_span.start_hole;
+			return 0;
+		}
+	}
+	return -ENOSPC;
+}
+
+static int iopt_check_iova(struct io_pagetable *iopt, unsigned long iova,
+			   unsigned long length)
+{
+	unsigned long last;
+
+	lockdep_assert_held(&iopt->iova_rwsem);
+
+	if ((iova & (iopt->iova_alignment - 1)))
+		return -EINVAL;
+
+	if (check_add_overflow(iova, length - 1, &last))
+		return -EOVERFLOW;
+
+	/* No reserved IOVA intersects the range */
+	if (iopt_reserved_iter_first(iopt, iova, last))
+		return -EINVAL;
+
+	/* Check that there is not already a mapping in the range */
+	if (iopt_area_iter_first(iopt, iova, last))
+		return -EEXIST;
+	return 0;
+}
+
+/*
+ * The area takes a slice of the pages from start_bytes to start_byte + length
+ */
+static int iopt_insert_area(struct io_pagetable *iopt, struct iopt_area *area,
+			    struct iopt_pages *pages, unsigned long iova,
+			    unsigned long start_byte, unsigned long length,
+			    int iommu_prot)
+{
+	lockdep_assert_held_write(&iopt->iova_rwsem);
+
+	if ((iommu_prot & IOMMU_WRITE) && !pages->writable)
+		return -EPERM;
+
+	area->iommu_prot = iommu_prot;
+	area->page_offset = start_byte % PAGE_SIZE;
+	if (area->page_offset & (iopt->iova_alignment - 1))
+		return -EINVAL;
+
+	area->node.start = iova;
+	if (check_add_overflow(iova, length - 1, &area->node.last))
+		return -EOVERFLOW;
+
+	area->pages_node.start = start_byte / PAGE_SIZE;
+	if (check_add_overflow(start_byte, length - 1, &area->pages_node.last))
+		return -EOVERFLOW;
+	area->pages_node.last = area->pages_node.last / PAGE_SIZE;
+	if (WARN_ON(area->pages_node.last >= pages->npages))
+		return -EOVERFLOW;
+
+	/*
+	 * The area is inserted with a NULL pages indicating it is not fully
+	 * initialized yet.
+	 */
+	area->iopt = iopt;
+	interval_tree_insert(&area->node, &iopt->area_itree);
+	return 0;
+}
+
+static int iopt_alloc_area_pages(struct io_pagetable *iopt,
+				 struct list_head *pages_list,
+				 unsigned long length, unsigned long *dst_iova,
+				 int iommu_prot, unsigned int flags)
+{
+	struct iopt_pages_list *elm;
+	unsigned long iova;
+	int rc = 0;
+
+	list_for_each_entry(elm, pages_list, next) {
+		elm->area = kzalloc(sizeof(*elm->area), GFP_KERNEL_ACCOUNT);
+		if (!elm->area)
+			return -ENOMEM;
+	}
+
+	down_write(&iopt->iova_rwsem);
+	if ((length & (iopt->iova_alignment - 1)) || !length) {
+		rc = -EINVAL;
+		goto out_unlock;
+	}
+
+	if (flags & IOPT_ALLOC_IOVA) {
+		/* Use the first entry to guess the ideal IOVA alignment */
+		elm = list_first_entry(pages_list, struct iopt_pages_list,
+				       next);
+		rc = iopt_alloc_iova(
+			iopt, dst_iova,
+			(uintptr_t)elm->pages->uptr + elm->start_byte, length);
+		if (rc)
+			goto out_unlock;
+	} else {
+		rc = iopt_check_iova(iopt, *dst_iova, length);
+		if (rc)
+			goto out_unlock;
+	}
+
+	/*
+	 * Areas are created with a NULL pages so that the IOVA space is
+	 * reserved and we can unlock the iova_rwsem.
+	 */
+	iova = *dst_iova;
+	list_for_each_entry(elm, pages_list, next) {
+		rc = iopt_insert_area(iopt, elm->area, elm->pages, iova,
+				      elm->start_byte, elm->length, iommu_prot);
+		if (rc)
+			goto out_unlock;
+		iova += elm->length;
+	}
+
+out_unlock:
+	up_write(&iopt->iova_rwsem);
+	return rc;
+}
+
+static void iopt_abort_area(struct iopt_area *area)
+{
+	if (area->iopt) {
+		down_write(&area->iopt->iova_rwsem);
+		interval_tree_remove(&area->node, &area->iopt->area_itree);
+		up_write(&area->iopt->iova_rwsem);
+	}
+	kfree(area);
+}
+
+void iopt_free_pages_list(struct list_head *pages_list)
+{
+	struct iopt_pages_list *elm;
+
+	while ((elm = list_first_entry_or_null(pages_list,
+					       struct iopt_pages_list, next))) {
+		if (elm->area)
+			iopt_abort_area(elm->area);
+		if (elm->pages)
+			iopt_put_pages(elm->pages);
+		list_del(&elm->next);
+		kfree(elm);
+	}
+}
+
+static int iopt_fill_domains_pages(struct list_head *pages_list)
+{
+	struct iopt_pages_list *undo_elm;
+	struct iopt_pages_list *elm;
+	int rc;
+
+	list_for_each_entry(elm, pages_list, next) {
+		rc = iopt_area_fill_domains(elm->area, elm->pages);
+		if (rc)
+			goto err_undo;
+	}
+	return 0;
+
+err_undo:
+	list_for_each_entry(undo_elm, pages_list, next) {
+		if (undo_elm == elm)
+			break;
+		iopt_area_unfill_domains(undo_elm->area, undo_elm->pages);
+	}
+	return rc;
+}
+
+int iopt_map_pages(struct io_pagetable *iopt, struct list_head *pages_list,
+		   unsigned long length, unsigned long *dst_iova,
+		   int iommu_prot, unsigned int flags)
+{
+	struct iopt_pages_list *elm;
+	int rc;
+
+	rc = iopt_alloc_area_pages(iopt, pages_list, length, dst_iova,
+				   iommu_prot, flags);
+	if (rc)
+		return rc;
+
+	down_read(&iopt->domains_rwsem);
+	rc = iopt_fill_domains_pages(pages_list);
+	if (rc)
+		goto out_unlock_domains;
+
+	down_write(&iopt->iova_rwsem);
+	list_for_each_entry(elm, pages_list, next) {
+		/*
+		 * area->pages must be set inside the domains_rwsem to ensure
+		 * any newly added domains will get filled. Moves the reference
+		 * in from the list.
+		 */
+		elm->area->pages = elm->pages;
+		elm->pages = NULL;
+		elm->area = NULL;
+	}
+	up_write(&iopt->iova_rwsem);
+out_unlock_domains:
+	up_read(&iopt->domains_rwsem);
+	return rc;
+}
+
+/**
+ * iopt_map_user_pages() - Map a user VA to an iova in the io page table
+ * @ictx: iommufd_ctx the iopt is part of
+ * @iopt: io_pagetable to act on
+ * @iova: If IOPT_ALLOC_IOVA is set this is unused on input and contains
+ *        the chosen iova on output. Otherwise is the iova to map to on input
+ * @uptr: User VA to map
+ * @length: Number of bytes to map
+ * @iommu_prot: Combination of IOMMU_READ/WRITE/etc bits for the mapping
+ * @flags: IOPT_ALLOC_IOVA or zero
+ *
+ * iova, uptr, and length must be aligned to iova_alignment. For domain backed
+ * page tables this will pin the pages and load them into the domain at iova.
+ * For non-domain page tables this will only setup a lazy reference and the
+ * caller must use iopt_access_pages() to touch them.
+ *
+ * iopt_unmap_iova() must be called to undo this before the io_pagetable can be
+ * destroyed.
+ */
+int iopt_map_user_pages(struct iommufd_ctx *ictx, struct io_pagetable *iopt,
+			unsigned long *iova, void __user *uptr,
+			unsigned long length, int iommu_prot,
+			unsigned int flags)
+{
+	struct iopt_pages_list elm = {};
+	LIST_HEAD(pages_list);
+	int rc;
+
+	elm.pages = iopt_alloc_pages(uptr, length, iommu_prot & IOMMU_WRITE);
+	if (IS_ERR(elm.pages))
+		return PTR_ERR(elm.pages);
+	if (ictx->account_mode == IOPT_PAGES_ACCOUNT_MM &&
+	    elm.pages->account_mode == IOPT_PAGES_ACCOUNT_USER)
+		elm.pages->account_mode = IOPT_PAGES_ACCOUNT_MM;
+	elm.start_byte = uptr - elm.pages->uptr;
+	elm.length = length;
+	list_add(&elm.next, &pages_list);
+
+	rc = iopt_map_pages(iopt, &pages_list, length, iova, iommu_prot, flags);
+	if (rc) {
+		if (elm.area)
+			iopt_abort_area(elm.area);
+		if (elm.pages)
+			iopt_put_pages(elm.pages);
+		return rc;
+	}
+	return 0;
+}
+
+int iopt_get_pages(struct io_pagetable *iopt, unsigned long iova,
+		   unsigned long length, struct list_head *pages_list)
+{
+	struct iopt_area_contig_iter iter;
+	unsigned long last_iova;
+	struct iopt_area *area;
+	int rc;
+
+	if (!length)
+		return -EINVAL;
+	if (check_add_overflow(iova, length - 1, &last_iova))
+		return -EOVERFLOW;
+
+	down_read(&iopt->iova_rwsem);
+	iopt_for_each_contig_area(&iter, area, iopt, iova, last_iova) {
+		struct iopt_pages_list *elm;
+		unsigned long last = min(last_iova, iopt_area_last_iova(area));
+
+		elm = kzalloc(sizeof(*elm), GFP_KERNEL_ACCOUNT);
+		if (!elm) {
+			rc = -ENOMEM;
+			goto err_free;
+		}
+		elm->start_byte = iopt_area_start_byte(area, iter.cur_iova);
+		elm->pages = area->pages;
+		elm->length = (last - iter.cur_iova) + 1;
+		kref_get(&elm->pages->kref);
+		list_add_tail(&elm->next, pages_list);
+	}
+	if (!iopt_area_contig_done(&iter)) {
+		rc = -ENOENT;
+		goto err_free;
+	}
+	up_read(&iopt->iova_rwsem);
+	return 0;
+err_free:
+	up_read(&iopt->iova_rwsem);
+	iopt_free_pages_list(pages_list);
+	return rc;
+}
+
+static int iopt_unmap_iova_range(struct io_pagetable *iopt, unsigned long start,
+				 unsigned long last, unsigned long *unmapped)
+{
+	struct iopt_area *area;
+	unsigned long unmapped_bytes = 0;
+	int rc = -ENOENT;
+
+	/*
+	 * The domains_rwsem must be held in read mode any time any area->pages
+	 * is NULL. This prevents domain attach/detatch from running
+	 * concurrently with cleaning up the area.
+	 */
+	down_read(&iopt->domains_rwsem);
+	down_write(&iopt->iova_rwsem);
+	while ((area = iopt_area_iter_first(iopt, start, last))) {
+		unsigned long area_last = iopt_area_last_iova(area);
+		unsigned long area_first = iopt_area_iova(area);
+		struct iopt_pages *pages;
+
+		/* Userspace should not race map/unmap's of the same area */
+		if (!area->pages) {
+			rc = -EBUSY;
+			goto out_unlock_iova;
+		}
+
+		if (area_first < start || area_last > last) {
+			rc = -ENOENT;
+			goto out_unlock_iova;
+		}
+
+		/*
+		 * num_accesses writers must hold the iova_rwsem too, so we can
+		 * safely read it under the write side of the iovam_rwsem
+		 * without the pages->mutex.
+		 */
+		if (area->num_accesses) {
+			start = area_first;
+			area->prevent_access = true;
+			up_write(&iopt->iova_rwsem);
+			up_read(&iopt->domains_rwsem);
+			/* Later patch calls back to drivers to unmap */
+			return -EBUSY;
+		}
+
+		pages = area->pages;
+		area->pages = NULL;
+		up_write(&iopt->iova_rwsem);
+
+		iopt_area_unfill_domains(area, pages);
+		iopt_abort_area(area);
+		iopt_put_pages(pages);
+
+		unmapped_bytes += area_last - area_first + 1;
+
+		down_write(&iopt->iova_rwsem);
+	}
+	if (unmapped_bytes)
+		rc = 0;
+
+out_unlock_iova:
+	up_write(&iopt->iova_rwsem);
+	up_read(&iopt->domains_rwsem);
+	if (unmapped)
+		*unmapped = unmapped_bytes;
+	return rc;
+}
+
+/**
+ * iopt_unmap_iova() - Remove a range of iova
+ * @iopt: io_pagetable to act on
+ * @iova: Starting iova to unmap
+ * @length: Number of bytes to unmap
+ * @unmapped: Return number of bytes unmapped
+ *
+ * The requested range must be a superset of existing ranges.
+ * Splitting/truncating IOVA mappings is not allowed.
+ */
+int iopt_unmap_iova(struct io_pagetable *iopt, unsigned long iova,
+		    unsigned long length, unsigned long *unmapped)
+{
+	unsigned long iova_last;
+
+	if (!length)
+		return -EINVAL;
+
+	if (check_add_overflow(iova, length - 1, &iova_last))
+		return -EOVERFLOW;
+
+	return iopt_unmap_iova_range(iopt, iova, iova_last, unmapped);
+}
+
+int iopt_unmap_all(struct io_pagetable *iopt, unsigned long *unmapped)
+{
+	int rc;
+
+	rc = iopt_unmap_iova_range(iopt, 0, ULONG_MAX, unmapped);
+	/* If the IOVAs are empty then unmap all succeeds */
+	if (rc == -ENOENT)
+		return 0;
+	return rc;
+}
+
+/* The caller must always free all the nodes in the allowed_iova rb_root. */
+int iopt_set_allow_iova(struct io_pagetable *iopt,
+			struct rb_root_cached *allowed_iova)
+{
+	struct iopt_allowed *allowed;
+
+	down_write(&iopt->iova_rwsem);
+	swap(*allowed_iova, iopt->allowed_itree);
+
+	for (allowed = iopt_allowed_iter_first(iopt, 0, ULONG_MAX); allowed;
+	     allowed = iopt_allowed_iter_next(allowed, 0, ULONG_MAX)) {
+		if (iopt_reserved_iter_first(iopt, allowed->node.start,
+					     allowed->node.last)) {
+			swap(*allowed_iova, iopt->allowed_itree);
+			up_write(&iopt->iova_rwsem);
+			return -EADDRINUSE;
+		}
+	}
+	up_write(&iopt->iova_rwsem);
+	return 0;
+}
+
+int iopt_reserve_iova(struct io_pagetable *iopt, unsigned long start,
+		      unsigned long last, void *owner)
+{
+	struct iopt_reserved *reserved;
+
+	lockdep_assert_held_write(&iopt->iova_rwsem);
+
+	if (iopt_area_iter_first(iopt, start, last) ||
+	    iopt_allowed_iter_first(iopt, start, last))
+		return -EADDRINUSE;
+
+	reserved = kzalloc(sizeof(*reserved), GFP_KERNEL_ACCOUNT);
+	if (!reserved)
+		return -ENOMEM;
+	reserved->node.start = start;
+	reserved->node.last = last;
+	reserved->owner = owner;
+	interval_tree_insert(&reserved->node, &iopt->reserved_itree);
+	return 0;
+}
+
+static void __iopt_remove_reserved_iova(struct io_pagetable *iopt, void *owner)
+{
+	struct iopt_reserved *reserved, *next;
+
+	lockdep_assert_held_write(&iopt->iova_rwsem);
+
+	for (reserved = iopt_reserved_iter_first(iopt, 0, ULONG_MAX); reserved;
+	     reserved = next) {
+		next = iopt_reserved_iter_next(reserved, 0, ULONG_MAX);
+
+		if (reserved->owner == owner) {
+			interval_tree_remove(&reserved->node,
+					     &iopt->reserved_itree);
+			kfree(reserved);
+		}
+	}
+}
+
+void iopt_remove_reserved_iova(struct io_pagetable *iopt, void *owner)
+{
+	down_write(&iopt->iova_rwsem);
+	__iopt_remove_reserved_iova(iopt, owner);
+	up_write(&iopt->iova_rwsem);
+}
+
+void iopt_init_table(struct io_pagetable *iopt)
+{
+	init_rwsem(&iopt->iova_rwsem);
+	init_rwsem(&iopt->domains_rwsem);
+	iopt->area_itree = RB_ROOT_CACHED;
+	iopt->allowed_itree = RB_ROOT_CACHED;
+	iopt->reserved_itree = RB_ROOT_CACHED;
+	xa_init_flags(&iopt->domains, XA_FLAGS_ACCOUNT);
+	xa_init_flags(&iopt->access_list, XA_FLAGS_ALLOC);
+
+	/*
+	 * iopt's start as SW tables that can use the entire size_t IOVA space
+	 * due to the use of size_t in the APIs. They have no alignment
+	 * restriction.
+	 */
+	iopt->iova_alignment = 1;
+}
+
+void iopt_destroy_table(struct io_pagetable *iopt)
+{
+	struct interval_tree_node *node;
+
+	while ((node = interval_tree_iter_first(&iopt->allowed_itree, 0,
+						ULONG_MAX))) {
+		interval_tree_remove(node, &iopt->allowed_itree);
+		kfree(container_of(node, struct iopt_allowed, node));
+	}
+
+	WARN_ON(!RB_EMPTY_ROOT(&iopt->reserved_itree.rb_root));
+	WARN_ON(!xa_empty(&iopt->domains));
+	WARN_ON(!xa_empty(&iopt->access_list));
+	WARN_ON(!RB_EMPTY_ROOT(&iopt->area_itree.rb_root));
+}
+
+/**
+ * iopt_unfill_domain() - Unfill a domain with PFNs
+ * @iopt: io_pagetable to act on
+ * @domain: domain to unfill
+ *
+ * This is used when removing a domain from the iopt. Every area in the iopt
+ * will be unmapped from the domain. The domain must already be removed from the
+ * domains xarray.
+ */
+static void iopt_unfill_domain(struct io_pagetable *iopt,
+			       struct iommu_domain *domain)
+{
+	struct iopt_area *area;
+
+	lockdep_assert_held(&iopt->iova_rwsem);
+	lockdep_assert_held_write(&iopt->domains_rwsem);
+
+	/*
+	 * Some other domain is holding all the pfns still, rapidly unmap this
+	 * domain.
+	 */
+	if (iopt->next_domain_id != 0) {
+		/* Pick an arbitrary remaining domain to act as storage */
+		struct iommu_domain *storage_domain =
+			xa_load(&iopt->domains, 0);
+
+		for (area = iopt_area_iter_first(iopt, 0, ULONG_MAX); area;
+		     area = iopt_area_iter_next(area, 0, ULONG_MAX)) {
+			struct iopt_pages *pages = area->pages;
+
+			if (!pages)
+				continue;
+
+			mutex_lock(&pages->mutex);
+			if (area->storage_domain == domain)
+				area->storage_domain = storage_domain;
+			mutex_unlock(&pages->mutex);
+
+			iopt_area_unmap_domain(area, domain);
+		}
+		return;
+	}
+
+	for (area = iopt_area_iter_first(iopt, 0, ULONG_MAX); area;
+	     area = iopt_area_iter_next(area, 0, ULONG_MAX)) {
+		struct iopt_pages *pages = area->pages;
+
+		if (!pages)
+			continue;
+
+		mutex_lock(&pages->mutex);
+		interval_tree_remove(&area->pages_node, &pages->domains_itree);
+		WARN_ON(area->storage_domain != domain);
+		area->storage_domain = NULL;
+		iopt_area_unfill_domain(area, pages, domain);
+		mutex_unlock(&pages->mutex);
+	}
+}
+
+/**
+ * iopt_fill_domain() - Fill a domain with PFNs
+ * @iopt: io_pagetable to act on
+ * @domain: domain to fill
+ *
+ * Fill the domain with PFNs from every area in the iopt. On failure the domain
+ * is left unchanged.
+ */
+static int iopt_fill_domain(struct io_pagetable *iopt,
+			    struct iommu_domain *domain)
+{
+	struct iopt_area *end_area;
+	struct iopt_area *area;
+	int rc;
+
+	lockdep_assert_held(&iopt->iova_rwsem);
+	lockdep_assert_held_write(&iopt->domains_rwsem);
+
+	for (area = iopt_area_iter_first(iopt, 0, ULONG_MAX); area;
+	     area = iopt_area_iter_next(area, 0, ULONG_MAX)) {
+		struct iopt_pages *pages = area->pages;
+
+		if (!pages)
+			continue;
+
+		mutex_lock(&pages->mutex);
+		rc = iopt_area_fill_domain(area, domain);
+		if (rc) {
+			mutex_unlock(&pages->mutex);
+			goto out_unfill;
+		}
+		if (!area->storage_domain) {
+			WARN_ON(iopt->next_domain_id != 0);
+			area->storage_domain = domain;
+			interval_tree_insert(&area->pages_node,
+					     &pages->domains_itree);
+		}
+		mutex_unlock(&pages->mutex);
+	}
+	return 0;
+
+out_unfill:
+	end_area = area;
+	for (area = iopt_area_iter_first(iopt, 0, ULONG_MAX); area;
+	     area = iopt_area_iter_next(area, 0, ULONG_MAX)) {
+		struct iopt_pages *pages = area->pages;
+
+		if (area == end_area)
+			break;
+		if (!pages)
+			continue;
+		mutex_lock(&pages->mutex);
+		if (iopt->next_domain_id == 0) {
+			interval_tree_remove(&area->pages_node,
+					     &pages->domains_itree);
+			area->storage_domain = NULL;
+		}
+		iopt_area_unfill_domain(area, pages, domain);
+		mutex_unlock(&pages->mutex);
+	}
+	return rc;
+}
+
+/* All existing area's conform to an increased page size */
+static int iopt_check_iova_alignment(struct io_pagetable *iopt,
+				     unsigned long new_iova_alignment)
+{
+	unsigned long align_mask = new_iova_alignment - 1;
+	struct iopt_area *area;
+
+	lockdep_assert_held(&iopt->iova_rwsem);
+	lockdep_assert_held(&iopt->domains_rwsem);
+
+	for (area = iopt_area_iter_first(iopt, 0, ULONG_MAX); area;
+	     area = iopt_area_iter_next(area, 0, ULONG_MAX))
+		if ((iopt_area_iova(area) & align_mask) ||
+		    (iopt_area_length(area) & align_mask) ||
+		    (area->page_offset & align_mask))
+			return -EADDRINUSE;
+	return 0;
+}
+
+int iopt_table_add_domain(struct io_pagetable *iopt,
+			  struct iommu_domain *domain)
+{
+	const struct iommu_domain_geometry *geometry = &domain->geometry;
+	struct iommu_domain *iter_domain;
+	unsigned int new_iova_alignment;
+	unsigned long index;
+	int rc;
+
+	down_write(&iopt->domains_rwsem);
+	down_write(&iopt->iova_rwsem);
+
+	xa_for_each(&iopt->domains, index, iter_domain) {
+		if (WARN_ON(iter_domain == domain)) {
+			rc = -EEXIST;
+			goto out_unlock;
+		}
+	}
+
+	/*
+	 * The io page size drives the iova_alignment. Internally the iopt_pages
+	 * works in PAGE_SIZE units and we adjust when mapping sub-PAGE_SIZE
+	 * objects into the iommu_domain.
+	 *
+	 * A iommu_domain must always be able to accept PAGE_SIZE to be
+	 * compatible as we can't guarantee higher contiguity.
+	 */
+	new_iova_alignment = max_t(unsigned long,
+				   1UL << __ffs(domain->pgsize_bitmap),
+				   iopt->iova_alignment);
+	if (new_iova_alignment > PAGE_SIZE) {
+		rc = -EINVAL;
+		goto out_unlock;
+	}
+	if (new_iova_alignment != iopt->iova_alignment) {
+		rc = iopt_check_iova_alignment(iopt, new_iova_alignment);
+		if (rc)
+			goto out_unlock;
+	}
+
+	/* No area exists that is outside the allowed domain aperture */
+	if (geometry->aperture_start != 0) {
+		rc = iopt_reserve_iova(iopt, 0, geometry->aperture_start - 1,
+				       domain);
+		if (rc)
+			goto out_reserved;
+	}
+	if (geometry->aperture_end != ULONG_MAX) {
+		rc = iopt_reserve_iova(iopt, geometry->aperture_end + 1,
+				       ULONG_MAX, domain);
+		if (rc)
+			goto out_reserved;
+	}
+
+	rc = xa_reserve(&iopt->domains, iopt->next_domain_id, GFP_KERNEL);
+	if (rc)
+		goto out_reserved;
+
+	rc = iopt_fill_domain(iopt, domain);
+	if (rc)
+		goto out_release;
+
+	iopt->iova_alignment = new_iova_alignment;
+	xa_store(&iopt->domains, iopt->next_domain_id, domain, GFP_KERNEL);
+	iopt->next_domain_id++;
+	up_write(&iopt->iova_rwsem);
+	up_write(&iopt->domains_rwsem);
+	return 0;
+out_release:
+	xa_release(&iopt->domains, iopt->next_domain_id);
+out_reserved:
+	__iopt_remove_reserved_iova(iopt, domain);
+out_unlock:
+	up_write(&iopt->iova_rwsem);
+	up_write(&iopt->domains_rwsem);
+	return rc;
+}
+
+static int iopt_calculate_iova_alignment(struct io_pagetable *iopt)
+{
+	unsigned long new_iova_alignment;
+	struct iommufd_access *access;
+	struct iommu_domain *domain;
+	unsigned long index;
+
+	lockdep_assert_held_write(&iopt->iova_rwsem);
+	lockdep_assert_held(&iopt->domains_rwsem);
+
+	/* See batch_iommu_map_small() */
+	if (iopt->disable_large_pages)
+		new_iova_alignment = PAGE_SIZE;
+	else
+		new_iova_alignment = 1;
+
+	xa_for_each(&iopt->domains, index, domain)
+		new_iova_alignment = max_t(unsigned long,
+					   1UL << __ffs(domain->pgsize_bitmap),
+					   new_iova_alignment);
+	xa_for_each(&iopt->access_list, index, access)
+		new_iova_alignment = max_t(unsigned long,
+					   access->iova_alignment,
+					   new_iova_alignment);
+
+	if (new_iova_alignment > iopt->iova_alignment) {
+		int rc;
+
+		rc = iopt_check_iova_alignment(iopt, new_iova_alignment);
+		if (rc)
+			return rc;
+	}
+	iopt->iova_alignment = new_iova_alignment;
+	return 0;
+}
+
+void iopt_table_remove_domain(struct io_pagetable *iopt,
+			      struct iommu_domain *domain)
+{
+	struct iommu_domain *iter_domain = NULL;
+	unsigned long index;
+
+	down_write(&iopt->domains_rwsem);
+	down_write(&iopt->iova_rwsem);
+
+	xa_for_each(&iopt->domains, index, iter_domain)
+		if (iter_domain == domain)
+			break;
+	if (WARN_ON(iter_domain != domain) || index >= iopt->next_domain_id)
+		goto out_unlock;
+
+	/*
+	 * Compress the xarray to keep it linear by swapping the entry to erase
+	 * with the tail entry and shrinking the tail.
+	 */
+	iopt->next_domain_id--;
+	iter_domain = xa_erase(&iopt->domains, iopt->next_domain_id);
+	if (index != iopt->next_domain_id)
+		xa_store(&iopt->domains, index, iter_domain, GFP_KERNEL);
+
+	iopt_unfill_domain(iopt, domain);
+	__iopt_remove_reserved_iova(iopt, domain);
+
+	WARN_ON(iopt_calculate_iova_alignment(iopt));
+out_unlock:
+	up_write(&iopt->iova_rwsem);
+	up_write(&iopt->domains_rwsem);
+}
+
+/**
+ * iopt_area_split - Split an area into two parts at iova
+ * @area: The area to split
+ * @iova: Becomes the last of a new area
+ *
+ * This splits an area into two. It is part of the VFIO compatibility to allow
+ * poking a hole in the mapping. The two areas continue to point at the same
+ * iopt_pages, just with different starting bytes.
+ */
+static int iopt_area_split(struct iopt_area *area, unsigned long iova)
+{
+	unsigned long alignment = area->iopt->iova_alignment;
+	unsigned long last_iova = iopt_area_last_iova(area);
+	unsigned long start_iova = iopt_area_iova(area);
+	unsigned long new_start = iova + 1;
+	struct io_pagetable *iopt = area->iopt;
+	struct iopt_pages *pages = area->pages;
+	struct iopt_area *lhs;
+	struct iopt_area *rhs;
+	int rc;
+
+	lockdep_assert_held_write(&iopt->iova_rwsem);
+
+	if (iova == start_iova || iova == last_iova)
+		return 0;
+
+	if (!pages || area->prevent_access)
+		return -EBUSY;
+
+	if (new_start & (alignment - 1) ||
+	    iopt_area_start_byte(area, new_start) & (alignment - 1))
+		return -EINVAL;
+
+	lhs = kzalloc(sizeof(*area), GFP_KERNEL_ACCOUNT);
+	if (!lhs)
+		return -ENOMEM;
+
+	rhs = kzalloc(sizeof(*area), GFP_KERNEL_ACCOUNT);
+	if (!rhs) {
+		rc = -ENOMEM;
+		goto err_free_lhs;
+	}
+
+	mutex_lock(&pages->mutex);
+	/*
+	 * Splitting is not permitted if an access exists, we don't track enough
+	 * information to split existing accesses.
+	 */
+	if (area->num_accesses) {
+		rc = -EINVAL;
+		goto err_unlock;
+	}
+
+	/*
+	 * Splitting is not permitted if a domain could have been mapped with
+	 * huge pages.
+	 */
+	if (area->storage_domain && !iopt->disable_large_pages) {
+		rc = -EINVAL;
+		goto err_unlock;
+	}
+
+	interval_tree_remove(&area->node, &iopt->area_itree);
+	rc = iopt_insert_area(iopt, lhs, area->pages, start_iova,
+			      iopt_area_start_byte(area, start_iova),
+			      (new_start - 1) - start_iova + 1,
+			      area->iommu_prot);
+	if (WARN_ON(rc))
+		goto err_insert;
+
+	rc = iopt_insert_area(iopt, rhs, area->pages, new_start,
+			      iopt_area_start_byte(area, new_start),
+			      last_iova - new_start + 1, area->iommu_prot);
+	if (WARN_ON(rc))
+		goto err_remove_lhs;
+
+	lhs->storage_domain = area->storage_domain;
+	lhs->pages = area->pages;
+	rhs->storage_domain = area->storage_domain;
+	rhs->pages = area->pages;
+	kref_get(&rhs->pages->kref);
+	kfree(area);
+	mutex_unlock(&pages->mutex);
+
+	/*
+	 * No change to domains or accesses because the pages hasn't been
+	 * changed
+	 */
+	return 0;
+
+err_remove_lhs:
+	interval_tree_remove(&lhs->node, &iopt->area_itree);
+err_insert:
+	interval_tree_insert(&area->node, &iopt->area_itree);
+err_unlock:
+	mutex_unlock(&pages->mutex);
+	kfree(rhs);
+err_free_lhs:
+	kfree(lhs);
+	return rc;
+}
+
+int iopt_cut_iova(struct io_pagetable *iopt, unsigned long *iovas,
+		  size_t num_iovas)
+{
+	int rc = 0;
+	int i;
+
+	down_write(&iopt->iova_rwsem);
+	for (i = 0; i < num_iovas; i++) {
+		struct iopt_area *area;
+
+		area = iopt_area_iter_first(iopt, iovas[i], iovas[i]);
+		if (!area)
+			continue;
+		rc = iopt_area_split(area, iovas[i]);
+		if (rc)
+			break;
+	}
+	up_write(&iopt->iova_rwsem);
+	return rc;
+}
+
+void iopt_enable_large_pages(struct io_pagetable *iopt)
+{
+	int rc;
+
+	down_write(&iopt->domains_rwsem);
+	down_write(&iopt->iova_rwsem);
+	WRITE_ONCE(iopt->disable_large_pages, false);
+	rc = iopt_calculate_iova_alignment(iopt);
+	WARN_ON(rc);
+	up_write(&iopt->iova_rwsem);
+	up_write(&iopt->domains_rwsem);
+}
+
+int iopt_disable_large_pages(struct io_pagetable *iopt)
+{
+	int rc = 0;
+
+	down_write(&iopt->domains_rwsem);
+	down_write(&iopt->iova_rwsem);
+	if (iopt->disable_large_pages)
+		goto out_unlock;
+
+	/* Won't do it if domains already have pages mapped in them */
+	if (!xa_empty(&iopt->domains) &&
+	    !RB_EMPTY_ROOT(&iopt->area_itree.rb_root)) {
+		rc = -EINVAL;
+		goto out_unlock;
+	}
+
+	WRITE_ONCE(iopt->disable_large_pages, true);
+	rc = iopt_calculate_iova_alignment(iopt);
+	if (rc)
+		WRITE_ONCE(iopt->disable_large_pages, false);
+out_unlock:
+	up_write(&iopt->iova_rwsem);
+	up_write(&iopt->domains_rwsem);
+	return rc;
+}
+
+int iopt_add_access(struct io_pagetable *iopt, struct iommufd_access *access)
+{
+	int rc;
+
+	down_write(&iopt->domains_rwsem);
+	down_write(&iopt->iova_rwsem);
+	rc = xa_alloc(&iopt->access_list, &access->iopt_access_list_id, access,
+		      xa_limit_16b, GFP_KERNEL_ACCOUNT);
+	if (rc)
+		goto out_unlock;
+
+	rc = iopt_calculate_iova_alignment(iopt);
+	if (rc) {
+		xa_erase(&iopt->access_list, access->iopt_access_list_id);
+		goto out_unlock;
+	}
+
+out_unlock:
+	up_write(&iopt->iova_rwsem);
+	up_write(&iopt->domains_rwsem);
+	return rc;
+}
+
+void iopt_remove_access(struct io_pagetable *iopt,
+			struct iommufd_access *access)
+{
+	down_write(&iopt->domains_rwsem);
+	down_write(&iopt->iova_rwsem);
+	WARN_ON(xa_erase(&iopt->access_list, access->iopt_access_list_id) !=
+		access);
+	WARN_ON(iopt_calculate_iova_alignment(iopt));
+	up_write(&iopt->iova_rwsem);
+	up_write(&iopt->domains_rwsem);
+}
+
+/* Narrow the valid_iova_itree to include reserved ranges from a group. */
+int iopt_table_enforce_group_resv_regions(struct io_pagetable *iopt,
+					  struct device *device,
+					  struct iommu_group *group,
+					  phys_addr_t *sw_msi_start)
+{
+	struct iommu_resv_region *resv;
+	struct iommu_resv_region *tmp;
+	LIST_HEAD(group_resv_regions);
+	int rc;
+
+	down_write(&iopt->iova_rwsem);
+	rc = iommu_get_group_resv_regions(group, &group_resv_regions);
+	if (rc)
+		goto out_unlock;
+
+	list_for_each_entry(resv, &group_resv_regions, list) {
+		if (resv->type == IOMMU_RESV_DIRECT_RELAXABLE)
+			continue;
+
+		/*
+		 * The presence of any 'real' MSI regions should take precedence
+		 * over the software-managed one if the IOMMU driver happens to
+		 * advertise both types.
+		 */
+		if (sw_msi_start && resv->type == IOMMU_RESV_MSI) {
+			*sw_msi_start = 0;
+			sw_msi_start = NULL;
+		}
+		if (sw_msi_start && resv->type == IOMMU_RESV_SW_MSI)
+			*sw_msi_start = resv->start;
+
+		rc = iopt_reserve_iova(iopt, resv->start,
+				       resv->length - 1 + resv->start, device);
+		if (rc)
+			goto out_reserved;
+	}
+	rc = 0;
+	goto out_free_resv;
+
+out_reserved:
+	__iopt_remove_reserved_iova(iopt, device);
+out_free_resv:
+	list_for_each_entry_safe(resv, tmp, &group_resv_regions, list)
+		kfree(resv);
+out_unlock:
+	up_write(&iopt->iova_rwsem);
+	return rc;
+}
diff --git a/drivers/iommu/iommufd/io_pagetable.h b/drivers/iommu/iommufd/io_pagetable.h
index a2b724175057b0..2ee6942c3ef4a5 100644
--- a/drivers/iommu/iommufd/io_pagetable.h
+++ b/drivers/iommu/iommufd/io_pagetable.h
@@ -46,9 +46,19 @@ struct iopt_area {
 	unsigned int page_offset;
 	/* IOMMU_READ, IOMMU_WRITE, etc */
 	int iommu_prot;
+	bool prevent_access : 1;
 	unsigned int num_accesses;
 };
 
+struct iopt_allowed {
+	struct interval_tree_node node;
+};
+
+struct iopt_reserved {
+	struct interval_tree_node node;
+	void *owner;
+};
+
 int iopt_area_fill_domains(struct iopt_area *area, struct iopt_pages *pages);
 void iopt_area_unfill_domains(struct iopt_area *area, struct iopt_pages *pages);
 
@@ -83,6 +93,24 @@ static inline size_t iopt_area_length(struct iopt_area *area)
 	return (area->node.last - area->node.start) + 1;
 }
 
+/*
+ * Number of bytes from the start of the iopt_pages that the iova begins.
+ * iopt_area_start_byte() / PAGE_SIZE encodes the starting page index
+ * iopt_area_start_byte() % PAGE_SIZE encodes the offset within that page
+ */
+static inline unsigned long iopt_area_start_byte(struct iopt_area *area,
+						 unsigned long iova)
+{
+	return (iova - iopt_area_iova(area)) + area->page_offset +
+	       iopt_area_index(area) * PAGE_SIZE;
+}
+
+static inline unsigned long iopt_area_iova_to_index(struct iopt_area *area,
+						    unsigned long iova)
+{
+	return iopt_area_start_byte(area, iova) / PAGE_SIZE;
+}
+
 #define __make_iopt_iter(name)                                                 \
 	static inline struct iopt_##name *iopt_##name##_iter_first(            \
 		struct io_pagetable *iopt, unsigned long start,                \
@@ -110,6 +138,33 @@ static inline size_t iopt_area_length(struct iopt_area *area)
 	}
 
 __make_iopt_iter(area)
+__make_iopt_iter(allowed)
+__make_iopt_iter(reserved)
+
+struct iopt_area_contig_iter {
+	unsigned long cur_iova;
+	unsigned long last_iova;
+	struct iopt_area *area;
+};
+struct iopt_area *iopt_area_contig_init(struct iopt_area_contig_iter *iter,
+					struct io_pagetable *iopt,
+					unsigned long iova,
+					unsigned long last_iova);
+struct iopt_area *iopt_area_contig_next(struct iopt_area_contig_iter *iter);
+
+static inline bool iopt_area_contig_done(struct iopt_area_contig_iter *iter)
+{
+	return iter->area && iter->last_iova <= iopt_area_last_iova(iter->area);
+}
+
+/*
+ * Iterate over a contiguous list of areas that span the iova,last_iova range.
+ * The caller must check iopt_area_contig_done() after the loop to see if
+ * contiguous areas existed.
+ */
+#define iopt_for_each_contig_area(iter, area, iopt, iova, last_iova)          \
+	for (area = iopt_area_contig_init(iter, iopt, iova, last_iova); area; \
+	     area = iopt_area_contig_next(iter))
 
 enum {
 	IOPT_PAGES_ACCOUNT_NONE = 0,
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 38088217b52259..dadd90cae543ba 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -9,9 +9,14 @@
 #include <linux/refcount.h>
 #include <linux/uaccess.h>
 
+struct iommu_domain;
+struct iommu_group;
+
 struct iommufd_ctx {
 	struct file *file;
 	struct xarray objects;
+
+	u8 account_mode;
 };
 
 /*
@@ -27,6 +32,7 @@ struct iommufd_ctx {
 struct io_pagetable {
 	struct rw_semaphore domains_rwsem;
 	struct xarray domains;
+	struct xarray access_list;
 	unsigned int next_domain_id;
 
 	struct rw_semaphore iova_rwsem;
@@ -36,7 +42,45 @@ struct io_pagetable {
 	/* IOVA that cannot be allocated, struct iopt_reserved */
 	struct rb_root_cached reserved_itree;
 	u8 disable_large_pages;
+	unsigned long iova_alignment;
+};
+
+void iopt_init_table(struct io_pagetable *iopt);
+void iopt_destroy_table(struct io_pagetable *iopt);
+int iopt_get_pages(struct io_pagetable *iopt, unsigned long iova,
+		   unsigned long length, struct list_head *pages_list);
+void iopt_free_pages_list(struct list_head *pages_list);
+enum {
+	IOPT_ALLOC_IOVA = 1 << 0,
 };
+int iopt_map_user_pages(struct iommufd_ctx *ictx, struct io_pagetable *iopt,
+			unsigned long *iova, void __user *uptr,
+			unsigned long length, int iommu_prot,
+			unsigned int flags);
+int iopt_map_pages(struct io_pagetable *iopt, struct list_head *pages_list,
+		   unsigned long length, unsigned long *dst_iova,
+		   int iommu_prot, unsigned int flags);
+int iopt_unmap_iova(struct io_pagetable *iopt, unsigned long iova,
+		    unsigned long length, unsigned long *unmapped);
+int iopt_unmap_all(struct io_pagetable *iopt, unsigned long *unmapped);
+
+int iopt_table_add_domain(struct io_pagetable *iopt,
+			  struct iommu_domain *domain);
+void iopt_table_remove_domain(struct io_pagetable *iopt,
+			      struct iommu_domain *domain);
+int iopt_table_enforce_group_resv_regions(struct io_pagetable *iopt,
+					  struct device *device,
+					  struct iommu_group *group,
+					  phys_addr_t *sw_msi_start);
+int iopt_set_allow_iova(struct io_pagetable *iopt,
+			struct rb_root_cached *allowed_iova);
+int iopt_reserve_iova(struct io_pagetable *iopt, unsigned long start,
+		      unsigned long last, void *owner);
+void iopt_remove_reserved_iova(struct io_pagetable *iopt, void *owner);
+int iopt_cut_iova(struct io_pagetable *iopt, unsigned long *iovas,
+		  size_t num_iovas);
+void iopt_enable_large_pages(struct io_pagetable *iopt);
+int iopt_disable_large_pages(struct io_pagetable *iopt);
 
 struct iommufd_ucmd {
 	struct iommufd_ctx *ictx;
@@ -130,4 +174,12 @@ struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
 			     type),                                            \
 		     typeof(*(ptr)), obj)
 
+struct iommufd_access {
+	unsigned long iova_alignment;
+	u32 iopt_access_list_id;
+};
+
+int iopt_add_access(struct io_pagetable *iopt, struct iommufd_access *access);
+void iopt_remove_access(struct io_pagetable *iopt,
+			struct iommufd_access *access);
 #endif
-- 
2.38.1

