Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872E8441F58
	for <lists+bpf@lfdr.de>; Mon,  1 Nov 2021 18:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbhKARei (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Nov 2021 13:34:38 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:15422 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232255AbhKARei (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 1 Nov 2021 13:34:38 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A1GodVO021415;
        Mon, 1 Nov 2021 10:31:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=mgjeOVttXjBvjvpTHQQD799bzpvHD5Qg19u8pNQkpfQ=;
 b=Uq+R7yMsYZE+eqe8LFW+p+aJ226OfeHrihCCnGoLS0nte1WxbYHaDttwgXMfWJdBnGPd
 gxXrDq8Ia63eJgcbppOH15KfxnPdeJyO6+Y45Izec95USL9BwNkbbKUAFwLulREU6Cn8
 8kesHP1PN/qhowvuHAPkTHdZcqWtYjyIU+M= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c2jjkh4gn-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 01 Nov 2021 10:31:48 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 1 Nov 2021 10:31:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YgTgcG7kw08f9d6/Vs4WAnr9DByJt8rJm4T9KQIcU7LFVk27Y3zQOXEUegsLbYNzvCSrk+LjFZNmcrxs6Z/vvBFvnKZgiVizTxfrHoneDX54MjIDNGR60PNe0hei2XVgEj1H6HFHuZ9vLx1LhGUm1JuXbrm/ygy+qEbVU0taW9UeViOqjX5e/NO6EeY8wfLcXuisEHu46I0yTB4IogfSIPkziONWn7jyAW9yLcTQbtLs+uAD7fl/3NMWFg+eMuWc5EUz2bU8Tmlws3SUnp06sA9m7VfG6OybALAsl8CAbEZ7z7JuZVPKhZvLGtvblSHho+MMIDygaIYZb+CPJnBFkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mgjeOVttXjBvjvpTHQQD799bzpvHD5Qg19u8pNQkpfQ=;
 b=AZJ7YRqo3bY4xkaEcZFfHdE04+OAQSjGkLtjc7tXI4+UKnipIIk9dC/zfC+q5t2kK2q8+HD2CFh3vabdosclbdaan2SgXbIIIvoHoKNePSvVtNRjK3Z/I1dhhZWzjxom7UX4O/IQ4X3aEDy21Os9Tsw9t28M7bPq0nGac1o3Y7sio3NSWxljYtGzehZgMAB0Is6Lnze4uyjw9ByWdcz56hjXAgCsVXU5TuTn6/rMd0elnbMmYTPaFCTj4fZozK8yYe/egk+7SFQ0b1j7aSh9fRalhB4Fjhz3EWKfkGAJEOQ3SLFQPkg8JwToLK6OBewcmEhKljxZ917zfp7h9UAmLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3982.namprd15.prod.outlook.com (2603:10b6:806:88::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Mon, 1 Nov
 2021 17:31:41 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4649.019; Mon, 1 Nov 2021
 17:31:41 +0000
Message-ID: <dccc55b4-9f45-4b1c-2166-184a8979bdc6@fb.com>
Date:   Mon, 1 Nov 2021 10:31:38 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH bpf-next] bpf: Allow bpf_d_path in perf_event_mmap
Content-Language: en-US
To:     Florent Revest <revest@chromium.org>,
        Hengqi Chen <hengqi.chen@gmail.com>
CC:     Martin KaFai Lau <kafai@fb.com>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kpsingh@kernel.org>, <jackmanb@google.com>,
        <linux-kernel@vger.kernel.org>
References: <20211028164357.1439102-1-revest@chromium.org>
 <20211028224653.qhuwkp75fridkzpw@kafai-mbp.dhcp.thefacebook.com>
 <CABRcYmLWAp6kYJBA2g+DvNQcg-5NaAz7u51ucBMPfW0dGykZAg@mail.gmail.com>
 <204584e8-7817-f445-1e73-b23552f54c2f@gmail.com>
 <CABRcYmJxp6-GSDRZfBQ-_7MbaJWTM_W4Ok=nSxLVEJ3+Sn7Fpw@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CABRcYmJxp6-GSDRZfBQ-_7MbaJWTM_W4Ok=nSxLVEJ3+Sn7Fpw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR20CA0039.namprd20.prod.outlook.com
 (2603:10b6:300:ed::25) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21c1::17cb] (2620:10d:c090:400::5:c93d) by MWHPR20CA0039.namprd20.prod.outlook.com (2603:10b6:300:ed::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Mon, 1 Nov 2021 17:31:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93da8e0b-10bf-47cb-70cf-08d99d5d7759
X-MS-TrafficTypeDiagnostic: SA0PR15MB3982:
X-Microsoft-Antispam-PRVS: <SA0PR15MB39825CC1928FA27330A36B95D38A9@SA0PR15MB3982.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TiW2ZkVMEFVoUy++znIrhd0p6OwZcT2JsbLwXMrSz41LTZYegmkeSO5bRvL0ihVSvJCY8iVVazoSbIQ6evFg/HpNi4GyBdryfX2jOqu+OnJZwfrcK7jseZcEbP/oJevKEw+INFxllLOMWhkezMDXwcbrNJzLSzd2ojKO9bpFEz5IrrNEH3JlUbuN+7kVWZMtAkJ3VmMJqOfHPVS46J53mBDU/1zYLWNBm9IH3eUuCLzBaTuW8nTyP7hmrneg18u65u1NxpiDSWsQVA1vuo4L9wf5fOpFhAcPVhDxBtPvSh8qP96Yi8fUG1tYvsz4428j3pnRniOqGYKr4/p3fzGI6zegwNPDinEbACulONVMy0U0EtsokJA9eXg8NPaCz8/2J4Rg+sZHOS9XEXMLZ0Im5EV96vuUeRp3A8yfQL9yjcOK2919Oiqi25pait+e/P2AFaMOq1eKtt8KDDp5xPkEMcWUGqbS0LLCOsSlGYP2yuCZ3Hz+LRfCoId0nUFpzojXh4Sc9xRF4vc0yKVO3gTxR+bdiQr6LFUBgPF2HrTOgAthGIEcqBBSZxtt+cy+WJCrlKJbs2vt+Ppu5JRtYhXLr9Kk3ZxvcU3DVJ21G9m5iKeZjoJXhHfPG4CDtlfmie1G2R4i3NewVMY+wwte0JULp70s4AAkg6QzIUMxrMLfJgOgHODIBrt6pTLK5M9l9CVE91pqDkpfEs1eJZU3Q+R1yCKK9PY1DQ2PmNyfamrgAK8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(5660300002)(52116002)(31686004)(186003)(36756003)(53546011)(2616005)(8936002)(66946007)(66556008)(66476007)(8676002)(31696002)(4326008)(316002)(38100700002)(86362001)(83380400001)(110136005)(508600001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlZHdTlYM29xOU8vSEdvd2NkeGFtbUkweEUwN1BhWkZObnhJZThsV2ZGSHVG?=
 =?utf-8?B?NUtaMzZsNzREM0wzSmdFdVpmZmU4R0pCT3Y1T1NoRlI5YThXWDdCTDkzYXBr?=
 =?utf-8?B?eE53YWxmQ3dPRDR4V1luWGFEZFR5N3k2YXBiUGhjUThEOVVqV1E3Qm9pL1Zq?=
 =?utf-8?B?NXJwRHRiT214czlDOHFIRHh5SEN0b1Z3V2d4Z051cUVKY09ZVkJpWk1hZGxp?=
 =?utf-8?B?dTVKRWdnWVJSQmJHeHFVVlFtU2RTeFdaUTlnYmNteEtHU2M5dUVMcVZQSGVS?=
 =?utf-8?B?NHE3dlZTdUw5ZEJNWUpGalgyTndmNHhLTGVGSGdJVHpvWTJVT2xkdE0vYnJ0?=
 =?utf-8?B?YlhSbHpUOFM5SHEyVlZwTXJkNEMxYW5kditzUGZBMDJoWUpMR054Rmw3bXdn?=
 =?utf-8?B?TVJaelBKN1o3RTVibkxFcUZSMGl4MU9pMEcvMHRkbS9QT1llQ1dwZDVScm1h?=
 =?utf-8?B?TDlIY1gzK3RDNFkwWTNmVUhTUEZBaEFWMmlxaHk1TUdCVEh5TmQ4UmxIclh6?=
 =?utf-8?B?Nk5ybkM5dTBJNU9UaUdjbFJka2JyRGlzUmdZTnllTDE2QS9McG5nd2xPZUN5?=
 =?utf-8?B?Ny9valJpdGg4SmFMQzUzYjY5V0E4RkMwc0xRZ2UvdVJ4WitlYXM5b3duUmM5?=
 =?utf-8?B?aUQ2RkR1YzdNVXFTTHhIWjBFaTdhZ05GUWFOSEorQ05uQnhET0xlbnMrbzBH?=
 =?utf-8?B?OU1ZSnpWVFpPUmRWUHJteU5ZdXdPcFlpdGdXVE5ZTGU1NUV5RXhiMU5YNFRz?=
 =?utf-8?B?KzQ0bDltQzg2dDRKdXhHS1RyNXhkem9HTlJHS3hxRFdvU1J1aFE1ZjNWcXlt?=
 =?utf-8?B?YnBWUnNzaDRRdU4rMU9JMGlVendReDd5c0lkbjZOWnhxV0haR1J5cVBwc2Zr?=
 =?utf-8?B?T3d5eVQralZEczZuZFV4Ri9yZmJtTnd3c0tITnNrTWtEUVcvM3lLNHFvancv?=
 =?utf-8?B?Z2J3OUJrZVQ0WmxXaDVIL0htNGNCcUdWK1lxNU1LNGtKSEQ0ZG9aSHlwYVJC?=
 =?utf-8?B?NFpwUUk2Y3FrVDlKMGdMMHA2QkR5SEJCV0hlamljR29YQ3FNWjNoSkVGVWVO?=
 =?utf-8?B?VHNDOUpORk1TYWNUdGNhWStoTW83SWVhQlhqclZldHhsalM5NVVxbDFQNzZ6?=
 =?utf-8?B?RnNrZllRRTNlUVdXTWhDVkFFRVRvZnZTZVJYUGZPamhHMzE0Zk5hZHFhY0NC?=
 =?utf-8?B?UzN4NlFpZXpIanBqZndNVUw3blN6UTkyR2dXWUhkSGpPOVRvWjVKQ1AwSnh5?=
 =?utf-8?B?TjVVMDVrMU91UUx1Z2NkOUdGY21DaUdrc3FvMkUzWEhWR0p3bXN6WUFiUElp?=
 =?utf-8?B?dThIWVJVVVVFRGh4ZEMyOVE0alFUaXZHNGhwdzhGNGNVb3hBSW5kWlZoNndW?=
 =?utf-8?B?YS93Qk5ockd4MlhrUDVRNUZXeEU4ZU9QY3ZuOTRrUGpoY1gxUjdUZVllVjRX?=
 =?utf-8?B?S1JodWhnTENxNWRrbmpIdU1xV05xdHZjRVdzZ3BUQXFrZkd4cFZzUWZ0WDFH?=
 =?utf-8?B?WVhaSFZMQkpSdVVyRGl2YlFrUEwvMkdJZXZiQUtjUWxYZnZ6VUhoNnRQcXJQ?=
 =?utf-8?B?bjZLUXlMVlBYYk85T3BlQ0plY3BPZ3drTzc3RWs3akdDZkFXM1Y2dm9jRTNP?=
 =?utf-8?B?d21nMXpLdThkS0FmR2xmdU9aVnlZd1UwMGNPdTcvYndOQ1Fyc25iUU9RQzE0?=
 =?utf-8?B?Q3F6WWp2VEJ2S24zVi9XSlFIOHpzYUx0NmJnbEtyQmF6Nk9YUVdDMXgrTThk?=
 =?utf-8?B?VHFWQ2xtYUF1a1A2aytDYlZYT2c0cTlJblNCZEQxcC9JaGw5dnVyK0hwODBL?=
 =?utf-8?B?RWpRaHRPYlBhejhJKzBxN2lnSE9wa0VIYXZzSFJRTFUxLzE2TVpPd0VSQi8r?=
 =?utf-8?B?NTg3dFI4U1lBNGVubHk0SnRmb3Bsd0lUWGhxdjlTaStVQ2d3ZFVMeXJTWDNh?=
 =?utf-8?B?YjcyelgxZjgrRG5mdk5VVGp2Z2pKMDE5M0tGL202Y3MySnZwVlEwcWN3V2tS?=
 =?utf-8?B?ZmdFTTU3QW5zYkg0U3QvSFhUWHpKYjY3MU0wZVdWcVBXQ3E0NWhadDdSaFZK?=
 =?utf-8?B?K3ZPOTh0TGxYZ3N5Sncya2pmWnQvUHp0bnBERzArdVRPbGF3UzQ5elBvOVI3?=
 =?utf-8?Q?F/9jDr0YoIwRoOaLA/7MumYKd?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 93da8e0b-10bf-47cb-70cf-08d99d5d7759
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2021 17:31:41.0654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LH/LPeCfr4OIQlhtNBICatD6wzFoidoLxqQp/mz8V5CCMnjx03ZEh+aIkASiSBA7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3982
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: o43A6PqkaWF50jFCjfYCNdSpnj94pj-u
X-Proofpoint-ORIG-GUID: o43A6PqkaWF50jFCjfYCNdSpnj94pj-u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-01_06,2021-11-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=728 impostorscore=0 clxscore=1011 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111010095
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/1/21 8:01 AM, Florent Revest wrote:
> On Mon, Nov 1, 2021 at 2:17 PM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>>
>> Hi,
>>
>>
>> On 2021/10/30 1:02 AM, Florent Revest wrote:
>>> On Fri, Oct 29, 2021 at 12:47 AM Martin KaFai Lau <kafai@fb.com> wrote:
>>>>
>>>> On Thu, Oct 28, 2021 at 06:43:57PM +0200, Florent Revest wrote:
>>>>> Allow the helper to be called from the perf_event_mmap hook. This is
>>>>> convenient to lookup vma->vm_file and implement a similar logic as
>>>>> perf_event_mmap_event in BPF.
>>>>  From struct vm_area_struct:
>>>>          struct file * vm_file;          /* File we map to (can be NULL). */
>>>>
>>>> Under perf_event_mmap, vm_file won't be NULL or bpf_d_path can handle it?
>>>
>>> Thanks Martin, this is a very good point. :) Yes, vm_file can be NULL
>>> in perf_event_mmap.
>>> I wonder what would happen (and what we could do about it? :|).
>>> bpf_d_path is called on &vma->vm_file->f_path So without NULL checks
>>> (of vm_file) in BPF, the helper wouldn't be called with a NULL pointer
>>> but rather with an address that is offsetof(struct file, f_path).
>>>
>>
>> I tested this patch with the following BCC script:
>>
>>      bpf_text = '''
>>      #include <linux/mm_types.h>
>>
>>      KFUNC_PROBE(perf_event_mmap, struct vm_area_struct *vma)
>>      {
>>          char path[256] = {};
>>
>>          bpf_d_path(&vma->vm_file->f_path, path, sizeof(path));
>>          bpf_trace_printk("perf_event_mmap %s", path);
>>          return 0;
>>      }
>>      '''
>>
>>      b = BPF(text=bpf_text)
>>      print("BPF program loaded")
>>      b.trace_print()
>>
>> This change causes kernel panic. I think it's because of this NULL pointer.
> 
> Thank you for the testing and repro Hengqi :)
> Indeed, I was able to reproduce this panic. When vma->vm_file is NULL,
> &vma->vm_file->f_path ends up being 0x18 so d_path causes a panic.
> I suppose that this sort of issue must be relatively common in helpers
> that take a PTR_TO_BTF_ID though ? I wonder if there is anything that

Most non-tracing ARG_PTR_TO_BTF_ID argument has strict helper/prog_type
protection and should be okay although I didn't check them 100%.

For some tracing helpers with ARG_PTR_TO_BTF_ID argument, we have
bpf_seq_printf/bpf_seq_write which has strict context as well and should 
not be NULL.

For helper bpf_task_pt_regs() which can attach to ANY kernel function, 
we kind of assume "task" is not NULL which should be the case in "almost 
all* cases from kernel internal data structure.

> the verifier could do about this ? For example if vma->vm_file could
> be PTR_TO_BTF_ID_OR_NULL and therefore vma->vm_file->f_path somehow
> considered invalid ?

Verifier has no way to know whether vma->vm_file is NULL or not during
verification time. So in your case, if we have to be conservative, that
means verifier will reject the program.

One possible way could be add a mode in verifier, we still *go through* 
the process for direct memory access but we require user explicit 
checking NULL pointers. This way, user will be forced to write code like

    FILE *vm_file = vma->vm_file; /* no checking is needed, vma from 
parameter which is not NULL */
    if (vm_file)
      bpf_d_path(&vm_file->f_path, path, sizeof(path));
