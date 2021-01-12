Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA552F28E1
	for <lists+bpf@lfdr.de>; Tue, 12 Jan 2021 08:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388822AbhALHZo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jan 2021 02:25:44 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:28006 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731337AbhALHZo (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 12 Jan 2021 02:25:44 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10C7EQUn001772;
        Mon, 11 Jan 2021 23:24:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=vz3ylnmm4FLeIysimoGvSTRLkS58QFX75SrzRZBlcBk=;
 b=EYMxj1z0qPfMCgNITTzAnOEi9SoJxwAXn4J7OKrzGcG+LU65E4S+iUDbSLqP3OxNaECn
 aMA6/Xr4B8uCwubirOrFRcn6ShTyCZ8t0ySi8rYYAe5lVUSfG3tbtHRi2ZjfNeaiyEqN
 5abareWnjNhCri7xLyOH2A3vncuFpCjGet0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3613ytgpf6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 11 Jan 2021 23:24:48 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 11 Jan 2021 23:24:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q606u3bLtasysIgtLJVpMbyNijt0HtPpSQvLLfc20ajlyV4VXW4Nsy/6CF8H5yv9MBx6xnMM6rCfhDlBRRxh/sph3Xq3FBMG5m0NOc84bLyZNfTLxN+X43uY3CnLI2Mp5mCXVqI2AiqyoGJFU04sZ4YoG/aRJVsH4gxdM0kkqvfHfJvBll/mw9IQGFB4ShoD6tBQT8rYsW/HZlhIHUfgMTVDyqbYGlC32FgsN5gE/eDg5dq7ABoQMzUi1jm43p55XWpUFcruCFp/ux1Ph3VshwcDZwqQMgycQujaWqEpEIWm9dKaheIVwRGoUZDsJ1xl2b2I4Pr8/y9xIW9iW34x8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vz3ylnmm4FLeIysimoGvSTRLkS58QFX75SrzRZBlcBk=;
 b=cRyTxsU0ZDMY6cxSzca8xZrsfTss76aEgzt02lqAYJHy6Obs9jVW61lYnG+39ag98yLeuzhuIeXwu4iBlR3PuREk5HQdTi8wo3NXM/m+IKU1KVpYnxszlW7HdIMqw2htdjuyVA1BDYlZbrgAnabZKyzVuap/hX1pBpqbO6Xxsee5pSZFG0rTR0PRHUrQq3YRI2pJR9WahdoXzSvojgmLetzrZZTrm8855kUgRRN6FetTelegT/B7/xROuvQOZneWsqmaggdUHDgI6vEvmmraeoHfbvN2oOVL7G+ImaazKj7L6T5wFMhUZ9XeskFGwT4n/9IaLxqmYCKZTLLZFXe2Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vz3ylnmm4FLeIysimoGvSTRLkS58QFX75SrzRZBlcBk=;
 b=Ndnrl8icGDw8Poyd5yiIC9NEGk0PVdFL/t4AwmYCW35F1vckcHuZIu1JBMWhMM3VFYIad+7HCobTASbQr238dxlO/QTKVb2BYQWrGgubsmoerF+Os/5/lPin7HIdxH4phJ66R05XGxEQ7pQvK4tNtGPxUDVCajjwnZ2QV3jruQM=
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BY5PR15MB3569.namprd15.prod.outlook.com (2603:10b6:a03:1ff::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.12; Tue, 12 Jan
 2021 07:24:45 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 07:24:45 +0000
Subject: Re: [PATCH bpf v2 1/3] bpf: update local storage test to check
 handling of null ptrs
To:     KP Singh <kpsingh@kernel.org>, <bpf@vger.kernel.org>
CC:     Gilad Reti <gilad.reti@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>
References: <20210111212340.86393-1-kpsingh@kernel.org>
 <20210111212340.86393-2-kpsingh@kernel.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <317e2cb6-3774-b343-d93b-5b6f1d41b97e@fb.com>
Date:   Mon, 11 Jan 2021 23:24:41 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
In-Reply-To: <20210111212340.86393-2-kpsingh@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:4443]
X-ClientProxiedBy: CO2PR04CA0160.namprd04.prod.outlook.com
 (2603:10b6:104:4::14) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::190b] (2620:10d:c090:400::5:4443) by CO2PR04CA0160.namprd04.prod.outlook.com (2603:10b6:104:4::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Tue, 12 Jan 2021 07:24:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5255b79-a4c8-4e6f-471a-08d8b6cb22f7
X-MS-TrafficTypeDiagnostic: BY5PR15MB3569:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR15MB35699B3818671AE98CD3D408D3AA0@BY5PR15MB3569.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UYGOk6Itj02WWkbcNVMGvTG4PcKGWataPPYtXfwYl67SZkU/9GydhQKrBWKb+kVj0dUAFZ94CGEPE27S1wOJckA1yq7ktaGwUNtGr8k8cagjoDlUNT8PhrYfug8FGzJA8SsyIuQIVgKfgtuo+ggq8RlyDsobUxWNe5V/SW7fjeW6oHkDmmLthsWdA2NP3D8E6nRY5y+c0d648hJIfaOWW77byPs3D8ocphpEAptygT5VsC8Sr9HD8tVY2DOjH9OBE1RGQEAsOt3RIqToN7odIfesl2oIG+BCz6F9JxS5wtufODwlx2OOJO1Jape+9V9rTcmDCNC8h0cDSxlSb8cqc63dlPNy/HMuCu8x3VrUkqDmrUbbVmmBY+OJNbyAXXRNV8dhuFSvrNLVqz83RLsMlbkUAa/Vd7pcnEraNt9CPzDwvU1JZAl3cmhjGsmZpskF36+VpkF6W93Gq/DEZRdyxtuZE9bTpIuRZ67UdYHytD6dGgU5E5bBRh8dBwi7M8i6O2KwD2C8zAOMyvOqE4nVFY4MT9plZ0TWTxnCvWJ7gjxvkV0e7uMpE0xMzL1MgR8x
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(396003)(39860400002)(376002)(366004)(8676002)(66556008)(4326008)(66476007)(86362001)(31696002)(478600001)(54906003)(52116002)(53546011)(31686004)(66946007)(186003)(6486002)(5660300002)(2906002)(36756003)(2616005)(83380400001)(316002)(966005)(6666004)(16526019)(15650500001)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NGFZNEg5WUEvenFqQnl2elJHQTJqZkRnUWFhS0xhRFl1c3gzRGtQa3pmdTlV?=
 =?utf-8?B?V0dVa1JJWktySTg1b3gvOXJjeWY1emQwQ0pNOCtROG95enJMbUowV2g0K0lP?=
 =?utf-8?B?RXV1S2tZTTZEQnZhRm9ETFFXeHdUbm1WczVhdE9oTmI1MnVGNjd2WFhtWVpp?=
 =?utf-8?B?UjJISGt5TjJPNFhTdHpuVlFDc1NMTFBEUXRobWVxSUpoTnp1bUhxUHZYc0N3?=
 =?utf-8?B?ZHR0eTFkdlJsVFFiN0FnWmszQ3NkL3Y3TUZxTm1jV0dlZ0dhUWcxT0hKN216?=
 =?utf-8?B?RGZMQW56ajVhMElKU1d4ZUhnOHZ6TG13ZFJJNU55U0JqSXhPK3ROWGlpRmdE?=
 =?utf-8?B?eURNRXM4Q09UdG9KUWhUWVhZbDZEVDRVSzg5RXdaVitQUEowaSttK0NsbGtG?=
 =?utf-8?B?QTRNRG9EaHZOOTgxbkwrcm81RlhFTTNRcExTaCtWcTE0bC9PU3kydlZOeG9O?=
 =?utf-8?B?VmNTekRyK0FSRkQrRnJId09IcDFoZklHdlBWNE9XWFEwalhHNTJEMG1JZEl6?=
 =?utf-8?B?eEs5M3ZJdWFkSE5LUDhxWnBnOEwyYkpHWVdsNE11RzdOdjRySzlKUE1HNzI1?=
 =?utf-8?B?Q3BmVS9ma056V1pINXRSTU5VeW1ZK0ZHK0RHLzlwM2hZQUNNSFJ1STU5UkUy?=
 =?utf-8?B?UU1kMm9uTEZvNDRpYTI4eVdUNUIvVEpXUjNrOGpFNzM0ZXQxa3pxK0FuS2kv?=
 =?utf-8?B?c2FCQlBXa1hnQ2ZTcDlXYmR5UzRMMG9TbHdmUUVjOC91U3ZTM0VTc29jTldE?=
 =?utf-8?B?dGxxZjAySUtyTURKWm1JT2JkbFRlOG9HdTZxdDdBTkNnellWYlVyZG53MVNp?=
 =?utf-8?B?eDA1K3NvRS83bWlacFVRZFcxa0Rja1N5cStxeW1qVkJweVFKSTdIV00xaWpk?=
 =?utf-8?B?c08vMVlXSiszaTlpaXdvSGQ0VnRZSzEydXVQVmQyVWwveUdZbUVvT2pMNk5I?=
 =?utf-8?B?a0tuaTJvektrR0I4S0VLY0E0QWw0RnoxdUhlT2FCeUlOS0dEMTVRblVFa2lw?=
 =?utf-8?B?blkwYVJsSEFaRWNTZTdNcEt6OUthRG5zTjVPVXpsTGROaGZEU25qZmYyeTFJ?=
 =?utf-8?B?KzgwSjBqc2ZjMlNUdnRNZTdidUdpSUg0OFBhQ1p2Z0dHa2c1SG5oUllmS3JP?=
 =?utf-8?B?akRMOWtPa1JpT28yd1I1YXlCbnFuYjRBWjFZVENGSDM0MFVIQTlKdzlwQ1NW?=
 =?utf-8?B?TWs0Zm42YVFFRzV1ZFlWY3VBK3VHUm4zQzFwdHVtRzRTM0JzUUhJVTc3c2lT?=
 =?utf-8?B?czRRNk96dkp2Y2NiK203SXRMVkZnTC9KdzRCcllyc05nV2tSZkZPTW1UdWRB?=
 =?utf-8?B?WDJWbEpzRm9MTUYrVHowZjZUZlFSd2FRL1k2RjhsNFdqamtnTk1Ka05tZmZ4?=
 =?utf-8?B?aGpETE9xMUtQUlE9PQ==?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2021 07:24:45.3322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: e5255b79-a4c8-4e6f-471a-08d8b6cb22f7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8+NXWP1K/5kSMe/wYenPs4XbUdcBQMGCeDBqLq+s9QDnLGhNikY5ZbgtgZeFRsqm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3569
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-12_03:2021-01-11,2021-01-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 clxscore=1015
 mlxlogscore=999 mlxscore=0 phishscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101120038
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/11/21 1:23 PM, KP Singh wrote:
> It was found in [1] that bpf_inode_storage_get helper did not check
> the nullness of the passed owner ptr which caused an oops when
> dereferenced. This change incorporates the example suggested in [1] into
> the local storage selftest.
> 
> The test is updated to create a temporary directory instead of just
> using a tempfile. In order to replicate the issue this copied rm binary
> is renamed tiggering the inode_rename with a null pointer for the
> new_inode. The logic to verify the setting and deletion of the inode
> local storage of the old inode is also moved to this LSM hook.
> 
> The change also removes the copy_rm function and simply shells out
> to copy files and recursively delete directories and consolidates the
> logic of setting the initial inode storage to the bprm_committed_creds
> hook and removes the file_open hook.
> 
> [1]: https://lore.kernel.org/bpf/CANaYP3HWkH91SN=wTNO9FL_2ztHfqcXKX38SSE-JJ2voh+vssw@mail.gmail.com
> 
> Suggested-by: Gilad Reti <gilad.reti@gmail.com>
> Signed-off-by: KP Singh <kpsingh@kernel.org>

Ack with one nit below.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   .../bpf/prog_tests/test_local_storage.c       | 96 +++++--------------
>   .../selftests/bpf/progs/local_storage.c       | 62 ++++++------
>   2 files changed, 61 insertions(+), 97 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_local_storage.c b/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
> index c0fe73a17ed1..338475fe9ffb 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_local_storage.c
> @@ -34,61 +34,6 @@ struct storage {
>   	struct bpf_spin_lock lock;
>   };
>   
> -/* Copies an rm binary to a temp file. dest is a mkstemp template */
> -static int copy_rm(char *dest)
> -{
> -	int fd_in, fd_out = -1, ret = 0;
> -	struct stat stat;
> -	char *buf = NULL;
> -
> -	fd_in = open("/bin/rm", O_RDONLY);
> -	if (fd_in < 0)
> -		return -errno;
> -
> -	fd_out = mkstemp(dest);
> -	if (fd_out < 0) {
> -		ret = -errno;
> -		goto out;
> -	}
> -
> -	ret = fstat(fd_in, &stat);
> -	if (ret == -1) {
> -		ret = -errno;
> -		goto out;
> -	}
> -
> -	buf = malloc(stat.st_blksize);
> -	if (!buf) {
> -		ret = -errno;
> -		goto out;
> -	}
> -
> -	while (ret = read(fd_in, buf, stat.st_blksize), ret > 0) {
> -		ret = write(fd_out, buf, ret);
> -		if (ret < 0) {
> -			ret = -errno;
> -			goto out;
> -
> -		}
> -	}
> -	if (ret < 0) {
> -		ret = -errno;
> -		goto out;
> -
> -	}
> -
> -	/* Set executable permission on the copied file */
> -	ret = chmod(dest, 0100);
> -	if (ret == -1)
> -		ret = -errno;
> -
> -out:
> -	free(buf);
> -	close(fd_in);
> -	close(fd_out);
> -	return ret;
> -}
> -
>   /* Fork and exec the provided rm binary and return the exit code of the
>    * forked process and its pid.
>    */
> @@ -168,9 +113,11 @@ static bool check_syscall_operations(int map_fd, int obj_fd)
>   
>   void test_test_local_storage(void)
>   {
> -	char tmp_exec_path[PATH_MAX] = "/tmp/copy_of_rmXXXXXX";
> +	char tmp_dir_path[64] = "/tmp/local_storageXXXXXX";
>   	int err, serv_sk = -1, task_fd = -1, rm_fd = -1;
>   	struct local_storage *skel = NULL;
> +	char tmp_exec_path[64];
> +	char cmd[256];
>   
>   	skel = local_storage__open_and_load();
>   	if (CHECK(!skel, "skel_load", "lsm skeleton failed\n"))
> @@ -189,18 +136,24 @@ void test_test_local_storage(void)
>   				      task_fd))
>   		goto close_prog;
>   
> -	err = copy_rm(tmp_exec_path);
> -	if (CHECK(err < 0, "copy_rm", "err %d errno %d\n", err, errno))
> +	mkdtemp(tmp_dir_path);
> +	if (CHECK(errno < 0, "mkdtemp", "unable to create tmpdir: %d\n", errno))

I think checking mkdtemp return value is more reliable than checking 
errno. It is possible mkdtemp returns 0 and errno is not 0 (inheritted 
from previous syscall).

>   		goto close_prog;
>   
> +	snprintf(tmp_exec_path, sizeof(tmp_exec_path), "%s/copy_of_rm",
> +		 tmp_dir_path);
> +	snprintf(cmd, sizeof(cmd), "cp /bin/rm %s", tmp_exec_path);
> +	if (CHECK_FAIL(system(cmd)))
> +		goto close_prog_rmdir;
> +
[...]
