Return-Path: <bpf+bounces-10003-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0107A0353
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 14:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C63B1280CE5
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 12:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A823D219E3;
	Thu, 14 Sep 2023 12:04:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAC4208BC
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 12:04:33 +0000 (UTC)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2090.outbound.protection.outlook.com [40.107.117.90])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2081BE8;
	Thu, 14 Sep 2023 05:04:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kIEyJMr0AAa8QMu8a9CBtfU3+RAGxuQiTrulTtsh4O3aaJ/lVXTOqFGR+n5M0O3tqYVE2VoTUB2vAczfgL97KyZyDG37B4Cy9pPudCiqLmdApPG6XUY5Zv9Dbghf7pIq1FgpDkFxBu7ir6rH9juVssFeo0Q8RnD5VhzJr56A0QDOk1tkeAJJyLYEJxc3lJxcfksFbVxX0SFd+w+E0oMZUuu67UgqxFBlPxFzu7CDJTRIiXb3wr+UfoWeLD3TTsXjjceuK5zpc4e13Euco8DzfLAwlDw1lMmh30Z7yAz2/UHs5c7be5urcxfy/x6Jwv/ybIoXZutIOsZ6aLWfkJLHUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5lMAjhk8bVmoXbhgFKyhUmq9tFlamqxz7Wev4qRObo=;
 b=DF+AG7Qu2TNDPjZxC2kQrUgJN7hwOb6qoVNhVU00yjhN3Oi0hBF9OpjQgk3Uu396Jh0pnCgOJUZLumqdYojfKYL8evx+2AvrYzKU0tksrqCXIU7adfYzuqLBN/orTvxAcbS/OYqbg/m9zD3r68PftjrbRA6qqtSYGR8VhmJS2lzpt8sBlvvXbV6zZKbihuEVQN2+vTgYUh5f8FAwVvqVTf29/jsl/qQdBPnUWZysPVVdNVCgzb8NQ/tCMsrb83BxWC0xCXpTeAMZ9/imuL/DUW7tg9LISL7eF8JfY7h7+nyYrP5qe9CwyTbffi2kbV1WCRATF7spvnFNeGNF27bNUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5lMAjhk8bVmoXbhgFKyhUmq9tFlamqxz7Wev4qRObo=;
 b=JDxXXmXlOVbqkd5xAzsICn461KvQLDoq8l9XHtagryYIibYInFa5LzPtjAAuDeNeRCsGkDVojkYsIw/PkVWkmssiE5wQ1FI8WawlIZ6Dl1ljIAdYSGQiLAgSgJwU7UnuXx2TznlrYcFIf7TSavCRQfGcjOwoMLBpSnZ0T8mu5KpYP9JVcq1lrv9p3RPgqglJ0W8/eNQFXTsaIRYxDsg6IGTUEvLl/i/d6uxx3ROshHIKJ7+pE6dhBYMkahfX4KE5Rcwce4Us8OYH2+no6FRDsEO8JKy7qsTMIOHAd8IsfKxnB8Fl56mSgDe8CMmxKg86qTQK+zOvRxHpKToONgNGPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4045.apcprd06.prod.outlook.com (2603:1096:400:21::8)
 by SEYPR06MB5515.apcprd06.prod.outlook.com (2603:1096:101:b2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 12:04:29 +0000
Received: from TYZPR06MB4045.apcprd06.prod.outlook.com
 ([fe80::1c25:781c:9638:960d]) by TYZPR06MB4045.apcprd06.prod.outlook.com
 ([fe80::1c25:781c:9638:960d%7]) with mapi id 15.20.6792.020; Thu, 14 Sep 2023
 12:04:29 +0000
Message-ID: <3f7d41bd-ca12-4458-89ba-474d7a4b5bb2@vivo.com>
Date: Thu, 14 Sep 2023 20:04:27 +0800
User-Agent: Mozilla Thunderbird
From: Bixuan Cui <cuibixuan@vivo.com>
Subject: Re: [RFC PATCH v2 2/5] mm: Add policy_name to identify OOM policies
To: Jonathan Corbet <corbet@lwn.net>, Chuyi Zhou <zhouchuyi@bytedance.com>,
 hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 muchun.song@linux.dev
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 wuyun.abel@bytedance.com, robin.lu@bytedance.com
References: <20230810081319.65668-1-zhouchuyi@bytedance.com>
 <20230810081319.65668-3-zhouchuyi@bytedance.com>
 <87h6p1uz3w.fsf@meer.lwn.net>
In-Reply-To: <87h6p1uz3w.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY1PR01CA0193.jpnprd01.prod.outlook.com (2603:1096:403::23)
 To TYZPR06MB4045.apcprd06.prod.outlook.com (2603:1096:400:21::8)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4045:EE_|SEYPR06MB5515:EE_
X-MS-Office365-Filtering-Correlation-Id: 76a5391b-72e2-4dcd-ba49-08dbb51abff0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	r1atFd87VKST1ygLq6A9C5e09DznW240PXJfVGMOmD7KNU+Qs4ZU+qFSqCI0YkGqaMWKrsH7EMnnFyIJ0t68fFC4K519cNU0QAhlHf3NNwDjtYg2qVstuStk8fEDo/FOpOGuert/LNbCyL1XgrQrutDK5AbD41YGtr0MYjQDAZvpHc5eOlzHWq2yTtk0B/ql1nTGI510n6JqaNrMq1r3XbsjWHTRUskQf8/vBmfID9vhZ8gKn6RUqTDM8Ikc7xwMCbzW1/RvJyBO1Lj7ILlfLDD5WkOef4WAMo0zzmMahA6zJrvGoy21nx+hEj2mGDldyfB0GMqc2nhsngWkRpuZGFM52ck9l+9x+Ew5UjhSJrP7RIsfbj12TuIb7B0eb8LE0+GHpCrEbVH1JmC5HMMa9qUybBA2pO/qtS/rZy8M/D5JAX/njHHPySmICy993pqQ/N/VZ3DZhsg1UoCNYKHPmjQKPQJdeC+vh+sa3sHk0qjg/VVNGwPo3fZrX5IRRYijLzzwX4ipRJiGfYFszlkr2neTc/GJX4dy/tRgni+0aKF4A4M4oP0nr3QR+nQd/X3YPXeJAStohDif7ZjRyyhJLLUaXUGRmaLm9Wgqvc4/t0HEQizO/4r4T/qeLgi2q50IJ/Jm5Oxo1sQA5VS4G1vs1/jFiPcTp9Lf4ow6WIztzReRftaqtWvGWPNDi6ucyN2A
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4045.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(366004)(39860400002)(376002)(186009)(1800799009)(451199024)(83380400001)(52116002)(6512007)(86362001)(38100700002)(110136005)(2616005)(38350700002)(6486002)(31696002)(478600001)(6506007)(26005)(4326008)(8676002)(7416002)(36756003)(316002)(66556008)(41300700001)(5660300002)(66476007)(8936002)(66946007)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWlRdUJvaGNjNG1GMEIyd1pGdSsrK3VRZWRqVWhoQ3VmK3RkUHUwWDBDRVpi?=
 =?utf-8?B?cmowbEkrNjk0NDVpOVNBK2NwcFJZN2VYM1hzT0R5eHQ3NVc3VnlsL0xMVzVz?=
 =?utf-8?B?Y0VpMjJRaEw1aS9Wc1BKeC9yNCsxY1pGdHZmak1SR2ljQ0lJRURkWHNiNDkv?=
 =?utf-8?B?SUptYjljdGRJVG83bVRvMndkN2JCMTNISzk0UFUzL3JBNnBNMWZxQy9odEZ5?=
 =?utf-8?B?cmpveXhUVVpkUjRyaWtIcXZPMGRRaDdweWc3MDB1U0NXZU9kMjdPc1B3enBl?=
 =?utf-8?B?dXJCZG1PT0N2Tk04RGk1M2FFMXVEM1dDaEVjRUNXT0tHY2lOdk5selhGL2Zl?=
 =?utf-8?B?TFViUXJPR2E4VzNnNmFYTkNMUHA1aXl6NFhaWTJHTTJpMEhXZEZ6emxpeklB?=
 =?utf-8?B?L2lsbzdYb0FaRlFvVVRSaHhUaEdHMjN5WDdqRHd4RVEvcCtUSXFEOTV0NWRN?=
 =?utf-8?B?V3NPR2g2R0xkd1JZVjNwa0w2UXNKK0xIS0VZbzUrQ0lkZ3pqczV4TDNuKzVi?=
 =?utf-8?B?dWxZTVZZZ1RwenJtQ3JySUgyeXNVVEErYTkxTlEvTkNvSm5IMzM1UlNwaGFP?=
 =?utf-8?B?UmRTQU1DejlkNitZVmlMQ0ZsdklQRWNZVHhIbyt1Y281c2oxQVk4M2RFUGRC?=
 =?utf-8?B?N04vMkNMM1NtbU0vSkNMQVBxdXFiSUVCT1o2eTM4dFFLNmdWN2U0SDhwanAy?=
 =?utf-8?B?dXJ2S2dpQ2VtQ2VCemtPdU5zODBFMktWM2dYcGZSeFozWDI4MC9xUWVjZDEv?=
 =?utf-8?B?UXp1RTEra0t0OWhJUkVKcUFKNjRUSFViaWpueTNEb2tEYnRXc0dwQmt3cmMw?=
 =?utf-8?B?cWg5R3VWY09Fd2hSRnkxcGxTOXZmbElYSG1ucS90MXRKVk16bTJseElpNTJ4?=
 =?utf-8?B?ZXNMeHhpNGdqZTVoZ1l3ZlhpQmZmaDljbUFHTFV3dmtxMlRIeWl0R0FSOCs1?=
 =?utf-8?B?V3VBTFp3ZndvdGo1UjFQUFI1c2pFb3pCalZKbXNBSkpJMUg4bUdvM0hIai9v?=
 =?utf-8?B?L0M2cHp1Rm1vV3BoOUczUmxINTZjMXFYK0VieGo4ZllqN0JGeHVVM0ZVMndl?=
 =?utf-8?B?ajgwRWRSWE4zeXY5WGh5eXNNNVlIaVpISlBOc3pvZExzRldKbHp4NnVwSHpi?=
 =?utf-8?B?TFpSeEw5YUhNN01SZXVYQmtIelIyaFA2czZTbXdXZGUrcThTWUx3WDV6alVN?=
 =?utf-8?B?L0ZQOEg1S2pEUFk3bnZ3SFZmWk1DNyt3bG1Ic243SHc5YmhTcGlKZ0JIdUJi?=
 =?utf-8?B?aGNJQ283ajE1RzlkU0t6UG5teFVyQ3QvcHVvdktYck9Uc21nZktMemdsSHhF?=
 =?utf-8?B?R3YvaGxIME0rRUtuUUg5ajVXbWZIUzVhRHhNMnFBWVppWFBwRVFWbzgzTldQ?=
 =?utf-8?B?dmxpWWY1SkdINm1vWk9mS3EvdGZtdzAzZ2hFMXZkWUlra3N0NSt0LzdFWThv?=
 =?utf-8?B?V2xYT2d2SnoyV1FZU3EyTjMrNDRyc2FqTVowL3o0N09qSGpmSk83Q01Tbm5s?=
 =?utf-8?B?ZkthSVdSeWhmNGd1eXE0L0Iyblp5L1laa2M3MUpkWTVEb2wweUxJSGhralh5?=
 =?utf-8?B?aEppZkMwUXN2bHV6UHlueEhDSzFXa1ZaTkF6bG1sS0lLVGRvVC9GQ1d2dnVo?=
 =?utf-8?B?cGlBRlFhVm9BYTlka20wcXBWaytjVE9WRjJtbkpMS0VubE5XRWNxanRJR090?=
 =?utf-8?B?RVF0WDVLUVRWSjJhdWhCT09IbWpvUjZOckxPTGtJZ3g5UEovVHpnNExXa2JS?=
 =?utf-8?B?eGtKakZOcU1KTHZKU0lDamdoa1EyeHJpYVdvWjVVU0JFaFpwZTFCVU9maWUx?=
 =?utf-8?B?WUIxNU5UYXU1VHlxYVNBUU9BMGVDc3VIQjJHcHNzdlN3UGhkb3d2K3hPQ3FG?=
 =?utf-8?B?RUhHNVVaK0pqaEJKWDJNV29tNmVPenJkMGFkZzk0ZFdDL2tKdWpGbElrbjh0?=
 =?utf-8?B?MTROV0d1aWFKWWV1cjJ4RjdZVXl5ZE5oaUhTTEc5V2JNb3dIOGdFUkd6TmhN?=
 =?utf-8?B?NGliWTJTU1k3bEtsclBpTGNsMDkxSjBua0RRZVV1ZW9STUVzVzVVNDJicmp0?=
 =?utf-8?B?THFEaEtnTGRzZ1ptQk1Gb1BDaFl6V3JvcHN4ZVA0dC92cjQ1ZlJmQk5aSVFE?=
 =?utf-8?Q?pWxzDkGbMrM9YunZKE2vXwJao?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a5391b-72e2-4dcd-ba49-08dbb51abff0
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4045.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 12:04:29.7819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8bmOGvsGzoLgr3hq8ZCg5Yw6iQ59wrpomwwUEvTK0TWVl7SIUy/3czjWjDg2XNX1MEQ0O48KeyV0Uuui62jh1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5515



在 2023/8/15 4:51, Jonathan Corbet 写道:
>>   /**
>>    * dump_tasks - dump current memory state of all system tasks
>>    * @oc: pointer to struct oom_control
>> @@ -484,8 +513,8 @@ static void dump_oom_summary(struct oom_control *oc, struct task_struct *victim)
>>   
>>   static void dump_header(struct oom_control *oc, struct task_struct *p)
>>   {
>> -	pr_warn("%s invoked oom-killer: gfp_mask=%#x(%pGg), order=%d, oom_score_adj=%hd\n",
>> -		current->comm, oc->gfp_mask, &oc->gfp_mask, oc->order,
>> +	pr_warn("%s invoked oom-killer: gfp_mask=%#x(%pGg), order=%d, policy_name=%s, oom_score_adj=%hd\n",
>> +		current->comm, oc->gfp_mask, &oc->gfp_mask, oc->order, oc->policy_name,
> ...and if the policy name is unterminated, this print will run off the
> end of the structure.
> 
> Am I missing something here?
Perhaps it is inaccurate to use policy name in this way. For example, 
some one use BPF_PROG(bpf_oom_evaluate_task, ...) but do not set the 
policy name through bpf_set_policy_name. In this way, the result is 
still policy name=default, which ultimately leads to error print in the 
dump_header.
I think a better way:

+static const char *const policy_select[] = {
+    "OOM_DEFAULT";
+    "BPF_ABORT",
+    "BPF_NEXT",
+    "BPF_SELECT",
+};

struct oom_control {

  	/* Used to print the constraint info. */
  	enum oom_constraint constraint;
+
+	/* Used to report the policy select. */
+	int policy_select;
  };

static int oom_evaluate_task(struct task_struct *task, void *arg)
{
...

+	switch (bpf_oom_evaluate_task(task, oc)) {
+	case BPF_EVAL_ABORT:
+              oc->policy_select = BPF_EVAL_ABORT;
+		goto abort; /* abort search process */
+	case BPF_EVAL_NEXT:
+              oc->policy_select = BPF_EVAL_NEXT;
+		goto next; /* ignore the task */
+	case BPF_EVAL_SELECT:
+             oc->policy_select = BPF_EVAL_SELECT;
+		goto select; /* select the task */
+	default:
+		break; /* No BPF policy */
+	}

  static void dump_header(struct oom_control *oc, struct task_struct *p)
  {
-	pr_warn("%s invoked oom-killer: gfp_mask=%#x(%pGg), order=%d, 
oom_score_adj=%hd\n",
-		current->comm, oc->gfp_mask, &oc->gfp_mask, oc->order,
+	pr_warn("%s invoked oom-killer: gfp_mask=%#x(%pGg), order=%d, 
policy_name=%s, oom_score_adj=%hd\n",
+		current->comm, oc->gfp_mask, &oc->gfp_mask, oc->order, 
policy_select[oc->policy_select],
  			current->signal->oom_score_adj);


And all definitions of oc should be added
struct oom_control oc = {
      .select = NO_BPF_POLICY,
}

Delete set_oom_policy_name, it makes no sense for users to set policy 
names. :-)

Thanks
Bixuan Cui






