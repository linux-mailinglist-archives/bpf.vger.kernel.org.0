Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914C45B4AF0
	for <lists+bpf@lfdr.de>; Sun, 11 Sep 2022 02:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiIKAH2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 10 Sep 2022 20:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIKAH1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 10 Sep 2022 20:07:27 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45592C12A;
        Sat, 10 Sep 2022 17:07:25 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28AMBTkf015494;
        Sat, 10 Sep 2022 17:07:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=micabOILmQ+LYELTLwjBCcVx3ut3q/B6f7BtYVtn6hk=;
 b=FwBOAhO3N7jqBAuWRXFtF52yEUf8nDY3UtNtQTwANnxWEG1NDA052dd8kVwdzyQ+yxWv
 gtLs+5NABdET+RBQRTZGQsBNFJ0/nRhgVYiG9raR8YpQj36XieEXCBJF5vCehtfcpe2f
 tbIZkdrhgdyKd2wy51huc1V5WWE5zRCI/cA= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jgr40a7mb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 10 Sep 2022 17:07:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLx/050ZEIWCc9sDMbc9AohhBdklO7syjIQ7AhOCLgp5s4nJWvXrpmywoKQrwir7I3QDAL+jILVACLZG65fI2a1oFBigyxAW3w9Mme1uvefOHQ4i96T9W6Oh9SjDGlFmoZjTlRt0+rciUrX3Sgs5sAsSExptwy3CPYnEIRxDkdQomw0W80EpVVlmTg5cbYglXEULB9tIyJv0GCIQ6VQACRKfvDxfe0K6cNxWgk/E5QpJhwlHGTV4DHpHxP/crJTFW/NMhfYd2qDSv6N59wvOjyUwVQevn70RHHskezY6LECLTr70KWz6y//9ohXtH5CrgBuCCTA6Hitp+8xbZM28Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=micabOILmQ+LYELTLwjBCcVx3ut3q/B6f7BtYVtn6hk=;
 b=I7Zm6IN6NiPj7GwLeCPYpeeeQUjdCc3l/mkkfeWN4MjzO443FXpK4vcvIG4ENNUD2fEnYOtl/15ELPFcRg21s2yqwTA0pVRg6O2LFjIPC/zJVTz/rcLCTtyfDspFRaJZYr6yT+hPstKm+6DYGV7M5Fc1gLm0FMZWr5GraCEVEDvchTCaUQqIXJmEe0nb87KNRlfv1j2KHNWSPKdN/kbjp8S37bIsagFP8IEnfepPA3AmJE4ZYY059kQtquPILPZaCuHMORIApR4mFSFUWGCdZJ0SXon2pQ/3DZbGFqh9WoD5NcMBqG8fESyI4OFjHWUapDOg0yx/vd37RjYGlKFKJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BN7PR15MB2436.namprd15.prod.outlook.com (2603:10b6:406:8d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Sun, 11 Sep
 2022 00:07:02 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff%4]) with mapi id 15.20.5612.022; Sun, 11 Sep 2022
 00:07:02 +0000
Message-ID: <2b84fe80-60b6-c9cb-369d-47fb0995aed3@fb.com>
Date:   Sat, 10 Sep 2022 17:06:56 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH] libbpf: define bpf_tail_call_static when __clang__ is not
 defined
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        James Hilliard <james.hilliard1@gmail.com>
Cc:     bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20220909224544.3702931-1-james.hilliard1@gmail.com>
 <CAEf4Bzbm_wq=n8+ve95aBtJkK-WcsUmKM_LT57XU0D9zS9gXuQ@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAEf4Bzbm_wq=n8+ve95aBtJkK-WcsUmKM_LT57XU0D9zS9gXuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0071.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::16) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BN7PR15MB2436:EE_
X-MS-Office365-Filtering-Correlation-Id: 37d88dd8-32dd-4a90-3640-08da93898d9d
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ur08edFuI3jJUboTL3rasuj0mmAJbMP/Np5GZH+V34Vw2T/jKKbX/Pn5GjF0P8y6j8GHBuTCMU6S9u6L+kXcxl0HsF/ZRgHfj1Q8Mvh3BqMT0VuGOSXAsU6z3fuUOVg9tfJGUwTMKTOri8JE0SSRK+rfoCvqBGcELBNUuWmacNg6aQmmVPaicqVjhJD96+wrnisIj/OdMRvN/uUZJXj+7DKcapWGi5dWDMox9hQRxnA9R/YiDNc4gmkDNct5LMrUkdnDcBOxtoqb1OaFVLxEvPhTrvAfZYZMtZ1YThpWU5DxiJztioTkxIoQCU00ZsCur19H7cIdFfgabBGa+KcVfqj16e0g/bzi6yErDYidUOxxseHsNbIBK8yDD8tZdv/ZLh5Zh0fZPyik5wyWExlajjDrqNJtM7iHgkx2jDrCE0WY7ScKF2245WBDjn1NKtO8wnsRBccRu1Dk3n/zwAUr55Fapbfbf7cJKm50iwUKZ+DnGquG3SvAqVMtQThD13w5a+DXCfKyLBOcAT7WKYp6/cQT6JK90vAzNa1w0w5ELwuAVLPyLTPiiIgE3R7jy5JdvDTTGDMNOfO6VI1a8wkHI5tPsAwZ5oKoZfGmTS2GSPYlYHA4yDJjYjsR+v9dfINSgtFmkh2Gza16r+BOP9frxjH/SESOBqgGVy+vkXYcOiIABvsODD2dtoQFafNJY52EEi0S5YsnSIuGJ6u0LjMbcHtXOV2n4JhbUB0Bfw0Hgav/9kRJg05QiG5h7XepraO3AHE96IoeBsVhVC4pLr/YLqhwT2DskQ0dQy78Xg+PVVo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(366004)(39860400002)(396003)(346002)(53546011)(6506007)(6512007)(41300700001)(6666004)(6486002)(478600001)(83380400001)(2616005)(186003)(2906002)(8936002)(7416002)(5660300002)(54906003)(110136005)(316002)(4326008)(66946007)(66476007)(66556008)(8676002)(36756003)(38100700002)(31686004)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkVmSm0vNjNQazR5OURITU54dUl5aWdjVkVNYzVkeXpVZlVpVU1JS1JSbWNR?=
 =?utf-8?B?blNZNUUvSlIvOWZXRERsekd1ZEgyRVk2RzdrTlhUbHVuWkZqREIvZzRQWjha?=
 =?utf-8?B?V0JSV0o2UFI2K1p3RU91WkhpaVEyYkxRN3pSdGVMRDRmRjJNcWFLcVllTDlP?=
 =?utf-8?B?VXl3cjZzZUUvQVl0WWtubWlLS1IxSFBmOTczT3lZV01GOGN5SkIwemZxTUVv?=
 =?utf-8?B?ek1lOUowbGJxNGhZVVZyRmZLQUYwd3JRekNKa1VkWTBlSGZjYlNoMEJnY2pP?=
 =?utf-8?B?WWxZam83OFI3Nmd0Zi80ZU05QmRibStxeXF1cGpuVW13bVJlcmtwdkxPaXdD?=
 =?utf-8?B?TVVtdFU5TUxZM09VNk42a0t6dVEzTTJ2Q1lueDN3TEVvWkVrSmwzY3hmQ0I2?=
 =?utf-8?B?QVQxY1YrK3ZjVExVV0tqUUxOQWNMOFh5emlhQlhhWXI3SXNkSElteFRmcENE?=
 =?utf-8?B?enY2MkdIOXdkb1N3Qmx5cURZUUIrdjFOVnlpTDFrSWkwR1lVa3Z6cHM4ZkFs?=
 =?utf-8?B?OENHRzg0UERGMmdmVFFLd09XTXBKVGxVQ2FDcEtvUlhuWmhLZ1BiSVNCTTdF?=
 =?utf-8?B?YjJhRXg4MDdQRDJacGRUWDhVbG04aW5JR3ZaTFNPWTJ5Ti9FSVlwY3RUTUJX?=
 =?utf-8?B?SXFkYkFFNENuRUExVlpGQ3VralRJT09rb015MUhLYmZVaGl5c0MrU2g2aDlk?=
 =?utf-8?B?U2NEUjExUTZJYmY2Z3dYK2I1WjlpdUorWjlhSVpORDF4cCtlVjZVL2dHcUtk?=
 =?utf-8?B?NERUYmlvVVQvYTRTeVkzLzRCRGkvalExUTVFbURieHVtRHM2dUVqanRUd2dE?=
 =?utf-8?B?aDlqRFNvaE0vUFRIcVdtK3JjeTZobXJBSEZtTCtnZWczdm8vS3lLN3FPZ3BT?=
 =?utf-8?B?VTN5YnkwcVY1a1ZMSnV0Y3FRaUl4eUcxTVI2V2EwMXk3dktZZkpyM05RemQ0?=
 =?utf-8?B?UlVYQmlqeStQMmpwZklibXpJN0cxc0ZtTFJXZEtJaHVpQ29xZldtNVNLSk9t?=
 =?utf-8?B?NWgxSGdXbUFiLzNGQ21zOEtmQ2svVFR3eVhDY2h6Qi9zUnBBZElRVkJmTFlQ?=
 =?utf-8?B?YjBHTnNXRkpHNXcvRjNRZjZzMjB4MEd4WmMvYkRUT2p4R3IxdWlGVVpKeFd1?=
 =?utf-8?B?RTJIYXROU1lsOVR2cnlUVVFWcVh5enhOeGVpazZ5WWo5SktQMWs0UDc1cG5h?=
 =?utf-8?B?NzNpNWkyREZJa2t2Ym9vbDFoTXhaUkpnQjlIWmtSdFVGZHVFYzI4S0lzNzh4?=
 =?utf-8?B?K2pMMG8yRWt0TGU3MW4wWUpORFY5SDg3ODV6U3UzRWp6ekJLNTBtYWF4ZndL?=
 =?utf-8?B?b0IxRDcwWmVZaUZqdHl1TTFnckFmUDZNalQzTExrQ3FiUEM4cTAyR2FBbFZP?=
 =?utf-8?B?aUV3Z3EyYnM1TGpiajdhT2VRY2NOMVZ3UDZIcnRZczhaVngvZWFwZnU0cTIy?=
 =?utf-8?B?aVRaTzBPWHFkaWJNUlVmTkJ0ekFDeVk2K1RqOWxZOVlueDY5WnBtU0w5cE5S?=
 =?utf-8?B?c2pINFFiVXlDb1ZOTlE5RUFDNnZZMGJDOTM3TkZYWlBUZDB1SFhIV2M2Ry95?=
 =?utf-8?B?WVFFZVMrVXI2bTZObnVENDYzdHl0T2RreUYwOFhkR29tdHIyOXBJZmZoKzho?=
 =?utf-8?B?YUZaRFJFN2U1T0x0aDJ6UXkvMWFFZFBDTGhMdnZ3MWd6N1MwUDJycmkycWwz?=
 =?utf-8?B?TFVQYy9oUzZZWWR0TjFRTnJrT21QUkwwUWtISUZoZy9ZT0syZFJ1UmpsWXk2?=
 =?utf-8?B?RDBlZUlpOUpUcllLczRaZFdKQm5ocTJmeWN5TkZPNlFiQWxtYUtEMTJCUlZ0?=
 =?utf-8?B?ZDE0c2NmVUlGaDE2clFDN0IzNHJvejE1bXFZa2p0cVFCM1JZTmVMemM1blNV?=
 =?utf-8?B?RnR0OHJGRlRPSEdTYnBkNXRXWHdCWFpBdGE4bll0cmVleEZXWDVkamhocGc5?=
 =?utf-8?B?MFBra2N3aG8zT1dsaHFZcy9TZ3BUYS96V1VPSDNvUEp1WjFBeERGQnhVdFJC?=
 =?utf-8?B?MUZ3ZURNVHRkUmZTUWV3UU43OHppS2ZNN3RmZ0pHRklrSkhCY1JoV2xFaW5S?=
 =?utf-8?B?c1hjVWdoZlBJTURvajViSlpsNWRoUTNuWXllZno0OXhHMzRxMktIeFAyYy9H?=
 =?utf-8?Q?zDUW8Q9K0YME1EW0Gq03LW+Ob?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d88dd8-32dd-4a90-3640-08da93898d9d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2022 00:07:02.3289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ADRX/W+/6/R43qAbINBdIE2GgYKu3Rhm8+c/4jpia/4+xsCW0cR9HH8lQpDnuER6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR15MB2436
X-Proofpoint-ORIG-GUID: ttNaPzvTOlOOh2kvrpqMC2BikcUHGjCG
X-Proofpoint-GUID: ttNaPzvTOlOOh2kvrpqMC2BikcUHGjCG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-10_12,2022-09-09_01,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/9/22 5:26 PM, Andrii Nakryiko wrote:
> On Fri, Sep 9, 2022 at 3:46 PM James Hilliard <james.hilliard1@gmail.com> wrote:
>>
>> The bpf_tail_call_static function is currently not defined unless
>> using clang >= 8.
>>
>> To support bpf_tail_call_static on GCC we can check if __clang__ is
>> not defined to enable bpf_tail_call_static.
>>
>> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
>> ---
>>   tools/lib/bpf/bpf_helpers.h | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
>> index 7349b16b8e2f..30fc95e7cd76 100644
>> --- a/tools/lib/bpf/bpf_helpers.h
>> +++ b/tools/lib/bpf/bpf_helpers.h
>> @@ -131,7 +131,7 @@
>>   /*
>>    * Helper function to perform a tail call with a constant/immediate map slot.
>>    */
>> -#if __clang_major__ >= 8 && defined(__bpf__)
>> +#if (!defined(__clang__) || __clang_major__ >= 8) && defined(__bpf__)
>>   static __always_inline void
>>   bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
>>   {
>> @@ -139,8 +139,8 @@ bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
>>                  __bpf_unreachable();
>>
>>          /*
>> -        * Provide a hard guarantee that LLVM won't optimize setting r2 (map
>> -        * pointer) and r3 (constant map index) from _different paths_ ending
>> +        * Provide a hard guarantee that the compiler won't optimize setting r2
>> +        * (map pointer) and r3 (constant map index) from _different paths_ ending
>>           * up at the _same_ call insn as otherwise we won't be able to use the
>>           * jmpq/nopl retpoline-free patching by the x86-64 JIT in the kernel
>>           * given they mismatch. See also d2e4c1e6c294 ("bpf: Constant map key
>> @@ -148,8 +148,8 @@ bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
>>           *
>>           * Note on clobber list: we need to stay in-line with BPF calling
>>           * convention, so even if we don't end up using r0, r4, r5, we need
>> -        * to mark them as clobber so that LLVM doesn't end up using them
>> -        * before / after the call.
>> +        * to mark them as clobber so that the compiler doesn't end up using
>> +        * them before / after the call.
>>           */
>>          asm volatile("r1 = %[ctx]\n\t"
>>                       "r2 = %[map]\n\t"
> 
> will this compile as is on GCC-BPF? I'm trying to understand what's
> the point. Once GCC supports this ASM syntax we can add similar check
> to __clang_major__, instead of allowing it for all GCC versions?
> 
> We must have done __clang_major__ check for a reason, old Clangs
> probably had some problems compiling this. Maybe Daniel remembers?

Yes, clang >= 8 is needed to ensure 'slot' is propagated as 'const' 
instead of variables. clang 6 added support for inline asm but clang 8
is needed for above 'const' propagation into asm code.

> 
>> --
>> 2.34.1
>>
