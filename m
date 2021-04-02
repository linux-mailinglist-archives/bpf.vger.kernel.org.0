Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D831D353161
	for <lists+bpf@lfdr.de>; Sat,  3 Apr 2021 01:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbhDBXAV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Apr 2021 19:00:21 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42048 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231406AbhDBXAV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 2 Apr 2021 19:00:21 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 132Mxqng021295;
        Fri, 2 Apr 2021 16:00:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : references
 : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=csU+Zfik0na/K2+Qyr1x8ji9CHip1a2i24Wwuko53e4=;
 b=k2pTruGH9fmmnuZIz6sEuiEOPtLrY/OLfZCDnVgMbwuvBDZQGErCzK8v5GT0JFI6ZLY8
 6nUbXA09dm+zWT6fh0+uuzVemgahiQMVcPklIy38nM+TtCnT9DlBQ5kvNEzBgqrGHTtg
 GhoOHRwDePF7ZOuahYPYTzG5s/qcbeaE8h8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37nsn9dj75-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 02 Apr 2021 16:00:05 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 2 Apr 2021 16:00:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3bP+7VsLZXgcppr0DJrlAm6NS5b75uYZ1Thv2Naxc4zQOhyOwnp/DFyniiOLP12TqbRO5frVkEtHKj1g99z+l9aNQ6JsldzQMuQeuLlZ9fZRWKlSO2XlKPLrLKk+BlQP5SE06TFPS3rhDZ932/31k7b1dCvbha2y+oNePdEhDcXreKaKS1LV24KKMnDDjLrXKiBdd5f+HCffL+JNRebmYw47m/flpWPrQk+pI4L2+ZoeuM0Fma2vwZ4G/jUtig3N/GFj8dza7GBYeujyYHdOKjrNNbNPkuD55N7hY9QQU9zI3BMRNER70LDBMJrYDNjJuct8+kOg5tf77+oRZInGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csU+Zfik0na/K2+Qyr1x8ji9CHip1a2i24Wwuko53e4=;
 b=AvnHdsHpRn89zGdBFlkwV6AG1KmTI0pMzk1hFackForl+AHudeRzRIYAjESM9Lrjgq/UFUqAu2u5KBIYKnF6m3Nc67lE4xnKYzPe4UKT0aW6EXxp8+TDFXM7pq63BS8+RRcF+fcFeqjbP5Sbb/SwvxhVxfKjgxNguZc2N8RUWybIILJurpxnjmbgtK4DFRamMXbhYZDRQ/Gu+ovx3NV88e6ymTjd0qRlKD0jVpW0EIyBMZA37Cd6lHkG3rQEc4GIzzNDRTadcwAihxrC8JpbXJDclFUwNudJElYQSPARxh1FNdGt9MZGAwRciVDGvnhH1Z1wIXdmcWp6tSFL00Cbcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2336.namprd15.prod.outlook.com (2603:10b6:805:26::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Fri, 2 Apr
 2021 23:00:02 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3999.027; Fri, 2 Apr 2021
 23:00:02 +0000
Subject: Re: libbpf: failed to find BTF ID for ksym
To:     Felix Maurer <felix@felix-maurer.de>, <bpf@vger.kernel.org>
References: <45cb2bbc-202b-00d6-7422-738a025be068@felix-maurer.de>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <fac7938c-a591-1ecd-9943-8b4726b69e01@fb.com>
Date:   Fri, 2 Apr 2021 15:59:58 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
In-Reply-To: <45cb2bbc-202b-00d6-7422-738a025be068@felix-maurer.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:4a82]
X-ClientProxiedBy: MWHPR1201CA0003.namprd12.prod.outlook.com
 (2603:10b6:301:4a::13) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::1466] (2620:10d:c090:400::5:4a82) by MWHPR1201CA0003.namprd12.prod.outlook.com (2603:10b6:301:4a::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26 via Frontend Transport; Fri, 2 Apr 2021 23:00:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bed1c0fb-f753-423e-4eca-08d8f62b0c24
X-MS-TrafficTypeDiagnostic: SN6PR15MB2336:
X-Microsoft-Antispam-PRVS: <SN6PR15MB2336CD697656AAB507CEFEC7D37A9@SN6PR15MB2336.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s6Vm4VjqkDo2BY0P16LJKTlxKtZedp5xfLTVZUo/RqPFSqPOsksTogKMvnBicC3ojzIyGsvxAw/UTcRBoTZnR94kEgygA4x9jsNOr1c0JRB2JJOnb2QQ5PBvyIMBpiTycohRHG/iZI0jhe0W5ujc/e6HbTC32+F64oUfdfwJSW0UO/p7bQu7Afnqf+XHPkFLZRHuxBBzDErvSJfqAyeNYeqCw7hRhSV5Edy1iX9YLfJsdKfrUQw4y8GK14b6tHX2KWYvamKVOC2+iSrg/Ez41yGhP7BRgswC4FlU5x+oQAztTWAKM9/D4d0I0n9nlga/B62A6rxv81M+8Z/4nVZ7eNrVdW9YSormfPRDqPnU9RUPllSUK6JJBKQmSPQDEY97p15qDu3ZyJZvlh8+7Lua5N1XUDI2q04A1LYGMue2QHVt2hqJ6fP/1/193p7TIn0fsniZ1zYTIXVad2sPTmWIRh1McrX/jlNL8MTrmxdhIDfhw66LZnIvohGW6p9JkrP38vEkcWvbRfhZ6JW+ZBAXWPqTw1OqNMaBS2HJJ8RgKsCxhrZVRl54Mae5+APh+mJiQvYvh0iKcUBdqi+SN7nsZWoN4tBjXtds2IOenLraqOpyQ86iWcy5U8wcg94EX6TbN36fRD7wMLnxp1bQTy382R0DUjNn/6SvbZ5ZTJVCduZJxEua97iI59gwuNAEbTlSkkDd1xBBEvOYukuus0cq+2U4WKUh6hWp+bz7KNVhJFOtSHvwN7Jk+6a4NBeHRoHl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(376002)(346002)(396003)(39860400002)(66556008)(66476007)(2906002)(6666004)(5660300002)(52116002)(8936002)(2616005)(31696002)(186003)(478600001)(316002)(31686004)(53546011)(36756003)(86362001)(8676002)(16526019)(6486002)(66946007)(38100700001)(37363001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NjNKMEI2Z2FnNld1Q3RnaTJTVG1ObTRFODMyaWxGQ1M4UC9UUmNHVWR5VDNw?=
 =?utf-8?B?MmtTbERUVkcwVEJPN1hBUU5rM2FKNGlWWVQwTXdDQ0dTNWhLZFhvVFMvWms2?=
 =?utf-8?B?YXNpYmRyQURoSnpNb243c2I4cDVxVkFLWDFIM2xlU1JhU3gzVHVnSlhxMXFq?=
 =?utf-8?B?enNyZmxGaEUzT1BOZmdNMnBFa0grc1dPVkxtY0xCV1hNb0JuNE0xQ0JHWnNT?=
 =?utf-8?B?ZWRIZVg1WG1vMU8rY2hOSHN0dGdVdWo3elcvYzJZUXpQdVJtajhtNzNjRFJU?=
 =?utf-8?B?aHFRbWtGSDJLWVhVVWliVjlIZ2xyR1VGTVA1YUZJTnUwS3lLTXlxY2hBbDdZ?=
 =?utf-8?B?Q2xtQ0tBbVNpSmNUZWNxNTJ3d09BbEVsTkdMTEdZQVlXcFgxaC9yckREUnNs?=
 =?utf-8?B?NFhqU2Noc0N1dkpvRngvVGZKRU9PbTY4Z2JOTXRFb1BVTGtxRDZpeGhmK25v?=
 =?utf-8?B?cEMvOEFVL0trb3lPM1FocEFJN0NCa3Zsakw3amJod3ZlOWUyckFSeEx4UTY3?=
 =?utf-8?B?NkV1R1hwdzVaTHpEcHhyOXF5bE1jMHN3WGxJOS9yLzJZSmhHbjRJRWVlOEVi?=
 =?utf-8?B?cWcvMFBZeHc2MncxczQveHA5ZzNRTGNoUjY2SVNUeHF0RG1OcitxNWlYRjMx?=
 =?utf-8?B?Y1R6Z2IrbkpSTE5GcjhXWEZsNU1mYmI5akkvZldsblRIbTk5V2x1MUluWDZl?=
 =?utf-8?B?UlNUSWJyV1NVWC9hVFBFRXRwSjZYWG9qNS83NFd6SXlYUkxRS2tSbWJYME1C?=
 =?utf-8?B?b21ZZ3lUaHIvTHNWWEozMmo1cm45N2tQZDVlRGhERGNIdk1MMGdzOERNREtP?=
 =?utf-8?B?dXl4SFhjVmN5YVJ4NXJTcndZdUdyd0M3UUNEbEplZjM4SXY0anNCUDBDRlc1?=
 =?utf-8?B?UmkxQzNxRkF2ejRJdlRocTZuWUJ1VVFSWE5IUU43M2FzUzhBU0VVVVBsUUt4?=
 =?utf-8?B?dStuTUhxdXVnZk5HSmU1MTVrWTFBeURPbkwxS25rb2Z5YXdUdDBzYmZOSDlK?=
 =?utf-8?B?RGphTVdKdE54WHZPallrekhhOGx5Z3lzeFRKdjcrOURid1NPS2hXQlRja3Z2?=
 =?utf-8?B?Mk0zRFJwNkhzOXo5dFN3aHpybGNWVWxRZWxuekR5MXBPRlJNazhReThrMjQz?=
 =?utf-8?B?MHBRdG85U1dwaVRvbDVJelQyc1FqRmFjV0J2cUZvNmE5QVE5dVRkWWRNSUhX?=
 =?utf-8?B?amVucGJEYzhuekYyK0loeFJMODlJODZPL3VJOXZiOEx0c1hNNFNYS0Z0eGZU?=
 =?utf-8?B?ZldwUjhrRklnT1BOQkZzbldxSUVLTllKWVF1dG02NkUyNUdmTnVMZjlxcURB?=
 =?utf-8?B?RHdpcVVLRjl6SlRYdkZHYlJwNXVDMkZHQXZGbUR0cytHZ3NxSjJoWk42Snkx?=
 =?utf-8?B?Q3NaamhZRmhwcGNaNFFueWNUcGpFL3ZieDF3ODNjd2VMU2k3N0lPK3l5ZDJH?=
 =?utf-8?B?cHRER2VoVm01MnNaZllNdSszWlUvR2M2NU9NYUtOWkF0YkFMczFNS09XMG5l?=
 =?utf-8?B?blloS0o4VERxcWFhVWRuN0tlMnJYK3NKaWpVVFZaWUNlc1lLMU5HU283RUJi?=
 =?utf-8?B?L0FuSDFBN0JLTzFVbWhnK08yVXlhTTNEMjhoN29xbWRvdUMzSWpjeGF3eXB0?=
 =?utf-8?B?V1puamN2WEVOOElmWUErU3lEMEw1YVUzRVF2Yk8vYmg5Qm1uWGcyWVNPdW1J?=
 =?utf-8?B?YkFXYTluUzQzUGxCRE1yUzVuZWNsM3JobEFxemZWQTBNQUw1NXlNeFBDZUdP?=
 =?utf-8?B?b3lMVzAvSVA0TWVGTWlIbE5QSUNaTUVIcDVBVDFlQS9zL3I4MzhOVFZzY2Vq?=
 =?utf-8?B?YjA3Z1YwMjI4MkJWYmFoUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bed1c0fb-f753-423e-4eca-08d8f62b0c24
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 23:00:02.2057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0v8+GlqsXIFupE6c8YcC2fe0Cm/oK6tc94THblCr3Yc4GZQrzAv5oT5mP4HHiCdp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2336
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: alntfps4O_ZmT7ApPx64VvIde2fZNcEe
X-Proofpoint-GUID: alntfps4O_ZmT7ApPx64VvIde2fZNcEe
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-02_15:2021-04-01,2021-04-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 clxscore=1011 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104020154
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/2/21 3:44 PM, Felix Maurer wrote:
> Hello,
> 
> I am working on a tracing tool for which I need know the address of some 
> kernel data structures. The tool should be CO-RE and I am using libbpf 
> (through the libbpf-rs Rust bindings, but this is not the issue I 
> assume). However, I am having trouble to use ksyms with libbpf.
> 
> To get the address of the data structure (in my case 
> skbuff_fclone_cache), I use an extern ksym declaration in my BPF code 
> like this:
> 
> extern struct kmem_cache *skbuff_fclone_cache __ksym;
> 
> This compiles just fine, opening the compiled bytecode with libbpf also 
> works. From the debug log[1], it can be seen that the extern is 
> identified. However, loading the object fails with the following error:
> 
> libbpf: loading kernel BTF '/sys/kernel/btf/vmlinux': 0
> libbpf: extern (ksym) 'skbuff_fclone_cache': failed to find BTF ID in 
> kernel BTF(s).
> libbpf: failed to load object 'skbuffTime_bpf'
> libbpf: failed to load BPF skeleton 'skbuffTime_bpf': -22

net/core/skbuff.c:static struct kmem_cache *skbuff_fclone_cache 
__ro_after_init;

skbuff_fclone_cache is a static variable. I think pahole does not
emit static variables into btf, only global variables.

> 
> I found, that libbpf has a check if it needs to load the BTF information 
> or /proc/kallsyms. In my case, it loads the BTF information and cannot 
> find the ksym in there. Searching in the BTF from the running kernel 
> (bpftool btf dump file /sys/kernel/btf/vmlinux format raw | grep 
> "skbuff_fclone_cache") indeed gives no results. However, it can be found 
> in kallsyms (cat /proc/kallsyms | grep "skbuff_fclone_cache" gives one 
> result). Therefore, a resolution of the ksym with kallsyms will probably 
> work but is not even attempted.
> 
> Now, I am not really sure where the root cause of the issue can be 
> found. Should the ksym be present in the BTF information (i.e., the 
> issue comes from building the kernel) or is the BPF object file broken 
> (i.e., an issue with clang) or is the identification of the ksym wrong 
> (i.e., the issue is in the libbpf loading code). Or something completely 
> different? Does anyone have a hint on what goes wrong here?
> 
> Some version information:
> I am running Ubuntu 20.04, the kernel version is 5.8.0-45-generic (from 
> HWE). The kernel has been build on the system to enable BTF; otherwise, 
> the configuration is identical to the Ubuntu upstream. It has been 
> compiled with gcc 9.3.0 and pahole v1.17. I am compiling the BPF code 
> with clang 10.0.0 and tested with different libbpf versions from the 
> GitHub mirror (0.2, 0.3, and 99bc17633).
> 
> Thank you already for taking a look at my issue!
> 
> Best regards,
> Felix Maurer
> 
> 
> 
> [1]: Full libbpf opening debug log:
> libbpf: loading object 'skbuffTime_bpf' from buffer
> libbpf: elf: section(3) fexit/kmem_cache_alloc, size 176, link 0, flags 
> 6, type=1
> libbpf: sec 'fexit/kmem_cache_alloc': found program 'kmem_cache_alloc' 
> at insn offset 0 (0 bytes), code size 22 insns (176 bytes)
> libbpf: elf: section(4) .relfexit/kmem_cache_alloc, size 32, link 26, 
> flags 0, type=9
> libbpf: elf: section(5) fexit/kmem_cache_alloc_node, size 176, link 0, 
> flags 6, type=1
> libbpf: sec 'fexit/kmem_cache_alloc_node': found program 
> 'kmem_cache_alloc_node' at insn offset 0 (0 bytes), code size 22 insns 
> (176 bytes)
> libbpf: elf: section(6) .relfexit/kmem_cache_alloc_node, size 32, link 
> 26, flags 0, type=9
> libbpf: elf: section(7) license, size 4, link 0, flags 3, type=1
> libbpf: license of skbuffTime_bpf is GPL
> libbpf: elf: section(8) .maps, size 24, link 0, flags 3, type=1
> libbpf: elf: section(17) .BTF, size 4419, link 0, flags 0, type=1
> libbpf: elf: section(19) .BTF.ext, size 440, link 0, flags 0, type=1
> libbpf: elf: section(26) .symtab, size 263040, link 1, flags 0, type=2
> libbpf: looking for externs among 10960 symbols...
> libbpf: collected 1 externs total
> libbpf: extern (ksym) #0: symbol 10959, name skbuff_fclone_cache
> libbpf: map 'events': at sec_idx 8, offset 0.
> libbpf: map 'events': found type = 4.
> libbpf: map 'events': found key_size = 4.
> libbpf: map 'events': found value_size = 4.
> libbpf: sec '.relfexit/kmem_cache_alloc': collecting relocation for 
> section(3) 'fexit/kmem_cache_alloc'
> libbpf: sec '.relfexit/kmem_cache_alloc': relo #0: insn #2 against 
> 'skbuff_fclone_cache'
> libbpf: prog 'kmem_cache_alloc': found extern #0 'skbuff_fclone_cache' 
> (sym 10959) for insn #2
> libbpf: sec '.relfexit/kmem_cache_alloc': relo #1: insn #14 against 
> 'events'
> libbpf: prog 'kmem_cache_alloc': found map 0 (events, sec 8, off 0) for 
> insn #14
> libbpf: sec '.relfexit/kmem_cache_alloc_node': collecting relocation for 
> section(5) 'fexit/kmem_cache_alloc_node'
> libbpf: sec '.relfexit/kmem_cache_alloc_node': relo #0: insn #2 against 
> 'skbuff_fclone_cache'
> libbpf: prog 'kmem_cache_alloc_node': found extern #0 
> 'skbuff_fclone_cache' (sym 10959) for insn #2
> libbpf: sec '.relfexit/kmem_cache_alloc_node': relo #1: insn #14 against 
> 'events'
> libbpf: prog 'kmem_cache_alloc_node': found map 0 (events, sec 8, off 0) 
> for insn #14
