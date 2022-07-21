Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2106657D38C
	for <lists+bpf@lfdr.de>; Thu, 21 Jul 2022 20:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbiGUSpr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Jul 2022 14:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiGUSpq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jul 2022 14:45:46 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A5221260
        for <bpf@vger.kernel.org>; Thu, 21 Jul 2022 11:45:45 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26LIjcUl015456;
        Thu, 21 Jul 2022 11:45:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=aPhRaRuD9QsGaaAKPiHwjbYjezjKp3cN55qLHurZ+Wk=;
 b=a65qkOuTWdjRHzywCMroPW/DsE3Wrq7FC5tRx+ix9VWpEY48H4tGCp88OXnrxoAehOT9
 tF/vhLXdAiRbGG14XPUN/mFDJCQW4eOwVJ5n54ZDQHskmHOtPJHfyLjclr7H44qb+NW9
 8M5PdSg04k1O6Kz4LCAC533E8wrcbyDeEdw= 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3heyc8vmg7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jul 2022 11:45:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LBh4TnDB2QdOew4a0l+O6Rdlyuw2ao1HT82Gn+2ZI9RxR1IRXfspxobBUaVQadACRUiCTI85U9GGNC70dPpLKFVRrPbB1It2wbLYF7Z9eT1H1RfQuLc7vz/1Afmdw62hkGKOVxdL+SKG0/O3SVM9bFJnxqjl0zI0eyLe2pJ05XUPWtfL2a8RTvLb85lbUsbIPRV/9DDlxrpmk25xnlZmV6KDrP0sS1Nz9iFbG8Ls3rPWsKrasB9fSay1cf00NzEofMjbzwgEJ+6SiPDQyMGQp07SAmnUUBdddW1jWAHc2uEMEt5tDON2Ojo8aCuT+2vJ6oLLwHp2saPSeAW1mEKPcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IaaeaBnJIO9B1r0LYuN2fekw3Kw3/tDcfGoSVrg41o4=;
 b=irpaNlvDyMOuo/eVW7RmJqRYuk3qR+ith9JncCOHoG30TqnSkamM9I58KP3yNGgiW0vlLBZlrAF7XC39MOki/1yinSpuIdKqW/wrcyJK+vN/kerCL5YLqb+sF0QwRulHj9bfb+UNxiTZT0Pq6VjS/+tbmkdcL3hgwOmjH0XW6uVMD+2cQTpV78tZkaeKoxVW8UOXu4oiOcFZK34eIsVIVLqg2Ir7RKh0YNEhrTOvu6/LI87QsydjI0VP35gLQ5nJdDDbQzdEMqvH0Paw5g/qN12I0vV//fjvup0vtcr6sYy2Da0pOaGqq97VX1axb1Bb7fSU+VDW7fK6PMpgf5DSaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CY4PR15MB1605.namprd15.prod.outlook.com (2603:10b6:903:137::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Thu, 21 Jul
 2022 18:44:35 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23%6]) with mapi id 15.20.5458.019; Thu, 21 Jul 2022
 18:44:35 +0000
Message-ID: <e636b480-8d53-a628-bacf-bac2b1506a47@fb.com>
Date:   Thu, 21 Jul 2022 11:44:33 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: Signedness of char in BTF
Content-Language: en-US
To:     "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        Lorenz Bauer <oss@lmb.io>
Cc:     andrii@kernel.org, bpf@vger.kernel.org
References: <3fcf2cb7-8d27-4649-b943-7c58e838664a@www.fastmail.com>
 <87wnc6bjny.fsf@oracle.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <87wnc6bjny.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BY5PR17CA0024.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::37) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1fbcef3-57f8-4564-e118-08da6b490ef5
X-MS-TrafficTypeDiagnostic: CY4PR15MB1605:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mu8XKh/YsoqwHPWcwDE0T8I6iKjihQs2MQguN1pwXjhXda9R7MPDqI+plEpV4pV6BiDvRYHuvJeH/U0l3YnacT5EdI9TXgVxXkyjs0geC2lcmnd0skow21CjbD5yP6dcumEwKNjKHRrwBAfgpnJ0M+ZD2xd5y65cAFmr82Lv0MF//OcZ+IOCXCFFE2nhJNp6kaeNXgxD3SAyItRqlvv5UgFDa3rlJJJhq6StzA3X4oAWIJl/8EwM63i57+7BnpQ5Vz02p+NZtQmydkfsVuocvYreIDvHg9eS//G0q3cS3fvSEaFNshfWmtIIfgwlDk3BSHhsMDUWJCzkmUmwy1ICdz8GaFTs05RAzpNnM9+VHKiuys4CwF/15TlnSWM14u2ttMcH0yJVvacO6lUQPzluAvI/xdSfm5f6AJGzgNzdEYESTVnVaHtKxbVuVZ+6OjU18GbyqYk4jkwF16WR/WT4usnThHqzxjLm3o1wwtYBxuZQ/Z/vJ5cwTR5/qOiihUEw4YadGliEQBiIo1INRccX+A0klkXMRtkSSAq1JPGHnehiiF4NK3+eODrcj7JLutTAzH2ez0a75QyS4tLK9hOkR2GdfGnq7fG3dALkXiXJoyrndaHF+0asegkVSMW1nU64pPCBR0OP4590m7Lx5GsrK0bFPlqwm+9Xl7vIAOULLHhX5Nz6p0TZ4VS4rC5XHHmHLXbVLGM9OPRbopsUOvBxDZ9bC3HJHENCq+IIgA+I2iC89ppnDRG5D4AdJoa4rOgktZe+dMIpnmyFupdSRTerTXm1tuHtqZEmyR/Fmcu5G/Crn89sKEzFPOkuhSELupiQHptby5uef1JQqvCZu6GfitWGhYNT2dhgksuBVt7qtS0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(186003)(8936002)(2906002)(478600001)(41300700001)(966005)(6512007)(6486002)(6506007)(53546011)(31696002)(2616005)(5660300002)(8676002)(4326008)(36756003)(86362001)(66946007)(38100700002)(66556008)(316002)(66476007)(31686004)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVZqWFpNRExCZ2ZKN1h5Um1FZDRtYWI0MkNNMlhrMjVYZGtXM0h6eEl0Z3Mv?=
 =?utf-8?B?SElXSUlZK1pHaHd4RWFVVzZxbzFMNGhPRlZHT2ZRcWRwZXh3dUdEMGNjWkV2?=
 =?utf-8?B?QW5nS1NhMkdTZlRUbDAybk81NzFlRVJLMXM4VS95dGVnbU9ST0pTeVVVSFhj?=
 =?utf-8?B?VGhjd2J2MUwyK2RoWUR1V3VWNUl0UEl5V3YxZFIweUlvblBtUDgxcWMyZlIv?=
 =?utf-8?B?bmFCazJrUzNyV1RmMUtESTlsNmZMcG8vSkZRWFVQMGxzOE5PUGdQeks1Rkpv?=
 =?utf-8?B?Y2xPeEluL083OUtHVnJySnR5bEk5UThLbEtDR241QnY5N2VWOUs3bklJUk9z?=
 =?utf-8?B?TFF3dUN4STdxd3k1a1Z6ZXAvVDNpejlWOVFtd3BGUWxXRnp2cWpraHFDaEd1?=
 =?utf-8?B?RFdIOFpBN0dpVGg4bTNVY0g4N01ScVk4eVExNG9OeHhWRlBnd3BmOU9vd1Vi?=
 =?utf-8?B?WnlheEM3MHlrL2pMT3J4ZUVTL1BvbHYvUmIzRWZzZFFmVUlWeitvbFVQaTd4?=
 =?utf-8?B?V2hLTTZ1Z21VcUZBVU5DSnkzV0hsLzhod0tncHMvWlZsQkRLaTdCejdqSHFm?=
 =?utf-8?B?L09kTEV6OGt4bmNWVC9qZk9VNVFibjg4QS9Ta2NkVlA0ZVNnRzAyL3g4aEZ2?=
 =?utf-8?B?UmJKRU1pOVFhNkY4ekkyMzNta3pORGlNNTkwTXF3VWVXNUUrcDdsTTBSSkpF?=
 =?utf-8?B?aCtlbnYxd1RwRUJNWi9NV25PRFFsR21hajJsM1JLMXBrVVhlTEFLRzRGTE5D?=
 =?utf-8?B?Q2UzdDBGd3YvMHArcFdhT3Vsb3hLRmU0ZWMrTTkwZlJtQVFBL0pUOCtxYlN3?=
 =?utf-8?B?Wm43VFJ1aTFCZzh2eDRPSUFmWmFIRXZrSXM3SGliRkdwV05lVWxjK3BSR055?=
 =?utf-8?B?TnZIQldlWGxacUExVTJUNUQ4OWtsZURFQWhpd3YrRS9Kcm1LeGQyM2lXamIv?=
 =?utf-8?B?R2crZDVweWtHL1lic3FxOCt5TGFPb1JQR1FXcFY2cjBIUFRTSC9yL0RkaHhq?=
 =?utf-8?B?QVVNbWovVDhyMjZHRWg4Z2hWWEs2aHplRXQrTXFhRjVabmsyTHYvaHlnUm5W?=
 =?utf-8?B?cDJLakVxckF4TU9WajBTY3hxOEJJVG5WT212K0F6N1pWa09KbCtaZkh3VUVR?=
 =?utf-8?B?Y1NpMGtWdGdtRXR4alNNcS93cXR0UzBDN1NRRTV1c0wvKzFVdU4zemxobDFU?=
 =?utf-8?B?aUdPUGE4RVdERnl1TXczQmJ4YklBUlRHMUhXZHRReVlSU1k3eDVmVDgzdzZs?=
 =?utf-8?B?OWh3ditmajZ0RjVlSUdvZDM3Z1FpaWxzdTliUjh0dFh1Q3VIbDdjSG9LTG1x?=
 =?utf-8?B?dDhvdmVQVzlWOUgvcEdaM0FsbkRsa2FOYUJUM1ZRVTR1a2hWcUJqRFpEZW11?=
 =?utf-8?B?UXhrNk52VjNvdjN4alJNMnhzOUo0V0JVTFE0SFk1VXlMcFk2UHMweW5OZDVQ?=
 =?utf-8?B?cUNzWW02OEZtVUVEM1Z6RGJTUFFtR3RDb2RNQXNrTkhodm8xeTJCS2RsNlFt?=
 =?utf-8?B?Z2VndnpMOFJqR3pLcWl2cnI1MUtwWVdaWmFYSjhRYXdzS0VVeVNwNTUwWTZi?=
 =?utf-8?B?b25ERUxkYUZaWDVhcjBlZzU3b3kxM20rQmhaaDJvTy9tcjJYVDlJL0p5d2Ez?=
 =?utf-8?B?MDEwVXJFNTBFdFpZRVlYWWUzSnhXR3JSOURIek41NllRaXZVb2ErL2tuUCtq?=
 =?utf-8?B?ekg0YWFNRDU0dW02emxCbGpxb3ZpTlJkKzQremhrb2IvYm9WeC9TSnlxcGV0?=
 =?utf-8?B?QlJYTmxOREVMWXB1VHE2M3dVck1jeUFmMGVpOUlzcmVZQzBEUi8xSCtYbzNX?=
 =?utf-8?B?djhvU0REb0RCcXJ0YjM2Wis5c2NkREY1M1RSbUtrVGZORW8zbi92TVZPQWFn?=
 =?utf-8?B?UHdiUTl0bElWanZ3Mm5JOHlJTlRpMDZMRFUxdm14aXgxdDNoZkNWTmhkNjl1?=
 =?utf-8?B?OHh4NVRtYVpwcEVMZVhTc1NkYkdDYnpiaFpZNHd2VmF3RDVIa3BHK1BadERK?=
 =?utf-8?B?dGdRTENveGJEWCttaU1wdjMrTWd5YnNnbnF6cDZVclpNb0l2aG1VZDk3VkJH?=
 =?utf-8?B?M0FpYXR3MmJQL2NoL0ZCS0owaHVsb0IyYVhrWVFZcll1SzljKzBjZjVRaEM0?=
 =?utf-8?B?SEZ5SExRWjBIM2M5VlhmenQ5Q2FsSXUrcXJPUWd0NzExYjFCMUpwRkk1U0o2?=
 =?utf-8?B?MHc9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1fbcef3-57f8-4564-e118-08da6b490ef5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 18:44:35.5376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M+1E8s6ic0qGJGvpwx6qw8xU/7S64Y5iU/C3gof+hnQMu3y2Ys7zkPWgJNesoWdn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1605
X-Proofpoint-GUID: peY8okhiJc8UyrbPmj1-O95FbDzWh12h
X-Proofpoint-ORIG-GUID: peY8okhiJc8UyrbPmj1-O95FbDzWh12h
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 2 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-21_26,2022-07-21_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/21/22 7:54 AM, Jose E. Marchesi wrote:
> 
>> Hi Yonghong and Andrii,
>>
>> I have some questions re: signedness of chars in BTF. According to [1]
>> BTF_INT_ENCODING() may be one of SIGNED, CHAR or BOOL.
> 
> I have always assumed that the bits in `encoding' are non-exclusive
> i.e. it is a bitmap, not an enumerated.

Based on current BTF design, it is enumerated. So signed char
is 'signed 1-byte int', unsigned char is 'unsigned 1-byte int'
and 'char' could be BTF_INT_CHAR but since in debuginfo
any 'char' has a signedness bit, so it is folded into
'signed 1-byte int' or 'unsigned 1-byte int'.

> 
>> If I read [2] correctly the signedness of char is implementation
>> defined. Does this mean that I need to know which implementation
>> generated the BTF to interpret CHAR correctly?
>>
>> Somewhat related, how to I make clang emit BTF_INT_CHAR in the first
>> place? I've tried with clang-14, but only ever get
>>
>>      [6] INT 'unsigned char' size=1 bits_offset=0 nr_bits=8 encoding=(none)
>>      [6] INT 'char' size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
> 
> Hm, in GCC we currently generate:
> 
> [1] int 'unsigned char'(0x00000001U#B) size=0x00000001U#B offset=0x00UB#b bits=0x08UB#b CHAR
> [2] int 'char'(0x00000001U#B) size=0x00000001U#B offset=0x00UB#b bits=0x08UB#b SIGNED CHAR
> 
> Which turns out is not correct?
> 
> We used a signed type for `char' because that was what the LLVM BPF
> toolchain uses, but then we assumed we had to emit the CHAR bit as
> well... wrong assumption apparently (I just tried with clang 15 and it
> doesn't set the CHAR bits for neither `char' nor `unsigned char').
> 
> But then what is the CHAR bit for?

This is not generated by llvm or pahole but apparently it may still
have some meaning when printing the value, a 'char c' may have
a dump like 'c' instead of '0x63'. In kernel/bpf/btf.c, we have

                 /*
                  * BTF_INT_CHAR encoding never seems to be set for
                  * char arrays, so if size is 1 and element is
                  * printable as a char, we'll do that.
                  */
                 if (elem_size == 1)
                         encoding = BTF_INT_CHAR;

> 
>> The kernel seems to agree that CHAR isn't a thing [3].
>>
>> Thanks!
>> Lorenz
>>
>> 1: https://www.kernel.org/doc/html/latest/bpf/btf.html#btf-kind-int
>> 2: https://stackoverflow.com/a/2054941/19544965
>> 3:
>> https://sourcegraph.com/github.com/torvalds/linux@353f7988dd8413c47718f7ca79c030b6fb62cfe5/-/blob/kernel/bpf/btf.c?L2928-2934
