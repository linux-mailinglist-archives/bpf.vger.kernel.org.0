Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCD92F5106
	for <lists+bpf@lfdr.de>; Wed, 13 Jan 2021 18:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbhAMRVQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Jan 2021 12:21:16 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:22688 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726379AbhAMRVP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 13 Jan 2021 12:21:15 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10DHKO2l009659;
        Wed, 13 Jan 2021 09:20:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=o9kPxwhqIIkOOL9PbvCIEe3NxVQSS+VVOgD/5FJuGi8=;
 b=qK1+wRQmIcJI/wut5KzzgisZ703dMxfoFymclYqayNerF+COxnCoKwHem4cZEtLYtD8p
 NuHV2P5vge+xfgS5rJvvINts5mxqjq1mxguM1VlZMw6tOvzX5Jx3lfZo2udBRK/+xQfi
 fOUkBxF8o4MIXTwL4kK/LINoLzFtdXL7yTY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 361fpje5vs-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 13 Jan 2021 09:20:29 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 13 Jan 2021 09:20:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fNV6cmCqVXM1wsUTCJ77sAq/OXAHQ9DIbFYvyPn/ONLFVbOJBwzHg/hI7vWmCrPdWt7xvjZktlHeTnKhXQw3MVMINg13k0H1bXIpczWGBzVektUxCqu8H2v2QYRmDEg3AbUo1WTg1lNg5r5Sr2zy13oMLYkwMqiN+CKkveBW/PrbrGw06MQc9ELpl03Nhq3A8hkR+krG1SnglFodT8wublMDpZ6EzmQJVLA6d7vspkGLsv/vPoTnpWGct4YYWm389yX2pU06L0PwjcWcsDm2CPMbndMyBXbr2dMgqpkwoBgIs48XfkCzE8iQZ99TYkQtPP27fBTAjzbR77U4I49ijA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9kPxwhqIIkOOL9PbvCIEe3NxVQSS+VVOgD/5FJuGi8=;
 b=G85GywFK6lhwWD7F1cdFAjaUdMxOFWEqPXb1zHY55XK/d4BYp2cid17rbhFWOdXGnFxDCC74AdEEMehEN2Mj6zBSRAIp1SX0jT+nX5VNdrPw3zACzTLrGioRbqMX44ZhLGIE/Cs0m7vmemQI2BE+ZTC+NWv1fBHKhTIWrJaR4LCZg3STXmwLQ+YV5A8QRH+6x8L4xalj2eJ1CuVNsj1qOCXUNiJ9SpLrx2cZ03B82WZXxG7kmVQzHM/OEr9IM7DsCyNCcnQcfehbC6UgUf6mFXic0tgmfCxsCXVu8fm/NMPmfRsEDSPt2j0ZI9IQ55hV6BpDbCRsVAiLZzYxf2m82A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9kPxwhqIIkOOL9PbvCIEe3NxVQSS+VVOgD/5FJuGi8=;
 b=WyRhBYiCCW1CmzLII3bgmdlE76u+VGqA8HPJFvK+Qgz5UEOXNTBj7hdVSGTi4B01EC25iP8lohXBSr2/FnRYV9A2L+I596JNeijvz/Gg2NyweJM+hcSzVVBTfyIdiD3L2NNpEpd1CGt40V6gdMY213I/jt1ZaRcKfh+9LWSFMyY=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3048.namprd15.prod.outlook.com (2603:10b6:a03:fc::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Wed, 13 Jan
 2021 17:20:20 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3742.012; Wed, 13 Jan 2021
 17:20:20 +0000
Subject: Re: [PATCHv2] btf_encoder: Add extra checks for symbol names
To:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     <dwarves@vger.kernel.org>, <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Hao Luo <haoluo@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Tom Stellard <tstellar@redhat.com>
References: <20210113102509.1338601-1-jolsa@kernel.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <2c933606-5591-cc20-9832-09a2549e9c58@fb.com>
Date:   Wed, 13 Jan 2021 09:20:17 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
In-Reply-To: <20210113102509.1338601-1-jolsa@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:e777]
X-ClientProxiedBy: MWHPR20CA0022.namprd20.prod.outlook.com
 (2603:10b6:300:13d::32) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::13f6] (2620:10d:c090:400::5:e777) by MWHPR20CA0022.namprd20.prod.outlook.com (2603:10b6:300:13d::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend Transport; Wed, 13 Jan 2021 17:20:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92c4b559-f867-4b87-78be-08d8b7e7814b
X-MS-TrafficTypeDiagnostic: BYAPR15MB3048:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB3048FD7AE7B02782FAF75E40D3A90@BYAPR15MB3048.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rjXM8JH+mineqpeXdT36/JfMOevZHU26HgWyLJhIZXSfAa3wFJtIsybSnr8ZmOhx8+Bk3R6yppZ42Qaj8/UzwjTzNsibCcLRSh+6JHL6tioFjnWA2HOnRo2ohPZT/3MHXyAPTgVO0U0wf1NlO1ymYioUPL7OCrI4VQtL48GeFdBy1VQmM1Uvc4dWXRa4g7Z5OVnlFZB/I+DVr+H7CpeLF+K67qHJV+DivU+w/00B1KHndqMhguplDYyvZ7SNYgl2aheciywlRG0GcSUqXaQCj4NhlCKeLv76NdvvwXUCZFcELWkseXUdKyJS/px55vZ12WS13BFm01enE6qKwdkpMpiJsvnuXBYTM9ioopAEl+K0CgVJV9xG79R6HGAvuTF0CTiCG6UDLikUgBz3c6Ld/O2rsZ19o+xEwQjksf2zdGKGtqMweR7Ns4q6HHEjQp46UYlnQWPzanUzTwZmDa6w/KFRWUYJdMFOId+2ZzuafG0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(346002)(376002)(39860400002)(31696002)(54906003)(83380400001)(86362001)(31686004)(8936002)(16526019)(2906002)(186003)(8676002)(316002)(110136005)(6486002)(66556008)(52116002)(4326008)(53546011)(66476007)(66946007)(2616005)(478600001)(5660300002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?KgqaIYeMste1dxgMK1sANs4rU8HOg9qGcpAjRCvOzDGnhGA3M1Tu5QMy?=
 =?Windows-1252?Q?/YanTt1iJgvHR0612YRILofq2BQJ67OC+SrgY6zCGI8z45FedYNyRVYi?=
 =?Windows-1252?Q?Ri/SJKk1aFrj5H0xXC2BKc6ygK817mZ+RkQnPX2rjy4hp+uLfTzGBce9?=
 =?Windows-1252?Q?zTmTAoNsVSLGthK0t8GgysTuGo4P5e4bQXmG9vvf3PmJ1xPlPXtYxOtu?=
 =?Windows-1252?Q?LzEgx0OGrGGLjKWkk60ZP1LwiEY3uR75jrIQYeRnAmSvNvB96qXQusRo?=
 =?Windows-1252?Q?dGRuxQ2xG92K5JL+wbuEDR+JiCCo7HgDTiXwlGor5rnSNQiPpNqOfxii?=
 =?Windows-1252?Q?Y2v78fGw6IAzyFMBsc66iD3OHwaQmgjPEOGjn6lPVRPD/DLDfgHlqQ7H?=
 =?Windows-1252?Q?b2spQl25nl3/OgrgIPYLlNDklPbyPRlZMJi9a+SndYHv65P6jvwJOujF?=
 =?Windows-1252?Q?qcgiyfC4XaeVwCG/Sn6tSMVhdVFRnqGUG3BzIqHhN2dyUOPcwQ199UsE?=
 =?Windows-1252?Q?ngajuxKDLsluGpyP4v99b2lYmXcBgdQ3ZVbOXu8LbpUf9CvuIVqHtqtW?=
 =?Windows-1252?Q?P2Sik+aaPBQEWOMNAuns0V1/MNSnIa0GgnGNBm9aZPG/0oeIINFEBN4c?=
 =?Windows-1252?Q?t0DMFDQ1Q+X8NOFA0eml3+WKY/cc/HtByDonCNGnGA0Yp8P+eYDSO0gC?=
 =?Windows-1252?Q?aGB2JRSDftLZk9VpIgg8wf4VdTeVnTJ5OjO15OXz0bgZK6r6/RyXtVtd?=
 =?Windows-1252?Q?QkAsp0qLyiMo9ADVEP5XQOHBRdVEy0chkZSYGuO2HwuFBOYgCth73q7l?=
 =?Windows-1252?Q?kZvhlLQxvQ/WckPjl3ps4LfF7pnuOfwEOWP2HQzTAf0eqlQVi0Yy+44I?=
 =?Windows-1252?Q?Cm3YRppg0g7tZUlKTsQba5RNU1TmrSN2oWwi0LUi+a04kp7kmlA63Y0B?=
 =?Windows-1252?Q?FwNmoH5755x6imAsryxI0Us73UO3pT47FTiw9xHh+tAjI+5aiNWobRFk?=
 =?Windows-1252?Q?NxTLMrb0oi10UoBwRegR70ifSp5tE6RBte6MUoiqUNGzLRYbemca8fN1?=
 =?Windows-1252?Q?kPMuhbPHBvc8RikWoSzscFm9h5Qdj0z3/8iDgg=3D=3D?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2021 17:20:20.6291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c4b559-f867-4b87-78be-08d8b7e7814b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GIBy7bRb0Pj+DM4EIGM0hjdS2Y8WQsq23LPz8mRPCrTZs0ZeltMvuH56seBzEG6V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3048
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-13_09:2021-01-13,2021-01-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 clxscore=1011 adultscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 mlxlogscore=999
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2101130104
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/13/21 2:25 AM, Jiri Olsa wrote:
> When processing kernel image build by clang we can
> find some functions without the name, which causes
> pahole to segfault.

Just curious. What kinds of functions gcc generates
names and clang doesn't?

> 
> Adding extra checks to make sure we always have
> function's name defined before using it.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>    v2 changes:
>      - reorg the code based on Andrii's suggestion
> 
>   btf_encoder.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 333973054b61..5557c9efd365 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -68,10 +68,14 @@ static int collect_function(struct btf_elf *btfe, GElf_Sym *sym)
>   	struct elf_function *new;
>   	static GElf_Shdr sh;
>   	static int last_idx;
> +	const char *name;
>   	int idx;
>   
>   	if (elf_sym__type(sym) != STT_FUNC)
>   		return 0;
> +	name = elf_sym__name(sym, btfe->symtab);
> +	if (!name)
> +		return 0;
>   
>   	if (functions_cnt == functions_alloc) {
>   		functions_alloc = max(1000, functions_alloc * 3 / 2);
> @@ -94,7 +98,7 @@ static int collect_function(struct btf_elf *btfe, GElf_Sym *sym)
>   		last_idx = idx;
>   	}
>   
> -	functions[functions_cnt].name = elf_sym__name(sym, btfe->symtab);
> +	functions[functions_cnt].name = name;
>   	functions[functions_cnt].addr = elf_sym__value(sym);
>   	functions[functions_cnt].sh_addr = sh.sh_addr;
>   	functions[functions_cnt].generated = false;
> @@ -731,8 +735,13 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
>   			continue;
>   		if (functions_cnt) {
>   			struct elf_function *func;
> +			const char *name;
> +
> +			name = function__name(fn, cu);
> +			if (!name)
> +				continue;
>   
> -			func = find_function(btfe, function__name(fn, cu));
> +			func = find_function(btfe, name);
>   			if (!func || func->generated)
>   				continue;
>   			func->generated = true;
> 
