Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40CB952A98E
	for <lists+bpf@lfdr.de>; Tue, 17 May 2022 19:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243328AbiEQRr3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 May 2022 13:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbiEQRr1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 May 2022 13:47:27 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979974EDD4
        for <bpf@vger.kernel.org>; Tue, 17 May 2022 10:47:23 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 24HHJi4g008743;
        Tue, 17 May 2022 10:47:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=55sBmCWvkR7EfgJAzZSt3vqYXsooxAGLwQtpkQsWNDY=;
 b=LpOyJKcxL00N0ISB8SeoK5M/vaIO3dWDd7Ncfqqd4w2nLvwqGTPuG0JTkZYBhJ9JAZRw
 F9nBw0q4f+Uo5NrucX0EAHAiaVIXxX4y3jzOUR2eZqlvSO0WJgd9euil+VYnOT4lyYpq
 qKznMGxKWxvYho/3fnWwUXPXlzaWHJSusfc= 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by m0089730.ppops.net (PPS) with ESMTPS id 3g4836km4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 10:47:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bg5SisyPlFF8bKOxki9v0nqLunvPZKmzaT3YQiCuxxCzEt1sol8cYd1i1enwvA7x8T8g4YxkPI9aK9JBrBSDhAvBHCv3wJgtjU8B4a2Ty0ZbXMNkkvjSqLNNlNrd5FwNiqu9oYq5vjH4apx5bIeTIMz+ZUQK3Ej8IWqsQVdUO6GgqUQ+93545JHX6bwQyJO5ime+3cFtVlvbx7rffUpNiNtnj2RtZ7jMVpmw43iWDPQ0I10+vOSSNaIDB/d8xQy9U4egVTm7iiR3XTvklaPYeITyCOW2xv/x64t3v5r7YcGzhNlQvwMlfkkryHSQCX3N60zWHJ71AKjvVOkU1PgPdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55sBmCWvkR7EfgJAzZSt3vqYXsooxAGLwQtpkQsWNDY=;
 b=FcpTtflUpIPsvqWNw22f/uIF1VGXJg2/wHT4VJV7eGPA23ZP5wYmx4QVr11jiZmhVqTcTDfZJ3EXAC3Sa47L/NpLuQk0/x+2/+1RgMeT87n8qBfgBAF5HLLFS7733ej0cst38SMJ/Ft+UatFjVbHn4n/+udeEQJ3nuJrgn7JxXF28wVghyeXaZF2xEzua1BX5wSe+/AMgkpzdB/ieHCqvQAvM6exMMEP9/4PCdMqphsm0vvBAt8MK+MKiueUBx/yIIjPBDy6OOuWTUFY6SjqIVK3E4lOAr4PWF+5gPgumn6+OuB4laU0uuEI4VIowRzXOfMi1yLV8/Fe6ZigE5wa5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM5PR15MB1932.namprd15.prod.outlook.com (2603:10b6:4:55::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.18; Tue, 17 May 2022 17:47:05 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53%7]) with mapi id 15.20.5273.013; Tue, 17 May 2022
 17:47:05 +0000
Message-ID: <9acb7673-8a7c-d9e9-efd3-f31148b47c7b@fb.com>
Date:   Tue, 17 May 2022 10:47:02 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: refine
 kernel.unpriviliged_bpf_disabled behaviour
Content-Language: en-US
To:     Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, keescook@chromium.org, bpf@vger.kernel.org
References: <1652788780-25520-1-git-send-email-alan.maguire@oracle.com>
 <1652788780-25520-2-git-send-email-alan.maguire@oracle.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <1652788780-25520-2-git-send-email-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0224.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::19) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2128b54d-524f-496a-dbd3-08da382d417f
X-MS-TrafficTypeDiagnostic: DM5PR15MB1932:EE_
X-Microsoft-Antispam-PRVS: <DM5PR15MB19322F8A4F0716B2554429EFD3CE9@DM5PR15MB1932.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mrBipv8XRCvmIhUvfG8MzAdubV/mq4AxBMNOIT/fdaXh6rRoLIzlQRySbn6THkaoD7V0qlOOpkj+ScAkKql7t2qFWosOSFqulE5UyC5qIdH9VkkGWigWds63G29ECLsNPlBLeb3tpbw06KC9AhTiJU18c48NYMidiu3cv2c91zo/eEJzjv9seQ/Pa/NJkvPUnwRHsabNqapvfPpz8dP5/7h+I5LHge7TpMNVmvIT4t9MqseCgVRJqYdh40xWrXQwYc3n7rr9KvQfrIam5qU2xt40LtU7ejNo4OiNFmRxaOQ+DVtpi0n5pJVk4+valy0b0hLCKhKkkKSXluY0SZGpw+ebULizGRffbhCJOAwUTG5EOqUWN4sDn/47U6uFfS/Fd6yraRN5GapzXzc5XNpw101cI193vrProkkfd0E+0xoc6AZwfaFES4TiSbcz2bJf0KcmX89QtLsp+L8OiijVL3lINiY+YkPob6qcEwe8+B7omiJ8LMw9Nnd4n21gukCbpEv5Bydzn4pTKUEOu/u05h/I//Fhotf7rkwgyrD9nyzE35kXIHaCZqiabOeb20Q48wHkPqUaR4Gf6uNldh3ce+99oLHKpCIe/a0XOuohHo0EYtxns0XXzlQuRYmx4SK1beLxD72g8DDv1dlDuF9oXlpUxdXER+zeYZNqyr9+cRRBDV3P/BhfN4j5BNPINZlktK/B6dejNAm9IBu2Rf6faqwbEncMVtTVj5xN274xMRpd+QZC4VV+2Enohu2XQrNM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(5660300002)(6506007)(31696002)(83380400001)(6512007)(6666004)(53546011)(52116002)(316002)(508600001)(8936002)(6486002)(66476007)(66946007)(66556008)(2616005)(38100700002)(8676002)(186003)(4326008)(36756003)(31686004)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUFlRDRnUlUyRElQMkIxYXFBMFp6ME1panVsZXZWajhNL2paSmVJM0NHdmtR?=
 =?utf-8?B?cmRkdHA5b25xRU5IR0J4aDAzS0NDUE1MUFRXdjR6MWVFOGF5OHppK1N2N1Rz?=
 =?utf-8?B?ZCtZSFlwSGZBVGhBRGRzK0xXNFF2bTF6U245SGVSYWRrbkVaRVBnQ2dVYmdx?=
 =?utf-8?B?L3UzQWhKeVhpb2xkREZtV0hMY2w1YmdRV0xiWlVNNmc3LzhiUEtXb1hMK2ZN?=
 =?utf-8?B?RHcwbEwvbHBhdnA0enc1OUY4bE9zNk1VWkZ6L2pTR2hNbXNqTXpqRkNDNnJC?=
 =?utf-8?B?U2VhQjZROTIyUFdXOVRHR1U1ZHNRaGpWWFpXUjlBTnZhQkh1K0poVjd5M09R?=
 =?utf-8?B?ckxZNkxUY004MTE2ay9RcFd5NE1kdlFQZThtRVlPZHZXQThQM3hYYlVXK3FY?=
 =?utf-8?B?VkV3K29iSFFXKyt0OUszZVpXb2I4TFgxUE1KN0ozemtDQnZIcGZwKy9maTF1?=
 =?utf-8?B?dFJwY2tLelhsc3IyNndyM2Y1RVhNQWFwV0R3Q25EY09aVWhBWDE4eGU3UHJh?=
 =?utf-8?B?WHpWZUpHQWRoUG1tbFRRbnN4dCtYWkNGRTc1emluQXJqaE05ZXRGWG5YR1Jj?=
 =?utf-8?B?Q3lBMnBhUTRaWGljS3ZrbGlURENpR0tra1BBZnE1RXU3VHVMTDVmK2J2cW5w?=
 =?utf-8?B?bG5EVk5XYnBRM0M4d0tWQ1ErSzZibytjNWZOMEgzVzB4ZXptc1lKb0hxc09r?=
 =?utf-8?B?NHhTVFd5b2hIKzJMRkRFRjhVL0g2aGFQd3dlQ1ZzUE1VZlpiMlplSEVCNDQ0?=
 =?utf-8?B?SjBZZzRzeFd3bEZzb1hQOWdnNGEraU44WnNuRXBWblkvRUl2ZmFIbmxOWUFt?=
 =?utf-8?B?QTBCaXd4MUFBRDFwdTlKdEhuYWZ1czJpWjkwd2d4bmlOdVovZE5jK1FpOFZR?=
 =?utf-8?B?ZVRXSmJJN0VyZ2JDVVhibi85TURaZnZRNE1NWElTdFFWV3JSV3p0UHpsN1BE?=
 =?utf-8?B?MDk2SDJEeWhvS0dha1krd09EbzdwbGV5Uk05RU1rNXo5OWhqUzdVZzlDS0U1?=
 =?utf-8?B?dDFaRVc1TEJYTFNvcWxVMmRSS0N1YW5naVVFQVdoWjBiWXE0N2NrbFlWL3lB?=
 =?utf-8?B?TU9GYThmN1lDOGlZeUFJREVMTE9nOXh0cS9xUWFINytGZEZXQ0tvZ2hoZU9r?=
 =?utf-8?B?cW8vS1p6bGo3dE5sVkR5YjdkMDdaS0g4cXg3UXJiT1FTaStOOWRlcEorazlq?=
 =?utf-8?B?SG5PT2ZVc0NYRUFJSXpGM053ZENESW5sNmtxZGlEMlZ4QTRGL293SDh0ZG5B?=
 =?utf-8?B?ekxOYTZIRVplYnZwSkp2aXFFZjg0eTcyZE40MUsyNXZ1S2ZpcDlINFROazVQ?=
 =?utf-8?B?Q0Y2cW5yZWZoRHRnalVJdW5VbEJhRFlsYkVyd05Vdlozb05aT2k0NEJyVktI?=
 =?utf-8?B?OWMzcXgzdlRoYVNsaE1OZ1U2QjVZbUVXOG03MDhLU2NJZ1VyRjN6S1NJamd4?=
 =?utf-8?B?UXBzbmNOYzh1b0p5TEQ1YkRDZVVjN0hmRGViaEtQTDJTYzQ0VUNQMkJ5cUVs?=
 =?utf-8?B?cStaTm1ReXFOakczTkdRb25iWVJiOEU4djVPanJtVmM1ZERzN1lBK3Y5Z0k4?=
 =?utf-8?B?WThpcFpPRmM0eitIRzZuSEF4TGZwZFkyeGxpNURQaFluTHpDUzJLR2xtRWM3?=
 =?utf-8?B?Q2JSS3Y2Q21udEVYRGpJYSt0dVBSeEV5VTBOeUdJdjhxdUJJTlZSRzRneHlM?=
 =?utf-8?B?TGtXOWw2NjY5RzdreGhnWmlUdUdZS0VVc3AvcFdmQWtIYkNyelkrSXlUZE8w?=
 =?utf-8?B?WXZWcDM5Q3RmYlQ1YzhuYmhRd2lZQWhiNWdQMGJCYnlOS2VSTFpNQlIwYlpI?=
 =?utf-8?B?dEhCQlVRVGxzN3FKT3pEWmNnT1BFK2t5bEtzWVNIblUrWUMvU09CbVA5dlFC?=
 =?utf-8?B?Z2NlOTV3eDBET2lucmNwTFQ1NlRUeFIzUkcybSthbWhLNGd3VlhZczdEVDNP?=
 =?utf-8?B?bUxERVI5d2pNWHNVcDJ0TWYrTEk2WEd0dE5pOWdJT1BjRjl0cHN0bUdMOGpt?=
 =?utf-8?B?RFFyV3pDWkNJaUlqMlJLaWtFcDd4SGV3RFhVV1J2bElsMlliNFd1Y1ZDWWhi?=
 =?utf-8?B?Vnl2R3g1a0RJOEFEMHNWcU5weHZpVG1HOWl1TTdDTzYzRFlHdFJTbGJlR0FB?=
 =?utf-8?B?RUNUc1lhdzNWNVhURjBPNmJNT2YrY3g3dE9xK20vM0VFOGszSWdFdlNvcnZ1?=
 =?utf-8?B?cnpDYVB2ZTJZU09GMDdkaGJPNnVQd0toQTk3T0RKclNjZDZUSll0K0lZd2pi?=
 =?utf-8?B?aWpvUUt6aTlYMXBQbkRMa1VyWTVoVlRMWGZWV0hMNWtlQ29vV2h6R244QlQr?=
 =?utf-8?B?UzcxZUJOaER0eTdxNmlMN1FkNWt2UjcvdXI3ZVhVNzFJLzF0UHFBUVB0Z2tJ?=
 =?utf-8?Q?sEj4uqDqmwzqme10=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2128b54d-524f-496a-dbd3-08da382d417f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 17:47:05.1334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WNirXAkhif0gAWlFYfTvtoR27usvNeJuSsfM103dRZGizyCfdPn53ymP6PD61n6+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1932
X-Proofpoint-GUID: qKE6-AG_K8h4bc5bCJoBkQDTPJ1SJ6GR
X-Proofpoint-ORIG-GUID: qKE6-AG_K8h4bc5bCJoBkQDTPJ1SJ6GR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-17_03,2022-05-17_02,2022-02-23_01
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/17/22 4:59 AM, Alan Maguire wrote:
> With unprivileged BPF disabled, all cmds associated with the BPF syscall
> are blocked to users without CAP_BPF/CAP_SYS_ADMIN.  However there are
> use cases where we may wish to allow interactions with BPF programs
> without being able to load and attach them.  So for example, a process
> with required capabilities loads/attaches a BPF program, and a process
> with less capabilities interacts with it; retrieving perf/ring buffer
> events, modifying map-specified config etc.  With all BPF syscall
> commands blocked as a result of unprivileged BPF being disabled,
> this mode of interaction becomes impossible for processes without
> CAP_BPF.
> 
> As Alexei notes
> 
> "The bpf ACL model is the same as traditional file's ACL.
> The creds and ACLs are checked at open().  Then during file's write/read
> additional checks might be performed. BPF has such functionality already.
> Different map_creates have capability checks while map_lookup has:
> map_get_sys_perms(map, f) & FMODE_CAN_READ.
> In other words it's enough to gate FD-receiving parts of bpf
> with unprivileged_bpf_disabled sysctl.
> The rest is handled by availability of FD and access to files in bpffs."
> 
> So key fd creation syscall commands BPF_PROG_LOAD and BPF_MAP_CREATE
> are blocked with unprivileged BPF disabled and no CAP_BPF.
> 
> And as Alexei notes, map creation with unprivileged BPF disabled off
> blocks creation of maps aside from array, hash and ringbuf maps.
> 
> Programs responsible for loading and attaching the BPF program
> can still control access to its pinned representation by restricting
> permissions on the pin path, as with normal files.
> 
> Fixes: 1be7f75d1668 ("bpf: enable non-root eBPF programs")
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Acked-by: Yonghong Song <yhs@fb.com>
