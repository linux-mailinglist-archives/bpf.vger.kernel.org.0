Return-Path: <bpf+bounces-10002-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7E27A0346
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 14:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C194B20B07
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 12:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC5B219E2;
	Thu, 14 Sep 2023 12:03:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622C0208BC
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 12:03:10 +0000 (UTC)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2118.outbound.protection.outlook.com [40.107.117.118])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86AC71BF1;
	Thu, 14 Sep 2023 05:03:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P6vmIW9OEbQHFIBZEZQxDz/fT1Yg9mwvpKitoeTxC77qgZxjhkIgsoAMo9l36vtCiNBHRnBdNB05GH8EI+KYAqPATZWkVUfvb7gq3dtfaNlEvXiXMuVu7qHxJBxdEJ5f9TOZ+aw1HD9Yit4HXkVfjziLvlzb49HEV+G/FtsBQfmEOP9Y98M0KRUA5/v5ZOVRCAMh3xjpOccxrdbU/Asm1vDb/UqrMq3TFm8Sml3sD4/wCtsbSuVIFBaJFuRsmTjN8+8KBaXhhJBElAseyn4BQ59UbZdVDz+1atzdUx+V2/mS/CHveH2OReSriTg9yCVPwyT8MRsvk9/9xuSXc+/CRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5lMAjhk8bVmoXbhgFKyhUmq9tFlamqxz7Wev4qRObo=;
 b=hOzCrL8l+/v76qg+/nVCCFfXcCC+KlriuChSB5w+87rH/hg32Nvd49ReACQT/35BRH2loERb5pMyO3DeSYLneZCosLYDxRaOASD2WpZZuXUUYL3vw7hpfVYs62f0TRkVz+JOLvrjDZVR2bqaYbgij7bPHD0xu+87G3TDd06Z+fpciyNHsI5l607YYCdiBDObNJIpqYQWbSJvh/lo1FRMJC/rfOPdOhR+n41WYsPx/8Z0rJaBkFIeKGELLpzgvx1tccQag6ct9mtim9mRiuKHzstbO+UUTRCMBeu5sXtKy9k0vIYXwVRuQyvHLM9JB7CUyl6A5qaF+QEMTwSoUA8f5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5lMAjhk8bVmoXbhgFKyhUmq9tFlamqxz7Wev4qRObo=;
 b=ZnCH6hBjfsiZlcgJM1DL6nyJCX44FxNx+KIQuvcMR4PBwaT4Eeef9SZprfbXUzezX9xxphP6G7nQtufX2wNRev+keIqN0dPGQ7vkK2tu1xw+mWqTG4uUhjmgMnN9oUggv5/jnW1n289DhE1KXZP/lnsDwwFb+BeF9yM4WhyVKJU6ylunKfsrPkmhZj1Lk0zuL0TIN1xeVrikq1ps23s4q2Awbw5Jml4juUHXTGWdNQZoxGLA5jmWxnV5fG0YrBFVzKd6rA7Qr3ag5THpC7xoEf1D1YXTD+eOeBgTm2GCGQrzKe+Cy32EGgcdCc5VdTArEtj9v3NYOqLrBmr2XhUm4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4045.apcprd06.prod.outlook.com (2603:1096:400:21::8)
 by SEYPR06MB5515.apcprd06.prod.outlook.com (2603:1096:101:b2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 12:03:05 +0000
Received: from TYZPR06MB4045.apcprd06.prod.outlook.com
 ([fe80::1c25:781c:9638:960d]) by TYZPR06MB4045.apcprd06.prod.outlook.com
 ([fe80::1c25:781c:9638:960d%7]) with mapi id 15.20.6792.020; Thu, 14 Sep 2023
 12:03:05 +0000
Message-ID: <5343d12a-630c-4d54-91f1-7a7d08326840@vivo.com>
Date: Thu, 14 Sep 2023 20:02:59 +0800
User-Agent: Mozilla Thunderbird
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
From: Bixuan Cui <cuibixuan@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 82a7301b-d647-4e5d-06dd-08dbb51a8d74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	X83IEV1BFa9WVvmCcTYZcpfD7XeelDIQTUskzGmbqIyzfS1gVHDKxdY75RuxtGVdR7mrdY2dybWLu4WrXwg5FH7R6LGVeXJCgl3b/2WdPWYMYFMI0c35cI6Sr9Tg95TguQ2AjzseLMvUVFwsKCA9ZBvMV9N0Kw3pFTCobssDRwyxQlkvGjVZRmaKPgOzZKr9iA8zRICSzabpziCOhnPMQkMiVZ3PWDgOWAhaqWAEcJeGOAwDmJy2K11qqKSbOo3WOWl+v5ig2EXTWcPSH9AEaq/6rmMd9QsxonmupXYx+tQuWvt4KKfZ/1Q/o8iNdpeHj7Vog3WT8+egXnuiejz4i9kwYO2f2MQ5UHF/62Iy9vlLkT2jNSa2S19CoVP7sS9qeIsb5Zbv3FJ+HHYK5SCV41Prbd1/enzA00bp6lsYSD3wpBffwNw6sgayMcfchDYy2rMcHo/qfk89pF0rzNRWszrNBrc0zRINzKHxJOaA3/Am8Q5D1b9dh65fhwg5H7wJkAw3xwE9ALbdzz/RVd0ppCUXJrxmX46yhs+KQD+E8NBPHj+DSLHM/L29LDEDP+T1kNDfp3wxID++MaTdgmoAFDroTQtHLSADQUlifpGRLX9oe11d/LMSSTgEYOsLbD3fvYGbModTtkhpQCsxUTCxsNF8E/fAsaxb7jUv90u/nBpC4Ldaled8cxBMo74Gkklb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4045.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(366004)(39860400002)(376002)(186009)(1800799009)(451199024)(83380400001)(52116002)(6512007)(86362001)(38100700002)(110136005)(2616005)(38350700002)(6666004)(6486002)(31696002)(478600001)(6506007)(26005)(4326008)(8676002)(7416002)(36756003)(316002)(66556008)(41300700001)(5660300002)(66476007)(8936002)(66946007)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDNRb3J4TWV6NFpBcERScGlRRGgrcThYdFFmbTVKdk5zNklFQloybllSbGVR?=
 =?utf-8?B?bGMvMXJHeEE1ZFE5cHhYMm4rRjRxdCtITlFzZDFTUjFRR0txY2UyZHZRQmhL?=
 =?utf-8?B?VCtZZFJKSjRwdTF5YUhKT1Y0Smo3STg4UFpxTk05QWxTZFRjOTY4UlRRbjd0?=
 =?utf-8?B?UTN5SVpmbDVlM2RZWHFzVDZoeUpVWnAzVDFuU0xvMktKVFl1ak1zTlVWYjB2?=
 =?utf-8?B?THlDSmI2UFNWRGJjWFVOTWRzWXN4OTUwN01XVWEvOHk5clpha2JERVE3YmRD?=
 =?utf-8?B?eGhXQXdZK1dtZ1VRMHB3TUo3OEpXczIzc2hXdkRiREViMFZHR09DcEVWQVNE?=
 =?utf-8?B?a3RycUd4QUhGM2VOblhtK1RPQ2prWG1JQkRoSFJkNlY1VTVydmJIUjg5OUFP?=
 =?utf-8?B?SzRkQWY1ZG9jUDNxVzFWUVZMNnJQWjlkQTJmcjA3ZXVlY2J0WUp4dG5Fbldu?=
 =?utf-8?B?MXZtdjIzS0VXN0s5L25mWlZEKzZzeW9KYlh1WWRrbnhMVXdrRTIzOURhazJO?=
 =?utf-8?B?MTJuNnNOc2NnbVpQem15ZDhSMlVFcW9jMmVKcWJNMkNtRzRtUkdsSlordEpx?=
 =?utf-8?B?Zk43Y1ZXUkpDNkdHQU5YRXpRSWdyanpRbUhRVEtKQXN0Ny8wYVBMLzFGajlw?=
 =?utf-8?B?V1pqeklGRFBvdE0veVBxOGMzTzIxMEtpdnZmNmRFUEJlaE9KRkFLNytEWTR4?=
 =?utf-8?B?TC8vUXJWUHFTMFZ4bTQweXAvc2pQMlFFZ0VUVzk5Uk9HYWNqNkJxdXFUUmFX?=
 =?utf-8?B?dm9hNzZwMlJGOXM4ZCtzcWdqd1RFVEJ2U2YyMzF2eDdEaDAvNVRGSm96WlZK?=
 =?utf-8?B?M1J4N3B3WS94VEx1ZkdKQkFzMmp4TU1kckIyZkpYODlRUFluQys3bzFsVTVi?=
 =?utf-8?B?eE1UZGhEcmtBUERnUjF0S1hIb0I4T0dhQ29Ra2NHK3lxeDVQMFJKRklGTDFH?=
 =?utf-8?B?dTViWnkvaGxYaE16Q2xIczZZOS9iTnVVYUhxQXBaazBudS9odUJIamp5M28y?=
 =?utf-8?B?QkVVWDNpMTBNdTVlWitxVWwvYVFSblFwK3Vtdmd6NTNLbGlvdFhaUVBtdC9x?=
 =?utf-8?B?dm83MkVFdVVsU0pTZmcrQnNGNVpaQ0JGcVFMcW9WeTFsZWxhWnFjdDh0TzlC?=
 =?utf-8?B?STJDMWVYVkhvWkRQdzRVRTJxdUFPRnZjeE1vdGMyWDFaMDlTUGtCTnFFbU40?=
 =?utf-8?B?UG10WUlocWxqaWdMRGdkOE5Vam9hNW5jc0xXcEZjcHk3Z2ZyS25yS0trTVdY?=
 =?utf-8?B?c2tNV0tGb0pReVJ5bWorS0dJNG1vVTAySDROdi9yMlBSejVVY3M4UkZOQW1k?=
 =?utf-8?B?c2x5Rmh1eG5XYjFUYUFQNmNoa2Q5bUl5V09NR0FCRGcwN1pNZXNRSmczdDRI?=
 =?utf-8?B?RlRjYldEOHo5dXpVcmpaTEFQVVhPYitTbGlxcy9zL1dkTXN5RFdZKzV4U3hU?=
 =?utf-8?B?bXBpTkFKRG9Wb2k0Q3ZmemlLaTJLSHp6SWIxUTlXZFBYb3FYSU1abmZkTndM?=
 =?utf-8?B?WWQ1YWJOMDYyc2l6UkFnSEZXcmVLcDRGSGZFWEdiMEtPbldWZ0V5LzJrTXhv?=
 =?utf-8?B?cEJyMmZYbmZ3MjJQWXpRRGlyK0Rrd0gwTElXMk9UazNKZWRpT3Q1VjZMNDNv?=
 =?utf-8?B?M1JQdUtncDJQcW4zZzFHZjh0Szh4cHhmZTIzaklDTHI3Q2ZTbHpNb21NcHd4?=
 =?utf-8?B?Q0x0aklxb3gwc29XUHNYeFRJdkpNYjN0WW15cGc2NnJUUlVVdDJJL2RWanJs?=
 =?utf-8?B?ZENvQUQ0SVE0cUFjditYc01HSXpwWXFZZUVYZk1vd0tEWUI5VkdnNzA3L0FU?=
 =?utf-8?B?MzVVbGZGd1E2LzJ4dUpORmx0TnF3Zm9WdUVjZExFNW9lT3hpK1FRSTB6cnVm?=
 =?utf-8?B?em51UGx3YWJpdHo4VjRZTTZKWEE0d0Q2bm9LMzcraE5USjZSMWNGTkxmcUFk?=
 =?utf-8?B?UEpxQTRCcHF3NXQ2TWhZNTFiSE9rclhlOWtmUHlkMzU5QWZENzNtQ3NzS3Yr?=
 =?utf-8?B?RTdJQk5yR3VxYTVYNVFPanMvcHl5V1J3RzlYK0sxYVBReHBYd3M0RUJKdXRy?=
 =?utf-8?B?eEpnUngxUEVxMkVMNUIyN05ja1ZIRE5NcFZBTzV3RjlTSnJTK1lBVE0wbnVC?=
 =?utf-8?Q?HxGo03C8ShlkQRDcGq6PZwqVp?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a7301b-d647-4e5d-06dd-08dbb51a8d74
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4045.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 12:03:05.1465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vLFXKE5bwYgb6Cmn/mTF0P38L23ncpiD0XTXdqHS9EINSi7eYCAySw4U6HqO6e0lbClSk5KOhhIubZ9xG8PIZQ==
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






