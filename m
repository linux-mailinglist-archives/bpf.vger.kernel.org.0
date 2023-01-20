Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B999E675D9F
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 20:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjATTG7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 14:06:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjATTG5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 14:06:57 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB19612848;
        Fri, 20 Jan 2023 11:06:47 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30K8Zq8t010790;
        Fri, 20 Jan 2023 11:06:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=E8kpzeQxD5fsMtvAt7MSzyMPdW5syqkqAccNCk8SLnc=;
 b=AOPr9WBsG6Mwb4fV0Ho8ktDTg2NXa6sOVOkebYwIYOrnX1zrB3bYajA+U1za9/inEXuy
 +8NedI0l4Z+DnVs3pUTCTAWzpohDoG12cM/YcJrIM5dge9TPgwBwqVDNvBXd4GtsUgS8
 htt7xEPwEUkaoMhwu5DRRtQpHXPye1cgGz7RKfBAn6frbs3EW1W+Qxh0VE/Jbckp5a5R
 J0xC6vo7bBYAlIYwZQOGBsQw7X1BtzHpDe1WTixfAl2IZhoEQvsi0m91IASRZE0grNSJ
 5w/QPp4LIKDaG/kfvxdw7WsUUtv6BoFt54zvV/tMjPGRzGqAM6xLHE8JQKpaJGuiGgl2 YA== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n6s3pc0gb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 11:06:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l7jzhBFmZeFiKe2pL7EZk5i0ojZD53RDjdgr1Eryjtd91bon+R4h70KURrYe9ANYZxzyg7YqxUawors6JchHs6y/tXYGTPh9cJMhKZBIRZigPplUMINDQqLjKc95U0Tt6k+YDLTbz5VwFg7Kdm/9J5rJ32CeZFhBZ1WqdIS6claJFE5NjjbIGq08AV/u/SN+D1g67UbGlw3x2ADHQc96CNQQczqQoS34dPQyXvChR/aaeHbZO77VBtxokfrQg5kamBNAaqB8gWjd8w3QMGLSlebXHNFSi866PfD/7QDMWaNOD1Gkl94Gi3ghPCWS6iuJ7L741TGlIsxYvIVIlgbBQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8kpzeQxD5fsMtvAt7MSzyMPdW5syqkqAccNCk8SLnc=;
 b=jPTjVe6JMRSDb4FdiTxIKwoPEV69sEKcDQcVhPNNzWUAIXmt9u72jeBauw6uYVt3v7pcTiGDRhUWhoHfe7C8xdJI2yomGf+YMeSmxaR94xO2VLR2JK0K4VUGuwvLPS1TDOEQWtRI2eguKrLMn7hKs1H1rjLyvJ/ltbTclkDK0QfRYvpD/OZ4laB8QD5OLtwkOuLlTuv9/cimI0NL5jv5q0/2tzQsKbqmeWXLu+ujHLdROgbIXTjPkpOgEBzaMZq2LnfXKk3zCCfqkmObEB+49ID5azACRnLh16rlgvZkCVa8q/k9mjZbuxxO2pPhpYgAK3m0bc2VL8QGC9v5pX4hXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SJ0PR15MB4711.namprd15.prod.outlook.com (2603:10b6:a03:37c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.26; Fri, 20 Jan
 2023 19:06:25 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18%4]) with mapi id 15.20.6002.024; Fri, 20 Jan 2023
 19:06:25 +0000
Message-ID: <3fe2052a-2085-6ca3-a577-e59b13d21685@meta.com>
Date:   Fri, 20 Jan 2023 11:06:22 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH bpf-next] selftests/bpf: Use __failure macro in task kfunc
 testsuite
Content-Language: en-US
To:     David Vernet <void@manifault.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
References: <20230120021844.3048244-1-void@manifault.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20230120021844.3048244-1-void@manifault.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0127.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::12) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SJ0PR15MB4711:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c445b7c-9584-4f36-6674-08dafb196d16
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MxGg+ZwTT0x04H062bRP1dbh2qmxLB/J5IJ5fl2G7hPHLYli2hTuIYOe1MoY4VeYpsvCzuQ1Mhl/gVGFtbMhp5Tf91khFwEgmIoq18HcSyoQpNXVMcGUqRVyuoOCUNf+pefvI5/vBc8gngti67fUr1zfBAzGOUh65I1dP9VYtN/BQZX25EejzGxpWQvh3wuZ3uv8301vMq76aArFrjHpMPvvZm7TXVx0Ui9vCeiCW1yJS97KPaFw/G8SdUz+6j+Rl0igYrNxWGDV2N/7HS0KC2rZpP2Ba/3s/K0X9kbENzQFtm+FsG//Z/u58SbA7/vvpK1j/WCy+qdHnx7aleZwaVOLV/5t30yeVUP9XNz9mIKFOBA/f+sbMfsIGkcZSsKbRDyLtTIr1PrgUUlOym78Ybqo1qcYDr3OcmsNgXX4p2qut0uYKC+aHukq80reND2b53PZx5OTzhnWmG1VZmQSLF9RCcRU0Ez888HmPX6stWQUHYS3dVpK4KAzVsqk5YNbu7WwYXveaZiAvrXdvnkCvqgvtHfTB0vzNb85gQb7Z3X8jT5i9GPshIC60Rcpuw3yTNYNnN8azEa6x+agWJcvitYYUtO2P4k1QJTKslC6eX3D2kSkmgKOJUlxqT5vNAykRsgGjiF7D5YIs4pmTT7nOAzHfHHDtlWn7fZdJqZsFuuRZRi5KynQjZbznE2juXN3APWTCJtB58IcCLkPKE4v75FS8NDRPei8SPWBatZOkpA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(451199015)(31696002)(31686004)(107886003)(6666004)(6506007)(6486002)(478600001)(53546011)(86362001)(2906002)(66556008)(4326008)(2616005)(7416002)(5660300002)(316002)(8676002)(4744005)(83380400001)(66476007)(66946007)(41300700001)(38100700002)(8936002)(6512007)(36756003)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RS9ISEM2U1hmMGxWZXZJS2d4NzV3T2pQQno0QWF5Z3QyRE81SlBCcFRlU2li?=
 =?utf-8?B?UDh5eGVwcFFHSmdRN2E0RjRtY1ozalg4RXp6MFV5QzU3enR0bU5VckdtN1N5?=
 =?utf-8?B?S3FRbWU2REFpYUh1QU5sMnVTcHlsY2FrSS9zcDZGNGkwV09ja3JqWG90ejJS?=
 =?utf-8?B?T2diRnh1ZHlkdXNyUnBpQmxlanByemdILzkyRTRwMExmM0s0bTM3ZFA3bXJN?=
 =?utf-8?B?YXJoaGpNQ2g2VlJxVC9WVlRUWmdZTXJvZHd3aWxMTjJVYjhzaEVOYWZqdVNa?=
 =?utf-8?B?OHRBQ25lcGsvSEtUK01xdyswN1ZtbEswQ3luakhkVFY0RkJJVFJJWlFtQmpY?=
 =?utf-8?B?RmU0Tkd5N0xHc2JCOU1IMGZjWXljSWZoMGp0NmV3VVQ0c0RVZVVPNndBaElT?=
 =?utf-8?B?UXlnZkUwMWdiMkhJeXhudVBPM2tIMVJuaE9ZWmg0bFdRb3FtU3R2azAzUjlw?=
 =?utf-8?B?T1NmZWZBTkhZOVk3SG1EVGlmNTJNK1dmdnpORlE2QUdqT1lDT2o4ZWxFbDZk?=
 =?utf-8?B?T3hmUlZxSzFlSXZucjFFTXJYc2pKWWhPZnRNRjFoNFB6Y2JjYmxIbVlGV1g4?=
 =?utf-8?B?VXpRMDhBUVJzamJMUlJzTFVnZDdobmUzQmRTcS94WnF2cHRWUld0dGlTbDl3?=
 =?utf-8?B?U3ljdmUwVGExRXY1ckZSSU96Qkp3UjlFNnRjWnZ1NkJlM2VmUEVLRUt0SUtj?=
 =?utf-8?B?OFpjZHNqTUpXanFnbVFrRCtSN2JJcGlDalY3TmlkbFUrbWZuT3JWdkJsajI2?=
 =?utf-8?B?TkVEWjQ2NGRYVUx0OTZJdFhkTHVFUDhtRUdqUUVWMEdMbEd1WUZ6UERGbGcy?=
 =?utf-8?B?RHZEL2llTk9lQW9DRm9XVUtEbWxoYWh6SkV6SmRTYk1TeUVJcjlXaytzUTFj?=
 =?utf-8?B?SmJwODJWWTlTY2Q1ejZHaWZ6Rjl4WDhVNkFETi9kZ2dRelBNQlNQUzFQeFZG?=
 =?utf-8?B?TWtjaXBiL3MwZ0JpQndpTEgyRlNwemdTYlE4cWtiWGJaRkZQUWJJeGJUbmtC?=
 =?utf-8?B?aHhSSU5aRXdkMUo2aWtKV1V4cHlneGl2WXNpV3BmUHJrUEJTSmZFTUdNVlJo?=
 =?utf-8?B?Tm9lOHVpQTBnOUdBVkI5dldPYjQwajYyWTVHMmg4ejNobWRPc1gzemdlRXdo?=
 =?utf-8?B?WkZMZVVGd2Z3d1kvMHl4OTRVSzl4RW9UY01PVmhibUV1N2NHMUgyaGMyRCtn?=
 =?utf-8?B?eDhzcjJGUUtCV0FIWE9CS1E5ZlR1d1pENWdyVnpRUGcrK1V1ZXIrT3NxNWlo?=
 =?utf-8?B?R1VyOEQ5eThOWWxjRzJDaHFLcDV0SHZSQkVGbWsyRUxKdzcrWURQUTVzTnBj?=
 =?utf-8?B?bERzaVFSbWxZVVNZVDVObUEvWFl3OVRvZ0dEVjUyZWZ4OElrTlUxWDhuWjl0?=
 =?utf-8?B?SVdjRFlTY2hHOXJ1U3g0VlBwS2syQWg0ejY4clRJTE1tTjQ3eW1yaGhnaHNP?=
 =?utf-8?B?Sy90NlFLYWp5T0FNbms3enpnL004ckphL2dwa2piempYSXdJdVNyelFXanRm?=
 =?utf-8?B?a2RFd1pyNEVrNC9mWm4yek1MbFowNldrdm0vbzJkVUFRTUFiRTQ4OHdaUjln?=
 =?utf-8?B?NFZqSzdpTDNrTzBWNnhDNEtZeVFzUDRWc0NWN2ZETERsa0VaRXQ0cW5NMmEx?=
 =?utf-8?B?V2FyQk9QUzhPRmlNSDVGbkxNYVAxUmsxYmhlditBeGFHNkdkN2JyQjdHSU9F?=
 =?utf-8?B?UjZ3L3V0TlZQUHFueE5vT05XUjV0SXNLK0J1YkJLY3hJMSs0ZlNNc1dsYkMr?=
 =?utf-8?B?Yy9qZzVSOHg0VzM2T28xRnBjUXhybmhZOUZZRG9kRTVKbHFvNnpCUkpmejNl?=
 =?utf-8?B?K0N3RU5jOURPWWtFbnlpNWMzTHdPTUx4ZnRaaWRXUlZzcko3QkNVT09XbjlR?=
 =?utf-8?B?OWdod0FBUWh1cklEdnVHbm5MdDd5UlpOOXkzZ0lWaTFqUkJXUjE3Y2tDNVQy?=
 =?utf-8?B?S3B1SXBTT29pUXRwUnJwOXlvQ0xKL1htOXBtM3FRZDJkQmR0bkZ6bFJWV1kx?=
 =?utf-8?B?S1ZTRDYrV0d4RlVJd1V5VVVhOVMxbUZLUktGWnRXM1dPSnhFQVd0N1piSlI3?=
 =?utf-8?B?eXBPOUoxVTRScmFiWm8wb2RCelRlQTRqMzBlR2xvTmIyby82YmFzWDNxVGF3?=
 =?utf-8?B?V2VKZW4zVVVkM2tYTVNZS0J5MEw5UlJCbUo4bXdrcTIxTFlETERFRFR2cytF?=
 =?utf-8?B?UFE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c445b7c-9584-4f36-6674-08dafb196d16
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 19:06:25.0691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ev8Y53jigSvs1U7MvonCwxGDTR2S9ZJHZ0Qu0GX5Cwler+xMd1dBEcIVcQyPvLJc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4711
X-Proofpoint-GUID: OYw3XOsUqu-1iFRCZn_RbEiEKrL3T_Ql
X-Proofpoint-ORIG-GUID: OYw3XOsUqu-1iFRCZn_RbEiEKrL3T_Ql
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_10,2023-01-20_01,2022-06-22_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/19/23 6:18 PM, David Vernet wrote:
> In commit 537c3f66eac1 ("selftests/bpf: add generic BPF program
> tester-loader"), a new mechanism was added to the BPF selftest framework
> to allow testsuites to use macros to define expected failing testcases.
> This allows any testsuite which tests verification failure to remove a
> good amount of boilerplate code. This patch updates the task_kfunc
> selftest suite to use these new macros.
> 
> Signed-off-by: David Vernet <void@manifault.com>

Acked-by: Yonghong Song <yhs@fb.com>
