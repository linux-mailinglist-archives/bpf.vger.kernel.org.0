Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE0C32C1FF
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 01:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbhCCWyF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Mar 2021 17:54:05 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:38088 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1387990AbhCCUNB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 3 Mar 2021 15:13:01 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 123JbKMI009117;
        Wed, 3 Mar 2021 11:38:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=JmcJ8D+dsITjJ8vEe4QAfU1KIggCsxfYuj3DWrrG7Tc=;
 b=NbmtG5UplBi171tuE1LR/vWsobnFQhLskv/WRSSvIVYrD2SWPUHxZdW6yT//4VSqwDeS
 5+NZLI6+eAYO/JZuX25o2YPsudO9W5Yijoaqbt4ueEqscNJgnpzNEm/QfVMyhjNwYEOz
 pDKAIlgX7gXeYON+HmI4cFV9beyejjkFSeI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 371uu3perq-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 03 Mar 2021 11:38:57 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 3 Mar 2021 11:38:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mtg5QtMKP2S6B+XtUvUpMizEw3bdmyK4ZvnGRt2OAg22tl+hz0e7XRSTIhyX8y16er/KFrgBPeN3Rrj21MFTpv3Ar8tyBVHdTzozr8AfASr4B0EIrqcwF3+FjIt0vffr6oVb5ktiuwSqzKxVHVowVdqOX5BOvB10m8y5i+01rtrkvWkXBfk41PFy+jkjxn6Jki5QoDsWAP6QDFczaTI7RsK90uVzj9W4LYvVUBFM4NsaqBW8Q3Z/CCAZhnPssGRiC0uCIsdKBMcM/VeU+EflABxOA7p5ZZNuuu+hnycbWZBuVjUX6B1u43qVY07QVGtorCvDJ4LPRjYeqvHL8FzUfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmcJ8D+dsITjJ8vEe4QAfU1KIggCsxfYuj3DWrrG7Tc=;
 b=lfz+DQWxM2ssJfpTPfhHoa8tI9q0Z8aNLAVqo+2v7wRz7lvcj3nfjYtCKGGt/e1rF6rCFFJ6NCR093r7kyisWbS94F0yUjle+HAfvuSUfKdk+4EaEqpPMHQPrSPO8axfC/UkYSaWDnphrBzeuLpqsl8H/rKu83aIMooVRQ8rVR6jQIwJskb+WiJB+4KgW8A9gczw1y8D/2XT/6LFZqcFWhanoiedq/FkFvlgXHyt4mJ+IYMqqchz+JLjpluEwfGjcMAi9UpppXCKk1tqbtsffwdZ1TyodO/c9eosJFUGl9Vii6Yzis8+DF1tXCPcs5YDD1NlcSQkSmSp0Oxkhv8PHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB2160.namprd15.prod.outlook.com (2603:10b6:805:9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28; Wed, 3 Mar
 2021 19:38:55 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3890.030; Wed, 3 Mar 2021
 19:38:55 +0000
Subject: Re: [PATCHv2 bpf-next 01/15] bpf: Import syscall arg documentation
To:     Joe Stringer <joe@cilium.io>, <bpf@vger.kernel.org>
CC:     <daniel@iogearbox.net>, <ast@kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-man@vger.kernel.org>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
References: <20210302171947.2268128-1-joe@cilium.io>
 <20210302171947.2268128-2-joe@cilium.io>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <f55e1371-bc0f-ba4b-3801-d0ad064cb490@fb.com>
Date:   Wed, 3 Mar 2021 11:38:50 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
In-Reply-To: <20210302171947.2268128-2-joe@cilium.io>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2620:10d:c090:400::5:94d2]
X-ClientProxiedBy: MW4PR04CA0225.namprd04.prod.outlook.com
 (2603:10b6:303:87::20) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::1a32] (2620:10d:c090:400::5:94d2) by MW4PR04CA0225.namprd04.prod.outlook.com (2603:10b6:303:87::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Wed, 3 Mar 2021 19:38:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00bb4455-3f4a-49d2-a815-08d8de7bfae8
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2160:
X-Microsoft-Antispam-PRVS: <SN6PR1501MB21607601E0EA1D30F50BD32DD3989@SN6PR1501MB2160.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AnL/7gt0dxscVx1okR9D5xVeiFhzr3F9w+3KaLj1getam1tdbvsKA1PJb5GiGjecO2QUF+YXumPhoXiaPlevDC/g+gzLp7x3cVbQXklAZQalBDbLBVejEPcLIvIm4uHZBbgkBY/hgcyyrQ6FEtnnlQra8UzawuYYU0T6vq1YyJslr/YD5P/SADTib+4779w12A4KRoMbomx4ejTTM64hlLrRQe2Mo0Yvj1Wu95Z3NFOg4IY03UQxDlVqG4PzPe6oBPo7qgYwTx0rZFl8fYrrOJ9wC433OP3xPyo2lzoHp8SwMLpsMTYN7cjHn9RKxj+O5HX/qKMCRyOKOpXOyH0RwWuudSZjT0vNOJyu3pUOhOZxY35b/hitFOHHOM95KjHVz/SJmnsyxgcvANXmKA7MLhKB9C6NfewjYTAejPJyu/9QacLsyeuvFKac0gSV1vfeTneI4QgWRcK1H+IxlKxtzvx6u03QxuuodQtnR21g1hkzyBlh0A3zjpFrT1mFRFSrTn2859CoPN1OFPtruaoqxlEklHRgVh0kprSsfDZdP1o5x3peIpoUOkBfb87E6ygnkLRT0j41K0oGcfneFrRzpg61nMnjXaklXkmd9ns2HWI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(39860400002)(376002)(366004)(396003)(53546011)(5660300002)(478600001)(8676002)(2906002)(316002)(52116002)(6486002)(31686004)(54906003)(86362001)(31696002)(8936002)(4326008)(36756003)(66946007)(66574015)(66476007)(186003)(66556008)(16526019)(2616005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bW1tN3FUS0lua3BnSUtzYnl0SjVRU05UNGFGN3NyUHhVWERlOWtpdXUybmlr?=
 =?utf-8?B?eU1IcnEvcnRrd1JmR3hoMW9HVTJYc0l4d3ZhWHdaczlRMm9hS1pKdUxxZFdz?=
 =?utf-8?B?ZkNIZ3JDN2JjM21oYzN6dVVrcU1wdEdENzBPWFFUY2JjVG5wMG1hbWlQdXda?=
 =?utf-8?B?dk1qVWVXZ0lFUStKanhSdURqRFhGRHh0SmIrVkRENEo1RzJKY2srRlMreU1r?=
 =?utf-8?B?cm9qS3FrOHY4SmJUYU1wTWIvNGhtNWVzNzJiWncwWURMSHk0dEQ5R0pBaTBi?=
 =?utf-8?B?TVdTT0l2WTl2MkY1YjFVRkplRlo3Rzd5NUJVT0Q2R25GOTdqbm1JMUErelE1?=
 =?utf-8?B?Yzhza3hPU2d6a0xyWkRyYWhjUFY3NGlYR3pkL3c3a2kzR3ptOE04Y2d3dWsr?=
 =?utf-8?B?MzRJUkIxaHpkNldnUjFoQnAvbitIeldLL1d5b3Yrcys5MzBoTVdMUHd0MWVy?=
 =?utf-8?B?N0JleFNUMXFtR1VtS1p6UWxydFg2ZWtsd1ZYc0xsWTRWbmpDZjFBMG5vNEhR?=
 =?utf-8?B?Nks3OG9mVjd0QzFnaU9TWWlEbTV4M0JhQ2F0ZEZpVkIwemVzMkpoWDZRanpv?=
 =?utf-8?B?NGJDNS9VQjlpdyttRVVJY0luZERzR2c2NG53eENjd1VkVyt6R01oSGQxWUVx?=
 =?utf-8?B?elRjTUJqSGtQTk54YjRGcDhyM0dSY1AwS3dzWmxySFZxa1RYaERzSTRCc1RZ?=
 =?utf-8?B?Wlh0ekp3dHl1czRUM2NvY01TTjF4UkthQ3FzY2pWUFBlajh6NStEcTRZM1p6?=
 =?utf-8?B?VmlKYk15UDhXbjdKUzkrMjAvNlRNMTdLV1F3b1dRVlAwQWRHMGpxRklJaTdH?=
 =?utf-8?B?ZFBBUjF1OGVBL2tZTWNzSHI2ZEl0MWVQR0FkOVMxNDFJMlFqZWRPVGhJdFli?=
 =?utf-8?B?STdKblRIaCtQMkc4RTZSZUFkVkM0VlNha3g2c25xMVEwKzB4QTVqT2J3RnVq?=
 =?utf-8?B?a09vUGNBU1NSc2I0cldaQzVHNlJ6bVJ5TFNIbG5OUEYxZnhlRkJHRXRTQzhE?=
 =?utf-8?B?OFhnUE9icSs5djhFWUdENFZNbmw0RWNBcXdieE15ajhxNU1QaHpjdFRRK0JM?=
 =?utf-8?B?SDUxMEVWdFlIcVJQdGJ3QjJ5Q29VeXZEQUM2dThBSGdWOE05ZjcwbkVnQ3Yz?=
 =?utf-8?B?M0ZtL21HMUpKQmlSUEVFb1pJREFPY1dHWVVYR1k2SWxsNit6dGVuQ2ZwNGxJ?=
 =?utf-8?B?dU9pemhDZDhVay8zMHN5c2kwQnV4QkFxdVZucUlsSWZmRXk1VWIrcmxQb1hw?=
 =?utf-8?B?bWFwVUJGNmJyY1hkLzZhb2tNQmR4dG9WaU9tNEdEOGF0NWZYdGcxQW1JTXUw?=
 =?utf-8?B?VVliWW1nMHpYOXlXUHJwaWlnbmhKR2VwNmtmTFF1Y1psd29XVTVINEFhbk1w?=
 =?utf-8?B?QVdXcWpDK2tGTmhvT2VXZ3R1N2gvT2xWanVNV1dsSU5BSUw1dy9tSGFPazFV?=
 =?utf-8?B?cTdEaS9CTGxmVUVyTTVlTXFFUmtYNVBidTRjZHFMUTNvVFVLSkxjeC9qOFJn?=
 =?utf-8?B?Tk9weEVlaVRoa2h0bThaSlhzY2JQR250QlNCY1gxREo4cWhNZHcxaVRsdFdi?=
 =?utf-8?B?emh2cHZGRHBJRXFBQWR2QngyMHFLRUlxeXdiYnlsYnp5MGcrTi9HZEM3V3lW?=
 =?utf-8?B?Y0hCWEZwN0J0VDZLT0dUbGo2c2NpU25pQm1ETWdBdGluS3QyVUh4YVlRczhF?=
 =?utf-8?B?dEpTNE0vK095MHdWcDROZTJpQ3VIb2VwYm9kbVBoTkxhNUNkUHRMeFlsSEJ5?=
 =?utf-8?B?Y0EySGd4R0R6ZHRjZ3Q4MHQ5ZzNBVUs5Ni9UVXVQWEk4bjBzVmsyR1pJNFR2?=
 =?utf-8?B?ankyNEtTOTQ1eFRUdG1PQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 00bb4455-3f4a-49d2-a815-08d8de7bfae8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2021 19:38:55.3545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XZ6u3hrNqBDywiwfGk3nE33mJKvKn3+h99i3PYz4E5vX+GFxcJb/H9+NNGT7Je2y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2160
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-03_06:2021-03-03,2021-03-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103030138
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/2/21 9:19 AM, Joe Stringer wrote:
> These descriptions are present in the man-pages project from the
> original submissions around 2015-2016. Import them so that they can be
> kept up to date as developers extend the bpf syscall commands.
> 
> These descriptions follow the pattern used by scripts/bpf_helpers_doc.py
> so that we can take advantage of the parser to generate more up-to-date
> man page writing based upon these headers.
> 
> Some minor wording adjustments were made to make the descriptions
> more consistent for the description / return format.
> 
> Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
> Reviewed-by: Quentin Monnet <quentin@isovalent.com>
> Co-authored-by: Alexei Starovoitov <ast@kernel.org>
> Co-authored-by: Michael Kerrisk <mtk.manpages@gmail.com>
> Signed-off-by: Joe Stringer <joe@cilium.io>

Ack with one nit below.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   include/uapi/linux/bpf.h | 122 ++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 121 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index b89af20cfa19..fb16c590e6d9 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -93,7 +93,127 @@ union bpf_iter_link_info {
>   	} map;
>   };
>   
> -/* BPF syscall commands, see bpf(2) man-page for details. */
> +/* BPF syscall commands, see bpf(2) man-page for more details. */
> +/**
> + * DOC: eBPF Syscall Preamble
> + *
> + * The operation to be performed by the **bpf**\ () system call is determined
> + * by the *cmd* argument. Each operation takes an accompanying argument,
> + * provided via *attr*, which is a pointer to a union of type *bpf_attr* (see
> + * below). The size argument is the size of the union pointed to by *attr*.
> + */
> +/**
> + * DOC: eBPF Syscall Commands
> + *
> + * BPF_MAP_CREATE
> + *	Description
> + *		Create a map and return a file descriptor that refers to the
> + *		map. The close-on-exec file descriptor flag (see **fcntl**\ (2))
> + *		is automatically enabled for the new file descriptor.
> + *
> + *		Applying **close**\ (2) to the file descriptor returned by
> + *		**BPF_MAP_CREATE** will delete the map (but see NOTES).
> + *
> + *	Return
> + *		A new file descriptor (a nonnegative integer), or -1 if an
> + *		error occurred (in which case, *errno* is set appropriately).
> + *
[...]
> + * BPF_PROG_LOAD
> + *	Description
> + *		Verify and load an eBPF program, returning a new file
> + *		descriptor associated with the program.
> + *
> + *		Applying **close**\ (2) to the file descriptor returned by
> + *		**BPF_PROG_LOAD** will unload the eBPF program (but see NOTES).
> + *
> + *		The close-on-exec file descriptor flag (see **fcntl**\ (2)) is
> + *		automatically enabled for the new file descriptor.
> + *
> + *	Return
> + *		A new file descriptor (a nonnegative integer), or -1 if an
> + *		error occurred (in which case, *errno* is set appropriately).
> + *
> + * NOTES
> + *	eBPF objects (maps and programs) can be shared between processes.
> + *	For example, after **fork**\ (2), the child inherits file descriptors
> + *	referring to the same eBPF objects. In addition, file descriptors
> + *	referring to eBPF objects can be transferred over UNIX domain sockets.
> + *	File descriptors referring to eBPF objects can be duplicated in the
> + *	usual way, using **dup**\ (2) and similar calls. An eBPF object is
> + *	deallocated only after all file descriptors referring to the object
> + *	have been closed.

if the object is pinned, the object will be live if the pinned file is 
not removed. The file description can refer to a link file descriptor or
an iterator file descriptor which will (indirectly) hold a reference 
count to the program as well. It will be good we can clarify a little 
more in Patch #2 at NOTES section after other bpf syscall commands are
introduced.

> + */
>   enum bpf_cmd {
>   	BPF_MAP_CREATE,
>   	BPF_MAP_LOOKUP_ELEM,
> 
