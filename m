Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 698132C2FA3
	for <lists+bpf@lfdr.de>; Tue, 24 Nov 2020 19:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404205AbgKXSHo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Nov 2020 13:07:44 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:11522 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2403986AbgKXSHn (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 24 Nov 2020 13:07:43 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AOI53SM026672;
        Tue, 24 Nov 2020 10:07:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=T6o0hQpOrr1kzIgYo+rp8j79EBQKeMtJhotG+ZMOqMg=;
 b=Uq69AS+TZuhyYmc+szolT4As1OYqyupGVSQgf7zV9YukhFtE/ZuaC9OaWVfua9Lcy4/7
 nFT4obtFL2fFGXgtM+G7GDj4PLgczGKmanoQDS5IIW84gteU2ezPqwmqUqr5c+o5Sxzr
 iHe+uAXwIh5eYmuzmujcll4em4uZZpcLyaQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34yk9gav9w-17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 24 Nov 2020 10:07:26 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 24 Nov 2020 10:07:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f5ctzUnl2Xx1EV7ivnJ2+EH3wrLGjuFQ97G6hO9rKq4nTjYRaythXUgJYlRjnEj5hDnSzwC2wjBJvkaBym0dDHa/3v2X6rtmouAPGSpXfLI+GQqzLtjMyIcs9NFpOWCB8yTePINx0EuE1NZMsl7vReaCmtmJ+U3gV5H6y/W/SMtIEaexHZcx51ruhqC6BC9bI4oOS40jBlo/JErHjaoSUBeCK4ulvwaoWnZPb0PQwQ+K/xbxajjUlSYpCTtd54IomYOW2vA5ZvMuDMFz3E56NyBO7k1H2OuSmSbT4bxu56XJthpFFG4wwK0WwWE0eg0HA5qo2biS47wy+5P+4oIRYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6o0hQpOrr1kzIgYo+rp8j79EBQKeMtJhotG+ZMOqMg=;
 b=CI759itkiHDwfUv4em9lYzTdh9hneNSyPqwy5CG5jzFQeCW1MnaySdwjJhSSQvlNuUVTjLiGptMGAlXKvUpbCQ1MLPfPO9n3KuubtQfm94x3lYUSynN/WhCfP3OYSASXD33BX7tgn1TwuzA2A6JC82HQyoyQogit1rDfbIKG6Ut3J66AxS5JShYNDMhi4h0V+i4bZQYhmfG1S5qJWiHKKp5CZfEuMWkGbQK6+57mAMHhtdQZXMeMbFOMjboe/U6w9syooenR9cDp+oiwTy1uCbBASEOgScxqJoLOq8vtd4+vQLX6F/rMA80ruusOVSEHbIQkHl8g+lfpuK+OMSZGwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6o0hQpOrr1kzIgYo+rp8j79EBQKeMtJhotG+ZMOqMg=;
 b=WVDiSAJlalUqWpEhMKepl6guXT1V1nucb70aRDBAlkAYgRdyjwraX8eGn28zub/2MzXVFSnvrVQSOcTBYA2cmoY8sRt2r3yGQvzmcTVI0Fai5QxbNtuo9pazxWPwm672TRjDwH8aXgWdhORJ6d0F7dmk3ghn84dbf/LvgTki8UU=
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2776.namprd15.prod.outlook.com (2603:10b6:a03:154::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Tue, 24 Nov
 2020 18:07:17 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3589.029; Tue, 24 Nov 2020
 18:07:17 +0000
Subject: Re: [PATCH bpf-next v3 3/3] bpf: Add a selftest for
 bpf_ima_inode_hash
To:     KP Singh <kpsingh@chromium.org>, James Morris <jmorris@namei.org>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Mimi Zohar <zohar@linux.ibm.com>
References: <20201124151210.1081188-1-kpsingh@chromium.org>
 <20201124151210.1081188-4-kpsingh@chromium.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <f098e91e-d5c3-43a7-cc34-7ed67cc565e0@fb.com>
Date:   Tue, 24 Nov 2020 10:07:14 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
In-Reply-To: <20201124151210.1081188-4-kpsingh@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:4987]
X-ClientProxiedBy: MWHPR1201CA0009.namprd12.prod.outlook.com
 (2603:10b6:301:4a::19) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::10b2] (2620:10d:c090:400::5:4987) by MWHPR1201CA0009.namprd12.prod.outlook.com (2603:10b6:301:4a::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Tue, 24 Nov 2020 18:07:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 068bdb11-6b5f-4806-9c22-08d890a3c793
X-MS-TrafficTypeDiagnostic: BYAPR15MB2776:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2776528608B41ADABE6227E2D3FB0@BYAPR15MB2776.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PjIsb1Eyxwz3DlNni9frbtiKQornzJIOmr7qmsuKtxcEg9FduR8BoeJRPZwhmL67r6O2IIzyyGsrkOokiOiMz/g9A24/Z+jcJBIOCul/qqTQyZHqaKAw/kr6OkUwi4hfkZ0YfV32Jg7Hwv47Ldosze42loUmHbvIzphGcF25tJb4lzRwHK+e2lTFmWzEKmArFSkNzHKKf+w1QQwEID1jUNDjdB6d23S0MLyn9iwg4LfpD0w60BZ3ziJkWGcERqvm/3paoZoSWiBD4Cx5BYyPOYeZ0Gf09PeMXZGABtj6ABZ8fitxfn5lCMKaSNqXdHRWoRPfOtDIIp9O+FF0bIGzwlAzNPsYtPl55EZk8aYRm0P0WkolA8Eada6urlSoCFWn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(366004)(39860400002)(136003)(396003)(86362001)(83380400001)(52116002)(36756003)(4326008)(110136005)(54906003)(316002)(31686004)(7416002)(2616005)(16526019)(2906002)(31696002)(186003)(53546011)(478600001)(8936002)(5660300002)(8676002)(66946007)(66556008)(66476007)(6486002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bCtHd0M0T2Z6WVN3WkV5bUZnMVdnTHZxMStTcnhPd3RWSXVJczRyZ0NLMzRn?=
 =?utf-8?B?VTd4NEVjQktFNWx6YTRKQXRlV2JhS3NtQXFzbTlCaXhseFFGVlhqeWpRTmFV?=
 =?utf-8?B?KzVWVk1MVnBteis5ODFsa2JtYjNBLzRGRjFTVEYweG1wNEpVWDJwOUFld1J2?=
 =?utf-8?B?NlZaMy9jK1QrRmRUcTd6ZHRvNmtUK1MzeW1zUUZWb3hQZUY4KzkyTkEzQ0lm?=
 =?utf-8?B?S0lkOTY0d0M1clJ1T1U0Sm1pYUk1d25UMHdLdWJ2Vlpmd3EvYVkzYmMwQWty?=
 =?utf-8?B?Z1dUemUrd3VtdVliZkhFQXZXTTB6azdFNnNnVE1DY0NIVjJOQmdHdWdJOW1v?=
 =?utf-8?B?M3JDSURwWHJmWCt3b2VSYjM1T2lOdHpaS3h6ZnFiTS9uWSt3TnlVNTFrd0Z2?=
 =?utf-8?B?aHBGT0RwRGJzYkZjRjZVRWJseTgxUVJ0NDVZUzZVdVZhcXdlY1FrQ28xZmls?=
 =?utf-8?B?Y2ppSHpTc2hSQ2FCclNpdlU4WkxYS3BiZ2tKMWowY2V1bStFbXo5ZEZ4Y0hF?=
 =?utf-8?B?SDVjTVQzOWFyQzhzdEFmdzBpYWF6Q1pmWS92K2t1d3VRK3VnMmVzTFV6Uzhn?=
 =?utf-8?B?UTdwbys1ZnhwWGE3MkZDaEFoMnBjRG02YnRsNWhDcHdqV1ZYOUFCYUdlOGE4?=
 =?utf-8?B?eGc0anB2UWs0SGtIYkVaM1ExenVHQTR2UUowYXFBb2JBWDdpN1JPY29XQW1y?=
 =?utf-8?B?d2hPaXlrREV3S3pHL1R4WEhXT1BoNzNPUHh2THNKN1ErWDVqZnZYV2xRcmkz?=
 =?utf-8?B?MHd0dW5GSWdybURsUGZnbnlrQ0c0bDhnWFVlZXNnSDFqbGdJb0xHSHk2SHdo?=
 =?utf-8?B?VFF4T0FaVld0eEpza2VXSUVMMXZPYkZveEpXL2t2MFBqY2pIMHZNU2d3Mm5a?=
 =?utf-8?B?MkNycmg3TlJzamdBcDl3dWdadGx3aXVMQ2xSd2IrUThhd25iVnpJelV2ZTdq?=
 =?utf-8?B?eEErSVNMYThpOXBsRkpHYWFIV0p6SkU5Umo4eEJyWGdQWGsvRitPQnE3N2o0?=
 =?utf-8?B?NEY0VlBCa2dianZSMDFQWWxmYlRQNVI1bzNIUVE0YnVGZmF6U1FqaWpMcnQv?=
 =?utf-8?B?RmNwZWJJUGlWTng1aTVSWjMycWZ1cmdOTUdtQzJpNHBMVlJkSm5Gd24vNW5J?=
 =?utf-8?B?R1lpOHFac0ZPQTZPTExmVklvZjJQR2JMSU5TTHN6alVicHFLVmRYYlo5MlMy?=
 =?utf-8?B?RGJmc2NTK3VkbzI2TUwzMmowRS9CRHBxRG5OUzRIL1paYmUzWVIzalMxYmx2?=
 =?utf-8?B?M0ZNTGRYcUFsMGszRW9LekFyQVZmYWV1NHhtbTZpOUVhQ1ZCOXBIT2I2clI4?=
 =?utf-8?B?NVBMWFpkRCtHczF6MmdSMFlzNEpEUENKYy9WVFBteUNDaXZmOEM2ZEhCQTFQ?=
 =?utf-8?B?R3ZTUi9yZnh5N3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 068bdb11-6b5f-4806-9c22-08d890a3c793
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2020 18:07:17.6313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ubXoxRN24llzkLWgdAG8P1KmJE6HREl749sO7ehx1+RDCHca0833/kdlpGgeEcoh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2776
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-24_05:2020-11-24,2020-11-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 suspectscore=0 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011240110
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/24/20 7:12 AM, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> The test does the following:
> 
> - Mounts a loopback filesystem and appends the IMA policy to measure
>    executions only on this file-system. Restricting the IMA policy to a
>    particular filesystem prevents a system-wide IMA policy change.
> - Executes an executable copied to this loopback filesystem.
> - Calls the bpf_ima_inode_hash in the bprm_committed_creds hook and
>    checks if the call succeeded and checks if a hash was calculated.
> 
> The test shells out to the added ima_setup.sh script as the setup is
> better handled in a shell script and is more complicated to do in the
> test program or even shelling out individual commands from C.
> 
> The list of required configs (i.e. IMA, SECURITYFS,
> IMA_{WRITE,READ}_POLICY) for running this test are also updated.
> 
> Signed-off-by: KP Singh <kpsingh@google.com>

Ack from bpf perspective,

Acked-by: Yonghong Song <yhs@fb.com>

LSM/IMA experts may want to check ima_setup.sh as well.

> ---
>   tools/testing/selftests/bpf/config            |  4 +
>   tools/testing/selftests/bpf/ima_setup.sh      | 80 +++++++++++++++++++
>   .../selftests/bpf/prog_tests/test_ima.c       | 74 +++++++++++++++++
>   tools/testing/selftests/bpf/progs/ima.c       | 28 +++++++
>   4 files changed, 186 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/ima_setup.sh
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/test_ima.c
>   create mode 100644 tools/testing/selftests/bpf/progs/ima.c
> 
> diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
> index 2118e23ac07a..365bf9771b07 100644
> --- a/tools/testing/selftests/bpf/config
> +++ b/tools/testing/selftests/bpf/config
> @@ -39,3 +39,7 @@ CONFIG_BPF_JIT=y
>   CONFIG_BPF_LSM=y
>   CONFIG_SECURITY=y
>   CONFIG_LIRC=y
> +CONFIG_IMA=y
> +CONFIG_SECURITYFS=y
> +CONFIG_IMA_WRITE_POLICY=y
> +CONFIG_IMA_READ_POLICY=y
> diff --git a/tools/testing/selftests/bpf/ima_setup.sh b/tools/testing/selftests/bpf/ima_setup.sh
> new file mode 100644
> index 000000000000..15490ccc5e55
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/ima_setup.sh
> @@ -0,0 +1,80 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set -e
> +set -u
> +
> +IMA_POLICY_FILE="/sys/kernel/security/ima/policy"
> +TEST_BINARY="/bin/true"
> +
> +usage()
> +{
> +        echo "Usage: $0 <setup|cleanup|run> <existing_tmp_dir>"
> +        exit 1
> +}
> +
> +setup()
> +{
> +        local tmp_dir="$1"
> +        local mount_img="${tmp_dir}/test.img"
> +        local mount_dir="${tmp_dir}/mnt"
> +        local copied_bin_path="${mount_dir}/$(basename ${TEST_BINARY})"
> +        mkdir -p ${mount_dir}
> +
> +        dd if=/dev/zero of="${mount_img}" bs=1M count=10
> +
> +        local loop_device="$(losetup --find --show ${mount_img})"
> +
> +        mkfs.ext4 "${loop_device}"
> +        mount "${loop_device}" "${mount_dir}"
> +
> +        cp "${TEST_BINARY}" "${mount_dir}"
> +        local mount_uuid="$(blkid -s UUID -o value ${loop_device})"
> +        echo "measure func=BPRM_CHECK fsuuid=${mount_uuid}" > ${IMA_POLICY_FILE}
> +}
> +
> +cleanup() {
> +        local tmp_dir="$1"
> +        local mount_img="${tmp_dir}/test.img"
> +        local mount_dir="${tmp_dir}/mnt"
> +
> +        local loop_devices=$(losetup -j ${mount_img} -O NAME --noheadings)
> +        for loop_dev in "${loop_devices}"; do
> +                losetup -d $loop_dev
> +        done
> +
> +        umount ${mount_dir}
> +        rm -rf ${tmp_dir}
> +}
> +
> +run()
> +{
> +        local tmp_dir="$1"
> +        local mount_dir="${tmp_dir}/mnt"
> +        local copied_bin_path="${mount_dir}/$(basename ${TEST_BINARY})"
> +
> +        exec "${copied_bin_path}"
> +}
> +
> +main()
> +{
> +        [[ $# -ne 2 ]] && usage
> +
> +        local action="$1"
> +        local tmp_dir="$2"
> +
> +        [[ ! -d "${tmp_dir}" ]] && echo "Directory ${tmp_dir} doesn't exist" && exit 1
> +
> +        if [[ "${action}" == "setup" ]]; then
> +                setup "${tmp_dir}"
> +        elif [[ "${action}" == "cleanup" ]]; then
> +                cleanup "${tmp_dir}"
> +        elif [[ "${action}" == "run" ]]; then
> +                run "${tmp_dir}"
> +        else
> +                echo "Unknown action: ${action}"
> +                exit 1
> +        fi
> +}
> +
> +main "$@"
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_ima.c b/tools/testing/selftests/bpf/prog_tests/test_ima.c
> new file mode 100644
> index 000000000000..61fca681d524
[...]
