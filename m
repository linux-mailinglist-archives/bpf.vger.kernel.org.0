Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 058D326399D
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 03:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgIJB6s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 21:58:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61396 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728971AbgIJBkX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Sep 2020 21:40:23 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 089MWYau086231;
        Wed, 9 Sep 2020 18:50:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=RRr2AhMntElCE2e8/bydu4WrV9n+FB7z0ZGETqXa5HI=;
 b=ip8DcvwDfi3ym3nC5/W9ZPfnZobJMmak84saep+XgpDs9/eAqupv/Ia1Pjy/J3qrxhop
 WgQEtyfZDViMtcEZ5EjO7G7rKQDmeg96b8rdflh1WkwzTeNXJtxzqCC3+MDOb5u5UqgA
 a7MSZbGzxBVlF5fOhsoo070TMx8B1fUrFanvK0vRNR9Q9SYfH64GSdIOVPeBUMsPXqcw
 UXCEuu2xv0Lg+lcskH+/9AKI2rCNFz0LwwF3NOT0V4zPCprWyekq+7SykVZUyr9xAZb8
 4evJ713jeEuFViGV4WrSF2qNvetkYk4evtFwTrr+k8yeT24ZJ2RQdZbzROQnK3HvjXVz nA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33f78vsbfu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 18:50:27 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 089MgeM2026463;
        Wed, 9 Sep 2020 22:50:25 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 33dxdr2f97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 22:50:24 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 089MoMY627197742
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Sep 2020 22:50:22 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B09BBA4057;
        Wed,  9 Sep 2020 22:50:22 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E4EEA4040;
        Wed,  9 Sep 2020 22:50:22 +0000 (GMT)
Received: from sig-9-145-5-224.uk.ibm.com (unknown [9.145.5.224])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Sep 2020 22:50:22 +0000 (GMT)
Message-ID: <ba11b067a4d9635ee4e28ccc1b2896cc9c8c5be1.camel@linux.ibm.com>
Subject: Re: [PATCH v3 bpf-next 3/9] selftests/bpf: add __ksym extern
 selftest
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org
Date:   Thu, 10 Sep 2020 00:50:22 +0200
In-Reply-To: <20200619231703.738941-4-andriin@fb.com>
References: <20200619231703.738941-1-andriin@fb.com>
         <20200619231703.738941-4-andriin@fb.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-09_17:2020-09-09,2020-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 suspectscore=3 clxscore=1015 phishscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009090192
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi!

On Fri, 2020-06-19 at 16:16 -0700, Andrii Nakryiko wrote:
> Validate libbpf is able to handle weak and strong kernel symbol
> externs in BPF
> code correctly.
> 
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> ---
>  .../testing/selftests/bpf/prog_tests/ksyms.c  | 71
> +++++++++++++++++++
>  .../testing/selftests/bpf/progs/test_ksyms.c  | 32 +++++++++
>  2 files changed, 103 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/ksyms.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_ksyms.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/ksyms.c
> b/tools/testing/selftests/bpf/prog_tests/ksyms.c
> new file mode 100644
> index 000000000000..e3d6777226a8
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/ksyms.c
> @@ -0,0 +1,71 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2019 Facebook */
> +
> +#include <test_progs.h>
> +#include "test_ksyms.skel.h"
> +#include <sys/stat.h>
> +
> +static int duration;
> +
> +static __u64 kallsyms_find(const char *sym)
> +{
> +	char type, name[500];
> +	__u64 addr, res = 0;
> +	FILE *f;
> +
> +	f = fopen("/proc/kallsyms", "r");
> +	if (CHECK(!f, "kallsyms_fopen", "failed to open: %d\n", errno))
> +		return 0;
> +
> +	while (fscanf(f, "%llx %c %499s%*[^\n]\n", &addr, &type, name)
> > 0) {
> +		if (strcmp(name, sym) == 0) {
> +			res = addr;
> +			goto out;
> +		}
> +	}
> +
> +	CHECK(false, "not_found", "symbol %s not found\n", sym);
> +out:
> +	fclose(f);
> +	return res;
> +}
> +
> +void test_ksyms(void)
> +{
> +	__u64 link_fops_addr = kallsyms_find("bpf_link_fops");
> +	const char *btf_path = "/sys/kernel/btf/vmlinux";
> +	struct test_ksyms *skel;
> +	struct test_ksyms__data *data;
> +	struct stat st;
> +	__u64 btf_size;
> +	int err;
> +
> +	if (CHECK(stat(btf_path, &st), "stat_btf", "err %d\n", errno))
> +		return;
> +	btf_size = st.st_size;
> +
> +	skel = test_ksyms__open_and_load();
> +	if (CHECK(!skel, "skel_open", "failed to open and load
> skeleton\n"))
> +		return;
> +
> +	err = test_ksyms__attach(skel);
> +	if (CHECK(err, "skel_attach", "skeleton attach failed: %d\n",
> err))
> +		goto cleanup;
> +
> +	/* trigger tracepoint */
> +	usleep(1);
> +
> +	data = skel->data;
> +	CHECK(data->out__bpf_link_fops != link_fops_addr,
> "bpf_link_fops",
> +	      "got 0x%llx, exp 0x%llx\n",
> +	      data->out__bpf_link_fops, link_fops_addr);
> +	CHECK(data->out__bpf_link_fops1 != 0, "bpf_link_fops1",
> +	      "got %llu, exp %llu\n", data->out__bpf_link_fops1,
> (__u64)0);
> +	CHECK(data->out__btf_size != btf_size, "btf_size",
> +	      "got %llu, exp %llu\n", data->out__btf_size, btf_size);
> +	CHECK(data->out__per_cpu_start != 0, "__per_cpu_start",
> +	      "got %llu, exp %llu\n", data->out__per_cpu_start,
> (__u64)0);
> +
> +cleanup:
> +	test_ksyms__destroy(skel);
> +}

Why is __per_cpu_start expected to be 0? On my x86_64 Debian VM it is
something like ffffffffxxxxxxxx, and this test fails. Wouldn't
it be better to take the value from kallsyms, like it's done with
bpf_link_fops, or am I missing something in my setup?

Best regards,
Ilya

