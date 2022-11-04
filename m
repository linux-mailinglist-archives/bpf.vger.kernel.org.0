Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D7C619C55
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 16:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbiKDP65 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 11:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbiKDP6t (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 11:58:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC7431DFA
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 08:58:47 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4FOAbK029158;
        Fri, 4 Nov 2022 15:58:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=adHgz4kVbI901SIIOaK8yYmP+d+eeCOJ7yXT4FKlmrA=;
 b=W7J7gfghc0A0N6DXW5hv1VyuaTiMPZVkn8Be9bxzfPwxMCO+cBsywGWAaxGdVaNEBsWb
 2ixIK7Qhd4wqRuqpcEWSY8tcD8raSBtv4gdhD1hYxlL1wDP/1djXtVJgBcYrXCVD8JnC
 Gxy39Izd4iRThxU2JBxkTHdWfMXi/L+dd9Ce/MWAMAlHSUqO/aA1XW/S+uIf8YNrzlay
 oM27ZYGgl63jg891o0Ux9eBTT7sPK06+pA6cvdjLp9l1G5+IytB16Gwsa4fzkdrdtz/o
 ETLa3zON/o2TySyBQ6f3UKEj8eJ9IUYrc1xCqhT8r1Xa0MDRZvW8S/R25rMPhTFNuHbz eA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgv2ar3pc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Nov 2022 15:58:27 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4EF5qg023389;
        Fri, 4 Nov 2022 15:58:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kmpwnpedf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Nov 2022 15:58:26 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A4FwITm025431;
        Fri, 4 Nov 2022 15:58:26 GMT
Received: from myrouter.uk.oracle.com (dhcp-10-175-178-135.vpn.oracle.com [10.175.178.135])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3kmpwnpe7w-3;
        Fri, 04 Nov 2022 15:58:25 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     andrii@kernel.org, ast@kernel.org, martin.lau@linux.dev,
        daniel@iogearbox.net
Cc:     song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, masahiroy@kernel.org, michal.lkml@markovi.net,
        ndesaulniers@google.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next 2/2] bpf: allow opt-out from using split BTF for modules
Date:   Fri,  4 Nov 2022 15:58:07 +0000
Message-Id: <1667577487-9162-3-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1667577487-9162-1-git-send-email-alan.maguire@oracle.com>
References: <1667577487-9162-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_11,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211040104
X-Proofpoint-ORIG-GUID: 89Ov_aqinCCPWeaWAJc8bulKoF5PAQjH
X-Proofpoint-GUID: 89Ov_aqinCCPWeaWAJc8bulKoF5PAQjH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

By having a BTF_BASE variable defaulting to using vmlinux
as base BTF, we allow module builders to build standalone
BTF such that it is generated independently and not
de-duplicated with core vmlinux BTF.  This allows such
modules to be more resilient to changes in vmlinux BTF
if they occur, as would happen if a change resulted in
a different vmlinux BTF id mapping.

Opt-out of split BTF is done via

 make BTF_BASE= M=path/2/module

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 scripts/Makefile.modfinal | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 25bedd8..7294918 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -30,6 +30,8 @@ quiet_cmd_cc_o_c = CC [M]  $@
 
 ARCH_POSTLINK := $(wildcard $(srctree)/arch/$(SRCARCH)/Makefile.postlink)
 
+BTF_BASE := --btf_base vmlinux
+
 quiet_cmd_ld_ko_o = LD [M]  $@
       cmd_ld_ko_o +=							\
 	$(LD) -r $(KBUILD_LDFLAGS)					\
@@ -44,7 +46,7 @@ quiet_cmd_btf_ko = BTF [M] $@
 	elif [ -n "$(CONFIG_RUST)" ] && $(srctree)/scripts/is_rust_module.sh $@; then 		\
 		printf "Skipping BTF generation for %s because it's a Rust module\n" $@ 1>&2; \
 	else								\
-		LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) --btf_base vmlinux $@; \
+		LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) $(BTF_BASE) $@; \
 		$(RESOLVE_BTFIDS) -b vmlinux $@; 			\
 	fi;
 
-- 
1.8.3.1

