Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8BA4B9288
	for <lists+bpf@lfdr.de>; Wed, 16 Feb 2022 21:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbiBPUjB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Feb 2022 15:39:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiBPUjA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Feb 2022 15:39:00 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A612AF3D3
        for <bpf@vger.kernel.org>; Wed, 16 Feb 2022 12:38:47 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21GK51Sn006339;
        Wed, 16 Feb 2022 12:38:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=C+miGcB+PM/xHENtAcPI4grSZKzinoEpUgY0yscOLIA=;
 b=TZimd05vBsV6mnBBg2OjR2sJLbebSCjrW/X8ijAJeUrw1hieHibvx+Ij8cEXGjq7U2bR
 F9ouPu5ZAZD46YRSqJ6/XpbtoNi2iNvZS5C7sc/qL/qlvtyRvTp4nbvhVibYDjD+7CM6
 0+WV6mKJ5973lQl02zCRAe/Q4obFhLaggnE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e8n3d7bq2-18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 16 Feb 2022 12:38:33 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Feb 2022 12:38:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f5Sp3Cv0jZolMkB+RITkwRBJpzrHov0hECr8M3LdeBV9OD+QCtr/TG/A+dEBIBNEfgms3XgCulaxldxxWAXbYxrhwU/rq/6KOqQTJjygKWPmwwZ6w+bCVLrhtJPOuYAh2jhDMOJyuiIwVgQhOiBfpKRxHMA9ThFmRAM1QiJd4E1w1PzrtBbw+o+ENKXwrCl8My0NwP8BZY32MNp0UR7ZAumelFNI/auzR8mHRlbwlJM0JPeyzl6+aCPl4ttBX8WQ5UwloUikIQuHc9qQ3y2tLG/wvltAywTmuRELh4KjvJfPqOpWV9cN4HtE8mbMUFL9QCUvRq1CQq0bVgV9+ZAnzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+miGcB+PM/xHENtAcPI4grSZKzinoEpUgY0yscOLIA=;
 b=OYbQ9P7GeQ4UlQn4ilvAOITLDGU/jMXOzmTYRyzz5g9hlsav/S1SmutRqLf4ZRPtAVJgWrHeROdJhVzSUKYp3mCPnh7LvHX7BJKACTFC8X2BeE6eT5tAbJKWCOchKSmVhN4D7KUO1gG/OWPe0gvHR7XaxPeQE2eAJB1RVNtEum5GP0P6Fn0tcPrerPMYYcfGdBD2A6+FFy1eXfG/4jokxmOMt2ctjfYESNK8QDzMeKeBFQhb3J422g6YkphAiNDp7hF9hICA/DOuZ3urggQDBwWrcPV+fsZY8C6bKZ91+pbTnPjSn/qxMIw6VStwTEHHP9ROqy5W+JjYecmAI2Z4nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW4PR15MB4729.namprd15.prod.outlook.com (2603:10b6:303:10a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 16 Feb
 2022 20:38:16 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1%3]) with mapi id 15.20.4995.016; Wed, 16 Feb 2022
 20:38:16 +0000
Message-ID: <48356210-820b-94a2-6c43-8f9555580c96@fb.com>
Date:   Wed, 16 Feb 2022 12:38:12 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH v2 bpf-next] scripts/pahole-flags.sh: Enable
 parallelization of pahole.
Content-Language: en-US
To:     Kui-Feng Lee <kuifeng@fb.com>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>
CC:     <kernel-team@fb.com>
References: <20220216193431.2691015-1-kuifeng@fb.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220216193431.2691015-1-kuifeng@fb.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR04CA0116.namprd04.prod.outlook.com
 (2603:10b6:104:7::18) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67b5befd-2482-47b2-0f82-08d9f18c4272
X-MS-TrafficTypeDiagnostic: MW4PR15MB4729:EE_
X-Microsoft-Antispam-PRVS: <MW4PR15MB4729D02D8E7DB2163090A021D3359@MW4PR15MB4729.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:478;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mXGzM4GSSHi68FPGeFDGISB0ODVJt9CgQhZAeru8xDriFCJFdVQqMc7ainMaZorD1iE6LZLvBefeQcGmTvdnHS3oG+AIa5WmQLd++OwK8ftLbOI2AS2eK261bCrKmfBmKzfqJmH37BobbqUSd/029/x3AyyHStZdiNnNHVAxdA+crj6ALrpJMLfP6D0mO30+5F3SQhgaFXBuUqkOgMGET+k5s8m8g2A1qCqhO9HQLgWcfdTJ8zlwUtT0e9DfzgjasjPnHPCEBKSs7nb+tWHJYI/zB1mbcPaTZXwvMhzl2+Vck0bSvgDz9IEeaIp3HrF/2jilMSWwnw31nAqI0Tf6qFnBBZGr+TC9OWva4cJGdq5IkTY4tMdpEDxHdZnlmkKc8y/bWSbPgEXEXtNAzuZYu0wiPYve3oW8dXrfb9sh/iBM449ZcsZRIt//ikxUzcpnhPxOHnQBGIhdfR6xOp1p5JqTqZxzANdum5/Qq0Vp8P3fTFcpqQvLEeNVdUMwq02oWbwRSxIk8yGwEIdXzlLB4rt3a+o9U42Bb3A0hFXTNuWTSHppK3mDqUAESCHTBsjCk4woZYiU8P4uhqiang+COfbhU0BPLDSv8djFTRGTG9izMAKF5Ttrj6gLm4BXZs9Ur4lYCQoN3M+bb3WfGFQMOU7Ret5SE8wHwvEj3zbhjIigwcBBjrK4MBn6rNDT5EJpQVyqew1cljLvUJmMRqgg7qgmansJA8fKkQPwF1FuyJg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6506007)(36756003)(31686004)(6512007)(8936002)(86362001)(2616005)(53546011)(5660300002)(52116002)(6666004)(316002)(6486002)(558084003)(2906002)(186003)(66476007)(4326008)(66946007)(66556008)(8676002)(38100700002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnlTcXdaaDVWcDBnWkRtbnk0M210Z1B5ZjR3amh6UnFkY2pJYVgycVc3bzNK?=
 =?utf-8?B?TCt0QUR1cm92SkY2WnBycGxHSXNrMUVHU3lBT2NIZ01wc3hGR3pRbGZpMjlB?=
 =?utf-8?B?K0tuZWV3czNSNmNLRW02ZGh6UVdsempYV2hEVk01SDN0S21sNmt6MGVWOHBM?=
 =?utf-8?B?NVkwUjZqVUxwQ3JmSXZPL2trcjJ0RG0vY0ZLQjVFVGRiKzBJcW9VTG96NEQy?=
 =?utf-8?B?MmhnVkJ6emw1NlBQa0lFMUg3eVJmbTBIY0Z3dENXRHBNcWt3YWdQSkJKRkR5?=
 =?utf-8?B?VkQxZHR5Z3prNWNpa2pscWRETDU5dG9RQkY0NkNoa00zNGxvSE05UFNZQ2ZR?=
 =?utf-8?B?S0NSYTJiT25kSmRjNXBTU3pkTC81a2tUTS9pQjNwc0JhUko5ZEdiRTdHd3BT?=
 =?utf-8?B?OUNTUGJMaHU2aEVvSElwSVBSVWRlR1huc1ozMldyY3RSSzdUK200WHJ5OEJl?=
 =?utf-8?B?R0daWldwM09lKzl0ckVvYTBXRmphL1dTcXVsdlduU1Fna2REQWdiT21GNHhI?=
 =?utf-8?B?ZlhOUU9UTllsMkxnRGRoLzBsUWdBQVVuOUF3QmpWWFdOekFnQ2Q1eXdBdGtP?=
 =?utf-8?B?bWh0bUk2bmhxbWVRbHdVb0JIWnlTWGprTkhhUWkzVTdicmZkQUNoZ3pYL3Ez?=
 =?utf-8?B?S2Y5VEs2WmtIVk1IS0NEWnRKa1N6WHBDcXhYSnBkS0FXM2ZaaFZOTzJ3N2Js?=
 =?utf-8?B?RTM4Smw4bEdOcFZ3cVZ0a1RLdjhxOW1jVVUrV2tHd2FhYm9FU2hQR0ZHMXp1?=
 =?utf-8?B?Zzc5aG9HWERCMVVOdjVxTksrdllMbG5sR2ZrMWxsZ2plZGVPWHZjTlRQMjVr?=
 =?utf-8?B?OVM2blJ6S3NickZsbTVkUXVMdFFYY2Z6UXl1ZTB3b2h4THdNWk0rRTMvUU55?=
 =?utf-8?B?K3V0bW12L1NXbjBkREhuVEdLTTVRWW5vYVFxV0haQ25LWSttS3IrTVBGa0Np?=
 =?utf-8?B?UEdOVHV1TTk3TzVDNDk0dmJ2N3ZyeGhkYnk5SzBma0hDdkxSYXZIOUdqMzRV?=
 =?utf-8?B?a3ZrcHNkQSt2ZmU1SytmbWMwQUw2bG9CQm42Tm1mSU9CL0diK3dlRkVFUXJJ?=
 =?utf-8?B?S3NaZC9ORC9FbW9aN2RaNVhOakhjZExzdXJabnlQM2FHWVFiNlhObjRDU3Vz?=
 =?utf-8?B?bnQrbzg4ejlLcWVQMzV1UUZuVnFMaE1sa20wSVYrakNEdzV4Qk82ZHRPR0dI?=
 =?utf-8?B?UGx5YlJvTWxSanhHYk5Da1NyTWptTGNWWFJqa3crSnJsbDJId3R1Vk0zMmxH?=
 =?utf-8?B?dW1RWXBUK1NzZ1ZrWTJ1Sms3SkNiTThNVHo0RkJDN0F3MXZGMEVINFluSGNh?=
 =?utf-8?B?Z3k5aThJSWh5R0JKTnBWRkpTVFpSOWtyd0NHc2JnYXR0VVVUa01tb3lUN3Uv?=
 =?utf-8?B?TEFtTWkxTWNSTkhmQmVveWJ0NFdVTWYrZU15bXdVM05pbEFDeUp4UG92QlE4?=
 =?utf-8?B?cTloNGZ2dk1qNjBoRFA4K0tmVHhqeTQ4c1g1NWFrMk1GL0N0clFjcVdGT3JB?=
 =?utf-8?B?MlFqV1FPRm1BaU9SMTh3M3Qzb2YxNkVJU21KdUVGbjQzVHlIRG9MRGtJOHFI?=
 =?utf-8?B?SGNIcjI3aW9zTnpiM2p5OVJJNDhMaGMzNWlnMHdkT2JnMDI4dWlCM2pKNVlh?=
 =?utf-8?B?bWhJcnNKNUVFSWcvR3ZKalV1M09iUy9RVi9qQ0JtcE9tVmp3RGN5VmJ3REsv?=
 =?utf-8?B?ZWRKQ3VGM2dzdFQ1QkY4SThGczh4TzhwRzZCZzdqSFJkQ2FrU2laeXpnVkdT?=
 =?utf-8?B?SUtsTC9ySWF1a1AyeVVpMG1uTURDTGNKNzlQQnUxeGpuZ20yVXk2YjROWVJh?=
 =?utf-8?B?VzB6cUlRS3BmaHlNRnU2U3Zhdmg1QmtqRUZvUmd2WnhRc3ovb0QrQ3lKNUdO?=
 =?utf-8?B?MW5USUM0VlZieFl5TUU4QWhEZ0V2a2pRcURQYXdiaS9NZWpVa2ZQMmV4ajU2?=
 =?utf-8?B?Y3FmcGg3TVp3ZlJYQWlmdjl6QzgzUnVtNEJ1aW1iVVNiVmJ0N090Z0R0ZTRq?=
 =?utf-8?B?YUV4UG5kNG41cThSc3FRcTJTUUNrZDJNeFR5MmNrVUlEWnczalY2bkhlSzVI?=
 =?utf-8?B?c2k0YlIxRDlodXdubHZnY3hOZVBrUUNZa3ZTYXk0UEhoL3NpR1FNeDgxV0g5?=
 =?utf-8?B?YWxtQnAxU3RsUWp5TkdHOWVEbUZtOE95dTRVMWwrdnVPLzRjQUVuMGxWK212?=
 =?utf-8?B?N1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 67b5befd-2482-47b2-0f82-08d9f18c4272
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 20:38:16.4466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sd86jnCveNsbUugtDJD8fhN7XQMlP8w5PYDjLuNHlb6cRmkzB1si8iRO6ycDFp/U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4729
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: qihlxsaz_rBpKwVyRrrK2g4gpSngVuJo
X-Proofpoint-GUID: qihlxsaz_rBpKwVyRrrK2g4gpSngVuJo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-16_09,2022-02-16_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0
 impostorscore=0 phishscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=814 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202160113
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/16/22 11:34 AM, Kui-Feng Lee wrote:
> Pass a -j argument to pahole to parse DWARF and generate BTF with
> multithreading.
> 
> v2 checks the version of pahole to apply -j only if >= v1.22.
> 
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>

Acked-by: Yonghong Song <yhs@fb.com>
