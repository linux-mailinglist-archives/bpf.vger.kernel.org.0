Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C557671483
	for <lists+bpf@lfdr.de>; Wed, 18 Jan 2023 07:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjARGry (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Jan 2023 01:47:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjARGpd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Jan 2023 01:45:33 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAA05D907
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 22:25:40 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30I4s6ZU029161
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 06:25:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : from : to : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ylraSXxVrGZh+1aCJKm+FGYKARsnct93cwjMj/6W/ZQ=;
 b=bisgqa+Hg0grwDqLf+E8jvS4eK8Kfv8mwkOVvLz/oVcsqpvZd+VL86ibg7Myv8f02vlV
 rAB1JsLEITphKXAuCAJ4b2bXgtMs/8lHvGB6Q9cpH4C/kVsXbHOs7JMC9c/S3DCFBk7A
 UUBb3vx8KOhs617lOkwF19S2DW3c/hv3Nji+Xi+P9ZeAjlKoQFalhzDF2UMueN1TfVF6
 ih0GWlNFVQ72xoqKtP9YxAVpRlT96KKGdGehlJnFe+RcXYT99tuuYPIPZsUs7zbLTlXW
 6P5FC6Eicra5h+Bc4m5k5f3FdSdcaI9QNYpEf+P+zHjan7rZ4M6Ihal7B3HcFHag8IkQ hg== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n66eydrcg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 06:25:05 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30HMm8hM023698
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 06:25:03 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3n3m16mu68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 06:25:03 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30I6P1Zu25887286
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 06:25:01 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 373EC20049
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 06:25:01 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 936592004B
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 06:25:00 +0000 (GMT)
Received: from [9.197.231.165] (unknown [9.197.231.165])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 06:25:00 +0000 (GMT)
Message-ID: <72b92403-a477-3468-3e1f-bc8b8ab6ea12@linux.vnet.ibm.com>
Date:   Wed, 18 Jan 2023 14:24:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: Question: any hidden in __sk_buff
Content-Language: en-US
From:   dongdwdw <dongdwdw@linux.vnet.ibm.com>
To:     bpf@vger.kernel.org
References: <59346030-edd4-30cc-db9e-6fd600713532@linux.vnet.ibm.com>
In-Reply-To: <59346030-edd4-30cc-db9e-6fd600713532@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hK0y901x0z-RfDLSDbQfS9BfIgW5NkfV
X-Proofpoint-GUID: hK0y901x0z-RfDLSDbQfS9BfIgW5NkfV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_01,2023-01-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 adultscore=0 mlxlogscore=997 suspectscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301180051
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I found the tricks here. it is BPF_LD_ABS instruction.

On 2023/1/18 09:26, dongdwdw wrote:
> Hi,
>
>
> Hi Experts,
>
> I am reading ebpf sample code recently. When I read socketx2_kern.c 
> socketx2_user.c, I got a question here.
>
>         __u64 proto = load_half(skb, 12);
>
>
> I can not understand here: It means load 2 bytes from 12th bytes of 
> skb address ( it is a pointer of struct__skb_buff ).
>
> struct __sk_buff {
>
>             __u32 len;
>             __u32 pkt_type;
>             __u32 mark;
>             __u32 queue_mapping;
>             __u32 protocol;
>             __u32 vlan_present;
>             __u32 vlan_tci;
>             __u32 vlan_proto;
>
>             ******
>
> }
>
> But I found the structure as above. So the reading start point should 
> be at queue_mapping. But it actually reads protocol info here. *And I 
> did found the result is protocol info*. Why?
>
> The v*alue of pkt_type, mark, and queue_mapping are all 0.* But when 
> to read starting from queue_mapping's offset, the info is about 
> protocol. It is a little tricky to me. I can not understand this. From 
> my pointview, the protocol info should start at 16 bytes.
>
> Is there any background that is hidden from me? I search a lot and 
> cannot find any detailed info about this. Please help explain this. 
> Thanks so much.
>
