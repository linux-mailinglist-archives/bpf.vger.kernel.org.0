Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55778636993
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 20:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239823AbiKWTIN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 14:08:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239697AbiKWTHx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 14:07:53 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA9687A50
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 11:07:44 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 2ANHsHif030562;
        Wed, 23 Nov 2022 11:07:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=BasOAdm/7BvtyUugC+X/b3Ypc2tJZCNcc+R9I1oE5xI=;
 b=FSpLs8cm6EHM+pZOfz2jpcs0F9tO1uKK/oMPjtQB/UTFoUntlgDscytdATSYOdRJ8/su
 QqQemlvnb7CsHDPpFnpI8pdCjvlSxy0bi9iCTnEa+MIWztaIKU1myYWIfRSO+WWi3TJh
 HisUwcOhWkr0Dkijg1P+gfdrsIbzejYJhACSXoRmM2Qa/xXurE3eZr1C5OOimn2HkyiO
 YIDLrGwzYf+hinI2cjKcMkMCVphlgOFHmIRCbgQ/CnyufbA3zWC1P1VeXOdf92JZm0K7
 XCXOYrg2eDyoNCY2zUfAcaVpPdWpYuqXMrPHB00j/AgC/3CVMez+eAImmt/XbIEMKJ+P oA== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by m0089730.ppops.net (PPS) with ESMTPS id 3m1c7rd7kp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 11:07:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lPd/iZP/edpGhiX9yhPsKjn7YBDY9BUFUozInvqhBTpF/2RmhaqRK6O+qnBFTIA5dOD5xwTf7GS7vgccUChjopTIyfMHK2f9RrZrpinMqG64EZqfSlIfi46r+omlFL7BfLDHry5swee3KIEUhtW+hgDO+fu0mtQWd7lasOqUpc3eddrQUSlUi7+7LPN8q3+eAOKzO2HBRGdh790xDaJRWL55JQUD8IECjHoUcGlQ8J2sePe8w8NkPnwCYkmOZ1tilD/wNoE/60/w8YWMExhcYvU2xkLZKXEqlVUoYVScUPuyzhnXgT/649bDnGgli71/jazkp889yHfEIC5PyXRtRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BasOAdm/7BvtyUugC+X/b3Ypc2tJZCNcc+R9I1oE5xI=;
 b=cPcY5JP8ZuGF4S5K1eFmhKflyKlnIgsB4N52dwNXNHZuIwPjotNTB7x5R0kd4+9UPF/8ilNDRX9RNxEeCr5Bgy0stFOkk8glONfXC1z5Oua+dt9RlNW/+s830/OP/9DlulDtV/tao7okCS9qUy7+qiIyhxrIUTHPqLcqQVf6HWVpozPVdhsYCLojpOOweUJwiGBm32GHGnosrW2IONYvNnFMgkXBq/UPR1WClBarFDVdTKAhjASOcwe9rtlT6UW7j6aEpMWbgvxEGxO673zr1leplc7evL4MK7neXYoKmKsZjkWiX07KYDra6cOvzoH6Mb+cUbLdZcixE7dSQ2zWfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW2PR1501MB2170.namprd15.prod.outlook.com (2603:10b6:302:e::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Wed, 23 Nov
 2022 19:07:23 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ac66:fb37:a598:8519]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ac66:fb37:a598:8519%7]) with mapi id 15.20.5834.011; Wed, 23 Nov 2022
 19:07:23 +0000
Message-ID: <63b85917-a2ea-8e35-620c-808560910819@meta.com>
Date:   Wed, 23 Nov 2022 11:07:18 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Make sure zero-len skbs
 aren't redirectable
Content-Language: en-US
To:     sdf@google.com
Cc:     Jiri Olsa <olsajiri@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com
References: <20221121180340.1983627-1-sdf@google.com>
 <20221121180340.1983627-2-sdf@google.com> <Y34QpET78/KX9JLh@krava>
 <34cb2b2f-ac3b-65c4-c479-0c4ed3dda096@meta.com> <Y35VrXvKBFg2RJ7y@google.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <Y35VrXvKBFg2RJ7y@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR17CA0004.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::17) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MW2PR1501MB2170:EE_
X-MS-Office365-Filtering-Correlation-Id: 95e89d14-7c90-4175-b4dd-08dacd85f3cf
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uW9x8g68Qf3Whos4Quq1V5ANfC1h2ObLKBl5Rhkkx4WZgNEPntSUpDDM6YiR9udGD1AExYNhH65wNT5WTL7mrHNQx7Wp0t2R6pvUKQ5MGuz4Da7Tv5dyrYxzXfPAolAHiJtvaCx3maZsV5g8ymECuyHKuljwNW2GK7HFfMbK8yaaPk3Gsi5vRYxmXPxVNzi0CqKDNQAuT1KO5bX3ubbXE8BfVVL79Paz27Dj3J4RqC4ghlXTXqaFTGBvYmZzj5sWjKV1FNNgledwUMtaFA+rIoO8S51ztxVXOR72lZBMu4TCd9HDXJmea/RsAoTfin0DXgswYe4VbfPXJQZU9I7zgMzCGJmskn29h0/65qzjs4VODpcclL5/svokHWECwfQik9A8IAB8HmtcP3a+LoGml7t953OAdJLsXLsfBSkqJKHbqgkcNUzqL8W9A6W5irGmkmseps1XYpmBEZV7IGw6YStfgUgV4OZp5SMCazB2WCsmn+dIf9DX2L8/DeZeo4JiqQ6zGPbTF0gnuD1XtpoDUKIRhPRTajuwsvoE5US8voXthWb9wvxqZt+NFc0BL+/uOpNLuHnIbmMPH14jK2/FMIp4OdtKwyP7FqK+uTirq5yCCInIiTyru5PvV2TAJ63awAY2t2mVdq+sCa00vjMbR2bT0r9oPmbqB3Qh4LxStXsNrxZIkl3lcLjRqFYYDPHhgEeFlDWezjy4yBgoKUgfGr7RuTV4zz2RfREfl+yRb+Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(451199015)(2906002)(31686004)(36756003)(38100700002)(41300700001)(83380400001)(66476007)(31696002)(6512007)(86362001)(8676002)(66556008)(66946007)(4326008)(6486002)(186003)(6916009)(5660300002)(6506007)(7416002)(8936002)(316002)(2616005)(6666004)(478600001)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVFVdGdZVnJwckRxNnRCSDJ2ckdwaHJxY3M2Z0hUTVArT1plOTQvaFBEanlh?=
 =?utf-8?B?dnJhdkRxcUI5WjBUdGdKZ3p5bmRpWEJHR1N0V1V5dSs2Z0ZSOUVnTWs5cEZU?=
 =?utf-8?B?OEVrcDN2UlUramRmaVZZNjBSQzRWL2NEelhQNEZDeUorRXdDTm9CSzJUL1dh?=
 =?utf-8?B?S0EvTjBLelMyMnJwaWdvZmhoREwwS201eVhXRkFEYnJkR0dXd3RqM0lOemRi?=
 =?utf-8?B?YWpjUzdobDc1aHFuMHQ0QS9pemNNbHhJRzNoUUxjUUR4Ly9EY2xVcmNFVkVU?=
 =?utf-8?B?U05lSmx3cE5MajhERDVZUG4xQ29oQjFsMlJ3NFM2c2hLbnZMNlNLZEVvVlNB?=
 =?utf-8?B?Wm5LaEEyZXZDWHpiVWtaUjh0UEhkUG5uaUtua0IyY3ZOS0d6Mnk5WHFCYk5w?=
 =?utf-8?B?SCtkMTVuN1dmbFpxQWsxSVUyeHM5WUhKTFFwTnhjUUk2Qm1ySGI1cmI3Ti9x?=
 =?utf-8?B?U1VhejVOelhpNmlsQWRGRDdqL1BWTnhBU1l0bjlxSk5GOU5naDZieHBHd3RF?=
 =?utf-8?B?eWQrbzFPQTkydllvMzBXZ2VlQUR0YVg1MnJwQUwxaWVzT2Jwa01qeDJpRG8y?=
 =?utf-8?B?VzE3UmI3cEoyblpRMk5vdnBlTldFUTFLbGNtT2FSVFJUc1ArSVVJMFNIZ0xx?=
 =?utf-8?B?Um9QSkg5QU5XSUlDcEZBS0JKeWQ5U3crSC9uNWQ4NWcvbFRwNE5qdzBtS2Q4?=
 =?utf-8?B?N2JsWVMxendkSWlaTjA2Y0RqYjhnbEVycWEyRTZZblZmVFQ5dGluVTQyNkhs?=
 =?utf-8?B?eFVEQ01leUR6R2lVNUt4VFMzM3RNaFVlOUQrR1hxdU0vUjBYWUpoc21BR3M3?=
 =?utf-8?B?ZnA0dGc5aUl3eDBJa1pqZ0k3SnNXMTJsbVFndmxVRnpJTDJGd0JnVDZvaHRQ?=
 =?utf-8?B?bjNxZGtqYTRJNm5aak40elJkekc2SmZ2VWJMWXM2R2wvT2JhY3dSV1hBRXZ2?=
 =?utf-8?B?VTFMVmFjZzQ1RFZvRlkrV3JwRy9RRnNRK28rU3ZkVVZUMnZsSFNGKytzZzEy?=
 =?utf-8?B?SURvaWhPNjVINmRzSGRBdlh2VHB5aXpjQzV4b1p5Rm44dUhrbm9Dc2pvZ29E?=
 =?utf-8?B?MkxrUnJOTTI2cFk1cHZ0WGU5UnZWVDczWmVCVVh1Mkp4ZVFtTHZyTmxxRU4z?=
 =?utf-8?B?S1gwTzE0eVl0ZnNlcWZYYkszZnVwUERPTHhROC9QbDdEMTRTZEtvTnM5VGVN?=
 =?utf-8?B?cnA4ck9ub3Q5MHQrak9rTThqOC9rK3IxWkV3OU9jbllFVmFLWlU0TW1NNXZ1?=
 =?utf-8?B?aDNLbzducmRLZS9NVi84NVZoTDdQVlNzUjdSS3RDWjVac0Q2ZUF1QkxiUU52?=
 =?utf-8?B?ankweThhaDVZaENhdS81SkVkam9CNUNYZzQwMENndmpySEdralpoUm1XVnJD?=
 =?utf-8?B?emVoSElaUFI1OFZVbGphbW1SUUtvSzdDdkFPMHFFVUF2QitCOWt3YndZcU9F?=
 =?utf-8?B?aVR5d0IzZGR3aCtteWR3VDNCTHRqMFpmNGwrWjdHYTFYWHN4VnBZSFNsN0ha?=
 =?utf-8?B?OElyM290NGk1dm1kZjNzR1F6RE5pbW5mdXkwbm5ha1M1ckVWS2Z0VUhMMWp0?=
 =?utf-8?B?cjkxQUlDNFpOU0lxbm5rdXZjWVNlc3kvckM1NVJWYTVFbk1OUHgrN1I5a0Vu?=
 =?utf-8?B?S21YS0haTXpSKzVZNldpVmhRV0ZoYzVqZllIbHRxcDJTMEtWR0NtMHFqZVVo?=
 =?utf-8?B?aktDUUUwbE1teEJtSWNEdVdtR1llaVUrZGcwOFh1QTFXR09sUVp4YmV5eHc0?=
 =?utf-8?B?NXFaMTUyR2gxMnZZU3ZtbnV2Wnc0QkZ3Wnczd3ZtOGFrQ011TEd3N1NmT2Nv?=
 =?utf-8?B?dWN1TFcrUE1RMThrL1ZNRm1jclJGS3hIR2ZEOW9MamNId2hVOWdpWjMyUDNT?=
 =?utf-8?B?OUdONFN0dXBlYkFFcmliZFlCWmtUMUI1dktzSGtKT1V5cnpsQm80anhNaTJQ?=
 =?utf-8?B?M3JzV2tBL004SWhuQjRTclJrZis0UHhza1pHY3pTWjVKK0JSSXkwMytJNjll?=
 =?utf-8?B?UVpCdzBTVE1ubVZJcDlOTjhzdStFYkVrMXBMOTlQelJGcG82K2RtUDU2R2lj?=
 =?utf-8?B?V2VYQlVxdURvR1BNTCtBMzQrWkF3TGVicitLWWtYNWJ6ODd5NW1JVzFaRVFH?=
 =?utf-8?B?Q1JJVjJ0anJTeU0zOWRQNzZFajE1UkdiRnBRaG5uWldqU2hNd2ljOFdwN04x?=
 =?utf-8?B?K2c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e89d14-7c90-4175-b4dd-08dacd85f3cf
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 19:07:23.2572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M/2dR85zdp/vXAzqAEHHNjKPpSxoBNRZDoWJm96vEt29pzD7uN37PHOxo2VLGhHV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR1501MB2170
X-Proofpoint-GUID: pqFozWyPAqBNfUBp6J3p8c6BIfCJYM-6
X-Proofpoint-ORIG-GUID: pqFozWyPAqBNfUBp6J3p8c6BIfCJYM-6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-23_11,2022-11-23_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/23/22 9:17 AM, sdf@google.com wrote:
> On 11/23, Yonghong Song wrote:
> 
> 
>> On 11/23/22 4:23 AM, Jiri Olsa wrote:
>> > On Mon, Nov 21, 2022 at 10:03:40AM -0800, Stanislav Fomichev wrote:
>> > > LWT_XMIT to test L3 case, TC to test L2 case.
>> > >
>> > > v2:
>> > > - s/veth_ifindex/ipip_ifindex/ in two places (Martin)
>> > > - add comment about which condition triggers the rejection (Martin)
>> > >
>> > > Signed-off-by: Stanislav Fomichev <sdf@google.com>
>> >
>> > hi,
>> > I'm getting selftest fails and it looks like it's because of this test:
>> >
>> >     [root@qemu bpf]# ./test_progs -n 62,98
>> >     #62      empty_skb:OK
>> >     execute_one_variant:PASS:skel_open 0 nsec
>> >     execute_one_variant:PASS:my_pid_map_update 0 nsec
>> >     libbpf: failed to determine tracepoint 'raw_syscalls/sys_enter' 
>> perf event ID: No such file or directory
>> >     libbpf: prog 'handle_legacy': failed to create tracepoint 
>> 'raw_syscalls/sys_enter' perf event: No such file or directory
>> >     libbpf: prog 'handle_legacy': failed to auto-attach: -2
>> >     execute_one_variant:FAIL:skel_attach unexpected error: -2 (errno 2)
>> >     test_legacy_printk:FAIL:legacy_case unexpected error: -2 (errno 2)
>> >     execute_one_variant:PASS:skel_open 0 nsec
>> >     libbpf: failed to determine tracepoint 'raw_syscalls/sys_enter' 
>> perf event ID: No such file or directory
>> >     libbpf: prog 'handle_modern': failed to create tracepoint 
>> 'raw_syscalls/sys_enter' perf event: No such file or directory
>> >     libbpf: prog 'handle_modern': failed to auto-attach: -2
>> >     execute_one_variant:FAIL:skel_attach unexpected error: -2 (errno 2)
>> >     #98      legacy_printk:FAIL
>> >
>> >     All error logs:
>> >     execute_one_variant:PASS:skel_open 0 nsec
>> >     execute_one_variant:PASS:my_pid_map_update 0 nsec
>> >     libbpf: failed to determine tracepoint 'raw_syscalls/sys_enter' 
>> perf event ID: No such file or directory
>> >     libbpf: prog 'handle_legacy': failed to create tracepoint 
>> 'raw_syscalls/sys_enter' perf event: No such file or directory
>> >     libbpf: prog 'handle_legacy': failed to auto-attach: -2
>> >     execute_one_variant:FAIL:skel_attach unexpected error: -2 (errno 2)
>> >     test_legacy_printk:FAIL:legacy_case unexpected error: -2 (errno 2)
>> >     execute_one_variant:PASS:skel_open 0 nsec
>> >     libbpf: failed to determine tracepoint 'raw_syscalls/sys_enter' 
>> perf event ID: No such file or directory
>> >     libbpf: prog 'handle_modern': failed to create tracepoint 
>> 'raw_syscalls/sys_enter' perf event: No such file or directory
>> >     libbpf: prog 'handle_modern': failed to auto-attach: -2
>> >     execute_one_variant:FAIL:skel_attach unexpected error: -2 (errno 2)
>> >     #98      legacy_printk:FAIL
>> >     Summary: 1/0 PASSED, 0 SKIPPED, 1 FAILED
>> >
>> > when I run separately it passes:
>> >
>> >     [root@qemu bpf]# ./test_progs -n 98
>> >     #98      legacy_printk:OK
>> >     Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
>> >
>> >
>> > it seems that the open_netns/close_netns does not work properly,
>> > and screw up access to tracefs for following tests
>> >
>> > if I comment out all the umounts in setns_by_fd, it does not fail
> 
>> Agreed with the above observations.
>> With the current bpf-next, I can easily hit the above perf event ID 
>> issue.
> 
>> But if I backout the following two patches:
>> 68f8e3d4b916531ea3bb8b83e35138cf78f2fce5 selftests/bpf: Make sure 
>> zero-len
>> skbs aren't redirectable
>> 114039b342014680911c35bd6b72624180fd669a bpf: Move skb->len == 0 
>> checks into
>> __bpf_redirect
> 
> 
>> and run a few times with './test_progs -j' and I didn't hit any issues.
> 
> My guess would be that we need to remount debugfs in setns_by_fd?
> 
> diff --git a/tools/testing/selftests/bpf/network_helpers.c 
> b/tools/testing/selftests/bpf/network_helpers.c
> index bec15558fd93..1f37adff7632 100644
> --- a/tools/testing/selftests/bpf/network_helpers.c
> +++ b/tools/testing/selftests/bpf/network_helpers.c
> @@ -426,6 +426,10 @@ static int setns_by_fd(int nsfd)
>       if (!ASSERT_OK(err, "mount /sys/fs/bpf"))
>           return err;
> 
> +    err = mount("debugfs", "/sys/kernel/debug", "debugfs", 0, NULL);
> +    if (!ASSERT_OK(err, "mount /sys/kernel/debug"))
> +        return err;
> +
>       return 0;
>   }

Ya, this does fix the problem. Could you craft a patch for this?
