Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D584683522
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 19:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjAaSZu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Jan 2023 13:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjAaSZt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 13:25:49 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFF327D7E
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 10:25:48 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 30VIGv7H032460;
        Tue, 31 Jan 2023 10:25:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=yT1shnZSKJzAtU4KIoIHg7pbmFQUjPff8y+GXReTkHc=;
 b=X1Mx/KI5CeCLYroeuTrtXULH4WIgkclLKTntAFIEm9mGWSzmYxu9Ko/Jaf+bcMGttH57
 tFJIFJTMghK0cjE7lTX1nb6RyR6o/YqXKh/xnEtdlUXxAdYv7q30KUJyZjBdzMya5Hok
 gvdsRVZWv6DHd7TFgSuHj2eG7JwgRbtz9EwL+BB4JRyumT0DsBoKRCwwz8LsJP+Jn6Ua
 3Q5xl5ShhIzuxiRux0YeZA46CJ0AjA7Ms+r05BpSlR6neSjmzkKSpFNMw8zWwalK9Lgs
 37QbswBX3DuDB/cCb6/Ro0YVq4PrzUmJsvq+8jH1vgNVYB/6YUHgxlM2fME8WiOyUip6 UA== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
        by m0001303.ppops.net (PPS) with ESMTPS id 3nf37etw78-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 10:25:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oq2Q+b9XCx3XTpiJaWs9S036Lo32LZFHBCAvXL4OTi1v0zvj+qJHsKFuZt9jGMWFXfVUUjuucZhPv1Jz6H9laeIITGsDo51p0M5+ht0woUHt3Q6QwW6BSzyOnYsd4OGDZUxhXoO6ZtFYhpPxSDRDpOBBTopJHuZN04kYq9UUjyJutIvsNs/WUWTbQe7WyAXuKZ/C+pIE8iFKYbggq+BJeWCN7/+ctmaN1rbalfYUS2Vc2Jc4E3rbrXMHoTpfyfoovfLlsqoYHvwZkQg7sL3tCWCr/UL464k5niDGjeMUaNeUHNUKPz1b7YoZnus6g0m1JEv1Hb5OCBEB575LK7fbkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yT1shnZSKJzAtU4KIoIHg7pbmFQUjPff8y+GXReTkHc=;
 b=U7MW7Lzrt9G1lIuwhqaipsO+CmdO7i3paEbcR/GjV1hV3LYmzyVPhnQX91vU4LypWjzIzuKU2XCc0jhOFPTAfSubXWTmS7q5rFvptkqQlHn38uhzgS9HGgNmzdQ/UXEjFTMTuKuIIWcga/LEir5r3FNCUtohARXQRrlbh/Hjanto9dZSSBhJsJyffC4njw3/rxkykdW1WkqkYfj5UAgQ1untPcCcowSzVxqUxlhmlNffI9Annxjs6LDI51MuwA9O/tS6Y97Phc3FTE4TkiiJwepPaLQQn1QDGrmfKDQUmQXfSDzPFvwMgW6Qa5cERNyjjO6zeAN9vD831rX5uqNR8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MW4PR15MB4442.namprd15.prod.outlook.com (2603:10b6:303:103::13)
 by PH7PR15MB5428.namprd15.prod.outlook.com (2603:10b6:510:1fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 18:25:30 +0000
Received: from MW4PR15MB4442.namprd15.prod.outlook.com
 ([fe80::a677:2a9d:89d6:b1d1]) by MW4PR15MB4442.namprd15.prod.outlook.com
 ([fe80::a677:2a9d:89d6:b1d1%9]) with mapi id 15.20.6043.036; Tue, 31 Jan 2023
 18:25:30 +0000
Message-ID: <05779f7b-6b60-33ad-1c25-a4017fcb8936@meta.com>
Date:   Tue, 31 Jan 2023 13:25:26 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v3 bpf-next 02/11] bpf: Improve bpf_reg_state space usage
 for non-owning ref lock
Content-Language: en-US
To:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>
References: <20230131180016.3368305-1-davemarchevsky@fb.com>
 <20230131180016.3368305-3-davemarchevsky@fb.com>
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <20230131180016.3368305-3-davemarchevsky@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0204.namprd13.prod.outlook.com
 (2603:10b6:208:2be::29) To MW4PR15MB4442.namprd15.prod.outlook.com
 (2603:10b6:303:103::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR15MB4442:EE_|PH7PR15MB5428:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e45f5e8-c498-4afb-1efa-08db03b888a9
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W6ebEQLrjHcFuwvuUpPwL36Ol4sQcYMOThHSm7aXNrYCRwjF/bja++Ek2v/bdDmZGRrnCULG2hGpWi1dKT1Dn1sLpXy1JijSGKplb38M3+M5MQfp6X0uI2FSrLczy959xdOL9gZXUl+mnq1ch71QS2hdula7I9dglnVg9i8xyHS+4pV04q+AplEOslCBKORFrrgZaZpw/ae5dv6rPLlNwhsnnPqRkbegwZ0WpR9xolUDFMKeml2F8IpIS+WfeFB9PyNYkCDNWoRReVN2KvGecRACNB5hDbby//FLtHOH5s1Kd1+kuVy3GC38eTwIhQ6apNIvOV6wlC2Ju6nuJiio/oHkKRMC8xf5x48pVI/ZDvr0bmS8jYAZi17jJ388eABIMbXg71XbyejvrW0potUKsrAUM3i+2nTnlroZYhoGx8eUo0w+7zJsLFFi5tJ0kOEj59I6VUucvlY4HhT7VGXGoW1HUbRsId7NjxvHI0NA/PY6ZR+iHfbxcGJKLezJ+NH06Yv94/61xD1X27/MJ1jtpCKwY/JGqGuuOcYGhr9EvZA2l4Bp3t/PhwvDHtT+hbDrvZTUpyYEpjAFY3zgXxYQHPfGyF0zdIASNq+DaXVRibNy/ZLdKzG+n/WUPGVZjuCScim151dbixxZnD4R4vmbHI/TM+aQrFkHMLpIBtWVs3tnuUVocN69AwUJtILA0xzcjgSlRGQwYhHrGpXEYa7MjxFkAN2ROZxzl3dGBHhi7gc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4442.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(366004)(396003)(376002)(136003)(451199018)(31686004)(2616005)(6666004)(316002)(83380400001)(54906003)(2906002)(36756003)(38100700002)(66946007)(53546011)(6506007)(4326008)(66556008)(66476007)(6486002)(478600001)(6512007)(186003)(41300700001)(86362001)(8676002)(5660300002)(31696002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVEzS2NSTjMxemdVOVFUVSs4Unh5RE5wRloxWTA3NlFwZHBCNHo1QTlacTNR?=
 =?utf-8?B?QnVseWRmUWF4MVZYb2Vza0JDUkxsWk5abDh5bFRWRzZ6V2NrYTRzNnJ4MzR3?=
 =?utf-8?B?VU9nOUwvM2lucWE4dGU5M3pCWkJhTkRNYjJOaE9CaVlMVzhMZHYvdEJWNm5k?=
 =?utf-8?B?SEI2R2M0aXFPYW1XY3FVd0FsTmUvOE1UKzdSYmkxUm83dkxCT1QvcjdTa0tH?=
 =?utf-8?B?dkZqVTJoV3doTExROThGTXl4elVFcDRjdlh2Ni92TmJzdmh1VU5hblJtZUJs?=
 =?utf-8?B?MFphWjYzejhnWHFURkhJZ0paMHVMWUxUdEZLOUtldUtyd0daYUpjbHJ5b2Qx?=
 =?utf-8?B?V1RTUDRJR3FTQ2x1U2RqTGY4ZjdneG9XK3BQb3JzRGpsMFhWcElBalFlVUZq?=
 =?utf-8?B?OGJ1M2hiem9laGF3bFBUNFMzZUxSN0lLb1FJSTVsVDJ3dlRpVHZwSXVtOVFk?=
 =?utf-8?B?aW0vODBKWmtnWG0wYVNwRVpQWTdxRWlHSHRoMTVrbEEra292TWIvNFJCRjc1?=
 =?utf-8?B?TC9DMytFOE50R1VrU2hoY3VaaUtpRHhTLzNHSEZ6RFNzZ29SYTFnWHZRNEJQ?=
 =?utf-8?B?dGM4RVVKK3AvTWl4V1gzaUJQY01aU2FXU3pIdmtXZXJQYTdHTjEweEJBOCtZ?=
 =?utf-8?B?RUVob1RlVUVsSm5UaFpOaTMyK1ptVGZNWFRtWFR3Y3k3MVFaWVYybGVTc2VX?=
 =?utf-8?B?WkcvdXNMK2JZQ1BLQzNJUEs4S3YzQ0RQY1pVUGVTL3ZBOXE1bk1sdmYzZHND?=
 =?utf-8?B?U0I5emVHUzVqdVpaZ2FaQ09mcDM2dVJKekpldWQ0Q1NXdU12K1RiN3Y4YUwx?=
 =?utf-8?B?YkNxL3BRQVVWeHJxN2NUQzlIVmFKWVYxQStJckJhczh5R3lOWStPVVlQbDFJ?=
 =?utf-8?B?L0dqS2NlQklUSFh5WDk2Si9qWVFydU83cDlSQUhpZVFmdWtMaXM1VjU2djN1?=
 =?utf-8?B?SHlDbFUwN3UrTzJpL1VXQWFkTzIvdDdWekIzaGx2ZDc5U3BnM0NkTUFjQWtW?=
 =?utf-8?B?WmVJUXduOE5UZ2hlUzg1Q2JWTTBjaHJCVDB5OEFLVmdZdTJVOFZDMkhuc3Rz?=
 =?utf-8?B?djloK0FEYXp1V3dBSnB2TVMvam1ZWkdmY1dHcGlTU0xCYmJ4S0t6N2lsMjc5?=
 =?utf-8?B?QWV1bk5CY2xOWDhrZkZ3ZDVTR0RSd3NnKzlkVFBGT0w5Rzd4MDhOakdsTjRl?=
 =?utf-8?B?RVcrTVNyWXV3dUNncnNVS0h5UW54NkxtV3h0ZUN3QWsvVVU4MDJOSC9JOHFa?=
 =?utf-8?B?RnZOR0pLd3dObUgrVDk2VXNuYWFiUlBhdDhhNThIRUNjWHlzYXRSM0tPeURj?=
 =?utf-8?B?WUdQTi9kdjdrSzV0Mi80dlFvTERqdlV0ZzNESkwrSENPbkpreGY2ZUVqbzJC?=
 =?utf-8?B?MlpQdXFqam1Md3RoNFE1Zk94RGtBam5XNzNyeDhld0dmOU9wREVuVHU2UFlq?=
 =?utf-8?B?Y2RlczE1ZU80aTJLdXNrL3JoZThaN3RPbGFCNlkyUVBBTkI4ZXFuS0dsZ2I0?=
 =?utf-8?B?MnNnck1tZ0J1cGhvZzNBa08wbERXYnR1ZmpMa1oxU2FIY3lteWtaS2kvNTJN?=
 =?utf-8?B?UnRLWFVDYjBYZlZpTTkwa0Qwa3JzSk9DUFhVWFdwd2JoRUNqQm1UL2d5Z29U?=
 =?utf-8?B?bEdOajBqdVhnaXVTYzVBNXZiOFB2MGtUdTJnQ0FkOE5EOWdxSnhRQmZ1YlBY?=
 =?utf-8?B?U0Y2amVQK0FaeFRyRmk5L3lSSTVwYWFxUVNxVkxDV1JIRkV3alNvT0dUOEJS?=
 =?utf-8?B?SEVnWHNFaHI4dHRvUnU5cExKcVlnM3BZN2JxbWtrTUVkeVJRMlhZV1JUSXJV?=
 =?utf-8?B?Z3NMOWlVd1hldnp3UStMbkpnYXNTUll3UzdRcGdjbWgvTldZR3VJR3RaWnlq?=
 =?utf-8?B?MCtKV2M3TTMxQW1lZUJqR0dVa3ZoYVBwdi9KWnA2UG1FbWQ2ZzE2azdqS09W?=
 =?utf-8?B?QkxCV2k1OXdXcFExcUxHNy9kTnRlRW1Sd3JpOEl2ZHZSbUpXUGZsQjd0Zzhu?=
 =?utf-8?B?UDNYY28wcjA5UUg2OE9NSzBhVTN6c0R3U2psdzlwaStVRWMrL0sxQXJZM0Fo?=
 =?utf-8?B?VU4yMWE3a3NlbDJvV1QyN1d4cVN6R3ZoRkZRU3ZocmkwNmFVbVBXZk9ZUkI3?=
 =?utf-8?B?SkNUZGJFVXo2eCtBV2tnTmc2TUswQzJiYi9ZN0E1RkdITkd2SVYyVWNFL3Ez?=
 =?utf-8?Q?9DNjYMZOawguevdER62i0qg=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e45f5e8-c498-4afb-1efa-08db03b888a9
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4442.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 18:25:30.7065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4O+ZauJ7ar0dYi256nFXIXK3/y6/3PfJ+YvBRSZER2NTXBrBAL0afHzVxEQSYklKgt3ZdhvCzZHg+blr4/BcLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB5428
X-Proofpoint-ORIG-GUID: KbSrqxX7zbVxwvnrQTpzSH2xy6F2IPA2
X-Proofpoint-GUID: KbSrqxX7zbVxwvnrQTpzSH2xy6F2IPA2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/31/23 1:00 PM, Dave Marchevsky wrote:
> This patch eliminates extra bpf_reg_state memory usage added due to
> previous patch keeping a copy of lock identity in reg state for
> non-owning refs.
> 
> Instead of copying lock identity around, this patch changes
> non_owning_ref_lock field to be a bool, taking advantage of the
> following:
> 
>   * There can currently only be one active lock at a time
>   * non-owning refs are only valid in the critical section
> 
> So if a verifier_state has an active_lock, any non-owning ref must've
> been obtained under that lock, and any non-owning ref not obtained under
> that lock must have been invalidated previously. Therefore if a
> non-owning ref is associated with a lock, it's the active_lock of the
> current state. So we can keep a bool "are we associated with active_lock
> of current state" instead of copying lock identity around.
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>  include/linux/bpf_verifier.h |  2 +-
>  kernel/bpf/verifier.c        | 20 ++++++++++----------
>  2 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 1c6bbde40705..baeb5afb0b81 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -84,7 +84,7 @@ struct bpf_reg_state {
>  		struct {
>  			struct btf *btf;
>  			u32 btf_id;
> -			struct bpf_active_lock non_owning_ref_lock;
> +			bool non_owning_ref_lock;
>  		};
>  
>  		u32 mem_size; /* for PTR_TO_MEM | PTR_TO_MEM_OR_NULL */

Pahole output after this change:

        union {
                int                range;                /*     8     4 */
                struct {
                        struct bpf_map * map_ptr;        /*     8     8 */
                        u32        map_uid;              /*    16     4 */
                };                                       /*     8    16 */
                struct {
                        struct btf * btf;                /*     8     8 */
                        u32        btf_id;               /*    16     4 */
                        bool       non_owning_ref_lock;  /*    20     1 */
                };                                       /*     8    16 */
                u32                mem_size;             /*     8     4 */
                struct {
                        enum bpf_dynptr_type type;       /*     8     4 */
                        bool       first_slot;           /*    12     1 */
                } dynptr;                                /*     8     8 */
                struct {
                        long unsigned int raw1;          /*     8     8 */
                        long unsigned int raw2;          /*    16     8 */
                } raw;                                   /*     8    16 */
                u32                subprogno;            /*     8     4 */
        };                                               /*     8    16 */

The PTR_TO_BTF_ID union entry was taking 24 bytes in previous commit,
now it's down to 16, so back to same size as before previous commit.
