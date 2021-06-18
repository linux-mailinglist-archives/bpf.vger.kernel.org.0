Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA0A3AC055
	for <lists+bpf@lfdr.de>; Fri, 18 Jun 2021 02:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbhFRA7m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Jun 2021 20:59:42 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:5844 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233005AbhFRA7j (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 17 Jun 2021 20:59:39 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15I0p0Ha009950;
        Thu, 17 Jun 2021 17:57:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=aVTvv8oJU6Mpxo62wTXvYlt+zqS5uW6TEGv8JQAO2ps=;
 b=Zvnk7aj0+4tQZ2OohKRedrzYZG2SkNr1xevZ4/ub3hmZx1oMu184wS2gZrdL18Rs3kgX
 fsE5Rn/wpdG+L99bnnvmm4subYIy35yr91qUZlpZPBf2yzPGil/gzPluKNRT1KAq61hY
 t/Yx0UPZrNLqjZdGAd4Zn9+mehO4ydPgpO8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3982mfdhr9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 17 Jun 2021 17:57:16 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 17:57:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGE51qKbnPJJbwPMAwufKlKl7I87ivjCQxfeE/1KcmKl8XHRByMcaN/5cbF6vrE7BfddcvgN/MmUQ3R5G/Bv/gczPcfC13e3ePoRGpkRz0hcPqml4W1HpCG6AhD3uSlfz3HE7U50gSx1XNZpX+pqyzJr5xs1U1q4xZbgu5GWSMw5CRLr+nAqcbdJbJlQvpzr7WlRZUUYJleNWvTSwCNwpLSE8WeNMxMGbBl053PDHclvC6bj3GIds9qIhZSnjYp8gptE9BfDhia61YM2NJtQ5fLpBBfwYLErj8CpqS+7vGnz7X0IuAD58UkCcGrjWv/tS8tkwqxwSmWW7NWXoHGlEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVTvv8oJU6Mpxo62wTXvYlt+zqS5uW6TEGv8JQAO2ps=;
 b=UpfI6ql5MeQaXiq6cZwq59uFtCUiNGBgUtROYgMHXqpTABWUXG54DwrzFhFzSmjuSO1ZJGNtNij/L24REKlju5KpJi0b9MDzAbEiueafJmW3wVCmCsMjwHy6b/9RsUvvg6K4sbt9F4H7fYFVa3raxfyNXCWfEQXF+G8baEjgivFon4H+DsfCN1kVYlkr24u1rBUiWHc42irKOokjsG1Jcxhqw6tFGkPUcIsNb6s1t7bluevz3iC1vE03RxJfCQqklmnnOvXFfpn6c2NrRY0/Vi+8C5NegBTh+pjzO8k9JdFYo8225kUsTnr/zqZxqWtQMtYWWwu5SHJvVz7Ln5ie9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: riotgames.com; dkim=none (message not signed)
 header.d=none;riotgames.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4737.namprd15.prod.outlook.com (2603:10b6:806:19c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Fri, 18 Jun
 2021 00:57:15 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906%5]) with mapi id 15.20.4242.021; Fri, 18 Jun 2021
 00:57:15 +0000
Subject: Re: [PATCH bpf-next v6 2/4] bpf: support input xdp_md context in
 BPF_PROG_TEST_RUN
To:     Zvi Effron <zeffron@riotgames.com>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Cody Haas <chaas@riotgames.com>,
        Lisa Watanabe <lwatanabe@riotgames.com>
References: <20210617232904.1899-1-zeffron@riotgames.com>
 <20210617232904.1899-3-zeffron@riotgames.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <0951275e-8104-9aee-5b96-c00e4b38ab5a@fb.com>
Date:   Thu, 17 Jun 2021 17:57:12 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <20210617232904.1899-3-zeffron@riotgames.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:c984]
X-ClientProxiedBy: SJ0PR13CA0081.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::26) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::1349] (2620:10d:c090:400::5:c984) by SJ0PR13CA0081.namprd13.prod.outlook.com (2603:10b6:a03:2c4::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.7 via Frontend Transport; Fri, 18 Jun 2021 00:57:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51f3976b-71b0-48fd-a122-08d931f4036d
X-MS-TrafficTypeDiagnostic: SA1PR15MB4737:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB47376625E6DD1A1545115D33D30D9@SA1PR15MB4737.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eTgJMdbgT61Dd+FhCPXKtS2eoS86oKaDEJs/jCis0MfESX91Bo+mNIFMl4xnEyPoNSgUi+Vjm/wckbcvkoTirDUmTZcvfmtqeZELfMNvDGmKix6qq0VxdTYv26JMZJFqds7GJL8JAE+eW9wFY7RvddLxtnf+Af4iLxi1MVsk3/vitdQcUZymQcls9HnI2nyzDt32AyQJMGVIzD9JZsayv7aiH+x9cSjc3MFdCZVD6ULo1EI9oWNS0ll9UcYlI6coum4Qy1btgAB+ncGsmWotHGKO3gR9Xw6UBeOZ6Sz/1ZFAofIKsc0zzzwkX35kyz8stnuaIyfrsDHuXybrtrds8cMRhxbJNQWdsAy2/ZR1/bMrY08L1iQM8ZidHkPDaqwJFBj5IVZhulaJofGujVA13oISUKCoSkeRHgOjrqZGt8v4v9wiFwHnErHAJDic6u5oaqN7s80woV+D2z8LgqpOnoV+ttBlZC58CkvOIQ3JasM1kT3CSgqHNLdj5cr6Z3XMYCiLxRMHeLoAVcrDePVeECXYn2SIoLzaqZ5V0wYTurw3e9+zdSd+jWnzKSDC2nHZNrvDoFHwnnCuF2f/LGHxP4nRVU7IKp0OZpJA/ThvUwU0e7daAN9xMQSIetCrlHYTedgou6Uqx1u6YI2YbGF1nmAsMJfPbHurwYQfCeJEeuvupnErC2340zPsYQ1Vqu+p
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(2616005)(36756003)(66476007)(66946007)(38100700002)(478600001)(7416002)(8676002)(66556008)(53546011)(6486002)(31686004)(86362001)(2906002)(186003)(5660300002)(52116002)(4326008)(316002)(31696002)(54906003)(16526019)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFRvempxSldLNzVjS3JmU2JKNVRMMHVuTnUramx3Z1BnSFNaTXV6djRjTktX?=
 =?utf-8?B?VXhTVjhGNXRTZjNrOWxtL1NzdkhxdWlTSllaQzE0L0liWVNoV2R5SkR5N2lv?=
 =?utf-8?B?Sm9XMTcvcTFrWTViQTVoR3RoSm81UzEwemJ2R1ZhYno5bzFXeVVIaFRuV3JY?=
 =?utf-8?B?WXlja2p2SWMvaWxvSFhHNmZZMjRFb0VxeC83ODhBYTFkR1F6Vi9PY0c3WG9T?=
 =?utf-8?B?ZVg5SmtaLzIwR1h1djkveERONXZnWWtaTUVKcVJDVitxQy9qSEFNaVhvclo3?=
 =?utf-8?B?dVJ2UWdMVklubE04LzRaV3h3TklVbW5IRFhmUkl1cDNDT3dubi94R2tmNjRM?=
 =?utf-8?B?Ti8vSnA4aFNMUHdhMloyY3RwYU9JdzBjUHUvM1ZiQ0FnbjNJeUNVMUhZU1c2?=
 =?utf-8?B?cWZtK2t2cEtNek1udUZKQXpsNVY3NkpiRlJyMWR2eERjTFN3Z2cwUXJxdE1T?=
 =?utf-8?B?MUU1K054cDRWVW1aVDViTXZpQm02eTRsR29ic0thR3RXWlJ0VnBzcDZSM200?=
 =?utf-8?B?QUJueHRtakh5aDd6YllMUTJuU0xrdjZzUzc3UW83aTBVVEFOSy9tTVA5dUNW?=
 =?utf-8?B?TGgvSEI4YUNPWUZyT0VYVVFQdWFUMEM5TTJiYk5Kdm9LTGJtMCtmMzlOc3hZ?=
 =?utf-8?B?YlFLNktweGJkV0x2eTB2L2VFTmJYRC9LdmZHcVhWTmpBYmhKNmZsVDhwKy9F?=
 =?utf-8?B?YkVaWTRYWU13ajErS0hWKzRVVGhpc2EydEJtU0NjWkFJRmM5dE95YTRNRVRi?=
 =?utf-8?B?UFNaN2V2MkZoYjRERFQxaVJMV3cvUml6WkpLbFozTElDaFowQTNOamk4V0s5?=
 =?utf-8?B?dnZpcWJqdnJjVmp1dFhuR1ovQVlOMnZBYTlEWmZFVi8rdDNCaEw4amJRYytE?=
 =?utf-8?B?UWFVVnBxMmdnd1V4ZHo2Tm1SYTBFRU5leVhGQ0Nhd2Q3cEFyK2ZEUFNpZW5x?=
 =?utf-8?B?K1dPdXUwTzRaN294Sk5wdEViclB0WGk4MmJoR2dRa0g0dnpnUHQ0cTBUaXJD?=
 =?utf-8?B?Z05PSWU0aVlGbkdCWDdOaVA3d3NaTW9yM01mZWs0dEpDM0tHbDcxMFh4U1JF?=
 =?utf-8?B?bll0TWsvenp0MXA0a3Jxb1RadEtBblRUdDZUTDJTckk3aXhoeUxyd2l2MS92?=
 =?utf-8?B?eDNqTWwrbUdwYjRlbmZIazJEeVg0b3VINERkZWRuNzFYako3RmtzSEVMczVl?=
 =?utf-8?B?UytrMUZNZi90VkhGZVNxdmdoV1k2bFE0Mnd2QTRwSGNvOUgrWXgzdUxDUVN5?=
 =?utf-8?B?UVU5cnVwRm95NU82UUkxZDAvaHJ5a0pnd3IzZ2JkL0I0VmhzKzBoc0VLY0VJ?=
 =?utf-8?B?RERoREZKQU4zUFRJQjZCMURKZVNuNE5xQTdnRXZTd0d5QmIxSWViSUVZV0Rr?=
 =?utf-8?B?WUlLTGtUYVJqTWNYSUZjUWV6RnlNZHVobjh4WEFaZGIvK3BMYjg1VHNrTENz?=
 =?utf-8?B?VHY1WHg5MkVOZmg0K0RtNWthN1FpWWFUK0EydWdBMGloWnB1RGVvcFNsdTdv?=
 =?utf-8?B?M1RMVUxCelZZdEt1bnFNVEpOOEtWMVNQV1lBcUZjcGdKS0tiS0VyWDBmTHJQ?=
 =?utf-8?B?TDVIOFJrMVoyaitKcUFJZVlaVUVvVCtFWG5rdlFheFp4aGFMSm1leG45ckM0?=
 =?utf-8?B?NjFMWVB6QTVuWXgxSHVyRUVIcXFTdHgyZEhXcFpkUmJYTDQrbEFRSUFOMHps?=
 =?utf-8?B?L3oybnpJcUYzZGJLazI1TXpHVmEzTWF6ZXFqNjdrYnR3OTZicTlVa0RlWFVi?=
 =?utf-8?B?bVBCRk1MZXVORHF5YUxnQnlBT1BYZUl0dk02RU14TnJTeXF1bmY2YXcramN4?=
 =?utf-8?Q?5xn8Upc5jNwyzqpI7aItNE0AZLr8yEsSmT98E=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 51f3976b-71b0-48fd-a122-08d931f4036d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 00:57:14.9892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f7df0cHrBUnSTUFjfCqhaITupBG6Rq4IJpt1rDMeXc1ijP8/ypUxjnDAfAWRpofK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4737
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 5nLtASGBy4TIH5Z0oJVH-msdYijgXD_W
X-Proofpoint-GUID: 5nLtASGBy4TIH5Z0oJVH-msdYijgXD_W
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-17_16:2021-06-15,2021-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 malwarescore=0 bulkscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106180003
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 6/17/21 4:29 PM, Zvi Effron wrote:
> Support passing a xdp_md via ctx_in/ctx_out in bpf_attr for
> BPF_PROG_TEST_RUN.
> 
> The intended use case is to pass some XDP meta data to the test runs of
> XDP programs that are used as tail calls.
> 
> For programs that use bpf_prog_test_run_xdp, support xdp_md input and
> output. Unlike with an actual xdp_md during a non-test run, data_meta must
> be 0 because it must point to the start of the provided user data. From
> the initial xdp_md, use data and data_end to adjust the pointers in the
> generated xdp_buff. All other non-zero fields are prohibited (with
> EINVAL). If the user has set ctx_out/ctx_size_out, copy the (potentially
> different) xdp_md back to the userspace.
> 
> We require all fields of input xdp_md except the ones we explicitly
> support to be set to zero. The expectation is that in the future we might
> add support for more fields and we want to fail explicitly if the user
> runs the program on the kernel where we don't yet support them.
> 
> Co-developed-by: Cody Haas <chaas@riotgames.com>
> Signed-off-by: Cody Haas <chaas@riotgames.com>
> Co-developed-by: Lisa Watanabe <lwatanabe@riotgames.com>
> Signed-off-by: Lisa Watanabe <lwatanabe@riotgames.com>
> Signed-off-by: Zvi Effron <zeffron@riotgames.com>

Acked-by: Yonghong Song <yhs@fb.com>
