Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED7C52270F
	for <lists+bpf@lfdr.de>; Wed, 11 May 2022 00:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233937AbiEJWpL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 May 2022 18:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiEJWpK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 May 2022 18:45:10 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C2520D264
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 15:45:08 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24ALMlfw021577;
        Tue, 10 May 2022 15:44:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=+HR0Qp2sbug9Dj7HjcPPDvWD9Ho0DxSirKg/iGRa/tE=;
 b=muiIqSGgo71G0D8+0krzJ4kuk7I2zbwPp+6ARy2IMdz9hoLJFFvZlWbdxcdEaELFb8MR
 8Wz9TjYHlEsznK0Jn30Z7cOUpCpd7KHwkmy6b8+yVE4icZ4DkQ3Oi/NOPaplu6bpDEAC
 1UU++bL5iCYwfiQBgm0sKMIuX2YysVQdkao= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fykexp6sp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 May 2022 15:44:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FYctB6yeVix8EXpt+/0lB2em+3E+6yYUaf6KCdobJPhg93rQOw5HnmbUmK6ZGKHUk5c9kh5UkkDV4VU+56hU/FjsfodiO/ykdWQkH/oa7hv3X1ZKCbbtdCiFD05nfN3+tJNtBW/kBAue+ufQvwqdQz4ah1Qs8QDkVr8hazzyiN0mT40UpWyD+h5YhJZiZaETUXT67J0TlJmlwzoFTutNPiIx9GDpDX8wVhlbCeCWqV/kYK3CnZcU5n8lI87yqQSqySfCKvSn71k5cSxACNxi6ZfrzH1lJ+Fa4r4jvEKvfnJDVB1pGN8RY9OLQr2z5YeTrcJGF493X+oGzGzkug8+Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+HR0Qp2sbug9Dj7HjcPPDvWD9Ho0DxSirKg/iGRa/tE=;
 b=HIy69Wg/a0NrMjWmcDtEzQgrnu/n6RnIy9QACS0LJGyOoXLyRj8GQwfpzNfWeB7bWdV1TVsteKkn56h+8NprGsWotH2tINLeArWpzPY+rMMxpvlKEF24nFFVUvuaz4iD9yMjX1rIyHbFEFP+bkzBERpArjsb30ql6Iufr1RGa7TY+QwXZIpagWRjHXFoexfcMSGiljSRCThABZf5GTHwPXWC/EAY8uWBkE2d9YtMTsBr05YnUn9XmA/POk/sjMGseCVxLdCodm7vuyDj9KFXUIo2cDjS5VacKOcAw/achZwR1QBGnEkgmKR1tgxiqkFifvcipuLIf7O7ffpkRNg1cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2336.namprd15.prod.outlook.com (2603:10b6:805:26::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Tue, 10 May
 2022 22:44:52 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53%7]) with mapi id 15.20.5227.021; Tue, 10 May 2022
 22:44:52 +0000
Message-ID: <a268f2d9-3193-9c4d-051d-0161a093ce12@fb.com>
Date:   Tue, 10 May 2022 15:44:50 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next 09/12] selftests/bpf: Test BTF_KIND_ENUM64 for
 deduplication
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20220501190002.2576452-1-yhs@fb.com>
 <20220501190049.2580282-1-yhs@fb.com>
 <CAEf4BzaY1St3YwYJirkvXWumYYK9zBi2HX8ru3PbjEXRurr9Ng@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAEf4BzaY1St3YwYJirkvXWumYYK9zBi2HX8ru3PbjEXRurr9Ng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0147.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::32) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a8a122d-f1a3-41ea-3c24-08da32d6b222
X-MS-TrafficTypeDiagnostic: SN6PR15MB2336:EE_
X-Microsoft-Antispam-PRVS: <SN6PR15MB2336A850D29F805A9028D3A5D3C99@SN6PR15MB2336.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: npaOBkBWwg6TYmx1Tv9FQa93lRfoQks/eDGdvHk9Y/ASFP5xuBy0Zg4pRvttC3gFq/F6CqFOkR4We7vPwlbRPb8SvXSLI0R74EpxSi33UKEIIkeMG+ktm4bpvaimIgPg9g44DBrses2Lq//Vxr0Gg5wbnow1YHm2wD0dmXnjM/robIgrKe+O+SexURTMshlDnZKUM62T/7U3+HeN+0bm31CJKL/XUrNIf2ccaZTAxQUkl9SDornfAIb0gaxLmJJ6vuQLRrz2v4F0USBOC3avwDxY8SayYiGvlhvnuBlQqYToyALD65fzURcBdSaI8GROvSkC8GJtEP3gyWVTr0EsGUOUMFw9Bwfh/g+9883vk/Ngadu79F1gwHQHEvpd6fcJ088cEg5IgrYoDym5HqePMjwHEk1nxKs2EdCHJs70bQPRC668x5hlhVTmvueEKZBR2SJeywRQkB0QkTOUxStOIH18RJISzTZpKw6bcvLB3piAfqQ86GHP4n67OEDGHyQcsyJbcvGHcPv+UdtcW4+Thk2p6WW9nlW2s3zhMGA96kljqMTZm0lWbuM4Tkq+Orv3ZD37Vs+XFmJWaLxXSwofx4W82xK8w1L9dM+MlLBDa5Gy0zp6mz8kSpv2iAIM8Oc9bkGsn5eQiPj4faDG2Ia1ByaYJ/byjEQrn3Tc4XzOcvEX945Ki9MEubV1ErFT4EmyV/scxb4bVftzKKecqmRYuPjybWm67WLC1jmS9ZP70E4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(86362001)(66946007)(66556008)(31696002)(8936002)(66476007)(6916009)(54906003)(2616005)(38100700002)(8676002)(4326008)(6486002)(53546011)(6512007)(6506007)(52116002)(508600001)(2906002)(36756003)(31686004)(83380400001)(186003)(5660300002)(4744005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHNGU3pYaTd0VkNZQ001cWxmUHJ2cnprVW5qd2hyN0piT05seWwwMEphSEt2?=
 =?utf-8?B?cDkvZm5SOGFOc0Z4a2hDRXdoNXN6UXBWZ3d1MnV0QUlEVDBHUVJPWndBWlB4?=
 =?utf-8?B?aVZ4QVZqck02SDhEMmdtMUd0d2NZdGtYSURzcmdZWW16YkhJa0tYeEJ1ZW1N?=
 =?utf-8?B?eXBwRUZHTy9rOHFING95YTl6ZWo0VzNWUE9CYS9pZ0ZZUDZXa0N4SEVYa0Ur?=
 =?utf-8?B?NXo0blBwK2lNVGxTQ3BLbmFpdTF6UDRETzJMd3l6c1FKTUQ2cFEwWk44VDE4?=
 =?utf-8?B?b3p3NTBma0o1RHg3QzI1OElWZGVnbUViUnNKUHpkSWJhNjRJb3VuL0hHeDlY?=
 =?utf-8?B?NS9ZVy9MWkNuZkl5RzhqSkcwdnJBSTZGVnpNRlhuWHc1ZW55UTlSQ09XeUEw?=
 =?utf-8?B?bzBrcjVrUk9ReXcvRWtRM1VGQVRzM1RoeEh0NUo2Y1BqeGgzODdKRlpGYkxk?=
 =?utf-8?B?NXFVR3ZCc0JYTUpHVDUrTjduWm55WFFyQzlSOXNqZHdXMkhZY3VHck9uVFZZ?=
 =?utf-8?B?dFVoU3dTb3p1TDZUeWpqRVlXTFRWMEJrOXhPT0luUi9vZk82NzlLWWd0dnRj?=
 =?utf-8?B?VjFHVTd4ZmFDVnZpYnJsd0E3bW1Qb3VrZXNMYWU4em15Yy9tL0FFWWhNVkJQ?=
 =?utf-8?B?RnhsUUw5ZXVIUjBxSHd5RkJ3azBRWVNieU9VUXExdXdTUm0xWDFaMVA0SjNE?=
 =?utf-8?B?RTN3Y3YwT3l5M2VJeXpWZVM5NHZ3ZzFTWXFheVFUTXlnQWwxTFhsWDN2Vm1B?=
 =?utf-8?B?RUsrNTBKSkY5NkJ2ZFBUbDZlU0p2akczZjNxMDhxZFR4dWFiaFREU2lhNnBl?=
 =?utf-8?B?bVRhdGt2SE50bkIzRCs1RitxMk45VEdXS2VlWGVGOHVSZ094RGNGS0FVN1FM?=
 =?utf-8?B?c3dOQTVONnQ3N1dRWlB6VlVsQnoveWdhYnc4cnIreGdtZTQrS25pRnRMY0s5?=
 =?utf-8?B?djQyMGIvVk5qai95bmVmTG52bXQzZ2F5YWlNOVZVMG1PZG5MTy83aEducDZV?=
 =?utf-8?B?ZlcrajhWdm1tTW0rU0x0OWdaV3AvaUo5dzljdWFzcllaMlIrRDNqVTM2UTR0?=
 =?utf-8?B?ZWxLYm9GVzRxWEFPdTF2bUN1VHh6V1BMWjdLL0t0QXRSY003eHdlZlJGRzdx?=
 =?utf-8?B?c1RzVGdBbFJIKzhlVzF0OFZhKzMwa0VwbEUrZkNCU2dUNmdXN1NWTDh1QzJh?=
 =?utf-8?B?b0x1MXYwU2o3M2xrN1EvcitkV1NYYTlSZm1iUUVJMFk1Q0E2eXYyZjBrQWhn?=
 =?utf-8?B?bERyOU9OUG1Ud1p4cjNORjA0MjFOcXJwTVI5aDBlbmx4Rlc3Qm1teG0zNjFS?=
 =?utf-8?B?M25kd2E2NWU2bjRMbjJGQXVXaDNKdEFKSW1zNmhFMTIzM3BXWG42VW9vUmgv?=
 =?utf-8?B?RG5RMVB4SXVDT3VwTUNKV29vbmRYVGE3MkkyNHBlNmhoS3dKdFFDUHN2eS9p?=
 =?utf-8?B?eDJIZklsY1pEdHVldHhxZXY0UTJ3SzNqelBpYkZFMkRwSnFZSmpJd0kvVUly?=
 =?utf-8?B?L1E5VjFzdWJnZ2hHZm82UjJLb1B6cHZxdW9sSEI3Nkw3WXNNclc0WURGOU9t?=
 =?utf-8?B?TFV6MExlSDByWWQ3ZTdHNlAxcDRFenRVc0s3T3djblZnOExHT2U1bFNOTWdI?=
 =?utf-8?B?cENtRlVhM3IyQnlxa2VJUXMycHY3aE1rOXdKL3lMZlRLSVZueHBHKzFubmNX?=
 =?utf-8?B?N3NkWi80Q1NZWHNubTg1Tkx3VTI5Tmk2aTdQRFNqbk9nNjhaQm9CK2Q0Nlh6?=
 =?utf-8?B?ZXJkUlRPWjViQUN3OU5yR1pSZzBqbXh4cHVIVWJ0QTdvNWNaKysvbjBnbGV0?=
 =?utf-8?B?N2lmTitzc2N2d0ZjVWM0YUtQZk16SWZrbjNkNktnMDB6VFFqdXRzVGMzM2ha?=
 =?utf-8?B?NUxVeENldFJjbzd3YUZSZTlDeXpRUmR3T01hcUZLOUdyUUIwSHpRU3I0WmJC?=
 =?utf-8?B?YVFBdkpBektGNThiT0FLa3AvRUt4Mk9ZK295VmV3SElraDhFRnpnZ2ZOdWth?=
 =?utf-8?B?MWQzVHRKL3Z5OHVYVGhUU1NmQ0VnczBKbm5oQzdSWHJuV2NUQ01lTWNnVXJw?=
 =?utf-8?B?eGRuMEVpM2xRZ3F4RzhaVjJXZVJsTDV4L01CSy9RQVRsVWtrZHBDZ3FycTZo?=
 =?utf-8?B?Nk5iOFRFUlYwd1lyTVFqK0ZHNU95OXl0YmI2N1pQbCthOG9uVWszZi9yOU9U?=
 =?utf-8?B?b2tQa2RYV3BrckZYWlIzRCtGTXppWXNNa3BPSzBLTkZYc1VvbitoQnU4eEpD?=
 =?utf-8?B?RU5uZHpRR214NCtCTjdwR0NyMzBXeDVYTmlCU2tMM3BkUkUwQ0paQzkxeUlP?=
 =?utf-8?B?V2w4dmpHaFRVd0pYeUJWWjUybmdQOXVjM1lGeUZhcnRXTEJCRWROQjlWVFJG?=
 =?utf-8?Q?AQUKlp5K27Rkd/u0=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a8a122d-f1a3-41ea-3c24-08da32d6b222
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 22:44:52.0262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hOxcXYpslNJqtxUX1zwpo9X+V+j8eOxblaJZGBS7dU/83qevodA5qktfijHgEofC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2336
X-Proofpoint-GUID: AwVbv51Jmm4HMbe0HA00HMMugepVMsac
X-Proofpoint-ORIG-GUID: AwVbv51Jmm4HMbe0HA00HMMugepVMsac
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-10_07,2022-05-10_01,2022-02-23_01
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/9/22 4:37 PM, Andrii Nakryiko wrote:
> On Sun, May 1, 2022 at 12:00 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
> 
> Please add some commit message, however trivial.
> 
> Can you please add a simple test to validate that enum and enum64 are
> not deduplicated against each other?

okay.

> 
> 
>>   tools/testing/selftests/bpf/prog_tests/btf.c | 70 +++++++++++++++++++-
>>   1 file changed, 68 insertions(+), 2 deletions(-)
>>
> 
> [...]
