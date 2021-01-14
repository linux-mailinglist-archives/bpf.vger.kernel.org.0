Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD902F6A41
	for <lists+bpf@lfdr.de>; Thu, 14 Jan 2021 20:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbhANS6t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jan 2021 13:58:49 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:30548 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726287AbhANS6s (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 14 Jan 2021 13:58:48 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10EIife3009921;
        Thu, 14 Jan 2021 10:56:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=rZv+jzu6sFvGuaxWb4xVpZ9UWPePj/XLijyNIZ0NNcE=;
 b=W8rG3ydh35LsaEcQhlSB3fFLYuLO9aebuipz4knCSXBpOHakgYy+FJR0HTCrvi2vovM4
 qjnmeMmCUvBzMmyJLvkBdvli61vko6XHXqRpRmlLWqrpd1RM2QKvb0GoB0us/4JbV6cp
 TMTtJAAhTPGYNYu/9CLanC+NjFu/UVGpIJY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 361fpumgwj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 14 Jan 2021 10:56:38 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 14 Jan 2021 10:56:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XGSIn5lNwOoKMGijXy8IPz09lpb0HUC1x/4V1vab6Kp9bBA9i6C2AYEmHhkpofre0DypdnapD9kBAPRd0Zwc/jqmpGVdbOPyVfZ/xclBfuU7JBxd61lYRBrIQNYPYi1UQs61bRM5PP3aWWwF+OPw1kKUyVuePcsRguOmNpsVPwhs1a2DpfTXjssday3dLAQ6+Kr8iYsN2mbq7U/wf7c7+OMovZeJZc60HUK8if0AQik4EdnETqbCJsSzvhEMyfwkUHzeTXX2Fmc7tcu2C5qMTyFgIbPAtSQ7mKnDkXVrCOp1nyHCxXrDRtYb//tTZFunUOOKmo5qDPcbSZwDRCS8SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZv+jzu6sFvGuaxWb4xVpZ9UWPePj/XLijyNIZ0NNcE=;
 b=YCdLIJ7y4MoyXX4F69WuABfQzIKUCeXLQOT3azS/Qqf75ghlybled4rh/v/lL34TyOJBmscAY3N/mI1vXgkGtFEjGTP24C/jTEWO0i1MKsebK91I8HqYtSoVQQ+LI5tF/CdnwzGiZCBKqxFWPeId/2Ootm+IPQMy/9WLNGy3J96Aua6wTmpuRo9S0n7dvueIX6TqrnkM1/ZNKQENYmqXER86/+QQbI0gZKe0S8VfRKhDgBCezv1NrQv24q6SwC+SvrhdYqdMatBI2XroKH/bnWmsWPfDKeyK5CY3oXlyRiBexZQY2sbUVALB0noO36IZKvLZoWFylC0G+buM1J5d/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZv+jzu6sFvGuaxWb4xVpZ9UWPePj/XLijyNIZ0NNcE=;
 b=AgjWUDl7Z7aQ0dpL2vLUCZ+B18y7mYvy2CeKBseaIgUKaKxAt4FyymkCgTcAz3+g4kMVhjwEIsfh+Wg2OCkE13A5/ZOq11UVBHLEMH03+dTeyx7shGJ7lYngPWTjMTJk9quQ/o+cgffHW+oNxtNP+MGK2hvXZ8SusYWmt5hKZvY=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2584.namprd15.prod.outlook.com (2603:10b6:a03:150::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Thu, 14 Jan
 2021 18:56:36 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3763.011; Thu, 14 Jan 2021
 18:56:36 +0000
Subject: Re: [PATCH bpf-next 2/3] bpf: Add size arg to build_id_parse function
To:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        lkml <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
References: <20210114134044.1418404-1-jolsa@kernel.org>
 <20210114134044.1418404-3-jolsa@kernel.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <19f16729-96d6-cc8e-5bd5-c3f5940365d4@fb.com>
Date:   Thu, 14 Jan 2021 10:56:33 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
In-Reply-To: <20210114134044.1418404-3-jolsa@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:ab59]
X-ClientProxiedBy: MWHPR10CA0066.namprd10.prod.outlook.com
 (2603:10b6:300:2c::28) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::13f6] (2620:10d:c090:400::5:ab59) by MWHPR10CA0066.namprd10.prod.outlook.com (2603:10b6:300:2c::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend Transport; Thu, 14 Jan 2021 18:56:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b8db0fa-3b1e-4d61-0e1d-08d8b8be1e56
X-MS-TrafficTypeDiagnostic: BYAPR15MB2584:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2584475838E78FC2991D0E4CD3A80@BYAPR15MB2584.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ou37/oZAOzVFhSg0E3hLAbdmRVYQ/a+zhJdsZNFORYmhKDztot7tlN0ejlSuaWmXfmvW7fB0yn5Y4+dhl2WwXzgl/YF26KSg50JcmKuPNFlubUEcN0D8C91KQuOuFT4tdH+ry4VRy1H3Z8LZlzlGkd69Re/ovsVV1omw2TDtfWl7izOxh7pNxVgSUKUFwztFprqx/On8n2MUNswTAJnKmylxw5NRKHbIyFaKWvtUzfUEd+R22dvOazISyASZxZNeFBXtGD/pfCM7TeWxPb5io4Ea0FfrcpBHpdksdRKH2DgEPgGZElcqwcddqsIW70tdOV2Yw9I+A37YCPUFWoAGuZGKZbBpfAcSryiqqTmnC6u8W/i1rMbQlzVrGvWSoTllUYcEjjQ3MV9EsTRrviIOiNVa//LlBY7EzWiZcAeI6RMtkphjPn9+NgxB9NaCUtLhMi2MS1++2StYuIWFRPno/9DJYRcP5SqaS2m3Cmwft7k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(376002)(366004)(39860400002)(346002)(8936002)(36756003)(31696002)(8676002)(6486002)(53546011)(478600001)(110136005)(7416002)(2616005)(83380400001)(52116002)(66556008)(31686004)(54906003)(4326008)(316002)(5660300002)(186003)(2906002)(86362001)(16526019)(66946007)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?AERAt7tH4d+xhOI/16NgbAfhWy7mkBhY42vRfO5gpG8xEjW7Kjh1NrWb?=
 =?Windows-1252?Q?tlRLVHBjCXTkvFRdXLy3Wl3C7idNCWi8KEwQhu0sESTauFwGxuSfLyPG?=
 =?Windows-1252?Q?2BDZbfy1LmnvFlx6omjSvcS1ZMMrsKmK+8syar0MFG3NJdPcpL+W/WR5?=
 =?Windows-1252?Q?RcR7yEEsOHRHi3XS/E777ED9q03XbliSLzoLH+58nzpc6u4JBLQ/szEt?=
 =?Windows-1252?Q?p8D58MpumDKunuRRzYVLbBaOsP/54isheb9cFx/3xk6sJarVH0gABQVk?=
 =?Windows-1252?Q?QsVgEDVcVzlNeLAiskjgsi+SsOSE1zW4oPPmuGcxx3jTMfyrnYxUKs86?=
 =?Windows-1252?Q?vvMc63KxLhrK9jpEDAp1g3KrF0ov69Dl9q6QzOTot2IgitJOCDzUrFfU?=
 =?Windows-1252?Q?V1sjJIvGh//lQHZHw7pIMaeHoxcuTSdJyH9TQRP1m9Hw1n5xtVqgmTf+?=
 =?Windows-1252?Q?qxlE4HQvf9439i+XGj/LA2YOfbx6VXJ/uZ9EkGfHTLopKmAsBchg6q+z?=
 =?Windows-1252?Q?lKz9crdFHNgMwOqa+OF6oSj+XrHAzGEh8uzWL6i1ZCehgiZlVuJJ6h9v?=
 =?Windows-1252?Q?WduPvoiE0rQssuUupCeFcOMVw3wAwT9/8JeXZaW4ZtB/JAxLJGRWE1UW?=
 =?Windows-1252?Q?PS355VQ6QjqaaqjkgwSkenkMnT/WHX7Aulwz9aXdCJvb/nyNWV4RjPVQ?=
 =?Windows-1252?Q?DyzQP4li+XquB1gOXK7sM4hxtjOdvJOtfpqtp2GXfXSpfKE5Q6tLffFj?=
 =?Windows-1252?Q?/Y5w44pi4iQrMm1Vaq0u4tkJOLTU4J8FFLzbGGUQiB6CAoM2y7a2EXqB?=
 =?Windows-1252?Q?2BiEmgEyC0LdT8+77gvApkDIlNmHzJyy/8y6Dra16BpyMb4h0PFZ4iiy?=
 =?Windows-1252?Q?513bcJ9mFohi/5f6XS5/jmDoUhU+QvEYP4B3iY4BGtwZUH93M/r40Gh0?=
 =?Windows-1252?Q?mAFKCGFAo/L6H1MC/w/+xTnOkL39Mr4SvmjQZqG9TPe+w+bNXz0s4ox2?=
 =?Windows-1252?Q?gADC9Up4gddjaN8oNtRIZUl/nt95gSTFHF18FDv0bPtviMxCB4wZ962B?=
 =?Windows-1252?Q?czq8dhN21Ml1cKk9LKBAFRDvk2KF85UaJnC7CQ=3D=3D?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2021 18:56:36.4538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b8db0fa-3b1e-4d61-0e1d-08d8b8be1e56
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T02A60MTI8dVHXRA5U+pvDB2mkde00OPu4R6GMX6nnkFdUESnJDbUytmGmUIBKFA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2584
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-14_07:2021-01-14,2021-01-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1011
 adultscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101140108
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/14/21 5:40 AM, Jiri Olsa wrote:
> It's possible to have other build id types (other than default SHA1).
> Currently there's also ld support for MD5 build id.

Currently, bpf build_id based stackmap does not returns the size of
the build_id. Did you see an issue here? I guess user space can check
the length of non-zero bits of the build id to decide what kind of
type it is, right?

> 
> Adding size argument to build_id_parse function, that returns (if defined)
> size of the parsed build id, so we can recognize the build id type.
> 
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Song Liu <songliubraving@fb.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>   include/linux/buildid.h |  3 ++-
>   kernel/bpf/stackmap.c   |  2 +-
>   lib/buildid.c           | 29 +++++++++++++++++++++--------
>   3 files changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/buildid.h b/include/linux/buildid.h
> index 08028a212589..40232f90db6e 100644
> --- a/include/linux/buildid.h
> +++ b/include/linux/buildid.h
> @@ -6,6 +6,7 @@
>   
>   #define BUILD_ID_SIZE_MAX 20
>   
> -int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id);
> +int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
> +		   __u32 *size);
>   
>   #endif
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 55d254a59f07..cabaf7db8efc 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -189,7 +189,7 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
>   
>   	for (i = 0; i < trace_nr; i++) {
>   		vma = find_vma(current->mm, ips[i]);
> -		if (!vma || build_id_parse(vma, id_offs[i].build_id)) {
> +		if (!vma || build_id_parse(vma, id_offs[i].build_id, NULL)) {
>   			/* per entry fall back to ips */
>   			id_offs[i].status = BPF_STACK_BUILD_ID_IP;
>   			id_offs[i].ip = ips[i];
> diff --git a/lib/buildid.c b/lib/buildid.c
> index 4a4f520c0e29..6156997c3895 100644
> --- a/lib/buildid.c
> +++ b/lib/buildid.c
> @@ -12,6 +12,7 @@
>    */
>   static inline int parse_build_id(void *page_addr,
>   				 unsigned char *build_id,
> +				 __u32 *size,
>   				 void *note_start,
>   				 Elf32_Word note_size)
>   {
> @@ -38,6 +39,8 @@ static inline int parse_build_id(void *page_addr,
>   			       nhdr->n_descsz);
>   			memset(build_id + nhdr->n_descsz, 0,
>   			       BUILD_ID_SIZE_MAX - nhdr->n_descsz);
> +			if (size)
> +				*size = nhdr->n_descsz;
>   			return 0;
>   		}
>   		new_offs = note_offs + sizeof(Elf32_Nhdr) +
> @@ -50,7 +53,8 @@ static inline int parse_build_id(void *page_addr,
>   }
>   
[...]
