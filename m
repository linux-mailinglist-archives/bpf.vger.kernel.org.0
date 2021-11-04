Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6FC44598C
	for <lists+bpf@lfdr.de>; Thu,  4 Nov 2021 19:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbhKDSXj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Nov 2021 14:23:39 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52306 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234150AbhKDSXi (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 4 Nov 2021 14:23:38 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A4GOAnO016594;
        Thu, 4 Nov 2021 11:20:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=xJFKM7aF/ZSS9TbdiNqcC76gtOvvqK8AKgsNExqTFRM=;
 b=fO59qa2Dsz2nFT4ShSVQxDa0IDxFC9bwfMcpKwF8OJxDYdoyBCf1oJgDdVEwKic2CLP+
 RJYHuFmFgjK+00av1re8QugRr/1eXrUceAfLntKkwxiVxxTN6gwGbboT7zjukyYLBSQg
 lUY2z2Mo0lPTrB7pt2bCMmP3SdWoOPDnY78= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c3vegjnb7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 04 Nov 2021 11:20:44 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 4 Nov 2021 11:20:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iAJRWCyDHyJT/874lRrNkiB04uZ5qtOZIf32HqN//B9/Apq8beSe8z32nOU95Giz3iyVvcpStgupn/fiqKgKvngtg9SQX3HWv1GqT6UqpcpQRLgjEfI955zUE0WzZqTyDaCuNY+kC18qXretxPyhev7Tt5chK7hCCZjt4GqGMWF65eKE6nBvMtBZW+QAWUGeq1TyJEmzqOoZKdB7dgUhnA+FveNrFu1SzSNu+jYs7KSECn+T7FsCx+o/jxqW7R5rwnHQMALGdSlpYN0X/uF+/rAXA0LgzDrWOyk8zGZ3RvUbrptGWL02t/rmAxfwDcVynJK4amx4Jx75tLYh6ZB68A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJFKM7aF/ZSS9TbdiNqcC76gtOvvqK8AKgsNExqTFRM=;
 b=mpgZnaU/KdT/l6vFhTQPoNHxhFwg7UIDgB6liPpRwXA+uP83Px5F5IWlsLXA6PKVP1f8KYVdHGn4rJp1dkE57JqvovdQgE+eN3BW6d8devszaI4oRdIQKzc6uq3cvVSFMX6ifc6Z4eB2I3rEY+aEk84ZSxJ5LSOmOM3wfCghZmUm9kfmJv4fufbgNzZLyEtKE0eW45h8nx7rdc5pl/qWqkBktt8kqNSxs4TtzDGy8NGxVbaH11q1GMLwcQNoO+Vj3xyz+XzbOjVnc6SLP1t1gVSBPoaaJj4ue+fZLfNXt65bXikGPtXC8vFdlM2Q5Ff82/ZkRMXbeFpzr5H4dXgHzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3789.namprd15.prod.outlook.com (2603:10b6:806:8e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Thu, 4 Nov
 2021 18:20:42 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4669.011; Thu, 4 Nov 2021
 18:20:42 +0000
Message-ID: <98743688-2a66-8f09-8adc-efc3f3ab9445@fb.com>
Date:   Thu, 4 Nov 2021 11:20:39 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH bpf-next] libbpf: demote log message about unrecognised
 data sections back down to debug
Content-Language: en-US
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
CC:     <bpf@vger.kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>,
        Ciara Loftus <ciara.loftus@intel.com>
References: <20211104122911.779034-1-toke@redhat.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20211104122911.779034-1-toke@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MWHPR1201CA0018.namprd12.prod.outlook.com
 (2603:10b6:301:4a::28) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21e8::1253] (2620:10d:c090:400::5:e407) by MWHPR1201CA0018.namprd12.prod.outlook.com (2603:10b6:301:4a::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 18:20:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61bf2bfd-c897-42de-6788-08d99fbfcfd3
X-MS-TrafficTypeDiagnostic: SA0PR15MB3789:
X-Microsoft-Antispam-PRVS: <SA0PR15MB3789EB097B6F77D828B0E855D38D9@SA0PR15MB3789.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uUVP3U+xszZkWDMj5X/seF11C1NhKyXRkQsJhs0n3vL/VFKhsvtCO2XZRwuqCamc9ycBpA0jrSwwm3UGlHxi1KvNqcfDM/KpYIbDP76ylDdjw7V0VTZjyMMOVE4iLS9tfft11BM7d3PtZFbugnfekJUjVw48fBrFZAh3YuDal96Kr/4d/5LOjUUf/C65Th8gQ42Q3xcH79ttvwEpRP/7U9Gt3D/LJtOognNVZWv0XDsg6ktIxDFvdJ5YgAUSrFtAZLeAAghcGWtySt2MPnd7RajEJPdl5s+xsXdrTA4EWEuEEZZgJRK/MBMe2lnpy6yGtd3Xw5kfRl5/mz42TYqQRvsLSeFKnXvK8BVe32XGYZmYH/8ZpdhRS4EoprGeUn41jx+gOb/kZd830AjxKmeTV7nj4JZl27DCgVponP52I8/6mdhFQojPA/7gnsO3QUYVPhlApAMi9JO4ZFTL9xTbemNNIB/qVbV+tctSWK4BAXNQqfW+B8egaqzRM5b/Fuuylg4Y1fvtL9/RR3hIhVhi8DwahKOdopsco7AYeOnbPhgw+sE3Cj1eGcVWDwYpdDcMyTC1NQgSbYU7CufPuMmrPGBt5IHE0asgJjRy0RzXxjQpMsX746qWbT5FwE2YLRy3zY97o6nWc5D0XTfd6J/lAk7M1bWf1tSEmOAeUUPdnGWBZsPcAkhM3b4SY1eXlxOqUhXT4W0sVoZFebJSlFIKkiSMo44Q/hy16yo7NXOTVyF33As2kResaGPqXMy/3jzI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(31686004)(508600001)(110136005)(8936002)(54906003)(86362001)(5660300002)(83380400001)(2616005)(8676002)(4326008)(53546011)(52116002)(66476007)(66556008)(66946007)(186003)(36756003)(15650500001)(31696002)(2906002)(316002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0ZnQnorZ004ZkxzUG95TFBLbG80U0tIWEJSUmVTRm5LaTFzMng4RHU2VXlI?=
 =?utf-8?B?c1VVaUh3bGZxM2FFYlI3SEZIUGNKMnZOVFM4U0tqc1NTUWxIYWxNTVFxMWpT?=
 =?utf-8?B?eEg1U0xVZTN6VUFhM2piQitnMkY3QVN0T1VKZnpHUlBESjNEQUpVc1puTU5O?=
 =?utf-8?B?cHI0aU9mcUhkM3pOUjJPVTRxdmVLYUsyMmxsaVJ1TUM3UHJmSC9sb0hVZXFk?=
 =?utf-8?B?cUQwZ0RnUHhHdkFJcDJrSlRySnllTG40WEVpb0lwOC8zMkxDYklON2E4RU1O?=
 =?utf-8?B?a3JnUDZuVDBla01lajMzVE5sZ1drUHJxQlNLeTJLVGlEOHhrZzFRb0FPczZQ?=
 =?utf-8?B?dzlqWVlYc002N1Q1djdDaVh6K2NPQ3VENk1vQ1laTEM2OWF2cFRrMlVvMVFi?=
 =?utf-8?B?Y2MwZnZoT0h3NWRtU25NdXhHQTc3RmdGa0ZTbTlycVdyUHF6Y1kxbWdQUlNX?=
 =?utf-8?B?QzRkSy9GUDc2VGNBQU51ZHBnRk1KVFVJNkgySENRN3NQZE5MMUZiS0Z0OUFh?=
 =?utf-8?B?OXRNZDdCazZhMXBYeHVqWkJLOFhmTGFGMXNxcnFqL3RKQWxjVDFkbkZRdGp3?=
 =?utf-8?B?TFBpYisrd29yWjlOeWpHZlhEWmMrdlRuYzlkWkVzeUkyR28vNkVXcDArNGRv?=
 =?utf-8?B?eTdQN2VDM2NvNVRkUHVwaG1VMVFMalZGSFFKTnZ1VVY0WmZwUXRKamlheGpS?=
 =?utf-8?B?VG5ZL3U0VlBST2V0TDVHbUo0NGxEQlF5eHBTeWNaNk84WUR0RloreWs1dnRh?=
 =?utf-8?B?c01sdWN1QW1xR2FKU05SaEdtY1dUTDVRWmtGSjYxeCs5RUxYRnBSdzd1eTFJ?=
 =?utf-8?B?OXB2TDluM2NHYVlKeTBZQXZ5OEw0MXRoMW5yQ1U2R1RiS0RRYjJNQ2RFaGNl?=
 =?utf-8?B?VDRvQ3loUFlZMGxEdldxNnAvLy9VZXVmQ2FLNXhDaUF3RU5xQUlxWWM5WlN0?=
 =?utf-8?B?cUFlWTRyYVpBUncyMmpPaXJid0FDVXNUWUNDNjNEUTlVVnBEajZhYUkzNzg5?=
 =?utf-8?B?S08yY2FVK0IyL3dWQXpjZlpnUzcwWG5WMWtqTS9yOEdBb3NmVm0yWjdKdWdE?=
 =?utf-8?B?bjNPanlVemJSMzF6Qm0wNmhyT0VLNTBNQ3pyaVBqOTRPSkpoU0lWNytEazlY?=
 =?utf-8?B?TFhoNXZkMUtLQVgzeldGdHpyRUJpMVp4emI0N1hTY2l0WklPNlJlWE1vODZy?=
 =?utf-8?B?eTFXMzNpOEx1OXFabFczOWZTeUVkNFZ0Z0hBbWZ5SzdUc2hJRm5CNDZRUm5S?=
 =?utf-8?B?MjRhSzR1dVJaZHdabXpGUGdadjdFbTFOWlFNUWd1aXJ6bWljVklKa0VUejdu?=
 =?utf-8?B?SVpQUVhtRzBVYU1iWkZwNmFuMGo1RHlPRzdoRXFNT3hhYjZqSVpWSWVxeDBY?=
 =?utf-8?B?SHpIaWZhdmoyQXhnUTNVdXBjWi9MVUZBT21OUjVteG5ZQ3RFRS8vVkVnSmQw?=
 =?utf-8?B?RzBtZzZYMHVxL2UxNEJkdkswMkhpeWU1OUFlRDlWenJIWkdmNlpzQnUxZDBN?=
 =?utf-8?B?N1phaUs1QUtJNE43cTljejdya3ZyV1A4VDVobzFPQlQvbHB0V2FKa0E3U25l?=
 =?utf-8?B?aTlRUDluU014dGs4WDk1K1ovSUxHbytGdjFFR2VpTVBGbGgrdkU3ZjRCZGxF?=
 =?utf-8?B?cDd1MHl5NFhvbzkxOHIxdzJhSmYyVkhRTk0yVE1sVDVyUnZIQmJ2WjdlRlRZ?=
 =?utf-8?B?ZzJmYmZvaklSU3ZwVTc4d0tKeUZvSktWWjNoMk12emZibk8xRjNvMnRjcVFV?=
 =?utf-8?B?Nnp4STYyVHRETTFqU0NDVVU5eHhvRms5SnE4TE9ZRWE1cktTUHh3YUhySUdt?=
 =?utf-8?B?MlhOVE9zdmFPQStzV0FZV1RsTDYyeWZRblhBY2ticzZiVm1XNU9zOFBIOGN1?=
 =?utf-8?B?TE1vOG11c3pGNE5Yb0FzVHoxaFNCdkZSSkhKUlJRcmxDOEtqVWN3QTdZRE5V?=
 =?utf-8?B?M0RKdW01SFlrKzlSeVloc200blZ4b0dRblJPSzN5ZXpROUVkU1ZoWG1qd1U5?=
 =?utf-8?B?QnYwbVltb2swRSt5RXpFNlU0TjJuU3g5bFI0Znh2UklFQjNzUElxd042WVph?=
 =?utf-8?B?Wm41UEVENW9EdTY1bnFYSWNTNEo0ZC9pY1Q1MFZtSlVzSmZsMlJwVE5PNGhi?=
 =?utf-8?B?d0hrNXRBMDBYZ3FXeC9LVzVFcDl0eUR5OStaWWNyZGZNSDZGQU9hemhkT0NS?=
 =?utf-8?B?MXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 61bf2bfd-c897-42de-6788-08d99fbfcfd3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 18:20:42.5023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fqkglHduV8sRnazEq6MQnH/fPV6MPGXHdx5XF8tqsM2hbWWBKEolPnFj1VhsejN3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3789
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: qT80K_ew6NbndQHOte7BQP8p_umfeUdJ
X-Proofpoint-ORIG-GUID: qT80K_ew6NbndQHOte7BQP8p_umfeUdJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-04_06,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 mlxscore=0 adultscore=0
 impostorscore=0 spamscore=0 bulkscore=0 clxscore=1011 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111040071
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/4/21 5:29 AM, Toke Høiland-Jørgensen wrote:
> When loading a BPF object, libbpf will output a log message when it
> encounters an unrecognised data section. Since commit
> 50e09460d9f8 ("libbpf: Skip well-known ELF sections when iterating ELF")
> they are printed at "info" level so they will show up on the console by
> default.
> 
> The rationale in the commit cited above is to "increase visibility" of such
> errors, but there can be legitimate, and completely harmless, uses of extra
> data sections. In particular, libxdp uses custom data sections to store
> metadata and run priority configuration of XDP programs, which triggers the
> log message. Ciara noticed that when porting XSK code to use libxdp instead
> of libbpf as part of the deprecation, libbpf would output messages like:
> 
> libbpf: elf: skipping unrecognized data section(7) .xdp_run_config
> libbpf: elf: skipping unrecognized data section(8) xdp_metadata
> libbpf: elf: skipping unrecognized data section(8) xdp_metadata
> libbpf: elf: skipping unrecognized data section(8) xdp_metadata
> 
> In light of this, let's demote the message severity back down to debug so
> that it won't clutter up the default output of applications.
> 
> Cc: Magnus Karlsson <magnus.karlsson@intel.com>
> Reported-by: Ciara Loftus <ciara.loftus@intel.com>
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>

I think it is okay to demote the visibility from "info" to "debug".
Andrii's recent patches can handle more data sections. And also,
if applications work fine, skipping unrecognized sections probably
will be ignored by user any way. If application has issues, debug
mode will reveal more information.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   tools/lib/bpf/libbpf.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index a1bea1953df6..ac0eadbe1475 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -3297,8 +3297,8 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
>   				obj->efile.st_ops_data = data;
>   				obj->efile.st_ops_shndx = idx;
>   			} else {
> -				pr_info("elf: skipping unrecognized data section(%d) %s\n",
> -					idx, name);
> +				pr_debug("elf: skipping unrecognized data section(%d) %s\n",
> +					 idx, name);
>   			}
>   		} else if (sh->sh_type == SHT_REL) {
>   			int targ_sec_idx = sh->sh_info; /* points to other section */
> 
