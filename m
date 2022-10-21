Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF59B607CB9
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 18:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbiJUQvg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 12:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbiJUQv2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 12:51:28 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC93927D4FD
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 09:51:25 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29LEItMg007430;
        Fri, 21 Oct 2022 09:51:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=k9w6yt10WmNbqxXXzQC4e+fQSABEpZjZRVUQVykGtW8=;
 b=ieX0nWFixeOmDZZiFGxWI9NUlCRfKjkZ05SxH1xfcOAK5JRp0eLEIvXgxHbsPCAi55OW
 +8368189YnSmjPg7rRIYbBYpQ6h9DCZaQJdH8v6opTKVcfOkAFXiDcpRdGgx9ILpQ0oi
 AhwNXsdzsDUNjdWnvuyLBlGUb7RIP3oj89yb1TRZaeP4jdaaZbcZay6Cw/en+1fgOWXa
 bKlLfXFR/B/MwikvZ+RdF73H/FTZI/vJKfzgwwp78gsMI68aSfTEfyhyf5uMSGzQ9LAH
 URbmgkAT7ed97yNftujTtXIL87kAzTBfrHWfkRzLO0zXPVmTFL5LWMGznNMxmHYgcrDd 7A== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kb799mwxk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 09:51:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4lAjnPXwGL5rmeggKaZxlAyj03oG6Z8/t5jDeauTtb8yxs0Ss26EcEResBhEvA95dAEpT13/66cWZQoQ0YJmbnBvspDkzXPhst+Ho46Md+OfI5odIRr4Aip0T8t8th39B4CIvxpF7gEe1ScKfhjtDZowPuBafYw4FCuBsdLNe7b1zlEDSEBiNY6h8v2AMAIcI+W7O3CawuZ2ekno0SYWjEuw90Mlv+OzmKC2wyZpsv5MD1O1H+U6qVEMYMrJ2+2p6OMn/Ce0D+h1uf/XJZ9YuTlgraMh83Dl2yYYaI1Fs4n1eN/U2G/y/nZ9523m/NKOQ/IQcBfBCSGk30kQ2YeAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dv65zGPhDW86AdyOF0iaszmn+qMUjAheKHa+r0ttREs=;
 b=DjlaxoRgjE6vM7Ao7pKk9vL02AlGUBZuPWYJEqsJ8tKbVFQI/2up97TTIIjxjGGIhupHP8rbM/yaP5TSdTMZ8xlt03tY5PWfcUrZC6R6k5uhkXp4xYbfj1NBgOYCXqdVHNLY5Me7o+y06OQkKHs4YqQm3ISr++/CyXxEINf7HO+cSS5k6vLPVI9ZFKA6MZozOU4Uzu+3ZURFMR52Mtd4GeyHpqFCdV72knwnQdJgtauaKvR8C9vPYrqGeIxCH6UcTEWElffm/bnDx3pv3oKAQuTpYm4AloIrSHT/3xUGG/kDmq1sZpOhL2ggqxmmejafXGhUw7nqRK5MWufehUpD7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BYAPR15MB3446.namprd15.prod.outlook.com (2603:10b6:a03:109::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Fri, 21 Oct
 2022 16:51:05 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::6e08:a405:4130:f36e]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::6e08:a405:4130:f36e%6]) with mapi id 15.20.5723.036; Fri, 21 Oct 2022
 16:51:05 +0000
Message-ID: <b31025c9-80da-86c6-ee2c-0c4acf5f2bff@meta.com>
Date:   Fri, 21 Oct 2022 09:51:00 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH bpf-next v2 2/6] bpf: Implement cgroup storage available
 to non-cgroup-attached bpf progs
To:     kernel test robot <lkp@intel.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>
References: <20221020221306.3554250-1-yhs@fb.com>
 <202210210932.nHqTyTmx-lkp@intel.com>
Content-Language: en-US
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <202210210932.nHqTyTmx-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: MN2PR13CA0016.namprd13.prod.outlook.com
 (2603:10b6:208:160::29) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BYAPR15MB3446:EE_
X-MS-Office365-Filtering-Correlation-Id: 50b70bec-919d-42a2-287d-08dab384718f
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P2vgy+ZGBbdUn8HiNuua102WbYFD6EwCV36ygqVaBtkYS61aHrxg+faLtTpvybzwPw2SxrC15rNHmbQnbExpjlOjS7uUbdNFDl89Z1LfL7uPGO3+cqLhoO5nq2+magiAqCvnla2jAtJrRC2J7Z/wJbCX7p/PRi678lF9fkYQF8lcQkrJhQgQqEMSLW4W3Kdg4BixFIWLG9UUaDXUblwhy5C7h5axHaH2wt31wHvQgS1ottOvOTYDIyHQDSmgdizyHzVaqpjTHvrb3qOPEgMOI9J5pOUf/jS682SlYFdPjTnIiQa0VfX++QEmQpcfkkSzvweQu/KwhWkeArvKnBztd+3j7Ezrc3qBHOq+yC3AZyZEO73LCnr9c+nNyC/mV1HZlBsCHtDTlODYEHtmSfwUynpglhDpkF6A/mSUDK5jTTrbLJ4wSTlAqpck2eGUizhiQ38iHtQjzNWdS+pmRSw1K4wrqOc+7e4AHALpqhCvyvs2LqVFZvhBkIiPRgxdJQItwDjEjCfz7SiHIeOcu1IqMy5wP/S4wbPISFIMx9K+eTgquvq328oebC8uS8CZk0HnZmSo9kS+EUIB//crGlVJevM1ATASoJJeZtBI9NyVzvj5Eo4AXZtMm/O+lI9u1mqQd2NnlBJZJb5J665BWjvJnhASHFYMjh+m3Pg2yRg9ZkyidH3AN0jmdCcJeYQO6ZVqVUf6+1aR8kpeaM3jAVntYEPZ0vkvHrZVsZTDsli04rT5zXOFdfdFSx3+M7gfU01kWjawkvasgzQYI/r3oPg3knKY9qcEUJg7CmEYLK3GuepvvKl5rugwXCkOifjweFDJWbLABLbgHUpxZtMoQYyBu0/PBiuDnM00otWfcxXk+x0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(366004)(396003)(346002)(451199015)(6506007)(41300700001)(36756003)(31686004)(86362001)(38100700002)(83380400001)(66556008)(53546011)(2616005)(5660300002)(6486002)(2906002)(6512007)(6666004)(478600001)(66946007)(31696002)(966005)(8936002)(66476007)(54906003)(4326008)(316002)(186003)(8676002)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjJIK1prVjd2YUovcjVNeVYveWdvVmZSV25wVWhnQnErWHJiMEpaSmNzV01D?=
 =?utf-8?B?MTd4ZFpKSU13YUR4dU1EMWtRTE0wRXdwczlpUnpkVnZGam5MMnZ2KzkxM0ZW?=
 =?utf-8?B?L2ZScGE2L1RXOXBYNUV3Q1dubnVzQWVTYjJHQkdkNHRoS24ySWtPMVJjdVhq?=
 =?utf-8?B?Y1dRRXllUXZjSXdhZng1OHB2YjRmVG9pc0l0K2tGejNxWHU5SStpL0JZdjZH?=
 =?utf-8?B?VUNuRWRiaEkwTm5FWjJmd05rNmJCUitGV1pjaFFyQXppY1VKSUdOVGQ0Q0Nq?=
 =?utf-8?B?MGNaaXlVbTRlSDRIdGRoVHMxOXFjV0pmUzFYMkdINUtvTG5LY0VxTXc2MzdL?=
 =?utf-8?B?c3REYlRWREx2dVYvVkJRTlQrZE1TMHR6YjY2L0pKOW5wR2hjKzZqZTk4dXhH?=
 =?utf-8?B?ZjV3VGk4K3c3UHJ2dmR5Q1duK3EzaDhGOVFJL24vWC8zb0lwU1J1dFF2VnhO?=
 =?utf-8?B?UWNreTF2aUc0SDN4eDJsNU1WSVBteTdINXF5ZDhDeFRpeHVXQ1NFemdDTG9N?=
 =?utf-8?B?aEo2WjBrSHRXT0FTWW1IS1RXTW1QbUdwbW5zTThYY0NrdmgrZVhhVGxTRXI5?=
 =?utf-8?B?V2JTd29WNGp3OWF0VDd1L3Y4bVhweHVXeUo1eFJTTHp3OWl4QlhXb3JHNFF3?=
 =?utf-8?B?M21TNlhHdUJ1Y0dmTmc1Tkd5RkRud1RMSkI0STlRcE1CTmV2TmduYm5CVzVk?=
 =?utf-8?B?SlMwQjJZRFhKQWE0RjMzMjNBK2ZjazY4RFZmMWF4aFBLSWkrb3B5NFc2OHdF?=
 =?utf-8?B?Y3ZhUGZUNTJSenFiWGNVNlZwR2JYcWsrcDdlZnZ2VnlkYklsQWZFRXJ6VnBr?=
 =?utf-8?B?OUY2cFNxdWhxMmZHQTVUUks3N2tOdTNxaFJZQVlnWXdVaWh5ZS90eGRZVDk1?=
 =?utf-8?B?T0RJNjJJMEswQlFYaVN2QW42MzZTN0lJQXlFOENqM0M4aWl0ODhZWWpGM1dm?=
 =?utf-8?B?a3M5U0szSzEyQUd0ekhvZ0owejVrMjAremREeVEzeVZEck03NXdzTURWR2kx?=
 =?utf-8?B?MXJKS0F4TnB0anh1bGp6bWpMdDhKZE5zbWcxcGhiVjJVTmJjUkxWc2lTc29a?=
 =?utf-8?B?bmFzcGE3Q0Fyai9IY2ZmanBuelNaTFdaNlZIc25ZN2ZJQ3piYXFBSVVrcTZ0?=
 =?utf-8?B?WlpwbFJEVW1DaHREVXo1S2pMT24rSjJ6bnBqclpIazFiUk1uSktJYnpVYTls?=
 =?utf-8?B?bWpGNW91ODNUY3VFUStROGlnbEJVNnVQRmVOeWxUS1h1NU5hbitIeXR4V0Jy?=
 =?utf-8?B?dnFnUEg1NUlWWTZwVFdUd3l4bE1IT1BtL0xTZWNSRW40TVBKY2d4STlub25B?=
 =?utf-8?B?d09nbWVwUDFjSFRyYmEzTUFnOWJVL1lZay9mcVJCZHcrUzVXbzN3ZWZ3MUkw?=
 =?utf-8?B?M25sUnR3MHFrY2NFek5TY3VKRnY2VVlEOEhDY08zNy9sb1FjMTU2MFlZandT?=
 =?utf-8?B?OVIzVWYvMUJOUGpIM1VSVXM5MWNQUHhPVG5oUUVhc3pvZFJSUXFRRitSZXBi?=
 =?utf-8?B?WnhYZVpCT3lVYnpTbTk5R2dMd1kyNWFiWEFDMm5kNXgwYjVTREhyaWpOYmxz?=
 =?utf-8?B?OWJGdDJkQ3FaOHpIeXJvbDBNc2t6QkNmT0F2azNqRG9OdWQydUJuNzFpWnRk?=
 =?utf-8?B?V2hWS1J0QnhNVjdVcjFlL3ArZTlPTjN0dW1wTUQxdWFCVjhmN0ROQzNKZFVl?=
 =?utf-8?B?WWxUam9qazdOUXpDU2YvZ2dzZVBnaDlRTm9UdFg2VTdKZ1dJMW1Vdzg2SHp3?=
 =?utf-8?B?eHVhNnBNOXo3NHhsZDBHMEc3ODVqeTUraXBmb0hPenhpQ2QzbWE2UFNNcmpw?=
 =?utf-8?B?L2x3a2hBTEU4UVdXSjBVbzhpemdVaVBub3RidDN6b2pTS0N3UVMwd2hlRkVJ?=
 =?utf-8?B?RCtZWHRtOHo2RGs5Y3RpMDhTcGdvSDNWTTBNakxYeXRqRTFDNHFtMlZQcVFn?=
 =?utf-8?B?cXJEeTVoWlUwekg1ZWhWcGJYdFVyRTVqS2Z4VjN0MGZVNUNqV3U3YlVjRFNC?=
 =?utf-8?B?NVQ5T1Z6dC9yRGFhdng1dFpydUtNRmFPT3lxZzdlbTYwRnEyeFhCWjU4TXEy?=
 =?utf-8?B?TThLdHB4dHMzSTN5NHRlT2pnMnRVTEp2Mm9ZdlFodVQ2ZmF2c21DdjRFMXUy?=
 =?utf-8?Q?dUA0ULAY6e3gw3/TDMuX9WCPm?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b70bec-919d-42a2-287d-08dab384718f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 16:51:05.0015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kuoZFDaHR5NQLe9xvKNFbV4u5xRYUlXCEminC1jGsIeWOmjJl+RiZG8Qt05dXU7q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3446
X-Proofpoint-GUID: q2OJkZg_ABMMzhRzejuoJkmPP6mwQHr0
X-Proofpoint-ORIG-GUID: q2OJkZg_ABMMzhRzejuoJkmPP6mwQHr0
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 10/20/22 6:29 PM, kernel test robot wrote:
> Hi Yonghong,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on bpf-next/master]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Yonghong-Song/bpf-Implement-cgroup-local-storage-available-to-non-cgroup-attached-bpf-progs/20221021-061520
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> patch link:    https://lore.kernel.org/r/20221020221306.3554250-1-yhs%40fb.com
> patch subject: [PATCH bpf-next v2 2/6] bpf: Implement cgroup storage available to non-cgroup-attached bpf progs
> config: mips-randconfig-r021-20221019
> compiler: mipsel-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross   -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://github.com/intel-lab-lkp/linux/commit/444d94c5601ec8650f49598c284571e1bc81a43d
>          git remote add linux-review https://github.com/intel-lab-lkp/linux
>          git fetch --no-tags linux-review Yonghong-Song/bpf-Implement-cgroup-local-storage-available-to-non-cgroup-attached-bpf-progs/20221021-061520
>          git checkout 444d94c5601ec8650f49598c284571e1bc81a43d
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash kernel/bpf/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>     kernel/bpf/bpf_cgrp_storage.c: In function 'cgroup_storage_ptr':
>>> kernel/bpf/bpf_cgrp_storage.c:43:19: error: 'struct cgroup' has no member named 'bpf_cgrp_storage'
>        43 |         return &cg->bpf_cgrp_storage;

I used CONFIG_CGROUP_BPF to guard this field in cgroup-defs.h.
But it is possible that CONFIG_CGROUPS=y and CONFIG_BPF_SYSCALL=y, but
CONFIG_CGROUP_BPF=n.
I will change to guard the bpf_cgrp_storage field in cgroup-defs.h
with CONFIG_BPF_SYSCALL=y and it should fix the issue.

>           |                   ^~
>     In file included from include/linux/workqueue.h:16,
>                      from include/linux/bpf.h:10,
>                      from kernel/bpf/bpf_cgrp_storage.c:7:
>     kernel/bpf/bpf_cgrp_storage.c: In function 'bpf_cgrp_storage_free':
>     kernel/bpf/bpf_cgrp_storage.c:55:47: error: 'struct cgroup' has no member named 'bpf_cgrp_storage'
>        55 |         local_storage = rcu_dereference(cgroup->bpf_cgrp_storage);
>           |                                               ^~
>     include/linux/rcupdate.h:439:17: note: in definition of macro '__rcu_dereference_check'
>       439 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
>           |                 ^
>     include/linux/rcupdate.h:659:28: note: in expansion of macro 'rcu_dereference_check'
>       659 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
>           |                            ^~~~~~~~~~~~~~~~~~~~~
>     kernel/bpf/bpf_cgrp_storage.c:55:25: note: in expansion of macro 'rcu_dereference'
>        55 |         local_storage = rcu_dereference(cgroup->bpf_cgrp_storage);
>           |                         ^~~~~~~~~~~~~~~
>     kernel/bpf/bpf_cgrp_storage.c:55:47: error: 'struct cgroup' has no member named 'bpf_cgrp_storage'
>        55 |         local_storage = rcu_dereference(cgroup->bpf_cgrp_storage);
>           |                                               ^~
>     include/linux/rcupdate.h:439:38: note: in definition of macro '__rcu_dereference_check'
>       439 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
>           |                                      ^
>     include/linux/rcupdate.h:659:28: note: in expansion of macro 'rcu_dereference_check'
>       659 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
>           |                            ^~~~~~~~~~~~~~~~~~~~~
>     kernel/bpf/bpf_cgrp_storage.c:55:25: note: in expansion of macro 'rcu_dereference'
>        55 |         local_storage = rcu_dereference(cgroup->bpf_cgrp_storage);
>           |                         ^~~~~~~~~~~~~~~
>     In file included from <command-line>:
>     kernel/bpf/bpf_cgrp_storage.c:55:47: error: 'struct cgroup' has no member named 'bpf_cgrp_storage'
>        55 |         local_storage = rcu_dereference(cgroup->bpf_cgrp_storage);
>           |                                               ^~
>     include/linux/compiler_types.h:337:23: note: in definition of macro '__compiletime_assert'
>       337 |                 if (!(condition))                                       \
>           |                       ^~~~~~~~~
>     include/linux/compiler_types.h:357:9: note: in expansion of macro '_compiletime_assert'
>       357 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>           |         ^~~~~~~~~~~~~~~~~~~
>     include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
>        36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
>           |         ^~~~~~~~~~~~~~~~~~
>     include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
>        36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
>           |                            ^~~~~~~~~~~~~
>     include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
>        49 |         compiletime_assert_rwonce_type(x);                              \
>           |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     include/linux/rcupdate.h:439:50: note: in expansion of macro 'READ_ONCE'
>       439 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
>           |                                                  ^~~~~~~~~
>     include/linux/rcupdate.h:587:9: note: in expansion of macro '__rcu_dereference_check'
>       587 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
>           |         ^~~~~~~~~~~~~~~~~~~~~~~
>     include/linux/rcupdate.h:659:28: note: in expansion of macro 'rcu_dereference_check'
>       659 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
>           |                            ^~~~~~~~~~~~~~~~~~~~~
>     kernel/bpf/bpf_cgrp_storage.c:55:25: note: in expansion of macro 'rcu_dereference'
>        55 |         local_storage = rcu_dereference(cgroup->bpf_cgrp_storage);
>           |                         ^~~~~~~~~~~~~~~
>     kernel/bpf/bpf_cgrp_storage.c:55:47: error: 'struct cgroup' has no member named 'bpf_cgrp_storage'
>        55 |         local_storage = rcu_dereference(cgroup->bpf_cgrp_storage);
>           |                                               ^~
>     include/linux/compiler_types.h:337:23: note: in definition of macro '__compiletime_assert'
>       337 |                 if (!(condition))                                       \
>           |                       ^~~~~~~~~
>     include/linux/compiler_types.h:357:9: note: in expansion of macro '_compiletime_assert'
>       357 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>           |         ^~~~~~~~~~~~~~~~~~~
>     include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
>        36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
>           |         ^~~~~~~~~~~~~~~~~~
>     include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
>        36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
>           |                            ^~~~~~~~~~~~~
>     include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
>        49 |         compiletime_assert_rwonce_type(x);                              \
>           |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     include/linux/rcupdate.h:439:50: note: in expansion of macro 'READ_ONCE'
>       439 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
>           |                                                  ^~~~~~~~~
>     include/linux/rcupdate.h:587:9: note: in expansion of macro '__rcu_dereference_check'
>       587 |         __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
>           |         ^~~~~~~~~~~~~~~~~~~~~~~
>     include/linux/rcupdate.h:659:28: note: in expansion of macro 'rcu_dereference_check'
>       659 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
>           |                            ^~~~~~~~~~~~~~~~~~~~~
>     kernel/bpf/bpf_cgrp_storage.c:55:25: note: in expansion of macro 'rcu_dereference'
>        55 |         local_storage = rcu_dereference(cgroup->bpf_cgrp_storage);
>           |                         ^~~~~~~~~~~~~~~
>     kernel/bpf/bpf_cgrp_storage.c:55:47: error: 'struct cgroup' has no member named 'bpf_cgrp_storage'
>        55 |         local_storage = rcu_dereference(cgroup->bpf_cgrp_storage);
>           |                                               ^~
>     include/linux/compiler_types.h:337:23: note: in definition of macro '__compiletime_assert'
>       337 |                 if (!(condition))                                       \
>           |                       ^~~~~~~~~
>     include/linux/compiler_types.h:357:9: note: in expansion of macro '_compiletime_assert'
>       357 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>           |         ^~~~~~~~~~~~~~~~~~~
> 
> 
> vim +43 kernel/bpf/bpf_cgrp_storage.c
> 
>      38	
>      39	static struct bpf_local_storage __rcu **cgroup_storage_ptr(void *owner)
>      40	{
>      41		struct cgroup *cg = owner;
>      42	
>    > 43		return &cg->bpf_cgrp_storage;
>      44	}
>      45	
> 
