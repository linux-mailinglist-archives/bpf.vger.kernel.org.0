Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1B532C231
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 01:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391987AbhCCXAB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Mar 2021 18:00:01 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:32954 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1376620AbhCCWYr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 3 Mar 2021 17:24:47 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 123MHPac025233;
        Wed, 3 Mar 2021 14:23:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=fKcFEL3OmnNYepI0ZhNg3iqaDdU7ACS+Vx2ZaboD/QY=;
 b=NHy/pkhsCapb0gZAPST261yLV++ABWhenpJVrB2duNf/79l7yZDQTr+UB3GlkH8pOwdo
 rH0yCzijg7JBVBfcl5/WJ1/QYFpLDBVw+tJw4yJE4IriycGubdC7TnRjXK9roqv2vR7B
 saTIBY4ZUye7Hz71gM8vnXSJ53dtrQWHm6A= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 371uu3qa8p-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 03 Mar 2021 14:23:37 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 3 Mar 2021 14:23:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RntdbkJnbT6/vSS88VVoZ4XTBFOOPn74l2aLeGrSLuBqQbcWqtCot6Rg66LbWe+iQPpv7AskUnGdt0NNd9OV2CVWTartu1fZg8rUYtWi9RTXG6r9W4F9d1ptvW/FL7p0w3Eq940cYVanIdZtV5CcVE+DXO59UrltBb5gujJAF4r+OEAQfDbur/huEi163ZPU6zknpoRbSLk8TIxTEdHWdaIDxBH3JuMLEB8BndyxLsqe+ZCdf8tZWMq7wpYkEyg576DtmU2jc8YQ4zQ8Fd2iAGyWgFEa+OJ1SAkQMAU6ONdIH+sM90Ob5u8f28NzjUJdb9LIcqv1E4eYSAxNQo6iTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKcFEL3OmnNYepI0ZhNg3iqaDdU7ACS+Vx2ZaboD/QY=;
 b=Iyntt9ctSejcVCTWW2EeXy5+LRi4k+pUEbhoe1Hx9r4wttmycUFWl2bQt5H6HXxflRJQec+clsru35xlvUEl1JaKFY6fedGmrPkumktWJNtWfJrWWukkmG1kvkpFghbR9I6dZymo1ZMyeewc9Kq6GuEvyfdT3X/W4mF7AU4CMhlXKDSLYzh+8xTV3Y+l1jjSkbpu8pAucOYfStSOAUNNtc14fj3DVshzO509cMQl/dTcbMyX1RqqYHScB7o4/fxX+XC5a3H5wSsro1nfk79/39YpFLJavG6dQI4XKz1279j5fTbXqMHxd5C6PK8sQ1w2W5BEqyMKdnqYc4xRDP2oBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: isovalent.com; dkim=none (message not signed)
 header.d=none;isovalent.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4739.namprd15.prod.outlook.com (2603:10b6:806:19e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 3 Mar
 2021 22:23:35 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3890.030; Wed, 3 Mar 2021
 22:23:35 +0000
Subject: Re: [PATCHv2 bpf-next 13/15] selftests/bpf: Test syscall command
 parsing
To:     Joe Stringer <joe@cilium.io>, <bpf@vger.kernel.org>
CC:     <daniel@iogearbox.net>, <ast@kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-man@vger.kernel.org>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Quentin Monnet <quentin@isovalent.com>
References: <20210302171947.2268128-1-joe@cilium.io>
 <20210302171947.2268128-14-joe@cilium.io>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <0c5a3a41-2df2-2d54-80d5-00a9951074fb@fb.com>
Date:   Wed, 3 Mar 2021 14:23:31 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
In-Reply-To: <20210302171947.2268128-14-joe@cilium.io>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2620:10d:c090:400::5:94d2]
X-ClientProxiedBy: MWHPR22CA0010.namprd22.prod.outlook.com
 (2603:10b6:300:ef::20) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::1a32] (2620:10d:c090:400::5:94d2) by MWHPR22CA0010.namprd22.prod.outlook.com (2603:10b6:300:ef::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Wed, 3 Mar 2021 22:23:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49c57179-4565-479d-897b-08d8de92fc2c
X-MS-TrafficTypeDiagnostic: SA1PR15MB4739:
X-Microsoft-Antispam-PRVS: <SA1PR15MB473962ECCF49773199338BB4D3989@SA1PR15MB4739.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: StuggWwbzPXY57wfvQtVisNAC08+5gvjaR4dnTB80NaNOh87s+3slf4M4ek4GgkAAzcFvjbL7hJwYq7+/TTvGk3lx/rZaj1G1yOtIgXEsZcWOaWrPM668c1Y7cmUiOfK8bbwOU+r2ztO/JGnroeC55kx18/yBHqOpXE7/SK5IweVEn6yERfI1EkL0dpHsqqIVQ1cCBTj4PQ/5Tp4siE7PRtxm10+2XPWuB+Ek2jUvHoHI17jXMA1HU+lgmLQNkxsWMPdhr16WAet+vVS8v/qQmPQJmOcQ4f0UuIRTgniz4BEyK30TWNcH0YYNvyXnr1pYfHr3OHc7eeGlVsgRJEyQA4dVetFV2rHgZMGyVNGzFK7YFVOIYATrm33VEfEwP0FQ2RcBtMV5AOEZANKk2Y37yInTFAL5fdY8+z03OzPS6PcHGOd9viOiX5jmn18lycB3iTiSVNhkjaMn/bSB2MhIpdTmab+c3oKtkWYvrbqYVJfmorBfFGkhGhDhil4XH9Rnfz5q83KqkfS9nZxz8dA9UYxnpEKR2hy86vgwO9XoECAKlHjFccpFh/xrWYb5FtBnZNHQqjDqK+BGfAOoYNUiRnjVx8HDqoR2QIOm1oUY7U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(136003)(346002)(376002)(396003)(66946007)(4326008)(66476007)(8676002)(66556008)(6486002)(2616005)(478600001)(6666004)(316002)(31686004)(86362001)(66574015)(54906003)(31696002)(53546011)(2906002)(5660300002)(52116002)(83380400001)(8936002)(186003)(16526019)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MzZ0Q0t6MDZwYURCL1pGdmY2Z2NUVm93OXU2YUw3N3hUSmJlK2Fka1JKbEph?=
 =?utf-8?B?SW9KT291NFJFaDBqKzErS3JmeWtZMDA1TVVMK2FGM2NHMm1jNmJIQjg3WFZx?=
 =?utf-8?B?SEEzQVlDV3l1Q1ArWS8vdHlBTzZtK0kwcHVSUkQ1K0tpSUk5N1UzSlZlR2Fz?=
 =?utf-8?B?K0JnT0NEazI0Z3I1UzQ1aGpZdWlpL1NOSnpOQy85SjJDdHRoOE13dlZmVkF0?=
 =?utf-8?B?VGZaK2pzWjBmbjk3OTV3NnI5YlgwTnhBU3k1dU1iYzEvRmF5WFBKVU9iQjBu?=
 =?utf-8?B?K1VxeUdFNG53SEZ5RnpLelVWUnhKVWtLUlgyd3Zwdjd3bTRDb21hdTE0ZG9E?=
 =?utf-8?B?TFVGRzRVdGcwQWU3VFdYM2p0bEl4YnYwcjNmOUVPME9MYnFVQ1IrWUtDWk5C?=
 =?utf-8?B?WWN0Ny8wK21oYnAwNFE1SkhhU0tIVU5qVW5UVGxkUStaVGw0Tm5qV0tjZHk0?=
 =?utf-8?B?WnBKNlkrSnBLczJrOStBcm44eVRWcUpkN3dibnpLaWozTFQzZXdFRUZKSGVB?=
 =?utf-8?B?UWQ0dS9nVE1VR09uYk9xYzYyakxnclZxQmJFcHFjT28rOHFHeEIzaENMYVNi?=
 =?utf-8?B?bDJKSzJ0WWNsYzRRY3QxRmpURWpjUzZqL0FBMHdJMFZTWFpHVFhiMEd5bUVT?=
 =?utf-8?B?OEtFRjE4b2duQU1kZ0hBU3Q3amUzYnNIYVJHUHJXbWF0eDF2THYvQXRWQzcx?=
 =?utf-8?B?dHJmMEp3cldVaXhHYks0Y1VIY2hLSWk4azdzUks4ZGFzOXVFTktBV2pPNmlK?=
 =?utf-8?B?SHhTV3FJZ2hnd1NqaHl4SXVxK0psdE1iZnNJa1RwRlp6RHNEaTBZTjI0MHkw?=
 =?utf-8?B?eXBDOTcxSXRPVlU2MnJxamJsU3hNaTZGZmRpdE14cFYxSGhicGlUQnc5TGc1?=
 =?utf-8?B?TG1wdzJBYkF5cEt5VlhKRmd0dFA1MVlDSGY1QUNxNTBta3B2UElKMXhBaFIr?=
 =?utf-8?B?ektOYTI4V3ZiK2NZdFQvb2RrVUdFd2NoRnhNSC9zd3EyVEJrQnFMUzhqWUl5?=
 =?utf-8?B?V0pUbGRvRDFCSHFTWm1UcFVlOXJjM2EzazdPQmVNcnpEVWI3N2Z4UUhGK2V0?=
 =?utf-8?B?R09YcVlMZnFkVXY2d1N5eXBMZEVFQ1VjZ0YzUXhIbmR1RUxsRmV5b25XZVdR?=
 =?utf-8?B?R25XSE9GV293Nytra1RHc0R6M09pd0xKaDBqNzVXWm96STErUzhhUnJxWVgy?=
 =?utf-8?B?akJXL0lzdExPQ21tNU8vZy9scnNnQzJyV24rcHlVd0lyMk4wZ1lxYlk0MUpI?=
 =?utf-8?B?V1JSUzloQTkra2Nad1FjOXV5eXZvb1I5dGVVWDlEVUF0NUhpWDIrU3RkRWZt?=
 =?utf-8?B?THlpRUV6TElRRUFldEdrV0JWZUN6amV5ZENjVE85UXhIbTVxK3VtS2R4NWpY?=
 =?utf-8?B?L0I5RlpNcTVCbzc5K1hGajBBR3Y2REdHbkFoeFlvU2UzRDRRVlkyc2ZCY3cv?=
 =?utf-8?B?aHZzQmFSTkZ1RUlhN2c3eVMrNDlNQk1PVmYxZG11Ykl5TWhOUGlxUUF5NHY2?=
 =?utf-8?B?cEhCSEloZ3BiWWJiajh1bTZSbFRnNm9ONjJKRkxxN0xOeG9pbnh2bUhYR1Fl?=
 =?utf-8?B?b3lzNSs3bjc2MFNKSmh1d0RwYWE4NzROc1YyL3Yrak4rbjNnK3NLeXBMSVhX?=
 =?utf-8?B?RHl0QURUb0ppUFlFRHE4N3pXdEx1VE5HaTAyQ3RGd0pML3dJenJqTmQ3Q3J6?=
 =?utf-8?B?aEovK3E0RFpkZFRoL3B3TDRxYkNSSzdEeERVb3ExNktjNHNZdmcrRzVPWEha?=
 =?utf-8?B?bjUzTncwQ2FHaUc1dWF0ZWtqNHhwcGNLRWRlSzByWEM0aWJsMHgrTHd1T000?=
 =?utf-8?Q?u32Gfg+0aKdLQyC//Cxb+ID742ODmCofqTQ34=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 49c57179-4565-479d-897b-08d8de92fc2c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2021 22:23:35.1703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D/e+nxTgeNIgp0XhbuF7DthWJsfrQzzP5DXir4EkpEqrIi+htIAsaCvZi/fsV/Z0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4739
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-03_07:2021-03-03,2021-03-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103030159
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/2/21 9:19 AM, Joe Stringer wrote:
> Add building of the bpf(2) syscall commands documentation as part of the
> docs building step in the build. This allows us to pick up on potential
> parse errors from the docs generator script as part of selftests.
> 
> The generated manual pages here are not intended for distribution, they
> are just a fragment that can be integrated into the other static text of
> bpf(2) to form the full manual page.

I tried and the generated bpf(2) man page looks like:

BPF(2) 
 
                          BPF(2)

NAME
        bpf - Perform a command on an extended BPF object

COMMANDS
        BPF_MAP_CREATE

               Description
                      Create  a map and return a file descriptor that 
refers to the map. The close-on-exec file descriptor flag (see fcntl(2)) 
is automatically enabled for the
                      new file descriptor.

                      Applying close(2) to the file descriptor returned 
by BPF_MAP_CREATE will delete the map (but see NOTES).

               Return A new file descriptor (a nonnegative integer), or 
-1 if an error occurred (in which case, errno is set appropriately).

        BPF_MAP_LOOKUP_ELEM
...
        BPF_PROG_BIND_MAP

               Description
                      Bind a map to the lifetime of an eBPF program.

                      The map identified by map_fd is bound to the 
program identified by prog_fd and only released when prog_fd is 
released. This may be used  in  cases  where
                      metadata  should  be  associated  with  a  program 
  which otherwise does not contain any references to the map (for 
example, embedded in the eBPF program
                      instructions).

               Return Returns zero on success. On error, -1 is returned 
and errno is set appropriately.


Yes, this needs to be integrated into the real man page. But this is 
already great so people can see latest bpf latest features without
going to the source code. Thanks!

> 
> Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
> Reviewed-by: Quentin Monnet <quentin@isovalent.com>
> Signed-off-by: Joe Stringer <joe@cilium.io>

Acked-by: Yonghong Song <yhs@fb.com>
