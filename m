Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05D7C1D380C
	for <lists+bpf@lfdr.de>; Thu, 14 May 2020 19:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgENRZM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 May 2020 13:25:12 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51294 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726075AbgENRZL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 14 May 2020 13:25:11 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04EHJCnv016819;
        Thu, 14 May 2020 10:24:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=4rSTDRhq6+pyfxcYzqq1O3Pl9R1FpobxN6NxMh+pGm0=;
 b=QNAz8Ly1PUDW/bFsxv/9vlSU/nbrQVHEZ/8UutTU8TsfuH7RJkTb8MuLmgyDsRzg8QZm
 1TSzu/gOh50stGGVK7CoFbauggd9UhqrhSj8tlI5uVdqRbNNBJ9EjvuD4Kb6vkkDSvp9
 tYVFnwy/DGlUS50WUvODZncuuAlK4nxqjUE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3111r0jvgw-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 14 May 2020 10:24:57 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 14 May 2020 10:24:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ip6OouiiRALuMmRDVsSTGsPx76yevdpujkbHu00chT3Xl5aLKaLPDQu+EE8n+NEdnNwqp0rBCUU5pT7E4bnEIS9pSyphM+yowKaOxAkpphME2OMWfyU273xfsWJgQmvW5tTN4ynDe4/wnm/0/WPlaHJyJ5iNQ74gddXPmbeRE5BXyCicLC3dvEbt4jD42/mUvlGGBIQHOJI+p+jVD66k9DlIVhjhmfZ+RNxJ2bZEZE3PIMN+rD39cVFdaljVBZXOwJImHaCBiHA+CO2chhg2OfSdRMMjFDtyOHF2LcRrVkrzaym2y+DhtTWJnnnxhCIsbWKWowpFSCrNFkMt6FDmsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rSTDRhq6+pyfxcYzqq1O3Pl9R1FpobxN6NxMh+pGm0=;
 b=IE9dixatlcVtHwqnO8ByH+hWlIcoalmGjaXoUNkgLpHeFOFGQNGMXjXgjEhluhm6/nQFDjaemrDAtRkF678O88YajByV3Enfv4UC2Ytz1R1Fe+6y+ldAQ0N3+k/zzNYkwb/uLJf3x0YdjTe54sWH231fpNMyFBCdvy9BhIDiBga2n4yRhVedrr5dq4v/zq9bjhX0iSmhcc7edgbNnRLatgLmVSvFj1uoS0Pf5VcTSpfrWkSmnbRHlBF7qUXfF6XyXOsDEhchtn2FJZ1Xzn5z0PcTNKT8fehfAJ9BZREZ/vig04WGxszZ6lxgRwruZYOEYOZApxnhZ/r7YYud9I3c3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rSTDRhq6+pyfxcYzqq1O3Pl9R1FpobxN6NxMh+pGm0=;
 b=bGfAK0tfICzDnsfHq8ahY7Z32rxIAwe3J8ot427mPjNc2XD/s5IUN0Yy5HWd3Au4ymWgSEVvdfPQ1itc+rDFIH3Acjbi8A74OX81i4V0fWpOgLyRx2W4c5a2s+noGHqSSut3/C4tO66EYgpddyYGPB5S7kBSWIVrHpc9BjcgW1c=
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3336.namprd15.prod.outlook.com (2603:10b6:a03:109::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Thu, 14 May
 2020 17:24:52 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301%7]) with mapi id 15.20.3000.022; Thu, 14 May 2020
 17:24:52 +0000
Subject: Re: [PATCH v2 bpf-next 3/5] bpf: Introduce
 bpf_sk_{,ancestor_}cgroup_id helpers
To:     Andrey Ignatov <rdna@fb.com>
CC:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kernel-team@fb.com>
References: <cover.1589405669.git.rdna@fb.com>
 <c65795a13e69b7e4aa61a8e37aa340f2484f6c8a.1589405669.git.rdna@fb.com>
 <f885aa42-eb76-415a-7fe3-95ad9c4f38c8@fb.com>
 <20200514165549.GA22366@rdna-mbp>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <6cc5f0a5-b6af-e74f-2266-d5c85a0205f7@fb.com>
Date:   Thu, 14 May 2020 10:24:51 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
In-Reply-To: <20200514165549.GA22366@rdna-mbp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0103.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::44) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from macbook-pro-52.local.dhcp.thefacebook.com (2620:10d:c090:400::5:3bff) by BYAPR11CA0103.namprd11.prod.outlook.com (2603:10b6:a03:f4::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend Transport; Thu, 14 May 2020 17:24:52 +0000
X-Originating-IP: [2620:10d:c090:400::5:3bff]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e2accbc-8309-43d0-19a8-08d7f82bb68e
X-MS-TrafficTypeDiagnostic: BYAPR15MB3336:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB3336CA3C557C581D7BFF759DD3BC0@BYAPR15MB3336.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ibJQVcfmcyWuPAlO80hTfAP3xzE2jF0rEPnTbw8IBeQTHbcRmBbBCwxfHFHeveEwtmh4ri73yaO8SLiV/VrCCW+9yC411AVQbWJvy8UW+LVWg9h/zkKnO6UqH8lxSgF/E7ZfiVYsYexpc9q83E9X90Z6s+ZEZFOp7z4jGW0N6JOhgBc3czYX1Di7FhlBejWl5RfXgvL5T3Hc6c5RGTgZ+hLs04kVqdX474pMNTYtfRAaQkP4VLQ4r0+Rqk2ZY+xQ3ZncfwEaV9MbIDLVMqXAOk0sPMyIU+hMCJUzzoYgeAqfK78n9HiRy6iWMVCCva24fcaQPsOeb4xijZ5vzQROWv+vG/WGtemVFLMEDINXY380NGQEzlbKefk+cziWqt7wovJ2juL6XgNRBgCtGjDv11UeuDXQktNcH7RXGTfLMer6+rWt6Lo7lpr3vku1NGtZY59Hf7Rk59OgIsL80t4S660y6bMIAzVtdfTiU8RXxHiLIQYpPY24knCqvJqOZy6FU5VafFZ12epGY6DdS3fsbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(136003)(376002)(39860400002)(396003)(366004)(8676002)(6506007)(186003)(478600001)(31686004)(31696002)(53546011)(16526019)(52116002)(36756003)(5660300002)(8936002)(86362001)(66476007)(66556008)(2616005)(6636002)(2906002)(316002)(37006003)(6512007)(4326008)(6862004)(6486002)(66946007)(21314003)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: dl5K97uYHT1VTVUJ8sY1jEZRv4vaf1DIlhKkN/Cel2Fwte8lgfJi7fcMoLVB6jGhqFFaVeQCakKVbrmLTAZo/ITfPto1RfFdKQy/pKArIuhq8Ede0dqr6ddzGn2KrvC5TbkW54k46m4UUaXEgG2MnCniEqIhElRECV56xs6CI/+4ve/O5WLD3vVwAShnz6Qz0VZvyNceJnRdaqRi2hmW2QAr/e+sHOPAFPaRHFcQ9cH5ag7Jn/3Cz+npOkGw5SIFFGJV2CbsmmOxpitthaz8VFQomtuAALmtF8TZHksln70nrtunXUY5Fr/14bHAlHhbocd+NCZIcP0x2KMONc9qPIShwmqmFXhPCorVk8/FMfVCTUOetsFuPl+PfVs6WKJ2Kz6aTjl8YY12i8+/rC382L9UFXcgNEfYbkLQBIJ9jligfKB317vXM9cIR2ZDXYsMhIfUPWOOEK0TwT01KgjPdfHg2xIowJPM4OQJ74BRNozGP9q9VqRCRbNdG7wG7YqxpQiHHcod6iKi+K9Pe6aASA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e2accbc-8309-43d0-19a8-08d7f82bb68e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 17:24:52.8111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QvGo/tLc9V5m5/pFglb+TB9lmIET3HXiYJDd8aDZhXbsMsiT9pU13eKHyhGoDVrf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3336
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-14_05:2020-05-14,2020-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 cotscore=-2147483648
 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1015
 mlxlogscore=999 impostorscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005140153
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/14/20 9:55 AM, Andrey Ignatov wrote:
> Yonghong Song <yhs@fb.com> [Thu, 2020-05-14 08:16 -0700]:
>> On 5/13/20 2:38 PM, Andrey Ignatov wrote:
> 
>>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>>> index bfb31c1be219..e3cbc2790cdf 100644
>>> --- a/include/uapi/linux/bpf.h
>>> +++ b/include/uapi/linux/bpf.h
>>> @@ -3121,6 +3121,37 @@ union bpf_attr {
>>>     * 		0 on success, or a negative error in case of failure:
>>>     *
>>>     *		**-EOVERFLOW** if an overflow happened: The same object will be tried again.
>>> + *
>>> + * u64 bpf_sk_cgroup_id(struct bpf_sock *sk)
>>> + *	Description
>>> + *		Return the cgroup v2 id of the socket *sk*.
>>> + *
>>> + *		*sk* must be a non-**NULL** pointer that was returned from
>>> + *		**bpf_sk_lookup_xxx**\ (). The format of returned id is same
>>
>> It should also include bpf_skc_lookup_tcp(), right?
> 
>  From what I see it should not.
> 
> cgroup id is available from sk->sk_cgrp_data that is a field of `struct
> sock', i.e. `struct sock_common' doesn't have this field.
> 
> bpf_skc_lookup_tcp() returns RET_PTR_TO_SOCK_COMMON_OR_NULL and it can
> be for example `struct request_sock` that has only `struct sock_common`
> member, i.e. it doesn't have cgroup id.

So you can do bpf_skc_lookup_tcp() and then do tcp_sock() to get a full
socket which will have cgroup_id. I think maybe this is the reason you
added bpf_skc_lookup_tcp() in patch #1, right?

If this is the case, maybe rewording a little bit for the description
to include bpf_skc_lookup_tcp() + bpf_tcp_sock() as another input
to bpf_sk_cgroup_id()?
