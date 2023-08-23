Return-Path: <bpf+bounces-8347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CB47852EF
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 10:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D40321C20C48
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 08:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B48A934;
	Wed, 23 Aug 2023 08:45:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07333A921;
	Wed, 23 Aug 2023 08:45:25 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D583426B3;
	Wed, 23 Aug 2023 01:45:21 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37N8Scd7016231;
	Wed, 23 Aug 2023 08:44:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=bFCgQ1VwQb87NWxyMzGPyCOeeMqKIRNu44QdUDKyZTk=;
 b=QVqJQnG4yu7qDX29+N189wKIoTyYbLdJp82BvjUIgampmip/MgrA5wn1sQpK6vf68Mq2
 dzif6HtuYw3CwsB4u6IVZuLjv5XFa3WJNI61TVh7LdYeCOE4a6NEGqbxJGCTelOv+Z1g
 5lzQgJTxUUS55Mu5VEybm7+z9Ly1Gjkqqz53gI4ijhqAUyUswIDdbNJKKmv0q0b+qhnB
 RUiSZNNy6wlH/248yckDfB5y5rbAe7YDAFiw9ZSGSM9XBtLqa6djXkheM0tUUUgZiisB
 WdWiJHEY6E60Hi+1qe7P3FhyJUhibbuLeUyeoR+NKGgJY5CPfmf8H7no+RKmzAxRdTyQ ug== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3snemhrfwv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Aug 2023 08:44:57 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37N8ShwU016407;
	Wed, 23 Aug 2023 08:44:56 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3snemhrfwe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Aug 2023 08:44:56 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37N7GMlO018281;
	Wed, 23 Aug 2023 08:44:55 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sn21scwyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Aug 2023 08:44:55 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37N8iqx920972158
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Aug 2023 08:44:52 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 62EBA20040;
	Wed, 23 Aug 2023 08:44:52 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A58A20043;
	Wed, 23 Aug 2023 08:44:49 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 23 Aug 2023 08:44:48 +0000 (GMT)
Date: Wed, 23 Aug 2023 14:14:48 +0530
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Vishal Chourasia <vishalc@linux.ibm.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, haoluo@google.com,
        hawk@kernel.org, john.fastabend@gmail.com, jolsa@kernel.org,
        kpsingh@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
        martin.lau@linux.dev, netdev@vger.kernel.org, sachinp@linux.ibm.com,
        sdf@google.com, song@kernel.org, yhs@fb.com
Subject: Re: [PATCH] Fix invalid escape sequence warnings
Message-ID: <20230823084448.GB1766638@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20230811084739.GY3902@linux.vnet.ibm.com>
 <20230816122133.1231599-1-vishalc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20230816122133.1231599-1-vishalc@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sO97qhLZFWISY1LXlLzevBgAPlc2lsBy
X-Proofpoint-ORIG-GUID: 2CXY-svMiUuv1PZV5YJdNZp7XcNrumXe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_06,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=638
 priorityscore=1501 phishscore=0 clxscore=1015 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308230077
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

* Vishal Chourasia <vishalc@linux.ibm.com> [2023-08-16 17:51:33]:

> The Python script `bpf_doc.py` uses regular expressions with
> backslashes in string literals, which results in SyntaxWarnings
> during its execution.
> 
> This patch addresses these warnings by converting relevant string
> literals to raw strings, which interpret backslashes as literal
> characters. This ensures that the regular expressions are parsed
> correctly without causing any warnings.
> 
> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
> Reported-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

Thanks, Works for me
Tested-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

-- 
Thanks and Regards
Srikar Dronamraju

