Return-Path: <bpf+bounces-12149-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E404B7C88C0
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 17:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E808B20BD5
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 15:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2521BDC3;
	Fri, 13 Oct 2023 15:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="u243HdG8"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBFC1B299
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 15:34:49 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724ECBE
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 08:34:47 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39DE0pDC015815;
	Fri, 13 Oct 2023 15:34:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=U/8V6Hk6uNkgFkFPChFeL4DwpIIttQyX+ss3qcIhTvc=;
 b=u243HdG8uY/R3JEmxKnVOFkp8Ul3PWoFRkSiOE/YiTRf/odf+QyDZAOuTj9YoKbmpTxd
 j3KExTZoCFsvniZ/mkeyj9N1tQIfZCDUzW6RmwG6ZtWxCDny22PWru1QwHVWNix2+a0s
 Du0xa6eXY3Gs/5qZcPhrVEjyCJYz59hbImo2r9k3Ices/jyFaBeu/CMOto8NiqPSOQRC
 Rn5CW/PbKScJ/C8oqPTJJee8kLCDVSkeHkaTlQTRanhr1cclvFreDKwmhrT1tLRjS7II
 pub8O10gh74HWSIQuZmwfdrsjm7ORmTc2YZPNTY9hiHpy1bPQNeDxN5/fEOG64h3YsY5 kA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjx8cnbwu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Oct 2023 15:34:21 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39DEu4Fx039203;
	Fri, 13 Oct 2023 15:34:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tpt0u1xc7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Oct 2023 15:34:04 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39DFY4GP030819;
	Fri, 13 Oct 2023 15:34:04 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-183-179.vpn.oracle.com [10.175.183.179])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3tpt0u1x9h-1;
	Fri, 13 Oct 2023 15:34:03 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org, andrii.nakryiko@gmail.com
Cc: jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 dwarves 0/5] pahole, btf_encoder: support --btf_features
Date: Fri, 13 Oct 2023 16:33:54 +0100
Message-Id: <20231013153359.88274-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_06,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310130132
X-Proofpoint-ORIG-GUID: Vom5zXzG_6_1NQqleoKGQ-qojQpifv9a
X-Proofpoint-GUID: Vom5zXzG_6_1NQqleoKGQ-qojQpifv9a
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
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

To better future-proof this process, this series introduces a
single "btf_features" parameter that uses a comma-separated list
of encoding options.  This is helpful because

- the semantics are simpler for the user; the list comprises the set of
  BTF features asked for, rather than having to specify a combination of
  --skip_encoding_btf_feature and --btf_gen_feature options; and
- any version of pahole that supports --btf_features can accept the
  option list; unknown options are silently ignored.  As a result, there
  would be no need to add additional version clauses beyond

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
out when it encounters unrecognized features (this ensures
an older pahole without a requested feature will not dump warnings
in the build log for kernel/module BTF generation).  Patch 5
adds --btf_features_strict, which is identical to --btf_features
aside from the fact it will fail if an unrecognized feature is used.

See [1] for more background on this topic.

Changes since RFC [2]:

- ensure features are disabled unless requested; use "default" field in
  "struct btf_features" to specify the conf_load default value which
  corresponds to the feature being disabled.  For
  conf_load->btf_gen_floats for example, the default value is false,
  while for conf_load->skip_encoding_btf_type_tags the default is
  true; in both cases the intent is to _not_ encode the associated
  feature by default.  However if the user specifies "float" or
  "type_tag" in --btf_features, the default conf_load value is negated,
  resulting in a BTF encoding that contains floats and type tags
  (Eduard, patch 3)
- clarify feature default/setting behaviour and how it only applies
  when --btf_features is used (Eduard, patch 3)
- ensure we do not run off the end of the feature_list[] array
  (Eduard, patch 3)
- rather than having each struct btf_feature record the offset in the
  conf_load structure of the boolean (requiring us to later do pointer
  math to update it), record the pointers to the boolean conf_load
  values associated with each feature (Jiri, patch 3)
- allow for multiple specifications of --btf_features, enabling the
  union of all features specified (Andrii, patch 3)
- rename function-related optimized/consistent to optimized_func and
  consistent_func in recognition of the fact they are function-specific
  (Andrii, patch 3)
- add a strict version of --btf_features, --btf_features_strict that
  will error out if an unrecognized feature is used (Andrii, patch 5)

[1] https://lore.kernel.org/bpf/CAEf4Bzaz1UqqxuZ7Q+KQee-HLyY1nwhAurBE2n9YTWchqoYLbg@mail.gmail.com/
[2] https://lore.kernel.org/bpf/20231011091732.93254-1-alan.maguire@oracle.com/

Alan Maguire (5):
  btf_encoder, pahole: move btf encoding options into conf_load
  dwarves: move ARRAY_SIZE() to dwarves.h
  pahole: add --btf_features support
  pahole: add --supported_btf_features
  pahole: add --btf_features_strict to reject unknown BTF features

 btf_encoder.c      |   8 +--
 btf_encoder.h      |   2 +-
 dwarves.c          |  16 -----
 dwarves.h          |  19 ++++++
 man-pages/pahole.1 |  32 +++++++++
 pahole.c           | 167 +++++++++++++++++++++++++++++++++++++++++----
 6 files changed, 210 insertions(+), 34 deletions(-)

-- 
2.31.1


