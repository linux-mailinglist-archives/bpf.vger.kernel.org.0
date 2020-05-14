Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00F111D38FB
	for <lists+bpf@lfdr.de>; Thu, 14 May 2020 20:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgENSPt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 May 2020 14:15:49 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:37752 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726084AbgENSPs (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 14 May 2020 14:15:48 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04EIFQaM002293;
        Thu, 14 May 2020 11:15:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=H19spleZv5freAFsEBxWu4B8GP2jiRGC+DFzfpknNYM=;
 b=C1O5KbRrLd8hhgIXw/YJw73tHXiFs97pU3Zg5eI9MsPQmjWY7wYye3DYwYnRdrx9bBaV
 3sViuDiAqyCsAOujhZNLJ/sg3mwUiDvtQaQRCubhobjr4WQLdyBzX74Lnac2yEbe058X
 IGmT1tLSzWaYNiEesiBzGy9v8gAP+xa+54E= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3100x74yf7-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 14 May 2020 11:15:34 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 14 May 2020 11:15:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZZFtf8R99cRZmz93mdQlMB9iZDDCVnQYL1AtNwCK1ikV56sjUS88pjSXqVYQUGyb7lBF6Ts+4OLiL8tQLk0bYO/DCtkVXr7xPhg5q/GRt/MSIQj4FD71N9FPtAPlX/JJsRTR1POYyfz196johTprMkFkwmTJGDc0UJS3HVY/d4MbHsZ56kWWVMSDPif0wxIoKleb2qFs7zf+AB8BXo61KZsUo4g87WkL6JAIhBVUB/oT1GwNEHUH128nE0J6WROCFVgrMwB3WAWbKDrVuyX0iRh11rkuAogTbXGHHiEaYB1kg+mygNdxGprHzQVMbGddxGOfBr6ZnEoYXWg2wd3Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H19spleZv5freAFsEBxWu4B8GP2jiRGC+DFzfpknNYM=;
 b=bcdKvE+IVwmh6W76tK39KQ/Kp0B1GkvmZYnAI1jjNFqrz0/HDNNbnEp8e7/Yd2zSs8j0BWBNrDipfTI6MlP8I+PCUjVfw7Xoy4Sx8RXl0C/1qE8Sdca4ijyhCTkDJKqf+QkhpmtAe7qaBAs2Pg6R2BEW+JhwoJQ+RczQhmY6WVfIXRdolhlgPPWuiGlQqnqWNMwePbF5jkRXZUSGE5MyZ2RgT6hh2xs1DX7Tz0dr5Ek6XZP+FoOyKNsq4WVjw4euMaSYzKEpWX9SRwVH5Uw+5Itc/qTBHO0lwRXamg+36AYD+e1fH6lD5WyS0LjSJiJBUnh7pneNQO9/EvHAH+Sx1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H19spleZv5freAFsEBxWu4B8GP2jiRGC+DFzfpknNYM=;
 b=WRdjIhF4bgHftDUiF47So3Ux8a49Lpx2FqRPQGGvehpEDBFC8VXjYgRup9RcNYTkfTOYtn+SUFozWP1vFEMVAapZqb7zlxEyfNZo9mV+nevVVSNj4+N/UvfqQM6T4vNui06VDxkvfAFO2LjrPSg+fUptDQFQduDSN/7kgDX0QzQ=
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3222.namprd15.prod.outlook.com (2603:10b6:a03:10d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Thu, 14 May
 2020 18:15:27 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301%7]) with mapi id 15.20.3000.022; Thu, 14 May 2020
 18:15:27 +0000
Subject: Re: [PATCH v2 bpf-next 3/5] bpf: Introduce
 bpf_sk_{,ancestor_}cgroup_id helpers
To:     Andrey Ignatov <rdna@fb.com>
CC:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kernel-team@fb.com>
References: <cover.1589405669.git.rdna@fb.com>
 <c65795a13e69b7e4aa61a8e37aa340f2484f6c8a.1589405669.git.rdna@fb.com>
 <f885aa42-eb76-415a-7fe3-95ad9c4f38c8@fb.com>
 <20200514165549.GA22366@rdna-mbp>
 <6cc5f0a5-b6af-e74f-2266-d5c85a0205f7@fb.com>
 <20200514180110.GD22366@rdna-mbp>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <de7e9449-2f73-0366-7cff-dd692317cef7@fb.com>
Date:   Thu, 14 May 2020 11:15:24 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
In-Reply-To: <20200514180110.GD22366@rdna-mbp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::14) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from macbook-pro-52.local.dhcp.thefacebook.com (2620:10d:c090:400::5:3bff) by BYAPR03CA0001.namprd03.prod.outlook.com (2603:10b6:a02:a8::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend Transport; Thu, 14 May 2020 18:15:26 +0000
X-Originating-IP: [2620:10d:c090:400::5:3bff]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95df985c-d726-44b5-a406-08d7f832c747
X-MS-TrafficTypeDiagnostic: BYAPR15MB3222:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB32225AF888DDAF6E9E773AEED3BC0@BYAPR15MB3222.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LI+dPMvS0agz+8d62DxeHfR1SRhEmD/Ui/rrUJSctENGP/nfaasewp0EsvggT0uW76AtfciSNQEjBDjhDSPaRfS1lsZsS9mf63h1cgC2uMDWsZyyNyw5YPMDaa8x8AvaQDZ0M3QXLxrt67pdQ4k+czk1YmevT7p22004Cikg9iN1ydlQT47XmyB16RKxJfeoxWCQ5JwGfCFKbTD9pThfmeq0D/1Gp342NRBFATfc0490RdLDtHdK9iABbPjqWoX9WQxB2EP+HUbdKv6kgbip1Gt5/aMwzhFQETGRo6wUSifr+xzfmExoj5EXD1EocAK25zogxe4+e2r69Qr/LIL/KW0xcZ6UbnjdpM+6sQlDJeU9vgwN7CKawaDFhfyJeRx/JgjAzlTa1M8VXHWBwOj0iXBdX9mNUar052vsMjWhWSZIb3NassjcWhCJAAJYz+w4F+mROVkkKNtmGnAUSsP8nU8b/auV4auc7TxI4fLYcXOQXO0w6i9jFk1ddljqn5folnquhCGETMdMF8Ebh1cYWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(376002)(396003)(346002)(136003)(39860400002)(4326008)(31686004)(52116002)(8676002)(6486002)(66946007)(53546011)(8936002)(6506007)(2616005)(5660300002)(31696002)(66556008)(86362001)(66476007)(16526019)(36756003)(6862004)(2906002)(6512007)(316002)(37006003)(186003)(478600001)(6636002)(21314003)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: JGl1N97/6mnAAYSXkUejsmV9LM96mIDvMCPxdlQCPMzJbzrcEI71xUndn1JB0zfViWVFDEERTfz1ahqhA3/xNgUlbfmhEGjoWRpejJaZExewuogSUthlCR95DZACgZnNPzortYwqgavv5iTCKESuMEw/ensEcFi2JMF86rHGVOufuI8IoF6qWshQfmqQvtvNU+rbuDegrv8fXYSq93sWexi/wb4tRKlNc5pqrqaCyeqMJGVoszTgk/GuCfliSafSMnRGRJ3b9nvHM3o38AJbdgVPiFs1oLPxDuo/SQiHQK5sgUd5JQzCSH3ksiHrWMyh4QPq/M+1EENsSURzkabSTbTE0n1tgrMXzK7hoHrgLvBR+Aqn4258UcJVjsugNaVys/Arcq9RE6XJ1OIaQwO4Ts6CnJMw6npJD9bdnp6FDZywXXPp+8rnzrx+sRJk5b9f2smSbvmSw6N5ZtIAMfGlirAB34yDQ8mFzrdH2MZOJlsKgs48WIwBfiT5pIjL1XOUKQh7a4uEFF7UGK432GvfYA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 95df985c-d726-44b5-a406-08d7f832c747
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 18:15:27.3987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RHsAOzZQ+U7ACujazGMNAFs64fAkCbNcsemLGE0I/47dCJzSy3KWsIM+UY2NQUp3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3222
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-14_06:2020-05-14,2020-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 cotscore=-2147483648 lowpriorityscore=0 spamscore=0 adultscore=0
 impostorscore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 suspectscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005140162
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/14/20 11:01 AM, Andrey Ignatov wrote:
> Yonghong Song <yhs@fb.com> [Thu, 2020-05-14 10:24 -0700]:
>>
>>
>> On 5/14/20 9:55 AM, Andrey Ignatov wrote:
>>> Yonghong Song <yhs@fb.com> [Thu, 2020-05-14 08:16 -0700]:
>>>> On 5/13/20 2:38 PM, Andrey Ignatov wrote:
>>>
>>>>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>>>>> index bfb31c1be219..e3cbc2790cdf 100644
>>>>> --- a/include/uapi/linux/bpf.h
>>>>> +++ b/include/uapi/linux/bpf.h
>>>>> @@ -3121,6 +3121,37 @@ union bpf_attr {
>>>>>      * 		0 on success, or a negative error in case of failure:
>>>>>      *
>>>>>      *		**-EOVERFLOW** if an overflow happened: The same object will be tried again.
>>>>> + *
>>>>> + * u64 bpf_sk_cgroup_id(struct bpf_sock *sk)
>>>>> + *	Description
>>>>> + *		Return the cgroup v2 id of the socket *sk*.
>>>>> + *
>>>>> + *		*sk* must be a non-**NULL** pointer that was returned from
>>>>> + *		**bpf_sk_lookup_xxx**\ (). The format of returned id is same
>>>>
>>>> It should also include bpf_skc_lookup_tcp(), right?
>>>
>>>   From what I see it should not.
>>>
>>> cgroup id is available from sk->sk_cgrp_data that is a field of `struct
>>> sock', i.e. `struct sock_common' doesn't have this field.
>>>
>>> bpf_skc_lookup_tcp() returns RET_PTR_TO_SOCK_COMMON_OR_NULL and it can
>>> be for example `struct request_sock` that has only `struct sock_common`
>>> member, i.e. it doesn't have cgroup id.
>>
>> So you can do bpf_skc_lookup_tcp() and then do tcp_sock() to get a full
>> socket which will have cgroup_id. I think maybe this is the reason you
>> added bpf_skc_lookup_tcp() in patch #1, right?
>>
>> If this is the case, maybe rewording a little bit for the description
>> to include bpf_skc_lookup_tcp() + bpf_tcp_sock() as another input
>> to bpf_sk_cgroup_id()?
> 
> Yeah, this bpf_skc_lookup_tcp() + bpf_tcp_sock() combination should also
> return a full socket that can be used with the helper.
> 
> bpf_sk_fullsock() is one more way to get it.
> 
> I'm not sure it's worth listing all possible ways to get full socket
> since it's 1) easy to miss something; 2) easy to forget to update this
> list if a new way to get full socket is being added.
> 
> What about rephrasing to highlight that it has to be full socket and
> **bpf_sk_lookup_xxx**\ () is an example of getting it?
> 
> For example:
> 
> 	*sk* must be a non-**NULL** pointer to full socket, e.g. one
> 	returned from **bpf_sk_lookup_xxx**\ () or
> 	**bpf_sk_fullsock**\ ().
> 
> Will it be better?

This should be fine. Thanks!
