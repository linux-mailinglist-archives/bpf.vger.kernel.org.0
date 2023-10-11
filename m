Return-Path: <bpf+bounces-11874-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C08267C4E55
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 11:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7730128212C
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 09:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E11E1B263;
	Wed, 11 Oct 2023 09:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l0O/b2Os"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4751A713
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 09:18:01 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1019094
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 02:17:58 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39B7mm7i024476;
	Wed, 11 Oct 2023 09:17:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=UhqylAxiFMozlxznFxOIpQlAQohS3tdhXOAa/rRQ6YA=;
 b=l0O/b2OsukrHq0g38Vsy+V41au1YPhIR2KAN9kY/oX72lUHjNBSvNaW7hyiE5ExX0LOl
 RvSc9/TMlKpZjOO04F0PWYinpM86Zeoiz7bsZAAd7iTLXkC51u9zzDG6zXAd5WTF/uu5
 8JFcfigOoqUFcLDryUgGZ+JtHDwfnMwxGu+zV1PUH79OkIXZgCPd1BquU4NZqoGh63Hu
 Dmknw46/LZCC1/YSheb9YM521T8YkclYhWZBOG/HvnVLLEFDyXzEdFgLOlfzUG95HTNv
 +DOaqEe2Pa+59tRFiz+mgaf6hLVc8+NWm4MFuLeJ1IhByr4fnoLBfdOloyxjJp2YfhLj yA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjxxu7arx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Oct 2023 09:17:39 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39B8RDZJ014881;
	Wed, 11 Oct 2023 09:17:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tjws8d0wp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Oct 2023 09:17:38 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39B9Hbxi020344;
	Wed, 11 Oct 2023 09:17:37 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-183-173.vpn.oracle.com [10.175.183.173])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3tjws8d0tb-1;
	Wed, 11 Oct 2023 09:17:37 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org, andrii.nakryiko@gmail.com
Cc: jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC dwarves 0/4] pahole, btf_encoder: support --btf_features
Date: Wed, 11 Oct 2023 10:17:28 +0100
Message-Id: <20231011091732.93254-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_06,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310110081
X-Proofpoint-GUID: KpxDpYPY95Bev5MlDxcmRH67tZ-7kLNC
X-Proofpoint-ORIG-GUID: KpxDpYPY95Bev5MlDxcmRH67tZ-7kLNC
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Currently, the kernel uses pahole version checking as the way to
determine which BTF encoding features to request from pahole.  This
means that such features have to be tied to a specific version and
as new features are added, additional clauses in scripts/pahole-flags.sh
have to be added; for example

if [ "${pahole_ver}" -ge "125" ]; then
	extra_paholeopt="${extra_paholeopt} --skip_encoding_btf_inconsistent_proto --btf_gen_optimized"
fi

To better future-proof this process, we can have a catch-all
single "btf_features" parameter that uses a comma-separated list
of encoding options.  What makes this better is that any version
of pahole that supports btf_features can accept the option list;
unknown options are silently ignored. However there would be no need
to add additional version clauses beyond

if [ "${pahole_ver}" -ge "126" ]; then
	extra_pahole_opt="-j --lang_exclude=rust
--btf_features=encode_force,var,float,decl_tag,type_tag,enum64,optimized,consistent"
fi

Newly-supported features would simply be appended to the btf_features
list, and these would have impact on BTF encoding only if the features
were supported by pahole.  This means pahole will not require a version
bump when new BTF features are added, and should ease the burden of
coordinating such changes between bpf-next and dwarves.

Patches 1 and 2 are preparatory work, while patch 3 adds the
--btf_features support.  Patch 4 provides a means of querying
the supported feature set since --btf_features will not error
out when it encounters an unrecognized features (this ensures
an older pahole without a requested feature will not dump warnings
in the build log for kernel/module BTF generation).

See [1] for more background on this topic.

[1] https://lore.kernel.org/bpf/CAEf4Bzaz1UqqxuZ7Q+KQee-HLyY1nwhAurBE2n9YTWchqoYLbg@mail.gmail.com/

Alan Maguire (4):
  btf_encoder, pahole: move btf encoding options into conf_load
  dwarves: move ARRAY_SIZE() to dwarves.h
  pahole: add --btf_features=feature1[,feature2...] support
  pahole: add --supported_btf_features to display feature support

 btf_encoder.c      |   8 +--
 btf_encoder.h      |   2 +-
 dwarves.c          |  16 ------
 dwarves.h          |  19 +++++++
 man-pages/pahole.1 |  24 +++++++++
 pahole.c           | 127 ++++++++++++++++++++++++++++++++++++++++-----
 6 files changed, 162 insertions(+), 34 deletions(-)

-- 
2.31.1


