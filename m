Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FACE47DC00
	for <lists+bpf@lfdr.de>; Thu, 23 Dec 2021 01:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbhLWA1u (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Dec 2021 19:27:50 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:22664 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232757AbhLWA1u (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 22 Dec 2021 19:27:50 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BMHwxhp013985;
        Wed, 22 Dec 2021 16:27:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=SFz15bGejvGjx8vBPQ9b+gfOMgM6jg7HppfH74tmzt8=;
 b=cloUyNFnos8BGYZQus0bUnlh6KxyWvDA+6IpCiakhySNAibtCpigYR5Mhbqy4fxxyM+t
 fgc97Psji4p93v9ERRNEEny5uHqM+/bz5PbAF9MvrDpu+T9kmhrIj8SuH8/wzdgtTK7D
 2EkqFAszKCCCnGKPUM0aJQjVua8+/jb2R1Y= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3d42mxmst5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 22 Dec 2021 16:27:29 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 22 Dec 2021 16:27:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTUcBMuhXF67u7huVjyhZTh8rEYPpVrIxWWp/5Ccet7w27tkRVjVdYxj+zfOImWUu6dMKHKBa60BXtuXGoGgRr4eBDwZianNB4wyFum+zpz6jTh1hdp4W3+OsIdHkVzXKTAHLoNNgTTNgnNqnK94zXIzu2wbT32hVh+oIiB42ervwR0sWUIri/HgjpuFc44BBg6gqy7r14H71RAbsgvPfiTN+CLCPijH8rE6zpAOs2gUyKmU/z5OIrXTwqJ9h8y0wBNCCexmFboDDAOxDB90TbmB61OJbm9Tem/Cx+Pn0EJil8SErk6vgCbVU16EEGPzxUwGzrTU2mE43bhyHnQICw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFz15bGejvGjx8vBPQ9b+gfOMgM6jg7HppfH74tmzt8=;
 b=GA2yNwclqXX9tOErewdIoheiYYYwDkBeeYPBvgKfSorfqGs9g7USNA2M1nBze0utFlpVgiZ+RS2R2qYLZsWKhJru6YAr2rlRYTiGDIx9rDlS57jZcZ6p+e5RMOryFydgAQdeRFVy1dQxd8rCEdh7x8/QrZRkVKOeqbWTWmV/0FDa0oklCdPipCmz7hoSEo6apUpIhe7QbUJ3N7sqGLO9pAEjLBtYWTIfDFJ10A72Rb1j5qg6m0iwqMtherPcBPyXTc5M+aBfB8S+BOSdEX2y24e+X8Pg7W9XzDOAp2IxGFMljSZGB8KMo/1ZdwHEtqQ55sCpm2tdPAbx3SfjkF74LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4903.namprd15.prod.outlook.com (2603:10b6:806:1d2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Thu, 23 Dec
 2021 00:27:27 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::b4ef:3f1:c561:fc26]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::b4ef:3f1:c561:fc26%5]) with mapi id 15.20.4801.024; Thu, 23 Dec 2021
 00:27:27 +0000
Message-ID: <92c0ba5e-7849-075b-d192-e422af7f0905@fb.com>
Date:   Wed, 22 Dec 2021 16:27:24 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH bpf-next 2/2] libbpf: use 100-character limit to make
 bpf_tracing.h easier to read
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>, Kenta Tada <Kenta.Tada@sony.com>,
        Hengqi Chen <hengqi.chen@gmail.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>
References: <20211222213924.1869758-1-andrii@kernel.org>
 <20211222213924.1869758-2-andrii@kernel.org>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20211222213924.1869758-2-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0026.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::31) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a006da7b-1c6f-47b2-1407-08d9c5aaffb2
X-MS-TrafficTypeDiagnostic: SA1PR15MB4903:EE_
X-Microsoft-Antispam-PRVS: <SA1PR15MB4903FB2DD4FCCA28653F2F11D37E9@SA1PR15MB4903.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:608;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f1viGwUbkiVj4cjWltKmfO2MHTymVObdlXdbYiuLQqgnlsAhuvtE6V0oc4bZPMXIEbY66ocBSxydL3CKpJp4a6dTI0TD5UoNuavQiqYyoXtwFUPwSb6EfbZVzzF+/tya3pft/bUbunKr81HF+4feoEQLihHYRTAOpoNNUNdPy2BjvkNY0x5CdLEp9wuESM9CJJRf4U6rbgl8HF5FvgGPIx7VcpYngZAEvGEH5ZQExm5UK1E8+hwF6NsfaNG2sNnnjkeptiLRDPC4TRMOV6VYOoB4KziaeN3qDaHnYq2Un8HquLvI9g2p0UXJL6/Aupf7qkNFBJqfvp4o6hIsjhRxkopsUS/dJUQp/hO9GHm8lJpEcbMgJ3IUtwicymF97TLVJ5ElwtJZ+CFp9MnBAhEHEpnCDDDodhHdL5yvi/nu/d1vFOlf/xaNFEAlvw9iCXAGCOBAg9nQE0fCkkJrJ2SHfdRbDGp4JCheeYi22ZGQOsPuKFDQWKx5c3whQRqRlry8LfbJAr+ymWur8twbXGJrAm3k4+kOWNbpvk8OWogJazev216X+DMpzaBZFRwOKk2fMfWvSWBr0X2Trtsrp2piGd9Ll7l6qDA3AfpX8EBE6EwwBPJF5NZrxYXbQLqQhqPVjMaNgRLu51EYlAlYhnlojK8FxyDS8qyFXAgGPt/OFxInuvtxpOTe1zF0Di70ZcFpdnead1Pny5jyJqpjuJh1Dk51qvBZ5KwhrRaABupPn9U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(508600001)(53546011)(316002)(52116002)(66476007)(6486002)(54906003)(38100700002)(86362001)(6666004)(186003)(2906002)(31696002)(66946007)(4326008)(66556008)(2616005)(36756003)(4744005)(8676002)(8936002)(5660300002)(31686004)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0tVK2M0bmIzWUZxaXZlcTZHaE9WTU9tVzBINEtHbWhFdmpCRTV5Ry9aM2Uz?=
 =?utf-8?B?NkxTTWpCd1pjQld1dlVPcUtUVDFXZzRycXRBOFUyQk15enN5dkxhK0xETUhL?=
 =?utf-8?B?NkFHbi91R0o4d0lYdk1zMmhic2dXSldTK2d6Y0dSQklXVXRDemtSTkFjemxB?=
 =?utf-8?B?UDBqajFna043WEdDaDRhcDV4SDJrZHFIOVQ5bFVLUGM2eXcrTWtWNEhwM3hQ?=
 =?utf-8?B?bnI3U054dm9uYjR4NU9OaTFuMFkzeW4xYjl5YTVJdVA5M2M2WVZ6cnJkRkkx?=
 =?utf-8?B?S0R6TVdoZk01SmpFR2FEUlhTZGx5NHNweklHSWdicERNK2NXUWZFMmZRMER5?=
 =?utf-8?B?eE5NRGpsR3hrbnZjdHVnRkdNNHNoZms3S2RBc3plVFdhZlFqd2lQMnZKY3dM?=
 =?utf-8?B?VGgzMUlwUUtGUTR5U1llRnIrZHFBUlhvYU5GcGJkTkZPaGJraU45QlFwWmt3?=
 =?utf-8?B?M0JVREhRL1lYUnN0a3JNc2ZEa3BENURFRnUzdzZiY2hrTUZ6MkZNVVVXTVNn?=
 =?utf-8?B?enI0eEYvU2lHMWx2MnlHeWxQSWlhVTZUWjNVb0FRSlpnTHhMd05pSjNLY2N6?=
 =?utf-8?B?YnRlUEgvL1NBbFg4Z1dQTnhlWFFVclZ4VWRyTStncGxyVVIxVlZ1ZFpybzFF?=
 =?utf-8?B?WWp5cGovRDZ2eGJkdUlZa2dzT3BtNlM0ZmpGL0lMdHFqcHNJKzBKcURFRkhs?=
 =?utf-8?B?MDY2SlpGekhWSXduTk1RSzF4U3lycG85NjIrWmdVOFczQTFhTWg5UFJta3ZU?=
 =?utf-8?B?NTNyR29pbEdCT0dwNm5RcmZFZlhvV0xLeXMxeUc0NFkyWlNFM3JTR3NhNHFQ?=
 =?utf-8?B?ck9vbHRvbXJrOWxOVzlXSkw1WllDbGo2WmdPYTFRU0ZxVW01a3ZQTWQvSUNi?=
 =?utf-8?B?bmZFcGIzNUQ0YS83QUVHRjJjR3hxTWQ0WENYdFFCTUs4NzJDeGRoNWRGNmRt?=
 =?utf-8?B?a1B3Y0x0ejZZZmhMaWhUbWlRQTRFZ29jOHd6QTZWSmVleVRqaWU2Vno1TzlI?=
 =?utf-8?B?VE1RYitpajcvZEQ0dTVWYllYWHpaQVdtWlBVZnBLYWNxNnphTkQ5dFJzcGI2?=
 =?utf-8?B?Q0dHTUVjNGhWUWpLWHVOMzdITnBCM2ZGWCt0bU5qcDBkeXpNemtGR2NGZTh4?=
 =?utf-8?B?OVowMlhBcjlXL09vRnNqbkVacHZlMFlPWXh4UzQ3aHpvelYrVVlKaW9OMitH?=
 =?utf-8?B?WFlMNlhFdzVFaGIrQm9ldGlKTlk1VzVVS2NVeHF3QmxzcU1YUThRTDlsVVhZ?=
 =?utf-8?B?a3B1RVdsQ0VEMWt1cE9FeS8zLytIQ2hZM3l2a0RCMFZHTnRYT1JSZnVadU4z?=
 =?utf-8?B?WmpHRi94QnpuaXRQMy8zNEwxR2VKcG05RXNHRFA0QXVmdmtrWWpvT0FBY0FM?=
 =?utf-8?B?aXkrdlZGZW1DeVA1RXAvNjVGNi8yWXhtaDVmSjVONDcwTktZZkVhc1N5OGlv?=
 =?utf-8?B?N3dnbnhGM0I3STc0QjI3aG1CWDBzTTBucXRLQjhOVnVoUHhlQjZLWWQ1aGh4?=
 =?utf-8?B?c1g0NngxQm9FNWJIZndaNjhjMUozUGZiN1ZDcjN4UmpkM3R3UmNrSU9yMkI2?=
 =?utf-8?B?UmJCQlRJUjdzbUxJV3ZNb2dwTFhjN21leGlzaUFpVUl0K0lJN1NSSzc3YkRv?=
 =?utf-8?B?Y1pEdFlMeE1xbHFCdkpyVk0yTldxZE5Uc3d0ZDVwTUVPa2hHQzVaYTdJS0Ra?=
 =?utf-8?B?TXhvc2g1ekEvRjcyTXRtelNXeHlFeWNIbGNpd1ZsT2szZjlQVW5vN1J3VW5X?=
 =?utf-8?B?NEE4ajdpdnFYd3JhdXVQQkhwL2xLb1JlTDhsejM5Mm9TME5sZ2FtelJIUCtP?=
 =?utf-8?B?M0QzMFVQb1F4amsrM0lwWmhRMFBWazN2ZmNMQUNEZVRTZGpaNXV6ZHJHa2oy?=
 =?utf-8?B?M0ZSekNyc0s5czQwdDdxaTlYK0JpUER3TnZJUFpJY2tuN256TXczODFUN2ZS?=
 =?utf-8?B?WkNMNXh5NW5wbHdYYVNqSHVuZFZpQTZuVWV6MWt4Nkc5Q1Y2YkhqOXJUMmxW?=
 =?utf-8?B?QllWUUVtNHB1N3N3OC82bVM1QksxejNjMmdyMkZ2VTMzYm9Fc1NyTmlvVEIx?=
 =?utf-8?B?OXdWcnhhQ3ExV1VZSHB2bDlRZk52UVkvN2JFK0FYTUI4aWNOOEtsdWZ0SFN0?=
 =?utf-8?Q?VVRlxyTdlEIModYsBeNTauV0j?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a006da7b-1c6f-47b2-1407-08d9c5aaffb2
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2021 00:27:27.6796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UnBqu802j/D2oqSRVNkhIDUwm7s5YvMy957okH6uGVbPQHZLcRcSnfrYSjU4O402
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4903
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: -rK6GfhiM3R5iKaH7g_ircGxR-OJyUzo
X-Proofpoint-GUID: -rK6GfhiM3R5iKaH7g_ircGxR-OJyUzo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-22_09,2021-12-22_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 adultscore=0
 clxscore=1015 mlxlogscore=830 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112220125
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/22/21 1:39 PM, Andrii Nakryiko wrote:
> Improve bpf_tracing.h's macro definition readability by keeping them
> single-line and better aligned. This makes it easier to follow all those
> variadic patterns.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Yonghong Song <yhs@fb.com>
