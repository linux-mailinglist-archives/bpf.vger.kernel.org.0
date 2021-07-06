Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 375DA3BDD82
	for <lists+bpf@lfdr.de>; Tue,  6 Jul 2021 20:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhGFSsw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Jul 2021 14:48:52 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35238 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230084AbhGFSsw (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 6 Jul 2021 14:48:52 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 166IZN9d004777;
        Tue, 6 Jul 2021 11:46:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : references
 : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=RUD2gaviQdifogSsFDzQkYy0Hhe9q+d/ctdKL98Dbe4=;
 b=qNywMJnl55VqsrSBfCehk8AxuJpyNgruFNOEpkmndyK06NAVvFNodhOvsCrKT3SiELt5
 htZgh13sYrjBmWqMz85cfPenUDIuDNn2tOAWNsKjsbk1JGnFvldh808D44LcF0zGjB2+
 ztHxnzOWdBJsjMWGgpwfvrWGB9hBbDYkvuQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 39mhu43sqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 06 Jul 2021 11:46:09 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 6 Jul 2021 11:46:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EbfGtInEnribaBYB87auNtx7GNDVewl4Ss/KzOMSfw3qpSX6ODpXn6vdCl/BNOGGop4qX3x/FTSE06R3JVUv5lDDE+xtFzaqfMIcVs4jQczHiAKP7k04IhDypX1jtSrHM9G3870MQzEagUzjaewcYevgvPQRouAYoj+XWkN/KElC8BPjEFXIryinhSDiHxNIfTuKRdYz3AzB33yP1cx6yudoodVfA84dxGzIdQs+WMrTfVRkS0eQwwEZUOUjMi/55Wt5PW4vO1fAqRlGrz39E58tSHjJ+A4fI8UDO4PhKxg4myQXXww9VMyjn/ArpYgKVEc77YbgzQegBnVkShGpgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPfK814frfvBFP83r6kgapSZ1OC7Xm2iwJoBRL/vMEw=;
 b=BMf3cMVCFZd7wQUxA44dwrrSEZX+8JtCHXoQEaWZ+3yndcaF3AdpTWXEBvzspV0aFVhbKqGXz3i62+v1UwO0L/jTdGsfCwod0MzKMCRIn9HF4TD4TLJ0eJSMfm8XbQT9bdf0zUzKY56z2Issmom5IojcFdsXhAG9c3Upq3NOnJeI9SDcVMA9N3qf/JV8uGZK++hCdSM4+GAVpW3IGhjFvg7obXeifMEgufgTmbobYe+Qu2Qpa0gItxapud1c3ZNzYsTvg+SScFie9xweMFRr5W+UrJ61O9JbH625/mgDNjtPAD+OOwqxPnX5A9616tSAtKRtwepQHnQ/JxWvUu5eGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4497.namprd15.prod.outlook.com (2603:10b6:806:198::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.31; Tue, 6 Jul
 2021 18:46:06 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906%5]) with mapi id 15.20.4287.033; Tue, 6 Jul 2021
 18:46:06 +0000
Subject: Re: using bpf_map_update_elem and bpf_map_get_next_key at the same
 time when looping through the hash map
To:     G <chapterk93@163.com>, <bpf@vger.kernel.org>
References: <51e18157.22f7.17a79cc5306.Coremail.chapterk93@163.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <87a28f77-19c0-636a-3c79-a2c4eec17d81@fb.com>
Date:   Tue, 6 Jul 2021 11:46:04 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <51e18157.22f7.17a79cc5306.Coremail.chapterk93@163.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR16CA0024.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::37) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c1::19fa] (2620:10d:c090:400::5:e2df) by BY5PR16CA0024.namprd16.prod.outlook.com (2603:10b6:a03:1a0::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend Transport; Tue, 6 Jul 2021 18:46:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ecf82230-b75f-4314-81a9-08d940ae5066
X-MS-TrafficTypeDiagnostic: SA1PR15MB4497:
X-Microsoft-Antispam-PRVS: <SA1PR15MB44971B26CE5F588629E90F07D31B9@SA1PR15MB4497.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6bkyFaPoBe3GFY/kf+aX0+r0e0EXMslPcI4mvvdf0siyVDbAyo8nRB/KwGAq9bpIvFaGJ1H0JTsqKAqu2CTPzc95odzemSqi7XsmcN9/xB2GOeW9voiUsrnW+20wvZ9M8zI4dg5Avxl5Fo0CIrctyrGR+oBj5JZcjTEGmLYPVTtgM9xeVtPkmvHDtvsupTb2hzY+ovy0KWQT9jxlbGcp2N5mIaFx5VmDF6MgXSuEAotL6I4BCBCtHFJhLi6bIjv7g63BewgPwSk/01tJWhresbTRKCI/9WZA/Hj4vU8yo8b5HAf2EIHMtgDB27ctwNr6mPdgNiMvWyZ0kwSy22rZI1ea/gAAXa1VT09OBdFiZrYLHpYulZOyz8edDjrt8lvWFhl9foqOPx+9FU1hSynqPITa1dV6Ep9U0RTTFFmso6fiM6mlTcpRB1ZucYwTWEDSDISB1LpM4XsF9CUqvaHOa4EsqMcdONNoOmvGrcTVxsAFMrWTUU8oiA2hT/eCbabt0bq2OrPKwDeXtAdEO4MkmGycE7HV7S5WYtDhPVMahck2LEt0xFAyJ6xEfgM1jIWR3Nsa0ntOqvVyb65E8wS5PANDK6yU+DFHmLIDmppqhPY5nosreMu3ecBNQ/yxU9/IxHaO5qbZtNcg6w3PMfRaUtNlWPXdfL6iS5YcTBx72/AMMun/kp1dw1jU8bjZsn9C9asEetqY/pRwHxLeTZaTXXr50UkuOOY8SlR6eC0cwO0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(366004)(136003)(39860400002)(346002)(478600001)(186003)(52116002)(2616005)(6486002)(38100700002)(8676002)(5660300002)(8936002)(53546011)(66556008)(86362001)(66946007)(316002)(31686004)(31696002)(83380400001)(66476007)(36756003)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?gb2312?B?QkY1U2RYdU1mbzE1VmIraUJWRHJPQ2E0WFkwa1NSaGRMT2dNemNyekpqUk96?=
 =?gb2312?B?NnY4NFczcERPTjdhbjgzazhUSFJOalBuRmdRODZhMGdySjJleFo4T3BmclBk?=
 =?gb2312?B?MHhiSURneVV3M2FVY1c4djVsUkVseUJnU3lEYkxPc3ZhaWl3c1lIVVVYQkpO?=
 =?gb2312?B?NG05cEVyMTBMWTdyRWw1TmdWTjJERmp6TUZIOURYUjdNRXlYTEh6OExWaUpt?=
 =?gb2312?B?UVM1bzNlYklFMlNRNS9uQnBIVzZVRkhXTVpjWW5aaWpSQW0xSVBlVUpkb1oy?=
 =?gb2312?B?aWc4MU83RFE4ZWl5WkROU0E3UzAvdEp1MG9SOGNZb2tDYm4rSHNFdmQzOU1v?=
 =?gb2312?B?VG1maUNqcnR3WFFPUmJCU24yZ2pBRVQzKzZMVlMwMEx1THpmTFJROTVoTXZZ?=
 =?gb2312?B?WE5MdVhRa2EyVktJMmN1YVFUOWtpME4rZTBjMlJtTWNUK3NnWjBEbW1tYmZG?=
 =?gb2312?B?S3dMZVRvM1hCc1lNaVJJeEFDdXQ0aFdJSU1aZU5wWHZjUm9jZitBMU5xRVAr?=
 =?gb2312?B?MjlxZmp4M1BSSUlzK0RCc04rSWhUWDcxUzUxZUVOREUwNHI2UW1USndUamlD?=
 =?gb2312?B?dFdGcGlrRExZWW1aeDlFbkJ1ejh3OGIvM3RuUnpqeUVDOWhRV1JBRDVrbGpx?=
 =?gb2312?B?ZDZrYkFOU1RZY2h6U21xbE1nZUdSY0NkZmNJakYzVmJUeHdweDFJTkdtUjZV?=
 =?gb2312?B?NUZyNUx0elYrWnBScy90NktUa3lKS3dLRGtBcXMwR0lYbmE4cElZUGpzdVBD?=
 =?gb2312?B?VWcxTlBCZ3NOK1BlR3c0N2xVK1pWYW53OFhqVVlva01qTGFZbmRGempiZEFZ?=
 =?gb2312?B?M2FFSmVXNE40aHg0VHNZejhDdXVFdHY2WnlZUlI4VkxMSDNlODA1bEJOeDV0?=
 =?gb2312?B?QVNFRitmemU3RzFTUEZVbFNXVENqcTRTbTVyaEZqeWxBTzF6MXIrT2dwcUZQ?=
 =?gb2312?B?dGlsK3JFRlBMZzNYU3FvOEhJQytuN0RwUHNJSWwzVXFhUkRkbnJCSDAyUkxK?=
 =?gb2312?B?cWtxNkwyUU9LNS85dTI0NS80QmhZcnBHcDAxb2NpV1pwSWRsK25ZY2hxQnhG?=
 =?gb2312?B?bFlNNkNnMk9pR01hWXFCcXZxM2FrdVd2eTREc0lPVEowYzlpSk1CdXZ3TzFj?=
 =?gb2312?B?N0xlTUo3N0R6dkQwUlVValdlKytnMk5vR3ppVnhqbTIyck05T2QxeGV1SFMx?=
 =?gb2312?B?eFg0a3hQRXpkVmRXV2o5TjdFSkJ5M0p5NjhjdDI3dWlHa0JlNkREQS82MjZB?=
 =?gb2312?B?dXEzRE5BNjh1dUlUekRTNzE3UTVpRDRHbnE4Y0dOMWczSXZFOUFxbXJvL0FZ?=
 =?gb2312?B?TGI5b1FqYWZnOGZkejNodWlzMFhZbjk5VlV5KzRUOWpWMkdGWFFyVE9zdVM4?=
 =?gb2312?B?T3Jlc241RXdJa3hwVGRndUdtOXcyVmFNYVFLYlRXYUxGNTBzVGhSc0g2ZFhK?=
 =?gb2312?B?T2V6Mmd6dDJTaVJ1V3hhbVUxblB4c2xQSUtxYWR2aWFLR1N3UGtxbkNnWlQr?=
 =?gb2312?B?R3h4amtRZVZWL1hrRXBUaDhkcmE0K0RUaENSbS8vK09tRHdrZTN4UTNETFlG?=
 =?gb2312?B?UmVPcHZqeHN0eDBzeUdMVzZ1SVRHb1FZMzVydFY1VW1QcUYyT1I4aVhiL3lY?=
 =?gb2312?B?R1FiVlB1dlpVZEtXZC80TDA4V3pkbDl6OG5FR005OFlQZi9IRkhtVjFZRzd1?=
 =?gb2312?B?Rkp5YkNHVWgwM1RCMnFUdDRWeXcrTjd5eW9kd0l5Nm9CUnhzZUgvaGdDQkdy?=
 =?gb2312?B?V3lyK1c4UURLMG9JbFFNMVdNbHlBRXNLK1VBb1BsMW5LSGFLQm9iZFJKUlJF?=
 =?gb2312?B?dExBTDBLVUpkTmdkeHlodz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ecf82230-b75f-4314-81a9-08d940ae5066
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2021 18:46:06.8067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UuAHLU2SRtjt4HeoWwBr/c/qCj6b5rOy8XfmjkSol5ngC8KVjM3VOeRcpeDljbEt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4497
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: D9nWTvGRXuy66DjddblOCUz0X3GhH48U
X-Proofpoint-ORIG-GUID: D9nWTvGRXuy66DjddblOCUz0X3GhH48U
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-06_10:2021-07-06,2021-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=819 clxscore=1011
 lowpriorityscore=0 spamscore=0 malwarescore=0 phishscore=0 impostorscore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107060087
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/5/21 8:11 PM, G wrote:
> Hi BPF Experts
> 
> I'm having an issue with using "bpf_map_update_elem" and  "bpf_map_get_next_key" at the same time when looping through the bpf HashMap.
> My program turns to an infinite loop and the pseudocode is as following:
> ------------------------------------------------------------------------------
>      bpf.MapCreate          // type=BPF_MAP_TYPE_HASH size=128
>      for { bpf.MapUpdate }  // add(update) 128 elements at once
> 
>      then loop through the map to update each element
>      bpf.MapGetNextKey(fd, nil, &scankey) // find first key
>      for {
>            bpf.MapUpate(fd, &scankey, &val, BPF_EXIST)
>            bpf.MapGetNextKey(fd, &scankey, &scankey)
>      }
> ------------------------------------------------------------------------------
> 
> I have tried to read the relevant kernel code, and seems like it is moving the element to the top of the has bucket when calling the ¡°bpf_map_update_elem¡± even the element already exists in the hash map. See the following source code:
> ------------------------------------------------------------------------------
>      // kernel/bpf/hashtab.c
>      htab_map_update_elem {
>          ...
>         /* add new element to the head of the list, so that
>          * concurrent search will find it before old elem
>          */
>         hlist_nulls_add_head_rcu(&l_new->hash_node, head);
>          ...
>      }
> ------------------------------------------------------------------------------
> 
> Therefore, when I was trying to traversing the two elements in the same hash a bucket, it ran into an infinite loop by repeatedly getting the key of these two elements. Not sure my understanding for "bpf_map_update_elem"and "bpf_map_get_next_key" is correct or not. My question is: is that behave as the design? or is it a bug for the bpf hashmap? Please let me know, thanks.

bpf_map_get_next_key() is added after bpf_map_update_elem(). So the 
above behavior is in the kernel already for sometimes.

bpf_map_get_next_key() is not super reliable for hash table as if some 
deletion happens, the get_next_key may start from the beginning.
The recommendation is to use bpf_map_*_batch() interface.
If your kernel does not implement bpf_map_*_batch() interface, I think
it would be best you call bpf_map_get_next_key() for ALL elements before
doing any update/delete.

> 
> Best regards
> W.Gao
> 
