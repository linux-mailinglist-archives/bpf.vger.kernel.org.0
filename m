Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE25164B6D
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2020 18:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgBSRE5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Feb 2020 12:04:57 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56220 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726558AbgBSRE5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 19 Feb 2020 12:04:57 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01JGtfIK020720;
        Wed, 19 Feb 2020 09:04:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=02OkWBHl/ps+9/IbyVfuM8Flu10X7ncBe+z4q6fDkHw=;
 b=oHxAgbzy1kr4G+3NCm7K+8B61II9AGXPJvI0Z38I5fRgHJ5ryoSOIyOAQ2zJ5ngwgTxk
 OGkznXdNRjdkJcQBVeHLbbG1rhy1pBJzPKuc9MCGVcOIbQQIg75uENhdzYUz6nqkpLrL
 Xb5E70oVlG1zKcD7GAOnSwNzV0n52LdhiOo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2y8ud1bhc6-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 19 Feb 2020 09:04:45 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 19 Feb 2020 09:04:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NuTnpXCObXY6Xp0jloQICfJkHBBez/iN1vnKgvCl9byk3AfvhlmNthZUHwIktMB38hgGirDgzdWbxXLLbsB7vXGVOF7p20pT6rWvEXVEGWV67LGcYYrYtzDHb1ArSetqkptA4Fzi1elGZggKwf5mU2mnC88cYG2RdaDhQkp+0INlrzFd8o3b8r8EwjGnxD3LqDztXFe0+3PJpr0yd+BnJj5q0cEgoAoh6Hdar7p2k1Csf7pjnHU7VQS9UVBLD5WlcFELQVBPpkpTREHsz/AfkXhPmO8JhxxmuuD4hsDNe4KIzwpp3h1CtinrtICjvVQEPCjyvO24onz9dB+zGAyOiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02OkWBHl/ps+9/IbyVfuM8Flu10X7ncBe+z4q6fDkHw=;
 b=d5jzuOXD0IgrsYVV8tKPbRIAxwWm9/2TqEc3i1vyXUWikemVpEVh6JBQr/T30aUysCwXSPtNy/reoHWi7wxOBcd3c49xpEz+AZfAX2RHKFlzVkXiJBUwwnVSDjUsvAxGZ/u0cp1Mmq8CUSS/5s56BUEmNGLrj4TNoCKRgzODmRPWXLD1pQk3lIpMSumTSaenkai9ps0oaqRNubN2H1OMc90pDthhE1URw3GyGGI1f6C/ZOSZTqj8yvhEtVOTgtJHq0WGlclTUxSUd7MDgBKJ9zERpGQEzAd82y5zkwmrr/Mmq6O3KLkhAPtBwGWuTUiwoPkE7HzJSmSyrPfoHfWN7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02OkWBHl/ps+9/IbyVfuM8Flu10X7ncBe+z4q6fDkHw=;
 b=gpFYJvp0FMmX63lDkjBMfChA+Zjdj/seHHgD8DUMvW8CcpPr0249OZakhxTugguU6xhYFui6JF36dwlS6V8yEMo0ER7wKAkm+juZQg1pjBSS+aCsxESoqFF5te+q2IEIf/qcpV2ZBgx67ZMLd1LrraOMzXihVhsQoA68j+8oL2E=
Received: from DM6PR15MB3001.namprd15.prod.outlook.com (20.178.231.16) by
 DM6PR15MB3784.namprd15.prod.outlook.com (20.181.4.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17; Wed, 19 Feb 2020 17:04:38 +0000
Received: from DM6PR15MB3001.namprd15.prod.outlook.com
 ([fe80::294e:884:76fd:743c]) by DM6PR15MB3001.namprd15.prod.outlook.com
 ([fe80::294e:884:76fd:743c%4]) with mapi id 15.20.2729.033; Wed, 19 Feb 2020
 17:04:38 +0000
Subject: Re: [PATCH bpf-next] selftests/bpf: change llvm flag -mcpu=probe to
 -mcpu=v3
To:     Daniel Borkmann <daniel@iogearbox.net>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>, <kernel-team@fb.com>
References: <20200219004236.2291125-1-yhs@fb.com>
 <956ccea3-0440-7c59-9c75-90cd7b25afb7@iogearbox.net>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <81fdc321-7bc2-d8aa-29dd-077e49e4fa6d@fb.com>
Date:   Wed, 19 Feb 2020 09:04:34 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
In-Reply-To: <956ccea3-0440-7c59-9c75-90cd7b25afb7@iogearbox.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR04CA0098.namprd04.prod.outlook.com
 (2603:10b6:104:6::24) To DM6PR15MB3001.namprd15.prod.outlook.com
 (2603:10b6:5:13c::16)
MIME-Version: 1.0
Received: from marksan-mbp.DHCP.thefacebook.com (2620:10d:c090:400::5:99e4) by CO2PR04CA0098.namprd04.prod.outlook.com (2603:10b6:104:6::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.27 via Frontend Transport; Wed, 19 Feb 2020 17:04:37 +0000
X-Originating-IP: [2620:10d:c090:400::5:99e4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e8c89ef-29f9-427b-f4de-08d7b55dcd69
X-MS-TrafficTypeDiagnostic: DM6PR15MB3784:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR15MB3784ED41AEA333A9959F6FDCD3100@DM6PR15MB3784.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(396003)(136003)(366004)(199004)(189003)(66476007)(66556008)(53546011)(316002)(8676002)(86362001)(6506007)(81166006)(6666004)(66946007)(8936002)(81156014)(36756003)(52116002)(4326008)(5660300002)(2906002)(31686004)(6486002)(31696002)(6512007)(478600001)(186003)(16526019)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR15MB3784;H:DM6PR15MB3001.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PjNwpaykojt42xN+8BIpySHLpMllMY62wpsDTS2Uxv5vMRMmvouYqZrgSJvyOp8Y5V7ORI4Uw81cnCIt+FGjNp13UCV2NpM+kvWr2Qyi2GIquuk3d36/vobsPp+Cjx2wLgeivDqchExIkz6S6InzJ+VqBdxqsk5G6UIqmzh1/POeHxJY3wMJFaHsjS36bwpQKDZ63JUXM/YrixwZz0lscInr6WkYcEgT4JnkyVdRq3ukavlCQtN6xcs1YHljZM69VHWsiGwFR0XXKRkAAwPb7aZoGFQu12NESPqt7E8eEvFxtMRHA+IsZv8qIeElgw7+py6rAZOAfnlUTJC/KDpbcKQ4895PV5YZn48H8QE5SknnkEIWfTwoRcF/PfEI5POPAyPL0FW3xYMP2QObLIpjBrsSqHvVgQbdR8P/dCcMr7CL+Qrh7O91HXLy6vBPHAf0
X-MS-Exchange-AntiSpam-MessageData: VqN1jzkgKaeoyizGwLiem3/fF1XXSPxbS8Xw+qOiLczKfQnI2PoVASkE5Wvhny6t1rqEWXtqYQucFiZTft93z34biAQbkRX29qfSX9xLEOIjuL7C4KbBy/lF8WJ+vnjZjNL6nQMerENWKWow2S2bpshk5wZ8tEXLNccI95DdM+QGMV84kUUM0Bjj9lftSrZC
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e8c89ef-29f9-427b-f4de-08d7b55dcd69
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 17:04:38.1112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zCYN5C86BIwRCYfhcM5vsNA2u3W2XngSHTtEEKuT+T8YM+j0WHkddZdwrZzK1SSq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3784
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-19_04:2020-02-19,2020-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 mlxscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002190129
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/19/20 8:56 AM, Daniel Borkmann wrote:
> On 2/19/20 1:42 AM, Yonghong Song wrote:
>> The latest llvm supports cpu version v3, which is cpu version v1
>> plus some additional 64bit jmp insns and 32bit jmp insn support.
>>
>> In selftests/bpf Makefile, the llvm flag -mcpu=probe did runtime
>> probe into the host system. Depending on compilation environments,
>> it is possible that runtime probe may fail, e.g., due to
>> memlock issue. This will cause generated code with cpu version v1.
> 
> But those are tiny BPF progs that LLVM is probing. If memlock is not
> sufficient, should it try to bump the limit with the diff needed and
> only if that fails as well then it bails out to v1.

The selftest is also trying to test the latest kernel, so we want
to keep cpu version as v3 always?

There are cases e.g., compilation on a devserver and selftests running 
in a VM. The linux directory is shared between the host and the qemu.
qemu runs latest kernel and devserver's old kernel may have small
memlock or in unlikely case the old kernel may simply not supporting the 
cpu v3, so in such cases, maybe forcing cpu=v3 is better since this is
what we intend to test?

> 
>> This may cause confusion as the same compiler and the same C code
>> generates different byte codes in different environment.
>>
>> Let us change the llvm flag -mcpu=probe to -mcpu=v3 so the
>> generated code will be the same regardless of the compilation
>> environment.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
