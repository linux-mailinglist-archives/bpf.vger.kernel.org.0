Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB2293C7381
	for <lists+bpf@lfdr.de>; Tue, 13 Jul 2021 17:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236932AbhGMPtl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Jul 2021 11:49:41 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43140 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237061AbhGMPtl (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 13 Jul 2021 11:49:41 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16DFjU1W018475;
        Tue, 13 Jul 2021 08:46:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=10J7h0rC/IQ5JtwMT5mFoHGtdSxG5DSMJ9rjgtluz6E=;
 b=SLyGNC0X+boAq4aOx4wFxeerlxb/PS6ga995PvYAP0XdAL8kEdw3b0Or4M1RpZzPhz5q
 9l8c5Hg0J87xX+IRPa/F+rMEZeEGYtZ+jBuu2RYxhVYO4+XdYrtHoDbQ+DsW8XAiBR/h
 +4RMayu5FM18v7EIK6iYtbcXpfejQsT+bv4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 39rsx1pvny-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 13 Jul 2021 08:46:50 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 13 Jul 2021 08:46:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJL3DtIRgfWMZijcCvoGI59hksyisiUlVszs/WWEyKYlYFrMuHnk51dkeJFNvPl0N3kRARBYBzF0MKALFUmQatVlO9vgH2Q5N/KB70zLRz7hndFVg9qPvPcSjPoRgeN9O3tOJodIfZM987q7OP9zuRbhwlb0lC/Rj4wcnlxr5AxKVWW2DUmewXK/jClZ/c/4kCRfutnqx/DV265cDWpIFDH3fCfNWzCzFGPUPa7bKqXxcRDVDrX1dpNuur7+4rHM379H/Bd3wlzs55upHsDKgUh1ADH3XC3GXQqDm93O4cf4szPlwG4IBd5xCHn6HPrtU26iFBoTYlcQYyJhlS3vSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10J7h0rC/IQ5JtwMT5mFoHGtdSxG5DSMJ9rjgtluz6E=;
 b=T2nxvAOc5opgDdc//rB7vZ5ps3Dy1cLk34rmClAT+S/wrDXBkFsQsjxXybknqsKeBvQHbtHyMEYPH8NXROHpZq8mB14mSmobuLdDHeao/7ZK3p9raR863wjiJwZcp79lh87IrwjS1FHh5h29+WW64dgjpG/0zy7lgVdDTIMPWwev0hGIrDo6ec5OiG4gm3WIBRx9aBQMuFWjooou9KKnN1cDx6c0gVYoCJ/iLBEdRfg9YKwah0hOVyU0rBkNLT9cIj2dvm5tR28fgNswa1bTAIlCvEQ7nCxPQMrWdUoirz9cjbwttGHzqCbWfRCZSS2T/vvyHHbOnszpM4+7zQrRNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4808.namprd15.prod.outlook.com (2603:10b6:806:1e3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Tue, 13 Jul
 2021 15:46:39 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb%7]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 15:46:39 +0000
Subject: Re: R1 invalid mem access 'inv'
To:     Vincent Li <vincent.mc.li@gmail.com>
CC:     <bpf@vger.kernel.org>
References: <c43bc0a9-9eca-44df-d0c7-7865f448cc24@gmail.com>
 <92121d33-4a45-b27a-e3cd-e54232924583@fb.com>
 <79e4924c-e581-47dd-875c-6fd72e85dfac@gmail.com>
 <6c6b765d-1d8e-671c-c0a9-97b44c04862c@fb.com>
 <85caf3b3-868-7085-f4df-89df7930ad9b@gmail.com>
 <ce2ea7e8-0443-3e78-6cf8-d3105f729646@fb.com>
 <64cd3e3e-3b6-52b2-f176-9075f4804b7a@gmail.com>
 <497fc0fe-8036-8b79-2c6e-495f2a7b0ae@gmail.com>
 <CAK3+h2xv-EZH9afEymGqKdwHozHHu=XHJYKispFSixYxz7YVLQ@mail.gmail.com>
 <CAK3+h2zW5ZgnXu0_iMHUMLxmgVd2EAoRFuwAEKVkJwOnxSp56g@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <efbbc4bc-5513-82d4-4f00-28c690653509@fb.com>
Date:   Tue, 13 Jul 2021 08:46:36 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <CAK3+h2zW5ZgnXu0_iMHUMLxmgVd2EAoRFuwAEKVkJwOnxSp56g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-ClientProxiedBy: SJ0PR13CA0154.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::9) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c1::1156] (2620:10d:c090:400::5:a0d4) by SJ0PR13CA0154.namprd13.prod.outlook.com (2603:10b6:a03:2c7::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.10 via Frontend Transport; Tue, 13 Jul 2021 15:46:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc58049d-cf66-44bf-a76d-08d946156732
X-MS-TrafficTypeDiagnostic: SA1PR15MB4808:
X-Microsoft-Antispam-PRVS: <SA1PR15MB4808DAEB96C2F43CAD721FACD3149@SA1PR15MB4808.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:619;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dlJnq5N/pveoYKml81fuNyTVdcTzD4oBxiS32TjU5MbV+OjDNf+n12gICVBqdKv3+mMbPYOR+nS0LWou9BquuKZX3Ddzu33fwHAmtFR0AsJA0Uzaoc1DHU2Llv8RJAibhQhMo60XZSIFwasPIWsLoqNWkh6VMb70c56wTzjaUBpvnUSMGgvdNJuvht0GGSfL0cCUXL9YIsH/TiiR2wdQ7Xly/jIcHreS24lXX28HZpmVEsCfo06UjhRXbZcyuWPQ/WempGTytn/UolTySzlViuXhFMrf4U5iTJPggy/vDkHuaFDk4UYfTUqrtlX+djXPG+gXlLmiKJV30hE5rptLwdYRPUNyQ14RPxaDn7qpJOKGthh9/liEgx1yjL7fxJTBdxtglBzSfQraEcn6WNwYbom0mMXJ1NaACCUDOet9cLJ+5x8A0nh3geZmh8HdC2J87dv5lCPzQwV6tiK+h2Adjin3Tk66QVsln1XQr2I4rM0Q8yM9Zj/IWKx2ecWoUz2muOF5P4qnzdJzKy2aRTp0ZkQ6avbdv6KwTwLBllQSwEOu65C3sUYZ4rKlSSdpoQFEZIpZsGzAPwqV7cTErcRfMPUIQOtQULmsxnQaV4WNGzr+xGCvVua+wxQpJBJRl4bnTKb+NNsmf0+HjSdqLbHjamNxzb/A69Y0Ihy+W4r0Vwp+hdVvKMw8BM9jiQhYITtV6uh2XS6OSvK3N2fn0DJVnCX5gNEUMRe4IlgVBXHSwXVqoKp+/Lmh+gH/P7+iqSksATyeSol9SjPFZhXjTb64rl+0vhnBI3QgIBRC/5ipO48A00e6zuHCOZhdVJl7i4OvpW+BcGZFfmuTp5E1XRy5441glqebotJmotE0YL17/AE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(39860400002)(136003)(396003)(376002)(31686004)(186003)(8936002)(86362001)(6486002)(4326008)(31696002)(38100700002)(8676002)(5660300002)(53546011)(2906002)(316002)(83380400001)(52116002)(66946007)(66476007)(66556008)(36756003)(966005)(6916009)(478600001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVFJalRTejVaNDEzYUF6NWYyT3d0R2EyY3BUZEV2L0pQRzNOSHZLWnRGK1d0?=
 =?utf-8?B?UXlSRkpRWmdlOUJKNGZqaUkrdXQvcnhjdnZEamIvaWo3eVRiT21hTGQ5ZlM0?=
 =?utf-8?B?YWJSc0FTTGZkYkNnV0RZQ29JKzQrU1FMVjlpczhHUFI2UXI0U1NZbmI4dTFu?=
 =?utf-8?B?MEo0dE5jK3NOcXo2UW9zN1RjV1ljTXY5L1cyVVJDdGliSUZEeTRsY0xBVlg1?=
 =?utf-8?B?Z0txdHBPbDJPNUMxTTRNNEo0VFFuR2svbXhHNlRMWFV6eXhhOERkaGRkUHJU?=
 =?utf-8?B?QitqRUFCZEFUSFNVZmdUQXpBcEFnNXB5VDNaWGdWaWRnaVNGMHBGaXJRVjVo?=
 =?utf-8?B?RksyODQxeEttajVJd2tqNjN5QTRrVXB2cXQ2VjZYYTVJQTBZWWdOR2k1c2wz?=
 =?utf-8?B?RmJ2ODJZc3hrajhxSU9KMTFsU1JGYXZaLzFyV3lRL1pPTjBCbjlpeGwrbC9G?=
 =?utf-8?B?Y3FrZ0pMRGRQZjRXV1ZyRDAvZTIrRDZIWWUyUVRzUWsvd3Y3OGtPQU8zazlo?=
 =?utf-8?B?M2g2RXcxMXN0QXhuRDBiblV3ejZGUXduaVl2NFZZSzNzVXU0a1dKYWhMYUR4?=
 =?utf-8?B?Y1o5Q0JQRkZMcitjazIwcHNLSkFVM0dPalRKUUcwdGlGRS9TY0ltclpSSURU?=
 =?utf-8?B?RTFvclNWV0xvbXd1OFBIWlUwa1NkaVVFYytpZ3FZTFBvU1k5M3p0VkRoQ0xv?=
 =?utf-8?B?L3VWRDhaNUlFekw3bEVndjMwMVdiL0hkRW9DTExkMXpBVm9JRUwrZDR1SHRQ?=
 =?utf-8?B?ZGU1REZwcnNMaXExZm5aR1lsQUp6TGpGN3RtUStJODJ4dHRsMlpwaTdTaGtZ?=
 =?utf-8?B?ZjB6ZkFJN1hlM0dNYWkyRDA2RUpqcjdNbWk2RkM3bSttVmFqd0ZIQnZSNVI1?=
 =?utf-8?B?Z0ZqNGUya2w2UWNLdU5pcWJXTEliQmh4TEtscWt3cHhuaVoxVStUdzFFM2RY?=
 =?utf-8?B?V3NReTZQcnBwZ05UV01vdmd6TkM5TFVST2pER0JtaDNJa2htRGJHWHUxTXhL?=
 =?utf-8?B?ZmNxQzNjYm1ITTJHL1hhK0M0V3pDbjBjOCtTU09yVEJ5RnQ0YjQ4WHFiQjk3?=
 =?utf-8?B?cU5OdGlLN01NaEdKMENQSDZoRjZsQ1JFMUI1ZVhTVWYxeGVHK25uRkUrdm40?=
 =?utf-8?B?NzdBT3VrNkxXaUxUWFFCNmkxdlBwR2R1aGk2V1paemhSMFd2YWtsaDBFeEJV?=
 =?utf-8?B?T2FKKzhoSDZIdTBvV2xZNkVIOXUzR0o3MTlEcHAyNHQvc0ZURUcrYXlYRG9W?=
 =?utf-8?B?K2NlQmdvQTdZUTE5MTJ0cjJpbXZ5RjBlZnE1MVZFVmJaTDltY1dOTFRjRTNT?=
 =?utf-8?B?Q1BPdE82TzJXWkVmSFpCRm90NG5hbUc0WnRtbTJtdms5VzRmcDE4VHNIUlRL?=
 =?utf-8?B?VnhnM2tFMld6Y2xWVXlJT2N1dmxrN3RmNDhkMmwwaFhxWGNtK0Y0cjRqcDhh?=
 =?utf-8?B?Z0tVSVFSWGZERGtjN0FPeU16cGtaUE92YWREVHpzVjNqL2dBa2J5MDFXYmh6?=
 =?utf-8?B?RGxjdjhIM054STg1M0lFT0VSM3FEOS8wd3hZS2xQK3k2N2ZJUWpHd0RYVGlU?=
 =?utf-8?B?NWpqNTVyNVhIVmgxRU5qNVJFZ1cxS0FrWVVic0ROWEdHdXVTUG5uUnJQeVBs?=
 =?utf-8?B?SHBCRENiRCtJSzRCSGwwV2dRSnJVVHZHaTFJc0dqYTlVd2NSSFJJOUd1MWxD?=
 =?utf-8?B?QURmUHE3aUdwVDAxL3AxTkxOOGZFVks2R2cxTml2eGZiWjhXWnR1VC9nVEg5?=
 =?utf-8?B?NUdQY0RmRWs3Ri9KcGJFMEF4N25VTzM2ek5rS2VrWUxvd2ZqRmVjcUw1QkZ3?=
 =?utf-8?B?eGhERUw4RU44bVdlQ0VKUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bc58049d-cf66-44bf-a76d-08d946156732
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 15:46:39.1005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VqIlehwEBIk73E4nY0iqM/f2PPEzXM/UMy5HXrP/3nCEohIRkACxPM1vX5PVdDOg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4808
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: Kn9orDg4d_v7hn3H3HSlHcZH3D30MUiX
X-Proofpoint-ORIG-GUID: Kn9orDg4d_v7hn3H3HSlHcZH3D30MUiX
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-13_08:2021-07-13,2021-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 mlxlogscore=956
 impostorscore=0 adultscore=0 malwarescore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2107130101
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/12/21 4:38 PM, Vincent Li wrote:
> Hi Yonghong,
> 
> 
> 
> On Fri, Jun 18, 2021 at 12:58 PM Vincent Li <vincent.mc.li@gmail.com> wrote:
>>
>> Hi Yonghong,
>>
>> I attached the full verifier log and BPF bytecode just in case it is
>> obvious to you, if it is not, that is ok. I tried to make sense out of
>> it and I failed due to my limited knowledge about BPF :)
>>
> 
> I followed your clue on investigating how fp-200=pkt changed to
> fp-200=inv in https://github.com/cilium/cilium/issues/16517#issuecomment-873522146
> with previous attached complete bpf verifier log and bpf bytecode, it
> eventually comes to following
> 
> 0000000000004948 :
>      2345: bf a3 00 00 00 00 00 00 r3 = r10
>      2346: 07 03 00 00 d0 ff ff ff r3 += -48
>      2347: b7 08 00 00 06 00 00 00 r8 = 6
> ; return ctx_store_bytes(ctx, off, mac, ETH_ALEN, 0);
>      2348: bf 61 00 00 00 00 00 00 r1 = r6
>      2349: b7 02 00 00 00 00 00 00 r2 = 0
>      2350: b7 04 00 00 06 00 00 00 r4 = 6
>      2351: b7 05 00 00 00 00 00 00 r5 = 0
>      2352: 85 00 00 00 09 00 00 00 call 9
>      2353: 67 00 00 00 20 00 00 00 r0 <<= 32
>      2354: c7 00 00 00 20 00 00 00 r0 s>>= 32
> ; if (eth_store_daddr(ctx, (__u8 *) &vtep_mac.addr, 0) < 0)
>      2355: c5 00 54 00 00 00 00 00 if r0 s< 0 goto +84
> 
> my new code is eth_store_daddr(ctx, (__u8 *) &vtep_mac.addr, 0) < 0;
> that is what i copied from other part of cilium code, eth_store_daddr
> is:
> 
> static __always_inline int eth_store_daddr(struct __ctx_buff *ctx,
> 
>                                             const __u8 *mac, int off)
> {
> #if !CTX_DIRECT_WRITE_OK
>          return eth_store_daddr_aligned(ctx, mac, off);
> #else
> ......
> }
> 
> and eth_store_daddr_aligned is
> 
> static __always_inline int eth_store_daddr_aligned(struct __ctx_buff *ctx,
> 
>                                                     const __u8 *mac, int off)
> {
>          return ctx_store_bytes(ctx, off, mac, ETH_ALEN, 0);
> }
> 
> Joe  from Cilium raised an interesting question on why the compiler
> put ctx_store_bytes() before  if (eth_store_daddr(ctx, (__u8 *)
> &vtep_mac.addr, 0) < 0),
> that seems to have  fp-200=pkt changed to fp-200=inv, and indeed if I
> skip the eth_store_daddr_aligned call, the issue is resolved, do you
> have clue on why compiler does that?

This is expected. After inlining, you got
    if (ctx_store_bytes(...) < 0) ...

So you need to do
    ctx_store_bytes(...)
first and then do the if condition.

Looking at the issue at https://github.com/cilium/cilium/issues/16517,
the reason seems due to xdp_store_bytes/skb_store_bytes.
When these helpers write some data into the stack based buffer, they
invalidate some stack contents. I don't know whether it is a false
postive case or not, i.e., the verifier invalidates the wrong stack
location conservatively. This needs further investigation.


> 
> I have more follow-up in https://github.com/cilium/cilium/issues/16517
> if you are interested to know the full picture.
> 
> Appreciate it very much if you have time to look at it :)
> 
> Vincent
> 
