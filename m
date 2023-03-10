Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294476B406E
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 14:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjCJNax (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 08:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjCJNaw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 08:30:52 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37171009D2;
        Fri, 10 Mar 2023 05:30:49 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32ACCBYh015137;
        Fri, 10 Mar 2023 13:30:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=asYICjIrjQrbR77e2tmK7a69X9wRaG/debRPa7BHsck=;
 b=hz7KbY3BGPI5wPZaMVeD45ZG9+PA/Fd9hRfNv1m69OckQBgfyA0K8UZb4Vif0ljtw9SV
 Iz+aLB1pPx2VMXat2XqiEQQBZt1ZgYrTxgeXNiedZYid8Ko5NA6j8OVzpWRJyyZwtwV7
 7PJ0cimAyGWyPa0nBHYybn4uzfoNC69EsF18LsbzSv0sCANz9YR94UzQ8d2L/76KlmQF
 rDLGTny3iqcqAkei/rXzdToEtJ2BV/9a4BeABzC4yKKlRL8GkYcO7bduVb9p2EOCMq25
 SWP8Epxxum0yu66MkAcB6trk9ft941qBwEOm9gs86LIeUo7Mf2nnrbpuu/pCz7E0EkWz vg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p84be1urb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Mar 2023 13:30:21 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32AD0Nh6009740;
        Fri, 10 Mar 2023 13:30:20 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p84be1uqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Mar 2023 13:30:20 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32AClFDh007600;
        Fri, 10 Mar 2023 13:30:19 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([9.208.129.120])
        by ppma03wdc.us.ibm.com (PPS) with ESMTPS id 3p6fmy7448-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Mar 2023 13:30:19 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32ADUI2e13107786
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 13:30:18 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C93D5805F;
        Fri, 10 Mar 2023 13:30:18 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E760B58045;
        Fri, 10 Mar 2023 13:30:16 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.71.208])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 10 Mar 2023 13:30:16 +0000 (GMT)
Message-ID: <aea1e9de5120522be376e29828991f8975d3c165.camel@linux.ibm.com>
Subject: Re: [PATCH v4 1/3] security: Introduce LSM_ORDER_LAST and set it
 for the integrity LSM
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, mic@digikod.net
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Fri, 10 Mar 2023 08:30:16 -0500
In-Reply-To: <20230310085401.1964889-2-roberto.sassu@huaweicloud.com>
References: <20230310085401.1964889-1-roberto.sassu@huaweicloud.com>
         <20230310085401.1964889-2-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QhnLh_pJkHytYD-v3mK939KA5L0zcvjn
X-Proofpoint-ORIG-GUID: WMY2OYkPrgpJefZDEKM2bbSCbOATQIQN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_03,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=803
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303100104
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2023-03-10 at 09:53 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Introduce LSM_ORDER_LAST, to satisfy the requirement of LSMs needing to be
> last, e.g. the 'integrity' LSM, without changing the kernel command line or
> configuration.
> 
> Also, set this order for the 'integrity' LSM. While not enforced, this is
> the only LSM expected to use it.
> 
> Similarly to LSM_ORDER_FIRST, LSMs with LSM_ORDER_LAST are always enabled
> and put at the end of the LSM list, if selected in the kernel
> configuration. Setting one of these orders alone, does not cause the LSMs
> to be selected and compiled built-in in the kernel.
> 
> Finally, for LSM_ORDER_MUTABLE LSMs, set the found variable to true if an
> LSM is found, regardless of its order. In this way, the kernel would not
> wrongly report that the LSM is not built-in in the kernel if its order is
> LSM_ORDER_LAST.
> 
> Fixes: 79f7865d844c ("LSM: Introduce "lsm=" for boottime LSM selection")
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Acked-by: Mimi Zohar <zohar@linux.ibm.com>


