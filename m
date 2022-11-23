Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767CB6369FC
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 20:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiKWTlJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 14:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235311AbiKWTlI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 14:41:08 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96B991513
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 11:41:06 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ANHsOPJ025401;
        Wed, 23 Nov 2022 11:40:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=vAc/QfKtChIv+z8DylAd7v7/F1yIFD9V0qqtqtqzESI=;
 b=Z3icPpFrFQ22aMFmvslvJx2xOkHCJVp73rWXyhSH5IlBjNxKrhwPBNsDA4DYMxtqbQ2G
 VHdPJtgHEojIBlDhqfvR5y7xCFLjMzDl/W5/SSnzCIORCAPo4mxnrJxYX1He5YV84rhN
 tXTu3dZCi5Zh/pwhaKclY62WJWDdWKcGqTdsiqlkl/34ROZbDUzNaXwBszTFZMUjphj2
 pi99ELAwEWY5GC2lsRRhoajd3yyPQfz3VpsIoTSN5WaDO07AC3+qX9i6xkO2TIunXM06
 IzH1OqNzvC/yMjTQQWwAhKyY5GbCz9Eowhg8EiXVj7b0q0We2dgaK0XUhC/vG3qh8pN6 /w== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m0m19xxpg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 11:40:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5QNQwiRLHv2V1bzfsohHtgCsWsxI/mQlsLdiyl/yNTj33BXALeh8hgtr0EgcgVF+r508NKs9AHXwK3LAIUkZ+z1qVVFypJkfbc5V1ZBGJBF3766ip5IKPMZ05PZNofAqSjPRAvYmq1fOfs5WlI5GU74CdGt9h/Z9MiteyzRVb3PfdCp5SyNo3+4iyOGiUYkIZjQ8guKqMsFSAmbhEvUbXZUEV+3Tlk8B1gymFqo3tHpu1/NMmkVx7cBZyC70ilhjVibIX0jrL9wBGzrLVZBVtqkSL7nuwrKBkIoi1YZyjyye78v8YJRHizxMoCSHzBHIectxeTc1pXFgyHBupP4Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAc/QfKtChIv+z8DylAd7v7/F1yIFD9V0qqtqtqzESI=;
 b=lYSOQcVttuqz3USKHC5BJjKNbqhvPjXNf8KUOaf15sx+DT+Fe3Uagj2GFuwWAONWQZVQEw/CWkJe/U/uRTBeDVmDpKZUe09J30g38BXBeoCnAl7nX39jWYYRsH1a9QxlIA8rzkLDFvKzim+LJaEkBKm1J/INbbfyzs3aibSLJ9nQU6COd+eWhV6OfTHEDQT4lpCN2BsQJeKQaOfxSv/GgN2+KxQ2GQUWq3XqS8Ss4eHNlBSNw0tY9jo5s8I8tc9+Fp83pLbWTWOiiLAZ+LTvyBVrBKXHuPMCQRF2YL+w7DpeXYSfg+U+t6MWuPV0ig/EzjTyDfhSDibn6nTX0zArlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MN2PR15MB3021.namprd15.prod.outlook.com (2603:10b6:208:f4::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Wed, 23 Nov
 2022 19:40:42 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ac66:fb37:a598:8519]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ac66:fb37:a598:8519%7]) with mapi id 15.20.5834.011; Wed, 23 Nov 2022
 19:40:42 +0000
Message-ID: <5c82360f-bcec-21b3-61b0-28be7b196dfb@meta.com>
Date:   Wed, 23 Nov 2022 11:40:39 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH bpf-next 1/2] selftests/bpf: Add reproducer for decl_tag
 in func_proto argument
Content-Language: en-US
To:     Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
        jolsa@kernel.org
References: <20221123035422.872531-1-sdf@google.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221123035422.872531-1-sdf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0070.namprd05.prod.outlook.com
 (2603:10b6:a03:332::15) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MN2PR15MB3021:EE_
X-MS-Office365-Filtering-Correlation-Id: b1d0adf8-d47a-4899-98a7-08dacd8a9b19
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GmU69RgsoDe/5ulg79aSBYOGWNAjtUwYDxQ1VILR5UL2WfPn//h9hehV0riFeOgoyZD9cMDX138Gfxy98nQaT0hVqRYpc8j7dNQjbytYo8ogiv83YZ8/TmWDXoJUGIaMQWSgnb7OxLzBzsBu9agJqD1Z3LNWfXcyQSYogdOX5bMiCG5+kp7hBctLHvl8WPwYS9/hRcj9IoofQ7xNvQ7T9zu+TGrOvfmwKqR2HzbeM8Gpoik2WOuwkco4bbephmQtT5mLs/oC9mefgzapTjuIIxOOOHMBXjd1uORXVipnmD7mcwRCKvcrDUqE0daxv1Gn/wIX04fiGrhA+Qea/PCOi8LEWohIMiFUmpumtI4b+XrPBVkeLJky8j3Lz8xI+ZSxTRQyCPnEeRQnPE9ipBpMXCmbgfK5Qtb9BcPvzsxmffoF0j0yh8cS9NRSlik5KzVMBxALiYYvPGz+fJRHFcQry8drhjKH2F0a2Qrnol/wK+1+ZclRlVwm4wXtVDV0wgx9Q3K3TZI2y8eYDwWN1ROHNU1lw6cW0cQs75/DRmiW6DHeJZ045Y/LYhLIVMupLx5pAomTZVGF6/Eoiii2LVJE6ZR8sdsCfsYyG9a7CMWVxecXsvS3T8YkTzJrq9svnHN9iR1yOVg5rnC4Ve8yxx9IxWwdygHxvgWbFFpTb/zohXDs+1gH0eeVjgmnnERUIXRJ3g9UtD3uHTKICHNZEb0qtmFr1K1yXxnZnI3r6fAbzqw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(451199015)(53546011)(66556008)(6512007)(38100700002)(2906002)(186003)(7416002)(5660300002)(2616005)(66476007)(8676002)(478600001)(6666004)(6486002)(8936002)(4326008)(316002)(66946007)(41300700001)(6506007)(31696002)(86362001)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmNuTmNIZ1JHS0lFYk1SWEJWclJMUzg0cGhLbTFtcFdoQm92SEtmbFA0S0F5?=
 =?utf-8?B?NzZrbzI0K21mN2x2R2ltS3VEVGpTNkZwRVlNTlNpaXNKQTJ4dU81V2k2L2Nt?=
 =?utf-8?B?MjIyME80aU9QM0RMZHFZdUY5UlBhajJKWk96RHlvK3JxL2lWNENveVh2WjVD?=
 =?utf-8?B?c2xIOTJscVk4b1BJb052Rmdna2VmZ0JHZnhWbDRvVkpBbUhmV1VzSWZ5Vlht?=
 =?utf-8?B?Z1BvdHN2NHQyRDQ4czdoRDcvUmpIYWd1NjViQUd4ZDN5MlptQXY3ZllEZkpM?=
 =?utf-8?B?aHBzcjZOdjk5cUZpdVRYY09iaEVGQW5mY1dBTEx2L3dyWkFxQStDUTBLOWtj?=
 =?utf-8?B?T2EvM213YUdMcWJwWTNGREVxcllLK09YN3R2WTV2d3ZWTm5YdUQ1cWRlM2RF?=
 =?utf-8?B?S2UwcjdZVzZVdkwrai9mc0NFMHVZUVliMWZicFNFMkR6WkdrTmNTa0tSSWx5?=
 =?utf-8?B?SGR4UnpBZ291NnhLSElZOVlHNHJvZ0xBOXpzVXNiNCtxbmJnazVnRm9LRjAr?=
 =?utf-8?B?TUswQzZLYlNPU0Rpc0hsV2thek93SE81Vm42cDZqalVJN0ZhQ1lKdjJLYnBF?=
 =?utf-8?B?S3RtQWVWMjNkc3VmMkYzblZoUlFLb2VJeWZBTkcwajR3RWRTazZWb0NabHNX?=
 =?utf-8?B?NjZVYlQ0aS9sSUVyTWcrNkFRQmJKWkZrZ2tOdHNDWE1keDEwSXlRREJITEZ0?=
 =?utf-8?B?aHdpSndxYlpRUGpzcWFiR2Y4VVc2Qk1mV2s3T2JNZ3FudHBZVXlGNXdrYzI3?=
 =?utf-8?B?Mm4xSG9QWHJsdkxNbE9VcFArbUxtdEpoYW16R2xUcjJ6Yy8xVFE0UWg3MGVQ?=
 =?utf-8?B?b2ZDaSszTytZZ2JDc1FSa3g0T2NGL1FTUkRJWkpmN3ExdnlHeDEyelRwbVNX?=
 =?utf-8?B?azI1eGVZOWhIWVhoZGpNR3ZIRTJBU3o1VG1MRmdFVzJRd003MkYrTXFOcFA4?=
 =?utf-8?B?NmwzWmM0Q1kyeGQzTFl6TDBOdEp1dEpncVhoY1BsS296R1RpeWhEcG1DaUd1?=
 =?utf-8?B?dkZuRkZWL3pJMkcrRGlML1ZkL3lMSUYyb0dtTHZZc2g1WmJGSXgzalBxMEJo?=
 =?utf-8?B?M2Jma0xZZTRONlRlWWxMWHhNWHgwUS9BSHoyUzZZMG5aUXRSZ3V1cW9aemtG?=
 =?utf-8?B?cW1MdTNzTjVVczVndUEyWGJmeU1Nb3JEeGUwa2YyZWFOK2VJcyt1OUV6dzlE?=
 =?utf-8?B?TldrU2h1dGU0QjBESCtBV2tlaVd3Y0c3N2JSeE1YdjFwZzhONS94MWgxMTNv?=
 =?utf-8?B?R2VQcEt1WTNROHRobWFaK1JLT211YVVZUndGMStFZWZOZVVMUjBhNXdlenlm?=
 =?utf-8?B?U09obkgwTkltOTQySWd3MXZvb1ppWlczQmRVUDNOSkdxWU9oVllsRXlFNTlq?=
 =?utf-8?B?QmI2a1U3SHVnSHE5bmUwNnpPYURNZm5rZHRwOGYvQXBBMEpqRWtuNHNhV3Bi?=
 =?utf-8?B?SmtrZ0l3WGlyMVlTOFBxdE1kczZJamt2Wm1uY0VCcy9LQ1NmWVNKelBCdmpj?=
 =?utf-8?B?bnRyL0pIcGpmT1J1Sy9BVkNBUldUUFNhK3AzbXl0MGpRUXJSNnprNmg0aXZi?=
 =?utf-8?B?Q0lsbFdBbVpyem8xeXdKS2ZMV1p2UEYvT2hKTU9UQ3FGcm5DbTNMcUc5ckE5?=
 =?utf-8?B?dDlhTkg5UFBQQzY3WDJrSTllOXN0ZXZSeGIyQlZ1TkhJcG9Jb1J0U3lqOTUy?=
 =?utf-8?B?RXRFdjRvQkQzWGRzQUUxamxyeEdOS080MXRTMmZmcDdjVGthR0p4UmZPV2Zm?=
 =?utf-8?B?R1ZDUVExajE2bmgvV2pVaFJWanM4K21PSWVjenBYQUVYMlJwVWZQeEFZTlFu?=
 =?utf-8?B?YUhkNllsWUFkalhmeVExa0ExQWZ1ZXE0SldFUUxGdlFiME5aU0Izb1cydC9z?=
 =?utf-8?B?Rmxydk9VT3JOUmp2czhlcXEwL1VWekMwTWQ0NWptSUkvN1FuY0Ftdyt5ckRP?=
 =?utf-8?B?NDhtbS9lbEFBS0FaM0d1TzY2Ky84bEF1aUlzRFdlOUEwRDhiS29uZXo5RVcy?=
 =?utf-8?B?amFtNDllOWM5TWFkT0FaQWtLdFlLTDlyV1Y1eDRidWdLM29ZNXpLL2FnQTN1?=
 =?utf-8?B?bWp2cU1LY2tOQmZLUkozRStDc0xHRUEwcHFHUTdJd2lzT1VySWNzMHRaKzY3?=
 =?utf-8?B?WHQ1dm1PNCtmazVEbDVPb1BhN21idVQ2RjZwNmlVUWRzY3lvWk0yM0VZK2Vi?=
 =?utf-8?B?aWc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d0adf8-d47a-4899-98a7-08dacd8a9b19
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 19:40:41.9392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lo2Ph6vjyzunSqYzR16CYWsUoBrl1v2nv5DeF1rDDL1OmiR1yx6dXsj0UwZetO50
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3021
X-Proofpoint-ORIG-GUID: XDsdkwhEhOmSIkp38ZfjJSCrrXCIFJCs
X-Proofpoint-GUID: XDsdkwhEhOmSIkp38ZfjJSCrrXCIFJCs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-23_11,2022-11-23_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/22/22 7:54 PM, Stanislav Fomichev wrote:
> It should trigger a WARN_ON_ONCE in btf_type_id_size.
> 
>      RIP: 0010:btf_type_id_size+0x8bd/0x940 kernel/bpf/btf.c:1952
>      btf_func_proto_check kernel/bpf/btf.c:4506 [inline]
>      btf_check_all_types kernel/bpf/btf.c:4734 [inline]
>      btf_parse_type_sec+0x1175/0x1980 kernel/bpf/btf.c:4763
>      btf_parse kernel/bpf/btf.c:5042 [inline]
>      btf_new_fd+0x65a/0xb00 kernel/bpf/btf.c:6709
>      bpf_btf_load+0x6f/0x90 kernel/bpf/syscall.c:4342
>      __sys_bpf+0x50a/0x6c0 kernel/bpf/syscall.c:5034
>      __do_sys_bpf kernel/bpf/syscall.c:5093 [inline]
>      __se_sys_bpf kernel/bpf/syscall.c:5091 [inline]
>      __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5091
>      do_syscall_64+0x54/0x70 arch/x86/entry/common.c:48
> 
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   tools/testing/selftests/bpf/prog_tests/btf.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
> index 95a2b80f0d17..de1b5b9eb93a 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf.c
> @@ -3948,6 +3948,20 @@ static struct btf_raw_test raw_tests[] = {
>   	.btf_load_err = true,
>   	.err_str = "Invalid return type",
>   },
> +{
> +	.descr = "decl_tag test #17, func proto, argument",
> +	.raw_types = {
> +		BTF_TYPE_ENC(NAME_TBD, BTF_INFO_ENC(BTF_KIND_DECL_TAG, 0, 0), 4), (-1),	/* [1] */
> +		BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_PTR, 0, 0), 0), /* [2] */
> +		BTF_FUNC_PROTO_ENC(0, 1),			/* [3] */
> +			BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 1),
> +		BTF_VAR_ENC(NAME_TBD, 2, 0),			/* [4] */
> +		BTF_END_RAW,
> +	},
> +	BTF_STR_SEC("\0local\0tag1\0var"),
> +	.btf_load_err = true,
> +	.err_str = "Invalid arg#1",
> +},
>   {
>   	.descr = "type_tag test #1",
>   	.raw_types = {
