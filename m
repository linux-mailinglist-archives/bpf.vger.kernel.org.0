Return-Path: <bpf+bounces-800-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3364706F05
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 19:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFF621C2102E
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 17:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4BE31125;
	Wed, 17 May 2023 17:06:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7654E442F
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 17:06:31 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465B693F2
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 10:06:30 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HE4xoN029155;
	Wed, 17 May 2023 16:17:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=L6c3i3a3qPc57CTZ6BRO7Hwogt/2WMSzmQqj/yOMp1s=;
 b=y1/2LuE8jH9wN82De3/UKvsPGpmAWpwfWvo2kszcIE1CoWz8yk+LkP018fIW9NR6ttMt
 mG9dA8Y2Pw7yDjz3lDr+HYEa/ZSI/kRGYTAsf/GGFgZhPBpLUWTHfLm+kGBRLuKktSa7
 h00ZPSL++GmL6zkOXwP70wDzFXLuAROK/i6dZs0orb0cioAJGnMm59xv4yqysIaQdYYo
 sOLvt+q8uNOCPnSfo5qNGxi00YWTlESofUJVgisNclBfmUEfUSu0Gu9NFBr+v9lSnhYt
 7C4kBip5FZj1gQp9tUrWc19z+3sbNOI1fqBEFiCHGi/eFjqaalLV+USic53qgu93wUXQ hg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qmxfc0nwp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 May 2023 16:17:41 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34HFBcww004227;
	Wed, 17 May 2023 16:17:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10bwyet-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 May 2023 16:17:40 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34HGHdX7034295;
	Wed, 17 May 2023 16:17:39 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-213-201.vpn.oracle.com [10.175.213.201])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3qj10bwyb5-1;
	Wed, 17 May 2023 16:17:39 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org, ast@kernel.org, jolsa@kernel.org, yhs@fb.com,
        andrii@kernel.org
Cc: daniel@iogearbox.net, laoar.shao@gmail.com, martin.lau@linux.dev,
        song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC dwarves 0/6] Encoding function addresses using DECL_TAGs
Date: Wed, 17 May 2023 17:16:42 +0100
Message-Id: <20230517161648.17582-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_02,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170132
X-Proofpoint-GUID: p0dAn6IyXUO3_53k6zdq2ienRNSyyX0P
X-Proofpoint-ORIG-GUID: p0dAn6IyXUO3_53k6zdq2ienRNSyyX0P
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

As a means to continue the discussion in [1], which is
concerned with finding the best long-term solution to
having a BPF Type Format (BTF) representation of
functions that is usable for tracing of edge cases, this
proof-of-concept series is intended to explore one approach
to adding information to help make tracing more accurate.

A key problem today is that there is no matching from function
description to the actual instances of a function.

When that function only has one description, that is
not an issue, but if we have multiple inconsistent
static functions in different CUs such as

From kernel/irq/irqdesc.c
    
    static ssize_t wakeup_show(struct kobject *kobj,
                               struct kobj_attribute *attr, char *buf)
    
...and from drivers/base/power/sysfs.c
    
    static ssize_t wakeup_show(struct device *dev, struct device_attribute *attr,
                               char *buf);

...this becomes a problem.  If I am attaching,
which do I want?  And even if I know which one
I want, which instance in kallsyms is which?

This series is a proof-of-concept that supports encoding
function addresses and associating them with BTF FUNC
descriptions using BTF declaration tags.

More work would need to be done on the kernel side
to _use_ this representation, but hopefully having a
rough approach outlined will help make that more feasible.

[1] https://lore.kernel.org/bpf/ZF61j8WJls25BYTl@krava/

Alan Maguire (6):
  btf_encoder: record function address and if it is local
  dwarf_loader: store address in function low_pc if available
  dwarf_loader: transfer low_pc info from subtroutine to its abstract
    origin
  btf_encoder: add "addr=0x<addr>" function declaration tag if
    --btf_gen_func_addr specified
  btf_encoder: store ELF function representations sorted by name _and_
    address
  pahole: document --btf_gen_func_addr

 btf_encoder.c      | 64 +++++++++++++++++++++++++++++++++++-----------
 btf_encoder.h      |  4 +--
 dwarf_loader.c     | 16 +++++++++---
 dwarves.h          |  3 +++
 man-pages/pahole.1 |  8 ++++++
 pahole.c           | 12 +++++++--
 6 files changed, 85 insertions(+), 22 deletions(-)

-- 
2.31.1


