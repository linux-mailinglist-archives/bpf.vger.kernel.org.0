Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17ED7621B4C
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 18:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbiKHR6l (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 12:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbiKHR6j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 12:58:39 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F1A1FCE5
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 09:58:38 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A8HnHI6003802;
        Tue, 8 Nov 2022 09:58:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=Cc/BZ3JNYNuxZ2kcK6CqqR94dLwvmv98Uds0IAHuKVE=;
 b=diPqJC/MRGjr9j9FDg4yBPB0xgA3qPmRRo/0hP++lpYQjl588+1v05rsMDCqcRyBCaka
 XBT5vpAq4WXWN11P4J0K2SqvUIwEtiB0Gt2R55vG90ipYVHAHMSQy8FBXrgyfGECiTEE
 MRX71wtJu3LJLGdwpG9IkvPJhoMM61t0TGm8yZawV0s2lNM6DzNzCF4jCu5GNAqGmAhU
 Mw9gSoqFyc5c8qUY7q0h+tOZYGHrMadENN16VETloWb6ebeqTcovjjJn9iw0DYeLdBsa
 6a403lKI/TgmqyBKhgA2VYKCMWLhls4RLqbGs/+J+wactuSseHgY0wN7eSJcqe9604Ur xQ== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kqj97mwyc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Nov 2022 09:58:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TgaialDWH6/z5UWSM0NBwXIWUmTduNW7dWHu4XpV9BuYus8QCQzbkLEgfuXD3o0L9Ava4FPfrIJJNBFrnaL0ymY+DDeep2n9QAv8KT5L+3YWx7yB2NZU//C0GnkI8hkTxMDwr/kVtMrp2UD4epoGazfqmV55mBxzu33AOIDB6xP6I/hUVLio2oihZkusmUD57Ka3bJlz1lwKrna3G1ztUVm0eb2IKpf9T+1QGf9vJVVtnOnEolSrroo6aPLDUF9EfJ4PV1Jr0BcWm4hh1qKVKzeIhlh2Y7pbdzbW/61q4DKxMRMf42Sz/jwhQI3wLaVDvLa/f5U002aF3su29tknAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cc/BZ3JNYNuxZ2kcK6CqqR94dLwvmv98Uds0IAHuKVE=;
 b=gt61rmmYrlr85Fx/vC3bEh8VR2g/er/JsuqYOY8U0SzQ/PDkneTpY2FkpgrqDPRh7nFeyzyF7gwh2DMSY3p9QmbHq4AV6f7OUz62rDbTg/YbP7IbM6zU7XLI5oueL1KOKp5JPFE0D2f4V/32riPiImHTeRG39HKTQKLnSWr5Mbn4Mb9DQUltdqc0f98t2bAomOFMtBJ3CluwXubsfi+R18hpwxG72pLEUIM+A45cA2OuoR1Y7gtzqD5pSao1vJheRyRZZVxaOschEzJjfcfsnav1Rgf9LPt1D1nKZrleHR1EH1KmvlBIXNauHuP8QsiLVO/sPOyrdySZcJ7nSJz4rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM5PR15MB1371.namprd15.prod.outlook.com (2603:10b6:3:d1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.24; Tue, 8 Nov
 2022 17:58:12 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3%4]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 17:58:12 +0000
Message-ID: <8c305248-e3ea-c74a-2fd1-83737af61f78@meta.com>
Date:   Tue, 8 Nov 2022 09:58:09 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH 4/4] bpftool: clean-up usage of libbpf_get_error()
Content-Language: en-US
To:     Sahid Orentino Ferdjaoui 
        <sahid.ferdjaoui@industrialdiscipline.com>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        quentin@isovalent.com
Cc:     martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
References: <20221108142515.126199-1-sahid.ferdjaoui@industrialdiscipline.com>
 <20221108142515.126199-5-sahid.ferdjaoui@industrialdiscipline.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221108142515.126199-5-sahid.ferdjaoui@industrialdiscipline.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0042.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::17) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM5PR15MB1371:EE_
X-MS-Office365-Filtering-Correlation-Id: cc41ff8a-7d63-4fcd-9e12-08dac1b2cd6b
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CZFpNmhg+/rj5ERPSXUl20VPe7FUW+vLnNeD010cJYqPZnifJooP1W+kxcJ3vV7LU/gsZwH9gvH4qNo22I4Vu4r6EZ+k5nVBjj57QVGJflqoF0UZu1NQZzWPJfLYU3Fv/Oo9nZoPDWGtkPyKeZDl51+VSpxCTG40CFwucSmuWI9EXsJtyaJ0ZpEqzYqnYnNGY+r5p9QFtDjaRHffITDS5btrk5Pwvijc6u35sYJ/YG41UXrw2j0LA8yXER0hEc8M+T0t2eKzBUGAcjkjZ0JguaaG9fvyCIvoH6qygDMNKT/FbOtrHZbktIALLwfdeHMnXZ0RZ0rwBWoQ7tYddvjEF03yynP1v/5gaewS9jpeuxfv9z5iH+kWtTtM4ni+k1FFnMVuY3lFDsR7gMIdwFYZy+7THYRWXDmjRi1TS1zSaguWZ2pa7p3Do5Ezil3EgOeEjvh678rB9f3wMez81q6Cm99ytvsWx0qHz4ZmS7seEyrSejQe9ZRJ41MRL2rY6zRqI89ljHhwIFOwsSlAjQf1zt/sMNu+x78uF6b7ZQifFkf/SIwzRZicCY7UobyASjMSxvhYdb6zBtwYrBUK3qki/c8zOHAmwUo/WmK6VjVuWrC/sPdv4NM6CUrZ0IPJFjjDuhHFKfd+3x1izdPat2TVAm1Q6ULJj37/VgIdV/SnIC/YE3aOzVOgHz+l228sSYQ0zK3UGiGacv8lOQThf+mscFCmpFrxRUPXYYbzllL5LftDuCpDotK4U28C3AFDLCGuIgEiANVVE6B/AGLr36L5h8TEAvZN66v0rNgb13rz6ME=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(451199015)(31686004)(36756003)(38100700002)(86362001)(2906002)(6486002)(316002)(66556008)(31696002)(478600001)(6506007)(6666004)(53546011)(66476007)(4326008)(8676002)(5660300002)(7416002)(6512007)(8936002)(186003)(66946007)(83380400001)(2616005)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S25UeFhPL1NsRmJTbnphdzk5QzRPS0lhTmpKVUhLanNTeEZZL3JheHRQVEFQ?=
 =?utf-8?B?UEZ2RERMUkZUaFpFdGhFa2kyZUNaM1J1bnVxZlMySUF2aDdQVVBqV1FmaFg1?=
 =?utf-8?B?RnZjazlYR1h6RG9pbmNMODcxNXl6ZHNONGFDQk9ocmgyb2x6LzlWcktUY2NI?=
 =?utf-8?B?TmZDQlBOR2VJZjlOYlJrYkFYSTl4bXhKd3V3VlUzVjYxaE1lMTkrY3J6M3N1?=
 =?utf-8?B?YnZVTldYT2VIUWxEVklSQ2YzeGt0bTVtemR5QWFwRWlhcHVMT3lYc0Fodm11?=
 =?utf-8?B?NGYyL2NNaDRrKytnaUYydU1GcktYQWx3MDdESm93TFB6Zk1jSldKN3pGTHJZ?=
 =?utf-8?B?WE9TUTY1ZUlEdVAwaWhoMTMwZzFwRGROU2N0Z3cySzlhZjlwMHh5U2JrZEVI?=
 =?utf-8?B?ZGw2aERsWkVYcEZhd3hncTFBSlJOWFJLc01PVWxlVHlhNGtVckM3OU5uVG10?=
 =?utf-8?B?ZlhkcnVLNmNEUngrVVM3Z21kSnFDMGJIMU1VOWErUTltcWdlYXpVQWdtY1pH?=
 =?utf-8?B?T3lzQVVFL3cwc09ZYWRuWEc3NkVNMWxJQWZEYWJCZTVJeURQcGUrWEZPWGFr?=
 =?utf-8?B?YnNUUWU3Tk0yeFlwaWZoaWJya0ZPYTkrbG9pOXpXSFRPVHYxMUxYRTdBWXo4?=
 =?utf-8?B?aFlhSkY2SElkYUhOZU5VMTQ5YmMyNDcyZ3F2VDR6TG91MmhUMlFpMEFFUDIv?=
 =?utf-8?B?K2hJQkxHOUx4OUxCTXgxSHJJME9tMGlFTkg4NlNDbEk4Qmo0TEk4UmEyV2d5?=
 =?utf-8?B?VDAyMHl3K3l4WlR1UnBmYjNHdEVnVkYyM3JUV0duQ1k1MDlXajJzalA5YzVY?=
 =?utf-8?B?NG92WlBVcTA4bTQ3NDJyYWwzeWx0MUhpUUIrUU13dzYrd0xoRG9tbXB5UHcw?=
 =?utf-8?B?N2VrcUprclAzaTFSS0pZaTRvcTFEczl5Y1UyNFMvbkxuL2tVcEVHM3hORE44?=
 =?utf-8?B?ZzE1d29rTi9PS3cySlZOOWZBT1J5NHRPbzlGaFFuSVNpTkVPbm5DQ3dwSkQv?=
 =?utf-8?B?SWszdDI1dytIcHd1VVEvRSswSTBjSFluUWppY3F6ZVpuMm9BT1ZOaTV0bkMw?=
 =?utf-8?B?VlVhejVhQXVQaDdtQ3ZnT0JyM1lIb2xBc3RCRnl6N1YwaXkvbVRLQVdLdW43?=
 =?utf-8?B?c1BrU1RsaXN4WVdHLzBPaGV6RlIxeTQ5ZHluV0oxRDIwQlozZlR1ZTBNcGxR?=
 =?utf-8?B?MENDVkh4cE90QlAyRXJCeW5jTmx5U2RMaUF5RmJzcHBUZ2VFT0RveHJUV2tB?=
 =?utf-8?B?VG55UU11MmVKQWM0VzVIUWRpQitEUVdqNXM4ckJESGEvSmVKUTE0ejZPdHMz?=
 =?utf-8?B?czlFN1dzWktjaEVLYlkwbGd1RlJCZHdldHhTMUMyRWNibGNaMGE0TUE2dkd4?=
 =?utf-8?B?NXdQNmdkRjJ6K24zdVNQVjdvaG85L2RRdEducytoaXZsN2IxOTdyOTlOSG9H?=
 =?utf-8?B?SkkyUkV5bnJzcGVubGIwZU1mK0hOOFU5SUJsRnhncDlmNC9odm5MTDhwSVBZ?=
 =?utf-8?B?VHdTdGZIYXBqREJEZklCRmsyeG85cWtCVzBVem91MEVmL21MSjVzdVdCV0Rm?=
 =?utf-8?B?Zm84UGtFaVlaWk9kYXU0WWdmKzJjd3lNTFdaVWpFcHZvRXlPRFROcG1hOWQ4?=
 =?utf-8?B?bUdqYjNKVnZrY1VYeXJJV2F6Z1FaOUFpZ2VKaVJ4bXhzVnhVQ1NtQXowVDVj?=
 =?utf-8?B?ZktyQTFZdjc0TkxkMGptb3FiYUtVZFhCU0RLdkczUHpYRzA3WnNpODI5RURw?=
 =?utf-8?B?WXNJU0xXUTBOSXY2Y24zRjdxWmpPeERySFRRcGw2cDhkR1NqdkRjbmx0aW1x?=
 =?utf-8?B?U2tKaVhKVmRLVWdhSlJOamFSSVZyblkrZjA3eEVQVEdJZjFLVnNha3BwWkt0?=
 =?utf-8?B?OWI3N29JNmgvTUFCTTlhaWFiaTdycm1uMlFCRDFmYmUyeTJmMTMxWmIrakNY?=
 =?utf-8?B?OVVRYlNWYVpscS9FTmhmNytPQWxOOFJMS0FlcHhVcHMrVk1wLzBod1o0aXVV?=
 =?utf-8?B?ZlprZEIxYnJDUU0zNFRIbFZtMElCNU5jZmpFZlFGWm1BSmRsdDdRZnh5am5O?=
 =?utf-8?B?MytVYlJrcm5EREM4S3NBTlA1UkYwTWFHVGRCNy9uQjFXa01TZmdER2RaVmx0?=
 =?utf-8?B?VjV4UmJ4citpMW8wZHVMRWtHOXFsbTBtOXMvTE5IOGxOcC92d3NaTisyK244?=
 =?utf-8?B?a2c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc41ff8a-7d63-4fcd-9e12-08dac1b2cd6b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 17:58:12.2630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3BnHVgPpreMls1xT4hAMHQDfv+uA/Sz9CXbXxPzSB/QgYLAe0BX6/9QELVM4Izx6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1371
X-Proofpoint-GUID: 77ApoaxOQhI7On02Bu7B4ZbaOc4w6U6q
X-Proofpoint-ORIG-GUID: 77ApoaxOQhI7On02Bu7B4ZbaOc4w6U6q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-08_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/8/22 6:28 AM, Sahid Orentino Ferdjaoui wrote:
> bpftool is now totally compliant with libbpf 1.0 mode and is not
> expected to be compiled with pre-1.0, let's clean-up the usage of
> libbpf_get_error().
> 
> sidenode: We can remove the checks on NULL pointers before calling
> btf__free() because that function already does the check.
> 
> Signed-off-by: Sahid Orentino Ferdjaoui <sahid.ferdjaoui@industrialdiscipline.com>

Ack with a few nits below.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   tools/bpf/bpftool/btf.c        | 16 +++++++---------
>   tools/bpf/bpftool/btf_dumper.c |  2 +-
>   tools/bpf/bpftool/gen.c        | 11 ++++-------
>   tools/bpf/bpftool/iter.c       |  6 ++----
>   tools/bpf/bpftool/main.c       |  7 +++----
>   tools/bpf/bpftool/map.c        | 15 +++++++--------
>   tools/bpf/bpftool/prog.c       | 10 +++++-----
>   tools/bpf/bpftool/struct_ops.c | 15 +++++++--------
>   8 files changed, 36 insertions(+), 46 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index 68a70ac03c80..9bcd3be42358 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -467,9 +467,8 @@ static int dump_btf_c(const struct btf *btf,
>   	int err = 0, i;
> 
>   	d = btf_dump__new(btf, btf_dump_printf, NULL, NULL);
> -	err = libbpf_get_error(d);
> -	if (err)
> -		return err;
> +	if (!d)
> +		return errno;

Actually there is a difference here.
libbpf_get_error() will return -errno in such case. So the old
way is returning -errno and the new way returning errno.
It looks like this won't impact the functionality as the
caller checks 0/non-0 for success/failure and still use
errno for actual error. But it may still be worthwhile
to mention this in the commit message.

There are some other instances below as well.

> 
>   	printf("#ifndef __VMLINUX_H__\n");
>   	printf("#define __VMLINUX_H__\n");
> @@ -512,10 +511,9 @@ static struct btf *get_vmlinux_btf_from_sysfs(void)
>   	struct btf *base;
> 
>   	base = btf__parse(sysfs_vmlinux, NULL);
> -	if (libbpf_get_error(base)) {
> -		p_err("failed to parse vmlinux BTF at '%s': %ld\n",
> -		      sysfs_vmlinux, libbpf_get_error(base));
> -		base = NULL;
> +	if (!base) {
> +		p_err("failed to parse vmlinux BTF at '%s': %d\n",
> +		      sysfs_vmlinux, errno);
>   	}

You can remove the bracket since only one statement in the 'if' body.

> 
>   	return base;
> @@ -634,8 +632,8 @@ static int do_dump(int argc, char **argv)
>   			base = get_vmlinux_btf_from_sysfs();
> 
>   		btf = btf__parse_split(*argv, base ?: base_btf);
> -		err = libbpf_get_error(btf);
>   		if (!btf) {
> +			err = errno;
>   			p_err("failed to load BTF from %s: %s",
>   			      *argv, strerror(errno));
>   			goto done;
> @@ -681,8 +679,8 @@ static int do_dump(int argc, char **argv)
>   		}
> 
>   		btf = btf__load_from_kernel_by_id_split(btf_id, base_btf);
> -		err = libbpf_get_error(btf);
>   		if (!btf) {
> +			err = errno;
>   			p_err("get btf by id (%u): %s", btf_id, strerror(errno));
>   			goto done;
>   		}
[...]
> @@ -809,14 +809,13 @@ static int get_map_kv_btf(const struct bpf_map_info *info, struct btf **btf)
> 
>   static void free_map_kv_btf(struct btf *btf)
>   {
> -	if (!libbpf_get_error(btf) && btf != btf_vmlinux)
> +	if (btf != btf_vmlinux)
>   		btf__free(btf);
>   }
> 
>   static void free_btf_vmlinux(void)
>   {
> -	if (!libbpf_get_error(btf_vmlinux))
> -		btf__free(btf_vmlinux);
> +	btf__free(btf_vmlinux);
>   }

free_btf_vmlinux() contains a single btf__free() now which can be 
inlined and this function can be removed.

> 
>   static int
> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index b6b62b3ef49b..72e1c458dadc 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -322,7 +322,7 @@ static void show_prog_metadata(int fd, __u32 num_maps)
>   		return;
> 
>   	btf = btf__load_from_kernel_by_id(map_info.btf_id);
> -	if (libbpf_get_error(btf))
> +	if (!btf)
>   		goto out_free;
> 
>   	t_datasec = btf__type_by_id(btf, map_info.btf_value_type_id);
[...]
