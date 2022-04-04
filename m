Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A7D4F1C8E
	for <lists+bpf@lfdr.de>; Mon,  4 Apr 2022 23:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382364AbiDDV1s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Apr 2022 17:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379996AbiDDSgd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Apr 2022 14:36:33 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DDE31376
        for <bpf@vger.kernel.org>; Mon,  4 Apr 2022 11:34:35 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 234Hkf38003182;
        Mon, 4 Apr 2022 11:34:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=hn4FxtoIQL+rF3xmcADOCfQhwvBXxCBNTUS0JUeE0ok=;
 b=SGMxjISbSdsmFe4m69xDGuqvqZy8nbz2U6/W5aaJvXCbn2VOp/xNy+e7AFMTSiGfH8Lp
 O/3muJ3tA29CAb+XVOFymXlp/evvZ7UaKoGjkJfW1L/odzy/L4Fk0Y8p5bBDBM0b58hr
 CuP4z7KMv6A0brdTOBE6NYQR71MYD6aeo5g= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f6kkrv7w3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Apr 2022 11:34:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YM0nEq3nun8Lyc6tqtcMiQJx8QVq8xEmyvvgp/GEP7hdJlbMrs4eR87/f++V5rMfaTzzW6OO3HYjQhlxFYAVKkvlkJ5z0hACFTcGfi9UqaNjQfJUVb0nODU1DkriLmeocdnqU41jTbc9veo4ONiueiQQAzPAL2vicSzBuLUax7dulqZ18ezND6b95yUnRD2060cgodPGvn6W++gQQoft3EwIxSV/gFt8ygiJFOG/tBmXs5Cc0GuDRnO3VOAdhm3VBHGK5w4n7q8eMYqN3Bg97aYZLWaGnMj2aojg+2+kMgxWGCdw3zF5WTdo8mbMhDHu3IE1lVnTXr+Kqgx5xszCGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hn4FxtoIQL+rF3xmcADOCfQhwvBXxCBNTUS0JUeE0ok=;
 b=VpbONaiuFLehAig/8grS/ghTz/jdGlZ5H7DGLusqmQ1q68RgrPIva5Ha8KDbTmcSgnGPL/QCv8fCnjIJr7NHChy0hmwKIP41JLMmZb3rVpRTlKTwUrastrOPOSFt/vkhlqs/ETlg9Oy4+nHRaGXBb7pETChnSyNn4EfjiR9FgJLSZpinJAukdOjevuV5euNn6s4+pZWmluXChEGs7sFumcnlt9HBoQSXgE2YH8LvdJrnJEu7SwzqzxJGq2ldRyOFXZLsX2Y91+0Td9093VNxl5iUDo1oHNACb1+nbzETKjBPQXQ1gHAJ+jiW9JVpQbp0TQd0d11XslR5N7NJTAjuAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by PH0PR15MB4720.namprd15.prod.outlook.com (2603:10b6:510:9a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 18:34:13 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::5ca4:f6e8:5d75:1abc]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::5ca4:f6e8:5d75:1abc%8]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 18:34:13 +0000
Message-ID: <e55f6f36-d544-cfd6-c960-40f8e97fbd3b@fb.com>
Date:   Mon, 4 Apr 2022 14:34:10 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v2 bpf-next 7/7] selftests/bpf: add urandom_read shared
 lib and USDTs
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     kernel-team@fb.com, Alan Maguire <alan.maguire@oracle.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
References: <20220402002944.382019-1-andrii@kernel.org>
 <20220402002944.382019-8-andrii@kernel.org>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <20220402002944.382019-8-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR19CA0056.namprd19.prod.outlook.com
 (2603:10b6:208:19b::33) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3410b4c0-fa68-46a3-fc95-08da1669b72c
X-MS-TrafficTypeDiagnostic: PH0PR15MB4720:EE_
X-Microsoft-Antispam-PRVS: <PH0PR15MB4720BF4408BE1E3C1F2E13CCA0E59@PH0PR15MB4720.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PVtgiYLp204vGIYs00r7h3HBkeF8wxCahTWCs7eVdNd6fnhoALWaQniAProUhSP5susI1D1BHahJx8Nuvv5vN4bw6iS/MlgmchaGHD5u/gi6s1Nml12TmPhbKiLbBmX80TfDQ9X99/RdEN4483AyCnmNVJHzhJhxGwFGtBUKm/ObhL4GyWZp55RAbozLHrvM9xZfXZn2UhwDBN3HhvrPwoFQTaRuyBLeQ8se8iKoINtLrIBuMNbSlUk/k6yatLvv/b0d80V1foAWkq9ulin2ZLS1SreHLxIVA/ZxV+PNIzlWOM9dZaWcRhzEp3rJoIAV6kI4m64m+cmFpYwRzwm4mx4GyZbeyFFoNo7us3hGLQjfVpLsEERqhOYNt5Q/1vEQyzuHB1uF+Ug2wvg8x0o9LhcRm9sYtWT9crVxbELmcpy5SHQlHL1cLegHvEHk+RcN4RFPkYnXMS7St3FlbX/yeVd1Yfc2KR8sy1ML+w7SVV9g386p+IWrJmIPF6NAShRAccHYQ0ehByDvIFaBN7XTGUzvot51+nlziyrZ47HwI8ZBR7IPRrDe0vN37cYrCzU8GoJAqVXebQj1tpyYfgLtH4zWWdG24IR/uooQu8LOF9ZyP0JF5cvsmdhnXhJJT1E9Y04mr+VnCEl8KVTOo519njmPzJXwDDB/9DdYrflZ1FtYUx/cu3mjf8ZwTAXCtYWLQN2VKKTJMNLWAbDZNRPMTh3VUL0G7gR53YrAXgopsBQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(66946007)(66476007)(6506007)(6512007)(54906003)(316002)(6486002)(508600001)(86362001)(31696002)(83380400001)(38100700002)(31686004)(2616005)(186003)(8676002)(53546011)(8936002)(36756003)(5660300002)(2906002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDNBYWt4bTZxOTIydXNLOFVQalBUakNiMW42aWJReVhDeE9lY1gvOXV2dnBy?=
 =?utf-8?B?bmpzY1lIWGZtQXdNeG1DY05mTjlkeldNQlJSRWFDZjkrdVJoMzZKcU9SY3ov?=
 =?utf-8?B?cjQ0NytQNDF3ZkRraW54NDdtR1prOC9aVEtMMnNhNnJUWjJpVG5GK0tQNDFi?=
 =?utf-8?B?aUN1cU45RythdTFUVUVDMkFFelBWa0VUdlo5RTlhMitmVC8xcUZZMXFJaGlt?=
 =?utf-8?B?OWIxRWZKNW9JRHhoSnphWFJaWWdtOGtBa1Q0WG4rK0JUZW40a3RFNHdXemZk?=
 =?utf-8?B?NE1XeU9KMkVlalBwK2MwU0JLcE9ueXpPd0hmdXFGV0lJVnAxTkJ5NUZzeGJF?=
 =?utf-8?B?SmtSTFFXSDBialZ6ekpXa1JUWCtBajcxeEVYQWQyRDVtUUdadUNCRCt4eHhI?=
 =?utf-8?B?OXVoM0pTcmZIa3BpeWQ4QUpqVHFHNklFcnNFdTU2U21mem0zN0lKNzg3M1JV?=
 =?utf-8?B?Z3RGQysrS2o4bkhCUVRyenN3NU5mN09rc0NaVFBlckN1Ukl0RkFlZWNEbG9O?=
 =?utf-8?B?ckdwdE1MeWtDRlVpYlI1bXVmNHVBN2NMS1JDQVhOcUxZcFRrRWtsc0h2V3o4?=
 =?utf-8?B?Q2h6bW9PNjdaT1FlNzhVRWtTUitybmpXTXEzMlYxV0tISXpRaXFnVU5wSy93?=
 =?utf-8?B?STVDejFvR1JVSzhyZEdFR1F4R1VXYjAvTUFzRlhaa09TN28rekRkWWdoUGdQ?=
 =?utf-8?B?SWZ2YTVkL0JmQ1VzZGh0NjZWbTg5c0x2T095OUNNV3BPZlp6TUFHOGgwTEhO?=
 =?utf-8?B?cWVDZ1c1d2lEeGlCdUl5QWxFbDJRS3J0MU1hSzBqWjlXU2Z1aklXRnFWTmdp?=
 =?utf-8?B?d080WTR6ZlVWQW5RenhHNTd3MHNPVlJmd0c4c0p3dkdiczd5SXNDd1djeUtO?=
 =?utf-8?B?MlpxTmp3ZzIwNW85enpUbjF5NVFhdGd4b2pvcVU0SVRXQlJ3bm0zMGsvV25k?=
 =?utf-8?B?aUJyZzlJU05EbUFmdkVNMGJ0ejd3bEttbzl4WXk2ZzdDUHg4ZkZmT0pYdkxT?=
 =?utf-8?B?bWVUZFBjM3lxR2EvVXFGdTlNSHp0WGh6cm5sdjE0Z3hXNXBiSElOVmJIK1BY?=
 =?utf-8?B?VzRwd2RnZmtYNGxWakxhWkhFNG5nM0xGTEVhL0lmeGhGSGR4ZkgwMXNzNE5E?=
 =?utf-8?B?dElHc1dDVU1mdSs3cWxianNlUzhZdVlTVHliaVRHOEE3QS9aMmZxOURuOUxj?=
 =?utf-8?B?UG5veVFwd01SbFRBd1l5WE5nK1lqSkdhK01QQW0xSlZYR0dnU2x0MGVBLzZ3?=
 =?utf-8?B?R2t3OFlOdmNDdVEvckw5SXNHejZ1d0FvN1NGKzJGS21aaUtqUUV5RjlPOGt5?=
 =?utf-8?B?WjhzK1ppR3FDV245NUtST0tyUkZzdXRLa05GWFF3Nmo4Y2xMc0F6VjBPcW5T?=
 =?utf-8?B?Mko5bUVsREM1dHgzSUppa2dYSVZyc3Mrdm9Kb0JhWElpWmZNV0dlZ3poOG02?=
 =?utf-8?B?TGpobFIySGFjVEs5V2lhUC96eEdWcG5Cek1rNlJLTnV2UDNnbHNwWGlRQ0ND?=
 =?utf-8?B?cnR3LzlxZ1kwOG1IbmFLZEduQitYaG83T2xtK3pzZUFKUWhQUW9sdlc1SG5Q?=
 =?utf-8?B?Z1Y2WVVlYS9sNVl3VXpNTEswRndLNHR6dWtmTnRaWXZvc3F5aS94bmFPUW5D?=
 =?utf-8?B?VVR6Zlg1SWxPbko1ZXJJM3Z2QTJYc3RSdEJ5UDZNTVh1SzhuZkRUT08rQUJi?=
 =?utf-8?B?Y3p1clhiOGthNGZKSTJOODFBL0NkTDdteUVwUjVJZERJWWdjemovMTU4bUgz?=
 =?utf-8?B?OVNvYzVKT282cTZqbVZwWVNMa1pBaWFNWHNTeDFiOFhPdHg1V2lDd0J1ZXdF?=
 =?utf-8?B?dzFPWEwrSytsd2hYdUx5b2RyZUxQM0R6YUtQZVpNWEEvbkRGcUVJbmRIOGtX?=
 =?utf-8?B?ZmRjYkNhNW85SDliOGpyYUtPNFZ3cmEwMWoxRWNoR1N6dkJjSWJ5ekREM21o?=
 =?utf-8?B?Z2hGbEN4NytocEZJQnZYdFlvR3N0L3MwVWIwUm91NlFVK1BWTjc2Y05LQ1Zx?=
 =?utf-8?B?NDQvY3hOMkhYTEt5bWd4T3gzS2oyM1picEtVcDZCalJpbUVCbStyQm1sUlEy?=
 =?utf-8?B?dnpUaHExZTNMZGh2MG1Vd09IOWVhK09FbWhOOHFvVXU4LzE5eHFkUGN0SHd1?=
 =?utf-8?B?RFY3emJ6Y3RWU2RkcHZGMGpDbC9HODh1Q1IxUmdYdjlaMXpnb2RsQ0ZSYytP?=
 =?utf-8?B?bmVlQ1BlU3RQK0R3Qld6dzZSNmphajdqdGZZdk5jRnZHUVQ3UEtIalgvc2hQ?=
 =?utf-8?B?NUV4MGxiZ3QvZWlZV1BtamNDSXp4WkdJL0RPbkM5NzhZaHJSZEJXSkU0R2h3?=
 =?utf-8?B?Q1V4TS90R3doRFRaSi9Sa1BMOGg2b3RIR2MvZnNxd2k4MVlxYldhNHU1bkNx?=
 =?utf-8?Q?ZBMRgUt0eUZJ5IDKevd+icj9GezUVFsbzzyBl?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3410b4c0-fa68-46a3-fc95-08da1669b72c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 18:34:13.1745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jz6U/hUNLRKYtbVD1j7D51iG2j0JL3xUuXwNRuSbxGlLaFns5yFnTVqVmaLABx1iblPAxXxgoYACih96lzKdVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4720
X-Proofpoint-ORIG-GUID: DYvfOPtxB0MWELAvlco8xTNEzfnBOd7c
X-Proofpoint-GUID: DYvfOPtxB0MWELAvlco8xTNEzfnBOd7c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-04_08,2022-03-31_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/1/22 8:29 PM, Andrii Nakryiko wrote:   
> Extend urandom_read helper binary to include USDTs of 4 combinations:
> semaphore/semaphoreless (refcounted and non-refcounted) and based in
> executable or shared library. We also extend urandom_read with ability
> to report it's own PID to parent process and wait for parent process to
> ready itself up for tracing urandom_read. We utilize popen() and
> underlying pipe properties for proper signaling.
> 
> Once urandom_read is ready, we add few tests to validate that libbpf's
> USDT attachment handles all the above combinations of semaphore (or lack
> of it) and static or shared library USDTs. Also, we validate that libbpf
> handles shared libraries both with PID filter and without one (i.e., -1
> for PID argument).
> 
> Having the shared library case tested with and without PID is important
> because internal logic differs on kernels that don't support BPF
> cookies. On such older kernels, attaching to USDTs in shared libraries
> without specifying concrete PID doesn't work in principle, because it's
> impossible to determine shared library's load address to derive absolute
> IPs for uprobe attachments. Without absolute IPs, it's impossible to
> perform correct look up of USDT spec based on uprobe's absolute IP (the
> only kind available from BPF at runtime). This is not the problem on
> newer kernels with BPF cookie as we don't need IP-to-ID lookup because
> BPF cookie value *is* spec ID.
> 
> So having those two situations as separate subtests is good because
> libbpf CI is able to test latest selftests against old kernels (e.g.,
> 4.9 and 5.5), so we'll be able to disable PID-less shared lib attachment
> for old kernels, but will still leave PID-specific one enabled to validate
> this legacy logic is working correctly.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Acked-by: Dave Marchevsky <davemarchevsky@fb.com>
