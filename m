Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 803933670C8
	for <lists+bpf@lfdr.de>; Wed, 21 Apr 2021 19:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244513AbhDURAg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Apr 2021 13:00:36 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:29002 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236712AbhDURAf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 21 Apr 2021 13:00:35 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13LGtd83002802;
        Wed, 21 Apr 2021 09:59:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : from : to : cc
 : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=p07Mpd5qcFqcGwSKtchzxOEoP/VeUFJcc4bRkUwlW9Q=;
 b=Z5eDFSgm5Wwp28BIsjkEWyk4GGo3C/+msVIAKLoBJw3UlEOAkkGwB+IWrzJX2XMiYA2V
 vBo1JfGn03wokwIcTHCNxLCx/RmsvNIjEvZQN85HdLD2tsMwKyO3wACyytsS4+KbEUML
 0LDV+5WWGIHWXCGM+aZNRLsL+geitv4mYmI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 382726n1xh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 21 Apr 2021 09:59:46 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 21 Apr 2021 09:59:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FW+f/RMIXdxjiceGthrU8zD6jkrpTxgQ90NMNfSujkGvWSLRE3r5L4svnZXWmqbAkJjwBjqFEeZvLvRZ6qzn9mozP0tMcnbZj59UkRZYBEzMvq+fUUFMZg4tpox8SrwZ8WYA140ShZs5ZFA9JXPOzv67TURGDf9nJrf3WtgZ5+OPnJ23JQdRJC2tMoctuR+nNodXQLZsw4oisVx20x5T+iAFQ28KjRXhfyweXbEdOiZHaJPkDu031/jzblbVY6cW+RHVqMxbi77sm8AJ721o0uJlzLqiETBzrfaG5976S/SHOCjGOuYnuTMLb2kqaka6VTH+g402s4S2A2HwIvUBwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGfnQE5nGKFnQqmfIpCyM8QdHskrNrMDmxocSLkV37g=;
 b=czF1FHReeTLJYHUVpjdnR7dAr8S51S/pwuI03arBuJ7DDzPwWi/PYQmYBfNOaTnEfnUk+yoQU/NSsbot4pf/S7H68cjSdgPtxvN2iQoJwdlnhxEVYDHN8Q1eSnFBHYfTqJfxQw2CmsRAFmRqPl4nJEv3HEI4oGF7vT5NqVRJuZGh8pA6WBI0ndeFQY39JvF9uqaGj/rdsqTrR4nR+eejIIRzaYkALG8gFJ3sRUT1rWcE+3RZdABGguioe6l5S+nscCq4/2ejqwwQQPkSQbcCsbVY9cq4dPmG271YrmbC9C618VHV1JhBODOL7nejXTd6y8V4f2AHV2PquQOroX/XsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN7PR15MB4223.namprd15.prod.outlook.com (2603:10b6:806:107::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Wed, 21 Apr
 2021 16:59:44 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.4065.021; Wed, 21 Apr 2021
 16:59:44 +0000
Subject: Re: Help with verifier failure
From:   Yonghong Song <yhs@fb.com>
To:     Brendan Jackman <jackmanb@google.com>, <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20210421122348.547922-1-jackmanb@google.com>
 <94c4f7b0-c64e-e580-7d9b-a0a65e2fe33d@fb.com>
Message-ID: <3933ce3c-6161-2309-88bb-72707997ed76@fb.com>
Date:   Wed, 21 Apr 2021 09:59:40 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
In-Reply-To: <94c4f7b0-c64e-e580-7d9b-a0a65e2fe33d@fb.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:ff0e]
X-ClientProxiedBy: CO2PR18CA0055.namprd18.prod.outlook.com
 (2603:10b6:104:2::23) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e8::138b] (2620:10d:c090:400::5:ff0e) by CO2PR18CA0055.namprd18.prod.outlook.com (2603:10b6:104:2::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend Transport; Wed, 21 Apr 2021 16:59:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d842be6c-0765-46ca-ae59-08d904e6dceb
X-MS-TrafficTypeDiagnostic: SN7PR15MB4223:
X-Microsoft-Antispam-PRVS: <SN7PR15MB42238F791D82684F24C4C8B3D3479@SN7PR15MB4223.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KlW8Z2F+l5o/Svp4hbVyXW8tIJUQI6h4ytravX7Zdfuz3TuPBE/wVXBY9hiL1qLr034i/+Y9IwB9g1PnCmzlmM8Sn5Wns7m2Dia1Yrs7b1SY9FCHaOSM3UREUBGtFb9ZGqGnDlc9O1dtFRhvIxetHo7lVXSJcBPL6ApabtfpMpfqKlg9f9vtoKEU+fGe6DU3KUJG4S1+p+Rhv53Q11HqWou/c+ktqqiaWobobASfVcPFfC2lAPIkY1CjfE3lGgMSK7cZix4KMhrVQQ7bhNL2bTVhuFt3YTILfLxZhsx5GWND6bac9gadyMiIkEAwUHz3Hg7+He0WVmrEIFQSsWdpoj5xdWimmCtaFsq5HvKuAAbZ80rmwleOf3+JyX4RsneCLlK98uuQoMryPkk4wmxDTT6knMGJc58mI01xnEIBR7tizkps4iWEECx5l6l032XSisVkgmEX7MDRKHOARDUOcZNpryFNgWT4Arh5nHC+NoFrZrO4KPnG66z/MaI/f6B59cuQEvXdj7vRTx165GanppI2VKkMVZVfuTHuPNKcUKsDXgdQpKHgA0lovgZ/Jd/t4cYb4AqkMLbu8xXS2U78wEMRKvKHU+XiCZisa0YfFbfTyz9jzrNyaeKhHP4MEDwaO+0xdioAQjeucZHD9lpU785qN0kW4B0rhSFybaYusdWb9Ccoa+iEEz+9dtE40sjVcoumREgUzCEinL+6+B45dnzCkZQ0nVXdfdfi42+NndsYW1Lf882UXeuL+2Z4LDqDKyEfvlzrJg1nLcdtvq+BLffPFyUuzhISrl946A01134=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(346002)(396003)(39860400002)(136003)(3480700007)(16526019)(186003)(38100700002)(5660300002)(36756003)(8936002)(2906002)(66556008)(66476007)(2616005)(8676002)(66946007)(86362001)(52116002)(53546011)(316002)(4326008)(6486002)(478600001)(966005)(31696002)(83380400001)(31686004)(43740500002)(45980500001)(505234006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OE9XWVFMZ0pNVzZJR0t4SUhuZEFJTjdZYlBoQVJjOElxRGhwaktpQjJsZ2hZ?=
 =?utf-8?B?MDdXSk5mOUQ4R3NuMm5zamY2enBHQVdlMCt0VngxM3VzRXJraXBJZGh1Witv?=
 =?utf-8?B?M3lCYk5lWXZ1ZlhZRDIrUy9LSWJwT2RmOTdVSmRvd29nRy9KaTNFVEd5dUdK?=
 =?utf-8?B?OGRIVEhpMXhxS1FaZ3JxRHRrVFVHRm0wRmhFbUNCWVVkOFM5QWNEMHY3VGJ2?=
 =?utf-8?B?cG0wZHphVzJhUEdnQ0VnUUU0ejFjMy9GNkxZb3B1MnRHaE1CeXVLbFgvZ3J4?=
 =?utf-8?B?R1ZUZm9rSU9wRFR6RUJYY3d2ZExPYXRrbnFLOHBGL1EwbDRuNS9TbTQxWXZq?=
 =?utf-8?B?RCtCaE4yNDkwczZYOEVpRUJZWHdrbU1PMVh6Z0xiVGdmZ1ZsVHE4YTdQREFZ?=
 =?utf-8?B?Q0w4Um9Sa25YcFFYRXlsTDlSd0lpVU85akdDcU12MnlIbFE4WlhHL2FWNW9v?=
 =?utf-8?B?RTZsekEwYkd2Q1ZxOStUNXRzTGhmZWlOcUdQR3pxaG9tK3B0cGl6NERKYlhD?=
 =?utf-8?B?LzBYdUtITmtsK3E3N1ppU0JHTk51cWw3eWhMTEw3VmlZNUMrNkNrSEFpd1Vv?=
 =?utf-8?B?Ky93YVQ2eTcvangvM01laThyQ1gxZ3ZMbXFPK1FzcVJOL1U4YnpWQjV4akxI?=
 =?utf-8?B?Z0RnL21nQUc1eTc1eElVQTVodG5FbnFlV2wzeEJ6L2FncW9BTEFTQVZWcmtY?=
 =?utf-8?B?dDZDNVZCdVJtb1RUUi9tbTFoSWdVd0YrMUlnNDQzT0N1ZnV5UlpVRTlCN3Zw?=
 =?utf-8?B?a3YycDBMVU9kOXVLWFo1NVNMa3ZVSFNwQ280Vjd5aDV1MitQTEp6M00yWlBx?=
 =?utf-8?B?Q0FHdTdBV0NUczZVUkozd2VqN2pSMGJna1pEa1QwNXNBa1VOVUgwTXRIVXp2?=
 =?utf-8?B?N0lUS2kxWUtMWnBhUXh3NUp0UTNzenUxdW9uMEFKa1dtL1BOV201dVorRjlX?=
 =?utf-8?B?Z0orZ0kzSythbzl6U3MwNzNPeHFLcldZWnhuVnpwczRsdkJQZmJMZVY3UzZI?=
 =?utf-8?B?U1kraTRPSkdnVzAvVm02RUFTYUNnV0xjdFdmN2F6cGtTb3R2a1JzVUhGUEJC?=
 =?utf-8?B?ODh3U2Rac0l0YjJOOEk4cTJmR0kyMXhYRUJ0UzFOOGE4RVNBY2pVRXF6TFQv?=
 =?utf-8?B?NHRpUUJZRmlpZDY3TUhYcVJBRGFGOC94enlIVlZPWUdTMFBZZGovbktlNXVv?=
 =?utf-8?B?blprTXhWbFh1RUd6czNndW9RMkIrdkMvZGpzK1ZaWlQzRTZ6MXQ5Unc3R242?=
 =?utf-8?B?ZG05WjkzZ0xhWEVuaWQwWFJSVUZoWS9yWmJyL0hWZTM3WlNzSnZTdWpUckt6?=
 =?utf-8?B?cDMwbGtKV2JUUVFpa0NlZG9RWDd0eWZ6YXRNUmg1OVhYQXNXdnRpNERxZ3cx?=
 =?utf-8?B?MnY0Zk5ydGpUZC9tQUZSZDZiOFhLKzFRNkJTMEUyc1hnZjlwY2Z4VllYbDdt?=
 =?utf-8?B?TzJMUVVKbEx0akNOc0hJdGl0OE5ubURtcng0SndqUHpsNFl2bXl6VEd2a1NO?=
 =?utf-8?B?djNDdkRKQWJ0YUZCVFRUOG5EVzZHZ3V6OWRqaDJwb0NweTRXa0IvWEJxZ1NT?=
 =?utf-8?B?OHNLalJhMTJxNkcwbm04WnJiVWF2QmZlUHVYWGZGdG9XenZwZkhKS0lUMFcv?=
 =?utf-8?B?VVM5ZFNHUmt0VkJTSlN0cDRSMHlpYkd4aTRUOE1mTkd6RmZGQ2cwS3F6dVZt?=
 =?utf-8?B?WUVzWmtwcGJUVHJSU1JWRzZPR1FpekpSR0docEpGQ0xnR01LTVhXZGRaT0ll?=
 =?utf-8?B?SFlvSjRpM3k0eGFPMUZjLzJ5MllZKzZwN2xOWUhVcmgrWFF1S1VFTTFJNDJ1?=
 =?utf-8?Q?4t7cbdZQE8cmMCKS+S8NQkSdahuvdWU4vmPw0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d842be6c-0765-46ca-ae59-08d904e6dceb
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 16:59:44.6437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: llAoj+9HlEuoI9FSBUkb4/FTcpxHVV4iwSneSTPE4nH0s4zTbjCYFuuVvxg42DP4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB4223
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: V0wYxJwVWL5uCudfX9jCPbi1DDnJQZIQ
X-Proofpoint-GUID: V0wYxJwVWL5uCudfX9jCPbi1DDnJQZIQ
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-21_05:2021-04-21,2021-04-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 mlxscore=0 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104210121
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/21/21 8:06 AM, Yonghong Song wrote:
> 
> 
> On 4/21/21 5:23 AM, Brendan Jackman wrote:
>> Hi,
>>
>> Recently when our internal Clang build was updated to 0e92cbd6a652 we 
>> started
>> hitting a verifier issue that I can't see an easy fix for. I've 
>> narrowed it down
>> to a minimal reproducer - this email is a patch to add that repro as a 
>> prog
>> test (./test_progs -t example).
>>
>> Here's the BPF code I get from the attached source:
>>
>> 0000000000000000 <exec>:
>> ; int BPF_PROG(exec, struct linux_binprm *bprm) {
>>         0:       79 11 00 00 00 00 00 00 r1 = *(u64 *)(r1 + 0)
>>         1:       7b 1a e8 ff 00 00 00 00 *(u64 *)(r10 - 24) = r1
>> ;   uint64_t args_size = bprm->argc & 0xFFFFFFF;
>>         2:       61 17 58 00 00 00 00 00 r7 = *(u32 *)(r1 + 88)
>>         3:       b4 01 00 00 00 00 00 00 w1 = 0
>> ;   int map_key = 0;
>>         4:       63 1a fc ff 00 00 00 00 *(u32 *)(r10 - 4) = r1
>>         5:       bf a2 00 00 00 00 00 00 r2 = r10
>>         6:       07 02 00 00 fc ff ff ff r2 += -4
>> ;   void *buf = bpf_map_lookup_elem(&buf_map, &map_key);
>>         7:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0ll
>>         9:       85 00 00 00 01 00 00 00 call 1
>>        10:       7b 0a f0 ff 00 00 00 00 *(u64 *)(r10 - 16) = r0
>>        11:       57 07 00 00 ff ff ff 0f r7 &= 268435455
>>        12:       bf 76 00 00 00 00 00 00 r6 = r7
>> ;   if (!buf)
>>        13:       16 07 12 00 00 00 00 00 if w7 == 0 goto +18 <LBB0_7>
>>        14:       79 a1 f0 ff 00 00 00 00 r1 = *(u64 *)(r10 - 16)
>>        15:       15 01 10 00 00 00 00 00 if r1 == 0 goto +16 <LBB0_7>
>>        16:       b4 09 00 00 00 00 00 00 w9 = 0
>>        17:       b7 01 00 00 00 10 00 00 r1 = 4096
>>        18:       bf 68 00 00 00 00 00 00 r8 = r6
>>        19:       05 00 0e 00 00 00 00 00 goto +14 <LBB0_3>
>>
>> 00000000000000a0 <LBB0_5>:
>> ;     void *src = (void *)(char *)bprm->p + offset;
>>        20:       79 a1 e8 ff 00 00 00 00 r1 = *(u64 *)(r10 - 24)
>>        21:       79 13 18 00 00 00 00 00 r3 = *(u64 *)(r1 + 24)
>> ;     uint64_t read_size = args_size - offset;
>>        22:       0f 73 00 00 00 00 00 00 r3 += r7
>>        23:       07 03 00 00 00 f0 ff ff r3 += -4096
>> ;     (void) bpf_probe_read_user(buf, read_size, src);
>>        24:       79 a1 f0 ff 00 00 00 00 r1 = *(u64 *)(r10 - 16)
>>        25:       85 00 00 00 70 00 00 00 call 112
>> ;   for (int i = 0; i < 512 && offset < args_size; i++) {
>>        26:       26 09 05 00 fe 01 00 00 if w9 > 510 goto +5 <LBB0_7>
>>        27:       07 08 00 00 00 f0 ff ff r8 += -4096
>>        28:       bf 71 00 00 00 00 00 00 r1 = r7
>>        29:       07 01 00 00 00 10 00 00 r1 += 4096
>>        30:       04 09 00 00 01 00 00 00 w9 += 1
>> ;   for (int i = 0; i < 512 && offset < args_size; i++) {
>>        31:       ad 67 02 00 00 00 00 00 if r7 < r6 goto +2 <LBB0_3>
>>
>> 0000000000000100 <LBB0_7>:
>> ; int BPF_PROG(exec, struct linux_binprm *bprm) {
>>        32:       b4 00 00 00 00 00 00 00 w0 = 0
>>        33:       95 00 00 00 00 00 00 00 exit
>>
>> 0000000000000110 <LBB0_3>:
>>        34:       bf 17 00 00 00 00 00 00 r7 = r1
>> ;     (void) bpf_probe_read_user(buf, read_size, src);
>>        35:       bc 82 00 00 00 00 00 00 w2 = w8
>>        36:       a5 08 ef ff 00 10 00 00 if r8 < 4096 goto -17 <LBB0_5>
>>        37:       b4 02 00 00 00 10 00 00 w2 = 4096
>>        38:       05 00 ed ff 00 00 00 00 goto -19 <LBB0_5>
>>
>>
>> The full log I get is at
>> https://gist.githubusercontent.com/bjackman/2928c4ff4cc89545f3993bddd9d5edb2/raw/feda6d7c165d24be3ea72c3cf7045c50246abd83/gistfile1.txt  
>> ,
>> but basically the verifier runs through the loop a large number of 
>> times,going
>> down the true path of the `if (read_size > CHUNK_LEN)` every time. Then
>> eventually it takes the false path.
>>
>> In the disassembly this is basically instructions 35-37 - pseudocode:
>>    w2 = w8
>>    if (r8 < 4096) {
>>      w2 = 4096
>>    }
>>
>> w2 can't exceed 4096 but the verifier doesn't seem to "backpropagate" 
>> those
>> bounds from r8 (note the umax_value for R8 goes to 4095 after the 
>> branch from 36
>> to 20, but R2's umax_value is still 266342399)
>>
>> from 31 to 34: R0_w=inv(id=0) R1_w=inv2097152 
>> R6=inv(id=2,umin_value=2093057,umax_value=268435455,var_off=(0x0; 
>> 0xfffffff)) R7_w=inv2093056 
>> R8_w=inv(id=0,umax_value=266342399,var_off=(0x0; 0xfffffff)) 
>> R9_w=invP511 R10=fp0 fp-8=mmmm???? fp-16=map_value fp-24=ptr_
>> ; int BPF_PROG(exec, struct linux_binprm *bprm) {
>> 34: (bf) r7 = r1
>> ; (void) bpf_probe_read_user(buf, read_size, src);
>> 35: (bc) w2 = w8
>> 36: (a5) if r8 < 0x1000 goto pc-17
>>
>> from 36 to 20: R0_w=inv(id=0) R1_w=inv2097152 
>> R2_w=inv(id=0,umax_value=266342399,var_off=(0x0; 0xfffffff)) 
>> R6=inv(id=2,umin_value=2093057,umax_value=268435455,var_off=(0x0; 
>> 0xfffffff)) R7_w=inv2097152 
>> R8_w=inv(id=0,umax_value=4095,var_off=(0x0; 0xfff)) R9_w=invP511 
>> R10=fp0 fp-8=mmmm???? fp-16=map_value fp-24=ptr_
>> ; void *src = (void *)(char *)bprm->p + offset;
>> 20: (79) r1 = *(u64 *)(r10 -24)
>> 21: (79) r3 = *(u64 *)(r1 +24)
>> ; uint64_t read_size = args_size - offset;
>> 22: (0f) r3 += r7
>> 23: (07) r3 += -4096
>> ; (void) bpf_probe_read_user(buf, read_size, src);
>> 24: (79) r1 = *(u64 *)(r10 -16)
>> 25: (85) call bpf_probe_read_user#112
>>   R0_w=inv(id=0) R1_w=map_value(id=0,off=0,ks=4,vs=4096,imm=0) 
>> R2_w=inv(id=0,umax_value=266342399,var_off=(0x0; 0xfffffff)) 
>> R3_w=inv(id=0) 
>> R6=inv(id=2,umin_value=2093057,umax_value=268435455,var_off=(0x0; 
>> 0xfffffff)) R7_w=inv2097152 
>> R8_w=inv(id=0,umax_value=4095,var_off=(0x0; 0xfff)) R9_w=invP511 
>> R10=fp0 fp-8=mmmm????fp-16=map_value fp-24=ptr_
>>   R0_w=inv(id=0) R1_w=map_value(id=0,off=0,ks=4,vs=4096,imm=0) 
>> R2_w=inv(id=0,umax_value=266342399,var_off=(0x0; 0xfffffff)) 
>> R3_w=inv(id=0) 
>> R6=inv(id=2,umin_value=2093057,umax_value=268435455,var_off=(0x0; 
>> 0xfffffff)) R7_w=inv2097152 
>> R8_w=inv(id=0,umax_value=4095,var_off=(0x0; 0xfff)) R9_w=invP511 
>> R10=fp0 fp-8=mmmm????fp-16=map_value fp-24=ptr_
>> invalid access to map value, value_size=4096 off=0 size=266342399
>> R1 min value is outside of the allowed memory range
>> processed 9239 insns (limit 1000000) max_states_per_insn 4 
>> total_states 133 peak_states 133 mark_read 2
> 
> Thanks, Brendan. Looks at least the verifier failure is triggered
> by recent clang changes. I will take a look whether we could
> improve verifier for such a case and whether we could improve
> clang to avoid generate such codes the verifier doesn't like.
> Will get back to you once I had concrete analysis.
> 
>>
>> This seems like it must be a common pitfall, any idea what we can do 
>> to fix it
>> and avoid it in future? Am I misunderstanding the issue?

First, for the example code you provided, I checked with llvm11, llvm12 
and latest trunk llvm (llvm13-dev) and they all generated similar codes,
which may trigger verifier failure. Somehow you original code could be
different may only show up with a recent llvm, I guess.

Checking llvm IR, the divergence between "w2 = w8" and "if r8 < 0x1000"
appears in insn scheduling phase related handling PHIs. Need to further
check whether it is possible to prevent the compiler from generating
such codes.

The latest kernel already had the ability to track register equivalence.
However, the tracking is conservative for 32bit mov like "w2 = w8" as 
you described in the above. if we have code like "r2 = r8; if r8 < 
0x1000 ...", we will be all good.

The following hack fixed the issue,

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 58730872f7e5..54f418fd6a4a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7728,12 +7728,20 @@ static int check_alu_op(struct bpf_verifier_env 
*env, struct bpf_insn *insn)
                                                 insn->src_reg);
                                         return -EACCES;
                                 } else if (src_reg->type == SCALAR_VALUE) {
+                                       /* If src_reg is in 32bit range, 
there is
+                                        * no need to reset the ID.
+                                        */
+                                       bool is_32bit_src = 
src_reg->umax_value <= 0x7fffffff;
+
+                                       if (is_32bit_src && !src_reg->id)
+                                               src_reg->id = ++env->id_gen;
                                         *dst_reg = *src_reg;
                                         /* Make sure ID is cleared 
otherwise
                                          * dst_reg min/max could be 
incorrectly
                                          * propagated into src_reg by 
find_equal_scalars()
                                          */
-                                       dst_reg->id = 0;
+                                       if (!is_32bit_src)
+                                               dst_reg->id = 0;
                                         dst_reg->live |= REG_LIVE_WRITTEN;
                                         dst_reg->subreg_def = 
env->insn_idx + 1;
                                 } else {

Basically, for a 32bit mov insn like "w2 = w8", if we can ensure
that "w8" is 32bit and has no possibility that upper 32bit is set
for r8, we can declare them equivalent. This fixed your issue.

Will try to submit a formal patch later.

>>
>> Cheers,
>> Brendan
>>
> [...]
