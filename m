Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3B34AFDB0
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 20:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiBITsd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Feb 2022 14:48:33 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiBITsc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Feb 2022 14:48:32 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE36E040CA0
        for <bpf@vger.kernel.org>; Wed,  9 Feb 2022 11:48:30 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 219HJ9OC020348;
        Wed, 9 Feb 2022 11:10:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=fqHyfSd4hPs5E3LbQ0f01xnXCV8x4QHTd/CHNXtzpP0=;
 b=DVgz4DzC5o58dzZ4FR6u2XRjUwHOUk5161t20zvSfF8jOaO1k+cT08humJFygZtglLwO
 9PaxZ0sx5r8IBhRiXdO/uWYc9SALdpkNhodor2Swi/CZdDtwEVKmuGIa1/f4+EXI04eJ
 VrKNvcJf1nMByuKAF82OgE7wwGfvCCaUOuM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e4fyk1vsv-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 09 Feb 2022 11:10:14 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Feb 2022 11:10:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SdcNmPh4gje5Pnr9OBH2ToDyMrOs9mUmG4kSyhg8FDMUeOknddbnNGCZ+EylolAd7hbNf7BDCyOS9oCulqrJYrD4PVFPpmfmJ2ENpZMt4gORY8xcG6RzoKl1j/E7WtJRQm+8N0oQhQ5u5MJOgefg7T080SrFhNJdMyRQhb76WvGqXi96JqquUG7m9MQyd7GsaAQd1CpV0TIEfzBP7fcSaTJ0yp0eXfLlnEAHZRNheohvPbANGb2KklW6C3Uk14JKdtToN4StPmKpZgjnlzlKgk79IlZWFY2OudOJWuvU0jenm6lBfQKoMCba2qXGRPw4+hwU+nU3oRsVsvERIqZHnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqHyfSd4hPs5E3LbQ0f01xnXCV8x4QHTd/CHNXtzpP0=;
 b=amAhF9WPwa4w6AfaXlie3Esnx+ExUSMmycR0Q28KCt/NVOfElUKrUsXQ+q/u9HIH6W9MlmjLoO22d596pMaTQ3FJIMOwvX2UzqRRKeGhVJouL4MGucBdyhCpLyE8cQAGQtEnUifYBZVp3po/sjLyYVmbB7A7S4WU0/DyOZv5fhvqGD/dW61yZwIY/h16MQpKBASbp/c+rpF+ZG2TGaUObTWvjoLVshBmrZb3+i0NfJvLJ+tMwwwsgpG8GWlZnWp1X0igLBiiUrBv6yUIabkXzUVbjw91PSO3dNt81jdZZ8ChZCZ7z5trlMR5HETyJ6kWo8tKEySWPYP2MS/2+LZiJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CO6PR15MB4162.namprd15.prod.outlook.com (2603:10b6:5:349::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 19:10:02 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f54e:cd09:acc2:1092]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f54e:cd09:acc2:1092%4]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 19:10:02 +0000
Message-ID: <2743285b-a610-80c1-2c0f-936f5a54f0f8@fb.com>
Date:   Wed, 9 Feb 2022 11:09:59 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [RFC PATCH v2] bpftool: Add bpf_cookie to link output
Content-Language: en-US
To:     Dmitry Dolgov <9erthalion6@gmail.com>
CC:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>
References: <20220204181146.8429-1-9erthalion6@gmail.com>
 <CAEf4BzYiT-HRn9bLy=qoyOhOQ1ESCB3mB97xt98JWapgB_nbBw@mail.gmail.com>
 <c81ddb7b-1eff-b5e8-a80b-ef0e8c3bc513@fb.com>
 <20220208201657.esd2z7446ce5xj67@erthalion.local>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220208201657.esd2z7446ce5xj67@erthalion.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR15CA0032.namprd15.prod.outlook.com
 (2603:10b6:300:ad::18) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6c5fca4-cefa-48b3-26f4-08d9ebffc631
X-MS-TrafficTypeDiagnostic: CO6PR15MB4162:EE_
X-Microsoft-Antispam-PRVS: <CO6PR15MB41620AB411E7F1F6E8557091D32E9@CO6PR15MB4162.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NBYY/5V5KJF76AblzEkfQno5ZTvv6/Q2h5P2+SeHAFMf90mxndAGwPNKx9+LDPgjNtu9l4pp0JyU+xLj+566y6XKdgDC6QxSf4Wntg5HVtAOCKi5c5WhbMuX9ZLo/afLDO3g9d12TxGVhS3XtFrzGW4foT1R3bSKGkBQI6RivBI0iilpy4pyA7lvToBM4bxKYDOUYcp9qoDW1xWwFmYBMTHYrIRtD7hzTX0jYPLpuiv/tIkK+zQhc/N1miLMfNAjDDXEFQpOGLJFTDbP6nzCDi5IVAQHW/A2vMozOPPfaKvDQ2xKw1sTCiK1DK5GvsUsDe6mSxtjRP6Xh4js1qZLMyI3RjzdcJvITmkUSlCTfLQ7Da/J2Jgk5NFk2srADrS9HftSxjpRpjrzXu6no2ilcQo6ZJ8nqs6PUUt1fJv0XC6DGSFZ0/wwk9/ggzciqJcWNOtTmcFrpIU9wE5wQupVdE2y1NWaR/lAtyHqOXuODtPkzgLcUveQ1OJmOMJxyIziKGMZnrkdY246V3kRG0pM5ibiJb01pfWwmDT0DMBh5F9QOs7SdC9dY3ooFvVqOpDeF3U4yb6UwR7D0bxDlrs52W11ReovpzCshmna8V4piDdIH7uQKe63mMkZstuCl1tz8Z4OvyRbvOqrkROVKTlNaY8lmJ8frYHRTnap38wtuaFss3XiIGLbafWoLqWMlRpN0LYFY6DQtUMCqOMAnfpP/M4Jc4CnDFhUSi6zBLdNUbkkFl7MypZl2rfsN22tO4BT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31696002)(86362001)(38100700002)(6666004)(8936002)(5660300002)(53546011)(508600001)(6916009)(54906003)(6486002)(4326008)(66476007)(66556008)(8676002)(66946007)(31686004)(186003)(52116002)(36756003)(6512007)(4744005)(2906002)(6506007)(316002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0Ruam1Kd0MvYWloaEtBcWxQUGRubmVZN3krd0FPcWZHMDhvRDliR1BFb2hE?=
 =?utf-8?B?Tk9XdEcrRDV3QThPYW1GVUQySVpLQy93MWQrc1NLVy90bFkwSE16U2xyMVAz?=
 =?utf-8?B?RWc2U25hUzdEVXVDMnF1UkhnRWZvNXlQdEpaTWhJQ3B0NDE5WTVrYnR0ZGYr?=
 =?utf-8?B?Qy9qSWJlS3lacXEyR2NnOXVGd0FVcXNJTU1sRmcrVHlXSnhEZWU5czNVZENL?=
 =?utf-8?B?ZUNXOXh3c040clhKL3dYNW9QZTExWFppdXpXNmxvb2VEWGsxN2hZTkJUUWls?=
 =?utf-8?B?T2pFZ01wK21xRW41SCsxVFlpdlFObzNsWkpYR0ozL1pYWkhYVkJNUDArdlU2?=
 =?utf-8?B?Y005eWZxdCtJVzdlTW5aeTdQT3VuUDBCQzVXeWNQOXFrblNaU3hlSU45Uzhs?=
 =?utf-8?B?Z2FuR0NLd21SN0YxdG1QS0taRHJuUmg1NUJFcHUxV29Ob2NxNzc5UDNuTjhp?=
 =?utf-8?B?VjZhYjdDMlVsOGtRZ1NPS3Fnd3VTNUdreHdJdXRrNE5QdEJ1NkRyNXozMXdy?=
 =?utf-8?B?K3UreFE2bldPMENMTGxyaDJ2dUtBOUozU1ZrcWtBSDlDaVRDVHBpVjBsckJI?=
 =?utf-8?B?cjVHL05UU1JYMkxRUzB4UEQvZTNpQlA2T2txcUdseGNadjYvVmNRU1RjNDN4?=
 =?utf-8?B?aUlZaThxNGU5YUdpRGFxZTVGb2w3NS9VVUV5UjhtVDZVWEZqOWY4SUprZHpW?=
 =?utf-8?B?UzlEcWlWVmdWMlZ5bDlOTmUxQ0NkMlViTlo2RmFjdHVsd3RIRUNMalZpUmNw?=
 =?utf-8?B?MnRhcnkxRGZDbGh3ZVd4UjREaDVBUFNOakd4ZjY3U2R3KzFyLzVCcXFqazhG?=
 =?utf-8?B?UCtRKzRueVE4V0FoL2RwUEpUNit5ak51QmNoNkowaVZEaE1qVU03dldrOTND?=
 =?utf-8?B?c2JUMVdqSVMrVnR5ekNsRGtScVZRQlRmaE13akl2TGtZTHdnTEhsbkpEdFc1?=
 =?utf-8?B?WldSaEtKcXpPdXFWR0lvTDk4MDZLOW1YWWhpdldLc0NQVnBieldoaUJEYjR3?=
 =?utf-8?B?SkQ5aERJdGpXRnd1RHpTcGtlbklFS2QxM3lpUVk5ZE9aUDlwc21zT29CSjM0?=
 =?utf-8?B?WGZkYTJoR1U1UmlKWDNPNktpL0VxcDJXWGRGOXQvOGxGWkhVMkRKMk1zTGZo?=
 =?utf-8?B?Qm9heEh6TFVuOWFCTWFVTll2MnAzMmZVUk1BaU1QOFVIRFpaUlh1eUVhRmlr?=
 =?utf-8?B?VkNmeTVVV1psYmZ6L2xIeWFaN1FKcWEvTEJqS3RscW5qbmZ2YUNKcWM3WHhR?=
 =?utf-8?B?L1AzTmcwRUlDbDdwQ1c3K0U0NEt0MmNlMUtIaDBCWlVOdDQ0aGVwcXNobHRJ?=
 =?utf-8?B?UC93L29KaXAxbmpEN1VyMUVpKzZIRHBVdHpSeVJJVnlKcE1ONHNTbno3aDVC?=
 =?utf-8?B?ZlZBbmxRNWNsWC93bmRkVWg1c01hVmVVdGIybzFacjNIeFZkeVhBR1UwNWRV?=
 =?utf-8?B?RWYwUTlwVEJFNUs0L282dFRTMFVmUmx6R1VUSEZNZEx6eFNUYStaZytzRHhq?=
 =?utf-8?B?Zi9iR29zZElnVTFUUndFMUU3SFMvQ3hYdjNYZ1lCY05pZ2lrNGcxZ25QM1pq?=
 =?utf-8?B?bGV0Qm9QdWV3SU9Ld1FDQ2IxY0lrNmw2bGMrTlRxRy9PbmFLa0VPcHljN1I1?=
 =?utf-8?B?YjB1TmJGWm1RUVQyQ1ZSY1RBbkw5R3R3N1kwUTZIZk0yVHRZTHRKcHFjMCs5?=
 =?utf-8?B?QVhvRHYzZlVwNjZFWm9XSXNWRlNOT2hpY29neDdWVkhpTlFMTGVvN3NmNzhs?=
 =?utf-8?B?c05waVFucTl5RGF6OUNXSkFCd1ZhMnM3MUlSa1dUVThBR1k1UUJUdFdLYWdn?=
 =?utf-8?B?OEMrUnVSUHN3dnRYK1lZTzEzVjRzUHdsdyt3MGZkS1ZEQTNEVDVGZ1BzRGxJ?=
 =?utf-8?B?cWVxL1NTTVRFSTBCRFVrdDFYZW93VnBPSzJsSVh4WUQwdUx4UVltRWxZdGZY?=
 =?utf-8?B?aCtPd0dnVk0xdmF0dXoxbFQwd3pRdzFBZ3MzUmNWSzk5dWNrbG5HbnpvdGFh?=
 =?utf-8?B?SEJPYnBEM0FCZktjZWg5STNTMlhjMWlNc1BqRzZWWjVjT2NSeUtIVTRDNmFt?=
 =?utf-8?B?aU1VOWlSbjNua0tvN1k5eldLTU4yenFkOTRHNi95dFNxdlFieXBPbVBHVkFw?=
 =?utf-8?B?MGcvMnV3ZGV6OUVYTzJTS2U0ZGQ1N0ZaT0NjVTJ2VkJhVGZWYWFZUXlQS3NT?=
 =?utf-8?B?Y1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c6c5fca4-cefa-48b3-26f4-08d9ebffc631
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 19:10:02.5027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z8uIXaGZC1IOTJckQ/YLrlYFBgpI7ODRSPcaxZ9iNlr9uhmMaLhIvPdVAt21x0F8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR15MB4162
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: egyt4HK4UoonRHs7vYsQdwTp9UtwEL-K
X-Proofpoint-ORIG-GUID: egyt4HK4UoonRHs7vYsQdwTp9UtwEL-K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-09_10,2022-02-09_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 suspectscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 mlxlogscore=958 bulkscore=0
 phishscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202090101
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/8/22 12:16 PM, Dmitry Dolgov wrote:
>> On Mon, Feb 07, 2022 at 09:46:36PM -0800, Yonghong Song wrote:
>>> As an aside (and probably something more generally useful), it seems
>>> like we have a bpf_iter__bpf_map iterator, but we don't have prog and
>>> link iterators implemented. Would it be a good idea to add that to the
>>> kernel? Yonghong, Alexei, any thoughts?
>>
>> We already have program iterator. We have discussed link iterators
>> for sometime. As more and more usages for links, a link iterator
>> should be good to improve performance compared to generic 'task/file'
>> iterator.
> 
> Are those discussions about link iterators captured somewhere in the
> mailing list, could you point me to them?

We could have mentioned link iterators in various occasions as it is
natural to extend beyond progs/maps, but I don't remember a dedicated
discussion around this.
