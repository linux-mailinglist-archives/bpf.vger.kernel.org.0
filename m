Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CD957B1DE
	for <lists+bpf@lfdr.de>; Wed, 20 Jul 2022 09:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240070AbiGTHif (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Jul 2022 03:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240067AbiGTHie (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Jul 2022 03:38:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF1868DC8;
        Wed, 20 Jul 2022 00:38:32 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K2FSRX030727;
        Wed, 20 Jul 2022 07:38:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=oQ62l5E3/7QgaKhKzpMFcOWxTZA2CnNvJ+1zIrHXOJ8=;
 b=xwe49+ZZG66sj3HRimph3uGR3o0L9hJPg6z8M84TsrX89MaBbKKhzzEUp6p7CyxAKGfv
 EYT2I3CtMrLZjnIrxXFSVdGak3HY3V254uXW8zV7jwkYpugGOxd1h80w1HUMBejoZqcL
 RV299I7wT4ocw7gkQHAaFn6XKPMUinYIVSV9PilqnoulJbVKar3EY6waQetk3FvW4Pdy
 mCj3X7CGdyAFX3cLXCPS2CXb1cRsa7Gi+XXNReheKrbdfFlzOnkwWK8Jym2PwA7f/EcZ
 TLGwPgmAh1Ie0fB+xTkQ53t79O0SdXHyq07kaBqKtdYYnBTwM4xezDVK6yShQcOyeOAH xA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkrc8eq0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 07:38:12 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26K651KO016650;
        Wed, 20 Jul 2022 07:38:10 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1en88ej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 07:38:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhLWyC6oSsWc/I1up6BZ61gRS+7ZMo0oEFzIhCS/sDvbqXVwUaDK85s48v+AfvdE9L/dOA0BhyjDBh4RtTJRJJPJWk92QMQ2w0EaNDAOENbkccyvQRZ1wvGbgv9Lg9b5iOQ2ulnWJuEKqUauiiEDETjSkh61dJ2YBDSAfgGw2atU3ZR/NxzYeoJ7eQ9SZuX/E1ytYr89UY1ypV1Ocvzy9aQTtEFcJRzEjs5ufll97coSkMFu2d4Dvsae62r6simdUgoM+fi41pgLPgNeIPQ8lTL8zFM1MSvpcULALE97cs49ESUGH/iV3XBPnf/L6c8AStCLcMIe4wGFS290kROy3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQ62l5E3/7QgaKhKzpMFcOWxTZA2CnNvJ+1zIrHXOJ8=;
 b=DylW2mm9NnSKwE4e0+mogostqnITMH3Ix8LZFXiCC4qYEZ1VV+mCN23HLvVu8jqD5pmOp1aYE8shJLXgsnEb9ECtivImcv5AgCNPXcSRwswjFBmG/P+XEpCCSgvn2t6S3hELa0sZbQrK900B0w038qbt4PXZVV4xv25XcDitImSQ/PPYw58ycEo8H6/A9U3TWGHqpU/hRnNsrI6ppXVI6w+yz/cU9k098Z/zP9Ksw0M4wWUe97yrgiQuhWHbIicVn3Vo2hP06gr7+4O/Drnos3Fvzm5LtgsQ9b/MZm4FUSCpja4Xc+ZL31mhP9w5z01FLlI+qA4M+3cdo1EMhPIygg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQ62l5E3/7QgaKhKzpMFcOWxTZA2CnNvJ+1zIrHXOJ8=;
 b=h92sm4HW110KtwSTrdJZj/Eg4XvHJE9IueCwRzA3IcgkPiWmgibX+jQ3+B2pCW4MVJRE7auMFXQ1iqFNvcOxxUhiPA89ML2hiwxYrIt280DfKDTChzEhV3s1NwjNEfD+GyG2ppLLrvAVLMhA3HSyVK87/XAn29sE3jlCyhfdUGI=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by IA1PR10MB5969.namprd10.prod.outlook.com (2603:10b6:208:3ef::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19; Wed, 20 Jul
 2022 07:38:08 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b1c7:933:e8c2:f84f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b1c7:933:e8c2:f84f%9]) with mapi id 15.20.5438.025; Wed, 20 Jul 2022
 07:38:08 +0000
Subject: Re: [PATCH] libbpf: fix str_has_sfx()
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <YtZ+/dAA195d99ak@kili>
 <20220719171902.37gvquchuwf5e4gh@kafai-mbp.dhcp.thefacebook.com>
 <CAADnVQLS=asNdrmdK-jgW4AZmJih00OTvXZg_RA55wLY=bHMZg@mail.gmail.com>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <46ca78ec-17b5-3cf1-a42d-7659563c6cf7@oracle.com>
Date:   Wed, 20 Jul 2022 08:37:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <CAADnVQLS=asNdrmdK-jgW4AZmJih00OTvXZg_RA55wLY=bHMZg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0089.eurprd03.prod.outlook.com
 (2603:10a6:208:69::30) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6328e254-8f3b-41f4-e90d-08da6a22ca7f
X-MS-TrafficTypeDiagnostic: IA1PR10MB5969:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YqUIQQBw9zxmnIdQOD16TEYe7448EW4cTwbQpayC7mBSAuwic2OzQA1F2JIF9+CXqQk9KTpwUcGR0wTLK9NeFxidMsU150XEJ0UhrlIkbFzJP7qPoZzs21yBP+Ag7oog0SDikksGJRPjYqCg7LiZHkhcCbhSK1+lEARySh88XoJot47+uZBno2FmYPpr1WUOYgNxkI/OmHQinOQfIwbRudJXezupLnvUFFD5dAs9EnbioJJ03WUboGCyA0fUWdPVC32PZp8EfSckUb12n1p32xHD2WlSAmBTzweDeK3klxjWJsBM4sy4FC5uoebKvsN8qs7tzyMrRUKQK2DEqBtWdvI3gh3n0BdAv8X4jIIZIjjlZ9brNLnVrlGUIwUyiiPCe9gfJHvMo5IYkBHus1/I0uG1hKm8VOcJcpbblLhpWu4R+Jg1gFV+FJIj7hvad5jgvEMLNF3if2oGqIAy64C5z1uAzAJH7tf40NG8esAzKTYlyD72aRhqLAHUi5CfTs0YLKpmI68A+q4Ho9ZVIRh5n4vMBjPhwdR2I+ET/r3FFpiMwAICvRLMSN8f4OQP/7gIwa22tVTXI7qjd41HO6u4UMkVylR6M0WsXX/7WL4jr8ZDQa3m2jkPNH6AI19+lN6Mp2YkrX7sUYTt5TJzqMgKJOvL+5Tk32IXFGx6b+5RTsmHL8ZXvyc+dXyMnjaTMf8mRDIT5UQMEFbRrmr0uBgnnAthY/dXBLAOwi9/+QvIiA7c1wlDmi1rvk2pBcMt8tT4Lymzehgy5CNVyHBJzzWhLMRRvi7eekHPu7hHL2yks/eXOHGf4uzZayUXK1+8y3RlVCjLi4TxmKaFGfB/0Qbv2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(366004)(396003)(346002)(376002)(186003)(66556008)(110136005)(2616005)(83380400001)(8676002)(66476007)(316002)(66946007)(36756003)(4326008)(6512007)(31696002)(86362001)(53546011)(8936002)(7416002)(6506007)(478600001)(6486002)(5660300002)(52116002)(54906003)(2906002)(31686004)(6666004)(41300700001)(44832011)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlJEVWNXd1k3STRVVEdPVXJuTE4vRTkxK284QXNKeFhSQzB1eWxmVXlHa2Fm?=
 =?utf-8?B?dXNPTlJESXF0QkhBZGJnajRpdmhOVFNoNmFQNXM1dDdreU1jZXdxS3EwV2tm?=
 =?utf-8?B?WnR3S2ZBYTdxeWZXUjU2Zi8zb2dpVUw0S1REdzBvMDJiZFpqZnZNR1FJQkNS?=
 =?utf-8?B?bHR3cXFZL2xsaGVWd1ZKVUdmYnlLdnJKejdNdzhsSTlqaE5mRFBra2V1K0l6?=
 =?utf-8?B?YnBwRmIwVTJ1MHg3NGhyaHR3cFlGUzAvQXpsNWZoSEh6WVNXdHVla0hXRlFP?=
 =?utf-8?B?ZlNqSFphNkFmVjJkS3RLdEs3akpGQW8rYks0TkRMSzN1bUpscElnNTU5eS9a?=
 =?utf-8?B?TE9WY2o5L3kwSGh2NFRSQWR1bGVYWERhTkRWY2pYb242T0M5OUJOKzhzVGFI?=
 =?utf-8?B?eGlVL2tUS3dDVmFDdC9FY3VUTUxycmdmVjByZW5LdUxDa1E5S0VRaksvN3No?=
 =?utf-8?B?WTVPc05FRjExaU9HbHZYZjhlSE1sRE1Kb28vSlE0d2dlQUVvVFBxN09IQ0hO?=
 =?utf-8?B?VU82ckhWSUZFQVVDalB2WWh0QmtKNDR0ck15MWNXZFJKOERMQnNDNEdReWtz?=
 =?utf-8?B?N3I3QllOODh1NHMxejFnSWpQeE1qK1VOQjY3K3dLQTdGaEVoZmVKNHZ0R2pn?=
 =?utf-8?B?M0E5S2JBMHFCUU5YU3UrVXZKTWdLVmRjcW5iWGRYbUFMUXNsc09sdTYwUjNl?=
 =?utf-8?B?cWlTT2FrcThsSXZSM1ZqZ2VYRW5FNmdyV1JOcm53MFdiY3Z6N1VkL0tuUTNC?=
 =?utf-8?B?Njk2eHBUbDRxcVZwbnNYaFVxalBYVWFKODQrMktINnI1eHQ5bEZUNWpVMFl2?=
 =?utf-8?B?b1hmRkk4N0UrcXB6ZEdpYkpiYTdzNVZmd2s5cURlRzRVQi9VNW9TeXl5V1cx?=
 =?utf-8?B?YUFKWnpVYkFOZlRUOFlRR0Z6cmkyVzRrd3hHclRHUDE1R2VkZUM0a3pEUS8x?=
 =?utf-8?B?Vk5tUFBONWdsQWdZUC82QW9SeWU3RHpQV3Z2aWZPY3R3VlFCR0k5eTBRTWpk?=
 =?utf-8?B?L3JwM0xEakwxYkx5b2ROYmxQYkNCWGR6ZitXRkxOVWtMKzVJaThxMVNtRzNO?=
 =?utf-8?B?QjZtTFdwN1hlcmlMcThCb3BoYmtldnV1LzhNOFFNZ2UwNTNrN285MXJJRmpR?=
 =?utf-8?B?QXhIV2lmcTduZVJUYW9hTjhDMkVXV05FRWdRSFVCMHc3RHIxQXpPMGxCRVpO?=
 =?utf-8?B?Mi85OG9pd2ZYSDZzT09jRFRzVlZ3cWtlbUlJcUNzcitjRjNBalJWaXZUNGtK?=
 =?utf-8?B?cnFsZ1crYTdWWW0yQ0FSNjYvTFJpalBMaGN6azRlc013cXVuaXNPNy8vUVVo?=
 =?utf-8?B?ZE50RTdBdXZUQW1VU0hPbmlkOE1ZU1VlWVZRR01ZVWRRMVhpaTNpRUNPaUlz?=
 =?utf-8?B?U3FEOFBlMnQzdVgyRUc5czdndlZ6eFExU1h2eWZWOEMrNU9idDlEbDZXNFB1?=
 =?utf-8?B?d0EwbFlVaWdxRnd4V2xQYlUzS2JQVGZ3STNtVXIxenBrK0pYRVNXY0xTeDlJ?=
 =?utf-8?B?bWpwdyt1R1ZyVDFmMVhLdWFPTEdxc0pEMytjY1pPZHpTeHRlV002UVd5NGpq?=
 =?utf-8?B?anYySndNUXgrQk9xNUhhK3prd0RtdmJTUmV4U3ozaGY4ZHZDclpYbXJ0RGdL?=
 =?utf-8?B?YXh6V0g4SGNkaG9SeFVIdEZuWXZsT3VzNVgvQUgzTU1hUEVkRzlyeDMvWi9l?=
 =?utf-8?B?dEU3elNTekoyTFM4NDZES2ZnaHhHSU5jOWIzclBlK3hLZm1rT0dHSWVaTU1L?=
 =?utf-8?B?SGVaVWNoa0d6eFZwSUNFYy9oTWdZYnRCaXVzQVlzdThEV1d6bXdpVUdYSGRo?=
 =?utf-8?B?WWYyOW4ydWoxb2hiSWEvb2hTK2NBaHNVVThROEZwNnlwWUZtcVBHdU9MU1ZP?=
 =?utf-8?B?MzZDZ1ltS0pWMnlNcy9HcUJzMmFjMTZiZTNPdk1zY3p3TVNQK3AxZ0U2NDls?=
 =?utf-8?B?NWRYMGtUM3lXNmZYNVJNTHB2Yk5yK0lYU3p2MnhSZmR6c0gvMjhnQTBVVEF2?=
 =?utf-8?B?THcyTklZK2l0dGpLT2tFaTlFYWgzRGpkb2xwSW15cXJEaW83R2xWVVhicG9U?=
 =?utf-8?B?RXRmYUtqS1FyMG8xMnR4dFU4b0phL2NETDl5ZlVJVUZCNE9iR09qMmdZekdt?=
 =?utf-8?B?LzhDYlo0ZFpXY0VDT0hBUlNMKzJlZ3F6WXJIOWN4V0FzOXF2a0dTWHBWTjdw?=
 =?utf-8?Q?cN36HmXN+0lJw5YLKQ8xRSo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6328e254-8f3b-41f4-e90d-08da6a22ca7f
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 07:38:08.6564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pEx+ZmitRFx54kpAgkwpSGcNV+eRn+/3KBruLZGEFLVBuvkmn8WkTEN0bifotrSM+5R4e/xQF9zWDj8b3APUKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5969
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-20_04,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200031
X-Proofpoint-GUID: yRUoEB5Kt45Bf9LwHeRxtVOG5vKFELW2
X-Proofpoint-ORIG-GUID: yRUoEB5Kt45Bf9LwHeRxtVOG5vKFELW2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 19/07/2022 18:51, Alexei Starovoitov wrote:
> On Tue, Jul 19, 2022 at 10:19 AM Martin KaFai Lau <kafai@fb.com> wrote:
>>
>> On Tue, Jul 19, 2022 at 12:53:01PM +0300, Dan Carpenter wrote:
>>> The return from strcmp() is inverted so the it returns true instead
>>> of false and vise versa.
>>>
>>> Fixes: a1c9d61b19cb ("libbpf: Improve library identification for uprobe binary path resolution")
>>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>>> ---
>>> Spotted during review.  *cmp() functions should always have a comparison
>>> to zero.
>>>       if (strcmp(a, b) < 0) {  <-- means a < b
>>>       if (strcmp(a, b) >= 0) { <-- means a >= b
>>>       if (strcmp(a, b) != 0) { <-- means a != b
>>> etc.
>>>
>>>  tools/lib/bpf/libbpf_internal.h | 6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
>>> index 9cd7829cbe41..008485296a29 100644
>>> --- a/tools/lib/bpf/libbpf_internal.h
>>> +++ b/tools/lib/bpf/libbpf_internal.h
>>> @@ -108,9 +108,9 @@ static inline bool str_has_sfx(const char *str, const char *sfx)
>>>       size_t str_len = strlen(str);
>>>       size_t sfx_len = strlen(sfx);
>>>
>>> -     if (sfx_len <= str_len)
>>> -             return strcmp(str + str_len - sfx_len, sfx);
>>> -     return false;
>>> +     if (sfx_len > str_len)
>>> +             return false;
>>> +     return strcmp(str + str_len - sfx_len, sfx) == 0;
>> Please tag the subject with "bpf" next time.
>>
>> Acked-by: Martin KaFai Lau <kafai@fb.com>
> 
> Alan,
> 
> If it was so broken how did it work earlier?
> Do we have a test for this?
> 

We have tests for automatic path determination, yes, but those
tests specify libc.so.6, so are testing the strstr(file, ".so.") 
predicate below:

	if (str_has_sfx(file, ".so") || strstr(file, ".so.")) {

Problem is, on many systems, libc.so is a GNU ld script rather
than an actual library:

cat /usr/lib64/libc.so
/* GNU ld script
   Use the shared library, but some functions are only in
   the static library, so try that secondarily.  */
OUTPUT_FORMAT(elf64-x86-64)
GROUP ( /lib64/libc.so.6 /usr/lib64/libc_nonshared.a  AS_NEEDED ( /lib64/ld-linux-x86-64.so.2 ) )

...so we can't rely on system library .so files actually containing
the library to instrument.

Maybe we can do something with liburandom_read.so now we have it
there; I was looking at extending the auto-path determination
to usdt too, so we could add a new test to cover this then I think.

Alan
