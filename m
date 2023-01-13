Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C36668EB8
	for <lists+bpf@lfdr.de>; Fri, 13 Jan 2023 08:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241097AbjAMHAv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Jan 2023 02:00:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241134AbjAMG7m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Jan 2023 01:59:42 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA4510C1;
        Thu, 12 Jan 2023 22:46:21 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30D0ImDl014126;
        Thu, 12 Jan 2023 22:46:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=tBEwUOHoIoZ5c5Y/gCoSyEdnRLe61fEgQKcXdoejNlA=;
 b=gLR21cbzgpEwsMEyIL0AvR6tWUmOjsFHxCpKVvxVmPkxmOKnRkdOK48KqpD685qPDjOr
 dSPDekoZfmag7GFgFEC1LdUlt9XanL2vTEwJImBfdGA7Vd0lo0xzPUpIoEzmh+VmiSjF
 I82a50la4KFxl6GSYlznQ1msfNqihdCko1qfAUB3q7wo9GTyo3CaDWx2v6i3YlQHi6OZ
 Wlb/e7YVmd4UfFTDi/WVQz7g8uaIIpPHzYtRSRVlXrynGQ3jAsZKjf6qUw1LYW7pyz2T
 tKQl8HXwfRZBuVkPnUOv6f8LdZ1b3ygiK/Kiy5iwbJv733uC7A7DFQzbYJ4yHOG9v/UX RA== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n2d1jedm0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 22:46:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HY8jWJaVVRO33KSD1RxByj1kf8PhL6Dh3O48nULuDR47/NfTHRCJvIbiMzEk0AfC8RC5hNwWVUXFQyisIjbzh1e0GSrSIALyui8kwWojOhEgUlXyyy8iNaALmkQmzTG0LVcU8KXwMDqeqSI6bjslZDehvVyuF9e4UgXTwdSoncDP+IiySKcD3RDsqnjGKqSY/mSf0wrnYRjpC/fVa8nN+6rrN7LBRmI97G5rvCdKQs+Ov5JPg29jZm7Wigh14cx31zpXbEg8D7Emt9DCEP6rN8XxayDJVc9lsNhD9fp+ikr6ksmfRHt60nrV02MeSB9V3U/7pZjrRiBR/ZTyAlo6tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UD8996HnOnr7IGnPpmNqDogY8Oy+rNk9lfWYqcjHS0s=;
 b=RmaqaDu4Tb/XYaBG49ub3lWhM0QiuQ/6AzMi6RHbpW4BapLfSItb9lLTsEU2Zuv9tFyA7+S0hZynAOAOIQfCfkJ+pU1J3nnDxR1TFXBp5RuKVynbT6ltBSfHG3pfxeFQs2BXvml8t0bKej1gW0v1EsUh+C5L1FDJ2NgjB9hNRDc7YKwEdclxKd/0cd0ulbbhvjp5OBiPfUXMqx071PYV0WWuy/JPdhLmz9DCp9ndoUZ/bQ4oUUIaiOUdwJqq+GfpV5YLSrTeUVX0B6WJA9w6+u21pxxkCjHpoqUKf2AhjtpNI2GOS2L2Q0bmblXiWuW63suGQmqPDRj0Y/IFfYSX4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MN0PR15MB5348.namprd15.prod.outlook.com (2603:10b6:208:373::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Fri, 13 Jan
 2023 06:45:59 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5986.018; Fri, 13 Jan 2023
 06:45:59 +0000
Message-ID: <be494ee3-864d-1a33-e14d-d27712ab6248@meta.com>
Date:   Thu, 12 Jan 2023 22:45:55 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: WARNING in debug_mutex_unlock
To:     Hao Sun <sunhao.th@gmail.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, davem@davemloft.net, linux-kernel@vger.kernel.org
References: <20230109074425.12556-1-sunhao.th@gmail.com>
Content-Language: en-US
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20230109074425.12556-1-sunhao.th@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BY3PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::16) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MN0PR15MB5348:EE_
X-MS-Office365-Filtering-Correlation-Id: 08a55ac5-cdec-439b-54ea-08daf531d428
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lw4k0Joi+CYlMXOqMXPwh2m7yIww5bozXOq4r1GfgDoHSJB/UtBRfh2yoKnU+q0l1d69oKiBgHjdaI7NSb96XrjlAOdw4/cJgaKNEyk86//G8/K+SZa6Uy29ISlR9TQt63tI53YtkGTSYmHpokasYmNHgBLA7/LTud6XI4Aax3PgXAu+GR+BSL3kXT6plvwnA9zLne5QhFWTU1GPmCEu0g6ZM3mmNcySmxNcCG54wBmMcbjf/ygPfQnokw853kylWf1rke2bd89a+U4ltPV4/fSwN3byp1aZs3BL1tM08ilKf2gW4BNqEzrf9tal0S0xoSHVTph9XzelU/a86N945yV5yiMVMO9btjvEMZ4ab8vl0EW0cOqyWa65bof5v1GTBfvKlJ410exjA4Ma8bkm3mGtk9CodjeElTEr8Bs9CklQxhFdIh4qEEy+UKTv1HoiumXqcoZJwHFgpOxaCZBV0BM8enEsRN8dJhOIgpiK8QVgEaeIQTbJS91BCxuSNEUeGmX/2Wq+oNvZmsrPuNA7HmB3vmc47JJQJX+zBGcQPLfT4TzHfrjwm12EXtpZQ0gvhRHWadDuidUxUJqGVAg4M/owEjueKqbKztlBxR/FpAuVyNP0+bp1YQimGSvClYrlArAIhrAMjDUGwahYE/Zyaq2Zju6LX3rz25afrNY/e9Bq3QKZxplOuQplFs3PoTAjeAhRSQDUzMKUZXZO7UscjbFM3dcyqxg1rBT8I0itAZwfmJo+ydl19afi8GhpfpNMaTH+gjBjDKH4hpi3heaPwI/Uloq6UcSVgMGgZoObaSQ2jk1ddmC2Ht68eatMru3dlOklfflT1AKf3CKDMULx1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(39860400002)(366004)(376002)(451199015)(6506007)(7416002)(45954011)(6666004)(2906002)(36756003)(5660300002)(53546011)(83380400001)(8936002)(31686004)(4326008)(8676002)(38100700002)(6512007)(478600001)(966005)(41300700001)(45080400002)(6486002)(7116003)(66556008)(66946007)(66476007)(186003)(31696002)(86362001)(2616005)(316002)(10126625003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEhOd1dHQy9QT3lTbjBIZkhIQ0wrd0FCSS9oZmh5eXViVVFacHUvVmJGWWRO?=
 =?utf-8?B?NGY1VTl3Vm1qUTZrR2xaRG05TXByRmc1MVorSzZHbG5peHBOWFUwN1FDMk9I?=
 =?utf-8?B?WjV3bXhtV3luYStwd1RXWkk4c2hobUM1a3NMb0xJVm1pY3VXSEpPWmFNdFoy?=
 =?utf-8?B?TURja290YzYzUmpFV0RDQmMrSlJXUXNDVHNES3YyYUEyM0tEV01LeURKcGF0?=
 =?utf-8?B?SmtqOTVjTDN1UnBWNzBPYlNTQXQ0V2NzNWpBTE1ROFQ1RExXakNQYS94M1Ix?=
 =?utf-8?B?VlZwVWE0dzQwNXRsbmY1MUUySEVRV0N0M1VOV0doaGczZ01mblJpRlNNUGNj?=
 =?utf-8?B?OXZndVl0VFVLZm96dlQ3UWQ2UzZRa1QwdS96OXZHYk0xMWp3YUNaN2ZMWldD?=
 =?utf-8?B?M0piU3gyUURMUXNZb2creWNxTXhBUnV4WURIMjlIOTZ4SWU0V0FXSU10UVlh?=
 =?utf-8?B?OHN2UXdwR0JKZERKY0lrQUplT3RhRkE0dG9oL1REeStiUkZsSzRyR28xRWZm?=
 =?utf-8?B?V3NQSjJxRzJUcmxHR0JTVTVuOVl1UWJ1azh5VlhyUndHWlJTaWlRZ0g3QUgz?=
 =?utf-8?B?a1FRZHMveFZ5UHkxbk9uNXdha3MraDV4Z2xNbngwL0MxWGVISGlFb0h3aG11?=
 =?utf-8?B?bVlMczZrYXhjVk9xbHVPbTRqMjcwWVl3REhoRnhRNnJSQk44aVg4c3h6bnZt?=
 =?utf-8?B?Z0FZcTNka3JwRzFENzk5ZTBFSHljRTJja2RTc0dQMkVMZlNTT0R5ek1VZFdW?=
 =?utf-8?B?RWNXcDhsck95MGR3K0VLSTN5bjRRU2gzMXo4SWpJU1d5LzdTaE9kNUUrVkF0?=
 =?utf-8?B?bTRaOS9FTC9NYVoyK3ExSUo4emZxTUd6b0tudm1kK1hSdWZ0RGUrZlp0Q1BD?=
 =?utf-8?B?aGd2aFUySzd4bjZmZWtDSG8ybVNCMitFMTFPUCtDNUpvejYxTkY2cHBhZFpa?=
 =?utf-8?B?ZzV6L09mVHUwUkp0NzJJZnd2QVBOaVY4SjZBVWppVUx2cDBPeWdMMXVaN2JP?=
 =?utf-8?B?NVpCblk2cDByZG00R21tMVNMVXluVFRlREdLRm9NNm12RGhnZzRJc2FxVGt2?=
 =?utf-8?B?d2w3Z3NQZUtaU3BMRHZXZE50bkNQYzZ5ejhHMGI5eUpJODkwZDhvYWJocldQ?=
 =?utf-8?B?T01zcGdaTmppT3hRWDJqZkhBRjR0cHhOOVMxNXVUZi9QalRoY2tmZmZlRlNQ?=
 =?utf-8?B?Tk9YSkVmTXZNQjduOTR0Um5VZlhwKzZaYzBKOWVVTkNybFBFL1h5MVl1cWpy?=
 =?utf-8?B?R2lmUFp5b2V3cnVFekZLQ1RTeEJwSis4dzc3d0tLVExFSmZaaytNRmxyYW9F?=
 =?utf-8?B?T1Y4dlFCUUNQZmZTTVBieklIVUVkclBBNVZGWmVFZnhtVGQwdm5LelMyNmxl?=
 =?utf-8?B?U3k5dkUzSmd1VEtNeFBoemkwemdaQ0Y5UEdFOXNFOGVhTHVQMmhwSC9rSmJa?=
 =?utf-8?B?aWY3dWtITkgxNXhtUXQ1V3krTWxaR3prTDhBVGtTS0ovQ3ZXVmR5NElMNGRI?=
 =?utf-8?B?Ry9tc3BGS01paEtvMnVHUDB1bW53cUtxaXVFTzFOWnFHQk9UUnNQSHE1VjZu?=
 =?utf-8?B?cTU0WjZmL0ZONVB1eWxMV2V0elhGQ0dZMys1eGx4emgrd3BqWFhTL1JIQm5X?=
 =?utf-8?B?a2Q4RTY0Wm9LUnA4MWxQTW1pdWhSZEQ2cEdjWkZ3MlNkV1AwS1dUeTZCb1JX?=
 =?utf-8?B?ZmJES2x1TGNjS0R6Q051bFU2ZnZkVXEzS2g0cmo3c1lKNjhYRnBaVk5jR3lK?=
 =?utf-8?B?bHk3OXl2akd4SUpnRGNvWmdpU2VCaUxwaGQ4bWIwWXd3N2lHajFNanZ6WFNi?=
 =?utf-8?B?ekVFdWI3b1JTckxhdmUrc0Qzc1dKKzJoSkhZS0VETUQzNHpwNjhpZ2EzUWRy?=
 =?utf-8?B?Zy9FMWFDTnRRck4xeHBwSE54Vkk0SHZKUTlTWWNxbU5QL3JGQ3orUGNMZDJl?=
 =?utf-8?B?djVjbVRFb1lnanhpWGpOcHpva29XVDI5VStHRmkzVDFSZ080cEkrbWNoSVlu?=
 =?utf-8?B?RDhjYzFPY25qcytKejdSeG5uTmcrem1rWFRpL2tESy9pMVpORmQyKy82NW93?=
 =?utf-8?B?Nk85VEprTGZtY3pXV2JBYjBKWXRFakl5ZytoeDN4Rzc0UklIazZBbGpRYjV5?=
 =?utf-8?B?YXZycUdwYWs0SThoR1hoVlhEZWwxbERQMGNDTzR5dHkxaXZ5OTE2OTAyaExG?=
 =?utf-8?B?T2c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a55ac5-cdec-439b-54ea-08daf531d428
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 06:45:58.9993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ph4zbZZ732wfxE7vd7U7VhgtLILCIBzpX88KLT63TchMXi74oi+k18ldxtGGx4gu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR15MB5348
X-Proofpoint-ORIG-GUID: FHuLB2TBI9gqlw-f2al_40lzdpkPwiSB
X-Proofpoint-GUID: FHuLB2TBI9gqlw-f2al_40lzdpkPwiSB
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 3 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-13_02,2023-01-12_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/8/23 11:44 PM, Hao Sun wrote:
> Hi,
> 
> The following warning can be triggered with the C reproducer in
> the link. The repro starts 32 threads, each attaches a tracepoint
> into `ext4_mark_inode_dirty`. The prog loads the following insns
> that simply sends signal to current proc, and then wait.
> 
> Seems issues in queued irq_work with `do_bpf_send_signal`, also
> I'm wondering what if the task in `send_signal_irq_work` exited,
> at the time the callback invoked.

Somehow, I cannot reproduce the issue in my qemu environment
with below kernel config and C reproducer.

But could you try the following patch to see whether it
fixed the issue in your environment?

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 23ce498bca97..1b26d51caf31 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -831,6 +831,7 @@ static void do_bpf_send_signal(struct irq_work *entry)

         work = container_of(entry, struct send_signal_irq_work, irq_work);
         group_send_sig_info(work->sig, SEND_SIG_PRIV, work->task, 
work->type);
+       put_task_struct(work->task);
  }

  static int bpf_send_signal_common(u32 sig, enum pid_type type)
@@ -862,7 +863,7 @@ static int bpf_send_signal_common(u32 sig, enum 
pid_type type)
                  * to the irq_work. The current task may change when queued
                  * irq works get executed.
                  */
-               work->task = current;
+               work->task = get_task_struct(current);
                 work->sig = sig;
                 work->type = type;
                 irq_work_queue(&work->irq_work);

> 
> This can be reproduced on:
> 
> HEAD commit:    6d0c4b11e743 ("libbpf: Poison strlcpy()")
> git tree:       bpf-next
> console output: https://pastebin.com/raw/ZtVM15Jx
> kernel config : https://pastebin.com/raw/nt6XW0Sz
> C reproducer  : https://pastebin.com/raw/NHqy5tR6
> 
> func#0 @0
> 0: R1=ctx(off=0,imm=0) R10=fp0
> 0: (18) r0 = 0x0                      ; R0_w=0
> 2: (18) r6 = 0x0                      ; R6_w=0
> 4: (18) r7 = 0x0                      ; R7_w=0
> 6: (18) r8 = 0x0                      ; R8_w=0
> 8: (18) r9 = 0x0                      ; R9_w=0
> 10: (18) r1 = 0x700000007             ; R1_w=30064771079
> 12: (85) call bpf_send_signal#109     ; R0_w=scalar()
> 13: (95) exit
> processed 8 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
> 
> ------------[ cut here ]------------
> DEBUG_LOCKS_WARN_ON(lock->magic != lock)
> WARNING: CPU: 3 PID: 41309 at kernel/locking/mutex-debug.c:74 debug_mutex_unlock+0x1fc/0x250 kernel/locking/mutex-debug.c:74
> Modules linked in:
> CPU: 3 PID: 41309 Comm: systemd-udevd Not tainted 6.2.0-rc2-00302-g6d0c4b11e743 #153
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> RIP: 0010:debug_mutex_unlock+0x1fc/0x250 kernel/locking/mutex-debug.c:74
> Code: 84 c0 75 59 8b 15 34 92 3a 11 85 d2 0f 84 c5 fe ff ff e9 e6 fe ff ff 48 c7 c6 a0 50 4c 8a 48 c7 c7 a0 4e 4c 8a e8 9e bb 5f 08 <0f> 0b eb b2 e8 bb 9d 6e 00 e9 be fe ff ff e8 b1 9d 6e 00 e9 8b fe
> RSP: 0018:ffffc90012b7f6f8 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: ffff88804145a2d0 RCX: 0000000000000000
> RDX: ffff88803f468000 RSI: ffffffff81671400 RDI: fffff5200256fed1
> RBP: ffffffff929e2a00 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000080000001 R11: ffffffff90d3f0c3 R12: ffff88804145a2d8
> R13: fffffbfff253c540 R14: ffffffff929e2a00 R15: ffffc90012b7f798
> FS:  00007f36a937e8c0(0000) GS:ffff888135c80000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000056181882c020 CR3: 000000002a9a2000 CR4: 0000000000750ee0
> PKRU: 55555554
> Call Trace:
>   <TASK>
>   __mutex_unlock_slowpath+0x197/0x630 kernel/locking/mutex.c:933
>   devlink_compat_running_version+0x128/0x6c0 net/devlink/leftover.c:12237
>   dev_ethtool+0x55f/0x53c0 net/ethtool/ioctl.c:3091
>   dev_ioctl+0x29e/0x1050 net/core/dev_ioctl.c:524
>   sock_do_ioctl+0x1be/0x250 net/socket.c:1183
>   sock_ioctl+0x205/0x6a0 net/socket.c:1286
>   vfs_ioctl fs/ioctl.c:51 [inline]
>   __do_sys_ioctl fs/ioctl.c:870 [inline]
>   __se_sys_ioctl fs/ioctl.c:856 [inline]
>   __x64_sys_ioctl+0x189/0x210 fs/ioctl.c:856
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f36a94a55f7
> Code: 00 00 00 48 8b 05 99 c8 0d 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 69 c8 0d 00 f7 d8 64 89 01 48
> RSP: 002b:00007ffd663b3d98 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00005618188043f0 RCX: 00007f36a94a55f7
> RDX: 00007ffd663b3e60 RSI: 0000000000008946 RDI: 0000000000000006
> RBP: 00007ffd663b3e90 R08: 0000561818887fa0 R09: 0000000000000000
> R10: 00007f36a937e6c0 R11: 0000000000000246 R12: 0000561818887fa0
> R13: 0000561818832c70 R14: 00007ffd663b3e60 R15: 0000000000000007
>   </TASK>
> 
