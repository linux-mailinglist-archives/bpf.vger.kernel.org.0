Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB9E342A30
	for <lists+bpf@lfdr.de>; Sat, 20 Mar 2021 04:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhCTDcB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Mar 2021 23:32:01 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:11436 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229618AbhCTDbp (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 19 Mar 2021 23:31:45 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12K3MilC025682;
        Fri, 19 Mar 2021 20:31:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=d4ZSaXJohQHlfGuq5mPprfNbETTliGNYUFqt0Zejods=;
 b=KMKekltWqPzJK7Ke6qU3/hM+4TYYqJGSAehblszoKZR3WploZ324wMS8xP5syLIYL3S8
 YCsaiIxSxsSEdGNw+u/c8xWEOHgYpmof+OuoIWRJ6ydbwW/qgBLMB2H7WzmXcbFz1Z/e
 3bUxXtgujOBxILKbOkZR9Kn/R6ZQ+J7COSg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37bs1exb8w-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 19 Mar 2021 20:31:31 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 19 Mar 2021 20:31:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z11FUAShwURgNIWe4Cd5yACLlpdNHlbxY6leAHjeUZXYceqWCukpvhzOiZxxE4OHywxCsCH7yaTFf8nNpKJmu0GY1Tso70/xs3eLJMiSm4iZMmNFrBYnuplXOP9zmxEMc3FnFKKn7yyFv/XCAZAnEqfH4Eg7Fe28uTPYla2fFDtWwKpafwYGIV4hds8EPtU2x02DevfMs358KjY4FWVRgdWGPgM3ORaP029DzTgf3i853XgFi7WoAGL11R+8doPjjuhki/kkruNkSj8MQVLByInI0MfaCqiaXuZ6zoz1K0k48n7k0bi+4BFIXRSz9bUdzSNXOU0b+w8pKO/sCQn9pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4ZSaXJohQHlfGuq5mPprfNbETTliGNYUFqt0Zejods=;
 b=CGW8eh3A5O0oEheAVnZNr8R5BVg+A7mnrLKp92L6zWn41sMm44T8dvwz1vYfUH5E/GhFE+sMs2UyNexiMeL08p3YZ+VKbqOINXw1uqi9X4Wu9Rw48WGwcBLL1/gdEzwDLlYvOnECzUZRZkVyWYODLKQAIHU/o6etKIvIctGEq8k+3HY7AyBMkfNHcw0I5vVFXBpDL1LIvHNdSmicvpu2WkZPtcJ5ylzCNXHbITGf6YPtrAjk0VOwZVbMrSjzkWanuR1A2uNRiUqXhJeIySYSK2cY61h6lUc8jxP48Fa7q7Aage507qeR5XUlxz07rMm8qf1dN+69Gibhxr8+0XI2TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3936.namprd15.prod.outlook.com (2603:10b6:806:80::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Sat, 20 Mar
 2021 03:31:29 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3955.024; Sat, 20 Mar 2021
 03:31:29 +0000
Subject: Re: [PATCH bpf-next v2 1/2] bpf: fix NULL pointer dereference in
 bpf_get_local_storage() helper
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Jiri Olsa <jolsa@kernel.org>, Roman Gushchin <guro@fb.com>
References: <20210319031231.3707705-1-yhs@fb.com>
 <20210319031236.3709026-1-yhs@fb.com>
 <20210320024704.adg6xknxtznba5ng@ast-mbp>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <8d723982-f020-a591-0556-375786777e03@fb.com>
Date:   Fri, 19 Mar 2021 20:31:25 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
In-Reply-To: <20210320024704.adg6xknxtznba5ng@ast-mbp>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:9bb1]
X-ClientProxiedBy: BYAPR01CA0009.prod.exchangelabs.com (2603:10b6:a02:80::22)
 To SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c1::1948] (2620:10d:c090:400::5:9bb1) by BYAPR01CA0009.prod.exchangelabs.com (2603:10b6:a02:80::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Sat, 20 Mar 2021 03:31:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21628594-6256-44c8-3654-08d8eb50a62a
X-MS-TrafficTypeDiagnostic: SA0PR15MB3936:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR15MB39367498E2707003542A0952D3679@SA0PR15MB3936.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FpZOmds8sC1tTJzRn+labUws/iTiSyj2Qa8dUXW1pWZrfb6qQ1e9bOVLrnhtYtA7OQFS8rXPleakYp5Dd+AFH1UzjiUndabLIUwVo3bF/Kx6sKlJ+u2EwvofW/c12aSYRCBILJBG7v1+SnXmLtm3H7ZNRymePHIK2kWIE3Osb6ekWygUSBIJpKRWgrbqu7waA5ht9kEUTXxO42ENeVBoJmC1Wb2NwLykDgoGiYAR9m4IAZaQZciO7Jjyu1FgbMMxdxPooggjBgpPdh3+IuGmdNyasA1KwrUVv6iYYDQxJhrnoaLlESjk/XPHFlqMwQyGrY1rQs77Uu1RMO/syWQeMV5Infar/x0Yf9BeBwazALG19QyXkvt4WwfNMzc91mddT9VXnT5PLpsE+ll1Wzh+GuLNt1H1X2iMxWdJT9Zxi1jJIRjVtT0JXB7vx+v7LTzrKsFlpRXtizvppLFd9aVzJ2bFMIxVSsb+1SgDubkRg1jF1UUnmop1wGEd1JjuFlTCOIrA3k7l8iUGjSQuxRZZdbCXj3ymLLdfUdTVGBGt5kIFLkwdySgHy1cp6nK6ZifRdQVaIWlEGZAcbdetRNuJOV+FMAmueW0WYDUFCBne8SfX5VhOewwOj33PxjbG/3ZWv621wB4FRLsLavvzUeGdkHCW3gY594mZQV4//p8PWuvNCi5GbgEWK7Pyk0FA/g8I
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(136003)(366004)(396003)(39860400002)(16526019)(6666004)(83380400001)(86362001)(31696002)(66556008)(5660300002)(6916009)(52116002)(53546011)(186003)(54906003)(4326008)(2616005)(8936002)(478600001)(66946007)(2906002)(6486002)(36756003)(66476007)(316002)(38100700001)(31686004)(8676002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?STlvdG0xQnFOR2NtSU0yQ3JZTkpZdDBucncweVBHM2F5RWkxZHVMOWdQMjNU?=
 =?utf-8?B?UmJERGNmNjhQNHJXMU5LL1ZVSHRIdFl0NDNIOGNhQXB3eDNZZFlFeUx4THd5?=
 =?utf-8?B?R1RVTC9qWGxCTk1qQWlBZ0s2czkyMjVFYXFJVG0yY1NpeVJhRFpaVUtmMERk?=
 =?utf-8?B?S0pnWHZaWk5TMzU3NjJKQWhNNEp5SDNDUDhKdmRxbGpwRzdlQ2RwZGZESGVO?=
 =?utf-8?B?YkFsTkV6SEhXR00wMEcrM1V0VXp6OVMrT1d3MFEyYStXdjEydFdGVUNxUi9K?=
 =?utf-8?B?NFdBMEVvZWZ1MVBKTGVjTVlicTN3VDZycGk1QUlWeENVcWh1d1hnQ3cvNGRT?=
 =?utf-8?B?akJ3K2M4TDh2OXZCZFZKNU5OSytkcStyUnJqb0ZRblpwbXhmL1VNN1FIQm42?=
 =?utf-8?B?THJUWVpiVUQ4SUJibXJYdTBHMmR3dW1pTlZ0WUFOcFBPY1J5Q3N3Y2J1dlpp?=
 =?utf-8?B?Uk9pbmlsS0E5K29ycG9vVzdRT05TZDlEUlE2U3dpSnF4bEMwb2wwWFljL1pF?=
 =?utf-8?B?V3lubUgrdUpvTk90MmtYcTZKY1l2enNqOUw3RXNZRHFIR2VoZWEvUVl2ZnJP?=
 =?utf-8?B?UUc1REJGYzYvNjJkRVNJRDBxSG9aQUVPYXE0Rmo4RXVGVDQvMkh2SUl1MUVU?=
 =?utf-8?B?dVMyeXJGWDUrNlkxaWNudzZZb3haanYxWVFBaDIzRU5MMmNaY1d0M1J0VVV3?=
 =?utf-8?B?cHJFVTV1S1ZJclpjSzZJWXVlU2hDL0Z3N0dVemlQOStsUm01bjdUMnJCQkJT?=
 =?utf-8?B?dndncUVRN2JyTkRhT1FrNjY2T1c2SllQME1uWlRPVStxaGV1dnlJLzY5Mm8z?=
 =?utf-8?B?Z3lSWFFRWEUvR1BLN0lJOFpnWnAxYktEaXV1ZGduekprTHE0RlE2MU5rQlF1?=
 =?utf-8?B?TkZpakhOZzEzWFlaNEhnNHY1Z2FxN1NrSytQU2pnT2diRUZHcG5JQTBTTGZ4?=
 =?utf-8?B?di9teXp4dUZweXpXQUs0M0JsaHQ5cHVLakhPa1lOSnIyS2kybWFPUHQ1TW5H?=
 =?utf-8?B?ZWVYb25JY0VwYzVDelBCNWRrbWZNOU5mVnBGaGVPM0I1NzFYaWpRRjIyMXZL?=
 =?utf-8?B?eXVMQUw2MFd1S1E0Mm1rSUh0WFJleit0Q2ZWWHJZcUJhSytwaUpsdkhUcGJv?=
 =?utf-8?B?TTJuRmxpWXpENjNCZE95MnBqeU1XVjliUEJQbWwxQklzeFp3Y05MeGVFOG5I?=
 =?utf-8?B?OXl6dTZKR20rb3JuRWhhYndmeVd5dXZsYjR6Snl6N3NoczdJZHVMYXMySHM3?=
 =?utf-8?B?YmxHY2cyV2lvTVN6U0hzblpOSGV0UFNFeVplaUdXOHRIM20vZFFRQUt6aWlV?=
 =?utf-8?B?TW4xUXNiV3d0NXpueCtaK0VCa0RKYTlLTjlEWDE5bVBqczBJa25xbG9EV2dL?=
 =?utf-8?B?TjgrRExaT1AzV2tLS3RQc3UxYm1JQ293REp1Tm9YVWdJd25CSk5GdU9kR0hw?=
 =?utf-8?B?Y1QzbG1BaUJvMFZ5cUI1L3dBcWpwOEFEdENTaE81U1BvaGkxajM5OHN0ZmYx?=
 =?utf-8?B?cU82eFFDM2U4SHhteDl3a2RJWmx6V21rOVpmQTZsSlhSaGQ5N05EKzF2dzJH?=
 =?utf-8?B?aTNCVWpCTk4xTUFiV1Y2Z2gwNE40RVBBTjN1QlJQRHdrUWVMWUowcjRKRWRX?=
 =?utf-8?B?aUd6YVp3ZUdhUENKekFRa3NNVVI4YnhIOUdHRCtBM21haC84ZXJlMThBYUo4?=
 =?utf-8?B?N3d2MEpod05QZmdLQmdKdFF6dVhOVEdsWU1EaGJVUTBXVXcrWW11S2pmeUJF?=
 =?utf-8?B?YUFveHdpNXpvTmZ3Z2d2MUZEZE42ZWZKdDk2L0JodFliQmtjTUtMZWtuaGNY?=
 =?utf-8?B?eURTKzFVdWRmUEJkYmdjdz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 21628594-6256-44c8-3654-08d8eb50a62a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2021 03:31:29.1769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oDcp0HB3vHgQJk+XDndcp8VVIQQ1jw9dD9mato92sQYpezgw7ByGgRQKKeLu+dMb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3936
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-19_12:2021-03-19,2021-03-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103200023
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/19/21 7:47 PM, Alexei Starovoitov wrote:
> On Thu, Mar 18, 2021 at 08:12:36PM -0700, Yonghong Song wrote:
>> -static inline void bpf_cgroup_storage_set(struct bpf_cgroup_storage
>> -					  *storage[MAX_BPF_CGROUP_STORAGE_TYPE])
>> +static inline int bpf_cgroup_storage_set(struct bpf_cgroup_storage
>> +					 *storage[MAX_BPF_CGROUP_STORAGE_TYPE])
>>   {
>>   	enum bpf_cgroup_storage_type stype;
>> +	int i;
>> +
>> +	preempt_disable();
>> +	for (i = 0; i < BPF_CGROUP_STORAGE_NEST_MAX; i++) {
>> +		if (unlikely(this_cpu_read(bpf_cgroup_storage_info[i].task) != NULL))
>> +			continue;
>> +
>> +		this_cpu_write(bpf_cgroup_storage_info[i].task, current);
>> +		for_each_cgroup_storage_type(stype)
>> +			this_cpu_write(bpf_cgroup_storage_info[i].storage[stype],
>> +				       storage[stype]);
>> +		break;
>> +	}
>> +	preempt_enable();
>> +
>> +	if (i == BPF_CGROUP_STORAGE_NEST_MAX) {
>> +		WARN_ON_ONCE(1);
>> +		return -EBUSY;
>> +	}
>> +	return 0;
> 
> The extra 'if' probably will be optimized by the compiler,
> but could you write it like this instead:
> +       int err = 0;
> ..
> +		for_each_cgroup_storage_type(stype)
> +			this_cpu_write(bpf_cgroup_storage_info[i].storage[stype],
> +				       storage[stype]);
> +		goto out;
> +	}
> +       err = -EBUSY;
> +	WARN_ON_ONCE(1);
> +    out:
> +	preempt_enable();
> +	return err;

okay.

> 
> Also patch 2 should be squashed into patch 1,
> since patch 1 alone makes bpf_prog_test_run() broken.
> (The WARN_ON_ONCE should trigger right away on test_run without patch 2).

You are right. Will fold this into one patch. My original intention is
to apply patch 1 to bpf tree. Looks like folding one patch is necessary.
We can create a different patch for bpf tree if needed.

> 
> Another nit:
> Is title of the patch "fix NULL pointer dereference" actually correct?
> It surely was correct before accidental tracing overwrite was fixed.
> But the fix is already in bpf tree.
> Do you still see it as NULL deref with that 3 min reproducer?

Yes, I do. I just double checked and run again with latest bpf-next +
bpf_local_storage kprobe/tracepoint fix.

with gcc 8.4.1, kasan is enabled. I hit

[  806.571378] BUG: KASAN: null-ptr-deref in 
bpf_get_local_storage+0x29/0x70 

[  806.572393] Read of size 8 at addr 0000000000000000 by task 
test_progs/16069 

[  806.573487] 
 

[  806.573747] CPU: 1 PID: 16069 Comm: test_progs Tainted: G           O 
      5.12.0-rc2+ #59 

[  806.574964] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014 

[  806.576627] Call Trace: 
 

[  806.577045]  dump_stack+0xa4/0xe5 
 

[  806.577572]  ? bpf_get_local_storage+0x29/0x70 
 

[  806.578257]  ? bpf_get_local_storage+0x29/0x70 
 

[  806.578929]  kasan_report.cold.13+0x5f/0xd8 
 

[  806.579595]  ? bpf_get_local_storage+0x29/0x70 
 

[  806.580300]  bpf_get_local_storage+0x29/0x70 
 

[  806.580970] 
bpf_prog_b06a218bf1bb5278_bpf_sping_lock_test+0x2af/0xdc8 
 

[  806.581976]  bpf_test_run+0x268/0x420 
 

[  806.582602]  ? bpf_test_timer_continue+0x1c0/0x1c0 
 

[  806.583338]  ? __build_skb+0x20/0x50 
 

[  806.583871]  ? rcu_read_lock_sched_held+0xa1/0xd0 
 

[  806.584562]  ? rcu_read_lock_bh_held+0xb0/0xb0 
 

[  806.585235]  ? static_obj+0x32/0x80 
 

[  806.585801]  ? eth_gro_receive+0x3b0/0x3b0 
 

[  806.586440]  ? __build_skb+0x45/0x50 
 

[  806.587006]  bpf_prog_test_run_skb+0x69c/0xc10 
 

[  806.587721]  ? bpf_prog_test_run_raw_tp+0x2e0/0x2e0 
 

[  806.588500]  ? fput_many+0x1a/0xc0 
 

[  806.589052]  __do_sys_bpf+0x1025/0x2d30
[  806.589637]  ? check_chain_key+0x1ea/0x2f0
[  806.590277]  ? bpf_link_get_from_fd+0x80/0x80
[  806.590974]  ? __lock_acquire+0x921/0x2f80
[  806.591633]  ? register_lock_class+0x950/0x950
[  806.592354]  ? pvclock_clocksource_read+0xdc/0x180
[  806.593160]  ? rcu_read_lock_sched_held+0xa1/0xd0
[  806.593940]  ? syscall_enter_from_user_mode+0x1c/0x40
[  806.594696]  do_syscall_64+0x33/0x40
[  806.595244]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  806.594696]  do_syscall_64+0x33/0x40
[  806.595244]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  806.596044] RIP: 0033:0x7f7a155e67f9
[  806.596599] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 
48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 
05 <48> 3d 01 f0 ff ff 73 01 c3 488
[  806.599404] RSP: 002b:00007f7a144ffe68 EFLAGS: 00000202 ORIG_RAX: 
0000000000000141
[  806.600552] RAX: ffffffffffffffda RBX: 00007f7a144fff2c RCX: 
00007f7a155e67f9
[  806.601627] RDX: 0000000000000078 RSI: 00007f7a144ffe70 RDI: 
000000000000000a
[  806.602694] RBP: 00007f7a144fff28 R08: 0000000000000000 R09: 
0000000000000008
[  806.603795] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000000
[  806.604833] R13: 00007ffd8b062d9f R14: 0000000000000003 R15: 
0000000000000000




