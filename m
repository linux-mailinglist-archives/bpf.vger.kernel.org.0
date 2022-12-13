Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEC664BEE6
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 22:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237060AbiLMV4L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 16:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237015AbiLMVzn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 16:55:43 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FF4131
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 13:54:47 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 2BDJOUcm014712;
        Tue, 13 Dec 2022 13:54:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=dFYnaWflAT8MPTLYwgC89KF4Zir4ugAEm3+GvrXEbkw=;
 b=XaDzgwol2d0n3//4PsqaXVC9FFax+qU9BKGVTsCZKZ3InzdiAEsyzi9dQzP1sUk/ttt2
 tjtEQaG6acNkc9M30xDji5+3nmSrAteqoxNoY7iuk/RK8XuLMUFgBlu+C/4I8dx6Yd0o
 MTIZmCNNDk1PRsx7PdPq1xptgpyHF5rLDgm9VoRguYIgcarXtJfL3Xb1DDyb0dL3ZuzH
 7v4FGPWtBn8falAp+ImJTiYAdQuKI6b075dqSuOTR+ZuFgkaC1i3uGN7xHZuR3Itu3zF
 DW2hziIdfdEFkkydfr0xLALXUqmKXYiaGavLbp2zr4UyvVMklXLxodwvgTAB96Fs7I7A 1Q== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by m0001303.ppops.net (PPS) with ESMTPS id 3meyf81vxr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 13:54:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AFksFaG1tYPNDg9I/iwfGexlWNYw6RlKQOmBXLPv6SnTENzCMo9yQ2eX9t8YRG8uftajqtpsKuncitB/CcXY60BkHC17V46uOm2QVYXf9xAQ/xvMasNIXSOPtkZdQliT6E3wmGvtIwoVr3utuDZK0FBv7nja4Z9PLVMvZMKCLZ6G0OH97M4QeRT65dLhhPmMaLCTIanzAvW4qWeEem9G2IkEKpe0vWcidfYYVyGvk4hciMkhCp2i4BGOCoPD4TDQfgya4cTvMSUyawdKubuuxK0Z974EfaTgATRzrEm4azCtxc6XJiVn98rIVFk2aZGmEKNFhR+kHUjMdPeInGs43Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dFYnaWflAT8MPTLYwgC89KF4Zir4ugAEm3+GvrXEbkw=;
 b=Nvf8UKohLkwaemAGGQBLA/R6hpx9XI4NYWCp+3fmbcyB8lTLcnGageo1jfnc8ql0X2JPC1nGPzia1DdnW3DnqNZduMgq9vMZLTj0PmNgtSJ5Ipc+97vo6UlkZAVqaRZeFtwQlQu8Y9KtkDPfMB72dPQZmIHjvKfgo43Z8KFmbZ+TNUKjK3khTt5uROcem+QadN9wjq7VxOuTjGtSdiMQ8FJW+9xeI0HhsmjvexJLnsYGffnSqFXiHnrEAlJV53RhK93ZdE1MAbzKQUR3m2dGPk0tkMd/ObczIZnIi5+fTMMWLVwAdVgXY/bL8L7cx3hA5xLqRQH3zVh9NpW96O4xMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BN8PR15MB3348.namprd15.prod.outlook.com (2603:10b6:408:a2::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 21:54:42 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d665:7e05:61d1:aebf]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d665:7e05:61d1:aebf%7]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 21:54:41 +0000
Message-ID: <76c8be5a-685d-539c-7323-ab1dc9b06464@meta.com>
Date:   Tue, 13 Dec 2022 13:54:39 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH bpf-next v2 5/9] bpf: Implement cgroup sockaddr hooks for
 unix sockets
Content-Language: en-US
To:     Daan De Meyer <daan.j.demeyer@gmail.com>
Cc:     bpf@vger.kernel.org, martin.lau@linux.dev, kernel-team@meta.com
References: <20221210193559.371515-1-daan.j.demeyer@gmail.com>
 <20221210193559.371515-6-daan.j.demeyer@gmail.com>
 <70ea5f8b-be37-267e-56d6-381938cb6e5b@meta.com>
 <CAO8sHcmNKN6kagFeCoWzjf1K0sOqTQxfdDG-U8iqBGN=TaHefg@mail.gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <CAO8sHcmNKN6kagFeCoWzjf1K0sOqTQxfdDG-U8iqBGN=TaHefg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0209.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::34) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BN8PR15MB3348:EE_
X-MS-Office365-Filtering-Correlation-Id: 50bce403-2ffa-4af5-ffb3-08dadd54a389
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nizgeDzpm+H6A+H6gItVbSPoyBT5LQPSHhtsXyeRNA/679+3dQhO40ND8K0H51jvTk0ZTKv7JN9Z93GihFRCuujW4NL3XMyR4sYl9TIq8K0wnvOH971KfcYCTVb0XWkepQFTeaxxpOmPmtIG6qOTn9+DpebT8JgPS2yIlgaPJXxWL7WUwhBNaejBOx+n9GA/OXtWwd5zND5F+mPhUh4uQcgPQh2LLGkg88dMtUT+EwKH9hh+6GMTU4Y7G6ZnXYoUAW9lifU77jOCZedq853OzkFz1paXTGdY/y6L6Nn7vX852LyebVxFjuV9KuT/EtGInKrOpY76+nUxRkSfGyiHXOZvIXrOGr+6AaP3IoUjPVBz5eH8OoYZPoiyOOR6c8vTloxvEQweV4dNqyFUgSf8QOV6Jiaywv/7NEW3LkJFwfZCddX27+GHZO36NaCb0AzKQ1XgJRxOtcWfa6Foz/Hi3VP8idBhlwISYsvHqkR5lWhyCq8M0b+Zn9B1642aNfM9tTsc2PFgKv+ckY5Ib+JcujOtsHt9IpZk8WwBBw4C+HHPItRuXImEKveVVGaavNO9An7ktLGVhF7SUwY3LRvHHx64dtqE6UxVc6Oa4qqSIZHvCsTL57OtyJlKtutwGZRSD1M7dzmvXP5ZECb6QeTeM1Z8Hnoi+45lz6pGgRstrQ41otq7HBv5Cdo/DIDjeUbCKYb4jXN74e+xR/F72C8/tyguag98iu0w5+wJnR/DHRU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(136003)(396003)(39860400002)(376002)(451199015)(83380400001)(2616005)(186003)(2906002)(38100700002)(86362001)(6512007)(31696002)(5660300002)(41300700001)(8936002)(36756003)(6916009)(66899015)(31686004)(107886003)(316002)(6486002)(478600001)(6506007)(8676002)(66476007)(4326008)(66556008)(53546011)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1dwRFpIUUdNNUpNTFh3ZWc0NWZZRTBNUm1CT1A2SlRYVDBSZy96SFVNSGVD?=
 =?utf-8?B?bjBuZ0xGeG9BUVdVZXNZdER0T0VUTWFiUGI4c2t6SThDRWlpZGw1ak1wczlV?=
 =?utf-8?B?dlNRaXE3SGJiM2JEMklta3A4OFdZRjNZK000c0NRVXVNODhlbHV4bUtrekxt?=
 =?utf-8?B?SUN1aXM5eER2VkpMVXU3ZVJodXBzeG5XZFN5WXEvbktHbDFEdGJJWVhKdCs4?=
 =?utf-8?B?ZzZGWE52aXUrbEpWdEZUblFac2NjYVNtUkpCR0N4Q2RxNm4xVGd0bnlBamc2?=
 =?utf-8?B?REI2RHZmR01FMi80dUJMemd4QzJ6UE9oTUl3ZzY5KzRheXQ5NDVTczl3Z2tx?=
 =?utf-8?B?TldXd2NPekRBSWJmaWhIUlk4bHdJMUpLSXRqVmlwVGEyVGJqUWJkVXlhVDh6?=
 =?utf-8?B?SUt0ZVpIWGNIblZITVVaOWtHWkYwL1Y0dDRkcXRzaTlOWnVUbFd2SFpaTnlQ?=
 =?utf-8?B?QWF5WFhTU1JlVkRyRGlLZ1oxbjdzR0pPcUowU1dDbGpVL1FidXYzSk5HQXpC?=
 =?utf-8?B?QWRFdGhNM3BaNE1wQ1FHemdDVmNXME9NYjFNRUFaaHhQMmpGcFN0b0xlQUk2?=
 =?utf-8?B?NytOaDNhc0dEa2VqVEV0M3M2UytMUjBlRklGemprd3lTUkQyYzVSMGhEajMx?=
 =?utf-8?B?SXhWUHhxU2U1VGNEZEhkZmFDa2VxQXd1UU4vNnVLc1lRTFoxM3U2Z3lvcnVy?=
 =?utf-8?B?SDFWYUtvZU5kcHRERWthQ0dBQWtRNmc1ZW1COURRQXdxQWwvZGI4K253M0dG?=
 =?utf-8?B?SGppZTdKTXpmTFZyMUpoMEtNOTA0ZTQvMy9ybU0xZ3NCT0VIMHp1TUhHV091?=
 =?utf-8?B?TWVEa2w4L1RsSE9nQjBEMFlPWXhNalVqcnBHOS9kcHAydThEZ2h1VHpQWkxJ?=
 =?utf-8?B?cmIxb0dZejV4MVJRRFE0T0JteXZKemRHb1l4dFU1bWwzR1JScFVzdWhzdFJj?=
 =?utf-8?B?cVBKNytiQ1V0akMyOUIzUVlxTVB1N2hYWUUyUUZBcDBmS1JiMWM0VGhHbmxv?=
 =?utf-8?B?bFlYYVRrekRvTGdoNEpiUHRqK3Q0NGZud0hoeFF5Zkp2NXoxZUpKM0paNWVL?=
 =?utf-8?B?QUpkeGlYYzR0eTdLYXg4MzFhRDYyYXkzWXJ4SzRjd1FiUm1LSHlwSUFuSFRE?=
 =?utf-8?B?UjJoaGIyUEIxVXdNS0p6Z0JBTFp3aG1MTXpwYWtyTENUanU4aWE2dmRBL25X?=
 =?utf-8?B?c1ZLVGpzb2s0RFJRUzZraFp1QjZVSWwxc29STXJyMDJNSnhGOExQUHExT2Ur?=
 =?utf-8?B?Zmw5VnVDOW5XYS9CcG5FRDJzeHpwSldaaXk3a2RXME94WEVjclAyUjF5ZTYr?=
 =?utf-8?B?TXRWamxoRmtIcWxOd0YvblZ4dTFabEQrdkx6MFRDNnlyalREVVdueWJhU01m?=
 =?utf-8?B?N1dkWllFV01iUTc0RGpRN0VPZ3Y3dzdwbUFxcjhyalVBTTBIcmZ3eXNjVnVj?=
 =?utf-8?B?OHdPTnE1OHloak1mejFEUU9GNGxXWUFaeXBJOThkSDVHY24xQVdINFBsZWpi?=
 =?utf-8?B?b3JIOFBqbHE1RkdPMjVoTk5PaUtwZHRlRjB5MUNSY3U0bjlYNVJXaFRieWgr?=
 =?utf-8?B?b3NITTNTWnZ3eDNQYzh0cTE5Y0N3U3E4bXkyNURyRERvNkZZV0xJYkU3RWta?=
 =?utf-8?B?ZlFzVWN4TzlWNDE0QXQxem95cUxWOHpYQUZrc2R0S0x2RnlOMnBBMjVMNzBo?=
 =?utf-8?B?N3pIRkRUcWZYSGp1bFFDZ21Tc1lSbzV5MzI2WDlzMkRCZ3BFcEF6VEl5WkNp?=
 =?utf-8?B?cEZEMjJoWVptNkRMRWJxUUttKzEyaTZNbVNaZ2VQTUx2bnNMS0NRMEtpSGM5?=
 =?utf-8?B?aUpFRUJzaTdBU0h2d1NpUmlUSU12NEZLcDNRUk1rSjV2UnVHVlV0ZlNoQVBX?=
 =?utf-8?B?RFh4Z1F4S1Q4RG4wcWIvblYydFFKUUg0bTNYTkt3bW5RN2NYUEl2RW82RXB3?=
 =?utf-8?B?Sk1tNkdwTXQ1VGo0bk1JNHRhMnloaWFpMkxFUjhoOE5wcjB1bmNrSTFYM0Ey?=
 =?utf-8?B?Vm9iVEVlSUpENG1YaU9YTUowc0kxUy8ybC9veFNlZGJ2K2xDNGVZYUc2bEZh?=
 =?utf-8?B?SUtzMUhiNWhLTGV4bFVhai8xLzE5Nm1YakhlekczaGRXTjFpUzN1Q284VnY1?=
 =?utf-8?B?NnJ5UW5OZ3NFcGZ6blJjazlJYnVGYWZmendOaGpleWtVbWJYQks5TGU2ZHlt?=
 =?utf-8?B?L2c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50bce403-2ffa-4af5-ffb3-08dadd54a389
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 21:54:41.8317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UWFPXeif1O2bwbq5SHoPkNe0uYvY6mg/CREmIT0yiC2xch4Q301EJ+k2/lM7nl5G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3348
X-Proofpoint-ORIG-GUID: W7x8xdgxMTL880OVxwkMB6qKiJ9y41H8
X-Proofpoint-GUID: W7x8xdgxMTL880OVxwkMB6qKiJ9y41H8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/13/22 3:36 AM, Daan De Meyer wrote:
>> On 12/10/22 11:35 AM, Daan De Meyer wrote:
>>> These hooks allows intercepting bind(), connect(), getsockname(),
>>> getpeername(), sendmsg() and recvmsg() for unix sockets. The unix
>>> socket hooks get write access to the address length because the
>>> address length is not fixed when dealing with unix sockets and
>>> needs to be modified when a unix socket address is modified by
>>> the hook. Because abstract socket unix addresses start with a
>>> NUL byte, we cannot recalculate the socket address in kernelspace
>>> after running the hook by calculating the length of the unix socket
>>> path using strlen().
>>
>> Yes, although we cannot calculate the socket path length with
>> strlen(). But we still have a method to find the path. In
>> unix_seq_show(), the unix socket path is calculated as below,
>>
>>                   if (u->addr) {  // under a hash table lock here
>>                           int i, len;
>>                           seq_putc(seq, ' ');
>>
>>                           i = 0;
>>                           len = u->addr->len -
>>                                   offsetof(struct sockaddr_un, sun_path);
>>                           if (u->addr->name->sun_path[0]) {
>>                                   len--;
>>                           } else {
>>                                   seq_putc(seq, '@');
>>                                   i++;
>>                           }
>>                           for ( ; i < len; i++)
>>                                   seq_putc(seq, u->addr->name->sun_path[i] ?:
>>                                            '@');
>>                   }
>>
>> Is it possible that we can use the above method to find the
>> address length so we won't need to pass uaddr_len to bpf program?
>>
>> Since all other hooks do not need to uaddr_len, you could add some
>> new hooks for unix socket which can specially calculate uaddr_len
>> after the bpf program run.
> 
> I don't think we can. If we look at the definition of abstract unix
> socket in the official man page:
> 
>> abstract: an abstract socket address is distinguished (from a pathname socket) by the fact that sun_path[0] is a null byte ('\0').  The socket's address in this namespace is given by the additional bytes in sun_path that are covered by the specified length of the address structure.  (Null bytes in
>> the  name  have  no  special  significance.)   The name has no connection with filesystem pathnames.  When the address of an abstract socket is returned, the returned addrlen is greater than sizeof(sa_family_t) (i.e., greater than 2), and the name of the socket is contained in the first (addrlen -
>> sizeof(sa_family_t)) bytes of sun_path.
> 
> This specifically says that the address in the abstract namespace is
> given by the additional bytes in sun_path that are covered by the
> length of the address structure. If I understand correctly, that means
> there's no way to derive the length from just the contents of the
> sockaddr structure. We need
> the actual length as specified by the caller to know which bytes
> belong to the address. Note that it's valid for the abstract name to
> contain Null bytes, so we cannot use those in any way or form to
> detect whether further bytes belong to the address or not. It seems
> valid to have an abstract name
> consisting of 107 Null bytes in sun_path.

Okay, it looks like bpf program is able to set abstract name as well.
It would be good we have an example for this in selftest.

With abstract address setable by bpf program, I guess you are right,
we have to let user to explicitly tell us the address length.

I assume it is possible for user to write an address like below:
"a\0b\0"
addr_len = offsetof(struct sockaddr_un, sun_path) + 4
but actually it is illegal, right? We have to validate the
legality of sun_path/addr_len beyond unix_validate_addr(), right?

> 
> 
> On Tue, 13 Dec 2022 at 06:20, Yonghong Song <yhs@meta.com> wrote:
>>
>>
>>
>> On 12/10/22 11:35 AM, Daan De Meyer wrote:
>>> These hooks allows intercepting bind(), connect(), getsockname(),
>>> getpeername(), sendmsg() and recvmsg() for unix sockets. The unix
>>> socket hooks get write access to the address length because the
>>> address length is not fixed when dealing with unix sockets and
>>> needs to be modified when a unix socket address is modified by
>>> the hook. Because abstract socket unix addresses start with a
>>> NUL byte, we cannot recalculate the socket address in kernelspace
>>> after running the hook by calculating the length of the unix socket
>>> path using strlen().
>>
>> Yes, although we cannot calculate the socket path length with
>> strlen(). But we still have a method to find the path. In
>> unix_seq_show(), the unix socket path is calculated as below,
>>
>>                   if (u->addr) {  // under a hash table lock here
>>                           int i, len;
>>                           seq_putc(seq, ' ');
>>
>>                           i = 0;
>>                           len = u->addr->len -
>>                                   offsetof(struct sockaddr_un, sun_path);
>>                           if (u->addr->name->sun_path[0]) {
>>                                   len--;
>>                           } else {
>>                                   seq_putc(seq, '@');
>>                                   i++;
>>                           }
>>                           for ( ; i < len; i++)
>>                                   seq_putc(seq, u->addr->name->sun_path[i] ?:
>>                                            '@');
>>                   }
>>
>> Is it possible that we can use the above method to find the
>> address length so we won't need to pass uaddr_len to bpf program?
>>
>> Since all other hooks do not need to uaddr_len, you could add some
>> new hooks for unix socket which can specially calculate uaddr_len
>> after the bpf program run.
>>
>>>
>>> This hook can be used when users want to multiplex syscall to a
>>> single unix socket to multiple different processes behind the scenes
>>> by redirecting the connect() and other syscalls to process specific
>>> sockets.
>>> ---
>>>    include/linux/bpf-cgroup-defs.h |  6 +++
>>>    include/linux/bpf-cgroup.h      | 29 ++++++++++-
>>>    include/uapi/linux/bpf.h        | 14 ++++--
>>>    kernel/bpf/cgroup.c             | 11 ++++-
>>>    kernel/bpf/syscall.c            | 18 +++++++
>>>    kernel/bpf/verifier.c           |  7 ++-
>>>    net/core/filter.c               | 45 +++++++++++++++--
>>>    net/unix/af_unix.c              | 85 +++++++++++++++++++++++++++++----
>>>    tools/include/uapi/linux/bpf.h  | 14 ++++--
>>>    9 files changed, 204 insertions(+), 25 deletions(-)
>>>
[...]
