Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1488532C215
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 01:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239966AbhCCWzH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Mar 2021 17:55:07 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:7820 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1388003AbhCCUVD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 3 Mar 2021 15:21:03 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 123KIGwW024765;
        Wed, 3 Mar 2021 12:20:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : from : to : cc
 : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=970IVmEj07swrBzJ+LY54vlHPnCqXtXcKQHwPfeBNyA=;
 b=mWbnWhjbd71dgFKNnOQ+ZDNX9Ktxi59AzK+n10RBEZmPjE/XIARxMvf4AZ0EBP3/KqxM
 qVU1V6/5KxGF4Jf1+HIFAWjMAoX3H3/GpE8sr5HchJMaKvMaSa5aTOnaEERvCM1FgLKq
 aSu9qUg82FlGQqm48EmMFTQ7AbxeMgo/0W8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 371vkaecry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 03 Mar 2021 12:20:07 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 3 Mar 2021 12:20:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PAIsbSJGl5DsRe1uC/pMkC4Z1HBDli35Im0HmcK//Y8j3EtO1UlpakEcghhEdy3fjae+AzYfLqRZ1G5hweruMsaBeG24TmQdeeX7PWDgoiLnRzMDANRV70HBnGADa1fqX11QZXzPCxRl+heVb3JMxOXSP1VAhn7evEJWvKKTHO9WiPVdOlKlP4vt9gz2Qk2Ei2gRUCkVovsXIbANrxIxlfXr2KWnRznhS+rJKUsLKreBdlNTdu5heGLY7jhp+3Q6qSJyTRz8LhI4T5L2G1H8HB2l5owEoY72Nf1isv7KK1aTow296OJmVOPrTi5sH6cggRU/CcRi7/5lZGR1eJYIdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=970IVmEj07swrBzJ+LY54vlHPnCqXtXcKQHwPfeBNyA=;
 b=KEaoKiYYySiUiVDVTpMu6bjznPYiddj2kNPjTXvvNIr1SoQ/R+VABQyYHtEj70b8berpIUefs+4Z7AzAdkCuJbO0VP2myQDRWz1WlkfAdMa9d80uXL0+XjSTEtGJbDeXb6QOQ1NPD4BGZItF8SC1LHm0RkDpKlsxY3OI3HhYsuMwI4qM6RPy9YiYs6NMNU2gW5qUjkPjHtOwd87lj0VCGmNajofGxWy3rdgayPZvJZdKmlVgg80ctOKXRU/L25VkoFipwDyD5e4hcX4K0rnOHHp6gkGdUy4fVLNNF7zRXh4yQIBycM+rBV9F1fQAm9sBtnRjbWHQwYG/o5SKWFj75w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4740.namprd15.prod.outlook.com (2603:10b6:806:19f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 3 Mar
 2021 20:20:05 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3890.030; Wed, 3 Mar 2021
 20:20:05 +0000
Subject: Re: [PATCHv2 bpf-next 01/15] bpf: Import syscall arg documentation
From:   Yonghong Song <yhs@fb.com>
To:     Joe Stringer <joe@cilium.io>, <bpf@vger.kernel.org>
CC:     <daniel@iogearbox.net>, <ast@kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-man@vger.kernel.org>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
References: <20210302171947.2268128-1-joe@cilium.io>
 <20210302171947.2268128-2-joe@cilium.io>
 <f55e1371-bc0f-ba4b-3801-d0ad064cb490@fb.com>
Message-ID: <9909f5ad-f532-646d-6282-73a2578dbc34@fb.com>
Date:   Wed, 3 Mar 2021 12:20:00 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
In-Reply-To: <f55e1371-bc0f-ba4b-3801-d0ad064cb490@fb.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2620:10d:c090:400::5:94d2]
X-ClientProxiedBy: MWHPR12CA0025.namprd12.prod.outlook.com
 (2603:10b6:301:2::11) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::1a32] (2620:10d:c090:400::5:94d2) by MWHPR12CA0025.namprd12.prod.outlook.com (2603:10b6:301:2::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20 via Frontend Transport; Wed, 3 Mar 2021 20:20:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a65edb8-4222-44fd-b721-08d8de81bb59
X-MS-TrafficTypeDiagnostic: SA1PR15MB4740:
X-Microsoft-Antispam-PRVS: <SA1PR15MB4740E5BB91F8ED33F4712123D3989@SA1PR15MB4740.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MwXU27J8gYrSd7+AjXGO8N8PogSb+RhYlo5pQAXmXQxIlknCKTGVJBFQO3ZGnBcRJuds6dZ+Cw7NTVVsrGJPLvjMEELfRiCghy8kaD3N+HSLmGHzgpIG58UPCH9v97rZkDQwxkWLdSbpSRKMk9mp0aWI6dhG0n+Q4nNdIT9FwvUl4L6OFHODBFsiFh7Z4glMbXCr3KHEKGGjr9qBK2c/Xwhnuf+YyfY6w69HhovsBuk60OZ7dhyexoUN0k7hJgbmn/0e0oF6D504VvI3nqZ9oY4x7+/qPOK+bazaWfO5cXv+idsVgtWX7+Q520wfEoILNLRN5BPcn/TzkKyz/KRSY6+RWn8QDIJzI+m777y2RZiGHogMK1QMHg5kIgunrrYWkt+kVQhaLwgM4aCPcDWqXYZ7W+A5dk1cs+EJ8BUzEPDb+QK5h4/DJZxfnp/V/GTXJU7OhzixvDFOi9fLloH0iRsxL/CR6byjrXSwA4rN40ZUXn6lUNxI7KDR8I2MCLzJlzscBKp48RPYRnu7tYw98dwbU2uwmGjve2bbNYxT5YrNW4CNDKEkxUW8gv+gfTbFoWbY6PirsQXDXFvhda1Fu3DbUtK4yjf1uE+4HhhnfaU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(39860400002)(346002)(366004)(83380400001)(186003)(6486002)(478600001)(16526019)(5660300002)(54906003)(66946007)(2906002)(316002)(36756003)(52116002)(53546011)(66574015)(86362001)(4326008)(66556008)(66476007)(31696002)(8676002)(8936002)(31686004)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NzlPODFEOFJBTGNaMUw1T3p2NnpUY3hMbGRNdCtUZ0RWdnlUNmR1WUc0OGYy?=
 =?utf-8?B?enBiUkFzQlZpQlp2ZlFOOEpQdHc5SURkQVdyQk5lQWxWYTNuUGZTVTlvMHlP?=
 =?utf-8?B?MTFSNElmVG5CVFJ6S0RuclQ0aDd3OWFuNHV5MU5NWlU4SDRMWmtvLzMzNHZZ?=
 =?utf-8?B?cDhWcGV3SVIvaVlSaElQS3Q3c1dFUEpLREVneE5IQWhER3JqWGlqazFEVTht?=
 =?utf-8?B?L1FjSWcxWWRKeld5c1dTT28xTG1iRkJNUTJ1bGltRVNtUWZUeGdHcms3MUJ1?=
 =?utf-8?B?OFVraWdyeVU3Qko0aFVlNVI4bzc2QWZRNEJYc1pHL3BpTWVob2s4ejJjUWFI?=
 =?utf-8?B?NmFuSDBJUHA0aFdnbXBBL2M3bGRwMk9LWDZhSCtYYzFkUHJ0T0VSVURFek5K?=
 =?utf-8?B?bWczM2pmWlJoYXBEdE9NSFptQ1BZajhLQWJSOGFKalV6USt4VklpVERCVUox?=
 =?utf-8?B?cExOUUZyNUJXdStjempxakQwSm1BVUxBTHUzdnVZb0paZ044dnpyWVZsanM5?=
 =?utf-8?B?cEk1emxxVHVDQ2w3bXArWHFFUWxCSm00WlR5MnVuZEtXUGJhcFlWczJNcGhn?=
 =?utf-8?B?VGFFQnNYMmludWlDb1VvMXkxOGNqaUhqTzl3bi9CTHM5QUxnMmw5TTNkRjE0?=
 =?utf-8?B?dllFMXl6N0wrMXpUZHhVKzNYY2lFdXFURkUwaGQ3NDNaK0Z6dnpEY2NyK2hF?=
 =?utf-8?B?dzM5NStoak5aTVc3WHhUVWVnamhCUGRObnF0WjAvT20wcGIzSXdPR2xXQWZ6?=
 =?utf-8?B?cStJc0xOdVlyMXpPN3cyOU9ZQkF5WFVFTDAxSXFqZksvM0xMTm9mOWFkZjZ0?=
 =?utf-8?B?bzhBbHNDS2tQT1ZDR3IzKy9tVDdkeW9GM1MyUmwyQ2pNanQ3cXgvS3pHRWJ4?=
 =?utf-8?B?alU0WnlSN0dZd2tpTVpiVEwxYmoxcUcwMXlpNzJpZHZrNitOeEI0aWYxZlJv?=
 =?utf-8?B?THhzVElJcVRKQkJOakZwOTRpZGc1YWxHUTI0bXJYczRiU09tNnY3RjZXWWxQ?=
 =?utf-8?B?bWIwUEE5OWE3UXJjU2k1a05ad2NtaWRsVGdzTVV6aGJvcm90V0J4U3V5WWho?=
 =?utf-8?B?bXNMRXBpSWJpbUNzT08rMFBkMXFGMUhmU0labURhSGZHdDFIMlFoUjBxMDNv?=
 =?utf-8?B?QTJTbmd5OXUwRCtRaURxeVgwTVVhcitYSGRzZDNYOG5tZ2xadGEvMVRoTjFv?=
 =?utf-8?B?SmpoV2xTZGFXa3FDS1lUdXBkVzA1Mk51Tkt1bncvWGxOOFlYekpvV0xrRENV?=
 =?utf-8?B?VmZTTWxMeXdkaGlOd2pHL00yc0FoTUJhbXpHMmtoaDA2YzI0NUk2cWtZcmJz?=
 =?utf-8?B?aUxzOGdqUWVmdGdwbEVob3Q1REwvM3JFblg3QllSYjdJYi9rMER4QmI5Q1pk?=
 =?utf-8?B?SW1qelJScHhQMUJCdUFrU1RHcEgyV1l6TWo0OWhMOXRWYTc1V1FnSkhuRzVl?=
 =?utf-8?B?cTk2OEtaaEt1akdUTDd1Q1R5SkhvSmE3cit2RFJqRTY2MHdpdXlXS0o2VUNR?=
 =?utf-8?B?Q2ZxbUxCbElVMFZQd1J3Q1l5Q0JsdHBORHdFR3FxMEd0Ni9YNnQ1aXFJZXFO?=
 =?utf-8?B?UnJhd1VXYlNZd0VWRk02MEFXWm9Xc2NsMzFYanBEZnBhYlRCT2RuR3FBRTU2?=
 =?utf-8?B?dnMySEpvYkVsVjgrOFlrVThqREM0aGhwSUc0amh3djFCL1V2Yit5d0VCL3Fn?=
 =?utf-8?B?MStZVG9STnhnbHVNdTdmZkRndStDMXNCbTc2NG9Vd2haZjVqRlRQelcxMU8r?=
 =?utf-8?B?Yk4zODd5aEtMVEZ3OEVRTDYyaEpQU1ViMWlUekZsd3crY1kxekNUR3Nqd2VH?=
 =?utf-8?Q?uxRcX3ikFwgbdyPV9wQLsF0c/txM5Bbxr1Ruw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a65edb8-4222-44fd-b721-08d8de81bb59
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2021 20:20:05.0550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gYh0ZWlD62xdWH13TcaaPE0uaMEm/AUlZVC46/sePWf2Ba7LSb6D6k13VIZqtkkh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4740
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-03_06:2021-03-03,2021-03-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 phishscore=0
 clxscore=1015 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103030144
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/3/21 11:38 AM, Yonghong Song wrote:
> 
> 
> On 3/2/21 9:19 AM, Joe Stringer wrote:
>> These descriptions are present in the man-pages project from the
>> original submissions around 2015-2016. Import them so that they can be
>> kept up to date as developers extend the bpf syscall commands.
>>
>> These descriptions follow the pattern used by scripts/bpf_helpers_doc.py
>> so that we can take advantage of the parser to generate more up-to-date
>> man page writing based upon these headers.
>>
>> Some minor wording adjustments were made to make the descriptions
>> more consistent for the description / return format.
>>
>> Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
>> Reviewed-by: Quentin Monnet <quentin@isovalent.com>
>> Co-authored-by: Alexei Starovoitov <ast@kernel.org>
>> Co-authored-by: Michael Kerrisk <mtk.manpages@gmail.com>
>> Signed-off-by: Joe Stringer <joe@cilium.io>
> 
> Ack with one nit below.
> 
> Acked-by: Yonghong Song <yhs@fb.com>
> 
>> ---
>>   include/uapi/linux/bpf.h | 122 ++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 121 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index b89af20cfa19..fb16c590e6d9 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -93,7 +93,127 @@ union bpf_iter_link_info {
>>       } map;
>>   };
>> -/* BPF syscall commands, see bpf(2) man-page for details. */
>> +/* BPF syscall commands, see bpf(2) man-page for more details. */
>> +/**
>> + * DOC: eBPF Syscall Preamble
>> + *
>> + * The operation to be performed by the **bpf**\ () system call is 
>> determined
>> + * by the *cmd* argument. Each operation takes an accompanying argument,
>> + * provided via *attr*, which is a pointer to a union of type 
>> *bpf_attr* (see
>> + * below). The size argument is the size of the union pointed to by 
>> *attr*.
>> + */
>> +/**
>> + * DOC: eBPF Syscall Commands
>> + *
>> + * BPF_MAP_CREATE
>> + *    Description
>> + *        Create a map and return a file descriptor that refers to the
>> + *        map. The close-on-exec file descriptor flag (see **fcntl**\ 
>> (2))
>> + *        is automatically enabled for the new file descriptor.
>> + *
>> + *        Applying **close**\ (2) to the file descriptor returned by
>> + *        **BPF_MAP_CREATE** will delete the map (but see NOTES).
>> + *
>> + *    Return
>> + *        A new file descriptor (a nonnegative integer), or -1 if an
>> + *        error occurred (in which case, *errno* is set appropriately).
>> + *
> [...]
>> + * BPF_PROG_LOAD
>> + *    Description
>> + *        Verify and load an eBPF program, returning a new file
>> + *        descriptor associated with the program.
>> + *
>> + *        Applying **close**\ (2) to the file descriptor returned by
>> + *        **BPF_PROG_LOAD** will unload the eBPF program (but see 
>> NOTES).
>> + *
>> + *        The close-on-exec file descriptor flag (see **fcntl**\ (2)) is
>> + *        automatically enabled for the new file descriptor.
>> + *
>> + *    Return
>> + *        A new file descriptor (a nonnegative integer), or -1 if an
>> + *        error occurred (in which case, *errno* is set appropriately).
>> + *
>> + * NOTES
>> + *    eBPF objects (maps and programs) can be shared between processes.
>> + *    For example, after **fork**\ (2), the child inherits file 
>> descriptors
>> + *    referring to the same eBPF objects. In addition, file descriptors
>> + *    referring to eBPF objects can be transferred over UNIX domain 
>> sockets.
>> + *    File descriptors referring to eBPF objects can be duplicated in 
>> the
>> + *    usual way, using **dup**\ (2) and similar calls. An eBPF object is
>> + *    deallocated only after all file descriptors referring to the 
>> object
>> + *    have been closed.
> 
> if the object is pinned, the object will be live if the pinned file is 
> not removed. The file description can refer to a link file descriptor or
> an iterator file descriptor which will (indirectly) hold a reference 
> count to the program as well. It will be good we can clarify a little 
> more in Patch #2 at NOTES section after other bpf syscall commands are
> introduced.

Sorry. Looks like NOTES are properly updated in patch #4. So you can
ignore this comment.

> 
>> + */
>>   enum bpf_cmd {
>>       BPF_MAP_CREATE,
>>       BPF_MAP_LOOKUP_ELEM,
>>
