Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1499C46F680
	for <lists+bpf@lfdr.de>; Thu,  9 Dec 2021 23:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbhLIWNN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Dec 2021 17:13:13 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:62046 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231253AbhLIWNM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 9 Dec 2021 17:13:12 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 1B9Lp7iB001363;
        Thu, 9 Dec 2021 14:09:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=FsfpIVX//rFGySwCYhkDq7OdMVt2ExJqkMZ81ouov40=;
 b=WgcukQ8IAw6alsVQKp27RYmMX0Um8qAfiMEoZZRSsHwjNJz2Ef0RHuYuBrQlBTKSpbpE
 VdDQWe50RASb7bE+w8h5L3pQDSE30f39hc1/GDTDccWo/15LbPg0IFNcufB5zEGXQWe2
 0dH3wgQ2kSQ7l8AQzuAPIjMDRJp1SAwcf8Y= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 3cupvj9m1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 09 Dec 2021 14:09:18 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 9 Dec 2021 14:09:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FgPaXcrLMx4Pl2uZWpiZUzqD5H3SAz3zs0TsNqTcczMqkR8wpp2qATwW4gEtGoOZpWOG8NkkmqzGsxxhEhgGCRRNKB9FrMCVKyhMs/dzPURK54VLtkS2Kwc+Wwy+lBnq+BBjfyJd8ourRgMbU5/nTrr6JBXHXK/Ew+6rUstr/zYYhBK2xXsGZgKd2rGt5VXSukeVicqxmGfuFXBNCIsTTpLDuBVJ8fZssViX0x4Vn9mCLC9ptDMgk72jZ7DLlDSli6ilqvDShr43OlVdimVuG95RLT/Yzhe+14jtXAFQQLNMLH1AwXfQAPeNXM4V0NT+aeP51WaO9jukBiiQ9BXgoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FsfpIVX//rFGySwCYhkDq7OdMVt2ExJqkMZ81ouov40=;
 b=U4XVMmgGTrIBLztChMjpky/epJ0Dp3qb0WR74atmHOlSIbZKSR5GXY5mvtYhPmUxePeUaMFiUJbEyieHLYaZ/+PVGihrFtKYAl+mdq6WUZfpuruTrGHrBRabH+VqzU4GKsmgxZUYPdFc95MPnvoJYbYH7sLMICTtg4DQ4x6nCbP+vuoRaEQbEIkrbVzrkm6jtMN0t8nYaH6FHqgKtZiBOsjO3XPN3suyK6QrT9efNQ1hKdYaLwf5/C8yJo2MlTe8lYysohEo56w4xEZkiXLtgbBFng7KuBPfecsqdscWHIQfe9Fkoka+w2cjA7gv2oanXUMshhoHE+B5KOtI0pWo3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2414.namprd15.prod.outlook.com (2603:10b6:805:24::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Thu, 9 Dec
 2021 22:09:17 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::b4ef:3f1:c561:fc26]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::b4ef:3f1:c561:fc26%4]) with mapi id 15.20.4755.025; Thu, 9 Dec 2021
 22:09:16 +0000
Message-ID: <0364fb10-359e-c9c1-f90f-a01be2944dd6@fb.com>
Date:   Thu, 9 Dec 2021 14:09:13 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: ANNOUNCE: pahole v1.23 (BTF tags and alignment inference)
Content-Language: en-US
To:     Jan Engelhardt <jengelh@inai.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     <dwarves@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <bpf@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Domenico Andreoli <domenico.andreoli@linux.com>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Douglas RAILLARD <douglas.raillard@arm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Matteo Croce <mcroce@microsoft.com>
References: <YSQSZQnnlIWAQ06v@kernel.org> <YbC5MC+h+PkDZten@kernel.org>
 <1587op7-6246-638r-5815-2ops848q5r4@vanv.qr> <YbD696GWcp+KeMyg@kernel.org>
 <57104347-7557-19rs-5845-31o122o45798@vanv.qr>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <57104347-7557-19rs-5845-31o122o45798@vanv.qr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0093.namprd03.prod.outlook.com
 (2603:10b6:303:b7::8) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21e1::125f] (2620:10d:c090:400::5:1dca) by MW4PR03CA0093.namprd03.prod.outlook.com (2603:10b6:303:b7::8) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Thu, 9 Dec 2021 22:09:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 588ed4cf-f8ec-4959-ca2c-08d9bb608aa8
X-MS-TrafficTypeDiagnostic: SN6PR15MB2414:EE_
X-Microsoft-Antispam-PRVS: <SN6PR15MB24142BFAB46EAB1EE43E945ED3709@SN6PR15MB2414.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n67twZlGj5h9KkEVKRgZ+lTStfDFIBV5lx3BLlcj4RHWQLiKy6zJ5Q89wHeMrpDq/2TY3BpjsmV1skZ36Bqgubsl/hQXG4jT9SguoBPNNEglckdXyDqBgLr3TloVkvpYXgynD4xhuFkJhAeEE32QsMM2/GlPGhwTngevhDhqaOkgr8oVce1Hs/u+0rDJcK0qjj/De3x6cusXtx2LAE1z/J9vYdNtJp5aieOkoRDAWJWibthLilezirEkHXx2DBKEFeb0pQmAvFNTshg2arnouQA+/emUzt66tT/MeR+KdFg0KGHfvXf5cOSmVSIk//rZh2wFKeKBgViQyIO3fXOcLnnGMKL4XuI3OCLBuV/SGjJrjjblQhDMbuABDsHk1R9O8J0Zpiv5aRfoQR9diZMxlwHrpug6OuYjvMWt1Cw6vlnQgKtTJyQo92J65Mhx7MAsgtXNs0HqlEfLn4XRYvByzbzk/D2xsquBj/uu+lE+qIh4/c9fJ/TV6Dw9zL+9THZDNNIDgoDDwGPtWCjLIVMq6qUA5Vw/jIquROmSbxcufgAbL2tb9/hNXJhSBdXb7e7hNvtrAtYhAb9lAdbw+QEO74G9cZ7C7XbaxJExj2df44rTXBqBvFfGbY/ZD7rCQZ4nDjTivjE2FG4YUX10kyWFyIvHnpQ1QMrt5QMk4XqUIbpZNL3T470EpgIHMiCjlPN2ths6f8jNf+m4xX8JZI85IzCpkn3gEItVfSXdpYQOnp0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(31696002)(66556008)(316002)(4326008)(52116002)(2906002)(186003)(66476007)(8936002)(110136005)(36756003)(53546011)(508600001)(31686004)(8676002)(54906003)(6486002)(5660300002)(38100700002)(86362001)(7416002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0VUSEs1dHdTUGhIWDh4WkZtek9zc0N2b052eTB6N1drYVltcmJyMlhuZGZZ?=
 =?utf-8?B?VThZYzBSVUVIdjQwalkrRStYanNvZCtvTUI5bEljYkRCYm9qTy9pU1pnOU1W?=
 =?utf-8?B?eXczTk9vQmhZSk9BRy9LR1QyT282RHplTDFIU0Q0dHVldE9lTTUybk5qVFRK?=
 =?utf-8?B?Y1NHU2ZSSW94cDUwWlhDVTNJODhJbWpxbnRvaHpDelo3SU9rbS9kempTbzlP?=
 =?utf-8?B?ZEswc3dNZHlhaUhVRDJDTmY4VmtwNHRZU2hhdnByVFliei9zRVU0VldIaUY5?=
 =?utf-8?B?SlV3cU1kazNZUnVzR1pGNDd5S21iN0lEQUN4NFVJanFTc25FVlhjY2VrVTNV?=
 =?utf-8?B?QUtXNGxOeUNrWjl4eGNYdXNJTEw2OGJ4YzRQc255MnZDOG16WklhQVZRNXUy?=
 =?utf-8?B?ZUtsWlJpa2dFUFpyV0JuVDBOeHJQRk00VWRJSnc4NC8yTi9aRmd6MGpqMlh3?=
 =?utf-8?B?ZVYxczhYamZWWkdWYUFzcXE1STU0YlhwSk1VSTlHTGtiMzZHc1pSeityYTYz?=
 =?utf-8?B?SnVWbU10dGRTSGNYUGR5R29zQkpjRHQyTXRDNTB6dDBmQ3FQU09UWkR0ZlM1?=
 =?utf-8?B?SzFZUjNSdTdyWTllWnl6MUxLTmFuRGMza3Z1Vy9nWGt2UU92U0RXaTU4dmNZ?=
 =?utf-8?B?cEN2R1I5ckdVSWF6UzY2TnM4L0xBbFhMTFZtRnpqY3FMVElsWHZiRURaRWVL?=
 =?utf-8?B?YlRBZjJoaExwUHZ3eGJiMDR3d2hXNkFlNVdIdmhLdDlEV0wzbWhqS0Z0ZHEx?=
 =?utf-8?B?V1RPekVVWktiSGZkY0FPUG5ZWUxoS3JGa2JPL3NIWFNueS9TQjV6UkdrZzcv?=
 =?utf-8?B?cTk4OUc3YWRHOUx6ckRCOXAzSWQ2OUlpcmRrT3d4NkxOUUJYemQwRnFZcWJo?=
 =?utf-8?B?emVKZjhsdUowSVVla21PMTd6dXNha3g4b3FUYVVkUEFQaThYR3QrQ2wvUmpT?=
 =?utf-8?B?ZzkyYmdsWS94OVRrR1ZPMmRRTENoZ21Ob3JGR0JJSU5qOFBra2xxeHNTOHRY?=
 =?utf-8?B?UmNLWVU5Ym9zQnR2MVdUb2V5aEZIUkoxWUJKalhwTlpXTzhUOEFpK3RFNC9C?=
 =?utf-8?B?RXZEU1QyclZhUDJtVE1ETUhhQlBQVUJkT1lMenhyYW92Uzg2Q0c2c1FnU1Ft?=
 =?utf-8?B?a3Rnd2hBcE1Kd29kemJKbUc5RFU5YTh6eEJ6b1ZkUjBXdk01NWEySEhLY0I4?=
 =?utf-8?B?djU4VlY1QThCVGd0QlZERmFwSzhEdmxBQTZab3FFbUhKZzBycFpZdUVJOUxM?=
 =?utf-8?B?V0NXbHpWdXFiN29QdTZWVEx1bXp0NTB4cVBJSjlnL1hrbkVjSGlPKzJCU0Jz?=
 =?utf-8?B?YzZmMDE1cXBoUnI4MFl0UmVZcVZNTVkxTDhTWkoxVXhNNzFRTTE4WHlncThJ?=
 =?utf-8?B?MXdBbFJDT1JVSnVFd3dsWVU1L0lYVXY0YXo1ZEpETnJBaW8zcUNMbFV4aHI2?=
 =?utf-8?B?VDlsVHJOaFVGU0k3OWRyemN3ekQ1azYzcXBCWWdqVnRqNnRmSGZRNGZOQXAx?=
 =?utf-8?B?cElxaVp6Z0xLMUFvVFRmOEYwNktqTHk0VFQzd0FoR1ViTU5NNmtiUUJENEc5?=
 =?utf-8?B?cVlXYmxkZU1xektpd3g4RS9HV0RXVHg1QURLdG40a1dsdkNsaUlUdTkwNEp3?=
 =?utf-8?B?NUduK3R0endYS3NUWnNFeTR5b25zZW4zUk90UG9aWHZQTzZZNGoxR0FtL1ph?=
 =?utf-8?B?cnBnQnBiOUNiOEo2ejdDQno2YXV3cENBa3dtWHU4cHZoUmhxSVBQYk52bWpE?=
 =?utf-8?B?VUhFSGJITGZENERRMlJaUXFZRFdEclk2dHZBMWVGM2huTTFFQ2dKWXU5Rzhy?=
 =?utf-8?B?a3RPU3l0anVYNXJFdXZRaFBFbENHL1F4NjJJak5JZ3lwVUpYYjFvR0dsVjRO?=
 =?utf-8?B?Mm1wTTdGV3E4d3NHaW53cmtGWk12L2dQWjcyMDlNaXdYYmZmeUkwa294R1BP?=
 =?utf-8?B?R3REYTdFNkRtajd5aDZ3T3YrTGd6cVAwMmJ4dFBBcnNkbkpFcXdnL0tBaG1F?=
 =?utf-8?B?U1JJOXZQZ0F6SWUyMUpPbHNOT0JuZlp3M2U1WjMxVDhkZU9tWFFtMWwyUDZX?=
 =?utf-8?B?ZlpBSzE0SEpTTlF6dnRlbWg1MVU4ZERsa1VxVTBsdy9DMjdJN1FPckZjeXB6?=
 =?utf-8?Q?Nh6UlkfA2sJrk2Vi7YVfKbaYS?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 588ed4cf-f8ec-4959-ca2c-08d9bb608aa8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 22:09:16.8770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HXxgnBvXxHbp9atzwR0pfhg+zVMUf5adwPNBRQUuI0I01wvAoUDolqdBuq8mjkhJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2414
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 98YcxyYpvAzYAOUcZEJytgsUcDLL1mVg
X-Proofpoint-GUID: 98YcxyYpvAzYAOUcZEJytgsUcDLL1mVg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-09_09,2021-12-08_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 phishscore=0 clxscore=1011 adultscore=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112090114
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/8/21 11:11 AM, Jan Engelhardt wrote:
> 
> On Wednesday 2021-12-08 19:35, Arnaldo Carvalho de Melo wrote:
> 
>> Em Wed, Dec 08, 2021 at 03:26:31PM +0100, Jan Engelhardt escreveu:
>>>
>>> On Wednesday 2021-12-08 14:54, Arnaldo Carvalho de Melo wrote:
>>>>
>>>> 	The v1.23 release of pahole and its friends is out, this time
>>>> the main new features are the ability to encode BTF tags, to carry
>>>
>>> [    7s] /home/abuild/rpmbuild/BUILD/dwarves-1.23/btf_encoder.c:145:10: error: 'BTF_KIND_DECL_TAG' undeclared here (not in a function); did you mean 'BTF_KIND_FLOAT'?
>>>
>>> libbpf-0.5.0 is present, since CMakeLists.txt checked for >= 0.4.0.
>>
>> My fault, knowing the flux that libbpf is in getting to 1.0 I should
>> have retested with the perf tools container based tests.
>>
>> Can you think about some fix for that? Lemme see if BTF_KIND_DECL_TAG is
>> a define or an enum...
> 
> Just bumping this line
> 
>                  pkg_check_modules(LIBBPF REQUIRED libbpf>=0.4.0)
> 
> to the right version would absolutely be sufficient for us. Of course, that
> requires that the libbpf project itself at least manages to make tags
> regularly.

Change above version 0.4.0 to 0.6.0 should work as libbpf 0.6.0 contains
all the changes related to BTF_KIND_{TYPE,DECL}_TAGs.

