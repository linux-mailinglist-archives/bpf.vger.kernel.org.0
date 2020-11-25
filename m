Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5E02C36B6
	for <lists+bpf@lfdr.de>; Wed, 25 Nov 2020 03:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgKYCUy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Nov 2020 21:20:54 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57050 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725616AbgKYCUx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 24 Nov 2020 21:20:53 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AP24vW0064944;
        Tue, 24 Nov 2020 21:20:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=1UoIOVcvh0hbYFn1xsc3ArW7972Yu0vK1B/8QcLbzoM=;
 b=R6maUKMAn5RmXDZOsTi4DSJuT4B/HCR7BFz3SjhldmUsPcvKppFkgkj7+w7tVwv/LzK3
 N55TqTZ1ZUGm+g8jBqh5z2L/i7tC0juKV82qlXh38D5BZri5rdqQpO2x7FPQfAqGDoFE
 jsM9BkDKFrRPu5h9+IgNWgpvTFe+Q8hrReb+dPlvTHG0WBn1lNZg6jBskF1l2HqTexj2
 nxO34mDoVviOTZ+iIITKlvyXnOJfd8lU8kmJTLI7MIzRa2QmsNOdb6LmQjcHs5ccoYgb
 nVwDJdx8oJjzXU+RhhiEfZ3zXeoirMig0idlTn3L5aMH+ESQuC7Er17TN8FcwFWQlsT1 Uw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 350vbvub6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Nov 2020 21:20:39 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AP2HFxk022126;
        Wed, 25 Nov 2020 02:20:37 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3518j8g7w1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Nov 2020 02:20:37 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AP2KY8C48628164
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Nov 2020 02:20:35 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A90DF52057;
        Wed, 25 Nov 2020 02:20:34 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.82.212])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id D00D252052;
        Wed, 25 Nov 2020 02:20:32 +0000 (GMT)
Message-ID: <adaa989215f4b748eb817d15bd3c2e8db2cbee3c.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next v3 3/3] bpf: Add a selftest for
 bpf_ima_inode_hash
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     KP Singh <kpsingh@chromium.org>, James Morris <jmorris@namei.org>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Date:   Tue, 24 Nov 2020 21:20:31 -0500
In-Reply-To: <20201124151210.1081188-4-kpsingh@chromium.org>
References: <20201124151210.1081188-1-kpsingh@chromium.org>
         <20201124151210.1081188-4-kpsingh@chromium.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-24_11:2020-11-24,2020-11-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 clxscore=1015 impostorscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011250007
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2020-11-24 at 15:12 +0000, KP Singh wrote:
> diff --git a/tools/testing/selftests/bpf/ima_setup.sh b/tools/testing/selftests/bpf/ima_setup.sh
> new file mode 100644
> index 000000000000..15490ccc5e55
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/ima_setup.sh
> @@ -0,0 +1,80 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set -e
> +set -u
> +
> +IMA_POLICY_FILE="/sys/kernel/security/ima/policy"
> +TEST_BINARY="/bin/true"
> +
> +usage()
> +{
> +        echo "Usage: $0 <setup|cleanup|run> <existing_tmp_dir>"
> +        exit 1
> +}
> +
> +setup()
> +{
> +        local tmp_dir="$1"
> +        local mount_img="${tmp_dir}/test.img"
> +        local mount_dir="${tmp_dir}/mnt"
> +        local copied_bin_path="${mount_dir}/$(basename ${TEST_BINARY})"
> +        mkdir -p ${mount_dir}
> +
> +        dd if=/dev/zero of="${mount_img}" bs=1M count=10
> +
> +        local loop_device="$(losetup --find --show ${mount_img})"
> +
> +        mkfs.ext4 "${loop_device}"
> +        mount "${loop_device}" "${mount_dir}"
> +
> +        cp "${TEST_BINARY}" "${mount_dir}"
> +        local mount_uuid="$(blkid -s UUID -o value ${loop_device})"
> +        echo "measure func=BPRM_CHECK fsuuid=${mount_uuid}" > ${IMA_POLICY_FILE}

Anyone using IMA, normally define policy rules requiring the policy
itself to be signed.   Instead of writing the policy rules, write the
signed policy file pathname.  Refer to dracut commit 479b5cd9
("98integrity: support validating the IMA policy file signature").

Both enabling IMA_APPRAISE_REQUIRE_POLICY_SIGS and the builtin
"appraise_tcb" policy require loading a signed policy.

Mimi

