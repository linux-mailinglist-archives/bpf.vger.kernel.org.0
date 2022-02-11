Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F354B2487
	for <lists+bpf@lfdr.de>; Fri, 11 Feb 2022 12:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240820AbiBKLiE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Feb 2022 06:38:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345246AbiBKLiD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Feb 2022 06:38:03 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FEC9381
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 03:38:02 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21B8MiZa001247;
        Fri, 11 Feb 2022 11:37:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=MWlKOgEikHFkQbZ2J6EozVGERprdr0dxmmmtMQPQ/GI=;
 b=Kyp1VP9KrRAJxQAU+eXEildp/HeeuivZoTcQt3tNy3crG1ZqqpsvadLHKDG76Dj6Ec0E
 Qt6UUUNfkyY919jTCzCm3dzVJm1z8AbsX+RY/ULK6+USaKSo5Pk2oWJjHE7QBkDISQtD
 /QWtUg44Cqe5DyUB66mXKStFLg0V5zXFUbWXU0j4dI2CLuNtZIhToXWa2GNejqzBxm/b
 xjBlI5i7sZZ+dTjSg94Aj+avXVdHWmGt5lQgy9suAvLLQ7qQZsEI334O4zlEFYbGRf7s
 JPzEZflp8TfuTXRAxJjoCie//O7hJw3/KLVhP6t8zPdbyawFzv7KyXJXECGQXFZ+pMTM uA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e59swe05y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Feb 2022 11:37:07 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21BBMqah008544;
        Fri, 11 Feb 2022 11:37:06 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e59swe04w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Feb 2022 11:37:06 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21BBW7aM031482;
        Fri, 11 Feb 2022 11:37:03 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3e1ggks99e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Feb 2022 11:37:03 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21BBb1oT39125434
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Feb 2022 11:37:01 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F448AE045;
        Fri, 11 Feb 2022 11:37:01 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00F84AE04D;
        Fri, 11 Feb 2022 11:37:01 +0000 (GMT)
Received: from localhost (unknown [9.43.26.72])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 11 Feb 2022 11:37:00 +0000 (GMT)
Date:   Fri, 11 Feb 2022 17:06:59 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 2/3] powerpc/ftrace: Override ftrace_location_lookup()
 for MPROFILE_KERNEL
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Jordan Niethe <jniethe5@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
References: <cover.1644216043.git.naveen.n.rao@linux.vnet.ibm.com>
        <fadc5f2a295d6cb9f590bbbdd71fc2f78bf3a085.1644216043.git.naveen.n.rao@linux.vnet.ibm.com>
        <20220207102454.41b1d6b5@gandalf.local.home>
        <1644426751.786cjrgqey.naveen@linux.ibm.com>
        <20220209161017.2bbdb01a@gandalf.local.home>
        <1644501274.apfdo9z1hy.naveen@linux.ibm.com>
        <20220210095944.1fe98b74@gandalf.local.home>
        <1644508338.5ucomwqtts.naveen@linux.ibm.com>
        <20220210120152.00d24b64@gandalf.local.home>
In-Reply-To: <20220210120152.00d24b64@gandalf.local.home>
MIME-Version: 1.0
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1644579392.dotfvngs71.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aXE9rOkXWLfOtWMO1n9rJTvmZrqufkyp
X-Proofpoint-ORIG-GUID: THFEPOkaLdLyov42li4LOlLizcBY7b16
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-11_04,2022-02-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 spamscore=0 clxscore=1015 mlxlogscore=999 malwarescore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202110066
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Steven Rostedt wrote:
> On Thu, 10 Feb 2022 16:40:28 +0000
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
>=20
>> The other option is to mark ftrace_cmp_recs() as a __weak function, but=20
>> I have a vague recollection of you suggesting #ifdef rather than a=20
>> __weak function in the past. I might be mis-remembering, so if you think=
=20
>> making this a __weak function is better, I can do that.
>=20
> No. If I wanted that I would have suggested it. I think this is the
> prettiest of the ugly solutions out there ;-)

Understood :)

>=20
> As I said, I can't think of a better solution, and we can go with this
> until something else comes along.

Thanks,
- Naveen
