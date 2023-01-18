Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829A4670FF4
	for <lists+bpf@lfdr.de>; Wed, 18 Jan 2023 02:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjARB0u (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Jan 2023 20:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjARB0t (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Jan 2023 20:26:49 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD27C196B3
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 17:26:46 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30I0g8Ix029161
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 01:26:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : to : from : subject : content-type :
 content-transfer-encoding; s=pp1;
 bh=bI9GiGxmPo9lhlizeeZGOP94jPdktJcBOYH50yYceG8=;
 b=BYFdCbe6SHpG1CKa9wMANkYZh9optbcLZIVQlMPUR6EDUQtMQqnOdODHnpUZOgDqCzaZ
 bOCJy6rsomYDYSekuElOyaMgms6CunJb9mIJtlk5kf3c8xs9MSZZ5lvg4mqd2RJXD9os
 LI8cG7nXJf3M1RmQhOo6vKl05ge/ACDQ1etNUwcu9BldAjBI15cRpDwm+AnbCttQNZXE
 MsmPtewixP7ntSfmxrRtaoJm8FzFDWNr98MWEbqWAAzEOH92lzUy7MlnH4ey6exv5Tyd
 a9rwlK97tXZP1ij6yUmraHOO45D6BcfCcyJyTisDkunII6PvbHc43AhQSw1BE34m2OeM +g== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n66ey8s2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 01:26:46 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30HMgG7t004689
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 01:26:43 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3n3m16mkba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 01:26:43 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30I1Qf9245547776
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 01:26:41 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 33AC720049
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 01:26:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8CCDB20040
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 01:26:40 +0000 (GMT)
Received: from [9.197.231.165] (unknown [9.197.231.165])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 01:26:40 +0000 (GMT)
Message-ID: <59346030-edd4-30cc-db9e-6fd600713532@linux.vnet.ibm.com>
Date:   Wed, 18 Jan 2023 09:26:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Content-Language: en-US
To:     bpf@vger.kernel.org
From:   dongdwdw <dongdwdw@linux.vnet.ibm.com>
Subject: Question: any hidden in __sk_buff
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lS9dmAfq45pdxwEoBgUdKsdeUYfnfivP
X-Proofpoint-GUID: lS9dmAfq45pdxwEoBgUdKsdeUYfnfivP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_11,2023-01-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 adultscore=0 mlxlogscore=856 suspectscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301180005
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,


Hi Experts,

I am reading ebpf sample code recently. When I read socketx2_kern.c 
socketx2_user.c, I got a question here.

         __u64 proto = load_half(skb, 12);


I can not understand here: It means load 2 bytes from 12th bytes of skb 
address ( it is a pointer of struct__skb_buff ).

struct __sk_buff {

             __u32 len;
             __u32 pkt_type;
             __u32 mark;
             __u32 queue_mapping;
             __u32 protocol;
             __u32 vlan_present;
             __u32 vlan_tci;
             __u32 vlan_proto;

             ******

}

But I found the structure as above. So the reading start point should be 
at queue_mapping. But it actually reads protocol info here. *And I did 
found the result is protocol info*. Why?

The v*alue of pkt_type, mark, and queue_mapping are all 0.* But when to 
read starting from queue_mapping's offset, the info is about protocol. 
It is a little tricky to me. I can not understand this. From my 
pointview, the protocol info should start at 16 bytes.

Is there any background that is hidden from me? I search a lot and 
cannot find any detailed info about this. Please help explain this. 
Thanks so much.

