Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24625626520
	for <lists+bpf@lfdr.de>; Sat, 12 Nov 2022 00:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbiKKXC6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 18:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233908AbiKKXC6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 18:02:58 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6E611C0D
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 15:02:57 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2ABJOO32029543;
        Fri, 11 Nov 2022 15:02:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=1U62ZoH8dXzC2vZ97CF4dey8bHFL5h0tp+LjhfBgU2Y=;
 b=HBblGo+R/82o2/wf5MMWT3WjN2nZLW47ff8id7o8XzAsTQwzsXzs4cTae7MwrSNg9Ute
 YqsjLNiUwROo832YE2sB1DafDx4bH8FEofJg5xUnFxX1O9D4x92aIX1Y9ZpRUpgB7b2j
 JWh1Pf+oyFksfcxXkTnIMLUqjTg4IadznIgaNk5GvQ5RfSWtBJISb+S/daNmNdlkWTGv
 0rA5hX1haYNcOhH/sUCiALj0BcAN9qkSU1F+VUmFhUeWFbNZIBHe76qb+zRNKgMMNGly
 TDjHDw2ZJ1KTewe2uGdu/rt4T4eBDwPtJEdlaa9s0/1XpJWu5n3JVSb1MEYO/RhBJpag gQ== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2040.outbound.protection.outlook.com [104.47.51.40])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ks3nwkvff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 15:02:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f0iMDM5F6dObJ3um3iAnHmt4E+6o3AZB2acgKogSBx3D7v6eGpTm872Cv6P/yXLwcjhVDSIRPOOTTRudjhGwWWhCYxSuf+zFRnr70VQpEyp1Rv3vzVqOaavc0iNJGf6qRliMgYTYD4wPjDEUIRg89tCbLRRzMzQJREd1XGxl19+eBbLYjeJYJAdGdH/W+gPDFPwCzk8zBf+SHRK9fyRE/7VEvglWpMsmjujptMsN9Ql7ggGGUyCNJinGu9mRXRQozoxNM20Kg6SR4FzqrCQsd/M6GhgjxG1O09ReI/8XEhSkvFsVVbbKRHMBuHxqXA+khI9qj8Lz6Xw/FP1aZ39fkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1U62ZoH8dXzC2vZ97CF4dey8bHFL5h0tp+LjhfBgU2Y=;
 b=HHLLRfR7g4fRzxGjDtPPX4rDUCWfZQ1me8qAHEnd11vc9tXEXg2DfKTTCTZIvwG8JhOPmnq0PNie7SuqQuCGOTdw3P8I/wa5uP3L/7MDRHHKOqnApwg7EUBnW0W++zoEa+LDSAG5PUH1U/Fa/in4de49upiVZQpVuWfyesAv8zCYEa0yQQU+MeivrDX+qU/Dc8P4bmH1rLW+Dk2WwZW6lAfvMTjANUaidw3Tiq1lxQTlX9JvUyf0eB48yjNNOYvtLfZzXgdvZE3PN4a3kjv/g3mNLw9xCbBNZ6TeX3ksI/UzPWbs5xkSfPq8kTmZ+T2tc8YAW0vCndhSK7v9CODZ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BN7PR15MB2308.namprd15.prod.outlook.com (2603:10b6:406:8d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 11 Nov
 2022 23:02:16 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ac66:fb37:a598:8519]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ac66:fb37:a598:8519%7]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 23:02:15 +0000
Message-ID: <7b04d3b2-3a2a-2408-6c14-742b5fd84123@meta.com>
Date:   Fri, 11 Nov 2022 15:02:12 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH bpf-next v2] bpf: Pass map file to .map_update_batch
 directly
Content-Language: en-US
To:     Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org,
        Yonghong Song <yhs@fb.com>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Xu Kuohai <xukuohai@huawei.com>, houtao1@huawei.com
References: <20221111080757.2224969-1-houtao@huaweicloud.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221111080757.2224969-1-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0087.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::28) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BN7PR15MB2308:EE_
X-MS-Office365-Filtering-Correlation-Id: 18a20f79-80e0-403d-5bb3-08dac438c679
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HtBh2aC/99MqYnM8JTYaznXzv65UHwnxEFonXXLZbw/qZ37xHaY1LxEqMyooP+56xB7F6ijinceiZYQhQTvASaygnjLFKyTjf1CPQ1rvNlTu15ZDYjd/wnRe2Kgd5nIWEDicdao19AUZkhb5qmuxKkV+IZFQFWFX1kOwDbQF0tbaoWohBLzhhVFSQ3pVpdLRJYETkMFJi+33MiuP0jF183DclSEZ4iRjfQo2w14yAYgTx6YbifcebD6bcX0JAD64BxLzs52ONzviFFhlyTEBPQS5wIDk5vmIUDFlXuD8g0RtQae+OoCxt5fch5AAUDIrpV+K82TCSEn7ZE2xDuQacShPq9Z1owxZ9h41YQE0WXfiHNki7+0yLlZSDoz876pbm5D8aFtznwE9lN+yrdypT2VvkwzGux6ReyUMi1l09/vOkqzSiWyIIbWKTYZaMvDUA9t7BE/WM0Ppc8trOdAK2537Ng12WoGKL1c9ShdePFGns4YThSs9piEZNgD7m0Ru1ncINkUykMGAXEdcyBinmTs5gvGh0VNSczH7JfL2WLcUSO2q+3umRPD60AAmMemRtZG0NqHlGu+HYBbGd4j9DRnq43NZ1XSW9UdcLFDJrf7umptJ6TwOaoC3oJgS0lqRGc5UBfwHLapqHjunvicYTjG2y850BiGqfNnmp5VmNXrIwOVtoeJ+/M1fzMi6J3KkLgWT7wlSHBISZ0JOb8jy9gsDa8ypHIlGuQz5wJjLGZb2uwwZafmsQ+nZd2VeR9jFPe8/4lVikjDN+PlJWiNchYC3z+wLEnMvaBKz+WbHI+1mL4BAlbFP5ya5Y9actDCx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(451199015)(53546011)(2616005)(8936002)(86362001)(83380400001)(66476007)(66946007)(6512007)(66556008)(8676002)(4326008)(54906003)(6506007)(38100700002)(31696002)(36756003)(6666004)(110136005)(316002)(2906002)(41300700001)(478600001)(31686004)(186003)(5660300002)(7416002)(6486002)(142923001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGxneFRNcllPZG5uNjE2L0d1ZGFSMGVuNnhYajdiT2pQUDhtSlg5L1hWeGdK?=
 =?utf-8?B?VlVPYWRSV3FYSlFQRG1IbU1wVzY3enFrZms1eElNbFNnL0ZTOVliQzYwMlYx?=
 =?utf-8?B?c0pPcjY0SXBnNHlRc3Q2akE4UWVUdjc3bkhxQ21sdnBteUhuTll5UXI1TzNQ?=
 =?utf-8?B?YUg2WkFGNHhMQmNieUFxK1hIeEsyM2NWMEUzM2dnYk1xWC9qaDJ1dU9PSmhP?=
 =?utf-8?B?KzlXbThkR2xyYTE2UkE4ejBLVUhRaFhYbUZBa2l1V1Zxck5Malo4aUN6NFZq?=
 =?utf-8?B?dmtqOEZ3aVhlYkZHTmh4RVJFQ3JxeWJWbWVmR3lEbU02UHR2cEVjWlZ0MjZ1?=
 =?utf-8?B?aVR4VDE5OW5PMXdUbk9adms0c1Z0Q0pxUk9TOXJrdUZKMWRmQ3ZZSXpEYXZ3?=
 =?utf-8?B?ZXJLVjd1NVJwUTFHcDB4TkZzbEFqeEJWdUFRTWRiMkI0ejlVdjJrdUJXUlpI?=
 =?utf-8?B?WUIrWHMzTVpqUWxpK25YRVgzM1F5cnhjNk53WGJTdG40TkxmYlUyN1VMamhV?=
 =?utf-8?B?UmtPQTR3TWVuaW5tNGRhYnorazdsNTEzK01jSDdRcjh6enkwQjRrMlN0RC9X?=
 =?utf-8?B?MmQwd1gzRnJMWVJkQi9hdXJpaE41Tnc5eVNWcDFCQW9RK04yRUl3RGxxK1hL?=
 =?utf-8?B?ejBFUHRTcGx3QTY5ZjAySS9zb3FESUpIRko3SDJoQ2JxdjdOdUlIcDF2WUtn?=
 =?utf-8?B?ZjBpZThqcU1nRjlZa3VocFpaaDhkeHVkcXl0RUtwUkRlemMrcTBBZGt2VlJW?=
 =?utf-8?B?Q3dkWWhNQ2VKM1hoMnB1dXRCeWZoTm9idEllK3MzM2tnMkVWT2lXVHA1VXRX?=
 =?utf-8?B?MmRUN1Jvay9iZDBrZDh3dlcwR3pTaXduRXJndFVwcVIvWVE0clZCZmxQbXZy?=
 =?utf-8?B?d2pMNStaUHRIWVdkT3JMSzNleTNFVi9sbnVtU2MxWElpbzUzUWRWc3hsek1W?=
 =?utf-8?B?Sis2SXIxbjBoSS9nZ2p4NVJoV3NSMXBKTVBQdXpMdnF1NTJVd3daMGRHOUEv?=
 =?utf-8?B?UU5vL2srQmpPSXl5Nko3R0Fjd1VTNUhFK3JrRkVjNkJ3VjRPeFZmcUNFdTdS?=
 =?utf-8?B?VXVIQzY5ODN5aGhMYXpLeUxZZDhtM2ZleDAxb2tNSVN1NUxsbE1lSVBZQ2tE?=
 =?utf-8?B?QWNUWkFuNHBZUUY3eVJwN1JEQlU5SmtLZ0oyN2dPRC9nN1N4dzZNbkF5Vkc1?=
 =?utf-8?B?K0IxbkQwcjI3S0V5bUJjdTBFMzl6MXZCNmpqc0s4bEY3RUs4d2l6Nkl3Smcy?=
 =?utf-8?B?Z2g1ZmxQY2hGN25iNHI5VTI2QjZGa0czbEx4RGNiNmg0OWRYYVVjOWNMcDBB?=
 =?utf-8?B?TCs2K1hxYnBUWjRHTDZhMG9OVDJLSHA1Zk83WFNzeVI2bHBtUUJjNnEvUkt3?=
 =?utf-8?B?aThjcWg5eXNhZ2kwalVLeHU1bWJ0OWxodWNlaHNzYTJIZk9VOWdHY09yOTEy?=
 =?utf-8?B?ZGFTaVVDT0FIRUJ4SmpLRHVKSHhEeVZsRXc3L01xUUVjOU9vc0VXRGdRZEpS?=
 =?utf-8?B?VkZ3TkE0SW1nTWZDRUF6UU5YL056RmZYQjB5cEdDWEtvaDR5VGFMcU51L3Bn?=
 =?utf-8?B?RnRQbEs1T0JKZStWbWxmOFpMWjZmOG9zSGY0ampUZmtvNyt5VDMvNisvTWVn?=
 =?utf-8?B?WWQ2ZkxGZjF5RVowbzV4dmRqY2JzZ25RdEJyc0cwaCt1ajVJK3R6WkxiUXFw?=
 =?utf-8?B?SFoyaTBRaTYyTENRZzlXU2M2VlJNbzRJWklUQ01DVk1yU0hRdDZLT2xGWnJ1?=
 =?utf-8?B?N1dsUmR4ZXR1V3l1aTNnWkF0WjBVdGJ2MzNad3d6bEpxbnZpNkVzb24wZUFL?=
 =?utf-8?B?TmZoVUhJMXk2STI4WkUzVC90eWxycGVKM0dGdU1PZElKTU55MWNxYTZRN1FO?=
 =?utf-8?B?a0g0M0pFUlowT3haOEpFL2YrbnNFR3llY1RZUHhLbEo5NXQ1OFFFN0xWeGdt?=
 =?utf-8?B?YzgzZ0o3dEVyUFN1RmhFdWJKQ2VNM1p0ZWhyTFVqR1o1V3RCa05pSllRS1R1?=
 =?utf-8?B?amRIN1RJTTZvUlIyazdWZlBrbkhGVUxsbW9hd25uQ2ZxUGI5NXlkQ2N5Zkdk?=
 =?utf-8?B?Z3VKSFl1c1I4Wmd1bDYxcEJNMGlWUGdoUGFIMEVjN2xTYXpmcmVSOFNlWVFH?=
 =?utf-8?B?S0F4ZFJZaXZ6Wmpkblg0T2NOaXdmbkRDbmw1ajNPRWJFS2FuUVlJa241dXlv?=
 =?utf-8?B?dVE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a20f79-80e0-403d-5bb3-08dac438c679
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 23:02:15.5744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WLtqKD4at+RK0XBL/2lbiVW4Nye+1kP75+N+3GoAhCh7mgJpoK00E2Ze6+EzNT8/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR15MB2308
X-Proofpoint-GUID: IyUeXi4K_lPDmhd-ujyC_z0YHd9heQb5
X-Proofpoint-ORIG-GUID: IyUeXi4K_lPDmhd-ujyC_z0YHd9heQb5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-11_11,2022-11-11_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/11/22 12:07 AM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Currently bpf_map_do_batch() first invokes fdget(batch.map_fd) to get
> the target map file, then it invokes generic_map_update_batch() to do
> batch update. generic_map_update_batch() will get the target map file
> by using fdget(batch.map_fd) again and pass it to
> bpf_map_update_value().
> 
> The problem is map file returned by the second fdget() may be NULL or a
> totally different file compared by map file in bpf_map_do_batch(). The
> reason is that the first fdget() only guarantees the liveness of struct
> file instead of file descriptor and the file description may be released
> by concurrent close() through pick_file().
> 
> It doesn't incur any problem as for now, because maps with batch update
> support don't use map file in .map_fd_get_ptr() ops. But it is better to
> fix the access of a potentially invalid map file.
> 
> using __bpf_map_get() again in generic_map_update_batch() can not fix
> the problem, because batch.map_fd may be closed and reopened, and the
> returned map file may be different with map file got in
> bpf_map_do_batch(), so just passing the map file directly to
> .map_update_batch() in bpf_map_do_batch().
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>

Acked-by: Yonghong Song <yhs@fb.com>
