Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0DA52F3B7
	for <lists+bpf@lfdr.de>; Fri, 20 May 2022 21:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353173AbiETTTo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 May 2022 15:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347963AbiETTTo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 May 2022 15:19:44 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384CB17CC8A
        for <bpf@vger.kernel.org>; Fri, 20 May 2022 12:19:43 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24KHSIL8010689;
        Fri, 20 May 2022 12:19:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=ionc3juw/TjzCI3yGsl7cvzEQYZ/wBtknwTsE4W27Y8=;
 b=Wn5O6PCj55RtU+X5JRvRlRK2SRZvhNC57d2FIHyb3eSN810JL8dBqzs1vxLA3cxS8qjB
 F6yQi4lQBirWQDKSZZTECUQPjqyhgatZukfhkx6ZSE4LMvjxOgL8T4aZZ/Vhu5Egdj9T
 Z95vwywQ/ZzEyJknG8U8HRP2MvQ4lRppvZ8= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g6341cu43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 12:19:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5gBhBxdn3CZHOMN2+i6F/XGhTzSGB7LHSmiyCXBa3atemgnu9C2kTRde9uHpseeUtBH55OWdRVYioDT9RCgbh2KAcyHgoMh+Jw2xXW8RS6lRKsRy7ySewlNZyjSxIv5ETB2Y8CECwicy2aN4T11d8BY7M6mz52eHpyY/HhERViWiOuaDBHPUxrnyYkjy2qm3g8xUwOUBI6LFnqEBpxbqcpEawX5xCHZ9k9hazQ5zN7YPUTqlo2jLg5sUoI/SoZMJEwz3JX1/Xdy1OtYwTql6C6s4RY0wds3gsb2ToxDxddit4CWUTT9uiqPezSIiToGdb4VZvgJNHFkmUhgL/kLfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ionc3juw/TjzCI3yGsl7cvzEQYZ/wBtknwTsE4W27Y8=;
 b=LngddMVxWxIHnommbHrI1WKAGJHOxxksnJnAD98x284NF8yML/QK/CpuFM0pbQQHgJaQCi1t36e2U3V7yoo+hHZo1TZa/hEmmC2gEr240EvbocZVMFntaJ0vcij2G4+N6AsTj1YyumYkDq6CDq/fbSGOko3HVPfmRenz++7wQ0M3UITHOEMIDeeJuJE29uTzqt6kDZpp7zRrXyqQAN78B0w9epCYjj4WP16g/t9oTv0OXueUNtpQZNtqZHAj0cR+kXWYe4mPbqlflZnqNzFjVxKb3QXk9tjPJO3mmolfM7zn1ABX0yWZ0xNXlwn4QwrEsn+FbAFU8YJhK+pxPR+fVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CY4PR15MB1351.namprd15.prod.outlook.com (2603:10b6:903:f9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Fri, 20 May
 2022 19:19:37 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53%7]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 19:19:37 +0000
Message-ID: <6b714495-aa3e-8d46-5eb2-041968d26fae@fb.com>
Date:   Fri, 20 May 2022 12:19:35 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH] libbpf: Fix determine_ptr_size() guessing
Content-Language: en-US
To:     Douglas RAILLARD <douglas.raillard@arm.com>, bpf@vger.kernel.org
Cc:     beata.michalska@arm.com
References: <20220520153851.2873337-1-douglas.raillard@arm.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220520153851.2873337-1-douglas.raillard@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0151.namprd03.prod.outlook.com
 (2603:10b6:a03:338::6) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b068f50f-44f6-41e3-cd25-08da3a95ae37
X-MS-TrafficTypeDiagnostic: CY4PR15MB1351:EE_
X-Microsoft-Antispam-PRVS: <CY4PR15MB13517AA876703A6F5FF113C3D3D39@CY4PR15MB1351.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MYYNm3+sn/pbnxrF6jcholT0SjFRrxZ3uvj5vmwyF7uic0jQSED67dhDxkufyOJ4cAmU/3AGHhgbL91aWK136H/LTMGtRy5p18NqkfBSsm2BY78mmtROtGRVqOhg8EkK0zpJBaFkds6oNcN9PvPgSIRIXGas9bfdRIySv9gdZHgwqsU4AqMaCfnH/8eqbCZqJB79BTftsjMygn0yA62lOXahEzDROWw4AuwkNmsUmor1DtvjlW1hG30mVsEUiepOG5n0nGfDEnS8G2rGMyjxwFGnaFsrearllIZ0oi9yLGFqGT0hSt2b33fyN89O8Gd7Nz7Lf86M5BXvrEYx0zuwHXlzoXzrcEv0YoalkokUIaMXAUPV0YMQU/UZy/QPtvf8JNPwxUlzBfYuPy/l1k+JKSSID40Y5/xG6l975vwGKzPeGFyzQ2BHlhVOUixmnbjk2+y5JkbGs3D6/393tmKvBw2z4u+LFq3JxhGkv6+fIW6KVcnlWX/nqxRTayJ6mIMY1OkMi/iW+hj5/P8Kvs4o385NsJg0WkKlLk84if1pWMTTXJlApYXI3v8PDafSV/MSaVIMzMp8Czh7hL2/8wk1Z4MX47EEduCEZblIffalevPRB9Xiw5PJR0s2YtU/wcDQScLJkYNmaUIzJ8FVRdDZuhkWpa8o27PkaMHnMB1aXDQU8+EdGfRpUN84G5iM8ssuXsoAmkvtV93fGaiQ+a1MB5x8vtB8UrAy1rRqZabrvwc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31696002)(53546011)(316002)(508600001)(31686004)(8676002)(4326008)(8936002)(6506007)(83380400001)(2906002)(6486002)(36756003)(38100700002)(86362001)(5660300002)(6512007)(2616005)(66946007)(186003)(52116002)(66556008)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmF0T093ZmFYQzRiVk9qcnVVc2dUN29nbkxhcldkZFZQcXZQelBBQzkzTzhC?=
 =?utf-8?B?aEdjeHNPU1BKZys4dFpyVWdLN0hNQSs2SjQrR2pDVlVCdFAydFpCUmFHVXZ5?=
 =?utf-8?B?cnRWOFQrdzF1dTFmMjd0b1NTT0I4NGsrdmNwRStLeWxSSisxVTNaSWxSOW9T?=
 =?utf-8?B?aEtqclZ6UWF6NFVSNkROK2h5VGg5aG5VdmU4WGJHTzhwQk5hdkJ5NTE1SW9y?=
 =?utf-8?B?Snc0QlMySG1NL2xOQlU2U0pjQkxndEh4YktSOUZNa3I0SWZyaG5KT082NTda?=
 =?utf-8?B?bzIvNW1lU1VCbkhzaWVEWHJ3L0RtRFZkZlF3RXdRa1JsVWxxR2gwbWFzQmJY?=
 =?utf-8?B?ODhFc3BTREhDS3VrSnJwS3lLNU9mK3V3WVBhS3ZXZWFGaldsZE4rVm83Z0t1?=
 =?utf-8?B?ank3U0ZxUWtwQStPS2N4ZWdZZ2FYcGtTU1o2NWtIRTBaU2hiUVkzdDQxWnFE?=
 =?utf-8?B?VmlaVHF1MHUvVjJJeTdORnRqUEttM3ZVOHAzbWhVcGMvR0h4Y3dlWDIvQ1di?=
 =?utf-8?B?RzNnSDVMQk1pdzhUOGk4UWxrRytsNjRBTUNQek82eS9CY1RIcEJ0K3R3SFRD?=
 =?utf-8?B?OVg1UFdVMGVRWXNWNlNlWVVVYVlDZUYvUEs5V2tYZGlqOGc4VmxQUzBUZnE1?=
 =?utf-8?B?NWJzRHVBYk5vRVhUdVNQSWI5WEUxL2xqZDV0YytVVFJraXdLV1BjeTBLR0pH?=
 =?utf-8?B?RkY4RStXRXljUmNUS3lQR0xmcmR6cHVMaGYyWmxQTXRXWTRLdk1EUEJSTTk5?=
 =?utf-8?B?WmJjTjFPcXNkL2d3ZnBVTU5RKzd6bzFsMEM2WVphclFDbDRRYTl4V095N1NN?=
 =?utf-8?B?cXNQVGdNbHp1VldOcWdOUWlLditXQmtlaWN2ZmRnQnJRdlZpMXJ2ZnhPOVVF?=
 =?utf-8?B?MXhmVzdFYnpmT1I2U0x4VURobnNWNSs5UHBIVU5ESGxtNEoyV2F6cTA2SzBY?=
 =?utf-8?B?N1Nvam9ramw2YjlSNFN4Ylo1OURBNU55TGw2aWtoUU1CRlJFRlVyVXpEeUV1?=
 =?utf-8?B?eVl2ZHJ3eExESjFwZWtXQTJyVGc1UWZYNVFFVE1xdis0d04yeWdGNDUyUDJt?=
 =?utf-8?B?dXdQVERGZnhlSndDa2hSSGlhRHl2Q0U4RXovQ0gyd0ROYTB2cWlieXd6ZHRL?=
 =?utf-8?B?emQwQkx6cyt5VXd3WEM2NkVkL1dmTWgvL1VNZEIrRmVRdUg4dkdYWFByYjdy?=
 =?utf-8?B?WmJHOUJ0QzEwa0J3Tm9BNC8yOHFMbWlRSGtTSE5Wc280NnQxcDRxTVZhbmlU?=
 =?utf-8?B?STB1SCthakx2SWpra1BEQnpMditIQmNxM3EvY3p3V0hBeHc3MEplVlI5N2Ju?=
 =?utf-8?B?bWdjSE1CaXBVQ2pkNElGWXV3a2hoMU4rc1ZSTStsYkhwZ1Y1L09GTEVzWTU1?=
 =?utf-8?B?bkJOTUNyamNYSkQzc2JhYTBjOFJMN2d4cXl0VHozUENUdG0rZ0Q3c1RSUDNy?=
 =?utf-8?B?WG9LYnR5d2VtNGZwd3dJVmNyQmwyRWsyZ3JDaXRaTWJNTDY0UmxONFVEZlBQ?=
 =?utf-8?B?OXZSRUdMVTU1OWdZRHZiOGM3aDRTOHdTSUIxWVQ1cXA3bzYwVG5HUmVqdVpx?=
 =?utf-8?B?VkNrUUZPVTdpYUdKQmRaTm5PbWxnanZlRUtLOEh0c0xTU2RzOVRlSThuNjVC?=
 =?utf-8?B?UExLQWlxbExCOEVZOXU0NllyK0M4TjVIcXFudWVoamlqWFlHZE91R2t5Y0Fp?=
 =?utf-8?B?RXplYzhzSHdaVFN1QnRFNmpvZXhvRjdYa0xSOWlXZDJmZ1B5MXRnOXgwbUhl?=
 =?utf-8?B?UjArb3l5bjhjQWZnU3lKRDRRR0xhcVNjN21KQWRIUHZlVElYRlJtM1ZSSTY1?=
 =?utf-8?B?MEREQ1NVS2Z1Um00dGFOOWVOSHRVVmVRYmhaRDhkTFBKSTJxMG5BWkZSS3li?=
 =?utf-8?B?U2VSQ0JnSU5kemk5VTY1bDNIVEVQazZtRXUyYTdRaVNLOUpDM25SRXo2ays3?=
 =?utf-8?B?aUhVWnN4MGtiQUpvOHFRN0NoWlUwbkh3MjNFbFJZQnR4Z1hyc1F1ZTIvM2sx?=
 =?utf-8?B?MllLVExJWnZ1ZWRnSG9BdUQ5Tzdqa1dwWjdQQW9jeU53V3lvUVphQWtpZVdz?=
 =?utf-8?B?cG00OTN1M1VPdWZJN3NWVm5waUtLNFY3cmFmcDFabTRFNlhXenU4bzQ2RWtj?=
 =?utf-8?B?QWtkSmVKMG5EUkh5UjJNci80Sk83Q0loZ3Qvd09hSVRrL3NPY3gwWkFMK0lI?=
 =?utf-8?B?QmpodDlEeElTbWRmTHZML1hiTzNWTEpUSVFDTGRwaUx1eFphZGFBc3BXcnpW?=
 =?utf-8?B?WThBUkVxMG02T0tGZXcvVUxXL3FUenoxcU53U3NXYUx3NmFqdVg4VW5DaW9B?=
 =?utf-8?B?VThDSWRCZDdTczhsbzNyRCt6Z3E2OVYzWGU0cXE0VjhPcVFyL1J3RmZNZ0RC?=
 =?utf-8?Q?IAexqqhTIo1GIv+A=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b068f50f-44f6-41e3-cd25-08da3a95ae37
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 19:19:37.4870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D7Xjh5rcvV19bfQYwgt2jt3uqt6FdcmmvuZOlN2OJQB/iL3vibvM4evM9+hdvTmX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1351
X-Proofpoint-GUID: pteNbFLv23ribPb8k7681ll-S6i0uHDe
X-Proofpoint-ORIG-GUID: pteNbFLv23ribPb8k7681ll-S6i0uHDe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-20_06,2022-05-20_02,2022-02-23_01
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/20/22 8:38 AM, Douglas RAILLARD wrote:
> From: Douglas Raillard <douglas.raillard@arm.com>
> 
> One strategy employed by libbpf to guess the pointer size is by finding
> the size of "unsigned long" type. This is achieved by looking for a type
> of with the expected name and checking its size.
> 
> Unfortunately, the C syntax is friendlier to humans than to computers
> as there is some variety in how such a type can be named. Specifically,
> gcc and clang do not use the same name in debug info.

Yes, this is indeed the case.

> 
> Lookup all the names for such a type so that libbpf can hope to find the
> information it wants.
> 
> Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>

LGTM with some comments and needed change below.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   tools/lib/bpf/btf.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 1383e26c5d1f..ce05e4b1febd 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -489,8 +489,18 @@ static int determine_ptr_size(const struct btf *btf)
>   		if (!name)
>   			continue;
>   
> -		if (strcmp(name, "long int") == 0 ||
> -		    strcmp(name, "long unsigned int") == 0) {
> +		if (
> +			strcmp(name, "long int") == 0 ||
> +			strcmp(name, "int long") == 0 ||
> +			strcmp(name, "unsigned long") == 0 ||
> +			strcmp(name, "long unsigned") == 0 ||
> +			strcmp(name, "unsigned long int") == 0 ||
> +			strcmp(name, "unsigned int long") == 0 ||
> +			strcmp(name, "long unsigned int") == 0 ||
> +			strcmp(name, "long int unsigned") == 0 ||
> +			strcmp(name, "int unsigned long") == 0 ||
> +			strcmp(name, "int long unsigned") == 0

Please add "long" as well. For "long t" declaration, clang generates
the following dwarf:

0x00000029:   DW_TAG_base_type
                 DW_AT_name      ("long")
                 DW_AT_encoding  (DW_ATE_signed)
                 DW_AT_byte_size (0x08)

If the type name can be sorted with words, we only need
to compare the following 4 instead of 11
   "long"
   "int long"
   "long unsigned"
   "int long unsigned"

But I don't know whether we have an existing function
to do word sorting or not.


> +		) {
>   			if (t->size != 4 && t->size != 8)
>   				continue;
>   			return t->size;
