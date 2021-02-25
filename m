Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 739AD324A90
	for <lists+bpf@lfdr.de>; Thu, 25 Feb 2021 07:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbhBYGci (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Feb 2021 01:32:38 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40668 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229708AbhBYGcg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 25 Feb 2021 01:32:36 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11P6Np6C018856;
        Wed, 24 Feb 2021 22:31:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=+yXVivtzYHQTRXyS4Xomt1eBuRLbJZL3d6Y87ujLocs=;
 b=o+w5JbQrh+VxZbwKSvaLsn+gocxbPSc6UOHhWckxWV080LB7YNmU4vvErkXiWb83+GrP
 28j+OeC9UnCMd8IG4cHJIyhKVqDphqzsu49d6A+sSPmieaXRoGhX98VRBFQMo2ytjRKR
 vHRHqYbhw3m1dNRcmblriyRnKfyki5ZfRxw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36vx7avnra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 24 Feb 2021 22:31:38 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 24 Feb 2021 22:31:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fnr8xoJBujal3NE40iZ9Tyzj0hXHlOm9zx6odl5UomBIP38eBU341nGF1XVEe9L+e15RrapTARm8sXi2iRovO9HOfausYVUdIOPhvELioKR9ku15Uuesu8RvMXtGTZQRaM+e+JfUx+2N0WXKAq/ctKghWsL1wUoW1+Nyx1HUf0EceNJL3PlM8ciphCMsDZoYWcxxnSIUcsefNX8XCt2Qaqn8WFOL6FZXctYGYCQnhFcVJYKYSFLULiB9/OinZ1kG9IFlfmZEWtfU2Bq/g6E3mmVhGr40xjRv7An0+qg432CYdAEzTs4Vu0kAV5p2Z9mkNssqNFX2Qcg/U9VLlaZmjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yXVivtzYHQTRXyS4Xomt1eBuRLbJZL3d6Y87ujLocs=;
 b=IJ5W3nRLL6v2JA/Lwg84bCbAmJNBccsr+4jDnHFo9cdYF1rquo6AolryxnfjCITNDWoUeLr2OYy2ikIM1yI1Hi/eV2Wucj+fPDqcMvt+0lxTQyRUX+UZ8vo8ImgnCnu1J4HN0eyDi5xMjkEKBYbmG9db7KCZQa65wPwyV2SeIGUTRduMShHkWDUQsUuGl3+MSvNfyxqi7snSykC88fSG3UQ8Ay44JdLBQY1E9ImKcpvqE2tCvXzeRRYZZ4OuF5iOsKi+t/y2MLpuK/BDGVHi8i9oSlp02vLP8v2njOGfwsK3zPvoiSVykIxn+ZFrX8WSD01s8osY1fb00GcfD9mHag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB1968.namprd15.prod.outlook.com (2603:10b6:805:e::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Thu, 25 Feb
 2021 06:31:35 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e5af:7efb:8079:2c93]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e5af:7efb:8079:2c93%6]) with mapi id 15.20.3868.033; Thu, 25 Feb 2021
 06:31:35 +0000
Subject: Re: [PATCH v6 bpf-next 5/9] selftests/bpf: Use the 25th bit in the
 "invalid BTF_INFO" test
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>
CC:     <bpf@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20210224234535.106970-1-iii@linux.ibm.com>
 <20210224234535.106970-6-iii@linux.ibm.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <68cae666-2d71-1437-a09d-71787581a8c8@fb.com>
Date:   Wed, 24 Feb 2021 22:31:28 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <20210224234535.106970-6-iii@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c091:480::1:78a9]
X-ClientProxiedBy: YTOPR0101CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::31) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c0a8:11d1::15dd] (2620:10d:c091:480::1:78a9) by YTOPR0101CA0054.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31 via Frontend Transport; Thu, 25 Feb 2021 06:31:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a65cbb5-91af-47b6-3708-08d8d956ff47
X-MS-TrafficTypeDiagnostic: SN6PR1501MB1968:
X-Microsoft-Antispam-PRVS: <SN6PR1501MB1968E225C93488700F8E3777D39E9@SN6PR1501MB1968.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /qoUJNxDjFab/3oTvXakNGxijF/mERX6/0jRiBJeTCXfSBns/VeA0OtjpzzF+n1UZvCZOXWwhGhKQiv7TGXb0XzSFp7LfEYHJqq9el3B3y7U7xOSJNMK+Vcn6Ep0MgnvLCSJwcKdlDXqxmCdV8pNOFrq1dTTnGPJdxrqNRF68mRsJrtMeFL4PbOOOYQkrMCJXCpbS5VuBYB7ABVnmHkh5Q114ZQ6411Le+aNrI87aExFaJh0H1QIWrPW7+lSOOBYJ4RnNcBbUV2ktSamkP39UHGYppejtNpWLU+SXazIb9iiKWJ3qrCOLiYT2968ws622XWHagu0ciErspSq19hfNIfgv6CJyPFOhXrracyH9eXpj/l59Yzs2ZbKI/D+m9YdiVQOE0J93tETlry9znr4bxDWcOo+/tletmc4iegnHpEnScouT3JpByJoMm8qcPJbnyjeUoKWvML98trnEiPGsxx4Er9ScMlgMgxFLTTr/g8xpzXdSNzEcUaOE0/vBqCFp94kz/z8z7pAk437D8qzCPpENUKMS/zPUT7X5a4TNGvKGgxjr9dIbA+ORkqrm6FPRmj5ooBOB1Mc3jMh3ze2vKxvUGFC8o7Xq8xYOS9fPiw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(346002)(136003)(39860400002)(376002)(86362001)(316002)(31696002)(31686004)(54906003)(6666004)(4326008)(5660300002)(66556008)(66946007)(8676002)(8936002)(53546011)(110136005)(36756003)(66476007)(16526019)(478600001)(6486002)(186003)(2616005)(2906002)(52116002)(558084003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RUw1VGZBMTk1dXl2ZFFIcHdHQ0lTbEJnakpjREl1S0FOb2x2WTh6eFluRFNQ?=
 =?utf-8?B?WXhQTzM5NERWL3ZrRjcrQXFITXNlU3k0dUlVOTRKUVlzaUYwTnVPN3V5aURP?=
 =?utf-8?B?eTl5K3RId2lYTEVzaElPcmh3UlBQZThicGVBbHd4enlYdnlaRmN0YUc2TWll?=
 =?utf-8?B?a3VHUkZ1NFRZVzdZZHN6MnhPVDEzTVh6ZzJURUV6ZWpRRmtYQXlKNFo0UlFI?=
 =?utf-8?B?a0VOSG43Q2JrbElnZDB4N2N2NStQSnlkZURmd1J5dGVsN2F6N3ozdFJpZmZV?=
 =?utf-8?B?QjFMNmd3THZUQVYyUHljdVc3N1ZoV1Q3VVJsSFlBZU1QREVHZ3Q4UEcyaTU1?=
 =?utf-8?B?d0ZWZGtpWG5CMkJneU5aVzg5UUFMTVlWN0hkYTJKTk1YS2RnUFgza2hOcFZa?=
 =?utf-8?B?QmpnUHVkY0Vuc0l1TStmS3hKeUNPMVAzOWx5TitMMjgxZC90cllkTUZHQVFK?=
 =?utf-8?B?R0RiR2F4S3dKYTdjWklYMlJlR1FaK0RVM3RRV3l3ZjAyYnNlcmlWeTZobkZ1?=
 =?utf-8?B?QkRyd2VIcU9WbUJWaEkxQm1uNXdEcmlwalpQMVJNdytjZU5KM0NZV2Y2NnJm?=
 =?utf-8?B?WUF5QUhMVVRZT3grVG9rRVNKWEtrZmlXdStwekVLQkZyNmF4S0F4dDllVytN?=
 =?utf-8?B?L0V3QmpoV2RkVFFTUHBvRkFoYm1sZWV5MnFUajhybzJBcGlzQldNUG90YkMw?=
 =?utf-8?B?VmJueUhDbXRVclhxY3EwdDVJTElrY0ZDaGFyS1ltNVBYQVlrZCs5cjBCUDhW?=
 =?utf-8?B?aDdBNUZidWI1RDJaL1UxbmsyU0ZGWDVERTE4eXUzR3cvZGJWY2xwcDZyTThZ?=
 =?utf-8?B?b0Nwa3UvU25nM1F2aW1zRmx3N1VaTlZuNE43YXk1QTMrUjNTMWJTWWd3cGha?=
 =?utf-8?B?NXkxc3hSaWFraW9XRDY2RnNVN0I5WUVWSUxiSVIxNS9RRDRaWjkvNkR0eGtD?=
 =?utf-8?B?Z2tVakg3TEF6ZVpJM1FmbXEvQWJjb2NaOTJ1am1FM2hFTzA0Z08zMVdXcGNM?=
 =?utf-8?B?RDd3L2UzVFhmWkhucFlBZlVVblNFVU9UK0h6NFlNYTBIMkkwVXFibS9PRHdX?=
 =?utf-8?B?eDFiTGZkajlGWDRLRHhRRkw4SkRCNVVYcjkyUFdibXpoclV0VUx2SEI3MTlU?=
 =?utf-8?B?OStHME4vSFN3S0gvdFArMHA1WGlrb2hDY3VGZ1ZpWVpjUlg1VGZPMU1ZYVpP?=
 =?utf-8?B?by9vRGN4STQxb3NIU29Ea3dQUEJkODc3ZWk4UmpvNXBjeDhKSnhNdjBNUE9s?=
 =?utf-8?B?bjdMTExjZ214YUt2a2JKQnVic1VIVWxxeDErZit3MG9sZ0VwcURwS0FUVkwz?=
 =?utf-8?B?TXc5dXBYeTd2c2VUUGdyVmFXMkRuMkNRYmN6aTdIQmpnMEJHaHk0R0g1NHJU?=
 =?utf-8?B?YXVmS3IzYkhINGxsRldqLzdVVVMyWW8wV2piMkpwVndYenNnZTM2TFY0dzFx?=
 =?utf-8?B?VlpRaUJjc01aRzZWMGp5enJmZU5WR0VVUXl1U3dpYm9VOTNsVDMrV3c4b2pO?=
 =?utf-8?B?aTdUUVFOSm1PTlR1OGUxQ1h2eXdsK1B2OERWY1FXTXQ3d0wrZDZ0enl3Y1hM?=
 =?utf-8?B?Ui9NRjl3TTczaHM5Z3BybUFlVmZ6SXBZUmhiZERlS2tUQURaeTNsM2x1ZVN1?=
 =?utf-8?B?dGpCc2lYMFkwOFkyQUFGTGhYRlZIR1V4S1VMck50aGkvS1RhTERBbDhmdlEv?=
 =?utf-8?B?MTBVNEhjNk81d202M1dLakJtQ0RMYWhtd1ZCL0E4ZGQrVXVMUmh1OVBLZHh6?=
 =?utf-8?B?ZURMbGM4UCtjR1RZalowOUxnbG9ZdFpjTVN2Q2NyRHJaOEpNemlQTG5Bam0x?=
 =?utf-8?Q?3GEpGcu7OK7W61t7MgL4yBOpr6Xe+3bCXqTIs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a65cbb5-91af-47b6-3708-08d8d956ff47
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 06:31:34.9455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7uvjMHWkUjIrF9JcwMlFUDrdZ620uiIfEsd6zYQ7WyyEuZ+PYC/HGcp926gHYLtw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB1968
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-25_04:2021-02-24,2021-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 clxscore=1015 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102250055
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/24/21 3:45 PM, Ilya Leoshkevich wrote:
> The bit being checked by this test is no longer reserved after
> introducing BTF_KIND_FLOAT, so use the next one instead.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Acked-by: Yonghong Song <yhs@fb.com>
