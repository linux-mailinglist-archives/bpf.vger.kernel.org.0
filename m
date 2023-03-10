Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CE16B4072
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 14:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjCJNa7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 08:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjCJNaz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 08:30:55 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B691009DA;
        Fri, 10 Mar 2023 05:30:54 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32ACdDSO031124;
        Fri, 10 Mar 2023 13:30:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=7T7M4ZBh+sWIlR0wrgSnys7iGCXB+Ut+3nJ6W4l+RWU=;
 b=lM+xVsx+XYYJc5NdNzRzn92vioHQEJX5B2IjC1IQugP1+Ux4mf9vqga7SnijJpXwcacZ
 FgT5L08w2BZEjTkknD+dcMJORZXvpfzaOLaq5/CbehD6OMJOM/LlORlR9hmTbcbPmII3
 ChASSQmktW8lIbbcZcD8dTvQ9GadPlhPe+9axrPSSQ6qdoW5Y9oVXmQ0lap1VbzJg6yE
 T6AE8RL95MGxFvROnVcCzuTeOGSDq05uWylsYhXEgqrbKxdfLVID5hGBQMR1gI1kNr0h
 F5gLPZjevx0TY8TICuDDkbJ2goek2VOP/RFv5Y4D9F7bbTHEJW8gdno7VNPRa1n+kl5w Kg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p80wdpxtc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Mar 2023 13:30:30 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32ADTTiE023467;
        Fri, 10 Mar 2023 13:30:30 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p80wdpxsk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Mar 2023 13:30:30 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32ACj5hE014445;
        Fri, 10 Mar 2023 13:30:28 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([9.208.130.102])
        by ppma05wdc.us.ibm.com (PPS) with ESMTPS id 3p6fhhy4nm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Mar 2023 13:30:28 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32ADURE932309610
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 13:30:27 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F99A58064;
        Fri, 10 Mar 2023 13:30:27 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F244358062;
        Fri, 10 Mar 2023 13:30:25 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.71.208])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 10 Mar 2023 13:30:25 +0000 (GMT)
Message-ID: <292a8cf196bd13745df5d3eb34f1e645fc66951d.camel@linux.ibm.com>
Subject: Re: [PATCH v4 3/3] security: Remove integrity from the LSM list in
 Kconfig
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, mic@digikod.net
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Fri, 10 Mar 2023 08:30:25 -0500
In-Reply-To: <20230310085401.1964889-4-roberto.sassu@huaweicloud.com>
References: <20230310085401.1964889-1-roberto.sassu@huaweicloud.com>
         <20230310085401.1964889-4-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1ZuWZ0CMiLtkTx23FdVHMmYcoojhRgMu
X-Proofpoint-GUID: 8nu5GhKzlNdCFXPsM0on-jVzOUYoIen5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_03,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 bulkscore=0
 clxscore=1015 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303100104
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2023-03-10 at 09:54 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Remove 'integrity' from the list of LSMs in Kconfig, as it is no longer
> necessary. Since the recent change (set order to LSM_ORDER_LAST), the
> 'integrity' LSM is always enabled (if selected in the kernel
> configuration).
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Acked-by: Mimi Zohar <zohar@linux.ibm.com>b

