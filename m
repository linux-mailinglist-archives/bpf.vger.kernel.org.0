Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CC0633457
	for <lists+bpf@lfdr.de>; Tue, 22 Nov 2022 05:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiKVEJp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 23:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbiKVEJn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 23:09:43 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC972ED5D
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 20:09:42 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AM43J0O018959;
        Mon, 21 Nov 2022 20:09:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=aDttgR1oquKuenDZK2mNPTIf4/hNCO3Wd6Duk8gXSIQ=;
 b=R8+fsDD6hkghg5xWKzwjoPdoUoL8/qgLPcKx0yjJQU6SeZ5B641c0/fKsuOK1Wo3FNTz
 Mtneu+wuXfRC2jrsisaD/L5Uo+gx9IiipSW5w3Fui2K56E6C6la6mn7Rj58eDavY5+k3
 zLitswOE8apqyMRjkYK34M4p7bZI9oFQXaQdsSky0xr35Dox2V9Vbq25S4eeZ3ivYO7X
 HwbRRjliKqNXiQHpekPHId1JTB6vNRNSOUmqbM5WAxShZkjmmHD52b8oqGtE+Wlbz/4i
 yZzQ21PxPtV0BLVfcIf3VlenpJ6ZA81/m7UbHKizxqqI4KA9Ea8dx36+CNpoMjgbDdQa Iw== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m08hupdxu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 20:09:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bm5a+SUXZ0k5d/3PF4CkxYHEsJHmE+AWMgVTUaqnFD4vrsFTAlUWp3OjwIHUvzKEE8fpmKlp36E5p1jT+WX6i7oi9G6czZVFYLP/GlWNmt5qlp+rTNI3F9NP4YSMv3hC2KAYuhtYtjKgVSgj3lJ2Qr5fw7SWDxOsM8qSTZ3laOY+UdRLLLMZ53MYPs3k0xRJWmc60KSLZC2naFdQe+iaCt4tqdUsmSI11P2qKH4TiGmC6URi9e4kb9C+btYc2sJ4TSzJ1ZlZ2O6TMwH00tP5sesgmbw8Kk2gWtSlRpfPGdtw8diI46CaImCmEmSCnNQSwK6sycQPO/ZJ/TxFPHqCYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aDttgR1oquKuenDZK2mNPTIf4/hNCO3Wd6Duk8gXSIQ=;
 b=N8r8frwYB7YrhbNU2lpW0z8LbbdWB21zj9Wz4KtJbd4hfeikE8NZ/Dfbppw6Var1Zgic3gN04rtELfSJ5ZMRehB8CmIbJxcrZYJbEX38tClvg0QtgPbA6QxLUxUVgbUSI1Bw2OcnrdbdgIRT5yru1YJ3dA5FvCPZeS5Bo2ZGyDYNr2EfFqnSinEWcHY3Txbc3adCL+cEk2T8VwZogMZxHx9WtO8M9JDSCRGNtjPsMEPx9A6g7+UsMWOmlL8XjUCo2VrvsBWM+uAK+PBEPOyjt9+9p+Fc8JDsoZDSFE9OrryDOIN3nxAPQBSXn/82EuZswuDt1Jj+5lM9Gvg0HGrR8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BY5PR15MB3570.namprd15.prod.outlook.com (2603:10b6:a03:1f9::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Tue, 22 Nov
 2022 04:09:24 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ac66:fb37:a598:8519]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ac66:fb37:a598:8519%7]) with mapi id 15.20.5834.011; Tue, 22 Nov 2022
 04:09:24 +0000
Message-ID: <e577e7de-c5e9-fcbe-bafa-2b9b761b655f@meta.com>
Date:   Mon, 21 Nov 2022 20:09:22 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH bpf-next v7 4/4] selftests/bpf: Add tests for
 bpf_rcu_read_lock()
Content-Language: en-US
To:     John Fastabend <john.fastabend@gmail.com>,
        Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20221121170515.1193967-1-yhs@fb.com>
 <20221121170536.1198240-1-yhs@fb.com> <637c2d1826988_18ed920851@john.notmuch>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <637c2d1826988_18ed920851@john.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0054.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::29) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BY5PR15MB3570:EE_
X-MS-Office365-Filtering-Correlation-Id: d2970bd1-d31b-4a7a-96e3-08dacc3f5725
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CDvIe92MeRZQGnwrrHXfeJ49KORPVa7KFXl1qo5NUTb4mOkQGRS2lwmo/kfa1z+ZKCDk3zJx4JiPMFaBhovzGwA5VTdgu3elQXgAipberE0oxZnu27lxBYceV91eUlr88I+Z2rkcRm1Le+7GLoLVNN6OV/NbebDywktOPfAoWD8276PBpEdJwlUPK87ZMr+K6FS7m8/H6sknmJgGWcw6uVd6N1J3m7qNeX9UNHGFPAjERIU2/8zoyccWpvaWtW2mi/9iCLyRZJeREG5EBNNGmRCl+tp9fqFuPFYw+3uL/pLb0ZqmTT39+yCJD0j8uHES1hHgU8Vdc6+mLFjuPYCBtJDxl+J6lWBMCpYW2R23J3eyIFuzUAfapHw2SMpp24wdqcnhND+5TJ02XvCqg4woemDFnYujTqsrSYBUJMYFWhFhlU3xUDMHNqNS1fmmeK5T2PNsJ/Rgk/qgYZ+uOxziSzU8VPpFEDr/cLtzQeYoHY0cuv7wnaoe5nBJwQPntXYDxMswR5w2twiOBSYokKPRrMpoa7/0bFSb0ocivb10t84wtiQXhcmIhKh3fvmdmlAPaZ68NVkNHWxoIhco4ed6wFAM0RXCBCrLtvI7MpKBCGNoIwSoUHc1v6Wclz10R9JGtMWlehlviWANHFAQh5xsxZYt0bAtuQiUMTWj8TINEqN7hbz5cQfmDcFsYYrf8OpPSFGNS6bIDV1fa3lRTqw7NZNUVOsczRkAv6uPqLRPX+k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(451199015)(2906002)(83380400001)(31686004)(36756003)(66556008)(66476007)(2616005)(66946007)(41300700001)(86362001)(31696002)(8936002)(38100700002)(6506007)(110136005)(54906003)(5660300002)(186003)(8676002)(4326008)(53546011)(6512007)(316002)(6486002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzBTVmpwMCt0NWI5dEhUZHFpMDR0VUMvVUU2NnhtcFhaL1dDandvUmEvbTBw?=
 =?utf-8?B?b05oQlNCamphcFo3NTREdlo1NG9GL2RKcU9FUjJJSjBZYnN5T2RJMkV4MzFY?=
 =?utf-8?B?d1dEZmd0aEJIdjVodFBvZTNMUHhMZW9tK1o4ZWMxR2hvTEFtV21DdVlhcFhT?=
 =?utf-8?B?OGZaMFMvL3NCTk9CSXUzdjBCWWYvR3MyVyt2OEdvWExiZDJ5aGtUQlEzYWhw?=
 =?utf-8?B?OWJMMGEySVhwclZoQkJsbzhId0JsLzZjV2ltckliUmUyRlRkNmU4cDhYejNT?=
 =?utf-8?B?TloxTE1CVFNUN29LOEdnUktaUzI4R045aEh2NVU5MWNJRk5zYjB3NE51YnFZ?=
 =?utf-8?B?S0NudDZCZnJPcnFQTE9SL2M1WlUrU3lDYVRvQldrZ3NLa2pGNXAybG5adEJS?=
 =?utf-8?B?VGJsK0VXN2VYWXFvV1pJQmNLRXFTK1VxVEovT29QKzl4N2tvM3BWQlNVYlV2?=
 =?utf-8?B?UFVORUdWYWU1c2xRMUFQTE1zK1VlZ1lPZlF4MWl5bW1USDkzYWxjWk1DR2cy?=
 =?utf-8?B?ZHI5QnlyeldLcHFkby9WVHJ0cTN3TU9nS2ErSi95ZUxhNTRXK1FobERCcGFn?=
 =?utf-8?B?Wk54WHJzOHJhTGxqV21WbEFqMVVDaHI1VFg2NENUTkZaTzVvQjJnQkptMmQ1?=
 =?utf-8?B?WkFzYiszQ3JFSHErZnRGVFdLOU80Y1pCL3ZQdVJkUmFZTHVhS094M0ZERkxz?=
 =?utf-8?B?dENQWTdZTUN4QVBadTdseDJZeDVSSEdJOXlzWDFIdmtFQWZlQ0ZHK3NSTU5q?=
 =?utf-8?B?U3BQd3FqKzBOd1FsaUtjVVMvR0ZpaEFVNTdlSWFCV0Q2SVJpT3J2SzFkT2dp?=
 =?utf-8?B?TDd5SzZTeHRQak1QQllQVHFTVG9BSElPUzFRNTZFelNTZmpPWHVKZ0dBdjgz?=
 =?utf-8?B?dnFOZDBHbkhHa1htdDRDLzNjczZ4STQyVWV5bmhVWExPemFaNzV2eWVRa2g4?=
 =?utf-8?B?K2tGYVdHQUV5cllWcUx2MDMrejMwSlVFYWNDT1ZINk9iakhPaGt1QVJtSHpy?=
 =?utf-8?B?eXF2citBY2p6ZVhJTkszM0hCYlpIU2pHY0I0bDJuR0RLcTBUQnpYZmNJQXBa?=
 =?utf-8?B?bCt2SHJzc25XejNLZVNjMUhjUW1hZHFYdWZ5enpDYjBRWUVsOHdCM0loSDIz?=
 =?utf-8?B?bk12Nk9BRkdVRTdwd1NJRFFBT291ajlQbEhMYjN0Mk5id3BkbU1tWWh1QWpD?=
 =?utf-8?B?VFY1MVlwdkkyWU1BZXJMN2lIZ2NsYnJ5QWh0c0g1cWlLRnAxckNqRlFuMStn?=
 =?utf-8?B?UE0xR1BEZjV0eUc1ZXZVcXBlL2x2cllocTdJVVNJOTlRQ1FmS1NjVWt5cUxV?=
 =?utf-8?B?U0s4RkwvUGR4Vk9udkpONnhnNEF5d043K01GenFiZUIwWUI3aENqYmZoZTF5?=
 =?utf-8?B?U0xhcEl3bzIvalVjUHJsOThIT0toRFdocFV3b2VHS3VmMUlCQzgxcEMvU0Rw?=
 =?utf-8?B?UHhQeDlsSEVoS2E0Y3BnUzNWVEhuZ040SlczWEtxYVJoWEpOcG0wRHlRNytE?=
 =?utf-8?B?UHJHaExtelQ2REZvTUdMa05saW56TUpwclRRSjhENEJlS1F1eWFXTGdjRzJF?=
 =?utf-8?B?TndKWlhNSzFaTTdrQXZ6N1o2ekZEaUlWdURpMmZxVGN6NDZLTkdaQ1Y4clRl?=
 =?utf-8?B?TFBDbmxEcXRlYVNxeHUraXJvSzZEU3Zhd1duaFFLSTRLbTRmWWlEMDk3RXkx?=
 =?utf-8?B?NEo3Mk4vTGVLUHd6WDVRVThsMGUyMnRmVVU0TFUzeDFVTS8wellJVzRBbWto?=
 =?utf-8?B?MlJqRE9VNHF2NVF6blhRYm1aRkg1TEpwcng4ZGZtekJwRFJJZzJkc21jcjg3?=
 =?utf-8?B?MDk3RFE0SXQ2c2JpdUIwT21WeE1XR0FUTitoVEtTTmJZRDY2VUdVcW1GNmNk?=
 =?utf-8?B?K252eTZMWDdUbkhEeGN3aUV0ZHpVR1Vwbjd2YURvdmZ1clNaVnVGRTVrdUNm?=
 =?utf-8?B?QURNL2JsYVoyOWUvVXJOODdYb2FTV0wzT0dWUGVwMmkvY0l2NjVWQWtVazYz?=
 =?utf-8?B?TkI2NEY3dnFteVhXT3M2d3lLckJxZGtnOGlwVHZtWjNlS0R5SHl4blJIQjdW?=
 =?utf-8?B?VjNkcml5MVJYd1NiUnBJanBHNmJ0Z1ArTVZQeGRUZGdVRFBxb05WWWFmZjEr?=
 =?utf-8?B?Tlc4TklidGUxVk82VllnSGRiSjh6TEhobUFMNFIyVmF3SXlXMVhSbk02b3Nq?=
 =?utf-8?B?L0E9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2970bd1-d31b-4a7a-96e3-08dacc3f5725
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 04:09:24.4683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0REd5xclNtin5CNDtdhy67bS7veBgOxr9ALRDivA1TTucRVdC7iz0w7UjngSAhA6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3570
X-Proofpoint-GUID: FimiTjIG5PHnogzEAOtC1MV_t_qYJHuj
X-Proofpoint-ORIG-GUID: FimiTjIG5PHnogzEAOtC1MV_t_qYJHuj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-22_01,2022-11-18_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/21/22 5:59 PM, John Fastabend wrote:
> Yonghong Song wrote:
>> Add a few positive/negative tests to test bpf_rcu_read_lock()
>> and its corresponding verifier support. The new test will fail
>> on s390x and aarch64, so an entry is added to each of their
>> respective deny lists.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
> 
> [...]
> 
>> +SEC("?fentry.s/" SYS_PREFIX "sys_nanosleep")
>> +int nested_rcu_region(void *ctx)
>> +{
>> +	struct task_struct *task, *real_parent;
>> +
>> +	/* nested rcu read lock regions */
>> +	task = bpf_get_current_task_btf();
>> +	bpf_rcu_read_lock();
>> +	bpf_rcu_read_lock();
>> +	real_parent = task->real_parent;
>> +	(void)bpf_task_storage_get(&map_a, real_parent, 0, 0);
>> +	bpf_rcu_read_unlock();
>> +	bpf_rcu_read_unlock();
>> +	return 0;
>> +}
> 
> I think you also need the nested imbalance case is this
> handled? It looks like the active_rcu is just a bool?

Currently we don't support nested bpf_rcu_read_lock()
regions. So the error will appear for the second
bpf_rcu_read_lock() in the above code, regardless of
the eventual balance or not-balance.

> 
>   +SEC("?fentry.s/" SYS_PREFIX "sys_nanosleep")
>   +int nested_rcu_region(void *ctx)
>   +{
>   +	struct task_struct *task, *real_parent;
>   +
>   +	/* nested rcu read lock regions */
>   +	task = bpf_get_current_task_btf();
>   +	bpf_rcu_read_lock();
>   +	bpf_rcu_read_lock();
>   +	real_parent = task->real_parent;
>   +	(void)bpf_task_storage_get(&map_a, real_parent, 0, 0);
>   +      // imbalance unlock()
>   +	bpf_rcu_read_unlock();
>   +	return 0;
>   +}
