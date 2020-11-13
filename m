Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B108D2B133A
	for <lists+bpf@lfdr.de>; Fri, 13 Nov 2020 01:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgKMA1K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Nov 2020 19:27:10 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:13238 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725929AbgKMA1K (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 12 Nov 2020 19:27:10 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AD0GdUf008250;
        Thu, 12 Nov 2020 16:27:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=QFDVK8+cvVjzaOR/m4UODdt1hWETX2E6qvRvnwlZgzk=;
 b=IEv+okrBSenDMjITm2xxKWXfJLTVxCqFXjGYHJEhgLR5QDB1jz5jYynZJeFFEv+E+jqm
 sE0G8K7jgYmrE+aS3PLNgzoH5wVToKtr7seEDXCEBeZbv6CJRX6ZYHr2pUvOmshBfNo9
 INllMSWB1+X7rkAGt/HO8H3rqCKvQIgG1hM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34s7crk6q9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 12 Nov 2020 16:27:07 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 12 Nov 2020 16:27:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UhE38umFVVs99ch+LqcJtJkbxC0dWUGVbNs/oqMtSToxnP6eZeImAFfuRpctpOUFZIbc26SoyJ5AeMJ5JyzGOc0RRmLwbllWRAKwzcZkB2RlmIHeTX7gYj32FJyoWHuETAdlLQbZiGMNt1Jbqyp05y6jqrliQA209lIyJUKQsJQepVl9rrMExY5eCgKj/EoU8Jajri87zFDNUSN9ofxz0ohD8w98Gi3qqhh0gx/f0c4u8tGfOCppXEKLX7lASju+mz6IucGIR1YG1Hq9tQ/tmLLnHDOcs290Kv08lWXQYZgmiNpbId1/O1yKuzfb0zc6Vqn/8PdvImlH3uOLD+R/2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFDVK8+cvVjzaOR/m4UODdt1hWETX2E6qvRvnwlZgzk=;
 b=eTYnujegrNimCoQxCdnGDSOAggWhxIi1YQteu7oDkiIt56Md7lg4HPKsksidpVqixh9gUwuf4zx9o268DRh2WsrbSyYoqhlNjPogLn7ySfgX8I6FyBZfubf4CXCr70ezyNtYaz5reTjAW2xi/1A3zL6t3F/QCE3yhGTC+2HT/TAWaU3FeaJvw7q4TMC/xe8eRLr35COjSThZ/9axSNIl1J+6YQ7Fv9bqVfAUG/8wcvJhiG6spLpmUDpeC+RtgTIdEIm/wfgb0rB+S2Kw4XVbPN5Dt97FAuTX184jZbjfTvEewghJw7Eigo4mgQAQeVqXHlAZfJQRJj+IC3e9IM8eTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFDVK8+cvVjzaOR/m4UODdt1hWETX2E6qvRvnwlZgzk=;
 b=Kz7TBwP/cIFpNwxWRfcs74kwE92jLlkxRN3ILDvpO7hPqp7RJia2R0IAcmr1SUjTw97cssEI9IlDxwtWQjYAogwGZ61WYSJuiucSbB/EZEmIYgxnfoIwMZ3y/A0/i7rJClrWk+uqRjFwfKqBOza3ypsy/BBiOCBM+r7dWxQbFsM=
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BY5PR15MB3618.namprd15.prod.outlook.com (2603:10b6:a03:1b0::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.24; Fri, 13 Nov
 2020 00:27:04 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::8887:dd68:f497:ea42]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::8887:dd68:f497:ea42%3]) with mapi id 15.20.3541.025; Fri, 13 Nov 2020
 00:27:04 +0000
Subject: Re: Extending bpf_get_ns_current_pid_tgid()
To:     Daniel Xu <dxu@dxuuu.xyz>, <bpf@vger.kernel.org>
CC:     <cneirabustos@gmail.com>, <ebiederm@xmission.com>, <blez@fb.com>
References: <C71MVCBQMCPF.1CCKLFRTGYD0D@maharaja>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <3fb902d7-a88c-f9ed-03f0-460f7bd552fa@fb.com>
Date:   Thu, 12 Nov 2020 16:27:02 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.2
In-Reply-To: <C71MVCBQMCPF.1CCKLFRTGYD0D@maharaja>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:3ef]
X-ClientProxiedBy: MWHPR22CA0056.namprd22.prod.outlook.com
 (2603:10b6:300:12a::18) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::11f6] (2620:10d:c090:400::5:3ef) by MWHPR22CA0056.namprd22.prod.outlook.com (2603:10b6:300:12a::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Fri, 13 Nov 2020 00:27:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9c2bb30-9e87-49fa-e876-08d8876ad8b4
X-MS-TrafficTypeDiagnostic: BY5PR15MB3618:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR15MB3618B25D2C3F812BCBDF92EDD3E60@BY5PR15MB3618.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gd6wkE1k8vtxJp2ycCHIrMBaiRTZG5dh5M4dcW4NZlgfmJuc6VtV6uevDKAX27G89EdnIfurpawylgwdZKHCUWWw6RHI0oqmNDU/qTb0HPsQhlYLlKZm5qs9DP5+Mc2LqXasXOlDFsEu0bm6RIWvp/JCHIUBo2ATgSkXR07nAQfLSHnwIUAsziVqLcxS2+6DD5gNFIVTdjXOp7IbzxicJx1Z/YQ+EI4n6dHRyncBGZL6ij9FdB35AAmqF0XEUBxkdjSecLdoTK6GEKc5O8tFnTWmpthUOHk66eYNDWtN2Rc1nzVvdFpL9IMWNH6noQuLbtcdxUSK0v1KiBXne5dot+Dm1DcKISIjuX15Bb72ZUweqClLJfI6kRMmEw1uTPQv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(376002)(396003)(346002)(366004)(53546011)(316002)(31696002)(31686004)(8936002)(66476007)(4326008)(2906002)(6486002)(86362001)(66946007)(16526019)(36756003)(66556008)(478600001)(2616005)(8676002)(52116002)(7116003)(5660300002)(186003)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 5STgtvKzCRGlgTgIwDbLhvY1ji1CWwsMeXwiIHqLbEI93+rnQoCatJBhqNVy2m9WN1NMs+sxZWR6g3kDTMyeI8bB/mC3oYLJoB6RTPtBN/EYxyIgBRcJyA04WnJedOAzYAc3ZwW3iQs1fBAJTXENj32E/FvUdAIPu2/1u9IdbTf39VtieRze7N0e8xxhqO06bVb5ALFoDnLMLwuEzV+Qjl6t/NZG3D4fsmHqsMZqD0avD75mdbWfBAEoPDfzSbc/FxlViqR5osXy/jso/8ZCedc+D47JdOO4cFJGCAnEUlfvScK1OAVx6rxn8oDUsYJ48XN03WFhL9FoUHyOVbTYTRpNC2+YXXb9hKuvq2Zj5xGWLmJG2kytNFQTh+t3LBJh0ud3fAp39hqbkLSZAWlPfWfXp+RiONbukZTVMrRKtNL2lHl/Y/gJ1yz+tC+O3CgBd/5YOLnEQlzUou1xaq4X+fwhrpw/8hoCL8J3n5hhljrQqZYwQaDbzSXva0jTsWn/SU6jD2uV7XeYpHGItEZCSN3UfN+9IZxEeDfXDw/8EHUzLdQTedPzEfqbyg9FsqyWTA2UAD6a10QKyOGzoOOMYNQv2BeLD0K9NEWe541FWhTibAxo8y5h0RhryjqBRPpq2BFlPisdg6ewVnu7EMyqp8NkzFXVjkuWm3h6qVRvweBYyndZ4RIJq0v6irG6JLacZtR/q8AuOygx2HUE0mF5bBriwqTMTbe9eeMEhELo+BNgfSw9RBLoJTmjXb5WCwxFpkh+l7mdKS9O0nps1vsxSrMsOVEVqsbQA2lQ+nd6vBwDHZnSaBuE5Fc6bFamEyW33b+iDFesLLzf2S4cyl0d1JUBFNbzjKQd4eI2ee8U8zx8gd6qAwWK+OhuHQLoOZJE1B6xRatTVjuqROV6Zx+TRQ3py4ayHZDylklMUQheFWU=
X-MS-Exchange-CrossTenant-Network-Message-Id: d9c2bb30-9e87-49fa-e876-08d8876ad8b4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2020 00:27:04.7291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j+Ns0AlsWmdbgX0+9SA6dXEOZ3qlU4VVfHK5LoUdfm/zncsUsmna2FY83J9+/uoG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3618
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-12_16:2020-11-12,2020-11-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 phishscore=0
 mlxlogscore=999 clxscore=1011 impostorscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011130000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/12/20 2:20 PM, Daniel Xu wrote:
> Hi,
> 
> I'm looking at the current implementation of
> bpf_get_ns_current_pid_tgid() and the helper seems to be a bit overly
> restricting to me. Specifically the following line:
> 
>      if (!ns_match(&pidns->ns, (dev_t)dev, ino))
>              goto clear;
> 
> Why bail if the inode # does not match? IIUC from the old discussions,
> it was b/c in the future pidns files might belong to different devices.
> It's not clear to me (possibly b/c I'm missing something) why the inode
> has to match as well.

Yes, pidns file might belong to different devices in theory so we need
to match dev as well.

The inode number needs to match so we can ensure user indeed wants to
get the *current pidns* tgid/pid.

(dev, ino) input expressed user intention. Without this, in no-process
context, it will be hard to interpret the results.

> 
> Would it be possible to instead have the helper return the pid/tgid of
> the current task as viewed _from_ the `dev`/`ino` pidns? If the current
> task is hidden from the `dev`/`ino` pidns, then return -ENOENT. The use
> case is for bpftrace symbolize stacks when run inside a container. For
> example:
> 
>      (in-container)# bpftrace -e 'profile:hz:99 { print(ustack) }'

I think you try to propose something like below:
   - user provides dev/ino
   - the helper will try to go through all pidns'es (not just active
     one), if any match pidns match, returns tgid/pid in that pidns,
     otherwise, returns -ENOENT.

The current helper is
    bpf_get_ns_current_pid_tgid
you want
    bpf_get_ns_pid_tgid

I think it is possible, you need to check
    pid->numbers[pid_level].ns
for all pid levels. You need to get a reference count for the namespace
to ensure valid result.

This may work for root inode, but for container inode, it may have 
issues. For example,
   container 1: create, inode 2
   container 1 removed
   container 2: create, inode 2
If you use inode 2, depending on timing you may accidentally targetting
wrong container.

I think you can workaround the issue without this helper. See below.

> 
> This currently does not work b/c bpftrace will generate a prog that gets
> the root pidns pid, pack it with the stackid, and pass it up to
> userspace. But b/c bpftrace is running inside the container, the root
> pidns pid is invalid and symbolization fails.

bpftrace can generate a program takes dev/inode as input parameters in
map. The bpftrace will supply dev/inode value, by query the current 
system/container, and then run the program.

> 
> What would be nice is if bpftrace could generate a prog that gets the
> current pid as viewed from bpftrace's pidns. Then symbolization would
> work.

Despite the above workaround, what you really need is although it is 
running on container, you want to get stack trace interpreted with
root pid/tgid for symbolization purpose? But you can already achieve
this with bpf_get_pid_tgid()?

> 
> Thanks,
> Daniel
> 
