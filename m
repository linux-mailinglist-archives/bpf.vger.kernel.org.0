Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A876B4812
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 15:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbjCJO6R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 09:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233669AbjCJO5t (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 09:57:49 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A4C12871
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 06:52:38 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32AAlRBu008506;
        Fri, 10 Mar 2023 14:50:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=PeLY+a/4QwWZ+hC7+Qzptq8rBDZJ/BkNNzhiMLF2pXI=;
 b=P8KpNYH/3tNhAifqexNGDpjMWaCFJMkib5eA3oizb88anVWLn95RsbA3G4pOAWcB/tY4
 vadbY8W/8pgA0ZDzLzfNmFcZo8/HS8+JZKXyLyzW1KKg/8xDzCBJr/OQEmUz3uG6qC2+
 SNt4dh+eclDIG2SEn577/UwcpiNRnQn9gvlYJg9Nigpf2qAUqSScNT9QPREupMbhX3he
 5t18j0kYz++ZAFBQuTC2N1qN/AcrluLQ8n6Sx+H5Q/+Abdb/lkcsrigu7NGF65YjHvXS
 +e38KBaAOWcrJLZc+SxZEBFRHdo3RDJKWeoWj98i/zK8WFD3rPPOwbgr1O5H4FxVnDs7 yQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p417cnc4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 14:50:55 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32AECkWH020848;
        Fri, 10 Mar 2023 14:50:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p6fub0dqe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 14:50:54 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32AEosCL013152;
        Fri, 10 Mar 2023 14:50:54 GMT
Received: from myrouter.uk.oracle.com (dhcp-10-175-184-199.vpn.oracle.com [10.175.184.199])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3p6fub0dkf-1;
        Fri, 10 Mar 2023 14:50:54 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     acme@kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        eddyz87@gmail.com, haoluo@google.com, jolsa@kernel.org,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        sinquersw@gmail.com, martin.lau@kernel.org, songliubraving@fb.com,
        sdf@google.com, timo@incline.eu, yhs@fb.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 0/3] dwarves: improve BTF encoder comparison method
Date:   Fri, 10 Mar 2023 14:50:47 +0000
Message-Id: <1678459850-16140-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_06,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=748 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303100121
X-Proofpoint-GUID: BSLKCBT2kzzZ7vOJ48vP0ol_HuSAxl1b
X-Proofpoint-ORIG-GUID: BSLKCBT2kzzZ7vOJ48vP0ol_HuSAxl1b
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently when looking for function prototype mismatches with a view
to excluding inconsistent functions, we fall back to a comparison
between parameter names when the name and number of parameters match.
This is brittle, as it is sometimes the case that a function has
multiple type-identical definitions which use different parameters.

Here the existing dwarves_fprintf functionality is re-used to instead
create a string representation of the function prototype - minus the
parameter names - to support a less brittle comparison method.

To support this, patch 1 generalizes function prototype print to
take a conf_fprintf parameter; this allows us to customize the
parameters we use in prototype string generation.

Patch 2 supports generating prototypes without modifiers such
as const as they can lead to false positive prototype mismatches;
see the patch for details.

Finally patch 3 replaces the logic used to compare parameter
names with the prototype string comparison instead.

Using verbose pahole output we can see some of the rejected
comparisons.  73 comparisons are rejected via prototype
comparison, 63 of which are non "."-suffixed functions.  For
example:

function mismatch for 'name_show'('name_show'): 'ssize_t ()(struct kobject *, struct kobj_attribute *, char *)' != 'ssize_t ()(struct device *, struct device_attribute *, char *)'

With these changes, the syscalls defined in sys_ni.c
that Jiri mentioned were missing [1] are present in BTF:

[43071] FUNC '__ia32_compat_sys_io_setup' type_id=42335 linkage=static
[43295] FUNC '__ia32_sys_io_setup' type_id=42335 linkage=static
[47536] FUNC '__x64_sys_io_setup' type_id=42335 linkage=static

[43290] FUNC '__ia32_sys_io_destroy' type_id=42335 linkage=static
[47531] FUNC '__x64_sys_io_destroy' type_id=42335 linkage=static

[43072] FUNC '__ia32_compat_sys_io_submit' type_id=42335 linkage=static
[43296] FUNC '__ia32_sys_io_submit' type_id=42335 linkage=static
[47537] FUNC '__x64_sys_io_submit' type_id=42335 linkage=static

[1] https://lore.kernel.org/bpf/ZAsBYpsBV0wvkhh0@krava/

Alan Maguire (3):
  dwarves_fprintf: generalize function prototype print to support
    passing conf
  dwarves_fprintf: support skipping modifier
  btf_encoder: compare functions via prototypes not parameter names

 btf_encoder.c     | 67 +++++++++++++++++++++++++------------------------------
 dwarves.h         |  6 +++++
 dwarves_fprintf.c | 48 ++++++++++++++++++++++++++-------------
 3 files changed, 70 insertions(+), 51 deletions(-)

-- 
1.8.3.1

