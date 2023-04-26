Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C036EF862
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 18:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjDZQYo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Apr 2023 12:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjDZQYn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Apr 2023 12:24:43 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0020AE6E
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 09:24:41 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QG0lIN003981
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 09:24:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=fJv6T8y5vehZKVz1xhk8aoTGHWrsam0NBPoi1cmulmQ=;
 b=DW3eOzF5u2siXEMqGsgWCYi8hgEsmzWz2DzU2+XGaZJSFrgA9czlShFK10wqgrkS3CBq
 uBB0G1C34LwUnRY395E3GzFuY0FMN0oPREP9O3tjlbpk+IwrIZN4WePxf/771m0DXTA2
 nINwQU3vQCwbOFEVGwpayTKYhVdK8U3Ch00pYTh11KgDnKV6oR1kmeeVop1aU4jqhrIL
 sJ1Z2eHf0RJZEyYhaT8o6i/J1SivuRE4dbUnAMax5SHAwc1HVqDHeICxXeZDKKfhqun9
 RJDAsoWSuie3UbPr5ZshucIitB2L+w5AkY4qc1ECNVBS+gcVDwgT4lliMj9hSgEi2lPy 0Q== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3q6yxeu1bf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 09:24:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kl8R5zoSXaKTIv6XDx6nlnJuGSev4PqONRkLlxBzvQlrFAW0ExCJ0lu/HIYTVdFajIcwFaV/Nyno1dwEw9BS53pGkQjBLZPdJAgnRONnXF6ddnEdMwo/Iz1hlpCuzynT4Rjttfld7azN+5WmPZPfhah2wThHtA793D0Sc3fPXufsszaG0qjHuSw6MN7EGNGARWHcwdGIthvuHiMKlkPAlJrsgDwj0+dFMjzBXvzUDCXFkAOHRK/S8cVgrxRCeLKgbo3teo7wOeIKFhzZU92C2NNdbUxYBCvLW4Ix4i8jIrAFcjlCpDc1LAyVkYt/ayTjtm/tiJUx+Y1Rj66UjgV2iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJv6T8y5vehZKVz1xhk8aoTGHWrsam0NBPoi1cmulmQ=;
 b=Ny12EeICERSt6BDT8gLIXmP3FU3vtLaH1V6knmcpAP72TE/XnT0vQA+S0dd8/sYjRXqAtCwnUZWq+vLKR3/bPiU3dYMImTheVjXahX/3V5uOz0BYWj7dP8zeThzqCa9847r5bXNEvEgKcjE6xrzmcKQFgotsxuvD5Lxh3F5gYYY9mYlSaQ22HebJEdktE9LdnkbkPz5uFHKf18CDbvCbbkQ3lBz6ZGVmwU6dn47PTgGplnnks6eRXklrMMuJ23mkVKzSv+d9OV0ggBXw+rEK3eSRn1T01oMOB4fPNA5CpIlgFf8P7wllLMg59/b5bYpYpJ2f6J/xcYFkHhxlROwrWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM4PR15MB6033.namprd15.prod.outlook.com (2603:10b6:8:185::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Wed, 26 Apr
 2023 16:24:39 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6319.033; Wed, 26 Apr 2023
 16:24:39 +0000
Message-ID: <f5ddc267-30ae-b600-5f0f-c86e6e685e71@meta.com>
Date:   Wed, 26 Apr 2023 09:24:36 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: test_progs can read test
 lists from file
To:     Stephen Veiss <sveiss@meta.com>
Cc:     bpf@vger.kernel.org
References: <20230425225401.1075796-1-sveiss@meta.com>
 <20230425225401.1075796-3-sveiss@meta.com>
 <3c83f3ae-c707-1852-57a6-18ac295a9f79@meta.com> <ZElNDYRVTGCzxBOd@meta.com>
Content-Language: en-US
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <ZElNDYRVTGCzxBOd@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SJ0PR05CA0093.namprd05.prod.outlook.com
 (2603:10b6:a03:334::8) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM4PR15MB6033:EE_
X-MS-Office365-Filtering-Correlation-Id: 7de5329e-0667-4972-0cd0-08db4672bbb2
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mFUEYVv0ZmjAqIeB6sg7l1JDJg34u/mBNwGFiQ7Gdmlc+1PGnb3WwZ6KsrQ3rg/iCFMx+imMx8yf14ySakDgiFGCgOJRspPsgyyQulcdBDxsy+jU5e4bk3wht9kHPtANaWZ6wM2/8ieTddbZHuAr73KnkEf/dItNebUu1aFUqZI/RzH3CA3CtMkWIgsvSxpcukcTOBIP048/Znkepy8oDgs4t/KNNRMXtNEgfsyP4pw6P5YPPsxqTpocTrkL4VZwpDrD3K7cs3QGqsVuViu1t9GahDnMGV5/sCC50jHEFp/dGkCnpgqARTbP3z/dxax8ykcXtRyjcPmZRT9ua5h0DyS80MXEAdt1c1wJzh5vnYgc23gWa9Ap9dcD8a34lZ6UvLJoBscMTgf4VshMUk3NDO8Kxaebhd1SZy2Y9gDxv7JLBsUw7f3PB28j1JHpGYZyVbYh5LyRWxo64KpW/6o+oi5ejh/KvfYGtYOMs+pCPSkEqoK9VVhGT/E4lI7O+8RZHyZ/q9+WndJD5sB0WTx9mxakV6nax7piswq85k+OrBsKdYJJa41kc6TgO4mmk326Exn9fL7JL5PXyzBnjmdVeAyhES5d14OPzM2/9wLsvLJGzXCz++/SVPCm+1RH88E9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(451199021)(38100700002)(31696002)(5660300002)(6862004)(8936002)(66946007)(66556008)(66476007)(8676002)(41300700001)(86362001)(4326008)(316002)(2906002)(4744005)(186003)(6506007)(53546011)(6512007)(6486002)(36756003)(966005)(6666004)(31686004)(2616005)(478600001)(37006003)(6636002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXdRR1pudkF1NXpZR2gxa1VjZUdpMVp5d3lrRHVGWkhmVjFmaFdwbml3NEZt?=
 =?utf-8?B?dTVJUUhJMlNESm4wQ2VpY0VYUHp2bm51YnV5eDJGcTJXSHJYNEJQZE4wRVp1?=
 =?utf-8?B?S1VlQUZQMlJtYm5xbGJ6N1JidkhzbzZjWm53OGx2aVM2V1NZL0o4Z0xITEF0?=
 =?utf-8?B?aTFKZC8zRjNCaEVwZDUyVmdkMUpaNmR0MnpnY3pVZ2grZU5oa0dnVDhOYVFa?=
 =?utf-8?B?R2p0dUxad3RUMmRqbndrRi9hOWZ6M3pPdlNjRFZEL0htakhPSXhCY3ZHMWp3?=
 =?utf-8?B?WGNLeGx6cG5iRkpRRjhQa3E5UkJhaHVzZjRGMEtqTGJBbmRKZkRSaHRZRWZt?=
 =?utf-8?B?V3c3eTBvV2VYYlBRMExSSHFZdkpXU0owdjhwcUdxZXA0M2RoUWJKcnljeFhs?=
 =?utf-8?B?R2hjc3ZWdmFwWWVJOHB5NVVaWm1vKzdyRWlLbU82bnJBS2cvTHZTeGRKMWJR?=
 =?utf-8?B?SHY0R2lnUGtGbkNFbHlWdmlNTzFhQ2g3SG5ZOTBLVzJQL2IxZXNhN3V3RVlF?=
 =?utf-8?B?MjR4WUdUN1c3RTBoSEpSWjE4K3ZKMXZPWGY1eVAxSG42M1NGTjFVVGtrMGk5?=
 =?utf-8?B?aTgwS3Qwbi9NSGhhbURlckpqUVVKZmMycmxNbzl6MDkrckhwMUkzV1c1K0M1?=
 =?utf-8?B?N3FISDl6bUdSK1VCcFN5NzU3dm9JbTZaV1JKcUx5T2xMSG03L1FSNHg1ZUIw?=
 =?utf-8?B?MkdvbytJQjg0UVVaL2JMRjJ2UTF2QnZpRjVOZ1ZkRzVyRE8waDhzTGlWM2tY?=
 =?utf-8?B?YURNRnI2dXdvRGg2WHJaSTBZaUtEdmg0Vnpad0xwNXc2UDV3VVFtaE1BNkt3?=
 =?utf-8?B?YTJhak1zS01aT0VjY1NpeFA3Rk56eTU0MHdBNWprUVFreTRMcHMyWjlQd0U1?=
 =?utf-8?B?WUh6OFZaa2k0bzg3YVUzdzdCZjYvUkVaNVl0NTN6MVMrYlppQjczMlBKTDc0?=
 =?utf-8?B?T2FQRFJUZlZsb0tPSzhUK2NpaGhFZEZ3K3pkSG8ybis3UUtlQWFYdmZIcjhm?=
 =?utf-8?B?ZmpwS09OY3l6d2FZOGl4ZGc2NHBQU3RuUDZvR3lzNmFQUTEzQUdKK09aSnJn?=
 =?utf-8?B?WDVEL2NXYVVtOXo5QllRK3d3dGNuaXZxMkkyRi9YVnkxUmFWbGJYcWhrU3cy?=
 =?utf-8?B?eEcrUGVISEk1a2ZxNG1Cc2V4WmUxWFQxSHh1d0lvZWI3ellCTEN4WnJ1U2g2?=
 =?utf-8?B?WUdobGNzQndmYU9iYXdwa3hWYytaVHJ1YmJuMENraUNQQit4b0wxbGZKd0w4?=
 =?utf-8?B?VXhrVTNKRFM2M3hCUlNxVDg4ckxHbDcwdUQ3Sy9UbUlwUWtTSFpWS2VFL0dh?=
 =?utf-8?B?QnpEd2ozOXhpTVpUUDhRcnQ0OERyRE13R3JsTXpyVVEybHJuTko1QXJJdlg0?=
 =?utf-8?B?YnRVcjdnR2k2WmVYamNkZm5lNjQxbXYxMU1TM1FnTnhSNlpSUzVvL2xpbklo?=
 =?utf-8?B?WGVkWEh2Z1RsRVlPaHJvWGtuQ0JQZlFWMFEwOVI0TG80SEhoUTllT1JwRHYr?=
 =?utf-8?B?V1hzcHF2R2xHTjRkc2J1K2lUWE85RkdIOS9CUEdrWGlpZnkrNGhGbTJqaFZj?=
 =?utf-8?B?QlF1cldwU1U1ZVhPaGVCdEMzSVlrNEdIZ2xTRUJyczVjbURsNTVaallJVHJX?=
 =?utf-8?B?WDlkbTdFeUswaXlQMllKRzlzUmZzYU84SmRxKzdtY3l3aHNhbjNJSnhtY0h3?=
 =?utf-8?B?bjJ4cTJKaFVRdWZVZHJBbElZKzYxWG43bEJQSE9YTEN4WXlDU2hiZU1rRUF6?=
 =?utf-8?B?RXViZEd2SUl1aW1ieWlKU05wSkpxUWhlSUdxajc2WVdxMEFSRnJkempEWHlw?=
 =?utf-8?B?SDI3N1R5bUwvZysvNGFOR0xvajRPckcrWkpBZTlSVXZ5bitUYnduankzeSsv?=
 =?utf-8?B?SFEwVHkvSWoxTVdPSkEzZjV2K2c5RENjREUrNTZDaUdCQkE5N01CQURDbm5u?=
 =?utf-8?B?dTAvVjJ4VzRlMmN1SUtKYWJEWTgyTStyMm1mcmxSTTJKVDlTYU5JeTA3bDVo?=
 =?utf-8?B?eXRRYThyWFRTcTFBVjZ4VTF1WWQwckxLL2xsOWtuNFdubUI3VUMvaFVmRk05?=
 =?utf-8?B?dS8zNktCRTBOYitCQXRSdEJBS0thUnVUVzB3TkxoWDFhZitkWjN3anJ4MnAx?=
 =?utf-8?B?ZTBwOGhsQXo4VlZXVjY0d2FXenhjcGFpT09yMnBLMXQ5VHYrZUdJUjkwVWVU?=
 =?utf-8?B?eWc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7de5329e-0667-4972-0cd0-08db4672bbb2
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 16:24:39.3897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RI/ReK0F2kRRjIcLOvBPeDdSgo12k4QuayrioH+rcaBZ5x5QGaEj6nX+kc/bT35u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB6033
X-Proofpoint-GUID: suqHjp0xL988WvEyaNKl9MT3SzWkRzum
X-Proofpoint-ORIG-GUID: suqHjp0xL988WvEyaNKl9MT3SzWkRzum
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-26_08,2023-04-26_03,2023-02-09_01
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/26/23 9:10 AM, Stephen Veiss wrote:
> On Tue, Apr 25, 2023 at 09:25:40PM -0700, Yonghong Song wrote:
>> On 4/25/23 3:54 PM, Stephen Veiss wrote:
>>> +static const char argp_program_doc[] =
>>> +"BPF selftests test runner\v"
>>
>> What does it mean to use "\v" here?
> 
> argp splits the documentation string on \v. The part before \v shows
> up at the start of the --help output, while the part after appears
> after the detailed help text for the arguments. [1]

sounds good. Thanks for explanations!

> 
> Happy to take all your other suggestions; I'll revise and resend the
> patch series later in the week.
> 
> Thanks,
> 
> Stephen
> 
> [1] https://www.gnu.org/software/libc/manual/html_node/Argp-Parsers.html
