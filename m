Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235E64CB4AC
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 03:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbiCCCE3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 21:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbiCCCE3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 21:04:29 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F6C1002;
        Wed,  2 Mar 2022 18:03:40 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 222JMu7Q016129;
        Wed, 2 Mar 2022 18:03:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=bbNQstT/gb92UbFiGBN1XmF0aOWpW/oPXVWkc8sTC9Q=;
 b=HXJwK/t+JTIRwPk52RvmKQ6JG2GcnhKd5fo6iRnqxWnb9gOnU9fq48Ze119nWNNoola7
 i8AEuYhsPsC+HcSeWCWTmLhPALuy7E65XSkxGYsmXD3c0uAY5WZndN7QoAmrI1ZL/A0D
 7MpsoimgTazhz2EV+m7xtM0D2YkcnMvEl3I= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by m0001303.ppops.net (PPS) with ESMTPS id 3ej6mrynvy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 18:03:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZztVD2lAiHl5I38dWigBAvLKvBlWvEYp+IX4zI4fIL1lMI/lBJOFWQGgKDloTnNDD+IE3lU8VuvQVVa4rim1ylluhKfrsTWBDKcgC5F3V3UjZgeMP1ISdKMHmI6AcVFAVy6Mw+VH0q+mIYcTAuGDMS8/4DB32mIXc/vnQXkfvm57YipyoVllSdSbo4J1E7cGUXvseFqvcsMeIz1xN6Z3JuLudE2wSJiuCuD+zbQeupunzh01X+8EiSfnRsCl30Q4sJzK2ZByO43kuWjydhh+rggS82Fpd8f5dmnlMmzmSh9YlbuMFRyFd3YLrfgIEySDlZjJwNo89Sh4DaijBTj/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bbNQstT/gb92UbFiGBN1XmF0aOWpW/oPXVWkc8sTC9Q=;
 b=SVDlEIujepIU95p6Y1wPUCaTIflZX8K4i15IXyBbQSICQY+qFzAJ/PyCN5aFr5/mtjDZOicetASTd5h8QfX3YSg7+TpacAZt7URIkKtgxE+9L7tiH61rr7wpz4WCPpOpFdK6d8xgbq6ZUnHAfSFBl5VOf6NRbuyCdkZtIx+mT3JKaR7pMDUn5YLfUko6vFAY27cJehMjGzdpLOd8NUAG2i8JmfxAYy5brRS3GUO0KLpLirdScpqGPCj4SHoeN11nBSvcmZFrusSFanDUc5jl6NKKRwFW+aMW/3ivFT2l0i8HJm5EE/M9uuWOCe4jgfngVUXBmd9so/GSGrBbVCYKZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BN6PR15MB1330.namprd15.prod.outlook.com (2603:10b6:404:ea::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 02:03:20 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1%3]) with mapi id 15.20.5017.027; Thu, 3 Mar 2022
 02:03:20 +0000
Message-ID: <f780fc3a-dbc2-986c-d5a0-6b0ef1c4311f@fb.com>
Date:   Wed, 2 Mar 2022 18:03:16 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH bpf-next v1 8/9] bpf: Introduce cgroup iter
Content-Language: en-US
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Hao Luo <haoluo@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Tejun Heo <tj@kernel.org>, joshdon@google.com, sdf@google.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220225234339.2386398-1-haoluo@google.com>
 <20220225234339.2386398-9-haoluo@google.com>
 <20220302224506.jc7jwkdaatukicik@apollo.legion>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220302224506.jc7jwkdaatukicik@apollo.legion>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR04CA0150.namprd04.prod.outlook.com (2603:10b6:104::28)
 To SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db776696-369b-4367-58f2-08d9fcb9fd51
X-MS-TrafficTypeDiagnostic: BN6PR15MB1330:EE_
X-Microsoft-Antispam-PRVS: <BN6PR15MB13306295B4593ED35101B3B8D3049@BN6PR15MB1330.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qXob8QJvi8Y92XKdPfVyqJJRx++kvavv7R1tBo2iHpI47ssSKOZ//P9Tt0sekUUXHGlOW+Y6kah4Zo0gcUOiUi25z/Cov/V/BP91i0qlUlf7wQ/YE53ZkKEmZ20+xn8iEp3KQql/pIyixcgVA4CEN2QSx8Lhw5FDmYWNtxjwZnUGkSzFizz99Utjelndx4YGzpjNonLkCs3fSEyTD9YkYHq22lcqExbDrGk+NiB4mXroEy7OFz+aqSE1PNU3usr1s6qN4OEPHmyi9D7G/x+Q4RB9pIWCKxrARGB2bzfIyRDs/nDOuhlfvgBaOe8xfVAiW+yXlFuRPW5jMuFLIKmviRA4MDcoFVotYfNTPP2JgbNwRgNcFouAg+CIXJovGnnpQR7NvYi+KB2krRtWrfRUyHEku/nE/PCS3b/uZCEbCIuuFK4j+qLC0ySC9YJ8sVSYE6AY8BI+gyoMZTaRRMw9xyyeTtf0yY7HZUfS9GB8YO0JVLILQ0XnW1nDXywYbrEW+Uwttt7q4Fcl9tE/OkdPIP77IGv0TXbGDcP1u2F4gvO/OoGdceE1y0zmvXDyRAbgbeTuZwK9MYXlt8OOibLmF7NYHqPb7HodgGevZVLARrxkl/VKeIER0RB/JPuyggr67kRrhXs8wqXhcf3bTRLRMediIneePxJ4cyRUsFuPgCZD8xwiWzEd78n7YVHMvDhYxYniNvmijFwgEhIirsbtlAtsh/l/yInnHjJDWQMU+PY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(6666004)(6486002)(52116002)(36756003)(53546011)(110136005)(54906003)(508600001)(6506007)(8676002)(31686004)(316002)(83380400001)(66556008)(66946007)(66476007)(4326008)(2906002)(5660300002)(31696002)(8936002)(86362001)(186003)(2616005)(38100700002)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjRpcHlPMWcwOXZZNmhGZm5sdzd6d1QxSjhDMWdldFh3ZnhTMVNyNHNGMDcw?=
 =?utf-8?B?WVNQQWRYV294RTJkTlRvNEFmUTZzcGMwWFhVV2x3T1hmS3dETHZkY0Vrbndi?=
 =?utf-8?B?bGllSDIxdlJOVnFNVHp3bVBIOVoxemhQQldoVG1TSFdQWUNFcXoycmpZU2FT?=
 =?utf-8?B?dEdpSUJlSkQyUmpYTlJ0MFRlWnR3WkF6YkI2WVJ0KysrN3dab0kxbzIzWURx?=
 =?utf-8?B?b1FCRzJUbUR0dTNkdHNMWGQrWmNmM1NuS0pGS09RQXhEdXFidGJ0eVdURk9W?=
 =?utf-8?B?TUd5cmVrWjBKOFRiRVJhZlVsWmZyb2JQcDN5UGk0T3JYR2YrN2lxbjhNT2xk?=
 =?utf-8?B?aUVhYjlMcXE3TDFyNzE1MEh4ZHVFS2ZRai9iN2N5MDRmRGNlNWRvcGZtUE5R?=
 =?utf-8?B?bnZqaVpjeVMxWWZrWkVaM3dUa0ZDYWNrUlJYNHY0R0FTSGRIOGJyNjV5UnZM?=
 =?utf-8?B?bStNaWp5cWVvQ2tEKzEzOVRIc1gvQ2pueWJyOURuaXlENDNpaDhKRXd3bHAy?=
 =?utf-8?B?aTVMTk55R2dpaU94YlVvbC8ydDF4T24yQmZXUzVMd2E1T3FxdDV3VjBpTnhq?=
 =?utf-8?B?U3pUR3h2dm1hdHdjYUtoYkl3TExPSmVFVDBPa2FXVVJIeEo5TkpzTmRrL0cw?=
 =?utf-8?B?STVidE5hT09vQU1WaE41QkFQQzR6Sm5kckQyb0ErQy9qMERMYUYrYitrdXRz?=
 =?utf-8?B?Q2w1QWhVN3ZRKzZlaDE5L29jcVZUSXh0M0Y0YkhONjlRVHNUc2FxY0FSR1BD?=
 =?utf-8?B?ejFNYSs1STlFT0c0cnQ2cEJrSm1FdzdSbGUwOVR3M2pyOGlrajNSNDFsSWg3?=
 =?utf-8?B?akdNb2hKOGQ4YkNnMFFqMk1pbWE2VDUvcWs0dUtJR1ByTytSRGxBeFlaS3Rk?=
 =?utf-8?B?cy82dmtnN3JWcjZyS1dNSno4N2Y4Vm93aEFPZFFyRldrU1hvUzRaMkkxTVUy?=
 =?utf-8?B?dkFKTWVpbkNjZy94SkxtYzJNZnJ0M1Yyd0Jrc1JXdWdGQU1ldHFMYVZLZUcz?=
 =?utf-8?B?RXRXVWs5UmtZMCtmNGM0T1RSYTVRQlVHL1ZlZW1MSmd0YStNUEc3Q1RRWGlq?=
 =?utf-8?B?dnA3aFJuS2JiNTlNN1dvcjFXMFE5d1JLU1RIYTgwZWhCb3lDWjlsV3hSN1hV?=
 =?utf-8?B?bUJjanRrbmlEWmJsSnhocG5BL0h1VStjUEVnMnlacnBvVWpVY1M4SS80V3da?=
 =?utf-8?B?RzJjYkwzNXIxODFMeHV2cDhpSHhUSHQxbWJ1cDFJZVJaeTNCMzc4TUwxRDNF?=
 =?utf-8?B?bnpOSFA4VFNHZXNCN0hhNHRJazVFRHZ2emRCcFhnSm9nTTZhZ05iUitLbkRP?=
 =?utf-8?B?SlZqUS9FWWtQeUw4N0llMzltb0gvRU5YcjJSYmMwRVRvMTJNeC9SeTRra3FU?=
 =?utf-8?B?ZXoycHhQZmtlZjJmMGRxSEx0VStBVTFUaW5BQ21rVzByelUwMXYybjA0am1x?=
 =?utf-8?B?Umx3L3RxUGMwbFFoeTZkRFI4Z1B1Q0M2a2I0cWNQdUQ0Z0tCOS93VW9sVGda?=
 =?utf-8?B?M3k3M1p3ZFNDU1RPM1M5U1pZMWJtOFpHZmlWUWFFMWhmd05iNVhwaDcyNk5L?=
 =?utf-8?B?bGEyZzk4T0FtM3pxSm9jVlJ2VVpxbG9uLzkwK3h2cmxPT1d1OEJ4d0VJRW5Q?=
 =?utf-8?B?K0dkUDUwVEVGRkxobG1kenNWY0xvWjZIVHpRZTlGYkQyQ1dUTzNsQi9wZ3Uw?=
 =?utf-8?B?aVkyNGgvcFZia0o0ampQTldDaDVPTlhaQmVKV2NPc3FCTXNuVUo3MGJKVW1O?=
 =?utf-8?B?U2IxOHd2YTV3UzJNYis5dTNVQ3NnWWR5ZDZBMUJMLzJSNEhlTnR3c2ZLSjNl?=
 =?utf-8?B?VzBDZTNBcnV5UmZ0cVZHYjgvMitTZTFrK0hPbFBTajJ0NHNvdm4xVThNT2Ry?=
 =?utf-8?B?a2xsaUJzVEdaTW5LbCtMTnR1NlFUUEZVSCtaRk9XZkNCUVFGZlJTOEVDZndo?=
 =?utf-8?B?MVppaGVSMU8yOWIrUElQQ0JsUWpydmRBM1BnekJCb2owbUJqSjN5K1ptUG00?=
 =?utf-8?B?ZVMzTklsZW9tbExoNjVuZUtKcHNIOTJ3Z0M4RXpYTGFFL3cwcS9oNmxnWXpB?=
 =?utf-8?B?bmllUUE0dE1JTW9RRjFxOUM0ZC9XLzVUVDNxRm03bVFPVzBJYlBra2lodHFy?=
 =?utf-8?B?QTJYaGJlSjVvUFpNbGZBaWxmc1Ywb3FTM2pBSlFRTS9OemVYSjRNaXNlTmVQ?=
 =?utf-8?B?N3c9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db776696-369b-4367-58f2-08d9fcb9fd51
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 02:03:20.0626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JveFRdCTpS3inhaZJUyCt7XcNWUAlWCL08U7oRa2G9cazOqGq7V53t4S3eZRLNqN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1330
X-Proofpoint-ORIG-GUID: NIpyPDj2XiobyRfvpLihgoyElBGPChsw
X-Proofpoint-GUID: NIpyPDj2XiobyRfvpLihgoyElBGPChsw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-02_12,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203030007
X-FB-Internal: deliver
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/2/22 2:45 PM, Kumar Kartikeya Dwivedi wrote:
> On Sat, Feb 26, 2022 at 05:13:38AM IST, Hao Luo wrote:
>> Introduce a new type of iter prog: cgroup. Unlike other bpf_iter, this
>> iter doesn't iterate a set of kernel objects. Instead, it is supposed to
>> be parameterized by a cgroup id and prints only that cgroup. So one
>> needs to specify a target cgroup id when attaching this iter.
>>
>> The target cgroup's state can be read out via a link of this iter.
>> Typically, we can monitor cgroup creation and deletion using sleepable
>> tracing and use it to create corresponding directories in bpffs and pin
>> a cgroup id parameterized link in the directory. Then we can read the
>> auto-pinned iter link to get cgroup's state. The output of the iter link
>> is determined by the program. See the selftest test_cgroup_stats.c for
>> an example.
>>
>> Signed-off-by: Hao Luo <haoluo@google.com>
>> ---
>>   include/linux/bpf.h            |   1 +
>>   include/uapi/linux/bpf.h       |   6 ++
>>   kernel/bpf/Makefile            |   2 +-
>>   kernel/bpf/cgroup_iter.c       | 141 +++++++++++++++++++++++++++++++++
>>   tools/include/uapi/linux/bpf.h |   6 ++
>>   5 files changed, 155 insertions(+), 1 deletion(-)
>>   create mode 100644 kernel/bpf/cgroup_iter.c
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 759ade7b24b3..3ce9b0b7ed89 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -1595,6 +1595,7 @@ int bpf_obj_get_path(bpfptr_t pathname, int flags);
>>
>>   struct bpf_iter_aux_info {
>>   	struct bpf_map *map;
>> +	u64 cgroup_id;
>>   };
>>
>>   typedef int (*bpf_iter_attach_target_t)(struct bpf_prog *prog,
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index a5dbc794403d..855ad80d9983 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -91,6 +91,9 @@ union bpf_iter_link_info {
>>   	struct {
>>   		__u32	map_fd;
>>   	} map;
>> +	struct {
>> +		__u64	cgroup_id;
>> +	} cgroup;
>>   };
>>
>>   /* BPF syscall commands, see bpf(2) man-page for more details. */
>> @@ -5887,6 +5890,9 @@ struct bpf_link_info {
>>   				struct {
>>   					__u32 map_id;
>>   				} map;
>> +				struct {
>> +					__u64 cgroup_id;
>> +				} cgroup;
>>   			};
>>   		} iter;
>>   		struct  {
>> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
>> index c1a9be6a4b9f..52a0e4c6e96e 100644
>> --- a/kernel/bpf/Makefile
>> +++ b/kernel/bpf/Makefile
>> @@ -8,7 +8,7 @@ CFLAGS_core.o += $(call cc-disable-warning, override-init) $(cflags-nogcse-yy)
>>
>>   obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o bpf_iter.o map_iter.o task_iter.o prog_iter.o
>>   obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
>> -obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o
>> +obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o cgroup_iter.o
>>   obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o bpf_task_storage.o
>>   obj-${CONFIG_BPF_LSM}	  += bpf_inode_storage.o
>>   obj-$(CONFIG_BPF_SYSCALL) += disasm.o
>> diff --git a/kernel/bpf/cgroup_iter.c b/kernel/bpf/cgroup_iter.c
>> new file mode 100644
>> index 000000000000..011d9dcd1d51
>> --- /dev/null
>> +++ b/kernel/bpf/cgroup_iter.c
>> @@ -0,0 +1,141 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/* Copyright (c) 2022 Google */
>> +#include <linux/bpf.h>
>> +#include <linux/btf_ids.h>
>> +#include <linux/cgroup.h>
>> +#include <linux/kernel.h>
>> +#include <linux/seq_file.h>
>> +
>> +struct bpf_iter__cgroup {
>> +	__bpf_md_ptr(struct bpf_iter_meta *, meta);
>> +	__bpf_md_ptr(struct cgroup *, cgroup);
>> +};
>> +
>> +static void *cgroup_iter_seq_start(struct seq_file *seq, loff_t *pos)
>> +{
>> +	struct cgroup *cgroup;
>> +	u64 cgroup_id;
>> +
>> +	/* Only one session is supported. */
>> +	if (*pos > 0)
>> +		return NULL;
>> +
>> +	cgroup_id = *(u64 *)seq->private;
>> +	cgroup = cgroup_get_from_id(cgroup_id);
>> +	if (!cgroup)
>> +		return NULL;
>> +
>> +	if (*pos == 0)
>> +		++*pos;
>> +
>> +	return cgroup;
>> +}
>> +
>> +static void *cgroup_iter_seq_next(struct seq_file *seq, void *v, loff_t *pos)
>> +{
>> +	++*pos;
>> +	return NULL;
>> +}
>> +
>> +static int cgroup_iter_seq_show(struct seq_file *seq, void *v)
>> +{
>> +	struct bpf_iter__cgroup ctx;
>> +	struct bpf_iter_meta meta;
>> +	struct bpf_prog *prog;
>> +	int ret = 0;
>> +
>> +	ctx.meta = &meta;
>> +	ctx.cgroup = v;
>> +	meta.seq = seq;
>> +	prog = bpf_iter_get_info(&meta, false);
>> +	if (prog)
>> +		ret = bpf_iter_run_prog(prog, &ctx);
>> +
>> +	return ret;
>> +}
>> +
>> +static void cgroup_iter_seq_stop(struct seq_file *seq, void *v)
>> +{
>> +	if (v)
>> +		cgroup_put(v);
>> +}
> 
> I think in existing iterators, we make a final call to seq_show, with v as NULL,
> is there a specific reason to do it differently for this? There is logic in
> bpf_iter.c to trigger ->stop() callback again when ->start() or ->next() returns
> NULL, to execute BPF program with NULL p, see the comment above stop label.
> 
> If you do add the seq_show call with NULL, you'd also need to change the
> ctx_arg_info PTR_TO_BTF_ID to PTR_TO_BTF_ID_OR_NULL.

Kumar, PTR_TO_BTF_ID should be okay since the show() never takes a 
non-NULL cgroup. But we do have issues for cgroup_iter_seq_stop() which 
I missed earlier.

For cgroup_iter, the following is the current workflow:
    start -> not NULL -> show -> next -> NULL -> stop
or
    start -> NULL -> stop

So for cgroup_iter_seq_stop, the input parameter 'v' will be NULL, so
the cgroup_put() is not actually called, i.e., corresponding cgroup is
not freed.

There are two ways to fix the issue:
   . call cgroup_put() in next() before return NULL. This way,
     stop() will be a noop.
   . put cgroup_get_from_id() and cgroup_put() in
     bpf_iter_attach_cgroup() and bpf_iter_detach_cgroup().

I prefer the second approach as it is cleaner.

> 
>> +
>> +static const struct seq_operations cgroup_iter_seq_ops = {
>> +	.start  = cgroup_iter_seq_start,
>> +	.next   = cgroup_iter_seq_next,
>> +	.stop   = cgroup_iter_seq_stop,
>> +	.show   = cgroup_iter_seq_show,
>> +};
>> +
>> +BTF_ID_LIST_SINGLE(bpf_cgroup_btf_id, struct, cgroup)
>> +
>> +static int cgroup_iter_seq_init(void *priv_data, struct bpf_iter_aux_info *aux)
>> +{
>> +	*(u64 *)priv_data = aux->cgroup_id;
>> +	return 0;
>> +}
>> +
>> +static void cgroup_iter_seq_fini(void *priv_data)
>> +{
>> +}
>> +
>> +static const struct bpf_iter_seq_info cgroup_iter_seq_info = {
>> +	.seq_ops                = &cgroup_iter_seq_ops,
>> +	.init_seq_private       = cgroup_iter_seq_init,
>> +	.fini_seq_private       = cgroup_iter_seq_fini,
>> +	.seq_priv_size          = sizeof(u64),
>> +};
>> +
>> +static int bpf_iter_attach_cgroup(struct bpf_prog *prog,
>> +				  union bpf_iter_link_info *linfo,
>> +				  struct bpf_iter_aux_info *aux)
>> +{
>> +	aux->cgroup_id = linfo->cgroup.cgroup_id;
>> +	return 0;
>> +}
>> +
>> +static void bpf_iter_detach_cgroup(struct bpf_iter_aux_info *aux)
>> +{
>> +}
>> +
>> +void bpf_iter_cgroup_show_fdinfo(const struct bpf_iter_aux_info *aux,
>> +				 struct seq_file *seq)
>> +{
>> +	char buf[64] = {0};
>> +
>> +	cgroup_path_from_kernfs_id(aux->cgroup_id, buf, sizeof(buf));
>> +	seq_printf(seq, "cgroup_id:\t%lu\n", aux->cgroup_id);
>> +	seq_printf(seq, "cgroup_path:\t%s\n", buf);
>> +}
>> +
>> +int bpf_iter_cgroup_fill_link_info(const struct bpf_iter_aux_info *aux,
>> +				   struct bpf_link_info *info)
>> +{
>> +	info->iter.cgroup.cgroup_id = aux->cgroup_id;
>> +	return 0;
>> +}
>> +
>> +DEFINE_BPF_ITER_FUNC(cgroup, struct bpf_iter_meta *meta,
>> +		     struct cgroup *cgroup)
>> +
>> +static struct bpf_iter_reg bpf_cgroup_reg_info = {
>> +	.target			= "cgroup",
>> +	.attach_target		= bpf_iter_attach_cgroup,
>> +	.detach_target		= bpf_iter_detach_cgroup,
>> +	.show_fdinfo		= bpf_iter_cgroup_show_fdinfo,
>> +	.fill_link_info		= bpf_iter_cgroup_fill_link_info,
>> +	.ctx_arg_info_size	= 1,
>> +	.ctx_arg_info		= {
>> +		{ offsetof(struct bpf_iter__cgroup, cgroup),
>> +		  PTR_TO_BTF_ID },
>> +	},
>> +	.seq_info		= &cgroup_iter_seq_info,
>> +};
>> +
>> +static int __init bpf_cgroup_iter_init(void)
>> +{
>> +	bpf_cgroup_reg_info.ctx_arg_info[0].btf_id = bpf_cgroup_btf_id[0];
>> +	return bpf_iter_reg_target(&bpf_cgroup_reg_info);
>> +}
>> +
>> +late_initcall(bpf_cgroup_iter_init);
>> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
>> index a5dbc794403d..855ad80d9983 100644
>> --- a/tools/include/uapi/linux/bpf.h
>> +++ b/tools/include/uapi/linux/bpf.h
>> @@ -91,6 +91,9 @@ union bpf_iter_link_info {
>>   	struct {
>>   		__u32	map_fd;
>>   	} map;
>> +	struct {
>> +		__u64	cgroup_id;
>> +	} cgroup;
>>   };
>>
>>   /* BPF syscall commands, see bpf(2) man-page for more details. */
>> @@ -5887,6 +5890,9 @@ struct bpf_link_info {
>>   				struct {
>>   					__u32 map_id;
>>   				} map;
>> +				struct {
>> +					__u64 cgroup_id;
>> +				} cgroup;
>>   			};
>>   		} iter;
>>   		struct  {
>> --
>> 2.35.1.574.g5d30c73bfb-goog
>>
> 
> --
> Kartikeya
