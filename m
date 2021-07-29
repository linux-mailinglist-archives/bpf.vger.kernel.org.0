Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B0B3D9D95
	for <lists+bpf@lfdr.de>; Thu, 29 Jul 2021 08:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbhG2GWU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Jul 2021 02:22:20 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:22422 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233934AbhG2GWT (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 29 Jul 2021 02:22:19 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16T6LBBt008230;
        Wed, 28 Jul 2021 23:22:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=sWCjw7axCt+SmDbmlxAEvxZDggKTb84K7EVg3lictD4=;
 b=iOux/1NXRKKX5EpAzoc3wBvpekb7c8OxL7YsNBZtWwIqoKuFCbe66wJVgBUIFiIMMjca
 hUNWb/Q3U2ZBZfcuwimTfffQRiCRPxDUGyeWgYrQE58XKVHtXkQf7UOryMcmDVxyinKw
 J/Q0TBzUdbZJ+INv96qOuy3nws9zRw3hisY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3a38tpn032-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 28 Jul 2021 23:22:13 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 28 Jul 2021 23:22:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nFrHz5SpTlGKAtt96rUarC/Hw3rQ7pT8egPpKu9RDO0FqsbG0SRQ6d1cXrGgh92L9OEghouXxIoAwBLT4kLld0w9Da/lYacDFuhhJtmva9ebYk7KVwIgYyBFTNnMGhrYiralUT2vyCgZqojqd2PTm6IYh0NABYwV3vCaxwPxgIDDMBN2vjapgd0XehV6tXRqrXz4Qm55LAEq7UVWZyLfyP6UENLzOzuICLJG5aPT0ZtCvoETbmtuqOoBYfuuH7ISzOl1EFKmZpljkFy1s/4M5Ed9oSDPLrkwGqZP8YnklSPgFMfQS3rkkxBxBRB8UbxuoeMtcIsdD599A5UxO80LsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWCjw7axCt+SmDbmlxAEvxZDggKTb84K7EVg3lictD4=;
 b=kDcBfD8gF4LjCSYCRE862Vk4aKVTrejLxFC9I6Ivf+TJkyEizeI2SAw5XqSLSDOEipxa/N4gvEBGroUOJFm0IaNoVCqQhraxR+wau+P0tC33aPo53llzVZn44eLADumyraetkNS+448g0r1OP9kTOzGSEjXJNbF1eWtrt12Mi3yA2lE4FSdiYG+0OwviJSJoAQG1FCr/xoOzRpweRWPABBNN5SlQJR4LUK0XbKUnDi/E9RWr+nrwrqBtaz/O62xq1/hpT9jHzyeiKgDHxAi180a3CBe3joSLyGak8rO4pDWKdwZj71JVKlXxkj8UDEu47KWpNG4rJMPttQaRRlrf2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4871.namprd15.prod.outlook.com (2603:10b6:806:1d2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.20; Thu, 29 Jul
 2021 06:22:09 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb%7]) with mapi id 15.20.4373.021; Thu, 29 Jul 2021
 06:22:09 +0000
Subject: Re: [PATCH bpf] bpf: Do not close un-owned FD 0 on errors
To:     Daniel Xu <dxu@dxuuu.xyz>, <andrii@kernel.org>
CC:     <bpf@vger.kernel.org>, <kernel-team@fb.com>
References: <5969bb991adedb03c6ae93e051fd2a00d293cf25.1627513670.git.dxu@dxuuu.xyz>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <effb263c-971f-c149-11f0-b17739f6f197@fb.com>
Date:   Wed, 28 Jul 2021 23:22:06 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
In-Reply-To: <5969bb991adedb03c6ae93e051fd2a00d293cf25.1627513670.git.dxu@dxuuu.xyz>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR06CA0057.namprd06.prod.outlook.com
 (2603:10b6:104:3::15) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::1181] (2620:10d:c090:400::5:d11a) by CO2PR06CA0057.namprd06.prod.outlook.com (2603:10b6:104:3::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.20 via Frontend Transport; Thu, 29 Jul 2021 06:22:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f8cf105-8f58-41e0-76db-08d9525931ef
X-MS-TrafficTypeDiagnostic: SA1PR15MB4871:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB4871A912161A4021A799F492D3EB9@SA1PR15MB4871.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8mpoojhJR5UPxwlHjOwCCa7GU30/7Q3FFg6tV3oKJkiZhb9eJ9RI52Hq7eCnWMb6oLCLhWBGU7m+5/UltxrUjMy5308h6034NQJOv7eGhaV8bCWjf9zEpVPTBFHx+9vonfAe/OLA4W+EZc7pm0lX2dO8nCdownsJqD94eN77SAP3xdQKLRYlNVl/oWXTfCmvFfqdtU/5w7d/lqIGtl7eby4O8AzU5Fe0BiQOakW2eIVkrbl5uT52fmP6AaDcAdmyu5gpUfodMIApe4B3zsFvZdeVvX45Mvq0xN+FxqQe2rI0qAWjd8SEL+NksQ4iJPX4HLB5ekvj4XRD0sTIKYP8xtchX/Gi4Q65jXxVYsnGc+KCDkVsCKzCIGy+z/Y5TAwPWBIz5A5k1Pdd+4XmFWdZ0+d9ig9FSzhlHxOa3BID0AvEgxLtwXT8DdGlknwRUC7EutfznKwUWDZ6olQup9EZPOsk32FZX7G7WN+E7+ePbeuZsbUnGP7C0XENGbBBv7xhg4L6job7RlsHMY9KTsHDI2AvCOE0Xl0Oc9mnYT1q5Lmak46e1iixq2N1U6N6kN+xR3Ejqvj5MZrh7EI+s5FJn375c/fmUh/8bCX1vXqZwSjJfZdlf7qivw8V/ybFgIvvyAnaLWo5Nm/WljJ6YlyIAjUHYVoEtun3Px9wXBG3OvvKs9ILV5z+wugPP7hf8IhS4cWstJC/YxlreLA38o+QdDgDzZtF+fdB8LHStg+GeeM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(6486002)(8936002)(66946007)(66476007)(38100700002)(66556008)(4326008)(86362001)(478600001)(2906002)(2616005)(31686004)(53546011)(83380400001)(52116002)(31696002)(186003)(36756003)(8676002)(316002)(4744005)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmNvM3pjYmVaSVRsYURlUEdTQTgyMjE1UWpYcUdNQ2pXWFI1b3dhM3FWVm81?=
 =?utf-8?B?WE04bEdkTldIZ2Z1SjVxL20wQjBNT0pqTUk1S1I1aFVOZTQvNjNlaGV2ZnZs?=
 =?utf-8?B?bWI0clF4SWt3c0l1TUJkc05VUUJRVDVUb3dOWkQ4bmVVTWNtV0QxY2NoN3N1?=
 =?utf-8?B?RUtmVEJOQkc5SllQV2RSeEhhc0MwY0E1V1l6THFsY3FtVWJMaDVOMGxiNGM0?=
 =?utf-8?B?akhZSDlyMjBERmFMSktOTEdSa005RnlldXY5cTVickZINHFXTEFWUGhZb1cz?=
 =?utf-8?B?Vmtldm5JcWEzeVZydnd0NXVvMFZRSjltNGtsWnVRK1FWNVJSa28zWE5UdkQ1?=
 =?utf-8?B?NUZBbktUMTBTUHM2NFdjaGRpQmVBZ0tyQVBId2tueERvb1hONnZTcnNsdXdo?=
 =?utf-8?B?K0kvRktkcnJER204RUlOc2h0cVY1WWlPcU0yY2t0cjQxdHB1R2x4azc5Vmg1?=
 =?utf-8?B?bWc3K1c0N0huZk9STjgwWEhVMUl3NXpKc0tMd1ZzVDFxazRHQUxxSU0wUFJm?=
 =?utf-8?B?U2t5SFpJQXBCam8rQVRORm5pZm9LZno5TVNvTFd3VTQxeFBXR0QvLzdyMzBQ?=
 =?utf-8?B?VTFZQUR0NjBGNDg0c3l3WTBYZTl4YS83ZW0xREJSa3JnTGRMNDVncG9kbEp4?=
 =?utf-8?B?VTNjMXdlVTFtV08zejlkQkVvMzRDWjdRbDdVdUtxMjJYVGlUM1pJNXVnUDhP?=
 =?utf-8?B?UGxKb09iN0NDZVZFSVRPVEwvRTJUNkF4NGdlVG1WbldVZkV2VjhRK2V3WDh4?=
 =?utf-8?B?clVvOW9FTG9YRVlwTzNLcXdNNTlOOVBLTHZUaWpaNHNUNWxlOERZNEZVRUky?=
 =?utf-8?B?OG5WWVo0NTEvZnBQSlpheDdEbXVOOFZKN0dqQ3Zmb3ErRVVFVGltRFNzU1ZU?=
 =?utf-8?B?WDN4MzRWVEhLSW9GdlM1OGpIZkdOTSt1TDFrRThUQk55ZThDaXd4OUp4c1lI?=
 =?utf-8?B?Q1FRMXVqQVZ2OW5Oa3VrclBJVkJCeDhLZXRjdlVna1JmcVhFeHI1bW04dWM4?=
 =?utf-8?B?MlA5NFZObEtoRnFlR01DOUQ0clJTVU5pbEVVOWkrS1VIbEFpMGpnMkZrRms0?=
 =?utf-8?B?bVVVVis3dkRxTVBRdk83RlpWSllCQjlyOXNVTEdYcTFLS0JmL2h0MzRCYkY1?=
 =?utf-8?B?bmpDZ2VNbG41SVBZNlk0TFMzb1VleUFHNG12dG8zWGVsSjFZaEZhdnhWVUNv?=
 =?utf-8?B?KzFkYWl4VUdMQmZqK3g2d0JodUVyWGU4OEpUVkM2T2RmeVNMQ1lyYWQ1Q0Vh?=
 =?utf-8?B?YkVEeGhpYU5MWUppbDdFdFVSNzVHN0Y4K08zQVh5ZXJSNjRqUE1tblFUTGVZ?=
 =?utf-8?B?dU5xeE1XdmFnOE8zWmxnMENwMEg4Zkx1clIzVnB6NFcvNUxzallFSzBLMkZP?=
 =?utf-8?B?Z3BDYk1wWTFLTDZ3VWtMT3IweWx4VTVUNjhRL0lUZHIrWTJ4SmRGRHdycUV0?=
 =?utf-8?B?WUtTaHVjL2hSTDF1eDNXYUZNdDMvVXV6Y3UyMGVlckR2SHRKelNjSmk2VDNR?=
 =?utf-8?B?bnhCOHBOQ2tjN01kZkExYTlKS2FtN3VSVVh0YTlUN29KeThPNFJpT05ML21r?=
 =?utf-8?B?ZWtVd2NSMC9kNmVoMTNucjdSTnY4emI5ODI4MUZHNTRRWVlmYjluVUJwMVdW?=
 =?utf-8?B?QmVGT0hRZDZRclpkeEhjZmlrcHhyL05TYytCRkxpbDhOZEJKV3p6T2dkdDFT?=
 =?utf-8?B?QlcrRklpWm9NcHRHMHRENHhnM2RvTkh4SmxuOE1iVnJ4ZlRlbDdHc2JESFE1?=
 =?utf-8?B?djIwTk84NUR4bTZBdXNXT2FoS2FSb0hjQmo4cWR4dnN5V1IrU1ZjMUZHUmRn?=
 =?utf-8?Q?KBaayL8WZy6lwPTOWoDZL3F5CON2pyaBoTfxM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f8cf105-8f58-41e0-76db-08d9525931ef
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 06:22:09.4199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hKSZhdF0fZg68Jgir1HbZBHvpG9hp0d+O1CjzoldkYA8UbREIc2n4t8+jLFZxTBL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4871
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: J9PjJ2_5i-b3EpsJma24mj7n4BuEqdzq
X-Proofpoint-ORIG-GUID: J9PjJ2_5i-b3EpsJma24mj7n4BuEqdzq
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-29_06:2021-07-27,2021-07-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 clxscore=1011 malwarescore=0
 bulkscore=0 mlxlogscore=999 impostorscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107290043
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/28/21 4:09 PM, Daniel Xu wrote:
> Before this patch, btf_new() was liable to close an arbitrary FD 0 if
> BTF parsing failed. This was because:
> 
> * btf->fd was initialized to 0 through the calloc()
> * btf__free() (in the `done` label) closed any FDs >= 0
> * btf->fd is left at 0 if parsing fails
> 
> This issue was discovered on a system using libbpf v0.3 (without
> BTF_KIND_FLOAT support) but with a kernel that had BTF_KIND_FLOAT types
> in BTF. Thus, parsing fails.
> 
> While this patch technically doesn't fix any issues b/c upstream libbpf
> has BTF_KIND_FLOAT support, it'll help prevent issues in the future if
> more BTF types are added. It also allow the fix to be backported to
> older libbpf's.
> 
> Fixes: 3289959b97ca ("libbpf: Support BTF loading and raw data output in both endianness")
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>

Acked-by: Yonghong Song <yhs@fb.com>
