Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9EC7653617
	for <lists+bpf@lfdr.de>; Wed, 21 Dec 2022 19:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234633AbiLUSWq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Dec 2022 13:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234746AbiLUSWm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Dec 2022 13:22:42 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6395424F12
        for <bpf@vger.kernel.org>; Wed, 21 Dec 2022 10:22:41 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BLHDlSd012259;
        Wed, 21 Dec 2022 18:22:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=cDzifLyVZbqRMEkIE6MMu+bh5PdKaejBL4LoPDwOzy8=;
 b=2ZcyXk5vIqovJI7yiVEDBrsw/LOpg5uENzQAbAamPEQhADoNcaAiNMNWVRhdnIzoRDXD
 jBw/DrOBD+x5kP0zA+OeBXOZK4bvAbKP0MIesfc/qgfmcD6t7l+MSv32tJtRtpomxLB8
 9qqTp6AkRwIfIF5jYPX8z7yBUsq6471kUBHJgmQnIaoQ/nOjD/aG3h8/x5smXMHK46KB
 VCCqnrb2KBkgOnBkaeBWUs/H+eTlbbWHYxTX/1oaPiF+G8CHFv/cYubOHqAJXrxGaD1+
 D7WnGUgogF/zh2z8TBm74GHiHJedVR9WTRILaQilPAPGjbGQ90XapJ/87rt1RTPjZ8z9 RA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mh6tm9hk3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Dec 2022 18:22:34 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BLGio39012259;
        Wed, 21 Dec 2022 18:22:33 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mh4776xt8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Dec 2022 18:22:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/LdvbcfuAwm85JY9kFvVgOE8M7gfQon2826KBHCbmYTo7A+/uVDZ/DhC2oz11MgHG4f+yLKWmTMqPL+Kex0f6zIc8GiO17pCYzg5D2XCzv4acGuLJPBMgO1u+gSfNeXfjEndrRF/idhiMOIF9JKNg8dZy9rlijpzQRcWCPZcoPxQgj5zwjx5qGrqjlMJqCHu05I49/8zzC5/pM2VGmVJYaBfhcfF91nntho7zYiOyGPCBqFFaeCyV80BG88N1n9h91wyrejkKQof92IRfl+sJkHSz6d4c5U/nRjZvIFi4rgfPKX4ZpPnkX+8QXX7Cv5PmB8rc1B3Fn1x924XXBbgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDzifLyVZbqRMEkIE6MMu+bh5PdKaejBL4LoPDwOzy8=;
 b=m7Wck9fw50riox0oPyEdZ+7FYm4GCV+0B21O7YZkMy+VXKY6e/w9f/pQMoTKs044kGKd3GUg2u6r7jEzw/ZHKkIgsK/Yxoh4MPwamlCoHeoOl7xQaODQJUue/mJKjozX3wZXkkeGfqZHDDM0s8IojAoA1AYZ5SScPde7FEkon2cnzVZFs9yPIRQoMWDe6lu2fOFZqcHOEEUGotThSGxLpJMa/a34WU1Tt7ZO5MqzsNjkWJQenMF+4o8whW4QyokMtdNxJWul5TqqJoRR8DJa7LkUJfPBJvhPQQr8Lzy6j+EJ9kmPWnzVv/BszAay8qNlAee2pmAN4wPE0xHNHt2HLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDzifLyVZbqRMEkIE6MMu+bh5PdKaejBL4LoPDwOzy8=;
 b=iUEq6rywl0Ne46ILKWSkMhU75hyhC/AhLuEDlTwyFkdgvpRmj2NFWutrgte1fE5LK9FODQEn0OtGuc0uqM7o0zybMO+vPfp0k13tKxjvxcLWnlFmK9qK8Yd8nT8XHk/vkB69iTc6GmIoHZ1+owWzAFMBFO7zAU6RjntCuJ6An4Q=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by BLAPR10MB4977.namprd10.prod.outlook.com (2603:10b6:208:306::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 18:22:21 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::ebe9:b7c9:82ae:d256]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::ebe9:b7c9:82ae:d256%7]) with mapi id 15.20.5924.016; Wed, 21 Dec 2022
 18:22:21 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     SuHsueyu <anolasc13@gmail.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>, bpf@vger.kernel.org
Subject: Re: Support for gcc
References: <CAEc2n-vmWk6+hG-fcqvMdeG-hSyuFoHv9R79U5MjnOU7nXQSpw@mail.gmail.com>
        <CAEf4BzbQYUQu1RaVrqBNJzjPxRa=W7R-ezuZoXY4O=tUP22dTA@mail.gmail.com>
Date:   Wed, 21 Dec 2022 19:26:27 +0100
In-Reply-To: <CAEf4BzbQYUQu1RaVrqBNJzjPxRa=W7R-ezuZoXY4O=tUP22dTA@mail.gmail.com>
        (Andrii Nakryiko's message of "Tue, 20 Dec 2022 16:34:13 -0800")
Message-ID: <87wn6kwr3g.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0302CA0009.eurprd03.prod.outlook.com
 (2603:10a6:205:2::22) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|BLAPR10MB4977:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c1668d6-b8fe-4e39-1f55-08dae3804ca6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ow+zVopM7A7HF6Xlvb4731NUwnyDJwvJmMBDo+qep1HNMP7b8Ur3vK61DOeTFAIpg3912UOayDQlAcJV6xs4OE1vS+bA87KbUehFa9seDzCHD8VUaotGJoj0F2jmDPrN5Xg+u/81PydNPgitkyACqWBQKAhdzyJsqruNg8dMv05VQjFUMQv5fb9KApyUkeR5wX/oerZbm4jM8//IjeBamr1CinR2VwU1qozz9Gnt6U24dGZ8sev+cz3USB3PhYOsUcPQ4wyjttKppfp7zCUw3q3vcAsUd4G5zXkQk8R02vD5WqCXxP4bwQ7za9ewrAHdVHZH7XB5xhvwUAucpDsPSzw3l0UR80DobXf6j2lazL2emySosCRxbVqQ/p8ntkMFOQYwQuBi5XT8zw6oItUnkCZga4Vg5JlIjzVpmb64uduvKxa1ISdqHJZrMZYmo20533j5VL+i5IqtbS2Te4moM3I4BroQrnLmvpX3p5H+KjmSK2Qfj/PaliQjSkVa4zto7EUzM78Ksbu3gQEON4/+u4JIkt71Ox+Jws/jkNyIzSs6cgeMD7QEy2m86Vwdis0bEfeTc/QaoG6gOaUd0RlsfUP0ZBSmfbSmuJ3Iqey65Su0zIKVZ/b2VvhPTEWbg5YU0+OVDEZc7rF8Y44EhXxmOnsvw0Ac9MoUftY/mLSUREk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(39860400002)(346002)(366004)(136003)(451199015)(2616005)(6506007)(6916009)(478600001)(26005)(6512007)(966005)(6486002)(66556008)(66476007)(8676002)(4326008)(7116003)(66946007)(41300700001)(8936002)(5660300002)(2906002)(3480700007)(36756003)(186003)(38100700002)(316002)(53546011)(86362001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+/dDFLZimPWjJu9e7yNeaozNGWn9KJPrTxWP1gsLuJTQNtj17aPWMtcCq+0z?=
 =?us-ascii?Q?4l2bB/AHHcHXZaVMc+j0U7j66krJ4aSwMxK+hijjKgQ6NUO7r8KiGWsPTXmZ?=
 =?us-ascii?Q?s+AGtINIswRrxdF2Wt5ESPXn4w+xjUpj9WJHgEXu5ZcxFiorpdMxGxEAiJcB?=
 =?us-ascii?Q?BIlu3Y0ZPO0YqQSLMZCt8dHlATb0e7hYWQKorbUxccL6uM3ggnRNRyQBAKjw?=
 =?us-ascii?Q?4tYCup8CiBkIifOaPXsp4Ui6aF8KQ39re44ONKO7BhtPGJ0AaT7XPHNoZiN5?=
 =?us-ascii?Q?S8dqyaYedPKXd1Ttlq5pwTxF8qiQiqOvn8ODGU3XePg1lKTZpYCEUBHwEabP?=
 =?us-ascii?Q?fAkAjO4REyZlCGmyrm+0AuMdGABBgehuMmT3OTM9/uiENXKjrM3/zzN8qD9c?=
 =?us-ascii?Q?w2PepjcLYnOkRKxQNdUUdz30HdXLAguq2uLZKEF+x3r9aD1IaRDBRpOBoSkB?=
 =?us-ascii?Q?xDWFDAbd5oBURr8qkKYx9vijCB4yYTlzZ0AmnY16ydc+5UfrojU3j8lPjVNU?=
 =?us-ascii?Q?0cbOKruSluWZ3czYvh11TOrm7k8/nshpexyrraGPdEee49Idhe5hXxLSmTGu?=
 =?us-ascii?Q?pnGL1NHi70xIgRKiJlG4tIhrvAiM0iO7cYaJGa2n60Pc5gKncZDVIfkJFda3?=
 =?us-ascii?Q?LMI9pdgMpS9f3OgNvQHK+LYCKZGw0VIE5fenWoFBFbf/sO2MN4xokGMHcrAQ?=
 =?us-ascii?Q?Q+QLxNyMgBT3Kj2czW+6OmQejL18B+IT2//ekJSknhMMjyrFdZqhmYVVHCRY?=
 =?us-ascii?Q?t/W4fri/poS/zJffRmxeXfEWMIEtQDdUk1mgUGOWr8w0hHCgHbUGpKhblnnS?=
 =?us-ascii?Q?PExgn/R96rSYg4h7qGtRjLhVwRv5vTT+9xMa5cXVf2z6SfKfoc0AS+hP2pg3?=
 =?us-ascii?Q?QhwM3DZ86mSH5M/Idh9hsekuEC0efazzHTOmlS1URkzQIUXl0nFpYGo+//GM?=
 =?us-ascii?Q?O8Z4FHTfM1uqwIs5aFgXM42UHQqXnrLvJljEtcqU21zLMcqaXUbC0Ngrb2Ii?=
 =?us-ascii?Q?AX9q4Xhm7b0fGJsgNr4T5Uwf0hJachDUy2WwUK7XWby07o0JFZL8chxfAcCR?=
 =?us-ascii?Q?ttL28V31bFrKS9H+K916VycmvwJA9+b+Xm2dDQJ9moDK4lFMXOMPa3+BPfcn?=
 =?us-ascii?Q?KPrFrWW8TxnDcr0w6sErU8goK1tmqpyXSCoMJyvierpc2lwtttEPtaKnS8yo?=
 =?us-ascii?Q?VP8pKSIWbRtxe8iPdpxdu8fHNM0R/hnFgtnoOMgxiiXaLp69K2dDiZKQXM/4?=
 =?us-ascii?Q?WJRd6gRPxuvdNoDMS5DfP2bn0xN2iRGzx5QwIekRMaKnxWZ12HpNUGs3S3H/?=
 =?us-ascii?Q?KPZ0ucVltyDTQoutLUnTdu3HgW3H7uTGJvSnP6TE6+Skry1apRAEXz1sLPT2?=
 =?us-ascii?Q?eTKjxKHFvzrNePQl5LWenVCCALchpbMelkSzMSb5EZJRkgwPYcbwJPDDWoJ8?=
 =?us-ascii?Q?9jI1DvqKpXDVGO9Wi/Ezdu87C/hMgKSJYmSTUtsGA+PF+Y9+TN8dRpC5m+0m?=
 =?us-ascii?Q?9UDsI7c94rsYS8S20n2bAdNNnlz5y/xr/rjRAfF0niUBB6iHOwGaSJJhME9i?=
 =?us-ascii?Q?cs5oIQmWPy8tiR2m7dbNK+JMVCznmq63yOFE2pfzKzVfQG5II+iSyImhgSCQ?=
 =?us-ascii?Q?NA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c1668d6-b8fe-4e39-1f55-08dae3804ca6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2022 18:22:20.9808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QuDZohDjEcDL/ykJPZzA4ZlPS0D8DIASnyXoEfmr3zor4UIs/qBqTBgI9HBpYdOhPR7jOgcaR/7ecpZAEmX8xQKPJtQRjFQVYHtTQshcMl8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4977
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-21_11,2022-12-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212210155
X-Proofpoint-GUID: PmtDkhhiaHa4oIET-sM3lp8qWACPZGhI
X-Proofpoint-ORIG-GUID: PmtDkhhiaHa4oIET-sM3lp8qWACPZGhI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On Tue, Dec 20, 2022 at 3:56 AM SuHsueyu <anolasc13@gmail.com> wrote:
>>
>> Hello, I use gcc 12.1.0 to compile a source file:
>> t.c
>> struct t {
>>   int a:2;
>>   int b:3;
>>   int c:2;
>> } g;
>> with gcc -c -gbtf t.c
>> and try to use libbpf API btf__parse_split, bpf_object__open, and
>> bpf_object__open to parse and load into the kernel, but it failed with
>> "libbpf: elf: /path/to/t.o is not a valid eBPF object file".
>
> if (ehdr->e_type != ET_REL || (ehdr->e_machine && ehdr->e_machine != EM_BPF))
>
> This check is failing in libbpf. So check which of those two are not
> set appropriately. cc Jose to point where to report GCC-BPF specific
> issues.

Thanks for the CC.
That would be https://gcc.gnu.org/bugzilla.

(I don't think this is a GCC issue and certainly not a libbpf one.
 Seems like the op is building a x86_64 object and not a BPF object.)

>
>>
>> Is it wrong for me to do so? Due to some constraint, I cannot use
>> clang but gcc. How to parse and load gcc compiled object file with
>> libbpf?
