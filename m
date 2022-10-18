Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84BF602410
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 08:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiJRGAS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Oct 2022 02:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiJRGAO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 02:00:14 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080B963F30
        for <bpf@vger.kernel.org>; Mon, 17 Oct 2022 23:00:09 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HNduNi024967;
        Mon, 17 Oct 2022 22:59:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=ZrcwEMQnLD4Q92ECAruNME8hxcGHJZLMwOFswirFG9Y=;
 b=CeSePo+V9fqME+wtpLSvh0ItSvs2RzPK/LXhAJmoTIPc+FxavKuI08bxp4oQDwSnEHNu
 hrBDCaclxiDPfs/ETVjltuiJ52va7B/CoUvlmyTfRDVUcE8oAY4laW6/q52t5/xkaQrE
 RMrht8bSKrVbSia3us572QZURaJkp+J2PgTkwG0/p28BC7yBKR0EaGuwnNaHljOF8/hv
 TK0pLHU1WUU+adZnM8/uGZzDuyK4JSiP4i6K3fhAdqIffKULj6YdMXna8d+fpv60qm50
 6FfZJ1PsqJzHzAGsU9MjPNOQ+F1PF/LnFnY9eMyDM/qlmZqp9YckO/dAPpvihOPsbqAP BA== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3k9gcnkbp4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Oct 2022 22:59:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KdTrf4P17aukJ3wODAEI6luaDl4RifR7pAQSgxO79AYgBYLum0ShTjIPRWjC3vRR4jlOsEO4z79QH8Z0Ml3mVw3uEcS3a33WiY5jb4GpqnLgBkBgStmBaN9y+Oq+aJxMRpoPo4l0CpdruXCH5PXPlmoINEvlbSrr391wrZw/elrbF1ZMDCgBPabmh2fk32O8Fjf0EAUXhoznWOOMkCEYhqkIpUZTR4304ecJB1uMhKRX07I/l3rja2X/ynmjCAvoN0zjwRN5GefA0cx8bgeIy7ImgakM709/oOQN424MtcOwEY8RwDJFjMr6BCcBPv/yphuIhMNM4+HcRiJG6Sfoew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZrcwEMQnLD4Q92ECAruNME8hxcGHJZLMwOFswirFG9Y=;
 b=DJEv62XIJcYBwTbF2c2nVJBrAWBATALr+fOOsj9Vf55Mbfo7QPtmfE4hIWCryMjYMkrtgb4bi4ura4XFpHLplkO+TtTcBSN7PHWQGI0N3ZM7G7g1goT2E5w2MQ/Z3meO3qhUZLcwV/Kn4D6Vl3HDTLhgaegjz/iYrJwMuXIUCmHA/lVzP4vPehtDXKu2HgJweSg+0VEkeglnWLlsMz+UXkBhp7RicwdjZQHcNWaf4UnnRJUX7YC5KNAU0072kFHiNjgVGP3RsxOj2LoAy+LxIeM8w1wCwo8ta9ZssXQIDIn8A2VqgMvIJdmlRI1XvlR0+2wr6Ww1NuIGwh/aCFptow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB3225.namprd15.prod.outlook.com (2603:10b6:5:165::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Tue, 18 Oct
 2022 05:59:48 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::6e08:a405:4130:f36e]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::6e08:a405:4130:f36e%6]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 05:59:48 +0000
Message-ID: <fdc0484e-c2da-a118-b845-f937f0ef5688@meta.com>
Date:   Mon, 17 Oct 2022 22:59:43 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
Subject: Re: [PATCH bpf-next 2/5] bpf: Implement cgroup storage available to
 non-cgroup-attached bpf progs
Content-Language: en-US
To:     Martin KaFai Lau <martin.lau@linux.dev>, sdf@google.com
Cc:     Yosry Ahmed <yosryahmed@google.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>
References: <20221014045619.3309899-1-yhs@fb.com>
 <20221014045630.3311951-1-yhs@fb.com> <Y02Yk8gUgVDuZR4Q@google.com>
 <CAJD7tkYSXNb=D1OX_iv7PD-eJaK_7-5tcNvDQrWprWbWwJ2=oQ@mail.gmail.com>
 <CAKH8qBvHJPj6U_dOxH1C4FHJvg9=FE8YZUV3_kc_HJNt1TDuJQ@mail.gmail.com>
 <CAJD7tkYHQ=7jVqU__v4eNxvP-RBAH-M6BmTO1+ogto=m-xb2gw@mail.gmail.com>
 <CAKH8qBtdNv0OmL0oH+U2w0ygLmGUug37xNhHWpjc5=0tn1cThQ@mail.gmail.com>
 <CAJD7tkbPhecz+XPeSMjua77YXr-+Fkrpz9M3bBVKAj+PsXJgyQ@mail.gmail.com>
 <b539eba1-586a-bf3b-31f9-11ea0774c805@linux.dev>
 <Y03USAeiBL5Ol22E@google.com>
 <06e37b29-b384-7432-d966-ad89901de55d@linux.dev>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <06e37b29-b384-7432-d966-ad89901de55d@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: MN2PR06CA0012.namprd06.prod.outlook.com
 (2603:10b6:208:23d::17) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM6PR15MB3225:EE_
X-MS-Office365-Filtering-Correlation-Id: e04f1258-1af6-4ab7-2081-08dab0cdf6b3
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4r5JDyLokdY2e6uRnzrIaH+YKrmqdGUCREnrIeDrh9p0d5yYEUuHD7UU1e32XTJoi47RbU3CQKkGdMUuk0Kg88bxQ30qWeRyE1aCDLbQmzPGRZ1pXLIVxsvUStRhNuRoTCh1qi0GLwn5Q4IriwOtWLrVOXzTH8GAUH/XVm/O88a7ciL4W0kRmF0RompJPeIf0FfPVNR8dLsOwhrmlkG8CgbImk/92wnqB6KUwlSyT48ScopViAxYKA1UIOaeurLz3QRIbaUGpScQyTR28XAM7AGeZEwZQhYL9koGHNMbHelJaTcv+P+LRqrU2egOj0Fo1KKzoKAFOTCiI51hLpfn8rSFTt3/bdYAa313nSbx4Z8R7+WrVYfgB4XAqC2ubOlBr8uQfnHV1F4SZpMee7ftr6FtStEItM5JMqXBWL2kWn5b62YsG1y5ifWTQc/WJpes5NsqB8kU7z/BAa0rgBe6Z5l6SsP3qBcr+7kSkorjyMKKzwyUhws6oXLeOyU5ynzXNj1MvEGLcA3nJzZYVgqmE5cFVW23BMM2F6sFsZrceUGaWQQa/fdWEmyW/1QvJgt6fJP0Z50TYoPDWghGSraRyfkZbwIlHfI4rLEy1J8NuuQ2qi8dyNyttZf+jvr0bamRMePTXF0Cuoh7FljmNeQ9Mb5Qc0fOmlZCBDigXHvZ3rY1DM5LRsIWe5xHLNiEMk6eOt7evfaa1S+oQUtTAeVTNgBEPNKDrGdupTH238+EsOEmMxp9Z4nERkeGFgNeS/ZG/TpMgBGssPFLHISu4w2Ce6S29t+EakMNPgRs3vF3uJrF0wRPscnflqz99zjNhagg73BYlLBED6Brizoyxzlmtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(451199015)(31696002)(7416002)(8936002)(5660300002)(66476007)(83380400001)(41300700001)(4326008)(66946007)(66556008)(8676002)(2906002)(38100700002)(86362001)(30864003)(36756003)(2616005)(186003)(6666004)(6506007)(478600001)(6512007)(6486002)(966005)(316002)(54906003)(53546011)(66899015)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MENqUkpTSWdpVW44ZW9rMjJmUWY1RTNxZkxjbDhJK0tzWlBLTTliL3VCcG04?=
 =?utf-8?B?SU9KbGxNYWhCMTdWMVVZUUJMVnNzZWtCZ2Y1R3VMaWRmVU9JRTNBU3dveTNF?=
 =?utf-8?B?VWZXT1NTQ2szRVJvTGZSbDVHbXAvUlZtU05oQUx1S0hrYTN5bnJGSUpqTFhn?=
 =?utf-8?B?OGp6cDlNTGszSVpTZWJQUnVBSE5MdFlnTnJXTDQ3bm4xQ0psQ2RNcmpWMFgr?=
 =?utf-8?B?VDQ2V0d5em4rTjB6TVpmTXpTUmZHOUp5QUZzNkJlK2F3VGd3TnRVQXAvRTVz?=
 =?utf-8?B?ZlZxVGtMZENRV3FOTjJnY2V5ekJWSlR5Z0xsdnhRMGYrcUtOWXlsWHFWUVUv?=
 =?utf-8?B?dFp1RnFyY0JOWGhzMjU4YUo0NmlFTytrSHpML2MxRXlWVHNvL1JMcGE5cHRW?=
 =?utf-8?B?Z01sNUNaQmtaWktiQlhXQlV1NGhFSFJ2ZDNoZ2huNEtNeDVaWnBmZkpBREFD?=
 =?utf-8?B?cXovVWlpaGxPNEg2TmRIUGVpbmJqa2w2MGNFSkFleFlFdFF3aGRsSkwvTERa?=
 =?utf-8?B?SWlxUFRkaWNTMExpYTlmQ3JmYXhrczIvL0Rxck1TRVAxdE1zVSsrWjFjc0NX?=
 =?utf-8?B?TmdXUFU3SEhyWURxTTZaeSsyckNXK0VvTXRQR3cxcmJjMUxnZVl6Unl1TjVr?=
 =?utf-8?B?YmtZcVd0d0hSWjVvNlRRRm9tSFZzTEhLaU1WVG0xejlyd2FhemZHYlh5aE54?=
 =?utf-8?B?TFB3UkVHaXlQTlVQbTRod0ZXdnV0NVpXbjRsMHhzaTcyVC9nSlQwSEpsYnBK?=
 =?utf-8?B?NEdZdmF5eEd3bTRBQjJkL05DVUxEOEpUemFlbmh3V2FpODdUSFVZR09uWk9G?=
 =?utf-8?B?R1c3d3RPK1JoV0JoZUZNWjR3OWh4N3Ura2ZKZk1kVnE2VUlxRk9jRFBubzBU?=
 =?utf-8?B?S0E1VEhVcWtxM3hhYkJoeEQ5aHFBNUQrcUhMcE5wVGc1Y1l4dUVFZG5rM0Np?=
 =?utf-8?B?eGgyNlcyMGxhVVM5TTJueVN2YTA1ZUVvanRSdDZNcmVmN0tlYVB3WVlhVUxY?=
 =?utf-8?B?a01yYjJhNS9LV1UyeDU2aTBHZStIMWFiQW0weUhyQU02YU12MFpSRWxscG41?=
 =?utf-8?B?OGdTdkJyejNISDBpQ0dMMXBvd3pNZlEyVDUwU2hwQXNjZEdTYVpwZnllWXIz?=
 =?utf-8?B?bWRRUFY0Z2xZb0l5K05wdHZ0TTlFd1NvUW9LM1hndG9hOWJ4VnhuZS9UMXhD?=
 =?utf-8?B?d1EvN1pTbGJkRTBPMEhNS0Yxb1B4R1dZRTNEWmdNNGt4VFMzekVURmh4aURw?=
 =?utf-8?B?MTBOKzkyWHRZNG9hdWFTYnlEclYvWDJodEhRT1N0cUpvSzRNTnBLMVFQRndr?=
 =?utf-8?B?bmRzbmc0eURLeFNmZEE2emUybjVjK00za3huWFZQZlRxQUZtem94L2FYc0JT?=
 =?utf-8?B?MlpSc3N2TTNudVU3TS9QL0gyUGlJdmpDd1ZjUnNTTFF6cGhBNjZRVmRWSlFN?=
 =?utf-8?B?U3MvK1M0NUZOUlVBdXRTQmNyK1plM2RHMTFoazhGajlWZk4wVUFTT1NlMUVx?=
 =?utf-8?B?QStPVlc1SkZ5MHlWNk02TzFsQ0Z4OUN0YlNQRDlPdW9DcExwZ0ZNYU5KZnQr?=
 =?utf-8?B?bytnSFljaG5ZQTFGTDJkUjNJZDNGWm9jVUVkN0E4c0s4NGRxZk9SdHBqWkd0?=
 =?utf-8?B?OG5YazIwTHBIUzNGY1RPQzJOYVdLQXRjbCs3LzBkUXN2bElncHpvd3dNUGJP?=
 =?utf-8?B?RkE1V3VucUd3eng4UGxTZlUybWZyKzBpVEhCV3VXUE9iN3FjOVoraHJiNDAv?=
 =?utf-8?B?UnFGcWlESm1nQVo2RWJya3BFbm16YXRxTUNKYlFLRk9sSFc5MGxWV1JXMjZV?=
 =?utf-8?B?amV5bWtLaExzYWZoeDVid2xab2lzTFd0K0g1MExRVzhDRHBZV3dBZmRrNmhy?=
 =?utf-8?B?QjFNQzNxeTBFTFh3T1hOZUNKd3JHZlZpYXc4cWlKRTV1SkVOb1NPN3hWR3lL?=
 =?utf-8?B?ekRiR0hSMWFPQ0Rtcko3ckluTXpNSDNkM3dLWVMrNDY3TU1GbWUvNXFuVlJJ?=
 =?utf-8?B?ZURDZkp0R0xLSzJWMGg3QTFyUWR1YmY1Z0E5YXQ1cWtpL0xRMEsrRTNaT1FO?=
 =?utf-8?B?ZURyOVErMTVyTXFOUTBJc1dUS1RlSGhaRE03RXhsOFE0OENnanZhRW0yMGd3?=
 =?utf-8?B?dFlCYmFWM3FtWlVsMnA1a0lBNG53L2oxTThjeWlkTjNMblJMSW9lT2J2b0FO?=
 =?utf-8?B?QUE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e04f1258-1af6-4ab7-2081-08dab0cdf6b3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 05:59:48.1783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1SOiFOYbupCU6xby2ZczB+gKHyTmmEoWgb7fqu8uxR/T8NMRPox/+L/5jW6I2/L1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3225
X-Proofpoint-GUID: -Yy5ljWKJcFAJiAoMhbQBL9EgNsVh-Xd
X-Proofpoint-ORIG-GUID: -Yy5ljWKJcFAJiAoMhbQBL9EgNsVh-Xd
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_01,2022-10-17_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 10/17/22 5:52 PM, Martin KaFai Lau wrote:
> On 10/17/22 3:16 PM, sdf@google.com wrote:
>> On 10/17, Martin KaFai Lau wrote:
>>> On 10/17/22 12:11 PM, Yosry Ahmed wrote:
>>> > On Mon, Oct 17, 2022 at 12:07 PM Stanislav Fomichev 
>>> <sdf@google.com> wrote:
>>> > >
>>> > > On Mon, Oct 17, 2022 at 11:47 AM Yosry Ahmed 
>>> <yosryahmed@google.com> wrote:
>>> > > >
>>> > > > On Mon, Oct 17, 2022 at 11:43 AM Stanislav Fomichev 
>>> <sdf@google.com> wrote:
>>> > > > >
>>> > > > > On Mon, Oct 17, 2022 at 11:26 AM Yosry Ahmed 
>>> <yosryahmed@google.com> wrote:
>>> > > > > >
>>> > > > > > On Mon, Oct 17, 2022 at 11:02 AM <sdf@google.com> wrote:
>>> > > > > > >
>>> > > > > > > On 10/13, Yonghong Song wrote:
>>> > > > > > > > Similar to sk/inode/task storage, implement similar 
>>> cgroup local storage.
>>> > > > > > >
>>> > > > > > > > There already exists a local storage implementation for 
>>> cgroup-attached
>>> > > > > > > > bpf programs.  See map type BPF_MAP_TYPE_CGROUP_STORAGE 
>>> and helper
>>> > > > > > > > bpf_get_local_storage(). But there are use cases such 
>>> that non-cgroup
>>> > > > > > > > attached bpf progs wants to access cgroup local storage 
>>> data. For example,
>>> > > > > > > > tc egress prog has access to sk and cgroup. It is 
>>> possible to use
>>> > > > > > > > sk local storage to emulate cgroup local storage by 
>>> storing data in
>>> > > > > > > > socket.
>>> > > > > > > > But this is a waste as it could be lots of sockets 
>>> belonging to a
>>> > > > > > > > particular
>>> > > > > > > > cgroup. Alternatively, a separate map can be created 
>>> with cgroup id as
>>> > > > > > > > the key.
>>> > > > > > > > But this will introduce additional overhead to 
>>> manipulate the new map.
>>> > > > > > > > A cgroup local storage, similar to existing 
>>> sk/inode/task storage,
>>> > > > > > > > should help for this use case.
>>> > > > > > >
>>> > > > > > > > The life-cycle of storage is managed with the 
>>> life-cycle of the
>>> > > > > > > > cgroup struct.  i.e. the storage is destroyed along 
>>> with the owning cgroup
>>> > > > > > > > with a callback to the bpf_cgroup_storage_free when 
>>> cgroup itself
>>> > > > > > > > is deleted.
>>> > > > > > >
>>> > > > > > > > The userspace map operations can be done by using a 
>>> cgroup fd as a key
>>> > > > > > > > passed to the lookup, update and delete operations.
>>> > > > > > >
>>> > > > > > >
>>> > > > > > > [..]
>>> > > > > > >
>>> > > > > > > > Since map name BPF_MAP_TYPE_CGROUP_STORAGE has been 
>>> used for old cgroup
>>> > > > > > > > local
>>> > > > > > > > storage support, the new map name 
>>> BPF_MAP_TYPE_CGROUP_LOCAL_STORAGE is
>>> > > > > > > > used
>>> > > > > > > > for cgroup storage available to non-cgroup-attached bpf 
>>> programs. The two
>>> > > > > > > > helpers are named as bpf_cgroup_local_storage_get() and
>>> > > > > > > > bpf_cgroup_local_storage_delete().
>>> > > > > > >
>>> > > > > > > Have you considered doing something similar to 
>>> 7d9c3427894f ("bpf: Make
>>> > > > > > > cgroup storages shared between programs on the same 
>>> cgroup") where
>>> > > > > > > the map changes its behavior depending on the key size 
>>> (see key_size checks
>>> > > > > > > in cgroup_storage_map_alloc)? Looks like sizeof(int) for 
>>> fd still
>>> > > > > > > can be used so we can, in theory, reuse the name..
>>> > > > > > >
>>> > > > > > > Pros:
>>> > > > > > > - no need for a new map name
>>> > > > > > >
>>> > > > > > > Cons:
>>> > > > > > > - existing BPF_MAP_TYPE_CGROUP_STORAGE is already messy; 
>>> might be not a
>>> > > > > > >     good idea to add more stuff to it?
>>> > > > > > >
>>> > > > > > > But, for the very least, should we also extend
>>> > > > > > > Documentation/bpf/map_cgroup_storage.rst to cover the new 
>>> map? We've
>>> > > > > > > tried to keep some of the important details in there..
>>> > > > > >
>>> > > > > > This might be a long shot, but is it possible to switch 
>>> completely to
>>> > > > > > this new generic cgroup storage, and for programs that 
>>> attach to
>>> > > > > > cgroups we can still do lookups/allocations during 
>>> attachment like we
>>> > > > > > do today? IOW, maintain the current API for cgroup progs 
>>> but switch it
>>> > > > > > to use this new map type instead.
>>> > > > > >
>>> > > > > > It feels like this map type is more generic and can be a 
>>> superset of
>>> > > > > > the existing cgroup storage, but I feel like I am missing 
>>> something.
>>> > > > >
>>> > > > > I feel like the biggest issue is that the existing
>>> > > > > bpf_get_local_storage helper is guaranteed to always return 
>>> non-null
>>> > > > > and the verifier doesn't require the programs to do null 
>>> checks on it;
>>> > > > > the new helper might return NULL making all existing programs 
>>> fail the
>>> > > > > verifier.
>>> > > >
>>> > > > What I meant is, keep the old bpf_get_local_storage helper only 
>>> for
>>> > > > cgroup-attached programs like we have today, and add a new generic
>>> > > > bpf_cgroup_local_storage_get() helper.
>>> > > >
>>> > > > For cgroup-attached programs, make sure a cgroup storage entry is
>>> > > > allocated and hooked to the helper on program attach time, to keep
>>> > > > today's behavior constant.
>>> > > >
>>> > > > For other programs, the bpf_cgroup_local_storage_get() will do the
>>> > > > normal lookup and allocate if necessary.
>>> > > >
>>> > > > Does this make any sense to you?
>>> > >
>>> > > But then you also need to somehow mark these to make sure it's not
>>> > > possible to delete them as long as the program is 
>>> loaded/attached? Not
>>> > > saying it's impossible, but it's a bit of a departure from the
>>> > > existing common local storage framework used by inode/task; not sure
>>> > > whether we want to pull all this complexity in there? But we can
>>> > > definitely try if there is a wider agreement..
>>> >
>>> > I agree that it's not ideal, but it feels like we are comparing two
>>> > non-ideal options anyway, I am just throwing ideas around :)
>>
>>> I don't think it is a good idea to marry the new
>>> BPF_MAP_TYPE_CGROUP_LOCAL_STORAGE and the existing
>>> BPF_MAP_TYPE_CGROUP_STORAGE in any way.  The API is very different.  
>>> A few
>>> have already been mentioned here.  Delete is one.  Storage creation 
>>> time is
>>> another one.  The map key is also different.  Yes, maybe we can reuse 
>>> the
>>> different key size concept in bpf_cgroup_storage_key in some way but 
>>> still
>>> feel too much unnecessary quirks for the existing sk/inode/task storage
>>> users to remember.
>>
>>> imo, it is better to keep them separate and have a different map-type.
>>> Adding a map flag or using map extra will make it sounds like an 
>>> extension
>>> which it is not.
>>
>> This part is the most confusing to me:
>>
>> BPF_MAP_TYPE_CGROUP_STORAGE       bpf_get_local_storage
>> BPF_MAP_TYPE_CGROUP_LOCAL_STORAGE bpf_cgroup_local_storage_get
>>
>> The new helpers should probably drop 'local' name to match the 
>> task/inode ([0])?
>> And we're left with:
>>
>> BPF_MAP_TYPE_CGROUP_STORAGE       bpf_get_local_storage
>> BPF_MAP_TYPE_CGROUP_LOCAL_STORAGE bpf_cgroup_storage_get
>>
>> You read CGROUP_STORAGE via get_local_storage and
>> you read CGROUP_LOCAL_STORAGE via cgroup_storage_get :-/
> 
> Yep, agree that it is not ideal :(

I guess I need to add more documentation to explain the difference
of old and new map regardless of the final names.

> 
>>
>> That's why I'm slightly tilting towards reusing the name. At least we can
>> add a big DEPRECATED message for bpf_get_local_storage and that seems 
>> to be
>> it? All those extra key sizes can also be deprecated, but I'm honestly
>> not sure if anybody is using them.
> 
> Reusing 'key_size == sizeof(int)' to mean new map type...hmm...  I have 
> been thinking about it after your suggestion in another reply since it 
> can use the BPF_MAP_TYPE_CGROUP_STORAGE name.  I wish the 
> BPF_MAP_TYPE_CGROUP_LOCAL_STORAGE was given to the 
> bpf_get_local_storage() instead because it is a better name to describe 
> what it is doing.
> 
> hmm.... However, this feels working like a map_flags or map_extra but in 
> a more hidden way.  I am worry it will actually be more confusing and 
> also having usage surprises when there are quite many behavior 
> differences that this thread has already mentioned.  That will be hard 
> for the user to reason those API differences just because of using a 
> different key_size.
> 
> May be going back to revisit the naming a little bit.  How about giving 
> a new and likely more correct 'BPF_MAP_TYPE_CGRP_LOCAL_STORAGE' name for 
> the existing bpf_get_local_storage() use.  Then
> 
> '#define BPF_MAP_TYPE_CGROUP_STORAGE BPF_MAP_TYPE_CGRP_LOCAL_STORAGE /* 
> depreciated by BPF_MAP_TYPE_CGRP_STORAGE */' in the uapi.
> 
> The new cgroup storage uses a shorter name "cgrp", like 
> BPF_MAP_TYPE_CGRP_STORAGE and bpf_cgrp_storage_get()?

This might work and the naming convention will be similar to
existing sk/inode/task storage.

Another alternative is to name the map name as
     BPF_MAP_TYPE_CGROUP_STORAGE2
to indicate it is a different version of cgroup_storage map
and the documentation should explain the difference clearly.
This should avoid the possible confusion between
BPF_MAP_TYPE_CGROUP_STORAGE and BPF_MAP_TYPE_CGRP_STORAGE.

> 
>>
>> But having a separate map also seems fine, as long as we have a patch to
>> update the existing header documentation. (and mention in
>> Documentation/bpf/map_cgroup_storage.rst that there is a replacement?)
>> Current bpf_get_local_storage description is too vague; let's at least
>> mention that it works only with BPF_MAP_TYPE_CGROUP_STORAGE.
>>
>> 0: 
>> https://lore.kernel.org/bpf/6ce7d490-f015-531f-3dbb-b6f7717f0590@meta.com/T/#mb2107250caa19a8d9ec3549a52f4a9698be99e33
>>
>>> > >
>>> > > > > There might be something else I don't remember at this point 
>>> (besides
>>> > > > > that weird per-prog_type that we'd have to emulate as well)..
>>> > > >
>>> > > > Yeah there are things that will need to be emulated, but I feel 
>>> like
>>> > > > we may end up with less confusing code (and less code in general).
>>
>>
> 
