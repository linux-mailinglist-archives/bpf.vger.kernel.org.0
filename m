Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9055D5A0225
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 21:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235966AbiHXTeO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 15:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234790AbiHXTeN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 15:34:13 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC886D57F
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 12:34:11 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27OIsvnA017330;
        Wed, 24 Aug 2022 12:33:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=+2klhxCarPKH5t2XOeF+qfbtwu5QXF95HCYLcLLMqNI=;
 b=B80tzMxiG+Z405jJTG4AhsDfjT66BsB7AwuOXpK8OAPUFJSvYxkLtRuFYSgc83oeg8n/
 hK2yMg0LX2vN5ALEXo1YFOLSMUuOH+J3auICoG4CfBXdccyoD9xZskvnEOTltn/VgVdm
 xWIpfEGZ27aZvdn7OsGjHV1utdUXPk6i/wQ= 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2043.outbound.protection.outlook.com [104.47.51.43])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j5bejwh86-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Aug 2022 12:33:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RUg+dQoOaosMCt4cJEjSjQnSqHrL1bt/93gZy71jUvFxHYdxJ0nmF4dg/3LxQeaWN+WQPwEaNf4gbcjh1VMDC8hUqfeipW+WahdIEs+ZPYbCG9m2y9u32tZtNekQ88Aj93Yi7ywbVrG/SaYOgM9eX/AFf0hGwFIn22//xcrt9M79WJZcuwmBCq+pKd2mOtKsuvcHaeBSHXCRpRaUnV4GeyiOF26H6S1ClrfhuAUvbq4HhhIOFBBxm3B5bDxt4LHSftgBHfCPktNJ6VTeqKQbL6uiddT2h8ILXz892SEeMKAqiftZln+jLbUrIWsJQdlDwg2GueVL8Nf/2PKpYlLTLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+2klhxCarPKH5t2XOeF+qfbtwu5QXF95HCYLcLLMqNI=;
 b=kU8+ZexJlxMIUKtac7MC0vdyauKgXBDQE2klqxwZkOYJGQBK+YlnIBGLq7fRUrwoXTn7Ufa3SYV2tvFvP1/4x5ffUmjzPhbc598MezM1hq6BZJSXBInUNtKPuAL9YO9R/+qtSzrTYII3pllGtFeTptONSCnAtsP7vpET1/GXxMhrQQl/6rs10bbgHdM7C4JtliNT4CjK3O4trrUxQwf6l7a/gl40v3B25fYIRymKa7+GIjM70EWjsi1DTu7aP3lCdCz0hUrO0+D2SVgXbd++ZhkW5UzGaf3boKwakEx+hdr1/QjKOUuYyqvyVoL1Kg7Nv1Xst5VVAvpMP84jjYZDMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BYAPR15MB3334.namprd15.prod.outlook.com (2603:10b6:a03:106::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.23; Wed, 24 Aug
 2022 19:33:54 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7%2]) with mapi id 15.20.5566.015; Wed, 24 Aug 2022
 19:33:54 +0000
Message-ID: <6cc0a303-021c-625b-12a3-47963b2e0bca@fb.com>
Date:   Wed, 24 Aug 2022 12:33:52 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH bpf-next v6 1/4] bpf: Parameterize task iterators.
Content-Language: en-US
To:     Kui-Feng Lee <kuifeng@fb.com>, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kernel-team@fb.com
References: <20220819220927.3409575-1-kuifeng@fb.com>
 <20220819220927.3409575-2-kuifeng@fb.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220819220927.3409575-2-kuifeng@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0052.prod.exchangelabs.com (2603:10b6:a03:94::29)
 To SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b110cdf-239a-43cc-caa7-08da860794db
X-MS-TrafficTypeDiagnostic: BYAPR15MB3334:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8EvAeh0m8COfLFp7ge6xGBCo3NG/xMKGgeA9cl+a8ciZTuqq4Uup9+kJ5rc7rU5C9mSRvygqlOC5/Fvq/gbVeUYUL22f3b+J328BQePCUTdxffWnu7wx8LLaSF4IEVNN7ONnCd/sRSlbesZhSTfXWO8dikhV7yUmGg88qqDCAeaQLGnrn8SZvzXSDBCMhs6qYiJH6nX/xMgP/oZuTASm8jeHAQwW3IDyWKI0B525oxxc93c32Z5OOxPyPvxW1seXGsKVunVNNnS9Erd3vOO99vba9WQvtWgJylh3oRm3L479TX1UL/8HDoQZCuFS73muFdgSP2LCoN/D0qGBRm1mNKn2TF/hpIMH8M9Xjn56Kv1y48iSynkwnRyay9FxRcPD+p3EOKcdpgvnyLidy8ot7CeS6wVlRAXGFxMhP1mnNR/IHDiJ4sru6CMxckMPGrERQGqy7YreZiaWwA3o4EkBdiDaRWFnRIe8Qa28JOU4QQIhlGNAp4VbJ81Y7/3b8clq5iXs3+UKGtQ1tD35ISDICriA5oNs8EPw345DS52ZsVBVihmBWf+l2rLAlaNFpTMGYWNX5kIxjVQDIB/Fu1JLcTgRlOxYVjL/uOfU5Cr5Vw1yOGbXIRaO1AvFy+4WLpSIMUZXliwQL8ROinDKzIRG6YgYXOH2rGlKpoSgLjVH/0YvhmYtGykDtFKYWd+3WUXJu6q4DetYiDLVaE3/lVkwjKcsNtH1GmnNsjznlhadNB66NVLhhX5wIZl9MNwTu9z3DfW5Iz5xqE+hIOXoemafW3Zz+h6//v7MJT3Hwe0MpD4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(36756003)(8936002)(6636002)(38100700002)(316002)(31686004)(66476007)(6486002)(6506007)(66946007)(8676002)(6512007)(186003)(53546011)(66556008)(5660300002)(478600001)(41300700001)(4744005)(2906002)(31696002)(86362001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjBWQ3hWMGhkQldTaUtSd0Z1NDZwTnJwbVQ4eWdVVmw2TUtlbHA4NXJMenlm?=
 =?utf-8?B?UlY3VXlxcGY2OGVBZGhtV0RWYnNpT21yM1M3WGN0K3RSNXpubXB3L0RtS2hx?=
 =?utf-8?B?Mk9QNEUyQzE3VmFUYkZBYkpwdTA4ZVBzSmdja1pmVWZMVnlscEFwMzFIUk9r?=
 =?utf-8?B?YjFkam1BbGtZWCtWQUwwZ1lHbWkwKy9PaHUrVmY0T2tQRXRaNVJ1MXY4aGFD?=
 =?utf-8?B?bi9sQk4wSEsrN3YwMnlQY0JrNHQzRzNCZE1yU1pXSzlKY1M3eTFOVmtWN1d4?=
 =?utf-8?B?UFhyWTZUYWpPMXJOVEs4UldjdXVnejViMk1RQ0hlM3RVZ2gwenZVVEV1dEJO?=
 =?utf-8?B?MnE0a0p6N2Zka0dTOEw4cVovZlYvNFA3QkJOZE1zWTFUbnAySGdYRHZwWjBv?=
 =?utf-8?B?WUFnVGd4WHRodkI3TXcxL2FTOU9uNksrL2s0KzlqR1JPdVlZQjNleHJSemU1?=
 =?utf-8?B?UWlWS1p1R2FGbjcrSWFOTkJTdUZmSDBOU3c0WkR4NHV1ZHhUVG9DbW1CNmJX?=
 =?utf-8?B?dzBITzFXRFdsYW1JWUNGUGo5TDNwWE5rRzR4N2Fya0FBYkc2YldNZEtuSlg5?=
 =?utf-8?B?V3hzbHZEaVpBK25wU3M4VXY1Wk9SUVJkMjRudkYvQmFSRC9wZndkOElSaXpm?=
 =?utf-8?B?QUZsdHFkcnN6YkdTTGZxOUpDZnhuUkNkVk1ZZnk0OGN1TC9WWlFmWnA0OVZO?=
 =?utf-8?B?bXd0d25iTzNjOEF2Q0F4NFNUNHlaZ0hReU1QVnprNzJGVnFxN2ZVdW1wR2ZK?=
 =?utf-8?B?UGoyYlU2eDErTmxEMDl3RUlPd0hocTZmWFV4U2kwUGJLV3pmSFpDUjNUbzBT?=
 =?utf-8?B?UlBST3YwaUFzblJ3UURsbjF2dFppbldpZEFKbnFNSUZoeHJackp0ckZoOVRx?=
 =?utf-8?B?bis0YnI4aEEyMERmUFI0TnZXazYvdzljRnQvQXh6cVdNY1dmVVNVd2NFSlpx?=
 =?utf-8?B?MU91TlZwbFRZRDU0cHFlM0ZrY3hSd3NMTStpQkZVNTZCS0h1U0E0d0k2SHhS?=
 =?utf-8?B?ODNMTWh3ZjJ4eEFESEhveEJPM1pwUUpaSjhYSlRaRkVHNHA2Qk83ZnlOWGk1?=
 =?utf-8?B?UWJnb3o4ODRFczFpanNSQmxBeFNJYVZoT3ltQVRRVjV0bndaaDkydXVobVZU?=
 =?utf-8?B?Sjk5TGtibTNyYmFiVjlOdEZveVJQdnQ0NzZxbW1xbVVSb2JtM3lOUVRDT0dt?=
 =?utf-8?B?cHVZdlpYeWdJREd6TWZXcnQ2VUQ4RkxQb3hadzJQdGhJZ1ZoVXdGMmpFUGhw?=
 =?utf-8?B?UGxGRXpjbDNsbm1kTW9iZi9OT3g2WHhKSTJCTGxZTk1MV0xhTHF1bU5mRzNv?=
 =?utf-8?B?d0IzVzFFZy9IUFBVNHFJbkxPV3BxMUpmNmh0YmloY08xaW1hdktpV0FIM1Rr?=
 =?utf-8?B?ZmxHVUdZZWliRWliSmgwRmZLQmM5NVdkcEJRUTg3YzlqbXJvcWJqTFVXckZC?=
 =?utf-8?B?NGNXdmRNRGNaanVEa3Ywd2lyQ01RNjUrSmtjT2paYWVCQm5GNWl1allrYlkr?=
 =?utf-8?B?eVVWNUpvckpXei9wNFRFU29nTTVYQ2lYbFlUcG9qRnhYK0RzNFRlVGp4WDRD?=
 =?utf-8?B?Q0trbEExQk03aGo5QVV5a2hmRnJkc1YvUm5yRUlsVm1SbXo3SUl4ZVp6RGh4?=
 =?utf-8?B?djg2K0pTV1dzZnBINi9uYmNwSFdzQ1U5K09mLzF6WDE4Z2F3UW8zYTlQejBn?=
 =?utf-8?B?NDBjVDlrRnhvdUxnR0t2bGhZbklkaVdNak54MkpldE9pVWhYeHlaU0FrSkIv?=
 =?utf-8?B?dEhtcUVBVTg3blFWU1pLUGIwSGJaRjR3K1BQYVBmemUvbjZlM2xjbFB3VlVw?=
 =?utf-8?B?Y0Q3Y1A2S1dscXYvb2ZRMHp6d2N5blFReGRlMGVlaU55Nkw4QllRc2JrOHVS?=
 =?utf-8?B?UWYyTURWOEN0U3RFOGtBNDgvRkkrQ3ozWVpMcS9sYXZORTZwRlloUXdISVdE?=
 =?utf-8?B?dy94YVJPWm5RVHMzMVVhV3ZrdXNYYlJHUjV3ZHNpdE5yeWN0VjFaS3lBNUZ2?=
 =?utf-8?B?ZklQNDNyVEFaVDF6VFZncHMvTTdFazVxRXpuOVp0UnArdS9iL2xGUGVaREx4?=
 =?utf-8?B?RTFycVhlU2h3V2gzbXIrQWVxaTNJZWhQT3FHOU9nWEtlRVlpWXM2OEsxVzNP?=
 =?utf-8?B?M1lOMjNHOGdiNmMrM3dIanlvOXVMMlpnVzA4OWdtUGZSVTFQWjROanpKNHlw?=
 =?utf-8?B?NXc9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b110cdf-239a-43cc-caa7-08da860794db
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 19:33:54.8077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Iag/+X0YcJPmCYUHotNbXBw3yVIpd8bDLbd38LKEeOVQR58yeBQ+NPIJ1qHi3aH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3334
X-Proofpoint-ORIG-GUID: LrTHANBAG3vdU3vK1JzTZmGQRTfpYvu0
X-Proofpoint-GUID: LrTHANBAG3vdU3vK1JzTZmGQRTfpYvu0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-24_11,2022-08-22_02,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/19/22 3:09 PM, Kui-Feng Lee wrote:
> Allow creating an iterator that loops through resources of one task/thread.

one thread/process.

> 
> People could only create iterators to loop through all resources of
> files, vma, and tasks in the system, even though they were interested
> in only the resources of a specific task or process.  Passing the
> additional parameters, people can now create an iterator to go
> through all resources or only the resources of a task.
> 
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>

Acked-by: Yonghong Song <yhs@fb.com>
